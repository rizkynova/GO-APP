.PHONY: help build run test clean docker-build docker-run docker-stop

# Default target
help:
	@echo "Available commands:"
	@echo "  build        - Build the Go application"
	@echo "  run          - Run the Go application locally"
	@echo "  test         - Run tests"
	@echo "  clean        - Clean build artifacts"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-run   - Run Docker container"
	@echo "  docker-stop  - Stop Docker container"
	@echo "  deps         - Download Go dependencies"

# Build the application
build:
	go build -o go-app .

# Run the application locally
run:
	go run main.go

# Run tests
test:
	go test -v ./...

# Clean build artifacts
clean:
	rm -f go-app
	go clean

# Download dependencies
deps:
	go mod download
	go mod tidy

# Build Docker image
docker-build:
	docker build -t go-app .

# Run Docker container
docker-run:
	docker run -d --name go-app-container -p 8080:8080 go-app

# Stop Docker container
docker-stop:
	docker stop go-app-container || true
	docker rm go-app-container || true

# Run with docker-compose
compose-up:
	docker-compose up -d

# Stop docker-compose
compose-down:
	docker-compose down

# View logs
logs:
	docker-compose logs -f go-app 