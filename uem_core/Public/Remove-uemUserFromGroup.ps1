function Remove-uemUserFromGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position=0)]
		[System.Guid]
		$userGUID,

		[Parameter(Mandatory, Position=1)]
		[System.String]
		$groupName
	)

	$groupGuid = ($validGroups | Where-Object Name -eq $groupName | Select-Object -ExpandProperty guid)

	$restCall = @{
		Headers = @{Authorization = $AuthorizationString}
		Method = "DELETE"
		Uri = "$UEMHostPortTenantGUIDBaseURL/groups/$groupGuid/users"
		Body = @{
				"users" = @(@{
						"guid" = $userGUID
					})
			} | ConvertTo-Json
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
