all:
	elm make src/Main.elm --output build/style.js
	cp src/bgm.mp3 build/bgm.mp3
	cp src/trigger.mp3 build/trigger.mp3


