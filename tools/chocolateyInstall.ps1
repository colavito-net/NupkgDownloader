
$ErrorActionPreference = 'Stop';
function Install-To {
    Param([string] $target)

    $PackageDir = Split-Path -Parent $PSScriptRoot
    $ModuleDir = Join-Path $target "NupkgDownloader"
    
    New-Item $ModuleDir/src -ItemType Directory -Force 
    Copy-Item $PackageDir/src/* $ModuleDir/src
    Copy-Item $PackageDir/NupkgDownloader.ps* $ModuleDir
}

$WindowsPowershellAllUsers = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\Modules"
$WindowsPwshAllUsers = "$env:PROGRAMFILES\PowerShell\Modules"

if ( $(Get-Command -ErrorAction SilentlyContinue pwsh )) { 
    Install-To $WindowsPwshAllUsers
}

Install-To $WindowsPowershellAllUsers
