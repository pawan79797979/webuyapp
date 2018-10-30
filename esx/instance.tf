resource "aws_instance" "appconf" {
  ami = "${var.AMIS}"
  instance_type = "t2.micro"
  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"
  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
  # user data
  user_data = "${data.template_cloudinit_config.cloudinit-public.rendered}"
}

resource "aws_instance" "app" {
  ami = "${var.AMIS}"
  instance_type = "t2.micro"
  # the VPC subnet
  subnet_id = "${aws_subnet.main-private-1.id}"
  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
  # user data
  user_data = "${data.template_cloudinit_config.cloudinit-private.rendered}"
}
