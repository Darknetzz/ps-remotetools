# Remote-Tools


## Usage

```ps1

# Source or run Remote-Tools.ps1
. ".\Remote-Tools.ps1"

# Alternatively source a module
Import-Module "Modules\RT-<module>.psm1"

```

## Variables
* $CurrentScriptName 
    > $MyInvocation.MyCommand.Name
* $CurrentScriptPath 
    > $MyInvocation.MyCommand.Path
* $CurrentScriptDir  
    > Split-Path -Path $CurrentScriptPath -Parent
* $CurrentScriptFile 
    > Split-Path -Path $CurrentScriptPath -Leaf
* $isDotSourced
    > $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq ''

## Modules
* RT-Files.psm1
  * Unblock-Files
* RT-GroupMembers
  * Get-GroupMembers
  * Add-GroupMembers
  * Remove-GroupMembers