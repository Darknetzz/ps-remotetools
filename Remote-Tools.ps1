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
    [switch]$Install = $False
)

$CurrentScriptName = $MyInvocation.MyCommand.Name
$CurrentScriptPath = $MyInvocation.MyCommand.Path
$CurrentScriptDir  = Split-Path -Path $CurrentScriptPath -Parent
$CurrentScriptFile = Split-Path -Path $CurrentScriptPath -Leaf
$isDotSourced      = $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq ''

# Write-Output "Current script name: $CurrentScriptName"
# Write-Output "Current script path: $CurrentScriptPath"
# Write-Output "Current script dir: $CurrentScriptDir"
# Write-Output "Current script file: $CurrentScriptFile"
# Write-Output "Is dot sourced: $isDotSourced"


# List files in the Modules directory
Write-Output "Remote Tools imported!"

Import-Module ".\Remote-Tools.psd1" -Force


# Ask if user wants to import or install the modules
if ($Install -eq $true) {

    # NOTE: Broken
    Write-Output "Installing is currently not available. Exiting..."
    Exit

    Write-Output "Installing module..."

    $ModuleObj = Get-Module -Name "Remote-Tools"
    Write-Output "ModuleObj: $ModuleObj"
    if ($null -eq $ModuleObj.Path) {
        Write-Output "Module not found and can't be installed. Exiting..."
        Exit
    }

    Install-Module -Name $ModuleObj -Force
    Exit
} 


# # Import all modules in the Modules directory
# $ModulesFiles = Get-ChildItem -Path "$CurrentScriptDir\Modules" -Filter *.psm1
# foreach ($Module in $ModulesFiles) {

#     $ThisModuleName    = $Module.BaseName
#     $ThisModuleFile    = $Module.Name
#     $ThisModulePath    = $Module.FullName

# Write-Output @"
#         `n`n
#         ====================
#         [ $ThisModuleName ]
#         Module: $ThisModuleName
#         File  : $ThisModuleFile
#         Path  : $ThisModulePath
#         ====================
#         `n`n
# "@

#     # Install/import the module
#     if ($action -eq "Install") {
#         Write-Output "> Install-Module -InputObject $ThisModuleName"
#         Install-Module ".\Remote-Tools.psd1" -Force
#     } elseif ($action -eq "Import") {
#         Write-Output "> Import-Module -Name $ThisModuleName"
#         Import-Module "$ThisModuleName"
#         Import-Module $($ThisModulePath)
#     }
#     exit

#     Get-Module -Name $ThisModuleName -ListAvailable
#     Write-Output "Install-Module -InputObject $Module"
#     Install-Module -InputObject $Module
#     exit
#     # Get-Help $ThisModuleName -Full
#     # exit
#     Write-Output ""
#     Import-Module -Name "$ThisModuleName"
#     exit
#     Update-Help -Module $ThisModuleName -Force
#     Get-Module -Name $ThisModuleName
#     Get-Command -Module $Module.Value.Name | ForEach-Object {
#         Write-Output "> $_.Name"
#         Get-Help -Name $_.Name -Full | Format-List -Property Name, Synopsis
#     }

#     Write-Output ""
# }