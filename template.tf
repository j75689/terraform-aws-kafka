data "template_file" "user_data_kafka" {
  template = "${file("${path.module}/scripts/kafka-init.sh")}"
  vars {
    zookeeper_ips = "${join(":2181,", aws_instance.zookeeper.*.private_ip)}:2181",
    hosted_zone_id = "${data.terraform_remote_state.static.hosted_zone_id}",
    hosted_zone_name = "${data.terraform_remote_state.static.hosted_zone_name}"
  }
}
