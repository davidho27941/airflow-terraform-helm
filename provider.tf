terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.15.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.32.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
  
}

provider "kubernetes" {
  config_path = "<path to k8s config>"
}

provider "helm" {
  kubernetes {
    config_path = "<path to k8s config>"
  }

  registry {
    url = "<URL to registery>"
    username = "<user name of registery>"
    password = "<password of registery>"
  }
}

