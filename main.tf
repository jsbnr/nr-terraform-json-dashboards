
provider "newrelic" {}

module "json_dash1" {
  source = "./modules/json_dashboard"
  json = templatefile("${path.module}/resources/json_dashboards/dash.json", 
    { 
      dashboardName   = "Example 1"                   # Just examples of templating feature,
      anotherExample  = "Interpolated value here"     # can be omitted!
    }

  )
}


# Output fomr the module:
output "dashboard_id" {
  value = module.json_dash1.dashboard_id
}
output "dashboard_url" {
  value = module.json_dash1.dashboard_url
}