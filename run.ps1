# PowerShell Run Script for Go App
Write-Host "Starting Go App..." -ForegroundColor Green

# Check if executable exists
if (Test-Path "go-app.exe") {
    Write-Host "Found go-app.exe, starting application..." -ForegroundColor Yellow
    Write-Host "Application will be available at: http://localhost:8080" -ForegroundColor Cyan
    Write-Host "Press Ctrl+C to stop the application" -ForegroundColor Yellow
    .\go-app.exe
} else {
    Write-Host "go-app.exe not found. Please run setup.ps1 first." -ForegroundColor Red
    exit 1
} 