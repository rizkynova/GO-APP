# PowerShell Setup Script for Go App
Write-Host "Setting up Go App..." -ForegroundColor Green

# Check if Go is installed
try {
    $goVersion = go version
    Write-Host "Go is installed: $goVersion" -ForegroundColor Green
} catch {
    Write-Host "Go is not installed. Please install Go from https://golang.org/dl/" -ForegroundColor Red
    Write-Host "After installing Go, run this script again." -ForegroundColor Yellow
    exit 1
}

# Download dependencies
Write-Host "Downloading Go dependencies..." -ForegroundColor Yellow
go mod download
go mod tidy

# Build the application
Write-Host "Building the application..." -ForegroundColor Yellow
go build -o go-app.exe .

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build successful!" -ForegroundColor Green
    Write-Host "You can now run: .\go-app.exe" -ForegroundColor Cyan
} else {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Setup completed successfully!" -ForegroundColor Green 