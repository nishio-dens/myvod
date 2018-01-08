# == Schema Information
#
# Table name: videos
#
#  id                    :integer          not null, primary key
#  mezzanine             :boolean          default(TRUE), not null
#  transcoding_status_id :integer          default(0), not null
#  transcoded_video_id   :integer
#  filename              :string(255)      not null
#  md5                   :string(32)       not null
#  filepath              :string(1024)     not null
#  removed               :boolean          default(FALSE), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Video < ApplicationRecord
  # Relations
  has_many :video_streams
  has_many :audio_streams
  has_many :meta_streams

  # Validations

  # Scope

  # Methods
end
