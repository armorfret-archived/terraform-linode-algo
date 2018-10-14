data "template_file" "config" {
  template = "${file("${path.module}/assets/config.cfg")}"

  vars {
    userlist = "${jsonencode(var.users)}"
  }
}

module "vm" {
  source = "github.com/akerl/terraform-linode-algo-base"

  name            = "${var.name}"
  ssh_keys        = "${var.ssh_keys}"
  region          = "${var.region}"
  type            = "${var.type}"
  algo_repo       = "${var.algo_repo}"
  source_image_id = "${image_id}"
}

resource "null_resource" "configuration" {
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
    command     = "${path.module}/assets/download.sh ${module.vm.ip_address}"
    working_dir = "${path.root}"
  }
}
