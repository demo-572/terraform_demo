variable "region" {
  default     = "us-west-1"
  description = "AWS Region"
}

variable "access_key" {
  description = "AWS Access Key"
  default     = ""
}

variable "secret_key" {
  description = "AWS Secret Key"
  default     = ""
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "instance_tenancy" {
  default     = "default"
  description = "Instance Tenancy"
}

variable "vpc_cidr" {
  default     = "172.0.0.0/16"
  description = "VPC cidr block"
}

variable "enable_dns_hostnames" {
  default     = "false"
  description = "enable dns hostname"
}

variable "enable_dns_support" {
  default     = "true"
  description = "enable dns support"
}

variable "map_public_ip_on_launch" {
  default     = "false"
  description = "map public ip on launch"
}

variable "az1a" {
  default     = "us-west-1a"
  description = "AWS Availability zone"
}

variable "subnet_cidr" {
  default     = "172.0.1.0/24"
  description = "Subnet CIDR Block"
}

variable "all_cidrs" {
  default     = "0.0.0.0/0"
  description = "Destination CIDR Block"
}

variable "sg_name" {
  default     = "sg_devops"
  description = "SG Name"
}

variable "tcp_protocal" {
  default     = "tcp"
  description = "TCP Protocal"
}

variable "algorithm" {
  default     = "RSA"
  description = "AwS SSH Key algorithm"
}

variable "ssh_key" {
  default     = "kp_devops"
  description = "AWS Key Name"
}

variable "ssh_key_name" {
  default     = "kp_devops.pem"
  description = "AWS Key filename"
}

variable "volume_size" {
  default     = "10"
  description = "AWS EBS Volume Size"
}

variable "volume_type" {
  default     = "gp2"
  description = "Volume Type"
}

variable "ami_id" {
  default     = "ami-00831fc7c1e3ddc60"
  description = "AWS AMI ID"
}

variable "private_ip" {
  default     = "172.0.1.10"
  description = "Private IP Address"
}

variable "delete_on_termination" {
  default     = "true"
  description = "delete on termination"
}

variable "vpc" {
  default     = "true"
  description = "vpc eip"
}
