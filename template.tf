data "template_file" "setup-kafka" {
  template = "${file("${path.module}/scripts/setup-kafka.sh")}"
  vars = {
    repo="http://apache.org/dist/kafka"
    scala_version="${var.kafka_scala_version}"
    version="${var.kafka_version}"
    num_partitions="${var.kafka_num_partitions}"
    log_retention="${var.kafka_log_retention}"
    repl_factor="${var.kafka_replication_factor}"
    mount_point = "${var.ebs_mount_point}"
    zookeeper_connect="${join(",", formatlist("%s:2181", aws_instance.kafka.*.private_ip))}"
  }
}
