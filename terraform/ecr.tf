resource "aws_ecr_repository" "frontend" {
  name = "travel-frontend"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ecr_repository" "backend" {
  name = "travel-backend"

  lifecycle {
    prevent_destroy = true
  }
}
