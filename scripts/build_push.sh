#!/bin/bash

# Configuration
# Docker Hub configuration
REGISTRY_USER="hkchi-pham"
REGISTRY_EMAIL="khanhchi.phamha@gmail.com"
IMAGE_NAME="mental-health-api"

# Get Git Commit Hash
GIT_COMMIT=$(git rev-parse --short HEAD)
if [ -z "$GIT_COMMIT" ]; then
    echo "⚠️  Could not get git commit hash. Using 'latest' only."
    TAG="latest"
else
    TAG="$GIT_COMMIT"
    echo "🏷️  Detected Git Commit: $TAG"
fi

FULL_IMAGE_NAME="$REGISTRY_USER/$IMAGE_NAME:$TAG"
LATEST_IMAGE_NAME="$REGISTRY_USER/$IMAGE_NAME:latest"

echo "🔨 Building Docker image: $FULL_IMAGE_NAME..."
docker build -t "$FULL_IMAGE_NAME" -t "$LATEST_IMAGE_NAME" .

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    
    echo "📤 Pushing image to registry..."
    echo "   (Make sure you are logged in using 'docker login')"
    
    docker push "$FULL_IMAGE_NAME"
    docker push "$LATEST_IMAGE_NAME"
    
    if [ $? -eq 0 ]; then
        echo "✅ Push successful!"
        echo "---------------------------------------------------------"
        echo "🚀 To deploy on server:"
        echo "1. Copy 'docker-compose.deploy.yaml' and '.env' to the server."
        echo "2. Set DOCKER_IMAGE in .env:"
        echo "   DOCKER_IMAGE=$FULL_IMAGE_NAME"
        echo "3. Run: docker-compose -f docker-compose.deploy.yaml up -d"
        echo "---------------------------------------------------------"
    else
        echo "❌ Push failed!"
        exit 1
    fi
else
    echo "❌ Build failed!"
    exit 1
fi

