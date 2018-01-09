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
  has_many :video_streams, dependent: :destroy
  has_many :audio_streams, dependent: :destroy
  has_many :meta_streams, dependent: :destroy
  belongs_to :transcoded_video, class_name: "Video", foreign_key: "transcoded_video_id", required: false

  belongs_to_active_hash :transcoding_status, class_name: 'TranscodingStatus'

  # Validations

  # Scope
  scope :transcoded, -> do
    where(mezzanine: true, transcoding_status_id: TranscodingStatus::SUCCESS.id)
  end

  scope :not_transcoded, -> do
    where(mezzanine: true, transcoding_status_id: TranscodingStatus::WAITING.id)
      .or(where(mezzanine: true, transcoding_status_id: TranscodingStatus::FAIL.id))
  end

  scope :mezzanine_active, -> do
    where(mezzanine: true, removed: false)
  end

  scope :mezzanine_removed, -> do
    where(mezzanine: true, removed: true)
  end

  # Methods
  def has_streams?
    video_streams.present? || audio_streams.present? || meta_streams.present?
  end

  def interlaced?
    self.video_streams.first.field_order.present?
  end

  def transcode_failed?
    self.transcoding_status_id == TranscodingStatus::FAIL.id
  end

  def remove_mezzanine!
    return unless self.mezzanine
    return if self.removed

    Rails.logger.info("Removed #{self.filepath}")
    File.delete(self.filepath)
    self.update(removed: true)
  rescue => e
    Rails.logger.error(e)
  end
end
