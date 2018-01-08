# == Schema Information
#
# Table name: programs
#
#  id         :integer          not null, primary key
#  name       :string(512)      default(""), not null
#  category   :string(64)       default(""), not null
#  channel_id :integer
#  started_at :datetime
#  ended_at   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Program < ApplicationRecord
  # Relations
  belongs_to :channel, required: false
  has_many :program_assets

  # Validations

  # Scope

  # Methods
end
