function Remove-uemDirectoryUser {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.Guid]
		$userGuid
	)

	$restCall = @{
		Headers = @{Authorization = $AuthorizationString}
		Method = "DELETE"
		Uri = "$UEMHostPortTenantGUIDBaseURL/users/$userGuid"
		ContentType = "application/vnd.blackberry.users-v1+json"
	}

	try
	{
		$null = Invoke-RESTMethod @restCall;
	}
	catch
	{
		Set-ErrorReport $_
		throw
	}
}
