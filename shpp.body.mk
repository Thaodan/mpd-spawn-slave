$(SCRIPTS): ${SCRIPTS:=.$(body_suffix)}
	$(SHPP) $(SHPPFLAGS)\
		$(@).$(body_suffix) \
		-o $@
