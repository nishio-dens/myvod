class TranscodingStatus < ActiveYaml::Base
  include ActiveHash::Enum

  set_root_path 'config/divisions'
  set_filename "transcoding_status"

  enum_accessor :type

  def name
    self.type
  end
end
