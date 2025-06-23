#!/bin/bash

docker run --rm -v "$(pwd)/hello.py:/hello.py" python:3-slim python /hello.py
