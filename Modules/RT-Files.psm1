# ======================================================================= #
#                              Unblock-Files                              #
# ======================================================================= #
function Unblock-Files {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Host,
        [Parameter(Mandatory=$true)]
        [string[]]$Files
    )

    <#
    .SYNOPSIS
        Unblocks specified files on remote hosts.

    .DESCRIPTION
        Unblock-Files unblocks specified files on one or more remote hosts using PowerShell remoting. 
        It takes a list of Hosts and a list of file paths as input parameters and executes the Unblock-File cmdlet on each remote host.

    .PARAMETER Host
        An array of hosts where the files need to be unblocked. This parameter is mandatory.

    .PARAMETER Files
        An array of file paths that need to be unblocked on the remote hosts. This parameter is mandatory.

    .EXAMPLE
        Unblock-Files -Host "Server01", "Server02" -Files "C:\path\to\file1.txt", "C:\path\to\file2.txt"
        This command unblocks the specified files on the remote hosts Server01 and Server02.
    #>

    $remoteCommands = {
        Unblock-File -Path $using:Files
    }
    $output = Invoke-Command -ComputerName $Host -ScriptBlock $remoteCommands
    Write-Output "> Unblocking files for $Host"
    Write-Output "$($output | Out-String)"
}

Export-ModuleMember -Function Unblock-Files