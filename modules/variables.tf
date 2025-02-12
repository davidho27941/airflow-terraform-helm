#########################################################################
#                 Basic Configuration
#########################################################################

variable "image_repo" {
  description = "Repository of airflow image."
  type = string
  default = "apache/airflow"
}

variable "image_tag" {
  description = "Tag of airflow image."
  type = string
  default = "2.10.2"
}

variable "airflow_version" {
  description = "Airflow version."
  type = string
  default = "2.10.2"
}

variable "namespace" {
  description = "Kubernetes namespace for airflow release."
  type = string
  default = "airflow"
}

variable "deploy_name" {
  description = "Helm release name"
  type = string
  default = "airflow"
}

variable "uid" {
  description = "airflow uid"
  type = string
  default = "50000"
}

variable "secrets_root" {
  description = "folder to place secrets and outputs"
  type = string
}

variable "fernet_key" {
  description = "Fernet key"
  type = string
}

#########################################################################
#                 Webserver Configuration
#########################################################################

variable "enable_webserver" {
  description = "Whether enable ingress."
  type = string
  default = "true"
}

variable "user_web_username" {
  description = "Username for airflow web service."
  type = string
}

variable "enable_ingress_web" {
  description = "Whether enable ingress."
  type = string
  default = "true"
}

variable "enable_ingress_tls" {
  description = "Whether enable ingress."
  type = string
  default = "true"
}

variable "user_web_password" {
  description = "Password for airflow web service."
  type = string
  sensitive = true
}

variable "user_web_email" {
  description = "Email for airflow web service."
  type = string
}

variable "dns_name" {
  description = "DNS Domain for airflow web service."
  type = string
}

variable "tls_cert_name" {
  description = "TLS certs for airflow web service."
  type = string
}

variable "if_expose_config" {
  description = "Wehther to expose webserver configurations"
  type = string
  default = "false"
}

#########################################################################
#                 GitSync Related Configuration
#########################################################################

variable "gitSync_repo" {
  description = "GitSync Repository"
  type = string
}

variable "gitSync_branch" {
  description = "GitSync Repository branch"
  type = string
}

variable "gitSync_secret_filename" {
  description = "GitSync Repository secret name"
  type = string
}

variable "gitSync_subPath" {
  description = "GitSync Repository sub path."
  type = string
}

#########################################################################
#                 Volume and Volume Mount Configuration
#########################################################################

variable "volumes" {
  description = "Configuration for wolume mounts"
  type = list(object({
    name = string
    secret_name = string
  }))
  default = []
}

variable "volume_mounts" {
  description = "Configuration for volume"
  type = list(object({
    name = string
    mount_path = string
    readOnly = string
  }))
  default = []
}

#########################################################################
#                 Environment Variables Configuration
#########################################################################

variable "env_vars" {
  description = "Configuration for environment variables"
  type = list(object({
    name = string
    value = string
  }))
  default = []
}

#########################################################################
#     Extra Environment Variables (for airflow only) Configuration
#########################################################################

variable "extraENV" {
  description = "Configuration of `extraEnv` section in airflow release."
  type = string
  default = ""
}

#########################################################################
#                  Persistenct volume Configuration
#########################################################################

# Worker

variable "worker_persistence_size" {
  description = "Size of persistence volume."
  type = string
  default = "10G"
}

# Triggerer

variable "triggerer_persistence_size" {
  description = "Size of persistence volume."
  type = string
  default = "10G"
}

# Redis

variable "redis_persistence_size" {
  description = "Size of persistence volume."
  type = string
  default = "5G"
}


# logs

variable "enable_dags_persistence" {
  description = "Whether enable persistence volume for dags"
  type = string
  default = "false"
}

variable "dags_persistence_size" {
  description = "Size of persistence volume."
  type = string
  default = "10G"
}


# logs

variable "enable_logs_persistence" {
  description = "Whether enable persistence volume for logs"
  type = string
  default = "false"
}

variable "logs_persistence_size" {
  description = "Size of persistence volume."
  type = string
  default = "10G"
}
