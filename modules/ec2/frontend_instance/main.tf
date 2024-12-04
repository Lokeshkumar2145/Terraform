resource "aws_instance" "frontend_instance" {
  ami                   = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = var.subnet_id
  key_name              = "tf_key"
  security_groups       = var.security_groups
  associate_public_ip_address = true
  tags = {
    Name = var.instance_name
  }

  provisioner "remote-exec" {
    inline = [
      "echo '${file("C:/Users/LENOVO/Desktop/TFmodules/tf_key.pem")}' > /home/ubuntu/tf_key.pem",
      "chmod 400 /home/ubuntu/tf_key.pem",
      # "sudo sed -i 's|server_name .*|server_name ${var.frontend_lb_dns};|' /etc/nginx/sites-available/fundoo.conf",
      # "sudo sed -i 's|proxy_pass .*|proxy_pass http://${var.backend_lb_dns}:8000;|' /etc/nginx/sites-available/fundoo.conf",
      # "sudo systemctl daemon-reload",
      # "sudo systemctl reload nginx"
    ]

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file("C:/Users/LENOVO/Desktop/TFmodules/tf_key.pem")
      host                = self.public_ip
      port                = 22
      timeout             = "4m"
    }
  }
}
