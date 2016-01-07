# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150306184045) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgres_fdw"

  create_table "BUCKETING_COLS", id: false, force: :cascade do |t|
    t.integer "SD_ID",           limit: 8,   null: false
    t.string  "BUCKET_COL_NAME", limit: 256
    t.integer "INTEGER_IDX",     limit: 8,   null: false
  end

  add_index "BUCKETING_COLS", ["SD_ID"], name: "BUCKETING_COLS_N49", using: :btree

  create_table "CDS", primary_key: "CD_ID", force: :cascade do |t|
  end

  create_table "COLUMNS_OLD", id: false, force: :cascade do |t|
    t.integer "SD_ID",       limit: 8,    null: false
    t.string  "COMMENT",     limit: 256
    t.string  "COLUMN_NAME", limit: 128,  null: false
    t.string  "TYPE_NAME",   limit: 4000, null: false
    t.integer "INTEGER_IDX", limit: 8,    null: false
  end

  add_index "COLUMNS_OLD", ["SD_ID"], name: "COLUMNS_N49", using: :btree

  create_table "COLUMNS_V2", id: false, force: :cascade do |t|
    t.integer "CD_ID",       limit: 8,    null: false
    t.string  "COMMENT",     limit: 4000
    t.string  "COLUMN_NAME", limit: 128,  null: false
    t.string  "TYPE_NAME",   limit: 4000
    t.integer "INTEGER_IDX",              null: false
  end

  create_table "DATABASE_PARAMS", id: false, force: :cascade do |t|
    t.integer "DB_ID",       limit: 8,    null: false
    t.string  "PARAM_KEY",   limit: 180,  null: false
    t.string  "PARAM_VALUE", limit: 4000
  end

  add_index "DATABASE_PARAMS", ["DB_ID"], name: "DATABASE_PARAMS_N49", using: :btree

  create_table "DBS", primary_key: "DB_ID", force: :cascade do |t|
    t.string "DESC",            limit: 4000
    t.string "DB_LOCATION_URI", limit: 4000, null: false
    t.string "NAME",            limit: 128
    t.string "OWNER_NAME",      limit: 128
    t.string "OWNER_TYPE",      limit: 10
  end

  add_index "DBS", ["NAME"], name: "UNIQUE_DATABASE", unique: true, using: :btree

  create_table "DB_PRIVS", primary_key: "DB_GRANT_ID", force: :cascade do |t|
    t.integer "CREATE_TIME",    limit: 8,   null: false
    t.integer "DB_ID",          limit: 8
    t.integer "GRANT_OPTION",   limit: 2,   null: false
    t.string  "GRANTOR",        limit: 128
    t.string  "GRANTOR_TYPE",   limit: 128
    t.string  "PRINCIPAL_NAME", limit: 128
    t.string  "PRINCIPAL_TYPE", limit: 128
    t.string  "DB_PRIV",        limit: 128
  end

  add_index "DB_PRIVS", ["DB_ID", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "DB_PRIV", "GRANTOR", "GRANTOR_TYPE"], name: "DBPRIVILEGEINDEX", unique: true, using: :btree
  add_index "DB_PRIVS", ["DB_ID"], name: "DB_PRIVS_N49", using: :btree

  create_table "DELEGATION_TOKENS", primary_key: "TOKEN_IDENT", force: :cascade do |t|
    t.string "TOKEN", limit: 767
  end

  create_table "FUNCS", primary_key: "FUNC_ID", force: :cascade do |t|
    t.string  "CLASS_NAME",  limit: 4000
    t.integer "CREATE_TIME",              null: false
    t.integer "DB_ID",       limit: 8
    t.string  "FUNC_NAME",   limit: 128
    t.integer "FUNC_TYPE",                null: false
    t.string  "OWNER_NAME",  limit: 128
    t.string  "OWNER_TYPE",  limit: 10
  end

  add_index "FUNCS", ["DB_ID"], name: "FUNCS_N49", using: :btree
  add_index "FUNCS", ["FUNC_NAME", "DB_ID"], name: "UNIQUEFUNCTION", unique: true, using: :btree

  create_table "FUNC_RU", id: false, force: :cascade do |t|
    t.integer "FUNC_ID",       limit: 8,    null: false
    t.integer "RESOURCE_TYPE",              null: false
    t.string  "RESOURCE_URI",  limit: 4000
    t.integer "INTEGER_IDX",                null: false
  end

  add_index "FUNC_RU", ["FUNC_ID"], name: "FUNC_RU_N49", using: :btree

  create_table "GLOBAL_PRIVS", primary_key: "USER_GRANT_ID", force: :cascade do |t|
    t.integer "CREATE_TIME",    limit: 8,   null: false
    t.integer "GRANT_OPTION",   limit: 2,   null: false
    t.string  "GRANTOR",        limit: 128
    t.string  "GRANTOR_TYPE",   limit: 128
    t.string  "PRINCIPAL_NAME", limit: 128
    t.string  "PRINCIPAL_TYPE", limit: 128
    t.string  "USER_PRIV",      limit: 128
  end

  add_index "GLOBAL_PRIVS", ["PRINCIPAL_NAME", "PRINCIPAL_TYPE", "USER_PRIV", "GRANTOR", "GRANTOR_TYPE"], name: "GLOBALPRIVILEGEINDEX", unique: true, using: :btree

  create_table "IDXS", primary_key: "INDEX_ID", force: :cascade do |t|
    t.integer "CREATE_TIME",         limit: 8,    null: false
    t.boolean "DEFERRED_REBUILD",                 null: false
    t.string  "INDEX_HANDLER_CLASS", limit: 4000
    t.string  "INDEX_NAME",          limit: 128
    t.integer "INDEX_TBL_ID",        limit: 8
    t.integer "LAST_ACCESS_TIME",    limit: 8,    null: false
    t.integer "ORIG_TBL_ID",         limit: 8
    t.integer "SD_ID",               limit: 8
  end

  add_index "IDXS", ["INDEX_NAME", "ORIG_TBL_ID"], name: "UNIQUEINDEX", unique: true, using: :btree
  add_index "IDXS", ["INDEX_TBL_ID"], name: "IDXS_N50", using: :btree
  add_index "IDXS", ["ORIG_TBL_ID"], name: "IDXS_N49", using: :btree
  add_index "IDXS", ["SD_ID"], name: "IDXS_N51", using: :btree

  create_table "INDEX_PARAMS", id: false, force: :cascade do |t|
    t.integer "INDEX_ID",    limit: 8,    null: false
    t.string  "PARAM_KEY",   limit: 256,  null: false
    t.string  "PARAM_VALUE", limit: 4000
  end

  add_index "INDEX_PARAMS", ["INDEX_ID"], name: "INDEX_PARAMS_N49", using: :btree

  create_table "MASTER_KEYS", primary_key: "KEY_ID", force: :cascade do |t|
    t.string "MASTER_KEY", limit: 767
  end

  create_table "NOTIFICATION_LOG", primary_key: "NL_ID", force: :cascade do |t|
    t.integer "EVENT_ID",   limit: 8,   null: false
    t.integer "EVENT_TIME",             null: false
    t.string  "EVENT_TYPE", limit: 32,  null: false
    t.string  "DB_NAME",    limit: 128
    t.string  "TBL_NAME",   limit: 128
    t.text    "MESSAGE"
  end

  create_table "NOTIFICATION_SEQUENCE", primary_key: "NNI_ID", force: :cascade do |t|
    t.integer "NEXT_EVENT_ID", limit: 8, null: false
  end

  create_table "NUCLEUS_TABLES", primary_key: "CLASS_NAME", force: :cascade do |t|
    t.string "TABLE_NAME",     limit: 128, null: false
    t.string "TYPE",           limit: 4,   null: false
    t.string "OWNER",          limit: 2,   null: false
    t.string "VERSION",        limit: 20,  null: false
    t.string "INTERFACE_NAME", limit: 255
  end

  create_table "PARTITIONS", primary_key: "PART_ID", force: :cascade do |t|
    t.integer "CREATE_TIME",      limit: 8,   null: false
    t.integer "LAST_ACCESS_TIME", limit: 8,   null: false
    t.string  "PART_NAME",        limit: 767
    t.integer "SD_ID",            limit: 8
    t.integer "TBL_ID",           limit: 8
  end

  add_index "PARTITIONS", ["PART_NAME", "TBL_ID"], name: "UNIQUEPARTITION", unique: true, using: :btree
  add_index "PARTITIONS", ["SD_ID"], name: "PARTITIONS_N50", using: :btree
  add_index "PARTITIONS", ["TBL_ID"], name: "PARTITIONS_N49", using: :btree

  create_table "PARTITION_EVENTS", primary_key: "PART_NAME_ID", force: :cascade do |t|
    t.string  "DB_NAME",        limit: 128
    t.integer "EVENT_TIME",     limit: 8,   null: false
    t.integer "EVENT_TYPE",                 null: false
    t.string  "PARTITION_NAME", limit: 767
    t.string  "TBL_NAME",       limit: 128
  end

  add_index "PARTITION_EVENTS", ["PARTITION_NAME"], name: "PARTITIONEVENTINDEX", using: :btree

  create_table "PARTITION_KEYS", id: false, force: :cascade do |t|
    t.integer "TBL_ID",       limit: 8,    null: false
    t.string  "PKEY_COMMENT", limit: 4000
    t.string  "PKEY_NAME",    limit: 128,  null: false
    t.string  "PKEY_TYPE",    limit: 767,  null: false
    t.integer "INTEGER_IDX",  limit: 8,    null: false
  end

  add_index "PARTITION_KEYS", ["TBL_ID"], name: "PARTITION_KEYS_N49", using: :btree

  create_table "PARTITION_KEY_VALS", id: false, force: :cascade do |t|
    t.integer "PART_ID",      limit: 8,   null: false
    t.string  "PART_KEY_VAL", limit: 256
    t.integer "INTEGER_IDX",  limit: 8,   null: false
  end

  add_index "PARTITION_KEY_VALS", ["PART_ID"], name: "PARTITION_KEY_VALS_N49", using: :btree

  create_table "PARTITION_PARAMS", id: false, force: :cascade do |t|
    t.integer "PART_ID",     limit: 8,    null: false
    t.string  "PARAM_KEY",   limit: 256,  null: false
    t.string  "PARAM_VALUE", limit: 4000
  end

  add_index "PARTITION_PARAMS", ["PART_ID"], name: "PARTITION_PARAMS_N49", using: :btree

  create_table "PART_COL_PRIVS", primary_key: "PART_COLUMN_GRANT_ID", force: :cascade do |t|
    t.string  "COLUMN_NAME",    limit: 128
    t.integer "CREATE_TIME",    limit: 8,   null: false
    t.integer "GRANT_OPTION",   limit: 2,   null: false
    t.string  "GRANTOR",        limit: 128
    t.string  "GRANTOR_TYPE",   limit: 128
    t.integer "PART_ID",        limit: 8
    t.string  "PRINCIPAL_NAME", limit: 128
    t.string  "PRINCIPAL_TYPE", limit: 128
    t.string  "PART_COL_PRIV",  limit: 128
  end

  add_index "PART_COL_PRIVS", ["PART_ID", "COLUMN_NAME", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "PART_COL_PRIV", "GRANTOR", "GRANTOR_TYPE"], name: "PARTITIONCOLUMNPRIVILEGEINDEX", using: :btree
  add_index "PART_COL_PRIVS", ["PART_ID"], name: "PART_COL_PRIVS_N49", using: :btree

  create_table "PART_COL_STATS", primary_key: "CS_ID", force: :cascade do |t|
    t.string  "DB_NAME",                limit: 128
    t.string  "TABLE_NAME",             limit: 128
    t.string  "PARTITION_NAME",         limit: 767
    t.string  "COLUMN_NAME",            limit: 128
    t.string  "COLUMN_TYPE",            limit: 128
    t.integer "PART_ID",                limit: 8,    null: false
    t.integer "LONG_LOW_VALUE",         limit: 8
    t.integer "LONG_HIGH_VALUE",        limit: 8
    t.float   "DOUBLE_LOW_VALUE"
    t.float   "DOUBLE_HIGH_VALUE"
    t.string  "BIG_DECIMAL_LOW_VALUE",  limit: 4000
    t.string  "BIG_DECIMAL_HIGH_VALUE", limit: 4000
    t.integer "NUM_NULLS",              limit: 8,    null: false
    t.integer "NUM_DISTINCTS",          limit: 8
    t.float   "AVG_COL_LEN"
    t.integer "MAX_COL_LEN",            limit: 8
    t.integer "NUM_TRUES",              limit: 8
    t.integer "NUM_FALSES",             limit: 8
    t.integer "LAST_ANALYZED",          limit: 8,    null: false
  end

  add_index "PART_COL_STATS", ["DB_NAME", "TABLE_NAME", "COLUMN_NAME", "PARTITION_NAME"], name: "PCS_STATS_IDX", using: :btree
  add_index "PART_COL_STATS", ["PART_ID"], name: "PART_COL_STATS_N49", using: :btree

  create_table "PART_PRIVS", primary_key: "PART_GRANT_ID", force: :cascade do |t|
    t.integer "CREATE_TIME",    limit: 8,   null: false
    t.integer "GRANT_OPTION",   limit: 2,   null: false
    t.string  "GRANTOR",        limit: 128
    t.string  "GRANTOR_TYPE",   limit: 128
    t.integer "PART_ID",        limit: 8
    t.string  "PRINCIPAL_NAME", limit: 128
    t.string  "PRINCIPAL_TYPE", limit: 128
    t.string  "PART_PRIV",      limit: 128
  end

  add_index "PART_PRIVS", ["PART_ID", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "PART_PRIV", "GRANTOR", "GRANTOR_TYPE"], name: "PARTPRIVILEGEINDEX", using: :btree
  add_index "PART_PRIVS", ["PART_ID"], name: "PART_PRIVS_N49", using: :btree

  create_table "ROLES", primary_key: "ROLE_ID", force: :cascade do |t|
    t.integer "CREATE_TIME", limit: 8,   null: false
    t.string  "OWNER_NAME",  limit: 128
    t.string  "ROLE_NAME",   limit: 128
  end

  add_index "ROLES", ["ROLE_NAME"], name: "ROLEENTITYINDEX", unique: true, using: :btree

  create_table "ROLE_MAP", primary_key: "ROLE_GRANT_ID", force: :cascade do |t|
    t.integer "ADD_TIME",       limit: 8,   null: false
    t.integer "GRANT_OPTION",   limit: 2,   null: false
    t.string  "GRANTOR",        limit: 128
    t.string  "GRANTOR_TYPE",   limit: 128
    t.string  "PRINCIPAL_NAME", limit: 128
    t.string  "PRINCIPAL_TYPE", limit: 128
    t.integer "ROLE_ID",        limit: 8
  end

  add_index "ROLE_MAP", ["PRINCIPAL_NAME", "ROLE_ID", "GRANTOR", "GRANTOR_TYPE"], name: "USERROLEMAPINDEX", unique: true, using: :btree
  add_index "ROLE_MAP", ["ROLE_ID"], name: "ROLE_MAP_N49", using: :btree

  create_table "SDS", primary_key: "SD_ID", force: :cascade do |t|
    t.string  "INPUT_FORMAT",              limit: 4000
    t.boolean "IS_COMPRESSED",                          null: false
    t.string  "LOCATION",                  limit: 4000
    t.integer "NUM_BUCKETS",               limit: 8,    null: false
    t.string  "OUTPUT_FORMAT",             limit: 4000
    t.integer "SERDE_ID",                  limit: 8
    t.integer "CD_ID",                     limit: 8
    t.boolean "IS_STOREDASSUBDIRECTORIES",              null: false
  end

  add_index "SDS", ["SERDE_ID"], name: "SDS_N49", using: :btree

  create_table "SD_PARAMS", id: false, force: :cascade do |t|
    t.integer "SD_ID",       limit: 8,    null: false
    t.string  "PARAM_KEY",   limit: 256,  null: false
    t.string  "PARAM_VALUE", limit: 4000
  end

  add_index "SD_PARAMS", ["SD_ID"], name: "SD_PARAMS_N49", using: :btree

  create_table "SEQUENCE_TABLE", primary_key: "SEQUENCE_NAME", force: :cascade do |t|
    t.integer "NEXT_VAL", limit: 8, null: false
  end

  create_table "SERDES", primary_key: "SERDE_ID", force: :cascade do |t|
    t.string "NAME", limit: 128
    t.string "SLIB", limit: 4000
  end

  create_table "SERDE_PARAMS", id: false, force: :cascade do |t|
    t.integer "SERDE_ID",    limit: 8,    null: false
    t.string  "PARAM_KEY",   limit: 256,  null: false
    t.string  "PARAM_VALUE", limit: 4000
  end

  add_index "SERDE_PARAMS", ["SERDE_ID"], name: "SERDE_PARAMS_N49", using: :btree

  create_table "SKEWED_COL_NAMES", id: false, force: :cascade do |t|
    t.integer "SD_ID",           limit: 8,   null: false
    t.string  "SKEWED_COL_NAME", limit: 256
    t.integer "INTEGER_IDX",     limit: 8,   null: false
  end

  create_table "SKEWED_COL_VALUE_LOC_MAP", id: false, force: :cascade do |t|
    t.integer "SD_ID",              limit: 8,    null: false
    t.integer "STRING_LIST_ID_KID", limit: 8,    null: false
    t.string  "LOCATION",           limit: 4000
  end

  create_table "SKEWED_STRING_LIST", primary_key: "STRING_LIST_ID", force: :cascade do |t|
  end

  create_table "SKEWED_STRING_LIST_VALUES", id: false, force: :cascade do |t|
    t.integer "STRING_LIST_ID",    limit: 8,   null: false
    t.string  "STRING_LIST_VALUE", limit: 256
    t.integer "INTEGER_IDX",       limit: 8,   null: false
  end

  create_table "SKEWED_VALUES", id: false, force: :cascade do |t|
    t.integer "SD_ID_OID",          limit: 8, null: false
    t.integer "STRING_LIST_ID_EID", limit: 8, null: false
    t.integer "INTEGER_IDX",        limit: 8, null: false
  end

  create_table "SORT_COLS", id: false, force: :cascade do |t|
    t.integer "SD_ID",       limit: 8,   null: false
    t.string  "COLUMN_NAME", limit: 128
    t.integer "ORDER",       limit: 8,   null: false
    t.integer "INTEGER_IDX", limit: 8,   null: false
  end

  add_index "SORT_COLS", ["SD_ID"], name: "SORT_COLS_N49", using: :btree

  create_table "TABLE_PARAMS", id: false, force: :cascade do |t|
    t.integer "TBL_ID",      limit: 8,    null: false
    t.string  "PARAM_KEY",   limit: 256,  null: false
    t.string  "PARAM_VALUE", limit: 4000
  end

  add_index "TABLE_PARAMS", ["TBL_ID"], name: "TABLE_PARAMS_N49", using: :btree

  create_table "TAB_COL_STATS", primary_key: "CS_ID", force: :cascade do |t|
    t.string  "DB_NAME",                limit: 128
    t.string  "TABLE_NAME",             limit: 128
    t.string  "COLUMN_NAME",            limit: 128
    t.string  "COLUMN_TYPE",            limit: 128
    t.integer "TBL_ID",                 limit: 8,    null: false
    t.integer "LONG_LOW_VALUE",         limit: 8
    t.integer "LONG_HIGH_VALUE",        limit: 8
    t.float   "DOUBLE_LOW_VALUE"
    t.float   "DOUBLE_HIGH_VALUE"
    t.string  "BIG_DECIMAL_LOW_VALUE",  limit: 4000
    t.string  "BIG_DECIMAL_HIGH_VALUE", limit: 4000
    t.integer "NUM_NULLS",              limit: 8,    null: false
    t.integer "NUM_DISTINCTS",          limit: 8
    t.float   "AVG_COL_LEN"
    t.integer "MAX_COL_LEN",            limit: 8
    t.integer "NUM_TRUES",              limit: 8
    t.integer "NUM_FALSES",             limit: 8
    t.integer "LAST_ANALYZED",          limit: 8,    null: false
  end

  add_index "TAB_COL_STATS", ["TBL_ID"], name: "TAB_COL_STATS_N49", using: :btree

  create_table "TBLS", primary_key: "TBL_ID", force: :cascade do |t|
    t.integer "CREATE_TIME",        limit: 8,   null: false
    t.integer "DB_ID",              limit: 8
    t.integer "LAST_ACCESS_TIME",   limit: 8,   null: false
    t.string  "OWNER",              limit: 767
    t.integer "RETENTION",          limit: 8,   null: false
    t.integer "SD_ID",              limit: 8
    t.string  "TBL_NAME",           limit: 128
    t.string  "TBL_TYPE",           limit: 128
    t.text    "VIEW_EXPANDED_TEXT"
    t.text    "VIEW_ORIGINAL_TEXT"
  end

  add_index "TBLS", ["DB_ID"], name: "TBLS_N49", using: :btree
  add_index "TBLS", ["SD_ID"], name: "TBLS_N50", using: :btree
  add_index "TBLS", ["TBL_NAME", "DB_ID"], name: "UNIQUETABLE", unique: true, using: :btree

  create_table "TBL_COL_PRIVS", primary_key: "TBL_COLUMN_GRANT_ID", force: :cascade do |t|
    t.string  "COLUMN_NAME",    limit: 128
    t.integer "CREATE_TIME",    limit: 8,   null: false
    t.integer "GRANT_OPTION",   limit: 2,   null: false
    t.string  "GRANTOR",        limit: 128
    t.string  "GRANTOR_TYPE",   limit: 128
    t.string  "PRINCIPAL_NAME", limit: 128
    t.string  "PRINCIPAL_TYPE", limit: 128
    t.string  "TBL_COL_PRIV",   limit: 128
    t.integer "TBL_ID",         limit: 8
  end

  add_index "TBL_COL_PRIVS", ["TBL_ID", "COLUMN_NAME", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "TBL_COL_PRIV", "GRANTOR", "GRANTOR_TYPE"], name: "TABLECOLUMNPRIVILEGEINDEX", using: :btree
  add_index "TBL_COL_PRIVS", ["TBL_ID"], name: "TBL_COL_PRIVS_N49", using: :btree

  create_table "TBL_PRIVS", primary_key: "TBL_GRANT_ID", force: :cascade do |t|
    t.integer "CREATE_TIME",    limit: 8,   null: false
    t.integer "GRANT_OPTION",   limit: 2,   null: false
    t.string  "GRANTOR",        limit: 128
    t.string  "GRANTOR_TYPE",   limit: 128
    t.string  "PRINCIPAL_NAME", limit: 128
    t.string  "PRINCIPAL_TYPE", limit: 128
    t.string  "TBL_PRIV",       limit: 128
    t.integer "TBL_ID",         limit: 8
  end

  add_index "TBL_PRIVS", ["TBL_ID", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "TBL_PRIV", "GRANTOR", "GRANTOR_TYPE"], name: "TABLEPRIVILEGEINDEX", using: :btree
  add_index "TBL_PRIVS", ["TBL_ID"], name: "TBL_PRIVS_N49", using: :btree

  create_table "TYPES", primary_key: "TYPES_ID", force: :cascade do |t|
    t.string "TYPE_NAME", limit: 128
    t.string "TYPE1",     limit: 767
    t.string "TYPE2",     limit: 767
  end

  add_index "TYPES", ["TYPE_NAME"], name: "UNIQUE_TYPE", unique: true, using: :btree

  create_table "TYPE_FIELDS", id: false, force: :cascade do |t|
    t.integer "TYPE_NAME",   limit: 8,   null: false
    t.string  "COMMENT",     limit: 256
    t.string  "FIELD_NAME",  limit: 128, null: false
    t.string  "FIELD_TYPE",  limit: 767, null: false
    t.integer "INTEGER_IDX", limit: 8,   null: false
  end

  add_index "TYPE_FIELDS", ["TYPE_NAME"], name: "TYPE_FIELDS_N49", using: :btree

  create_table "VERSION", primary_key: "VER_ID", force: :cascade do |t|
    t.string "SCHEMA_VERSION",  limit: 127, null: false
    t.string "VERSION_COMMENT", limit: 255, null: false
  end

  create_table "affiliated_orgs", id: false, force: :cascade do |t|
    t.string   "organization_ppb_country", limit: 31
    t.decimal  "employer_id",                          precision: 38
    t.datetime "update_ts",                            precision: 6
    t.decimal  "create_user_id",                       precision: 38
    t.decimal  "update_user_id",                       precision: 38
    t.string   "organization_country",     limit: 31
    t.datetime "create_ts",                            precision: 6
    t.decimal  "affiliated_org_id",                    precision: 38, null: false
    t.string   "organization_name",        limit: 101,                null: false
  end

  create_table "agency_file_details", primary_key: "file_id", force: :cascade do |t|
    t.string "file_pat",      limit: 100, null: false
    t.string "agency",        limit: 10,  null: false
    t.text   "description"
    t.time   "expected_time"
    t.string "frequency",     limit: 20
    t.string "schedule",      limit: 200
    t.string "legacy_name",   limit: 40
    t.string "log_location",  limit: 200
  end

  create_table "brd_11578f56ea467c745c0bb8854c1d310cc0a3376b", id: false, force: :cascade do |t|
    t.integer  "row_id",                                       limit: 8, default: "nextval('brd_11578f56ea467c745c0bb8854c1d310cc0a3376b_row_id_seq'::regclass)", null: false
    t.datetime "modification_timestamp",                                                                                                                          null: false
    t.integer  "modifier_uuid",                                                                                                                                   null: false
    t.text     "col_cd11a6462a804b9119f054275b44a7335e535450",                                                                                                    null: false
    t.text     "col_02541a942642198686a4d5d0600e55b50c5ceb73",                                                                                                    null: false
    t.text     "col_956b6bcef8ded05302ae39aae3ee45f55249a08c",                                                                                                    null: false
    t.float    "col_76848a51abc8a4425d880c875756d3d418e1c1c4",                                                                                                    null: false
    t.float    "col_e722f4f84b394ce2ede0c615e10204d0efab4e8a",                                                                                                    null: false
    t.text     "col_0f926799b910a46327586d1a964b629d3c91c760",                                                                                                    null: false
    t.text     "col_2d54c297ac7d85676891e5fb986478a521d08c45",                                                                                                    null: false
    t.text     "col_f13e4eb25abfbda52b873574c505d5a7b2163bf2"
    t.text     "col_a9ed9534cdeb63776a04ad93f7b6d2a310db9222"
    t.text     "col_a60f66bc15caad86091710cbf030f3a37d69be7c"
    t.text     "col_ab9244080edb4763c468e871a3601dd8ed9f6dbe"
    t.text     "col_e8e15e75660e44c13afc21b8c3ec3d6e676e8e42"
    t.text     "col_434e37085470d30301aa07ba0fd3379436b2030f"
    t.text     "col_fd397feeff7c89d0f281827210daf207e60736a3"
    t.text     "col_81645c3b536602ae54ec54c96bc694466763a965"
    t.text     "col_184d90bab2b3367927ce49826e6018d881ca2de6"
    t.text     "col_144b8aac0db947a58ac5f9902684a99e4bb21358"
    t.text     "col_d16c1db6d1fca2699d4feac6e863a6e1487b9366"
    t.text     "col_671c67c4348b7d504cf2564c22644c9debf1ebbc"
    t.text     "col_594ef2032ce7da4bc84a69e7eb3264272f094224"
    t.text     "col_f067534a6de5055dc1ca366ca5dbea1bbcfb3ac7"
    t.text     "col_d805cc6e489f9a0e29b99a61b56fd5b4e63a58e9"
    t.text     "col_3f375235cd99e2a0314879197e12c57d629b1e4f"
    t.text     "col_d1109dea964e6cbebdaa69658f80d902fff976d7"
    t.text     "col_b9b5d9f3734815b835044888329629de6cddcc6d"
    t.text     "col_8f1c773e05255fd564fe0c0885122b3d53fa4311"
    t.text     "col_c22eedee9767433df0bde0b1e5a05c4a5da624da"
    t.text     "col_f7df389013073dc91e55259a2f3800482977c319"
    t.text     "col_feaf24fe1c506be7624b58dd7cb4ec06c1a933c4"
    t.text     "col_eb66d98e088503ff4e444a51cbc48bdce58dea2a"
    t.text     "col_772236980e03bfeb50c02d24d74c89dcc3881a38"
    t.text     "col_9ac77a0a073a61a3e91e255bf369a5718d346c5f"
    t.text     "col_d008c76263a92143cbd39a00c88d5961332caccb"
    t.text     "col_fc373207e874174fc1d6e3501ea9db4c7aeb3c9d"
    t.text     "col_e89751487b6f2047e72347433f03a08be3a16a12"
    t.text     "col_125224efe844ec07f500bfa199ddf7677968a633",                                                                                                    null: false
    t.text     "col_a98f85a855f924ea4aed98c67bcfb6ef7774315f"
    t.float    "col_ba3c373a9f957df7668eb23b1d1a00c9f90f6270"
  end

  create_table "builds", force: :cascade do |t|
    t.text     "violations_archive"
    t.integer  "repo_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "uuid",                null: false
    t.integer  "pull_request_number"
    t.string   "commit_sha"
  end

  add_index "builds", ["repo_id"], name: "index_builds_on_repo_id", using: :btree
  add_index "builds", ["uuid"], name: "index_builds_on_uuid", unique: true, using: :btree

  create_table "compaction_queue", primary_key: "cq_id", force: :cascade do |t|
    t.string  "cq_database",  limit: 128, null: false
    t.string  "cq_table",     limit: 128, null: false
    t.string  "cq_partition", limit: 767
    t.string  "cq_state",     limit: 1,   null: false
    t.string  "cq_type",      limit: 1,   null: false
    t.string  "cq_worker_id", limit: 128
    t.integer "cq_start",     limit: 8
    t.string  "cq_run_as",    limit: 128
  end

  create_table "completed_txn_components", id: false, force: :cascade do |t|
    t.integer "ctc_txnid",     limit: 8
    t.string  "ctc_database",  limit: 128, null: false
    t.string  "ctc_table",     limit: 128
    t.string  "ctc_partition", limit: 767
  end

  create_table "data_ab077396fd77c1c66df95bbc6fa77956e05340cf", id: false, force: :cascade do |t|
    t.integer  "row_id",       limit: 8, default: "nextval('data_ab077396fd77c1c66df95bbc6fa77956e05340cf_row_id_seq'::regclass)", null: false
    t.datetime "modification",                                                                                                     null: false
    t.integer  "modifier",                                                                                                         null: false
  end

  create_table "db_list", force: :cascade do |t|
    t.string   "dbname",        limit: 255
    t.integer  "sqld"
    t.datetime "created_at"
    t.datetime "last_updated"
    t.datetime "last_accessed"
  end

  create_table "hive_locks", id: false, force: :cascade do |t|
    t.integer "hl_lock_ext_id",    limit: 8,   null: false
    t.integer "hl_lock_int_id",    limit: 8,   null: false
    t.integer "hl_txnid",          limit: 8
    t.string  "hl_db",             limit: 128, null: false
    t.string  "hl_table",          limit: 128
    t.string  "hl_partition",      limit: 767
    t.string  "hl_lock_state",     limit: 1,   null: false
    t.string  "hl_lock_type",      limit: 1,   null: false
    t.integer "hl_last_heartbeat", limit: 8,   null: false
    t.integer "hl_acquired_at",    limit: 8
    t.string  "hl_user",           limit: 128, null: false
    t.string  "hl_host",           limit: 128, null: false
  end

  add_index "hive_locks", ["hl_txnid"], name: "hl_txnid_index", using: :hash

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "repo_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["repo_id"], name: "index_memberships_on_repo_id", using: :btree
  add_index "memberships", ["user_id", "repo_id"], name: "index_memberships_on_user_id_and_repo_id", unique: true, using: :btree

  create_table "mytest", id: false, force: :cascade do |t|
    t.integer "id"
    t.string  "name", limit: 20
  end

  create_table "next_compaction_queue_id", id: false, force: :cascade do |t|
    t.integer "ncq_next", limit: 8, null: false
  end

  create_table "next_lock_id", id: false, force: :cascade do |t|
    t.integer "nl_next", limit: 8, null: false
  end

  create_table "next_txn_id", id: false, force: :cascade do |t|
    t.integer "ntxn_next", limit: 8, null: false
  end

  create_table "number", primary_key: "numbervalue", force: :cascade do |t|
    t.string   "stringvalue", limit: 50, null: false
    t.datetime "datevalue",              null: false
  end

  create_table "owners", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "github_id",                    null: false
    t.string   "name",                         null: false
    t.boolean  "organization", default: false, null: false
  end

  add_index "owners", ["github_id"], name: "index_owners_on_github_id", unique: true, using: :btree
  add_index "owners", ["name"], name: "index_owners_on_name", unique: true, using: :btree

  create_table "pool_dynamic", id: false, force: :cascade do |t|
    t.string  "ticker",                     limit: 3,  null: false
    t.string  "series",                     limit: 10, null: false
    t.date    "factor_date",                           null: false
    t.float   "balance"
    t.integer "loan_count"
    t.float   "coupon"
    t.float   "previous_coupon"
    t.float   "interest"
    t.float   "factor"
    t.float   "sched"
    t.float   "unsched"
    t.float   "principal"
    t.date    "payment_date"
    t.date    "interest_accrual_end_date"
    t.date    "adjusted_next_payment_date"
    t.date    "adjusted_payment_date"
  end

  create_table "pool_dynamic_collateral_composition", id: false, force: :cascade do |t|
    t.string "ticker",        limit: 3,  null: false
    t.string "series",        limit: 10, null: false
    t.date   "factor_date",              null: false
    t.string "coll_level1",   limit: 30
    t.string "coll_level2",   limit: 30
    t.float  "balance"
    t.float  "balance_ratio"
    t.float  "loan_count"
  end

  create_table "pool_dynamic_geo_composition", id: false, force: :cascade do |t|
    t.string "ticker",        limit: 3,  null: false
    t.string "series",        limit: 10, null: false
    t.date   "factor_date",              null: false
    t.string "geo_name",      limit: 10
    t.float  "balance"
    t.float  "balance_ratio"
    t.float  "loan_count"
    t.float  "loan_ratio"
  end

  create_table "pool_dynamic_quartile", id: false, force: :cascade do |t|
    t.string "ticker",      limit: 3,  null: false
    t.string "series",      limit: 10, null: false
    t.date   "factor_date",            null: false
    t.string "metric_name", limit: 30
    t.float  "metric_0"
    t.float  "metric_25"
    t.float  "metric_50"
    t.float  "metric_75"
    t.float  "metric_100"
  end

  create_table "pool_static", id: false, force: :cascade do |t|
    t.string "ticker",           limit: 3,  null: false
    t.string "series",           limit: 10, null: false
    t.string "cusip",            limit: 9,  null: false
    t.date   "maturity_date"
    t.float  "original_balance"
    t.string "pool_prefix_code", limit: 3
    t.date   "settle_date"
    t.string "bb_unique_id",     limit: 20
  end

  create_table "repos", force: :cascade do |t|
    t.integer  "github_id",                        null: false
    t.boolean  "active",           default: false, null: false
    t.integer  "hook_id"
    t.string   "full_github_name",                 null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "private"
    t.boolean  "in_organization"
    t.integer  "owner_id"
  end

  add_index "repos", ["active"], name: "index_repos_on_active", using: :btree
  add_index "repos", ["full_github_name"], name: "index_repos_on_full_github_name", unique: true, using: :btree
  add_index "repos", ["github_id"], name: "index_repos_on_github_id", using: :btree
  add_index "repos", ["owner_id"], name: "index_repos_on_owner_id", using: :btree

  create_table "style_configs", force: :cascade do |t|
    t.boolean "enabled",  default: true, null: false
    t.string  "language",                null: false
    t.text    "rules",                   null: false
    t.integer "owner_id",                null: false
  end

  add_index "style_configs", ["owner_id", "language"], name: "index_style_configs_on_owner_id_and_language", unique: true, using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "user_id",                                                      null: false
    t.integer  "repo_id",                                                      null: false
    t.string   "stripe_subscription_id",                                       null: false
    t.datetime "deleted_at"
    t.decimal  "price",                  precision: 8, scale: 2, default: 0.0, null: false
  end

  add_index "subscriptions", ["repo_id"], name: "index_subscriptions_on_repo_id", unique: true, where: "(deleted_at IS NULL)", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "txn_components", id: false, force: :cascade do |t|
    t.integer "tc_txnid",     limit: 8
    t.string  "tc_database",  limit: 128, null: false
    t.string  "tc_table",     limit: 128
    t.string  "tc_partition", limit: 767
  end

  create_table "txns", primary_key: "txn_id", force: :cascade do |t|
    t.string  "txn_state",          limit: 1,   null: false
    t.integer "txn_started",        limit: 8,   null: false
    t.integer "txn_last_heartbeat", limit: 8,   null: false
    t.string  "txn_user",           limit: 128, null: false
    t.string  "txn_host",           limit: 128, null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "github_username",                    null: false
    t.string   "remember_token",                     null: false
    t.boolean  "refreshing_repos",   default: false
    t.string   "email_address"
    t.string   "stripe_customer_id"
    t.string   "token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "violations", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "build_id",                    null: false
    t.string   "filename",                    null: false
    t.integer  "patch_position"
    t.integer  "line_number"
    t.text     "messages",       default: [], null: false, array: true
  end

  add_index "violations", ["build_id"], name: "index_violations_on_build_id", using: :btree

  add_foreign_key "BUCKETING_COLS", "\"SDS\"", column: "SD_ID", primary_key: "SD_ID", name: "BUCKETING_COLS_SD_ID_fkey"
  add_foreign_key "COLUMNS_OLD", "\"SDS\"", column: "SD_ID", primary_key: "SD_ID", name: "COLUMNS_SD_ID_fkey"
  add_foreign_key "COLUMNS_V2", "\"CDS\"", column: "CD_ID", primary_key: "CD_ID", name: "COLUMNS_V2_CD_ID_fkey"
  add_foreign_key "DATABASE_PARAMS", "\"DBS\"", column: "DB_ID", primary_key: "DB_ID", name: "DATABASE_PARAMS_DB_ID_fkey"
  add_foreign_key "DB_PRIVS", "\"DBS\"", column: "DB_ID", primary_key: "DB_ID", name: "DB_PRIVS_DB_ID_fkey"
  add_foreign_key "FUNCS", "\"DBS\"", column: "DB_ID", primary_key: "DB_ID", name: "FUNCS_FK1"
  add_foreign_key "FUNC_RU", "\"FUNCS\"", column: "FUNC_ID", primary_key: "FUNC_ID", name: "FUNC_RU_FK1"
  add_foreign_key "IDXS", "\"SDS\"", column: "SD_ID", primary_key: "SD_ID", name: "IDXS_SD_ID_fkey"
  add_foreign_key "IDXS", "\"TBLS\"", column: "INDEX_TBL_ID", primary_key: "TBL_ID", name: "IDXS_INDEX_TBL_ID_fkey"
  add_foreign_key "IDXS", "\"TBLS\"", column: "ORIG_TBL_ID", primary_key: "TBL_ID", name: "IDXS_ORIG_TBL_ID_fkey"
  add_foreign_key "INDEX_PARAMS", "\"IDXS\"", column: "INDEX_ID", primary_key: "INDEX_ID", name: "INDEX_PARAMS_INDEX_ID_fkey"
  add_foreign_key "PARTITIONS", "\"SDS\"", column: "SD_ID", primary_key: "SD_ID", name: "PARTITIONS_SD_ID_fkey"
  add_foreign_key "PARTITIONS", "\"TBLS\"", column: "TBL_ID", primary_key: "TBL_ID", name: "PARTITIONS_TBL_ID_fkey"
  add_foreign_key "PARTITION_KEYS", "\"TBLS\"", column: "TBL_ID", primary_key: "TBL_ID", name: "PARTITION_KEYS_TBL_ID_fkey"
  add_foreign_key "PARTITION_KEY_VALS", "\"PARTITIONS\"", column: "PART_ID", primary_key: "PART_ID", name: "PARTITION_KEY_VALS_PART_ID_fkey"
  add_foreign_key "PARTITION_PARAMS", "\"PARTITIONS\"", column: "PART_ID", primary_key: "PART_ID", name: "PARTITION_PARAMS_PART_ID_fkey"
  add_foreign_key "PART_COL_PRIVS", "\"PARTITIONS\"", column: "PART_ID", primary_key: "PART_ID", name: "PART_COL_PRIVS_PART_ID_fkey"
  add_foreign_key "PART_COL_STATS", "\"PARTITIONS\"", column: "PART_ID", primary_key: "PART_ID", name: "PART_COL_STATS_fkey"
  add_foreign_key "PART_PRIVS", "\"PARTITIONS\"", column: "PART_ID", primary_key: "PART_ID", name: "PART_PRIVS_PART_ID_fkey"
  add_foreign_key "ROLE_MAP", "\"ROLES\"", column: "ROLE_ID", primary_key: "ROLE_ID", name: "ROLE_MAP_ROLE_ID_fkey"
  add_foreign_key "SDS", "\"CDS\"", column: "CD_ID", primary_key: "CD_ID", name: "SDS_CD_ID_fkey"
  add_foreign_key "SDS", "\"SERDES\"", column: "SERDE_ID", primary_key: "SERDE_ID", name: "SDS_SERDE_ID_fkey"
  add_foreign_key "SD_PARAMS", "\"SDS\"", column: "SD_ID", primary_key: "SD_ID", name: "SD_PARAMS_SD_ID_fkey"
  add_foreign_key "SERDE_PARAMS", "\"SERDES\"", column: "SERDE_ID", primary_key: "SERDE_ID", name: "SERDE_PARAMS_SERDE_ID_fkey"
  add_foreign_key "SKEWED_COL_NAMES", "\"SDS\"", column: "SD_ID", primary_key: "SD_ID", name: "SKEWED_COL_NAMES_fkey"
  add_foreign_key "SKEWED_COL_VALUE_LOC_MAP", "\"SDS\"", column: "SD_ID", primary_key: "SD_ID", name: "SKEWED_COL_VALUE_LOC_MAP_fkey1"
  add_foreign_key "SKEWED_COL_VALUE_LOC_MAP", "\"SKEWED_STRING_LIST\"", column: "STRING_LIST_ID_KID", primary_key: "STRING_LIST_ID", name: "SKEWED_COL_VALUE_LOC_MAP_fkey2"
  add_foreign_key "SKEWED_STRING_LIST_VALUES", "\"SKEWED_STRING_LIST\"", column: "STRING_LIST_ID", primary_key: "STRING_LIST_ID", name: "SKEWED_STRING_LIST_VALUES_fkey"
  add_foreign_key "SKEWED_VALUES", "\"SDS\"", column: "SD_ID_OID", primary_key: "SD_ID", name: "SKEWED_VALUES_fkey2"
  add_foreign_key "SKEWED_VALUES", "\"SKEWED_STRING_LIST\"", column: "STRING_LIST_ID_EID", primary_key: "STRING_LIST_ID", name: "SKEWED_VALUES_fkey1"
  add_foreign_key "SORT_COLS", "\"SDS\"", column: "SD_ID", primary_key: "SD_ID", name: "SORT_COLS_SD_ID_fkey"
  add_foreign_key "TABLE_PARAMS", "\"TBLS\"", column: "TBL_ID", primary_key: "TBL_ID", name: "TABLE_PARAMS_TBL_ID_fkey"
  add_foreign_key "TAB_COL_STATS", "\"TBLS\"", column: "TBL_ID", primary_key: "TBL_ID", name: "TAB_COL_STATS_fkey"
  add_foreign_key "TBLS", "\"DBS\"", column: "DB_ID", primary_key: "DB_ID", name: "TBLS_DB_ID_fkey"
  add_foreign_key "TBLS", "\"SDS\"", column: "SD_ID", primary_key: "SD_ID", name: "TBLS_SD_ID_fkey"
  add_foreign_key "TBL_COL_PRIVS", "\"TBLS\"", column: "TBL_ID", primary_key: "TBL_ID", name: "TBL_COL_PRIVS_TBL_ID_fkey"
  add_foreign_key "TBL_PRIVS", "\"TBLS\"", column: "TBL_ID", primary_key: "TBL_ID", name: "TBL_PRIVS_TBL_ID_fkey"
  add_foreign_key "TYPE_FIELDS", "\"TYPES\"", column: "TYPE_NAME", primary_key: "TYPES_ID", name: "TYPE_FIELDS_TYPE_NAME_fkey"
  add_foreign_key "memberships", "repos"
  add_foreign_key "memberships", "users"
  add_foreign_key "repos", "owners"
  add_foreign_key "style_configs", "owners"
  add_foreign_key "txn_components", "txns", column: "tc_txnid", primary_key: "txn_id", name: "txn_components_tc_txnid_fkey"
end
