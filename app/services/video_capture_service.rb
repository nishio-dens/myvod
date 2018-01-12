class VideoCaptureService < BaseService
  def execute(video, capture_position: 3)
    result = capture_thumbnail(video, capture_position)

    if result[:success]
      video_stream = video.primary_video_stream
      capture = VideoCapture.new(
        video_id: video.id,
        filepath: result[:filepath],
        width: result[:width],
        height: result[:height],
        position: capture_position
      )
      capture.save!
      capture
    else
      fail "Cannot capture thumbnail."
    end
  end

  private

  def capture_thumbnail(video, position_sec)
    video_stream = video.primary_video_stream
    width = video_stream.width
    dar_x, dar_y = video_stream.display_aspect_ratio.split(":").map(&:to_f)
    height = (width * (dar_y / dar_x)).to_i

    deinterlace_cmd = video.interlaced? ? "-vf yadif=0:-1" : ""
    artfile_path = "#{Settings.artfile_path}/#{video.id}_#{position_sec}.png"
    ffmpeg_command = <<-EOS.strip_heredoc
      ffmpeg -y -ss #{position_sec} -i \"#{video.filepath}\" #{deinterlace_cmd} \
      -s #{width}x#{height} -vframes 1 #{artfile_path}
    EOS
    _, status = Open3.capture2e(ffmpeg_command)

    { success: status.success?, filepath: artfile_path, width: width, height: height }
  end
end
