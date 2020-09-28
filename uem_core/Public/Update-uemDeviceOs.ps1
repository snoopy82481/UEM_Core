function Update-uemDeviceOs {
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
		[System.String]
        $version,

		[Parameter(Position=3)]
		[Switch]
        $downloadOnly,

		[Parameter(Position=4)]
		[Switch]
        $downloadAndInstall,

		[Parameter(Position=5)]
		[Switch]
        $Install
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

        if ($downloadOnly.IsPresent) {
            if ($null -eq $version) {
                $restCall.Body = @(
					@{
						"type" = "UPDATE_DEVICE_OS"
						"properties" = @{
							"installAction" = "OS_UPDATE_INSTALL_ACTION_DOWNLOAD_ONLY"
							"osVersion" = $null
						}
					}
				) | ConvertTo-Json
            } else {
                $restCall.Body = @(
					@{
						"type" = "UPDATE_DEVICE_OS"
						"properties" = @{
							"installAction" = "OS_UPDATE_INSTALL_ACTION_DOWNLOAD_ONLY"
							"osVersion" = $version
						}
					}
				) | ConvertTo-Json
            }
        }

        if ($downloadAndInstall.IsPresent) {
            if ($null -eq $version) {
                $restCall.Body = @(
					@{
						"type" = "UPDATE_DEVICE_OS"
						"properties" = @{
							"installAction" = "OS_UPDATE_INSTALL_ACTION_DOWNLOAD_AND_INSTALL"
							"osVersion" = $null
						}
					}
				) | ConvertTo-Json
            } else {
                $restCall.Body = @(
					@{
						"type" = "UPDATE_DEVICE_OS"
						"properties" = @{
							"installAction" = "OS_UPDATE_INSTALL_ACTION_DOWNLOAD_AND_INSTALL"
							"osVersion" = $version
						}
					}
				) | ConvertTo-Json
            }
        }

        if ($Install.IsPresent) {
            if ($null -eq $version) {
                $restCall.Body = @(
					@{
						"type" = "UPDATE_DEVICE_OS"
						"properties" = @{
							"installAction" = "OS_UPDATE_INSTALL_ACTION_INSTALL_DOWNLOADED"
							"osVersion" = $null
						}
					}
				) | ConvertTo-Json
            } else {
                $restCall.Body = @(
					@{
						"type" = "UPDATE_DEVICE_OS"
						"properties" = @{
							"installAction" = "OS_UPDATE_INSTALL_ACTION_INSTALL_DOWNLOADED"
							"osVersion" = $version
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