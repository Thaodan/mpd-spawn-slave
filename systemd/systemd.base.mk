include $(abspath $(dir $(lastword $(MAKEFILE_LIST))))/../rules.mk
src_systemddir		= $(DIST_ROOT)/systemd
config_shh		= $(src_systemddir)/config.shh
body_suffix 		= in
