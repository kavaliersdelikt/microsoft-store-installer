# Run as Administrator

# Check if script is running as Administrator
$currentUser = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as Administrator!" -ForegroundColor Red
    exit
}

# Download the Microsoft Store package
$storeUrl = "https://store.rg-adguard.net/api/GetFiles?type=ProductId&url=9wzdncrfjbmp&ring=Retail"
$downloadPath = "$env:TEMP\MicrosoftStorePackages"
New-Item -ItemType Directory -Path $downloadPath -Force | Out-Null

Write-Host "Fetching download links for Microsoft Store..." -ForegroundColor Yellow
$storePackages = Invoke-WebRequest -Uri $storeUrl -UseBasicParsing | Select-String -Pattern "https://.*?\.appx" | ForEach-Object { $_.Matches.Value }

# Filter and download required packages
$requiredPackages = $storePackages | Where-Object { $_ -match "Microsoft.WindowsStore|VCLibs|Framework|Net.Native" }

if ($requiredPackages.Count -eq 0) {
    Write-Host "Failed to fetch Microsoft Store packages. Check your internet connection." -ForegroundColor Red
    exit
}

Write-Host "Downloading Microsoft Store packages..." -ForegroundColor Yellow
foreach ($package in $requiredPackages) {
    $fileName = $package -split "/" | Select-Object -Last 1
    $filePath = "$downloadPath\$fileName"
    if (!(Test-Path $filePath)) {
        Invoke-WebRequest -Uri $package -OutFile $filePath
    }
}

# Install required dependencies
Write-Host "Installing dependencies..." -ForegroundColor Yellow
Get-ChildItem -Path $downloadPath -Filter "*.appx" | ForEach-Object { Add-AppxPackage -Path $_.FullName }

Write-Host "Microsoft Store installation completed!" -ForegroundColor Green
