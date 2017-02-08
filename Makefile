build:
	docker build --tag=mrjoshuap/znc:latest .

run:
	docker run --detach --publish=6667:6667 --name=znc mrjoshuap/znc:latest

logs:
	docker logs -f znc

shell:
	docker exec -it znc bash

kill:
	docker kill znc

clean:
	docker rm znc || echo "already removed"
	docker rmi mrjoshuap/znc:latest || echo "already removed"

.PHONY: build

