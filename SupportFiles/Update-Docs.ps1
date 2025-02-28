$CurrentScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$ParentDir        = Split-Path -Path $CurrentScriptDir -Parent
$ModulesDir       = $ParentDir | Get-ChildItem -Recurse -Directory -Filter Modules
$ModuleFiles      = $ModulesDir | Get-ChildItem -Filter *.psm1 -Recurse
. $CurrentScriptDir\Variables.ps1


$global:readmeContent = ""

Function AddToReadme {
    Param (
        [string]$Content
    )

    Write-Output "$Content"
    $global:readmeContent += $Content
    $readmePath = Join-Path "$ParentDir" -ChildPath "MODULES.md"
    $global:readmeContent | Out-File -FilePath $ReadmePath -Encoding utf8
}

# Initialize the README.md content
AddToReadme @"

# Remote-Tools
**Last updated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")**


This repository contains a collection of PowerShell modules that provide functions for managing remote computers.


"@

foreach ($Module in $ModuleFiles) {

Write-Output "Module.BaseName $($Module.BaseName)"
Write-Output "Module.FullName $($Module.FullName)"
Write-Output "Module.DirectoryName $($Module.DirectoryName)"
if (Get-Module -Name $Module.BaseName) {
    Write-Output "Module $($Module.BaseName) is already loaded. Removing it first."
    Remove-Module -Name $Module.BaseName -Force
}
Write-Output "Import-Module $($Module.Directory) -Force -PassThru"
Write-Output "Get-Command -Module $ThisModule -CommandType Function -All -PassThru"
$ThisModule = Import-Module $Module.FullName -Force -PassThru
$Functions  = Get-Command -Module $ThisModule -CommandType Function -All -PassThru

    AddToReadme @"
# $($ThisModule.Name)
$($ThisModule.Description)
"@
    # Get all functions defined in the module
    $Functions | ForEach-Object {

        # Get the function details
        $functionDetails = Get-Help -Name $_.Name -Full
        # $functionDetails | Select-String -Property Name, Synopsis, Syntax, Description, Parameters, Examples, Notes
        # Append the function details to the README.md content
        $functionDetailsFormatted = @{
            Name        = $functionDetails.Name
            Synopsis    = $functionDetails.Synopsis
            Syntax      = $functionDetails.Syntax | ForEach-Object {$_} | Out-String
            Description = $functionDetails.Description.Text
            Parameters  = $functionDetails.Parameters | ForEach-Object {$_} | Out-String
            Examples    = $functionDetails.Examples | ForEach-Object {$_} | Out-String
            Notes       = $functionDetails.Notes
        }

        Write-Output "Processing function: $($_.Name)"
        Write-Output "Help content found: $(if($functionDetails.Synopsis){$true}else{$false})"
        AddToReadme @"

## $($functionDetailsFormatted.Name)

### Synopsis
$($functionDetailsFormatted.Synopsis)

### Description
$($functionDetailsFormatted.Description)

### Syntax
``````ps1
$($functionDetailsFormatted.Syntax)
``````

### Parameters
$($functionDetailsFormatted.Parameters)

### Examples
``````powershell
$($functionDetailsFormatted.Examples)
``````

### Notes
``````powershell
$($functionDetailsFormatted.Notes)
``````


"@

    }

    # Remove the imported module
    Write-Output "Remove-Module ${ThisModule}"
    Remove-Module $ThisModule.Name


# Add a separator between modules
AddToReadme "---`n"
}