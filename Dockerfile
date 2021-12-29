FROM maven:3.6.0-jdk-8-slim
# Create environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
COPY . /
WORKDIR /my-app
EXPOSE 80
RUN mvn clean package
