resource "null_resource" "sshnull1" {
  triggers = {
	mytest = timestamp()
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
	  "sudo systemctl enable httpd --now"
	  ]
	}
#meta argument 
	depends_on = [
		aws_instance.web1, null_resource.volumeformatenull
	]
}