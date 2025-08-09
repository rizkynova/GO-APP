package main

import (
	"log"
	"net/http"
	"os"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/cors"
)

func main() {
	// Set Gin to release mode in production
	gin.SetMode(gin.ReleaseMode)

	r := gin.Default()

	// CORS middleware
	config := cors.DefaultConfig()
	config.AllowAllOrigins = true
	config.AllowMethods = []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"}
	config.AllowHeaders = []string{"Origin", "Content-Type", "Accept", "Authorization"}
	r.Use(cors.New(config))

	// Health check endpoint
	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"service": "go-app",
			"status":  "healthy",
			"version": "1.0.0",
			"time":    time.Now().Format(time.RFC3339),
		})
	})

	// Welcome endpoint
	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "Welcome to Go App!",
			"service": "go-app",
			"version": "1.0.0",
		})
	})

	// API info endpoint
	r.GET("/api/info", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"app_name":    "Go App",
			"description": "A simple Go application for Git and Docker CI/CD",
			"features": []string{
				"RESTful API",
				"Docker support",
				"CI/CD ready",
				"Health check",
				"Prometheus metrics",
			},
		})
	})

	// Prometheus metrics endpoint
	r.GET("/metrics", func(c *gin.Context) {
		c.Header("Content-Type", "text/plain")
		c.String(http.StatusOK, `# HELP go_app_http_requests_total Total number of HTTP requests
# TYPE go_app_http_requests_total counter
go_app_http_requests_total{method="GET",endpoint="/health"} 0
go_app_http_requests_total{method="GET",endpoint="/"} 0
go_app_http_requests_total{method="GET",endpoint="/api/info"} 0
go_app_http_requests_total{method="GET",endpoint="/metrics"} 0

# HELP go_app_http_request_duration_seconds Duration of HTTP requests
# TYPE go_app_http_request_duration_seconds histogram
go_app_http_request_duration_seconds_bucket{method="GET",endpoint="/health",le="0.1"} 0
go_app_http_request_duration_seconds_bucket{method="GET",endpoint="/health",le="0.5"} 0
go_app_http_request_duration_seconds_bucket{method="GET",endpoint="/health",le="1.0"} 0
go_app_http_request_duration_seconds_bucket{method="GET",endpoint="/health",le="+Inf"} 0
go_app_http_request_duration_seconds_sum{method="GET",endpoint="/health"} 0
go_app_http_request_duration_seconds_count{method="GET",endpoint="/health"} 0

# HELP go_app_up Application status
# TYPE go_app_up gauge
go_app_up 1
`)
	})

	// Get port from environment variable or use default
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("Starting server on port %s", port)
	if err := r.Run(":" + port); err != nil {
		log.Fatal("Failed to start server:", err)
	}
} 