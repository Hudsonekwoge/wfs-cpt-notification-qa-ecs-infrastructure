

# VPC data
data "aws_vpc" "WFS_VPC" {
  id = var.VPC_ID
}

resource "aws_cloudwatch_log_group" "notification_service" {
  name = var.CLOUDWATCH_LOG_GROUP
}


# Creating the Target group for the ECS service to attach to

resource "aws_lb_target_group" "notification_service" {
  name = "notification-service"
  port = var.HTTP_PORT
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = data.aws_vpc.WFS_VPC.id
  health_check {
    path = var.HEALTH_CHECK_PATH
    protocol = "HTTP"
    matcher  = "200"
  }

}

# Creating the ALB Listerner Rule

resource "aws_lb_listener_rule" "notification_service" {
  listener_arn = var.ALB_LISTENER_ARN
  priority     = var.ALB_PRIORITY

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.notification_service.arn
  }

  condition {
    path_pattern {
      values = ["/wfs/app/v4/service/*"]
    }
  }

  condition {
    host_header {
      values = ["dash-qa.wfs.wigroup.io"]
    }
  }
}

# Creating the ECS Service

resource "aws_ecs_service" "notification_service" {
  name            = "notification-service"
  cluster         = var.ECS_CLUSTER
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.notification_service.arn
  desired_count   = var.REPLICAS

  network_configuration {
    security_groups = [var.SECURITY_GROUP_1]
    subnets         = [var.PRIVATE_SUBNET_1, var.PRIVATE_SUBNET_2]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.notification_service.arn
    container_name   = var.CONTAINER_NAME
    container_port   = var.HTTP_PORT
  }

  service_registries {
    registry_arn = var.CLOUD_MAP_REGISTRY
  }


}