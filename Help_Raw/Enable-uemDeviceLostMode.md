---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Enable-uemDeviceLostMode

## SYNOPSIS
Enable Lost Mode on the device.

## SYNTAX

```
Enable-uemDeviceLostMode [-userGuid] <Guid> [-userDeviceGuid] <Guid> [-phoneNumber] <String>
 [-message] <String> [[-footnote] <String>] [<CommonParameters>]
```

## DESCRIPTION
Enable Lost Mode on the device. Phone Number and message need to be specified for the device lock screen.

## EXAMPLES

### Example 1
```powershell
PS C:\> Enable-uemDeviceLostMode -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6 -userDeviceGuid 60d360cb-7e8d-49ba-a902-c8ce8678cde2 -message "This device has been placed in lost mode. You will not be able to access any information on it." -phoneNumber "15555555555"
```

Sets message and phone number to call when the device is found.

### Example 2
```powershell
PS C:\> Enable-uemDeviceLostMode -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6 -userDeviceGuid 60d360cb-7e8d-49ba-a902-c8ce8678cde2 -message "This device has been placed in lost mode. You will not be able to access any information on it." -phoneNumber "15555555555" -footnote "Slide to Unlock Device"
```

Sets message and phone number to call when the device is found.  Sets a slide to unlock message on device.

## PARAMETERS

### -footnote
Slide to unlock text. The maximum length of the text is 30 characters (optional).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -message
The message to display on the locked device. The maximum length of the message is 150 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phoneNumber
The phone number to display on the locked device. The maximum length of the phone number is 30 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
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
