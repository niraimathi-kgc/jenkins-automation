#directory, repository and file names
DIRNAME=jenkins
FILENAME=Dockerfile
REPNAME=jenkins-automation

#locations of directories, files and repositories
DIR=/home/utthunga/jenkins
FILE=/home/utthunga/jenkins/jenkins-automation/Dockerfile
REP=/home/utthunga/jenkins/jenkins-automation

#commands as a variables
LIST=$(ls)
WORKDIR=$(pwd)
# DELIMG=$(docker rmi -f testjenkins:latest)
PORT=8765
RUNPORT=8765:80
IMG=testjenkins:latest
NAME=autojenkins
BUILD=$(docker build -t $IMG .)
RUN=$(docker run -d -p $RUNPORT --name $NAME $IMG)

if [ -d "$DIR" ]; then
    echo "$DIRNAME Exists so, Deleting it for updation of new files in it..."
    rm -rf $DIR
else
    echo "$DIRNAME doesn't exists... Creating One and cloning Repository to it..."
    mkdir $DIR
    cd $DIR
    git clone https://github.com/niraimathi-kgc/jenkins-automation.git
    echo "you are currently working on $WORKDIR"
    echo "Moving to the cloned repository $REPNAME"
    cd $REP
    echo "Currently Working inside $WORKDIR"
fi


if [ -f "$FILE" ]; then 
    echo "$FILE exists, Building image using $FILE..."
    echo "Checking whether tho old containers and images are sitll running..."
    build-check
    echo "Started building new Image..."
    $BUILD
    run-container
else
    echo "$FILENAME does not exists..."
    echo "Files available in current directory are $LIST"
    echo "you are currently in $WORKDIR, mention the correct path to $FILENAME"
fi

build-check() {
    if [ -n "$(docker ps -q $NAME)" ]; then
        echo "old container exists... deleting it..."
        docker rm -f $NAME
    else
        echo "old container does not exists"
    fi

    if [ -n "$(docker images -q $IMG)" ]; then
        echo "old image exist... deleting it..."
        docker rmi -f $IMG
    else
        echo "old image does not exist"
    fi
}

run-container() {
    $RUN
}
# netstat -tulpn | grep LISTEN
