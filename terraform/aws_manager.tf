resource teleport_workload_identity "mwi_demo_aws_manager" {
  version = "v1"
  metadata = {
    name = "mwi-demo-aws-manager"
    description = "Workload Identity for AWS manager IaC process"
    labels = {
      "env" = "mwi-demo"
      "aws-account" = "dev-rel-staging"
    }
  }

  spec = {
    spiffe = {
      id = "/infra/mwi-demo-aws-manager"
    }
  }
}

resource teleport_role "mwi_demo_aws_manager" {
  version = "v7"
  metadata = {
    name = "mwi-demo-aws-manager-identity-issuer"
  }
  
  spec = {
    allow = {
      workload_identity_labels = {
        "env" = [teleport_workload_identity.mwi_demo_aws_manager.metadata.labels["env"]]
        "aws-account" = [teleport_workload_identity.mwi_demo_aws_manager.metadata.labels["aws-account"]]
      }
      rules = [
        {
          resources = ["workload_identity"]
          verbs = ["list", "read"]
        }
      ]
    }
  }
}

resource teleport_role "mwi_demo_infra_token_creator" {
  version = "v7"
  metadata = {
    name = "mwi-demo-infra-token-creator"
  }
  
  spec = {
    allow = {
      rules = [
        {
          resources = ["token"]
          verbs = ["read", "list", "create", "update"]
        }
      ]
    }
  }
}

resource teleport_bot "mwi_demo_aws_manager" {
  name = "mwi-demo-aws-manager"
  roles = [
    teleport_role.mwi_demo_aws_manager.metadata.name,
    teleport_role.mwi_demo_infra_token_creator.metadata.name
  ]
}

resource "teleport_provision_token" "mwi_demo_aws_manager" {
  version = "v2"
  metadata = {
    name = "mwi-demo-aws-manager"
  }
  spec = {
    roles       = ["Bot"]
    bot_name    = "mwi-demo-aws-manager"
    join_method = "github"
    github = {
      allow = [{
        repository = "asteroid-earth/mwi-demo-infra"
        ref = "ref/heads/main"
      }]
      enterprise_slug = "teleport"
    }
  }
}
