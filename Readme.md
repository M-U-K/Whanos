3rd year project

# Description

The Whanos project allow you to automatically deploy (nearly) any application into a cluster, just by pushing into your GIT repository.
<br>
<br>

# Installation

You just have to clone this repository, then choose a langage in **Suported langage** and follow the instruction of **Docker**, **Jenkins** and **Kubernetes**.
<br>
<br>

# Suported langage (and their requirement)

All langage may have their sources in an `app/` folder, at the root of the repository

### Befunge

Use of **Befunge 93**

**Requirements:**
* Has a `main.bf` file in the `app/` folder

### C

Use of **GNU Compiler Collection 11.2**

**Requirements:**
* Has a `Makefile` file at the root
* The binary name must be `compiled-app`, and must be at the root

### Java

Use of **Java SE 17**
Use of **Maven** system

**Requirements:**
* Has a `pom.xml` file in the `app/` folder
* The binary name must be `app.jar`, and must be placed in a target subdirectory (Maven convention)

### JavaScript

Use of **Node.js 14.17.5**
Use of **npm** system

**Requirements:**
* Has a `package.json` file at the root

### Python

Use of **Python 3.10**
Use of **pip** system

**Requirements:**
* Has a `requirements.txt` file at the root
<br>
<br>

# Docker

By default, the scripts will use the Dockerfile `.standalone` in relation with its langage in `images/langage/` *(e.g: images/c/Dockerfile.standalone)*.
So you don't need to write any Dockerfile.

If you want to write your own Dockerfile, write it in the root of your repository, for it to be taken into account by the scripts.
You need to do it derived from `whanos-langage` docker *(e.g: whanos-c)*
<br>
<br>

# Jenkins

We use Jenkins to automate the process. To lauch a Jenkins instance, you just need to use the script `jenkins.sh` at the root of this repository.

> Remember to use the command `chmod 755 jenkins.sh` to be able to start the script
```shell
./jenkins.sh [OPTION]
```
* [OPTION] - **up** or **down [OPTION1=""] [OPTION2=""]**
    * **down [OPTION1=""] [OPTION2=""]** - **images** or **volumes**
    * **images** will down the docker image of your jenkins instance
    * **volumes** will remove all the files use by your jenkins instance

When the Jenkins are lauched, locally you can go to `0.0.0.0:8080/`. The default user is *admin* and the password *admin*.<br>
Once connect, you can see a job **link-project**, a folder **Projects** and a folder **Whanos base images**.

### Whanos base images

This folder contains the jobs that are use to build the base images of the suported langage. If you need one of them for a personaly Dockerfile (like described in **Docker**), so lauch it. You just need to do it once.<br>
You can already use `Build all base images` to build all the base images.

### Projects

In this folder you will able to find the jobs that you create with the **link-project** job.

### link-project

This job create a job in the folder **Projects**. The first time, the created job will clone your repository, build a docker, and try to run your program. Then it will only update the files, rebuild the docker if there is any new or modified files, and then try to run it.<br>
It will verify each minute if a changement occured, so you don't have to lauch it each time you need to test it. It will do it itself !

To create such a job, **link-project** will ask you a project name *(ex: my job)* and the github path of your repository *(ex: DarkSasuke/HelloWorld)* to be able to work.
The project name will be use to name the job and the github path to clone it obviously.
<br>
<br>

# Kubernetes

*In progress*
<br>
<br>

# Author

Nicolas Peter<br>
Lily Dieudonne<br>
[Maxime Payant](https://github.com/MaximePayant)
