#!/bin/bash


# Install Packages (Ansible, zip, git, jq)
    apt update -y \
    && apt-get install -y --no-install-recommends \
        gpg \
        lsb-core \
        zip \
        git \
        ansible \
        jq \
        terraform \

# Install Terraform
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    # Install the HashiCorp GPG key.
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    # Verify the key's fingerprint.
    gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
    # Add the official HashiCorp repository to your system.
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
    # Download the package information from HashiCorp and Install Terraform.
    sudo apt update -y && sudo apt-get install terraform -y


# Install KUBECTL + MiniKube + Helm
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube-linux-amd64
    sudo mv minikube-linux-amd64 /usr/local/bin/minikube
    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    minikube start --kubernetes-version=v1.25.0