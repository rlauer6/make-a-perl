VERSION = $$VERSION

TARBALL = $$TARBALL

all: test_$(VERSION)

test_$(VERSION): Dockerfile
	set -x; \
	docker build --build-arg version=$(VERSION) -f $< . -t $@
	touch $@

test: test_$(VERSION)
	set -x; \
	cp $(TARBALL) .; \
	TARBALL=$$(basename $(TARBALL)); \
	docker run --rm -v $$(pwd)/$$TARBALL:/$$TARBALL test_$(VERSION) ./test-module $$TARBALL
