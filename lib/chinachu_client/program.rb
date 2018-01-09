class ChinachuClient::Program
  ATTRIBUTES = %i(
    id category title full_title detail start end seconds description channel sub_title episode recorded
  )
  attr_accessor *ATTRIBUTES

  def self.parse_from(response)
    program = self.new
    ATTRIBUTES.each { |attr| program.send("#{attr}=", response[attr.to_s.camelize(:lower)]) }
    program.channel = ChinachuClient::Channel.parse_from(program.channel)
    program.start = Time.at(program.start / 1000.0)
    program.end = Time.at(program.end / 1000.0)

    program
  end

  def video_path
    self.recorded
  end
end
