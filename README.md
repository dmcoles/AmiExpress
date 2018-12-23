# AmiExpress

### Introduction

Welcome to the AmiExpress repository. AmiExpress was a BBS System that ran on the Commodore Amiga series of computers and was developed by Lightspeed Technologies in the 1990s. Joe Hodge from Lightspeed technologies has given full approval of this project to resurrect the Ami-Express product and has given me permission to continue to use the Ami-Express name.

This is a rewrite of that system  written in Amiga E. It is open source and has new features and bug fixes in addition to most of the functionality of the previous version being implemented.

I have also updated the documentation for AmiExpress as many existing features were not properly documented.

### Some of the new features that have been added

*  Account editing screen correctly handles 115200 baud and above
*  Support for large partitions >2gb
*  Cursor left/right/insert/delete capability added to the line editor
*  Command history can be saved between sessions
*  Remote shell (needs fifo handler and library)
*  Display callers IP address in status bar
*  Option to display node callers log from await screen (Shift F6)
*  Option to change file size into MB instead of bytes in file list when it is too big
*  Option to allow timeout to be treated as a normal logoff instead of a carrier loss
*  New FM (File Maintenance command) allows files to be moved between conferences
*  Configurable node timeouts
*  configurable email notifications
*  specify default upload location for local uploads for each conference
*  New US command (upload sysop) allows files to be uploaded to any directory anyhere on the system
*  Query callers ip/hostname from telnetd.device and record to callers log, provide via door interface

### Want to help out?

I am currently the sole developer on this project. If you are experienced with running /X on the Amiga platform and wish to help out, please feel free to contact me. I am always looking for ideas on how to improve this product.
