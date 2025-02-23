# Terraform GCP Demo

This repository acts as a demo for GitOps integration between Terraform and GCP, using Actions for the CI/CD pipelines.

Integration runs with every merged pull request in the default branch, and it can be configured for different
environments by creating specific branches.

## Steps:

* Create a new project in GCP
* Create a service account in IAM (Editor permissions used for demo purposes)
* Add a new JSON key for the new account in IAM
* Create a bucket in Cloud Storage (to hold Terraform's file control state)
* Configure the JSON credentials downloaded in Actions' Secrets

Then, the repository needs to have the GitHub Actions workflows configured alongside the Terraform files.

---
