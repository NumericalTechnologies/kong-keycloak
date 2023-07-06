return {
  INVALID_USERNAME_LENGTH = {
    error = "invalidUsernameLength",
    error_description = "Usernames should be between 1 and 64 characters."
  },
  INVALID_USERNAME_ASCII = {
    error = "invalidUsernameAscii",
    error_description = "Usernames should only contain ASCII characters."
  },
  PROTECTED_USER_DELETE = {
    error = "protectedUserDelete",
    error_description = "Cannot delete a protected user or its roles."
  },
  PROTECTED_USER_MODIFY = {
    error = "protectedUserModify",
    error_description = "Cannot modify a protected user or its roles."
  },
  MISSING_AUTHORIZATION_HEADER = {
    error = "missingAuthorizationHeader",
    error_description = "Missing authorization header."
  },
  UNEXPECTED_ERROR = {
    error = "unexpectedError",
    error_description = "An unexpected error has occurred."
  },
  USER_LIMIT_REACHED = {
    error = "userLimitReached",
    error_description = "You have reached the maximum number of users allowed."
  },
}