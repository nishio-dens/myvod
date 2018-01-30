json.(program, :id, :name, :category, :channel_id)

json.set!(:channel_chinachu_id, program.channel.chinachu_id)
json.set!(:channel_name, program.channel.name)
json.set!(:channel_type, program.channel.channel_type)
json.set!(:channel_number, program.channel.channel_number)
json.set!(:channel_capture_url, program.video_capture_url || "/images/no_images.png")
