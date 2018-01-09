class ChinachuClient::Channel
  ATTRIBUTES = %i(
    id sid nid type channel name has_logo_data n
  )
  attr_accessor *ATTRIBUTES

  def self.parse_from(response)
    channel = self.new
    ATTRIBUTES.each { |attr| channel.send("#{attr}=", response[attr.to_s.camelize(:lower)]) }

    channel
  end
end
