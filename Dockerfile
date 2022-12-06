ARG BASE_REGISTRY=registry1.dso.mil
ARG BASE_IMAGE=ironbank/ironbank-pipelines/pipeline-runner
ARG BASE_TAG=v0.9.0

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

USER root

RUN dnf install -y podman unzip && \
    dnf clean all && \
    rm -rf /var/cache/dnf

COPY requirements.txt /local/requirements.txt
COPY *.rpm /opt/dnfmodules/

RUN dnf upgrade -y && \
    dnf install -y podman buildah skopeo && \
    dnf install -y /opt/dnfmodules/*.rpm --setopt=tsflags=nodocs && \
    dnf install -y make gcc openssl-devel bzip2-devel \
        libffi-devel bc gettext git lsof rsync unzip \
        zip bzip2 jq gcc-c++ \
        --setopt=tsflags=nodocs

RUN python3 -m pip install -r /local/requirements.txt

RUN dnf -y remove gcc make openssl-devel bzip2-devel libffi-devel && \
    dnf reinstall -y shadow-utils && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    chmod 0755 /usr/bin/fusermount3 && \
    sed -i 's/driver = "overlay"/driver = "vfs"/g' /etc/containers/storage.conf

RUN rm -f /usr/share/doc/perl-IO-Socket-SSL/example/simulate_proxy.pl && \
        find /usr/share/doc -type f \( -iname \*.pem -o -iname \*.enc \) -exec rm -f {} \;

USER 1001