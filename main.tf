data "template_file" "config" {
  template = "${file("${path.module}/assets/config.cfg")}"

  vars {
    userlist = "${jsonencode(var.users)}"
  }
}

resource "linode_instance" "algo" {
  label = "${var.name}-algo"

  image  = "linode/ubuntu18.04"
  kernel = "linode/grub2"
  region = "${var.region}"
  type   = "${var.type}"

  ssh_key       = "${var.ssh_key}"
  root_password = "random"

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
