# == Schema Information
#
# Table name: videos
#
#  id                    :integer          not null, primary key
#  mezzanine             :boolean          default(TRUE), not null
#  program_asset_id      :integer
#  transcoding_status_id :integer          default(0), not null
#  transcoded_video_id   :integer
#  filename              :string(255)      not null
#  filepath              :string(1024)     not null
#  filesize              :integer          default(0), not null
#  removed               :boolean          default(FALSE), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Video < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # Relations
  belongs_to :program_asset, required: false
  has_one :program, through: :program_asset
  has_many :video_streams
  has_many :audio_streams
  has_many :meta_streams
  belongs_to :transcoded_video, class_name: "Video", foreign_key: "transcoded_video_id", required: false

  belongs_to_active_hash :transcoding_status, class_name: 'TranscodingStatus'

  # Validations

  # Scope
  scope :not_transcoded, -> do
    where(mezzanine: true, transcoding_status_id: TranscodingStatus::WAITING.id)
      .or(where(mezzanine: true, transcoding_status_id: TranscodingStatus::FAIL.id))
  end

  # Methods
  def has_streams?
    video_streams.present? || audio_streams.present? || meta_streams.present?
  end

  def transcode_failed?
    self.transcoding_status_id == TranscodingStatus::FAIL.id
  end
end
