INSTALL=install
INIT=sysv

.PHONY: install uninstall purge install-files install-$(INIT)

help:
	cat README.rst

install: install-files install-$(INIT)

install-files:
	$(INSTALL) -d /etc/lte
	$(INSTALL) lte-connect /usr/sbin/lte-connect
	$(INSTALL) -b --mode=0600 wvdial.conf /etc/lte/wvdial.conf
	$(INSTALL) -b modeswitch.conf /etc/lte/modeswitch.conf

install-upstart:
	$(INSTALL) upstart/lte.conf /etc/init/lte.conf

install-sysv:
	$(INSTALL) sysv/lte /etc/init.d/lte
	update-rc.d lte defaults

purge: uninstall
	-rm -r /etc/lte

uninstall:
	-rm /usr/sbin/lte-connect
	-rm /etc/init.d/lte && update-rc.d lte remove
	-rm /etc/init/lte.conf

