module VideoCoder
  class Video
    attr_reader :filepath
    attr_reader :metadata

    def initialize(filepath)
      fail Errno::ENOENT, "#{filepath} not found" unless File.exist?(filepath)

      @filepath = filepath
    end

    def transcode(options)
      Transcoder.new(filepath, options).transcode
    end

    def metadata
      @metadata ||= MetadataCollector.new(filepath).metadata
    end

    def duration
      metadata[:duration]
    end

    def video_bitrate
      metadata[:video_bitrate]
    end
  end
end
