#!/bin/bash

set -ex

echo "Updating packages..."
apt-get update -y

apt-get install net-tools -y 

echo "Installing Docker..."
apt-get install -y docker.io

usermod -aG docker azureuser

echo "Starting Docker..."
systemctl enable docker
systemctl start docker

echo "Waiting for Docker to be ready..."
sleep 10

docker --version
sudo docker login -u devopsdeveloper909 -p Jadapeta@909 || echo "Docker login failed, continuing..."

echo "Pulling Docker image..."

for i in {1..5}; do
  sudo docker pull devopsdeveloper909/azure-private-access-to-services:latest && break
  echo "Retrying in 10 seconds..."
  sleep 10
done
  
echo "Running container..."
sudo docker run -d -p 9090:9090 --restart=always \
  --name azure-private-access-to-services \
  -e STORAGE_CONNECTION_STRING="${storage_connection_string}" \
  -e CONTAINER_NAME="${container_name}" \
  devopsdeveloper909/azure-private-access-to-services:latest

echo "Setup completed!"

