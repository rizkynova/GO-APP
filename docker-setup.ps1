# PowerShell Docker Setup Script for Go App
Write-Host "Setting up Docker for Go App..." -ForegroundColor Green

# Check if Docker is installed
try {
    $dockerVersion = docker --version
    Write-Host "Docker is installed: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "Docker is not installed. Please install Docker Desktop from https://www.docker.com/products/docker-desktop/" -ForegroundColor Red
    exit 1
}

# Check if Docker is running
try {
    $dockerInfo = docker info
    Write-Host "Docker is running." -ForegroundColor Green
} catch {
    Write-Host "Docker is not running. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# Build Docker image
Write-Host "Building Docker image..." -ForegroundColor Yellow
docker build -t go-app .

if ($LASTEXITCODE -eq 0) {
    Write-Host "Docker image built successfully!" -ForegroundColor Green
    Write-Host "Image name: go-app" -ForegroundColor Cyan
    
    # Show available commands
    Write-Host "`nAvailable Docker commands:" -ForegroundColor Yellow
    Write-Host "Run container: docker run -p 8080:8080 go-app" -ForegroundColor White
    Write-Host "Run with docker-compose: docker-compose up -d" -ForegroundColor White
    Write-Host "Stop with docker-compose: docker-compose down" -ForegroundColor White
    Write-Host "View logs: docker-compose logs -f go-app" -ForegroundColor White
} else {
    Write-Host "Docker build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "`nDocker setup completed successfully!" -ForegroundColor Green 