#
#EPITECH PROJECT, 2021
#Epitech Years 3
#File description:
#Dockerfile
#

FROM jenkins/jenkins:lts
WORKDIR /jenkins/
USER root

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY images/ images/.
COPY jenkins/job_dsl.groovy .
COPY jenkins/plugins.txt .
COPY jenkins/run.sh .
COPY jenkins/whanos-jenkins.yml .

ENV CASC_JENKINS_CONFIG whanos-jenkins.yml

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz

RUN /usr/local/bin/install-plugins.sh < plugins.txt