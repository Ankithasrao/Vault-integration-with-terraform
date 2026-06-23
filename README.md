# Vault-integration-with-terraform

# Vault Integration with Terraform

## 📖 Overview

This project demonstrates how to integrate **HashiCorp Vault** with **Terraform** to securely manage and retrieve secrets during infrastructure provisioning.

Instead of hardcoding sensitive information such as AWS credentials, database passwords, or API keys in Terraform code, Vault acts as a centralized secret management solution. Terraform authenticates with Vault and dynamically retrieves secrets at runtime, improving security and compliance.

---

## 🚀 Features

* Secure secret management using HashiCorp Vault
* Dynamic retrieval of secrets in Terraform
* Elimination of hardcoded credentials
* Support for AWS infrastructure provisioning
* Improved security and compliance
* Centralized secret storage and access control

---

## 🏗️ Architecture

```text
                +----------------+
                |  Terraform     |
                +--------+-------+
                         |
                         |
                         v
                +----------------+
                | HashiCorp Vault|
                +--------+-------+
                         |
                         |
                         v
                +----------------+
                | AWS Resources  |
                +----------------+
```

Terraform authenticates with Vault, retrieves required secrets, and uses them to provision infrastructure on AWS.

---

## 🛠️ Prerequisites

Before getting started, ensure the following are installed:

* Terraform >= 1.0
* HashiCorp Vault
* AWS Account
---

## 🔒 Security Benefits

* No credentials stored in Terraform code
* Centralized secret management
* Fine-grained access control
* Secret rotation without code changes
* Reduced risk of credential leakage

---

# Vault Integration

Here are the detailed steps for each of these steps:

## Create an AWS EC2 instance with Ubuntu

To create an AWS EC2 instance with Ubuntu, you can use the AWS Management Console or the AWS CLI. Here are the steps involved in creating an EC2 instance using the AWS Management Console:

- Go to the AWS Management Console and navigate to the EC2 service.
- Click on the Launch Instance button.
- Select the Ubuntu Server xx.xx LTS AMI.
- Select the instance type that you want to use.
- Configure the instance settings.
- Click on the Launch button.

## Install Vault on the EC2 instance

To install Vault on the EC2 instance, you can use the following steps:

**Install gpg**

```
sudo apt update && sudo apt install gpg
```

**Download the signing key to a new keyring**

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

**Verify the key's fingerprint**

```
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
```

**Add the HashiCorp repo**

```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

```
sudo apt update
```

**Finally, Install Vault**

```
sudo apt install vault
```

## Start Vault.

To start Vault, you can use the following command:

```
vault server -dev -dev-listen-address="0.0.0.0:8200"
```

#### Note : dev mode is enabled! In this mode, Vault runs entirely in-memory and starts unsealed with a single unseal key. The root token is already authenticated to the CLI, so you can immediately begin using Vault.

#### You may need to set the following environment variables: (otherwise you will ran into the below shown error)
```
    $ export VAULT_ADDR='http://0.0.0.0:8200'
```
<img width="1872" height="147" alt="terraform vault" src="https://github.com/user-attachments/assets/08036a13-90c8-442a-bc03-49909427188a" />

## Configure Terraform to read the secret from Vault.

Detailed steps to enable and configure AppRole authentication in HashiCorp Vault:

1. **Enable AppRole Authentication**:

To enable the AppRole authentication method in Vault, you need to use the Vault CLI or the Vault HTTP API.

**Using Vault CLI**:

Run the following command to enable the AppRole authentication method:

```bash
vault auth enable approle
```

This command tells Vault to enable the AppRole authentication method.



















## 📊 Use Cases

* AWS Infrastructure Provisioning
* Multi-Cloud Deployments
* CI/CD Pipeline Integrations
* Kubernetes Secret Management
* Dynamic Database Credentials

---

## 🎯 Learning Outcomes

Through this project, you will learn:

* Terraform Vault Provider usage
* Secret management best practices
* Secure Infrastructure as Code (IaC)
---

## ⭐ Support

If you found this project helpful, consider giving it a ⭐ on GitHub.

