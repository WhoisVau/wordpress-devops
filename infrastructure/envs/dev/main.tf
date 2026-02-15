module "vpc" {
  source = "../../modules/vpc"

  project_name = "wordpress"
  environment  = "dev"
  cluster_name = "wordpress-dev-eks"

  vpc_cidr = "10.0.0.0/16"

  azs = ["eu-central-1a", "eu-central-1b"]

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source = "../../modules/eks"

  project_name = "wordpress"
  environment  = "dev"
  cluster_name = "wordpress-dev-eks"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids

  node_instance_type = "t3.small"

  desired_size = 2
  min_size     = 2
  max_size     = 3
}

module "rds" {
  source = "../../modules/rds"

  project_name = "wordpress"
  environment  = "dev"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  db_name     = "wordpress"
  db_username = "wpuser"
  db_password = "StrongPassword123!"
}

module "redis" {
  source = "../../modules/redis"

  project_name = "wordpress"
  environment  = "dev"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}
