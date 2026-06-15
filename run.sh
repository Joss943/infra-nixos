#!/usr/bin/env bash
set -euo pipefail
export PATH=/run/current-system/sw/bin:$PATH
cd "$(dirname "$0")"
bash install-luks.sh