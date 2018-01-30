# == Schema Information
#
# Table name: programs
#
#  id         :integer          not null, primary key
#  name       :string(512)      default(""), not null
#  category   :string(32)       default(""), not null
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Program < ApplicationRecord
  # Relations
  belongs_to :channel, required: false
  has_many :program_assets
  has_many :mezzanine_videos, -> { where(mezzanine: true) }, class_name: "Video", through: :program_assets
  has_many :transcoded_videos, -> { where(mezzanine: false) }, class_name: "Video", through: :program_assets
  has_many :transcoded_video_captures, class_name: "VideoCapture", through: :transcoded_videos, source: :video_captures

  # Validations

  # Scope

  # Methods
  def anime?
    self.category == "anime"
  end

  def cleanup_mezzanine!(force: false)
    target_videos = if force
                      self.mezzanine_videos
                    else
                      self.mezzanine_videos.transcoded
                    end
    target_videos.each(&:remove_mezzanine!)
  end

  def video_capture_url
    self.transcoded_video_captures.first&.url
  end
end
