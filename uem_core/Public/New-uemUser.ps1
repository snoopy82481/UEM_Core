function New-uemUser {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory,Position=0)]
		[System.Net.Mail.MailAddress]
		$userEmailAddress
	)

	begin {
		$directoryId = Get-uemDirectoryID $userEmailAddress

		if (!$directoryId) {
			Set-ErrorReport [PSCustomObject]@{
				Reason = "$userEmailAddress already has an account"
				Details = "The user: $($userEmailAddress.split('@')[0].replace('.ctr','')) already has an account. Verify name is correct."
				Line = $null
				Command = 'New-uemUser'
				FullyQualifiedErrorID = $null
			}
		}

		switch ($userEmailAddress) {
			{$_ -like "*.ctr*"} { $userName = $userEmailAddress.replace(".ctr@navy.mil","") }
			{$_ -like "*@nmci-isf.com"} { $userName = $userEmailAddress.replace("@nmci-isf.com","") }
			Default {$userName = $userEmailAddress.replace("@navy.mil","")}
		}

		$user = Get-ADUser $userName

		$restCall = @{
			Headers = @{Authorization = $AuthorizationString}
			Method = "POST"
			Uri = "$UEMHostPortTenantGUIDBaseURL/users"
			body = @(
				@{
					username = $userName
					displayName = $user.displayName
					firstName = $user.GivinName
					lastName = $user.surname
					emailAddress = $userEmailAddress
					directoryId = $directoryId
					mdm = $true
				} | ConvertTo-Json
			)
			ContentType = "application/vnd.blackberry.users-v1+json"
		}
	}

	process {
		try
		{
			$null = Invoke-RestMethod @restCall
		}
		catch
		{
			Set-ErrorReport $_
			throw
		}
	}
}
