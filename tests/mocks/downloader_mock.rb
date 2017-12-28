class DownloaderMock
  def download(file_url)
    current_script_path = File.dirname(__FILE__)
    file_path = File.expand_path("../images/#{file_url}", current_script_path)
  end
end