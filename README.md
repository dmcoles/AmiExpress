# AmiExpress

### Introduction

Welcome to the AmiExpress repository. AmiExpress was a BBS System that ran on the Commodore Amiga series of computers and was originally written by Michael Thomas of Synthetic Technologies and later developed by Joseph Hodge of Lightspeed Technologies after he purchased the rights to it. 

Joe has given full approval of this project to resurrect the Ami-Express product and has given me permission to continue to use the Ami-Express name.

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

### Documentation

The latest documentation for setting up and troubleshooting Ami-Express 5 is always located here:

https://github.com/dmcoles/AmiExpress/wiki

### Want to help out?

I am currently the sole developer on this project. If you are experienced with running /X on the Amiga platform and wish to help out, please feel free to contact me. I am always looking for ideas on how to improve this product.

### License 

Copyright (c)2024 Darren Coles

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Installer and Installer project icon
(c) Copyright 1995-96 Escom AG.  All Rights Reserved.
Reproduced and distributed under license from Escom AG.

INSTALLER SOFTWARE IS PROVIDED "AS-IS" AND SUBJECT TO CHANGE;
NO WARRANTIES ARE MADE.  ALL USE IS AT YOUR OWN RISK.  NO LIABILITY
OR RESPONSIBILITY IS ASSUMED.