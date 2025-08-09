# Simple Git Setup Script
Write-Host "Setting up Git repository..." -ForegroundColor Green

# Check if Git is available
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git is not installed. Please install Git first." -ForegroundColor Red
    exit 1
}

# Check if we're in a Git repository
if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init
} else {
    Write-Host "Git repository already exists" -ForegroundColor Green
}

# Add all files
Write-Host "Adding files to Git..." -ForegroundColor Yellow
git add .

# Check status
Write-Host "Git status:" -ForegroundColor Cyan
git status

# Create initial commit
Write-Host "Creating initial commit..." -ForegroundColor Yellow
git commit -m "Initial commit: Go App with CI/CD and Monitoring Stack"

Write-Host "Initial commit created successfully!" -ForegroundColor Green

# Show commit history
Write-Host "Commit history:" -ForegroundColor Cyan
git log --oneline -3

Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Green
Write-Host "1. Create GitHub Repository at https://github.com/new" -ForegroundColor Yellow
Write-Host "2. Add remote: git remote add origin YOUR_REPO_URL" -ForegroundColor Yellow
Write-Host "3. Push: git push -u origin main" -ForegroundColor Yellow
Write-Host ""
Write-Host "Your Go App is ready for Git!" -ForegroundColor Green 