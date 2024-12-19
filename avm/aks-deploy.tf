module "aks-module" {
  source     = "./aks"

  name                = var.aks_name_module
  resource_group_name = var.rg_name
  location            = var.location

  azure_policy_enabled              = true
  kubernetes_version                = var.k8s_version
  local_account_disabled            = false
  role_based_access_control_enabled = true
  sku_tier                          = "Standard"

  dns_prefix                        = var.aks_name_module
#  dns_prefix_private_cluster        = var.aks_name_module
  private_cluster_enabled           = true
  private_dns_zone_id               = "None"
  private_cluster_public_fqdn_enabled = true

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  identity = {
    type         = "SystemAssigned"
  }

  default_node_pool = {
    name                         = "default"
    vm_size                      = "Standard_B2s"
    vnet_subnet_id               = var.subnet_id
    auto_scaling_enabled         = true
    max_count                    = 2
    min_count                    = 2
  }

  network_profile = {
    network_plugin      = "azure"
    network_policy      = "calico"
  }
}
