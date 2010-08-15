ROOT=ttf-orbitron

FONTS=$(ROOT)/orbitron-black.otf $(ROOT)/orbitron-bold.otf $(ROOT)/orbitron-light.otf $(ROOT)/orbitron-medium.otf

ttf-orbitron_001.000-1_all.deb: $(FONTS) $(ROOT)/OFL.txt $(ROOT)/readme.txt
	cd $(ROOT) && debuild -us -uc

$(ROOT)/OFL.txt: $(ROOT)/Open\ Font\ License.txt
	cd $(ROOT) && cp "Open Font License.txt" OFL.txt

$(ROOT)/readme.txt $(ROOT)/Open\ Font\ License.txt: $(ROOT)/orbitron.zip
	cd $(ROOT) && unzip -j orbitron.zip "Orbitron/$(@F)"

$(FONTS): $(ROOT)/orbitron.zip
	cd $(ROOT) && unzip -j orbitron.zip "Orbitron/OTF/$(@F)"

$(ROOT)/orbitron.zip:
	cd $(ROOT) && curl -O http://s3.amazonaws.com/theleague-production/fonts/orbitron.zip

install: ttf-orbitron_001.000-1_all.deb
	dpkg -i ttf-orbitron_001.000-1_all.deb

clean:
	rm -f ttf-orbitron_001.* *~ $(FONTS)
	cd $(ROOT) && rm -f *.txt orbitron.zip
	cd $(ROOT)/debian && rm -rf ttf-orbitron.debhelper.log ttf-orbitron.substvars ttf-orbitron/
