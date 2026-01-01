docker build -t my-web-app:latest .
docker images | grep my-web-app
docker run -d \
  --name my-web-app-container \
  -p 8080:80 \
  my-web-app:latest
curl http://localhost:8080
