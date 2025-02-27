# ps-remotetools

Helpful functions to execute commands on remote hosts using `PSRemote` and `Invoke-Command`.


## Usage

### Importing all modules
```ps1
# Source or run Remote-Tools.ps1
"PS> .\Remote-Tools.ps1"
```

### Importing a single module
```ps1
Import-Module "Modules\RT-<module>.psm1"
```

## Module Documentation
For detailed module documentation, please refer to [MODULES.md](MODULES.md).

<!--
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
-->