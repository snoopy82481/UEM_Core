---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Disable-uemDeviceLostMode

## SYNOPSIS
Disables lost mode on mobile device.

## SYNTAX

```
Disable-uemDeviceLostMode [-userGuid] <Guid> [-userDeviceGuid] <Guid> [<CommonParameters>]
```

## DESCRIPTION
Disables lost mode for mobile device.

## EXAMPLES

### Example 1
```powershell
PS C:\> Disable-uemDeviceLostMode -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6 -userDeviceGuid 60d360cb-7e8d-49ba-a902-c8ce8678cde2
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
Accept pipeline input: False
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
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
