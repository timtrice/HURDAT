#!/bin/bash
docker-compose build --force-rm

docker run -dti --name hurdat -p 8787:8787 hurdat_hurdat

$SHELL