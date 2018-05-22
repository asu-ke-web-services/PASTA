FROM tomcat:7-jre8

MAINTAINER Nathan Rollins <nathan.rollins@asu.edu>

ENV DATAPORTAL2_DATA_DIR /var/local/DataPortal2
ENV DATAPORTAL2_INSTALL_DIR /usr/local/DataPortal2

# Uncomment to use APT cache (requires apt-cacher-ng on host)
#RUN echo "Acquire::http { Proxy \"http://`/sbin/ip route|awk '/default/ { print $3 }'`:3142\"; };" > /etc/apt/apt.conf.d/71-apt-cacher-ng

# DataPortal2
ADD conf/DataPortal2.xml /usr/local/tomcat/conf/Catalina/localhost/DataPortal2.xml
RUN mkdir ${DATAPORTAL2_DATA_DIR} \
	&& mkdir ${DATAPORTAL2_INSTALL_DIR} \
	&& cd ${DATAPORTAL2_INSTALL_DIR} \

	&& wget http://sourceforge.net/projects/DataPortal2/files/GeoServer/${DATAPORTAL2_VERSION}/DataPortal2-${DATAPORTAL2_VERSION}-war.zip \
	&& unzip DataPortal2-${DATAPORTAL2_VERSION}-war.zip \
	&& unzip DataPortal2.war \
	&& mv data/* ${DATAPORTAL2_DATA_DIR} \
	&& rm -rf DataPortal2-${DATAPORTAL2_VERSION}-war.zip DataPortal2.war target *.txt

# Enable CORS
RUN sed -i '\:</web-app>:i\
    <filter>\
        <filter-name>CorsFilter</filter-name>\
        <filter-class>org.apache.catalina.filters.CorsFilter</filter-class>\
    </filter>\
\
    <filter-mapping>\
        <filter-name>CorsFilter</filter-name>\
        <url-pattern>/*</url-pattern>\
    </filter-mapping>\
\
    <init-param>\
        <param-name>cors.support.credentials</param-name>\
        <param-value>true</param-value>\
    </init-param>' ${DATAPORTAL2_INSTALL_DIR}/WEB-INF/web.xml

# Tomcat environment
ENV CATALINA_OPTS "-server -Djava.awt.headless=true \
	-Xms768m -Xmx1560m -XX:+UseConcMarkSweepGC -XX:NewSize=48m \
	-DDATAPORTAL2_DATA_DIR=${DATAPORTAL2_DATA_DIR}"

ADD docker-files/start.sh /usr/local/bin/start.sh
CMD start.sh

EXPOSE 8080
