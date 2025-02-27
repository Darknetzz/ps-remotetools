$CurrentScriptName = $MyInvocation.MyCommand.Name
$CurrentScriptPath = $MyInvocation.MyCommand.Path
$CurrentScriptDir  = Split-Path -Path $CurrentScriptPath -Parent
$CurrentScriptFile = Split-Path -Path $CurrentScriptPath -Leaf
$isDotSourced      = $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq ''

# List files in the Modules directory
$Modules = Get-ChildItem -Path "$CurrentScriptDir\Modules" -Filter *.psm1
Write-Output $($CurrentScriptDir)
Write-Output "Remote Tools"
Write-Output "============"

# Import all modules in the Modules directory
foreach ($Module in $Modules) {

    $ThisName     = $Module.BaseName
    $ThisFile     = $Module.Name
    $ThisPath     = $Module.FullName

    # Update-Help $Module
    # Get-Help $ThisName -Full
    # exit
    Write-Output "- ModuleName: ${ThisName}"
    Write-Output "- ModuleFile: ${ThisFile}"
    Write-Output "- ModulePath: ${ThisPath}"
    Write-Output ""
    Import-Module -Name $ThisPath
    Get-Module -Name $ThisName
    exit
    Get-Command -Module $Module.Value.Name | ForEach-Object {
        Write-Output "> $_.Name"
        Get-Help -Name $_.Name -Full | Format-List -Property Name, Synopsis
    }

    Write-Output ""
}