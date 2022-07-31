#!/usr/bin/env bash
# -*- mode: sh; -*-


function usage {
    cat <<EOF
usage: make-a-perl.sh options command

Options
-------
-d      name of Dockerfile, default: Dockerfile
-v      version of Perl to build, e.g. 5.10.0
-r      Docker repo to push to
-p      password for docker repo
-l      logfile

Recipes
-------

Build Perl 5.10.10

 $ make-a-perl.sh -v 5.10.0 build

Push to repo

 $ make-a-perl.sh -v 5.10.0 -r ghcr.io/my-repo -p ~/.ssh/github-token push
EOF
    exit
}

function build {    
    docker build --build-arg version=$VERSION -f $DOCKERFILE . -t $TAG:latest | tee $LOGFILE;
    
    test -n "$REPO_TAG" && docker tag $TAG "$REPO_TAG:latest"
}

function push_to_repo {
    if test -z "$REPO"; then
        echo "no repo specified!"
        exit;
    fi
    
    if test -n "$PASSWORD"; then
        cat $PASSWORD | docker push "$REPO_TAG:latest"
    else
        docker push "$REPO_TAG:latest"
    fi
}

BUILD="yes"

while getopts "nhv:r:p:l:d:" arg "$@"; do

    case "${arg}" in

        n)
            BUILD="";
            ;;
        
        v)
            VERSION="$OPTARG";
            TAG="perl_$VERSION";
            ;;

        d)
            DOCKERFILE="$OPTARG";
            ;;
        
        r)
            REPO="$OPTARG";
            REPO_TAG="$REPO/$TAG";
            ;;

        p)
            PASSWORD="$OPTARG";
            if ! test -e "$PASSWORD"; then
                echo "password should be name of a file containing your password";
                exit
            fi
            ;;

        l)
            LOGFILE="$OPTARG";
            ;;
        
        h)
	    usage;
	    ;;

    esac
done

test -n "$DEBUG" && set -x
test -z "$LOGFILE" && LOGFILE="$TAG.log"

DOCKERFILE=${DOCKERFILE:-Dockerfile}

shift $((OPTIND -1))

if test -z "$VERSION"; then \
    echo "no version specified"
    usage;
fi

COMMAND="$1"

if [ "$COMMAND" = "build" ]; then
    build
fi

if [ "$COMMAND" = "push" ]; then
    push_to_repo
fi
