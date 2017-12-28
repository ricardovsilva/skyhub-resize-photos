require 'sinatra'
require 'rest-client'
require 'down'
require_relative 'lib/image_service'
require_relative 'lib/filters/image_resizer_filter'
require_relative 'lib/file_downloader'

SERVICE_URL = "http://54.152.221.29/images.json"
IMAGES_OUTPUT_PATH = File.join(File.dirname(__FILE__), "/images/")

RESIZE_IMAGE_FILTERS = [ImageResizerFilter.new(320, 240), ImageResizerFilter.new(384, 288), ImageResizerFilter.new(640, 480)]
IMAGE_SERVICE = ImageService.new RestClient, SERVICE_URL
FILE_SAVER = FileDownloader.new IMAGES_OUTPUT_PATH, Down, RESIZE_IMAGE_FILTERS

get '/image' do
  images_paths = IMAGE_SERVICE.download_images_to FILE_SAVER
  images_names = images_paths.map {|path| "#{request.base_url}/images/#{path.split('/').last}"}
  { images: images_names }.to_json
end

get '/image/:name' do |name|
end