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
**Last updated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ii")**


This repository contains a collection of PowerShell modules that provide functions for managing remote computers.


"@

foreach ($Module in $ModuleFiles) {

Write-Output "Module.BaseName $($Module.BaseName)"
Write-Output "Module.FullName $($Module.FullName)"
Write-Output "Module.DirectoryName $($Module.DirectoryName)"

$ThisModule = Import-Module $Module.FullName -Force -PassThru
$Functions = Get-Command -Module $ThisModule -CommandType Function -PassThru

AddToReadme @"
## Module: $($ThisModule.Name)
"@

    # Get all functions defined in the module
    foreach ($function in $functions) {
        # Get the function details
        $functionDetails = Get-Help $function.Name -Full

        # Append the function details to the README.md content
        AddToReadme @"

### $($functionDetails.Name)

* __Synopsis__
``````ps1
$($functionDetails.Synopsis)
``````

* __Syntax__
``````ps1
$($functionDetails.Syntax | Out-String)
``````

* __Description__
``````ps1
$($functionDetails.Description)
``````

* __Parameters__
``````ps1
$($functionDetails.Parameters | ForEach-Object {
    "`n### $($_.Name)`n$($_.Description)"
} | Out-String)
``````

* __Examples__
``````ps1
$($functionDetails.Examples | ForEach-Object {
    "`n### Example $($_.Name)`n$($_.Code)"
} | Out-String)
``````

* __Notes__
``````ps1
$($functionDetails.Notes)
``````

Functiondetails
``````ps1
$($functionDetails)
``````

"@
    }

    # Remove the imported module
    Write-Output "Remove-Module ${ThisModule}"
    Remove-Module $ThisModule.Name

    # Add a separator between modules
    AddToReadme "---`n"
}