output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "redis_endpoint" {
  value = module.redis.redis_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
