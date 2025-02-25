# Terraform GCP Demo

This repository acts as a demo for GitOps integration between Terraform and GCP, using Actions for CI/CD pipelines.

Integration runs with every merged pull request in the default branch, and it can be configured for different
environments by creating specific branches.

### Steps:

* Create a new project in GCP
* Add Cloud Billing and Management in APIs
* Create a service account in IAM (Editor permissions used for demo purposes)
    * Make sure that the account has proper billing permissions
* Add a new JSON key for the new account in IAM
* Create a bucket in Cloud Storage (to hold Terraform's file control state)
* Configure the JSON credentials downloaded in Actions' Secrets
    * File content must not have line breaks in Secrets

Then, the repository needs to have the GitHub Actions workflows configured alongside the Terraform files.

---

### Terraform Quick Guide

All Terraform files are hosted in the **_.terraform_** folder, for easy management.

Files are set as follows:

* _bucket.tf_ - declares the configuration for a bucket in Cloud Storage
* _providers.tf_ - declares the cloud provider, and the backend
    * backend configurations are set inside the Actions workflow
* _variables.tf_ - declares environment variables to be used in other configuration files
    * those variables cannot be used within backend configurations

Some variables used on Terraform files are configured directly on GitHub Actions, for easy management.

To set environment variables on Terraform, they must have the **_TF_VAR__** prefix (e.g.: _TF_VAR_variable-name_)

For backend environment variables file configuration, the file has the recommended naming pattern:
_config.**\<provider-name\>**.tfbackend_

Terraform connects to GCP using the JSON credentials, added through the _GOOGLE_CREDENTIALS_ environment variable.

---

Refer to [Terraform Docs](https://developer.hashicorp.com/terraform/docs) on how to create different resources, and
more.
