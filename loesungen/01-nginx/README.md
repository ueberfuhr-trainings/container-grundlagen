# NGinX sample

## Local Development

To run the local container with the local `index.html` file, run

```bash
docker run \
  --rm \
  -v "$(pwd)/index.html:/usr/share/nginx/html/index.html" \
  -p8080:80 \
  nginx:1.27.5
```

## Build & Deployment

To Build the image and run the container:

```bash
docker build \
  -t my-website:1.0.0 \
  .
docker run \
  --rm \
  -p8080:80 \
  my-website:1.0.0
```
