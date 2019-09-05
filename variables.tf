
variable "project" {
  default = "kafka-aws"
}

variable "region" {
  default = "us-west-2"
}

variable "amis_id" {
  default = "ami-04b762b4289fba92b"
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

variable "kafka_version" {
  description = "The kafka version"
  default     = ""
}

variable "instance_type" {
  default = "t2.small"
}

variable "cluster_size_max" {
  default = "3"
}

variable "cluster_size_min" {
  default = "3"
}

variable "availability_zones" {
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}