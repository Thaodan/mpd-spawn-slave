include systemd.base.mk
VER	     	 	= $(shell ./../tools/git_revgen)
SCRIPTS			= mpd-slaves@.service
override SHPPFLAGS     += -Dbindir=$(bindir)
all: $(SCRIPTS)

#$(config_shh): 
#	@echo $@: generating 
#	@echo '#\\define VER=$(VER)' > $@
#	@echo '#\\define libdir=$(libdir)' >> $@

include $(DIST_ROOT)/shpp.body.mk


install: install_bin
install_bin: $(SCRIPTS)
	$(INSTALL) -dm755 $(systemduserdir)


clean:
	rm -f $(SCRIPTS)

.PHONY: clean  install
