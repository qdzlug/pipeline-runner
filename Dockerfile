ARG BASE_REGISTRY=registry1.dso.mil
ARG BASE_IMAGE=ironbank/ironbank-pipelines/pipeline-runner
ARG BASE_TAG=v0.9.0

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

USER root

RUN dnf install -y podman unzip && \
    dnf clean all && \
    rm -rf /var/cache/dnf

COPY requirements.txt /local/requirements.txt

RUN python3 -m pip install -r /local/requirements.txt

USER 1001