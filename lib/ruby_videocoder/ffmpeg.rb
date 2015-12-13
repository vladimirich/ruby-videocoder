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
        options.to_s
      )

      options.output
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
  end
end
