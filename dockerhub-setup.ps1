# Docker Hub Setup and Operations Script
Write-Host "🐳 Docker Hub Setup and Operations" -ForegroundColor Blue
Write-Host "===================================" -ForegroundColor Blue

# Check if Docker is available
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Docker is not installed. Please install Docker Desktop first:" -ForegroundColor Red
    Write-Host "   Download from: https://www.docker.com/products/docker-desktop/" -ForegroundColor Yellow
    exit 1
}

# Check Docker status
Write-Host "🔍 Checking Docker status..." -ForegroundColor Yellow
try {
    $dockerInfo = docker info 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Docker is running" -ForegroundColor Green
    } else {
        Write-Host "❌ Docker is not running. Please start Docker Desktop." -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Docker is not running. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# Function to login to Docker Hub
function Login-DockerHub {
    Write-Host "🔐 Docker Hub Login" -ForegroundColor Yellow
    Write-Host "===================" -ForegroundColor Yellow
    
    $username = Read-Host "Enter your Docker Hub username"
    $password = Read-Host "Enter your Docker Hub password/token" -AsSecureString
    
    # Convert secure string to plain text
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    
    Write-Host "🔄 Logging in to Docker Hub..." -ForegroundColor Yellow
    echo $plainPassword | docker login -u $username --password-stdin
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Successfully logged in to Docker Hub" -ForegroundColor Green
        return $username
    } else {
        Write-Host "❌ Failed to login to Docker Hub" -ForegroundColor Red
        return $null
    }
}

# Function to build and tag images
function Build-DockerImages {
    param($username)
    
    Write-Host "🔨 Building Docker Images" -ForegroundColor Yellow
    Write-Host "=========================" -ForegroundColor Yellow
    
    # Build Go App image
    Write-Host "📦 Building Go App image..." -ForegroundColor Cyan
    docker build -t $username/go-app:latest .
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Go App image built successfully" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to build Go App image" -ForegroundColor Red
        return $false
    }
    
    # Build Monitoring Stack image
    Write-Host "📊 Building Monitoring Stack image..." -ForegroundColor Cyan
    docker build -f monitoring/Dockerfile.monitoring -t $username/go-app-monitoring:latest monitoring/
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Monitoring Stack image built successfully" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to build Monitoring Stack image" -ForegroundColor Red
        return $false
    }
    
    return $true
}

# Function to push images to Docker Hub
function Push-DockerImages {
    param($username)
    
    Write-Host "🚀 Pushing Images to Docker Hub" -ForegroundColor Yellow
    Write-Host "=================================" -ForegroundColor Yellow
    
    # Push Go App image
    Write-Host "📤 Pushing Go App image..." -ForegroundColor Cyan
    docker push $username/go-app:latest
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Go App image pushed successfully" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to push Go App image" -ForegroundColor Red
        return $false
    }
    
    # Push Monitoring Stack image
    Write-Host "📤 Pushing Monitoring Stack image..." -ForegroundColor Cyan
    docker push $username/go-app-monitoring:latest
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Monitoring Stack image pushed successfully" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to push Monitoring Stack image" -ForegroundColor Red
        return $false
    }
    
    return $true
}

# Main execution
Write-Host ""
Write-Host "🎯 Choose an option:" -ForegroundColor Green
Write-Host "1. 🔐 Login to Docker Hub" -ForegroundColor White
Write-Host "2. 🔨 Build Docker Images" -ForegroundColor White
Write-Host "3. 🚀 Push Images to Docker Hub" -ForegroundColor White
Write-Host "4. 🔄 Complete Build and Push" -ForegroundColor White
Write-Host "5. 📋 List Local Images" -ForegroundColor White
Write-Host "6. 🗑️ Clean Up Images" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter your choice (1-6)"

switch ($choice) {
    "1" {
        $username = Login-DockerHub
        if ($username) {
            Write-Host "💾 Username saved: $username" -ForegroundColor Green
        }
    }
    "2" {
        $username = Read-Host "Enter your Docker Hub username"
        Build-DockerImages -username $username
    }
    "3" {
        $username = Read-Host "Enter your Docker Hub username"
        Push-DockerImages -username $username
    }
    "4" {
        $username = Login-DockerHub
        if ($username) {
            if (Build-DockerImages -username $username) {
                Push-DockerImages -username $username
            }
        }
    }
    "5" {
        Write-Host "📋 Local Docker Images:" -ForegroundColor Cyan
        docker images | findstr "go-app"
    }
    "6" {
        Write-Host "🗑️ Cleaning up images..." -ForegroundColor Yellow
        docker rmi $(docker images -q go-app*) 2>$null
        Write-Host "✅ Cleanup completed" -ForegroundColor Green
    }
    default {
        Write-Host "❌ Invalid choice. Please run the script again." -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "🎉 Docker Hub operations completed!" -ForegroundColor Green
Write-Host "📚 Next: Run .\git-setup-complete.ps1 to setup Git and push to GitHub" -ForegroundColor Cyan 