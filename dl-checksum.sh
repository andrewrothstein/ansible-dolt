#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/dolthub/dolt/releases/download

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
        curl -sSLf -o $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `sha256sum $lfile | awk '{print $1}'`
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" $ver
    dl $ver darwin amd64
    dl $ver darwin arm64
    dl $ver linux amd64
    dl $ver linux arm64
    dl $ver windows amd64 zip
}

dl_ver v1.78.6
dl_ver v1.78.7
dl_ver v1.78.8
dl_ver v1.79.0
dl_ver v1.79.1
dl_ver v1.79.2
dl_ver v1.79.3
dl_ver v1.79.4
dl_ver v1.80.0
dl_ver v1.80.1
dl_ver v1.80.2
dl_ver v1.81.0
dl_ver v1.81.1
dl_ver ${1:-v1.81.2}
