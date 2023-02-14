NAME = kubiscan
REGISTRY = gcr.io/awesome-dogfish-208918
VERSION = $(shell git describe --tags --dirty --always --long)

BUILDX_BUILDER = flexibits-multi-arch-builder
DEPLOYMENT_ARCH = linux/amd64

all: buildx-builder
	docker buildx build -f Dockerfile.flexibits -t ${NAME} --platform ${DEPLOYMENT_ARCH} --load .

push:
	docker tag ${NAME}:latest ${NAME}:${VERSION}-dev
	docker tag ${NAME}:latest ${REGISTRY}/${NAME}:${VERSION}-dev
	docker push ${REGISTRY}/${NAME}:${VERSION}-dev

buildx-builder:
	docker buildx create --use --name ${BUILDX_BUILDER} --node ${BUILDX_BUILDER} --platform linux/arm64,linux/amd64
