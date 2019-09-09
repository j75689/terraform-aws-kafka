
resource "aws_security_group" "kafka" {
  name        = "kafka_security_group"
  description = "Allow kafka traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.ssh_inbound_block}"
  }

  ingress {
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = "${var.kafka_inbound_block}"
  }

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = "${var.kafka_inbound_block}"
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    description = "private network"
    cidr_blocks = "${var.cluster_network_cidr}"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kafka_security_group"
  }
}
