module VideoCoder
  class Transcoder
    attr_reader :filepath
    attr_reader :options

    def initialize(filepath, options)
      validator = EncodeOption.new(options)
      fail EncodeError, validator.errors.join(';') unless validator.valid?

      @filepath = filepath
      @options  = options
    end

    def transcode
      Ffmpeg.new(filepath).transcode(options)
    end
  end
end
