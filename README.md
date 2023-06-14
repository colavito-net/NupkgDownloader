# Introduction 

This repository contains a Powershell module that downloads nuget (and chocolatey) packages as nupkg files from a feed including their dependencies

# Chocolatey Installation

```
choco install NupkgDownloader
```

# Powershell module import
```
Import-Module NupkgDownlaoder
```

# Usage

Once installed and imported, run the command as follows (e.g. this will download fooPackage version 1.2.3 from the chocolatey community feed to c:\temp\install, along with all of its dependencies):

```
Get-NupkgDependencies fooPackage -Version 1.2.3 -OutputDirectory c:\temp\install -Source "https://community.chocolatey.org/api/v2/"
```

