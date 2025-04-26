terraform { 
  cloud { 
    
    organization = "plant-coach" 

    workspaces { 
      name = "digitalocean-kubernetes" 
    } 
  } 
}