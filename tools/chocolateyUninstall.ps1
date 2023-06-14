. $PSScriptRoot/Definitions.ps1

$ErrorActionPreference = 'SilentlyContinue'

$WindowsPowershellModuleDir = Join-Path $WindowsPowershellAllUsers "NupkgDownloader"
$WindowsPwshModuleDir = Join-Path $WindowsPwshAllUsers "NupkgDownloader"

Remove-Module NupkgDownloader

if(test-path($WindowsPowershellModuleDir)) {
    Remove-Item $WindowsPowershellModuleDir -Recurse
}
if(test-path($WindowsPwshModuleDir)) {
    Remove-Item $WindowsPwshModuleDir -Recurse
}
