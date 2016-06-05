#!/bin/sh

: "Configure" && {
    IMAGE_TAG="auto_colorize"  # You can change this
}

: "Get arguments" && {
    if [ $# -ne 2 ]; then
        echo "Usage: $0 inimg outimg"
        echo "  caution: image files should be under this folder."
        exit
    fi
    inimg=$1
    outimg=$2
}

: "Build image" && {
    WORKDIR="/opt/siggraph2016_colorization"
    MOUNT_BASE="working"
    # Building image (only once) might take 15 minutes.
    docker build -q -t ${IMAGE_TAG} . > /dev/null 2>&1
}

: "Run" && {
    mount_opt="-v $(pwd):${WORKDIR}/${MOUNT_BASE}"
    img_arg="${MOUNT_BASE}/${inimg} ${MOUNT_BASE}/${outimg}"

    docker run --rm ${mount_opt} -t ${IMAGE_TAG} ${img_arg}
}
