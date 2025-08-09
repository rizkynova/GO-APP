# PowerShell Script to Start Monitoring Stack
Write-Host "Starting Monitoring Stack..." -ForegroundColor Green

# Check if Docker is running
try {
    $dockerInfo = docker info
    Write-Host "Docker is running." -ForegroundColor Green
} catch {
    Write-Host "Docker is not running. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# Navigate to monitoring directory
Set-Location $PSScriptRoot

# Start monitoring stack
Write-Host "Starting Prometheus, Grafana, and Alertmanager..." -ForegroundColor Yellow
docker-compose -f docker-compose.monitoring.yml up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "Monitoring stack started successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Services available at:" -ForegroundColor Cyan
    Write-Host "  Prometheus: http://localhost:9090" -ForegroundColor White
    Write-Host "  Grafana:    http://localhost:3000 (admin/admin)" -ForegroundColor White
    Write-Host "  Alertmanager: http://localhost:9093" -ForegroundColor White
    Write-Host ""
    Write-Host "To stop the monitoring stack:" -ForegroundColor Yellow
    Write-Host "  docker-compose -f docker-compose.monitoring.yml down" -ForegroundColor White
} else {
    Write-Host "Failed to start monitoring stack!" -ForegroundColor Red
    exit 1
} 