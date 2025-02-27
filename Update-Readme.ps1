# Path to the Modules directory
$currentDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$modulesPath      = "$currentDirectory\Modules"

# Get all module files in the Modules directory
$moduleFiles = Get-ChildItem -Path $modulesPath -Filter *.psm1

# Initialize the README.md content
$readmeContent = ""

foreach ($moduleFile in $moduleFiles) {
    # Import the module
    Import-Module $moduleFile.FullName -Force

    # Get all functions defined in the module
    $functions = Get-Command -Module $moduleFile.BaseName -CommandType Function

    $readmeContent += "# $($moduleFile.BaseName)"

    foreach ($function in $functions) {
        # Get the function details
        $functionDetails = Get-Help $function.Name

        # Append the function details to the README.md content
        $readmeContent += @"

## $($function.Name)

### Synopsis
``````ps1
$($functionDetails.Synopsis)
``````

### Syntax
``````ps1
$($functionDetails.Syntax | Out-String)
``````

### Description
$($functionDetails.Description)

### Parameters
$($functionDetails.Parameters | ForEach-Object {
    "`n### $($_.Name)`n$($_.Description)"
} | Out-String)

### Examples
$($functionDetails.Examples | ForEach-Object {
    "`n### Example $($_.Name)`n$($_.Code)"
} | Out-String)

### Notes
$($functionDetails.Notes)

"@
    }

    # Remove the imported module
    Remove-Module $moduleFile.BaseName
}

# Path to the README.md file
$readmePath = Join-Path -Path $currentDirectory -ChildPath "MODULES.md"

# Write the README.md file
$readmeContent | Out-File -FilePath $readmePath -Encoding utf8