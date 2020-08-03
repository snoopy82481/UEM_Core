function Get-PlainText {
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.Security.SecureString]$SecureString
    )
    BEGIN { }
    PROCESS {
        $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString);

        try {
            return [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr);
        }
        finally {
            [Runtime.InteropServices.Marshal]::FreeBSTR($bstr);
        }
    }
    END { }
}