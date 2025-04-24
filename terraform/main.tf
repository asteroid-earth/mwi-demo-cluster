terraform { 
  cloud { 
    
    organization = "teleport_product_tests" 

    workspaces { 
      name = "mwi_demo_cluster" 
    } 
  }

  required_providers {
    teleport = {
      source  = "terraform.releases.teleport.dev/gravitational/teleport"
      version = "17.4.3"
    }
  }
}