data "template_file" "running_config" {

    template = file("${path.module}/running_config.tpl")

    vars = {
        admin_password = var.admin_password
        hostname       = var.hostname
    }
}