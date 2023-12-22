#!/bin/bash

# Perintah untuk membuat Docker image dari Dockerfile
docker build -t ghcr.io/caturheri/karsajobs-ui:latest .

# Melihat daftar image di lokal
docker images

# Login ke Github Packages via Terminal
echo $CR_PAT | docker login ghcr.io -u caturheri --password-stdin

# Mengunggah image ke Github Packages
docker push ghcr.io/caturheri/karsajobs-ui:latest
