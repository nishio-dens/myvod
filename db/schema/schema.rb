create_table :videos, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment

  t.boolean :mezzanine, default: true
  t.int :transcoding_status_id, default: 0
  t.int :transcoded_video_id, null: true
  t.varchar :filename
  t.varchar :filepath, limit: 1024
  t.bigint :filesize, default: 0
  t.boolean :removed, default: false

  t.datetime :created_at
  t.datetime :updated_at

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
