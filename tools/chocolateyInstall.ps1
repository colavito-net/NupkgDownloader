
$ErrorActionPreference = 'Stop';
$_PSModulePath = Join-Path $PSHOME "Modules"
$AllUsersModuleDir = Join-Path $_PSModulePath "NupkgDownloader"
$PackageDir = Split-Path -Parent $PSScriptRoot

New-Item $AllUsersModuleDir/src -ItemType Directory -Force 
Copy-Item $PackageDir/src/* $AllUsersModuleDir/src
Copy-Item $PackageDir/NupkgDownloader.ps* $AllUsersModuleDir
