environment = "tools"
stack_name  = "fider"
env_subnet_ids = [
  "subnet-3cad2912", # 0.public.tools.pubgisd.services
  "subnet-5a7b3210", # 1.public.tools.pubgisd.services
  "subnet-3199236d"  # 2.public.tools.pubgisd.services
]
node_sg_id = ["sg-8ea440c3"]
vpc_id     = "vpc-7aab6100"
min_scaling = 2
max_scaling = 64
auto_pause = false
