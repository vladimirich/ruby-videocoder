module VideoCoder
  class MetadataCollector
    attr_reader :filepath

    DURATION_REGEX = %r{Duration:\s+(\d+):(\d+):([\d.]+).*?
      bitrate:\s*(\d+)\s*kb\/s}x

    VIDEO_BITRATE_REGEX = %r{Stream\s#\d:\d.*?Video:.*,\s(.*)\skb\/s,}

    def initialize(filepath)
      @filepath = filepath
    end

    def metadata
      collect_metadata
    end

    private

    def collect_metadata
      parse_ffmpeg_output
    end

    def parse_ffmpeg_output
      parsed_output = {}
      ffmpeg_output = Ffmpeg.new(filepath).output
      parsed_output[:duration] = duration(ffmpeg_output)
      parsed_output[:video_bitrate] = video_bitrate(ffmpeg_output)

      parsed_output
    end

    def duration(ffmpeg_output)
      return unless (matched = ffmpeg_output.match(DURATION_REGEX))

      ((matched[1].to_i * 3600 +
        matched[2].to_i * 60 +
        matched[3].to_f) * 1000).to_i
    end

    def video_bitrate(ffmpeg_output)
      return unless (matched = ffmpeg_output.match(VIDEO_BITRATE_REGEX))

      matched[1].to_i
    end
  end
end
