---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Get-uemUserGroups

## SYNOPSIS
Gets users groups.

## SYNTAX

```
Get-uemUserGroups [-userGuid] <Guid> [<CommonParameters>]
```

## DESCRIPTION
Queries the users UEM account and gets the groups that the user is assigned to. Can display to screen or store as a variable as it creates an array of custom object.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-uemUserGroups -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6

name      guid
----      ----
All Users c27d4c69-af03-4525-b064-e828f29b251a
```

Lists users groups to the screen.

### Example 2
```powershell
PS C:\> $groups = Get-uemUserGroups -userGuid cf2e85dd-1977-4c8a-9023-86eea5e233c6
PS C:\> $groups.name
All Users
```

Stores users groups to a variable that is an array of objects.

## PARAMETERS

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
