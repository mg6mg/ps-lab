# Log in first with Connect-AzAccount if not using Cloud Shell

$azContext = Get-AzContext
$azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)
$token = $profileClient.AcquireAccessToken($azContext.Subscription.TenantId)
$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.AccessToken
}

# Select the target with reference and assign it to a variable
# https://learn.microsoft.com/en-us/rest/api/azure/

# Invoke the REST API - Get
$restUri = '<url>'
$response = Invoke-WebRequest -Uri $restUri -Method Get -Headers $authHeader

# Invoke the REST API - Put
$body = [System.Text.Encoding]::UTF8.GetBytes('{"id":""}')
Invoke-WebRequest -Uri $restUri -Method Put -Headers $authHeader -Body $body -ContentType 'application/json'