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

data "template_file" "setup-zookeeper" {
  template = "${file("${path.module}/scripts/setup-zookeeper.sh")}"
  vars = {
    version="${var.zookeeper_version}"
    ip_addrs="${join(",", formatlist("%s", aws_instance.kafka.*.private_ip))}"
  }
}

data "template_file" "kafka-ctl" {
    template = "${file("${path.module}/scripts/kafka")}"
    vars = {
        scala_version = "${var.kafka_scala_version}"
        kafka_version = "${var.kafka_version}"
    }
}

data "template_file" "zookeeper-ctl" {
    template = "${file("${path.module}/scripts/zookeeper")}"
    vars = {
        version = "${var.zookeeper_version}"
    }
}