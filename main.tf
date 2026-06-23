provider "aws" {
  region = "us-east-1"
}

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

data "vault_kv_secret_v2" "example" {
  mount = "kv" // change it according to your mount
  name  = "test-secret" // change it according to your secret
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
    Secret = data.vault_kv_secret_v2.example.data["username"]
  }
}
