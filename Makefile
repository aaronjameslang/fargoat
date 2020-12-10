build:
	docker build . -t fargoat

run:
	docker run -it --rm --publish 5555:5000 fargoat
	# -it is needed for ctrl-c
