class TranscodeVideoService < BaseService
  CRF = 18

  def execute(video)
    return if video.transcoding_status_id != TranscodingStatus::WAITING.id
    transcode!(video)

    transcoded_video = Video.new(
      mezzanine: false,
      transcoding_status_id: TranscodingStatus::SUCCESS.id,
      program_asset_id: video.program_asset_id,
    )
    transcoded_video.filepath = transcoded_video_path(video)
    transcoded_video.filename = transcoded_video.filepath.split("/")[-1]
    transcoded_video.filesize = File.size(transcoded_video.filepath)
    SetVideoStreamService.new.execute(transcoded_video)

    Video.transaction do
      transcoded_video.save!
      video.update(transcoding_status_id: TranscodingStatus::SUCCESS.id, transcoded_video_id: transcoded_video.id)
    end
  rescue => e
    Rails.logger.error(e)
    video.update(transcoding_status_id: TranscodingStatus::FAIL.id)
  end

  private

  def transcode!(video)
    tune = video.program&.category == "anime" ? "zerolatency,animation" : "zerolatency"

    ffmpeg_command = <<-EOS.strip_heredoc
      ffmpeg -y -i "#{video.filepath}" -vcodec libx264 -preset veryfast \
      -crf #{CRF} -tune #{tune} -movflags +faststart \
      "#{transcoded_video_path(video)}"
    EOS
    `#{ffmpeg_command}`
  end

  def transcoded_video_path(video)
    "#{Settings.transcoded_video_path}/#{video.filename}.mp4"
  end
end
