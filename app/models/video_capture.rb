# == Schema Information
#
# Table name: video_captures
#
#  id         :integer          not null, primary key
#  video_id   :integer          not null
#  filepath   :string(255)      default(""), not null
#  width      :integer          default(0), not null
#  height     :integer          default(0), not null
#  position   :decimal(10, 3)   default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VideoCapture < ApplicationRecord
  # Relations
  belongs_to :video

  # Validations

  # Scopes

  # Methods
  def url
    URI.escape("#{Settings.storage_base_url}#{filepath}")
  end
end
