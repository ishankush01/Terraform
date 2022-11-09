resource "null_resource" "localexecnull" {
	triggers = {
          mytest = timestamp()
	}
	provisioner "local-exec" {
	  command = "echo ${aws_instance.web1.public_ip} > inventory"
	}
}

resource "null_resource" "launchwebsite" {
	triggers = {
          mytest = timestamp()
	}
	provisioner "local-exec" {
	  command = "chrome http://${aws_instance.web1.public_ip}/index.html"
	}
}
