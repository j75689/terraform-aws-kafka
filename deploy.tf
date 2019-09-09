resource "null_resource" "nodes" {
  count = "${length(aws_instance.kafka)}"
  triggers = {
    zookeeper_id = "${element(aws_instance.kafka.*.id, count.index)}"
  }
  connection {
    host = "${element(aws_instance.kafka.*.public_ip, count.index)}"
    user = "${var.ssh_username}"
    private_key = "${file(var.ssh_key_file)}"
  }
  provisioner "file" {
    content = "${data.template_file.setup-zookeeper.rendered}"
    destination = "/tmp/setup-zookeeper.sh"
  }
  provisioner "file" {
    content = "${data.template_file.zookeeper-ctl.rendered}"
    destination = "/tmp/zookeeper-ctl"
  }

  provisioner "file" {
    content = "${data.template_file.setup-kafka.rendered}"
    destination = "/tmp/setup-kafka.sh"
  }
  provisioner "file" {
    content = "${data.template_file.kafka-ctl.rendered}"
    destination = "/tmp/kafka-ctl"
  }

  provisioner "remote-exec" {
    inline = [
      // install java
      "sudo yum remove -y java-*",
      "sudo yum install -y java-1.8.0",
      // setup zookeeper
      "chmod +x /tmp/setup-zookeeper.sh",
      "sudo /tmp/setup-zookeeper.sh ${count.index}",
      "sudo mv /tmp/zookeeper-ctl /etc/init.d/zookeeper",
      "sudo chmod a+x /etc/init.d/zookeeper",
      "sudo chown root:root /etc/init.d/zookeeper",
      "sudo chkconfig zookeeper on",
      "sudo service zookeeper start",
      // setup broker
      "chmod +x /tmp/setup-kafka.sh",
      "sudo /tmp/setup-kafka.sh ${count.index} ${count.index}",
      "sudo mv /tmp/kafka-ctl /etc/init.d/kafka",
      "sudo chmod a+x /etc/init.d/kafka",
      "sudo chown root:root /etc/init.d/kafka",
      "sudo chkconfig kafka on",
      "sudo service kafka start"
    ]
  }
}
