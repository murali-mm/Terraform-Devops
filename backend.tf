terraform {
  backend "azurerm" {
  #access_key           = "kNm8tvv3Eqz+FuYOi3qJBxzdtDuUuSpbUmGKz7Qgu1YmcGLqUSZnzEa+4WPuyLguYmG46ueMobEX+ASt/8Epuw=="  # Can also be set via `ARM_ACCESS_KEY` environment variable.
    storage_account_name = "backendstr01"                                 # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                                  # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "terraform.tfstate"                   # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}
