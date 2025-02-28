
# Remote-Tools
**Last updated: 2025-02-28 09:38:34**


This repository contains a collection of PowerShell modules that provide functions for managing remote computers.

# RT-Files

## Unblock-Files

### Synopsis
Unblock-Files - Unblocks specified files on remote hosts.

### Description
Unblock-Files unblocks specified files on one or more remote hosts using PowerShell remoting. 
It takes a list of Hosts and a list of file paths as input parameters and executes the Unblock-File cmdlet on each remote host.

### Syntax
```ps1

Unblock-Files [-Hosts] <String[]> [-Files] <String[]> [<CommonParameters>]




```

### Parameters

    -Hosts <String[]>
        An array of hosts where the files need to be unblocked. This parameter is mandatory.
        
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    -Files <String[]>
        An array of file paths that need to be unblocked on the remote hosts. This parameter is mandatory.
        
        Required?                    true
        Position?                    2
        Default value                
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216). 
    




### Examples
```powershell

-------------------------- EXAMPLE 1 --------------------------

PS > Unblock-Files -Hosts "Server01", "Server02" -Files "C:\path\to\file1.txt", "C:\path\to\file2.txt"
This command unblocks the specified files on the remote hosts Server01 and Server02.









```

### Notes
```powershell

```

---
# RT-GroupMembers

## Add-GroupMembers

### Synopsis
Adds specified members to a local group on a remote computer.

### Description
The Add-GroupMembers function connects to a remote computer specified by the Host parameter and adds the specified members to a local group. By default, the group is "Administrators", but this can be changed using the GroupName parameter.

### Syntax
```ps1

Add-GroupMembers [-Hosts] <String> [[-GroupName] <String>] [-Members] <String[]> [[-Force] <Boolean>] [<CommonParameters>]




```

### Parameters

    -Hosts <String>
        The name of the remote computer where the group members will be added. This parameter is mandatory.
        
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    -GroupName <String>
        The name of the local group to which the members will be added. This parameter is optional and defaults to "Administrators".
        
        Required?                    false
        Position?                    2
        Default value                Administrators
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    -Members <String[]>
        An array of members to be added to the specified group. This parameter is mandatory.
        
        Required?                    true
        Position?                    3
        Default value                
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    -Force <Boolean>
        
        Required?                    false
        Position?                    4
        Default value                False
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216). 
    




### Examples
```powershell

-------------------------- EXAMPLE 1 --------------------------

PS > Add-GroupMembers -Hosts "Server01" -GroupName "Remote Desktop Users" -Members "User1", "User2"
This example adds User1 and User2 to the "Remote Desktop Users" group on the remote computer "Server01".






-------------------------- EXAMPLE 2 --------------------------

PS > Add-GroupMembers -Hosts "Server02" -Members "User3"
This example adds User3 to the "Administrators" group on the remote computer "Server02".









```

### Notes
```powershell

```


## Get-GroupMembers

### Synopsis
Retrieves members of a specified local group on a remote computer.

### Description
The Get-GroupMembers function connects to a remote computer specified by the Host parameter and retrieves the members of a specified local group. By default, the group is "Administrators", but this can be changed using the GroupName parameter.

### Syntax
```ps1

Get-GroupMembers [-Hosts] <String> [[-GroupName] <String>] [<CommonParameters>]




```

### Parameters

    -Hosts <String>
        The name of the remote computer from which the group members will be retrieved. This parameter is mandatory.
        
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    -GroupName <String>
        The name of the local group whose members will be retrieved. This parameter is optional and defaults to "Administrators".
        
        Required?                    false
        Position?                    2
        Default value                Administrators
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216). 
    




### Examples
```powershell

-------------------------- EXAMPLE 1 --------------------------

PS>Get-GroupMembers -Hosts "Server01" -GroupName "Remote Desktop Users"
This example retrieves the members of the "Remote Desktop Users" group on the remote computer "Server01".






-------------------------- EXAMPLE 2 --------------------------

PS>Get-GroupMembers -Hosts "Server02"
This example retrieves the members of the "Administrators" group on the remote computer "Server02".









```

### Notes
```powershell

```


## Remove-GroupMembers

### Synopsis
Removes specified members from a local group on a remote computer.

### Description
The Remove-GroupMembers function connects to a remote computer specified by the Host parameter and removes the specified members from a local group. By default, the group is "Administrators", but this can be changed using the GroupName parameter.

### Syntax
```ps1

Remove-GroupMembers [-Hosts] <String> [[-GroupName] <String>] [-Members] <String[]> [[-Force] <Boolean>] [<CommonParameters>]




```

### Parameters

    -Hosts <String>
        
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    -GroupName <String>
        The name of the local group from which the members will be removed. This parameter is optional and defaults to "Administrators".
        
        Required?                    false
        Position?                    2
        Default value                Administrators
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    -Members <String[]>
        An array of members to be removed from the specified group. This parameter is mandatory.
        
        Required?                    true
        Position?                    3
        Default value                
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    -Force <Boolean>
        
        Required?                    false
        Position?                    4
        Default value                False
        Accept pipeline input?       false
        Aliases                      
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216). 
    




### Examples
```powershell

-------------------------- EXAMPLE 1 --------------------------

PS > Remove-GroupMembers -Hosts "Server01" -GroupName "Remote Desktop Users" -Members "User1", "User2"
This example removes User1 and User2 from the "Remote Desktop Users" group on the remote computer "Server01".






-------------------------- EXAMPLE 2 --------------------------

PS > Remove-GroupMembers -Hosts "Server02" -Members "User3"
This example removes User3 from the "Administrators" group on the remote computer "Server02".









```

### Notes
```powershell

```

---
# RT-MpPreferences
---
# RT-PSRemoting

## Set-RemoteExecutionPolicy

### Synopsis

Set-RemoteExecutionPolicy [[-ComputerName] <string>] [[-ExecutionPolicy] <string>] [[-Scope] <string>] [<CommonParameters>]


### Description


### Syntax
```ps1

syntaxItem
----------
{@{name=Set-RemoteExecutionPolicy; CommonParameters=True; parameter=System.Object[]}}


```

### Parameters

parameter
---------
{@{name=ComputerName; required=false; pipelineInput=false; isDynamic=false; globbing=false; parameterSetName=(All); parameterValue=string; type=; position=0; aliases=None}, @{name=ExecutionPolicy; required=false; pipelineInput=false; isDynamic=false; globbing=false; parameterSetName=(All); parameterValue=string; type=; …



### Examples
```powershell

```

### Notes
```powershell

```


## Test-WSMan

### Synopsis

Test-WSMan [[-ComputerName] <string>] [<CommonParameters>]


### Description


### Syntax
```ps1

syntaxItem
----------
{@{name=Test-WSMan; CommonParameters=True; parameter=System.Object[]}}


```

### Parameters

parameter
---------
{@{name=ComputerName; required=false; pipelineInput=false; isDynamic=false; globbing=false; parameterSetName=(All); parameterValue=string; type=; position=0; aliases=None}}



### Examples
```powershell

```

### Notes
```powershell

```

---

