function Get-uemUserGroups {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position=0)]
		[System.Guid]
		$userGuid
	)

	$response = $null
	$groupInfo = [System.Collections.Generic.List[System.Object]]::new()

	$restCall = @{
		Headers = @{Authorization = $AuthorizationString}
		Method = "GET"
		Uri = "$UEMHostPortTenantGUIDBaseURL/users/$userGuid/groups"
		ContentType = "application/vnd.blackberry.groupassignments-v1+json"
	}

	try
	{
		$response = Invoke-RESTMethod @restCall;

		foreach ($group in $response.groups) {
			$groupInfo.Add([PSCustomObject]@{
				Name = $group.name
				Guid = $group.guid
			})
		}

		$groupInfo
	}
	catch
	{
		handleError $_
		throw
	}
}