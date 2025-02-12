resource "random_id" "webserver_key" {
  byte_length = 16
}

resource "kubernetes_secret_v1" "airflow-git-ssh-secret" {
  metadata {
    name = "airflow-git-ssh-secret"
    namespace = var.namespace
  }

  data = {
    "gitSshKey": file("${var.gitSync_secret_filename}")
  }
}