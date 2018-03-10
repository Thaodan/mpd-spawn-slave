include src.base.mk
VER	     	 	= $(shell ./../tools/git_revgen)
SCRIPTS			= mpd-spawn-slave

all: $(SCRIPTS)

#$(config_shh): 
#	@echo $@: generating 
#	@echo '#\\define VER=$(VER)' > $@
#	@echo '#\\define libdir=$(libdir)' >> $@

include src.body.mk

install: install_bin
install_bin: $(SCRIPTS)
	$(INSTALL) -dm755 $(bindir)
	$(INSTALL) -m755 $(^) $(bindir) 

clean:
	rm -f $(SCRIPTS)

.PHONY: clean lib install
