resource "aws_instance" "backend" {
    ami                     = var.ami_id
    instance_type           = var.instance_type
    key_name                = var.key_name
    tags = {
        Name = var.instance_name
    }
}
