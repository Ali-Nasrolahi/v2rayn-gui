all:
	podman compose build

run:
	podman compose run --rm v2rayn

up: down
	podman compose up

down:
	podman compose down

clean:
	podman system prune --volumes