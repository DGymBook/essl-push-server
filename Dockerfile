# Use an official Tomcat image as the base image
FROM tomcat:9.0-jdk8-corretto

# Access the environment variable during the build
ARG DB_CONNECT
ARG DB_URL_MYSQL
ARG DB_USERNAME_MYSQL
ARG DB_PASSWORD_MYSQL

ENV DB_CONNECT=${DB_CONNECT}
ENV DB_URL_MYSQL=${DB_URL_MYSQL}
ENV DB_USERNAME_MYSQL=${DB_USERNAME_MYSQL}
ENV DB_PASSWORD_MYSQL=${DB_PASSWORD_MYSQL}

# Remove the default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your JSP application WAR file to the webapps directory of Tomcat
COPY . /usr/local/tomcat/webapps/iclock/

# Generate databaseconfig.properties file
RUN echo "DB_CONNECT=${DB_CONNECT}" > /usr/local/tomcat/webapps/iclock/WEB-INF/databaseconfig.properties
RUN echo "DB_DRIVER_MYSQL=com.mysql.jdbc.Driver" >> /usr/local/tomcat/webapps/iclock/WEB-INF/databaseconfig.properties
RUN echo "DB_URL_MYSQL=${DB_URL_MYSQL}" >> /usr/local/tomcat/webapps/iclock/WEB-INF/databaseconfig.properties
RUN echo "DB_USERNAME_MYSQL=${DB_USERNAME_MYSQL}" >> /usr/local/tomcat/webapps/iclock/WEB-INF/databaseconfig.properties
RUN echo "DB_PASSWORD_MYSQL=${DB_PASSWORD_MYSQL}" >> /usr/local/tomcat/webapps/iclock/WEB-INF/databaseconfig.properties

# Expose the port on which Tomcat will run
EXPOSE 8080

# Start Tomcat when the container starts
CMD ["catalina.sh", "run"]
