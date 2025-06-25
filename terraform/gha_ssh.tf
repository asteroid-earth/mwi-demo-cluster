// This Bot identity will be used to represent our CI/CD. We'll assign it
// roles to control what it can access.
resource teleport_bot "mwi_demo_gha_ssh" {
  name = "mwi-demo-gha-ssh"
  roles = [
    teleport_role.mwi_demo_gha_ssh.metadata.name
  ]
}

// This Join Token is used to configure which machines can authenticate as our
// mwi-demo-gha-ssh bot.
resource teleport_provision_token "mwi_demo_gha_ssh" {
  version = "v2"
  metadata = {
    name = "mwi-demo-gha-ssh"
  }
  spec = {
    roles       = ["Bot"]
    bot_name    = "mwi-demo-gha-ssh"
    // Configured to use the GitHub join method - which allows authentication
    // using the OIDC ID Token issued by GitHub Actions.
    join_method = "github"
    github = {
      enterprise_slug = "teleport"
      // Only grant access to GitHub Actions running against the main branch
      // of our specific repository.
      allow = [{
        repository = "asteroid-earth/mwi-demo-gha-ssh"
        ref_type   = "branch"
        ref_name   = "main"
      }]
    }
  }
}

// This role controls what our Bot is allowed to access. In this case, we'll
// grant it access to SSH as the `ubuntu` user to any SSH node with the
// `env=mwi-demo` label.
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