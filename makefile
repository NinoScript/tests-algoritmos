all:
	coffee --watch --compile --map src/

clear:
	rm src/*.js
