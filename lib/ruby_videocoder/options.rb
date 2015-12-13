module VideoCoder
  class Options
    attr_reader :options
    attr_reader :errors

    BITRATE_PATTERN = /\d+[k]/

    def initialize(options)
      @options = options
      @errors  = []
    end

    def to_s
      "#{codec} #{bitrate} #{options[:output_file]}"
    end

    def output
      VideoCoder::Video.new(options[:output_file])
    end

    def valid?
      validate_bitrate
      validate_output_file
      true
    rescue EncodeError => e
      errors << e.message
      false
    end

    private

    def codec
      '-c:v libx264 -c:a libfaac'
    end

    def bitrate
      return unless options[:video_bitrate]

      "-b:v #{options[:video_bitrate]}"
    end

    def validate_bitrate
      return unless options[:video_bitrate]

      fail(
        EncodeError, 'Not valid bitrate value (must be like 100k)'
      ) unless options[:video_bitrate].match(BITRATE_PATTERN)
    end

    def validate_output_file
      fail(
        EncodeError, 'No output_file given'
      ) unless options[:output_file]
    end
  end
end
