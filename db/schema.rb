# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "audio_streams", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT" do |t|
    t.integer "video_id", null: false
    t.integer "index", default: 0, null: false
    t.string "codec_name", default: "", null: false
    t.string "profile", default: "", null: false
    t.string "codec_time_base", default: "", null: false
    t.string "sample_rate", default: "", null: false
    t.integer "channels", default: 0, null: false
    t.string "channel_layout", default: "", null: false
    t.integer "bit_per_sample", default: 0, null: false
    t.string "codec_id", default: "", null: false
    t.bigint "start_pts", default: 0, null: false
    t.decimal "start_time", precision: 20, scale: 6, default: "0.0", null: false
    t.bigint "duration_ts", default: 0, null: false
    t.decimal "duration", precision: 20, scale: 6, default: "0.0", null: false
    t.integer "bitrate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "audio_streams_video_id_fk"
  end

  create_table "channels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT" do |t|
    t.string "chinachu_id", default: "", null: false
    t.string "name", default: "", null: false
    t.string "channel_type", default: "", null: false
    t.integer "channel_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meta_streams", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT" do |t|
    t.integer "video_id", null: false
    t.integer "index", default: 0, null: false
    t.string "codec_name", default: "", null: false
    t.string "codec_type", default: "", null: false
    t.string "codec_id", default: "", null: false
    t.bigint "start_pts", default: 0, null: false
    t.decimal "start_time", precision: 20, scale: 6, default: "0.0", null: false
    t.bigint "duration_ts", default: 0, null: false
    t.decimal "duration", precision: 20, scale: 6, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "meta_streams_video_id_fk"
  end

  create_table "program_assets", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT" do |t|
    t.string "chinachu_id", limit: 20, default: "", null: false
    t.integer "program_id", null: false
    t.string "name", limit: 512, default: "", null: false
    t.string "short_description", limit: 4096, default: "", null: false
    t.string "full_description", limit: 8192, default: "", null: false
    t.integer "episode_number"
    t.integer "duration_seconds", default: 0, null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "program_assets_program_id_fk"
  end

  create_table "programs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT" do |t|
    t.string "name", limit: 512, default: "", null: false
    t.string "category", limit: 32, default: "", null: false
    t.integer "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "programs_channel_id_fk"
  end

  create_table "video_streams", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT" do |t|
    t.integer "video_id", null: false
    t.integer "index", default: 0, null: false
    t.string "codec_name", default: "", null: false
    t.string "profile", default: "", null: false
    t.string "codec_time_base", default: "", null: false
    t.integer "width", default: 0, null: false
    t.integer "height", default: 0, null: false
    t.boolean "has_b_frames", default: false, null: false
    t.string "sample_aspect_ratio", default: "", null: false
    t.string "display_aspect_ratio", default: "", null: false
    t.string "pix_fmt", default: "", null: false
    t.string "color_range", default: "", null: false
    t.string "color_space", default: "", null: false
    t.string "color_transfer", default: "", null: false
    t.string "color_primaries", default: "", null: false
    t.string "chroma_location", default: "", null: false
    t.string "field_order", default: "", null: false
    t.string "codec_id", default: "", null: false
    t.string "r_frame_rate", default: "", null: false
    t.string "avg_frame_rate", default: "", null: false
    t.bigint "start_pts", default: 0, null: false
    t.decimal "start_time", precision: 20, scale: 6, default: "0.0", null: false
    t.bigint "duration_ts", default: 0, null: false
    t.decimal "duration", precision: 20, scale: 6, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "video_streams_video_id_fk"
  end

  create_table "videos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT" do |t|
    t.boolean "mezzanine", default: true, null: false
    t.integer "program_asset_id"
    t.integer "transcoding_status_id", default: 0, null: false
    t.integer "transcoded_video_id"
    t.string "filename", null: false
    t.string "filepath", limit: 1024, null: false
    t.bigint "filesize", default: 0, null: false
    t.boolean "removed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_asset_id"], name: "videos_program_asset_id_fk"
    t.index ["transcoded_video_id"], name: "videos_transcoded_video_id_fk"
  end

  add_foreign_key "audio_streams", "videos", name: "audio_streams_video_id_fk"
  add_foreign_key "meta_streams", "videos", name: "meta_streams_video_id_fk"
  add_foreign_key "program_assets", "programs", name: "program_assets_program_id_fk"
  add_foreign_key "programs", "channels", name: "programs_channel_id_fk"
  add_foreign_key "video_streams", "videos", name: "video_streams_video_id_fk"
  add_foreign_key "videos", "program_assets", name: "videos_program_asset_id_fk"
  add_foreign_key "videos", "videos", column: "transcoded_video_id", name: "videos_transcoded_video_id_fk"
end
