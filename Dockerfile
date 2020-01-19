FROM amazonlinux:2.0.20191217.0

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN yum -y groupinstall development && \
    yum -y install zlib-devel && \
    yum -y install tk-devel && \
    yum -y install openssl-devel && \
    yum -y install wget tar gzip zip && \
    yum -y install sqlite-devel && \
    yum clean all

RUN wget https://github.com/openssl/openssl/archive/OpenSSL_1_0_2u.tar.gz && \
    tar -zxvf OpenSSL_1_0_2u.tar.gz && \
    cd openssl-OpenSSL_1_0_2u/ && \
    ./config shared && \
    make && \
    make install

RUN export LD_LIBRARY_PATH=/usr/local/ssl/lib/

RUN rm OpenSSL_1_0_2u.tar.gz
RUN rm -rf openssl-OpenSSL_1_0_2u/

RUN wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz && \
    tar xJf Python-3.6.8.tar.xz && \
    cd Python-3.6.8 && \
    ./configure --enable-loadable-sqlite-extensions --enable-optimizations && \
    make && \
    make install

RUN rm Python-3.6.8.tar.xz
RUN rm -rf Python-3.6.8

RUN yum install -y python2-pip
RUN pip install --upgrade pip
RUN pip install --upgrade virtualenv

# python3 -m venv pandas
# source pandas/bin/activate
# pip install chemdataextractor
# python3 --version
