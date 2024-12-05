terraform { 
  backend "remote"{ 
    
    organization = "tf_cloud_org" 

    workspaces { 
      name = "dev" 
    } 
  } 
}