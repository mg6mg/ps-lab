# Set Target
$SQLServerName = "<ServerName>"    # Azure SQL logical server name
$DatabaseName = "<DBname>"     # Azure SQL database name

# Connection Open
$queryParameter = "?resource=https://database.windows.net/"
$url = $env:IDENTITY_ENDPOINT + $queryParameter
$Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$Headers.Add("X-IDENTITY-HEADER", $env:IDENTITY_HEADER)
$Headers.Add("Metadata", "True")
$content =[System.Text.Encoding]::Default.GetString((Invoke-WebRequest -UseBasicParsing -Uri $url -Method 'GET' -Headers $Headers).RawContentStream.ToArray()) | ConvertFrom-Json
$Token = $content.access_token
Write-Host "Create SQL connection string."
$conn = New-Object System.Data.SqlClient.SQLConnection
$conn.ConnectionString = "Data Source=$SQLServerName.database.windows.net;Initial Catalog=$DatabaseName;Connect Timeout=30"
$conn.AccessToken = $Token
Write-host "Connect to database."
$conn.Open()

# Executing Queries
$ddlstmt = "<DDL or DML Command>"
Write-host "SQL DDL command"
$ddlstmt
$command = New-Object -TypeName System.Data.SqlClient.SqlCommand($ddlstmt, $conn)
Write-host "Results"
$command.ExecuteNonQuery()
$conn.Close()

