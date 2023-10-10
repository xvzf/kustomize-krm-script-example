# Kustomize KRM function example/compare bash vs container

This repository shows the different behaviour of environment exposure for KRM functions, linked to exec and container based KRMs.

The `-e ENV_VAR=VALUE` flag is exposed to container KRM functions as environment variable, while it is dropped for exec based variables.

A Pull Request aligning the behaviour has already been created [here](https://github.com/kubernetes-sigs/kustomize/pull/5316).

## Steps to reproduce:
> Note: this requires a recent version of `kustomize`


Demo script at `exec-krm/demo.sh`:
```bash
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

```

1. Run the KRM exec function at `exec-krm/demo.sh` using
```bash
xvzf@MBP14 ~/gh/xvzf/kustomize-krm-script-example (git)-[main] % make exec-krm
kustomize build -e LOCAL_EMULATOR_ID=blablabla --enable-alpha-plugins --enable-exec ./exec-krm
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    local-emulator-id: ""
  name: demo
```

2. Build the `demo-krm` container, which runs the same script: `make build-demo-oci`

3. Run the KRM container function (same as step 1) with the same `-e LOCAL_EMULATOR_ID=blablabla`
```bash
xvzf@MBP14 ~/gh/xvzf/kustomize-krm-script-example (git)-[main] % make container-krm
You have to build the container local first using: docker build . -t krm-demo

kustomize build -e LOCAL_EMULATOR_ID=blablabla --enable-alpha-plugins ./container-krm
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    local-emulator-id: blablabla
  name: demo
```
