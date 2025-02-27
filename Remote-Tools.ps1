<#
.SYNOPSIS
    Installs or imports Remote-Tools modules.

.DESCRIPTION
    Helpful functions to execute commands on remote hosts using PSRemote and Invoke-Command.

.PARAMETER Install
    Installs the modules to the current user.

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
    [switch]$Import = $False
)

$CurrentScriptName = $MyInvocation.MyCommand.Name
$CurrentScriptPath = $MyInvocation.MyCommand.Path
$CurrentScriptDir  = Split-Path -Path $CurrentScriptPath -Parent
$CurrentScriptFile = Split-Path -Path $CurrentScriptPath -Leaf
$isDotSourced      = $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq ''

Write-Output "Current script name: $CurrentScriptName"
Write-Output "Current script path: $CurrentScriptPath"
Write-Output "Current script dir: $CurrentScriptDir"
Write-Output "Current script file: $CurrentScriptFile"
Write-Output "Is dot sourced: $isDotSourced"

Write-Output "============"

# List files in the Modules directory
$ModulesFiles = Get-ChildItem -Path "$CurrentScriptDir\Modules" -Filter *.psm1
Write-Output $($CurrentScriptDir)
Write-Output "Remote Tools"
Write-Output "============"

# Ask if user wants to import or install the modules
if ($Install -eq $true) {
    Write-Output "Installing modules..."
    $action = "Install"
} elseif ($Import -eq $true) {
    Write-Output "Importing modules..."
    $action = "Import"
} else {
    Write-Output "Do you want to import or install the modules?"
    Write-Output "1. Import modules to current session"
    Write-Output "2. Install modules to the current user"
    Write-Output "0. (or empty) Exit"
    $choice = Read-Host "Enter your choice (1 or 2)"
    if ($choice -eq "1") {
        $action = "Import"
        Import-Module ".\Remote-Tools.psd1"
    } elseif ($choice -eq "2") {
        $action = "Install"
        Install-Module ".\Remote-Tools.psd1" -Force
    } else {
        Write-Output "Exiting..."
        exit
    }
}

exit


# Import all modules in the Modules directory
foreach ($Module in $ModulesFiles) {

    $ThisName    = $Module.BaseName
    $ThisFile    = $Module.Name
    $ThisPath    = $Module.FullName

    Write-Output "Module: $ThisName"
    Write-Output "File: $ThisFile"
    Write-Output "Path: $ThisPath"

    # Install/import the module
    if ($action -eq "Install") {
        Write-Output "> Install-Module -InputObject $ThisName"
        Install-Module ".\Remote-Tools.psd1" -Force
    } elseif ($action -eq "Import") {
        Write-Output "> Import-Module -Name $ThisName"
        Import-Module "$ThisName"
        Import-Module $($ThisPath)
    }
    exit

    Get-Module -Name $ThisName -ListAvailable
    Write-Output "Install-Module -InputObject $Module"
    Install-Module -InputObject $Module
    exit
    # Get-Help $ThisName -Full
    # exit
    Write-Output ""
    Import-Module -Name "$ThisName"
    exit
    Update-Help -Module $ThisName -Force
    Get-Module -Name $ThisName
    Get-Command -Module $Module.Value.Name | ForEach-Object {
        Write-Output "> $_.Name"
        Get-Help -Name $_.Name -Full | Format-List -Property Name, Synopsis
    }

    Write-Output ""
}