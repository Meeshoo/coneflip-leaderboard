variables {
  access_key="${env("AWS_ACCESS_KEY_ID")}"
  secret_key="${env("AWS_SECRET_ACCESS_KEY")}"
}

source "docker" "fedora" {
  image = "fedora"
  commit = true
}

build {
  sources = ["source.docker.fedora"]

  provisioner "shell" {
    inline = ["echo hello > /tmp/test.txt"]
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "550661752655.dkr.ecr.eu-west-1.amazonaws.com/mitlan/coneflip-leaderboard"
      tags       = ["latest"]
    }

    post-processor "docker-push" {
      ecr_login = true
      aws_access_key = var.access_key
      aws_secret_key = var.secret_key
      login_server = "550661752655.dkr.ecr.eu-west-1.amazonaws.com/mitlan"
    }
  }
}

