.PHONY: try run build clean

try: REMOVE=--rm
try: run

run:
	@\
	SHARED="$$(mktemp -d /tmp/playground.XXXXXX)"; \
	DISPLAY="$$([ $$(uname) = Linux ] && echo $$DISPLAY || echo host.docker.internal:0)"; \
	docker run $(REMOVE) \
		--tty \
		--interactive \
		--volume "$$SHARED:/home/user/playground" \
		--volume /tmp/.X11-unix:/tmp/.X11-unix \
		--env PLAYGROUND_SHARED="$$SHARED" \
		--env DISPLAY=$$DISPLAY \
		--hostname playground \
		$(OPTIONS) \
		playground || true

build:
	@docker build --no-cache --tag playground .

clean:
	@docker rmi playground
