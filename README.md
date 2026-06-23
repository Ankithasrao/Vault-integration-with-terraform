# Vault-integration-with-terraform

## 📖 Overview
## This project demonstrates how to integrate HashiCorp Vault with Terraform to securely manage and retrieve secrets during infrastructure provisioning.

### Instead of hardcoding sensitive information such as AWS credentials, database passwords, or API keys in Terraform code, Vault acts as a centralized secret management solution. Terraform authenticates with Vault and dynamically retrieves secrets at runtime, improving security and compliance.

## 🚀 Features
### 1. Secure secret management using HashiCorp Vault
### 2. Dynamic retrieval of secrets in Terraform
### 3. Elimination of hardcoded credentials
### 4. Support for AWS infrastructure provisioning
### 5. Improved security and compliance
### 6. Centralized secret storage and access control

## 🏗️ Architecture
``` text
| Terraform | +--------+-------+ | | v +----------------+ | HashiCorp Vault| +--------+-------+ | | v +----------------+ | AWS Resources | +----------------+
```
