local Schema = require "kong.db.schema"

local add_user_schema = Schema.define {
  type = "record",
  fields = {
    {
      enabled = {
        type = "boolean",
        default = true
      }
    },
    {
      ascii_only_usernames = {
        type = "boolean",
        default = true
      }
    },
    {
      max_users = {
        type = "number",
        default = 50
      }
    },
  }
}

return add_user_schema