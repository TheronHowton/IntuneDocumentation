Function Get-MobileAppsBeta() {
    <#
    .SYNOPSIS
    This function is used to get the all mobile apps from the Beta Graph API REST interface
    .DESCRIPTION
    The function connects to the Graph API Interface and gets the mobile apps
    .EXAMPLE
    Get-MobileAppsBeta
    Returns the mobile apps configured in Intune
    .NOTES
    NAME: Get-MobileAppsBeta
    #>
    try {
        $uri = "https://graph.microsoft.us/beta/deviceAppManagement/mobileApps"
        (Invoke-MSGraphRequest -Url $uri -HttpMethod GET).Value
    }
    catch {
        $ex = $_.Exception
        $errorResponse = $ex.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($errorResponse)
        $reader.BaseStream.Position = 0
        $reader.DiscardBufferedData()
        $responseBody = $reader.ReadToEnd();
        Write-Log "Response content:`n$responseBody" -Type Error
        Write-Log "Request to $Uri failed with HTTP Status $($ex.Response.StatusCode) $($ex.Response.StatusDescription)" -Type Error
        
    }
}