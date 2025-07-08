
module "app_ecr" {
  source    = "../../modules/ecr"  
  repo_name = "my-app-staging"    
  env_name  = "staging"     
}
