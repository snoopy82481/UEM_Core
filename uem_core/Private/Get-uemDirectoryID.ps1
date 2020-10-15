function Get-uemDirectoryID {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory,Position=0)]
		[System.Net.Mail.MailAddress]
		$userEmailAddress
	)

	begin {
		$response = $null
		$emailAddress = $userEmailAddress.Address

		$restCall = @{
			Headers = @{Authorization = $AuthorizationString}
			Method = "GET"
			Uri = "$UEMHostPortTenantGUIDBaseURL/directories/users?search=$emailAddress"
		}
	}

	process {
		try
		{
			$response = Invoke-RestMethod @restCall
		}
		catch
		{
			Set-errorReport $_
			throw
		}
	}

	end {
		$response.directoryUsers.directoryId
	}
}