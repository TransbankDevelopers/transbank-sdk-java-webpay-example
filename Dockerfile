FROM maven:3-jdk-8
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git
RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/TransbankDevelopers/transbank-sdk-java-webpay-example.git
WORKDIR /app/transbank-sdk-java-webpay-example
RUN git checkout heroku-deployments
RUN mvn clean install -Dmaven.test.skip=true
ENTRYPOINT ["mvn", "jetty:run"]