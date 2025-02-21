# OSRM Backend Setup for LuganPH

This repository contains the Docker configuration for running a self-hosted OSRM (Open Source Routing Machine) backend service using Philippines map data. It uses OSRM backend version v5.27.1 for stable and reliable routing services.

## Prerequisites

- Docker
- Docker Compose
- At least 4GB of RAM available

## Setup Instructions

Clone this repository:

```bash
git clone <repository-url>
cd osrm-api
```

Build and start the OSRM service:

```bash
docker-compose up -d
```

The initial build will take some time as it needs to:

- Build the Docker image with OSRM v5.27.1
- Process the Philippines map data
- Create the routing graph

## API Endpoints

Once running, the following endpoints will be available at `http://localhost:5000`:

- `/route/v1/driving/{coordinates}` - Calculate a route between coordinates
- `/table/v1/driving/{coordinates}` - Compute distance/duration matrices
- `/match/v1/driving/{coordinates}` - Map matching
- `/trip/v1/driving/{coordinates}` - Solve Traveling Salesman Problem
- `/nearest/v1/driving/{coordinates}` - Find nearest road segment
- `/tile/v1/driving/{z}/{x}/{y}.mvt` - Vector tiles for visualization

### Example Requests

Route between two points:

```http
http://localhost:5000/route/v1/driving/121.0437,14.5649;121.0359,14.5530?steps=true
```

Distance matrix:

```http
http://localhost:5000/table/v1/driving/121.0437,14.5649;121.0359,14.5530
```

## Configuration

The service is configured with:

- 4GB maximum memory limit
- MLD (Multilevel Dijkstra) algorithm for faster routing
- Maximum table size of 1000 coordinates
- Automatic restart on failure

## Monitoring

Check the service status:

```bash
docker-compose ps
```

View logs:

```bash
docker-compose logs -f
```

## Updating Map Data

To update the Philippines map data:

1. Download latest PBF from OpenStreetMap
2. Replace `philippines-latest.osm.pbf`
3. Rebuild and restart the service:

```bash
docker-compose down
docker-compose up -d --build
```

## Version Information

- OSRM Backend: v5.27.1
- Base Image: ghcr.io/project-osrm/osrm-backend:v5.27.1
