variables {
  access_key="${env("AWS_ACCESS_KEY_ID")}"
  secret_key="${env("AWS_SECRET_ACCESS_KEY")}"
}

source "docker" "aspnet" {
  image = "mcr.microsoft.com/dotnet/aspnet:7.0"
  commit = true
  changes = [
    "ENV FOO bar",
    "EXPOSE 80",
    "WORKDIR /cfl",
    "CMD [\"/cfl/coneflip-backend.dll\"]",
    "ENTRYPOINT [\"/usr/bin/dotnet\"]"
  ]
}

build {
  sources = ["source.docker.aspnet"]

  provisioner "shell" {
    inline = ["mkdir /cfl"]
  }

  provisioner "file" {
    source = "../output/"
    destination = "/cfl"
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "550661752655.dkr.ecr.eu-west-1.amazonaws.com/coneflip-leaderboard-backend"
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
