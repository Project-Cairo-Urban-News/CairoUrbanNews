FROM debian:bookworm-slim
RUN apt-get update && apt-get -y install openjdk-17-jre-headless \
  rename \
  wget \
  curl \
  zip \
  ant \
  git \
  libxml2 \
  libxml2-utils \
  devscripts \
  xsltproc \
  libsaxonhe-java \
  debhelper \
  trang \
  jing
RUN echo "#! /bin/bash" > /usr/local/bin/saxon \
    && echo "java -jar /usr/share/java/Saxon-HE.jar \$*" >> /usr/local/bin/saxon \
    && chmod 755 /usr/local/bin/saxon
RUN git clone https://github.com/TEIC/Stylesheets.git /opt/stylesheets
RUN mkdir /opt/actions
COPY process.sh /opt/actions/process.sh
ENTRYPOINT ["/opt/actions/process.sh"]
