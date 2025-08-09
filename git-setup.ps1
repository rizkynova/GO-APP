# PowerShell Git Setup Script for Go App
Write-Host "Setting up Git repository..." -ForegroundColor Green

# Check if Git is installed
try {
    $gitVersion = git --version
    Write-Host "Git is installed: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "Git is not installed. Please install Git from https://git-scm.com/" -ForegroundColor Red
    exit 1
}

# Initialize Git repository
if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init
} else {
    Write-Host "Git repository already exists." -ForegroundColor Yellow
}

# Add all files
Write-Host "Adding files to Git..." -ForegroundColor Yellow
git add .

# Initial commit
Write-Host "Creating initial commit..." -ForegroundColor Yellow
git commit -m "Initial commit: Go application with CI/CD setup"

Write-Host "Git setup completed!" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Create a new repository on GitHub" -ForegroundColor White
Write-Host "2. Add remote origin: git remote add origin <your-repo-url>" -ForegroundColor White
Write-Host "3. Push to GitHub: git push -u origin main" -ForegroundColor White
Write-Host "4. Add DOCKERHUB_USERNAME and DOCKERHUB_TOKEN secrets in GitHub" -ForegroundColor White 