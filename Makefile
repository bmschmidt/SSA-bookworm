namesbystate.zip:
	wget http://www.ssa.gov/oact/babynames/state/namesbystate.zip


states:
	unzip namesbystate.zip
	mkdir -p states
	mv *.TXT states

input.txt: states
	python parsefiles.py

