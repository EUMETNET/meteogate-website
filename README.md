# meteogate-website
Holds the [meteogate.eu](https://www.meteogate.eu) website source code

## Overview
This repository contains the static website for MeteoGate, built with HTML, CSS, and served via Docker.

## Deployment
The website uses GitHub Actions for automated deployment.

### Development Deploy
- **Trigger**: Push to `main` branch
- **Process**:
  - Builds a Docker image using the `Dockerfile`
  - Tags the image with the short SHA and `latest`
  - Pushes to the configured image registry
- **Purpose**: Deploys development versions for testing

### Production Deploy
- **Trigger**: Push of version tags (e.g., `v1.0.0`)
- **Process**:
  - Builds a Docker image using the `Dockerfile`
  - Tags the image with the version number and `production`
  - Pushes to the configured image registry
- **Purpose**: Deploys stable production releases

## Local Development
To run the website locally:
1. Clone the repository
2. Open `index.html` in a browser, or use a local server

For Docker:
```bash
docker build -t meteogate-website .
docker run -p 8080:80 meteogate-website
```
