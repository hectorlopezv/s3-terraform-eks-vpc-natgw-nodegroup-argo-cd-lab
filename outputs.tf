output "random_pet" {
    value = "random_pet_hello_debug"
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server_amazon_linux_2023.id
}

output "instance_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server_amazon_linux_2023.public_ip
}

output "instance_name" {
  description = "Name of the EC2 instance"
  value       = aws_instance.app_server_amazon_linux_2023.tags.Name
}