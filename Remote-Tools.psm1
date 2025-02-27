# Directories
$CurrentScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$ModulesDir       = Join-Path -Path $CurrentScriptDir -ChildPath "Modules"

# Get the list of files in the 'Modules' folder
$ModulesFiles = Get-ChildItem -Path $ModulesDir -Filter *.psm1

# Export all functions in the modules
foreach ($Module in $ModulesFiles) {
    $ThisModuleName    = $Module.BaseName
    $ThisModuleFile    = $Module.Name
    $ThisModulePath    = $Module.FullName

    Write-Output "Module: $ThisModuleName"
    Write-Output "File: $ThisModuleFile"
    Write-Output "Path: $ThisModulePath"

    # Import the module
    Import-Module "$($ThisModulePath)" -Force

    # Export all functions in the module
    Export-Module $ThisModuleName
}