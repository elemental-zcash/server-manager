#!/usr/bin/env bash

set -e

log() {
    printf "%s INFO: %s\n" "$(date +"%Y-%m-%dT%H:%M:%S,%N")" "$*"
}

if [[ -z "$SSH_ORIGINAL_COMMAND" ]]; then
  log "No command specified."
  exit 1
fi

read -a PARAMS <<< "$SSH_ORIGINAL_COMMAND"

# branch_name=$(echo "$SSH_ORIGINAL_COMMAND" | tr -cd '[:alnum:]\n')
# git rev-parse --short=7 refs/heads/example-branch-name

# git rev-parse --short=7 refs/heads/$BRANCH_NAME

# deploy elemental-zcash sso main
# deploy elemental-zcash sso staging



if [[ "${PARAMS[0]}" == "update" ]]; then
  # org_name=$(echo "${PARAMS[1]}" | tr -cd '[:alnum:]-_\n')
  repo_name=$(echo "${PARAMS[1]}" | tr -cd '[:alnum:]-_\n')
  branch_name=$(echo "${PARAMS[2]}" | tr -cd '[:alnum:]/\n')
  log "$repo_name $branch_name"
  if [[ "${branch_name}" == "main" ]]; then
    cd ~/services/$repo_name/production
    log "123"
    git pull origin main
    npm run stop
    npm run start:prod
  elif [[ "${branch_name}" == "staging" ]]; then
    cd ~/services/$repo_name/staging
    git pull origin staging
    npm run stop
    npm run start:staging
  elif [[ -z "$branch_name" ]]; then
    exit 1
  fi
  # else
  #   hash_id="${git rev-parse --short=7 refs/heads/$BRANCH_NAME}"
  #   if [[ ! -d ~/services/$repo_name/$hash_id ]]; then
  #     mkdir ~/services/$repo_name/$hash_id
  #     cd ~/services/$repo_name/$hash_id
  #     git clone https://github.com/elemental-zcash/$repo_name.git
  #     git checkout $repo_name
  #   else
  #     cd ~/services/$repo_name/$hash_id
  #   fi
  #   git pull origin $repo_name
  # fi
  # cd ~/services/
  log "Starting update"
  # ...
elif [[ "${PARAMS[0]}" == "backup" ]]; then
  log "Starting backup"
  # ...
else
  log "Unknown Parameters: ${PARAMS[*]}"
  exit 1
fi


