---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Get-uemUserDevice

## SYNOPSIS
Gets device(s) assigned to user.

## SYNTAX

```
Get-uemUserDevice [-userGUID] <Guid> [<CommonParameters>]
```

## DESCRIPTION
Gets device(s) assigned to user. It can output to the screen, but has a custom object that you can store as a variable to be used elsewhere.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-uemUserDevice -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6

EnrollmentType      : MDM_CONTROLS
guid                : 60d360cb-7e8d-49ba-a902-c8ce8678cde2
activatinDate       : 10/1/2020 3:04:37 PM
activeSyncID        : MDANJE3243533WRFDS32353
batteryLevel        : 15
Compromised         : False
hadwareModel        : iPhone 8 Pus (GSM)
hardwareName        : iPhone10,5
homeCarrier         : AT&T
networkRoaming      : False
internalStorageFree : 51128
internalStorageSize : 55732
imei                : 25 950870 6874529 1
meid                :
osVersion           : 13.7
ownership           : CORPORATE
phoneNumber         :
serialNumber        : K325DNEWA543
udid                : 1afea56a18ag4ea125gg4agragf14781
wifiMacAddress      : g8:45:a5:34:e3:3g
```

Returns device information from UEM Console to the screen.

### Example 1
```powershell
PS C:\> $device = Get-uemUserDevice -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6
PS C:\> $device.hardwareModel
iPhone 8 Plus (GSM)
```

Returns device information from UEM Console as a custom object.

## PARAMETERS

### -userGUID
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
