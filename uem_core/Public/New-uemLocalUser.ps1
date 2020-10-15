function New-uemLocalUser {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline,Position=0)]
        [System.String]
        $displayName,

        [Parameter(ValueFromPipeline,Position=1)]
        [System.String]
        $firstName,

        [Parameter(ValueFromPipeline,Position=2)]
        [System.String]
        $lastName,

        [Parameter(ValueFromPipeline,Position=3)]
        [System.String]
        $username,

        [Parameter(ValueFromPipeline,Position=4)]
        [System.Net.Mail.MailAddress]
        $emailAddress,

        [Parameter(ValueFromPipeline,Position=5)]
        [System.String]
        $password,

        [Parameter(ValueFromPipeline,Position=6)]
        [System.String]
        $emailPassword,

        [Parameter(ValueFromPipeline,Position=7)]
        [System.Boolean]
        $mdm,

        [Parameter(ValueFromPipeline,Position=8)]
        [System.String]
        $company,

        [Parameter(ValueFromPipeline,Position=9)]
        [System.String]
        $title,

        [Parameter(ValueFromPipeline,Position=10)]
        [System.String]
        $department,

        [Parameter(ValueFromPipeline,Position=11)]
        [System.String]
        $officePhoneNumber,

        [Parameter(ValueFromPipeline,Position=12)]
        [System.String]
        $homePhoneNumber,

        [Parameter(ValueFromPipeline,Position=13)]
        [System.String]
        $mobilePhoneNumber,

        [Parameter(ValueFromPipeline,Position=14)]
        [System.String]
        $streetAddress,

        [Parameter(ValueFromPipeline,Position=14)]
        [System.String]
        $poBox,

        [Parameter(ValueFromPipeline,Position=15)]
        [System.String]
        $city,

        [Parameter(ValueFromPipeline,Position=16)]
        [System.String]
        $state,

        [Parameter(ValueFromPipeline,Position=17)]
        [System.String]
        $postalCode,

        [Parameter(ValueFromPipeline,Position=18)]
        [System.String]
        $country
    )

    begin {

        $body = [PSCustomObject]@{}

        foreach ($param in $PSBoundParameters.GetEnumerator()){
            $body | Add-Member -MemberType NoteProperty -Name $param.Key -Value $param.Value
        }

        $restCall = @{
			Headers = @{Authorization = $AuthorizationString}
			Method = "POST"
			Uri = "$UEMHostPortTenantGUIDBaseURL/users"
			body = $body | ConvertTo-Json
			ContentType = "application/vnd.blackberry.user-v1+json"
        }
    }

    process {
        try
		{
			$null = Invoke-RestMethod @restCall
		}
		catch
		{
			Set-ErrorReport $_
			throw
		}
    }

    end {

    }
}