FROM debian:bullseye-slim
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
# Hack to prevent openjdk-11 install failing
RUN mkdir /usr/share/man/man1/ 
# Enable contrib repo
RUN sed -i "s#deb http://deb.debian.org/debian bullseye main#deb http://deb.debian.org/debian bullseye main contrib#g" /etc/apt/sources.list
RUN apt-get update && apt-get -y install openjdk-11-jdk-headless \
  rename \
  wget \
  curl \
  zip \
  fontconfig
RUN fc-cache -f -v
RUN apt-get update && apt-get -y install fonts-ipafont-gothic \
  fonts-ipafont-mincho \
  ant \
  git \
  libxml2 \
  libxml2-utils \
  devscripts \
  xsltproc \
  libsaxonhe-java \
  debhelper \
  trang \
  jing \
RUN echo "#! /bin/bash" > /usr/local/bin/saxon \
    && echo "java -jar /usr/share/java/Saxon-HE.jar \$*" >> /usr/local/bin/saxon \
    && chmod 755 /usr/local/bin/saxon
RUN git clone https://github.com/TEIC/Stylesheets.git /opt/stylesheets
RUN mkdir /opt/actions
COPY process.sh /opt/actions/process.sh
ENTRYPOINT ["/opt/actions/process.sh"]
