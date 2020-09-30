---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Get-uemGroupInfo

## SYNOPSIS
Gets group information for a specified group.

## SYNTAX

```
Get-uemGroupInfo [-groupName] <String> [<CommonParameters>]
```

## DESCRIPTION
Retrieves the groups name and GUID of the specified group. Returns a custom object that can be store in a variable.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-uemGroupInfo -groupName 'All users'

guid                                 name
----                                 ----
c27d4c69-af03-4525-b064-e828f29b251a All Users

```

Returns the guid and name of the group supplied.

### Example 2
```powershell
PS C:\> $group = Get-uemGroupInfo -groupName 'All users'
PS C:\> $group.guid
c27d4c69-af03-4525-b064-e828f29b251a
PS C:\> $group.name
All Users
```

Returns the group info to variable to be called later.

## PARAMETERS

### -groupName
Name of the group that you want to get the information about.

```yaml
Type: String
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

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
