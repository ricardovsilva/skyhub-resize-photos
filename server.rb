require 'sinatra'
require 'rest-client'
require 'down'
require_relative 'lib/image_service'
require_relative 'lib/filters/image_resizer_filter'
require_relative 'lib/file_downloader'
require_relative 'lib/mongo_cache_service'

SERVICE_URL = "http://54.152.221.29/images.json"
IMAGES_OUTPUT_PATH = File.join(File.dirname(__FILE__), "/images/")

# Cache configuration - If you don't want to use cache, comment cache configuration section below
MONGO_URL = 'localhost:27017'
CACHE_DB_NAME = 'image-resizer'
CACHE_SERVICE = MongoCacheService.new(mongo_url: MONGO_URL, database_name: CACHE_DB_NAME, expiration_seconds: 10)
IMAGES_COLLECTION_NAME = 'images'
# END of cache configuration

RESIZE_IMAGE_FILTERS = [ImageResizerFilter.new(320, 240), ImageResizerFilter.new(384, 288), ImageResizerFilter.new(640, 480)]
IMAGE_SERVICE = ImageService.new RestClient, SERVICE_URL
FILE_SAVER = FileDownloader.new IMAGES_OUTPUT_PATH, Down, RESIZE_IMAGE_FILTERS

IMAGE_SERVICE.download_images_to FILE_SAVER

get '/image' do
  images_names = CACHE_SERVICE.get(IMAGES_COLLECTION_NAME) if defined? CACHE_SERVICE
  unless images_names
    images_paths = IMAGE_SERVICE.download_images_to FILE_SAVER
    images_names = images_paths.map {|path| "#{request.base_url}/image/#{path.split('/').last}"}
    defined? CACHE_SERVICE and CACHE_SERVICE.add(images_names, IMAGES_COLLECTION_NAME)
  end
  { images: images_names }.to_json
end

get '/image/:name' do |name|
  send_file File.join(IMAGES_OUTPUT_PATH, name)
end