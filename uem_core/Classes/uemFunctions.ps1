<#
	Created: 25 November 2019
	Updated: 12 June 2020
	Purpose: Core functions for UEM work as a custom powershell Class.
	Developed By: Stephen Beale
#>

<#
	12 June 2020 update
	-- Added changelog to class header

	25 November 2019 update
	-- Initial script creation
#>

<#
	! Class currently not at a working stage
#>

class uemFunctions {
	[System.Collections.Generic.List[System.Object]]$ErrorReport = @()
	[System.Object]$user = $null
	[System.Object]$device = $null
	[System.Object]$group = $null
	hidden [System.String]$AuthorizationString = $null
	hidden [System.String]$UEMHostPortTenantGUIDBaseURL = $null
	hidden [System.Collections.Generic.List[System.Object]]$validGroups = @()

	#Constructors
	uemFunctions(){}

	uemFunctions([System.Uri]$tenant){
		$this.UEMHostPortTenantGUIDBaseURL = $tenant
		$this.connect()
		$this.getGroups()
	}

	uemFunctions([System.Uri]$tenant,[System.Net.Mail.MailAddress]$userEmailAddress){
		$this.UEMHostPortTenantGUIDBaseURL = $tenant
		$this.connect()
		$this.getGroups()
		$this.getUserDetails($userEmailAddress)
	}

	#Methods
	[void]connect(){
		$Credential = $this.getCredentials()

		try {
			$null = Invoke-RESTMethod -Method GET -URI "$($this.UEMHostPortTenantGUIDBaseURL)/util/ping"
		}
		catch {
			$this.ErrorReport.add([PSCustomObject]@{
				Reason = "Server not available"
				Details = "Unable to access $($this.UEMHostPortTenantGUIDBaseURL)"
				Line = $null
				Command = "[uemFunctions]::connectionSetup"
				FullyQualifiedErrorID = $null
			})

			Throw 'Unable to reach server';
		}

		$restCall = @{
			Uri = "$this.UEMHostPortTenantGUIDBaseURL/util/authorization"
			Method = "POST"
			body = @{
				provider = "AD"
				username = $Credential.UserName
				password = $this.toBase64(($Credential.Password))
				domain = $Credential.UserName.split("\")[0]
			} | ConvertTo-Json
			ContentType = "application/vnd.blackberry.authorizationrequest-v1+json"
		}

		try
		{
			$this.AuthorizationString = Invoke-RESTMethod @restCall
		}
		catch
		{
			$this.errorHandleing($_);
			throw
		}
	}

	[System.Management.Automation.PSCredential] hidden getCredentials(){
		$credentials = [pscredential]::New((Read-Host -Prompt 'USERNAME'),(Read-Host -Prompt 'PASSWORD' -AsSecureString))

		return $credentials
	}

	[System.Object] hidden getUser([System.Net.Mail.MailAddress]$userEmailAddress){
		$response = $null

		$restCall = $this.RestCall("user","get",$userEmailAddress)

		try
		{
			$response = Invoke-RESTMethod @restCall;
		}
		catch
		{
			$this.errorHandleing($_);
			throw
		}

		return [PSCustomObject]@{
			username = $response.users.username
			displayname = $response.users.DisplayName
			Name  = "$($response.users.firstName) $($response.users.lastName)"
			emailAddress = $response.users.emailAddress
			links = $response.users.links
			guid = $response.users.guid
			directoryId = $response.users.directoryId
			admin = $response.users.admin
			created = $response.users.created | Get-Date -Format "MM/dd/yyyy HH:mm:ss"
		}
	}

	[System.Object] hidden getUserGroups([System.Guid]$userGuid){
		$response = $null
		$groupInfo = [System.Collections.Generic.List[System.Object]]::new()

		$restCall = $this.RestCall("group","get",$userGuid)

		try
		{
			$response = Invoke-RESTMethod @restCall;
		}
		catch
		{
			$this.errorHandleing($_);
			throw
		}

		foreach ($group in $response.groups) {
			$groupInfo.Add([PSCustomObject]@{
				Name = $group.name
				Guid = $group.guid
			})
		}

		return $groupInfo
	}

	[System.Object] hidden getUserDevice([System.Guid]$userGuid){
		$response = $null
		$deviceInfo = [System.Collections.Generic.List[System.Object]]::new()

		$restCall = $this.RestCall("device","get",$userGuid)

		try
		{
			$response = Invoke-RESTMethod @restCall;
		}
		catch
		{
			$this.errorHandleing($_);
			throw
		}

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
					hardwareVendorCompanyName = $device.device.hardwareVendorCompanyName
					homeCarrier = $device.device.homeCarrier
					currentCarrier = $device.device.currentCarrier
					networkRoaming = $device.device.networkRoaming
					internalStorageFree = $device.device.internalStorageFree
					internalStorageSize = $device.device.internalStorageSize
					imei = $device.device.imei
					meid = $device.device.meid
					os = $device.device.os
					osFamilyName = $device.device.osFamilyName
					osVersion = $device.device.osVersion
					ownership = $device.device.ownership
					phoneNumber = $PhoneNumber
					serialNumber = $device.device.serialNumber
					udid = $device.device.udid
					wifiMacAddress = $device.device.wifiMacAddress
				})
			}
		}
		else {
			$deviceInfo = $null
		}

		return $deviceInfo
	}

	[void]getUserDetails([mailaddress]$userEmailAddress){
		$this.user = $this.getUser($userEmailAddress)
		$this.group = $this.getUserGroups($this.user.guid)
		$this.device = $this.getUserDevice($this.user.guid)
	}

	[System.Object]getGroupInfo([System.String]$groupName){
		if ($this.validGroups.Name -contains $groupName) {
			$groupInfo = $this.validGroups | Where-Object {$_.Name -eq $groupName}
			return $groupInfo
		} else {
			$this.ErrorReport.add([PSCustomObject]@{
				Reason = "$groupName is not Valid"
				Details = "The group $groupName is not found on the server. Please verify that the group name is correct."
				Line = $null
				Command = "[uemFunctions]::getGroupInfo()"
				FullyQualifiedErrorID = $null
			})

			Throw "$groupName is not Valid";
		}
	}

	[void]setActivationPassword(){
		$activationExperationDate = [datetime]::Now.AddDays(20).ToString("o")

		$restCall = $this.RestCall("activationPassword","set",$activationExperationDate)

		try
		{
			$null = Invoke-RESTMethod @restCall;
		}
		catch
		{
			$this.errorHandleing($_);
			throw
		}
	}

	[void]removeActivationPassword(){
		$restCall = $this.RestCall("activationPassword","remove",$null)

		try
		{
			$null = Invoke-RESTMethod @restCall;
		}
		catch
		{
			$this.errorHandleing($_);
			throw
		}
	}

	[void]removeFromGroup([System.String]$groupName){
		$inputItem = [PSCustomObject]@{
			userGuid = $this.user.guid
			groupGuid = ($this.validGroups | Where-Object {$_.Name -eq $groupName} | Select-Object -ExpandProperty guid)
		}

		$restCall = $this.RestCall("user","remove",$inputItem)

		try
		{
			$null = Invoke-RESTMethod @restCall;
			($this.group | Where-Object {$_.name -eq $groupName}).Remove()
		}
		catch
		{
			$this.errorHandleing($_);
			throw
		}
	}

	[void]removeUser([System.Guid]$userGuid){
		$restCall = $this.RestCall("user","remove",$null)

		try
		{
			$null = Invoke-RESTMethod @restCall;
		}
		catch
		{
			$this.errorHandleing($_);
			throw
		}
	}

	[void] hidden removeDevice(){}

	[void]setUserGroup([System.String]$groupName){

		if (!($groupName -in $this.validGroups)) {
			$this.ErrorReport.add([PSCustomObject]@{
				Reason = "$groupName not valid"
				Details = "The group name: $groupName is not a valid group on the server. Please check name again."
				Line = $null
				Command = '$this.setUserGroup()'
				FullyQualifiedErrorID = $null
			})

			Throw;
		}

		$inputItem = [PSCustomObject]@{
			userGuid = $this.user.guid
			groupGuid = ($this.validGroups | Where-Object {$_.Name -eq $groupName} | Select-Object -ExpandProperty guid)
		}

		$restCall = $this.RestCall("user","set",$inputItem)

		try
		{
			$null = Invoke-RESTMethod @restCall;
			$this.group = $this.validGroups | Where-Object {$_.name -eq $groupName}
		}
		catch
		{
			$this.errorHandleing($_);
			throw
		}
	}

	[void] hidden getGroups(){
		$response = $null

		$restCall = @{
			uri = "$this.UEMHostPortTenantGUIDBaseURL/groups"
			Method = "GET"
			ContentType = "application/vnd.blackberry.groups-v1+json"
			Header = @{Authorization = $this.AuthorizationString}
		}

		try
		{
			$response = Invoke-RESTMethod @restCall;
		}
		catch
		{
			$this.errorHandleing($_);
			throw
		}

		foreach ($group in $response.groups) {
			$this.validGroups.Add([PSCustomObject]@{
				guid = $group.guid
				name = $group.name
			})
		}
	}

	[System.String]static hidden toBase64([Security.SecureString]$password){
		$password = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password);

		try
		{
			$null = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($password);
		}
		finally
		{
			[Runtime.InteropServices.Marshal]::FreeBSTR($password);
		}

		$bytes = [System.Text.Encoding]::UTF8.GetBytes($password);
		$base64Password = [Convert]::ToBase64String($Bytes);

		return $base64Password
	}

	[hashtable]hidden RestCall([System.String]$hashType,[System.String]$method,[System.Object]$inputItem){
		$HashTable = @{
			Header = @{Authorization = $this.AuthorizationString}
			Method = $Null
			Uri = $Null
			Body = $Null
			ContentType = $Null
		}

		switch ($hashType) {
			User {
				$HashTable.ContentType = "application/vnd.blackberry.users-v1+json";
				switch($method) {
					get {
						$HashTable.Method = "GET"
						$HashTable.Uri = "$this.UEMHostPortTenantGUIDBaseURL/users?query=emailAddress=$inputItem"
					}
					set {
						Throw "Method not configured yet"
						<# $HashTable.Method = "POST"
						$HashTable.Uri = "$this.UEMHostPortTenantGUIDBaseURL/users?query=emailAddress=$($this.user.emailAddress)" #>
					}
					remove {
						$HashTable.Method = "DELETE"
						HashTable.Uri = "$global:UEMHostPortTenantGUIDBaseURL/users/$($this.user.guid)"
					}
				}
			}
			device {
				$HashTable.ContentType = "application/vnd.blackberry.userdevice-v1+json";
				switch (method) {
					get {
						$HashTable.Method = "GET"
						$HashTable.Uri = "$this.UEMHostPortTenantGUIDBaseURL/users/$inputItem/userDevices"
					}
					remove {
						Throw "Method not available"
					}
				}
			}
			group {
				$HashTable.ContentType = "application/vnd.blackberry.groups-v1+json";
				switch (method) {
					get {
						$HashTable.Method = "GET"
						try {
							[System.Guid]::Parse($inputItem)
							$HashTable.Uri = "$this.UEMHostPortTenantGUIDBaseURL/users/$inputItem/groups"
						}
						catch {
							$HashTable.Uri = "$this.UEMHostPortTenantGUIDBaseURL/groups?query=name=$inputItem"
						}
					}
					set {
						$HashTable.Method = "POST"
						$HashTable.ContentType = "$this.UEMHostPortTenantGUIDBaseURL/groups/$($inputItem.groupGuid)/users"
						$Hashtable.Body = @(
							@{
								"users" = @(
									@{
										"guid" = $inputItem.userGUID
									}
								)
							}
						) | ConvertTo-Json
					}
					remove {
						$HashTable.Method = "DELETE"
						$HashTable.ContentType = "$this.UEMHostPortTenantGUIDBaseURL/groups/$($inputItem.groupGuid)/users"
						$Hashtable.Body = @(
							@{
								"users" = @(
									@{
										"guid" = $inputItem.userGUID
									}
								)
							}
						) | ConvertTo-Json
					}
				}
			}
			activationPassword {
				$HashTable.Uri = "$this.UEMHostPortTenantGUIDBaseURL/users/$($this.user.guid)/activationPasswords"
				$HashTable.ContentType =  "application/vnd.blackberry.activationpasswords-v1+json"
				switch (method) {
					get {
						$HashTable.method = "GET"
					}
					set {
						$HashTable.method = "POST"
						$HashTable.body = @(
							@{
								"activationPasswords" = @(
									@{
										"password" = $null
										"emailTemplate" = @{
											"name" = "Default activation email"
										}
										"expiry" = $inputItem
										"expireAfterUse" = $null;
										"activationProfile" = @{
											"name" = "NMCI Activation Profile"
										}
									}
								)
							}
						) | ConvertTo-Json -Depth 4
					}
					remove {
						$HashTable.Method = "DELETE"
					}
				}
			}
		}

		return $HashTable;
	}

	[void]hidden errorHandleing([System.Object]$errorinput){
		$errorOutput = [PSCustomObject]@{
			Reason = $errorinput.Exception
			Details = $errorinput.errordetails
			Line = $errorinput.Line
			Command = $errorinput.MyCommand
			FullyQualifiedErrorID = $errorinput.FullyQualifiedErrorID
		}

		$this.ErrorReport.add($errorOutput)
	}
}