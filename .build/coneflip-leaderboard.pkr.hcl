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
    inline = ["mkdir -p /mitlan/nginx/coneflip-leaderboard","mkdir -p /mitlan/dotnet/coneflip-leaderboard"]
  }

  provisioner "file" {
    source = "../coneflip-frontend/"
    destination = "/mitlan/nginx/coneflip-leaderboard"
  }

  provisioner "file" {
    source = "../coneflip-backend"
    destination = "/tmp"
  }

  provisioner "shell" {
    inline = ["sudo dnf install dotnet-sdk-7.0 aspnetcore-runtime-7.0 dotnet-runtime-7.0"]
  }

  provisioner "shell" {
    inline = ["dotnet build /tmp/coneflip-backend/coneflip-backend.csproj /mitlan/dotnet/coneflip-leaderboard"]
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "550661752655.dkr.ecr.eu-west-1.amazonaws.com/coneflip-leaderboard"
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
