function Lock-uemDeviceWorkSpace {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline,Position=0)]
		[ValidateNotNullOrEmpty()]
		[System.Guid]
		$userGuid,

		[Parameter(Mandatory,ValueFromPipeline,Position=1)]
		[ValidateNotNullOrEmpty()]
		[System.Guid]
        $userDeviceGuid,

        [Parameter(Mandatory,ValueFromPipeline,Position=2)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $password
    )

    begin {
        $restCall = @{
			Headers = @{Authorization = $AuthorizationString}
			Method = "POST"
			Uri = "$UEMHostPortTenantGUIDBaseURL/users/$userGuid/userDevices/$userDeviceGuid/commands"
			body = @(
                @{
                    "type" = "LOCK_DEVICE"
                    "properties" = @{
                        "password" = Set-base64Password ($password)
                    }
                }
            ) | ConvertTo-Json
			ContentType = "application/vnd.blackberry.command-v1+json"
        }
    }

    process {
        try	{
			$null = Invoke-RestMethod @restCall
		}
		catch {
			Set-ErrorReport $_
			throw
		}
    }

    end {

    }
}