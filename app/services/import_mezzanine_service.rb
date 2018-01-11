class ImportMezzanineService < BaseService
  BATCH_SIZE = 10

  def execute
    chinachu_programs = recorded_programs
    channels = import_channels(chinachu_programs)
    programs = import_programs(chinachu_programs, channels)
    assets = import_assets(chinachu_programs, programs)
    videos = import_videos(chinachu_programs, assets)
    videos.reject(&:has_streams?).each_slice(BATCH_SIZE).each do |vs|
      vs = set_streams(vs)
      vs.each(&:save!)
    end
  end

  private

  def recorded_programs
    client = ChinachuClient::Client.new(Settings.chinachu_base_url)
    client.recorded_programs
  end

  def import_channels(chinachu_programs)
    channels = chinachu_programs.map(&:channel).uniq(&:id).map do |chinachu_channel|
      c = Channel.find_or_initialize_by(chinachu_id: chinachu_channel.id)
      c.name = chinachu_channel.name
      c.channel_type = chinachu_channel.type
      c.channel_number = chinachu_channel.channel
      c
    end
    channels.each(&:save!)
    channels
  end

  def import_programs(chinachu_programs, channels)
    programs = chinachu_programs.uniq { |cp| [cp.category, cp.title] }.map do |cp|
      pg = Program.find_or_initialize_by(category: cp.category, name: cp.title)
      pg.channel = channels.find { |c| c.chinachu_id == cp.channel.id }
      pg
    end
    programs.each(&:save!)
    programs
  end

  def import_assets(chinachu_programs, programs)
    assets = chinachu_programs.map do |cp|
      asset = ProgramAsset.find_or_initialize_by(chinachu_id: cp.id)
      asset.program = programs.find { |p| p.category == cp.category && p.name == cp.title }
      asset.name = cp.full_title
      asset.short_description = cp.description || ""
      asset.full_description = cp.detail || ""
      asset.episode_number = cp.episode
      asset.duration_seconds = cp.seconds
      asset.started_at = cp.start
      asset.ended_at = cp.end
      asset
    end
    assets.each(&:save!)
    assets
  end

  def import_videos(chinachu_programs, assets)
    videos = assets.map do |asset|
      video = Video.find_or_initialize_by(program_asset_id: asset.id, mezzanine: true)
      cp = chinachu_programs.find { |c| c.id == asset.chinachu_id }
      video.filepath = cp.video_path
      video.filename = video.filepath.split("/")[-1]
      video.filesize = File.size(video.filepath)
      video
    end
    videos.each(&:save!)
    videos
  end

  def set_streams(videos)
    results = videos.map { |video| SetVideoStreamService.new.execute(video) }

    results.compact
  end
end
