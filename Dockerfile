FROM tomcat:10.1-jdk17-temurin-noble

# Copy the web application files
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Create the classes directory
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

# Copy Java source files
COPY src/main/java/ /tmp/codequest-src/

# Compile all Java files
RUN find /tmp/codequest-src -name "*.java" > /tmp/sources.txt && \
    javac -encoding UTF-8 \
    -cp "/usr/local/tomcat/lib/*:/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*" \
    -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
    @/tmp/sources.txt

# Start Tomcat
CMD ["catalina.sh", "run"]