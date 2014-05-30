namesbystate.zip:
	wget http://www.ssa.gov/oact/babynames/state/namesbystate.zip

bookworm/files:
	mkdir -p bookworm/files
	mkdir -p bookworm/files/texts
	mkdir -p bookworm/files/metadata

bookworm/files/metadata/jsoncatalog.txt: bookworm/files
	rm -f $@
	ln -s ../../../jsoncatalog.txt $@

bookworm/files/metadata/field_descriptions.json: field_descriptions.json bookworm/files
	cp $< $@

bookworm/files/texts/input.txt: bookworm/files
	rm -f $@
	ln -s ../../../input.txt $@

#bookworm/files/texts/metadata/field_descriptions.json

states:
	unzip namesbystate.zip
	mkdir -p states
	mv *.TXT states

bookwormdone: bookworm/bookworm.cnf bookworm/files/metadata/field_descriptions.json
	cd bookworm; make;
	touch $@

bookworm/bookworm.cnf: bookworm/files/texts/input.txt bookworm/files/metadata/jsoncatalog.txt
	cd bookworm; make bookworm.cnf

input.txt: states
	python parsefiles.py

bookworm:
	git clone git@github.com:bmschmidt/Presidio bookworm
	cd bookworm; git checkout lessDiskSpace


