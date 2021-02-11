#! /bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

docker run -d --rm -p 80:80 httpd
docker run -d --rm -p 5000:5000 einavl/earnix-time