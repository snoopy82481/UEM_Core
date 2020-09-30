function Get-uemGroups {
	$response = $null

	$restCall = @{
		Uri = "$UEMHostPortTenantGUIDBaseURL/groups"
		Headers = @{Authorization = $AuthorizationString}
		Method = "GET"
		ContentType = "application/vnd.blackberry.groups-v1+json"
	}

	try
    {
		$response = Invoke-RESTMethod @restCall

		foreach ($Group in $response.groups) {
			$validGroups.Add([PSCustomObject]@{
				guid = $Group.guid
				name = $Group.name
			})
		}
    }
    catch
    {
		Set-ErrorReport $_;
		throw
    }
}
