function New-uemDirectoryUser {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory,ValueFromPipeline,Position=0)]
		[ValidateNotNullOrEmpty()]
		[System.Net.Mail.MailAddress]
		$userEmailAddress
	)

	begin {
		Import-Module ActiveDirectory

		$directoryId = Get-uemDirectoryID $userEmailAddress

		if (!$directoryId) {
			Set-ErrorReport [PSCustomObject]@{
				Reason = "$userEmailAddress already has an account"
				Details = "The user: $($userEmailAddress.Address.split('@')[0]) already has an account. Verify name is correct."
				Line = $null
				Command = 'New-uemDirectoryUser'
				FullyQualifiedErrorID = $null
			}
		}

		$userName = $userEmailAddress.Address.Split("@", [System.StringSplitOptions]::RemoveEmptyEntries)[0]

		$userDomain = {
			$forest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest().name
			$GCADsPath = [ADSI]"GC://$forest"
			$GCSearch = [System.DirectoryServices.DirectorySearcher]::new($GCADsPath)
			$GCSearch.Filter = (&(objectCategory=User)(SamAccountName=$($userName)))
			[string]$GCUserInfo = $GCSearch.FindOne().GetDirectoryEntry().distingushedName
			$userDomain = $GCUserInfo.Substring($GCUserInfo.IndexOf("DC=")+3).Split(",")[0]

			[System.DirectoryServices.ActiveDirectory.Domain]::GetDomain([System.DirectoryServices.ActiveDirectory.DirectoryContext]::new('Domain', $userDomain)).RidRoleOwner.name
		}

		$user = Get-ADUser $userName -Server $userDomain -properties displayName

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
			ContentType = "application/vnd.blackberry.directoryuser-v1+json"
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
