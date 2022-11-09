resource "aws_instance" "web1" {
  ami           = var.amiId # us-west-2
  instance_type = "t2.micro"
  key_name           = "ishan"
  vpc_security_group_ids = ["sg-0034f601b61a164b7"]
  tags = {
    Name = "MyTFOS"
  }


  connection {
 	type = "ssh"
	user = "ec2-user"
	private_key = file("C:/Users/ishan/Downloads/ishan.pem")
	host = aws_instance.web1.public_ip
  }

  provisioner "remote-exec" {
  	inline = [
	  "sudo yum install httpd -y",
	  "sudo touch /var/www/html/index.html",
	  "sudo sh -c 'echo hi > /var/www/html/index.html'",
	  "sudo systemctl enable httpd --now"
	  ]
	}
}

resource "aws_ebs_volume" "myvol" {
  availability_zone = aws_instance.web1.availability_zone
  size = 1
  tags = {
	Name = "mywebvol"
  }
}

resource "aws_volume_attachment" "my_ebs_attach_ec2" {
  force_detach = true
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.myvol.id
  instance_id = aws_instance.web1.id
}



