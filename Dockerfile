FROM mcr.microsoft.com/powershell:debian-stretch-slim

# Install misc tools via APT
RUN apt-get update \
    && apt-get install -y curl jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# AWS PowerShell Module
RUN pwsh -Command Install-Module -Name AWSPowerShell.NetCore -Scope AllUsers -Force

# Slack PowerShell Module
RUN pwsh -Command Install-Module -Name PSSlack -Scope AllUsers -Force

# Kubectl
ENV KUBECTL_VERSION=1.12.0

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/
