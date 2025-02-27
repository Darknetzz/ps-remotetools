Set-Variable -Name "RTVariables" -Value @{
    Version           = [version]"1.0.0"
    Author            = "Darknetzz"
    Description       = "Helpful functions to execute commands on remote hosts using PSRemote and Invoke-Command."
    Tags              = @("Remote", "Tools")
}

# $CurrentScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# $ParentDir        = Split-Path -Path $CurrentScriptDir -Parent
# $ModulesDir       = $ParentDir | Get-ChildItem -Recurse -Directory -Filter Modules
# $ModuleFiles      = $ModulesDir | Get-ChildItem -Filter *.psm1 -Recurse
# . $CurrentScriptDir\Variables.ps1

# Write-Output "Parent directory: $ParentDir"
# Write-Output "Current directory: $CurrentScriptDir"
# Write-Output "Modules directory: $ModulesDir"
# Write-Output "Module files:"
# $ModuleFiles | ForEach-Object { $_.FullName }