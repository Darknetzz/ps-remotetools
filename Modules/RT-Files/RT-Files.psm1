# ======================================================================= #
#                              Unblock-Files                              #
# ======================================================================= #
function Unblock-Files {
    <#

    .SYNOPSIS
        Unblock-Files - Unblocks specified files on remote hosts.

    .DESCRIPTION
        Unblock-Files unblocks specified files on one or more remote hosts using PowerShell remoting. 
        It takes a list of Hosts and a list of file paths as input parameters and executes the Unblock-File cmdlet on each remote host.

    .PARAMETER Hosts
        An array of hosts where the files need to be unblocked. This parameter is mandatory.

    .PARAMETER Files
        An array of file paths that need to be unblocked on the remote hosts. This parameter is mandatory.

    .EXAMPLE
        Unblock-Files -Hosts "Server01", "Server02" -Files "C:\path\to\file1.txt", "C:\path\to\file2.txt"
        This command unblocks the specified files on the remote hosts Server01 and Server02.
        
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,HelpMessage="Enter one or more hostnames separated by commas.")]
        [string[]]$Hosts,

        [Parameter(Mandatory=$true,HelpMessage="Enter one or more filepaths separated by commas.")]
        [string[]]$Files
    )

    $remoteCommands = {
        Unblock-File -Path $using:Files
    }
    $output = Invoke-Command -ComputerName $Hosts -ScriptBlock $remoteCommands
    Write-Output "> Unblocking files for $Hosts"
    Write-Output "$($output | Out-String)"
}

Export-ModuleMember -Function Unblock-Files