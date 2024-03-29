  
# Creates latency monitor alert
resource "datadog_monitor" "latency_monitor" {
  count          = var.enabled && var.latency_enabled ? 1 : 0
  name           = "Latency monitor on ${var.env}:${var.service_name}"
  query          = "avg(${var.latency_threshold_duration}):avg:${var.latency_metric}{env:${var.env},service:${var.service_name}} ${var.latency_alert_threshold}"
  type           = "metric alert"
  notify_no_data = true
  include_tags   = true
  tags = [
    "env:${var.env}",
    "service:${var.service_name}",
    "terraform:true"
  ]
  message = <<EOM
{{#is_no_data}}Monitor doesn't have data on ${var.env}:${var.service_name}{{/is_no_data}}
{{#is_alert}}Latency is high on ${var.env}:${var.service_name}{{/is_alert}}
{{#is_recovery}}Latency is back to normal on ${var.env}:${var.service_name}{{/is_recovery}}
${join(" ", var.notification_targets)}
EOM
}

# Creates latency error rate monitor
resource "datadog_monitor" "error_rate_monitor" {
  count          = var.enabled && var.errors_enabled ? 1 : 0
  name           = "Error rate monitor on ${var.env}:${var.service_name}"
  query          = "sum(${var.error_threshold_duration}):( sum:${var.error_metric}.errors{env:${var.env},service:${var.service_name}}.as_count()/sum:${var.error_metric}.hits{env:${var.env},service:${var.service_name}}.as_count() ) ${var.error_alert_threshold}"
  type           = "metric alert"
  notify_no_data = true
  include_tags   = true
  tags = [
    "env:${var.env}",
    "service:${var.service_name}",
    "terraform:true"
  ]
  message = <<EOM
{{#is_no_data}}Monitor doesn't have data on ${var.env}:${var.service_name}{{/is_no_data}}
{{#is_alert}}Error rate is high on ${var.env}:${var.service_name}{{/is_alert}}
{{#is_recovery}}Error rate is back to normal on ${var.env}:${var.service_name}{{/is_recovery}}
${join(" ", var.notification_targets)}
EOM
}

# Creates abnormal change monitor
resource "datadog_monitor" "abnormal_change" {
  count          = var.enabled && var.abnormal_change_enabled ? 1 : 0
  name           = "Anormal Change monitor on ${var.env}:${var.service_name}"
  query          = "avg(${var.abnormal_change_duration}):( sum:${var.error_metric}.errors{env:${var.env},service:${var.service_name}}.as_count()/sum:${var.error_metric}.hits{env:${var.env},service:${var.service_name}}.as_count() ) ${var.error_alert_threshold}"
  type           = "anomaly alert"
  notify_no_data = true
  include_tags   = true
  tags = [
    "env:${var.env}",
    "service:${var.service_name}",
    "terraform:true"
  ]
  message = <<EOM
{{#is_no_data}}Monitor doesn't have data on ${var.env}:${var.service_name}{{/is_no_data}}
{{#is_alert}}Error rate is high on ${var.env}:${var.service_name}{{/is_alert}}
{{#is_recovery}}Error rate is back to normal on ${var.env}:${var.service_name}{{/is_recovery}}
${join(" ", var.notification_targets)}
EOM
}