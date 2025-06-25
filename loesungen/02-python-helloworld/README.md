# Python sample

## Local Development

To run the Python application in a local container during development, run

```bash
docker run \
  --rm \
  -v "$(pwd)/hello.py:/hello.py" \
  python:3-slim \
  python /hello.py
```

## Build & Deployment

To build the image and run the container:

```bash
docker build \
  -t my-python-app:1.0.0 \
  .
docker run \
  --rm \
  my-python-app:1.0.0
```
