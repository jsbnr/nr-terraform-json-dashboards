output "dashboard_id" {
  value = element(regex("^.+\\/([0-9]+)", newrelic_dashboard.exampledash.dashboard_url),0)
}
output "dashboard_url" {
  value = newrelic_dashboard.exampledash.dashboard_url
}