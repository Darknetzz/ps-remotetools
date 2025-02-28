Set-Variable -Name "RTVariables" -Value @{
    Version           = [version]"1.0.0"
    Author            = "Darknetzz"
    Description       = "Helpful functions to execute commands on remote hosts using PSRemote and Invoke-Command."
    Tags              = @("Remote", "Tools")
}

# $CurrentScriptDir - Will always be the directory where the current script is located
# That means SupportFiles as long as you are fetching the variables from the Variables.ps1 file
$CurrentScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# $RootDir - Will always be the root directory of the project
$RootDir          = Split-Path -Path $CurrentScriptDir -Parent

# Modules directory
$ModulesDir       = $ParentDir | Get-ChildItem -Recurse -Directory -Filter Modules
$ModuleFiles      = $ModulesDir | Get-ChildItem -Filter *.psm1 -Recurse