ARG version
FROM perl_$version
ARG version
COPY test-module .
RUN cp /opt/perl-$version/bin/perl  /usr/bin/perl
RUN cpanm --version
RUN yum install -y expat expat-devel openssl-devel
