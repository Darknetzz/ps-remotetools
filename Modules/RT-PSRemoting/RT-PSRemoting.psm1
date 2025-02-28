# Will be used to Enable-PSRemoting etc.

# Test-WSMan
# Enable-PSRemoting
# Disable-PSRemoting
# Set-ExecutionPolicy
# Get-Service WinRM
# Start-Service WinRM
# Stop-Service WinRM
# Restart-Service WinRM


# ======================================================================= #
#                          Test-RemoteConnection                          #
# ======================================================================= #
function Test-RemoteConnection {
    [CmdletBinding()]
    param (
        [string]$Hosts = $env:Hosts
    )
    <#
        .SYNOPSIS
            Test-RemoteConnection - Tests the connection to a remote host.

        .DESCRIPTION
            Test-RemoteConnection tests the connection to a remote host using the Test-Connection cmdlet. 
            It takes a Hosts as an input parameter and executes the Test-Connection cmdlet on the remote host.

        .PARAMETER Hosts
            The name of the remote host to which the connection needs to be tested. This parameter is optional and defaults to the local computer.

        .EXAMPLE
            Test-RemoteConnection -Hosts "Server01"
            This command tests the connection to the remote host Server01.

        .EXAMPLE
            Test-RemoteConnection -Hosts Server01, Server02
            This command tests the connection to the remote hosts Server01 and Server02.
    #>

    $ErrorActionPreference = 'Stop'

    try {
        $result = Test-Connection -ComputerName $Hosts -Count 1 -ErrorAction Stop
        Write-Output "Connection to $Hosts is successful"
    } catch {
        Write-Output "Failed to connect to $Hosts"
        Write-Output $_.Exception.Message
    }
}

# ======================================================================= #
#                             Get-WinRMStatus                             #
# ======================================================================= #
function Get-WinRMStatus {
    [CmdletBinding()]
    param (
        [string]$Hosts = $env:Hosts
    )
    <#
        .SYNOPSIS
            Get-WinRMStatus - Gets the status of the WinRM service on a remote host.

        .DESCRIPTION
            Get-WinRMStatus gets the status of the WinRM service on a remote host using PowerShell remoting. 
            It takes a Hosts as an input parameter and executes the Get-Service cmdlet on the remote host.

        .PARAMETER Hosts
            The name of the remote host where the WinRM status needs to be retrieved. This parameter is optional and defaults to the local computer.

        .EXAMPLE
            Get-WinRMStatus -Hosts "Server01"
            This command gets the status of the WinRM service on the remote host Server01.

        .EXAMPLE
            Get-WinRMStatus -Hosts Server01, Server02
            This command gets the status of the WinRM service on the remote hosts Server01 and Server02.
    #>

    $ErrorActionPreference = 'Stop'

    try {
        $result = Invoke-Command -ComputerName $Hosts -ScriptBlock { Get-Service WinRM } -ErrorAction Stop
        Write-Output "WinRM status on $Hosts is $result"
    } catch {
        Write-Output "Failed to get WinRM status on $Hosts"
    }
}

# ======================================================================= #
#                        Set-RemoteExecutionPolicy                        #
# ======================================================================= #
function Set-RemoteExecutionPolicy {
    [CmdletBinding()]
    param (
        [string[]]$Hosts         = $env:Hosts,
        [string]$ExecutionPolicy = 'RemoteSigned',
        [string]$Scope           = 'CurrentUser'
    )
    <#
        .SYNOPSIS
            Set-RemoteExecutionPolicy - Sets the Execution Policy on a remote host.

        .DESCRIPTION
            Set-RemoteExecutionPolicy sets the Execution Policy on a remote host using PowerShell remoting. 
            It takes a Hosts, ExecutionPolicy, and Scope as input parameters and executes the Set-ExecutionPolicy cmdlet on the remote host.

        .PARAMETER Hosts
            The name of the remote host where the Execution Policy needs to be set. This parameter is optional and defaults to the local computer.

        .PARAMETER ExecutionPolicy
            The Execution Policy to be set on the remote host. This parameter is optional and defaults to RemoteSigned.
            Possible options are:
            - RemoteSigned [default]
            - AllSigned
            - Restricted
            - Unrestricted
            - Bypass
            - Undefined

        .PARAMETER Scope
            The scope at which the Execution Policy needs to be set. This parameter is optional and defaults to CurrentUser.
            Possible options are:
            - CurrentUser [default]
            - Process
            - CurrentUser
            - LocalMachine

        .EXAMPLE
            Set-RemoteExecutionPolicy -Hosts "Server01" -ExecutionPolicy "RemoteSigned" -Scope "CurrentUser"
            This command sets the Execution Policy to RemoteSigned on the remote host Server01 for the CurrentUser scope.

        .EXAMPLE
            Set-RemoteExecutionPolicy -Hosts Server01, Server02 -ExecutionPolicy "RemoteSigned" -Scope "LocalMachine"
            This command sets the Execution Policy to RemoteSigned on the remote host Server01 for the LocalMachine scope.
    #>

    $ErrorActionPreference = 'Stop'

    try {
            Invoke-Command -ComputerName $Hosts -ScriptBlock {
            Set-ExecutionPolicy -ExecutionPolicy $using:ExecutionPolicy -Force
        } -ErrorAction Stop
        Write-Output "Execution Policy set to $ExecutionPolicy on $Hosts"
    } catch {
        Write-Output "Failed to set Execution Policy on $Hosts"
    }
}



# ======================================================================= #
#                        Get-RemoteExecutionPolicy                        #
# ======================================================================= #
function Get-RemoteExecutionPolicy {
    [CmdletBinding()]
    param (
        [string]$Hosts = $env:Hosts
    )
    <#
        .SYNOPSIS
            Get-RemoteExecutionPolicy - Gets the Execution Policy on a remote host.

        .DESCRIPTION
            Get-RemoteExecutionPolicy gets the Execution Policy on a remote host using PowerShell remoting. 
            It takes a Hosts as an input parameter and executes the Get-ExecutionPolicy cmdlet on the remote host.

        .PARAMETER Hosts
            The name of the remote host where the Execution Policy needs to be retrieved. This parameter is optional and defaults to the local computer.

        .EXAMPLE
            Get-RemoteExecutionPolicy -Hosts "Server01"
            This command gets the Execution Policy on the remote host Server01.

        .EXAMPLE
            Get-RemoteExecutionPolicy -Hosts Server01, Server02
            This command gets the Execution Policy on the remote hosts Server01 and Server02.
    #>

    $ErrorActionPreference = 'Stop'

    try {
        $result = Invoke-Command -ComputerName $Hosts -ScriptBlock { Get-ExecutionPolicy } -ErrorAction Stop
        Write-Output "Execution Policy on $Hosts is set to $result"
    } catch {
        Write-Output "Failed to get Execution Policy on $Hosts"
    }
}

# Test-WSMan
function Test-WSMan {
    [CmdletBinding()]
    param (
        [string]$Hosts = $env:Hosts
    )

    $ErrorActionPreference = 'Stop'

    try {
        $result = Invoke-Command -ComputerName $Hosts -ScriptBlock { $true } -ErrorAction Stop
        Write-Output "WSMan is working on $Hosts"
    } catch {
        Write-Output "WSMan is not working on $Hosts"
    }
}