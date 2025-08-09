# PowerShell Deployment Script for Go App
param(
    [string]$Environment = "development",
    [string]$Tag = "latest"
)

Write-Host "Deploying Go App to $Environment environment..." -ForegroundColor Green

# Check if Docker is running
try {
    $dockerInfo = docker info
    Write-Host "Docker is running." -ForegroundColor Green
} catch {
    Write-Host "Docker is not running. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# Build Docker image with tag
Write-Host "Building Docker image with tag: $Tag..." -ForegroundColor Yellow
docker build -t go-app:$Tag .

if ($LASTEXITCODE -eq 0) {
    Write-Host "Docker image built successfully!" -ForegroundColor Green
} else {
    Write-Host "Docker build failed!" -ForegroundColor Red
    exit 1
}

# Stop existing containers
Write-Host "Stopping existing containers..." -ForegroundColor Yellow
docker-compose down

# Start new deployment
Write-Host "Starting new deployment..." -ForegroundColor Yellow
docker-compose up -d

# Wait for health check
Write-Host "Waiting for health check..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Check if application is running
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080/health" -UseBasicParsing
    if ($response.StatusCode -eq 200) {
        Write-Host "Deployment successful! Application is healthy." -ForegroundColor Green
        Write-Host "Application URL: http://localhost:8080" -ForegroundColor Cyan
    } else {
        Write-Host "Deployment failed! Health check returned status: $($response.StatusCode)" -ForegroundColor Red
    }
} catch {
    Write-Host "Deployment failed! Cannot connect to application." -ForegroundColor Red
    Write-Host "Checking logs..." -ForegroundColor Yellow
    docker-compose logs go-app
    exit 1
}

Write-Host "Deployment completed successfully!" -ForegroundColor Green 