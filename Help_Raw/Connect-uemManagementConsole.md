---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Connect-uemManagementConsole

## SYNOPSIS
Connects to UEM Management Console

## SYNTAX

```
Connect-uemManagementConsole [-tenant] <Uri> [-localAdmin] [<CommonParameters>]
```

## DESCRIPTION
Connects current session to UEM Management console with username and password.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-uemManagementConsole -tenant https://servername:18084/S00000000
```

Creates your connection to the UEM Console provided by the tenant.  As an Active Directory administrator.

### Example 2
```powershell
PS C:\> Connect-uemManagementConsole -tenant https://servername:18084/S00000000 -localAdmin
```

Creates your connection to the UEM Console provided by the tenant.  As a locally created admin.

## PARAMETERS

### -localAdmin
Specified account is a local administrator account vs an Active Directory Linked administrator account.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -tenant
Server name for your connected UEM instance.

```yaml
Type: Uri
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

### System.Uri

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
