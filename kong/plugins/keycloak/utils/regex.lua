local function is_ascii_string(string)
  return string.match(string, "^[a-zA-Z0-9'.\\%-_!#^~]+$") ~= nil
end

local function sanitize_regex_string(string)
  return string.gsub(string, "[%^%%%a%%%c%%%d%%%g%%%l%%%p%%%s%%%u%%%w%%%x%%%z%%%A%[%]%(%)%-+*?%$]", "%%%1")
end

local function is_add_user_endpoint(path)
  return string.match(path, ".*/admin/.+/users/?$") ~= nil
end

local function is_modify_or_delete_endpoint(path, user_id)
  return string.match(path, ".*/admin/.+/users/" .. user_id .. "/?") ~= nil
end

return {
  is_ascii_string = is_ascii_string,
  sanitize_regex_string = sanitize_regex_string,
  is_add_user_endpoint = is_add_user_endpoint,
  is_modify_or_delete_endpoint = is_modify_or_delete_endpoint,
}


