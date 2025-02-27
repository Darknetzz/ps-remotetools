# ps-remotetools

Helpful functions to execute commands on remote hosts using `PSRemote` and `Invoke-Command`.


## Usage


### Importing Remote-Tools
```ps1
# Imports Remote-Tools to current session
PS> .\Remote-Tools.ps1
```

### Installing Remote-Tools
Currently does not work!
```ps1
# Installs Remote-Tools
PS> .\Remote-Tools.ps1 -Install
```

### Importing a single module
```ps1
Import-Module "Modules\RT-<module>\RT-"
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