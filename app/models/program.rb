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
  has_many :mezzanine_videos, -> { where(mezzanine: true) }, through: :program_assets
  has_many :transcoded_videos, -> { where(mezzanine: false) }, through: :program_assets

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
end
