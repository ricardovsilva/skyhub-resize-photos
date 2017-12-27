require_relative '../lib/image_service'
require_relative 'mocks/rest_client_mock'
require 'test/unit'

class ImageServiceTests < Test::Unit::TestCase
  def setup
    @imageService = ImageService.new(RestClientMock, "http://foo/images.json")
  end

  def test_get_images_urls__service_returns_json_with_10_urls__should_return_10_urls
    actual = @imageService.get_images_urls
    assert_equal(10, actual.length)
  end
end