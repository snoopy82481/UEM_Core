function Get-uemDirectoryID {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory,Position=0)]
		[System.Net.Mail.MailAddress]
		$userEmailAddress
	)

	begin {
		$response = $null

		$restCall = @{
			Headers = @{Authorization = $AuthorizationString}
			Method = "GET"
			Uri = "$UEMHostPortTenantGUIDBaseURL/directories/users?search=$userEmailAddress"
			Body = $Null
			ContentType = $Null
		}
	}

	process {
		try
		{
			$response = Invoke-RestMethod @restCall
		}
		catch
		{
			handleError $_
			throw
		}
	}

	end {
		$response.directoryUsers.directoryId
	}
}