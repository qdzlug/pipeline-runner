ARG BASE_REGISTRY=registry1.dso.mil
ARG BASE_IMAGE=ironbank/opensource/python/python39
ARG BASE_TAG=v3.9

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

USER 0

ENV PATH /usr/local/bin:$PATH

COPY signatures/centos-gpg-key /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
COPY *.rpm /opt/dnfmodules/
COPY *.whl *.tar.gz /opt/pymodules/
COPY notary-Linux-amd64 /usr/local/bin/

ENV _BUILDAH_STARTED_IN_USERNS="" BUILDAH_ISOLATION=chroot PATH="${PATH}:/root/.local/bin"

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial && \
    dnf upgrade -y && \
    dnf install -y podman buildah skopeo && \
    dnf install -y /opt/dnfmodules/*.rpm --setopt=tsflags=nodocs && \
    dnf install -y make gcc openssl-devel bzip2-devel \
        libffi-devel bc gettext git lsof rsync unzip \
        zip bzip2 jq gcc-c++ \
        --setopt=tsflags=nodocs && \
    mv /usr/local/bin/notary-Linux-amd64 /usr/local/bin/notary && \
    chmod 755 /usr/local/bin/notary && \
    rm /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial && \
    rm -rf /opt/dnfmodules && \
    chmod -s /usr/libexec/openssh/ssh-keysign && \
    dnf clean all && \
    rm -rf /var/cache/dnf

RUN python3 -m pip install --upgrade /opt/pymodules/pip-22.0.3-py3-none-any.whl

RUN python3 -m pip install /opt/pymodules/wheel-0.37.1-py2.py3-none-any.whl /opt/pymodules/setuptools-56.1.0-py3-none-any.whl /opt/pymodules/et_xmlfile-1.1.0-py3-none-any.whl && \
        rm -f /opt/pymodules/pip-22.0.3-py3-none-any.whl /opt/pymodules/wheel-0.37.1-py2.py3-none-any.whl /opt/pymodules/setuptools-56.1.0-py3-none-any.whl /opt/pymodules/et_xmlfile-1.1.0-py3-none-any.whl

RUN python3 -m pip install /opt/pymodules/numpy-1.22.2-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl && rm -f /opt/pymodules/numpy-1.22.2-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl && \
        python3 -m pip install /opt/pymodules/* && \
        rm -rf /opt/pymodules

RUN dnf -y remove gcc make openssl-devel bzip2-devel libffi-devel && \
    dnf reinstall -y shadow-utils && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    chmod 0755 /usr/bin/fusermount3 && \
    sed -i 's/driver = "overlay"/driver = "vfs"/g' /etc/containers/storage.conf

RUN rm -f /usr/share/doc/perl-IO-Socket-SSL/example/simulate_proxy.pl && \
        find /usr/share/doc -type f \( -iname \*.pem -o -iname \*.enc \) -exec rm -f {} \;
        
HEALTHCHECK none
