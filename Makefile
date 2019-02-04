.PHONY: try run build clean

try: REMOVE=--rm
try: run

run:
	@SHARED="$$(mktemp -d /tmp/playground.XXXXXX)"; \
	docker run $(REMOVE) -it \
		-v "$$SHARED:/home/user/playground" \
		-e PLAYGROUND_SHARED="$$SHARED" \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=$$DISPLAY \
		--shm-size=256m \
		--hostname playground \
		$(OPTIONS) \
		playground || true

build:
	@docker build --no-cache -t playground .

clean:
	@docker rmi playground
