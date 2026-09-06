#!/usr/bin/env bash
[[ -n "$DEBUG" ]] && set -x
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # http://stackoverflow.com/questions/59895
# export GIT_CEILING_DIRECTORIES="$(pwd)"

  cd "$DIR"
  make init
  make check
  uv run "$(basename "$PWD")"

echo "[PASS] Test succeeded!"  # errexit above guarantees failures exit before this
