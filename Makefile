NAME = kubiscan
REGISTRY = gcr.io/awesome-dogfish-208918
VERSION = $(shell git describe --tags --dirty --always --long)

all:
	docker build -f Dockerfile.flexibits -t ${NAME} .

push:
	docker tag ${NAME}:latest ${NAME}:${VERSION}-dev
	docker tag ${NAME}:latest ${REGISTRY}/${NAME}:${VERSION}-dev
	docker push ${REGISTRY}/${NAME}:${VERSION}-dev
