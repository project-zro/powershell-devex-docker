FROM mcr.microsoft.com/powershell:debian-stretch-slim

# Install misc tools via APT
RUN apt-get update \
    && apt-get install -y curl jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Kubectl
ENV KUBECTL_VERSION=1.16.0

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-Module AWSPowerShell.NetCore -Confirm:$false -AcceptLicense -Force -RequiredVersion 4.0.5