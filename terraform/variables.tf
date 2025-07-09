# Define variables
variable "TF_STATE_BUCKET" {
  type = string
  description = ""
  default = "wfs-cpt-qa-tf-state"
}

variable "VPC_ID" {
  type = string
  description = ""
  default = "vpc-0214e09129c4a8cdd"
}

variable "AWS_DEFAULT_REGION" {
  description = "The region to create the resource in"
  default = "af-south-1"
}

variable "CONTAINER_IMAGE" {
  description = "What is the URL to the container image on AWS ECR?"
  default = "697051637339.dkr.ecr.af-south-1.amazonaws.com/notification-service:latest"
}


variable "ECS_CLUSTER" {
  type = string
  description = ""
  default = "microservices"
}

variable "HTTP_PORT" {
  type = number
  description = "Container port"
  default = 8090
}

variable "SECURITY_GROUP_1" {
  type = string
  description = "Container port"
  default = "sg-09e3811e4d423421f"
}

variable "ALB_LISTENER_ARN" {
  type = string
  description = ""
  default = "arn:aws:elasticloadbalancing:af-south-1:697051637339:listener/app/wfs-qa-CapeTown-public-alb/bf181dea5633fa78/4647c7d1d77ec09b"
}

variable "CONTAINER_NAME" {
  type = string
  description = ""
  default = "notification-service"
}

variable "REPLICAS" {
  type = number
  description = ""
  default = 0
}

variable "PRIVATE_SUBNET_1" {
  type = string
  description = ""
  default = "subnet-0af249cf7cb70ad51"
}

variable "PRIVATE_SUBNET_2" {
  type = string
  description = ""
  default = "subnet-06a88866e8b4cba9b"
}

variable "ALB_PRIORITY" {
  type = number
  description = ""
  default = 8
}

variable "GLOBAL_ECS_TASK_ROLE" {
  description = "Global ECS Task Role"
  default = "arn:aws:iam::697051637339:role/wfs-oneapp-qa-security-ECSRole-QZIGYGDNHPQ-ECSRole-1EUU1EK0PO0O6"
}

variable "GLOBAL_ECS_TASK_EXECUTION_ROLE" {
  description = "Global ECS Task Role"
  default = "arn:aws:iam::697051637339:role/wfs-oneapp-qa-security-ECSRol-ECSTaskExecutionRole-ASR00WEQ09J3"
}

variable "DB_CREDENTIALS" {
  description = "What is the arn to the WFS DB Credentials on AWS Secrets Manager?"
  default = "arn:aws:secretsmanager:af-south-1:697051637339:secret:wfs-qa-notification-db-secret-GFBiM9"
}

variable "CLOUDWATCH_LOG_GROUP" {
  description = ""
  default = "notification-service"
}

variable "ROUTE_53_RECORD" {
  description = ""
  default = "notification.qa.wfs.yoyogroup.com"
}

variable "HEALTH_CHECK_PATH" {
  description = ""
  default = "/actuator/health"
}

variable "CLOUD_MAP_REGISTRY" {
  description = ""
  default = "arn:aws:servicediscovery:af-south-1:853499284982:service/srv-qtgoi2im4ugj2ubx"
}