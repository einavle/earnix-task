#! /bin/bash
sudo apt-get update -y
apt-get install apache2 -y
echo "<h1>Hello World!</h1>" > /var/www/html/app.html