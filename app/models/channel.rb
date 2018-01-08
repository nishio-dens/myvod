# == Schema Information
#
# Table name: channels
#
#  id             :integer          not null, primary key
#  chinachu_id    :string(255)      default(""), not null
#  name           :string(255)      default(""), not null
#  channel_type   :string(255)      default(""), not null
#  channel_number :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Channel < ApplicationRecord
  # Relations

  # Validations

  # Scope

  # Methods
end
