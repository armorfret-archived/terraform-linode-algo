data "template_file" "config" {
  template = "${file("${path.module}/assets/config.cfg")}"

  vars {
    userlist = "${jsonencode(var.users)}"
  }
}

resource "linode_instance" "algo" {
  label = "${var.name}-algo"

  region = "${var.region}"
  type   = "${var.type}"

  disk {
    label           = "root"
    size            = 10240
    authorized_keys = "${var.ssh_keys}"
    image           = "linode/ubuntu18.04"
  }

  config {
    label  = "default"
    kernel = "linode/grub2"

    devices {
      sda = {
        disk_label = "root"
      }
    }
  }

  provisioner "remote-exec" {
    script = "${path.module}/assets/system_init.sh"
  }

  provisioner "local-exec" {
    command = "${path.module}/assets/password_gen.sh ${linode_instance.algo.ip_address}"

    working_dir = "${path.root}"
  }

  provisioner "file" {
    content     = "${data.template_file.config.rendered}"
    destination = "/opt/algo/config.cfg"
  }

  provisioner "remote-exec" {
    script = "${path.module}/assets/ansible_run.sh"
  }

  provisioner "local-exec" {
    command = "${path.module}/assets/download.sh ${linode_instance.algo.ip_address}"

    working_dir = "${path.root}"
  }
}
