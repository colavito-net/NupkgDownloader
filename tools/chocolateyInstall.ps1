. $PSScriptRoot/Definitions.ps1

$ErrorActionPreference = 'Stop';
function Install-To {
    Param([string] $target)

    $PackageDir = Split-Path -Parent $PSScriptRoot
    $ModuleDir = Join-Path $target "NupkgDownloader"
    
    New-Item $ModuleDir/src -ItemType Directory -Force | Out-Null
    Copy-Item $PackageDir/src/* $ModuleDir/src
    Copy-Item $PackageDir/NupkgDownloader.ps* $ModuleDir
}

if ( $(Get-Command -ErrorAction SilentlyContinue pwsh)) { 
    Install-To $WindowsPwshAllUsers
}

Install-To $WindowsPowershellAllUsers
