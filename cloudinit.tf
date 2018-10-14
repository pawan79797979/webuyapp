data "template_file" "init-script" {
  template = "${file("scripts/init.cfg")}"
  vars {
    REGION = "${var.AWS_REGION}"
  }
}
data "template_file" "shell-script" {
  template = "${file("scripts/install.sh")}"
  
}
data "template_cloudinit_config" "cloudinit-public" {
  gzip = false
  base64_encode = false
  part {
    filename = "init.cfg"
    content_type = "text/cloud-config"
    content = "${data.template_file.init-script.rendered}"
  }
  part {
    content_type = "text/x-shellscript"
    content = "${data.template_file.shell-script-pub.rendered}"
  }
}
data "template_cloudinit_config" "cloudinit-private" {
  gzip = false
  base64_encode = false
  part {
    filename = "init.cfg"
    content_type = "text/cloud-config"
    content = "${data.template_file.init-script.rendered}"
  }
  part {
    content_type = "text/x-shellscript"
    content = "${data.template_file.shell-script-prv.rendered}"
  }
}
