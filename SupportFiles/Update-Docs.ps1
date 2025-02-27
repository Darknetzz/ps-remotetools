$CurrentScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$ParentDir        = Split-Path -Path $CurrentScriptDir -Parent
$ModulesDir       = $ParentDir | Get-ChildItem -Recurse -Directory -Filter Modules
$ModuleFiles      = $ModulesDir | Get-ChildItem -Filter *.psm1 -Recurse
. $CurrentScriptDir\Variables.ps1

# Initialize the README.md content
$readmeContent = @"

# Remote-Tools
**Last updated: $(Get-Date -Format "yyyy-MM-dd")**


This repository contains a collection of PowerShell modules that provide functions for managing remote computers.


"@

foreach ($Module in $ModuleFiles) {

Write-Output "BaseName $($Module.BaseName)"
Write-Output "FullName $($Module.FullName)"
Write-Output "DirectoryName $($Module.DirectoryName)"

Import-Module $Module.FullName -Force
$ThisModule = Get-Module $Module.BaseName
$Functions  = $ThisModule | Get-Command -CommandType Function

$readmeContent += @"
## Module: $($ThisModule.Name)
"@

    # Get all functions defined in the module
    foreach ($function in $functions) {
        # Get the function details
        $functionDetails = Get-Help $function.Name -Full

        # Append the function details to the README.md content
        $readmeContent += @"

### `__Function:__ ``$($function.Name)``

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
    Remove-Module $ThisModule

    # Add a separator between modules
    $readmeContent += "---`n"
}

# Path to the README.md file
$readmePath = Join-Path -Path $parentDirectory -ChildPath "MODULES.md"

# Write the README.md file
$readmeContent | Out-File -FilePath $readmePath -Encoding utf8