# ======================================================================= #
#                             Add-GroupMembers                            #
# ======================================================================= #
function Add-GroupMembers {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Host,

        [Parameter(Mandatory=$false)]
        [string]$GroupName = "Administrators",

        [Parameter(Mandatory=$true)]
        [string[]]$Members
    )

    <#
    .SYNOPSIS
    Adds specified members to a local group on a remote computer.

    .DESCRIPTION
    The Add-GroupMembers function connects to a remote computer specified by the Host parameter and adds the specified members to a local group. By default, the group is "Administrators", but this can be changed using the GroupName parameter.

    .PARAMETER Host
    The name of the remote computer where the group members will be added. This parameter is mandatory.

    .PARAMETER GroupName
    The name of the local group to which the members will be added. This parameter is optional and defaults to "Administrators".

    .PARAMETER Members
    An array of members to be added to the specified group. This parameter is mandatory.

    .EXAMPLE
    Add-GroupMembers -Host "Server01" -GroupName "Remote Desktop Users" -Members "User1", "User2"
    This example adds User1 and User2 to the "Remote Desktop Users" group on the remote computer "Server01".

    .EXAMPLE
    Add-GroupMembers -Host "Server02" -Members "User3"
    This example adds User3 to the "Administrators" group on the remote computer "Server02".
    #>

    $remoteCommands = {
        param ($GroupName, $Members)
        Add-LocalGroupMember -Group $GroupName -Member $Members
    }
    $output = Invoke-Command -ComputerName $Host -ScriptBlock $remoteCommands -ArgumentList $GroupName, $Members
    Write-Output "> Add-GroupMembers for $Host - Group: $GroupName"
    Write-Output "$($output | Out-String)"
}

# ======================================================================= #
#                           Get-GroupMembers                              #
# ======================================================================= #
function Get-GroupMembers {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Host,

        [Parameter(Mandatory=$false)]
        [string]$GroupName = "Administrators"
    )

    <#
    
        .SYNOPSIS
        Retrieves members of a specified local group on a remote computer.

        .DESCRIPTION
        The Get-GroupMembers function connects to a remote computer specified by the Host parameter and retrieves the members of a specified local group. By default, the group is "Administrators", but this can be changed using the GroupName parameter.

        .PARAMETER Host
        The name of the remote computer from which the group members will be retrieved. This parameter is mandatory.

        .PARAMETER GroupName
        The name of the local group whose members will be retrieved. This parameter is optional and defaults to "Administrators".

        .EXAMPLE
        Get-GroupMembers -Host "Server01" -GroupName "Remote Desktop Users"
        This example retrieves the members of the "Remote Desktop Users" group on the remote computer "Server01".

        .EXAMPLE
        Get-GroupMembers -Host "Server02"
        This example retrieves the members of the "Administrators" group on the remote computer "Server02".

    #>

    $remoteCommands = {
        param ($GroupName)
        Get-LocalGroupMember -Group $GroupName
    }
    $output = Invoke-Command -ComputerName $Host -ScriptBlock $remoteCommands -ArgumentList $GroupName
    Write-Output "> Show-GroupMembers for $Host - Group: $GroupName"
    Write-Output "$($output | Out-String)"
}

# ======================================================================= #
#                           Remove-GroupMembers                           #
# ======================================================================= #
function Remove-GroupMembers {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Host,

        [Parameter(Mandatory=$false)]
        [string]$GroupName = "Administrators",

        [Parameter(Mandatory=$true)]
        [string[]]$Members
    )

    $remoteCommands = {
        param ($GroupName, $Members)
        Remove-LocalGroupMember -Group $GroupName -Member $Members
    }
    $output = Invoke-Command -ComputerName $Host -ScriptBlock $remoteCommands -ArgumentList $GroupName, $Members
    Write-Output "> Remove-GroupMembers for $Host - Group: $GroupName"
    Write-Output "$($output | Out-String)"
}

Export-ModuleMember -Function Add-GroupMembers
Export-ModuleMember -Function Get-GroupMembers
Export-ModuleMember -Function Remove-GroupMembers