# The Dockerfile for universal devcontainer image which I use for all my projects.
# It contains all the sdk's, tools and utilities and can be used to instantly start working on any project.

# ----------------
# --- Settings ---
# ----------------

# Common
# buildpack-deps:24-04 (as of 2024-06-16)
ARG BASE_IMAGE=buildpack-deps@sha256:9f35d074ab95834d6be3e55f54306ebe6bc53bf79e68601b46a8ba7f8cd4adfd

# Crd2Pulumi
ARG CRD2PULUMI_VERSION=1.3.0

# NodeJS
ARG NVM_VERSION=0.39.7
ARG NODE_VERSION=22
ARG YARN_VERSION=4.3.0
ARG PNPM_VERSION=9.3.0

# kubectl
ARG KUBECTL_VERSION=1.30.2

# Helm
ARG HELM_VERSION=3.14.4

# Golang
ARG GOLANG_VERSION=1.22.2

# --------------
# --- Stages ---
# --------------

# Crd2Pulumi
# Outputs:
# - /crd2pulumi
FROM ${BASE_IMAGE} as crd2pulumi
ARG CRD2PULUMI_VERSION
RUN curl -LO "https://github.com/pulumi/crd2pulumi/releases/download/v${CRD2PULUMI_VERSION}/crd2pulumi-v${CRD2PULUMI_VERSION}-linux-amd64.tar.gz" && \
    tar -zxvf crd2pulumi-v${CRD2PULUMI_VERSION}-linux-amd64.tar.gz

# NodeJS via NVM + Corepack (Yarn and Pnpm)
# Outputs:
# - /root/.nvm
# - /root/.cache/node
# - /root/.yarnrc.yml
FROM ${BASE_IMAGE} as nodejs

ARG NVM_VERSION
ARG NODE_VERSION
ARG YARN_VERSION
ARG PNPM_VERSION

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \. "$NVM_DIR/nvm.sh" && \
    nvm install ${NODE_VERSION} && \
    corepack enable && \
    corepack install --global yarn@${YARN_VERSION} pnpm@${PNPM_VERSION} && \
    yarn config set --home enableTelemetry 0

# kubectl
# Outputs:
# - /kubectl
FROM ${BASE_IMAGE} as kubectl
ARG KUBECTL_VERSION
RUN curl -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

# Helm
# Outputs:
# - /helm
FROM ${BASE_IMAGE} as helm
ARG HELM_VERSION
RUN curl https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && tar -zxvf helm.tar.gz

# Golang
# Outputs:
# - /go
FROM ${BASE_IMAGE} as golang
ARG GOLANG_VERSION
RUN curl -LO https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    tar -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz

# ----------------
# --- Finalize ---
# ----------------

FROM ${BASE_IMAGE}

RUN useradd -ms /bin/bash dev
USER dev
WORKDIR /home/dev

# Create directories for tools and add them to PATH
RUN mkdir -p /home/dev/.local/bin && \
    mkdir -p /home/dev/.cache && \
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Crd2Pulumi
COPY --from=crd2pulumi /crd2pulumi .local/bin/crd2pulumi

# NodeJS
COPY --from=nodejs /root/.nvm .nvm
COPY --from=nodejs /root/.cache/node .cache/node
COPY --from=nodejs /root/.yarnrc.yml .yarnrc.yml

# kubectl
COPY --from=kubectl /kubectl .local/bin/kubectl

# Helm
COPY --from=helm /linux-amd64/helm .local/bin/helm

# Golang
COPY --from=golang /go .local/go
RUN echo 'export PATH="$HOME/.local/go/bin:$PATH"' >> ~/.bashrc && \
    echo 'export GOPATH="$HOME/go"' >> ~/.bashrc && \
    echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.bashrc