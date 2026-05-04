#!/bin/bash

set -ex

echo "Updating packages..."
apt-get update -y

apt-get install net-tools -y 

echo "Installing Docker..."
apt-get install -y docker.io

usermod -aG docker az700admin

echo "Starting Docker..."
systemctl enable docker
systemctl start docker

echo "Waiting for Docker to be ready..."
sleep 10

docker --version
sudo docker login -u ${docker_username} -p ${docker_password} || echo "Docker login failed, continuing..."

echo "Pulling Docker image..."

for i in {1..5}; do
  sudo docker pull ${docker_image} && break
  echo "Retrying in 10 seconds..."
  sleep 10
done
  
echo "Running container..."
sudo docker run -d -p 9090:9090 --restart=always \
  --name ${application_name} \
  ${docker_image}

echo "Setup completed!"

