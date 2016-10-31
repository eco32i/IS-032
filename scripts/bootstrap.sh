#!/bin/bash -e

tabs 4
clear
readonly VENV_DIR=$HOME/.venv

install_core() {
    sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y
    sudo apt install -y libcurl4-openssl-dev python-dev python3-dev \
        build-essential cmake git linux-headers-generic \
        libopenblas-base libopenblas-dev gfortran g++ python-pip \
        samtools bedtools libpng-dev libjpeg8-dev libfreetype6-dev \
        libatlas3-base libatlas-dev python3-venv libxml2-dev libxslt-dev
    sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
    sudo update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3
    sudo update-alternatives --set liblapack.so.3 /usr/lib/openblas-base/liblapack.so.3
}

setup_env() {
    local pydata="pydata.list"
    
    if [ -d $VENV_DIR/pydata3 ]
    then
        rm -rf $VENV_DIR/pydata3
    fi

    pyvenv $VENV_DIR/pydata3
    source $VENV_DIR/pydata3/bin/activate
    pip install -U pip
    cat $pydata | xargs -n 1 -L 1 pip install
    deactivate
}


show_help() {
    cat <<EOF
    usage: $0 options

    Installs dependencies and sets up python 3 virtual environment
    for ChIP-Seq data analysis on a standard Ubuntu (16.04) machine.

    OPTIONS:

    -h | --help     display this help text and exit

    -c | --core     upgrade GNOME to latest version, install dev dependencies,
                    install bioinformatics a nd data analysis packages
    -e | --env      set up python 3 virtualenv with data analysis/bioinformatics stack
                    as specified in pydata.list
    -a | --all      all of the above
EOF
}

readonly OPTS=`getopt -o aceh --long all,core,env,help -n 'bootstrap.sh' -- "$@"`

if [ $? != 0 ] ; then echo "Failed to parse options." >&2; exit 1; fi
eval set -- "$OPTS"

while true
do
    case "$1" in
        -a|--all)
            install_core
            setup_env
            shift
            ;;
        -c|--core)
            install_core
            shift
            ;;
        -e|--env)
            setup_env
            shift
            ;;
        -h|--help)
            show_help
            exit 1
            ;;
        * )
            break
            ;;
    esac
done

