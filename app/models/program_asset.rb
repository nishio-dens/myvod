# == Schema Information
#
# Table name: program_assets
#
#  id                :integer          not null, primary key
#  chinachu_id       :string(20)       default(""), not null
#  program_id        :integer          not null
#  name              :string(512)      default(""), not null
#  short_description :string(4096)     default(""), not null
#  full_description  :string(8192)     default(""), not null
#  episode_number    :integer
#  duration_seconds  :integer          default(0), not null
#  started_at        :datetime
#  ended_at          :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ProgramAsset < ApplicationRecord
  # Relations
  belongs_to :program
  has_one :mezzanine_video, -> { where(mezzanine: true) }, class_name: "Video"
  has_one :transcoded_video, -> { where(mezzanine: false) }, class_name: "Video"

  # Validations

  # Scope

  # Methods
end
