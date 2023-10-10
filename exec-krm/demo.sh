#!/bin/bash

set -e

e() {
  echo "ERROR: ${BASH_COMMAND}" >&2
}

trap e ERR

# <-- we have a custom code-generator here
# generate multipline string
cat <<EOF > /dev/stdout
---
apiVersion: v1
kind: Namespace
metadata:
  name: demo
  annotations:
    local-emulator-id: ${LOCAL_EMULATOR_ID}
EOF

