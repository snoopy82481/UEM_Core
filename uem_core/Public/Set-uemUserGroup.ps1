function Set-uemUserGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position=0)]
		[System.Guid]
		$userGUID,

		[Parameter(Mandatory, Position=1)]
		[System.String]
		$groupName
	)

	if (!($validGroups -match $groupName)) {
		$ErrorReport.add([PSCustomObject]@{
			Reason = "$groupName not valid"
			Details = "The group name: $groupName is not a valid group on the server. Please check name again."
			Line = $null
			Command = 'Set-uemUserGroup'
			FullyQualifiedErrorID = $null
		})

		Throw;
	}

	$groupGuid = ($validGroups | Where-Object Name -eq $groupName | Select-Object -ExpandProperty guid)

	$restCall = @{
		Headers = @{Authorization = $AuthorizationString}
		Method = "POST"
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
