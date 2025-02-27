# Path to the Modules directory
$currentDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$modulesPath      = "$currentDirectory\Modules"

# Get all module files in the Modules directory
$moduleFiles = Get-ChildItem -Path $modulesPath -Filter *.psm1

# Initialize the README.md content
$readmeContent = @"

# Remote-Tools
**Last updated: $(Get-Date -Format "yyyy-MM-dd")**


This repository contains a collection of PowerShell modules that provide functions for managing remote computers.


"@

foreach ($moduleFile in $moduleFiles) {
    # Import the module
    Import-Module $moduleFile.FullName -Force

    # Get all functions defined in the module
    $functions = Get-Command -Module $moduleFile.BaseName -CommandType Function

    $readmeContent += "## Module: $($moduleFile.BaseName)"

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
    Remove-Module $moduleFile.BaseName

    # Add a separator between modules
    $readmeContent += "---`n"
}

# Path to the README.md file
$readmePath = Join-Path -Path $currentDirectory -ChildPath "MODULES.md"

# Write the README.md file
$readmeContent | Out-File -FilePath $readmePath -Encoding utf8