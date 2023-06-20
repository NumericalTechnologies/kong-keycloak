local Schema = require("kong.db.schema")
local typedefs = require("kong.db.schema.typedefs")
local add_user_schema = require("kong.plugins.keycloak.add_user_schema")
local modify_user_schema = require("kong.plugins.keycloak.modify_user_schema")
local delete_user_schema = require("kong.plugins.keycloak.delete_user_schema")

local config_schema = Schema.define {
  type = "record",
  fields = {
    {
      host = {
        type = "string",
        required = true
      }
    },
    { add_user = add_user_schema },
    { modify_user = modify_user_schema },
    { delete_user = delete_user_schema },
  },
}

return {
  name = "kong-keycloak",
  fields = {
    { protocols = typedefs.protocols_http },
    { config = config_schema }
  },
}