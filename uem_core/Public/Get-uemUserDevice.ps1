function Get-uemUserDevice {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory,ValueFromPipeline,Position=0)]
		[ValidateNotNullOrEmpty()]
		[System.Guid]
		$userGUID
	)

	$response = $null
	$deviceInfo = [System.Collections.Generic.List[System.Object]]::new()

	$restCall = @{
		Headers = @{Authorization = $AuthorizationString}
		Method = "GET"
		Uri = "$UEMHostPortTenantGUIDBaseURL/users/$userGUID/userDevices"
		ContentType = "application/vnd.blackberry.userdevice-v1+json"
	}

	try
	{
		$response = Invoke-RESTMethod @restCall

		if ($response.userDevices.count -gt 0) {
			Foreach ($Device in $response.userDevices){
				if ($device.device.phoneNumber) {
					$phoneNumber = [System.String]::format([System.String]::Format('{0:+# (###) ###-####}',[int64]$device.device.phoneNumber))
				} else {
					$phoneNumber = $null
				}

				$deviceInfo.add([PSCustomObject]@{
					EnrollmentType = $device.enrollmentType.replace("{}","")
					guid = $device.device.guid
					activationDate = (Get-Date -Date $device.device.activationDate -Format "MM/dd/yyyy HH:mm:ss tt")
					activeSyncID = $device.device.activeSyncId
					batteryLevel = $device.device.batteryLevel
					Compromised = $device.device.compromised
					hardwareModel = $device.device.hardwareModel
					hardwareName = $device.device.hardwareName
					homeCarrier = $device.device.homeCarrier
					networkRoaming = $device.device.networkRoaming
					internalStorageFree = ([System.Math]::Round(($device.device.internalStorageFree/1GB),2))
					internalStorageSize = ([System.Math]::Round(($device.device.internalStorageSize/1GB),2))
					imei = $device.device.imei
					meid = $device.device.meid
					osVersion = $device.device.osVersion
					ownership = $device.device.ownership
					phoneNumber = $PhoneNumber
					serialNumber = $device.device.serialNumber
					udid = $device.device.udid
					wifiMacAddress = $device.device.wifiMacAddress
				})
			}

			$deviceInfo
		}
		else {
			$deviceInfo = $null
		}
	}
	catch
	{
		Set-ErrorReport $_
		throw
	}
}
