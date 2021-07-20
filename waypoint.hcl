project = "hcl-api"

app "hcl-api" {

  labels = {
    service = "hcl-api",
    env = "prod"
  }
    
  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "localhost:5000/hcl-api"
        tag = "latest"
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
    }
  }

  release {
    use "kubernetes" {
    }
  }

}