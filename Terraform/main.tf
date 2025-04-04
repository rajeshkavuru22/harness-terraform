provider "google" {
  project = harness-455805
  region  = us-central1-a
}

resource "google_container_cluster" "gke_cluster" {
  name     = "my-backend-cluster"
  location = us-central1-a
  remove_default_node_pool = true
  initial_node_count = 1
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.gke_cluster.name
  location   = us-central1-a
  node_count = 2
  node_config {
    machine_type = "e2-medium"
  }
}

output "kubeconfig" {
  value = google_container_cluster.gke_cluster.endpoint
}
