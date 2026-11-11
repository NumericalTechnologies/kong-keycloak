local Schema = require("kong.db.schema")

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
        deprecation = {
          message = "keycloak: config.add_user.ascii_only_usernames is ignored, Keycloak validates usernames",
          removal_in_version = "2.0.0"
        }
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