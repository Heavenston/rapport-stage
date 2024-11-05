#!/bin/bash

docker build . -t rapportbuilder:latest && \
docker tag rapportbuilder:latest ghcr.io/heavenston/rapportbuilder:latest && \
docker push ghcr.io/heavenston/rapportbuilder:latest
