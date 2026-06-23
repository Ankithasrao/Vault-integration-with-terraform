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


## **Enable the new secret engine**

There are many option in vault for enabling the secret engines, you can choose according to your requirment, enable the engine and store the secrets in the particular engines.

<img width="1302" height="767" alt="image" src="https://github.com/user-attachments/assets/f013324a-b7e2-4c33-891b-9dbe33dce0c3" />


## Configure Terraform to read the secret from Vault


Detailed steps to enable and configure AppRole authentication in HashiCorp Vault:

1. **Enable AppRole Authentication**:

To enable the AppRole authentication method in Vault, you need to use the Vault CLI or the Vault HTTP API.

**Using Vault CLI**:

Run the following command to enable the AppRole authentication method:

```bash
vault auth enable approle
```

This command tells Vault to enable the AppRole authentication method.

<img width="1357" height="762" alt="image" src="https://github.com/user-attachments/assets/c703fc80-4144-4498-9017-598275aea227" />


2. **Create an AppRole**:

Now you'll need to create an AppRole with appropriate policies and configure its authentication settings.

We need to create policy first,

```
vault policy write terraform - <<EOF
path "*" {
  capabilities = ["list", "read"]
}

path "secrets/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "kv/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}


path "secret/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "auth/token/create" {
capabilities = ["create", "read", "update", "list"]
}
EOF
```
<img width="962" height="572" alt="terraform vault 3" src="https://github.com/user-attachments/assets/2db52e27-41a8-4e68-a1c2-5cc56880b30d" />


**a. Create the AppRole**: Here are the steps to create an AppRole

```bash
vault write auth/approle/role/terraform \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=terraform
```
<img width="982" height="201" alt="terraform vault 4" src="https://github.com/user-attachments/assets/3df37d55-18f4-45bf-8c3a-4d9b0010e9ae" />


3. **Generate Role ID and Secret ID**:

After creating the AppRole, you need to generate a Role ID and Secret ID pair. The Role ID is a static identifier, while the Secret ID is a dynamic credential.

**a. Generate Role ID**:

You can retrieve the Role ID using the Vault CLI:

```bash
vault read auth/approle/role/my-approle/role-id
```

Save the Role ID for use in your Terraform configuration.

**b. Generate Secret ID**:

To generate a Secret ID, you can use the following command:

```bash
vault write -f auth/approle/role/my-approle/secret-id
   ```

This command generates a Secret ID and provides it in the response. Save the Secret ID securely, as it will be used for Terraform authentication.

<img width="1156" height="347" alt="terraform vault 5" src="https://github.com/user-attachments/assets/2cf1f3ed-ef41-4d9c-a286-2c063baf0c91" />


#### Now that we are done with Vault, the next step is to write down the Terraform project and check whether Terraform is able to read the secret from Vault.

### 🔐 Terraform Vault Provider Configuration:
```
provider "vault" {
  address = "http://65.1.86.138:8200" // change it according to your address
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "fda817b9-8b25-6627-2ed5-fb43fd2b21d9"
      secret_id = "6f8f44b7-1ba6-7092-40cb-dcd621bfa0ce"
    }
  }
}
```

### Retrieve Secrets from Vault:
```
data "vault_kv_secret_v2" "example" {
  mount = "kv" // change it according to your mount
  name  = "test-secret" // change it according to your secret
}
```
### ☁️ AWS resource Configuration:
```
resource "aws_instance" "my_instance" {
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
    Secret = data.vault_kv_secret_v2.example.data["username"]
  }
}
```
### 🚀 Deploy Infrastructure

Initialize Terraform:
```
terraform init
```
Validate Configuration:
```
terraform validate
```
Review Execution Plan:
```
terraform plan
```
Apply Changes:
```
terraform apply
```

<img width="880" height="577" alt="image" src="https://github.com/user-attachments/assets/6041a423-15d4-4768-ada5-50105c587237" />


## Note : If you encounter the following error while running ‘terraform apply’ command, then run it again to recreate ‘role-id’ and ‘secret-id’ with the same command as mentioned in step no. 20. After that, paste the new credentials into the code. This will solve your problem.

<img width="835" height="357" alt="image" src="https://github.com/user-attachments/assets/28438292-7c7e-4210-bd60-2230287af4df" />

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

## Credit : Abhishek Veeramalla

## ⭐ Support

If you found this project helpful, consider giving it a ⭐ on GitHub.

