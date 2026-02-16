module "vpc" {
  source = "../../modules/vpc"

  project_name = "wordpress"
  environment  = "prod"
  cluster_name = "wordpress-prod-eks"

  vpc_cidr = "10.1.0.0/16"

  azs = ["eu-central-1a", "eu-central-1b"]

  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.11.0/24", "10.1.12.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source = "../../modules/eks"

  project_name = "wordpress"
  environment  = "prod"
  cluster_name = "wordpress-prod-eks"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids

  node_instance_type = "t3.small"

  desired_size = 1
  min_size     = 1
  max_size     = 1
}

module "rds" {
  source = "../../modules/rds"

  project_name = "wordpress"
  environment  = "prod"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  db_name     = "wordpress"
  db_username = "wpuser_prod"
  db_password = "ProdStrongPassword456!"
}

module "redis" {
  source = "../../modules/redis"

  project_name = "wordpress"
  environment  = "prod"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

resource "aws_ecr_repository" "wordpress" {
  name = "wordpress-prod"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "prod"
    Project     = "wordpress"
  }
}
