function Set-uemActivationPassword {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory,Position=0)]
		[System.Net.Mail.MailAddress]
		$userEmailAddress,

		[Parameter(Position=1)]
		[switch]
		$Type
	)

	begin {
		$activationExperationDate = [datetime]::Now.AddDays(20).ToString("o")
		$userGuid = (Get-uemUser $userEmailAddress).guid

		switch ($type) {
			ABM {
				$restCall = @{
					Headers = @{Authorization = $AuthorizationString}
					Method = "POST"
					Uri = "$UEMHostPortTenantGUIDBaseURL/users/$userGuid/activationPasswords"
					Body =  @(
						@{
							"activationPasswords" = @(
								@{
									"password" = $null
									"emailTemplate" = @{
										"name" = "Default activation email"
									}
									"expiry" = $activationExperationDate
									"expireAfterUse" = $null;
									"activationProfile" = @{
										"name" = "Default"
									}
								}
							)
						}
					) | ConvertTo-Json -Depth 4
					ContentType = "application/vnd.blackberry.activationpasswords-v1+json"
				}
			}
			Default {
				$restCall = @{
					Headers = @{Authorization = $AuthorizationString}
					Method = "POST"
					Uri = "$UEMHostPortTenantGUIDBaseURL/users/$userGuid/activationPasswords"
					Body =  @(
						@{
							"activationPasswords" = @(
								@{
									"password" = $null
									"emailTemplate" = @{
										"name" = "Default activation email"
									}
									"expiry" = $activationExperationDate
									"expireAfterUse" = $null;
									"activationProfile" = @{
										"name" = "NMCI Activation Profile"
									}
								}
							)
						}
					) | ConvertTo-Json -Depth 4
					ContentType = "application/vnd.blackberry.activationpasswords-v1+json"
				}
			}
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
