terraform { 
  cloud { 
    
    organization = "plant-coach" 

    workspaces { 
      name = "doks-manager" 
    } 
  } 
}