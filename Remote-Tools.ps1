$CurrentScriptName = $MyInvocation.MyCommand.Name
$CurrentScriptPath = $MyInvocation.MyCommand.Path
$CurrentScriptDir  = Split-Path -Path $CurrentScriptPath -Parent
$CurrentScriptFile = Split-Path -Path $CurrentScriptPath -Leaf
$isDotSourced      = $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq ''

$Modules = @{
    "RT-GroupMembers" = @{
        "Name" = ($Name = "RT-GroupMembers")
        "Path" = ($Path = "$CurrentScriptDir\Modules\$Name.psm1")
        "File" = ($File = Split-Path -Path $Path -Leaf)
    }
    "RT-Files" = @{
        "Name" = ($Name = "RT-Files")
        "Path" = ($Path = "$CurrentScriptDir\Modules\$Name.psm1")
        "File" = ($File = Split-Path -Path $Path -Leaf)
    }
}


# ======================================================================= #
#                                   MAIN                                  #
# ======================================================================= #
Write-Output "Remote Tools"
Write-Output "============"

foreach ($Module in $Modules.GetEnumerator()) {
    if (-not (Get-Module -ListAvailable -Name $Module.Value.Name)) {
        Import-Module -Name $Module.Value.Path
        Write-Output "# $($Module.Value.File)"
        Get-Command -Module $Module.Value.Name | ForEach-Object {
            Get-Help -Name $_.Name -Full | Format-List -Property Name, Synopsis
        }
        Write-Output ""
    }
}