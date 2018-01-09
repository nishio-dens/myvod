class SetVideoStreamService < BaseService
  def execute(video)
    set_streams(video)
  end

  private

  def set_streams(video)
    ffprobe_command = "ffprobe -show_streams -print_format json \"#{video.filepath}\""
    streams = JSON.parse(`#{ffprobe_command}`)

    video = set_video_stream(streams, video)
    video = set_audio_stream(streams, video)
    video = set_meta_stream(streams, video)
    video
  rescue => e
    Rails.logger.error(e)
    nil
  end

  def set_video_stream(streams, video)
    video_streams = streams["streams"].select { |v| v["codec_type"] == "video" }
    video_streams.each do |stream|
      video.video_streams.build(
        index:                stream["index"],
        codec_name:           stream["codec_long_name"] || stream["codec_name"] || "",
        profile:              stream["profile"] || "",
        codec_time_base:      stream["codec_time_base"] || "",
        width:                stream["width"] || 0,
        height:               stream["height"] || 0,
        has_b_frames:         stream["has_b_frames"] || false,
        sample_aspect_ratio:  stream["sample_aspect_ratio"] || "",
        display_aspect_ratio: stream["display_aspect_ratio"] || "",
        pix_fmt:              stream["pix_fmt"] || "",
        color_range:          stream["color_range"] || "",
        color_space:          stream["color_space"] || "",
        color_transfer:       stream["color_transfer"] || "",
        color_primaries:      stream["color_primaries"] || "",
        chroma_location:      stream["chroma_location"] || "",
        field_order:          stream["field_order"] || "",
        codec_id:             stream["id"] || "",
        r_frame_rate:         stream["r_frame_rate"] || "",
        avg_frame_rate:       stream["avg_frame_rate"] || "",
        start_pts:            stream["start_pts"] || 0,
        start_time:           stream["start_time"] || 0,
        duration_ts:          stream["duration_ts"] || 0,
        duration:             stream["duration"] || 0
      )
    end

    video
  end

  def set_audio_stream(streams, video)
    video_streams = streams["streams"].select { |v| v["codec_type"] == "audio" }
    video_streams.each do |stream|
      video.audio_streams.build(
        index:           stream["index"],
        codec_name:      stream["codec_long_name"] || stream["codec_name"] || "",
        profile:         stream["profile"] || "",
        codec_time_base: stream["codec_time_base"] || "",
        sample_rate:     stream["sample_rate"] || "",
        channels:        stream["channels"] || 0,
        channel_layout:  stream["channel_layout"] || "",
        bit_per_sample:  stream["bit_per_sample"] || 0,
        codec_id:        stream["id"] || "",
        start_pts:       stream["start_pts"] || 0,
        start_time:      stream["start_time"] || 0,
        duration_ts:     stream["duration_ts"] || 0,
        duration:        stream["duration"] || 0,
        bitrate:         stream["bitrate"] || 0
      )
    end

    video
  end

  def set_meta_stream(streams, video)
    video_streams = streams["streams"].select { |v| v["codec_type"] != "video" && v["codec_type"] != "audio" }
    video_streams.each do |stream|
      video.meta_streams.build(
        index:       stream["index"],
        codec_name:  stream["codec_long_name"] || stream["codec_name"] || "",
        codec_type:  stream["codec_type"] || "",
        codec_id:    stream["id"] || "",
        start_pts:   stream["start_pts"] || 0,
        start_time:  stream["start_time"] || 0,
        duration_ts: stream["duration_ts"] || 0,
        duration:    stream["duration"] || 0
      )
    end

    video
  end

end
