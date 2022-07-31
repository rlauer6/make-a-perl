perl: Dockerfile
	if test -z "$$VERSION"; then \
	  echo "no version - set VERSION"; \
	else \
	  set -x; \
	  rm -f $@_$$VERSION; \
	  docker build --build-arg version=$$VERSION -f $< . -t $@_$$VERSION | tee $@_$$VERSION.log; \
	  touch $@_$$VERSION; \
	fi

clean:
	rm -f *.log
