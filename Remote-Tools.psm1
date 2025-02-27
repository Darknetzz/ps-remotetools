# Get the list of files in the 'Modules' folder
$moduleFiles = Get-ChildItem -Path "Modules" -File

# Iterate through each file in the 'Modules' folder
foreach ($file in $moduleFiles) {
    # Perform actions on each file
    Write-Output "Processing file: $($file.FullName)"
    Import-Module -Name $file.FullName
    Export-Module -Name $file.FullName
}