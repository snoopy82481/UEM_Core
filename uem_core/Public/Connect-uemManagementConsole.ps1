function Connect-uemManagementConsole {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript({
			$uri = $_ -as [System.Uri]
			$uri.Scheme -match '[http|https]'
		})]
		[System.Uri]
		$tenant
	)

	$global:UEMHostPortTenantGUIDBaseURL = $tenant

	if (!((Invoke-RESTMethod -Method GET -URI $UEMHostPortTenantGUIDBaseURL/util/ping).split(" ")[0..2] -join " ") -eq "Up and running") {
		Throw 'Unable to reach server';
	}

	$restCall = @{
		Uri = "$UEMHostPortTenantGUIDBaseURL/util/authorization"
		Method = "POST"
		body = @{
			provider = "AD"
			username = $Credential.GetNetworkCredential().UserName
			password = (Set-base64Password $($Credential.GetNetworkCredential().Password))
			domain = $Credential.GetNetworkCredential().domain
		} | ConvertTo-Json
		ContentType = "application/vnd.blackberry.authorizationrequest-v1+json"
	}

    try
    {
		$global:AuthorizationString = Invoke-RESTMethod @restCall
		if ($validGroups){ $validGroups.clear()}
		Get-uemGroups
    }
    catch
    {
		Set-ErrorReport $_;
		break;
    }
}
