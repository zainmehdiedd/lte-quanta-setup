=======================
 Automatic LTE Startup
=======================

The scripts and configurations automate the initialization of an lte
connection. The given configuration works for Quanta MobileGenie USB devices.

Requirements
============

 * wvdial
 * usb_modeswitch

Install
=======

The following command will install all files and configures a daemon to
auomatically establish the connection.

::
    make install

The default will install a SysV init script. Alternatively an upstart script
can be installed with the following command

::
    make install INIT=upstart

Run
===

To start the daemon just run:

::
    service lte start

This will start the program in the background. Additionally the daemon
should automatically start on reboots.

You can also run the program in the foreground. For this first stop the
daemon:

::
    service lte stop

And then call the startup script yourself:

::
    lte-connect

This can be helpful for troubleshooting.

Deinstall
=========

The executables can be removed with the following command:

::
    make uninstall

This also stops the daemon and removes the startup scripts. Some errors might
be reported because it will try to remove the daemon files for all init
systems.

But the configuration files will not be deleted. To also remove these files
run:

::
    make purge

Troubleshooting
===============

Normally the startup script should take care of all the problems. If it does
not work then you need to find the solution on your own. But the following
hints can help you to identify the source of the problem.

1. Check if the device is in the correct mode. Run `lsusb`. You should see
   a device with the id 0408:ea47. If you see 0408:ea43 then the device is
   in the wrong operation mode. Use usb_modeswitch to change that.
2. If the network interface does not exist there is probably a driver issue.
   Check if the devices /dev/ttyUSB* exist. If it does not exist then the
   driver is not loaded correctly.
3. Check if the ppp0 network interface is available and configured.  If the
   ppp0 device exists but has no IP then the error is probably with the
   connection to the LTE network. Check the `wvdial.conf`.

If all fails try to reboot or unplug the LTE device.
