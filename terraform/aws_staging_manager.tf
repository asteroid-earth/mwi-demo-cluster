resource teleport_workload_identity "mwi_demo_aws_manager" {
  metadata = {
    name = "mwi_demo_aws_manager"
    description = "Workload Identity for AWS manager IaC process"
    labels = {
      "env" = "mwi-demo"
      "aws_account" = "dev-rel-staging"
    }
  }

  spec = {
    spiffe = {
      id = "/infra/aws-staging-management"
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
      workload_identity_labels = teleport_workload_identity.mwi_demo_aws_manager.metadata.labels
      rules = [
        {
          resources = ["workload_identity"]
          verbs = ["list", "read"]
        }
      ]
    }
  }
}

resource teleport_bot "mwi_demo_aws_manager" {
  name = "mwi-demo-aws-manager"
  roles = [
    teleport_role.mwi_demo_aws_manager.metadata.name,
  ]
}
