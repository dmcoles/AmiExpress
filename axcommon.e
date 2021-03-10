-> stuff which is common to both ACP and Express 

  OPT MODULE

  MODULE 'exec/ports',
         'exec/nodes',
         'exec/semaphores',
         'exec/lists',
         'intuition/intuition',
         'dos/dosextens'

EXPORT ENUM ACS_ACCOUNT_EDITING,ACS_READ_BULLETINS,ACS_COMMENT_TO_SYSOP,ACS_DOWNLOAD,ACS_UPLOAD,ACS_ENTER_MESSAGE,ACS_FILE_LISTINGS,ACS_JOIN_CONFERENCE,ACS_NEW_FILES_SINCE,
     ACS_PAGE_SYSOP,ACS_READ_MESSAGE,ACS_REMOTE_SHELL,ACS_DISPLAY_USER_STATS,ACS_VIEW_A_FILE,ACS_EDIT_USER_INFO,ACS_EDIT_INTERNET_NAME,ACS_EDIT_USER_LOCATION,
     ACS_EDIT_PHONE_NUMBER,ACS_EDIT_PASSWORD,ACS_ZIPPY_TEXT_SEARCH,ACS_OVERRIDE_CHAT,ACS_SYSOP_DOWNLOAD,ACS_SYSOP_VIEW,ACS_SYSOP_READ,ACS_KEEP_UPLOAD_CREDIT,
     ACS_OVERRIDE_TIMES,ACS_CLEAR_SCREEN_MSG,ACS_FREE_RESUMING,ACS_ONE_TIME_BULLETINS,ACS_DO_CALLERSLOG,ACS_SENTBY_FILES,ACS_DO_UD_LOG,ACS_SCREEN_TO_FRONT,
     ACS_DEFAULT_CHAT_ON,ACS_EALL_MESSAGES,ACS_DUPE_FILECHECK,ACS_MESSAGE_EDIT,ACS_LIST_NODES,ACS_MSG_LEVEL,ACS_MSG_EXPERATION,ACS_DELETE_MESSAGE,ACS_ATTACH_FILES,
     ACS_CUSTOMCOMMANDS,ACS_JOIN_SUB_CONFERENCE,ACS_ZOOM_MAIL,ACS_MCI_MSG,ACS_EDIT_DIRS,ACS_EDIT_FILES,ACS_BREAK_CHAT,ACS_QUIET_NODE,ACS_SYSOP_COMMANDS,ACS_WHO_IS_ONLINE,
     ACS_RELOGON,ACS_ULSTATS,ACS_XPR_RECEIVE,ACS_XPR_SEND,ACS_WILDCARDS,ACS_CONFERENCE_ACCOUNTING,ACS_PRI_MSGFILES,ACS_PUB_MSGFILES,ACS_FULL_EDIT,ACS_CONFFLAGS,
     ACS_OLM,ACS_HIDE_FILES,ACS_SHOW_PAYMENTS,ACS_CREDIT_ACCESS,ACS_VOTE,ACS_MODIFY_VOTE,ACS_FILE_EXPANSION,ACS_EDIT_REAL_NAME,ACS_EDIT_USER_NAME,ACS_CENSORED,
     ACS_ACCOUNT_VIEW,ACS_TRANSLATION,ACS_UNKNOWN,ACS_CREATE_CONFERENCE,ACS_LOCAL_DOWNLOADS,ACS_MAX_PAGES,ACS_OVERRIDE_DEFAULTS,ACS_HOLD_ACCESS,ACS_EDIT_EMAIL,
     ACS_READ_PRIV_EALL,ACS_READ_PRIV_ALL,ACS_OVERRIDE_TIMELIMIT,ACS_OVERRIDE_CHATLIMIT,ACS_NO_TIMEOUT,ACS_USER_ULSTATS

EXPORT ENUM ENV_IDLE=0,ENV_DOWNLOADING=1,ENV_UPLOADING=2,ENV_DOORS=3,ENV_MAIL=4,ENV_STATS=5,ENV_ACCOUNT=6,ENV_ZOOM=7,ENV_FILES=8,ENV_BULLETINS=9,
      ENV_VIEWING=10,ENV_ACCOUNTSEQ=11,ENV_LOGOFF=12,ENV_SYSOP=13,ENV_SHELL=14,ENV_EMACS=15,ENV_JOIN=16,ENV_CHAT=17,ENV_NOTACTIVE=18,
       ENV_REQ_CHAT=19,ENV_CONNECT=20,ENV_LOGGINGON=21,ENV_AWAITCONNECT=22,ENV_SCANNING=23,ENV_SHUTDOWN=24,ENV_MULTICHAT=25,ENV_SUSPEND=26,ENV_RESERVE=27,
       ENV_ONLINEMSG=28, ENV_NUKE=29, ENV_SETUP=30

EXPORT CONST MAX_NODES=32

EXPORT CONST LVL_ACCOUNT_EDITING=0
EXPORT CONST LVL_COMMENT_TO_SYSOP=1
EXPORT CONST LVL_DOWNLOAD=2
EXPORT CONST LVL_ENTER_MESSAGE=3
EXPORT CONST LVL_FILE_LISTINGS=4
EXPORT CONST LVL_JOIN_CONFERENCE=5
EXPORT CONST LVL_NEW_FILES_SINCE=6
EXPORT CONST LVL_PAGE_SYSOP=7
EXPORT CONST LVL_READ_MSG=8
EXPORT CONST LVL_DISPLAY_USER_STATS=9
EXPORT CONST LVL_UPLOAD=10
EXPORT CONST LVL_VIEW_A_FILE=11
EXPORT CONST LVL_EDIT_USER_INFO=12
EXPORT CONST LVL_LVL_REMOTE_SHELL=13
EXPORT CONST LVL_ZIPPY_TEXT_SEARCH=14
EXPORT CONST LVL_OVERRIDE_CHAT=15
EXPORT CONST LVL_EDIT_USER_NAME=16
EXPORT CONST LVL_EDIT_USER_LOCATION=17
EXPORT CONST LVL_EDIT_PHONE_NUMBER=18
EXPORT CONST LVL_EDIT_PASSWORD=19
EXPORT CONST LVL_SENTBY_FILES=20
EXPORT CONST LVL_DEFAULT_CHAT_ON=21
EXPORT CONST LVL_CLEAR_SCREEN_MSG=22
EXPORT CONST LVL_CAPITOLS_in_FILE=23
EXPORT CONST LVL_CHAT_COLOR_SYSOP=24
EXPORT CONST LVL_CHAT_COLOR_USER=25
EXPORT CONST LVL_VARYING_LINK_RATE=26
EXPORT CONST LVL_KEEP_UPLOAD_CREDIT=27
EXPORT CONST LVL_ALLOW_FREE_RESUMING=28
EXPORT CONST LVL_DO_CALLERSLOG=29
EXPORT CONST LVL_DO_UD_LOG=30
EXPORT CONST LVL_OVERRIDE_TIMES=41
EXPORT CONST LVL_BULLETINS=42
EXPORT CONST LVL_SYSOP_READ=43
EXPORT CONST LVL_NODE_NUMBER=44
EXPORT CONST LVL_SCREEN_TO_FRONT=45
EXPORT CONST LVL_ZOO=46
EXPORT CONST LVL_PKAX=47
EXPORT CONST LVL_LHARC=48
EXPORT CONST LVL_WARP=49
EXPORT CONST LVL_LONGWHO=50

EXPORT CONST JH_LI=0
EXPORT CONST JH_REGISTER=1
EXPORT CONST JH_SHUTDOWN=2
EXPORT CONST JH_WRITE=3
EXPORT CONST JH_SM=4   
EXPORT CONST JH_PM=5
EXPORT CONST JH_HK=6
EXPORT CONST JH_SG=7
EXPORT CONST JH_SF=8
EXPORT CONST JH_EF=9
EXPORT CONST JH_CO=10
EXPORT CONST JH_BBSNAME=11
EXPORT CONST JH_SYSOP=12
EXPORT CONST JH_FLAGFILE=13
EXPORT CONST JH_SHOWFLAGS=14
EXPORT CONST JH_ExtHK=15
EXPORT CONST JH_SIGBIT=16
EXPORT CONST JH_FetchKey=17
EXPORT CONST JH_SO=18
EXPORT CONST JH_SMPTR=19
EXPORT CONST JH_20=20

EXPORT CONST DT_NAME=100
EXPORT CONST DT_PASSWORD=101
EXPORT CONST DT_LOCATION=102
EXPORT CONST DT_PHONENUMBER=103
EXPORT CONST DT_SLOTNUMBER=104
EXPORT CONST DT_SECSTATUS=105 /* DT_ACCESSLEVEL */
EXPORT CONST DT_SECBOARD=106 /* DT_RATIOTYPE */
EXPORT CONST DT_SECLIBRARY=107 /* DT_RATIO */
EXPORT CONST DT_SECBULLETIN=108 /* DT_COMPTYPE*/
EXPORT CONST DT_MESSAGESPOSTED=109
EXPORT CONST DT_UPLOADS=110
EXPORT CONST DT_DOWNLOADS=111
EXPORT CONST DT_TIMESCALLED=112
EXPORT CONST DT_TIMELASTON=113
EXPORT CONST DT_TIMEUSED=114
EXPORT CONST DT_TIMELIMIT=115
EXPORT CONST DT_TIMETOTAL=116
EXPORT CONST DT_BYTESUPLOAD=117
EXPORT CONST DT_BYTEDOWNLOAD=118
EXPORT CONST DT_DAILYBYTELIMIT=119
EXPORT CONST DT_DAILYBYTEDLD=120
EXPORT CONST DT_EXPERT=121
EXPORT CONST DT_LINELENGTH=122
EXPORT CONST ACTIVE_NODES=123
EXPORT CONST DT_DUMP=124
EXPORT CONST DT_TIMEOUT=125
EXPORT CONST BB_CONFNAME=126
EXPORT CONST BB_CONFLOCAL=127
EXPORT CONST BB_LOCAL=128
EXPORT CONST BB_STATUS=129
EXPORT CONST BB_COMMAND=130
EXPORT CONST BB_MAINLINE=131
EXPORT CONST NB_LOAD=132
EXPORT CONST DT_USERLOAD=133
EXPORT CONST BB_CONFIG=134
EXPORT CONST CHG_USER=135
EXPORT CONST RETURNCOMMAND=136
EXPORT CONST ZMODEMSEND=137
EXPORT CONST ZMODEMRECEIVE=138
EXPORT CONST SCREEN_ADDRESS=139
EXPORT CONST BB_TASKPRI=140
EXPORT CONST RAWSCREEN_ADDRESS=141
EXPORT CONST BB_CHATFLAG=142
EXPORT CONST DT_STAMP_LASTON=143
EXPORT CONST DT_STAMP_CTIME=144
EXPORT CONST DT_CURR_TIME=145
EXPORT CONST DT_CONFACCESS=146
EXPORT CONST BB_PCONFLOCAL=147
EXPORT CONST BB_PCONFNAME=148
EXPORT CONST BB_NODEID=149
EXPORT CONST BB_CALLERSLOG=150
EXPORT CONST BB_UDLOG=151
EXPORT CONST EXPRESS_VERSION=152

EXPORT CONST SV_UNICONIFY=153
EXPORT CONST SV_SYSOPLOG=154
EXPORT CONST SV_LOCALLOG=155
EXPORT CONST SV_ACCOUNTS=156
EXPORT CONST SV_CHAT=157
EXPORT CONST SV_NODEOFFHOOK=158
EXPORT CONST SV_EXITNODE=159
EXPORT CONST SV_INITMODEM=160
EXPORT CONST SV_WHATSUP=161
EXPORT CONST BB_CHATSET=162
EXPORT CONST ENVSTAT=163
EXPORT CONST SV_INSTANT=170
EXPORT CONST SV_RESERVE=171
EXPORT CONST SV_CHATTOGGLE=172
EXPORT CONST SV_TOPS=173
EXPORT CONST SV_AESHELL=174
EXPORT CONST SV_START=176
EXPORT CONST SV_NEWMSG=177
EXPORT CONST SV_QUIETNODE=178
EXPORT CONST SV_SETNRAMS=179
EXPORT CONST SV_RESERVENODE=180
EXPORT CONST SV_NODE_LOCK=181
EXPORT CONST SV_ACPALERT=182
EXPORT CONST SV_INCOMING_MSG=183
EXPORT CONST SV_KICKUSER=184
EXPORT CONST SV_STARTNODE=185
EXPORT CONST INCOMING_TELNET=200


EXPORT CONST GETKEY=500
EXPORT CONST RAWARROW=501
EXPORT CONST CHAIN=502

/****************** in progress ******************/
EXPORT CONST NODE_DEVICE=503
EXPORT CONST NODE_UNIT=504
EXPORT CONST NODE_BAUD=505
EXPORT CONST NODE_NUMBER=506
EXPORT CONST JH_MCI=507
/*************************************************/

EXPORT CONST PRV_COMMAND=508
EXPORT CONST PRV_GROUP=509
EXPORT CONST BB_CONFNUM=510
EXPORT CONST BB_DROPDTR=511
EXPORT CONST BB_GETTASK=512
EXPORT CONST BB_REMOVEPORT=513
EXPORT CONST BB_SOPT=514
EXPORT CONST NODE_BAUDRATE=516
EXPORT CONST BB_LOGONTYPE=517
EXPORT CONST BB_SCRLEFT=518
EXPORT CONST BB_SCRTOP=519
EXPORT CONST BB_SCRWIDTH=520
EXPORT CONST BB_SCRHEIGHT=521
EXPORT CONST BB_PURGELINE=522
EXPORT CONST BB_PURGELINESTART=523
EXPORT CONST BB_PURGELINEEND=524
EXPORT CONST BB_NONSTOPTEXT=525
EXPORT CONST BB_LINECOUNT=526
EXPORT CONST DT_LANGUAGE=527
EXPORT CONST DT_QUICKFLAG=528
EXPORT CONST DT_GOODFILE=529
EXPORT CONST DT_ANSICOLOR=530
EXPORT CONST MULTICOM=531
EXPORT CONST LOAD_ACCOUNT=532
EXPORT CONST SAVE_ACCOUNT=533
EXPORT CONST SAVE_CONFDB=534
EXPORT CONST LOAD_CONFDB=535
EXPORT CONST GET_CONFNUM=536
EXPORT CONST SEARCH_ACCOUNT=537
EXPORT CONST APPEND_ACCOUNT=538
EXPORT CONST LAST_ACCOUNTNUM=539
EXPORT CONST MOD_TYPE=540
EXPORT CONST DT_ISANSI=541
EXPORT CONST BATCHZMODEMSEND=542
EXPORT CONST DT_MSGCODE=543
EXPORT CONST ACP_COMMAND=544
EXPORT CONST DT_FILECODE=545
EXPORT CONST EDITOR_STRUCT=546
EXPORT CONST BYPASS_CSI_CHECK=547
EXPORT CONST SENTBY=548
EXPORT CONST SETOVERIDE=549
EXPORT CONST FULLEDIT=550
EXPORT CONST SETMCIOFF=551

EXPORT CONST GET_CUSTOM_MSGBASE_PARAM1=600
EXPORT CONST GET_CUSTOM_MSGBASE_PARAM2=601
EXPORT CONST LAST_READ=602
EXPORT CONST LAST_SCANNED=603
EXPORT CONST MSGBASE_LOC=604
EXPORT CONST GET_CUSTOM_MSGBASE_MENUCMD=605
EXPORT CONST DT_REALNAME=606
EXPORT CONST UNKNOWN4=607
EXPORT CONST QUICK_KEY=608
EXPORT CONST SER_INOUT=609
EXPORT CONST AXNET_RECEIVE=610
EXPORT CONST AXNET_SEND=611
EXPORT CONST MEMCONF=612
EXPORT CONST SET_SERSHARED=613
EXPORT CONST CONF_ACCESS=614
EXPORT CONST PASSWORD_HASH=615
EXPORT CONST GET_GNSFLAG=616
EXPORT CONST DISPLAY_FILE=617
EXPORT CONST CHECK_TO_DISPLAY=618
EXPORT CONST CHOOSE_NAME=619
EXPORT CONST SET_FILEATTACH=620
EXPORT CONST INTERPRET_MCI=621
EXPORT CONST GET_XIMPORT=622
EXPORT CONST GET_MENU_COMMAND_CHAR=623
EXPORT CONST FILE_REQUEST=624
EXPORT CONST DISABLE_FILE_ATTACH=625
EXPORT CONST QWKZOOM_REC=626
EXPORT CONST REL_CONF=627
EXPORT CONST RETURNCOMMAND2=628
EXPORT CONST CANCEL_TRANSFER_OFFHOOK=629
EXPORT CONST CLEAR_OLM_QUEUE=630
EXPORT CONST UNKNOWN12=631
EXPORT CONST CHECK_PLAYPEN_EXISTS=632
EXPORT CONST EXT_LOAD_ACCOUNT=633
EXPORT CONST EXT_SAVE_ACCOUNT=634
EXPORT CONST EXT_CHOOSE_NAME=635
EXPORT CONST CHECK_REALNAME=636
EXPORT CONST DT_INTERNETNAME=637
EXPORT CONST DT_TRANSLATOR=638
EXPORT CONST DT_HOST_LANGUAGE=639
EXPORT CONST XNET_OUTBOUND=640

/*
undocumented host addresses:

600 - get custom msgbase conf command parameter 1
601 - get custom msgbase conf command parameter 2
602 - get/set last msg read to/from msg.string
603 - get set last msg autoscanned to/from msg.string
604 - get/set MsgBase_Location to/from msg.string
605 - get custom msgbase command to msg.string
606 - get/set real name to/from msg.string
607 - get/set something that isnt used anywhere else in the code (not yet implemented)
608 - some kind of input routine ???   (currently implemented as default read char routine)
609 - set IO_Flags[IOFLAG_SER_IN] and IO_Flags[IOFLAG_SER_OUT]
610 - trigger netmail receive
611 - trigger netmail send
612 - get MemConf address (not yet implemented)
613 - set something - something to do with external programs accessing serial ???
614 - check conf access
615 - calculate password hash from msg.string back to msg.string
616 - get gnsflag
617 - display file (fn) without reseting gnsflag
618 - checktodislay(msg.string) without reseting gnsflag
619 - choose a name with no filler3 user misc support
620 - set fileattach flag
621 - interpret mci string (not yet implemented)
622 - get ximport value
623 - get edit message menu command character (not yet implemented)
624 -  asl requester asl(fn)
625 - enable/disable file attach (not yet implemented)
626 - get or set floating point record number used in qwkzoom (not yet implemented)
627 - call RelConf(CN)
628 - not sure - something to do with mainmenu_li and servercmd ??? used by aquascan to download - alternative version of RETURNCOMMAND
631 - get or set unknown thing ??? (skips messages during download)    (not yet implemented)
632 - check if file exists or is in playpens
633 - extended LOAD_ACCOUNT (532) with filler3 / user misc 
635 - choose a name with filler3 / user misc support 
636 - 1 if realname turned on, 2 if username turned on otherwise 0
637 - get or set internet name
638 - get or set translator
639 - get or set host language name (languages.info)
640 - set amixnet outbound path
*/

/* New host commands for /X5 using range 700+ */

EXPORT CONST DT_HOSTNAME=700
EXPORT CONST DT_HOSTIP=701
EXPORT CONST DT_GEOGRAPHIC=702
EXPORT CONST DT_SIZEUPLOAD=703
EXPORT CONST DT_SIZEDOWNLOAD=704
EXPORT CONST CON_CURSOR=705

/* end of new /X 5 host commands */

/* s!x commands */

EXPORT CONST DT_CONFACCESS2=900
EXPORT CONST DT_CBYTESUPLOAD=901
EXPORT CONST DT_CBYTESDOWNLOAD=902
EXPORT CONST DT_CFILESUPLOAD=903
EXPORT CONST DT_CFILESDOWNLOAD=904
EXPORT CONST BB_CONFACCOUNT=905
EXPORT CONST DT_CALLEDTODAY=906
EXPORT CONST SIG_PLAYPEN=908
EXPORT CONST ICONIFYQUERY=909
EXPORT CONST LOGON_UNAME=910
EXPORT CONST LOGON_UPASS=911
EXPORT CONST SIG_LI=912
/* end of s!x comments */

EXPORT CONST DT_ADDBIT=1000
EXPORT CONST DT_REMBIT=1001
EXPORT CONST DT_QUERYBIT=1002

EXPORT CONST MAX_CMD=1003

EXPORT CONST TOGGLES_TRUERESET=0
EXPORT CONST TOGGLES_CONFRELATIVE=1
EXPORT CONST TOGGLES_DOORLOG=2
EXPORT CONST TOGGLES_STARTLOG=3
EXPORT CONST TOGGLES_NOTIMEOUT=4
EXPORT CONST TOGGLES_NOMCIMSGS=5
EXPORT CONST TOGGLES_RED1=6
EXPORT CONST TOGGLES_BREAK_CHAT=7
EXPORT CONST TOGGLES_NAMEBASE=8
EXPORT CONST TOGGLES_QUIETSTART=9
EXPORT CONST TOGGLES_MULTICOM=10
EXPORT CONST TOGGLES_NOPURGE=11
EXPORT CONST TOGGLES_REPURGE=12
EXPORT CONST TOGGLES_REUSEINACTIVE=13
EXPORT CONST TOGGLES_USEWILDCARDS=14
EXPORT CONST TOGGLES_CALLERID=15
EXPORT CONST TOGGLES_CALLERIDNAME=16
EXPORT CONST TOGGLES_SERIALRESET=17
EXPORT CONST TOGGLES_AREABASE=18
EXPORT CONST TOGGLES_CREDITBYKB=19

EXPORT CONST JH_UPDATE=1
EXPORT CONST JH_DOWNLOAD=2
EXPORT CONST JH_UPLOAD=3
EXPORT CONST JH_CHATON=5
EXPORT CONST JH_CHATOFF=4
EXPORT CONST JH_QUIETON=7
EXPORT CONST JH_QUIETOFF=6
EXPORT CONST JH_AUTOCOMMAND=8
EXPORT CONST JH_TRANSFERCPS=9

EXPORT OBJECT commands
  acLvl[100]: ARRAY OF CHAR
  serDevUnit: CHAR
  serDev[40]: ARRAY OF CHAR
  newUserPw[15]: ARRAY OF CHAR -> 141
  openingBaud: LONG            -> 156
  taskPri: CHAR                -> 160
  conf1Name[54]: ARRAY OF CHAR ->161
  conf2Name[54]: ARRAY OF CHAR
  conf3Name[54]: ARRAY OF CHAR
  conf4Name[54]: ARRAY OF CHAR
  conf5Name[54]: ARRAY OF CHAR
  conf6Name[54]: ARRAY OF CHAR
  conf7Name[54]: ARRAY OF CHAR
  conf8Name[54]: ARRAY OF CHAR
  conf9Name[54]: ARRAY OF CHAR
  conf10Name[54]: ARRAY OF CHAR
  conf1Loc[54]: ARRAY OF CHAR
  conf2Loc[54]: ARRAY OF CHAR
  conf3Loc[54]: ARRAY OF CHAR
  conf4Loc[54]: ARRAY OF CHAR
  conf5Loc[54]: ARRAY OF CHAR
  conf6Loc[54]: ARRAY OF CHAR
  conf7Loc[54]: ARRAY OF CHAR
  conf8Loc[54]: ARRAY OF CHAR
  conf9Loc[54]: ARRAY OF CHAR
  conf10Loc[54]: ARRAY OF CHAR
  bbsName[41]: ARRAY OF CHAR  -> 1241
  bbsLoc[41]: ARRAY OF CHAR
  sysopName[41]: ARRAY OF CHAR   
  pSAcLvl[6]: ARRAY OF CHAR -> 1364
  pSRType[6]: ARRAY OF CHAR
  pSRatio[6]: ARRAY OF CHAR
  pSDBytes[6]: ARRAY OF LONG -> 1382
  pSTime[6]: ARRAY OF LONG 
  pSCnfAc1[6]:ARRAY OF CHAR -> 1430
  pSCnfAc2[6]:ARRAY OF CHAR
  pSCnfAc3[6]:ARRAY OF CHAR
  pSCnfAc4[6]:ARRAY OF CHAR
  pSCnfAc5[6]:ARRAY OF CHAR
  pSCnfAc6[6]:ARRAY OF CHAR
  pSCnfAc7[6]:ARRAY OF CHAR
  pSCnfAc8[6]:ARRAY OF CHAR
  pSCnfAc9[6]:ARRAY OF CHAR
  pPSCnfAc10[6]:ARRAY OF CHAR
  mInit[101]: ARRAY OF CHAR -> 1490
  mReset[31]: ARRAY OF CHAR
  mRing[31]: ARRAY OF CHAR
  mAnswer[31]: ARRAY OF CHAR
  mC300[31]: ARRAY OF CHAR
  mC1200[31]: ARRAY OF CHAR
  mC2400[31]: ARRAY OF CHAR
  mC4800[31]: ARRAY OF CHAR
  mC9600[31]: ARRAY OF CHAR
  mC19200[31]: ARRAY OF CHAR
  numConf: INT                -> 1870
  sysPass[31]: ARRAY OF CHAR  -> 1872
  remotePass[31]: ARRAY OF CHAR
  baudTimes[10]: ARRAY OF INT
  pad[22]: ARRAY OF CHAR
ENDOBJECT -> 1976

EXPORT OBJECT packedCommands
  acLvl[100]: ARRAY OF CHAR
  serDevUnit: CHAR
  serDev0:CHAR                              ->101
  serDev1[38]: ARRAY OF CHAR
  serDev39: CHAR
  newUserPw0: CHAR                          -> 141
  newUserPw1[14]: ARRAY OF CHAR
  openingBaud: LONG                        -> 156
  taskPri: CHAR                            -> 160
  confNames0: CHAR                         -> 161
  confNames1[538]: ARRAY OF CHAR
  confNames539: CHAR
  confLocs0: CHAR                           ->701
  confLocs1[538]: ARRAY OF CHAR
  confLocs539: CHAR
  bbsName0: CHAR                            ->1241
  bbsName1[40]: ARRAY OF CHAR
  bbsLoc[40]: ARRAY OF CHAR                 ->1282
  bbsLoc41: CHAR
  sysopName0: CHAR                          ->1323
  sysopName1[40]: ARRAY OF CHAR

  /*conf1Name[54]: ARRAY OF CHAR  ->odd      ->161
  conf2Name[54]: ARRAY OF CHAR
  conf3Name[54]: ARRAY OF CHAR
  conf4Name[54]: ARRAY OF CHAR
  conf5Name[54]: ARRAY OF CHAR
  conf6Name[54]: ARRAY OF CHAR
  conf7Name[54]: ARRAY OF CHAR
  conf8Name[54]: ARRAY OF CHAR
  conf9Name[54]: ARRAY OF CHAR
  conf10Name[54]: ARRAY OF CHAR
  conf1Loc[54]: ARRAY OF CHAR
  conf2Loc[54]: ARRAY OF CHAR
  conf3Loc[54]: ARRAY OF CHAR
  conf4Loc[54]: ARRAY OF CHAR
  conf5Loc[54]: ARRAY OF CHAR
  conf6Loc[54]: ARRAY OF CHAR
  conf7Loc[54]: ARRAY OF CHAR
  conf8Loc[54]: ARRAY OF CHAR
  conf9Loc[54]: ARRAY OF CHAR
  conf10Loc[54]: ARRAY OF CHAR
  bbsName[41]: ARRAY OF CHAR  -> 1241
  bbsLoc[41]: ARRAY OF CHAR
  sysopName[41]: ARRAY OF CHAR   */
  pSAcLvl[6]: ARRAY OF CHAR -> 1364
  pSRType[6]: ARRAY OF CHAR
  pSRatio[6]: ARRAY OF CHAR
  pSDBytes[6]: ARRAY OF LONG -> 1382
  pSTime[6]: ARRAY OF LONG 
  pSCnfAc1[6]:ARRAY OF CHAR -> 1430
  pSCnfAc2[6]:ARRAY OF CHAR
  pSCnfAc3[6]:ARRAY OF CHAR
  pSCnfAc4[6]:ARRAY OF CHAR
  pSCnfAc5[6]:ARRAY OF CHAR
  pSCnfAc6[6]:ARRAY OF CHAR
  pSCnfAc7[6]:ARRAY OF CHAR
  pSCnfAc8[6]:ARRAY OF CHAR
  pSCnfAc9[6]:ARRAY OF CHAR
  pPSCnfAc10[6]:ARRAY OF CHAR
  mInit[100]: ARRAY OF CHAR -> 1490
  mInit100: CHAR
  mReset0: CHAR             ->1591
  mReset1[30]: ARRAY OF CHAR  
  mRing[30]: ARRAY OF CHAR  ->1622
  mRing30:CHAR
  mAnswer0: CHAR            ->1653
  mAnswer1[30]: ARRAY OF CHAR
  mConnects[186]:ARRAY OF CHAR
  numConf: INT                -> 1870
  sysPass[30]: ARRAY OF CHAR  -> 1872
  sysPass30: CHAR
  remotePass0: CHAR
  remotePass1[30]: ARRAY OF CHAR
  baudTimes[10]: ARRAY OF INT
  pad[22]: ARRAY OF CHAR
ENDOBJECT -> 1976

EXPORT OBJECT startOption
  leftEdge : INT          ->done
  topEdge : INT           ->done
  width : INT             ->done
  height : INT            ->done
  bitPlanes : LONG        ->done
  statBar: INT  ->BOOL      ->done
  interlace: INT  ->BOOL      ->done
  dupeCheck: INT  ->BOOL
  qLogon: INT  ->BOOL         ->done
  takeCredits: INT ->BOOL
  seenIt: INT ->BOOL
  trapDoor: INT ->BOOL        ->done
  iconify: INT ->BOOL           ->done
  eall_level: INT ->BOOL
  a2232: INT ->BOOL             ->done
  toggles[20]:ARRAY OF INT      ->done
  logoff[80]:ARRAY OF CHAR
  shutDown[80]:ARRAY OF CHAR    ->done
  cycleLock[80]:ARRAY OF CHAR
  ramPen[80]:ARRAY OF CHAR      ->done
  namePrompt[80]:ARRAY OF CHAR  ->done
  filesNot[80]:ARRAY OF CHAR    ->done
  userData[80]:ARRAY OF CHAR
  userKey[80]:ARRAY OF CHAR
  offHook[80]:ARRAY OF CHAR     ->done
  nodeScreens[80]:ARRAY OF CHAR ->done
  masterSemi: PTR TO LONG       ->done
  singleSemi: PTR TO LONG       ->done
  translation: PTR TO LONG   -> 
  acpWindow: PTR TO window
ENDOBJECT ->exp888

EXPORT OBJECT acpMessage
  msg: mn ->length 20
  user[50]:ARRAY OF CHAR
  location[50]:ARRAY OF CHAR
  action[50]:ARRAY OF CHAR
  baud[10]:ARRAY OF CHAR
  data:LONG
  command:LONG
  node:LONG
  lineNum:LONG
  myCmds:PTR TO packedCommands
  sopt: PTR TO startOption
ENDOBJECT  ->LENGTH 204

EXPORT OBJECT jhMessage
  msg: mn
  string[200]: ARRAY OF CHAR
  data: LONG   -> SAID INT
  command: LONG -> SAID INT
  nodeID: LONG -> SAID INT
  lineNum: LONG -> SAID INT
  signal: LONG
  task: PTR TO process
  semi: LONG
  filler1: LONG
  filler2: LONG
  strptr: PTR TO CHAR
  filler3:LONG
ENDOBJECT

EXPORT OBJECT translator
  trans:mln
  translatorName[80]: ARRAY OF CHAR
  unknown:LONG
  translationText:PTR TO CHAR
  translationIndexes[28]:ARRAY OF LONG
ENDOBJECT

EXPORT OBJECT semiNodestat
  status:CHAR
  info:CHAR
ENDOBJECT
   
EXPORT OBJECT nodeInfo
  handle[31]:ARRAY OF CHAR
  telnetSocket:LONG
  chatColor:LONG
  offHook:LONG
  private:LONG
  stats[MAX_NODES]:ARRAY OF semiNodestat ->- 64
  t: LONG
  s: PTR TO singlePort
  taskSignal:LONG
ENDOBJECT  -> should be 124

EXPORT OBJECT multiPort
  semi:ss  ->length 46
  list: mlh  ->length 12
  myNode[MAX_NODES]:ARRAY OF nodeInfo
  semiName[20]:ARRAY OF CHAR
ENDOBJECT

EXPORT OBJECT singlePort
  semi: ss -> length 46
  list: mlh  -> length 12
  multiCom: LONG
  semiName[20]:ARRAY OF CHAR
  status:LONG -> 82
  handle[30]:ARRAY OF CHAR
  handle31:CHAR
  location0:CHAR
  location[30]:ARRAY OF CHAR
  misc1[100]:ARRAY OF CHAR
  misc2[100]:ARRAY OF CHAR
ENDOBJECT

