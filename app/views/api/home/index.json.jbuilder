json.new_arrivals @new_assets do |asset|
  json.partial! "api/shared/asset", asset: asset
end

json.new_programs @new_programs do |program|
  json.partial! "api/shared/program", program: program
end