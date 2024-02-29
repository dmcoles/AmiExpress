[sof]                 ____
       ___________  __\  /________ ________________________________
       \_  _ ¬\  ¬\/ ¬\\/¡  ___/ ¬Y  / __  /__ ¬\   ___/ ___/  ___/C
.--/----¡  ¬   \  \/   \ | __/__> ' <  ¬__/  ¬ _/_ __/_____ ¬\___ ¬\-----\--.
|//     l__¡   \\_¡¡   \\!___  ¬\_.  \  ¡ l__¡  ¯¬\__  ¬\    \\    \\     \\|
/         ¬l____/¬'l____/: ¬l___/ l___\ !   ¬l____/¬l___/_____/_____/       \
|                      ·                 ·                                  |
| Version 5.6.1                                                             |
|                                                                           |
| Ami-Express was a BBS System that ran on the Commodore Amiga series of    |
| computers and was developed by Lightspeed Technologies in the 1990s.      |
|                                                                           |
| This is a rewrite of that system written in Amiga E. It is open source    |
| and has new features and bug fixes in addition to aiming for near 100%    |
| backwards compatibility with the version 4.x releases.                    |
|                                                                           |
| I contacted Joe Hodge/LightSpeed Technologies the owner of /X product     |
| in December 2018 and he has given his full approval for me to take over   |
| this software and to continue using the Ami-Express name.                 |
|                                                                           |
| I have also updated the documentation for Ami-Express as many existing    |
| features were not properly documented. This documenations (including      |
| setup, tooltype information and troubleshooting help) is here:            |
|                                                                           |
|  https://github.com/dmcoles/AmiExpress/wiki                               |
|                                                                           |
| In addition all source code is publicly available at:                     |
|  https://github.com/dmcoles/AmiExpress                                    |
|                                                                           |
| The sample bbs configurations included in previous versions of this tool  |
| are no longer included. The new install process will create a default     |
| minimal (but functional) BBS for you. You can then use the new setup tool |
| to fully configure the BBS and create a system tailored to your needs.    |
| The default bbs also contains some useful doors that are typically used   |
| on every Ami-Express bbs eg AquaScan and FileDescription.                 |
|                                                                           |
| This version of /X comes with both rexxdoor 1.3 and 2.2 - If you have 10  |
| nodes or more you *MUST* use 2.2 - new installations will be configured   |
| to use the newer version but upgrades will leave the the setup unaltered. |
|                                                                           |
| If you are a pre-existing /X4 user, the ACP and Express files can just    |
| replace the old versions and should be as close to fully backwards        |
| compatible as possible. Please do contact me or raise issues in github if |
| you encounter any problems.                                               |
|                                                                           |
| Copyright (c)2024 Darren Coles                                            |
| Permission is hereby granted, free of charge, to any person obtaining a
| copy of this software and associated documentation files (the "Software"),|
| to deal in the Software without restriction, including without limitation |
| the rights to use, copy, modify, merge, publish, distribute, sublicense,  |
| and/or sell copies of the Software, and to permit persons to whom the     |
| Software is furnished to do so, subject to the following conditions:      |
|                                                                           |
| The above copyright notice and this permission notice shall be included   |
| in all copies or substantial portions of the Software.                    |
|                                                                           |
| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS   |
| OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF                |
| MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN |
| NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,  |
| DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR     |
| OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE |
| USE OR OTHER DEALINGS IN THE SOFTWARE.                                    |
|                                                                           |
| Installer and Installer project icon                                      |
| (c) Copyright 1995-96 Escom AG.  All Rights Reserved.                     |
| Reproduced and distributed under license from Escom AG.                   |
|                                                                           |
| INSTALLER SOFTWARE IS PROVIDED "AS-IS" AND SUBJECT TO CHANGE;             |
| NO WARRANTIES ARE MADE.  ALL USE IS AT YOUR OWN RISK.  NO LIABILITY       |
| OR RESPONSIBILITY IS ASSUMED.                                             |
|                                                                           |
|---------------------------------------------------------------------------|
|    This release is dedicated to my ex-partner Traci who was taken ill     |
|      unexpectedly at the end of 2018 and passed away after suffering      |
|               lung damage caused by Influenza. RIP Traci xx.              |
|---------------------------------------------------------------------------|
|                                                                           |
| Version History                                                           |
|                                                                           |
| 5.6.1 02 Jan 2024                                                         |
|       * Some fixes to resolve issues when running on 68000                |
|       * Added support for conf NDIRS setting in the configuration editor  |
|       * Added option to move mail messages to another conference          |
| 5.6.0 02 Jan 2024                                                         |
|       * Improved password encryption, Full Setup Editor, Installer        |
| 5.5.0 05 Jun 2022 (Feature parity release)                                |
|       * XMODEM and Hydra support, FTP Direct Server, IEMSI auto login     |
| 5.4.0 17 May 2021                                                         |
|       * YModem and ZModem 8k support, FTP authentication, shortcut mode   |
| 5.3.2 01 September 2020                                                   |
|       * Minor bugfix release                                              |
| 5.3.1 07 August 2020                                                      |
|       * Minor bugfix release                                              |
| 5.3.0 04 July 2020                                                        |
|       * Internal Zmodem, HTTP File Transfers, connect to QWK & FTN        |
| 5.2.0 02 Jan 2020                                                         |
|       * Native Telnet, FTP File Transfers, some bugfixes.                 |
| 5.1.0 03 June 2019                                                        |
|       * New features and bugfixes.                                        |
| 5.0.0 23 December 2018                                                    |
|       * First release of this project                                     |
\                                                                           /
|\\                                                                       //|
`--\---------------------------------------------------------------------/--'
                                                                        [eof]
