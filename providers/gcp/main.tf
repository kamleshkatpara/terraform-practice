terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.75.1"
    }
  }
}

provider "google" {
  credentials = "terraform-gcp-example-394222-f5b444739812.json"
  project     = "terraform-gcp-example-394222"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }


  network_interface {
    network = "default"
    access_config {}
  }

}
