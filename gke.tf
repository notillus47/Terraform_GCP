resource "google_container_cluster" "primary" {
  name     = "test-gke"
  location = "asia-northeast3"
 
  network    = google_compute_network.petclinic_vpc.name
  subnetwork = google_compute_subnetwork.petclinic_ane3.name
 
# Enabling Autopilot for this cluster
  enable_autopilot = true
}
