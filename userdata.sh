#!/bin/bash

# Update system
apt-get update -y

# Install Docker
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
sleep 10

# Create HTML directory
mkdir html

echo "<html><body><h1><font color=red>Hello from Container!</font></h1></body></html>" > html/index.html

# Create Dockerfile
cat <<'EOF2' > Dockerfile
FROM httpd:latest
COPY ./html/ /usr/local/apache2/htdocs/
EOF2

# Build and run Docker container
docker build -t mysite .
docker run -d -p 80:80 --cpus 0.256 --memory 64MB --name c1 mysite