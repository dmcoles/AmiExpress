[sof]                 ____
       ___________  __\  /________ ________________________________
       \_  _ ¬\  ¬\/ ¬\\/¡  ___/ ¬Y  / __  /__ ¬\   ___/ ___/  ___/C
.--/----¡  ¬   \  \/   \ | __/__> ' <  ¬__/  ¬ _/_ __/_____ ¬\___ ¬\-----\--.
|//     l__¡   \\_¡¡   \\!___  ¬\_.  \  ¡ l__¡  ¯¬\__  ¬\    \\    \\     \\|
/         ¬l____/¬'l____/: ¬l___/ l___\ !   ¬l____/¬l___/_____/_____/       \
|                      ·                 ·                                  |
| Ami-Express was a BBS System that ran on the Commodore Amiga series of    |
| computers and was developed by Lightspeed Technologies in the 1990s.      |
|                                                                           |
| Version 5.5.0                                                             |
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
| features were not properly documented. Some new features included in this |
| release are:                                                              |
|   * XMODEM and HYDRA protocol support                                     |
|   * IEMSI support for auto-login if your client supports it.              |
|   * FTP Direct Server - you can now log onto FTP directly and upload or   |
|     download without having to log on via telnet.                         | 
|   * Improved CPS info in ACP during transfers                             |
|                                                                           |
| With the inclusion of the HYDRA protocol support in this release we have  |
| achieved full feature parity with the old V4.x Releases of Ami-Express.   |
| There may still be some small differences between this version and the    |
| older releases but all features are now covered.                          |
|                                                                           |
| All source code is publicly available at:                                 |
|  https://github.com/dmcoles/AmiExpress along with the documentation.      |
|                                                                           |
| Included in this archive are several sample bbs configurations using      |
| tooltype (.info) and config file (.cfg) format. These are aimed at users  |
| wanting to set up a bbs for the first time. There is also a file called   |
| aeicon.json which can be imported using the json import tool or by        |
| selecting the file the first time you start /X with no configuration in   |
| place. This file will create a basic structure similar to the ones        |
| included in the archive.                                                  |
|                                                                           |
| This verison of /X comes with both rexxdoor 1.3 and 2.2 - If you have 10  |
| nodes or more you *MUST* use 2.2 (rename it to rexxdoor) - however this   |
| version requires that you make RX resident otherwise it won't work. If    |
| you have less than 10 nodes you can use either version.                   |
|                                                                           |
| If you are a pre-existing /X4 user, the ACP and Express files can just    |
| replace the old versions and should be as close to fully backwards        |
| compatible as possible. Plesae do contact me or raise issues in github if |
| you encounter any problems.                                               |
|                                                                           |
|---------------------------------------------------------------------------|
|      This release is dedicated to my partner Traci who was taken ill      |
|      unexpectedly at the end of 2018 and passed away after suffering      |
|               lung damage caused by Influenza. RIP Traci xx.              |
|---------------------------------------------------------------------------|
|                                                                           |
| Version History                                                           |
|                                                                           |
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
