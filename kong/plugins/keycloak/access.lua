local add_user_interceptor = require("kong.plugins.keycloak.interceptors.add_user")
local delete_user_interceptor = require("kong.plugins.keycloak.interceptors.delete_user")
local modify_user_interceptor = require("kong.plugins.keycloak.interceptors.modify_user")
local _M = {}

function _M.execute(config)
  local add_user_config = config.add_user
  if add_user_config.enabled and add_user_interceptor(add_user_config) ~= nil then
    return
  end

  local delete_user_config = config.delete_user
  if delete_user_config.enabled and delete_user_interceptor(delete_user_config) ~= nil then
    return
  end

  local modify_user_config = config.modify_user
  if modify_user_config.enabled and modify_user_interceptor(modify_user_config) ~= nil then
    return
  end
end

return _M