[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$global:validGroups = [System.Collections.Generic.List[System.Object]]::new()
$global:ErrorReport = [System.Collections.Generic.List[System.Object]]::new()
$global:UEMHostPortTenantGUIDBaseURL = $null
$global:AuthorizationString = $null

foreach ($directory in @('Public','Private','Classes')) {
	$folderPath = Join-Path -Path $PSScriptRoot -ChildPath $directory

	if (Test-Path $folderPath) {
		Write-Verbose -Message "Importing from $directory"
		$Functions = Get-ChildItem -Path $folderPath -Filter '*.ps1'

		foreach ($function in $Functions) {
			Write-Verbose -Message "  Importing $($function.BaseName)"
			. $($function.FullName)
		}
	}
}

$global:credential = $host.ui.PromptForCredential("UEM Server Login","Please enter your username and password",$userInfo,"NetBiosUserName")