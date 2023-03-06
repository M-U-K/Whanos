#!/bin/bash

name=`pwd`
name=`basename "$name"`

if [ -e app/ ]
then

    echo "job - $name: app/ folder finded"

    if [ -e Dockerfile ]
    then
        echo "job - $name: Dockerfile finded"
        dock=${name// /_}
        dock=${dock,,}
        echo "job - $name: Build $dock docker"
        docker build . -t "$dock"
        echo "job - $name: Done"
        echo "job - $name: Run $dock docker"
        docker run "$dock"

    else
        if [ -e Makefile ]
        then
            echo "job - $name: Makefile finded"
            echo "job - $name: Run whanos-c docker"
            cp /jenkins/images/c/Dockerfile.standalone ./Dockerfile.standalone
            docker build . -f ./Dockerfile.standalone -t whanos-c-standalone
            docker run whanos-c-standalone
            rm Dockerfile.standalone
        elif [ -e app/pom.xml ]
        then
            echo "job - $name: pom.xml finded"
            echo "job - $name: Run whanos-java docker"
            cp /jenkins/images/java/Dockerfile.standalone ./Dockerfile.standalone
            docker build . -f ./Dockerfile.standalone -t whanos-java-standalone
            docker run whanos-java-standalone
            rm Dockerfile.standalone
        elif [ -e package.json ]
        then
            echo "job - $name: package.json finded"
            echo "job - $name: Run whanos-javascript docker"
            cp /jenkins/images/javascript/Dockerfile.standalone ./Dockerfile.standalone
            docker build . -f /jenkins/images/javascript/Dockerfile.standalone -t whanos-javascript-standalone
            docker run whanos-javascript-standalone
            rm Dockerfile.standalone
        elif [ -e requirements.txt ]
        then
            echo "job - $name: requirements.txt finded"
            echo "job - $name: Run whanos-python docker"
            cp /jenkins/images/python/Dockerfile.standalone ./Dockerfile.standalone
            docker build . -f /jenkins/images/python/Dockerfile.standalone -t whanos-python-standalone
            docker run whanos-python-standalone
            rm Dockerfile.standalone
        elif [ -e app/main.bf ]
        then
            echo "job - $name: main.bf finded"
            echo "job - $name: Run whanos-befunge docker"
            cp /jenkins/images/befunge/befunge-compile.sh ./befunge-compile.sh
            cp /jenkins/images/befunge/core.int ./core.int
            cp /jenkins/images/befunge/tbc ./tbc
            chmod 755 befunge-compile.sh
            chmod 755 tbc
            cp /jenkins/images/befunge/Dockerfile.standalone ./Dockerfile.standalone
            docker build . -f /jenkins/images/befunge/Dockerfile.standalone -t whanos-befunge-standalone
            docker run whanos-befunge-standalone
            rm core.int tbc befunge-compile.sh
            rm Dockerfile.standalone
        else
            echo "job - $name: Can't build this project. Is it from a suported langage ? Did it meet the requirements ?"
            exit 1
        fi
    fi

fi

echo "job - $name: Done"