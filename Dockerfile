ARG BASE_REGISTRY=registry1.dso.mil
ARG BASE_IMAGE=ironbank/ironbank-pipelines/pipeline-runner
ARG BASE_TAG=v0.10.13

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

USER root

ENV PATH /usr/local/bin:$PATH

COPY signatures/centos-gpg-key /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

COPY requirements.txt /local/requirements.txt
COPY *.rpm /opt/dnfmodules/

ENV _BUILDAH_STARTED_IN_USERNS="" BUILDAH_ISOLATION=chroot PATH="${PATH}:/root/.local/bin"

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial && \
    dnf upgrade -y --nodocs && \
    dnf install -y --nodocs podman buildah skopeo && \
    dnf install -y /opt/dnfmodules/*.rpm --setopt=tsflags=nodocs && \
    dnf install -y --nodocs make automake gcc openssl-devel bzip2-devel \
        python3-devel libffi-devel bc gettext git lsof rsync unzip \
        zip bzip2 jq gcc-c++  \
        --setopt=tsflags=nodocs && \
    rm /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial && \
    rm -rf /opt/dnfmodules && \
    chmod -s /usr/libexec/openssh/ssh-keysign

RUN pip install --upgrade pip && \
    python3 -m pip install -r /local/requirements.txt

RUN dnf -y remove gcc make openssl-devel bzip2-devel libffi-devel && \
    dnf reinstall -y shadow-utils && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    chmod 0755 /usr/bin/fusermount3 && \
    sed -i 's/driver = "overlay"/driver = "vfs"/g' /etc/containers/storage.conf

RUN rm -f /usr/share/doc/perl-IO-Socket-SSL/example/simulate_proxy.pl && \
        find /usr/share/doc -type f \( -iname \*.pem -o -iname \*.enc \) -exec rm -f {} \;

