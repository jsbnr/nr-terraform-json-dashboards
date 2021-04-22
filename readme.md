# Terraform New Relic Dashboards with JSON

**This project is superceded by [this one](https://github.com/jsbnr/nr-terraform-json-nr1-dashboards) that supports NR1 Dashboards**

Example project showing how a dashboard can be managed in terraform but configured via a json template. This allows the dashboard to be designed in the UI, downloaded via the REST API and used as an input template to terraform, thus reducing the toil of maintaining widgets with HCL.

Ensure that the new relic license key is set in the env var NEWRELIC_API_KEY

The source JSON can include templates in the form "${variable_name}". Simply add each token to the map as in the example:

Usage example:
```main.tf
module "json_dash1" {
  source = "./modules/json_dashboard"
  json = templatefile("${path.module}/resources/json_dashboards/dash.json", 
    {                                       # template replacer variables
      dashboardName = "Example 1", 
      search        ="replace",
      etc           ="etc" 
    }
  )
}
```


## Getting a dashboard template
Existing dashboard JSON needs to be retrieved via the REST API. See helper script: modules/json_dashboard/get_dash.sh

## How it works
This works by leveraging the null_resource resource type. The content of the JSON file is used as the trigger to this resource - so when it changes the resource is marked as requring an update and it uses a local provisioner to upload the JSON to New Relic via the REST API.


