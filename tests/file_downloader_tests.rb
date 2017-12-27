require_relative '../lib/file_downloader'
require_relative 'mocks/downloader_mock'
require_relative '../lib/filters/image_resizer_filter'
require 'tmpdir'
require 'test/unit'

class FileDownloaderTests < Test::Unit::TestCase
  def setup
    @downloader_mock = DownloaderMock.new
    @output_dir = Dir.mktmpdir
    @file_downloader = FileDownloader.new(@output_dir, @downloader_mock)
  end

  def test__initialize_with_invalid_save_path_folder__should_raise
    assert_raise do FileDownloader.new(nil, nil) end
  end

  def test__download_foo__should_save_foo_at_output_dir
    @file_downloader.download("foo_1.jpg")
    saved_files = Dir["#{@output_dir}/*"].map { |file_name| file_name.split('/').last }
    assert_equal(1, saved_files.length)
    assert_equal("foo_1.jpg", saved_files.first)
  end

  def test__download_foo_with_image_resize_filters__should_return_four_images_paths
    expected = ["foo_1.jpg", "foo_1_320_240.jpg", "foo_1_384_288.jpg", "foo_1_640_480.jpg"]

    small = ImageResizerFilter.new 320, 240
    medium = ImageResizerFilter.new 384, 288
    large = ImageResizerFilter.new 640, 480

    @file_downloader.add_filter(small)
    @file_downloader.add_filter(medium)
    @file_downloader.add_filter(large)

    actual = @file_downloader.download("foo_1.jpg").map { |file| File.basename file }
    assert_equal(expected, actual)
  end
end