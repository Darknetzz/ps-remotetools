# Directories
$CurrentScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$ModulesDir       = Join-Path -Path $CurrentScriptDir -ChildPath "Modules"
$Modules          = $ModulesDir | Get-ChildItem -Directory -Recurse

# Get the list of files in the 'Modules' folder

# Export all functions in the modules
foreach ($Module in $Modules) {
    $ThisModuleName  = $Module.BaseName
    $ThisModuleFile  = $Module.Name
    $ThisModulePath  = $Module.FullName
    $ThisModuleDir   = $Module.DirectoryName
    # $ThisModuleFiles = Get-ChildItem -Path $ModulesDir -Filter *.psm1 -Recurse

Write-Output @"
    `n`n
    ====================
    [ $ThisModuleName ]
    Module   : $ThisModuleName
    File     : $ThisModuleFile
    Directory: $ThisModuleDir
    Path     : $ThisModulePath
    ====================
    `n`n
"@

    # Import the module
    Import-Module "$($ThisModulePath)" -Force

    # Export all functions in the module
    # Export-ModuleMember -Cmdlet $ThisModuleName -Function "*"
}