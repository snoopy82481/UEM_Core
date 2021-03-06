function Remove-uemActivationPassword {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory,ValueFromPipeline,Position=0)]
		[ValidateNotNullOrEmpty()]
		[System.Net.Mail.MailAddress]
		$userEmailAddress
	)

	begin{
		$userGuid = (Get-uemUser $userEmailAddress).guid

		$restCall = @{
			Headers = @{Authorization = $AuthorizationString}
			Method = "DELETE"
			Uri = "$UEMHostPortTenantGUIDBaseURL/users/$userGuid/activationPasswords"
			ContentType = "application/vnd.blackberry.activationpasswords-v1+json"
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

	end {}
}
