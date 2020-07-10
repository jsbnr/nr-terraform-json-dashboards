variable "json" {
  type = string
}

resource "newrelic_dashboard" "exampledash" {
  title = "Terraform Provsioner"
   lifecycle {

    #ignore attributes changed by json 
    ignore_changes = [
      title,editable,grid_column_count,icon,widget,icon,visibility,filter
    ]
  }
}

resource "null_resource" "dashboard" {
  depends_on = [
    newrelic_dashboard.exampledash,
  ]
  triggers = {
    dashjson = var.json
  }
  provisioner "local-exec" {
    command = "${path.module}/update_dash.sh ${element(regex("^.+\\/([0-9]+)", newrelic_dashboard.exampledash.dashboard_url),0)} ${base64encode(var.json)}"
  }
}
