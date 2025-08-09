# Production Deployment Script for Go App
param(
    [string]$Environment = "production",
    [string]$Tag = "latest",
    [string]$Registry = "docker.io",
    [string]$ImageName = "your-username/go-app"
)

Write-Host "Production Deployment for Go App" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green
Write-Host "Environment: $Environment" -ForegroundColor Cyan
Write-Host "Image: $Registry/$ImageName:$Tag" -ForegroundColor Cyan

# Check if Docker is running
try {
    $dockerInfo = docker info
    Write-Host "✓ Docker is running" -ForegroundColor Green
} catch {
    Write-Host "✗ Docker is not running. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# Check if docker-compose.prod.yml exists
if (-not (Test-Path "docker-compose.prod.yml")) {
    Write-Host "✗ Production docker-compose file not found!" -ForegroundColor Red
    exit 1
}

# Build and tag Docker image
Write-Host ""
Write-Host "Building and tagging Docker image..." -ForegroundColor Yellow
docker build -t $ImageName:$Tag .
docker tag $ImageName:$Tag $Registry/$ImageName:$Tag

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Docker image built and tagged successfully" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to build Docker image" -ForegroundColor Red
    exit 1
}

# Login to Docker registry (if needed)
Write-Host ""
Write-Host "Do you want to push to Docker registry? (y/n)" -ForegroundColor Yellow
$pushResponse = Read-Host

if ($pushResponse -eq "y" -or $pushResponse -eq "Y") {
    Write-Host "Logging in to Docker registry..." -ForegroundColor Yellow
    docker login $Registry
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Logged in to Docker registry" -ForegroundColor Green
        
        # Push image
        Write-Host "Pushing image to registry..." -ForegroundColor Yellow
        docker push $Registry/$ImageName:$Tag
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Image pushed successfully" -ForegroundColor Green
        } else {
            Write-Host "✗ Failed to push image" -ForegroundColor Red
        }
    } else {
        Write-Host "✗ Failed to login to Docker registry" -ForegroundColor Red
    }
}

# Deploy with production docker-compose
Write-Host ""
Write-Host "Deploying to production..." -ForegroundColor Yellow
docker-compose -f docker-compose.prod.yml down
docker-compose -f docker-compose.prod.yml up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Production deployment successful" -ForegroundColor Green
} else {
    Write-Host "✗ Production deployment failed" -ForegroundColor Red
    exit 1
}

# Wait for health check
Write-Host ""
Write-Host "Waiting for health check..." -ForegroundColor Yellow
Start-Sleep -Seconds 15

# Verify deployment
Write-Host ""
Write-Host "Verifying deployment..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost/health" -UseBasicParsing -TimeoutSec 10
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Production deployment verified successfully!" -ForegroundColor Green
        Write-Host "Application URL: http://localhost" -ForegroundColor Cyan
    } else {
        Write-Host "✗ Health check failed with status: $($response.StatusCode)" -ForegroundColor Red
    }
} catch {
    Write-Host "✗ Cannot connect to production application" -ForegroundColor Red
    Write-Host "Checking logs..." -ForegroundColor Yellow
    docker-compose -f docker-compose.prod.yml logs go-app
}

Write-Host ""
Write-Host "Production deployment completed!" -ForegroundColor Green
Write-Host "To view logs: docker-compose -f docker-compose.prod.yml logs -f" -ForegroundColor Cyan
Write-Host "To stop: docker-compose -f docker-compose.prod.yml down" -ForegroundColor Cyan 