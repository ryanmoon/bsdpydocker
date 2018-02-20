######################################################
# DOCKERFILE W/TFTP, NGINX, & BSDPY TO USE WITH IMAGR
######################################################
# Adapted from Pepijn Bruienne, amd Calem Hunter

###########################
# LATEST VERSION OF ALPINE
###########################

FROM alpine:3.6

MAINTAINER Ryan Moon (ryan.moon@gmail.com)

###############
# ADD PACKAGES
###############

RUN apk add --update \
    curl \
    libxml2-dev \
    python \
    python-dev \
    py-pip \
    nginx \
    tftp-hpa \
  && rm -rf /var/cache/apk/*

###########################
# CREATE DIRECTORIES & LOG
###########################

RUN mkdir /nbi && \
  mkdir /bsdpy && \
  touch /var/log/bsdpserver.log

######################
# ADD FILES & SCRIPTS
######################

ADD nginx.conf /etc/nginx/nginx.conf
ADD start.sh /start.sh
ADD bsdpserver.py /bsdpy/
ADD __init__.py /bsdpy/
ADD pydhcplib /bsdpy/pydhcplib
ADD requirements.txt /

###############
# SETUP PYTHON
###############

RUN pip install -r requirements.txt

#####################
# CORRECT PERMISIONS
#####################

RUN chown -R root:root /etc/nginx/nginx.conf && \
	chown -R root:root /start.sh && \
	chmod +x /start.sh /bsdpy/bsdpserver.py

###############
# EXPOSE PORTS
###############

EXPOSE 67/udp
EXPOSE 69/udp
EXPOSE 80

########
# START
########

CMD ["/start.sh"]

