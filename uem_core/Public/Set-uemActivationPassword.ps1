function Set-uemActivationPassword {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory,ValueFromPipeline,Position=0)]
		[ValidateNotNullOrEmpty()]
		[System.Net.Mail.MailAddress]
		$userEmailAddress,

		[Parameter(ValueFromPipeline,Position=1)]
		[System.String]
		$activationProfile,

		[Parameter(ValueFromPipeline,Position=2)]
		[System.String]
		$Type
	)

	begin {
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
									"expiry" = $null
									"expireAfterUse" = $null
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
									"expiry" = $null
									"expireAfterUse" = $null
									"activationProfile" = @{
										"name" = $activationProfile
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
