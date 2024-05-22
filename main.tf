resource "aws_instance" "app_server_amazon_linux_2023" {

    ami = "ami-0bb84b8ffd87024d8"
    instance_type = var.instance_type
    availability_zone = var.instance_az

    tags = {
      Name = var.instance_name
    }
}