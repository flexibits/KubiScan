REGISTRY = us-east1-docker.pkg.dev/awesome-dogfish-208918
REPOSITORY = kubiscan
IMAGE_NAME = ${REPOSITORY}/kubiscan
VERSION = $(shell git describe --tags --dirty --always --long)

BUILDX_BUILDER = flexibits-multi-arch-builder
DEPLOYMENT_ARCH = linux/amd64

push: buildx-builder
	docker buildx build -f Dockerfile.flexibits \
		--platform ${DEPLOYMENT_ARCH} \
		--tag ${REGISTRY}/${IMAGE_NAME}:${VERSION} \
		--push .

buildx-builder:
	docker buildx create --use --name ${BUILDX_BUILDER} --node ${BUILDX_BUILDER} --platform linux/arm64,linux/amd64
