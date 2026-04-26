#!/bin/bash
set -e

# Update system packages
apt-get update
apt-get upgrade -y

# Install nginx
apt-get install -y nginx

# Start nginx service
systemctl start nginx
systemctl enable nginx

# Create a simple health check page
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to WebVM1</title>
</head>
<body>
    <h1>Nginx is running on WebVM1!</h1>
    <p>Hostname: $(hostname)</p>
    <p>IP Address: $(hostname -I)</p>
</body>
</html>
EOF

echo "Nginx installation completed successfully"
