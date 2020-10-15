---
external help file: UEM_Core-help.xml
Module Name: uem_core
online version:
schema: 2.0.0
---

# New-uemDirectoryUser

## SYNOPSIS
Create's directory linked user on BlackBerry UEM Console.

## SYNTAX

```
New-uemDirectoryUser [-userEmailAddress] <MailAddress> [<CommonParameters>]
```

## DESCRIPTION
Create a directory-linked user (identified by the "directoryId" property). See the "Company directories" resource for searching for directory users. The user will be assigned the highest ranking self-service user role, the All users group, and any default policies and profiles. The user will be enabled for MDM, unless the "mdm" property is set to false.

The [directory user properties](https://developer.blackberry.com/files/bws/reference/blackberry_uem_12_12_rest/json_DirectoryUserView.html) that are allowed when creating a directory-linked user are: directoryId, mdm. Other properties in the directory user data type are ignored if they are provided, and directory-linked user information (ex. displayName, emailAddress) will be synced from the directory when the user is created. If properties are provided that are not part of the directory user data type, an error is returned.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-uemDirectoryUser -userEmailAddress tom.warbucks@conaco.com
```

Creates directory linked user with users E-mail Address supplied.

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
