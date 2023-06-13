
$ErrorActionPreference = 'SilentlyContinue'
$_PSModulePath = Join-Path $PSHOME "Modules"
$AllUsersModuleDir = Join-Path $_PSModulePath "NupkgDownloader"

Remove-Module NupkgDownloader
echo "Remove $allUsersModuleDir"
Remove-Item $AllUsersModuleDir -Recurse
