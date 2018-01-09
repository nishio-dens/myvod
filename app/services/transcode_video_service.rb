require "fileutils"

class TranscodeVideoService < BaseService
  DEFAULT_CRF = 18
  ANIME_CRF = 22
  VIDEO_WIDTH_HEIGHT = "1280x720"
  VIDEO_BITRATE = "1400k"
  AUDIO_BITRATE = "128k"

  def execute(video)
    return if video.transcoding_status_id != TranscodingStatus::WAITING.id
    video.update(transcoding_status_id: TranscodingStatus::TRANSCODING.id)

    make_transcoded_video_dir(video)
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
    tune = video.program&.anime? ? "zerolatency,animation" : "zerolatency"
    deinterlace_cmd = video.interlaced? ? "-flags +ilme+ildct -top -1 -deinterlace" : ""
    crf = video.program&.anime? ? ANIME_CRF : DEFAULT_CRF

    ffmpeg_command = <<-EOS.strip_heredoc
      ffmpeg -y -i "#{video.filepath}" -s #{VIDEO_WIDTH_HEIGHT} -vcodec libx264 \
      #{deinterlace_cmd} -b:v #{VIDEO_BITRATE} -profile:v main -preset veryfast \
      -crf #{crf} -tune #{tune} -movflags +faststart \
      -acodec aac -strict experimental -ab #{AUDIO_BITRATE} -ar 48000 \
      "#{transcoded_video_path(video)}"
    EOS
    `#{ffmpeg_command}`
  end

  def make_transcoded_video_dir(video)
    FileUtils.mkdir_p("#{Settings.transcoded_video_path}/#{video.program.name}")
  end

  def transcoded_video_path(video)
    "#{Settings.transcoded_video_path}/#{video.program.name}/#{video.filename}.mp4"
  end
end
