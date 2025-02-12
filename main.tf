module "airflow" {
  source = "./modules/airflow"

  # Basic config
  deploy_name = "airflow"
  namespace = "airflow"

  # Webserver related
  user_web_username = "<your username>"
  user_web_password = "<your password>"
  user_web_email = "<your email>"
  dns_name = "DNS name for your airflow deployment"
  if_expose_config = "true"
  tls_cert_name = "<your tls secret for ingress and DNS>"

  # GitSync related
  gitSync_repo = "<your repo>"
  gitSync_branch = "<your path>"
  gitSync_subPath = "<your subpath in repo>"
  gitSync_secret_filename = "<path to your ssh key secret>"

  # Volume & Volume Mount config
  volumes = var.airflow_volumes
  volume_mounts = var.airflow_volume_mounts

  # Environment and extraEnv config
  env_vars = var.airflow_env
  extraENV = var.airflow_extraEnv

  # Output file path
  secrets_root = "<path to place output file>"
  fernet_key = "<your fernet key>"

}
