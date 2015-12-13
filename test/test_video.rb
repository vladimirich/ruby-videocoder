require 'minitest/autorun'
require 'ruby_videocoder'

class TestVideo < MiniTest::Unit::TestCase
  def setup
    @input_video_path = File.join(Dir.pwd, 'test/fixtures/test.mp4')
    @video = VideoCoder::Video.new(@input_video_path)
  end

  def test_duration
    assert_equal 8039, @video.duration
  end

  def test_transcoding
    assert_raises VideoCoder::EncodeError do
      @video.transcode({})
    end

    assert_raises VideoCoder::EncodeError do
      @video.transcode({
        output_file: '/tmp/video.mp4',
        video_bitrate: '300'
      })
    end

    assert_equal(
      299,
      @video.transcode({
        output_file: '/tmp/video.mp4',
        video_bitrate: '300k'
      }).video_bitrate
    )
  end
end
