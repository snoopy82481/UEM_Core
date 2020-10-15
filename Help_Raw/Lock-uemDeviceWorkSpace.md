---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Lock-uemDeviceWorkSpace

## SYNOPSIS
Set work space password and locks work space.

## SYNTAX

```
Lock-uemDeviceWorkSpace [-userGuid] <Guid> [-userDeviceGuid] <Guid> [-password] <String> [<CommonParameters>]
```

## DESCRIPTION
Set work space password and locks work space.

## EXAMPLES

### Example 1
```powershell
PS C:\> Lock-uemDeviceWorkSpace -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6 -userDeviceGuid 60d360cb-7e8d-49ba-a902-c8ce8678cde2 -password 'password'
```

Set work space password and locks work space.

## PARAMETERS

### -password
Password string to set the workspace password to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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
