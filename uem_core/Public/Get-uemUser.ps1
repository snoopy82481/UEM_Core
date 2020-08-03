function Get-uemUser {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory,Position=0)]
		[System.Net.Mail.MailAddress]
		$userEmailAddress
	)

	$response = $null

	$restCall = @{
		Headers = @{Authorization = $AuthorizationString}
		Method = "GET"
		Uri = "$UEMHostPortTenantGUIDBaseURL/users?query=emailAddress=$userEmailAddress"
		ContentType = "application/vnd.blackberry.users-v1+json"
	}

	try
	{
		$response = Invoke-RESTMethod @restCall

		if (!($response.users.created)) {
			$createDate = $null
		}
		else {
			$createDate = $response.users.created | Get-Date -Format "MM/dd/yyyy HH:mm:ss"
		}

		[PSCustomObject]@{
			username = $response.users.username
			displayname = $response.users.DisplayName
			Name  = "$($response.users.firstName) $($response.users.lastName)"
			emailAddress = $response.users.emailAddress
			links = $response.users.links
			guid = $response.users.guid
			directoryId = $response.users.directoryId
			admin = $response.users.admin
			created = $createDate
		}
	}
	catch
	{
		Set-ErrorReport $_
		throw
	}
}
