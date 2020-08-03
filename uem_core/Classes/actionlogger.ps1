<#
	Created: 25 November 2019
	Purpose: Logging Class for better readability
	Developed By: Stephen Beale
	Updated: 27 November 2019
 #>

<#
	! How to call actionlogger class
	* If screen output is desired the LogError and LogInfo needs to have the second value set to $true, otherwise set it to $false so it will
	* just send to file on completion.

	* $MyActionLogger = [ActionLogger]::new("FolderName","$scriptName") Starts logging without screen output
	* $MyActionLogger = [ActionLogger]::new("FolderName","$scriptName",$true) Starts logging with screen output
	! Depreciated part of the new action
		$MyActionLogger.StartLog() - Starts logger without screen output
		$MyActionLogger.StartLog($True) - Starts logger with screen output
	* $MyActionLogger.LogError("error") - Writes Error to log without screen output
	* $MyActionLogger.LogError("error",$True) - Writes Error to log with screen output
	* $MyActionLogger.LogInfo("info") - Writes information to log without screen output
	* $MyActionLogger.LogInfo("info",$True) - Writes information to log with screen output
	* $MyActionLogger.StopLog() - Stops logger without screen output
	* $MyActionLogger.StopLog($true) - Stops logger without screen output
	* $MyActionLogger.ShowLog() - Shows whole log onto the screen
#>

param()
class ActionLogger {
	[System.Collections.Generic.List[System.Object]]$ActionLog = @()
	hidden [System.String]$LogPath = $null
	hidden [System.String]$tempLogPath = $null

	#Constructors
	ActionLogger(){
	}

	ActionLogger([System.IO.FileInfo]$logfolder,[System.String]$logfile){
		$this.LogPath = [ActionLogger]::FormatLogFolder($logfolder,$logfile)
		$this.tempLogPath = [ActionLogger]::FormatLogFolder($($env:TEMP),$logfile)
		$this.StartLog()
	}

	ActionLogger([System.IO.FileInfo]$logfolder,[System.String]$logfile,[bool]$ToScreen){
		$this.LogPath = [ActionLogger]::FormatLogFolder($logfolder,$logfile)
		$this.tempLogPath = [ActionLogger]::FormatLogFolder($($env:TEMP),$logfile)
		$this.StartLog($ToScreen)
	}

	#Methods
	[System.String]static FormatLogFolder([System.IO.FileInfo]$logfolder,[System.String]$logfile){
		if (!(Test-Path -Path $logfolder)) {
			Throw "Folder not found"
		}

		$fullfilepath = "$logfolder\$($logfile)_$([DateTime]::Now.ToString('yyyy-MM-dd_HHmm')).txt"

		return $fullfilepath
	}

    ShowLog() {
        ForEach ($action in $this.ActionLog) {
			if (($action -like "*started*") -or ($action -like "*Finished*")) {
				Write-Host $action.Text -ForegroundColor $Action.ForegroundColor
			} else {
				Write-Host $action.TimeStamp $action.Text -ForegroundColor $Action.ForegroundColor
			}
        }
        if ($this.ActionLog.Count -gt 0) {Write-Host `n}
    }

	[void]StartLog() {
		if (Test-Path $this.LogPath) { Remove-Item $this.LogPath -Force }
		$Null = New-Item $this.LogPath -ItemType File

		$This.ActionLog.Add([PSCustomObject]@{
            Text = "*********************************************`r`nStarted processing at [$([DateTime]::Now)]`r`n*********************************************`r`n"
            ForegroundColor = 'White'
            TimeStamp = ([datetime]::Now)
		})
	}

	[void]StartLog([bool]$ToScreen) {
		if (Test-Path $this.LogPath) { Remove-Item $this.LogPath -Force }
		$Null = New-Item $this.LogPath -ItemType File

		$This.ActionLog.Add([PSCustomObject]@{
            Text = "*********************************************`r`nStarted processing at [$([DateTime]::Now)]`r`n*********************************************`r`n"
            ForegroundColor = 'White'
            TimeStamp = ([datetime]::Now)
		})

		if ($ToScreen) {
			Write-Host $this.ActionLog[-1].Text -ForegroundColor $this.ActionLog[-1].ForegroundColor
		}
	}

	[void]StopLog() {
		$This.ActionLog.Add([PSCustomObject]@{
            Text = "`r`n*********************************************`r`nFinished processing at [$([DateTime]::Now)]`r`n*********************************************"
            ForegroundColor = 'White'
            TimeStamp = ([datetime]::Now)
		})

		foreach ($action in $this.ActionLog) {
			if (($action -like "*Started*") -or ($action -like "*Finished*")) {
				Add-Content -Path $this.tempLogPath -Value $action.text
			} else {
				Add-Content -Path $this.tempLogPath -Value "$($action.Timestamp) $($action.Text)"
			}
		}

		Copy-Item -Path $this.tempLogPath -destination $this.LogPath
	}

	[void]StopLog([bool]$ToScreen) {
		$This.ActionLog.Add([PSCustomObject]@{
            Text = "`r`n*********************************************`r`nFinished processing at [$([DateTime]::Now)]`r`n*********************************************"
            ForegroundColor = 'White'
            TimeStamp = ([datetime]::Now)
		})

		if ($ToScreen) {
			Write-Host $this.ActionLog[-1].Text -ForegroundColor $this.ActionLog[-1].ForegroundColor
		}

		foreach ($action in $this.ActionLog) {
			if (($action -like "*Started*") -or ($action -like "*Finished*")) {
				Add-Content -Path $this.tempLogPath -Value $action.text
			} else {
				Add-Content -Path $this.tempLogPath -Value "$($action.Timestamp) $($action.Text)"
			}
		}

		Copy-Item -Path $this.tempLogPath -destination $this.LogPath
	}

    [void]LogError([string]$Text) {
        $This.ActionLog.Add([PSCustomObject]@{
            Text = "[ERROR] $Text"
            ForegroundColor = 'Red'
            TimeStamp = ([datetime]::Now)
		})
	}

	[void]LogError([string]$Text,[bool]$ToScreen) {
        $This.ActionLog.Add([PSCustomObject]@{
            Text = "[ERROR] $Text"
            ForegroundColor = 'Red'
            TimeStamp = ([datetime]::Now)
		})

		if ($ToScreen) {
			Write-Host $this.ActionLog[-1].TimeStamp $this.ActionLog[-1].Text -ForegroundColor $this.ActionLog[-1].ForegroundColor
		}
	}

	[void]LogInfo([string]$Text) {
        $This.ActionLog.Add([PSCustomObject]@{
            Text = "[INFO] $Text"
            ForegroundColor = 'White'
            TimeStamp = ([datetime]::Now)
		})
	}

	[void]LogInfo([string]$Text,[bool]$ToScreen) {
        $This.ActionLog.Add([PSCustomObject]@{
            Text = "[INFO] $Text"
            ForegroundColor = 'White'
            TimeStamp = ([datetime]::Now)
		})

		if ($ToScreen) {
			Write-Host $this.ActionLog[-1].TimeStamp $this.ActionLog[-1].Text -ForegroundColor $this.ActionLog[-1].ForegroundColor
		}
	}

	[void]LogSetting([string]$Text) {
        $This.ActionLog.Add([PSCustomObject]@{
            Text = "[SETTING] $Text"
            ForegroundColor = 'White'
            TimeStamp = ([datetime]::Now)
		})
	}

	[void]LogSetting([string]$Text,[bool]$ToScreen) {
        $This.ActionLog.Add([PSCustomObject]@{
            Text = "[SETTING] $Text"
            ForegroundColor = 'White'
            TimeStamp = ([datetime]::Now)
		})

		if ($ToScreen) {
			Write-Host $this.ActionLog[-1].TimeStamp $this.ActionLog[-1].Text -ForegroundColor $this.ActionLog[-1].ForegroundColor
		}
	}

	[void]Clear() {
		$this.ActionLog.Clear()
		$this.LogPath = $null
	}
}