#!/usr/bin/env sh
VER=${1:-v0.10.0}
DIR=~/Downloads
MIRROR=https://github.com/liquidata-inc/dolt/releases/download/${VER}

dl()
{
    local os=$1
    local arch=$2
    local archive_type=${3:-tar.gz}
    local platform=${os}-${arch}
    local rfile=dolt-${platform}.${archive_type}
    local url=$MIRROR/$rfile
    local lfile=$DIR/dolt-${platform}-${VER}.tar.gz

    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `sha256sum $lfile | awk '{print $1}'`
}

printf "  %s:\n" $VER
dl darwin 386
dl darwin amd64
dl linux 386
dl linux amd64
dl windows 386 zip
dl windows amd64 zip



