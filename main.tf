data "template_file" "config" {
  template = "${file("${path.module}/assets/config.cfg")}"

  vars {
    userlist   = "${jsonencode(var.users)}"
    ip_address = "${module.vm.ip_address}"
  }
}

module "vm" {
  source          = "armorfret/algo-base/linode"
  version         = "0.0.4"
  name            = "${var.name}"
  ssh_keys        = ["${var.ssh_keys}"]
  ssh_users       = ["${var.ssh_users}"]
  region          = "${var.region}"
  type            = "${var.type}"
  algo_repo       = "${var.algo_repo}"
  source_image_id = "${var.image_id}"
}

resource "null_resource" "configuration" {
  triggers = {
    linode_id  = "${module.vm.linode_id}"
    ip_address = "${module.vm.ip_address}"
    content    = "${data.template_file.config.rendered}"
  }

  connection {
    type = "ssh"
    user = "root"
    host = "${module.vm.ip_address}"
  }

  provisioner "file" {
    content     = "${data.template_file.config.rendered}"
    destination = "/opt/algo/config.cfg"
  }

  provisioner "remote-exec" {
    script = "${path.module}/assets/deploy.sh"
  }

  provisioner "local-exec" {
    command     = "${path.module}/assets/download.sh '${module.vm.ip_address}' '${var.name}'"
    working_dir = "${path.root}"
  }
}
