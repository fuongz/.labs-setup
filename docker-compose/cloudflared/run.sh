#!/usr/bin/env bash

docker compose --env-file ./../../docker.env/.cloudflared.env up -d
