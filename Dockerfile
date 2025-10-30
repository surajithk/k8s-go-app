# Multi-stage build for Go application
# Stage 1: Build the Go binary
FROM golang:alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy go mod files (if they exist) and download dependencies
# For a simple single-file app, we'll copy the source directly
COPY cool_app.go .

# Build the Go application for linux/amd64
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o cool_app cool_app.go

# Stage 2: Create the final lightweight image
FROM alpine:latest

# Install ca-certificates for HTTPS requests (if needed)
RUN apk --no-cache add ca-certificates

# Create a non-root user for security
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

# Set the working directory
WORKDIR /root/

# Copy the binary from the builder stage
COPY --from=builder /app/cool_app .

# Change ownership to the non-root user
RUN chown appuser:appgroup cool_app

# Switch to non-root user
USER appuser

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["./cool_app"]