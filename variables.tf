variable "ssh_key_name" {
  default = "kafka-cluster"
}

variable "ssh_username" {
  default = "ec2-user"
}

variable "ssh_key_file" {
  default = "./kafka-cluster.pem"
}

variable "project" {
  default = "kafka-aws"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "amis" {
  type = "map"

  default = {
    ap-southeast-1 = "ami-048a01c78f7bae4aa"
    us-west-2 = "ami-04b762b4289fba92b"
  }
}

variable "zookeeper_version" {
  description = "The zookeeper version"
  default     = "3.5.5"
}

variable "kafka_scala_version" {
  description = "The kafka scala version"
  default     = "2.12"
}


variable "kafka_version" {
  description = "The kafka version"
  default     = "2.3.0"
}

variable "kafka_log_retention" {
  description = "retention period (hours)"
  default = 168
}

variable "kafka_num_partitions" {
  description = "number of partitions per topic"
  default = 3
}

variable "kafka_replication_factor" {
  description = "number of replication"
  default = 2
}

variable "instance_type" {
  default = "t2.small"
}

variable "cluster_size" {
  default = "3"
}

variable "ec2_ebs_volume_size" {
  description = "GB"
  default = 10
}

variable "ebs_mount_point" {
  default = "/dev/sdf"
}

variable "subnet_id" {
  default = "subnet-3521d242"
}

variable "vpc_id" {
  default = "vpc-e4be4581"
}

variable "kafka_inbound_block" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "ssh_inbound_block" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "cluster_network_cidr" {
  type    = list(string)
  default = ["172.31.0.0/16"]
}
