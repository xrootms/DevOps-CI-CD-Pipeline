#!/bin/bash
sudo apt-get update
sudo apt install -y openjdk-17-jre 
echo "Waiting for 30 seconds before installing the jenkins package..."
sleep 30
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  
sudo apt-get update
sudo apt-get install -y jenkins
sleep 30
echo "Waiting for 30 seconds before installing the Terraform..."
wget https://releases.hashicorp.com/terraform/1.13.3/terraform_1.13.3_linux_amd64.zip
sudo apt-get install -y unzip
unzip 'terraform*.zip'
sudo mv terraform /usr/local/bin/