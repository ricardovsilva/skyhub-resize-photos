require 'json'

class ImageService
  def initialize(rest_client, service_url)
    @rest_client = rest_client
    @service_url = service_url
  end

  def get_images_urls
    images_json = JSON.parse(@rest_client.get(@service_url).body)
    urls = images_json["images"].map { |json_entry| json_entry["url"] }
  end

  def download_images_to(file_saver)
    images_path = get_images_urls
    outputs_paths = []
    images_path.each do |image_path|
      outputs_paths = outputs_paths + file_saver.save(image_path)
    end

    return outputs_paths
  end
end