
resource teleport_role "mwi_demo_gha_ssh" {
  version = "v7"
  metadata = {
    name = "mwi-demo-gha-ssh"
  }

  spec = {
    allow = {
      node_labels = {
        "env" = ["mwi-demo"]
      }
      logins = ["ubuntu"]
    }
  }
}

resource teleport_bot "mwi_demo_gha_ssh" {
  name = "mwi-demo-gha-ssh"
  roles = [
    teleport_role.mwi_demo_gha_ssh.metadata.name
  ]
}

resource teleport_provision_token "mwi_demo_gha_ssh" {
  version = "v2"
  metadata = {
    name = "mwi-demo-gha-ssh"
  }
  spec = {
    roles       = ["Bot"]
    bot_name    = "mwi-demo-gha-ssh"
    join_method = "github"
    gha_ssh = {
      allow = [{
        repository = "asteroid_earth/mwi-demo-cluster"
        ref_type   = "branch"
        ref_name   = "main"
      }]
    }
  }
}