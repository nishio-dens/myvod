# == Schema Information
#
# Table name: video_streams
#
#  id                   :integer          not null, primary key
#  video_id             :integer          not null
#  index                :integer          default(0), not null
#  codec_name           :string(255)      default(""), not null
#  profile              :string(255)      default(""), not null
#  codec_time_base      :string(255)      default(""), not null
#  width                :integer          default(0), not null
#  height               :integer          default(0), not null
#  has_b_frames         :boolean          default(FALSE), not null
#  sample_aspect_ratio  :string(255)      default(""), not null
#  display_aspect_ratio :string(255)      default(""), not null
#  pix_fmt              :string(255)      default(""), not null
#  color_range          :string(255)      default(""), not null
#  color_space          :string(255)      default(""), not null
#  color_transfer       :string(255)      default(""), not null
#  color_primaries      :string(255)      default(""), not null
#  chroma_location      :string(255)      default(""), not null
#  field_order          :string(255)      default(""), not null
#  codec_id             :string(255)      default(""), not null
#  r_frame_rate         :string(255)      default(""), not null
#  avg_frame_rate       :string(255)      default(""), not null
#  start_pts            :integer          default(0), not null
#  start_time           :decimal(20, 6)   default(0.0), not null
#  duration_ts          :integer          default(0), not null
#  duration             :decimal(20, 6)   default(0.0), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class VideoStream < ApplicationRecord
  # Relations
  belongs_to :video

  # Validations

  # Scope

  # Methods
end
