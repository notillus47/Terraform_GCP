resource "google_container_cluster" "petclinic_gke" {
  provider                 = google-beta

  name                     = "private"
  location                 = "asia-northeast-3"

  network                  = google_compute_network.petclinic_vpc.name
  subnetwork               = google_compute_subnetwork.petclinic_ane3.id

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.gke_master_ipv4_cidr_block
  }

#  master_authorized_networks_config {
#    dynamic "cidr_blocks" {
#        for_each = var.authorized_source_ranges
#        content {
#            cidr_block = cidr_blocks.value
#        }
#    }
#   }

  maintenance_policy {
    recurring_window {
      start_time = "2021-06-18T00:00:00Z"
      end_time   = "2050-01-01T04:00:00Z"
      recurrence = "FREQ=WEEKLY"
    }
  }

  # Enable Autopilot for this cluster
  enable_autopilot = true

  # Configuration of cluster IP allocation for VPC-native clusters
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  # Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters.
  release_channel {
    channel = "REGULAR"
  }
}

variable "gke_master_ipv4_cidr_block" {
  type    = string
  default = "172.23.0.0/28"
}
