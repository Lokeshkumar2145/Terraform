resource "aws_instance" "backend_instance" {
  ami                   = var.ami_id_b
  instance_type         = var.instance_type_b
  key_name              = var.key_name_b
  subnet_id             = var.subnet_id
  security_groups       = var.security_groups
  tags = {
    Name = var.backend_instance_name
  }
}

resource "null_resource" "backend_setup" {
  triggers = {
    instance_id = aws_instance.backend_instance.id
  }

  provisioner "remote-exec" {
    inline = [
      "echo '${file(var.key_path)}' > /home/ubuntu/tf_key.pem",
      "chmod 400 /home/ubuntu/tf_key.pem",
      "sudo sed -i 's/DB_HOST=.*/DB_HOST=${var.database_private_ip}/' /etc/fundoo/env.conf",
      "sudo systemctl daemon-reload",
      "sudo su dev bash -c 'cd /Aws_test && source myenv/bin/activate && cd /Aws_test/fundoo_notes && python3 manage.py makemigrations && python3 manage.py migrate'",
      "sudo systemctl restart fundoo.service"
    ]

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file(var.key_path)
      host                = aws_instance.backend_instance.private_ip
      bastion_host        = var.bastion_host
      bastion_private_key = file(var.key_path)
      port                = 22
      timeout             = "10m"
    }
  }
}
