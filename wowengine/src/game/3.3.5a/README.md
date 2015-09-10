WOWENGINE
===========



To setup wowengine with upt just install upt with npm ( Nodejs is required to run npm and upt ):

	npm install -g upt

and then run

	upt install wowengine/game#3.3.5a

if you want to test the compiling, just run from the same folder 

	mkdir build
	cd build
	cmake ../upt-modules/wowengine/src/game/3.3.5a -DPREFIX=/home/$USER/wowengine-server
	make

To compile you need the requirements specified in trinitycore project: http://collab.kpsn.org/display/tc/TrinityCore+Requirements


You can also compile only core libraries using these commands from root folder:

	mkdir build
	cd build
	cmake ../upt-modules/trinitycore/src/project
	make
