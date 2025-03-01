# Terraform Demo

This repository acts as a demo for GitOps integration between Terraform and cloud providers, using Actions for
CI/CD pipelines.

Integration runs with every merged pull request in the default branch, and it can be configured for different
environments by creating specific branches.

### Steps for AWS:

* Create new user in IAM
    * IAM > Users > Create user
    * Added EC2 and S3 full access permissions for demo purposes
* Create access key to created user
* Copy access key and secret to GitHub Actions Secrets (Access key and Secret access key)
* Create S3 storage (to hold Terraform's file control state)
    * Amazon S3 > Create bucket

Then, the repository needs to have the GitHub Actions workflow configured alongside the Terraform files.

### Steps for Azure:

* Create Managed Identity in Azure Portal
    * Services > Managed Identities > Add
* Add role to created identity in Azure Portal
    * Services > Managed Identities > your identity > Access Control (IAM) > Add > Role assignment
    * Used Contributor role for demo purposes
* Add Federated Credential to created identity in Azure Portal
    * Services > Managed Identities > your identity > Settings > Federated Credentials > Add Credential
* Add created identity to Subscriptions (to create resources)
    * Subscriptions > your subscription > Access Control (IAM) > Add role assignment
    * Used Contributor role for demo purposes
* Copy ID info to GitHub Actions variables (Client ID, Subscription ID, Tenant ID and Object ID)
* Create Storage account in Azure Portal (to hold Terraform's file control state)
    * Add created identity to Access Control (IAM)
    * Create container for hosting Terraform's file control state
    * Make sure that network access is properly configured in storage account

Then, the repository needs to have the GitHub Actions workflow configured alongside the Terraform files.

### Steps for GCP:

* Create a new project
* Add Cloud Billing and Management in APIs
* Create a service account in IAM (Editor permissions used for demo purposes)
    * Make sure that the account has proper billing permissions
* Add a new JSON key for the new account in IAM
* Create a bucket in Cloud Storage (to hold Terraform's file control state)
* Configure the JSON credentials downloaded in Actions' Secrets
    * File content must not have line breaks in Secrets

Then, the repository needs to have the GitHub Actions workflow configured alongside the Terraform files.

---

### Terraform Quick Guide

All Terraform files are hosted in the **_.terraform_** folder, for easy management.

Files are set as follows:

* _providers.tf_ - declares the cloud provider, and the backend
    * backend configurations are set inside the Actions workflow
* _variables.tf_ - declares environment variables to be used in other files
    * those variables cannot be used within backend configurations
* Other files are declared on-demand, since Terraform processes all files within a directory

Some variables used on Terraform files are configured directly on GitHub Actions, for easy management.

To set environment variables on Terraform, they must have the **_TF_VAR__** prefix (e.g.: _TF_VAR_variable-name_)

For backend environment variables file configuration, the file has the recommended naming pattern:
_config.**\<provider-name\>**.tfbackend_

For GCP, Terraform connects using the JSON credentials, added through the _GOOGLE_CREDENTIALS_ environment variable.

For Azure, Terraform connects , using Azure credentials hosted in Actions' Secrets.

---

[Terraform Docs](https://developer.hashicorp.com/terraform/docs) > how to create different resources, and more.

[Azure Login with OIDC](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure-openid-connect) >
how to connect GitHub Actions to Azure (option 2).
