#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2164

## @file
# EFI build script for the UX581GV/UX581LV
#
# Copyright (c) 2023, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

# Change CWD for imports
__PWD__=$(pwd); cd "$(realpath "$(dirname "${BASH_SOURCE[0]}")"/../)"

args=("$@")
function has_flag() {
  local flag="$1"
  for i in "${!args[@]}"; do
    if [[ "${args[$i]}" == "$flag" ]]; then
      unset 'args[i]'
      return 0
    fi
  done
  return 1
}

# Switches for additional '--UX581GV' patches
if has_flag "--UX581GV"; then
  patches+=("-p patch.UX581GV.yml")
fi

# Run build script
args+=("${patches[@]}")
curl -sL https://raw.githubusercontent.com/Qonfused/OCE-Build/main/ci/bootstrap.sh \
  | bash -s build "${args[@]}"
