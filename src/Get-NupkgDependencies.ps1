Function Get-NupkgDependencies
{
    <#
    .SYNOPSIS
    Downloads a NUPKG and dependencies a feed using nuget.exe
    .DESCRIPTION
    Using parameters specified, calls nuget.exe to download the specified package as well as all of its dependencies from nuget sources or the specified -Source parameter

    .EXAMPLE
    PS> Get-NupkgDependencies fooPackage 
    Downloads the latest release version of fooPackage to the current directory.  Will use only sources configured in nuget.exe.  Will ignore pre-release versions.

    .EXAMPLE
    PS> Get-NupkgDependencies -PackageId fooPackage -Version 1.2.3-beta0001 -PreRelease -OutputDirectory c:\temp\install -Source "https://community.chocolatey.org/api/v2/"
    Downloads fooPackage version 1.2.3-beta0001 (a prerelease version), and all of its dependencies (pre-release or otherwise) to directory c:\temp\install using *only* the source "https://community.chocolatey.org/api/v2/"

    .LINK
    https://github.com/rossobianero/NupkgDownloader

    .LINK
    https://community.chocolatey.org/packages/NuGet.CommandLine

    #>    
    Param(
        [Parameter(Mandatory=$true, Position=0)] [string]
        # The package id (i.e. name) to download (along with its dependencies) from the feed 
        $PackageId,

        [string]
        # The output directory to download to (default: current directory)
        $OutputDirectory=$pwd,

        [string]
        # The version of the package to download (default: get latest released version)
        $Version,

        [switch]
        # If set, allow pre-release (beta, alpha, etc.) packages to be found (default: false)
        $Prerelease,

        [string]
        # Specify a specific source (feed) for nuget to search (default: use any sources configured in nuget already)
        $Source=$null,

        [string]
        [ValidateSet('normal', 'quiet', 'detailed')]
        # Verbosity under which nuget will execute (default: quiet)
        $Verbosity="quiet"
    )

    $tempDirectory = New-TemporaryDirectory
    $watcherObject = Add-DirectoryWatch -Path $($tempDirectory.FullName)

    try {
        $startParams = @{
            FilePath = 'nuget.exe'
            ArgumentList = @(
                "install $PackageId",
                " -OutputDirectory ""$($tempDirectory.FullName)""",
                #" -DirectDownload",
                " -NoCache",
                " -Verbosity $Verbosity"
            )
        }
        if($Version) {
            $startParams.ArgumentList += " -Version $Version"
        }
        if($Prerelease) {
            $startParams.ArgumentList += " -Prerelease"
        }
        if($Source) {
            $startParams.ArgumentList += " -Source $Source"
        }

        $startParams.NoNewWindow=$true
        $startParams.PassThru=$true

        Write-Host "Starting download..."
        $process = Start-Process @startParams 

        while(-not $process.WaitForExit(10)) {
            # wait
        }

        Write-Host "Copying to '$OutputDirectory'..."

        if(-not (Test-Path($OutputDirectory))) {
            New-Item $OutputDirectory -ItemType Directory -Force 
        }

        $nupkgs = Get-ChildItem -Recurse -Path $($tempDirectory.FullName) -Include *.nupkg 
        $nupkgs | ForEach-Object { 
            Copy-Item -Path $_.FullName -Destination $OutputDirectory 
        }
    }
    finally {
        if($null -ne $watcherObject) {
            Remove-DirectoryWatch -WatcherObject $watcherObject
        }
        if(Test-Path($tempDirectory.FullName)) {
            Write-Host "Removing $($tempDirectory.FullName).."
            Remove-Item -Force -Recurse -Path $($tempDirectory.FullName)
        }
    }
    Write-Host "Done."
}