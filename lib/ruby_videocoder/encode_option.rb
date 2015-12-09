module VideoCoder
  class EncodeOption
    attr_reader :options
    attr_reader :errors

    BITRATE_PATTERN = /\d+[k]/

    def initialize(options)
      @options = options
      @errors  = []
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

    def validate_bitrate
      return unless options[:video_bitrate]

      fail(
        EncodeError, 'Not valid bitrate value'
      ) unless options[:video_bitrate].match(BITRATE_PATTERN)
    end

    def validate_output_file
      fail(
        EncodeError, 'No output given'
      ) unless options[:output_file]
    end
  end
end
