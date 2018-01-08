# == Schema Information
#
# Table name: meta_streams
#
#  id          :integer          not null, primary key
#  video_id    :integer          not null
#  index       :integer          default(0), not null
#  codec_name  :string(255)      default(""), not null
#  codec_type  :string(255)      default(""), not null
#  codec_id    :string(255)      default(""), not null
#  start_pts   :integer          default(0), not null
#  start_time  :decimal(20, 6)   default(0.0), not null
#  duration_ts :integer          default(0), not null
#  duration    :decimal(20, 6)   default(0.0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MetaStream < ApplicationRecord
  # Relations
  belongs_to :video

  # Validations

  # Scope

  # Methods
end
