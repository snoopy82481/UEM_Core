function Lock-uemDevice {
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

        [Parameter(ValueFromPipeline,Position=2)]
        [System.String]
        $password,

        [Parameter(ValueFromPipeline,Position=3)]
        [System.String]
        $message
    )

    begin {
        $restCall = @{
			Headers = @{Authorization = $AuthorizationString}
			Method = "POST"
			Uri = "$UEMHostPortTenantGUIDBaseURL/users/$userGuid/userDevices/$userDeviceGuid/commands"
			body = $null
			ContentType = "application/vnd.blackberry.command-v1+json"
        }
    }

    process {

        if ($null -eq $password) {
            if ($null -eq $message) {
                $restCall.body = @(
                    @{
                        "type" = "LOCK_DEVICE"
                        "properties" = @{
                            "password" = $null
                            "message" = $null
                        }
                    }
                ) | ConvertTo-Json
            } else {
                $restCall.body = @(
                    @{
                        "type" = "LOCK_DEVICE"
                        "properties" = @{
                            "password" = $null
                            "message" = $message
                        }
                    }
                ) | ConvertTo-Json
            }
        } else {
            if ($null -eq $message) {
                $restCall.body = @(
                    @{
                        "type" = "LOCK_DEVICE"
                        "properties" = @{
                            "password" = Set-base64Password ($password)
                            "message" = $null
                        }
                    }
                ) | ConvertTo-Json
            } else {
                $restCall.body = @(
                    @{
                        "type" = "LOCK_DEVICE"
                        "properties" = @{
                            "password" = Set-base64Password ($password)
                            "message" = $message
                        }
                    }
                ) | ConvertTo-Json
            }
        }

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