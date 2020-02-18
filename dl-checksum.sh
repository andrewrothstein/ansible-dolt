#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/liquidata-inc/dolt/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local archive_type=${4:-tar.gz}
    local platform=${os}-${arch}
    local rfile=dolt-${platform}.${archive_type}
    local url=$MIRROR/${ver}/$rfile
    local lfile=$DIR/dolt-${platform}-${ver}.tar.gz

    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `sha256sum $lfile | awk '{print $1}'`
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" $ver
    dl $ver darwin 386
    dl $ver darwin amd64
    dl $ver linux 386
    dl $ver linux amd64
    dl $ver windows 386 zip
    dl $ver windows amd64 zip
}

dl_ver ${1:-v0.14.0}
