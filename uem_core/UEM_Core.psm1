$global:validGroups = [System.Collections.Generic.List[System.Object]]::new()
$global:ErrorReport = [System.Collections.Generic.List[System.Object]]::new()
$global:UEMHostPortTenantGUIDBaseURL = $null
$global:AuthorizationString = $null

foreach ($directory in @('Public','Private','Classes')) {
	Get-ChildItem -Path "$PSScriptRoot\$directory\*.ps1" | ForEach-Object {. $PSItem.FullName}
}

$global:credential = $host.ui.PromptForCredential("UEM Server Login","Please enter your username and password",$userInfo,"NetBiosUserName")