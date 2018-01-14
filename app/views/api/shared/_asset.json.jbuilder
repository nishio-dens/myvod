json.(asset,
  :id, :chinachu_id, :program_id, :name, :short_description, :full_description,
  :episode_number, :duration_seconds, :started_at, :ended_at, :created_at, :updated_at
)
json.set!(:capture_url, asset.primary_capture&.url)

json.set!(:program_name, asset.program.name)
json.set!(:category, asset.program.category)
json.set!(:channel_id, asset.program.channel_id)
json.set!(:channel_chinachu_id, asset.program.channel.chinachu_id)
json.set!(:channel_name, asset.program.channel.name)
json.set!(:channel_type, asset.program.channel.channel_type)
json.set!(:channel_number, asset.program.channel.channel_number)
