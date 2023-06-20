local Schema = require("kong.db.schema")

local delete_user_schema = Schema.define {
  type = "record",
  fields = {
    {
      enabled = {
        type = "boolean",
        default = true
      }
    },
    {
      blacklist = {
        type = "array",
        elements = {
          type = "record",
          fields = {
            {
              user_id = {
                type = "string",
                required = true
              }
            }
          }
        },
        default = {}
      }
    }
  }
}

return delete_user_schema