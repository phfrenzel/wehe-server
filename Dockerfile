# This image is intended to be run with the appropriate certs mounted in
# /wehe/ssl.
FROM python:2.7-alpine3.10
MAINTAINER Fangfan Li <li.fa@husky.neu.edu>, Harsh Modi <modi.ha@husky.neu.edu>
RUN pip install --upgrade pip
RUN apk add --no-cache gcc \
                libc-dev \
		linux-headers \
                mariadb-connector-c-dev \
                python-dev \
		freetype-dev \
		py-numpy \
		py-scipy \
		build-base \
		openblas-dev \
		libgfortran \
		tcpdump \
		wireshark \
		tshark \
		openssl
RUN pip install --no-cache psutil \
        mysqlclient \
        tornado==4.2 \
        multiprocessing_logging \
        netaddr \
        future \
        timezonefinder==1.5.3 \
        gevent \
        reverse-geocode \
        python-dateutil \
        prometheus_client
RUN apk del --purge gcc \
                libc-dev \
                linux-headers \
		build-base
ADD src /wehe
ADD replayTraces /replayTraces
WORKDIR /wehe
# You must provide a local hostname argument when you start this image.
ENTRYPOINT ["/bin/sh", "./startserver.sh"]
