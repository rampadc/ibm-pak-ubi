FROM registry.access.redhat.com/ubi9/ubi-minimal:9.5

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'
RUN microdnf install -y ca-certificates wget tar gzip bash jq unzip \
    && microdnf update -y \
    && microdnf clean all

RUN curl -sLO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz -o openshift-client-linux.tar.gz \
    && tar -xzf openshift-client-linux.tar.gz \
    && install -o root -g root -m 0755 oc /usr/local/bin/oc \
    && chmod +x /usr/local/bin/oc \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && rm openshift-client-linux.tar.gz

RUN wget https://github.com/mikefarah/yq/releases/download/v4.32.2/yq_linux_amd64 -O /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq

RUN curl -sLO https://github.com/IBM/ibm-pak/releases/download/v1.17.0/oc-ibm_pak-linux-amd64.tar.gz -o oc-ibm_pak-linux-amd64.tar.gz \
    && tar -xzf oc-ibm_pak-linux-amd64.tar.gz \
    && install -o root -g root -m 0755 oc-ibm_pak-linux-amd64 /usr/local/bin/oc-ibm_pak \
    && chmod +x /usr/local/bin/oc-ibm_pak \
    && rm LICENSE \
    && rm oc-ibm_pak-linux-amd64.tar.gz

RUN curl -sLO https://get.helm.sh/helm-v3.17.2-linux-amd64.tar.gz \
    && tar -zxf helm-v3.17.2-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64 \
    && chmod +x /usr/local/bin/helm

RUN curl -sLO https://releases.hashicorp.com/vault/1.19.0/vault_1.19.0_linux_amd64.zip \
    && unzip vault_1.19.0_linux_amd64.zip \
    && mv vault /usr/local/bin/vault \
    && chmod +x /usr/local/bin/vault \
    && rm LICENSE.txt
