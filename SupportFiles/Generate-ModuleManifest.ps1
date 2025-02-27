# Directories
$CurrentScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$ParentDir        = Split-Path -Path $CurrentScriptDir -Parent
$ModulesDir       = Join-Path -Path $ParentDir -ChildPath "Modules"

. "$CurrentScriptDir\Variables.ps1"

# Variables
Write-Output $RTVariables.Version
Write-Output $RTVariables.Author
Write-Output $RTVariables.Description
Write-Output $RTVariables.Tags

# Manifest values
$ManifestArguments = @{
    Path              = "Remote-Tools.psd1"
    RootModule        = ("Remote-Tools.psm1")
    ModuleVersion     = $RTVariables.Version
    Author            = $RTVariables.Author
    Description       = $RTVariables.Description
    Tags              = $RTVariables.Tags
}

# Create the module manifest for Remote-Tools
Write-Output "Generating module manifest for Remote-Tools"
New-ModuleManifest @ManifestArguments

# Get the list of files in the 'Modules' folder
$ModulesFiles = Get-ChildItem -Path "$ModulesDir" -Filter *.psm1 -Recurse
foreach ($Module in $ModulesFiles) {
    $ThisModuleName    = $Module.BaseName
    $ThisModuleFile    = $Module.Name
    $ThisModulePath    = $Module.FullName
    $ThisModuleDir     = $Module.DirectoryName
 
    Write-Output "Generating module manifest for $ThisModuleName"
    Write-Output "Module : $ThisModuleName"
    Write-Output "File   : $ThisModuleFile"
    Write-Output "Path   : $ThisModulePath"

    $ManifestArguments.Path       = "$ThisModuleDir\$ThisModuleName.psd1"
    $ManifestArguments.RootModule = $ThisModuleFile

    # Creating the module manifest
    New-ModuleManifest @ManifestArguments
    Write-Output "Module manifest for $ThisModuleName created successfully"
}