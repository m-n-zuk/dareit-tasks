provider "google" {
  project = "data-tangent-378423"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_default_object_access_control" "public_rule" {
  bucket = google_storage_bucket.bucket.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket" "bucket" {
  name = "task_6_cloud"
  project = "data-tangent-378423"
  storage_class = "standard"
  location = "EU"
}

resource "google_compute_instance" "dare-id-vm" {
  name         = "my-dareit-vm-tf"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["dareit"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}

resource "google_sql_database_instance" "instance" {
  name             = "postgres-task-6"
  database_version = "POSTGRES_14"
  root_password    = "abcABC123!"
  settings {
    tier = "db-custom-2-7680"
  }
}

resource "google_sql_database" "database" {
  name = "dareit"
  instance = "postgres-task-6"
  charset = "utf8"
}

resource "google_sql_user" "users" {
  name = "dareit_user"
  instance = "postgres-task-6"
  password = "abcABC123!"
}
