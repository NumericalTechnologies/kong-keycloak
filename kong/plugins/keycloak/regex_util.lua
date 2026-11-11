local function sanitize_regex_string(string)
  local sanitized_quantifiers = string.gsub(string, "[%^%[%]%(%)%-+*?%$]", "%%%1")
  local sanitized_quantifiers_and_metasequences = string.gsub(sanitized_quantifiers, "%%([acdglpsuwxzA])", "%1")
  return sanitized_quantifiers_and_metasequences
end

local function is_add_user_endpoint(path)
  return string.match(path, ".*/admin/realms/.+/users/?$") ~= nil
end

local function get_realm_from_add_user_endpoint(path)
  return string.match(path, ".*/admin/realms/(.+)/users/?$")
end

local function is_modify_or_delete_endpoint(path, user_id)
  return string.match(path, ".*/admin/realms/.+/users/" .. user_id .. "/?") ~= nil
end

return {
  sanitize_regex_string = sanitize_regex_string,
  is_add_user_endpoint = is_add_user_endpoint,
  get_realm_from_add_user_endpoint = get_realm_from_add_user_endpoint,
  is_modify_or_delete_endpoint = is_modify_or_delete_endpoint,
}


