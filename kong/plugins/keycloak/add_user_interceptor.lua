local regex = require("kong.plugins.keycloak.regex_util")
local errors = require("kong.plugins.keycloak.errors_constants")
local http = require("resty.http")
local kong = kong

return function(add_user_config, host)
  local path = kong.request.get_path()
  local method = kong.request.get_method()

  --[[
    https://www.keycloak.org/docs-api/21.0.1/rest-api/index.html#_users_resource
    Shoud match POST /{realm}/users
    Allow 0 or more prefix for the service path, and admin to refer to the Admin API path.
  --]]
  if method ~= "POST" then return end
  if not regex.is_add_user_endpoint(path) then return end

  if add_user_config.ascii_only_usernames then
    local body = kong.request.get_body("application/json")
    local username = body["username"]
    if username == nil then return end
    
    local username_length = #username
    if username_length < 1 or username_length > 64 then
      return kong.response.exit(400, errors.INVALID_USERNAME_LENGTH)
    end

    if not regex.is_ascii_string(username) then
      return kong.response.exit(400, errors.INVALID_USERNAME_ASCII)
    end
  end

  if add_user_config.max_users > 0 then
    local realm = regex.get_realm_from_add_user_endpoint(path)
    local count_users_url = host .. "/admin/realms/" .. realm .. "/users/count"
    local authorization_header_key = "authorization"
    local authorization = kong.request.get_header(authorization_header_key)

    if authorization == nil then
      return kong.response.exit(400, errors.MISSING_AUTHORIZATION_HEADER)
    end

    local res = http.new():request_uri(count_users_url, {
      method = "GET",
      headers = {
        [authorization_header_key] = authorization,
      },
    })

    if not res or res.status ~= 200 then
      return kong.response.exit(500, errors.UNEXPECTED_ERROR)
    end

    local number_of_users = tonumber(res.body)
    if number_of_users >= add_user_config.max_users then
      return kong.response.exit(400, errors.USER_LIMIT_REACHED)
    end
  end

end