provider "teleport" {
  addr = "mwidemo.cloud.gravitational.io:443"
  join_method = "terraform_cloud"
  join_token = "hcp-terraform"
  audience_tag = "teleport"
}

resource "null_resource" "print_token" {
  provisioner "local-exec" {
    command = "echo TFC_WORKLOAD_IDENTITY_TOKEN_TELEPORT: $TFC_WORKLOAD_IDENTITY_TOKEN_TELEPORT"
  }
}