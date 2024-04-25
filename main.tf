provider "aws" {
  region = "us-east-1"
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
  default     = "nodejs16.x"
}

variable "memory_size" {
  description = "The amount of memory in MB that the Lambda function can use"
  type        = number
  default     = 128
}

variable "number_value" {
  description = "A number extracted from the JSON input"
  type        = number
  default     = 5
}
variable "zip_file"{
  description = "Path to the zip file"
  type        = string
  default     = "index/function.zip"
}

locals {
    handler = contains(
      ["python3.6", "python3.7", "python3.8", "python3.9", "python3.10", "python3.11", "python3.12"],
      var.runtime
    ) ? "python.handler" : "index.handler"
}

resource "aws_lambda_function" "fibonacci" {
  function_name = "FibonacciFunction"
  role          = "arn:aws:iam::851725442571:role/LabRole"
  handler       = local.handler

  runtime     = var.runtime
  memory_size = var.memory_size

  filename         = var.zip_file
  source_code_hash = filebase64sha256(var.zip_file)
}

data "aws_lambda_invocation" "example_invocation" {
  function_name = "FibonacciFunction"

  input = jsonencode({
    number = var.number_value
  })

  depends_on = [aws_lambda_function.fibonacci]
}

output "result" {
  value = jsondecode(jsondecode(data.aws_lambda_invocation.example_invocation.result)["body"])["result"]
}

output "execution" {
  value = jsondecode(jsondecode(data.aws_lambda_invocation.example_invocation.result)["body"])["execution"]
}
