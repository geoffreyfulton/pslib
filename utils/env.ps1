<#
    PowerShell: Environment Variables
    =================================

    **PowerShell** has special heirarchal data-stores known as 'Providers'.
    The data within Providers are presented in a consistent format resembling
    a file system drive.
    
    `MSDN: About Providers <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-6>_

#>

# Get-PSProvider -PSProvider Environment

<#

    The *Environment* provider has a drive called Env which exposes all
    envars on a Windows system.

    Name                 Capabilities                   Drives                       
    ----                 ------------                   ------                       
    Environment          ShouldProcess                  {Env}                        
#>

# Enumerate all user envars
#Get-ChildItem -Path Env:\

<#
    PS C:\> Get-ChildItem -Path Env:\

    Name                           Value                                             
    ----                           -----                                             
    ALLUSERSPROFILE                C:\ProgramData                                    
    APPDATA                        C:\Users\admin\AppData\Roaming                    
    CommonProgramFiles             C:\Program Files\Common Files                     
    CommonProgramFiles(x86)        C:\Program Files (x86)\Common Files               
    CommonProgramW6432             C:\Program Files\Common Files                     
    ...
#>

function Get-Envar {
    Param([String]$name)

    $prevlocation = Get-Location
    Set-Location -Path Env:\

    Get-ChildItem -Path $name

    Set-Location $prevlocation
}

Get-Envar "COMPUTERNAME"

<#
    PS C:\dev\code\ps> C:\dev\code\ps\env.ps1

    Name                           Value                                             
    ----                           -----                                             
    COMPUTERNAME                   DESKTOP-######
#>

<#
    Using $env
    ==========

    The ```$env``` variable can be used as a shortcut when working
    with envars.
#>

Write-Output ""
Write-Output "`$COMPUTERNAME=$env:COMPUTERNAME"

Write-Output ""
Write-Output "`$PATH=$env:PATH"

<#
    Modifying Envars
    ================

    Using .NET we can harness the [System.Environment] object's static method
    GetEnvironmentVariable([String]) to view the PATH.

    Machine, Process, and User are the typical scopes in which individual sets
    of envars exist.
#>
Write-Output ""
Write-Output "User `$PATH"
[System.Environment]::GetEnvironmentVariable('PATH')

<#
    By providing the second argument we can set the scope to 'machine', in
    order to view the SYSTEM envars.
#>
Write-Output ""
Write-Output "SYSTEM `$PATH"
[System.Environment]::GetEnvironmentVariable('PATH', 'machine')

<#
    Setting Envars
    ==============
    Using the SetEnvironmentVariable() method on the [System.Environment]
    object we can create persistent envars!
    
#>
[System.Environment]::SetEnvironmentVariable('FOO', 'bar',[System.EnvironmentVariableTarget]::Machine)

