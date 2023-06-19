local regex = require("kong.plugins.keycloak.utils.regex")
local errors = require("kong.plugins.keycloak.constants.errors")
local kong = kong

return function(delete_user_config)
  local method = kong.request.get_method()
  if method ~= "DELETE" then return end

  for _, blacklist_object in ipairs(delete_user_config.blacklist) do
    if regex.is_modify_or_delete_endpoint(
      kong.request.get_path(),
      regex.sanitize_regex_string(blacklist_object.user_id)
    ) then
      return kong.response.exit(400, { errorMessage = errors.PROTECTED_USER_DELETE_ERROR_MESSAGE })
    end
  end
end