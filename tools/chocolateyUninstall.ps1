
$ErrorActionPreference = 'SilentlyContinue'

$WindowsPowershellModuleDir = Join-Path "$env:SystemRoot\System32\WindowsPowerShell\v1.0\Modules" "NupkgDownloader"
$WindowsPwshModuleDir = Join-Path "$env:PROGRAMFILES\PowerShell\Modules" "NupkgDownloader"

Remove-Module NupkgDownloader

if(test-path($WindowsPowershellModuleDir)) {
    Remove-Item $WindowsPowershellModuleDir -Recurse
}
if(test-path($WindowsPwshModuleDir)) {
    Remove-Item $WindowsPwshModuleDir -Recurse
}
