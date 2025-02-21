#!/bin/bash

# Check if data needs processing by looking for the .osrm file
if [ ! -f "/data/philippines-latest.osrm" ]; then
    echo "Processing Philippines map data..."
    osrm-extract /data/philippines-latest.osm.pbf -p /opt/car.lua
    osrm-partition /data/philippines-latest.osrm
    osrm-customize /data/philippines-latest.osrm
else
    echo "OSRM data already processed, skipping..."
fi

# Start the OSRM routing service
exec osrm-routed --algorithm mld --ip 0.0.0.0 --port 5000 --max-table-size 1000 /data/philippines-latest.osrm