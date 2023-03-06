#!/bin/bash


if [ "$1" = "up" ]
then
    docker build . -f jenkins/Dockerfile -t whanos-jenkins-base
    cd jenkins/
    docker-compose up whanos-jenkins

elif [ "$1" = "down" ]
then
    cd jenkins/
    if [ "$2" = "images" ]
    then
        if [ "$3" = "volumes" ]
        then
            docker-compose down --volumes --rmi all
        else
            docker-compose down --rmi all
        fi

    elif [ "$2" = "volumes" ]
    then
        if [ "$3" = "images" ]
        then
            docker-compose down --volumes --rmi all
        else
            docker-compose down --volumes
        fi
    fi
fi