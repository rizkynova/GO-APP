# 🚀 Go App with CI/CD and Monitoring Stack

A production-ready Go application with automated CI/CD pipeline, Docker containerization, and comprehensive monitoring using Prometheus, Grafana, and Alertmanager.

## ✨ Features

- **Go Application**: RESTful API with Gin framework
- **Prometheus Metrics**: Built-in metrics endpoint for monitoring
- **Docker Support**: Multi-stage Docker build for optimized images
- **CI/CD Pipeline**: GitHub Actions for automated testing and deployment
- **Monitoring Stack**: Prometheus, Grafana, and Alertmanager
- **Production Ready**: Kubernetes manifests and production deployment scripts
- **Health Checks**: Application and container health monitoring

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Go App       │    │   Prometheus    │    │   Grafana       │
│   (Port 8080)  │◄──►│   (Port 9090)   │◄──►│   (Port 3000)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       ▼                       │
         │              ┌─────────────────┐              │
         └──────────────►│  Alertmanager   │◄─────────────┘
                        │   (Port 9093)   │
                        └─────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- Go 1.23+
- Docker Desktop
- Git

### 1. Clone and Setup

```bash
git clone <your-repo-url>
cd GO-APP
```

### 2. Run Application

```powershell
# Using PowerShell scripts
.\run.ps1                    # Run Go app locally
.\docker-setup.ps1          # Docker operations
.\deploy.ps1                # Deploy with Docker Compose
```

### 3. Start Monitoring Stack

```powershell
cd monitoring
.\start-monitoring.ps1      # Start Prometheus, Grafana, Alertmanager
```

## 🔄 CI/CD Pipeline

### GitHub Actions Workflow

The CI/CD pipeline automatically:

1. **Tests**: Run Go tests and build verification
2. **Builds**: Create Docker images for Go app and monitoring stack
3. **Pushes**: Upload images to Docker Hub
4. **Deploys**: Deploy monitoring stack to production

### Setup GitHub Secrets

1. Go to Repository Settings → Secrets and variables → Actions
2. Add the following secrets:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token

## 🐳 Docker Operations

### Build Images

```bash
# Go Application
docker build -t go-app .

# Monitoring Stack
docker build -f monitoring/Dockerfile.monitoring -t go-app-monitoring monitoring/
```

### Run with Docker Compose

```bash
# Development
docker-compose up -d

# Production
docker-compose -f docker-compose.prod.yml up -d

# Monitoring
docker-compose -f monitoring/docker-compose.monitoring.yml up -d
```

## 📊 Monitoring

### Prometheus Targets

- **Go App**: `http://localhost:8080/metrics`
- **Prometheus**: `http://localhost:9090/metrics`
- **Grafana**: `http://localhost:3000` (admin/admin)

### Available Metrics

- HTTP request counts and durations
- Application health status
- Container resource usage
- Custom business metrics

## 🚀 Deployment

### Local Development

```powershell
.\run.ps1                    # Run locally
.\docker-setup.ps1          # Docker operations
```

### Production Deployment

```powershell
.\deploy.ps1                # Deploy with Docker Compose
.\production\deploy-prod.ps1 # Production deployment
```

### Kubernetes Deployment

```bash
kubectl apply -f k8s/
```

## 📁 Project Structure

```
GO-APP/
├── main.go                          # Go application entry point
├── go.mod                           # Go module dependencies
├── Dockerfile                       # Multi-stage Docker build
├── docker-compose.yml              # Development environment
├── docker-compose.prod.yml         # Production environment
├── .github/workflows/ci-cd.yml     # GitHub Actions CI/CD
├── monitoring/                      # Monitoring stack
│   ├── prometheus.yml              # Prometheus configuration
│   ├── grafana/                    # Grafana dashboards
│   ├── alertmanager/               # Alertmanager config
│   └── docker-compose.monitoring.yml
├── k8s/                           # Kubernetes manifests
├── production/                     # Production scripts
└── *.ps1                          # PowerShell automation scripts
```

## 🔧 Available Scripts

| Script | Description |
|--------|-------------|
| `run.ps1` | Run Go application locally |
| `docker-setup.ps1` | Docker operations and management |
| `deploy.ps1` | Deploy application with Docker Compose |
| `monitoring.ps1` | Monitor application health |
| `start-monitoring.ps1` | Start monitoring stack |
| `git-setup-complete.ps1` | Complete Git setup and initial push |
| `dockerhub-setup.ps1` | Docker Hub operations and image management |

## 🌐 API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/` | GET | Welcome message |
| `/health` | GET | Health check |
| `/api/info` | GET | Application information |
| `/metrics` | GET | Prometheus metrics |

## 📈 Monitoring Dashboards

### Grafana Dashboards

- **Go App Overview**: Application health and performance
- **HTTP Metrics**: Request counts, response times, error rates
- **System Resources**: Container CPU, memory, and network usage

### Alerts

- Application down
- High error rates
- Resource usage thresholds
- Response time degradation

## 🔐 Security Features

- Non-root user in containers
- Health checks for all services
- Secure headers in production
- Rate limiting with Nginx
- CORS configuration

## 🚀 Next Steps

1. **Setup Git Repository**:
   ```powershell
   .\git-setup-complete.ps1
   ```

2. **Configure Docker Hub**:
   ```powershell
   .\dockerhub-setup.ps1
   ```

3. **Push to GitHub**:
   ```bash
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

4. **Monitor CI/CD Pipeline**:
   - Check GitHub Actions tab
   - Verify Docker Hub images
   - Test monitoring stack

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and monitoring
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🆘 Support

- **Issues**: Create GitHub issues for bugs or feature requests
- **Documentation**: Check the monitoring dashboards for system status
- **Logs**: Use Docker logs for debugging

---

**🎉 Your Go App is ready for production with full CI/CD and monitoring!** 