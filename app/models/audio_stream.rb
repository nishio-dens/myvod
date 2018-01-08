# == Schema Information
#
# Table name: audio_streams
#
#  id              :integer          not null, primary key
#  video_id        :integer          not null
#  index           :integer          default(0), not null
#  codec_name      :string(255)      default(""), not null
#  profile         :string(255)      default(""), not null
#  codec_time_base :string(255)      default(""), not null
#  sample_rate     :string(255)      default(""), not null
#  channels        :integer          default(0), not null
#  channel_layout  :string(255)      default(""), not null
#  bit_per_sample  :integer          default(0), not null
#  codec_id        :string(255)      default(""), not null
#  start_pts       :integer          default(0), not null
#  start_time      :decimal(20, 6)   default(0.0), not null
#  duration_ts     :integer          default(0), not null
#  duration        :decimal(20, 6)   default(0.0), not null
#  bitrate         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class AudioStream < ApplicationRecord
  # Relations
  belongs_to :video

  # Validations

  # Scope

  # Methods
end
