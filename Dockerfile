# Use an official Tomcat image as the base image
FROM tomcat:9.0-jdk8-corretto

# Remove the default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your JSP application WAR file to the webapps directory of Tomcat
COPY . /usr/local/tomcat/webapps/iclock/

# Expose the port on which Tomcat will run
EXPOSE 8080

# Start Tomcat when the container starts
CMD ["catalina.sh", "run"]
