FROM centos:6.10

COPY centos6.repo /etc/yum.repos.d/centos6.repo

RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist=/#mirrorlist=/g' * && \
    sed -i 's/#baseurl=/baseurl=/g' * && \
    sed -i 's|mirror.centos.org\/centos|vault.centos.org|g' * && \
    sed -i 's/$releasever/6.10/g' * && \
    rm -rfv CentOS-Debuginfo.repo CentOS-Media.repo

RUN yum groupinstall -y 'Development Tools' rpm-build gcc gcc-c++ make --enablerepo=C6.10-base

RUN rpm -Uvh  https://archivefedora.mirror.angkasa.id/epel/6/x86_64/Packages/l/libnghttp2-devel-1.6.0-1.el6.1.x86_64.rpm \
              https://archivefedora.mirror.angkasa.id/epel/6/x86_64/Packages/l/libnghttp2-1.6.0-1.el6.1.x86_64.rpm \
              https://archivefedora.mirror.angkasa.id/epel/6/x86_64/Packages/l/libmetalink-0.1.3-1.el6.x86_64.rpm \
              https://archivefedora.mirror.angkasa.id/epel/6/x86_64/Packages/l/libmetalink-devel-0.1.3-1.el6.x86_64.rpm \
              https://archivefedora.mirror.angkasa.id/epel/6/x86_64/Packages/p/perl-interpreter-5.10.1-5.el6.noarch.rpm \
              https://archivefedora.mirror.angkasa.id/epel/6/x86_64/Packages/n/nghttp2-1.6.0-1.el6.1.x86_64.rpm

RUN yum install -y  vim \
                    c-ares-devel \
                    krb5-devel \
                    openldap-devel \
                    libmetalink-devel \
                    libssh2-devel \
                    perl-interpreter \
                    openssl-devel \
                    zlib-devel \
                    gnutls-utils \
                    openssh-server \
                    stunnel \
                    perl-Time-HiRes --enablerepo=C6.9-base

RUN rpm -Uvh http://mirror.city-fan.org/ftp/contrib/yum-repo/rhel6/source/curl-7.74.0-2.0.cf.rhel6.src.rpm

RUN cd /root/rpmbuild/SPECS/ && rpmbuild -bb curl.spec


