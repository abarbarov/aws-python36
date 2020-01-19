FROM amazonlinux:2.0.20191217.0

RUN yum -y groupinstall development && \
    yum -y install zlib-devel && \
    yum -y install tk-devel && \
    yum -y install openssl-devel && \
    yum -y install wget tar gzip zip && \
    yum clean all

# Installing openssl-devel alone seems to result in SSL errors in pip (see https://medium.com/@moreless/pip-complains-there-is-no-ssl-support-in-python-edbdce548852)
# Need to install OpenSSL also to avoid these errors
RUN wget https://github.com/openssl/openssl/archive/OpenSSL_1_0_2u.tar.gz && \
    tar -zxvf OpenSSL_1_0_2u.tar.gz && \
    cd openssl-OpenSSL_1_0_2u/ && \
    ./config shared && \
    make && \
    make install

RUN export LD_LIBRARY_PATH=/usr/local/ssl/lib/

# cd ..
RUN rm OpenSSL_1_0_2u.tar.gz
RUN rm -rf openssl-OpenSSL_1_0_2u/

# Install Python 3.6
RUN wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz && \
    tar xJf Python-3.6.0.tar.xz && \
    cd Python-3.6.0 && \
    ./configure && \
    make && \
    make install

RUN rm Python-3.6.0.tar.xz
RUN rm -rf Python-3.6.0

# Create virtualenv running Python 3.6
RUN yum install -y python2-pip
RUN pip install --upgrade pip

# RUN pip install --upgrade virtualenv

## python3 -m venv pandas
## source pandas/bin/activate

## python --version
## Python 3.6.0
