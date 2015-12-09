module VideoCoder
  class Ffmpeg
    attr_reader :filepath

    FFMPEG_BIN  = '/usr/local/bin/ffmpeg'
    FFPROBE_BIN = '/usr/local/bin/ffprobe'

    def initialize(filepath)
      @filepath = filepath
    end

    def output
      capture(FFPROBE_BIN, filepath)
    end

    def transcode(options)
      execute(
        FFMPEG_BIN,
        '-i',
        filepath,
        prepare_options_for_transcoding(options)
      )
    end

    private

    def execute(*args)
      command = args.join(' ')
      puts command
      system command
    end

    def capture(*args)
      `#{args.join(' ')} 2>&1`.encode(
        'UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''
      )
    end

    def prepare_options_for_transcoding(options)
      '-c:v libx264 -c:a libfaac -b:v'\
      " #{options[:video_bitrate]} #{options[:output_file]}"
    end
  end
end
