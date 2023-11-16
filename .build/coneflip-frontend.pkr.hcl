variables {
  access_key="${env("AWS_ACCESS_KEY_ID")}"
  secret_key="${env("AWS_SECRET_ACCESS_KEY")}"
}

source "docker" "nginx" {
  image = "nginx"
  commit = true
  changes = [
    "ENV FOO bar",
    "ENTRYPOINT [\"nginx\", \"-g\", \"daemon off;\"]"
  ]
}

build {
  sources = ["source.docker.nginx"]

  provisioner "file" {
    source = "../coneflip-frontend/"
    destination = "/usr/share/nginx/html"
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "550661752655.dkr.ecr.eu-west-1.amazonaws.com/coneflip-leaderboard-frontend"
      tags       = ["latest"]
    }

    post-processor "docker-push" {
      ecr_login = true
      aws_access_key = var.access_key
      aws_secret_key = var.secret_key
      login_server = "https://550661752655.dkr.ecr.eu-west-1.amazonaws.com/mitlan"
    }
  }
}
