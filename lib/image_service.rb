require 'json'

class ImageService
  def initialize(rest_client, service_url)
    @rest_client = rest_client
    @service_url = service_url
  end

  def get_images_urls
    images_json = JSON.parse(@rest_client.get(@service_url).body)
    require 'byebug'
    urls = images_json["images"].each do |json_entry| json_entry["url"] end
  end

  def download_images_to(file_saver)
    images_path = get_images_urls
    images_path.each do |image_path|
      file_saver.save
    end
  end
end