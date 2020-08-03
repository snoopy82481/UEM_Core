function Set-errorReport($errorinput) {
	$ErrorReport.Add([PSCustomObject]@{
		Reason = $errorinput.Exception
		Details = $errorinput.errordetails
		Details2 = $errorinput.message
		Line = $errorinput.Line
		Command = $errorinput.MyCommand
	})
}