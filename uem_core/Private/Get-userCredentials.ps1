function Get-userCredentials {
	$userName = $env:USERNAME

	switch ($userName) {
		{$_ -like "allyson*"} {
			$userInfo = "$env:USERDOMAIN\allyson.harter.adm"
		}
		Default {
			$userInfo = "$env:USERDOMAIN\$env:USERNAME"
		}
	}

	$host.ui.PromptForCredential("UEM Server Login","Please enter your username and password",$userInfo,"NetBiosUserName")
}

