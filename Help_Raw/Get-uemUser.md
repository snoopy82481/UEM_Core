---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# Get-uemUser

## SYNOPSIS
Gets user details from uem console.

## SYNTAX

```
Get-uemUser [-userEmailAddress] <MailAddress> [<CommonParameters>]
```

## DESCRIPTION
Gets users details into a custom object that can be stored as a variable and used elsewhere.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-uemUser -userEmailAddress tom.warbucks@conaco.com

username     : tom.warbucks
displayname  : Warbucks, Tom CEO
Name         : Tom Warbucks
emailAddress : tom.warbucks@conaco.com
links        : {@{href=https://servername:18084/S00000000/api/v1/users/cf2e85dd-1977-4c8a-9023-86eea5e233c6/groups;
               rel=groups},
               @{href=https://servername:18084/S00000000/api/v1/users/cf2e85dd-1977-4c8a-9023-86eea5e233c6/profiles;
               rel=profiles}}
guid         : cf2e85dd-1977-4c8a-9023-86eea5e233c6
directoryId  : 156dsgfr183se1taegh812sxedgfagss
admin        : False
created      : 9/30/2020 9:24:56 PM
```

Returns users information from UEM Console.

### Example 1
```powershell
PS C:\> $user = Get-uemUser -userEmailAddress tom.warbucks@conaco.com
PS C:\> $user.username
tom.warbucks
PS C:\> $user.guid
cf2e85dd-1977-4c8a-9023-86eea5e233c6
```

Returns users information from UEM Console as a custom object.


## PARAMETERS

### -userEmailAddress
Users email address.

```yaml
Type: MailAddress
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

### System.Net.Mail.MailAddress

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
