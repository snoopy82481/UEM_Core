---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Get-uemDeviceLogs

## SYNOPSIS
Retrieve logs from the device and send the logs to a path defined by the UEM administrator.

## SYNTAX

```
Get-uemDeviceLogs [-userGuid] <Guid> [-userDeviceGuid] <Guid> [<CommonParameters>]
```

## DESCRIPTION
Retrieve logs from the device and send the logs to a path defined by the UEM administrator. See [System Information](https://developer.blackberry.com/files/bws/reference/blackberry_uem_12_12_rest/resource_Info.html#resource_Info_getSystemInfo_GET) for the path to the log location.

The log file name when the command is processed by the device will be of the form:

{user name}_{device UDID}_YYYYMMdd-HHmmss.xyz

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-uemDeviceLogs -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6 -userDeviceGuid 60d360cb-7e8d-49ba-a902-c8ce8678cde2
```

## PARAMETERS

### -userDeviceGuid
Device GUID for user.  Should be sourced from the UEM Console.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -userGuid
Account GUID for user.  Should be sourced from the UEM Console.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Guid

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
