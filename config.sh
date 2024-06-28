#!/bin/bash

# Fill in your GitHub username and token. 
# It is recommended to set these as environment variables for security reasons.
GITHUB_USER="${GITHUB_USERNAME}"
GITHUB_TOKEN="${GITHUB_TOKEN}"

# Specify the visibility type of the repositories to be processed.
# Options:
# "public" - Targets public repositories.
# "private" - Targets private repositories.
REPOS_VISIBILITY_TYPE="public"

# Specify the desired visibility change for the target repositories.
# Options:
# "true" - Set repositories to private.
# "false" - Set repositories to public.
SET_TO_PRIVATE="true"


