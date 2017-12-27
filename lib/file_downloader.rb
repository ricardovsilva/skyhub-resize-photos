class FileDownloader
  def initialize(save_path, downloader, filters = [])
    raise if not save_path
    @save_path = save_path
    @downloader = downloader
    @filters = filters
  end

  def add_filter(filter)
    @filters.push(filter)
  end

  def download(file_url)
    file_content = @downloader.download file_url

    file_name = file_url.split('/').last
    output_file_path = File.join(@save_path, file_name)
    File.open(output_file_path, 'wb') { |file| file.write(file_content) }

    outputs = [output_file_path]
    @filters.each { |filter| outputs.push(filter.apply(output_file_path)) } if @filters

    return outputs
  end
end