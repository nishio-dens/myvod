create_table :channels, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment

  t.varchar :chinachu_id, default: ""
  t.varchar :name, default: ""
  t.varchar :channel_type, default: ""
  t.int :channel_number, null: true

  t.datetime :created_at
  t.datetime :updated_at
end

create_table :programs, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment

  t.varchar :name, limit: 512, default: ""
  t.varchar :category, limit: 32, default: ""
  t.int :channel_id, null: true

  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :channel_id, reference: :channels, reference_column: :id
end

create_table :program_assets, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment

  t.varchar :chinachu_id, limit: 20, default: ""
  t.int :program_id
  t.varchar :name, limit: 512, default: ""
  t.varchar :short_description, limit: 4096, default: ""
  t.varchar :full_description, limit: 8192, default: ""
  t.int :episode_number, null: true

  t.int :duration_seconds, default: 0
  t.datetime :started_at, null: true
  t.datetime :ended_at, null: true

  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :program_id, reference: :programs, reference_column: :id
end

create_table :videos, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment

  t.boolean :mezzanine, default: true
  t.int :program_asset_id, null: true
  t.int :transcoding_status_id, default: 0
  t.int :transcoded_video_id, null: true
  t.varchar :filename
  t.varchar :filepath, limit: 1024
  t.bigint :filesize, default: 0
  t.boolean :removed, default: false

  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :program_asset_id, reference: :program_assets, reference_column: :id
  t.foreign_key :transcoded_video_id, reference: :videos, reference_column: :id
end

create_table :video_streams, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :video_id
  t.int :index, default: 0
  t.varchar :codec_name, default: ""
  t.varchar :profile, default: ""
  t.varchar :codec_time_base, default: ""
  t.int :width, default: 0
  t.int :height, default: 0
  t.boolean :has_b_frames, default: 0
  t.varchar :sample_aspect_ratio, default: ""
  t.varchar :display_aspect_ratio, default: ""
  t.varchar :pix_fmt, default: ""
  t.varchar :color_range, default: ""
  t.varchar :color_space, default: ""
  t.varchar :color_transfer, default: ""
  t.varchar :color_primaries, default: ""
  t.varchar :chroma_location, default: ""
  t.varchar :field_order, default: ""
  t.varchar :codec_id, default: ""
  t.varchar :r_frame_rate, default: ""
  t.varchar :avg_frame_rate, default: ""
  t.bigint :start_pts, default: 0
  t.decimal :start_time, precision: 20, scale: 6, default: "0.000000"
  t.bigint :duration_ts, default: 0
  t.decimal :duration, precision: 20, scale: 6, default: "0.000000"

  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :video_id, reference: :videos, reference_column: :id
end

create_table :audio_streams, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :video_id
  t.int :index, default: 0
  t.varchar :codec_name, default: ""
  t.varchar :profile, default: ""
  t.varchar :codec_time_base, default: ""
  t.varchar :sample_rate, default: ""
  t.int :channels, default: 0
  t.varchar :channel_layout, default: ""
  t.int :bit_per_sample, default: 0
  t.varchar :codec_id, default: ""
  t.bigint :start_pts, default: 0
  t.decimal :start_time, precision: 20, scale: 6, default: "0.000000"
  t.bigint :duration_ts, default: 0
  t.decimal :duration, precision: 20, scale: 6, default: "0.000000"
  t.int :bitrate

  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :video_id, reference: :videos, reference_column: :id
end

create_table :meta_streams, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :video_id
  t.int :index, default: 0
  t.varchar :codec_name, default: ""
  t.varchar :codec_type, default: ""
  t.varchar :codec_id, default: ""
  t.bigint :start_pts, default: 0
  t.decimal :start_time, precision: 20, scale: 6, default: "0.000000"
  t.bigint :duration_ts, default: 0
  t.decimal :duration, precision: 20, scale: 6, default: "0.000000"

  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :video_id, reference: :videos, reference_column: :id
end

create_table :delayed_jobs, comment: "Delayed Job" do |t|
  t.int :id, primary_key: true, extra: 'auto_increment'
  t.int :priority, default: 0, null: false
  t.int :attempts, default: 0, null: false
  t.text :handler
  t.text :last_error, null: true
  t.datetime :run_at, null: true
  t.datetime :locked_at, null: true
  t.datetime :failed_at, null: true
  t.varchar :locked_by, null: true
  t.varchar :queue, null: true

  t.datetime :created_at, null: true
  t.datetime :updated_at, null: true

  t.index [:priority, :run_at], name: "delayed_jobs_priority"
end

create_table :schema_migrations, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci do |t|
  t.varchar :version, limit: 191

  t.index :version, name: "unique_schema_migrations", unique: true
end

create_table :ar_internal_metadata, collate: :utf8_bin do |t|
  t.varchar :key
  t.varchar :value
  t.datetime :created_at
  t.datetime :updated_at
end
