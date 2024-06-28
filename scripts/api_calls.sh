#!/bin/bash

b64_authentication() {
    echo -n "$GITHUB_USER:$GITHUB_TOKEN" | base64
}

call_api() {
    local endpoint=$1
    local methodType=$2
    local hasPostParams=$3
    local postParams=${4:-}

    local headers=(
        -H "Authorization: Basic $(b64_authentication)"
        -H "Accept: application/vnd.github.v3+json"
    )

    if $hasPostParams; then
        curl -s "${headers[@]}" -X "$methodType" -d "$postParams" "$endpoint"
    else
        curl -s "${headers[@]}" -X "$methodType" "$endpoint"
    fi
}
