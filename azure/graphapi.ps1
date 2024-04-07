# Use a service principal.
# Entering Application Information.
$tenantId = "<tanantId>"
$clientId = "<clientId>"
$clientSecret = "<clientsecret>"

$ReqTokenBody = @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    client_Id     = $clientID
    Client_Secret = $clientSecret
}

$TokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody

# Select the target with reference and assign it to a variable
# https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0

# Get user information.
$apiUrl = '<url>'
$userData = Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri $apiUrl -Method Get