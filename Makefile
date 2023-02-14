NAME = kubiscan
REGISTRY = gcr.io/awesome-dogfish-208918
VERSION = $(shell git describe --tags --dirty --always --long)

BUILDX_BUILDER = flexibits-multi-arch-builder
DEPLOYMENT_ARCH = linux/amd64

push: buildx-builder
	docker buildx build -f Dockerfile.flexibits \
		--platform ${DEPLOYMENT_ARCH} \
		--tag ${REGISTRY}/${NAME}:${VERSION}-dev \
		--push .

buildx-builder:
	docker buildx create --use --name ${BUILDX_BUILDER} --node ${BUILDX_BUILDER} --platform linux/arm64,linux/amd64
