terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
      version = "3.2.0"
    }
  }
}

provider "datadog" {
    api_url = "https://api.datadoghq.eu/"
}