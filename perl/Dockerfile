FROM amazonlinux:2
ARG version
RUN yum -y install gcc patch perl perl-core wget tar \
    gzip make less which autoconf automake openssl
RUN wget -O - http://cpanmin.us | perl - --self-upgrade
RUN cpanm -v App::cpanminus Devel::PatchPerl
RUN wget http://www.cpan.org/src/5.0/perl-$version.tar.gz
RUN tar xfvz perl-$version.tar.gz
COPY patch.pl .
RUN perl patch.pl $version
RUN cd perl-$version && \
    ./Configure -des -Dusethreads -Dprefix=/opt/perl-$version -Dman1dir=none -Dman3dir=none && \
    make && \
    make install
RUN cpanm --version
RUN yum install -y expat expat-devel openssl-devel
