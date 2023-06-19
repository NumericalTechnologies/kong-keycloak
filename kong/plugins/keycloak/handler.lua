local access = require("kong.plugins.keycloak.access")
local KongKeycloakHandler = {
  VERSION = "1.0.0",
  PRIORITY = 1028,
}

function KongKeycloakHandler:access(config)
  access.execute(config)
end

return KongKeycloakHandler