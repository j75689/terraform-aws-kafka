output "public_ips" {
    value = "${aws_instance.kafka.*.public_ip}"
}

output "zookeeper-connect" {
    value = "${join(",", formatlist("%s:2181", aws_instance.kafka.*.private_ip))}"
}