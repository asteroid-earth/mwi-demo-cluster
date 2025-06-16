resource teleport_role "mwi_demo_azure_devops" {
  version = "v7"
  metadata = {
    name = "mwi-demo-azure-devops"
  }
  
  spec = {
    allow = {
      node_labels = {
        "env" = ["mwi-demo"]
      },
      logins = ["ubuntu"]
    }
  }
}

resource teleport_bot "mwi_demo_azure_devops" {
  name = "mwi-demo-azure-devops"
  roles = [
    teleport_role.mwi_demo_azure_devops.metadata.name
  ]
}

resource "teleport_provision_token" "mwi_demo_azure_devops" {
  version = "v2"
  metadata = {
    name = "mwi-demo-azure-devops"
  }
  spec = {
    roles       = ["Bot"]
    bot_name    = "mwi-demo-azure-devops"
    join_method = "azure_devops"
    azure_devops = {
      organization_id = "0ca3ddd9-f0b0-4635-a98c-5866526961b6"
      allow = [{
        project_name = "testing-azure-devops-join"
        pipeline_name = "strideynet.azure-devops-testingv"
      }]
    }
  }
}