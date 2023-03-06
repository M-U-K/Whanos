folder('Whanos base images') {
    description("Folder for base docker images.")
}
folder('Projects') {
    description("Folder for projects.")
}

/** Base Image Build **/
freeStyleJob('Whanos base images/whanos-befunge') {
    steps {
        shell('docker build /jenkins/images/befunge/ -f /jenkins/images/befunge/Dockerfile.base -t whanos-befunge')
    }
    wrappers {
        preBuildCleanup {
            deleteDirectories()
        }
    }
}
freeStyleJob('Whanos base images/whanos-c') {
    steps {
        shell('docker build /jenkins/images/c/ -f /jenkins/images/c/Dockerfile.base -t whanos-c')
    }
    wrappers {
        preBuildCleanup {
            deleteDirectories()
        }
    }
}
freeStyleJob('Whanos base images/whanos-java') {
    steps {
        shell('docker build /jenkins/images/java/ -f /jenkins/images/java/Dockerfile.base -t whanos-java')
    }
    wrappers {
        preBuildCleanup {
            deleteDirectories()
        }
    }
}
freeStyleJob('Whanos base images/whanos-javascript') {
    steps {
        shell('docker build /jenkins/images/javascript/ -f /jenkins/images/javascript/Dockerfile.base -t whanos-javascript')
    }
    wrappers {
        preBuildCleanup {
            deleteDirectories()
        }
    }
}
freeStyleJob('Whanos base images/whanos-python') {
    steps {
        shell('docker build /jenkins/images/python/ -f /jenkins/images/python/Dockerfile.base -t whanos-python')
    }
    wrappers {
        preBuildCleanup {
            deleteDirectories()
        }
    }
}

multiJob('Whanos base images/Build all base images') {
    steps {
        phase('Run all base images') {
            phaseJob('whanos-befunge')
            phaseJob('whanos-c')
            phaseJob('whanos-java')
            phaseJob('whanos-javascript')
            phaseJob('whanos-python')
        }
    }
    wrappers {
        preBuildCleanup {
            deleteDirectories()
        }
    }
}

freeStyleJob('link-project') {
    parameters {
        stringParam("DISPLAY_NAME", "", "Display name for the job")
        stringParam("GITHUB_NAME", "", 'GitHub repository owner/repo_name (e.g.: "EpitechPromo2024/B-DOP-500-whanos-nicolas1.peter")')
    }
    steps {
        dsl {
            text("""
                freeStyleJob("Projects/\${DISPLAY_NAME}") {
                    scm {
                        github("\${GITHUB_NAME}")
                    }
                    triggers {
                        scm('*/1 * * * *')
                    }
                    steps {
                        shell('/jenkins/run.sh')
                    }
                    wrappers {
                        preBuildCleanup {
                            deleteDirectories()
                        }
                    }
                }
            """)
        }
    }
    wrappers {
        preBuildCleanup {
            deleteDirectories()
        }
    }
}