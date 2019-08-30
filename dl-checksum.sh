#!/usr/bin/env sh
VER=${1:-v0.9.8}
DIR=~/Downloads
MIRROR=https://github.com/liquidata-inc/dolt/releases/download/${VER}

dl()
{
    OS=$1
    ARCH=$2
    PLATFORM=${OS}-${ARCH}
    RFILE=dolt-${PLATFORM}.tar.gz
    URL=$MIRROR/$RFILE
    LFILE=$DIR/dolt-${PLATFORM}-${VER}.tar.gz

    if [ ! -e $LFILE ];
    then
        wget -q -O $LFILE $URL
    fi

    printf "    # %s\n" $URL
    printf "    %s: sha256:%s\n" $PLATFORM `sha256sum $LFILE | awk '{print $1}'`
}

printf "  %s:\n" $VER
dl darwin 386
dl darwin amd64
dl linux 386
dl linux amd64
dl windows 386
dl windows amd64



