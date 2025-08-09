# Complete Git Setup and Push Script for Go App with Monitoring
Write-Host "🚀 Complete Git Setup for Go App with Monitoring" -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Green

# Check if Git is available
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git is not installed. Please install Git first:" -ForegroundColor Red
    Write-Host "   Download from: https://git-scm.com/" -ForegroundColor Yellow
    exit 1
}

# Check if we're in a Git repository
if (-not (Test-Path ".git")) {
    Write-Host "📁 Initializing Git repository..." -ForegroundColor Yellow
    git init
} else {
    Write-Host "✅ Git repository already exists" -ForegroundColor Green
}

# Add all files
Write-Host "📝 Adding files to Git..." -ForegroundColor Yellow
git add .

# Check status
Write-Host "📊 Git status:" -ForegroundColor Cyan
git status

# Create initial commit
Write-Host "💾 Creating initial commit..." -ForegroundColor Yellow
git commit -m "🚀 Initial commit: Go App with CI/CD and Monitoring Stack

✨ Features:
- Go application with Gin framework
- Prometheus metrics endpoint
- Docker multi-stage build
- GitHub Actions CI/CD pipeline
- Monitoring stack (Prometheus, Grafana, Alertmanager)
- Production deployment ready
- Kubernetes manifests included"

Write-Host "✅ Initial commit created successfully!" -ForegroundColor Green

# Show commit history
Write-Host "📜 Commit history:" -ForegroundColor Cyan
git log --oneline -5

Write-Host ""
Write-Host "🎯 Next Steps:" -ForegroundColor Green
Write-Host "=============" -ForegroundColor Green
Write-Host ""
Write-Host "1. 🔗 Create GitHub Repository:" -ForegroundColor Yellow
Write-Host "   - Go to https://github.com/new" -ForegroundColor White
Write-Host "   - Name: go-app (or your preferred name)" -ForegroundColor White
Write-Host "   - Make it public or private as needed" -ForegroundColor White
Write-Host ""
Write-Host "2. 🔑 Add Remote Origin:" -ForegroundColor Yellow
Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/go-app.git" -ForegroundColor White
Write-Host ""
Write-Host "3. 🚀 Push to GitHub:" -ForegroundColor Yellow
Write-Host "   git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "4. ⚙️ Setup GitHub Secrets:" -ForegroundColor Yellow
Write-Host "   - Go to Repository Settings > Secrets and variables > Actions" -ForegroundColor White
Write-Host "   - Add DOCKERHUB_USERNAME and DOCKERHUB_TOKEN" -ForegroundColor White
Write-Host ""
Write-Host "5. 🔄 CI/CD will automatically:" -ForegroundColor Yellow
Write-Host "   - Build Go app Docker image" -ForegroundColor White
Write-Host "   - Build monitoring stack Docker image" -ForegroundColor White
Write-Host "   - Push both to Docker Hub" -ForegroundColor White
Write-Host "   - Deploy monitoring stack" -ForegroundColor White
Write-Host ""
Write-Host "📚 Available Commands:" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host "  .\run.ps1              - Run Go application locally" -ForegroundColor White
Write-Host "  .\docker-setup.ps1     - Docker operations" -ForegroundColor White
Write-Host "  .\deploy.ps1           - Deploy application" -ForegroundColor White
Write-Host "  .\monitoring.ps1       - Monitor application" -ForegroundColor White
Write-Host "  .\start-monitoring.ps1 - Start monitoring stack" -ForegroundColor White
Write-Host ""
Write-Host "🎉 Your Go App is ready for Git and Docker Hub!" -ForegroundColor Green 