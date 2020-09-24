function Enable-uemDeviceLostMode {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,Position=0)]
		[ValidateNotNullOrEmpty()]
		[System.Guid]
		$userGuid,

		[Parameter(Mandatory,Position=1)]
		[ValidateNotNullOrEmpty()]
		[System.Guid]
        $userDeviceGuid,

        [Parameter(Mandatory,Position=2)]
		[ValidateNotNullOrEmpty()]
		[System.String]
        $phoneNumber,

        [Parameter(Mandatory,Position=3)]
		[ValidateNotNullOrEmpty()]
		[System.String]
        $message,

        [Parameter(Position=4)]
		[ValidateNotNullOrEmpty()]
		[System.String]
		$footnote
    )

    begin {
        if ($null -ne $footnote) {
            $restCall.Body = @(
                @{
                    "type" = "ENABLE_LOST_MODE"
                    "properties" = @{
                        "phoneNumber" = $phoneNumber
                        "message" = $message
                        "footnote" = $footnote
                    }
                }
            ) | ConvertTo-Json
        } else {
            $restCall.Body = @(
            @{
                "type" = "ENABLE_LOST_MODE"
                "properties" = @{
                    "phoneNumber" = $phoneNumber
                    "message" = $message
                }
            }
        ) | ConvertTo-Json
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