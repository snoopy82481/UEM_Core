---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Lock-uemDevice

## SYNOPSIS
Locks device.

## SYNTAX

```
Lock-uemDevice [-userGuid] <Guid> [-userDeviceGuid] <Guid> [[-password] <String>] [[-message] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Locks device.  Allows you to set a different password and lock screen message to display on the device.

## EXAMPLES

### Example 1
```powershell
PS C:\> Lock-uemDevice -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6 -userDeviceGuid 60d360cb-7e8d-49ba-a902-c8ce8678cde2
```

Locks device.

### Example 2
```powershell
PS C:\> Lock-uemDevice -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6 -userDeviceGuid 60d360cb-7e8d-49ba-a902-c8ce8678cde2 -message 'Device is locked'
```

Locks device and displays a message stating that it is locked.

### Example 3
```powershell
PS C:\> Lock-uemDevice -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6 -userDeviceGuid 60d360cb-7e8d-49ba-a902-c8ce8678cde2 -password 'password'
```

Locks Device and sets the unlock password to password.

### Example 4
```powershell
PS C:\> Lock-uemDevice -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6 -userDeviceGuid 60d360cb-7e8d-49ba-a902-c8ce8678cde2 -password 'password' -message 'Device is locked'
```

Locks Device and sets the unlock password to password and sets the lock screen message to Device is locked.

## PARAMETERS

### -message
Message to display on device lock screen (optional).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -password
New device password (optional).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

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

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
