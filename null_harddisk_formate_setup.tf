resource "null_resource" "volumeformatenull" {
  connection {
 	type = "ssh"
	user = "ec2-user"
	private_key = file("C:/Users/ishan/Downloads/ishan.pem")
	host = aws_instance.web1.public_ip
  }

  provisioner "remote-exec" {
	on_failure = continue
  	inline = [
	  "sudo mkfs.ext4 /dev/xvdh",
	  "sudo mount /dev/xvdh /var/www/html",
	  "sudo sh -c 'echo welcome ishan!  > /var/www/html/index.html'",
	  ]
	}
#meta argument 
	depends_on = [
		aws_volume_attachment.my_ebs_attach_ec2 
	]
}