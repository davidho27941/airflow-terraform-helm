variable "airflow_env" {
  description = "Environment variable setting for airflow release"
  type = list(object({
    name = string
    value = string
  }))
  default = [ {
      name = "<your first env var name>"
      value = "<your first env var value>"
    },
    {
      name = "<your second env var name>"
      value = "<your second env var value>"
    } ]
}

variable "airflow_extraEnv" {
  description = "Configuration of `extraEnv` section in airflow release."
  type = string
  default = <<-EOT
    - name: AIRFLOW__CORE__DEFAULT_TIMEZONE
      value: "Asia/Taipei"
    EOT
}

variable "airflow_volumes" {
  description = "Volume setting for airflow release"
  type = list(object({
    name = string
    secret_name = string
  }))
  default = [ {
      name = "<your first k8s volume name>"
      secret_name = "<your first k8s volume secret name>"
    } ]
}

variable "airflow_volume_mounts" {
  description = "Volume setting for airflow release"
  type = list(object({
    name = string
    mount_path = string
    readOnly = string
  }))
  default = [ {
      name = "<your first k8s volume mount name>"
      mount_path = "<your first k8s volume mount path"
      readOnly = "true"
    } ]
}