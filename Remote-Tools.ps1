<#
.SYNOPSIS
    Installs or imports Remote-Tools modules.

.DESCRIPTION
    Helpful functions to execute commands on remote hosts using PSRemote and Invoke-Command.

.PARAMETER Install
    Installs the modules to the current user.

.PARAMETER Module
    Specifies a single module to import.

.EXAMPLE
    Installing Remote-Tools
    ```powershell
    # Installs Remote-Tools
    PS> .\Remote-Tools.ps1 -Install
    ```

.EXAMPLE
    Importing Remote-Tools
    ```powershell
    # Imports Remote-Tools to current session
    PS> .\Remote-Tools.ps1 -Import
    ```

.NOTES
    See https://github.com/Darknetzz/ps-remotetools for more information.

.LINK
    https://github.com/Darknetzz/ps-remotetools
#>
[CmdletBinding()]
param (
    [switch]$Install = $False,
    [string]$Module = $False
)

# Single module import
if ($Module -ne $False) {
    Write-Output "Module: $Module"

    # Import the module
    Import-Module .\Modules\$Module -Force

    if ($Install -ne $False) {
        Write-Output "Installing module $Module..."
        Install-Module -Name $Module -Force
    }

    Exit
}

# Remote Tools modules
Import-Module .\Remote-Tools.psd1 -Force
Write-Output "Remote-Tools modules imported."