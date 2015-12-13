# Ruby VideoCoder

Ruby gem for video transcoding, obtaining information, etc.
Uses ffmpeg and H246.

## Usage

```
VideoCoder::Video.new(input_file_path).transcode(options) # transcode
video to specified options
VideoCoder::Video.new(input_file_path).duration # get video duration
```

## Available options

* output_file - where to put result video
* video_bitrate - specify video bitrate for result video

## Requirements

Ffmpeg compiled with libx264. Gem is tested with 2.8.x version of
ffmpeg.
