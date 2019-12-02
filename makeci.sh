#!/bin/bash

# Configuration - set which branch will be the merge target.
# If you use git-flow or another branching strategy that calls for merging into a
# branch other than master, set MERGE_TARGET to that branch or ${1} for configurable.
MERGE_TARGET="master"

# Set the absolute location of this repository on the current filesystem
cd $(dirname ${0})
REPO_DIR=$(pwd)

show_help() {
    echo "makeci: A simple script to run tests only against changed units of code"
    echo "in a monolithic or shared git repository.  For usage information, see:"
    echo "https://github.com/gtrummell/makeci"
}

get_changelist() {
    # Get the differences between this branch and MERGE_TARGET
    cd ${REPO_DIR}
    GIT_CHANGELIST=( $(git diff --name-status master | awk '{print $2}') )
    for CHANGE in ${GIT_CHANGELIST[*]}; do
        dirname ${CHANGE} | sed 's/^\///g'
    done | sort | uniq
}

find_makefile_dirs() {
    # Find directories that contain makefiles
    CHANGELIST_DIRS=( $(get_changelist) )
    for DIR in ${CHANGELIST_DIRS[*]}; do
        if [[ ${DIR} = '.' ]]; then
            echo "${REPO_DIR}"
            continue
        fi
        REL_PATH=$(echo ${DIR} | sed 's/^\.//g' | sed 's/^\///g')
        find ${REPO_DIR}/${REL_PATH} -type f -name "Makefile" -exec dirname {} \;
    done | sort | uniq
}

build_changed() {
# Run `make ci` against each found Makefile
    cd ${REPO_DIR}
    MAKEFILE_DIRS=( $(find_makefile_dirs) )
    echo -e "Found changes in the following component paths:"
    for MAKEFILE_DIR in ${MAKEFILE_DIRS[*]}; do
    echo "  ${MAKEFILE_DIR}"
    done
    for MAKEFILE_DIR in ${MAKEFILE_DIRS[*]}; do
        echo "Building component in ${MAKEFILE_DIR} ..."
        cd ${MAKEFILE_DIR}
        make ci
        cd ${REPO_DIR}
    done
}

if [[ $(echo $@ | grep " -h" | wc -l) -gt 1 ]]; then
    show_help
else
    build_changed
fi
