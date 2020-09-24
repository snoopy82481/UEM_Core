function Send-uemDeviceCommand {
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
		[System.String]
		$deviceCommand,

		[Parameter(Position=3)]
		[System.Collections.Hashtable]
		$propertiesInput
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
		switch ($deviceCommand) {
			DELETE_DEVICE_DATA {
				$restCall.Body = @(
					@{
						"type" = "DELETE_DEVICE_DATA"
					}
				) | ConvertTo-Json
			}
			DELETE_WORK_SPACE_DATA {
				$restCall.Body = @(
					@{
						"type" = "DELETE_WORK_SPACE_DATA"
					}
				) | ConvertTo-Json
			}
	<# 		DISABLE_LOST_MODE {
				$restCall.Body = @(
					@{
						"type" = "DISABLE_LOST_MODE"
					}
				) | ConvertTo-Json
			} #>
			DISABLE_WORK_SPACE {
				$restCall.Body = @(
					@{
						"type" = "DISABLE_LOST_MODE"
					}
				) | ConvertTo-Json
			}
			<# ENABLE_LOST_MODE {
				if ($propertiesInput.footnote) {
					$restCall.Body = @(
						@{
							"type" = "ENABLE_LOST_MODE"
							"properties" = @{
								"phoneNumber" = $propertiesInput.phoneNumber
								"message" = $propertiesInput.message
								"footnote" = $propertiesInput.footnote
							}
						}
					) | ConvertTo-Json
				} else {
					$restCall.Body = @(
						@{
							"type" = "ENABLE_LOST_MODE"
							"properties" = @{
								"phoneNumber" = $propertiesInput.phoneNumber
								"message" = $propertiesInput.message
							}
						}
					) | ConvertTo-Json
				}
			} #>
			ENABLE_WORK_SPACE {
				$restCall.Body = @(
					@{
						"type" = "ENABLE_WORK_SPACE"
					}
				) | ConvertTo-Json
			}
			GET_DEVICE_LOGS {
				$restCall.Body = @(
					@{
						"type" = "ENABLE_WORK_SPACE"
					}
				) | ConvertTo-Json
			}
			LOCK_DEVICE {
				$restCall.Body = @(
					@{
						"type" = "LOCK_DEVICE"
						"properties" = @{
							"password" = $null
							"message" = $null
						}
					}
				) | ConvertTo-Json
			}
			LOCK_WORK_SPACE {
				$restCall.Body = @(
					@{
						"type" = "LOCK_DEVICE"
						"properties" = @{
							"password" = Set-base64Password ($propertiesInput.password)
						}
					}
				) | ConvertTo-Json
			}
			REMOVE_DEVICE {
				$restCall.Body = @(
					@{
						"type" = "REMOVE_DEVICE"
					}
				) | ConvertTo-Json
			}
			REQUEST_DEVICE_INFO {
				$restCall.Body = @(
					@{
						"type" = "REQUEST_DEVICE_INFO"
					}
				) | ConvertTo-Json
			}
			RESET_WORK_SPACE_PASSWORD {
				$restCall.Body = @(
					@{
						"type" = "RESET_WORK_SPACE_PASSWORD"
					}
				) | ConvertTo-Json
			}
			UNLOCK_DEVICE {
				$restCall.Body = @(
					@{
						"type" = "UNLOCK_DEVICE"
					}
				) | ConvertTo-Json
			}
			UPDATE_DEVICE_OS {
				$restCall.Body = @(
					@{
						"type" = "UPDATE_DEVICE_OS"
						"properties" = @{
							"installAction" = "OS_UPDATE_INSTALL_ACTION_DOWNLOAD_AND_INSTALL"
							"osVersion" = $null
						}
					}
				) | ConvertTo-Json
			}
			WIPE_APPLICATIONS {
				$restCall.Body = @(
					@{
						"type" = "WIPE_APPLICATIONS"
					}
				) | ConvertTo-Json
			}
			Default {
				Write-Output "No valid selection chosen.  Please run again with valid option."
				break
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
