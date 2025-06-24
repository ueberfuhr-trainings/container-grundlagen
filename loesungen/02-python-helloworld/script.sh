#!/bin/bash

# on Windows Git Bash, use $(pwd -W)!
docker run --rm -v "$(pwd)/hello.py:/hello.py" python:3-slim python /hello.py
