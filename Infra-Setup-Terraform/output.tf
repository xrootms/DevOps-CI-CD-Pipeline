output "ssh_connection_string_for_ec2_jenkins" {
  value = "ssh -i ~/Documents/keys/devops_proj1 ubuntu@${module.jenkins.jenkins_ec2_instance_public_ip}"
}

output "ssh_connection_string_for_ec2_sonar" {
  value = "ssh -i ~/Documents/keys/devops_proj1 ubuntu@${module.sonar.sonar_ec2_instance_public_ip}"
}

output "ssh_connection_string_for_ec2_nexus" {
  value = "ssh -i ~/Documents/keys/devops_proj1 ubuntu@${module.nexus.nexus_ec2_instance_public_ip}"
}