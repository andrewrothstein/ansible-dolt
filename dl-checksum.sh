#!/usr/bin/env bash
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

    if [ ! -e "$lfile" ];
    then
        curl -fsSL --proto '=https' --tlsv1.2 -o "$lfile" "$url"
    fi
    local sum
    sum=$(sha256sum "$lfile" | awk '{print $1}')
    if ! printf '%s' "$sum" | grep -Eq '^[0-9a-f]{64}$'; then
        echo "bad checksum for $url" >&2
        exit 1
    fi

    printf "    # %s\n" "$url"
    printf "    %s: sha256:%s\n" "$platform" "$sum"
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" "$ver"
    dl "$ver" darwin amd64
    dl "$ver" darwin arm64
    dl "$ver" linux amd64
    dl "$ver" linux arm64
    dl "$ver" windows amd64 zip
}

for v in "${@:-v2.7.2}"; do
    dl_ver "$v"
done
