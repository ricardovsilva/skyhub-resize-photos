require 'image_proc'

class ImageResizerFilter
  def initialize(output_width, output_height)
    @output_width = output_width
    @output_height = output_height
  end

  def apply(input_file_path)
    resolution_insert_index = input_file_path.rindex('.')
    output_file_path = String.new input_file_path #needs to use String.new because of a bug, reported by me at https://bugs.ruby-lang.org/issues/14251
    output_file_path.insert(resolution_insert_index, "_#{@output_width}_#{@output_height}")

    unless File.exists?(output_file_path)
      ImageProc.resize(
        input_file_path,
        output_file_path,
        width: @output_width,
        height: @output_height)
    end
    output_file_path
  end
end