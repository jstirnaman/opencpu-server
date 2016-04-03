# Use builds from launchpad
FROM ubuntu:14.04

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LC_COLLATE=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_MESSAGES=en_US.UTF-8 \
    LC_MONETARY=en_US.UTF-8 \
    LC_NUMERIC=en_US.UTF-8 \
    LC_TIME=en_US.UTF-8

# Install.
RUN \
  echo 'LC_ALL=en_US.UTF-8' >>  /etc/default/locale && \
  echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen en_US.UTF-8 && \
  dpkg-reconfigure locales && \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:opencpu/opencpu-1.5 && \
  apt-get update && \
  apt-get install -y opencpu rstudio-server

# Apache ports
EXPOSE 80
EXPOSE 443
EXPOSE 8004

# Define default command.
RUN touch /var/log/opencpu/apache_access.log

CMD service opencpu restart && rstudio-server restart && tail -F /var/log/opencpu/apache_access.log
