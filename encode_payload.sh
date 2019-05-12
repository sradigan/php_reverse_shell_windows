#!/bin/bash

source ./url_encode_decode.sh

urlencode "$(cat shell.php | tr -d '\n' | tr "'" "\"" | sed 's/\s\+/ /g')"
