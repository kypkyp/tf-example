provider "aws" {
  region = "ap-northeast-1"
}

module "webserver_cluster" {
  source = "../../../modules/webserver-cluster"

  cluster_name           = "webservers-stg"
  db_remote_state_bucket = "terraform-up-and-running-state-kyp"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 2
  max_size               = 3
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  autoscaling_group_name = module.webserver_cluster.alb_name

  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 5
  desired_capacity      = 5
  recurrence            = "0 9 * * *"
  time_zone             = "Asia/Tokyo"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  autoscaling_group_name = module.webserver_cluster.alb_name

  scheduled_action_name = "scale-in-at-night"
  min_size              = 2
  max_size              = 5
  desired_capacity      = 2
  recurrence            = "0 17 * * *"
  time_zone             = "Asia/Tokyo"
}
