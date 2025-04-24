provider "teleport" {
  addr = "mwidemo.cloud.gravitational.io:443"
  join_method = "terraform_cloud"
  join_token = "hcp-terraform"
  audience_tag = "teleport"
}
