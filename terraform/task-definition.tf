resource "aws_ecs_task_definition" "notification_service" {
  family                   = "notification-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = var.GLOBAL_ECS_TASK_ROLE
  execution_role_arn       = var.GLOBAL_ECS_TASK_EXECUTION_ROLE
  cpu                      = 1024
  memory                   = 2048

  container_definitions = jsonencode([
    {
      name      = var.CONTAINER_NAME
      image     = var.CONTAINER_IMAGE
      cpu       = 1024
      memory    = 2048
      essential = true


      secrets = [
        {
          name      = "secret"
          valueFrom = var.DB_CREDENTIALS
        }
      ]

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-region        = var.AWS_DEFAULT_REGION
          awslogs-group         = aws_cloudwatch_log_group.notification_service.name
          awslogs-stream-prefix = "notification"
        }
      }

      portMappings = [
        {
          containerPort = 8090
          hostPort      = 8090
        }
      ]
    }
  ])
}