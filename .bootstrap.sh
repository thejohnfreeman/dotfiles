#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

if [ $(id -u -n) == 'jfreema2' ]; then
  yadm config local.class citadel
fi

yadm alt
yadm bootstrap
