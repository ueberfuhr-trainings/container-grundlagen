#!/bin/bash

# on Windows Git Bash, use MSYS_NO_PATHCONV=1
docker run \
  --rm \
  -v "$(pwd)/:/usr/src/myapp" \
  -w "/usr/src/myapp" \
  python:3-slim \
  python hello.py
