# == Schema Information
#
# Table name: program_assets
#
#  id                  :integer          not null, primary key
#  chinachu_id         :string(20)       default(""), not null
#  name                :string(512)      default(""), not null
#  detail              :string(4096)     default(""), not null
#  episode_number      :integer
#  duration_seconds    :integer          default(0), not null
#  started_at          :datetime
#  ended_at            :datetime
#  mezzanine_video_id  :integer
#  transcoded_video_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ProgramAsset < ApplicationRecord
  # Relations
  belongs_to :program

  # Validations

  # Scope

  # Methods
end
