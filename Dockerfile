FROM registry.access.redhat.com/ubi8/ubi-minimal:8.7

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'
RUN microdnf install curl ca-certificates wget tar gzip bash jq \
    && microdnf update \
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

RUN curl -sLO https://github.com/IBM/ibm-pak/releases/download/v1.9.0/oc-ibm_pak-linux-amd64.tar.gz -o oc-ibm_pak-linux-amd64.tar.gz \
    && tar -xzf oc-ibm_pak-linux-amd64.tar.gz \
    && install -o root -g root -m 0755 oc-ibm_pak-linux-amd64 /usr/local/bin/oc-ibm_pak \
    && chmod +x /usr/local/bin/oc-ibm_pak \
    && rm LICENSE \
    && rm oc-ibm_pak-linux-amd64.tar.gz
