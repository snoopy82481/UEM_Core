function Remove-uemUserFromGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory,ValueFromPipeline,Position=0)]
		[ValidateNotNullOrEmpty()]
		[System.Guid]
		$userGUID,

		[Parameter(Mandatory,ValueFromPipeline,Position=1)]
		[ValidateNotNullOrEmpty()]
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
