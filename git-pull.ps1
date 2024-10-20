$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$directories = Get-ChildItem -Path $scriptDir -Directory

foreach ($dir in $directories) {
    Write-Host "Processing directory: $($dir.FullName)"

    Set-Location $dir.FullName

    try {
        git pull
        if ($LASTEXITCODE -eq 0) {
            Write-Host "git pull successful in $($dir.FullName)"
        } else {
            Write-Host "git pull failed in $($dir.FullName)"
        }
    } catch {
        Write-Host "An error occurred in $($dir.FullName): $_"
    }

    Set-Location $scriptDir
}

Write-Host "All directories processed."
