resource "helm_release" "airflow" {
    repository = "https://airflow.apache.org"
    chart = "airflow"
    name = var.deploy_name

    namespace = var.namespace
    create_namespace = true

    set {
        name = "createUserJob.useHelmHooks"
        value = "false"
    }

    set {
        name = "createUserJob.applyCustomEnv"
        value = "false"
    }

    set {
        name = "migrateDatabaseJob.useHelmHooks"
        value = "false"
    }

    set {
        name = "migrateDatabaseJob.applyCustomEnv"
        value = "false"
    }

    set {
        name = "defaultAirflowRepository"
        value = var.image_repo
    }
    
    set {
        name = "defaultAirflowTag"
        value = var.image_tag
    }

    set {
        name = "airflowVersion"
        value = var.airflow_version
    }

    set {
        name = "images.airflow.repository"
        value = var.image_repo
    }
    
    set {
        name = "images.airflow.tag"
        value = var.image_tag
    }

    set {
        name = "executor"
        value = "KubernetesExecutor"
    }

    set {
        name = "webserver.enabled"
        value = var.enable_webserver
    }

    set {
        name = "config.webserver.expose_config"
        value = var.if_expose_config
    }

    set {
        name = "webserver.defaultUser.username"
        value = var.user_web_username
    }

    set {
        name = "webserver.defaultUser.email"
        value = var.user_web_email
    }

    set {
        name = "webserver.defaultUser.password"
        value = var.user_web_password
    }

    set {
        name = "statsd.uid"
        value = var.uid
    }

    set {
        name = "ingress.web.enabled"
        value = var.enable_ingress_web
    }

    set_list {
        name = "ingress.web.hosts"
        value = [var.dns_name]
    }

    set {
        name = "ingress.web.tls.enabled"
        value = var.enable_ingress_tls
    }

    set {
        name = "ingress.web.tls.secretName"
        value = var.tls_cert_name
    }

    set {
        name = "extraEnv"
        value = var.extraENV
    }

    set {
        name = "dags.gitSync.enabled"
        value = "true"
    }

    set {
        name = "dags.gitSync.repo"
        value = var.gitSync_repo
    }

    set {
        name = "dags.gitSync.branch"
        value = var.gitSync_branch
    }

    set {
        name = "dags.gitSync.sshKeySecret"
        value = kubernetes_secret_v1.airflow-git-ssh-secret.metadata[0].name
    }

    set {
        name = "dags.gitSync.subPath"
        value = var.gitSync_subPath
    }

    set {
        name = "fernetKey"
        value = var.fernet_key
    }

    set {
        name = "webserverSecretKey"
        value = random_id.webserver_key.hex

    }

    set {
        name = "extraEnv"
        value = var.extraENV
    }

    dynamic "set" {
      for_each = var.env_vars
      content {
        name = "env[${set.key}].name"
        value = set.value["name"]
      }
    }

    dynamic "set" {
      for_each = var.env_vars
      content {
        name = "env[${set.key}].value"
        value = set.value["value"]
      }
    }

    dynamic "set" {
      for_each = var.volumes
      content {
        name = "volume[${set.key}].name"
        value = set.value["name"]
      }
    }

    dynamic "set" {
      for_each = var.volumes
      content {
        name = "volume[${set.key}].secret.secretName"
        value = set.value["secret_name"]
      }
    }

    dynamic "set" {
      for_each = var.volume_mounts
      content {
        name = "volume[${set.key}].name"
        value = set.value["name"]
      }
    }

    dynamic "set" {
      for_each = var.volume_mounts
      content {
        name = "volume[${set.key}].mount_path"
        value = set.value["mount_path"]
      }
    }

    dynamic "set" {
      for_each = var.volume_mounts
      content {
        name = "volume[${set.key}].readOnly"
        value = set.value["readOnly"]
      }
    }

    set {
        name = "workers.persistence.size"
        value = var.worker_persistence_size
    }

    set {
        name = "triggerer.persistence.size"
        value = var.triggerer_persistence_size
    }

    set {
        name = "redis.persistence.size"
        value = var.redis_persistence_size
    }

    set {
        name = "dags.persistence.enabled"
        value = var.enable_dags_persistence
    }

    set {
        name = "dags.persistence.size"
        value = var.dags_persistence_size
    }

    set {
        name = "logs.persistence.enabled"
        value = var.enable_logs_persistence
    }

    set {
        name = "logs.persistence.size"
        value = var.logs_persistence_size
    }

    depends_on = [ kubernetes_secret_v1.airflow-git-ssh-secret ]

}

resource "local_file" "airflow_release_note" {
  filename = "${var.secrets_root}/release_notes/${var.deploy_name}/notes.txt"
  content = helm_release.airflow.metadata[0].notes
  depends_on = [ helm_release.airflow ]
}

output "test" {
    value = jsondecode(jsonencode(helm_release.airflow.set))
    sensitive = true
}