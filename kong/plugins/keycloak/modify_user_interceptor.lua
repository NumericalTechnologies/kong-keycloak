local regex = require("kong.plugins.keycloak.regex_util")
local errors = require("kong.plugins.keycloak.errors_constants")
local kong = kong

return function(modify_user_config)
  local method = kong.request.get_method()
  if method ~= "PUT" and method ~= "POST" then return end

  for _, blacklist_object in ipairs(modify_user_config.blacklist) do
    if regex.is_modify_or_delete_endpoint(
      kong.request.get_path(),
      regex.sanitize_regex_string(blacklist_object.user_id)
    ) then
      return kong.response.exit(400, { errorMessage = errors.PROTECTED_USER_MODIFY_ERROR_MESSAGE })
    end
  end
end