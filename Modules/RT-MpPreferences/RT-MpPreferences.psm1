# Will be used to exclude folders from Microsoft Defender Antivirus
# And other things you can do with MpPreferences


# ======================================================================= #
#                          Add-RemoteMpPreference                         #
# ======================================================================= #
# FUNCTION: Add-RemoteMpPreference
function Add-RemoteMpPreference {
    <#
    .SYNOPSIS
    Adds an exclusion to Microsoft Defender Antivirus on a remote computer.

    .DESCRIPTION
    The Add-RemoteMpPreference function connects to a remote computer specified by the Host parameter and adds an exclusion to Microsoft Defender Antivirus. The exclusion can be a file, folder, file extension, or process. The exclusion type is specified by the Type parameter.

    .PARAMETER Hosts
    The name of the remote computer to which the exclusion will be added. This parameter is mandatory.

    .PARAMETER Type
    The type of exclusion to be added. This parameter is mandatory and can be one of the following values: File, Folder, Extension, Process.

    .PARAMETER Path
    The path to the file, folder, or process to be excluded. This parameter is mandatory.

    .EXAMPLE
    PS> Add-RemoteMpPreference -Hosts "Server01" -Type "Folder" -Path "C:\Temp"
    This example adds the folder "C:\Temp" to the exclusions list on the remote computer "Server01".

    .EXAMPLE
    PS> Add-RemoteMpPreference -Hosts "Server02" -Type "Extension" -Path ".log"
    This example adds the file extension ".log" to the exclusions list on the remote computer "Server02".
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Hosts,

        [Parameter(Mandatory=$true)]
        [ValidateSet("File", "Folder", "Extension", "Process")]
        [string]$Type,

        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    $remoteCommands = {
        param ($Type, $Path)
        Add-MpPreference -ExclusionPath $Path -ExclusionType $Type
    }
    $output = Invoke-Command -ComputerName $Hosts -ScriptBlock $remoteCommands -ArgumentList $Type, $Path
    Write-Output "> Add-MpPreference for $Hosts - Type: $Type - Path: $Path"
    Write-Output "$($output | Out-String)"
}