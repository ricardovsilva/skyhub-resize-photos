class FileDownloader
  def initialize(save_path, downloader, filters = [])
    raise if not save_path
    @save_path = save_path
    Dir.mkdir(save_path) unless Dir.exist?(save_path)
    @downloader = downloader
    @filters = filters
  end

  def add_filter(filter)
    @filters.push(filter)
  end

  def save(file_url)
    download_path = @downloader.download(file_url)
    file_name = file_url.split('/').last
    output_file_path = File.join(@save_path, file_name)

    File.open download_path, "rb" do |io|
      File.open(output_file_path, 'wb') { |file| file.write(io.read) }
      outputs = [output_file_path]
      @filters.each { |filter| outputs.push(filter.apply(output_file_path)) } if @filters

      return outputs
    end
  end
end