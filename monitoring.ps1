# PowerShell Monitoring Script for Go App
Write-Host "Monitoring Go App..." -ForegroundColor Green

# Function to check application health
function Test-AppHealth {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8080/health" -UseBasicParsing -TimeoutSec 5
        if ($response.StatusCode -eq 200) {
            Write-Host "✓ Application is healthy" -ForegroundColor Green
            return $true
        } else {
            Write-Host "✗ Application health check failed with status: $($response.StatusCode)" -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "✗ Cannot connect to application" -ForegroundColor Red
        return $false
    }
}

# Function to check container status
function Test-ContainerStatus {
    try {
        $containers = docker ps --filter "name=go-app" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
        if ($containers -and $containers.Length -gt 1) {
            Write-Host "✓ Container is running:" -ForegroundColor Green
            Write-Host $containers -ForegroundColor White
            return $true
        } else {
            Write-Host "✗ Container is not running" -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "✗ Cannot check container status" -ForegroundColor Red
        return $false
    }
}

# Function to check application info
function Get-AppInfo {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8080/api/info" -UseBasicParsing -TimeoutSec 5
        if ($response.StatusCode -eq 200) {
            $info = $response.Content | ConvertFrom-Json
            Write-Host "✓ Application Info:" -ForegroundColor Green
            Write-Host "  Name: $($info.app_name)" -ForegroundColor White
            Write-Host "  Description: $($info.description)" -ForegroundColor White
            Write-Host "  Features: $($info.features -join ', ')" -ForegroundColor White
        }
    } catch {
        Write-Host "✗ Cannot get application info" -ForegroundColor Red
    }
}

# Main monitoring loop
Write-Host "Starting monitoring... Press Ctrl+C to stop" -ForegroundColor Yellow
Write-Host ""

while ($true) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] Checking application status..." -ForegroundColor Cyan
    
    $healthOk = Test-AppHealth
    $containerOk = Test-ContainerStatus
    
    if ($healthOk -and $containerOk) {
        Get-AppInfo
        Write-Host "✓ All systems operational" -ForegroundColor Green
    } else {
        Write-Host "✗ Issues detected" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "Waiting 30 seconds before next check..." -ForegroundColor Yellow
    Start-Sleep -Seconds 30
} 