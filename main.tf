module "frontend_instance" {
  source         = "./modules/frontend"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  instance_name  = var.instance_name
}
