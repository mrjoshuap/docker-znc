build:
	docker build --tag=${USER}/znc:latest .

run:
	docker run --detach --publish=6667:6667 --name=znc ${USER}/znc:latest

logs:
	docker logs -f znc

shell:
	docker exec -it znc bash

kill:
	docker kill znc

clean:
	docker rm znc || echo "already removed"
	docker rmi ${USER}/znc:latest || echo "already removed"

.PHONY: build
