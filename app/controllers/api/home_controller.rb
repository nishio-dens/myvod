class Api::HomeController < Api::BaseController
  def index
    @new_assets = ProgramAsset
                      .publishable_assets
                      .preload(:program, :transcoded_video, transcoded_video: :video_captures, program: :channel)
                      .order(started_at: :desc)
                      .limit(18)
    @new_programs = Program
                        .all
                        .preload(:channel)
                        .order(:created_at)
                        .limit(18)
  end
end