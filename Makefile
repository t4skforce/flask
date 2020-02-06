.PHONY: all clean build run

all: clean build run

clean:
	@echo "cleaning things"
	docker kill flask && echo "stopped container" || /bin/true
	docker rm flask && echo "removed container" || /bin/true
	docker rmi t4skforce/flask:latest && echo "removed container image" || /bin/true

build:
	@echo "building things"
	docker build -t t4skforce/flask:latest .

run:
	@echo "runing things"
	docker run --name flask -p 127.0.0.1:8080:8080 -it --rm t4skforce/flask:latest

debug:
	@echo "runing things"
	docker run --name flask -p 127.0.0.1:8080:8080 -e FLASK_DEBUG=True -it --rm t4skforce/flask:latest

