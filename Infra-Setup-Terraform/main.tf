module "networking" {
  source               = "./networking"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  ap_availability_zone = var.ap_availability_zone
  cidr_private_subnet  = var.cidr_private_subnet

}

module "security_groups" {
  source              = "./security-groups"
  ec2_sg_name         = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  k8s_cluster_sg_name = "SG for k8s to enable 465, 30000-32767, 25, 3000-10000 & 6443"
  vpc_id              = module.networking.devops_proj_1_vpc_id
  # ec2_jenkins_sg_name = "Allow port 8080 for jenkins"
  # ec2_nexus_sg_name   = "Allow port 8081 for nexus"
  # ec2_sonar_sg_name   = "Allow port 9000 for sonar"
}