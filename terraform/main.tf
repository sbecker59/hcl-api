module "datadog_apm_monitor" {
  source                     = "./modules/apm"
  enabled                    = true
  latency_enabled            = true
  errors_enabled             = true
  env                        = "none"
  service_name               = "mux.router"
  monitor_type               = "metric alert"
  latency_metric             = "trace.http.request"
  latency_threshold_duration = "last_10m"
  latency_alert_threshold    = "> 0.5"
  error_metric               = "trace.http.request"
  error_threshold_duration   = "last_10m"
  error_alert_threshold      = "> 0.05"
  notification_targets = []
}