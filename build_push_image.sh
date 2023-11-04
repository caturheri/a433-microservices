#!/bin/bash

# Perintah untuk membuat Docker image dari Dockerfile
docker build -t item-app:v1 .

# Melihat daftar image di lokal
docker images

# Mengubah nama image agar sesuai dengan format GitHub Packages
docker tag item-app:v1 ghcr.io/caturheri/item-app:v1

# Login ke GitHub Packages via Terminal
echo $CR_PAT | docker login ghcr.io -u caturheri --password-stdin

# Mengunggah image ke GitHub Packages
docker push ghcr.io/caturheri/item-app:v1
