.PHONY: exec-krm
# -e LOCAL_EMULATOR_ID=blablabla should be exposed to the demo.sh script, but is not
exec-krm:
	kustomize build -e LOCAL_EMULATOR_ID=blablabla --enable-alpha-plugins --enable-exec ./exec-krm

.PHONY: container-krm
# -e LOCAL_EMULATOR_ID=blablabla is correctly exposed as env var to the container
container-krm:
	@echo "You have to build the container local first using: docker build . -t krm-demo"
	@echo ""

	kustomize build -e LOCAL_EMULATOR_ID=blablabla --enable-alpha-plugins ./container-krm

.PHONY: build-demo-oci
build-demo-oci:
	docker build . -t krm-demo
