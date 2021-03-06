function Disable-uemDeviceLostMode {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,Position=0)]
		[ValidateNotNullOrEmpty()]
		[System.Guid]
		$userGuid,

		[Parameter(Mandatory,Position=1)]
		[ValidateNotNullOrEmpty()]
		[System.Guid]
		$userDeviceGuid
    )

    begin {
        $restCall = @{
			Headers = @{Authorization = $AuthorizationString}
			Method = "POST"
			Uri = "$UEMHostPortTenantGUIDBaseURL/users/$userGuid/userDevices/$userDeviceGuid/commands"
			body = @(
                @{
                    "type" = "DISABLE_LOST_MODE"
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