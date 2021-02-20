project = "hcl-api"

app "hcl-api" {
    
  build {
    use "pack" {}

    registry {
      use "docker" {
        image = "gcr.io/huskyly/hcl-api"
        tag   = "latest"
      }
    }
  }

  deploy {
    use "google-cloud-run" {
      project  = "huskyly"
      location = "europe-north1"

      port = 3000

      capacity {
        memory                     = 128
        cpu_count                  = 1
        max_requests_per_container = 10
        request_timeout            = 300
      }

      service_account_name = "cloudrun@huskyly.iam.gserviceaccount.com"

      auto_scaling {
        max = 10
      }
    }
  }

  release {
    use "google-cloud-run" {}
  }
}