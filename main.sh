#!/bin/bash

source ./config.sh
source ./scripts/api_calls.sh
source ./scripts/repos_handler.sh

repos_to_private() {
    local jsonStr=""
    local pageNo=1

    while : ; do
        jsonStr=$(get_repos $pageNo)
        if [ "$jsonStr" = "[]" ]; then
            break
        fi
        handle_json_for_private "$jsonStr"
        ((pageNo++))
    done
}

get_repos() {
    local pageNo=$1
    local endpoint="https://api.github.com/user/repos?visibility=${REPOS_VISIBILITY_TYPE}&page=${pageNo}"
    call_api "$endpoint" "GET" false
}

handle_json_for_private() {
    local json=$1
    echo "$json" | grep -o '"url": *"[^"]*' | grep -o '"[^"]*$' | tr -d '"' | grep '/repos/' | while read -r endpoint; do
        echo "endpoint: $endpoint"
        local resp=$(set_repo_to_private "$endpoint")
        local private=$(echo "$resp" | grep -o '"private": *[^,]*' | grep -o '[^:]*$' | tr -d ' ' | tr -d '"')
        local archived=$(echo "$resp" | grep -o '"archived": *[^,]*' | grep -o '[^:]*$' | tr -d ' ' | tr -d '"')
        echo "private = $private, archived = $archived"
    done
}

set_repo_to_private() {
    local endpoint=$1
    local postParams="{\"private\":\"${SET_TO_PRIVATE}\", \"archived\":false}"
    call_api "$endpoint" "PATCH" true "$postParams"
}

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

# Start the process
repos_to_private
