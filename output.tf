

output "Public_ip_web_url" {
	value = "http://${aws_instance.web1.public_ip}/index.html"
}

output "os_state" {
	value = aws_instance.web1.instance_state
}

output "os_AZ_name" {
	value = aws_instance.web1.availability_zone
}
