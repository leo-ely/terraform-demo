# Terraform Demo

This repository acts as a demo for GitOps integration between Terraform and cloud providers, using Actions for
CI/CD pipelines.

Integration runs with a Actions workflow dispatch trigger, and it can be configured for different environments by
creating specific branches and environments. Protection rules block deploying in production environments from any other
branch besides the default one.

This repository also integrates with [Ansible](https://github.com/leo-ely/ansible-demo), triggering its execution with
every merge to the default branch. A Personal Access Token (PAT) with _repo_ permissions is required for the trigger.

## First run

Three workflows can be triggered inside Actions, where they act as a bootstrapper for creating the resources in each of
the cloud providers to save Terraform's state file.

They should be run only once, since they create the resources with a generic backend, and will fail if rerun (because
resources already exist).

### Steps for AWS:

* Create new user in IAM
    * IAM > Users > Create user
    * Added EC2 and S3 full access permissions for demo purposes
* Create access key to created user
* Copy access key and secret to GitHub Actions Secrets (Access key and Secret access key)

Then, the repository needs to have the GitHub Actions workflow configured alongside the Terraform files.

### Steps for Azure:

* Create Managed Identity in Azure Portal
    * Services > Managed Identities > Add
    * Create Resource group if needed (same group to be used in Terraform file)
* Add role to created identity in Azure Portal
    * Services > Managed Identities > your identity > Access Control (IAM) > Add > Role assignment
    * Used Contributor role for demo purposes
* Add Federated Credential to created identity in Azure Portal
    * Services > Managed Identities > your identity > Settings > Federated Credentials > Add Credential
* Add created identity to Subscriptions (to create resources)
    * Subscriptions > your subscription > Access Control (IAM) > Add role assignment
    * Used Contributor role for demo purposes
    * Make sure that your subscription has the proper resource providers registered
        * Subscriptions > your subscription > Settings > Resource providers
* Copy ID info to GitHub Actions variables (Client ID, Subscription ID, Tenant ID and Object ID)

Then, the repository needs to have the GitHub Actions workflow configured alongside the Terraform files.

### Steps for GCP:

* Create a new project
* Add Cloud Billing and Management in APIs
* Create a service account in IAM (Editor permissions used for demo purposes)
    * Make sure that the account has proper billing permissions
* Add a new JSON key for the new account in IAM
* Configure the JSON credentials downloaded in Actions' Secrets
    * File content must not have line breaks in Secrets

Then, the repository needs to have the GitHub Actions workflow configured alongside the Terraform files.

---

### Terraform Quick Guide

All Terraform files are hosted in the **_.terraform_** folder, for easy management.

Each cloud provider has its own folder and set of files.

Files are set as follows:

* _main.tf_ - declares the modules hosted in each folder inside _modules_
    * resources are separated in folders for easy management
* _providers.tf_ - declares the cloud provider, and the backend
    * backend configurations are set inside the Actions workflow
* _variables.tf_ - declares environment variables to be used in other files
    * those variables cannot be used within backend configurations
* Other files are declared on-demand, since Terraform processes all files within a directory

Some variables used on Terraform files are configured directly on GitHub Actions, for easy management.

To set environment variables on Terraform, they must have the **_TF_VAR__** prefix (e.g.: _TF_VAR_variable-name_)

For backend environment variables file configuration, the file has the recommended naming pattern:
_config.**\<provider-name\>**.tfbackend_

---

[Terraform Docs](https://developer.hashicorp.com/terraform/docs) > how to create different resources, and more.

[Azure Login with OIDC](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure-openid-connect) >
how to connect GitHub Actions to Azure (option 2).
