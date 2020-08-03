function Set-base64Password {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[System.Security.SecureString]
		$SecureString
	)

	$password = Get-PlainText $SecureString

    $bytes = [System.Text.Encoding]::UTF8.GetBytes($password);
    $base64Password = [Convert]::ToBase64String($Bytes);

	$base64Password
}