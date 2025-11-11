terraform {
  cloud {
    organization = "phinehas-org"

    workspaces {
      name = "flask-cicd-app"
    }
  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "tcp://192.168.56.103:2375"
}

resource "docker_image" "flask_app" {
  name         = "phinehasishaya/flask-cicd-app:latest"
  keep_locally = false
}

resource "docker_container" "flask_app" {
  name  = "flask-cicd-container"
  image = docker_image.flask_app.name
  ports {
    internal = 5000
    external = 5000
  }
}
