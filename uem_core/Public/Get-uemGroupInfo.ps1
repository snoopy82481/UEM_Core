function Get-uemGroupInfo {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position=0)]
		[System.String]
		$groupName
	)

	if (!($validGroups.Name -contains $groupName)) {
		$ErrorReport.add([PSCustomObject]@{
			Reason = "$groupName not valid"
			Details = "The group name: $groupName is not a valid group on the server. Please check name again."
			Line = $null
			Command = 'Get-uemGroupInfo'
			FullyQualifiedErrorID = $null
		})

		Throw;
	}

	$validGroups | Where-Object {$_.Name -eq $groupName}
}
