---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Connect-uemManagementConsole

## SYNOPSIS
Creates connection string to BlackBerry UEM console.

## SYNTAX

```
Connect-uemManagementConsole [-tenant] <Uri> [<CommonParameters>]
```

## DESCRIPTION
The **Connect-uemManagementConsole** cmdlet creates a connection string to the BlackBerry UEM console. This needs to be ran before any further command can be ran against the server.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-uemManagementConsole -tenant "https://server.name:18084/tenantguid"
```

## PARAMETERS

### -tenant
This is the server and tenant guid required to connect to your BlackBerry UEM instance.

```yaml
Type: Uri
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
