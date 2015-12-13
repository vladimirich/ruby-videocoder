module VideoCoder
  class Transcoder
    attr_reader :filepath
    attr_reader :options

    def initialize(filepath, options)
      options = Options.new(options)

      fail(
        EncodeError,
        options.errors.join(';')
      ) unless options.valid?

      @filepath = filepath
      @options  = options
    end

    def transcode
      Ffmpeg.new(filepath).transcode(options)
    end
  end
end
