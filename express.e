-> Replacement Express Project
->
->
OPT LARGE,REG=5

ENUM ERR_NONE, ERR_NOICON, ERR_NO_DISKFONT,ERR_SCREEN, ERR_WINDOW, ERR_MP, ERR_IO, ERR_DEV, ERR_PORT, ERR_ARG, ERR_BRKR, ERR_CXERR, ERR_LIB, ERR_PORT, ERR_ASL, ERR_KICK, ERR_LIB, ERR_SERVERRP, ERR_NOSERIAL, ERR_SSL

ENUM STATE_AWAIT, STATE_CONNECTING, STATE_SYSOPLOGON, STATE_LOGON, STATE_LOGGEDON, STATE_HANGUP, STATE_LOGGING_OFF, STATE_SHUTDOWN, STATE_CHECK,STATE_SUSPEND

ENUM REQ_STATE_NONE, REQ_STATE_LOGOFF, REQ_STATE_SHUTDOWN, REQ_STATE_SHUTDOWN_OFFHOOK, REQ_STATE_DISPLAY_AWAIT, REQ_STATE_SYSOPLOGON, REQ_STATE_LOGON, REQ_STATE_RESUME

ENUM SUBSTATE_DISPLAY_AWAIT, SUBSTATE_INPUT, SUBSTATE_DISPLAY_BULL, SUBSTATE_DISPLAY_CONF_BULL, SUBSTATE_DISPLAY_MENU, SUBSTATE_READ_COMMAND,  SUBSTATE_PROCESS_COMMAND

ENUM CMDTYPE_BBSCMD,CMDTYPE_SYSCMD

ENUM TOOLTYPE_PRESET, TOOLTYPE_NODE,TOOLTYPE_CONFCONFIG,TOOLTYPE_CONF,TOOLTYPE_BBSCMD,TOOLTYPE_CONFCMD,TOOLTYPE_NODECMD,TOOLTYPE_SYSCMD,TOOLTYPE_DRIVES,TOOLTYPE_NAMESNOTALLOWED,TOOLTYPE_COMPUTERLIST,TOOLTYPE_ACCESS,TOOLTYPE_AREA,TOOLTYPE_PRESET,TOOLTYPE_FCHECK,TOOLTYPE_NODE_WINDOW,TOOLTYPE_NODE_TIMES,TOOLTYPE_WINDOW,TOOLTYPE_CONNECT,TOOLTYPE_XPRTYPES,TOOLTYPE_XFERLIB,TOOLTYPE_SCREENTYPES,TOOLTYPE_NRAMS, TOOLTYPE_BBSCONFIG

ENUM DOORTYPE_XIM, DOORTYPE_AIM, DOORTYPE_SIM

ENUM LOG_NONE=0, LOG_ERROR=1, LOG_WARN=2, LOG_DEBUG=3

ENUM SCREEN_AWAIT, SCREEN_BBSTITLE, SCREEN_LOGON, SCREEN_JOIN, SCREEN_JOINCONF, SCREEN_JOINED, SCREEN_BULL, SCREEN_NODE_BULL, SCREEN_CONF_BULL, SCREEN_MENU, SCREEN_LOGOFF, SCREEN_DOWNLOAD, SCREEN_UPLOAD, SCREEN_NEWUSERPW, SCREEN_NONEWUSERS, SCREEN_NONEWATBAUD, SCREEN_GUESTLOGON, SCREEN_NOCALLERSATBAUD, SCREEN_LOCKOUT0, SCREEN_LOCKOUT1, SCREEN_PRIVATE, SCREEN_ONENODE, SCREEN_LOGON24, SCREEN_NOT_TIME, SCREEN_FILEHELP

ENUM LOGON_TYPE_LOGGED_OFF=0, LOGON_TYPE_SYSOP=1, LOGON_TYPE_LOCAL=2, LOGON_TYPE_REMOTE=3

ENUM RESULT_FAILURE=-1, RESULT_SUCCESS=0, RESULT_NOT_ALLOWED=1, RESULT_ABORT=-2, RESULT_TIMEOUT=-3, RESULT_NO_CARRIER=-4, RESULT_GOODBYE=-5, RESULT_SLEEP_LOGOFF=-6, RESULT_STANDARD_LOGOFF=-7, RESULT_CONNECT=-8, RESULT_NOT_TESTED=2, RESULT_LCFILES=9,RESULT_PRIVATE=10, RESULT_SIGNALLED=11, RESULT_NOT_FOUND=12

ENUM ERR_MEMORY,ERR_MEMORY2,ERR_MSGBASE,ERR_MEMORY3,ERR_FILELIST,ERR_NOFILES,ERR_FILEEXAMINE,ERR_WORKDIROPEN,ERR_LOCK,ERR_FREESPACE,ERR_SYMBOLS,ERR_FIB_MEMORY,ERR_NO_BULLS

ENUM MAIL_READ=1,MAIL_CREATE=2, MAIL_SCAN=3

ENUM CONSOLE_PORT=1, SERIAL_PORT=2

ENUM ZMODEM_NONE, ZMODEM_UPLOAD, ZMODEM_DOWNLOAD

ENUM NAME_TYPE_USERNAME, NAME_TYPE_REALNAME, NAME_TYPE_INTERNETNAME

ENUM UPDATE_RATIO,UPDATE_RATIO_TYPE,UPDATE_MAILSCAN_PTRS,UPDATE_NEW_MAIL_SCAN,UPDATE_NEW_FILE_SCAN,UPDATE_DEFAULT_ZOOM_FLAG,UPDATE_LAST_MESSAGE,UPDATE_MESSAGES_POSTED

ENUM ENV_IDLE=0,ENV_DOWNLOADING=1,ENV_UPLOADING=2,ENV_DOORS=3,ENV_MAIL=4,ENV_STATS=5,ENV_ACCOUNT=6,ENV_ZOOM=7,ENV_FILES=8,ENV_BULLETINS=9,
      ENV_VIEWING=10,ENV_ACCOUNTSEQ=11,ENV_LOGOFF=12,ENV_SYSOP=13,ENV_SHELL=14,ENV_EMACS=15,ENV_JOIN=16,ENV_CHAT=17,ENV_NOTACTIVE=18,
       ENV_REQ_CHAT=19,ENV_CONNECT=20,ENV_LOGGINGON=21,ENV_AWAITCONNECT=22,ENV_SCANNING=23,ENV_SHUTDOWN=24,ENV_MULTICHAT=25,ENV_SUSPEND=26,ENV_RESERVE=27,
       ENV_ONLINEMSG=28

CONST ACTION_REQUEST=5000

CONST FIFOF_READ=$00000100	  /*  intend to read from fifo	  */
CONST FIFOF_WRITE=$00000200	  /*  intend to write to fifo	  */
CONST FIFOF_RESERVED=$FFFF0000	  /*  reserved for internal use   */
CONST FIFOF_NORMAL=$00000400	  /*  request blocking/sig support*/
CONST FIFOF_NBIO=$00000800	  /*  non-blocking IO		  */

CONST FIFOF_KEEPIFD=$00002000	  /*  keep fifo alive if data pending */
CONST FIFOF_EOF=$00004000	  /*  EOF on close		      */
CONST FIFOF_RREQUIRED=$00008000	  /*  reader required to exist	  */

CONST FREQ_RPEND=1
CONST FREQ_WAVAIL=2
CONST FREQ_ABORT=3

CONST TWODIGITYEARSWITCHOVER=70

CONST MAXNODES=32

CONST MAIL_SCAN_MASK=4
CONST FILE_SCAN_MASK=8
CONST ZOOM_SCAN_MASK=2

CONST IOFLAG_FIL_IN=0
CONST IOFLAG_KBD_IN=1
CONST IOFLAG_SER_IN=2
CONST IOFLAG_FIL_OUT=3
CONST IOFLAG_PRT_OUT=4
CONST IOFLAG_SCR_OUT=5
CONST IOFLAG_SER_OUT=6

CONST CMD_NONSTD=9

CONST SDCMD_QUERY = CMD_NONSTD
CONST CIAF_COMCD=32
CONST CIAF_COMDSR=8

CONST ACCESS_READ=-2

CONST LVL_ACCOUNT_EDITING=0
CONST LVL_COMMENT_TO_SYSOP=1
CONST LVL_DOWNLOAD=2
CONST LVL_ENTER_MESSAGE=3
CONST LVL_FILE_LISTINGS=4
CONST LVL_JOIN_CONFERENCE=5
CONST LVL_NEW_FILES_SINCE=6
CONST LVL_PAGE_SYSOP=7
CONST LVL_READ_MSG=8
CONST LVL_DISPLAY_USER_STATS=9
CONST LVL_UPLOAD=10
CONST LVL_VIEW_A_FILE=11
CONST LVL_EDIT_USER_INFO=12
CONST LVL_LVL_REMOTE_SHELL=13
CONST LVL_ZIPPY_TEXT_SEARCH=14
CONST LVL_OVERRIDE_CHAT=15
CONST LVL_EDIT_USER_NAME=16
CONST LVL_EDIT_USER_LOCATION=17
CONST LVL_EDIT_PHONE_NUMBER=18
CONST LVL_EDIT_PASSWORD=19
CONST LVL_SENTBY_FILES=20
CONST LVL_DEFAULT_CHAT_ON=21
CONST LVL_CLEAR_SCREEN_MSG=22
CONST LVL_CAPITOLS_in_FILE=23
CONST LVL_CHAT_COLOR_SYSOP=24
CONST LVL_CHAT_COLOR_USER=25
CONST LVL_VARYING_LINK_RATE=26
CONST LVL_KEEP_UPLOAD_CREDIT=27
CONST LVL_ALLOW_FREE_RESUMING=28
CONST LVL_DO_CALLERSLOG=29
CONST LVL_DO_UD_LOG=30
CONST LVL_OVERRIDE_TIMES=41
CONST LVL_BULLETINS=42
CONST LVL_SYSOP_READ=43
CONST LVL_NODE_NUMBER=44
CONST LVL_SCREEN_TO_FRONT=45
CONST LVL_ZOO=46
CONST LVL_PKAX=47
CONST LVL_LHARC=48
CONST LVL_WARP=49
CONST LVL_LONGWHO=50

CONST ED_ANSI_ALLOWED=1         ->// Flag indicating that ANSI Colors are allowed in message
CONST ED_ABORT_ALLOWED=2        ->// Flag indicating that the Abort command is enabled
CONST ED_LOAD_ALLOWED=4         ->// Flag indicating that the Load command is enabled
CONST ED_BATCH_UPLOAD=8         ->// Flag indicating that the Upload command is enabled
CONST ED_ATTACH_FILE=16         ->// Flag indicating that the File Attach Command is enabled.
CONST ED_BATCH_REQUESTED=32768  ->// Flag indicating batch true
CONST ED_ATTACH_REQUESTED=16384

CONST HISTORY=999
CONST RIGHTARROW=2
CONST LEFTARROW=3
CONST UPARROW=4
CONST DOWNARROW=5

CONST CHAR_BACKSPACE=8
CONST CHAR_DELETE=127
CONST CHAR_TAB=9

CONST BIO_CTRL_FLUSH=11
CONST BIO_FLAGS_BASE64_NO_NL=$100
CONST BIO_CTRL_INFO=3

CONST AMISSLMASTER_MIN_VERSION=4
CONST AMISSL_CURRENT_VERSION=6

->CONST TAG_DONE=0

CONST SSL_VERIFY_PEER=1
CONST SSL_VERIFY_FAIL_IF_NO_PEER_CERT=2

CONST	BIO_NOCLOSE=$0
CONST	BIO_FP_TEXT=$10

CONST OPENSSL_LINE=0

CONST BIO_SET_FILE_PTR=$6a ->dont know what this is

CONST OPENSSL_INIT_LOAD_SSL_STRINGS=$200000
CONST OPENSSL_INIT_LOAD_CRYPTO_STRINGS=2

DEF amiSSL_SocketBase = $80000001
DEF amiSSL_ErrNoPtr = $8000000B

DEF errno
DEF ctx: LONG ->PTR TO SSL_CTX
DEF bio_err: LONG ->PTR TO BIO

ENUM ACS_ACCOUNT_EDITING,ACS_READ_BULLETINS,ACS_COMMENT_TO_SYSOP,ACS_DOWNLOAD,ACS_UPLOAD,ACS_ENTER_MESSAGE,ACS_FILE_LISTINGS,ACS_JOIN_CONFERENCE,ACS_NEW_FILES_SINCE,
     ACS_PAGE_SYSOP,ACS_READ_MESSAGE,ACS_REMOTE_SHELL,ACS_DISPLAY_USER_STATS,ACS_VIEW_A_FILE,ACS_EDIT_USER_INFO,ACS_EDIT_INTERNET_NAME,ACS_EDIT_USER_LOCATION,
     ACS_EDIT_PHONE_NUMBER,ACS_EDIT_PASSWORD,ACS_ZIPPY_TEXT_SEARCH,ACS_OVERRIDE_CHAT,ACS_SYSOP_DOWNLOAD,ACS_SYSOP_VIEW,ACS_SYSOP_READ,ACS_KEEP_UPLOAD_CREDIT,
     ACS_OVERRIDE_TIMES,ACS_CLEAR_SCREEN_MSG,ACS_FREE_RESUMING,ACS_ONE_TIME_BULLETINS,ACS_DO_CALLERSLOG,ACS_SENTBY_FILES,ACS_DO_UD_LOG,ACS_SCREEN_TO_FRONT,
     ACS_DEFAULT_CHAT_ON,ACS_EALL_MESSAGES,ACS_DUPE_FILECHECK,ACS_MESSAGE_EDIT,ACS_LIST_NODES,ACS_MSG_LEVEL,ACS_MSG_EXPERATION,ACS_DELETE_MESSAGE,ACS_ATTACH_FILES,
     ACS_CUSTOMCOMMANDS,ACS_JOIN_SUB_CONFERENCE,ACS_ZOOM_MAIL,ACS_MCI_MSG,ACS_EDIT_DIRS,ACS_EDIT_FILES,ACS_BREAK_CHAT,ACS_QUIET_NODE,ACS_SYSOP_COMMANDS,ACS_WHO_IS_ONLINE,
     ACS_RELOGON,ACS_ULSTATS,ACS_XPR_RECEIVE,ACS_XPR_SEND,ACS_WILDCARDS,ACS_CONFERENCE_ACCOUNTING,ACS_PRI_MSGFILES,ACS_PUB_MSGFILES,ACS_FULL_EDIT,ACS_CONFFLAGS,
     ACS_OLM,ACS_HIDE_FILES,ACS_SHOW_PAYMENTS,ACS_CREDIT_ACCESS,ACS_VOTE,ACS_MODIFY_VOTE,ACS_FILE_EXPANSION,ACS_EDIT_REAL_NAME,ACS_EDIT_USER_NAME,ACS_CENSORED,
     ACS_ACCOUNT_VIEW,ACS_TRANSLATION,ACS_UNKNOWN,ACS_CREATE_CONFERENCE,ACS_LOCAL_DOWNLOADS,ACS_MAX_PAGES,ACS_OVERRIDE_DEFAULTS

-> User Keys Flags
   /* show new user message */       /* show all users only once */
ENUM USER_NEWMSG=1,USER_TOCONF1=2, USER_ONETIME_MSG=4,USER_SCRNCLR=8,USER_DONATED=16,USER_ED_FULLSCREEN=32,USER_ED_PROMPT=64

-> AmiExpress_Node.0 - arexx port for shutdown/suspend messages
-> ServerRP0 - Send Messages to ACP (create at startup, register with ACP, receive bbs title)
-> AEServer.0 - messages from ACP (create at startup) - global door port
-> AEDoorPort0 - communicate with running exe (create while running door) - local door port

CONST TRACK_UPLOADS_BIT=1
CONST TRACK_DOWNLOADS_BIT=2

CONST TOGGLES_TRUERESET=0
CONST TOGGLES_CONFRELATIVE=1
CONST TOGGLES_DOORLOG=2
CONST TOGGLES_STARTLOG=3
CONST TOGGLES_NOTIMEOUT=4
CONST TOGGLES_NOMCIMSGS=5
CONST TOGGLES_RED1=6
->7 unused
->8 unused
CONST TOGGLES_QUIETSTART=9
CONST TOGGLES_MULTICOM=10
CONST TOGGLES_NOPURGE=11
CONST TOGGLES_REPURGE=12
CONST TOGGLES_APPENDNEW=13
CONST TOGGLES_USEWILDCARDS=14
CONST TOGGLES_CALLERID=15
CONST TOGGLES_CALLERIDNAME=16
CONST TOGGLES_SERIALRESET=17
CONST TOGGLES_LONGWHO=20
->18 unused
CONST TOGGLES_CREDITBYKB=19

/*


stuff to do:

'Voting Booth'
'                  [34m*[0m--[33mVOTING TOPICS MENU[0m--[34m*[0m\b\n'
'[0mVOTING IS NOT ESTABLISHED FOR THIS CONFERENCE\b\n\b\n'
'[34m[[0m Q[34m] [33mQUIT[0m\b\n'
'>: '
'Vote/vote%02d.def'
'[34m[[0m%2d[34m] [32mVOTED [35m'
'[34m[[0m%2d[34m]       [35m'
'[0m\b\n'
'                 [34m*[0m--[33mVOTE MAINTENANCE[0m--[34m*[0m\b\n\b\n'
'[34m[[0m 1[34m] [35mSHOW VOTING STATISTICS[0m\b\n'

'[34m[[0m 2[34m] [35mSHOW TOPICS[0m\b\n'
'[34m[[0m 3[34m] [35mCREATE VOTE TOPIC[0m\b\n'
					
'[34m[[0m 4[34m] [35mDELETE VOTE TOPIC[0m\b\n'
'[34m[[0m 5[34m] [35mEDIT   VOTE TOPIC[0m\b\n'
'[34m[[0m 6[34m] [35mVOTE[0m\b\n'

'[34m[[0m 7[34m] [33mEXIT VOTE MAINTENANCE[0m\b\n'
'>'
'%sVote/uservote%d'
'[33mTOPIC [34m[[0m'
'[34m][0m\b\n\b\n'
'%sVote/vote%02d.%02d.qst'
'\b\nQUESTION #%02d\b\n'
'%sVote/vote%02d.%02d.cnt'
'[35mTOTAL VOTES FOR THIS QUESTION [0m= [33m%4.0f\b\n'
'%sVote/vote%02d.%02d.%c.cnt'
'%sVote/vote%02d.%02d.%c'
'[34m[[0m%c[34m][0m %-40.40s [35mVOTES[33m:' [0m%4.0f, %3.0f%%\b\n'
'[34m[[0m%c[34m][0m %-40.40s\b\n'
'    %s\b\n'
'\b\n[0mCHOICE >: '
'%c\b\n'
'vote%02d.%02d.%c.cnt'
'%sVote/%s'
'%f''%sVote/VoteLock'
'[34mENTER TOPIC NUMBER TO DELETE [33m>:[0m '
'[0mTHIS TOPIC DOES NOT EXIST\b\n'
'[33mTOPIC DELETED[0m\b\n'
'[34mENTER TOPIC NUMBER [33m([0m1-25[33m)[34m>:[0m '
'[0mINVALID TOPIC\b\n'
'[0mTOPIC ALREADY EXISTS\b\n'
'[0m   ENTER OPTION\b\n'
'[0m1. EDIT DESCRIPTION\b\n'
'[0m2. EDIT QUESTION\b\n'
'[0m3. EDIT ANSWER\b\n'
'[0m4. EXIT\b\n'
'[0m>'
'%c'
'%sVote'
'[33mENTER TOPIC DESCRIPTION [0m[34mEDIT QUESTION NUMBER[0m > '
'QUESTION DOES NOT EXIST\b\n'
'[33mENTER QUESTION[0m\b\n'
'[34mEDIT CHOICE [33m[[0mA-Z[33m][0m > '
'CHOICE DOES NOT EXIST\b\n'
'[0mANSWER [33m%c [0m] '


any missing Door port commands
    DT_LANGUAGE(set),MOD_TYPE,BYPASS_CSI_CHECK,SETOVERIDE,FULLEDIT (not implemented in /X3 or 4), unknown commands 551,600-640

acp tooltypes
  CREDIT_BY_KBYTES  (TOGGLES_CREDITBYKB)

acs tooltypes
  ACS_OVERRIDE_DEFAULTS
  ACS_CENSORED

node tooltypes
  FREE_RESUMING  - see /X4 docs (LVL_ALLOW_FREE_RESUMING & ACS_ALLOW_FREE_RESUMING)
  STICKY - unknown
  RIPSCRIPT  - unknown (cant see any code that uses this value)
  NODBLBUFFER  - don't allow double buffer size during serial xfer
  HDTRANSBUFFER - see /X4 docs

conf tooltypes
  CUSTOM - see /X4 docs

door tooltypes
 MULTINODE= <YES|NO>  - not used anymore
 PASS_PARAMETERS=<res>-
 TRAPON
 TYPE= <TIM | IIM | MCI >

full Acp integration
RIP
translations
F3 instant logon
ACS_EDIT_FILES
partdownloads - user@ files
TOGGLES_NOMCIMSGS=5   ACS_MCI_MSG
private command
(ami-x) net confs - msgbase.info
user.misc - unknown fields

missing commands:
   VO - conf voting
   ZOOM - zoom mail

NOT needed

multinode / door lock - not used in /X4 anymore

notes:

await screen keys

F1 - sysop logon - done
F2 - local logon - done
F3 - instant remote logon
F4 - reserve node - done
F5 - conference maintenance
F6 - account editing - done
F7 - chat toggle - done
F8 - reprogram modem - done
F9 - exit bbs - done
F10 - exit bbs offhook - done

in call keys

F1- chat   - done
F2 - add time - done
F3 - less time - done
F4 - open capture, F4 to close again - done
Shift F4 - display file to user - done
f5 - shell - removed
F6 - account edit - done
Shift F6 - temporary account edit - done
F7 - chat toggle   - done
f8 - toggle ser in - done
f9 - toggle ser out - done
F10 - kick   - done
*/

CONST MAX_SAYINGS=50
CONST INPUT_TIMEOUT=300

CONST CONU_CHARMAP=1
CONST CONFLAG_DEFAULT=0

CONST JH_LI=0
CONST JH_REGISTER=1
CONST JH_SHUTDOWN=2
CONST JH_WRITE=3
CONST JH_SM=4   
CONST JH_PM=5
CONST JH_HK=6
CONST JH_SG=7
CONST JH_SF=8
CONST JH_EF=9
CONST JH_CO=10
CONST JH_BBSNAME=11
CONST JH_SYSOP=12
CONST JH_FLAGFILE=13
CONST JH_SHOWFLAGS=14
CONST JH_DL=15
CONST JH_ExtHK=15
CONST JH_SIGBIT=16
CONST JH_FetchKey=17
CONST JH_SO=18
CONST JH_SMPTR=19
CONST JH_20=20

CONST DT_NAME=100
CONST DT_PASSWORD=101
CONST DT_LOCATION=102
CONST DT_PHONENUMBER=103
CONST DT_SLOTNUMBER=104
CONST DT_SECSTATUS=105 /* DT_ACCESSLEVEL */
CONST DT_SECBOARD=106 /* DT_RATIOTYPE */
CONST DT_SECLIBRARY=107 /* DT_RATIO */
CONST DT_SECBULLETIN=108 /* DT_COMPTYPE*/
CONST DT_MESSAGESPOSTED=109
CONST DT_UPLOADS=110
CONST DT_DOWNLOADS=111
CONST DT_TIMESCALLED=112
CONST DT_TIMELASTON=113
CONST DT_TIMEUSED=114
CONST DT_TIMELIMIT=115
CONST DT_TIMETOTAL=116
CONST DT_BYTESUPLOAD=117
CONST DT_BYTEDOWNLOAD=118
CONST DT_DAILYBYTELIMIT=119
CONST DT_DAILYBYTEDLD=120
CONST DT_EXPERT=121
CONST DT_LINELENGTH=122
CONST ACTIVE_NODES=123
CONST DT_DUMP=124
CONST DT_TIMEOUT=125
CONST BB_CONFNAME=126
CONST BB_CONFLOCAL=127
CONST BB_LOCAL=128
CONST BB_STATUS=129
CONST BB_COMMAND=130
CONST BB_MAINLINE=131
CONST NB_LOAD=132
CONST DT_USERLOAD=133
CONST BB_CONFIG=134
CONST CHG_USER=135
CONST RETURNCOMMAND=136
CONST ZMODEMSEND=137
CONST ZMODEMRECEIVE=138
CONST SCREEN_ADDRESS=139
CONST BB_TASKPRI=140
CONST RAWSCREEN_ADDRESS=141
CONST BB_CHATFLAG=142
CONST DT_STAMP_LASTON=143
CONST DT_STAMP_CTIME=144
CONST DT_CURR_TIME=145
CONST DT_CONFACCESS=146
CONST BB_PCONFLOCAL=147
CONST BB_PCONFNAME=148
CONST BB_NODEID=149
CONST BB_CALLERSLOG=150
CONST BB_UDLOG=151
CONST EXPRESS_VERSION=152
CONST SV_UNICONIFY=153

CONST SV_SYSOPLOG=154
CONST SV_LOCALLOG=155
CONST SV_ACCOUNTS=156
CONST SV_CHAT=157
CONST SV_NODEOFFHOOK=158
CONST SV_EXITNODE=159
CONST SV_INITMODEM=160
CONST SV_WHATSUP=161
CONST SV_INSTANT=170
CONST SV_RESERVE=171
CONST SV_CHATTOGGLE=172
CONST SV_TOPS=173
CONST SV_AESHELL=174
CONST SV_START=176
CONST SV_NEWMSG=177
CONST SV_QUIETNODE=178
CONST SV_SETNRAMS=179
CONST SV_RESERVENAME=180
CONST SV_INCOMING_MSG=183

CONST BB_CHATSET=162
CONST ENVSTAT=163

CONST GETKEY=500
CONST RAWARROW=501
CONST CHAIN=502

/****************** in progress ******************/
CONST NODE_DEVICE=503
CONST NODE_UNIT=504
CONST NODE_BAUD=505
CONST NODE_NUMBER=506
CONST JH_MCI=507
/*************************************************/

CONST PRV_COMMAND=508
CONST PRV_GROUP=509
CONST BB_CONFNUM=510
CONST BB_DROPDTR=511
CONST BB_GETTASK=512
CONST BB_REMOVEPORT=513
CONST BB_SOPT=514
CONST NODE_BAUDRATE=516
CONST BB_LOGONTYPE=517
CONST BB_SCRLEFT=518
CONST BB_SCRTOP=519
CONST BB_SCRWIDTH=520
CONST BB_SCRHEIGHT=521
CONST BB_PURGELINE=522
CONST BB_PURGELINESTART=523
CONST BB_PURGELINEEND=524
CONST BB_NONSTOPTEXT=525
CONST BB_LINECOUNT=526
CONST DT_LANGUAGE=527
CONST DT_QUICKFLAG=528
CONST DT_GOODFILE=529
CONST DT_ANSICOLOR=530
CONST MULTICOM=531
CONST LOAD_ACCOUNT=532
CONST SAVE_ACCOUNT=533
CONST SAVE_CONFDB=534
CONST LOAD_CONFDB=535
CONST GET_CONFNUM=536
CONST SEARCH_ACCOUNT=537
CONST APPEND_ACCOUNT=538
CONST LAST_ACCOUNTNUM=539
CONST MOD_TYPE=540
CONST DT_ISANSI=541
CONST BATCHZMODEMSEND=542
CONST DT_MSGCODE=543
CONST ACP_COMMAND=544
CONST DT_FILECODE=545
CONST EDITOR_STRUCT=546
CONST BYPASS_CSI_CHECK=547
CONST SENTBY=548
CONST SETOVERIDE=549
CONST FULLEDIT=550
CONST SETMCIOFF=551

/*
undocumented host addresses:

600 - get something unknown amixnet related ???
601 - get something unknown amixnet related ???
602 - get/set last msg read to/from msg.string
603 - get set last msg autoscanned to/from msg.string
604 - get/set MsgBase_Location to/from msg.string
605 - get unknown to msg.string ???
606 - get/set real name to/from msg.string
607 - get/set something that isnt used anywhere else in the code
608 - some kind of input routine ???
609 - set IO_Flags[IOFLAG_SER_IN] and IO_Flags[IOFLAG_SER_OUT]
610 - something to do with netmail receive ???
611 - something to do with netmail send ???
612 - get MemConf address
613 - set something - something to do with external programs accessing serial ???
614 - check conf access
615 - calculate password hash from msg.string back to msg.string
616 - get gnsflag
617 - display file (fn)
618 - checktodislay(msg.string)
619 - choose a name with no filler3 user misc support
620 - set fileattach flag
621 - interpret mci string
622 - get ximport value
623 - unknonwn - related to 625  ???
624 -  asl requester asl(fn)
625 - unknown related to 623 ???
626 - get or set something related to messages.dat ???
627 - call RelConf(CN)
628 - not sure - something to do with mainmenu_li and servercmd ??? used by aquascan to download - alternative version of RETURNCOMMAND
631 - get or set unknown thing ???
632 - check if file exists or is in playpens
633 - extended LOAD_ACCOUNT (532) with filler3 / user misc 
635 - choose a name with filler3 / user misc support 
636 - 1 if realname turned on, 2 if username turned on otherwise 0
637 - get or set real name
638 - get or set translator
639 - get or set host language name (languages.info)
640 - set amixnet outbound path
*/
CONST CONF_ACCESS=614
CONST PASSWORD_HASH=615
CONST RETURNCOMMAND2=628

/* New host commands for /X5 using range 700+ */

CONST DT_HOSTNAME=700
CONST DT_HOSTIP=701

/* end of new /X 5 host commands */

CONST DT_ADDBIT=1000
CONST DT_REMBIT=1001
CONST DT_QUERYBIT=1002

MODULE 'intuition/screens',
       'intuition/intuition',
       'intuition/gadgetclass',
       'exec/ports',
       'exec/nodes',
       'exec/memory',
       'exec/semaphores',
       'devices/console',
       'devices/serial',
       'graphics/view',
       'dos/dos',
       'dos/var',
       'dos/dosextens',
       'dos/datetime',
       'dos/dostags',
       'dos/dosextens',
       'graphics/text',
       'libraries/diskfont',
       'diskfont',
       'devices/timer',
       'exec/io',
       'exec/tasks',
       'amigalib/io',
       'amigalib/ports',
       'icon',
       'workbench/workbench',
       'commodities',
       'exec/libraries',
       'exec/lists',
       'libraries/commodities',
       'asl',
       'workbench/startup',
       'rexx/storage',
       'rexxsyslib',
       'libraries/asl',
       'devices/serial',
       'xproto',
       'xpr_lib',
       'socket',
       'net/socket',
       'net/netdb',
       'net/in',
       'amissl',
       'amisslmaster',
       'fifo'

OBJECT semiNodestat
  status:CHAR
  info:CHAR
ENDOBJECT
   
OBJECT nodeInfo
  handle[31]:ARRAY OF CHAR
  startTime:LONG
  chatColor:LONG
  channel:LONG
  private:LONG
  stats[32]:ARRAY OF semiNodestat ->- 64
  t: LONG
  s: PTR TO singlePort
  taskSignal:LONG
ENDOBJECT  -> should be 124

        
OBJECT multiPort
  semi:ss  ->length 46
  sl_List: mlh  ->length 12
  myNode[32]:ARRAY OF nodeInfo
  semiName[20]:ARRAY OF CHAR
ENDOBJECT

OBJECT singlePort
  semi: ss -> length 46
  sl_List: mlh  -> length 12
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

OBJECT master
  msg: mn ->length 20
  user[50]:ARRAY OF CHAR
  location[50]:ARRAY OF CHAR
  action[50]:ARRAY OF CHAR
  baud[10]:ARRAY OF CHAR
  data:LONG
  command:LONG
  node:LONG
  lineNum:LONG
  myCmds:PTR TO commands
  sopt: PTR TO startOption
ENDOBJECT  ->LENGTH 204

OBJECT commands
  acLvl[100]: ARRAY OF CHAR
  serDevUnit: CHAR
  serDev[40]: ARRAY OF CHAR
  newUserPw[15]: ARRAY OF CHAR -> 141
  openingBaud: LONG            -> 156
  taskPri: CHAR -> 163          -> 160
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

OBJECT user
  name[30]:ARRAY OF CHAR
  name31: CHAR  -> last character of name (odd sized arrays are always padded so need this kludge)
  pass0: CHAR   -> first character of pass (odd sized arrays are always padded so need this kludge)
  pass[8]:ARRAY OF CHAR
  location[30]:ARRAY OF CHAR
  phoneNumber[13]:ARRAY OF CHAR
  slotNumber: INT
  secStatus: INT
  secBoard: INT                   /* File or Byte Ratio */
  secLibrary: INT                 /* Ratio              */
  secBulletin: INT                /* Computer Type      */
  messagesPosted: INT
 /* Note ConfYM = the last msg you actually read, ConfRead is the same ?? */
  newSinceDate: LONG
  pwdHash: LONG
  confRead2: LONG
  confRead3: LONG
  zoomType: INT
  unknown: INT
  unknown2: INT
  unknown3: INT
  xferProtocol: INT
  filler2: INT
  lcFiles: INT
  badFiles: INT
  accountDate: LONG
  screenType: INT
  editorType: INT
  conferenceAccess[10]: ARRAY OF CHAR
  uploads: INT
  downloads: INT
  confRJoin: INT
  timesCalled: INT
  timeLastOn: LONG
  timeUsed: LONG
  timeLimit: LONG
  timeTotal: LONG
  bytesDownload: LONG
  bytesUpload: LONG
  dailyBytesLimit: LONG
  dailyBytesDld: LONG
  expert: CHAR
  chatRemain: LONG
  chatLimit: LONG
  creditDays: LONG -> used to store days credited credit account
  creditAmount: LONG -> used to store amount paid credit account
  creditStartDate: LONG -> start date credit account
  creditTotalToDate: LONG ->  used to store amount paid to date credit account
  creditTotalDate: LONG -> credit total to date date
  creditTracking: CHAR ->  track uploads/downloads flags in credit account
  unused1: CHAR
  unused2: INT
  confYM9: LONG
  beginLogCall : LONG
  protocol: CHAR
  uucpa: CHAR
  lineLength: CHAR
  newUser: CHAR
ENDOBJECT

OBJECT userKeys
 userName[31]: ARRAY OF CHAR
 number: LONG
 newUser: CHAR
 upCPS: INT               /* highest upload cps rate */
 dnCPS: INT               /* highest dnload cps rate */
 userFlags: INT           /*                         */
 baud: INT                /* last online baud rate   */
 pad[9]: ARRAY OF CHAR    /* ?? should be 15         */
ENDOBJECT

OBJECT userMisc
  internetName[10]:ARRAY OF CHAR
  realName[26]:ARRAY OF CHAR
  unknown[46]:ARRAY OF CHAR
  unknown2:INT
  unknown3[164]:ARRAY OF CHAR
ENDOBJECT

OBJECT tempAccess
	accessLevel: INT
  ratioType: INT 
  ratio: INT
  timeTotal: LONG
  confAc[10]: ARRAY OF CHAR
ENDOBJECT

OBJECT zModem 
  fileName[40]:ARRAY OF CHAR
  titleBar[60]:ARRAY OF CHAR
  zStat[60]:ARRAY OF CHAR
  filesize:LONG
  cps:LONG
  eff:LONG
  recPos:LONG
  errorCount: LONG
  errorPos:LONG
  resumePos:LONG
  elapsedTime[40]:ARRAY OF CHAR
  apxTime[40]:ARRAY OF CHAR
  lastTime[40]:ARRAY OF CHAR
  pad[2]:ARRAY OF CHAR
  lastUpdate: LONG
  inProgress: LONG
  downloading: CHAR
ENDOBJECT

OBJECT confBase
  handle[31]: ARRAY OF CHAR
  newSinceDate: LONG
  confRead: LONG
  confYM: LONG
  bytesDownload: LONG
  bytesUpload: LONG
  lastEMail: LONG
  dailyBytesDld: LONG
  upload: INT
  downloads: INT
  ratioType: INT
  ratio: INT
  messagesPosted: INT
  access: INT
  active:INT
ENDOBJECT

OBJECT jhMessage
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

OBJECT screenDisplayState
  filename
  position
  parentDisplayState: PTR TO screenDisplayState
ENDOBJECT

OBJECT awaitState
  subState
ENDOBJECT

OBJECT loggedOnState
  subState   
ENDOBJECT

OBJECT ansi
  ansicode: INT
  buf[80]: ARRAY OF CHAR
ENDOBJECT

OBJECT mailHeader
  status: CHAR
  msgNumb: LONG
  toName[31]: ARRAY OF CHAR
  fromName[31]: ARRAY OF CHAR
  subject[31]: ARRAY OF CHAR
  msgDate: LONG
  recv: LONG
  pad: CHAR
ENDOBJECT

OBJECT mailStat
 lowestKey : LONG
 highMsgNum : LONG
 lowestNotDel : LONG
 pad[6]:ARRAY OF CHAR
ENDOBJECT

OBJECT myst
 zoom_mailcnt:LONG
 zoom_mailfile: PTR TO CHAR
 zoom_path: PTR TO CHAR
 maxdbytes: LONG
 sessiondbytes: LONG
 newuser:INT
 times_on: LONG
 ansiColor:INT
 startchatfile: PTR TO CHAR
 stopchatfile: PTR TO CHAR
 quotefile: PTR TO CHAR
 startchatnum: INT
 stopchatnum: INT
 quotenum: INT
 numlastcallers:INT
 lastcallerlevel:INT
 callerlist: PTR TO txt
 newuserfile: PTR TO CHAR
 max_desclines: INT
 uPcps: INT
 dNcps: INT
 uPcps_name: PTR TO CHAR
 uPcps_place: PTR TO CHAR
 dNcps_name: PTR TO CHAR
 dNcps_place: PTR TO CHAR
 flags: LONG
 cosysop_level: CHAR
 countryname: PTR TO CHAR
 notallowedfiles: PTR TO CHAR
 skiplcaller: PTR TO CHAR
 menu_say: PTR TO rndsay
 nozoom[9]: ARRAY OF CHAR
 zoommax: INT
ENDOBJECT

OBJECT txt
  next:PTR TO txt
  txt: PTR TO CHAR
ENDOBJECT

OBJECT rndsay
  saying[MAX_SAYINGS]: ARRAY OF LONG
  rnum:CHAR                            /* num of random sayings */
  type:CHAR
ENDOBJECT

OBJECT startOption
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
  unknown[80]:ARRAY OF CHAR
  shutDown[80]:ARRAY OF CHAR    ->done
  unknown2[80]:ARRAY OF CHAR
  ramPen[80]:ARRAY OF CHAR      ->done
  namePrompt[80]:ARRAY OF CHAR  ->done
  filesNot[80]:ARRAY OF CHAR    ->done
  unknown3[80]:ARRAY OF CHAR
  unknown4[80]:ARRAY OF CHAR
  offHook[80]:ARRAY OF CHAR     ->done
  nodeScreens[80]:ARRAY OF CHAR ->done
  t: PTR TO LONG                ->done
  s: PTR TO LONG                ->done
  unknown5: PTR TO LONG
ENDOBJECT ->exp884

OBJECT mailConfig
  smtpHost[255]:ARRAY OF CHAR
  smtpPort:LONG
  username[255]:ARRAY OF CHAR
  password[255]:ARRAY OF CHAR
  sysopEmail[255]:ARRAY OF CHAR
  bbsEmail[255]:ARRAY OF CHAR
  ssl: INT
  mailOnNewUser: INT
  mailOnSysopComment: INT
  mailOnSysopPage: INT
ENDOBJECT

->0 word - left
->2 word - top
->4 word - width
->6 word - height
->8 long - bitplanes ? and interlace?
->12 word -statbar
->14 Interlace
->16DupeCheck
->18QLogon
->20TakeCredits
->22SeenIt
->24 word trapdoor
->26 ?
->28
->30 word
->32 word ??? probably toggles[0]
->34 word
->36 word toggles[2]
->38 word toggles[3] startuplog START_LOG
->40 word toggles[4]
->42 word
->44 word toggles[6] 
->46 word
->48 word
->50 word toggles[9]
->52 word Toggles[10]
->54 word toggles[11]
->56 word toggles[12]
->58 word toggles[13]
->60 word toggles[14]
->62 word toggles[15]
->64 word toggles[16]
->66 word toggles[17]
->68 word toggles[18]
->70 word toggles[19] credit by kb
->72 [80] array of char
->152 shutdown [80] array of char
->232 [80] array of char
->312 byte  - rampen[80] array of char
->392 name prompt [80]
->472 files not allowed [80] array of char
->552  [80] array of char
->632 [80] array of char
->712  offHook[80]:ARRAY OF CHAR     -> should be 712
->792 nodeScreen[80]:ARRAY OF CHAR -> should be 792
->872  t: PTR TO LONG  -> should be 872
->876  s: PTR TO LONG  -> should be 876
->880  unknown4: PTR TO LONG -> should be 880
->884

OBJECT editor
  maxFileLength:INT
  maxScrLength:CHAR
  editorTop:CHAR
  editorMaxWidth:CHAR
  editorFlags:LONG       -> // Flags for the editor, duh!
  editorFile: PTR TO CHAR
  editorIncludeFile:PTR TO CHAR
  editorPrependFile: PTR TO CHAR
  editorPostPendFile: PTR TO CHAR
ENDOBJECT

DEF masterMsg:master
DEF resmp: PTR TO mp
DEF rexxmp: PTR TO mp
DEF serverRP=0:PTR TO mp
DEF currentStat=0
DEF rexxPortName[20]:STRING
DEF resPortName[10]:STRING
DEF servercmd=-1

DEF singleNode=0: PTR TO singlePort
DEF masterNode=0: PTR TO multiPort
DEF debug=FALSE
DEF consoleDebugLevel=LOG_NONE
DEF debugLogLevel=LOG_NONE

DEF state, stateData, reqState
DEF windowClose=NIL:PTR TO window
DEF windowStat=NIL:PTR TO window
DEF windowZmodem:PTR TO window
DEF consoleReadMP=NIL: PTR TO mp
DEF titlebar[255]:STRING
DEF ititlebar[255]:STRING
DEF consoleIO=NIL: PTR TO iostd
DEF statWriteMP=NIL: PTR TO mp
DEF statWriteIO=NIL: PTR TO iostd
DEF zModemStatWriteMP=NIL: PTR TO mp
DEF zModemStatWriteIO=NIL: PTR TO iostd
DEF serialReadIO=NIL: PTR TO ioextser
DEF serialReadMP=NIL: PTR TO mp
DEF serialWriteMP=NIL: PTR TO mp
DEF serialWriteIO=NIL: PTR TO ioextser
DEF timerport=NIL: PTR TO mp
DEF timermsg=NIL: PTR TO timerequest
DEF readQueued=FALSE
DEF timerQueued=FALSE
DEF ibuf, serbuff, inControl
DEF commandText[255]:STRING
DEF loggedOnUser: PTR TO user
DEF loggedOnUserKeys: PTR TO userKeys
DEF loggedOnUserMisc: PTR TO userMisc
DEF tempAccess: tempAccess
DEF tempAccessGranted=FALSE
DEF my_struct:myst
DEF sopt: startOption
DEF mailOptions: mailConfig
DEF node
DEF ringCount
DEF nodeScreenDir[255]:STRING
DEF confScreenDir[255]:STRING
DEF nodeWorkDir[255]:STRING
DEF reservedName[255]:STRING

DEF currentConf=0
DEF relConfNum=0
DEF callerNum=0
DEF currentConfName[255]:STRING
DEF currentConfDir[255]:STRING
DEF msgBaseLocation[255]:STRING
DEF uploadLocation[255]:STRING
DEF userDataFile[255]:STRING
DEF userKeysFile[255]:STRING
DEF userMiscFile[255]:STRING
DEF maxDirs
DEF ansi: ansi
DEF quickFlag=FALSE
DEF ansiColour=TRUE
DEF lineCount=0
DEF nonStopDisplayFlag=FALSE
DEF logonType=LOGON_TYPE_LOGGED_OFF
DEF timeoutOverride=-1
DEF sysopAvail=TRUE
DEF pagedFlag=FALSE
DEF doorTimeout=INPUT_TIMEOUT
DEF doorExtSig=NIL
DEF expressVer[15]:STRING
DEF expressDate[15]:STRING
DEF regKey[100]:STRING
DEF mailStat=NIL: PTR TO mailStat
DEF mailHeader=NIL: PTR TO mailHeader
DEF cmds: commands
DEF mybbsLoc[255]:STRING
DEF parsedParams: PTR TO LONG
DEF confBases: PTR TO LONG
DEF newSinceFlag
DEF computerEntries
DEF computerTypes: PTR TO LONG
DEF onlineEdit=0
DEF quietFlag=FALSE
DEF chatFlag=FALSE
DEF allowOLM=TRUE
DEF chatF=0
DEF pagesAllowed=-1
DEF ownPartFiles=FALSE
DEF localUpload=FALSE
DEF bytesADL=0
DEF tTEFF=0
DEF tTCPS=0
DEF tTTM=0
DEF tMPBT=0
DEF tBT=0
DEF dTBT=0
DEF beenUDd=0
DEF numSkipd=0
DEF lcFileXfr=0
DEF recFileNames[1024]:STRING
DEF skipdFiles=0
DEF checksym=0
DEF purgeScanNM[31]:STRING
DEF validUser=0
DEF freeDownloads=FALSE
DEF acsLevel=-1
DEF connectString[20]:STRING
DEF ioFlags[7]:ARRAY OF CHAR
DEF trapConnect[100]:STRING
DEF confDBName[255]:STRING
DEF captureFP = NIL
DEF nofkeys=0
DEF relogon=FALSE
DEF lostCarrier=FALSE
DEF timeoutLC=FALSE

DEF doormsgcode=0
DEF nonStopMail=FALSE
DEF noDirF
DEF tempFlag  
DEF replyFlag, numOfZMsgs
DEF fwdFlag
DEF fwdDir
DEF msgNum
DEF fwdToMsg
->DEF stat
DEF currentSeekPos
DEF netflag
DEF fileattach=TRUE, newmailsearch = FALSE
DEF attachedFile[255]:STRING
DEF privateFlag=0
DEF alreadyRecvd
DEF delMsgNum
DEF lastMsgReadConf=0
DEF lastNewReadConf=0
DEF msgBuf: PTR TO LONG
DEF confNames: PTR TO LONG
DEF confDirs: PTR TO LONG
DEF historyFolder[255]:STRING
DEF historyBuf : PTR TO LONG
DEF historyNum
DEF historyCycle
DEF comment=0
DEF menuPrompt[255]:STRING

DEF editor: editor
DEF editorFileName[80]:STRING
DEF editorFileInclude[80]:STRING

DEF xprLib: PTR TO LONG
DEF xprTitle: PTR TO LONG
DEF screenTypeTitle: PTR TO LONG
DEF screenTypeExt: PTR TO LONG
DEF scomment:PTR TO LONG

DEF lines=0
DEF rzmsg=0
DEF tempUser: PTR TO user
DEF tempUserKeys: PTR TO userKeys
DEF tempUserMisc: PTR TO userMisc
DEF flaglist[2048]:STRING
DEF rFinal[3072]:STRING
DEF onlineBaud,onlineBaudR
DEF idRate[15]:STRING
DEF idDate[15]:STRING
DEF idTime[15]:STRING
DEF idNmbr[41]:STRING
DEF idName[41]:STRING
DEF hostName[200]:STRING
DEF hostIP[20]:STRING
DEF onlineNFiles=0
DEF donf=0
DEF timeLimit
DEF logonTime
DEF lastTimeUpdate
DEF bitPlanes=3
DEF ximPort=0

DEF mciterminator[1]:STRING


DEF transfering=FALSE
DEF aeGoodFile=0
->download stuff
DEF sysopdl,numFiles,freeDFlag,fsize,tfsize,dtfsize
DEF zModemInfo: zModem
DEF chatSerFlag=0,chatConFlag=0

DEF zresume=0

DEF scropen=FALSE
DEF screen=NIL:PTR TO screen
DEF window=NIL:PTR TO window
DEF defaultfontattr: textattr
DEF fontName[255]:STRING
DEF fontHandle
DEF dStatBar=NIL
DEF consoleMP=NIL: PTR TO mp
DEF consoleReadIO=NIL: PTR TO iostd
DEF rawArrow=FALSE
DEF broker=NIL, broker_mp=NIL:PTR TO mp, cxsigflag

DEF securityNames
DEF securityFlags[255]:STRING
DEF shutDownMsg[255]:STRING
DEF shutDownFlag=0

DEF olmBuf: PTR TO LONG
DEF olmQueue: PTR TO LONG

DEF sdReplyRexx=NIL: PTR TO rexxmsg

RAISE ERR_BRKR IF CxBroker()=NIL,
      ERR_PORT IF CreateMsgPort()=NIL,
      ERR_ASL  IF AllocAslRequest()=NIL,
      ERR_KICK IF KickVersion()=FALSE

PROC checkIconifyMsg()
ENDPROC

PROC convertAccess()
ENDPROC

PROC stcsma(s: PTR TO CHAR,p: PTR TO CHAR)
  DEF ret,len
  DEF buf

  len:=StrLen(p)*2+2
  buf:=New(len)

  IF(buf=NIL)
    ret:=0
  ELSE
    IF (ParsePatternNoCase(p, buf, len) < 0)
      ret:=0
    ELSE
      ret:=MatchPatternNoCase(buf, s)
     ENDIF
  ENDIF
  END buf
ENDPROC ret

PROC sendMail(subject:PTR TO CHAR,bodytext:PTR TO CHAR, appendMsgBuf, toemail:PTR TO CHAR)
  DEF ssl,sock=0,errcode=0
	DEF buffer[4096]:STRING; /* This should be dynamically allocated */
  DEF bufsize=4096
	DEF request[512]:STRING
  DEF failed=FALSE,v,i

  /* The following needs to be done once per socket */

		/* Connect to the HTTPS server, directly or through a proxy */
      sock:=connectToServer(mailOptions.smtpHost,mailOptions.smtpPort)

			/* Check if connection was established */
			IF (sock >= 0)
        IF ctx
          IF((ssl:=SsL_new(ctx)) <> NIL)
        
            /* Associate the socket with the ssl structure */
            SsL_set_fd(ssl, sock)

            /* Perform SSL handshake */
            IF((errcode:=SsL_connect(ssl)) >= 0)

              IF ((errcode:=SsL_read(ssl, buffer,bufsize - 1)) >0)
                buffer[errcode]:=0
                WriteF('\s \d \d',buffer, errcode, 1);
              ELSE
                WriteF('Couldn''t read initial server message!\n');
              ENDIF

              StrCopy(request,'EHLO relay.example.com\n')
              IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                WriteF('error sending EHLO');
              ENDIF

              IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
                buffer[errcode]:=0
                v:=Val(buffer)
                failed:=((v<200) OR (v>299))
                WriteF('\s \d \d',buffer, errcode, 1);
              ENDIF

              IF (failed=FALSE)
                StringF(request,'\n\s\n\s',mailOptions.username,mailOptions.password)
                v:=StrLen(request)-1
                FOR i:=0 TO v
                  IF request[i]="\n" THEN request[i]:=0
                ENDFOR
                base64enc(request,EstrLen(request),buffer)
                StringF(request,'AUTH PLAIN \s\n',buffer)
                IF ((errcode:=SsL_write(ssl, request, EstrLen(request))) <=0 )
                  WriteF('error sending AUTH');
                ENDIF

                IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
                  buffer[errcode]:=0
                  v:=Val(buffer)
                  failed:=((v<200) OR (v>299))
                  WriteF('\s \d \d',buffer, errcode, 1);
                ENDIF
              ENDIF

              IF (failed=FALSE)
                StringF(request,'mail from:<\s>\n',mailOptions.bbsEmail)
                IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                  WriteF('error sending FROM');
                ENDIF

                IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
                  buffer[errcode]:=0
                  v:=Val(buffer)
                  failed:=((v<200) OR (v>299))
                  WriteF('\s \d \d',buffer, errcode, 1);
                ENDIF
              ENDIF

              IF (failed=FALSE)
                StringF(request,'rcpt to:<\s>\n',toemail)
                IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                  WriteF('error sending TO');
                ENDIF

                IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
                  buffer[errcode]:=0
                  v:=Val(buffer)
                  failed:=((v<200) OR (v>299))
                  WriteF('\s \d \d',buffer, errcode, 1);
                ENDIF
              ENDIF

              IF (failed=FALSE)
                StrCopy(request,'DATA\n')
                IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                  WriteF('error sending DATA');
                ENDIF

                IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
                  buffer[errcode]:=0
                  v:=Val(buffer)
                  failed:=(((v<200) OR (v>299)) AND (v<>354))
                  WriteF('\s \d \d',buffer, errcode, 1);
                ENDIF
              ENDIF

              IF (failed=FALSE)
                StrCopy(request,'From: <\s>\b\n',mailOptions.bbsEmail)
                IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                  WriteF('error sending msg data');
                ENDIF

                StrCopy(request,'To: <toemail>\b\n')
                IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                  WriteF('error sending `msg data');
                ENDIF

                StringF(request,'Subject: \s\b\n',subject)
                IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                  WriteF('error sending msg data');
                ENDIF

                StrCopy(request,'\b\n')
                IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                  WriteF('error sending msg data');
                ENDIF

                i:=0
                WHILE(i<StrLen(bodytext))
                  IF(v:=InStr('\n',bodytext,i)<0)
                    v:=StrLen(bodytext)
                    StrCopy(request,bodytext+i,v-i)
                    i:=v
                  ELSE
                    StrCopy(request,bodytext+i,v-i)
                    StrAdd(request,'\b\n')
                    i:=v+1
                  ENDIF
                  IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                    WriteF('error sending msg data');
                  ENDIF
                ENDWHILE

                IF appendMsgBuf
                  FOR i:=0 TO lines-1
                     StringF(request,'\s\b\n',msgBuf[i])
                     IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                       WriteF('error sending msg data');
                     ENDIF
                  ENDFOR
                ENDIF

                StrCopy(request,'\b\n.\b\n')
                IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                  WriteF('error sending DATA');
                ENDIF

                IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
                  buffer[errcode]:=0
                  WriteF('\s \d \d',buffer, errcode, 1);
                ENDIF


                StrCopy(request,'QUIT\n')
                IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                  WriteF('error sending QUIT');
                ENDIF
              ENDIF
            ELSE
              WriteF('Couldn''t establish SSL connection!\n');
            ENDIF

            /* If there were errors, print them */
            ->IF (errcode < 0) THEN ErR_print_errors(bio_err);

            /* Send SSL close notification and close the socket */
            SsL_shutdown(ssl);

            SsL_free(ssl);
          ELSE
            WriteF('Couldn''t create new SSL handle!\n');
          ENDIF


        ELSE
          ->standard unencrypted smtp
          IF ((errcode:=Recv(sock,buffer,bufsize - 1,0)) >0)
           buffer[errcode]:=0
            WriteF('\s \d \d',buffer, errcode, 1);
          ELSE
            WriteF('Couldn''t read initial server message!\n');
          ENDIF

          StrCopy(request,'EHLO relay.example.com\n')
          IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
            WriteF('error sending EHLO');
          ENDIF

          IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
            buffer[errcode]:=0
            v:=Val(buffer)
            failed:=((v<200) OR (v>299))
            WriteF('\s \d \d',buffer, errcode, 1);
          ENDIF

          IF (failed=FALSE)
            StringF(request,'\n\s\n\s',mailOptions.username,mailOptions.password)
            v:=StrLen(request)-1
            FOR i:=0 TO v
              IF request[i]="\n" THEN request[i]:=0
            ENDFOR
            base64enc(request,EstrLen(request),buffer)
            StringF(request,'AUTH PLAIN \s\n',buffer)
            IF ((errcode:=Send(sock, request, EstrLen(request),0)) <=0 )
              WriteF('error sending AUTH');
            ENDIF

            IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
              buffer[errcode]:=0
              v:=Val(buffer)
              failed:=((v<200) OR (v>299))
              WriteF('\s \d \d',buffer, errcode, 1);
            ENDIF
          ENDIF

          IF (failed=FALSE)
            StringF(request,'mail from:<\s>\n',mailOptions.bbsEmail)
            IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
              WriteF('error sending FROM');
            ENDIF

            IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
              buffer[errcode]:=0
              v:=Val(buffer)
              failed:=((v<200) OR (v>299))
              WriteF('\s \d \d',buffer, errcode, 1);
            ENDIF
          ENDIF

          IF (failed=FALSE)
            StringF(request,'rcpt to:<\s>\n',toemail)
            IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
              WriteF('error sending TO');
            ENDIF

            IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
              buffer[errcode]:=0
              v:=Val(buffer)
              failed:=((v<200) OR (v>299))
              WriteF('\s \d \d',buffer, errcode, 1);
            ENDIF
          ENDIF

          IF (failed=FALSE)
            StrCopy(request,'DATA\n')
            IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
              WriteF('error sending DATA');
            ENDIF

            IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
              buffer[errcode]:=0
              v:=Val(buffer)
              failed:=(((v<200) OR (v>299)) AND (v<>354))
              WriteF('\s \d \d',buffer, errcode, 1);
            ENDIF
          ENDIF

          IF (failed=FALSE)
            StrCopy(request,'From: <\s>\b\n',mailOptions.bbsEmail)
            IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
              WriteF('error sending msg data');
            ENDIF

            StrCopy(request,'To: <toemail>\b\n')
            IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
              WriteF('error sending `msg data');
            ENDIF

            StringF(request,'Subject: \s\b\n',subject)
            IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
              WriteF('error sending msg data');
            ENDIF

            StrCopy(request,'\b\n')
            IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
              WriteF('error sending msg data');
            ENDIF

            i:=0
            WHILE(i<StrLen(bodytext))
              IF(v:=InStr('\n',bodytext,i)<0)
                v:=StrLen(bodytext)
                StrCopy(request,bodytext+i,v-i)
                i:=v
              ELSE
                StrCopy(request,bodytext+i,v-i)
                StrAdd(request,'\b\n')
                i:=v+1
              ENDIF
              IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
                WriteF('error sending msg data');
              ENDIF
            ENDWHILE

            IF appendMsgBuf
              FOR i:=0 TO lines-1
                 StringF(request,'\s\b\n',msgBuf[i])
                 IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
                   WriteF('error sending msg data');
                 ENDIF
              ENDFOR
            ENDIF

            StrCopy(request,'\b\n.\b\n')
            IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
              WriteF('error sending DATA');
            ENDIF

            IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
              buffer[errcode]:=0
              WriteF('\s \d \d',buffer, errcode, 1);
            ENDIF


            StrCopy(request,'QUIT\n')
            IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
              WriteF('error sending QUIT');
            ENDIF
          ENDIF
        ENDIF
				CloseSocket(sock);     
			ELSE
        WriteF('Couldn''t connect to host!\n');
      ENDIF
ENDPROC

PROC base64enc(data:PTR TO CHAR,len,output)
  DEF b64
  DEF mem
  DEF done=FALSE,res=0,outstr,strlen
-> bio is simply a class that wraps BIO* and it free the BIO in the destructor.

  b64:=BiO_new(BiO_f_base64()); ->// create BIO to perform base64
  BiO_set_flags(b64, BIO_FLAGS_BASE64_NO_NL);

  mem:=BiO_new(BiO_s_mem()); ->// create BIO that holds the result

  ->// chain base64 with mem, so writing to b64 will encode base64 and write to mem.
  BiO_push(b64, mem);

  ->// write data
  WHILE(done=FALSE)
    res:=BiO_write(b64, data, len);

    IF(res <= 0) -> if failed
        IF(BiO_fd_should_retry(b64)=FALSE)
          ->// encoding failed
            /* Handle Error!!! */
          RETURN 0
        ENDIF
    ELSE
     ->// success!
        done:=TRUE;
    ENDIF
  ENDWHILE

  BiO_ctrl(b64,BIO_CTRL_FLUSH,0,NIL)

  strlen:=BiO_ctrl(mem,BIO_CTRL_INFO,0,{outstr})
  
  StrCopy(output,outstr,strlen)
  BiO_free(mem)
  BiO_free(b64)
  
ENDPROC 

/* Open and initialize AmiSSL */
PROC initssl(createctx)
  DEF tags

  socketbase:=OpenLibrary('bsdsocket.library', 4)
	IF (socketbase=NIL)
		WriteF('Couldn''t open bsdsocket.library v4!\n')
    cleanupssl()
    RETURN FALSE
  ENDIF

  amisslmasterbase:=OpenLibrary('amisslmaster.library',AMISSLMASTER_MIN_VERSION)
	IF (amisslmasterbase=NIL)
		WriteF('Couldn''t open amisslmaster.library v\d!\n',AMISSLMASTER_MIN_VERSION);
    cleanupssl()
    RETURN FALSE
  ENDIF

	IF (InitAmiSSLMaster(AMISSL_CURRENT_VERSION, TRUE))=NIL
		WriteF('AmiSSL version is too old!\n');
    cleanupssl()
    RETURN FALSE
  ENDIF

  amisslbase:=OpenAmiSSL()
	IF (amisslbase=NIL)
    WriteF('Couldn''t open AmiSSL!\n');
    cleanupssl()
    RETURN FALSE
  ENDIF

  tags:=NEW [amiSSL_ErrNoPtr,{errno},amiSSL_SocketBase,socketbase,0]
  IF (InitAmiSSLA(tags) <> 0)
    END tags
		WriteF('Couldn''t initialize AmiSSL!\n');
    cleanupssl()
    RETURN FALSE
  ENDIF
  END tags

  /* Basic intialization. Next few steps (up to SSL_new()) need
   * to be done only once per AmiSSL opener.
   */
   
   OpENSSL_init_ssl(0,NIL) 		->SSLeay_add_ssl_algorithms();   -$67C8(a6)
   OpENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS OR OPENSSL_INIT_LOAD_CRYPTO_STRINGS, NIL) ->SSL_load_error_strings();

  /* Note: BIO writing routines are prepared for NULL BIO handle */
  IF((bio_err:=BiO_new(BiO_s_file())) <> NIL) THEN BiO_ctrl(bio_err, BIO_SET_FILE_PTR, BIO_NOCLOSE OR BIO_FP_TEXT, Output()); ->BiO_set_fp_amiga(bio_err, Output(), BIO_NOCLOSE OR BIO_FP_TEXT);

  /* Get a new SSL context */
  IF (createctx)
    ctx:=SsL_CTX_new(TlS_client_method())
    IF (ctx=0)
      WriteF('Couldn''t create ssl ctx!\n');
      cleanupssl()
      RETURN FALSE
    ENDIF
    SsL_CTX_set_default_verify_paths(ctx);
    SsL_CTX_set_verify(ctx, SSL_VERIFY_PEER OR SSL_VERIFY_FAIL_IF_NO_PEER_CERT,NIL);
  ENDIF

ENDPROC TRUE

PROC cleanupssl()
  IF ctx<>NIL
		SsL_CTX_free(ctx);
    ctx:=NIL
  ENDIF
  
IF bio_err<>NIL
    BiO_free(bio_err)
    bio_err:=NIL
  ENDIF

	IF (amisslbase)
		CleanupAmiSSLA([0]);
		CloseAmiSSL();
		amisslbase:=NIL
	ENDIF

	CloseLibrary(amisslmasterbase);
	amisslmasterbase:=NIL;

	CloseLibrary(socketbase);
	socketbase:=NIL;
ENDPROC

/* Connect to the specified server, either directly or through the specified
 * proxy using HTTP CONNECT method.
 */

PROC connectToServer(host:PTR TO CHAR, port)
  DEF addr: PTR TO sockaddr_in
	DEF is_ok = FALSE;
	DEF sock=NIL;
  DEF hostEnt: PTR TO hostent
  DEF hostaddr: PTR TO LONG

	/* Create a socket and connect to the server */
	IF ((sock:=Socket(AF_INET, SOCK_STREAM, 0)) >= 0)
		->memset(&addr, 0, sizeof(addr));

    hostEnt:=GetHostByName(host)
    hostaddr:=hostEnt.h_addr_list[]
    hostaddr:=hostaddr[]

    NEW addr
		addr.sin_family:=AF_INET;
    addr.sin_addr:=hostaddr[]; /* This should be checked against INADDR_NONE */
    addr.sin_port:=port->htons(port);

		IF (Connect(sock, addr, SIZEOF sockaddr_in) >= 0)
			is_ok:=TRUE
		ELSE
      WriteF('Couldn''t connect to server\n');
    ENDIF
    END addr
		IF (is_ok=FALSE)
			CloseSocket(sock);
			sock:=-1;
    ENDIF
	ENDIF

ENDPROC sock

PROC checkOnlineStatus()
  DEF stat

  IF(state=STATE_AWAIT) THEN RETURN RESULT_SUCCESS

  IF(reqState=REQ_STATE_LOGOFF) THEN RETURN RESULT_NO_CARRIER
  IF(logonType>=LOGON_TYPE_REMOTE)
  	stat:=checkCarrier()
 	  IF(stat=FALSE) THEN RETURN RESULT_NO_CARRIER
 	ENDIF
ENDPROC RESULT_SUCCESS

PROC modemOffHook()
  IF(StrLen(cmds.serDev)>0)
    IF(sopt.toggles[TOGGLES_SERIALRESET])
      resetSystem(0)
      intDoReset(sopt.offHook)
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SER_OUT]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      ioFlags[IOFLAG_KBD_IN]:=-1
    ELSE
      dropDTR();Delay(25)->//Reset_System(0)
      intDoReset(sopt.offHook)
      Delay(5)
      ->droppedHook:=1
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SER_OUT]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      ioFlags[IOFLAG_KBD_IN]:=-1
    ENDIF
  ENDIF
ENDPROC

PROC updateTimeUsed()
  DEF currDay,logonDay,currTime,time
  DEF tempstr[255]:STRING
  currTime:=getSystemTime()
  currDay:=Div(currTime-21600,86400)
  logonDay:=Div(logonTime-21600,86400)
  IF (currDay<>logonDay)
    loggedOnUser.timeTotal:=loggedOnUser.timeLimit
    loggedOnUser.dailyBytesDld:=0
    loggedOnUser.timeUsed:=0
    loggedOnUser.chatRemain:=loggedOnUser.chatLimit

    logonTime:=Mul(currDay,86400)+21600
    StringF(tempstr,'timeused debug: new day reset,  currday \d, logonday \d, new logontime \d',currDay,logonDay,logonTime)
    debugLog(LOG_WARN,tempstr)
    lastTimeUpdate:=logonTime
  ENDIF
  IF (currTime-lastTimeUpdate)>0
    IF(chatFlag=0) 
      StringF(tempstr,'timeused debug: timeused \d, increment \d, currtime: \d, lasttime: \d',loggedOnUser.timeUsed,currTime-lastTimeUpdate,currTime,lastTimeUpdate)
      debugLog(LOG_WARN,tempstr)
      loggedOnUser.timeUsed:=loggedOnUser.timeUsed+(currTime-lastTimeUpdate)
      timeLimit:=timeLimit-(currTime-lastTimeUpdate)
    ELSE
      loggedOnUser.chatRemain:=loggedOnUser.chatRemain-(currTime-lastTimeUpdate)
    ENDIF
    lastTimeUpdate:=currTime
  ENDIF
  
  IF (timeLimit<0) AND (state<>STATE_LOGGING_OFF)
    IF displayScreen(SCREEN_LOGON24)=FALSE
      aePuts('You have exceeded your time limit\b\n')
      aePuts('Goodbye\b\n\b\n')
      aePuts('Disconnecting..\b\n')
    ENDIF
    dropDTR()
    quickFlag:=TRUE
    saveFlagged()
    IF StrLen(historyFolder)>0 THEN saveHistory()
    reqState:=REQ_STATE_LOGOFF
    setEnvStat(ENV_LOGOFF)  
  ENDIF
ENDPROC

PROC checkMailConfScan(conf)
  DEF cb: PTR TO confBase
  DEF res=TRUE

  IF((checkToolTypeExists(TOOLTYPE_CONF,conf,'FORCE_NEWSCAN')))
    RETURN TRUE
  ELSEIF (checkToolTypeExists(TOOLTYPE_CONF,conf,'NO_NEWSCAN'))
    RETURN FALSE
  ENDIF
   
  cb:=ListItem(confBases,conf-1)
  
  IF cb<>NIL
    IF (cb.handle[0] AND MAIL_SCAN_MASK)<>0 THEN res:=TRUE ELSE res:=FALSE
  ELSE
    res:=TRUE
  ENDIF
ENDPROC res

PROC checkFileConfScan(conf)
  DEF cb: PTR TO confBase
  DEF res

  IF((checkToolTypeExists(TOOLTYPE_CONF,conf,'SHOW_NEW_FILES')))
    RETURN TRUE
  ELSEIF (checkToolTypeExists(TOOLTYPE_CONF,conf,'NO_NEW_FILES'))
    RETURN FALSE
  ENDIF

  cb:=ListItem(confBases,conf-1)
  
  IF cb<>NIL
    IF (cb.handle[0] AND FILE_SCAN_MASK)<>0 THEN res:=TRUE ELSE res:=FALSE
  ELSE
    res:=TRUE
  ENDIF
ENDPROC res

PROC closeSerial()
  IF serialReadIO<>NIL
    IF CheckIO(serialReadIO)=FALSE THEN AbortIO(serialReadIO)
    CloseDevice(serialReadIO)
    deleteExtIO(serialReadIO)
    serialReadIO:=NIL
  ENDIF
  IF serialReadMP<>NIL
    deletePort(serialReadMP)
    serialReadMP:=NIL
  ENDIF
  IF serialWriteIO<>NIL
    CloseDevice(serialWriteIO)
    deleteExtIO(serialWriteIO)
    serialWriteIO:=NIL
  ENDIF
  IF serialWriteMP<>NIL 
    deletePort(serialWriteMP)
    serialWriteMP:=NIL
  ENDIF
ENDPROC

PROC setNRAMS()
  DEF nramName[255]:STRING
  DEF nramData[255]:STRING
  DEF n=1

  StringF(nramName,'NRAM.\d',1)
  IF readToolType(TOOLTYPE_NRAMS,node,nramName,nramData) AND (serialWriteIO<>NIL)
    ioFlags[IOFLAG_SER_IN]:=-1
    ioFlags[IOFLAG_SER_OUT]:=0
    ioFlags[IOFLAG_SCR_OUT]:=0
    ioFlags[IOFLAG_KBD_IN]:=-1
    dropDTR()
    intDoReset(sopt.offHook)
    setEnvMsg('Setting NRAMS')
    REPEAT
      StringF(nramName,'Setting NRAM.\d',n)
      setEnvMsg(nramName)
      intDoReset(nramData)
      Delay(60)    
      n++
      StringF(nramName,'NRAM.\d',n)
    UNTIL readToolType(TOOLTYPE_NRAMS,node,nramName,nramData)=FALSE
    resetSystem(0);
    setEnvStat(ENV_AWAITCONNECT)
  ELSE
    setEnvMsg('NO NRAM.DEF')
    Delay(30)
    setEnvStat(ENV_AWAITCONNECT)
  ENDIF
ENDPROC

PROC reInitModem()
  dropDTR()
  Delay(20)
  intDoReset(sopt.offHook)
  Delay(60)
  serPuts(cmds.mInit)
  serPutChar("\b")
  Delay(60)
  purgeLine()
ENDPROC

PROC openSerial(baud, dataLen, stopBits)
  DEF cia_ptr=12570624 ->0xBFD000
  DEF flags,rcount=0,error
  DEF errorstr[255]:STRING

  IF serialReadIO<>NIL THEN RETURN FALSE

  IF(StrLen(cmds.serDev)>0)
	
    IF(serialReadMP:=createPort(0,0))
      IF(serialReadIO:=createExtIO(serialReadMP,SIZEOF ioextser))
        IF(serialWriteMP:=createPort(0,0))
          IF(serialWriteIO:=createExtIO(serialWriteMP,SIZEOF ioextser))
          flags:=SERF_SHARED
           IF checkToolTypeExists(TOOLTYPE_NODE,node,'NORADBOOGIE')=FALSE THEN flags:=flags OR SERF_XDISABLED OR SERF_RAD_BOOGIE
           IF (cmds.acLvl[LVL_VARYING_LINK_RATE]=0) THEN flags:=flags OR SERF_7WIRE
           serialWriteIO.serflags:=flags
           serialReadIO.serflags:=flags

  retry:
            IF((OpenDevice(cmds.serDev,cmds.serDevUnit,serialReadIO,0)))=FALSE
              IF((OpenDevice(cmds.serDev,cmds.serDevUnit,serialWriteIO,0)))=FALSE
                Delay(10)

                serialWriteIO.baud:=baud
                serialWriteIO.readlen:=dataLen
                serialWriteIO.writelen:=dataLen
                serialWriteIO.serflags:=flags
                serialWriteIO.stopbits:=stopBits
                serialWriteIO.ctlchar:=286457856   ->0x11130000
                serialWriteIO.rbuflen:=16384
                serialWriteIO.iostd.command:=SDCMD_SETPARAMS
                error:=DoIO(serialWriteIO)
                IF error
                  StringF(errorstr,'error write setparams: \d',error)
                  debugLog(LOG_ERROR,errorstr)
                ENDIF

                serialReadIO.baud:=baud
                serialReadIO.readlen:=dataLen
                serialReadIO.writelen:=dataLen
                serialReadIO.serflags:=flags
                serialReadIO.stopbits:=stopBits
                serialReadIO.ctlchar:=286457856   ->0x11130000
                serialReadIO.rbuflen:=16384
                serialReadIO.iostd.command:=SDCMD_SETPARAMS
                error:=DoIO(serialReadIO)
                IF error 
                  StringF(errorstr,'error read setparams: \d',error)
                  debugLog(LOG_ERROR,errorstr)
                ENDIF

                ->SerCharSig=1L<<ReadSerPort->mp_SigBit
 
                queueRead(serialReadIO,{serbuff})
                RETURN FALSE
              ENDIF
            ELSE
             Delay(30)
             rcount++
             IF rcount<120 THEN JUMP retry
            ENDIF

            deleteExtIO(serialWriteIO)
            serialWriteIO:=NIL
           ENDIF
           deletePort(serialWriteMP)
           serialWriteMP:=NIL
         ENDIF
         deleteExtIO(serialReadIO)
         serialReadIO:=NIL
        ENDIF
      deletePort(serialReadMP)
      serialReadMP:=NIL
    ENDIF
    RETURN TRUE
  ENDIF

ENDPROC FALSE

PROC setBaud(rate)
  IF serialReadIO<>NIL
    purgeLine()                 /* Flush recieve buffer */
    AbortIO(serialReadIO)         /* Abort PurgeLine's read req */
    WaitIO(serialReadIO)
    serialReadIO.baud:=rate  /* set baud rate */
    serialReadIO.iostd.command:=SDCMD_SETPARAMS
    DoIO(serialReadIO)

    serialReadIO.iostd.command:=CMD_READ /* Restart read req */
    SendIO(serialReadIO)
	ENDIF
ENDPROC


PROC intDoReset(s: PTR TO CHAR)
  DEF loop,i
  i:=StrLen(s)
  FOR loop:=0 TO i-1
	  IF(s[loop]="~") 
      Delay(110)
    ELSE
      IF(s[loop]="|") THEN serPutChar("\b") ELSE serPutChar(s[loop])
    ENDIF
	ENDFOR
  serPutChar("\b")
  /*LineInput("",GSTR3,50,10)*/
ENDPROC

PROC dropDTR()
  IF(serialReadIO<>NIL)
    IF(CheckIO(serialReadIO))=FALSE 
	     AbortIO(serialReadIO)
    ENDIF
  	WaitIO(serialReadIO)
   
	  closeSerial()    ->// this was not resetting SEROUT Mon Jun  8 04:02:50 1992
 	  Delay(60)
	  IF(openSerial(cmds.openingBaud,8,1)<>0) 
      debugLog(LOG_ERROR,'Can''t re-open Serial Device!')
    ENDIF
 	
    Delay(12)
  ENDIF
ENDPROC


PROC rePurge()
  WHILE(checkSer())
     WaitIO(serialReadIO)
     serialReadIO.iostd.command:=CMD_READ
     SendIO(serialReadIO)
  ENDWHILE
ENDPROC

PROC resetSystem(yes)
  DEF tempStr[255]:STRING

  ioFlags[IOFLAG_KBD_IN]:=-1
  ioFlags[IOFLAG_SER_IN]:=0
  IF(ioFlags[IOFLAG_FIL_IN]) THEN ioFlags[IOFLAG_FIL_IN]:=0
  
  ioFlags[IOFLAG_SCR_OUT]:=0
  ioFlags[IOFLAG_SER_OUT]:=-1
  IF(StrLen(cmds.serDev)<>0)
  
  -> if(!Dropped_Hook)
  -> {
    purgeLine()
    dropDTR()
  -> }else Dropped_Hook=0
    Delay(25)
    IF(cmds.acLvl[LVL_VARYING_LINK_RATE]=1)
       setBaud(cmds.openingBaud)
  	Delay(25)
  	ENDIF
    intDoReset(cmds.mReset)
    IF(sopt.toggles[TOGGLES_TRUERESET])  /*toggles[0]=truereset*/
      Delay(30)
  	  serPuts('ATZ\b')
  	  lineInput('','',50,5,tempStr)
  	  IF(strCmpi(tempStr,'ATZ',3))
  		   Delay(50) ->//LineInput("",GSTR3,50,5)
  		ENDIF
  	  reInitModem()
  	  intDoReset(cmds.mReset)
  	ENDIF
    Delay(30)
    IF(sopt.toggles[TOGGLES_NOPURGE]) THEN RETURN
    IF(sopt.toggles[TOGGLES_REPURGE])
      rePurge()
      RETURN
    ENDIF
   purgeLine()
 
  /*IF checkToolTypeExists(TOOLTYPE_NODE,node,'TELNETD')
    serPuts('AT*C1\b')
  ENDIF*/

  ioFlags[IOFLAG_SER_OUT]:=0

  ENDIF
ENDPROC

PROC checkDoorMsg(mode)
   DEF inac=FALSE
   DEF returnval=FALSE
   DEF ch,cmd
   DEF type
   DEF servermsg: PTR TO jhMessage
   DEF olmmsg,len,i
   DEF subState: loggedOnState
   DEF debugstr[255]:STRING

   ->debugLog(LOG_DEBUG,'doormsg')
   IF(inac) THEN RETURN

   IF resmp=FALSE THEN RETURN

   WHILE(servermsg:=GetMsg(resmp))  
     StringF(debugstr,'server message cmd:\d',servermsg.command)
     debugLog(LOG_DEBUG,debugstr)
     StringF(debugstr,'server message data:\d',servermsg.data)
     debugLog(LOG_DEBUG,debugstr)
     StringF(debugstr,  'server message string:\s',servermsg.string)
     debugLog(LOG_DEBUG,debugstr)
     cmd:=servermsg.command
      SELECT cmd
        CASE JH_WRITE
          ->IF(currentStat=0)
            aePuts(servermsg.string)
          ->ENDIF
          servermsg.command:=currentStat 
        CASE SV_UNICONIFY
          servercmd:=SV_UNICONIFY
        CASE SV_EXITNODE
          servercmd:=SV_EXITNODE
        CASE SV_NODEOFFHOOK
          servercmd:=SV_NODEOFFHOOK
        CASE SV_SYSOPLOG
          servercmd:=SV_SYSOPLOG
        CASE SV_LOCALLOG
          servercmd:=SV_LOCALLOG
        CASE SV_CHATTOGGLE
          sysopAvail:=Not(sysopAvail)
          statChatFlag()
        CASE SV_ACCOUNTS
          servercmd:=SV_ACCOUNTS
        CASE SV_QUIETNODE
          quietFlag:=Not(quietFlag)
          sendQuietFlag(quietFlag)    
        CASE SV_SETNRAMS
          type:=servermsg.msg.ln.type
          ReplyMsg(servermsg)
          IF type=NT_FREEMSG THEN FreeMem(servermsg,servermsg.msg.length)
          servermsg:=NIL
          setNRAMS()
        CASE SV_CHAT
          IF logonType<>LOGON_TYPE_LOGGED_OFF THEN servercmd:=SV_CHAT
        CASE SV_INCOMING_MSG
          subState:=stateData
          
          IF ListLen(olmBuf)<ListMax(olmBuf)
            olmmsg:=String(StrLen(servermsg.string))
            StrCopy(olmmsg,servermsg.string)
            ListAdd(olmBuf,[olmmsg])
          ENDIF
          IF servermsg.lineNum<0
            ->message ready to send
            IF (state=STATE_LOGGEDON) AND (subState.subState=SUBSTATE_READ_COMMAND)
              FOR i:=0 TO ListLen(olmBuf)-1
                aePuts(olmBuf[i])
                DisposeLink(olmBuf[i])
              ENDFOR
              ->readChar(INPUT_TIMEOUT)
              ->displayMenuPrompt()
            ELSE
              len:=0
              FOR i:=0 TO ListLen(olmBuf)-1
                len:=len+StrLen(olmBuf[i])
                len:=len+2
              ENDFOR
              olmmsg:=String(len)
              FOR i:=0 TO ListLen(olmBuf)-1
                StrAdd(olmmsg,olmBuf[i])
                DisposeLink(olmBuf[i])
              ENDFOR
              ListAdd(olmQueue,[olmmsg])
            ENDIF
            SetList(olmBuf,0)
          ENDIF
      ENDSELECT    
     IF servermsg<>NIL
       type:=servermsg.msg.ln.type
       ReplyMsg(servermsg)
       IF type=NT_FREEMSG THEN FreeMem(servermsg,servermsg.msg.length)
     ENDIF
   ENDWHILE
ENDPROC returnval

PROC getPass2(prompt: PTR TO CHAR,password:PTR TO CHAR,pwdhash:LONG, max:LONG,outstr=NIL:PTR TO CHAR)

  DEF c,i,j
  DEF pass[200]:STRING
  DEF tempstr[255]:STRING

  i:=1
  IF (password<>NIL) AND (StrLen(password)=0) THEN RETURN RESULT_FAILURE
 
  WHILE i
    aePuts(prompt)
    j:=0
    REPEAT
      c:=readChar(INPUT_TIMEOUT)
      IF((c=RESULT_NO_CARRIER) OR (c=RESULT_TIMEOUT)) THEN RETURN c
      IF(c=CHAR_BACKSPACE)
         IF j<>0
            StrCopy(tempstr,'')
            strAddChar(tempstr,8)
            StrAdd(tempstr,' ')
            strAddChar(tempstr,8)
            aePuts(tempstr)
           j--
         ENDIF
      ELSE
        IF((c<>13) AND (c<>12) AND (c<>10))
          StrAdd(pass,' ')
          pass[j]:=c
          serPuts('*')
          IF checkToolTypeExists(TOOLTYPE_NODE,node,'VIEW_PASSWORD') THEN conPutChar(c) ELSE conPuts('*')
          j++
        ENDIF
      ENDIF
    UNTIL (c=13) OR (c=12) OR (j>=30)
        
    SetStr(pass,j)
    IF (outstr<>NIL) THEN StrCopy(outstr,pass)

    IF(j>max) THEN SetStr(pass,max)

    IF (password<>NIL)
      IF(strCmpi(pass,password,ALL))
        purgeLine()
        aePuts('\b\n')
        RETURN RESULT_SUCCESS
      ENDIF
    ELSE
      UpperStr(pass)
      IF calcPasswordHash(pass)=pwdhash
        purgeLine()
        aePuts('\b\n')
        RETURN RESULT_SUCCESS
      ENDIF
    ENDIF
    aePuts('\b\n')
    i--
  ENDWHILE
  purgeLine()
  aePuts('\b\n')
ENDPROC RESULT_NOT_ALLOWED

PROC asmputchar()
  MOVE.B D0,(A3)+
ENDPROC

PROC formatSpaceValue(spaceInKB,outstr)
  DEF frac,whole
  IF (spaceInKB<10240)
    StringF(outstr,'\d KB',spaceInKB)
  ELSEIF(spaceInKB<1048576)
    frac:=Shr(Mul((spaceInKB AND 1023),10),10)
    whole:=Shr(spaceInKB,10)
    StringF(outstr,'\d.\d MB',whole,frac)
  ELSE
    spaceInKB:=Shr(spaceInKB,10)
    frac:=Shr(Mul((spaceInKB AND 1023),10),10)
    whole:=Shr(spaceInKB,10)
    StringF(outstr,'\d.\d GB',whole,frac)
  ENDIF
ENDPROC

PROC formatUnsignedLong(val,outStr)
  RawDoFmt('%lu',{val},{asmputchar},outStr)
ENDPROC

PROC formatLongDate(cDateVal,outDateStr)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF datestr[10]:STRING
  DEF r,dateVal
  
  dateVal:=cDateVal-21600

  d:=dt.stamp
  d.tick:=(dateVal-Mul(Div(dateVal,60),60))
  d.tick:=Mul(d.tick,50)
  dateVal:=Div(dateVal,60)
  d.days:=Div((dateVal),1440)-2922   ->-2922 days between 1/1/70 and 1/1/78
  d.minute:=dateVal-(Mul(d.days+2922,1440))

  dt.format:=FORMAT_USA
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=datestr
  dt.strtime:=0

  IF DateToStr(dt)
    StringF(outDateStr,'\s',datestr)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

PROC formatLongTime(cDateVal,outDateStr)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF time[10]:STRING
  DEF r,dateVal
  
  dateVal:=cDateVal-21600

  d:=dt.stamp
  d.tick:=(dateVal-Mul(Div(dateVal,60),60))
  d.tick:=Mul(d.tick,50)
  dateVal:=Div(dateVal,60)
  d.days:=Div((dateVal),1440)-2922   ->-2922 days between 1/1/70 and 1/1/78
  d.minute:=dateVal-(Mul(d.days+2922,1440))

  dt.format:=FORMAT_USA
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=0
  dt.strtime:=time

  IF DateToStr(dt)
    StringF(outDateStr,'\s',time)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

PROC formatLongDateTime(cDateVal,outDateStr)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF datestr[10]:STRING
  DEF daystr[10]:STRING
  DEF timestr[10]:STRING
  DEF r,dateVal
  
  dateVal:=cDateVal-21600

  d:=dt.stamp
  d.tick:=(dateVal-Mul(Div(dateVal,60),60))
  d.tick:=Mul(d.tick,50)
  dateVal:=Div(dateVal,60)
  d.days:=Div((dateVal),1440)-2922   ->-2922 days between 1/1/70 and 1/1/78
  d.minute:=dateVal-(Mul(d.days+2922,1440))

  dt.format:=FORMAT_DOS
  dt.flags:=0
  dt.strday:=daystr
  dt.strdate:=datestr
  dt.strtime:=timestr

  IF DateToStr(dt)
    StringF(outDateStr,'\s[3] \s \s',daystr,datestr,timestr)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

->returns a numeric value of the date suitable for comparing to other dates
PROC getDateCompareVal(datestr:PTR TO CHAR)
  DEF month,day,year

  month:=Val(datestr)
  day:=Val(datestr+3)
  year:=Val(datestr+6)

  IF (year>TWODIGITYEARSWITCHOVER) THEN year:=1900+year ELSE year:=2000+year
  
ENDPROC Mul(year,10000)+Mul(month,100)+day

PROC isupper(c)
ENDPROC (c>="A") AND (c<="Z")

->returns system date converted to c time format
PROC getSystemDate()
  DEF currDate: datestamp
  DEF startds:PTR TO datestamp
  DEF s1,s2,s3,s4 

  startds:=DateStamp(currDate)

  s1:=startds.days+2922
  s1:=Mul(1440,s1)
  s1:=Mul(60,s1)
  s2:=Mul(60,startds.minute)
  s3:=startds.tick/50
  s4:=Mul(Mul(startds.days+2922,1440),60)+(startds.minute*60)+(startds.tick/50)
  
  s4:=s4+21600

  s4:=Mul(Div(s4,86400),86400)
 ->2922 days between 1/1/70 and 1/1/78
  
ENDPROC s4

->returns system time converted to c time format
PROC getSystemTime()
  DEF currDate: datestamp
  DEF startds:PTR TO datestamp
  DEF s1,s2,s3,s4 

  startds:=DateStamp(currDate)

  s1:=startds.days+2922
  s1:=Mul(1440,s1)
  s1:=Mul(60,s1)
  s2:=Mul(60,startds.minute)
  s3:=startds.tick/50
  s4:=Mul(Mul(startds.days+2922,1440),60)+(startds.minute*60)+(startds.tick/50)
  
 ->2922 days between 1/1/70 and 1/1/78
  
ENDPROC s4+21600

PROC fileWriteLn(fh,str: PTR TO CHAR)
  DEF stat
  IF (stat:=fileWrite(fh,str))<>RESULT_SUCCESS THEN RETURN stat
ENDPROC fileWrite(fh,'\n')

PROC fileWrite(fh,str: PTR TO CHAR)
  DEF s

  s:=Write(fh,str,StrLen(str))
  IF s<>StrLen(str) THEN RETURN RESULT_FAILURE
ENDPROC RESULT_SUCCESS

PROC strCmpi(test1: PTR TO CHAR, test2: PTR TO CHAR, len)
  DEF i,l1,l2

  IF len=ALL
    l1:=StrLen(test1)
    l2:=StrLen(test2)
    IF l1<>l2 THEN RETURN FALSE
    len:=l1
  ENDIF

  FOR i:=0 TO len-1
    IF charToLower(test1[i])<>charToLower(test2[i]) THEN RETURN FALSE
  ENDFOR
ENDPROC TRUE

PROC stripAnsi(s: PTR TO CHAR, d: PTR TO CHAR, resetit, strip)
  DEF i,j,k,p,c
  IF resetit
    ansi.ansicode:=0
    RETURN
  ENDIF

  i:=StrLen(s)
  j:=0
  k:=0
  WHILE(j<i)
   c:=s[j]
   IF((c=13) AND (strip<>0))
     j++
     ansi.ansicode:=0  
   ELSEIF((ansi.ansicode=0) AND (c<>""))
    d[k]:=c
    j++
    k++
   ELSE
     IF(ansi.ansicode)
        ansi.buf[ansi.ansicode]:=c
        IF((ansi.ansicode=1) AND (c<>"["))
           ansi.ansicode:=ansi.ansicode+1

          p:=0
          ansi.buf[ansi.ansicode]:=0
          WHILE(ansi.buf[p]<>0)
            d[k]:=ansi.buf[p]
            k++
            p++
          ENDWHILE
          ansi.ansicode:=0
        ELSE
           SELECT c
            CASE "m"
              ansi.ansicode:=0
            DEFAULT
              ansi.ansicode:=ansi.ansicode+1
              IF(((c>="A") AND (c<="Z")) OR ((c>="a") AND (c<="z")) OR (ansi.ansicode>30))
                p:=0
                ansi.buf[ansi.ansicode]:=0
                WHILE(ansi.buf[p]<>0)
                  d[k]:=ansi.buf[p]
                  k++
                  p++
                ENDWHILE
                ansi.ansicode:=0
              ENDIF
           ENDSELECT
        ENDIF
     ELSEIF(c="")
      ansi.buf[0]:=""
      ansi.ansicode:=1
     ENDIF
    j++
   ENDIF
  ENDWHILE
  d[k]:=0

  ->ensure estring length is updated
  SetStr(d,StrLen(d))
ENDPROC

PROC strCpy(dest: PTR TO CHAR, source: PTR TO CHAR, len)
  DEF c,endfound=FALSE
  DEF i
  IF len=ALL
    AstrCopy(dest,source,ALL)
  ELSE
    FOR i:=0 TO len-1
      c:=source[i]
      IF c=0 THEN endfound:=TRUE
      IF endfound THEN c:=0
      dest[i]:=c
    ENDFOR
  ENDIF
ENDPROC

PROC strAddChar(dest,source)
  StrAdd(dest,' ')
  dest[EstrLen(dest)-1]:=source
ENDPROC

/*PROC aePutChar(c)
  DEF str[1]:STRING
  StrCopy(str,' ')
  str[0]:=c
  aePuts(str)
ENDPROC*/

PROC aePuts(string)
  aePuts2(string,-1)
ENDPROC

PROC asl(s: PTR TO CHAR) HANDLE
  DEF fr:PTR TO filerequester
  DEF src[100]:STRING,tags=NIL
  
  KickVersion(37)  -> E-Note: requires V37   
  aslbase:=OpenLibrary('asl.library',37)
  IF aslbase=NIL THEN Raise(ERR_LIB)
  
  tags:=NEW [ASL_HAIL,'/X FileRequest',
                      ASLFR_SCREEN,screen,
                      ->ASL_WINDOW,window,
                      ASL_PATTERN,'#?',
                      ASL_FUNCFLAGS, FILF_MULTISELECT OR FILF_PATGAD,
                      ASL_DIR,cmds.bbsLoc,
                      NIL]
                      
  fr:=AllocAslRequest(ASL_FILEREQUEST,tags)

  IF(AslRequest(fr,0))

    StrCopy(src,fr.drawer)
    IF(src[StrLen(src)-1]<>":")
      StringF(src,'\s/\s',fr.drawer,fr.file)
    ELSE
      StringF(src,'\s\s',fr.drawer,fr.file)
    ENDIF
    StrCopy(s,src)
  ENDIF
EXCEPT DO
  IF fr THEN FreeAslRequest(fr)
  IF tags THEN END tags
  IF aslbase THEN CloseLibrary(aslbase)
  SELECT exception
    CASE ERR_ASL
      debugLog(LOG_ERROR,'Error: Could not allocate ASL request')
    CASE ERR_KICK
      debugLog(LOG_ERROR,'Error: Requires V37')
    CASE ERR_LIB
      debugLog(LOG_ERROR,'Error: Could not open ASL library')
  ENDSELECT
ENDPROC

PROC fAEPutStr(string)
  aePuts(string)
ENDPROC

PROC aePuts2(string,length)
  DEF str[1023]:STRING
  DEF str2[1023]:STRING
  
  IF ((captureFP<>0) OR (ansiColour=FALSE) OR (bitPlanes<3))
    IF length<>-1 THEN StrCopy(str,string,length) ELSE StrCopy(str,string)
    stripAnsi(str,str2,0,0)
  ENDIF
  
  IF (ansiColour=FALSE)
    IF (ioFlags[IOFLAG_SCR_OUT]) THEN conPuts(str2,length)
    IF (ioFlags[IOFLAG_SER_OUT]) THEN serPuts(str2,length)
  ELSE
    IF (ioFlags[IOFLAG_SCR_OUT]) 
      IF bitPlanes<3 THEN conPuts(str2) ELSE conPuts(string,length)
    ENDIF
    IF (ioFlags[IOFLAG_SER_OUT]) THEN serPuts(string,length)
  ENDIF
  
  IF captureFP THEN fileWrite(captureFP,str2)
ENDPROC

PROC serPutChar(c)
  DEF str[1]:STRING
  StrCopy(str,' ')
  str[0]:=c
  serPuts(str)
ENDPROC

PROC serPuts(string: PTR TO CHAR, putlen=-1,binary=FALSE)
  DEF error,actlen
  IF (serialWriteIO<>NIL)

    IF (binary=FALSE) AND ((actlen:=StrLen(string))<putlen) THEN putlen:=actlen
    serialWriteIO.iostd.command:=CMD_WRITE
    serialWriteIO.iostd.data:=string
    serialWriteIO.iostd.length:=putlen  -> use -1 for print until terminating NIL
    error:=DoIO(serialWriteIO)
    ->IF error THEN debugLog(LOG_ERROR,'serial write error: \d',error)
  ENDIF
ENDPROC    

PROC conPutChar(c)
  DEF str[1]:STRING
  StrCopy(str,' ')
  str[0]:=c
  conPuts(str)
ENDPROC

->>> PROC conPuts(string)
-> Output a NIL-terminated string of characters to a console.
PROC conPuts(string, putlen=-1)
  DEF actlen
  IF (consoleIO<>NIL)
    IF (actlen:=StrLen(string))<putlen THEN putlen:=actlen
    consoleIO.command:=CMD_WRITE
    consoleIO.data:=string
    consoleIO.length:=putlen  -> use -1 for print until terminating NIL
    DoIO(consoleIO)
  ENDIF
ENDPROC    

PROC checkCon()
  IF consoleReadIO=NIL THEN RETURN FALSE
ENDPROC CheckIO(consoleReadIO)

PROC checkSer()
  IF serialReadIO=NIL THEN RETURN FALSE
ENDPROC CheckIO(serialReadIO)

PROC lineReset()
  IF serialReadIO<>NIL 
    serialReadIO.iostd.command:=CMD_RESET
  	DoIO(serialReadIO)
   	serialReadIO.iostd.command:=CMD_READ
	  SendIO(serialReadIO)
  ENDIF
ENDPROC

PROC purgeLineEnd()
  DEF result

  IF serialReadIO<>NIL
    result:=CheckIO(serialReadIO)
	  IF(result=FALSE)
      AbortIO(serialReadIO)
    ENDIF
	  WaitIO(serialReadIO)
    serialReadIO.iostd.command:=CMD_CLEAR
	  DoIO(serialReadIO)
	ENDIF
ENDPROC

PROC purgeLineStart()
  IF serialReadIO<>NIL
    serialReadIO.iostd.command:=CMD_CLEAR
	  DoIO(serialReadIO);
    serialReadIO.iostd.command:=CMD_READ
	  SendIO(serialReadIO)
	ENDIF
ENDPROC

PROC purgeLine()
  IF serialReadIO<>NIL
    AbortIO(serialReadIO)
	  WaitIO(serialReadIO)
    serialReadIO.iostd.command:=CMD_CLEAR
	  DoIO(serialReadIO)
    serialReadIO.iostd.command:=CMD_READ
	  SendIO(serialReadIO)
	ENDIF
ENDPROC

PROC checkCarrier()
  DEF stat,stat2=0
  DEF temp[255]:STRING
  stat:=1
  IF(serialReadIO<>NIL) 
      serialWriteIO.iostd.command:=SDCMD_QUERY
     	stat2:=DoIO(serialWriteIO)
	    stat:=serialWriteIO.status AND CIAF_COMCD
      serialWriteIO.iostd.command:=CMD_WRITE
      IF((sopt.a2232<>0) AND (transfering=FALSE))
        IF((serialWriteIO.status<>0) AND (stat=FALSE))
          IF checkToolTypeExists(TOOLTYPE_NODE,node,'TRAP_SERIAL')
            StringF(temp,'Serial Error \d',serialWriteIO.status)
            errorLog(temp)
          ENDIF
          lineReset()
        ENDIF
      ENDIF
 	ELSE
    RETURN 1
  ENDIF

  IF stat
    lostCarrier:=TRUE
    RETURN FALSE
  ELSE
    RETURN TRUE
  ENDIF
ENDPROC

PROC checkInput()
  checkIconifyMsg()
  checkDoorMsg(0)
ENDPROC ((checkCon() OR checkSer()))

PROC checkScreenClear()
  IF((loggedOnUserKeys.userFlags AND USER_SCRNCLR))
    sendCLS()
  ENDIF
ENDPROC

PROC sCheckInput()
  DEF result1=0,result2=0
  
  IF(consoleReadIO) AND (ioFlags[IOFLAG_KBD_IN]) THEN result1:=CheckIO(consoleReadIO)
  IF(serialReadIO) AND (ioFlags[IOFLAG_SER_IN]) THEN result2:=CheckIO(serialReadIO)
ENDPROC result1 OR result2

->PROC dateDiff(date1: PTR TO datestamp, date2: PTR TO datestamp)
->ENDPROC (date1.days*60)+date1.minute-(date2.days*60)-date2.minute

PROC getConfLocation(confNum,outConfLocationString=NIL)
  IF outConfLocationString<>NIL THEN StrCopy(outConfLocationString,ListItem(confDirs,confNum-1))
ENDPROC ListItem(confDirs,confNum-1)

PROC setConfLocation(confNum,newconfLocation)
  DEF p : PTR TO CHAR

  StrCopy(ListItem(confDirs,confNum-1),newconfLocation)
  IF confNum<11
    p:=cmds.conf1Loc
    strCpy(p+((confNum-1)*60),newconfLocation,ALL)
  ENDIF
ENDPROC

PROC getConfDbFileName(confNum,outConfDbFile)
  DEF cn
  cn:=readToolTypeInt(TOOLTYPE_CONF,confNum,'CONFDB_SHARED')
  IF cn<>-1 THEN confNum:=cn
  getConfLocation(confNum,outConfDbFile)
  StrAdd(outConfDbFile,confDBName)
ENDPROC


PROC getConfName(confNum,outConfNameString=NIL)
  IF outConfNameString<>NIL THEN StrCopy(outConfNameString,ListItem(confNames,confNum-1))
ENDPROC ListItem(confNames,confNum-1)

PROC setConfName(confNum,newConfName)
  DEF p : PTR TO CHAR

  StrCopy(ListItem(confNames,confNum-1),newConfName)
  IF confNum<11
    p:=cmds.conf1Name

    strCpy(p+((confNum-1)*60),newConfName,ALL)
  ENDIF
ENDPROC

PROC yesNo(flag)
  DEF ch

 IF(flag) 
     ch:=Not(flag)
->     AEPutStr((ch?"(y/N)?)
     IF(ch)
       aePuts('[32m([33my[32m/[33mN[32m)[32m?[0m ')
     ELSE
       aePuts('[32m([33mY[32m/[33mn[32m)[32m?[0m ')
     ENDIF
 ENDIF

 WHILE(TRUE)
     ch:=readChar(INPUT_TIMEOUT)
     IF(ch<0) THEN RETURN ch
     IF((ch=13) OR (ch=10))
         IF(flag=1) THEN ch:="y"
         IF(flag=2) THEN ch:="n"
     ENDIF
     IF((ch="y") OR (ch="Y")) 
         aePuts('Yes\b\n')
         RETURN 1
     ENDIF
     IF((ch="n") OR  (ch="N"))
         aePuts('No\b\n')
         RETURN 0
     ENDIF
 ENDWHILE
ENDPROC

PROC addToHistory(text)
  DEF msg
  IF ListLen(historyBuf)<20
    msg:=String(255)
    StrCopy(msg,text)
    ListAdd(historyBuf,[msg])
    historyNum:=ListLen(historyBuf)-1
    historyCycle:=historyNum
  ELSE
    StrCopy(historyBuf[historyNum],text)
    historyCycle:=historyNum
    historyNum++
    IF historyNum>=ListLen(historyBuf) THEN historyNum:=0
  ENDIF
ENDPROC

PROC lineInput(promptText,defaultOutput,maxLen,timeout,outputString,addToHistoryFlag=TRUE)
  DEF result
  DEF wasControl,ch
  DEF cmdCharString[1]:STRING
  DEF timedout, i,originalTimeout,curpos
  DEF tempstr[255]:STRING
  DEF warning=FALSE

  IF StrLen(promptText)>0
    aePuts(promptText)
  ENDIF
  
  lineCount:=0
  
  ->no timeout tooltype overrides normal input timeouts
  IF sopt.toggles[TOGGLES_NOTIMEOUT]
    timeout:=0 
  ELSEIF timeoutOverride<>-1
    timeout:=timeoutOverride
  ENDIF

  IF timeout<120
    warning:=TRUE
  ELSE
    timeout:=timeout-60
  ENDIF
  originalTimeout:=timeout
  
  result:=RESULT_TIMEOUT
  
  ->IF defaultOutput<>outputString THEN
  StrCopy(outputString,defaultOutput,ALL)
  aePuts(outputString)
  curpos:=StrLen(outputString)
  
  conPuts('[ p') /* turn console cursor on */

  REPEAT
redoinput:
    wasControl,ch:=processInputMessage(timeout)
    IF ch=RESULT_ABORT
      StrCopy(outputString,'')
      ch:=13
    ENDIF

    timedout:=(ch=RESULT_TIMEOUT)
    IF timedout AND (warning=FALSE)
      sendBELL()
      timeout:=60
      timedout:=FALSE
      warning:=TRUE
      JUMP redoinput
    ENDIF
    
    IF timedout=FALSE
      warning:=FALSE
      timeout:=originalTimeout
      IF (ch=2) AND (wasControl=0)  -> CTRL B
        FOR i:=0 TO ListLen(historyBuf)-1
          DisposeLink(ListItem(historyBuf,i))
        ENDFOR
        SetList(historyBuf,0)
        historyNum:=0
        historyCycle:=0
        wasControl:=TRUE
      ENDIF
      
      IF (ch=24) AND (wasControl=0)   -> CTRL X
        StrCopy(tempstr,'')
        FOR i:=curpos TO StrLen(outputString)-1
          StrAdd(tempstr,'[1C')
        ENDFOR
        FOR i:=1 TO StrLen(outputString)
          strAddChar(tempstr,8)
          StrAdd(tempstr,' ')
          strAddChar(tempstr,8)
        ENDFOR
        aePuts(tempstr)
        StrCopy(outputString,'')
        curpos:=0
      ENDIF
      
      IF (rawArrow=FALSE)
        IF (ch=UPARROW) AND (ListLen(historyBuf)>0)
          StrCopy(tempstr,'')
          FOR i:=curpos TO StrLen(outputString)-1
            StrAdd(tempstr,'[1C')
          ENDFOR
          FOR i:=1 TO StrLen(outputString)
            strAddChar(tempstr,8)
            StrAdd(tempstr,' ')
            strAddChar(tempstr,8)
          ENDFOR
          StrCopy(outputString,historyBuf[historyCycle],maxLen)
          historyCycle--
          IF historyCycle<0 THEN historyCycle:=ListLen(historyBuf)-1
          aePuts(tempstr)
          aePuts(outputString)
          curpos:=StrLen(outputString)
        ENDIF
        IF (ch=DOWNARROW) AND (ListLen(historyBuf)>0) 
          StrCopy(tempstr,'')
          FOR i:=curpos TO StrLen(outputString)-1
            StrAdd(tempstr,'[1C')
          ENDFOR
          FOR i:=1 TO StrLen(outputString)
            strAddChar(tempstr,8)
            StrAdd(tempstr,' ')
            strAddChar(tempstr,8)
          ENDFOR
          StrCopy(outputString,historyBuf[historyCycle],maxLen)
          historyCycle++
          IF historyCycle>=ListLen(historyBuf) THEN historyCycle:=0
          aePuts(tempstr)
          aePuts(outputString)
          curpos:=StrLen(outputString)
        ENDIF
        IF ((ch=LEFTARROW) AND (curpos>0))
          curpos--
          aePuts('[1D')
        ENDIF
        IF ((ch=RIGHTARROW) AND (curpos<(StrLen(outputString))))
          curpos++
          aePuts('[1C')
        ENDIF
      ENDIF

      IF (wasControl=FALSE)
        cmdCharString[0]:=ch
        IF (ch=CHAR_BACKSPACE)
          StrCopy(tempstr,'')
          IF curpos>0
            strAddChar(tempstr,ch)
            curpos--
            FOR i:=curpos TO StrLen(outputString)-2
              outputString[i]:=outputString[i+1]
              strAddChar(tempstr,outputString[i+1])
            ENDFOR
            StrAdd(tempstr,' ')
            FOR i:=curpos TO StrLen(outputString)-1
              StrAdd(tempstr,'[1D')
            ENDFOR
            
            SetStr(outputString,EstrLen(outputString)-1)      
            aePuts(tempstr)
          ENDIF
        ELSEIF (ch=CHAR_DELETE)
          StrCopy(tempstr,'')
          IF curpos<(StrLen(outputString))
            FOR i:=curpos TO StrLen(outputString)-2
              outputString[i]:=outputString[i+1]
              strAddChar(tempstr,outputString[i+1])
            ENDFOR
            StrAdd(tempstr,' ')
            FOR i:=curpos TO StrLen(outputString)-1
              StrAdd(tempstr,'[1D')
            ENDFOR
            SetStr(outputString,EstrLen(outputString)-1)      
            aePuts(tempstr)
          ENDIF
        ELSEIF (ch>31) AND (EstrLen(outputString)<maxLen)
          StrCopy(tempstr,'')
          StrAdd(outputString,'#')
          FOR i:=StrLen(outputString)-1 TO curpos+1 STEP -1
            outputString[i]:=outputString[i-1]
          ENDFOR
          outputString[curpos]:=ch
          aePuts(cmdCharString)
          curpos++
          FOR i:=curpos TO StrLen(outputString)-1
            strAddChar(tempstr,outputString[i])
          ENDFOR
          FOR i:=curpos TO StrLen(outputString)-1
            StrAdd(tempstr,'[1D')
          ENDFOR
          aePuts(tempstr)
        ENDIF
      ENDIF
    ENDIF
  UNTIL (ch=13) OR (timedout) OR (reqState<>REQ_STATE_NONE)
  
  conPuts('[0 p'); /* turn console cursor off */

  IF ch=13  THEN result:=RESULT_SUCCESS
  IF (result=RESULT_SUCCESS) AND (StrLen(outputString)>0) AND (addToHistoryFlag)
    addToHistory(outputString)
  ENDIF
  
  IF (captureFP)
    fileWriteLn(captureFP,outputString)
  ENDIF

  aePuts('\b\n')
ENDPROC result
   
PROC readMayGetChar(msgport, whereto)
  DEF temp, readreq:PTR TO iostd
  IF NIL=(readreq:=GetMsg(msgport)) THEN RETURN -1
  temp:=whereto[]  -> Get the character...
  queueRead(readreq, whereto)  -> ...then re-use the request block
ENDPROC temp
     
->>> PROC queueRead(readreq:PTR TO iostd, whereto,size=1)
-> Queue up a read request to console, passing it pointer to a buffer into
-> which it can read the character
PROC queueRead(readreq:PTR TO iostd, whereto,bsize=1)
  readreq.command:=CMD_READ
  readreq.data:=whereto
  readreq.length:=bsize
  SendIO(readreq)
ENDPROC
->>>

PROC calcPasswordHash(pwd: PTR TO CHAR)
   DEF hash
   DEF hashdata
   
   hashdata:=NEW[$0000,$0000,$7707,$3096,$EE0E,$612C,$9909,$51BA,$076D,$C419,$706A,$F48F,$E963,$A535,$9E64,$95A3,$0EDB,$8832,$79DC,$B8A4,$E0D5,$E91E,
     $97D2,$D988,$09B6,$4C2B,$7EB1,$7CBD,$E7B8,$2D07,$90BF,$1D91,$1DB7,$1064,$6AB0,$20F2,$F3B9,$7148,$84BE,$41DE,$1ADA,$D47D,$6DDD,$E4EB,
     $F4D4,$B551,$83D3,$85C7,$136C,$9856,$646B,$A8C0,$FD62,$F97A,$8A65,$C9EC,$1401,$5C4F,$6306,$6CD9,$FA0F,$3D63,$8D08,$0DF5,$3B6E,$20C8,
     $4C69,$105E,$D560,$41E4,$A267,$7172,$3C03,$E4D1,$4B04,$D447,$D20D,$85FD,$A50A,$B56B,$35B5,$A8FA,$42B2,$986C,$DBBB,$C9D6,$ACBC,$F940,
     $32D8,$6CE3,$45DF,$5C75,$DCD6,$0DCF,$ABD1,$3D59,$26D9,$30AC,$51DE,$003A,$C8D7,$5180,$BFD0,$6116,$21B4,$F4B5,$56B3,$C423,$CFBA,$9599,
     $B8BD,$A50F,$2802,$B89E,$5F05,$8808,$C60C,$D9B2,$B10B,$E924,$2F6F,$7C87,$5868,$4C11,$C161,$1DAB,$B666,$2D3D,$76DC,$4190,$01DB,$7106,
     $98D2,$20BC,$EFD5,$102A,$71B1,$8589,$06B6,$B51F,$9FBF,$E4A5,$E8B8,$D433,$7807,$C9A2,$0F00,$F934,$9609,$A88E,$E10E,$9818,$7F6A,$0DBB,
     $086D,$3D2D,$9164,$6C97,$E663,$5C01,$6B6B,$51F4,$1C6C,$6162,$8565,$30D8,$F262,$004E,$6C06,$95ED,$1B01,$A57B,$8208,$F4C1,$F50F,$C457,
     $65B0,$D9C6,$12B7,$E950,$8BBE,$B8EA,$FCB9,$887C,$62DD,$1DDF,$15DA,$2D49,$8CD3,$7CF3,$FBD4,$4C65,$4DB2,$6158,$3AB5,$51CE,$A3BC,$0074,
     $D4BB,$30E2,$4ADF,$A541,$3DD8,$95D7,$A4D1,$C46D,$D3D6,$F4FB,$4369,$E96A,$346E,$D9FC,$AD67,$8846,$DA60,$B8D0,$4404,$2D73,$3303,$1DE5,
     $AA0A,$4C5F,$DD0D,$7CC9,$5005,$713C,$2702,$41AA,$BE0B,$1010,$C90C,$2086,$5768,$B525,$206F,$85B3,$B966,$D409,$CE61,$E49F,$5EDE,$F90E,
     $29D9,$C998,$B0D0,$9822,$C7D7,$A8B4,$59B3,$3D17,$2EB4,$0D81,$B7BD,$5C3B,$C0BA,$6CAD,$EDB8,$8320,$9ABF,$B3B6,$03B6,$E20C,$74B1,$D29A,
     $EAD5,$4739,$9DD2,$77AF,$04DB,$2615,$73DC,$1683,$E363,$0B12,$9464,$3B84,$0D6D,$6A3E,$7A6A,$5AA8,$E40E,$CF0B,$9309,$FF9D,$0A00,$AE27,
     $7D07,$9EB1,$F00F,$9344,$8708,$A3D2,$1E01,$F268,$6906,$C2FE,$F762,$575D,$8065,$67CB,$196C,$3671,$6E6B,$06E7,$FED4,$1B76,$89D3,$2BE0,
     $10DA,$7A5A,$67DD,$4ACC,$F9B9,$DF6F,$8EBE,$EFF9,$17B7,$BE43,$60B0,$8ED5,$D6D6,$A3E8,$A1D1,$937E,$38D8,$C2C4,$4FDF,$F252,$D1BB,$67F1,
     $A6BC,$5767,$3FB5,$06DD,$48B2,$364B,$D80D,$2BDA,$AF0A,$1B4C,$3603,$4AF6,$4104,$7A60,$DF60,$EFC3,$A867,$DF55,$316E,$8EEF,$4669,$BE79,
     $CB61,$B38C,$BC66,$831A,$256F,$D2A0,$5268,$E236,$CC0C,$7795,$BB0B,$4703,$2202,$16B9,$5505,$262F,$C5BA,$3BBE,$B2BD,$0B28,$2BB4,$5A92,
     $5CB3,$6A04,$C2D7,$FFA7,$B5D0,$CF31,$2CD9,$9E8B,$5BDE,$AE1D,$9B64,$C2B0,$EC63,$F226,$756A,$A39C,$026D,$930A,$9C09,$06A9,$EB0E,$363F,
     $7207,$6785,$0500,$5713,$95BF,$4A82,$E2B8,$7A14,$7BB1,$2BAE,$0CB6,$1B38,$92D2,$8E9B,$E5D5,$BE0D,$7CDC,$EFB7,$0BDB,$DF21,$86D3,$D2D4,
     $F1D4,$E242,$68DD,$B3F8,$1FDA,$836E,$81BE,$16CD,$F6B9,$265B,$6FB0,$77E1,$18B7,$4777,$8808,$5AE6,$FF0F,$6A70,$6606,$3BCA,$1101,$0B5C,
     $8F65,$9EFF,$F862,$AE69,$616B,$FFD3,$166C,$CF45,$A00A,$E278,$D70D,$D2EE,$4E04,$8354,$3903,$B3C2,$A767,$2661,$D060,$16F7,$4969,$474D,
     $3E6E,$77DB,$AED1,$6A4A,$D9D6,$5ADC,$40DF,$0B66,$37D8,$3BF0,$A9BC,$AE53,$DEBB,$9EC5,$47B2,$CF7F,$30B5,$FFE9,$BDBD,$F21C,$CABA,$C28A,
     $53B3,$9330,$24B4,$A3A6,$BAD0,$3605,$CDD7,$0693,$54DE,$5729,$23D9,$67BF,$B366,$7A2E,$C461,$4AB8,$5D68,$1B02,$2A6F,$2B94,$B40B,$BE37,
     $C30C,$8EA1,$5A05,$DF1B,$2D02,$EF8D,0]:INT
   
   MOVE.L pwd,A0
   BSR sub_486F0
   MOVE.L D0,hash
   END hashdata
   RETURN hash
/*
d1=51
d1=144
d1=1C6C6162
d1=54
d1=36
d1=d8
d1=cfba9599


d6d6a3e8
a2677172
e8b8d433
ad678846
8a65c9ec

end1
8ac8467e
b2373032
*/
sub_486F0:
    MOVEM.L D1-D7/A1-A6,-(A7)
    MOVEA.L A0,A3
    MOVEQ #0,D0
    TST.B (A0)
    BNE.W loc_48704
    MOVEM.L (A7)+,D1-D7/A1-A6
    RTS
-> ---------------------------------------------------------------------------

loc_48704:
    MOVEQ #0,D1

loc_48706:
    MOVE.B  (A0)+,D0
    TST.B D0
    BEQ.W loc_48712
    ADDQ.B  #1,D1
    BRA.S loc_48706
-> ---------------------------------------------------------------------------

loc_48712:
    MOVEA.L A3,A0
    MOVEA.L A0,A1
    MOVEA.L A0,A2
    MOVE.L hashdata,A1
    MOVE.L D1,D5

    MOVEQ #0,D0
    MOVEQ #8,D2
    MOVEQ #$FFFFFFFF,D3
    MOVEQ #2,D4

loc_48726:
    MOVEQ #0,D1
    MOVE.B  (A0)+,D1
    EOR.B D0,D1
    AND.W D3,D1
    ASL.W D4,D1
    MOVE.L  0(A1,D1.L),D1
    LSR.L D2,D0
    EOR.L D1,D0
    SUBQ.L  #1,D5
    BNE.S loc_48726
    SWAP  D0
    NOT.W D0
    ROXL.L  D0,D0
    NEG.L D0
    MOVEM.L (A7)+,D1-D7/A1-A6
    RTS    
-> End of function sub_486F0
ENDPROC
-> ---------------------------------------------------------------------------

PROC loadHistory()
  DEF fh,i
  DEF fname[255]:STRING
  DEF tempstr[255]:STRING
  DEF msg

  StringF(fname,'\shistory\d',historyFolder,loggedOnUser.slotNumber)
  IF(fh:=Open(fname,MODE_OLDFILE))>0
    ReadStr(fh,tempstr)
    historyNum:=Val(tempstr)
    ReadStr(fh,tempstr)
    historyCycle:=Val(tempstr)

    FOR i:=0 TO ListLen(historyBuf)-1
      DisposeLink(ListItem(historyBuf,i))
    ENDFOR
    SetList(historyBuf,0)

    WHILE(ReadStr(fh,tempstr)<>-1) OR (StrLen(tempstr)>0)
      msg:=String(255)
      StrCopy(msg,tempstr)

      ListAdd(historyBuf,[msg])
    ENDWHILE
    Close(fh)
  ENDIF
ENDPROC

PROC saveHistory()
  DEF fh,i,lock
  DEF fname[255]:STRING
  DEF tempstr[255]:STRING

  IF(lock:=CreateDir(historyFolder))
    UnLock(lock)
  ENDIF
  
  StringF(fname,'\shistory\d',historyFolder,loggedOnUser.slotNumber)
  IF(fh:=Open(fname,MODE_NEWFILE))>0
    StringF(tempstr,'\d',historyNum)
    fileWriteLn(fh,tempstr)
    StringF(tempstr,'\d',historyCycle)
    fileWriteLn(fh,tempstr)
    FOR i:=0 TO ListLen(historyBuf)-1
      fileWriteLn(fh,historyBuf[i])
    ENDFOR
    Close(fh)
  ENDIF
ENDPROC

PROC loadFlagged()
  DEF fh
  DEF fname[255]:STRING

  IF ownPartFiles
    StringF(fname,'\sPartdownload/dump\d-\d',cmds.bbsLoc,node,loggedOnUser.slotNumber)
  ELSE
    StringF(fname,'\sPartdownload/dump\d',cmds.bbsLoc,loggedOnUser.slotNumber)
  ENDIF  

  IF (fh:=Open(fname,MODE_OLDFILE))>0
      ReadStr(fh,flaglist)
      Close(fh)
  ENDIF

  IF StrLen(flaglist)>0
    aePuts('\b\n** Flagged File(s) Exist **\b\n')
    sendBELL()
  ENDIF

ENDPROC

PROC saveFlagged()
  DEF fh
  DEF fname[255]:STRING

  aePuts('\b\n** AutoSaving File Flags **\b\n')
  sendBELL()
  
  IF(StrLen(flaglist))
    IF ownPartFiles
      StringF(fname,'\sPartdownload/dump\d-\d',cmds.bbsLoc,node,loggedOnUser.slotNumber)
    ELSE
      StringF(fname,'\sPartdownload/dump\d',cmds.bbsLoc,loggedOnUser.slotNumber)
    ENDIF
  
    IF(fh:=Open(fname,MODE_NEWFILE))>0
      Write(fh,flaglist,StrLen(flaglist))
      Close(fh)
    ENDIF
  ENDIF
ENDPROC

PROC readIntFromFile(filename: PTR TO CHAR)
  DEF fh
  DEF v[100]:STRING
  IF((fh:=Open(filename,MODE_OLDFILE)))>0
    ReadStr(fh,v)
    Close(fh)
    RETURN Val(v)
  ENDIF
ENDPROC -1

PROC writeIntToFile(filename: PTR TO CHAR, v: LONG)
  DEF fh
  DEF vStr[100]:STRING
  IF((fh:=Open(filename,MODE_NEWFILE)))>0
    StringF(vStr,'\d',v)
    fileWriteLn(fh,vStr)
    Close(fh)
    RETURN RESULT_SUCCESS
  ENDIF
ENDPROC RESULT_FAILURE

PROC getCallerCount()
  DEF tempStr[255]:STRING
  StringF(tempStr,'\sSystemStats',cmds.bbsLoc)
ENDPROC readIntFromFile(tempStr)

PROC updateCallerNum()
  DEF tempStr[255]:STRING
  StringF(tempStr,'\sSystemStats',cmds.bbsLoc)
  callerNum:=readIntFromFile(tempStr)
  callerNum++
  writeIntToFile(tempStr,callerNum)
ENDPROC

PROC clearUser()
  DEF tempStr[255]:STRING
  StringF(tempStr,'\snode\d.user',cmds.bbsLoc,node)
  SetProtection(tempStr,FIBF_OTR_DELETE)
  DeleteFile(tempStr)

  StringF(tempStr,'\snode\d.userkeys',cmds.bbsLoc,node)
  SetProtection(tempStr,FIBF_OTR_DELETE)
  DeleteFile(tempStr)
ENDPROC

PROC dumpActiveUser(filename: PTR TO CHAR)
  DEF fi
  fi:=Open(filename,MODE_NEWFILE)
  Write(fi,loggedOnUser,SIZEOF user)
  Close(fi)
ENDPROC


PROC checkUserOnLine(user: PTR TO user, check)
  DEF fh,lock
  DEF temp[10]:STRING 
  DEF error=0,stat,loop
  DEF tempStr[255]:STRING
  DEF tuser:user
 
  IF(check)
 	    ->IF(tuser=(struct User *)AllocMem(sizeof(struct User),MEMF_ANY|MEMF_CLEAR))	{
 		    loop:=0
 		    error:=1
 		    REPEAT
 			    IF(loop=node)	THEN loop++
 
 			    StringF(tempStr,'\snode\d',cmds.bbsLoc,loop)
 			    IF(lock:=Lock(tempStr,ACCESS_READ)) 
 				    UnLock(lock)
 				    StringF(tempStr,'\snode\d.user',cmds.bbsLoc,loop)
 				    IF(fh:=Open(tempStr,MODE_OLDFILE))>0 
 					    IF(stat:=Read(fh,tuser,SIZEOF user)) 
 						    IF(stringCompare(tuser.name,loggedOnUser.name)=RESULT_SUCCESS)
 							    error:=0
 							    lock:=NIL
                ENDIF
 							ENDIF
 						ENDIF
 					  Close(fh)
 					ENDIF
 			  loop++
 			  UNTIL lock=NIL
 		  ->  FreeMem(tuser,sizeof(struct User))
 		->} else	AEPutStr("Can't allocate memory for user test\b\n")
 	ELSE
    error:=1
  ENDIF
 
  IF(error)
 	  error:=0
      /* Write the current user info to Node%d.user */
 
 	  StringF(tempStr,'\snode\d.user',cmds.bbsLoc,node)
 	  IF(fh:=Open(tempStr,MODE_NEWFILE))>0
 		  IF(stat:=Write(fh,loggedOnUser,SIZEOF user)) THEN error:=1
 		ENDIF
    Close(fh)
      /* Write current userkeys information */
      ->//(RTS)
 	  StringF(tempStr,'\snode\d.userkeys',cmds.bbsLoc,node) /* file name */
 	  IF(fh:=Open(tempStr,MODE_NEWFILE))>0
 		  IF(stat:=Write(fh,loggedOnUserKeys,SIZEOF userKeys)) THEN error:=1
    ENDIF
    Close(fh)
 ->//     printf("logon.c (79) User_keys.Userflags = %2x\b\n",User_keys.Userflags)
 	ENDIF

ENDPROC error


PROC getNodeFile(toolType,tooltypeSelector,nodeFile)
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF i,p

  SELECT toolType
    CASE TOOLTYPE_NODE
      -> tooltypeSector is node number
      StringF(nodeFile,'\sNode\d',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_WINDOW
      -> tooltypeSector is node number
      StringF(nodeFile,'\sNode\d/WINDOW.DEF',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_CONFCONFIG
      -> tooltypeSector is not used
      StringF(nodeFile,'\sConfconfig',cmds.bbsLoc)
    CASE TOOLTYPE_BBSCONFIG
      -> tooltypeSector is not used
      StringF(nodeFile,'\sbbsConfig',cmds.bbsLoc)
    CASE TOOLTYPE_NAMESNOTALLOWED
      -> tooltypeSector is not used
      StringF(nodeFile,'\sNamesNotAllowed',cmds.bbsLoc)
    CASE TOOLTYPE_CONF
      -> tooltypeSector is conf number
      ->get conf location
      StringF(tempStr,'LOCATION.\d',tooltypeSelector)
      readToolType(TOOLTYPE_CONFCONFIG,'',tempStr,tempStr2)
      IF tempStr2[StrLen(tempStr2)-1]="/" THEN SetStr(tempStr2,StrLen(tempStr2)-1)
      StringF(nodeFile,'\s',tempStr2)
    CASE TOOLTYPE_BBSCMD
      -> tooltypeSector is command name string
      StringF(nodeFile,'\sCommands/BBSCmd/\s',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_CONFCMD
      -> tooltypeSector is command name string
      StringF(nodeFile,'\sCommands/Conf\dCmd/\s',cmds.bbsLoc,currentConf,tooltypeSelector)
    CASE TOOLTYPE_NODECMD
      -> tooltypeSector is command name string
      StringF(nodeFile,'\sCommands/Node\dCmd/\s',cmds.bbsLoc,node,tooltypeSelector)
    CASE TOOLTYPE_SYSCMD
      -> tooltypeSector is command name string
      StringF(nodeFile,'\sCommands/SYSCmd/\s',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_DRIVES
      -> tooltypeSector is not used
      StringF(nodeFile,'\sDrives',cmds.bbsLoc)
    CASE TOOLTYPE_COMPUTERLIST
      -> tooltypeSector is not used
      StringF(nodeFile,'\sComputerList',cmds.bbsLoc)
    CASE TOOLTYPE_ACCESS
      -> tooltypeSector is access level number
      StringF(nodeFile,'\sAccess/ACS.\d',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_AREA
      -> tooltypeSector is access area name
      StringF(nodeFile,'\sAccess/AREA.\s',cmds.bbsLoc,tooltypeSelector)   
    CASE TOOLTYPE_PRESET
      -> tooltypeSector is preset level number
      StringF(nodeFile,'\sAccess/PRESET.\d',cmds.bbsLoc,tooltypeSelector)   
    CASE TOOLTYPE_FCHECK
      -> tooltypeSector is file type
      StringF(nodeFile,'\sFCheck/\s',cmds.bbsLoc,tooltypeSelector)    
    CASE TOOLTYPE_NODE_WINDOW
      -> tooltypeSector is node number
      StringF(nodeFile,'\sNode\d/WINDOW.DEF',cmds.bbsLoc,tooltypeSelector)        
    CASE TOOLTYPE_NODE_TIMES
      -> tooltypeSector is node number
      StringF(nodeFile,'\sNode\d/TIMES.DEF',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_CONNECT
      -> tooltypeSector is node number
      StringF(nodeFile,'\sNode\d/Connect.Def',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_XPRTYPES
      -> tooltypeSector is not used
      StringF(nodeFile,'\sProtocols/XprTypes',cmds.bbsLoc)
    CASE TOOLTYPE_XFERLIB
      -> tooltypeSector is xpr lib number
      StringF(nodeFile,'\sProtocols/\s',cmds.bbsLoc,xprLib[tooltypeSelector])
    CASE TOOLTYPE_SCREENTYPES
      -> tooltypeSector is not used
      StringF(nodeFile,'\sScreenTypes',cmds.bbsLoc)
    CASE TOOLTYPE_NRAMS
      -> tooltypeSector is node, 
      StringF(tempStr,'\sNode\d/NRAMS',cmds.bbsLoc,tooltypeSelector)
      IF findFirst(tempStr,tempStr2)
        p:=-1
        FOR i:=0 TO StrLen(tempStr2)-1
          IF tempStr2[i]="." THEN p:=i
        ENDFOR
        IF (p>=0)
          SetStr(tempStr2,p)
        ENDIF
        StringF(nodeFile,'\s/\s',tempStr,tempStr2)
      ELSE
        StrCopy(nodeFile,'')
      ENDIF   
  ENDSELECT
ENDPROC

PROC findFirst(path: PTR TO CHAR,buf: PTR TO CHAR)
  DEF pdir: PTR TO filelock
  DEF dir_info: PTR TO fileinfoblock
  DEF returnval=0

  IF ((dir_info:=(AllocDosObject(DOS_FIB,NIL)))=NIL)
    Delay(300)
    RETURN 0
  ENDIF
  
  IF((pdir:=(Lock(path,ACCESS_READ)))=FALSE)
    UnLock(pdir)
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF

  IF(Examine(pdir,dir_info))=FALSE
    UnLock(pdir)
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF

  IF(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0 )
      returnval:=1
      StrCopy(buf,dir_info.filename)
    ENDIF
  ENDIF
  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)
ENDPROC returnval

PROC findAcsLevel()
  DEF ttfile[255]:STRING,do,level
  level:=loggedOnUser.secStatus/5*5
  REPEAT
    getNodeFile(TOOLTYPE_ACCESS,level,ttfile)
    do:=GetDiskObject(ttfile)
    IF (do) THEN FreeDiskObject(do) ELSE level:=level-5
  UNTIL (level=0) OR (do)
  
  IF (do=NIL) THEN level:=-1
ENDPROC level

PROC higherAccess()
  aePuts('\b\nCommand requires higher access.\b\n')
ENDPROC

PROC readToolType(toolType,tooltypeSelector,key,outValue)
  DEF nodeFile[255]:STRING
  DEF do: PTR TO diskobject
  DEF tooltypes
  DEF s: PTR TO CHAR
  
  s:=NIL
  getNodeFile(toolType,tooltypeSelector,nodeFile)
  
  do:=GetDiskObject(nodeFile)
  IF (do)
    tooltypes:=do.tooltypes
      IF (s:=FindToolType(tooltypes,key)) THEN StrCopy(outValue,s,ALL)
    FreeDiskObject(do)
  ENDIF
ENDPROC s<>NIL

PROC readToolTypeInt(toolType,tooltypeSelector,key)
  DEF value[255]:STRING
  IF readToolType(toolType,tooltypeSelector,key,value)
    RETURN Val(value)
  ENDIF

ENDPROC -1

PROC checkToolType(toolType,tooltypeSelector,key,testValue)
  DEF nodeFile[255]:STRING
  DEF do: diskobject
  DEF tooltypes
  DEF s: PTR TO CHAR
  DEF result=FALSE
  
  s:=NIL

  getNodeFile(toolType,tooltypeSelector,nodeFile)
    
  do:=GetDiskObject(nodeFile)
  IF (do)
    tooltypes:=do.tooltypes
      IF(s:=FindToolType(tooltypes,key))
      IF (MatchToolValue(s,testValue)) THEN result:=TRUE
    ENDIF
    FreeDiskObject(do)
  ENDIF
ENDPROC result

PROC checkToolTypeExists(toolType,tooltypeSelector,key)
  DEF nodeFile[255]:STRING
  DEF do: diskobject
  DEF tooltypes
  DEF s: PTR TO CHAR
  DEF result=FALSE
  
  s:=NIL

  getNodeFile(toolType,tooltypeSelector,nodeFile)

  do:=GetDiskObject(nodeFile)
  IF (do)
    tooltypes:=do.tooltypes
    IF(s:=FindToolType(tooltypes,key)) THEN result:=TRUE
    FreeDiskObject(do)
  ENDIF
ENDPROC result

PROC runDoor(cmd,type,command,params,pri=0,stacksize=20000)
  DEF doorPort[12]:STRING
  DEF mp: PTR TO mp
  DEF exestring[100]:STRING
  DEF ximSig,signals
  DEF msg: PTR TO jhMessage
  DEF charptr: PTR TO CHAR
  DEF temp
  DEF async,ch
  DEF i,f
  DEF nodes = 0,msgcmd
  DEF tempstring[255]:STRING
  DEF tempstring2[255]:STRING
  DEF runOnExit[255]:STRING
  DEF exit=0
  DEF alreadyActive=FALSE
  DEF tuserdata:PTR TO user,tuserkeys:PTR TO userKeys, tusermisc: PTR TO userMisc
  DEF filetags

  StringF(tempstring,'run door: \s',cmd)
  debugLog(LOG_DEBUG,tempstring)

  StrCopy(runOnExit,'')

  IF (fileExists(cmd)=FALSE)
    aePuts('\b\nError, can''t locate Custom Command\b\n')
    aePuts('or Command is in use\b\n')
    RETURN
  ENDIF

  StringF(doorPort,'\s\d','AEDoorPort',node)
  IF (mp:=FindPort(doorPort))
    alreadyActive:=TRUE
  ELSE
    mp:=createPort(doorPort,0)
  ENDIF

  ximSig:=Shl(1,mp.sigbit)

  SELECT type
  CASE DOORTYPE_AIM
    StringF(exestring,'\sUtils/REXXDOOR \d \s',cmds.bbsLoc,node,cmd)
    async:=TRUE
  CASE DOORTYPE_XIM
    StringF(exestring,'\s \d',cmd,node)
    async:=TRUE
  CASE DOORTYPE_SIM
    StringF(exestring,'\s \d',cmd,node)
    async:=FALSE
  DEFAULT
    StringF(exestring,'\s \d',cmd,node)
    async:=FALSE
  ENDSELECT

  doorLog(type,cmd)

  filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,async,NP_STACKSIZE,stacksize,NP_PRIORITY,pri,0]

  temp:=SystemTagList(exestring,filetags)
  END filetags

  IF ((temp=-1) OR (async=FALSE))
    IF alreadyActive=FALSE THEN deletePort(mp)
    doorLog(type,'')
    RETURN
  ENDIF

  WHILE(exit=FALSE)
    signals:=Wait(ximSig)
    WHILE(msg:=GetMsg(mp))
      msgcmd:=msg.command
    
    stripAnsi(msg.string,tempstring,0,0)
    
    StringF(tempstring,'msg request: \d',msgcmd)
    debugLog(LOG_DEBUG,tempstring)
    StringF(tempstring,'data: \d',msg.data)
    debugLog(LOG_DEBUG,tempstring)
    StringF(tempstring,'string: \s',msg.string)
    debugLog(LOG_DEBUG,tempstring)
      IF(msgcmd<>ACP_COMMAND) THEN msg.lineNum:=0
      SELECT msgcmd
        CASE JH_REGISTER
            msg.command:=IF loggedOnUser<>NIL THEN loggedOnUser.lineLength ELSE 29
            nodes:=nodes+1  
        CASE JH_WRITE
          aePuts(msg.string)
        CASE CHAIN
            nodes:=nodes-1
        CASE JH_SHUTDOWN
            nodes:=nodes-1           
             IF(nodes=0)           
                rawArrow:=FALSE
                exit:=TRUE
             ENDIF
        CASE JH_CO
          conPuts(msg.string,-1)
          IF msg.data
            conPuts('\b\n',-1)
            checkForPause()
          ENDIF
        CASE JH_SO
          serPuts(msg.string,-1)
          IF msg.data
            serPuts('\b\n',-1)
          ENDIF
        CASE JH_SM
          aePuts(msg.string)
          IF msg.data
            aePuts('\b\n')
            checkForPause()
          ENDIF
        CASE JH_SMPTR
          aePuts(msg.strptr)
          IF msg.data
            aePuts('\b\n')
            checkForPause()
          ENDIF
        CASE JH_PM
          IF(lineInput(msg.string,'',msg.data,doorTimeout,tempstring)<>RESULT_SUCCESS)
            msg.data:=-1
          ELSE
            msg.data:=1
            strCpy(msg.string,tempstring,200)
          ENDIF
        CASE JH_LI
          IF(lineInput('',msg.string,msg.data,doorTimeout,tempstring)<>RESULT_SUCCESS)
            msg.data:=-1
          ELSE
            msg.data:=1
            strCpy(msg.string,tempstring,200)
          ENDIF
        CASE JH_ExtHK
            lineCount:=0
            msg.command:=readChar(doorTimeout,Shl(1,msg.signal))
            IF (msg.command<0) THEN msg.data:=-1 ELSE msg.data:=1
        CASE JH_HK
          lineCount:=0
          aePuts(msg.string)
          ch:=readChar(doorTimeout)
          IF (ch<0)
            msg.data:=-1
          ELSE
            msg.data:=1
          ENDIF
          msg.string[0]:=ch
          msg.string[1]:=0
          msg.command:=ximPort /*XIMPort=1 for console,2for serial  */
        CASE JH_MCI
          StrCopy(tempstring,msg.string)
          processMci(tempstring)
          IF msg.data
            aePuts('\b\n')
            checkForPause()
          ENDIF
        CASE JH_SIGBIT
          msg.data:=doorExtSig
        CASE JH_FetchKey
          IF checkCon()
            msg.command:=readChar(doorTimeout)
            IF (msg.command<0)  THEN msg.data:=-1 ELSE msg.data:=1
          ENDIF
        CASE JH_SG
          IF (findSecurityScreen(msg.string,tempstring)) THEN displayFile(tempstring)
        CASE JH_SF
          displayFile(msg.string)
        CASE JH_EF
          fileattach:=FALSE
          loadMsg(msg.string)
          IF(edit()=RESULT_SUCCESS)
            saveMsg(msg.string)
            msg.data:=1
          ELSE
            msg.data:=-1
          ENDIF 
        CASE JH_BBSNAME
          strCpy(msg.string,cmds.bbsName,41)
        CASE JH_SYSOP
          strCpy(msg.string,cmds.sysopName,41)
        CASE JH_FLAGFILE
           addFlagtoList(msg.string)
        CASE RETURNCOMMAND
          StrCopy(runOnExit,msg.string,200)
        CASE RETURNCOMMAND2
          StrCopy(runOnExit,msg.string,200)
        CASE DT_NAME
          IF (msg.data)
            strCpy(msg.string,loggedOnUser.name,31)
          ELSE
            strCpy(loggedOnUser.name,msg.string,31)
          ENDIF
        CASE DT_PASSWORD
          IF (msg.data)
            ->we dont allow doors to grab the password
            strCpy(msg.string,'',ALL)
          ELSE
            ->calculate the new password hash
            StrCopy(tempstring,msg.string)
            UpperStr(tempstring)
            loggedOnUser.pwdHash:=calcPasswordHash(tempstring)
          ENDIF
        CASE DT_LOCATION
          IF (msg.data)
            strCpy(msg.string,loggedOnUser.location,30)
          ELSE
            strCpy(loggedOnUser.location,msg.string,30)
          ENDIF
        CASE DT_PHONENUMBER
          IF (msg.data)
            strCpy(msg.string,loggedOnUser.phoneNumber,13)
          ELSE
            strCpy(loggedOnUser.phoneNumber,msg.string,13)
          ENDIF
        CASE DT_SLOTNUMBER
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.slotNumber)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.slotNumber:=Val(msg.string)
          ENDIF
        CASE DT_SECSTATUS
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.secStatus)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.secStatus:=Val(msg.string)
            convertAccess()
          ENDIF
        CASE DT_SECBOARD
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.secBoard)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.secBoard:=Val(msg.string)
          ENDIF
        CASE DT_SECLIBRARY
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.secLibrary)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.secLibrary:=Val(msg.string)
          ENDIF
        CASE DT_SECBULLETIN
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.secBulletin)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.secBulletin:=Val(msg.string)
          ENDIF
        CASE DT_MESSAGESPOSTED
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.messagesPosted AND $FFFF)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.messagesPosted:=Val(msg.string)
          ENDIF
        CASE DT_UPLOADS
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.uploads AND $FFFF)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.uploads:=Val(msg.string)
          ENDIF
        CASE DT_DOWNLOADS
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.downloads AND $FFFF)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.downloads:=Val(msg.string)
          ENDIF
        CASE DT_TIMESCALLED
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.timesCalled AND $FFFF)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.timesCalled:=Val(msg.string)
          ENDIF
        CASE DT_TIMELASTON
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.timeLastOn)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.timeLastOn:=Val(msg.string)
          ENDIF
        CASE DT_TIMEUSED
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.timeUsed)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.timeUsed:=Val(msg.string)
          ENDIF
        CASE DT_TIMELIMIT 
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.timeLimit)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.timeLimit:=Val(msg.string)
          ENDIF
        CASE DT_TIMETOTAL
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.timeTotal)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.timeTotal:=Val(msg.string)
          ENDIF
        CASE DT_BYTESUPLOAD
          IF (msg.data)
            formatUnsignedLong(loggedOnUser.bytesUpload,tempstring)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.bytesUpload:=Val(msg.string)
          ENDIF
        CASE DT_BYTEDOWNLOAD
          IF (msg.data)
            formatUnsignedLong(loggedOnUser.bytesDownload,tempstring)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.bytesDownload:=Val(msg.string)
          ENDIF
        CASE DT_DAILYBYTELIMIT
          IF (msg.data)
            formatUnsignedLong(loggedOnUser.dailyBytesLimit,tempstring)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.dailyBytesLimit:=Val(msg.string)
          ENDIF
        CASE DT_DAILYBYTEDLD
          IF (msg.data)
            formatUnsignedLong(loggedOnUser.dailyBytesDld,tempstring)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.dailyBytesDld:=Val(msg.string)
          ENDIF
        CASE DT_EXPERT 
          IF (msg.data)
            StringF(tempstring,'\c',loggedOnUser.expert)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.expert:=msg.string[0]
          ENDIF
        CASE DT_LINELENGTH
          IF (msg.data)
            StringF(tempstring,'\d',loggedOnUser.lineLength)
            strCpy(msg.string,tempstring,200)
          ELSE
            loggedOnUser.lineLength:=Val(msg.string)
          ENDIF
        CASE ACTIVE_NODES
            strCpy(msg.string,'          ',ALL)
            IF(FindPort('AmiExpress_Node.0')) THEN msg.string[0]:="X"
            IF(FindPort('AmiExpress_Node.1')) THEN msg.string[1]:="X"
            IF(FindPort('AmiExpress_Node.2')) THEN msg.string[2]:="X"
            IF(FindPort('AmiExpress_Node.3')) THEN msg.string[3]:="X"
            IF(FindPort('AmiExpress_Node.4')) THEN msg.string[4]:="X"
            IF(FindPort('AmiExpress_Node.5')) THEN msg.string[5]:="X"
            IF(FindPort('AmiExpress_Node.6')) THEN msg.string[6]:="X"
            IF(FindPort('AmiExpress_Node.7')) THEN msg.string[7]:="X"
            IF(FindPort('AmiExpress_Node.8')) THEN msg.string[8]:="X"
            IF(FindPort('AmiExpress_Node.9')) THEN msg.string[9]:="X"
        CASE DT_DUMP
          dumpActiveUser(msg.string)
        CASE DT_MSGCODE
          IF(msg.data=1 )
            doormsgcode:=1
          ELSEIF (msg.data=2)
            doormsgcode:=0
          ELSE
            msg.data:=doormsgcode
          ENDIF
        CASE ENVSTAT 
            IF(msg.data)
              StringF(tempstring,'\d',currentStat)
              strCpy(msg.string,tempstring,10)
            ELSE
              setEnvStat(Val(msg.string))
            ENDIF
        CASE SV_NEWMSG
          setEnvMsg(msg.string)
        CASE DT_TIMEOUT
          IF (msg.data)
            StringF(tempstring,'\d',doorTimeout)
            strCpy(msg.string,tempstring,200)
          ELSE
            doorTimeout:=Val(msg.string)
          ENDIF
        CASE BB_CONFNAME
          IF (msg.data)
            StringF(tempstring,'\s',currentConfName)
            strCpy(msg.string,tempstring,200)
          ELSE
            StrCopy(currentConfName,msg.string)
            setConfName(loggedOnUser.confRJoin-1,msg.string)
          ENDIF
        CASE BB_CONFLOCAL
          IF (msg.data)
            StringF(tempstring,'\s',currentConfDir)
            strCpy(msg.string,tempstring,200)
          ELSE
            setConfLocation(loggedOnUser.confRJoin-1,msg.string)
          ENDIF
        CASE BB_LOCAL
          StringF(tempstring,'\s',cmds.bbsLoc)
          strCpy(msg.string,tempstring,200)
        CASE ZMODEMSEND
            dTBT:=0
            tBT:=0  
            tTTM:=NIL
            tTEFF:=NIL
            tTCPS:=NIL
            StrCopy(tempstring,msg.string)
            ch:=downloadFile(tempstring)
            IF((logonType>=LOGON_TYPE_REMOTE) AND (checkCarrier()=FALSE)) THEN msg.data:=-2 ELSE msg.data:=ch
        CASE BATCHZMODEMSEND
            dTBT:=0
            tBT:=0
            tTTM:=NIL
            tTEFF:=NIL
            tTCPS:=NIL
            ch:=downloadFile(msg.filler1)
            IF((logonType>=LOGON_TYPE_REMOTE) AND (checkCarrier()=FALSE)) THEN msg.data:=-2 ELSE msg.data:=ch
        CASE ZMODEMRECEIVE
            dTBT:=0
            tBT:=0
            tTTM:=NIL
            tTEFF:=NIL
            tTCPS:=NIL
            StrCopy(tempstring,msg.string);
            ch:=zmodemReceive(tempstring,1); 
            IF((logonType>=LOGON_TYPE_REMOTE) AND (checkCarrier()=FALSE)) THEN msg.data:=-2 ELSE msg.data:=ch
        CASE SCREEN_ADDRESS 
            StringF(tempstring,'\z\h[8]',screen)
            LowerStr(tempstring)
            strCpy(msg.string,tempstring,200)
        CASE BB_TASKPRI
          StringF(tempstring,'\c',cmds.taskPri)
          strCpy(msg.string,tempstring,200)
        CASE RAWSCREEN_ADDRESS
          StringF(tempstring,'\d',screen)
          strCpy(msg.string,tempstring,200)
        CASE BB_CHATFLAG 
          IF sysopAvail
            strCpy(msg.string,'YES',ALL)
          ELSE
            strCpy(msg.string,'NO',ALL)
          ENDIF
        CASE BB_CHATSET
          IF msg.data
            StringF(tempstring,'\d',pagedFlag)
            strCpy(msg.string,tempstring,200)
          ELSE
            temp:=pagedFlag
            pagedFlag:=Val(msg.string)

            IF pagedFlag AND Not(temp)
              IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ON_SYSOP_PAGE',tempstring))
                filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,NIL]:LONG
                processMci2(tempstring,tempstring2)
                SystemTagList(tempstring2,filetags)
                END filetags
              ENDIF
              IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ASYNC_ON_SYSOP_PAGE',tempstring))
                filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,TRUE,NIL]:LONG
                processMci2(tempstring,tempstring2)
                SystemTagList(tempstring2,filetags)
                END filetags
              ENDIF
              IF(checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_SYSOP_PAGE')) AND (StrLen(mailOptions.sysopEmail)>0)
                StringF(tempstring,'\s: Ami-Express page notification',cmds.bbsName)
                StringF(tempstring2,'This is a notification that you were paged by \s.',loggedOnUser.name)
                sendMail(tempstring,tempstring2,FALSE,mailOptions.sysopEmail)
              ENDIF
            ENDIF
          ENDIF
        CASE DT_STAMP_LASTON
          formatLongDateTime(loggedOnUser.timeLastOn,msg.string)
        CASE DT_CURR_TIME
            StringF(tempstring,'\d',getSystemTime())
            strCpy(msg.string,tempstring,200)
        CASE DT_STAMP_CTIME
          formatLongDateTime(getSystemTime(),msg.string)
        CASE DT_CONFACCESS
            IF(msg.data) THEN strCpy(msg.string,loggedOnUser.conferenceAccess,10) ELSE strCpy(loggedOnUser.conferenceAccess,msg.string,10)
        CASE BB_PCONFNAME
            temp:=Val(msg.string)
            IF((temp<1) OR (temp>9))
              strCpy(msg.string,'ERROR',10)
            ELSE
              strCpy(msg.string,getConfName(temp),200)
            ENDIF
        CASE BB_PCONFLOCAL
            temp:=Val(msg.string)
            IF((temp<1) OR (temp>9))
              strCpy(msg.string,'ERROR',10)
            ELSE
              getConfLocation(temp,tempstring)
              strCpy(msg.string,tempstring,200)
            ENDIF
        CASE BB_MAINLINE
          IF StrLen(params)>0
            StringF(tempstring,'\s \s',command,params)
          ELSE
            StringF(tempstring,'\s',command)
          ENDIF
          strCpy(msg.string,tempstring,200)
        CASE BB_NODEID
          StringF(tempstring,'\d',node)
          strCpy(msg.string,tempstring,200)
        CASE BB_CALLERSLOG
          callersLog(msg.string,FALSE)
        CASE BB_UDLOG
          udLog(msg.string)
        CASE EXPRESS_VERSION
            IF (expressVer[0]="v") OR (expressVer[0]="V") THEN i:=1 ELSE i:=0
            IF ((temp:=InStr(expressVer,'.'))>=0)
              StringF(tempstring,'v\d.\d',Val(expressVer+i),Val(expressVer+temp+1))
            ELSE
              StringF(tempstring,'v\d',Val(expressVer+i))
            ENDIF
            strCpy(msg.string,tempstring,200)
        CASE GETKEY
          IF(checkSer() OR checkCon()) THEN msg.string[0]:="1" ELSE msg.string[0]:="0"
          msg.string[1]:=0
        CASE RAWARROW
          IF(rawArrow) THEN rawArrow:=FALSE ELSE rawArrow:=TRUE
        CASE PRV_COMMAND
          StrCopy(tempstring,msg.string)
          processCommand(tempstring)
        CASE PRV_GROUP
          StrCopy(tempstring,msg.string)
            temp:=Val(tempstring)
            strCpy(cmds.conf1Loc+(temp*54),tempstring+40,54)
            IF(temp=(currentConf-1)) THEN StrCopy(currentConfDir,tempstring+40)
            tempstring[39]:=0
            stripReturn(tempstring)
            strCpy(cmds.conf1Name+(temp*54),tempstring+2,54)
            IF(temp=(currentConf-1)) THEN StrCopy(currentConfName,tempstring+2)
        CASE BB_CONFNUM
          StringF(tempstring,'\d',currentConf-1)
          strCpy(msg.string,tempstring,200)
        CASE BB_DROPDTR
          modemOffHook()
        CASE BB_GETTASK
          msg.task:=FindTask(0)
        CASE NODE_BAUD
          StringF(tempstring,'\d',onlineBaud)
          strCpy(msg.string,tempstring,10)
        CASE NODE_BAUDRATE
          StringF(tempstring,'\d',onlineBaudR)
          strCpy(msg.string,tempstring,10)
        CASE NODE_DEVICE
          strCpy(msg.string,cmds.serDev,ALL)
        CASE NODE_UNIT
          StringF(tempstring,'\d',cmds.serDevUnit)
          strCpy(msg.string,tempstring,10)
        CASE DT_ADDBIT
            setTempSecurityFlags(msg.data)
        CASE DT_REMBIT
            clearTempSecurityFlags(msg.data)
        CASE DT_QUERYBIT
            msg.command:=extCheckSecurity(msg.data)
        CASE BB_LOGONTYPE
            msg.data:=logonType
        CASE BB_SCRLEFT
            msg.data:=screen.leftedge
        CASE BB_SCRTOP
            msg.data:=screen.topedge
        CASE BB_SCRWIDTH
            msg.data:=screen.width
        CASE BB_SCRHEIGHT
            msg.data:=screen.height
        CASE BB_PURGELINE
            purgeLine()
        CASE BB_PURGELINESTART
            purgeLineStart()
        CASE BB_PURGELINEEND
            purgeLineEnd()
        CASE BB_NONSTOPTEXT
          IF (msg.data=0) THEN nonStopDisplayFlag:=FALSE ELSE nonStopDisplayFlag:=TRUE
        CASE BB_LINECOUNT
          IF(msg.data)
            StringF(tempstring,'\d',lineCount)
            strCpy(msg.string,tempstring,200)
          ELSE
            lineCount:=Val(msg.string)
          ENDIF
        CASE DT_LANGUAGE
          IF msg.data
            IF loggedOnUser<>NIL 
              IF (loggedOnUser.screenType<ListLen(screenTypeExt))
                strCpy(msg.string,ListItem(screenTypeExt,loggedOnUser.screenType),200)
              ENDIF
            ENDIF
          ELSE
            debugLog(LOG_WARN,'DT_LANGUAGE set yet implemented')
          ENDIF
        
        CASE DT_QUICKFLAG
          quickFlag:=msg.data
        CASE DT_GOODFILE
          aeGoodFile:=msg.data
        CASE DT_ANSICOLOR
            IF msg.data THEN ansiColour:=TRUE ELSE ansiColour:=FALSE
        CASE DT_ISANSI
            IF ansiColour THEN msg.data:=1 ELSE msg.data:=0
        CASE MULTICOM
            msg.semi:=masterNode
        CASE LOAD_ACCOUNT
            msg.nodeID:=0;
            tuserdata:=msg.filler1
            tuserkeys:=msg.filler2
            IF (msg.msg.length>=SIZEOF jhMessage)
              tusermisc:=msg.filler3
            ELSE
              tusermisc:=NIL
            ENDIF
            IF(loggedOnUser.slotNumber=msg.data)
              saveMsgPointers(currentConf) ->AddMsgPointers(); 
              IF tuserdata<>NIL THEN CopyMem(loggedOnUser,tuserdata,SIZEOF user);
              IF tuserkeys<>NIL THEN CopyMem(loggedOnUserKeys,tuserkeys,SIZEOF userKeys)
              IF tusermisc<>NIL THEN CopyMem(loggedOnUserKeys,tusermisc,SIZEOF userMisc)
              loadMsgPointers(currentConf)
              msg.nodeID:=1;
            ELSE
              IF(loadAccount(msg.data,tuserdata,tuserkeys,tusermisc)<>RESULT_FAILURE) THEN msg.nodeID:=1; 
            ENDIF
            msg.data:=msg.nodeID
        CASE SEARCH_ACCOUNT
            IF(findUserFromNumber(msg.data,msg.filler1)) THEN msg.data:=1 ELSE msg.data:=0
        CASE APPEND_ACCOUNT
            
            tuserdata:=msg.filler1
            tuserkeys:=msg.filler2
            IF (msg.msg.length>=SIZEOF jhMessage)
              tusermisc:=msg.filler3
            ELSE
              tusermisc:=NIL
            ENDIF
            findOpenAccount(tuserdata,tuserkeys,tusermisc)
        CASE LAST_ACCOUNTNUM
            msg.data:=findLastAccount()
        CASE SAVE_ACCOUNT
           tuserdata:=msg.filler1
           tuserkeys:=msg.filler2
           IF (msg.msg.length>=SIZEOF jhMessage)
             tusermisc:=msg.filler3
           ELSE
             tusermisc:=NIL
           ENDIF
           IF(tuserdata.slotNumber=0)
             tuserkeys.number:=0;
             saveAccount(tuserdata,tuserkeys,tusermisc,msg.data,1)
           ELSE
             saveAccount(tuserdata,tuserkeys,tusermisc,0,0)
           ENDIF

           IF(loggedOnUser.slotNumber=msg.data)
             i:=0;
             IF((loggedOnUser.secStatus<>tuserdata.secStatus) OR (strCmpi(loggedOnUser.conferenceAccess,tuserdata.conferenceAccess,ALL))) THEN i:=1
             IF tuserdata<>NIL THEN CopyMem(tuserdata,loggedOnUser,SIZEOF user)
             IF tuserkeys<>NIL THEN CopyMem(tuserkeys,loggedOnUserKeys,SIZEOF userKeys)
             IF tusermisc<>NIL THEN CopyMem(tusermisc,loggedOnUserMisc,SIZEOF userMisc)
             timeLimit:=loggedOnUser.timeTotal-loggedOnUser.timeUsed
             loadMsgPointers(currentConf)
             IF(i) THEN convertAccess()
           ENDIF
        CASE EDITOR_STRUCT
            IF(msg.data)
              CopyMem(msg.filler1,editor,SIZEOF editor)
            ELSE
              CopyMem(editor,msg.filler1,SIZEOF editor)
            ENDIF
        CASE LOAD_CONFDB
          loadConfDB(msg.data,msg.nodeID,msg.filler1)
        CASE SAVE_CONFDB
          saveConfDB(msg.data,msg.nodeID,msg.filler1)
          IF(loggedOnUser.slotNumber=msg.data) THEN loadMsgPointers(currentConf)
        CASE GET_CONFNUM
          strCpy(msg.filler1,getConfName(msg.data),54)
          strCpy(msg.filler2,getConfLocation(msg.data),54)
       CASE MOD_TYPE
            debugLog(LOG_WARN,'MOD_TYPE not yet implemented')
        CASE DT_FILECODE
          checksym:=msg.data
        CASE ACP_COMMAND
            sendACPCommand(msg.string,msg.data,msg.lineNum)
        CASE BYPASS_CSI_CHECK
            debugLog(LOG_WARN,'BYPASS_CSI_CHECK not yet implemented')
        CASE SENTBY
           msg.data:=cmds.acLvl[LVL_SENTBY_FILES]
        CASE SETOVERIDE
            debugLog(LOG_WARN,'SETOVERIDE not yet implemented')
        CASE FULLEDIT
            debugLog(LOG_WARN,'FULLEDIT not yet implemented')
        CASE CONF_ACCESS
          IF (msg.data<0) OR (msg.data>=cmds.numConf)
            msg.data:=2
          ELSE
            IF checkConfAccess(msg.data+1) THEN msg.data:=1 ELSE msg.data:=0
          ENDIF
        CASE PASSWORD_HASH
          formatUnsignedLong(calcPasswordHash(msg.string),tempstring)
          strCpy(msg.string,tempstring,20)
        CASE DT_HOSTNAME
          strCpy(msg.string,hostName,200)
        CASE DT_HOSTIP
          strCpy(msg.string,hostIP,20)
        DEFAULT
          StringF(tempstring,'currently not implemented msg request: \d',msgcmd)
          debugLog(LOG_WARN,tempstring)
          StringF(tempstring,'data: \d',msg.data)
          debugLog(LOG_WARN,tempstring)
          StringF(tempstring,'string: \s',msg.string)
          debugLog(LOG_WARN,tempstring)
      ENDSELECT
      ReplyMsg(msg)
    ENDWHILE
  ENDWHILE
  IF alreadyActive=FALSE THEN deletePort(mp)

  doorLog(type,'')

  IF (StrLen(runOnExit)>0)
    processCommand(runOnExit,TRUE)
  ENDIF

/*  createport AEDoorPort0
  start door process in background
    (XIM) exe   0 exename
    (IIM) no interface exename 0 
    (TIM) paradoor: paradoor exename 0
    (AIM) rexx: rexxdoor 0 rexxscriptname
    (AEM) rexxexec: REXXEXEC 0 exename
    (SIM) script: script 0 (not async)

If doortype = IIM or SIM then exit

while(1)
{
  process door port messages 
}*/
ENDPROC

PROC runCommand(cmdtype,cmd,params,privcmd)
  DEF commandfile[255]:STRING
  DEF passwordstr[255]:STRING
  DEF doorname[255]:STRING
  DEF commandTypeCode
  DEF cmdfound = FALSE
  DEF tooltype,pri,stacksize
  DEF default=FALSE
  DEF acsLevel
  DEF passparams=-1
  DEF access=0
  DEF stat
  
  IF cmdtype=CMDTYPE_BBSCMD
    getNodeFile(TOOLTYPE_CONFCMD,cmd,commandfile)
    StrAdd(commandfile,'.info')
    IF fileExists(commandfile)
      tooltype:=TOOLTYPE_CONFCMD
    ELSE
      getNodeFile(TOOLTYPE_NODECMD,cmd,commandfile)
      StrAdd(commandfile,'.info')
      IF fileExists(commandfile)
        tooltype:=TOOLTYPE_NODECMD
      ELSE
        getNodeFile(TOOLTYPE_BBSCMD,cmd,commandfile)
        StrAdd(commandfile,'.info')
        IF fileExists(commandfile)
          tooltype:=TOOLTYPE_BBSCMD
        ELSE
          RETURN FALSE
        ENDIF
      ENDIF
    ENDIF

  ELSEIF cmdtype=CMDTYPE_SYSCMD
    getNodeFile(TOOLTYPE_SYSCMD,cmd,commandfile)
    StrAdd(commandfile,'.info')
    IF fileExists(commandfile)
      tooltype:=TOOLTYPE_SYSCMD
    ELSE
      RETURN FALSE
    ENDIF
  ENDIF
  
  commandTypeCode:=DOORTYPE_SIM
  IF checkToolType(tooltype,cmd,'TYPE','XIM')
    commandTypeCode:=DOORTYPE_XIM
  ENDIF
  IF checkToolType(tooltype,cmd,'TYPE','AIM')
    commandTypeCode:=DOORTYPE_AIM
  ENDIF

  acsLevel:=255
  IF loggedOnUser<>NIL THEN acsLevel:=loggedOnUser.secStatus
  access:=readToolTypeInt(tooltype,cmd,'ACCESS');
  IF access=0 THEN RETURN TRUE
  IF (access>acsLevel)
    higherAccess()
    RETURN FALSE
  ENDIF

  IF checkToolTypeExists(tooltype,cmd,'INTERNAL')
    passparams:=readToolTypeInt(tooltype,cmd,'PASS_PARAMETERS')
    IF passparams=1 THEN RETURN TRUE

    readToolType(tooltype,cmd,'INTERNAL',commandfile)    
    IF passparams=2
      ->pass in the original params
      StrAdd(commandfile,' ')
      StrAdd(commandfile,params)
    ENDIF
    
    RETURN (processCommand(commandfile,TRUE)=RESULT_SUCCESS)
  ENDIF
  
  setEnvStat(ENV_DOORS)
  IF readToolType(tooltype,cmd,'NAME',doorname)    
    setEnvMsg(doorname)
  ELSE
    setEnvMsg(cmd)
  ENDIF

  IF readToolType(tooltype,cmd,'PASSWORD',passwordstr)    
  
    aePuts('\b\n')
    aePuts('Enter Password >: ')
    StrCopy(commandfile,'')
    stat:=lineInput('','',15,INPUT_TIMEOUT,commandfile)
    IF(stat<0)
      ->UnLockDoor(&LockDoor)
      RETURN RESULT_FAILURE
    ENDIF  
    IF(strCmpi(passwordstr,commandfile,ALL))
      aePuts('\b\nInValid Password!\b\n\b\n')
      ->UnLockDoor(&LockDoor)
      RETURN RESULT_NOT_ALLOWED 
    ELSE
      aePuts('\b\n')
    ENDIF
  ENDIF

  IF (commandTypeCode=DOORTYPE_SIM)
    getNodeFile(tooltype,cmd,commandfile)
    default:=fileExists(commandfile)
  ELSE
    default:=FALSE
  ENDIF
  
  IF (default) OR (readToolType(tooltype,cmd,'LOCATION',commandfile))
    
    IF commandTypeCode=-1 THEN RETURN FALSE

    IF (checkToolTypeExists(tooltype,cmd,'QUICKMODE')) AND (quickFlag) THEN RETURN TRUE

    cmdfound:=TRUE
        
    pri:=0
    stacksize:=20000
    IF readToolType(tooltype,cmd,'PRIORITY',passwordstr) THEN pri:=Val(passwordstr)
    IF readToolType(tooltype,cmd,'STACK',passwordstr) THEN stacksize:=Val(passwordstr)
        
    runDoor(commandfile,commandTypeCode,cmd,params,pri,stacksize)
    
  ENDIF
ENDPROC cmdfound

PROC runBbsCommand(cmd,params,privcmd=FALSE)
  DEF debugstr[255]:STRING
  StringF(debugstr,'execute bbscmd: \s \s',cmd,params)
  debugLog(LOG_DEBUG,debugstr)
ENDPROC runCommand(CMDTYPE_BBSCMD,cmd,params,privcmd)

PROC runSysCommand(cmd,params,privcmd=FALSE)
  DEF debugstr[255]:STRING
  StringF(debugstr,'execute syscmd: \s \s',cmd,params)
  debugLog(LOG_DEBUG,debugstr)
ENDPROC runCommand(CMDTYPE_SYSCMD,cmd,params,privcmd)

PROC loadConfDB(account,confNum,addr,force=FALSE)
  DEF bi, confLoc[255]:STRING
  IF (account = loggedOnUser.slotNumber) AND (force=FALSE)
    CopyMem(ListItem(confBases,confNum-1),addr,SIZEOF confBase)
    RETURN
  ENDIF

  getConfDbFileName(confNum,confLoc)

  bi:=Open(confLoc,MODE_OLDFILE)
  IF(bi<=0)
    callersLog('\tError can''t open >:')
    callersLog(confLoc)
    RETURN
  ENDIF
    
  IF(Seek(bi,(account-1)*SIZEOF confBase,OFFSET_BEGINNING)=-1)
    callersLog('\tError Reading MsgBase Pointer')
    Close(bi)
    RETURN
  ENDIF

  IF (Read(bi,addr,SIZEOF confBase)<>SIZEOF confBase)
    callersLog('\tError Reading confbase data')
  ENDIF
  
  Close(bi)
ENDPROC

PROC saveConfDB(account,confNum,addr,force=FALSE)
  DEF bi, confLoc[255]:STRING

  IF (account = loggedOnUser.slotNumber) AND (force=FALSE)
    CopyMem(addr,ListItem(confBases,confNum-1),SIZEOF confBase)
    RETURN
  ENDIF

  getConfDbFileName(confNum,confLoc)

  bi:=Open(confLoc,MODE_READWRITE)
  IF(bi<=0)
    callersLog('\tError can''t open >:')
    callersLog(confLoc)
    RETURN
  ENDIF
  
  IF(Seek(bi,(account-1)*SIZEOF confBase,OFFSET_BEGINNING)=-1)
    callersLog('\tError Reading MsgBase Pointer')
    Close(bi)
    RETURN
  ENDIF

  Write(bi,addr,SIZEOF confBase)
  Close(bi)
ENDPROC

PROC loadMsgPointers(conf)
  DEF cb: PTR TO confBase

  IF(loggedOnUser.slotNumber<=0)
    lastMsgReadConf:=0
    lastNewReadConf:=0
    RETURN
  ENDIF

  cb:=ListItem(confBases,conf-1)

  IF (checkSecurity(ACS_CONFERENCE_ACCOUNTING))
    IF (readToolTypeInt(TOOLTYPE_CONF,conf,'CONFDB_SHARED')<=0)
      loggedOnUser.bytesDownload:=cb.bytesDownload
      loggedOnUser.bytesUpload:=cb.bytesUpload
      ->User.Daily_Bytes_Limit= it->CB.Daily_Bytes_Limit
      ->User.Daily_Bytes_Dld=   it->CB.Daily_Bytes_Dld
      loggedOnUser.uploads:=cb.upload
      loggedOnUser.downloads:=cb.downloads
      loggedOnUser.secBoard:=cb.ratioType
      loggedOnUser.secLibrary:=cb.ratio
    ENDIF
    loggedOnUser.messagesPosted:=cb.messagesPosted
  ENDIF
  
  IF(newSinceFlag) THEN cb.newSinceDate:=getSystemTime()
 -> Last_EMail=it->CB.LastEMail
  lastMsgReadConf:=cb.confYM
  lastNewReadConf:=cb.confRead
ENDPROC

PROC saveMsgPointers(conf)
  DEF cb: PTR TO confBase
  DEF debug[255]:STRING

  IF(loggedOnUser.slotNumber<=0) OR (conf=0)
    lastMsgReadConf:=0
    lastNewReadConf:=0
    RETURN
  ENDIF

  cb:=ListItem(confBases,conf-1)

  IF (checkSecurity(ACS_CONFERENCE_ACCOUNTING))
    IF (readToolTypeInt(TOOLTYPE_CONF,conf,'CONFDB_SHARED')<=0)
      cb.bytesDownload:=loggedOnUser.bytesDownload
      cb.bytesUpload:=loggedOnUser.bytesUpload
      ->User.Daily_Bytes_Limit= it->CB.Daily_Bytes_Limit
      ->User.Daily_Bytes_Dld=   it->CB.Daily_Bytes_Dld
      cb.upload:=loggedOnUser.uploads
      cb.downloads:=loggedOnUser.downloads
      cb.ratioType:=loggedOnUser.secBoard
      cb.ratio:=loggedOnUser.secLibrary
    ENDIF
    cb.messagesPosted:=loggedOnUser.messagesPosted
  ENDIF
  
  IF(newSinceFlag) THEN cb.newSinceDate:=getSystemTime()
 -> Last_EMail=it->CB.LastEMail

 IF (lastMsgReadConf=0)
    StringF(debug,'error putting last message read conf \d: value \d',conf,lastMsgReadConf)
    errorLog(debug)
    IF loggedOnUser<>NIL
      StringF(debug,'user = \s',loggedOnUser.name)
      errorLog(debug)
    ELSE
      StrCopy(debug,'user = nil')
      errorLog(debug)
    ENDIF
  ENDIF
    
 IF (lastNewReadConf=0)
    StringF(debug,'error putting last message new conf \d: value \d',conf,lastNewReadConf)
    errorLog(debug)
    IF loggedOnUser<>NIL
      StringF(debug,'user = \s',loggedOnUser.name)
      errorLog(debug)
    ELSE
      StrCopy(debug,'user = nil')
      errorLog(debug)
    ENDIF
 ENDIF

  cb.confYM:=lastMsgReadConf
  cb.confRead:=lastNewReadConf
ENDPROC

PROC joinConf(conf, confScan, auto, skipMailScan=FALSE)
  DEF string[255]:STRING,tempstr[255]:STRING
  DEF mystat, temp

  IF confScan=FALSE THEN currentConf:=conf
  getConfName(conf,currentConfName)
  getConfLocation(conf,currentConfDir)

  maxDirs:=readToolTypeInt(TOOLTYPE_CONF,conf,'NDIRS')

  IF checkToolTypeExists(TOOLTYPE_CONF,conf,'FREEDOWNLOADS') THEN freeDownloads:=TRUE ELSE freeDownloads:=FALSE
  
  StrCopy(menuPrompt,'')
  readToolType(TOOLTYPE_CONF,conf,'MENU_PROMPT',menuPrompt)
  
  StringF(msgBaseLocation,'\sMsgBase/',currentConfDir)
  StringF(uploadLocation,'\sUpload/',currentConfDir)

  loadMsgPointers(conf)
 
  mystat:=getMailStatFile()
  IF(mystat=RESULT_FAILURE) THEN RETURN RESULT_FAILURE
  IF(lastMsgReadConf<mailStat.lowestNotDel) THEN lastMsgReadConf:=mailStat.lowestNotDel
  IF(lastNewReadConf<mailStat.lowestNotDel) THEN lastNewReadConf:=mailStat.lowestNotDel

  IF(lastMsgReadConf>mailStat.highMsgNum)
    StringF(string,'error setting last message read: value \d, high msg num \d',lastMsgReadConf,mailStat.highMsgNum)
    errorLog(string)
    lastMsgReadConf:=0
  ENDIF
  IF(lastNewReadConf>mailStat.highMsgNum) 
    StringF(string,'error setting last new read read: value \d, high msg num \d',lastNewReadConf,mailStat.highMsgNum)
    errorLog(string)
    lastNewReadConf:=0
  ENDIF

  StrCopy(confScreenDir,currentConfDir)
  readToolType(TOOLTYPE_CONF,currentConf,'SCREENS',confScreenDir)
  
  IF(confScan=FALSE)
    IF displayScreen(SCREEN_CONF_BULL)
      temp:=doPause()
      IF(temp<0) THEN RETURN temp
    ENDIF

    relConfNum:=relConf(conf)

    aePuts('\b\n')
    IF (auto) 
      scanHoldDesc()
      internalCommandS()
      StringF(string,'Conference \d: \s Auto-ReJoined',relConfNum,currentConfName)
    ELSE
      StringF(string,'[32mJoining Conference[33m:[0m \s',currentConfName)
      aePuts(string)
      StringF(string,'\s (\d) Conference Joined',currentConfName,conf)
    ENDIF
    aePuts('\b\n')
    StringF(tempstr,'\t\s',string)
    callersLog(tempstr)

    IF(mailStat.lowestKey>1)
    
     StringF(string,'[32mMessages range from [33m( [0m\d [32m- [0m\d [33m)[0m\b\n',
                 mailStat.lowestKey,mailStat.highMsgNum-1)
    ELSE
     StringF(string,'\b\n[32mTotal messages           [33m:[0m \d\b\n',mailStat.highMsgNum-1)
    ENDIF
    aePuts(string)
   
    temp:=lastNewReadConf-1
    IF(temp<0) THEN temp:=1
    StringF(string,'\b\n[32mLast message auto scanned[33m:[0m \d\b\n',temp)
    aePuts(string)

    StringF(string,'[32mLast message read        [33m:[0m \d\b\n',lastMsgReadConf)
    aePuts(string)

    displaySysopULStats()

  ENDIF

  IF (auto=FALSE) AND (skipMailScan=FALSE)
    IF (checkMailConfScan(conf))
      mystat:=callMsgFuncs(MAIL_SCAN,conf)
      saveMsgPointers(conf)
    ENDIF
  ENDIF

  IF (auto=FALSE) AND (confScan=FALSE) THEN loggedOnUser.confRJoin:=conf

ENDPROC mystat

PROC doPause()
  DEF ch
  IF reqState<>REQ_STATE_NONE THEN RETURN
  aePuts('\b\n[32m([33mPause[32m)[34m...[32mSpace To Resume[33m: [0m')
  REPEAT
    ch:=readChar(INPUT_TIMEOUT)
  UNTIL (ch=13) OR (ch=32) OR (ch<0) OR (reqState<>REQ_STATE_NONE)
  lineCount:=0
  aePuts('\b\n')
ENDPROC

PROC readChar(timeout, extsig = 0)
  DEF wasControl,ch
  DEF timedout,signalled
  DEF temp[1]:STRING

  
 conPuts('[ p') /* turn console cursor on */
 REPEAT
    wasControl,ch:=processInputMessage(timeout, extsig)
    timedout:=(ch=RESULT_TIMEOUT)
    signalled:=(ch=RESULT_SIGNALLED)
  UNTIL ((wasControl=FALSE) AND (ch<>0)) OR (reqState<>REQ_STATE_NONE) OR (timedout) OR (signalled)
  conPuts('[0 p'); /* turn console cursor off */

  IF signalled THEN ch:=0
  IF timedout THEN ch:=RESULT_TIMEOUT
  IF reqState<>REQ_STATE_NONE THEN ch:=RESULT_NO_CARRIER
ENDPROC ch

PROC checkForPause()
  DEF stat,linelen
  DEF input[3]:STRING

  IF loggedOnUser<>NIL THEN linelen:=loggedOnUser.lineLength ELSE linelen:=30
  IF linelen=0 THEN linelen:=22
  
  IF(nonStopDisplayFlag=FALSE) THEN lineCount++
  IF((nonStopDisplayFlag=FALSE) AND (lineCount>=linelen))
    lineCount:=0
    aePuts('(Pause)...More(y/n/ns)? ')
    lineInput('','',3,INPUT_TIMEOUT,input)

    IF((input[0]="N") OR (input[0]="n"))
      IF((input[1]="S") OR (input[1]="s")) THEN nonStopDisplayFlag:=TRUE ELSE RETURN RESULT_FAILURE
    ENDIF
    aePuts('[1A[K')
  ENDIF
ENDPROC RESULT_SUCCESS
  
PROC sendChar(n)
  DEF c[1]:STRING
    StrCopy(c,' ',ALL)
    c[0]:=n
    aePuts(c)
ENDPROC

PROC send017()
  DEF chr[1]:STRING
    StrCopy(chr,' ',ALL)
    chr[0]:=15
    aePuts(chr)
ENDPROC
  
PROC conCLS()
  DEF cls[1]:STRING
    StrCopy(cls,' ',ALL)
    cls[0]:=12
    conPuts(cls)
  lineCount:=0
ENDPROC

PROC sendCLS()
  DEF cls[1]:STRING
    StrCopy(cls,' ',ALL)
    cls[0]:=12
    aePuts(cls)
  lineCount:=0
ENDPROC

PROC sendBELL()
  DEF bell[1]:STRING
    StrCopy(bell,' ',ALL)
    bell[0]:=7
    aePuts(bell)
ENDPROC

PROC sendBackspace()
  DEF c[1]:STRING
    StrCopy(c,' ',ALL)
    c[0]:=8
    aePuts(c)
ENDPROC

PROC blankLines(n)
  DEF stats

  WHILE n
    aePuts('\b\n')
    IF(stats:=checkForPause())
      aePuts('\b\n')
      RETURN stats
    ENDIF
    n--
  ENDWHILE
ENDPROC

PROC processMciCmd(mcidata,len,pos)
  DEF cmd[100]:STRING
  DEF num[4]:STRING
  DEF tempstr[255]:STRING
  DEF filename[100]:STRING
  DEF screenfilename[100]:STRING
  DEF nlen,nval,res
  DEF t=0

  IF (mcidata[pos]="~")
  pos:=pos+1
  
  WHILE (EstrLen(num)<3) AND (pos<len) AND (mcidata[pos]>="0") AND (mcidata[pos]<="9") 
    StrAdd(num,' ')
    num[EstrLen(num)-1]:=mcidata[pos]
    pos:=pos+1
  ENDWHILE
    
  nval:=InStr(mcidata,' ',pos)
  IF nval<0 THEN nval:=len
  nlen:=InStr(mcidata,mciterminator,pos)
  IF nlen<0 THEN nlen:=len ELSE t:=1
  IF nval<nlen
    nlen:=nval
    t:=0
  ENDIF
  
  MidStr(cmd,mcidata,pos,nlen-pos)
  IF EstrLen(num)>0 THEN nlen:=Val(num) ELSE nlen:=-1
      
  /*    
  ~~       This indicates you wish the ~ symbol to appear, you can
           have as many of them as you like after the first ~ to display
           them (NOTE: no ',' on this command)
  ~xN      Goto X position on screen. ie: ~x10
  ~yN      Goto Y position on screen. ie: ~y10

  NOTE: The above commands allow you to specify a width identifier before
  ~~~~  the action test.. ie:
        ~10N would only display the first 10 letters of the username.
      
  ~SX  - Show Sequentual Files

      NOTE: ALL MCI COMMANDS MUST END WITH EITHER A SPACE OR A '|' SYMBOL
                     ALL COMMANDS ARE CASE SENSITIVE!!!!!!!!
*/            
    IF (StrCmp(cmd,'',ALL))
      pos:=pos+t
    ELSEIF (StrCmp(cmd,'N',ALL))
      pos:=pos+1+t
      StrCopy(tempstr,loggedOnUser.name)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'UL',ALL))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUser.location)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'P',ALL))
      ->do nothing with password
      pos:=pos+1+t    
    ELSEIF (StrCmp(cmd,'#',ALL))
      pos:=pos+1+t   
      StrCopy(tempstr,loggedOnUser.phoneNumber)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'TC',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.timesCalled AND $FFFF)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'LC',ALL))
      pos:=pos+2+t
      formatLongDateTime(loggedOnUser.timeLastOn,tempstr)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'M',ALL))
      pos:=pos+1+t
      StringF(tempstr,'\d',loggedOnUser.messagesPosted AND $FFFF)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'A',ALL))
      pos:=pos+1+t
      StringF(tempstr,'\d',loggedOnUser.secStatus)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'S',ALL))
      pos:=pos+1+t
      StringF(tempstr,'\d',loggedOnUser.slotNumber)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'CA',ALL))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUser.conferenceAccess)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'BR',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',onlineBaud)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'HW',ALL))
      pos:=pos+2+t
      StrCopy(tempstr,computerTypes[loggedOnUser.secBulletin])
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'TL',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',Div(loggedOnUser.timeLimit,60))
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'TR',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',Div(timeLimit,60))
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'UB',ALL))
      pos:=pos+2+t
      formatUnsignedLong(loggedOnUser.bytesUpload,tempstr)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'DB',ALL))
      pos:=pos+2+t
      formatUnsignedLong(loggedOnUser.bytesDownload,tempstr)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'FU',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.uploads AND $FFFF)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'FD',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.downloads AND $FFFF)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'BD',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.dailyBytesLimit)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'LG',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',node)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'IN',ALL))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUserMisc.internetName)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'RN',ALL))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUserMisc.realName)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'DK',2))
      pos:=pos+2+t
      MidStr(cmd,mcidata,pos,ALL)
      StrCopy(mciterminator,cmd)
      pos:=pos+StrLen(cmd)
    ELSEIF (StrCmp(cmd,'OD',ALL))
      pos:=pos+2+t
      formatLongDate(logonTime,tempstr)
      aePuts2(tempstr,nlen)
    ELSEIF (StrCmp(cmd,'OT',ALL))
      pos:=pos+2+t
      formatLongTime(logonTime,tempstr)
      aePuts2(tempstr,nlen)    
    ELSEIF (StrCmp(cmd,'SC',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',getCallerCount())
      aePuts2(tempstr,nlen)    
    ELSEIF (StrCmp(cmd,'CT',ALL))
      pos:=pos+2+t
      formatLongTime(logonTime,tempstr)
      aePuts2(tempstr,nlen)    
    ELSEIF (StrCmp(cmd,'DT',ALL))
      pos:=pos+2+t
      formatLongDate(getSystemTime(),tempstr)
      aePuts2(tempstr,nlen)    
    ELSEIF (nlen=-1) AND (StrCmp(cmd,'SP',ALL))
      ->PAUSE
      pos:=pos+2+t
      res:=doPause()
      IF res<>RESULT_SUCCESS THEN RETURN res
    ELSEIF (nlen=-1) AND (StrCmp(cmd,'CR',ALL))
      ->PAUSE
      pos:=pos+2+t
      res:=readChar(INPUT_TIMEOUT)
      IF res<>RESULT_SUCCESS THEN RETURN res
    ELSEIF StrCmp(cmd,'f',ALL)
      sendCLS()
      pos:=pos+1+t
    ELSEIF StrCmp(cmd,'x',1)      
      nlen:=Val(mcidata+pos+1)      
      IF nlen>=0 
        StringF(tempstr,'[;\dH',nlen)
        aePuts(tempstr)
      ENDIF
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'y',1)
      nlen:=Val(mcidata+pos+1)
      IF nlen>=0 
        StringF(tempstr,'[\d;H',nlen)
        aePuts(tempstr)
      ENDIF
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'SS_',3)
      ->display another file
      pos:=pos+3
      nval:=EstrLen(cmd)-3
      MidStr(cmd,mcidata,pos,nval)
      displayFile(cmd)
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'SX_',3)
      ->sequential file display
      pos:=pos+3
      nval:=EstrLen(cmd)-3
      MidStr(cmd,mcidata,pos,nval)
      nval:=readIntFromFile(cmd)
      IF nval<>-1
        nval++
        StrCopy(tempstr,cmd,FilePart(cmd)-cmd)
        StringF(filename,'\s\z\r\d[3].\s',tempstr,nval,FilePart(cmd))
        IF findSecurityScreen(filename,screenfilename)
          displayFile(screenfilename)
        ELSE
          nval:=-1
        ENDIF
      ENDIF

      IF nval=-1
        nval:=1
        StringF(filename,'\s\z\r\d[3].\s',tempstr,nval,FilePart(cmd))
        IF findSecurityScreen(filename,screenfilename)
          displayFile(screenfilename)
        ENDIF
      ENDIF
      writeIntToFile(cmd,nval)
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'SR_',3)
      ->display random file
      pos:=pos+3
      nval:=Val(num)
      StringF(tempstr,'random \d',nval)
      debugLog(LOG_DEBUG,tempstr)
      nval:=Rnd(nval)
      StringF(tempstr,'random result \d',nval)
      debugLog(LOG_DEBUG,tempstr)
      nlen:=EstrLen(cmd)-3
      -> get full filename
      MidStr(cmd,mcidata,pos,nlen)
      StrCopy(tempstr,cmd,FilePart(cmd)-cmd)
      StringF(filename,'\z\r\d[3].\s',nval+1,FilePart(cmd),screenfilename)
      StrAdd(tempstr, filename)

      findSecurityScreen(tempstr,screenfilename)
      
      displayFile(screenfilename)
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'CC_',3)
      ->run a command
      pos:=pos+3
      nval:=EstrLen(cmd)-3
      MidStr(cmd,mcidata,pos,nval)
      processSysCommand(cmd)
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'CR_',3)
      ->promted keypress
      pos:=pos+3
      nval:=EstrLen(cmd)-3
      MidStr(cmd,mcidata,pos,nval)
      aePuts(cmd)
      res:=readChar(INPUT_TIMEOUT)
      IF res<>RESULT_SUCCESS THEN RETURN res
      pos:=pos+nval+t
    ELSEIF StrCmp(cmd,'q',ALL)
      pos:=pos+1+t
      aePuts('[0m')
    ELSEIF StrCmp(cmd,'h',ALL)
      pos:=pos+1+t
      sendBackspace()
    ELSEIF StrCmp(cmd,'CL',ALL)
      ->run a command
      pos:=pos+2+t
      num:=0
      FOR nval:=1 TO cmds.numConf
        IF((checkConfAccess(nval)=TRUE) OR (sopt.toggles[TOGGLES_CONFRELATIVE]=FALSE))
          num++
          StringF(tempstr,'                     [32m\d[3][33m) [35m',num)
          aePuts(tempstr)
          getConfName(nval,tempstr)
          res:=StrLen(tempstr)
          WHILE(res<30)
            aePuts(' ')
            res++
          ENDWHILE
          StringF(tempstr,'[36m\s[0m\b\n',getConfName(nval))
          aePuts(tempstr)
        ENDIF
      ENDFOR
    ELSEIF StrCmp(cmd,'c0',ALL)
      aePuts('[30m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c1',ALL)
      aePuts('[31m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c2',ALL)
      aePuts('[32m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c3',ALL)
      aePuts('[33m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c4',ALL)
      aePuts('[34m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c5',ALL)
      aePuts('[35m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c6',ALL)
      aePuts('[36m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c7',ALL)
      aePuts('[37m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b0',ALL)
      aePuts('[40m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b1',ALL)
      aePuts('[41m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b2',ALL)
      aePuts('[42m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b3',ALL)
      aePuts('[43m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b4',ALL)
      aePuts('[44m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b5',ALL)
      aePuts('[45m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b6',ALL)
      aePuts('[46m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b7',ALL)
      aePuts('[47m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n1',ALL)
      blankLines(1)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n2',ALL)
      blankLines(2)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n3',ALL)
      blankLines(3)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n4',ALL)
      blankLines(4)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n5',ALL)
      blankLines(5)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n6',ALL)
      blankLines(6)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n7',ALL)
      blankLines(7)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n8',ALL)
      blankLines(8)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n9',ALL)
      blankLines(9)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'~',1)
      aePuts(cmd)
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrLen(cmd)=0
      pos:=pos+t
    ELSE
      ->unknown mci
      aePuts('~')
      aePuts(num)
    ENDIF
  ENDIF
   
ENDPROC pos

PROC processMciCmd2(mcidata,len,pos,outdata)
  DEF cmd[100]:STRING
  DEF num[4]:STRING
  DEF tempstr[255]:STRING
  DEF nval,nlen,t=0

  IF (mcidata[pos]="~")
  pos:=pos+1
  
  WHILE (EstrLen(num)<3) AND (pos<len) AND (mcidata[pos]>="0") AND (mcidata[pos]<="9") 
    StrAdd(num,' ')
    num[EstrLen(num)-1]:=mcidata[pos]
    pos:=pos+1
  ENDWHILE
    
  nval:=InStr(mcidata,' ',pos)
  IF nval<0 THEN nval:=len
  nlen:=InStr(mcidata,mciterminator,pos)
  IF nlen<0 THEN nlen:=len ELSE t:=1
  IF nval<nlen
    nlen:=nval
    t:=0
  ENDIF
  
  MidStr(cmd,mcidata,pos,nlen-pos)
  IF EstrLen(num)>0 THEN nlen:=Val(num) ELSE nlen:=-1
      
    IF (StrCmp(cmd,'',ALL))
      pos:=pos+t
    ELSEIF (StrCmp(cmd,'N',ALL))
      pos:=pos+1+t
      StrCopy(tempstr,loggedOnUser.name)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'UL',ALL))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUser.location)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'P',ALL))
      ->do nothing with password
      pos:=pos+1+t    
    ELSEIF (StrCmp(cmd,'#',ALL))
      pos:=pos+1+t   
      StrCopy(tempstr,loggedOnUser.phoneNumber)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'TC',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.timesCalled AND $FFFF)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'LC',ALL))
      pos:=pos+2+t
      formatLongDateTime(loggedOnUser.timeLastOn,tempstr)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'M',ALL))
      pos:=pos+1+t
      StringF(tempstr,'\d',loggedOnUser.messagesPosted AND $FFFF)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'A',ALL))
      pos:=pos+1+t
      StringF(tempstr,'\d',loggedOnUser.secStatus)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'S',ALL))
      pos:=pos+1+t
      StringF(tempstr,'\d',loggedOnUser.slotNumber)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'CA',ALL))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUser.conferenceAccess)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'BR',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',onlineBaud)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'HW',ALL))
      pos:=pos+2+t
      StrCopy(tempstr,computerTypes[loggedOnUser.secBulletin])
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'TL',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',Div(loggedOnUser.timeLimit,60))
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'TR',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',Div(timeLimit,60))
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'UB',ALL))
      pos:=pos+2+t
      formatUnsignedLong(loggedOnUser.bytesUpload,tempstr)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'DB',ALL))
      pos:=pos+2+t
      formatUnsignedLong(loggedOnUser.bytesDownload,tempstr)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'FU',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.uploads AND $FFFF)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'FD',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.downloads AND $FFFF)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'BD',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.dailyBytesLimit)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'LG',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',node)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'IN',ALL))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUserMisc.internetName)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'RN',ALL))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUserMisc.realName)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'DK',2))
      pos:=pos+2+t
      MidStr(cmd,mcidata,pos,ALL)
      StrCopy(mciterminator,cmd)
      pos:=pos+StrLen(cmd)
    ELSEIF (StrCmp(cmd,'OD',ALL))
      pos:=pos+2+t
      formatLongDate(logonTime,tempstr)
      StrAdd(outdata,tempstr,nlen)
    ELSEIF (StrCmp(cmd,'OT',ALL))
      pos:=pos+2+t
      formatLongTime(logonTime,tempstr)
      StrAdd(outdata,tempstr,nlen)    
    ELSEIF (StrCmp(cmd,'SC',ALL))
      pos:=pos+2+t
      StringF(tempstr,'\d',getCallerCount())
      StrAdd(outdata,tempstr,nlen)    
    ELSEIF (StrCmp(cmd,'CT',ALL))
      pos:=pos+2+t
      formatLongTime(logonTime,tempstr)
      StrAdd(outdata,tempstr,nlen)    
    ELSEIF (StrCmp(cmd,'DT',ALL))
      pos:=pos+2+t
      formatLongDate(getSystemTime(),tempstr)
      StrAdd(outdata,tempstr,nlen)    
    ELSE
      ->unknown mci
      StrAdd(outdata,'~')
      StrAdd(outdata,num)
    ENDIF
  ENDIF
   
ENDPROC pos

PROC processMci(mcidata)
  DEF pos=0,cmdpos,len
  
  len:=EstrLen(mcidata)
  IF len=0
    RETURN
  ENDIF
  
  WHILE (pos>=0) AND (pos<len)
    IF reqState<>REQ_STATE_NONE THEN RETURN
    IF (cmdpos:=InStr(mcidata,'~',pos))<0
      aePuts(mcidata+pos)
      pos:=EstrLen(mcidata) 
    ELSE
      aePuts2(mcidata+pos,cmdpos-pos)
      pos:=pos+(cmdpos-pos)
      pos:=processMciCmd(mcidata,len,pos)
    ENDIF
  ENDWHILE
ENDPROC

PROC processMci2(mcidata,outdata)
  DEF pos=0,cmdpos,len
  
  StrCopy(outdata,'')

  len:=EstrLen(mcidata)
  IF len=0
    RETURN
  ENDIF
  
  WHILE (pos>=0) AND (pos<len)
    IF reqState<>REQ_STATE_NONE THEN RETURN
    IF (cmdpos:=InStr(mcidata,'~',pos))<0
      StrAdd(outdata, mcidata+pos)
      pos:=EstrLen(mcidata) 
    ELSE
      StrAdd(outdata, mcidata+pos,cmdpos-pos)
      pos:=pos+(cmdpos-pos)
      pos:=processMciCmd2(mcidata,len,pos,outdata)
    ENDIF
  ENDWHILE
ENDPROC

PROC startASend()
  DEF str[100]:STRING

  IF(logonType>=LOGON_TYPE_REMOTE)
 	  ioFlags[IOFLAG_SER_IN]:=0
	  ioFlags[IOFLAG_SER_OUT]:=0
	ENDIF
 
  /*ConPutStr("\nSend File, path/filename: ");
  stat=LineInput("",str,99,KEYBOARD_TIMEOUT);
  if(stat<0||str[0]=='\0')
  	return;
  */
  asl(str)
  IF(logonType>=LOGON_TYPE_REMOTE)
 	  ioFlags[IOFLAG_SER_IN]:=-1
	  ioFlags[IOFLAG_SER_OUT]:=-1
  ENDIF
  IF StrLen(str)>0 THEN displayFile(str)
ENDPROC

PROC startCapture()
  DEF stat
  DEF str[100]:STRING

  IF(captureFP)
	    Close(captureFP)
	    captureFP:=NIL
	    conPuts('\b\nCapture closed!\b\n')
	ELSE
redo:
	  conPuts('\b\nOpen capture, path/filename: ')
	  stat:=lineInput('','',99,INPUT_TIMEOUT,str)
	  IF((stat<0) OR (StrLen(str)=0))	THEN RETURN
	  captureFP:=Open(str,MODE_NEWFILE)
	  IF(captureFP<=0)
		  conPuts('ERROR: can''t open ')
		  conPuts(str)
		  conPuts(' for writing!  Try another!\b\n')
		  JUMP redo
		ELSE
		  conPuts('[A[KCapture opened!\b\n')
		ENDIF
	ENDIF
ENDPROC


PROC chat()
  DEF c,j,x,i,back,whichCon,whichSer
  DEF str[100]:STRING,str2[10]:STRING,space[90]:STRING,buff[256]:STRING
  DEF chatfile[255]:STRING
  DEF fp
 /* check for out cycled chat start sayings */
  IF(my_struct.startchatnum > 0)  /* do we have a chat file ?? */
     IF((fp:=Open(my_struct.startchatfile,MODE_OLDFILE)))>0 THEN JUMP wx

     StrCopy(buff,'')
     j:= Rnd(my_struct.startchatnum)
     i:=0
     WHILE(ReadStr(fp,buff)<>-1) OR (StrLen(buff)>0)
       EXIT (i >= j)
       i++
     ENDWHILE
     Close(fp)
     i:=0
     IF(StrLen(buff)=0) THEN JUMP wx
     aePuts('\b\n\b\n')
     aePuts(buff)
     aePuts('\b\n\b\n')
     JUMP sx
  ENDIF

wx:
  checkOnlineStatus()
  
  StrCopy(chatfile,'')
  IF (loggedOnUser.screenType<ListLen(screenTypeExt))
    StringF(chatfile,'\sNode\d/StartChat.\s',cmds.bbsLoc,node,screenTypeExt[loggedOnUser.screenType]) 
    IF fileExists(chatfile)=FALSE THEN StrCopy(chatfile,'')
  ENDIF
  IF StrLen(chatfile)=0
    StringF(chatfile,'\sNode\d/StartChat.txt',cmds.bbsLoc,node) 
  ENDIF

  IF((i:=displayFile(chatfile,TRUE,TRUE)))=FALSE
 	  aePuts('\b\n\b\nThis is ')
	  aePuts(cmds.sysopName)
	  aePuts(', How can I help you??\b\n\b\n')
	ENDIF
sx:

  pagedFlag:=0
  chatConFlag:=1
  IF(ansiColour)
  	 StringF(str,'[\dm',cmds.acLvl[LVL_CHAT_COLOR_SYSOP])
  	fAEPutStr(str)
  ENDIF
  
  chatSerFlag:=0
  StrCopy(space,'')
  StrCopy(str,'')
  x:=0
  WHILE(chatFlag)
  	next:
    
    whichCon:=chatConFlag
  	whichSer:=chatSerFlag
    cnext2:
    
  	c:=readChar(INPUT_TIMEOUT)
    IF(c=HISTORY)	THEN JUMP cnext2
      
    EXIT chatFlag=0

  	IF(c=RESULT_NO_CARRIER)
      chatFlag:=0
      RETURN RESULT_NO_CARRIER      
    ENDIF
    
    IF((c=3) AND (checkSecurity(ACS_BREAK_CHAT)))
      chatFlag:=0
      JUMP chatbrk
    ENDIF

    updateTimeUsed()
    IF (loggedOnUser.chatRemain<=0)
      chatFlag:=0
      JUMP chatbrk
    ENDIF
    
    IF(c=13)
  		IF(captureFP) THEN fileWriteLn(captureFP,space)
  
      /***** SIMILATES THE F1 'exit chat' routine *****/
      UpperStr(space)

      StrCopy(space,'')
      x:=0
      fAEPutStr('\b\n')
      checkOnlineStatus()
      JUMP cnext2
  	ENDIF
  
    IF((c=CHAR_BACKSPACE) OR (c=177))
  		IF(x>0)
      	x--
        SetStr(space,x)
        fAEPutStr(CHAR_BACKSPACE)
        fAEPutStr(' ')
  			fAEPutStr(CHAR_BACKSPACE)

  		  JUMP cnext2
  		ENDIF
  	  JUMP cnext2
  	ENDIF
    IF((c='')OR (c=7))
      sendChar(c)
  	  JUMP cnext2
  	ENDIF
  	
    IF(c<" ")	THEN JUMP cnext2
  
    x++
    IF(ansiColour)
      IF((chatConFlag=1) AND (whichSer=1))
        StringF(str,'[\dm',cmds.acLvl[LVL_CHAT_COLOR_SYSOP])
        IF(bitPlanes<3)	THEN serPuts(str) ELSE fAEPutStr(str)
      ENDIF
      IF((chatSerFlag=1) AND (whichCon=1))
        StringF(str,'[\dm',cmds.acLvl[LVL_CHAT_COLOR_USER])
        IF(bitPlanes<3) THEN serPuts(str) ELSE fAEPutStr(str)
      ENDIF
      sendChar(c)
  	ELSE    
      sendChar(c)
    ENDIF
  
    StrCopy(str2,' ')
    str2[0]:=c
    StrAdd(space,str2)
  
    IF(x>78) 
  		back:=0
      i:=x
      WHILE i>=0
  			IF(space[i-1]=" ")
  				back:=x-i
      		i:=0
  			ENDIF
        i--
  		ENDWHILE
  	  IF(back=0)
  			IF(captureFP) THEN fileWriteLn(captureFP,space)
  
  			fAEPutStr('\b\n')
        StrCopy(space,'')
  	    x:=0
  		  JUMP next
  		ENDIF
      StrCopy(str,'')
      FOR i:=(x-back) TO x-1
        StrCopy(str2,' ')
  			str2[0]:=space[i]
  	    StrAdd(str,str2)
  		ENDFOR
  
  		IF(captureFP) 
  			IF(x-back-1>=0) 
          SetStr(space,x-back-1)
  			ENDIF
      	fileWriteLn(captureFP,space)
  		ENDIF
  
  		x:=StrLen(str)
      StrCopy(space,str)
  	  FOR i:=0 TO x-1 
  			fAEPutStr(CHAR_BACKSPACE)
        fAEPutStr(' ')
  			fAEPutStr(CHAR_BACKSPACE)
      ENDFOR
  
      fAEPutStr('\b\n')
  	  fAEPutStr(str)
  	ENDIF
    
chatbrk:
    ENDWHILE

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  IF(ansiColour)	THEN aePuts('[0m')
  
  /*---------------- check for our cycled chat stop sayings ------------*/
  IF(my_struct.stopchatnum > 0)    /* do we have a chat file ?? */
      IF((fp:=Open(my_struct.stopchatfile,MODE_OLDFILE)))<=0 THEN JUMP wy
      StrCopy(buff,'')
      j:=Rnd(my_struct.stopchatnum)
      i:=0
      WHILE((ReadStr(fp,buff)<>-1) OR (StrLen(buff)>0))
        EXIT (i >= j)
        i++
      ENDWHILE
      Close(fp)
      i:=0
      IF StrLen(buff)=0 THEN JUMP wy
      aePuts('\b\n\b\n')
      aePuts(buff)
      aePuts('\b\n\b\n')
      RETURN RESULT_SUCCESS
  ENDIF

 wy:

  StrCopy(chatfile,'')
  IF (loggedOnUser.screenType<ListLen(screenTypeExt))
    StringF(chatfile,'\sNode\d/EndChat.\s',cmds.bbsLoc,node,screenTypeExt[loggedOnUser.screenType]) 
    IF fileExists(chatfile)=FALSE THEN StrCopy(chatfile,'')
  ENDIF
  IF StrLen(chatfile)=0
    StringF(chatfile,'\sNode\d/EndChat.txt',cmds.bbsLoc,node) 
  ENDIF

  IF((i:=displayFile(chatfile,TRUE,TRUE)))=FALSE
  
    aePuts('\b\n\b\nEnding Chat.')
wz:
  ENDIF
ENDPROC RESULT_SUCCESS

PROC fileExists(filename)
  DEF lh
  IF lh:=Lock(filename,ACCESS_READ)
    UnLock(lh)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

PROC findSecurityScreen(screenDirAndName,screenfileName)
  DEF secLevel
  DEF errorStr[255]:STRING
  DEF minLevel=5
  DEF defscr=FALSE

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'DEF_SCREENS')
    minLevel:=5
    defscr:=TRUE
  ENDIF

  ->DEF_SCREENS means find non-security screens first
  IF (defscr)
    IF loggedOnUser<>NIL
      IF (loggedOnUser.screenType<ListLen(screenTypeExt))
        StringF(screenfileName,'\s\s',screenDirAndName,screenTypeExt[loggedOnUser.screenType])
        IF fileExists(screenfileName) THEN RETURN TRUE
      ENDIF
    ENDIF
    StringF(screenfileName,'\s\s',screenDirAndName,'.TXT')
    IF fileExists(screenfileName) THEN RETURN TRUE
  ENDIF

  ->check security screens
  IF (loggedOnUser<>NIL)
    secLevel:=loggedOnUser.secStatus/5*5
    WHILE (secLevel>=minLevel)
      IF (loggedOnUser.screenType<ListLen(screenTypeExt))
        StringF(screenfileName,'\s\d\s',screenDirAndName,secLevel,screenTypeExt[loggedOnUser.screenType])
        IF fileExists(screenfileName) THEN RETURN TRUE
      ENDIF
      StringF(screenfileName,'\s\d\s',screenDirAndName,secLevel,'.TXT')
      IF fileExists(screenfileName) THEN RETURN TRUE
      secLevel:=secLevel-5
    ENDWHILE
  ENDIF

  ->check non security screens at end if not DEF_SCREENS
  IF (defscr=FALSE)
    IF loggedOnUser<>NIL
      IF (loggedOnUser.screenType<ListLen(screenTypeExt))
        StringF(screenfileName,'\s\s',screenDirAndName,screenTypeExt[loggedOnUser.screenType])
        IF fileExists(screenfileName) THEN RETURN TRUE
      ENDIF
    ENDIF
    StringF(screenfileName,'\s\s',screenDirAndName,'.TXT')
    IF fileExists(screenfileName) THEN RETURN TRUE
  ENDIF

ENDPROC FALSE

PROC suspendBBS()
  DEF wasopen
  DEF oldstate
  DEF rexxsig
  DEF error[255]:STRING
  DEF tempstr[255]:STRING,tempstr2[255]:STRING

  wasopen:=scropen
  oldstate:=state

  IF rexxmp<>NIL THEN rexxsig:=Shl(1, rexxmp.sigbit)

  state:=STATE_SUSPEND
  IF scropen THEN closeExpressScreen()
 
  closeSerial()

  formatLongDateTime(getSystemTime(),tempstr)
  StringF(tempstr2,'BBS has been suspended at \s',tempstr)
  startLog(tempstr2)

  WHILE(reqState<>REQ_STATE_RESUME)
    Wait(rexxsig)
    processRexxMessage()
  ENDWHILE
  state:=oldstate
  reqState:=REQ_STATE_NONE

  formatLongDateTime(getSystemTime(),tempstr)
  StringF(tempstr2,'BBS has received resume @ \s',tempstr)
  startLog(tempstr2)

  IF(openSerial(cmds.openingBaud,8,1)<>0)
    StringF(shutDownMsg,'Can''t open \s!',cmds.serDev)
    reqState:=REQ_STATE_SHUTDOWN
    RETURN
  ENDIF

 IF(wasopen)   /* got msg to LICON this (Uniconify this */
   openExpressScreen()
 ENDIF
ENDPROC


PROC displayInitialisingLogo()
  conCLS()
  conPuts('[ p')
  conPuts('[1;33m\n\n\n\n\n                               Express BBS[0m\n\n')
  conPuts('                             Initializing...')
ENDPROC

PROC checkShutDown()
  IF(shutDownFlag=1) 
    ReplyMsg(sdReplyRexx)
    reqState:=REQ_STATE_SHUTDOWN
    StrCopy(shutDownMsg,'!')
   ENDIF
  IF(shutDownFlag=2)
    ReplyMsg(sdReplyRexx)
    suspendBBS()
    IF reqState=REQ_STATE_SHUTDOWN THEN RETURN
    displayInitialisingLogo()
    reInitModem()
  ENDIF
  shutDownFlag:=0
ENDPROC


PROC displayScreen(screenType)
  DEF screenfile[255]:STRING
  DEF screencheck[255]:STRING
  DEF res
  res:=FALSE
  SELECT screenType
    CASE SCREEN_AWAIT
      StringF(screenfile,'\sAWAITSCREEN.TXT',nodeScreenDir)
      IF fileExists(screenfile) THEN res:=displayFile(screenfile)
    CASE SCREEN_BULL
      StringF(screencheck,'\s\s',cmds.bbsLoc,'BULL')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NODE_BULL
      StringF(screencheck,'\s\s',nodeScreenDir,'BULL')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_LOGOFF
      StringF(screencheck,'\s\s',nodeScreenDir,'LOGOFF')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_CONF_BULL
      StringF(screencheck,'\s\s',confScreenDir,'BULL')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_MENU
      StringF(screencheck,'\s\s',confScreenDir,'MENU')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_LOGON
      StringF(screencheck,'\s\s',nodeScreenDir,'LOGON')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_BBSTITLE
      StringF(screencheck,'\s\s',nodeScreenDir,'BBSTITLE')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_JOIN
      StringF(screencheck,'\s\s',nodeScreenDir,'JOIN')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_JOINED
      StringF(screencheck,'\s\s',nodeScreenDir,'JOINED')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_JOINCONF
      StringF(screencheck,'\s\s',nodeScreenDir,'JoinConf')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_DOWNLOAD
      StringF(screencheck,'\s\s',confScreenDir,'DownloadMsg')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_FILEHELP
      StringF(screencheck,'\s\s',confScreenDir,'FileHelp')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_UPLOAD
      StringF(screencheck,'\s\s',confScreenDir,'UploadMsg')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NEWUSERPW
      StringF(screencheck,'\s\s',nodeScreenDir,'NEWUSERPW')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NONEWUSERS
      StringF(screencheck,'\s\s',nodeScreenDir,'NONEWUSERS')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NONEWATBAUD
      StringF(screencheck,'\s\s\d',nodeScreenDir,'NONEWAT',onlineBaud)
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NOT_TIME
      StringF(screencheck,'\s\s\d',nodeScreenDir,'NOTTIME',onlineBaud)
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NOCALLERSATBAUD
      StringF(screencheck,'\s\s\d',nodeScreenDir,'NOCALLERSAT',onlineBaud)
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_GUESTLOGON
      StringF(screencheck,'\s\s',nodeScreenDir,'GUESTLOGON')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_LOCKOUT0
      StringF(screencheck,'\s\s',nodeScreenDir,'LOCKOUT0')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_LOCKOUT1
      StringF(screencheck,'\s\s',nodeScreenDir,'LOCKOUT1')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_PRIVATE
      StringF(screencheck,'\s\s',nodeScreenDir,'PRIVATE')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_ONENODE
      StringF(screencheck,'\s',cmds.bbsLoc,'OnlyOnOneNode')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_LOGON24
      StringF(screencheck,'\s',cmds.bbsLoc,'Logon24hrs')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
  ENDSELECT
ENDPROC res

PROC displayFile(filename, allowMCI=TRUE, resetNonStop=TRUE)
  DEF fh
  DEF firstline=TRUE
  DEF linedata[999]:STRING
  DEF len,res,stat,read,lf
  
  lineCount:=0

  StrCopy(mciterminator,'|')
  
  IF (resetNonStop) AND (state<>STATE_LOGGING_OFF) THEN nonStopDisplayFlag:=FALSE
  res:=FALSE

  IF (fh:=Open(filename,OLDFILE))>0
    res:=TRUE
    WHILE ((read:=Fgets(fh,linedata,999))<>NIL)
      len:=StrLen(linedata)-1
      IF linedata[len]="\n"
        SetStr(linedata,len)
        lf:=TRUE
      ELSE
        len++
        SetStr(linedata,len)
        lf:=FALSE
      ENDIF
      IF (firstline)
          IF len>0
            IF linedata[0]<>"~" THEN allowMCI:=FALSE
          ELSE
            allowMCI:=FALSE
          ENDIF
      ENDIF
      IF allowMCI
        processMci(linedata)
      ELSE
        aePuts(linedata)
      ENDIF
      stat:=RESULT_SUCCESS
      IF lf
        aePuts('\b\n')
        stat:=checkForPause()
      ENDIF
      EXIT (stat<>RESULT_SUCCESS) OR (reqState<>REQ_STATE_NONE)
      firstline:=FALSE
    ENDWHILE
    Close(fh)
  ENDIF
  aePuts('[0m')
ENDPROC res

PROC processRexxMessage()
  DEF rexxmsg: PTR TO rexxmsg
  DEF debugstr[255]:STRING
  DEF rexxstring:PTR TO CHAR
  DEF cmd

  debugLog(LOG_DEBUG,'rexx')
  
  rexxmsg,rexxstring:=rxGetMsg(rexxmp)
  WHILE(rexxmsg<>NIL)

    StringF(debugstr,'rexx message: \s',rexxstring)
    debugLog(LOG_DEBUG,debugstr)

		IF( strCmpi(rexxstring,'shutdown',8) )
			IF(shutDownFlag<>1)
				sdReplyRexx:=rexxmsg
				shutDownFlag:=1
        setEnvStat(ENV_SHUTDOWN)
			ELSE
				ReplyMsg(rexxmsg)
			ENDIF
			IF(state<>STATE_AWAIT)
				aePuts('\b\n\b\n  The BBS has recieved an emergency shutdown, you have 2 mins to logoff!!\b\n\b\n')
				timeLimit:=130
		  ENDIF
      RETURN
		ENDIF

		IF(strCmpi(rexxstring,'chat',4))
      sdReplyRexx:=rexxmsg
      ->rexxChatFlag:=1
      ->StrCopy(rexxChatMsg,rexxstring+4)
			IF(state<>STATE_AWAIT)
				aePuts(rexxstring+4)
        aePuts('\b\n')
        ->rexxChatFlag=0
			ENDIF
      ReplyMsg(rexxmsg)
		ELSEIF(strCmpi(rexxstring,'suspend',7))
			IF(shutDownFlag<>2) /* First suspend Notice */
				sdReplyRexx:=rexxmsg
				shutDownFlag:=2
        setEnvStat(ENV_SUSPEND)
			ELSE /* Already have a suspend pending! */
        /*if(rexxmsg->rm_Action&RXFF_RESULT)
					{
					rexxmsg->rm_Result1=1
					rexxmsg->rm_Result2=0
					}*/
				ReplyMsg(rexxmsg)
			ENDIF
    ELSEIF( strCmpi(rexxstring,'resume',6) )
			IF(state=STATE_SUSPEND) /* resume as soon as possible */
				ReplyMsg(rexxmsg)
				reqState:=REQ_STATE_RESUME
				shutDownFlag:=0
			ELSE /* fail these requests */
				ReplyMsg(rexxmsg)
      ENDIF

    ELSEIF( strCmpi(rexxstring,'getdata',7) )
       cmd:=Val(rexxstring+8)
       SELECT cmd
         CASE BB_CHATFLAG
           IF sysopAvail THEN rxReplyMsg(rexxmsg,0,'YES') ELSE rxReplyMsg(rexxmsg,0,'NO')
         DEFAULT
          rxReplyMsg(rexxmsg,0,'')
       ENDSELECT
    ELSEIF( strCmpi(rexxstring,'aesayln',7) )
      aePuts(rexxstring+8)
      aePuts('\b\n')
      rxReplyMsg(rexxmsg,0,'')
    ELSEIF( strCmpi(rexxstring,'aesay',5) )
      aePuts(rexxstring+6)
      rxReplyMsg(rexxmsg,0,'')
    ELSE
      rxReplyMsg(rexxmsg,0,'')
		ENDIF


    rexxmsg,rexxstring:=rxGetMsg(rexxmp)
  ENDWHILE
ENDPROC

PROC processCommodityMessage(signals)
  DEF msg, msgid, msgtype

  IF signals AND cxsigflag
  WHILE msg:=GetMsg(broker_mp)
      -> Extract any necessary information from the CxMessage and return it
      msgid:=CxMsgID(msg)
      msgtype:=CxMsgType(msg)
      ReplyMsg(msg)

      SELECT msgtype
      CASE CXM_IEVENT
        -> Shouldn't get any of these in this example
      CASE CXM_COMMAND
        -> Commodities has sent a command
        SELECT msgid
        CASE CXCMD_APPEAR
          debugLog(LOG_DEBUG,'CXCMD_APPEAR')
      openExpressScreen()
        CASE CXCMD_DISAPPEAR
      debugLog(LOG_DEBUG,'CXCMD_DISAPPEAR')
      closeExpressScreen()    
        CASE CXCMD_DISABLE
          debugLog(LOG_DEBUG,'CXCMD_DISABLE')
          -> The user clicked CX Exchange disable gadget, better disable
          ActivateCxObj(broker, FALSE)
        CASE CXCMD_ENABLE
          -> User clicked enable gadget
          debugLog(LOG_DEBUG,'CXCMD_ENABLE')
          ActivateCxObj(broker, TRUE)
        CASE CXCMD_KILL
          -> User clicked kill gadget, better quit
          debugLog(LOG_DEBUG,'CXCMD_KILL')
          reqState:=REQ_STATE_SHUTDOWN
        ENDSELECT
      DEFAULT
        debugLog(LOG_WARN,'Unknown msgtype')
      ENDSELECT
    ENDWHILE
  ENDIF
ENDPROC

PROC processWindowMessage(signals)
    -> If IDCMP messages received, handle them
    DEF winmsg:PTR TO intuimessage
    DEF windowsig
    DEF msgclass
    DEF win:PTR TO window

    IF windowClose<>NIL
      windowsig:=Shl(1, windowClose.userport.sigbit)
      win:=windowClose
    ELSEIF window<>NIL
      windowsig:=Shl(1, window.userport.sigbit)
      win:=window
    ELSE
      windowsig:=0
    ENDIF

    IF signals AND windowsig
      -> We have to ReplyMsg these when done with them
      WHILE winmsg:=GetMsg(win.userport)
        msgclass:=winmsg.class
        ReplyMsg(winmsg)
        SELECT msgclass
        CASE IDCMP_CLOSEWINDOW
          closeExpressScreen()        
        ENDSELECT
        EXIT window=NIL
      ENDWHILE
    ENDIF
ENDPROC

PROC initStatCon()
  IF statWriteMP=NIL THEN statWriteMP:=createPort(0,0)
  IF statWriteIO=NIL THEN statWriteIO:=createStdIO(statWriteMP)
  statWriteIO.data:=windowStat
  OpenDevice('console.device', 0, statWriteIO, 0)
ENDPROC

PROC clearStatusPane()
  DEF tempStr[255]:STRING,tempstr2[25]:STRING
  statMessage(1,1,'[37m[ s[0 p')

  statCursorTo(1,1)

  statPrint('0mLOGIN NAME     [34m|[0mREAL NAME      [34m|[0m  1[34m|[0m255[34m|[0mXXXXXXXXX[34m|[0m800-555-1212[34m|     |')
  statCursorTo(1,2)
  statPrint('[0mLOCATION                       [34m|[0m 0[34m|[0m 0[34m|[0m    0[34m|[0m    0[34m|[0m           0[34m|[0m           0[34m|   ')
  statCursorTo(1,3)
  formatLongDateTime(getSystemTime(),tempstr2)
  StringF(tempStr,'[0mTIME \s[25] [34m   |[0m       0[34m|[0m    0[34m|[0mLAST CALLED               [34m',tempstr2)
  statPrint(tempStr)
  statPrint('[0m')     /* and set text to normal */
  statParkCursor()

  StringF(tempStr,'\d[6]',cmds.openingBaud)
  statMessage(73,1,tempStr)
ENDPROC

PROC closeAEStats()
  IF statWriteIO<>NIL
    CloseDevice(statWriteIO)
    deleteStdIO(statWriteIO)
    statWriteIO:=NIL
  ENDIF
  IF statWriteMP<>NIL
    deletePort(statWriteMP)
    statWriteMP:=NIL
  ENDIF
  
 	IF(windowStat<>NIL) THEN CloseWindow(windowStat)
  windowStat:=NIL
ENDPROC

PROC toggleStatusDisplay()
  DEF dp,bp,tags

  IF screen=NIL THEN RETURN

  IF(dStatBar)
  	dStatBar:=0
	  closeAEStats()
      IF(bitPlanes)
        MoveWindow(window,0,-28)
	      SizeWindow(window,0,28)
	    ELSE
         MoveWindow(window,0,-38)
         SizeWindow(window,0,38)
      ENDIF
  	  IF (loggedOnUser<>NIL) AND (StrLen(loggedOnUser.name)>0) THEN statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
      ->//SetWindowTitles(MYwindow,titlebar,titlebar)
	ELSE

    IF(bitPlanes<2)
      dp:=1
		  bp:=1
    ELSE
      dp:=3
      bp:=4
    ENDIF

    tags:=NEW [WA_CUSTOMSCREEN,screen,
       WA_LEFT,0,
       WA_TOP,10,
       WA_WIDTH,640,
       WA_HEIGHT,30,
       WA_DETAILPEN,dp,
       WA_BLOCKPEN,bp,
       WA_FLAGS,
       WFLG_SIMPLE_REFRESH,NIL]
    IF(( windowStat:=OpenWindowTagList(NIL,tags))<>NIL)

      dStatBar:=1
      IF(bitPlanes)
        SizeWindow(window,0,-28)
        MoveWindow(window,0,28)
      ELSE
        SizeWindow(window,0,-38)
        MoveWindow(window,0,38)
      ENDIF
     
      initStatCon()
      clearStatusPane()
      SetWindowTitles(window,titlebar,titlebar)
      IF (loggedOnUser<>NIL) AND (StrLen(loggedOnUser.name)>0) THEN statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
      statChatFlag()
    ENDIF
    END tags
	ENDIF
   ->//SetWindowTitles(MYwindow,titlebar,titlebar)
ENDPROC

PROC checkIncomingCall()
  DEF rCount,input
  DEF string[255]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF stat,n,isConnected=FALSE
  DEF filetags
   
    IF(sopt.trapDoor) THEN JUMP go

    rCount:=ringCount
  
    IF (rCount=-1) THEN rCount:=2
    StringF(string,'ringcount: \d',rCount)
    debugLog(LOG_DEBUG,string)

	  ioFlags[IOFLAG_SER_IN]:=-1
	  ioFlags[IOFLAG_SER_OUT]:=0

    StrCopy(hostName,'')
    StrCopy(hostIP,'')

    WHILE(rCount)
		  stat:=lineInput('','',80,5,string)
      IF stat<>RESULT_SUCCESS THEN RETURN
      
      IF StrLen(string)>0
        IF InStr(string,'HOST NAME')>=0
          IF (n:=InStr(string,'='))<>-1
            StrCopy(hostName,TrimStr(string+n+1))
          ENDIF
        ENDIF
        IF InStr(string,'HOST IP ADDR')>=0
          IF (n:=InStr(string,'='))<>-1
            StrCopy(hostIP,TrimStr(string+n+1))
          ENDIF
        ENDIF
        IF(stringCompare(string,cmds.mRing))=RESULT_SUCCESS THEN rCount--
      ENDIF
    ENDWHILE
    IF(rCount) THEN RETURN
          
    IF(sopt.toggles[TOGGLES_CALLERID] OR sopt.toggles[TOGGLES_CALLERIDNAME])    
      lineInput('','',14,5,idRate)
      lineInput('','',14,5,idTime)
      lineInput('','',14,5,idDate)
      lineInput('','',40,5,idNmbr)
      IF(sopt.toggles[TOGGLES_CALLERIDNAME]) THEN lineInput('','',40,5,idName)
      callerIDLog(1)
    ENDIF
		/* OTHERWISE EQUAL, ANSWER AND SET BAUDS */
go: 
		statClearTime()
	  ->ioFlags[IOFLAG_SER_OUT]:=1
/*(JOE)---- added this v*/
    IF(sopt.trapDoor=FALSE)
      StringF(string,'\s\b',cmds.mAnswer)
      serPuts(string)
      n:=0
      IF(input=RESULT_TIMEOUT) THEN JUMP timedout
      REPEAT
        input:=lineInput('','',80,40,string)
        IF(input=RESULT_TIMEOUT) THEN JUMP timedout
        IF (StrCmp(string,'CONNECT',7))
          isConnected:=TRUE
        ELSEIF (StrLen(string)>0) AND (StrCmp(string,cmds.mRing,ALL)=FALSE) AND (StrCmp(string,cmds.mAnswer,ALL)=FALSE)
          n++
          StringF(tempstr,'\tINVALID CONNECT	= \s',string)
          callersLog(tempstr)
        ENDIF
      UNTIL((isConnected) OR (n=5))
      IF isConnected=FALSE THEN JUMP timedout
    ELSE
      strCpy(string,trapConnect,ALL)
    ENDIF
    StrCopy(connectString,string)
		IF(sopt.trapDoor)
            ->//CutConnect(string)
		  IF(input=RESULT_TIMEOUT) THEN JUMP timedout
    ENDIF
     
    stripReturn(string)
    readToolType(TOOLTYPE_CONNECT,node,string,connectString)
    
    IF(StrCmp(connectString,'CONNECT',7))
      onlineBaud:=Val(connectString+7)
      onlineBaudR:=cmds.openingBaud
      IF onlineBaud=0 THEN onlineBaud:=cmds.openingBaud
      IF StrLen(connectString)=7 THEN StringF(connectString,'CONNECT \d',onlineBaud)

      ioFlags[IOFLAG_SER_OUT]:=-1
      ioFlags[IOFLAG_SCR_OUT]:=-1
      IF(cmds.acLvl[LVL_VARYING_LINK_RATE]=1) THEN setBaud(onlineBaud)

      IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ON_CONNECT',tempstr))
        filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,NIL]:LONG
        processMci2(tempstr,tempstr2)
        SystemTagList(tempstr2,filetags)
        END filetags
      ENDIF

      IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ASYNC_ON_CONNECT',tempstr))
        filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,TRUE,NIL]:LONG
        processMci2(tempstr,tempstr2)
        SystemTagList(tempstr2,filetags)
        END filetags
      ENDIF

      conCLS()

      RETURN RESULT_CONNECT
    ENDIF
	  
    onlineBaud:=cmds.openingBaud 
    setEnvStat(ENV_AWAITCONNECT)
 

timedout:
	  dropDTR()
	  Delay(25)
	  IF(cmds.acLvl[LVL_VARYING_LINK_RATE]=1)
 		  setBaud(cmds.openingBaud)
	    Delay(25)
		ENDIF
 	  intDoReset(cmds.mReset)
 	  serPutChar("\b")
	  Delay(25)
	  purgeLine()
 		ioFlags[IOFLAG_SER_IN]:=0
 		ioFlags[IOFLAG_SER_OUT]:=0

ENDPROC RESULT_SUCCESS

PROC reserveForUser()
  DEF stat
  DEF str[34]:STRING

reserveRedo:
 aePuts('\b\n[0mEnter username to reserve for: ')
 stat:=lineInput('','',30,INPUT_TIMEOUT,str)
 IF((stat<0) OR (StrLen(str)=0)) THEN RETURN
 
 stat:=chooseAName(str,tempUser,tempUserKeys,tempUserMisc,0)
 IF(stat<RESULT_FAILURE) THEN	RETURN
 IF(stat=RESULT_FAILURE) THEN JUMP reserveRedo
 StrCopy(reservedName,tempUserKeys.userName)
ENDPROC

PROC processInputMessage(timeout, extsig = 0)
    DEF consolesig=0,windowsig=0,obuf[255]:STRING
    DEF ch=0,lch,wasControl=0,signals
    DEF doorsig=0,rexxsig=0,serialsig=0,timersig=0,timedout=0
    DEF temp[255]:STRING

    IF loggedOnUser<>NIL THEN statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
 
    IF consoleReadMP<>NIL THEN consolesig:=Shl(1, consoleReadMP.sigbit)
    IF serialReadMP<>NIL THEN serialsig:=Shl(1, serialReadMP.sigbit)
    
    IF windowClose<>NIL
       windowsig:=Shl(1, windowClose.userport.sigbit)
    ELSEIF window<>NIL
       windowsig:=Shl(1, window.userport.sigbit)
    ENDIF


    IF resmp<>NIL THEN doorsig:=Shl(1, resmp.sigbit)
    IF rexxmp<>NIL THEN rexxsig:=Shl(1, rexxmp.sigbit)

-> A character, or an IDCMP msg, or both could wake us up
    IF checkSer() 
      signals:=serialsig
    ELSEIF checkCon()
      signals:=consolesig
    ELSE
      IF timeout<>0
        openTimer()
        timeout:=Mul(timeout,1000000)
        setTimer(timeout)
        IF timerport<>NIL THEN timersig:=Shl(1, timerport.sigbit)
      ENDIF

      signals:=Wait(SIGBREAKF_CTRL_C OR consolesig OR windowsig OR cxsigflag OR doorsig OR rexxsig OR serialsig OR timersig OR extsig)
      timedout:=(timersig<>0) AND ((signals AND timersig)<>0)
      IF timedout THEN waitTime()
      closeTimer()
    ENDIF

    IF (extsig<>0) AND ((signals AND extsig)<>0) THEN RETURN TRUE,RESULT_SIGNALLED

  IF (timedout)
    IF (state<>STATE_AWAIT) THEN callersLog('\t**Input timed out **')
    IF timeoutLC THEN lostCarrier:=TRUE
    RETURN TRUE,RESULT_TIMEOUT
  ENDIF

  wasControl:=0
  ch:=0    

  IF state=STATE_LOGGING_OFF
    RETURN wasControl,ch
  ENDIF

  IF signals AND SIGBREAKF_CTRL_C
    debugLog(LOG_DEBUG,'CTRL-C detected')
    reqState:=REQ_STATE_SHUTDOWN
  ENDIF

  processWindowMessage(signals)
  processCommodityMessage(signals)
  IF (signals AND rexxsig) THEN processRexxMessage()
  IF (signals AND doorsig) THEN checkDoorMsg(1)
  
  IF signals AND serialsig
    IF -1<>(lch:=readMayGetChar(serialReadMP,{serbuff}))
      IF (ioFlags[IOFLAG_SER_IN])
        ch:=lch
        wasControl:=FALSE
        ->StringF(obuf, 'Serial Received: hex $\z\h[2] = \c', ch, ch)
        ->debugLog(LOG_DEBUG,obuf)

        IF ch=$1b
          ch:=readMayGetChar(serialReadMP,{serbuff})
          IF ch="["
            ch:=readMayGetChar(serialReadMP,{serbuff})

            IF (ch>="A") AND (ch<="D")
             wasControl:=1
               SELECT ch
                 CASE "A"
                   IF rawArrow THEN wasControl:=0
                   ch:=UPARROW
                 CASE "B"
                   IF rawArrow THEN wasControl:=0
                   ch:=DOWNARROW
                 CASE "C"
                   IF rawArrow THEN wasControl:=0
                   ch:=RIGHTARROW
                 CASE "D"
                   IF rawArrow THEN wasControl:=0 
                   ch:=LEFTARROW
               ENDSELECT
            ENDIF
          ENDIF
        ENDIF
      ENDIF
    ENDIF
  ELSEIF signals AND consolesig
  -> If a console signal was received, get the character
    IF -1<>(lch:=readMayGetChar(consoleReadMP, {ibuf}))
      IF (ioFlags[IOFLAG_KBD_IN])
        ch:=lch

        IF ((ch>=$1F) AND (ch<=$7E)) OR (ch>=$A0)
          StringF(obuf, 'Received: hex $\z\h[2] = \c inControl=\d\b\n', ch, ch,inControl)
        ELSE
          StringF(obuf, 'Received: hex $\z\h[2] \d', ch,inControl)
        ENDIF
        debugLog(LOG_DEBUG,obuf)

        IF ch=$9B
          ch:=readMayGetChar(consoleReadMP, {ibuf})
            StringF(obuf, 'Received control: hex $\z\h[2] \d', ch,ch)
            debugLog(LOG_DEBUG,obuf)
            lch:=readMayGetChar(consoleReadMP, {ibuf})
            StringF(obuf, 'Received control: hex $\z\h[2] \d', lch,lch)
            debugLog(LOG_DEBUG,obuf)
          IF (ch="1") AND (lch<>$7E)
            ch:=lch
            lch:=readMayGetChar(consoleReadMP, {ibuf})
            StringF(obuf, 'Received control: hex $\z\h[2] \d', lch,lch)
            debugLog(LOG_DEBUG,obuf)
            IF lch=$7e
              wasControl:=2
            ENDIF
          ELSEIF lch=$7e
            wasControl:=1
          ELSEIF (ch>="A") AND (ch<="D") AND (lch=-1)
             wasControl:=1
               SELECT ch
                 CASE "A"
                   IF rawArrow THEN wasControl:=0
                   ch:=UPARROW
                 CASE "B"
                   IF rawArrow THEN wasControl:=0
                   ch:=DOWNARROW
                 CASE "C"
                   IF rawArrow THEN wasControl:=0
                   ch:=RIGHTARROW
                 CASE "D"
                   IF rawArrow THEN wasControl:=0 
                   ch:=LEFTARROW
               ENDSELECT
          ENDIF
        ENDIF     
      ENDIF
    ENDIF
  ENDIF

  IF (state=STATE_AWAIT)
    IF servercmd=SV_UNICONIFY
      IF scropen THEN expressToFront() ELSE openExpressScreen()
      reqState:=REQ_STATE_DISPLAY_AWAIT
    ENDIF

    -> F1
    IF (servercmd=SV_SYSOPLOG) OR ((wasControl=1) AND (ch="0"))
      debugLog(LOG_DEBUG,'SYSOP LOGON')
      statClearTime()
      StrCopy(connectString,'SYSOP_LOCAL')
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      ioFlags[IOFLAG_SCR_OUT]:=-1
      onlineBaud:=cmds.openingBaud
      onlineBaudR:=cmds.openingBaud
      reqState:=REQ_STATE_SYSOPLOGON
    ENDIF
  
    -> F2
    IF (servercmd=SV_LOCALLOG) OR ((wasControl=1) AND (ch="1"))
      debugLog(LOG_DEBUG,'LOCAL LOGON')
      statClearTime()
      StrCopy(connectString,'F2_LOCAL')
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      ioFlags[IOFLAG_SCR_OUT]:=-1
      onlineBaud:=cmds.openingBaud
      onlineBaudR:=cmds.openingBaud
      logonType:=LOGON_TYPE_LOCAL
      reqState:=REQ_STATE_LOGON
    ENDIF

    ->F4
    IF (servercmd=SV_LOCALLOG) OR ((wasControl=1) AND (ch="3"))
    
    	IF(StrLen(reservedName)>0)
        StrCopy(reservedName,'')
			ELSE
 				ioFlags[IOFLAG_SER_IN]:=0
	    	ioFlags[IOFLAG_SER_OUT]:=0
		    ioFlags[IOFLAG_SCR_OUT]:=-1
			  ioFlags[IOFLAG_KBD_IN]:=-1
				timeLimit:=3600
				intDoReset(sopt.offHook)
				conPuts('[ p')
        conCLS()
 				reserveForUser()
	    	resetSystem(1)
		    ioFlags[IOFLAG_SER_IN]:=-1
			  ioFlags[IOFLAG_SCR_OUT]:=0
        setEnvStat(ENV_RESERVE)
			ENDIF
      IF reqState=REQ_STATE_NONE THEN reqState:=REQ_STATE_DISPLAY_AWAIT
    ENDIF
    
    ->F5
    IF ((wasControl=1) AND (ch="4"))
      servercmd:=-1
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      aePuts('[ p')
      sendCLS()
      onlineBaud:=cmds.openingBaud
      onlineBaudR:=cmds.openingBaud
      timeLimit:=3600
      logonType:=LOGON_TYPE_LOCAL
      loggedOnUser:=NEW loggedOnUser
      loggedOnUserKeys:=NEW loggedOnUserKeys
      loggedOnUserMisc:=NEW loggedOnUserMisc
      loadAccount(1,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
      masterLoadPointers(loggedOnUser)
      conferenceMaintenance()
      END loggedOnUser
      END loggedOnUserKeys
      END loggedOnUserMisc
      loggedOnUser:=NIL
      loggedOnUserMisc:=NIL
      loggedOnUserKeys:=NIL
      ioFlags[IOFLAG_SER_IN]:=-1
      ioFlags[IOFLAG_SCR_OUT]:=0
      IF(ioFlags[IOFLAG_FIL_IN]) THEN ioFlags[IOFLAG_FIL_IN]:=0
      IF reqState=REQ_STATE_NONE THEN reqState:=REQ_STATE_DISPLAY_AWAIT
    ENDIF

    ->Shift F5
    IF ((wasControl=2) AND (ch="4"))
      servercmd:=-1
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      intDoReset(sopt.offHook)
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      sendCLS()
      remoteShell()
      resetSystem(1)
      ioFlags[IOFLAG_SER_IN]:=-1
      ioFlags[IOFLAG_SCR_OUT]:=0
      IF(ioFlags[IOFLAG_FIL_IN]) THEN ioFlags[IOFLAG_FIL_IN]:=0
      IF reqState=REQ_STATE_NONE THEN reqState:=REQ_STATE_DISPLAY_AWAIT
    ENDIF

    ->F6
    IF (servercmd=SV_ACCOUNTS) OR ((wasControl=1) AND (ch="5"))
      servercmd:=-1
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      intDoReset(sopt.offHook)
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      aePuts('[ p')
      sendCLS()
      onlineBaud:=cmds.openingBaud
      onlineBaudR:=cmds.openingBaud
      timeLimit:=3600
      logonType:=LOGON_TYPE_LOCAL
      loggedOnUser:=NEW loggedOnUser
      loggedOnUserKeys:=NEW loggedOnUserKeys
      loggedOnUserMisc:=NEW loggedOnUserMisc
      loadAccount(1,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
      masterLoadPointers(loggedOnUser)
      editAccounts(FALSE)
      END loggedOnUser
      END loggedOnUserKeys
      END loggedOnUserMisc
      loggedOnUser:=NIL
      loggedOnUserMisc:=NIL
      loggedOnUserKeys:=NIL
      resetSystem(1)
      ioFlags[IOFLAG_SER_IN]:=-1
      ioFlags[IOFLAG_SCR_OUT]:=0
      IF(ioFlags[IOFLAG_FIL_IN]) THEN ioFlags[IOFLAG_FIL_IN]:=0
      IF reqState=REQ_STATE_NONE THEN reqState:=REQ_STATE_DISPLAY_AWAIT
    ENDIF

    ->Shift F6
    IF ((wasControl=2) AND (ch="5"))
      servercmd:=-1
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      intDoReset(sopt.offHook)
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      sendCLS()
      StringF(temp,'\sNode\d/Callerslog',cmds.bbsLoc,node)
      logonType:=LOGON_TYPE_LOCAL
      loggedOnUser:=NEW loggedOnUser
      loggedOnUserKeys:=NEW loggedOnUserKeys
      loggedOnUserMisc:=NEW loggedOnUserMisc
      loadAccount(1,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
      masterLoadPointers(loggedOnUser)
      displayCallersLog(temp,FALSE)
      END loggedOnUser
      END loggedOnUserKeys
      END loggedOnUserMisc
      loggedOnUser:=NIL
      loggedOnUserMisc:=NIL
      loggedOnUserKeys:=NIL   
      resetSystem(1)
      ioFlags[IOFLAG_SER_IN]:=-1
      ioFlags[IOFLAG_SCR_OUT]:=0
      IF(ioFlags[IOFLAG_FIL_IN]) THEN ioFlags[IOFLAG_FIL_IN]:=0
      IF reqState=REQ_STATE_NONE THEN reqState:=REQ_STATE_DISPLAY_AWAIT
    ENDIF

    ->F7
    IF ((wasControl=1) AND (ch="6"))
      sysopAvail:=Not(sysopAvail)
      updateTitle(NIL)
      statChatFlag()
    ENDIF

    ->F8
	  IF ((wasControl=1) AND (ch="7"))
 			reInitModem()
			resetSystem(1)
    ENDIF

    ->F9
    IF (servercmd=SV_EXITNODE) OR ((wasControl=1) AND (ch="8"))
      reqState:=REQ_STATE_SHUTDOWN
    ENDIF
    ->F10
    IF (servercmd=SV_NODEOFFHOOK) OR ((wasControl=1) AND (ch="9"))
      reqState:=REQ_STATE_SHUTDOWN_OFFHOOK
    ENDIF

    IF ((wasControl=1) AND (ch="?"))
      toggleStatusDisplay()
    ENDIF
  ENDIF

  IF ((state=STATE_LOGGEDON) OR (state=STATE_CONNECTING)) AND (nofkeys=FALSE)
    IF servercmd=SV_UNICONIFY
      IF scropen THEN expressToFront() ELSE openExpressScreen()
    ENDIF

    ->F1
    IF (servercmd=SV_CHAT) OR ((wasControl=1) AND (ch="0"))
      IF scropen THEN expressToFront() ELSE openExpressScreen()
      ch:=13
      wasControl:=FALSE
      chatF:=1
      chatFlag:=Not(chatFlag)
      IF (chatFlag<>0)
        setEnvStat(ENV_CHAT)
        IF(chat()=RESULT_NO_CARRIER)	THEN reqState:=REQ_STATE_LOGOFF
      ENDIF

    ENDIF

    ->F2 - increase time limit
    IF ((wasControl=1) AND (ch="1") AND (loggedOnUser<>NIL))
      timeLimit:=timeLimit+600
      loggedOnUser.timeTotal:=loggedOnUser.timeTotal+600
    ENDIF
              
    ->F3 - decrease time limit
    IF ((wasControl=1) AND (ch="2") AND (loggedOnUser<>NIL))
      timeLimit:=timeLimit-600
      loggedOnUser.timeTotal:=loggedOnUser.timeTotal-600
    ENDIF

    ->F4 - capture
    IF ((wasControl=1) AND (ch="3"))
      startCapture()
    ENDIF

    ->Shift F4 - display file to user  
    IF ((wasControl=2) AND (ch="3")) 
      startASend()
      RETURN TRUE,RESULT_ABORT
    ENDIF

    ->F6 - account edit
    IF (servercmd=SV_ACCOUNTS) OR ((wasControl=1) AND (ch="5") AND (loggedOnUser<>NIL))
      doOnLineEdit(TRUE)
      checkUserOnLine(loggedOnUser,0)
      convertAccess()
    ENDIF

    ->Shift F6 - grant/remove temporary access
    IF ((wasControl=2) AND (ch="5")) 
	    IF(tempAccessGranted)
 					loggedOnUser.secStatus:=tempAccess.accessLevel;
	    		loggedOnUser.secBoard:=tempAccess.ratioType;
		    	loggedOnUser.secLibrary:=tempAccess.ratio;
			    loggedOnUser.timeTotal:=tempAccess.timeTotal;
				  strCpy(loggedOnUser.conferenceAccess,tempAccess.confAc,10)
					statPrintUser(loggedOnUser,loggedOnUserMisc,loggedOnUserKeys)
			ELSE
 					tempAccess.accessLevel:=loggedOnUser.secStatus
	    		tempAccess.ratioType:=loggedOnUser.secBoard
		    	tempAccess.ratio:=loggedOnUser.secLibrary
			    tempAccess.timeTotal:=loggedOnUser.timeTotal
				  strCpy(tempAccess.confAc,loggedOnUser.conferenceAccess,10)
          doOnLineEdit(TRUE)
          convertAccess()
			ENDIF
 			tempAccessGranted:=Not(tempAccessGranted)
	    conPuts('\b\nTemporary Access ')
		  conPuts((IF tempAccessGranted THEN 'Granted\b\n' ELSE 'Removed\b\n'))		
    ENDIF

    ->F7
    IF ((wasControl=1) AND (ch="6"))
      sysopAvail:=Not(sysopAvail)
      statChatFlag()
    ENDIF
    
    ->F8 - toggle SER-OUT
    IF ((wasControl=1) AND (ch="7"))
      IF logonType>=LOGON_TYPE_REMOTE THEN ioFlags[IOFLAG_SER_OUT]:=Not(ioFlags[IOFLAG_SER_OUT])
    ENDIF
    
    ->F9 - toggle SER-INT
    IF ((wasControl=1) AND (ch="8"))
      IF logonType>=LOGON_TYPE_REMOTE THEN ioFlags[IOFLAG_SER_IN]:=Not(ioFlags[IOFLAG_SER_IN])
    ENDIF

    ->F10
    IF ((wasControl=1) AND (ch="9"))
      dropDTR()
      ioFlags[IOFLAG_SER_OUT]:=0
      saveFlagged()
      IF StrLen(historyFolder)>0 THEN saveHistory()
      reqState:=REQ_STATE_LOGOFF
      setEnvStat(ENV_LOGOFF)
    ENDIF

    ->HELP
    IF ((wasControl=1) AND (ch="?"))
      toggleStatusDisplay()
    ENDIF
  ENDIF
  servercmd:=-1

  checkShutDown()
 
ENDPROC wasControl, ch

PROC loadAccount(slot,userPtr, userKeysPtr, userMiscPtr)
  DEF l,fh
  DEF result

  result:=RESULT_SUCCESS
  l:=SIZEOF user
  IF (fh:=Open(userDataFile,OLDFILE))>0
    Seek(fh,(slot-1)*l,OFFSET_BEGINNING)
    IF Read(fh,userPtr,l)<>l THEN result:=RESULT_FAILURE
    Close(fh)
  ELSE
    result:=RESULT_FAILURE
  ENDIF    

  IF (userKeysPtr<>NIL)
    l:=SIZEOF userKeys
    IF (fh:=Open(userKeysFile,OLDFILE))>0
      Seek(fh,(slot-1)*l,OFFSET_BEGINNING)
      IF Read(fh,userKeysPtr,l)<>l THEN result:=RESULT_FAILURE
      Close(fh)
    ELSE
      result:=RESULT_FAILURE
    ENDIF    
  ENDIF

  IF (userMiscPtr<>NIL)
    l:=SIZEOF userMisc
    IF (fh:=Open(userMiscFile,OLDFILE))>0
      Seek(fh,(slot-1)*l,OFFSET_BEGINNING)
      IF Read(fh,userMiscPtr,l)<>l THEN result:=RESULT_FAILURE
      Close(fh)
    ELSE
      result:=RESULT_FAILURE
    ENDIF
  ENDIF
ENDPROC result

/* if flg > 0 then force save account */
PROC saveAccount(hoozer: PTR TO user, hoozer2: PTR TO userKeys, hoozer3: PTR TO userMisc,uslot,flg)
  DEF slot,stat
  DEF fh,l
  DEF tempStr[255]:STRING

  IF((onlineEdit) AND (logonType>=LOGON_TYPE_REMOTE))
    StringF(tempStr,'\tSaved account \d[4] \s',hoozer.slotNumber,hoozer.name)
    callersLog(tempStr)
  ENDIF
 
  IF(flg)                /* Force Save User Account */
     uslot--
     slot:=uslot
  ELSE
     IF(hoozer.slotNumber=0) THEN RETURN RESULT_FAILURE
     slot:=hoozer.slotNumber-1
  ENDIF

  l:=SIZEOF user

  fh:=Open(userDataFile,MODE_READWRITE)
  IF(fh<=0) THEN RETURN RESULT_FAILURE
  
  Seek(fh,slot*l,OFFSET_BEGINNING)

  stat:=Write(fh,hoozer,l)
  IF(stat<>l)
    Close(fh)
    RETURN RESULT_FAILURE
  ENDIF

  Close(fh)

  l:=SIZEOF userKeys
  fh:=Open(userKeysFile,MODE_READWRITE)
  IF(fh<=0) THEN RETURN RESULT_FAILURE

  Seek(fh,slot*l,OFFSET_BEGINNING)

  IF(hoozer.newUser)  THEN hoozer2.newUser:=1 ELSE hoozer2.newUser:=0

  stat:=Write(fh,hoozer2,l)
  IF(stat<>l)
    Close(fh)
    RETURN RESULT_FAILURE
  ENDIF

  Close(fh)

  IF (hoozer3<>NIL)
    l:=SIZEOF userMisc
    fh:=Open(userMiscFile,MODE_READWRITE)
    IF(fh<=0) THEN RETURN RESULT_FAILURE

    Seek(fh,slot*l,OFFSET_BEGINNING)

    stat:=Write(fh,hoozer3,l)
    IF(stat<>l)
      Close(fh)
      RETURN RESULT_FAILURE
    ENDIF

    Close(fh)
  ENDIF
ENDPROC RESULT_SUCCESS

PROC processLoggingOff()
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF i
  DEF filetags

  pagedFlag:=FALSE
  chatFlag:=FALSE
  allowOLM:=TRUE
  quietFlag:=FALSE
  nonStopDisplayFlag:=TRUE
  
  setEnvStat(ENV_LOGOFF)
  IF(captureFP) 
    Close(captureFP)
    captureFP:=NIL
  ENDIF
  
  checkOnlineStatus()
  StrCopy(flaglist,'')
  
  IF ListLen(olmBuf)>0
    FOR i:=0 TO ListLen(olmBuf)-1
      DisposeLink(olmBuf[i])
    ENDFOR
    SetList(olmBuf,0)
  ENDIF

  IF ListLen(olmQueue)>0
    FOR i:=0 TO ListLen(olmQueue)-1
      DisposeLink(olmQueue[i])
    ENDFOR
    SetList(olmQueue,0)
  ENDIF
  
  FOR i:=0 TO ListLen(historyBuf)-1
    DisposeLink(ListItem(historyBuf,i))
  ENDFOR
  SetList(historyBuf,0)
  historyNum:=0
  historyCycle:=0

  IF loggedOnUser<>NIL

    IF lostCarrier
      logoffLog('Loss Carrier')
    ELSE
      logoffLog('N')
    ENDIF
      
    IF tempAccessGranted
      loggedOnUser.secStatus:=tempAccess.accessLevel
      loggedOnUser.secBoard:=tempAccess.ratioType
      loggedOnUser.secLibrary:=tempAccess.ratio;
      loggedOnUser.timeTotal:=tempAccess.timeTotal
      strCpy(loggedOnUser.conferenceAccess,tempAccess.confAc,10)
      tempAccessGranted:=FALSE
    ENDIF

    updateTimeUsed()
    clearUser()

    IF(quickFlag=FALSE)
      checkScreenClear()
      IF(logonType<>LOGON_TYPE_SYSOP) THEN displayScreen(SCREEN_LOGOFF)
    ENDIF
   
    IF(logonType<>LOGON_TYPE_SYSOP) THEN aePuts('\b\nClick...')

    strCpy(loggedOnUserKeys.userName,loggedOnUser.name,31)
    UpperStr(loggedOnUserKeys.userName)
    loggedOnUserKeys.number:=loggedOnUser.slotNumber

    IF(newSinceFlag) THEN loggedOnUser.newSinceDate:=getSystemTime()

    saveMsgPointers(currentConf)
    
    loggedOnUser.timeLastOn:=getSystemTime()
    addMsgPointers()
    masterSavePointers(loggedOnUser)
    saveAccount(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,0,0) /* Reseave users account after logoff */

    IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ON_LOGOFF',tempstr))
      filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,NIL]:LONG
      processMci2(tempstr,tempstr2)
      SystemTagList(tempstr2,filetags)
      END filetags
    ENDIF

    IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ASYNC_ON_LOGOFF',tempstr))
      filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,TRUE,NIL]:LONG
      processMci2(tempstr,tempstr2)
      SystemTagList(tempstr2,filetags)
      END filetags
    ENDIF

    IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_LOGOFF')) AND (StrLen(mailOptions.sysopEmail)>0)
      StringF(tempstr,'\s: Ami-Express logoff notification',cmds.bbsName)
      StringF(tempstr2,'This is a notification that \s from \s has logged off\n\n',loggedOnUser.name,loggedOnUser.location)
      sendMail(tempstr,tempstr2,TRUE, mailOptions.sysopEmail)
    ENDIF
    
    StrCopy(reservedName,'')
    
    IF (relogon)
      processSysCommand('RELOGON')
      StringF(tempstr,'RELOGON\d',node)
      processSysCommand(tempstr)
    ENDIF

    processSysCommand('LOGOFF')
    StringF(tempstr,'LOGOFF\d',node)
    processSysCommand(tempstr)

    END loggedOnUser
    END loggedOnUserKeys
    END loggedOnUserMisc
  ENDIF
  loggedOnUser:=NIL
  loggedOnUserKeys:=NIL
  loggedOnUserMisc:=NIL
  sendQuietFlag(quietFlag)
  Delay(50)
  stateData:=0

  quickFlag:=FALSE
  ansiColour:=TRUE
  my_struct.ansiColor:=-1

  IF (relogon=FALSE)
    state:=STATE_AWAIT

   IF(cmds.acLvl[LVL_SCREEN_TO_FRONT] AND scropen) THEN expressToBack()
    dropDTR()
  ELSE
    state:=STATE_LOGON
    relogon:=FALSE
  ENDIF

  IF sopt.trapDoor THEN reqState:=REQ_STATE_SHUTDOWN
ENDPROC

PROC myDirProtect(bits,ps: PTR TO CHAR)
  DEF c,x,y
  DEF pbits
  pbits:=["d","e","w","r","a","p","s","h" ]:CHAR

  y:=1
  c:=Eor(bits,15)

  FOR x:=0 TO 7
    IF((c AND y)=y)	THEN ps[7-x]:=pbits[x]
    y:=Shl(y,1)
  ENDFOR
ENDPROC


PROC myDirDisplay(f_info: PTR TO fileinfoblock)
  DEF t,h,m,s
  DEF ans[10]:STRING
  DEF date[20]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

  t:=Mul(f_info.datestamp.days+2914,86400)
  t:=t+(Mul(f_info.datestamp.minute,60))
  t:=t+712800
  h:=(Div(f_info.datestamp.minute,60))
  m:=((f_info.datestamp.minute)-(Mul(h,60)))
  s:=(Div(f_info.datestamp.tick,50))
  t:=t+s
  t:=t-21601

  formatLongDateTime(t,date)
  
  t:=t+21601
  StrCopy(ans,'--------')
  myDirProtect(f_info.protection,ans)
 
  IF(f_info.entrytype<=0)
    StringF(tempstr,'\d[8]',f_info.size)
  ELSE
    StrCopy(tempstr,'     Dir')
  ENDIF
 
  StringF(tempstr2,' \l\s[25] \s \s \s \r\z\d[2]:\r\z\d[2]:\r\z\d[2]\b\n',f_info.filename,tempstr,ans,date,h,m,s)
  aePuts(tempstr2)
ENDPROC

PROC myDirRecurse(path: PTR TO CHAR,cflag)
  DEF stat=0
  DEF lock
  DEF f_info: PTR TO fileinfoblock
  DEF tempstr[255]:STRING
 
  f_info:=AllocDosObject(DOS_FIB,NIL)
  IF(f_info)=NIL THEN RETURN
 
  lock:=Lock(path,ACCESS_READ)
  IF(lock)=0
  	FreeDosObject(DOS_FIB,f_info)
 	  RETURN
 	ENDIF
 
  IF(Examine(lock,f_info))=0
    StringF(tempstr,'\s does not exist\b\n',path)
    aePuts(tempstr)
    UnLock(lock)
    FreeDosObject(DOS_FIB,f_info)
    RETURN
 	ENDIF
 
  lineCount:=0
  IF(f_info.entrytype>0)
  	StringF(tempstr,'Directory of \s\b\n',path)
 	  aePuts(tempstr)
 
  	WHILE(((ExNext(lock,f_info))<>0) AND(stat=FALSE))
  		myDirDisplay(f_info)
 	    stat:=checkForPause()
 		  IF(cflag AND (stat=FALSE) AND (StrLen(f_info.comment)>0))
  		  aePuts(' : ')
 	      aePuts(f_info.comment)
 		    aePuts('\b\n')
 			  stat:=checkForPause()
      ENDIF
    ENDWHILE
 	ELSE
    myDirDisplay(f_info)
  ENDIF
 
  UnLock(lock)
  FreeDosObject(DOS_FIB,f_info)
ENDPROC


PROC myDirAnyWhere(params)
  DEF stat,comments=0
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

  nonStopDisplayFlag:=FALSE

  aePuts('\b\n')
  parseParams(params)

  IF(ListLen(parsedParams)>0)
  	StrCopy(tempstr,parsedParams[0])
 	  IF ListLen(parsedParams)>1
      IF strCmpi(parsedParams[1],'c',1) THEN comments:=1
    ENDIF
  ELSE
    comments:=1
 	  aePuts('FullPath for directory? ')
 	  stat:=lineInput('','',250,INPUT_TIMEOUT,tempstr)
 	  IF((stat<0) OR (StrLen(tempstr)=0))	
      aePuts('\b\n')
 	  	RETURN
    ENDIF
  
    IF(findAssign(tempstr))
      aePuts('\b\nDevice not Mounted.\b\n')
      aePuts('\b\n')
      RETURN
    ENDIF

  	aePuts('Include comments (Y/n)? ')
 	    stat:=lineInput('','',3,INPUT_TIMEOUT,tempstr2)
      IF(stat<0) THEN RETURN

      IF((tempstr2[0]="n") OR (tempstr2[0]="N")) THEN comments:=0
	ENDIF
  myDirRecurse(tempstr,comments)
  aePuts('\b\n')
ENDPROC

PROC setTempSecurityFlags(securityFlag)
  WHILE StrLen(securityFlags)<=securityFlag
    StrAdd(securityFlags,'?')
  ENDWHILE
  securityFlags[securityFlag]:="T"
ENDPROC

PROC clearTempSecurityFlags(securityFlag)
  WHILE StrLen(securityFlags)<=securityFlag
    StrAdd(securityFlags,'?')
  ENDWHILE
  securityFlags[securityFlag]:="F"
ENDPROC

PROC extCheckSecurity(securityFlag)
  IF (StrLen(securityFlags)>securityFlag)
    IF securityFlags[securityFlag]<>"?" THEN RETURN (securityFlags[securityFlag]="T")
  ENDIF

  IF securityFlag=ACS_SENTBY_FILES
    RETURN cmds.acLvl[LVL_SENTBY_FILES]
  ELSEIF securityFlag=ACS_DEFAULT_CHAT_ON
    RETURN cmds.acLvl[LVL_DEFAULT_CHAT_ON]
  ELSEIF securityFlag=ACS_SENTBY_FILES
    RETURN cmds.acLvl[LVL_SENTBY_FILES]
  ELSEIF securityFlag=ACS_DO_CALLERSLOG
    RETURN cmds.acLvl[LVL_DO_CALLERSLOG]
  ELSEIF securityFlag=ACS_WILDCARDS
    RETURN sopt.toggles[TOGGLES_USEWILDCARDS]
  ELSEIF securityFlag=ACS_CLEAR_SCREEN_MSG
    IF loggedOnUserKeys=NIL THEN RETURN FALSE
    RETURN loggedOnUserKeys.userFlags AND USER_SCRNCLR
  ELSE
    RETURN checkSecurity(securityFlag)
  ENDIF
ENDPROC

PROC checkSecurity(securityFlag)  
  IF (loggedOnUser=NIL) OR (acsLevel=-1) THEN RETURN FALSE
  IF StrLen(securityFlags)>securityFlag
    IF securityFlags[securityFlag]<>"?" THEN RETURN (securityFlags[securityFlag]="T")
  ENDIF
ENDPROC checkToolTypeExists(TOOLTYPE_ACCESS,acsLevel,ListItem(securityNames,securityFlag)) 

PROC checkConfAccess(confNum)
  DEF ttname[20]:STRING
  IF (loggedOnUser=NIL) THEN RETURN FALSE
   
  StringF(ttname,'Conf.\d',confNum)
ENDPROC checkToolTypeExists(TOOLTYPE_AREA,loggedOnUser.conferenceAccess,ttname) 

PROC myError(errorCode)
  DEF errorString[100]:STRING

  SELECT errorCode
    CASE ERR_MEMORY
      StringF(errorString,'Could not allocate enough memory for workspace')
    CASE ERR_MEMORY2
      StringF(errorString,'Tell \s there is a memory problem.',cmds.sysopName)
    CASE ERR_MSGBASE
      StringF(errorString,'Msg Base ERROR!!  Please notify \s',cmds.sysopName)
    CASE ERR_MEMORY3
      StringF(errorString,'No Mem Error: Not enough memory to finish operation')
    CASE ERR_FILELIST
      StringF(errorString,'There is a problem with File listings, please tell \s',cmds.sysopName)
    CASE ERR_NOFILES
      aePuts('No files available in this conference.\b\n\b\n')
      RETURN
    CASE ERR_FILEEXAMINE
      StringF(errorString,'Tell \s there is a File Examine Error',cmds.sysopName)
    CASE ERR_WORKDIROPEN
      StringF(errorString,'Tell \s the system can''t open a file in the work dirs',cmds.sysopName)
    CASE ERR_LOCK
      StringF(errorString,'Tell \s the system has a Lock Error',cmds.sysopName)
    CASE ERR_FREESPACE
      StringF(errorString,'Not enough free space on Device for uploading.')
    CASE ERR_SYMBOLS
      StringF(errorString,'\b\nYou may not include any special symbols\b\n')
      RETURN
    CASE ERR_FIB_MEMORY
      StringF(errorString,'Out of chipmem for FileInfoBlock')
    CASE ERR_NO_BULLS
      aePuts('\b\nNo bulletins are available in this conference!\b\n\b\n')
      RETURN
  ENDSELECT

 aePuts('\b\n')
 aePuts(errorString)
 aePuts('\b\n\b\n')
 errorLog(errorString)
ENDPROC

PROC relConf(cn)
  DEF i=0
  DEF count=0

  WHILE(i<cn)
    IF((checkConfAccess(i+1)=TRUE) OR (sopt.toggles[TOGGLES_CONFRELATIVE]=FALSE)) THEN count++
    i++
  ENDWHILE
ENDPROC count

PROC getInverse(cn)
  DEF i=0
  DEF j=0
  IF(cn<1) THEN RETURN 0
  IF(sopt.toggles[TOGGLES_CONFRELATIVE]=FALSE) THEN RETURN cn
    WHILE(i<cn)
      IF(j<cmds.numConf)
       IF(checkConfAccess(j+1)) THEN i++
      ELSE
        RETURN 0
      ENDIF
      j++
    ENDWHILE
ENDPROC j


PROC masterLoadPointers(hoozer: PTR TO user)
  DEF i,cb: PTR TO confBase

  FOR i:=1 TO cmds.numConf
    cb:=ListItem(confBases,i-1)
    loadConfDB(hoozer.slotNumber,i,cb,TRUE)
  ENDFOR
ENDPROC

PROC clearMsgPointers()
  DEF cb: PTR TO confBase
  DEF i

  FOR i:=1 TO cmds.numConf
    cb:=ListItem(confBases,i-1)
    cb.bytesDownload:=0
    cb.bytesUpload:=0
    cb.upload:=0
    cb.downloads:=0
    cb.ratioType:=0
    cb.ratio:=0
    cb.messagesPosted:=0
    cb.lastEMail:=0
    cb.confYM:=0
    cb.confRead:=0
  ENDFOR
ENDPROC

PROC addMsgPointers()
  DEF i
  DEF cb: PTR TO confBase
  
  IF (checkSecurity(ACS_CONFERENCE_ACCOUNTING)=FALSE) THEN RETURN

  loggedOnUser.bytesDownload:=0
  loggedOnUser.bytesUpload:=0
  loggedOnUser.uploads:=0
  loggedOnUser.downloads:=0
  loggedOnUser.messagesPosted:=0

  FOR i:=1 TO cmds.numConf
    cb:=ListItem(confBases,i-1)
    IF (readToolTypeInt(TOOLTYPE_CONF,i,'CONFDB_SHARED')>0)
      loggedOnUser.bytesDownload:=loggedOnUser.bytesDownload+cb.bytesDownload
      loggedOnUser.bytesUpload:=loggedOnUser.bytesUpload+cb.bytesUpload
      loggedOnUser.uploads:=loggedOnUser.uploads+cb.upload
      loggedOnUser.downloads:=loggedOnUser.downloads+cb.downloads
    ENDIF
    loggedOnUser.messagesPosted:=loggedOnUser.messagesPosted+cb.messagesPosted
  ENDFOR

ENDPROC

PROC masterSavePointers(hoozer: PTR TO user)
  DEF i,cb: PTR TO confBase

  FOR i:=1 TO cmds.numConf
    cb:=ListItem(confBases,i-1)
    saveConfDB(hoozer.slotNumber,i,cb,TRUE)
  ENDFOR
ENDPROC

PROC getMailStatFile()
  DEF fd, stat
  DEF string[100]:STRING
 
  StringF(string,'\s\s',msgBaseLocation,'MailStats')

  fd:=Open(string,OLDFILE)
  IF(fd<=0)
     fd:=Open(string,MODE_READWRITE)
     IF(fd<=0) 
         myError(ERR_MSGBASE)
         RETURN RESULT_FAILURE
     ENDIF

     mailStat.lowestNotDel:=0
     mailStat.lowestKey:=1
     mailStat.highMsgNum:=1
     stat:=Write(fd,mailStat,SIZEOF mailStat)
  ELSE
     stat:=Read(fd,mailStat,SIZEOF mailStat)
  ENDIF

  IF (stat<>SIZEOF mailStat)
     Close(fd)
     myError(ERR_MSGBASE)
     RETURN RESULT_FAILURE
  ENDIF

  Close(fd)

ENDPROC RESULT_SUCCESS

PROC parseList(liststring,list)
  DEF spacepos,startpos,newitem
  DEF tempstr[255]:STRING
  
  SetList(list,0)
  IF StrLen(liststring)=0 THEN RETURN
  
  startpos:=0
  spacepos:=InStr(liststring,' ')
  IF spacepos>=0
    WHILE(spacepos>=0)
      MidStr(tempstr,liststring,startpos,spacepos-startpos)
      UpperStr(tempstr)
      newitem:=String(StrLen(TrimStr(tempstr)))
      StrCopy(newitem,TrimStr(tempstr),ALL)
      ListAdd(list,[newitem])
      startpos:=spacepos+1
      WHILE ((startpos<StrLen(liststring)) AND (liststring[startpos]=" ")) DO startpos:=startpos+1
      spacepos:=InStr(liststring,' ',startpos)
    ENDWHILE
    IF startpos<StrLen(liststring)
      MidStr(tempstr,liststring,startpos,StrLen(liststring)-startpos)
      UpperStr(tempstr)
      newitem:=String(StrLen(TrimStr(tempstr)))
      StrCopy(newitem,TrimStr(tempstr),ALL)
      ListAdd(list,[newitem])
    ENDIF
  ELSE
    newitem:=String(StrLen(liststring))
    StrCopy(newitem,liststring,ALL)
    UpperStr(newitem)
    ListAdd(list,[newitem])
  ENDIF
ENDPROC

PROC parseParams(paramstring)
  parseList(paramstring,parsedParams)
ENDPROC

PROC paramsContains(paramcheck)
  DEF i, paramitem

  FOR i:=0 TO ListLen(parsedParams)-1
    paramitem:=ListItem(parsedParams,i)
    IF StrCmp(paramitem,paramcheck) THEN RETURN TRUE
  ENDFOR

ENDPROC FALSE


PROC commentToSYSOP()
  DEF stat
  DEF str[255]:STRING
  
  stat:=loadAccount(1,tempUser,tempUserKeys,tempUserMisc)
  strCpy(mailHeader.toName,tempUser.name,31)

  aePuts('\b\n                       [32m([33m------------------------------[32m)[0m\b\n')
  StringF(str,'     [36mTo[33m: [32m([33mEnter[32m)[0m=[32m''[33mALL[32m''[32m?[0m \s\b\n',mailHeader.toName)
  aePuts(str)
  checkToForward(str,mailHeader.toName,0)
  aePuts('[36mSubject[33m: [32m([33mBlank[32m)[0m=[33mabort[32m?[0m ')
  ->strCpy(mailHeader.toNet,Sopt->BBSConfig,ALL)
  ->>strCpy(mailHeader.fromNet,Sopt->BBSConfig,ALL)
  stat:=lineInput('','',30,INPUT_TIMEOUT,str)
  IF(stat<0) THEN RETURN stat

  IF (StrLen(str)=0)
     aePuts('\b\n')
     RETURN RESULT_SUCCESS
  ENDIF
  strCpy(mailHeader.subject,str,30)
  mailHeader.status:="R"
  comment:=1
  stat:=callMsgFuncs(MAIL_CREATE,0)
  IF(stat<0) THEN RETURN stat
ENDPROC RESULT_SUCCESS

-> checks to see if a string contains a numeric value
PROC isDigit(teststring)
  DEF d

  d:=Val(teststring)
  IF (d>=0) THEN RETURN TRUE
ENDPROC FALSE

PROC charToLower(c)
  DEF str[1]:STRING
  str[0]:=c
  LowerStr(str)
ENDPROC str[0]

PROC charToUpper(c)
  DEF str[1]:STRING
  str[0]:=c
  UpperStr(str)
ENDPROC str[0]

PROC firstChar(teststring)
ENDPROC TrimStr(teststring)-teststring

PROC firstCharValue(teststring)
  IF StrLen(teststring)=0 THEN RETURN 0
ENDPROC teststring[0]

PROC stringCompare(nam,pat)
  DEF i
  FOR i:=0 TO StrLen(nam)-1
    IF (charToLower(nam[i])<>charToLower(pat[i])) AND ((pat[i]<>"?") OR (nam[i]=0))
      RETURN RESULT_FAILURE
    ENDIF
  ENDFOR  
ENDPROC RESULT_SUCCESS

PROC displayMessage(gfh)
 DEF timeVar
 DEF str[255]:STRING
 DEF string[255]:STRING
 DEF date[100]:STRING
 DEF tempStr[255]:STRING
 DEF stat

 timeVar:=mailHeader.msgDate
 formatLongDateTime(timeVar,date)
 
 checkScreenClear()

 StringF(str,'\b\n[32mDate   [33m: [0m\l\s[30]   [32mNumber[33m: [0m\d\b\n',date,mailHeader.msgNumb)
 aePuts(str)
 StrCopy(date,mailHeader.toName,31)
 LowerStr(date)
 timeVar:=(StrCmp(date,'eall',4))
 IF(timeVar) 
  StrCopy(date,loggedOnUser.name,31)
  StrAdd(date,' (ALL)')
 ELSE
      StrCopy(date,mailHeader.toName,31)
 ENDIF

 IF(netflag)
  ->StringF(str,'[32mTo     [33m: [0m\l\s[30]  [32mAddress[33m: [0m\s[6]\b\n',date,mailHeader.toNet)
 ELSE
  StringF(str,'[32mTo     [33m: [0m\l\s[30]  ',date)
 ENDIF

 aePuts(str)
 IF(netflag=FALSE)
   IF(mailHeader.recv<>0)
       timeVar:=mailHeader.recv
       formatLongDateTime(timeVar,date)
       StringF(str,' [32mRecv''d[33m: [0m\s\b\n',date)
       aePuts(str)
   ELSE
       aePuts(' [32mRecv''d[33m: [0m')
       IF(stringCompare(mailHeader.toName,'ALL')=RESULT_SUCCESS)
            aePuts('N/A\b\n')
       ELSE
            aePuts('No\b\n')
       ENDIF
   ENDIF

   IF(mailHeader.status="P")
       StrCopy(string,'Public Message',ALL)
   ELSE
       StrCopy(string,'Private Message',ALL)
   ENDIF
   
   StringF(str,'[32mFrom   [33m: [0m\l\s[30]   [32mStatus[33m: [0m\s\b\n',mailHeader.fromName,string)
   aePuts(str)
   StringF(str,'[32mSubject[33m: [0m\s\b\n\b\n',mailHeader.subject)
   aePuts(str)
 /*ELSE
    netflag=true to be implemented
   IF(mailHeader.status="P")
       StrCopy(string,'Public Message',ALL)
   ELSE
       StrCopy(string,'Private Message',ALL)
   ENDIF
   
   StringF(str,'[32mFrom   [33m: [0m\l\s[30]  [32mAddress[33m: [0m\s[6]\b\n',mailHeader.fromName,mailHeader.fromNet)
   aePuts(str)
   StringF(str,'[32mStatus [33m: [0m\l\s[30]  [32m Recv''d[33m: [0m',string)
   IF(mailHeader.recv<>0)
       timeVar:=mailHeader.recv
       formatLongDateTime(timeVar,date)
       StrAdd(str,date)
       StrAdd(str,'\b\n')
       aePuts(str)
   ELSE
       IF(stringCompare(mailHeader.toName,'ALL')=RESULT_SUCCESS)
            StrAdd(str,'N/A\b\n')
       ELSE
            StrAdd(str,'No\b\n')
       ENDIF
       aePuts(str)
   ENDIF
    StringF(str,'[32mSubject[33m: [0m\s\b\n\b\n',mailHeader.subject)
    aePuts(str)*/
 ENDIF

 alreadyRecvd:=mailHeader.recv

 IF(stringCompare(mailHeader.toName,loggedOnUser.name)=RESULT_SUCCESS)
     IF(mailHeader.recv=0)
      mailHeader.recv:=getSystemTime()
         delMsgNum:=mailHeader.msgNumb
         saveOverHeader(gfh)
     ENDIF
 ENDIF

 StringF(tempStr,'\s\d',msgBaseLocation,mailHeader.msgNumb)

 IF(nonStopMail)
    displayFile(tempStr,FALSE,FALSE)
    ->stat:=MenuSend(tempStr)
   IF(stat=RESULT_FAILURE) THEN nonStopMail:=FALSE
 ELSE
    displayFile(tempStr,FALSE)
      ->MenuSend24(tempStr,5)
 ENDIF
 ->mcioff=0
 stat:=checkAttachedFile(mailHeader.msgNumb,1)
ENDPROC stat


PROC errorLog(stringout: PTR TO CHAR)
  DEF gfp1, xgstr1[20]:STRING, xgstr2[255]:STRING
  DEF calltime
  DEF datestr[20]:STRING
  DEF timestr[20]:STRING
  DEF fname[100]:STRING
 
  calltime:=getSystemTime()
  formatLongDate(calltime,datestr)
  formatLongTime(calltime,timestr)

  StringF(xgstr1,'\s \s',datestr,timestr)

  StringF(fname,'\sNode\d/ErrorLog',cmds.bbsLoc,node)

  gfp1:=Open(fname,MODE_READWRITE)

  IF(gfp1>0)
	  Seek(gfp1,0,OFFSET_END)
    StringF(xgstr2,'\s ',xgstr1)
    Write(gfp1,xgstr2,StrLen(xgstr2))
    fileWriteLn(gfp1,stringout)
	  Close(gfp1)
	ENDIF
ENDPROC

PROC displayCallersLog(filename: PTR TO CHAR,tf)

  DEF stat,stat2,loop,lnlp=0,readSize,currentPos
  DEF buf:PTR TO CHAR
  DEF fh
  DEF memsize=4096
  DEF tempstr[255]:STRING

  readSize:=memsize
  lineCount:=0
  nonStopDisplayFlag:=FALSE
  IF(tf) THEN nonStopDisplayFlag:=TRUE

  IF(buf:=AllocMem(memsize+4,MEMF_ANY))<>0
    IF(fh:=Open(filename,MODE_OLDFILE))>0
      Seek(fh,0,OFFSET_END)
      currentPos:=Seek(fh,0,OFFSET_CURRENT)
      REPEAT
        IF(currentPos<memsize)
          readSize:=currentPos+lnlp
          currentPos:=0
        ELSE  
          currentPos:=(currentPos-4096)+lnlp
        ENDIF

        stat:=Seek(fh,currentPos,OFFSET_BEGINNING)
        IF(stat>=0)
          Seek(fh,0,OFFSET_CURRENT)
          IF((stat:=Read(fh,buf,readSize)))>0
            buf[readSize-1]:=0
            lnlp:=0
            FOR loop:=readSize TO 1 STEP -1
              IF(buf[loop]="\n") 
                StringF(tempstr,'\s\b\n',buf+loop+1)
                aePuts(tempstr)
                buf[loop]:=0
                lnlp:=loop+1
                IF(stat2:=checkForPause())<>0
                  aePuts('\b\n')
                  loop:=0;
                  stat:=(-1)
                ENDIF
                IF(sCheckInput())
                  stat2:=readChar(1)
                  IF(stat2<0)
                      loop:=0;
                      stat:=(-1);
                  ELSE
                    SELECT stat2
                      CASE 19 /* Pause */
                        stat:=readChar(INPUT_TIMEOUT)
                        IF(stat2<0) 
                          loop:=0
                          stat:=(-1)
                        ENDIF
                      CASE 3 /* ^C */
                        aePuts('**Break\b\n\b\n')
                        IF(ansiColour) THEN aePuts('[0m')
                        loop:=0
                        stat:=(-1);
                    ENDSELECT
                  ENDIF
                ENDIF
              ENDIF
            ENDFOR
          ENDIF
          IF(stat<0) 
            stat:=IoErr()
            IF(stat>0)
                ->sprintf(GSTR2,"IOErr #%d\b\n",stat);
                ->AEPutStr(GSTR2);
            ENDIF
            stat:=(-1)
          ENDIF
        ENDIF
      UNTIL (currentPos<=0) OR (stat<0)
      Close(fh)
    ELSE
      aePuts('\b\nNot a valid node!\b\n\b\n')
    ENDIF

    FreeMem(buf,memsize+4)
  ENDIF
ENDPROC

PROC debugLog(logType,logline:PTR TO CHAR)
  DEF buff[255]:STRING
  
  IF consoleDebugLevel>=logType THEN WriteF('\s\n',logline)
  
  IF debugLogLevel>=logType
    StringF(buff,'\tD-(Node \d)\s',node,logline)
    errorLog(buff)
  ENDIF
ENDPROC

PROC remoteShell()
  DEF rMsg:mn
  DEF wMsg:mn
  DEF fifoName[255]:STRING
  DEF fifoMast[255]:STRING
  DEF fifoSlav[255]:STRING
  DEF ioSink:PTR TO mp
  DEF fifoR
  DEF fifoW
  
  DEF fifrIP=0
  DEF fifwIP=0
  DEF done=0
  DEF pmask
  DEF msg:PTR TO mn
  DEF n,ch
  DEF bufptr:PTR TO CHAR
  DEF temp[255]:STRING

  StringF(fifoName,'bbsshell\d',node)

  StringF(fifoMast, '\s_m', fifoName)
  StringF(fifoSlav, '\s_s', fifoName)

  ioSink:=createPort(NIL, 0)

    /*
     *	FIFOS
     */

  fifobase:=OpenLibrary('fifo.library', 0)
  IF (fifobase=NIL) 
    aePuts('unable to open fifo.library\n')
    callersLog('\tunable to open fifo.library\n')
    deletePort(ioSink)
    RETURN RESULT_FAILURE
  ENDIF

  fifoW:=OpenFifo(fifoMast, 2048, FIFOF_WRITE OR FIFOF_NORMAL OR FIFOF_NBIO)
  IF (fifoW = NIL) 
    aePuts('unable to open fifo master\n')
    callersLog('\tunable to open fifo master\n')
    CloseLibrary(fifobase)
    deletePort(ioSink)   
    RETURN RESULT_FAILURE
  ENDIF
  
  fifoR:=OpenFifo(fifoSlav, 2048, FIFOF_READ  OR FIFOF_NORMAL OR FIFOF_NBIO)
  IF (fifoR = NIL) 
    aePuts('unable to open fifo slave\n')
    callersLog('\tunable to open fifo slave\n')
    CloseFifo(fifoW,FIFOF_EOF)
    CloseLibrary(fifobase)
    deletePort(ioSink)
    RETURN RESULT_FAILURE
  ENDIF
  

  rMsg.replyport:=ioSink
  wMsg.replyport:=ioSink

  /*
   *	WINDOW
   */

  IF(findAssign('fifo:')<>0)
    aePuts('unable to find fifo: device\n')
    callersLog('\tunable to find fifo: device\n')
    CloseFifo(fifoW,FIFOF_EOF)
    CloseLibrary(fifobase)
    deletePort(ioSink)
    RETURN RESULT_FAILURE
  ENDIF


  StringF(temp,'newshell fifo:\s/rwkecs',fifoName)
  SystemTagList(temp,[SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,1])

  pmask:=Shl(1,ioSink.sigbit)

  RequestFifo(fifoR, rMsg, FREQ_RPEND)
  fifrIP:=1

  /*
   * start shell for slave side
   */

  conPuts('[ p') /* turn console cursor on */
  aePuts('\b\n')

  Wait(pmask)   ->shell should send start string when it's started

  WHILE (done=FALSE) 
    
    WHILE ((msg:=GetMsg(ioSink)))
      IF (msg = rMsg) 
        ->incoming message from fifo read
        fifrIP:=0

        IF ((n:=ReadFifo(fifoR, {bufptr}, 0)) > 0)
          aePuts2(bufptr, n)
                    /*	clear N bytes	*/
          n:=ReadFifo(fifoR, {bufptr}, n)
        ENDIF
        
        IF (n < 0)            /*  EOF */
          aePuts('\nREMOTE EOF!\n')
          done:=TRUE
        ELSE
          RequestFifo(fifoR, rMsg, FREQ_RPEND)
          fifrIP:=1
        ENDIF
      ENDIF
    ENDWHILE

    IF done=0
      ch:=readChar(INPUT_TIMEOUT,pmask)

      IF (ch<0) OR (reqState<>REQ_STATE_NONE)
          ->timeout or kill signal
         done:=TRUE
      ENDIF
      
      IF (done=0) AND (ch<>0)
        ->incoming message from console read
        SELECT ch
          CASE 3
            sendBreak("C")
          CASE 4
            sendBreak("D")
          CASE 5
            sendBreak("E")
          CASE 6
            sendBreak("F")
          DEFAULT
            StrCopy(temp,'#')
            temp[0]:=ch
            n:=WriteFifo(fifoW, temp, 1)
            IF (n <> 1)
              IF (fifwIP = 0)
                RequestFifo(fifoW, wMsg, FREQ_WAVAIL)
                fifwIP:=1
              ENDIF
            ENDIF
        ENDSELECT
      ENDIF       
    ENDIF
  ENDWHILE

  conPuts('[0 p'); /* turn console cursor off */

  IF (fifwIP) 
    RequestFifo(fifoW, wMsg, FREQ_ABORT)
    waitMsg(wMsg)
  ENDIF

  IF (fifrIP)
    RequestFifo(fifoR, rMsg, FREQ_ABORT)
    waitMsg(rMsg)
  ENDIF

  IF (fifoR) THEN CloseFifo(fifoR, FIFOF_EOF)

  /*  no FIFOF_EOF on IDCMP_CLOSEWINDOW to conform to documentation */
  IF (fifoW) THEN	CloseFifo(fifoW, FIFOF_EOF)	

  IF (fifobase) THEN CloseLibrary(fifobase)

  IF (ioSink) THEN deletePort(ioSink)

ENDPROC RESULT_SUCCESS

PROC waitMsg(msg:PTR TO mn)
    WHILE(msg.ln.type = NT_MESSAGE)
      Wait(Shl(1,msg.replyport.sigbit))
    ENDWHILE
    Forbid()
    Remove(msg)
    Permit()
ENDPROC

PROC sendBreak(c)
    DEF buf[256]:STRING
    DEF fh

    StringF(buf, 'FIFO:bbsshell\d/\c', node, c)
    IF ((fh:=Open(buf, 1005))) THEN Close(fh)
ENDPROC

PROC doorLog(type, str:PTR TO CHAR)
  DEF gfp1
  DEF logname[255]:STRING
  DEF str1[255]:STRING
  DEF string[255]:STRING
  DEF name[255]:STRING

  IF(sopt.toggles[TOGGLES_DOORLOG])=FALSE THEN RETURN
  
  StringF(logname,'\sNode\d/DoorLog',cmds.bbsLoc,node)

  gfp1:=Open(logname,MODE_READWRITE)
  IF gfp1>0
    Seek(gfp1,0,OFFSET_END)

    IF loggedOnUser<>NIL THEN StrCopy(name,loggedOnUser.name) ELSE StrCopy(name,'')

    formatLongDateTime(getSystemTime(),str1)
    IF StrLen(str)>0
      StringF(string,'[\s[25]] \s - \d - \s[10]',str1,name,type,str)
    ELSE
      StringF(string,'[\s[25]] \s - \d - Exiting',str1,name,type)
    ENDIF

    fileWriteLn(gfp1,string)
    Close(gfp1)
  ENDIF
ENDPROC

PROC startLog(stringout:PTR TO CHAR)
  DEF gfp1
  DEF logname[255]:STRING

  IF(sopt.toggles[TOGGLES_STARTLOG])=FALSE THEN RETURN
  
  StringF(logname,'\sNode\d/StartUpLog',cmds.bbsLoc,node)

  gfp1:=Open(logname,MODE_READWRITE)
  IF gfp1>0
    Seek(gfp1,0,OFFSET_END)
    fileWriteLn(gfp1,stringout)
    Close(gfp1)
  ENDIF
ENDPROC

PROC creditLog(logline: PTR TO CHAR)
  DEF fn[255]:STRING
  DEF fh
  
  StringF(fn,'\sCreditLog',cmds.bbsLoc)
  fh:=Open(fn,MODE_OLDFILE)
  IF(fh<=0)
    fh:=Open(fn,MODE_NEWFILE)
  ELSE
	  Close(fh)
	  fh:=Open(fn,MODE_READWRITE)
    Seek(fh,0,OFFSET_END)
	ENDIF

  IF(fh)
    fileWriteLn(fh,logline)
	  Close(fh)
	ENDIF
ENDPROC

PROC logoffLog(stat: PTR TO CHAR)
  DEF tempstr[255]:STRING
  DEF datestr[10]:STRING
  DEF timestr[10]:STRING
  DEF calltime

  calltime:=getSystemTime()
  formatLongDate(calltime,datestr)
  formatLongTime(calltime,timestr)

  IF stat[0]="N"
    StringF(tempstr,'\s (\s) \s Off Normally',datestr,timestr,loggedOnUser.name)
  ELSE
    StringF(tempstr,'\s (\s) \s Off \s',datestr,timestr,loggedOnUser.name,stat)
  ENDIF
  callersLog(tempstr)
ENDPROC 

PROC callersLog(stringout: PTR TO CHAR,linefeed=TRUE)
  DEF buff[100]:STRING
  DEF gfp1

  IF cmds.acLvl[LVL_DO_CALLERSLOG]=FALSE THEN RETURN

  StringF(buff,'\sNode\d/CallersLog',cmds.bbsLoc,node)

  gfp1:=Open(buff,MODE_OLDFILE)
  IF(gfp1<=0)
    gfp1:=Open(buff,MODE_NEWFILE)
  ELSE
	  Close(gfp1)
	  gfp1:=Open(buff,MODE_READWRITE)
    Seek(gfp1,0,OFFSET_END)
	ENDIF

  IF(gfp1)
    IF linefeed
      fileWriteLn(gfp1,stringout)
    ELSE
      fileWrite(gfp1,stringout)
    ENDIF
	  Close(gfp1)
	ENDIF
ENDPROC

PROC udLog(stringout: PTR TO CHAR)
  DEF gfp1
  DEF lstr[300]:STRING

  IF((checkSecurity(ACS_DO_UD_LOG))=FALSE) THEN RETURN

  StringF(lstr,'\sNode\d/UDLog',cmds.bbsLoc,node)
  gfp1:=Open(lstr,MODE_OLDFILE)
  IF(gfp1<=0)
    gfp1:=Open(lstr,MODE_NEWFILE)
  ELSE
 	  Close(gfp1)
 	  gfp1:=Open(lstr,MODE_READWRITE)
 	ENDIF

  IF(gfp1)
    fileWriteLn(gfp1,stringout)
	  Close(gfp1)
	ENDIF
ENDPROC

PROC udLogDivider()
  udLog('**************************************************************')
ENDPROC

PROC callerIDLog(opt)
  DEF fi
  DEF tempstr[255]:STRING

  IF(((sopt.toggles[TOGGLES_CALLERID]) OR (sopt.toggles[TOGGLES_CALLERIDNAME])) AND opt)
    StringF(tempstr,'\sNode\d/CallerIDlog',cmds.bbsLoc,node)
     fi:=Open(tempstr,MODE_READWRITE)
     Seek(fi,0,OFFSET_END)
     fileWrite(fi,'**************************************************************\n');

     IF(sopt.toggles[TOGGLES_CALLERIDNAME])
        StringF(tempstr,'\t(\s - \s [\s[16] / \s]) \n',idDate,idTime,idNmbr,idName)
     ELSE
        StringF(tempstr,'\t(\s - \s [\s[16]])\n',idDate,idTime,idNmbr)
     ENDIF
     fileWrite(fi,tempstr)
     Close(fi)
     RETURN
  ENDIF
  IF(sopt.toggles[TOGGLES_CALLERID] OR sopt.toggles[TOGGLES_CALLERIDNAME])
    StringF(tempstr,'\sNode\d/CallerIDlog',cmds.bbsLoc,node)
     fi:=Open(tempstr,MODE_READWRITE)
     Seek(fi,0,OFFSET_END)
     StringF(tempstr,'\t\s\n',loggedOnUser.name)
     fileWrite(fi,tempstr)
     Close(fi)
  ENDIF
ENDPROC

PROC callersLogDivider()
  callersLog('**************************************************************')
ENDPROC

PROC restricted(str: PTR TO CHAR)
  DEF fLock
  DEF image[200]:STRING
  DEF bad=TRUE
  DEF fBlock: fileinfoblock

  IF(fLock:=Lock(str,ACCESS_READ))<>0
    IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))= NIL
      aePuts('\b\nCan''t allocate memory to lock file!!\b\n')
      bad:=TRUE
    ELSE
      IF((Examine(fLock,fBlock))=0)
        aePuts('\b\nCan''t get informations from file.\b\n') 
        bad:=TRUE
      ELSE
        IF(strCmpi(fBlock.comment,'Restricted',10))
          aePuts('\b\n ')
          aePuts(str)
          aePuts('\b\n >>Restricted File<< Updating CallersLog\b\n')
          StringF(image,'\tAttempt to examine RESTRICTED file \s[100]',str)
          callersLog(image)
          bad:=TRUE
        ELSE
          bad:=FALSE->//!AllowedView(FBlock->fib_Comment)  
        ENDIF
      ENDIF
      FreeDosObject(DOS_FIB,fBlock)
    ENDIF
    UnLock(fLock)
  ENDIF
ENDPROC bad

PROC deleteMsgFiles(num:LONG)
  DEF image[100]:STRING
  DEF fBlock:PTR TO fileinfoblock
  DEF fLock
  DEF str[100]:STRING
  
  StringF(str,'\sF\d',msgBaseLocation,num)

  IF(fBlock:=AllocDosObject(DOS_FIB,NIL))
	  IF(fLock:=Lock(str,ACCESS_READ))

 		  IF(Examine(fLock,fBlock))
        WHILE(ExNext(fLock,fBlock))
          StringF(image,'\sF\d/\s',msgBaseLocation,num,fBlock.filename)
          SetProtection(image,FIBF_OTR_DELETE)
          DeleteFile(image)
        ENDWHILE
        aePuts('\b\n')
		  ENDIF
      UnLock(fLock)   
    ENDIF
	  FreeDosObject(DOS_FIB,fBlock)
    SetProtection(str,FIBF_OTR_DELETE)
    DeleteFile(str)
	ENDIF
     
ENDPROC   


PROC attachMsgFiles(num: LONG,s:PTR TO CHAR)
  DEF image[100]:STRING
  DEF str[100]:STRING
  DEF fBlock: PTR TO fileinfoblock
  DEF fLock
 
  StrCopy(s,'')
  StringF(str,'\sF\d',msgBaseLocation,num)

  IF(fBlock:=AllocDosObject(DOS_FIB,NIL))
	  IF(fLock:=Lock(str,ACCESS_READ))
 		  IF(Examine(fLock,fBlock))
        WHILE(ExNext(fLock,fBlock))
          StringF(image,'\sF\d/\s ',msgBaseLocation,num,fBlock.filename)
          IF(StrLen(image)+StrLen(s)<1024)
            aePuts('\b\nFlagging >:')
            aePuts(fBlock.filename)
           
            StrAdd(s,image)
          ENDIF
			  ENDWHILE
        aePuts('\b\n')
		  ENDIF
      UnLock(fLock)
    ENDIF
	  FreeDosObject(DOS_FIB,fBlock)
	ENDIF
     
ENDPROC       


PROC checkAttachedFile(msgnumb,flag)
  DEF stat
  DEF str[250]:STRING
  DEF fBlock:PTR TO fileinfoblock
  DEF fLock
  DEF filetype=0
  DEF tempStr[255]:STRING
  
  StrCopy(tempStr,'')
 
  dTBT:=0
  tBT:=0
  tTTM:=NIL
  tTEFF:=NIL
  tTCPS:=NIL
 
  StringF(str,'\s\d',msgBaseLocation,msgnumb)
 
  IF(fBlock:=AllocDosObject(DOS_FIB,NIL))
 	  IF(fLock:=Lock(str,ACCESS_READ))
  		IF(Examine(fLock,fBlock)) 
  			IF(StrLen(fBlock.comment)>0)
  				StrCopy(tempStr,fBlock.comment)
          filetype:=1
 			  ENDIF
  		   
 	    ENDIF
      UnLock(fLock)
      IF(filetype=0)
        StringF(str,'\sF\d',msgBaseLocation,msgnumb)
        IF(fLock:=Lock(str,ACCESS_READ))
           UnLock(fLock)
           filetype:=2
        ENDIF
      ENDIF
    ENDIF
 	  FreeDosObject(DOS_FIB,fBlock)
 	ENDIF
      
        
  IF(filetype)
  	IF(flag)
      aePuts('...This message has an attached file(s), Download? (y/N/goodbye)? ')
      stat:=readChar(INPUT_TIMEOUT)
      IF(stat<0) THEN RETURN stat
      
      IF((stat="n") OR (stat="N")) THEN aePuts('No\b\n')
      IF((stat="y") OR (stat="Y"))
        aePuts('Yes\b\n\b\n')
        IF(filetype=2) THEN attachMsgFiles(msgnumb,tempStr)
        downloadFile(tempStr)
      ENDIF
      IF((stat="g") OR (stat="G"))
        aePuts('Goodbye\b\n\b\n')
        IF(filetype=2) THEN attachMsgFiles(msgnumb,tempStr)
            downloadFile(tempStr)
        aePuts('\b\n')
        stat:=pGoodbye()
        IF(stat=RESULT_GOODBYE) THEN modemOffHook()
        RETURN stat
      ENDIF
      stat:=0
  		aePuts('\b\n')
 		ELSE
      IF(filetype=2) THEN deleteMsgFiles(msgnumb)
  		  stat:=isupper(tempStr[0])
 	    	IF(stat) 
          SetProtection(tempStr,FIBF_OTR_DELETE)
  			  DeleteFile(tempStr)
 	    		aePuts('\b\nDeleted attached file(s) ')
 		    	aePuts(tempStr)
        ENDIF
 		ENDIF
 	ENDIF

ENDPROC RESULT_SUCCESS


PROC replyToMSG(gfh)
  DEF str[255]:STRING
  DEF frm[255]:STRING
  DEF stat

  delMsgNum:=mailHeader.msgNumb
  StrCopy(frm,mailHeader.toName)
  aePuts('\b\n                       [32m([33m------------------------------[32m)[0m\b\n')
  strCpy(mailHeader.toName,mailHeader.fromName,31)
  StringF(str,'     [36mTo[33m: [32m([33mEnter[32m)[0m=[32m''[33mALL[32m''[32m?[0m \s\b\n',mailHeader.toName)
  aePuts(str)
  checkToForward(str,mailHeader.toName,1)
  ->strCpy(mailHeader.toNet,mailHeader.fromNet)
  ->strCpy(MailHeader.FromNet,Sopt->BBSConfig)
  aePuts('[36mSubject[33m: [32m([33mBlank[32m)[0m=[33mabort[32m?[0m ')
  stat:=lineInput('',mailHeader.subject,30,INPUT_TIMEOUT,str)
  IF(stat<0) THEN RETURN stat
  strCpy(mailHeader.subject,str,31)
  IF(StrLen(mailHeader.subject)=0) THEN RETURN RESULT_SUCCESS
  
  mailHeader.recv:=0
  
  replyFlag:=1
  stat:=enterMSG(gfh)
  IF(stat<0) THEN RETURN stat
  
  IF checkSecurity(ACS_DELETE_MESSAGE)
    IF(stringCompare(frm,loggedOnUser.name)=RESULT_SUCCESS)
        aePuts('Delete original message ')
        stat:=yesNo(2)
        IF(stat<0) THEN RETURN stat
        IF(stat) THEN deleteMSG(gfh)
    ENDIF
  ENDIF
  
ENDPROC RESULT_SUCCESS

PROC checkToForward(str,name,check)
  DEF stat,error
  DEF tempStr[255]:STRING

  error:=0

  IF readToolType(TOOLTYPE_CONF,currentConf,'FORWARDMAIL',str)
    IF(str[StrLen(str)-1]="\n") THEN SetStr(str,StrLen(str)-1)
     IF(check)
       loadAccount(1,tempUser,tempUserKeys,tempUserMisc)
       IF(stringCompare(name,tempUser.name)=RESULT_SUCCESS)
         IF(stat:=findUserFromName(1,NAME_TYPE_USERNAME,str,tempUser,tempUserKeys,tempUserMisc))
           StringF(tempStr,'    [36mForwarding mail To[33m:[0m \s\b\n',tempUserKeys.userName)
           aePuts(tempStr)
           StrCopy(name,tempUserKeys.userName)
           error:=1
         ENDIF
       ENDIF
     ELSE
       IF(stat:=findUserFromName(1,NAME_TYPE_USERNAME,str,tempUser,tempUserKeys,tempUserMisc))
         StringF(tempStr,'    [36mForwarding mail To[33m:[0m \s\b\n',tempUserKeys.userName)
         aePuts(tempStr)
         StrCopy(name,tempUserKeys.userName)
         error:=1
       ENDIF
     ENDIF
  ENDIF
ENDPROC error

PROC saveMsg(s)
  DEF f,i=0

  IF(lines)
    IF (f:=Open(s,MODE_NEWFILE))>0
      WHILE lines
        fileWriteLn(f,msgBuf[i])
        lines--
        i++
      ENDWHILE
      Close(f)
      RETURN 1
    ENDIF
  ENDIF
ENDPROC RESULT_SUCCESS

PROC loadMsg(s)
  DEF f, temp

  lines:=0
  
  StrCopy(msgBuf[0],s,ALL)
  IF(f:=Open(msgBuf[0],MODE_OLDFILE))>0
  
     WHILE((ReadStr(f,msgBuf[lines])<>-1) AND (lines<99))
       lines++
     ENDWHILE
    IF StrLen(msgBuf[lines])>0 THEN lines++
      
     Close(f)
    /* temp:=lines-1
     WHILE(temp>0)
        stripReturn(&MsgBuf[temp][0])
        if(MsgBuf[temp][0]=='\0') temp--
        else break
     ENDWHILE
     lines:=temp+1*/
     RETURN 1
 ENDIF

ENDPROC FALSE

PROC msgToHeader()
 aePuts('\b\n                       [32m([33m------------------------------[32m)[0m\b\n')
 aePuts('     [36mTo[33m: [32m([33mEnter[32m)[0m=[32m''[33mALL[32m''[32m?[0m ')
ENDPROC

PROC processLine(pat, vorig, dest)
 DEF i,i2,nff
 DEF rep[80]:STRING
 DEF orig[100] : STRING

 StrCopy(orig,vorig,ALL)
 FOR i:=0 TO StrLen(pat)-1
     EXIT pat[i]=";"
 ENDFOR

 IF(i>=StrLen(pat)) THEN RETURN 0

 StrCopy(rep,pat+i+1,ALL)
 SetStr(pat,i)

 StrCopy(dest,'',ALL)

 FOR i:=0 TO StrLen(orig)-StrLen(pat)
     nff:=1
     IF(pat[0]=orig[i])
         nff:=0
         i2:=i+1
         WHILE((i2-i)<StrLen(pat)) 
             IF(pat[i2-i]<>orig[i2]) 
                 nff:=1
                 JUMP wbrk
             ENDIF
          i2++
         ENDWHILE
        wbrk:
     ENDIF
     IF(nff<>1)
         SetStr(orig,i)
         StrCopy(dest,orig,ALL)
         StrAdd(dest,rep)
         IF(i2<StrLen(vorig)) THEN StrAdd(dest,orig[i2])
         dest[75]:=0
         RETURN 1
     ENDIF
 ENDFOR

ENDPROC 0

PROC editEmacs(filename: PTR TO CHAR)
  DEF tempStr[255]:STRING
  StringF(tempStr,'\tEditor \s',filename)
  callersLog(tempStr)
  
  runSysCommand(tempStr,filename)
ENDPROC

PROC editEMessage(number)
  DEF tempStr[255]:STRING
  
  StringF(tempStr,'\s\d',msgBaseLocation,number)
  editEmacs(tempStr)
ENDPROC

PROC editDirFile(params)
  DEF stat,which
  DEF tempStr[255]:STRING
  
  IF(maxDirs=0)
    aePuts('\b\n')
    myError(5)
    RETURN
  ENDIF
 
  parseParams(params)
  REPEAT
      IF StrLen(tempStr)=0
          StringF(tempStr,'\b\nDirectory to Edit[1-\d]? ',maxDirs)
          aePuts(tempStr)
          stat:=lineInput('','',5,INPUT_TIMEOUT,tempStr)
          IF((stat<0) OR (StrLen(tempStr)=0))
              aePuts('\b\n')
              RETURN
          ENDIF
      ENDIF
      which:=Val(tempStr)
      StrCopy(tempStr,'')
      IF((which<1) OR (which>maxDirs)) THEN aePuts('\b\nNo such directory!\b\n')
  UNTIL (which>=1) AND (which<=maxDirs)
 
  StringF(tempStr,'\sDir\d',currentConfDir,which)
  editEmacs(tempStr)
  aePuts('\b\n')

ENDPROC

PROC editAnyFile(params)
  DEF stat
  DEF tempStr[255]:STRING

  setEnvStat(ENV_SYSOP)

  parseParams(params)
  IF(ListLen(parsedParams)>0)
    StrCopy(tempStr,parsedParams[0])
  ELSE
    aePuts('\b\nFullPath/Filename to Editor? ')
    stat:=lineInput('','',250,INPUT_TIMEOUT,tempStr)
    IF((stat<0) OR (StrLen(tempStr)=0))
      aePuts('\b\n')
      RETURN
    ENDIF
  ENDIF
  IF(findAssign(tempStr))
    aePuts('\b\nDevice not Mounted.\b\n')
    aePuts('\b\n')
    RETURN
  ENDIF
 editEmacs(tempStr)
 aePuts('\b\n')
ENDPROC


PROC edit()
  DEF c
  DEF cn,i,j,x,back,bkFlag,helplist
  DEF str[200]:STRING
  DEF space[90]:STRING
  DEF str2[10]:STRING
  DEF temp[170]:STRING
  DEF stat,brkflag
  DEF tempstr[255]:STRING

/* Clear msg buffer */
 rzmsg:=NIL
 StrCopy(str,'',ALL)
 x:=0
 bkFlag:=0

  StringF(str,'\sCommands/SysCmd/FULLEDIT.info',cmds.bbsLoc)
  IF(fileExists(str) AND checkSecurity(ACS_FULL_EDIT) AND (loggedOnUser.editorType<>1))
    IF(loggedOnUser.editorType<>2)
      aePuts('[36mFullScreen Editor[0m')
      stat:=yesNo(2)
    ELSE
      stat:=1 
    ENDIF
    IF(stat>0)
      editor.editorIncludeFile:=0
      StringF(editorFileInclude,'\sNode\d/Work/msg.i',cmds.bbsLoc,node)
      IF(saveMsg(editorFileInclude)) THEN editor.editorIncludeFile:=editorFileInclude
      StringF(str,'\sCommands/SysCmd/',cmds.bbsLoc)
      StringF(editorFileName,'\sNode\d/Work/msg',cmds.bbsLoc,node)
      editor.editorFile:=editorFileName
      editor.editorPrependFile:=0
      editor.editorPostPendFile:=0
      editor.editorFlags:=0
      editor.editorFlags:=editor.editorFlags OR ED_ABORT_ALLOWED
      editor.editorMaxWidth:=76
      editor.editorFlags:=editor.editorFlags OR ED_ANSI_ALLOWED
      editor.editorTop:=1
      editor.maxScrLength:=loggedOnUser.lineLength
      editor.maxFileLength:=100
      IF((checkSecurity(ACS_PRI_MSGFILES) OR checkSecurity(ACS_PUB_MSGFILES)) AND fileattach) THEN editor.editorFlags:=editor.editorFlags OR ED_BATCH_UPLOAD
      IF(checkSecurity(ACS_ATTACH_FILES) AND fileattach) THEN editor.editorFlags:=editor.editorFlags OR ED_ATTACH_FILE
     
      IF(runSysCommand('FULLEDIT','',1))
        IF(loadMsg(editorFileName))
          loggedOnUser.messagesPosted:=loggedOnUser.messagesPosted+1
          
          SetProtection(editorFileName,FIBF_OTR_DELETE)
          DeleteFile(editorFileName)
          SetProtection(editorFileInclude,FIBF_OTR_DELETE)
          DeleteFile(editorFileInclude)
          IF(editor.editorFlags AND ED_BATCH_REQUESTED) THEN rzmsg:=1
          editor.editorFlags:=editor.editorFlags AND Not(ED_BATCH_UPLOAD OR ED_ATTACH_FILE OR ED_BATCH_REQUESTED OR ED_ATTACH_REQUESTED)
          RETURN RESULT_SUCCESS
        ENDIF 
        editor.editorFlags:=editor.editorFlags AND Not(ED_BATCH_UPLOAD OR ED_ATTACH_FILE OR ED_BATCH_REQUESTED OR ED_ATTACH_REQUESTED)
      
        SetProtection(editorFileInclude,FIBF_OTR_DELETE)
        DeleteFile(editorFileInclude)
        RETURN -1
      ENDIF
      editor.editorFlags:=editor.editorFlags AND Not(ED_BATCH_UPLOAD OR ED_ATTACH_FILE OR ED_BATCH_REQUESTED OR ED_ATTACH_REQUESTED)
    ENDIF
  ENDIF

  aePuts('\b\n')
  aePuts('   Enter your text. (Enter) alone to end. (75 chars/line, 100 lines, max)\b\n')
  aePuts('   (|-------|-------|-------|-------|-------|-------|-------|-------|-------|--)\b\n')
  IF(lines<>0)
    FOR j:=0 TO lines-1
    StringF(space,'\d[2]> \s\b\n',j+1,msgBuf[j])
    aePuts(space)
    ENDFOR
  ENDIF
/*removed (JOE)

 if(Lines!=0) {
     for(j=0 j<Lines j++) {
         sprintf(SPACE,"%2d> \s\b\n",j+1,MsgBuf[j])
         AEPutStr(SPACE)
     }
 }
*/
  StrCopy(space,'',ALL)

 rawArrow:=TRUE

 REPEAT
     bEG_IN:
     StrCopy(msgBuf[lines],space,ALL)
     StringF(str,'\d[2]> \s',lines+1,msgBuf[lines])
     aePuts(str)

     WHILE TRUE
         next2:

         c:=readChar(INPUT_TIMEOUT)
         IF(c<0) THEN RETURN c        
         IF(c=13) 
             IF(StrLen(space)=0)
                 StrCopy(msgBuf[lines],'',ALL)
                 bkFlag:=1
                 JUMP brk
             ENDIF
             StrCopy(msgBuf[lines],space,ALL)
             StrCopy(space,'',ALL)
             aePuts('\b\n')
             x:=0
             JUMP brk
         ENDIF
         IF(c=30) 
             StrCopy(tempstr,'')
             WHILE(x)
                 strAddChar(tempstr,8)
                 StrAdd(tempstr,' ')
                 strAddChar(tempstr,8)
                 x--
             ENDWHILE
             aePuts(tempstr)
             StrCopy(space,'',ALL)
             JUMP next2
         ENDIF
         IF((c=CHAR_BACKSPACE) OR (c=177)) 
          StrCopy(tempstr,'')
          IF x>0
            strAddChar(tempstr,c)
            x--
            FOR i:=x TO StrLen(space)-2
              space[i]:=space[i+1]
              strAddChar(tempstr,space[i+1])
            ENDFOR
            StrAdd(tempstr,' ')
            FOR i:=x TO StrLen(space)-1
              StrAdd(tempstr,'[1D')
            ENDFOR
            
            SetStr(space,EstrLen(space)-1)      
            aePuts(tempstr)
          ENDIF
          JUMP next2
         ENDIF
         IF (c=CHAR_DELETE)
          StrCopy(tempstr,'')
          IF x<(StrLen(space))
            FOR i:=x TO StrLen(space)-2
              space[i]:=space[i+1]
              strAddChar(tempstr,space[i+1])
            ENDFOR
            StrAdd(tempstr,' ')
            FOR i:=x TO StrLen(space)-1
              StrAdd(tempstr,'[1D')
            ENDFOR
            SetStr(space,EstrLen(space)-1)      
            aePuts(tempstr)
          ENDIF
          JUMP next2
         ENDIF
         IF(c=CHAR_TAB)
           c:=Mod(x,8)
           IF x=(StrLen(space))
             IF(x+(8-c)>72)
              c:=CHAR_TAB
             ELSE
                 WHILE c<8
                    StrCopy(str2,' ',ALL)
                    aePuts(' ')
                    StrAdd(space,str2)
                    x++
                    c++
                 ENDWHILE
             ENDIF
           ELSE
             IF(StrLen(space)+(7-c)<75)
               FOR i:=c TO 7
                StrCopy(tempstr,'')
                StrAdd(space,'#')
               ENDFOR
               FOR i:=StrLen(space)-1 TO x+(7-c) STEP -1
                 space[i]:=space[i-(8-c)]
               ENDFOR

               FOR i:=c TO 7
                space[x]:=" "
                sendChar(" ")
                x++
               ENDFOR

                FOR i:=x TO StrLen(space)-1
                  strAddChar(tempstr,space[i])
                ENDFOR
                FOR i:=x TO StrLen(space)-1
                  StrAdd(tempstr,'[1D')
                ENDFOR
                aePuts(tempstr)
             ELSE
              c:=CHAR_TAB
             ENDIF
           ENDIF
         ENDIF
         IF ((c=LEFTARROW) AND (x>0))
           x--
           aePuts('[1D')
         ENDIF
         IF ((c=RIGHTARROW) AND (x<(StrLen(space))))
           x++
           aePuts('[1C')
         ENDIF

         IF(c<" ") THEN JUMP next2

         IF (x<StrLen(space))
            IF StrLen(space)<75
              StrCopy(tempstr,'')
              StrAdd(space,'#')
              FOR i:=StrLen(space)-1 TO x+1 STEP -1
                space[i]:=space[i-1]
              ENDFOR
              space[x]:=c
              sendChar(c)
              x++
              FOR i:=x TO StrLen(space)-1
                strAddChar(tempstr,space[i])
              ENDFOR
              FOR i:=x TO StrLen(space)-1
                StrAdd(tempstr,'[1D')
              ENDFOR
              aePuts(tempstr)
            ENDIF
         ELSE
           x++
           sendChar(c)
           StrCopy(str2,' ',ALL)
           str2[0]:=c
           StrAdd(space,str2)
         ENDIF

         IF(x>75) 
             back:=0
             brkflag:=FALSE
             FOR cn:=x TO 1 STEP -1
                 IF(space[cn-1]=" ")
                     back:=x-cn
                     SetStr(space,cn-1)
                     brkflag:=TRUE
                 ENDIF
                 EXIT brkflag
             ENDFOR
             IF(back=0)
                 StrCopy(msgBuf[lines],space,ALL)
                 aePuts('\b\n')
                 StrCopy(space,'',ALL)
                 x:=0
                 JUMP brk
             ENDIF
             StrCopy(str,'',ALL)
             FOR cn:=x-back TO x-1
                 StrCopy(str2,' ',ALL)
                 str2[0]:=space[cn]
                 StrAdd(str,str2)
             ENDFOR
             x:=StrLen(str)
             StrCopy(msgBuf[lines],space,ALL)
             StrCopy(space,str,ALL)
             StrCopy(tempstr,'')
             FOR cn:=0 TO x
                 strAddChar(tempstr,8)
                 StrAdd(tempstr,' ')
                 strAddChar(tempstr,8)
             ENDFOR
             aePuts(tempstr)
             aePuts('\b\n')
             JUMP brk
         ENDIF
     ENDWHILE
brk:
     lines++
     IF((lines=98) AND (bkFlag=0)) THEN aePuts('\b\nWarning two lines remaining.\b\n\b\n')

 UNTIL (bkFlag<>0) OR (lines>=100)

  IF(lines<100)
      lines--
  ELSE
      lines:=100
  ENDIF

 rawArrow:=FALSE

 aePuts('\b\n')

 REPEAT
cont2:
      IF(helplist=FALSE)
       aePuts('\b\n[32mMsg. Options: [33mA[36m,[33mC[36m,[33mD[36m,[33mE')
       IF(checkSecurity(ACS_ATTACH_FILES) AND fileattach) THEN aePuts('[36m,[33mF')
       aePuts('[36m,[33mL[36m,[33mS')
       IF(fileattach AND (((mailHeader.status="P") AND checkSecurity(ACS_PUB_MSGFILES)) OR (checkSecurity(ACS_PRI_MSGFILES) AND (mailHeader.status<>"P")))) THEN aePuts('[36m,[33mX')
       aePuts('[36m,[33m? [0m>:')
      ELSE
         aePuts('\b\n[33mA[32m>[36mbort[0m')
         aePuts('\b\n[33mC[32m>[36montinue[0m')
         aePuts('\b\n[33mD[32m>[36melete Lines[0m')
         aePuts('\b\n[33mE[32m>[36mdit[0m')
         IF (fileattach AND checkSecurity(ACS_ATTACH_FILES)) THEN aePuts('\b\n[33mF[32m>[36mile Attachment[0m')
         aePuts('\b\n[33mL[32m>[36mist[0m')
         aePuts('\b\n[33mS[32m>[36mave[0m')
         IF(fileattach AND (((mailHeader.status="P") AND checkSecurity(ACS_PUB_MSGFILES)) OR (checkSecurity(ACS_PRI_MSGFILES) AND (mailHeader.status<>"P")))) THEN aePuts('\b\n[33mX[32m>[36mfer Files[0m')
         aePuts('\b\n[0m >: ')
         helplist:=0
      ENDIF
     stat:=lineInput('','',10,INPUT_TIMEOUT,str)
     IF stat<0 THEN RETURN stat

     IF(str[0]="?")
        helplist:=1
        JUMP cont2
     ENDIF
     IF((str[0]="D") OR (str[0]="d"))
         REPEAT
             IF(lines=0)
                 aePuts('\b\nNo lines to delete.\b\n')
                 stat:=0
                 JUMP brk3
             ENDIF
/*
             if(Lines==89)   Lines+=1
*/
             StringF(str,'\b\n[36mLine number to delete [32m[[33m1[32m..[33m\d[32m][0m? ',lines)
             aePuts(str)
             stat:=lineInput('','',5,INPUT_TIMEOUT,str)
             IF (stat<0) THEN JUMP brk3
             
             IF(StrLen(str)=0) 
                stat:=0
                JUMP brk3
             ENDIF
             stat:=Val(str)

             IF((stat<1) OR (stat>lines))
                 StringF(str,'\b\nLine \d does not exist.\b\n',stat)
                 aePuts(str)
             ENDIF
         UNTIL (stat>0) AND (stat<=lines)
         brk3:

         IF stat<0 THEN RETURN stat

         IF (stat=0) THEN JUMP cont2

         StringF(str,'\b\n\d[2]> \s\b\n',stat,msgBuf[stat-1])
         aePuts(str)
         aePuts('\b\n[36mIs this the correct line [32m([33mY[32m/[33mN[32m)[0m? ')
         cn:=yesNo(0)
         IF cn<0 THEN RETURN stat

         IF(cn)
             FOR j:=(stat-1) TO lines-1
                     StrCopy(msgBuf[j],msgBuf[j+1],ALL)
             ENDFOR

             StringF(str,'\b\nDeleted line \d.\b\n',stat)
             lines--
             aePuts(str)
         ENDIF
         JUMP cont2
     ENDIF

     IF((str[0]="C") OR (str[0]="c")) 
         aePuts('\b\n')
         lines--
         IF(lines<0) THEN lines:=0
         StrCopy(space,msgBuf[lines],ALL)
         bkFlag:=0
         x:=StrLen(space)
         JUMP bEG_IN
     ENDIF
     IF((str[0]="E") OR (str[0]="e")) 
         IF(lines<1) 
             aePuts('\b\nNo Lines to edit!\b\n')
             JUMP cont2
         ENDIF
loopHere:
         StringF(str,'\b\n[36mLine number to edit [32m[[33m1[32m..[33m\d[32m][0m? ',lines)
         aePuts(str)

         stat:=lineInput('','',5,INPUT_TIMEOUT,str)
         IF (stat<0) THEN RETURN RESULT_TIMEOUT
         IF(StrLen(str)=0) THEN JUMP cont2

         x:=Val(str)
         IF((x<1) OR (x>lines))
             StringF(str,'\b\nLine \d does not exist.\b\n',x)
             aePuts(str)
             JUMP loopHere
         ENDIF
         StrCopy(temp,msgBuf[x-1])
         aePuts('\b\n    Edit Line')
         aePuts('\b\n   (---------------------------------------------------------------------------)')
         stat:=lineInput('\b\n    ',temp,75,INPUT_TIMEOUT,temp)
         IF (stat<0) THEN RETURN stat
         StrCopy(msgBuf[x-1],temp,ALL)
         
         /*StringF(space,'\b\n\d[2]> \s\b\n',x,msgBuf[x-1])
         aePuts(space)
         aePuts('\b\n    Old string;New string')
         aePuts('\b\n   (------------------------------------------------------------)')
         aePuts('\b\n   :')

         stat:=lineInput('','',60,INPUT_TIMEOUT,str)
         IF(stat<0) THEN RETURN RESULT_TIMEOUT
         IF(StrLen(str)=0) THEN JUMP cont2

         stat:=processLine(str,msgBuf[x-1],temp)
         IF(stat=0) 
             aePuts('\b\nString not found!\b\n')
             JUMP cont2
         ELSE
             aePuts('\b\n    NewLine:\b\n    --------\b\n   >')
             aePuts(temp)
             aePuts('\b\n\b\nCorrect ')

             stat:=yesNo(1)
             IF (stat<0) THEN RETURN stat
             IF (stat=0) THEN JUMP cont2

             StrCopy(msgBuf[x-1],temp,ALL)
         ENDIF*/
         JUMP cont2
     ENDIF

     IF((str[0]="L") OR (str[0]="l")) 
         aePuts('\b\n')
         FOR j:=0 TO lines-1
             StringF(space,'\d[2]> \s\b\n',j+1,msgBuf[j])
             aePuts(space)
         ENDFOR
         JUMP cont2
     ENDIF

     IF((str[0]="F") OR (str[0]="f"))
         IF(checkSecurity(ACS_ATTACH_FILES) AND fileattach) 
             WHILE TRUE
                 IF(ximPort=CONSOLE_PORT)
                    asl(attachedFile)
                 ELSE
                  aePuts('\b\nEnter path/filename to attach (''5 <DIR>''=DIR): ')
                  stat:=lineInput('','',250,INPUT_TIMEOUT,attachedFile)
                  IF(stat<0) THEN RETURN stat
                  IF((attachedFile[0]="5") AND (attachedFile[1]=" "))
                    myDirAnyWhere(attachedFile)
                    StrCopy(attachedFile,'')
                    JUMP cont2
                  ENDIF
                 ENDIF
                 IF(StrLen(attachedFile)>0)
                    LowerStr(attachedFile)
                    IF(findAssign(attachedFile))
                      aePuts('\b\nDevice not Mounted.\b\n')
                      aePuts('\b\n')
                      StrCopy(attachedFile,'')
                      JUMP cont2 
                    ENDIF
                    IF(restricted(attachedFile))
                      StrCopy(attachedFile,'')
                      JUMP cont2 
                    ELSE
                      aePuts('Delete file when message is deleted ')
                      stat:=yesNo(2)
                      IF(stat<0) THEN RETURN stat
                      LowerStr(attachedFile)
                      IF(stat)
                        attachedFile[0]:=charToUpper(attachedFile[0])
                      ENDIF
                    ENDIF
                 ENDIF
                 EXIT TRUE
             ENDWHILE
         ELSE
            higherAccess()
         ENDIF

     ENDIF
     IF((str[0]="S") OR (str[0]="s"))
         loggedOnUser.messagesPosted:=loggedOnUser.messagesPosted+1
         RETURN RESULT_SUCCESS
     ENDIF

     IF(fileattach AND ((str[0]="X") OR (str[0]="x")) AND ((checkSecurity(ACS_PRI_MSGFILES)) OR (checkSecurity(ACS_PUB_MSGFILES))))
       rzmsg:=1
       loggedOnUser.messagesPosted:=loggedOnUser.messagesPosted+1
       RETURN RESULT_SUCCESS
     ENDIF
     IF((str[0]="A") OR(str[0]="a")) 
         aePuts('\b\nAbort message entry (y/n)? ')
         stat:=yesNo(0)
         IF(stat<0) THEN RETURN stat
         IF(stat>0) THEN RETURN -1
     ENDIF
 UNTIL stat<0
ENDPROC stat

PROC enterMSG(gfh)
  DEF aFlag
  DEF i,i2,i3
  DEF rzmsglock
  DEF str[255]:STRING
  DEF string[255]:STRING
  DEF f
  DEF netmail
  DEF msgbaselock
  DEF firstparam
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF exit
  DEF stat
  DEF filetags  

  aFlag:=0
  netmail:=0

 StrCopy(attachedFile,'',ALL)
 IF(comment=1)
     comment:=0
     JUMP skipAll
 ENDIF

 IF(replyFlag=1)
   JUMP skipBegin
 ELSE
     IF(ListLen(parsedParams)>0) 
          firstparam:=ListItem(parsedParams,0)
          IF(StrLen(firstparam)<=30)        
             strCpy(mailHeader.toName,firstparam,31)
             msgToHeader()
             aePuts(mailHeader.toName)
             aePuts('\b\n')
             JUMP skipEntry
         ENDIF
     ENDIF
  ENDIF
 

 msgToHeader()
 stat:=lineInput('','',30,INPUT_TIMEOUT,tempStr)
 strCpy(mailHeader.toName,tempStr,31)
 IF(stat<0)
   RETURN stat
 ENDIF

skipEntry:

 mailHeader.status:="P"
 IF(StrLen(mailHeader.toName)=0) 
     aFlag:=1
     strCpy(mailHeader.toName,'ALL',ALL)
 ELSE
     strCpy(str,mailHeader.toName,31)
     LowerStr(str)                          /* convert string to lower case */
     stat:=StrCmp(str,'eall',4)            /* looking for eall             */

     IF(stat)
         IF(checkSecurity(ACS_EALL_MESSAGES)) 
             aFlag:=2
             strCpy(mailHeader.toName,'EALL',ALL)
         ELSE
             aePuts('\b\nUser does not exist!!\b\n\b\n')
             RETURN RESULT_FAILURE
         ENDIF
     ELSE
         stat:=StrCmp(str,'sysop',5)
         IF(stat)
             loadAccount(1,tempUser,tempUserKeys,tempUserMisc)
         ELSE
             IF(netflag=FALSE)
               stat:=chooseAName(mailHeader.toName,tempUser,tempUserKeys,tempUserMisc,1)
               IF(stat<0)
                 RETURN stat
               ENDIF
             ELSE
               strCpy(mailHeader.toName,str,31)
               netmail:=1
             ENDIF
         ENDIF
         IF(netmail=FALSE)
           strCpy(mailHeader.toName,tempUserKeys.userName,31)
           IF(isTempConf(tempUser,currentConf-1)=FALSE)
             aePuts('\b\nUser does not have access to this conference!\b\n\b\n')
             RETURN RESULT_FAILURE
           ENDIF
           netmail:=0
         ENDIF
     ENDIF
 ENDIF

 checkToForward(str,mailHeader.toName,1)
 /*
    netflag not yet implemented
   IF(netflag)
    aePuts('[36m  ToNet[33m: [32m([33mBlank[32m)[0m= [33mN/A [32m?[0m ')
    stat:=lineInput('','',7,INPUT_TIMEOUT,mailHeader.toNet--cantdothis)
    IF(stat<0)
      RETURN stat
    ENDIF

    IF(validNet((mailHeader.toNet)=FALSE) 
      aePuts('[32mThis BBS does not recognize that net address\b\n\b\n')
      RETURN RESULT_FAILURE
    ENDIF

    strCpy(mailHeader.fromNet,Sopt->BBSConfig,ALL)
 ENDIF*/

 aePuts('[36mSubject[33m: [32m([33mBlank[32m)[0m=[33mabort[32m?[0m ')
 stat:=lineInput('','',30,INPUT_TIMEOUT,tempStr)
 strCpy(mailHeader.subject,tempStr,31)
 IF(stat<0)
    RETURN stat
 ENDIF

 IF(StrLen(mailHeader.subject)=0)
    aePuts('\b\n')
    RETURN RESULT_FAILURE
 ENDIF

skipBegin:
 IF(aFlag=FALSE)
     aePuts('         [36mPrivate ')
     stat:=yesNo(2)
     IF(stat<0)
        RETURN stat
     ENDIF

     IF (stat) THEN mailHeader.status:="R" ELSE mailHeader.status:="P"
 ENDIF

 IF(replyFlag=1)
     replyFlag:=0
     aePuts('  [36mQuote in Reply ')
     stat:=yesNo(2)
     IF(stat<0)
        RETURN stat
     ENDIF

     IF(stat)
         StringF(tempStr,'\s\d',msgBaseLocation,mailHeader.msgNumb)
         IF(stat:=loadMsg(tempStr)) 
             aePuts('\b\n')
             nonStopDisplayFlag:=FALSE
             lineCount:=0
             FOR i:=0 TO lines-1
                 StringF(str,'\z\l\d[2]> \s\b\n',i+1,msgBuf[i])
                 aePuts(str)
                 EXIT stat:=checkForPause()
             ENDFOR
             WHILE TRUE
                 aePuts('\b\n Enter Startline,Endline or (*=ALL, A=Abort): ')
                 stat:=lineInput('','',6,INPUT_TIMEOUT,str)
                 IF(stat<0)
                    RETURN stat
                 ENDIF
         exit:=FALSE
                 stat:=firstCharValue(str)
                 IF((stat="A") OR (stat="a"))
                     i:=(-1)
                     lines:=0
                     exit:=TRUE
                 ENDIF
                 EXIT exit

                 IF(stat="*")
                     i:=1
                     i2:=lines
                 ELSE
                    IF (i:=InStr(str,','))<>-1
                      i2:=Val(str+i+1)
                    i:=Val(str)
                    ENDIF
                    ->sscanf(str,"%d,%d",&i,&i2)
                 ENDIF

                 EXIT (((i>0) AND (i<=lines)) AND ((i2>0) AND (i2<=lines)) AND (i<=i2))

             ENDWHILE
             IF(i<>(-1))
                 FOR i3:=0 TO i2-i
                      
                   /*  if(i3<98) {
                    sprintf(str,">\s",MsgBuf[i+i3-1])
                    strcpy(MsgBuf[i3],str)
                      }
                   */
                   IF(i3<97)
                     StrCopy(str,msgBuf[i+i3-1],ALL)
                     StrCopy(msgBuf[i3],str,ALL)
                   ENDIF
                 ENDFOR
                 
                 IF (i3<97)
                    lines:=i3
                 ELSE
                    lines:=97
                 ENDIF

                 StringF(msgBuf[lines],' ^^^-[ \s ]',mailHeader.fromName)
                 WHILE(StrLen(msgBuf[lines])<70)
                    StrAdd(msgBuf[lines],'-')
                 ENDWHILE

                 lines++
                 StrCopy(msgBuf[lines++],' ',ALL)
                 StrCopy(msgBuf[lines],'',ALL)
                 /****new reply routines ****/

             ELSE
                 FOR i:=0 TO 99
                     StrCopy(msgBuf[i],'',ALL)
                 ENDFOR
             ENDIF
         ENDIF
     ELSE
        FOR i:=0 TO 99
          StrCopy(msgBuf[i],'',ALL)
        ENDFOR
         lines:=0
     ENDIF
 ELSE

skipAll:
     FOR i:=0 TO 99
        StrCopy(msgBuf[i],'',ALL)
     ENDFOR
     lines:=0
 ENDIF

 stat:=edit()
 IF((stat=RESULT_TIMEOUT) OR (stat=RESULT_NO_CARRIER))
    RETURN stat
 ENDIF

 IF(stat<0)
    aePuts('\b\n')
    RETURN RESULT_FAILURE
 ENDIF
   
 aePuts('Saving...')
 mailHeader.recv:=0
 mailHeader.msgDate:=getSystemTime()
 strCpy(mailHeader.fromName,loggedOnUser.name,31)
 IF(msgbaselock:=lockMsgBase())
     getMailStatFile()
     mailHeader.msgNumb:=mailStat.highMsgNum
     stat:=saveMessageHeader(gfh)
     IF(stat<>RESULT_FAILURE) 
         StringF(string,'Message Number \d...',mailHeader.msgNumb)
         aePuts(string)
         StringF(tempStr,'\s\d',msgBaseLocation,mailHeader.msgNumb)
         IF((f:=Open(tempStr,MODE_NEWFILE)))<=0
             aePuts('Failed!\b\n\b\n')
             rzmsg:=NIL
             RETURN RESULT_FAILURE
         ENDIF
         FOR i:=0 TO lines-1
             StringF(tempStr2,'\s\b\n',msgBuf[i])
             Write(f,tempStr2,StrLen(tempStr2))
          ENDFOR
         Close(f)
         aePuts('done!\b\n\b\n')

         IF(StrLen(attachedFile)<>0)
             SetComment(tempStr,attachedFile)
             StrCopy(attachedFile,'',ALL)
         ENDIF
     ELSE
        aePuts('Failed!\b\n\b\n')
     ENDIF
     UnLock(msgbaselock)

    IF (tempUser.slotNumber=1)
      IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ON_SYSOP_COMMENT',tempStr))
        filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,NIL]:LONG
        processMci2(tempStr,tempStr2)
        SystemTagList(tempStr2,filetags)
        END filetags
      ENDIF
      IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ASYNC_ON_SYSOP_COMMENT',tempStr))
        filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,TRUE,NIL]:LONG
        processMci2(tempStr,tempStr2)
        SystemTagList(tempStr2,filetags)
        END filetags
      ENDIF
      IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_SYSOP_COMMENT')) AND (StrLen(mailOptions.sysopEmail)>0)
        StringF(tempStr,'\s: Ami-Express sysop message notification',cmds.bbsName)
        StringF(tempStr2,'This is a notification that \s has sent you a message.\n\nSubject: \s\n\n',mailHeader.fromName,mailHeader.subject)
        sendMail(tempStr,tempStr2,TRUE, mailOptions.sysopEmail)
      ENDIF
    ENDIF
  
     IF(rzmsg)
       StringF(tempStr,'\sF\d',msgBaseLocation,mailHeader.msgNumb)
       IF(rzmsglock=CreateDir(tempStr))
         UnLock(rzmsglock)
       ENDIF
       setEnvStat(ENV_UPLOADING) 
       aePuts('\b\n')           /* 11w */
       stat:=uploadaFile(0,'','')
       rzmsg:=NIL
       StringF(tempStr,'\sF\d',msgBaseLocation,mailHeader.msgNumb)
       SetProtection(tempStr,FIBF_OTR_DELETE)
       DeleteFile(tempStr)
       IF(stat=RESULT_GOODBYE)
         fileattach:=FALSE
         reqState:=REQ_STATE_LOGOFF
         RETURN RESULT_STANDARD_LOGOFF
       ENDIF
       
       IF(stat=RESULT_NO_CARRIER) THEN RETURN RESULT_NO_CARRIER
       RETURN stat
      ENDIF
 ELSE
     aePuts('ERROR! Another task has the MsgBase locked!\b\nMessage has not been saved!\b\n\b\n')
 ENDIF
 rzmsg:=NIL

ENDPROC RESULT_SUCCESS

PROC replyPrompt(gfh)
  DEF tempUser: PTR TO user
  DEF tempUserKeys: PTR TO userKeys
  DEF tempUserMisc: PTR TO userMisc
  DEF unum, helplist
  DEF str[255]:STRING
  DEF string[255]:STRING
  DEF stat
  
  helplist:=0
  WHILE TRUE
  contloop:
    fwdFlag:=0
    IF(helplist=FALSE)
       IF(nonStopMail=FALSE)
        aePuts('\b\n[32mMsg. Options: [33mA[36m')
        IF checkSecurity(ACS_DELETE_MESSAGE) THEN aePuts(',[33mD')
        aePuts('[36m,[33mR[36m,[33mQ')
        StringF(string,'[36m,[33m?[36m,[32m<[33mCR[32m> [32m([0m \d[32m )[0m >: ',msgNum)
        aePuts(string)
       ENDIF
    ELSE
         aePuts('\b\n[33mA[32m>[36mgain[0m')
         IF checkSecurity(ACS_DELETE_MESSAGE) THEN aePuts('\b\n[33mD[32m>[36melete Message[0m')
         aePuts('\b\n[33mR[32m>[36meply[0m')
         aePuts('\b\n[33mQ[32m>[36muit[0m')
         StringF(string,'\b\n[32m<[33mCR[32m>[0m=[33mNext [32m([0m \d[32m )[0m >: ',msgNum)
         aePuts(string)
         helplist:=0
    ENDIF

   IF(nonStopMail=FALSE)
       stat:=lineInput('','',10,INPUT_TIMEOUT,str)
       IF(stat<0) THEN RETURN stat
   ENDIF  
    IF(str[0]="?") 
      helplist:=1
      JUMP contloop
    ENDIF

    IF(((str[0]="N") OR (str[0]="n")) AND ((str[1]="S") OR (str[1]="s"))) THEN nonStopMail:=TRUE

    IF((StrLen(str)=0) OR (nonStopMail)) THEN RETURN RESULT_SUCCESS

    IF(((str[0]="A") OR (str[0]="a")))
           stat:=displayMessage(gfh)
           IF(stat<0) THEN RETURN stat
           JUMP contloop
    ENDIF
    IF checkSecurity(ACS_DELETE_MESSAGE)
      IF(((str[0]="D") OR (str[0]="d")))
         IF((privateFlag=0) OR ((stringCompare(mailHeader.toName,loggedOnUser.name)=RESULT_SUCCESS) AND
              ((netflag=FALSE) /*   netflag stuff not yet implemented OR (StrCmp(Sopt->BBSConfig,MailHeader.ToNet))*/)))
             stat:=deleteMSG(gfh)
             RETURN RESULT_SUCCESS
         ELSE
             aePuts('\b\nNot your message.\b\n')
             JUMP contloop
         ENDIF
      ENDIF
    ENDIF
   IF(((str[0]="E") OR (str[0]="e")) AND (checkSecurity(ACS_MESSAGE_EDIT))) 
         IF((str[1]="H") OR (str[1]="h"))
          IF((stat:=editHeader(gfh))<0) THEN RETURN stat
         ELSE
           editEMessage(mailHeader.msgNumb)
         ENDIF
       stat:=displayMessage(gfh)
       IF(stat<0) THEN RETURN stat
       JUMP contloop
   ENDIF
   IF(((str[0]="U") OR (str[0]="u"))) 
       IF(checkSecurity(ACS_ACCOUNT_EDITING)) 
           StrCopy(str,mailHeader.fromName,31)
           unum:=findUserFromName(1,NAME_TYPE_USERNAME,str,tempUser,tempUserKeys,tempUserMisc)
           stat:=loadAccount(unum,tempUser,tempUserKeys,tempUserMisc)
           IF(stat=RESULT_FAILURE)
               aePuts('Warning, error while loading account\b\n')
               JUMP contloop
           ENDIF

           sendCLS()
           callersLog('\tAccount editing from mail.')
           editInfo(unum,tempUser,tempUserKeys,tempUserMisc,FALSE)
           sendCLS()
           stat:=displayMessage(gfh)
           IF(stat<0) THEN RETURN stat
           JUMP contloop
       ENDIF
   ENDIF
   IF((str[0]="Q") OR (str[0]="q"))
       aePuts('\b\n')
       RETURN RESULT_FAILURE
   ENDIF

   IF(((str[0]="r") OR (str[0]="R")))
     IF((privateFlag=0) OR ((stringCompare(mailHeader.toName,loggedOnUser.name)=RESULT_SUCCESS)
         AND ((netflag=FALSE) /*   netflag stuff not yet implemented OR (!strcmp(Sopt->BBSConfig,MailHeader.ToNet))*/)) OR (StrCmp(mailHeader.toName,'EALL',4)))
         stat:=replyToMSG(gfh)
         RETURN RESULT_SUCCESS
     ELSE
         aePuts('\b\nNot your message.\b\n')
         JUMP contloop
     ENDIF
   ENDIF
 aePuts('\b\nNo such command!!\b\n')
ENDWHILE

ENDPROC RESULT_SUCCESS

PROC nameCompare(s,t)
 IF(sopt.toggles[TOGGLES_USEWILDCARDS])
    RETURN stringCompare(s,t)
 ELSEIF StrCmp(s,t)
    RETURN 0
 ENDIF
ENDPROC 1

PROC checkForAst(s)
  DEF i
  FOR i:=0 TO StrLen(s)-1
     IF((s[i]="*") AND (sopt.toggles[TOGGLES_USEWILDCARDS])) THEN RETURN i+1
  ENDFOR

ENDPROC FALSE

PROC checkIfNameAllowed(name)
  DEF num,loop
  DEF disallowedName[255]:STRING

  IF strCmpi(name,'',ALL)
    aePuts('Username not allowed!!\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  IF strCmpi(name,'ACS.',4)
    aePuts('Username not allowed!!\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  num:=1
  loop:=TRUE
  WHILE loop
    IF readToolType(TOOLTYPE_NAMESNOTALLOWED,'',num,disallowedName)=FALSE
      loop:=FALSE
    ELSE
      IF(strCmpi(name,disallowedName,ALL))
        aePuts('Username not allowed!!\b\n\b\n')
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF
    num++
  ENDWHILE
ENDPROC RESULT_SUCCESS

PROC numberOfLinesTest()
 DEF stat
 DEF str[20]:STRING

 FOR stat:=70 TO 2 STEP -1
  StringF(str,' \d\b\n',stat)
      aePuts(str)
 ENDFOR
 aePuts('\b\nEnter the number you see at the top of your screen: ')
 stat:=lineInput('','',3,INPUT_TIMEOUT,str)
 IF(stat<0) THEN RETURN stat
 IF(StrLen(str)=0) THEN RETURN RESULT_SUCCESS
 stat:=Val(str)

 IF((stat < 1) OR (stat > 255)) THEN RETURN RESULT_FAILURE
 loggedOnUser.lineLength:=stat
ENDPROC RESULT_SUCCESS


PROC chooseComputer()
 DEF stat
 DEF tempStr[40]:STRING
 
 FOR stat:=0 TO ListLen(computerTypes)-1 STEP 2
  StringF(tempStr,'\d[2]> \l\s[34] ',stat+1,computerTypes[stat])
  aePuts(tempStr)
  IF((stat+1)<ListLen(computerTypes))
    StringF(tempStr,'\d[2]> \l\s[34]\b\n',stat+2,computerTypes[stat+1])
    aePuts(tempStr)
  ELSE
    aePuts('\b\n')
  ENDIF

 ENDFOR
 aePuts('\b\n')

jLoop5:
 aePuts('Choose computer type: ')
 stat:=lineInput('','',3,INPUT_TIMEOUT,tempStr)
 IF(stat<0) THEN RETURN stat
 IF(StrLen(tempStr)=0) THEN RETURN RESULT_SUCCESS
 stat:=Val(tempStr)
 IF((stat <= 0) OR (stat > ListLen(computerTypes))) THEN JUMP jLoop5

 loggedOnUser.secBulletin:=stat-1
 
ENDPROC RESULT_SUCCESS

PROC chooseScreenType()

 DEF stat
 DEF tempStr[40]:STRING
 
 FOR stat:=1 TO ListLen(screenTypeTitle)
  StringF(tempStr,'\d> \l\s\b\n',stat,screenTypeTitle[stat-1])
  aePuts(tempStr)
 ENDFOR

stLoop5:
 aePuts('\b\nChoose screen type: ')
 stat:=lineInput('','',3,INPUT_TIMEOUT,tempStr)
 IF(stat<0) THEN RETURN stat
 IF(StrLen(tempStr)=0) THEN RETURN RESULT_SUCCESS
 stat:=Val(tempStr)
 IF((stat <= 0) OR (stat > ListLen(screenTypeTitle))) THEN JUMP stLoop5

 loggedOnUser.screenType:=stat-1
 
ENDPROC RESULT_SUCCESS

PROC chooseProtocol()
  DEF stat,i
  DEF tempStr[40]:STRING

  FOR i:=1 TO ListLen(xprTitle)
    StringF(tempStr,'\d> \s\b\n',i,xprTitle[i-1])
    aePuts(tempStr)
  ENDFOR
pLoop1:
  aePuts('\b\nChoose protocol: ')
         
  stat:=lineInput('','',5,INPUT_TIMEOUT,tempStr)
  IF(stat<0) THEN RETURN stat

  IF(StrLen(tempStr)=0) THEN RETURN RESULT_SUCCESS
  stat:=Val(tempStr)
  IF((stat <= 0) OR (stat > ListLen(xprTitle))) THEN JUMP pLoop1

  loggedOnUser.xferProtocol:=stat-1
ENDPROC

PROC findUserFromNumber(start,hoozer:PTR TO userKeys)
  DEF fh
  DEF tempstr[255]:STRING
  fh:=Open(userKeysFile,MODE_OLDFILE)
  IF(fh=NIL) THEN RETURN 0
  Seek(fh,(start-1)*SIZEOF userKeys,OFFSET_BEGINNING)
  IF(Read(fh,hoozer,SIZEOF userKeys)>0)
    Close(fh)
    RETURN 1
  ENDIF
  Close(fh)
ENDPROC 0

PROC findUserFromName(start,nameType,name, hoozer: PTR TO user, hoozer2: PTR TO userKeys, hoozer3: PTR TO userMisc)
  DEF slot, stat, fh,fh2
  DEF tempStr[255]:STRING

 start--
 StrCopy(tempStr,name,31)
 UpperStr(tempStr)

 fh:=Open(userKeysFile,MODE_OLDFILE)
 IF(fh<=0) THEN RETURN 0
 Seek(fh,start*SIZEOF userKeys,OFFSET_BEGINNING)

 fh2:=Open(userMiscFile,MODE_OLDFILE)
 IF(fh2<=0) THEN RETURN 0
 Seek(fh2,start*SIZEOF userMisc,OFFSET_BEGINNING)

 slot:=0
 REPEAT
  stat:=Read(fh,hoozer2,SIZEOF userKeys)
  IF(stat<>SIZEOF userKeys)
    Close(fh)
    Close(fh2)
    RETURN 0
  ENDIF

  stat:=Read(fh2,hoozer3,SIZEOF userMisc)
  IF(stat<>SIZEOF userMisc)
    Close(fh)
    Close(fh2)
    RETURN 0
  ENDIF

  slot++
  SELECT nameType
    CASE NAME_TYPE_USERNAME
      IF ((nameCompare(hoozer2.userName,tempStr)=RESULT_SUCCESS) AND (hoozer2.number<>0))
        Close(fh)
        Close(fh2)
        RETURN start+slot
      ENDIF
    CASE NAME_TYPE_REALNAME
      IF ((nameCompare(hoozer3.realName,tempStr)=RESULT_SUCCESS) AND (hoozer2.number<>0))
        Close(fh)
        Close(fh2)
        RETURN start+slot
      ENDIF
    CASE NAME_TYPE_INTERNETNAME
      IF ((nameCompare(hoozer3.internetName,tempStr)=RESULT_SUCCESS) AND (hoozer2.number<>0))
        Close(fh)
        Close(fh2)
        RETURN start+slot
      ENDIF
  ENDSELECT
 UNTIL FALSE
 Close(fh)
 Close(fh2)
ENDPROC 0

PROC chooseAName(s,hoozer: PTR TO user,hoozer2: PTR TO userKeys,hoozer3: PTR TO userMisc,lflag)
  DEF stat,i
  i:=1
 REPEAT
     stat:=findUserFromName(i,NAME_TYPE_USERNAME,s,hoozer,hoozer2,hoozer3)
     IF(stat=0) 
         IF(lflag) THEN aePuts('\b\nUser does not exist!!\b\n\b\n')
         RETURN RESULT_FAILURE
     ENDIF
     IF(stat:=checkForAst(s)) 
         IF((stat<4) OR ((sopt.toggles[TOGGLES_USEWILDCARDS])=FALSE)) THEN RETURN RESULT_FAILURE
         aePuts(' Expand: ')
         aePuts(hoozer2.userName)
         aePuts(' Correct ')
         stat:=yesNo(1)
         IF(stat<0) THEN RETURN stat
         IF(stat=0)
             IF(ansiColour) THEN aePuts('[A[K')
             stat:=1
             i:=(hoozer2.number)+1
         ELSE
          stat:=0
         ENDIF

     ELSE
      stat:=0
     ENDIF
 UNTIL stat=0
 loadAccount(hoozer2.number,hoozer,hoozer2,NIL)

ENDPROC 1

PROC isTempConf(user: PTR TO user,conf)
   DEF tooltypeName[10]:STRING
   StringF(tooltypeName,'CONF.\d',conf+1)

   IF checkToolTypeExists(TOOLTYPE_AREA,user.conferenceAccess,tooltypeName) THEN RETURN 1 ELSE RETURN 0
ENDPROC

PROC getAValidName(name, default, str)
  DEF stat

 IF(StrLen(name)=0)
   StrCopy(str,default,31)
   RETURN 0
 ENDIF

 StrCopy(str,name,31)
 LowerStr(str)
 IF(StrCmp(str,'all',3))
    UpperStr(str)
    RETURN 1
 ENDIF

 IF(StrCmp(str,'eall',4))
     UpperStr(str)
     RETURN 1
 ENDIF
 
 IF(StrCmp(str,'sysop',5))
    loadAccount(1,tempUser,tempUserKeys,tempUserMisc)
 ELSE
    stat:=chooseAName(name,tempUser,tempUserKeys,tempUserMisc,1)
    IF(stat<0)
      StrCopy(str,'',ALL)
      RETURN 0
    ENDIF
  ENDIF

  StrCopy(str,tempUserKeys.userName,31)
  IF(isTempConf(tempUser,currentConf-1)=FALSE)
     aePuts('\b\nUser does not have access to this conference, try another!\b\n\b\n')
    StrCopy(str,'',ALL)
    RETURN 0
 ENDIF
ENDPROC 0

PROC editHeader(gfh)
  DEF aFlag
  DEF mh: PTR TO mailHeader
  DEF string[200]:STRING
  DEF stat
 
 mh:=NEW mailHeader
 mh.status:="P"
 aePuts('\b\n')
 StringF(string,'     [36mFrom[33m: [32m([33mEnter[32m)[0m=[32m''[33m\s[32m''[32m?[0m ',mailHeader.fromName)
 aePuts(string)
 stat:=lineInput('','',30,INPUT_TIMEOUT,string)
 IF (stat<0) THEN RETURN stat
 aFlag:=getAValidName(string,mailHeader.fromName,mh.fromName)

 IF(mh.fromName[0]=0) THEN RETURN 2

 IF(aFlag)
   aePuts('Invalid From Name. Aborting.\b\n')
   RETURN 2
 ENDIF
 StringF(string,'     [36m  To[33m: [32m([33mEnter[32m)[0m=[32m''[33m\s[32m''[32m?[0m ',mailHeader.toName)
 aePuts(string)
 stat:=lineInput('','',30,INPUT_TIMEOUT,string)
 IF(stat<0) THEN RETURN stat
 aFlag:=getAValidName(string,mailHeader.toName,mh.toName)

 IF(mh.toName[0]=0) THEN RETURN 2
 StringF(string,'  [36mSubject[33m: [32m([33mEnter[32m)[0m=[32m''[33m\s[32m''[32m?[0m ',mailHeader.subject)
 aePuts(string)
 stat:=lineInput('','',30,INPUT_TIMEOUT,string)
 IF(stat<0) THEN RETURN stat
 IF(string[0]>=" ") THEN strCpy(mh.subject,string,30)

 IF(aFlag=FALSE)
    aePuts('         [36mPrivate ')
    stat:=yesNo(2)
    IF(stat<0) THEN RETURN stat
    IF(stat) THEN mh.status:="R" ELSE mh.status:="P"
  ENDIF

 mh.recv:=0
 
 END mailHeader
 mailHeader:=mh
 delMsgNum:=msgNum-fwdFlag
 saveOverHeader(gfh)

ENDPROC 1

PROC searchNewMail(gfh, cn)
  DEF mailFlag,msgcnt,dcnt,displayMsg
  DEF mailStatus[7]:STRING
  DEF tempStr[255]:STRING
  DEF stat
  msgcnt:=0
  dcnt:=0
  

  mailFlag:=0
  nonStopMail:=FALSE
  displayMsg:=0

  IF(mailStat.highMsgNum<lastNewReadConf) THEN lastNewReadConf:=mailStat.lowestKey

  IF(currentConf=0)
    StringF(tempStr,'[32mScanning Conference[33m: [0m\s - ',currentConfName)
    aePuts(tempStr)
  ENDIF

  msgNum:=lastNewReadConf

  IF(msgNum<=0) THEN lastNewReadConf:=msgNum:=mailStat.lowestKey

  IF(msgNum<mailStat.lowestKey) THEN msgNum:=mailStat.lowestKey
  IF(msgNum>=mailStat.highMsgNum)
     IF(currentConf=0) THEN aePuts('No mail today!\b\n') ELSE aePuts('\b\n')
     RETURN RESULT_SUCCESS
  ENDIF

  /*IF(currentConf<>0) 
    aePuts('\b\nNew Mail Scan.....')
  ENDIF*/

  REPEAT
     IF(msgNum>=mailStat.highMsgNum)
         JUMP getOUT
     ENDIF
   stat:=loadMessageHeader(gfh)
   IF(mailHeader.status="D") THEN JUMP getNextMSG
   
   IF(((stringCompare(mailHeader.toName,loggedOnUser.name)=RESULT_SUCCESS) OR (stringCompare(mailHeader.toName,'eall')=RESULT_SUCCESS))) AND (mailHeader.recv=0)
     IF(currentConf=0)

     ->IF((netflag=0) OR (StrCmp(Sopt->BBSConfig,mailHeader.toNet))=FALSE)
       IF(mailFlag=0)
           displayMsg:=msgNum
           aePuts('\b\n\b\n')
           aePuts('[32mType     From                           Subject                Msg    \b\n')
           aePuts('[33m-------  -----------------------------  ---------------------  -------\b\n')
           aePuts('[0m')
           mailFlag:=1
       ENDIF
       IF (mailHeader="P") THEN StrCopy(mailStatus,'Public ') ELSE StrCopy(mailStatus,'Private')
       StringF(tempStr,'\s  \l\s[29]  \l\s[21]  [0m\z\r\d[6]\b\n',mailStatus,mailHeader.fromName,mailHeader.subject,mailHeader.msgNumb)
       aePuts(tempStr)
        
     ->ENDIF
     ELSE
       IF mailFlag=0
         displayMsg:=msgNum
         mailFlag:=1
       ENDIF
     ENDIF
  ENDIF
 getNextMSG:
 msgNum++
 UNTIL msgNum>mailStat.highMsgNum

getOUT:
 IF(currentConf<>0) AND (mailFlag) THEN aePuts('\b\nFound Mail!')
 IF (mailFlag)
   aePuts('\b\nWould you like to read it now ')
   stat:=yesNo(1)
   IF(stat<0) THEN RETURN stat
   IF(stat)
     msgNum:=displayMsg
     WHILE (msgNum<mailStat.highMsgNum)
       stat:=loadMessageHeader(gfh)
       IF(mailHeader.status<>"D")   
         IF(((stringCompare(mailHeader.toName,loggedOnUser.name)=RESULT_SUCCESS) OR (stringCompare(mailHeader.toName,'eall')=RESULT_SUCCESS))) AND (mailHeader.recv=0)
           stat:=displayMessage(gfh)
           IF(stat<0) THEN RETURN stat
           stat:=replyPrompt(gfh)
           lastNewReadConf:=msgNum+1
           IF(stat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
           IF(stat<0) THEN RETURN stat
         ENDIF
       ENDIF
       msgNum++
     ENDWHILE
   ELSE
       aePuts('\b\n')
       RETURN RESULT_SUCCESS
   ENDIF
 ELSE
   lastNewReadConf:=msgNum
 ENDIF

 ->IF(mailFlag=0) THEN aePuts('No mail today!\b\n')
ENDPROC RESULT_SUCCESS

PROC saveOverHeader(gfh)
  DEF headPoint,size,filePos,error,temp

 headPoint:=delMsgNum-mailStat.lowestKey
 size:=110
 filePos:=Mul(size,headPoint)
 temp:=filePos-currentSeekPos

 error:=Seek(gfh,temp,OFFSET_CURRENT)
 IF(error<0)
     myError(ERR_MSGBASE)
     RETURN RESULT_FAILURE
 ENDIF

  mailHeader.pad:=0
  error:=Write(gfh,mailHeader,1)    -> STATUS
  error:=error+Write(gfh,mailHeader+110,1)   ->PAD
  error:=error+Write(gfh,mailHeader+2,4)   ->MsgNum
  error:=error+Write(gfh,mailHeader+6,31)   ->toName
  error:=error+Write(gfh,mailHeader+38,31)   ->fromName
  error:=error+Write(gfh,mailHeader+70,31)   ->subject
  error:=error+Write(gfh,mailHeader+110,1)   ->PAD
  error:=error+Write(gfh,mailHeader+102,9)  ->msgdate, recv & pad
  error:=error+Write(gfh,mailHeader+110,1)   ->PAD

 IF(error<>size)
     myError(ERR_MSGBASE)
     RETURN RESULT_FAILURE
 ENDIF
 Seek(gfh,currentSeekPos,OFFSET_BEGINNING)
 
ENDPROC RESULT_SUCCESS

PROC saveStatOnly()
  DEF error
  DEF string[255]:STRING
  DEF fd

 StringF(string,'\s\s',msgBaseLocation,'MailStats')
 fd:=Open(string,MODE_READWRITE)
 IF(fd<=0)
     myError(ERR_MSGBASE)
     RETURN RESULT_FAILURE
 ENDIF

 error:=Write(fd,mailStat,SIZEOF mailStat)
 IF(error<>SIZEOF mailStat)
     aePuts('Wasn''t the same!\b\n')
     Close(fd)
     myError(ERR_MSGBASE)
     RETURN RESULT_FAILURE
 ENDIF
 Close(fd)
 RETURN RESULT_SUCCESS
ENDPROC

PROC deleteMSG(gfh)
  DEF string[255]:STRING
  DEF msgbaselock
  DEF stat

  IF(loggedOnUser.secStatus<210)
      IF(stringCompare(mailHeader.fromName,loggedOnUser.name)=RESULT_SUCCESS) THEN JUMP goAheadDel
      IF(stringCompare(mailHeader.toName,loggedOnUser.name)=RESULT_SUCCESS) THEN JUMP goAheadDel
      aePuts('\b\nMessage not deleted, not your mail.\b\n\b\n')
      RETURN RESULT_FAILURE
  ENDIF

goAheadDel:
 IF(msgbaselock:=lockMsgBase())
    getMailStatFile()
    delMsgNum:=msgNum-fwdFlag
    IF(mailStat.lowestNotDel=delMsgNum) THEN mailStat.lowestNotDel:=mailStat.lowestNotDel+1
    stat:=saveStatOnly()
    mailHeader.status:="D"
    checkAttachedFile(delMsgNum,0)
    StringF(string,'\s\d',msgBaseLocation,delMsgNum)
    SetProtection(string,FIBF_OTR_DELETE)
    stat:=DeleteFile(string)
    stat:=saveOverHeader(gfh)
    StringF(string,'\b\nMessage \d deleted...\b\n',delMsgNum)
    aePuts(string)
    UnLock(msgbaselock)
 ELSE
   aePuts('Can''t Lock MsgBase, Message not Deleted!\b\n')
 ENDIF
ENDPROC RESULT_SUCCESS

PROC lockMsgBase()
  DEF lock, loop, error
 DEF tempstr[255]:STRING

 loop:=0
 StringF(tempstr,'\sMailLock',msgBaseLocation)
 REPEAT
   lock:=Lock(tempstr,ACCESS_WRITE)
     IF(lock=0)
         error:=IoErr()
         IF(error=205) THEN createFile(tempstr)
         Delay(120)
         aePuts('.')
     ENDIF
 UNTIL((lock<>0) OR (loop++>=30))

 IF(lock=0)
     StringF(tempstr,'\tError \d trying to Lock MSGBASE',IoErr())
     callersLog(tempstr)
 ENDIF
ENDPROC lock

PROC createFile(filename)
  DEF fh
  fh:=Open(filename,MODE_NEWFILE)
  Close(fh)
ENDPROC

PROC readMSG(gfh)
  DEF uNum,helplist=0
  DEF str[255]:STRING
  DEF string[255]:STRING
  DEF i,stat
  DEF lowerChar
 
  DEF firstparam

  nonStopMail:=replyFlag:=tempFlag:=numOfZMsgs:=0
  fwdFlag:=1
  fwdDir:="+"
  msgNum:=lastMsgReadConf+1
  IF(msgNum<mailStat.lowestKey) THEN msgNum:=mailStat.lowestKey
 
  aePuts('\b\n')

  nonStopMail:=paramsContains('NS')

  IF paramsContains('S')
     IF(msgNum>(mailStat.highMsgNum-1))
         aePuts('No new messages.\b\n')
         aePuts('\b\n')
         RETURN RESULT_FAILURE
     ENDIF
     JUMP goNextMsg
  ENDIF

  IF ListLen(parsedParams)>0
  firstparam:=ListItem(parsedParams,0)
  IF (StrCmp(firstparam,'-')) OR (StrCmp(firstparam,'+')) OR (isDigit(firstparam))
    StrCopy(str,firstparam,ALL) 
    JUMP passItIN
  ENDIF
  ENDIF

 WHILE TRUE
  cont:
     IF(fwdFlag=1) THEN StringF(str,'\d\c\d',msgNum,fwdDir,mailStat.highMsgNum-1) ELSE StringF(str,'\d\c\d',msgNum,fwdDir,mailStat.lowestKey)

     IF((msgNum>(mailStat.highMsgNum-1)) OR (msgNum<mailStat.lowestKey)) THEN StrCopy(str,'QUIT',ALL)

      IF(helplist=0)
       IF(nonStopMail=FALSE)
         aePuts('\b\n[32mMsg. Options: [33mA[36m')
         IF checkSecurity(ACS_DELETE_MESSAGE) THEN aePuts(',[33mD')
         aePuts('[36m,[33mR[36m,[33mQ')
         StringF(string,'[36m,[33m?[36m,[32m<[33mCR[32m> [32m([0m \s[32m )[0m>: ',str)
         aePuts(string)
       ENDIF
      ELSE
         aePuts('\b\n[33mA[32m>[36mgain[0m')
         IF checkSecurity(ACS_DELETE_MESSAGE) THEN aePuts('\b\n[33mD[32m>[36melete Message[0m')
         aePuts('\b\n[33mR[32m>[36meply[0m')
         aePuts('\b\n[33mQ[32m>[36muit[0m')
         StringF(string,'\b\n[32m<[33mCR[32m>[0m=[33mNext [32m([0m \s[32m )[0m? ',str)
         aePuts(string)
         helplist:=0
      ENDIF
   
     IF(nonStopMail=FALSE)
         noDirF:=1
         stat:=lineInput('','',10,INPUT_TIMEOUT,str)
         IF(stat<>RESULT_SUCCESS) THEN RETURN RESULT_FAILURE
     ENDIF
    
     IF(str[0]="?")
       helplist:=1
       JUMP cont
     ENDIF

     IF(((str[0]="N") OR (str[0]="n")) AND ((str[1]="S") OR (str[1]="s"))) THEN nonStopMail:=TRUE

     IF((EstrLen(str)=0) OR (nonStopMail))
         noDirF:=1
         JUMP goNextMsg
     ENDIF

     IF(tempFlag)
         IF((privateFlag=0) OR (stringCompare(mailHeader.toName,loggedOnUser.name)=RESULT_SUCCESS) OR
            (stringCompare(mailHeader.fromName,loggedOnUser.name)=RESULT_SUCCESS))
          ->IF((!netflag) OR (StrCmp(Sopt->BBSConfig,MailHeader.ToNet)=TRUE) OR (!strcmp(Sopt->BBSConfig,MailHeader.FromNet)) OR (checkSecurity(ACS_SYSOP_READ)) OR (privateFlag=0))

             lowerChar:=charToLower(str[0])
             SELECT lowerChar
                 CASE "a"
                     stat:=displayMessage(gfh)
                     IF(stat<0) THEN RETURN stat
                     JUMP nextMenu
                 CASE "d"
                     IF checkSecurity(ACS_DELETE_MESSAGE) 
                      stat:=deleteMSG(gfh)
                      noDirF:=1
                      JUMP goNextMsg
                     ENDIF
                 CASE "r"
                     stat:=replyToMSG(gfh)
                     IF(stat<0) THEN RETURN stat
                     noDirF:=1 
                     JUMP goNextMsg
             ENDSELECT      
          -> ENDIF
         ENDIF
         IF(((str[0]="E") OR (str[0]="e")) AND (checkSecurity(ACS_MESSAGE_EDIT))) 
               /* 11w add */
               IF((str[1]="H") OR (str[1]="h"))
               
                 IF((stat=editHeader(gfh))<0) THEN RETURN stat
               ELSE
               /* 11w end */
                 editEMessage(mailHeader.msgNumb)
               ENDIF
             stat:=displayMessage(gfh)
             IF(stat<0) THEN RETURN stat
             JUMP nextMenu
         ENDIF

         IF(((str[0]="U") OR (str[0]="u")) AND ((checkSecurity(ACS_ACCOUNT_EDITING))))
             StrCopy(str,mailHeader.fromName,31)
             uNum:=findUserFromName(1,NAME_TYPE_USERNAME,str,tempUser,tempUserKeys,tempUserMisc)
             stat:=loadAccount(uNum,tempUser,tempUserKeys,tempUserMisc)
             IF(stat=RESULT_FAILURE)
                 aePuts('Warning, error while loading account\b\n')
                 JUMP nextMenu
             ENDIF
             sendCLS()
             callersLog('\tAccount editing from mail.')
             StrCopy(str,'\d',tempUser.slotNumber)
             IF runSysCommand('ACCOUNTS',str)=FALSE THEN editInfo(uNum,tempUser,tempUserKeys,tempUserMisc,FALSE)
             sendCLS()
             stat:=displayMessage(gfh)
             IF(stat<0) THEN RETURN stat
             JUMP nextMenu
         ENDIF
     ENDIF

     IF((str[0]="Q") OR (str[0]="q"))
         aePuts('\b\n')
         RETURN RESULT_SUCCESS
     ENDIF

     passItIN:
     IF(nonStopMail=FALSE)
       noDirF:=0
     ELSE
       noDirF:=1
       fwdFlag:=1
       fwdDir:="+"
     ENDIF
     IF(str[StrLen(str)-1]="+")
         IF(fwdFlag=(-1)) THEN msgNum:=msgNum+2
         noDirF:=1

         fwdToMsg:=mailStat.highMsgNum
         fwdFlag:=1
         fwdDir:="+"
         stat:=firstChar(str)
         IF((stat>=0) AND (str[stat]="+")) THEN JUMP goNextMsg
         str[StrLen(str)-1]:=" "
     ENDIF
     IF(str[StrLen(str)-1]="-")
         IF(fwdFlag=1)
             msgNum:=msgNum-1
             msgNum:=msgNum-tempFlag
         ENDIF
         noDirF:=1
         fwdToMsg:=mailStat.lowestKey
         fwdFlag:=-1
         fwdDir:="-"
         stat:=firstChar(str)
         IF((stat>=0) AND (str[stat]="-")) THEN JUMP goNextMsg
         str[StrLen(str)-1]:=" "
     ENDIF
     StrAdd(str,' ')

     stat:=firstChar(str)
     IF(stat>=0)
         IF(isDigit(str+stat)) 
             msgNum:=Val(str)

            goNextMsg:
            IF(doormsgcode=2)
              doormsgcode:=0
              RETURN RESULT_SUCCESS
            ENDIF

            IF(doormsgcode=1) THEN doormsgcode:=2 
            
            IF((stat >=0) OR (str[stat]="+") OR (str[stat] = "-"))
              checkScreenClear()
            ENDIF

             stat:=readit(gfh)
             IF(stat<RESULT_FAILURE)
                RETURN RESULT_NO_CARRIER
             ENDIF
             IF(stat=10)
                 RETURN 10
             ENDIF
             IF(stat=RESULT_FAILURE) 
                 aePuts('\b\n')
                 IF(numOfZMsgs<>0) THEN RETURN RESULT_SUCCESS ELSE RETURN RESULT_FAILURE
             ENDIF
         ENDIF
     ENDIF
     nextMenu:
     aePuts('\b\n')
 ENDWHILE
ENDPROC RESULT_SUCCESS

PROC noMorePlus()
  DEF str[100]: STRING

  IF(nonStopMail=FALSE) 
     IF(noDirF=0) 
         StringF(str,'\b\nThe last message in this conference is \d\b\n',mailStat.highMsgNum-1)
         aePuts(str)
     ENDIF
  ENDIF
 nonStopMail:=FALSE
ENDPROC

PROC noMoreMinus()
  DEF str[100]: STRING

 IF(nonStopMail=FALSE) 
     IF(noDirF=0)
         StringF(str,'\b\nThe first message in this conference is \d\b\n',mailStat.lowestNotDel)
         aePuts(str)
     ENDIF
 ENDIF
 nonStopMail:=FALSE
ENDPROC

PROC readit(gfh)
  DEF stat
  tempFlag:=1
  
 REPEAT
     IF(msgNum>(mailStat.highMsgNum-1))
         noMorePlus()
         RETURN RESULT_FAILURE
     ENDIF
     IF(msgNum<mailStat.lowestKey)
         noMoreMinus()
         RETURN RESULT_FAILURE
     ENDIF

     stat:=loadMessageHeader(gfh)
     IF(stat=RESULT_FAILURE)
         aePuts('\b\nMSG Base Error!!!\b\n')
         RETURN RESULT_FAILURE
     ENDIF

     privateFlag:=0
     IF((mailHeader.status="R") AND (Not(checkSecurity(ACS_SYSOP_READ)))) 
         IF((stringCompare(mailHeader.toName,loggedOnUser.name)<>RESULT_SUCCESS) AND
            (stringCompare(mailHeader.fromName,loggedOnUser.name)<>RESULT_SUCCESS))
             privateFlag:=1
             IF(noDirF<>0) THEN JUMP nextMSG
             aePuts('\b\nThat message is Private.\b\n\b\n')
             nonStopMail:=FALSE
             RETURN RESULT_SUCCESS
         ENDIF
     ENDIF

     IF(mailHeader.status="D")
         privateFlag:=1
         IF(noDirF<>0) THEN JUMP nextMSG
         aePuts('\b\nThat message has been deleted.\b\n\b\n')
         nonStopMail:=FALSE
         msgNum:=msgNum+fwdFlag
         RETURN RESULT_SUCCESS
     ENDIF

     numOfZMsgs++
     stat:=displayMessage(gfh)
     IF(stat<0) THEN RETURN stat

     IF(msgNum>lastMsgReadConf) THEN lastMsgReadConf:=msgNum

     msgNum:=msgNum+fwdFlag
     RETURN RESULT_SUCCESS

     nextMSG:
     IF(msgNum>lastMsgReadConf) THEN lastMsgReadConf:=msgNum
     msgNum:=msgNum+fwdFlag
 UNTIL((msgNum>mailStat.highMsgNum) OR (msgNum<mailStat.lowestKey))

 IF(msgNum>=mailStat.highMsgNum)  THEN noMorePlus() ELSE noMoreMinus()
ENDPROC RESULT_FAILURE

PROC loadMessageHeader(gfh)
  DEF headPoint,size,filePos,error,temp
  DEF f: PTR TO CHAR
 
 headPoint:=msgNum-mailStat.lowestKey
 size:=110 ->SIZEOF mailHeader
 filePos:=Mul(size,headPoint)
 temp:=filePos-currentSeekPos
 IF(temp)
     error:=Seek(gfh,temp,OFFSET_CURRENT)
     IF(error<0)
         myError(ERR_MSGBASE)
         RETURN RESULT_FAILURE
     ENDIF
 ENDIF
 
  error:=Read(gfh,mailHeader,1)
  Seek(gfh,1,OFFSET_CURRENT)
  error:=error+Read(gfh,mailHeader+2,4)
  error:=error+Read(gfh,mailHeader+6,31)
  error:=error+Read(gfh,mailHeader+38,31)
  error:=error+Read(gfh,mailHeader+70,31)
  Seek(gfh,1,OFFSET_CURRENT)
  error:=error+Read(gfh,mailHeader+102,9)
  Seek(gfh,1,OFFSET_CURRENT)
  
  IF(error<>107)
     myError(ERR_MSGBASE)
     RETURN RESULT_FAILURE
 ENDIF

 currentSeekPos:=Seek(gfh,0,OFFSET_CURRENT)
 
ENDPROC RESULT_SUCCESS

PROC saveMessageHeader(gfh)
DEF stat, error
 Seek(gfh,0,OFFSET_END)

  mailHeader.pad:=0
  error:=Write(gfh,mailHeader,1)    -> STATUS
  error:=error+Write(gfh,mailHeader+110,1)   ->PAD
  error:=error+Write(gfh,mailHeader+2,4)   ->MsgNum
  error:=error+Write(gfh,mailHeader+6,31)   ->toName
  error:=error+Write(gfh,mailHeader+38,31)   ->fromName
  error:=error+Write(gfh,mailHeader+70,31)   ->subject
  error:=error+Write(gfh,mailHeader+110,1)   ->PAD
  error:=error+Write(gfh,mailHeader+102,9)  ->msgdate, recv & pad
  error:=error+Write(gfh,mailHeader+110,1)   ->PAD

 IF(error<>110) THEN RETURN RESULT_FAILURE

 Seek(gfh,currentSeekPos,OFFSET_BEGINNING)

 mailStat.highMsgNum:=mailStat.highMsgNum+1
 IF(mailStat.highMsgNum=2) THEN mailStat.lowestNotDel:=1

 stat:=saveStatOnly()
 IF(stat=RESULT_FAILURE) THEN RETURN stat
 
ENDPROC RESULT_SUCCESS


PROC callMsgFuncs(msgfunc, pass)
  DEF stat, gfh
  DEF filename[255]:STRING

  fileattach:=TRUE
  StringF(filename,'\s\s',msgBaseLocation,'HeaderFile')

  gfh:=Open(filename,MODE_READWRITE)
  IF(gfh<=0)
     gfh:=Open(filename,MODE_NEWFILE)
     IF(gfh<=0)
         myError(ERR_MSGBASE)
         fileattach:=FALSE
         RETURN RESULT_FAILURE
     ENDIF
  ENDIF
  currentSeekPos:=0
  stat:=RESULT_FAILURE
  ->if(NetConf[0]<>0) netflag=1 else netflag=0
 -> MCIViewSafe=FALSE
  SELECT msgfunc
    CASE MAIL_READ
         stat:=readMSG(gfh)
    CASE MAIL_CREATE
         stat:=enterMSG(gfh)
    CASE MAIL_SCAN
         newmailsearch:= TRUE
         stat:=searchNewMail(gfh,pass)
         newmailsearch:=FALSE
  ENDSELECT
 
  Close(gfh)
  fileattach:=FALSE
  ->MCIViewSafe=TRUE
ENDPROC stat

PROC showFlags()
  IF(StrLen(flaglist)=0)
    aePuts('No file flags\b\n')
  ELSE
      aePuts(flaglist)
      aePuts('\b\n')
  ENDIF
ENDPROC

PROC isInList(testflaglist,s)
  DEF tempStr[20]:STRING
  DEF v,i
  DEF flagfilelist: PTR TO LONG
  DEF result

  IF StrLen(testflaglist)=0 THEN RETURN FALSE

  flagfilelist:=List(StrLen(testflaglist))

  parseList(testflaglist,flagfilelist)

  result:=FALSE

  FOR i:=0 TO ListLen(flagfilelist)-1
    IF stcsma(s,ListItem(flagfilelist,i)) THEN result:=TRUE
  ENDFOR

  FOR i:=0 TO ListLen(flagfilelist)-1
    DisposeLink(ListItem(flagfilelist,i))
  ENDFOR
  END flagfilelist

ENDPROC result

PROC addFlagtoList(s:PTR TO CHAR)
  DEF p: PTR TO CHAR
  DEF stat
  IF(StrLen(s)>1)
     UpperStr(s)
     IF(StrLen(flaglist)+StrLen(s)>2040)
         aePuts('Too many flags\b\n')
         RETURN 1
     ENDIF
     stat:=isInList(flaglist,s)
     IF(stat=FALSE)
        IF StrLen(flaglist)>0 THEN StrAdd(flaglist,' ')
        StrAdd(flaglist,s)
     ENDIF 
     RETURN 2
  ENDIF
ENDPROC 0

PROC removeFileList(s: PTR TO CHAR)
  DEF templist:PTR TO LONG
  DEF i
  
  templist:=List(2048)
  parseList(flaglist,templist)
  
  StrCopy(flaglist,'')
  FOR i:=0 TO ListLen(templist)-1
    IF strCmpi(templist[i],s,ALL)=FALSE
      IF StrLen(flaglist)>0 THEN StrAdd(flaglist,' ')
      StrAdd(flaglist,templist[i])
    ENDIF
    DisposeLink(templist[i])
  ENDFOR
  DisposeLink(templist)
ENDPROC

PROC flagFrom(s: PTR TO CHAR)
  DEF stat, flag,fp,i
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  flag:=1
  StringF(tempStr,'\sdir\d',currentConfDir,maxDirs)
  IF(fp:=Open(tempStr,MODE_OLDFILE))>0
      WHILE(((ReadStr(fp,tempStr)<>-1) OR (StrLen(tempStr)>0)) AND (stat<>1))
        IF(StrLen(tempStr)>0) AND (tempStr[0]<>" ")
            i:=0
            WHILE((i<StrLen(tempStr)) AND (tempStr[i]<>" "))
              tempStr2[i]:=tempStr[i]
              i++
            ENDWHILE
            IF(i=0) THEN JUMP flagcont
            SetStr(tempStr2,i)
            IF(flag=FALSE) THEN stat:=addFlagtoList(tempStr2)
            IF(flag AND strCmpi(tempStr2,s,ALL))
              flag:=0
              stat:=addFlagtoList(tempStr2)
            ENDIF
        ENDIF
        flagcont:
      ENDWHILE
      IF(flag) THEN aePuts('Sorry filename not found!\b\n')
      Close(fp)
  ELSE
    RETURN RESULT_FAILURE
  ENDIF
ENDPROC RESULT_SUCCESS

PROC flagFiles(s: PTR TO CHAR)
  DEF stat
  DEF tempStr[190]:STRING

  IF(s=NIL) THEN showFlags()
backloop:
  IF(s=NIL)
    aePuts('[36mFilename(s) to flag: [32m([33mF[32m)[36mrom, [32m([33mC[32m)[36mlear, [32m([33mEnter[32m)[36m=none[0m? ')
    stat:=lineInput('','',190,INPUT_TIMEOUT,tempStr)
    IF(stat<0) THEN RETURN stat
  ELSE
    StrCopy(tempStr,s)
  ENDIF

  IF(StrLen(tempStr)>0)
    IF(((tempStr[0]="C") OR (tempStr[0]="c")) AND ((StrLen(tempStr)=1) OR (tempStr[1]=" ")))
      IF(tempStr[1]=" ")
        StrCopy(tempStr,tempStr+2)
      ELSE
        IF(s<>NIL) THEN showFlags()
        aePuts('[36mFilename(s) to Clear: [32m([33m*[32m)[36mAll, [32m([33mEnter[32m)[36m=none[0m? ')
        stat:=lineInput('','',190,INPUT_TIMEOUT,tempStr)
        IF(stat<0) THEN RETURN stat

        IF(StrLen(tempStr)=0) THEN RETURN RESULT_SUCCESS
        aePuts('\b\n')
      ENDIF
      UpperStr(tempStr)
      IF(tempStr[0]="*") THEN StrCopy(flaglist,'') ELSE removeFileList(tempStr)
      RETURN 1
    ELSE
      IF(((tempStr[0]="F") OR (tempStr[0]="f")) AND ((StrLen(tempStr)=1) OR (tempStr[1]=" ")))
        IF(tempStr[1]<>" ")
          aePuts('[36mFilename to start flagging from: [0m')
              stat:=lineInput('','',190,INPUT_TIMEOUT,tempStr)
              IF (stat<0) THEN RETURN stat
          IF(StrLen(tempStr)=0) THEN RETURN RESULT_SUCCESS
        ELSE 
          StrCopy(tempStr,tempStr+2)
        ENDIF

        flagFrom(tempStr)
        RETURN 1
      ELSE
        stat:=addFlagtoList(tempStr)
        IF(stat=1)
          IF (s=NIL ) THEN JUMP backloop ELSE RETURN RESULT_FAILURE
        ENDIF
        IF(stat=2) THEN RETURN RESULT_FAILURE
      ENDIF
    ENDIF
  ENDIF
ENDPROC RESULT_SUCCESS

PROC alterFlags(params)
  DEF stat

  aePuts('\b\n')
  IF(StrLen(params)>0)
     stat:=flagFiles(params)
     IF(stat<0) THEN RETURN
     WHILE(stat)
       stat:=flagFiles(NIL)
     ENDWHILE
  ELSE
     REPEAT
         stat:=flagFiles(NIL)
         IF(stat<0) THEN RETURN
     UNTIL stat=0
  ENDIF
  aePuts('\b\n')
ENDPROC

PROC checkFlagged()
  DEF stat
  IF(StrLen(flaglist))
     aePuts('\b\nYou have flagged files still not downloaded.\b\nDo you leave without them? ')
     stat:=yesNo(2)
     RETURN stat
  ENDIF
ENDPROC 1

PROC exceedRatio()
  aePuts('You have exceeded your ratio, you must upload first.\b\n\b\n')
ENDPROC

PROC displayULStats(u: PTR TO user)
  DEF string[200]:STRING

  StringF(string,'Number of Downloads   : \d (\dk total)\b\n',u.downloads AND $FFFF,Div(u.bytesDownload,1000))
  aePuts(string)
  StringF(string,'Number of Uploads     : \d (\dk total)\b\n',u.uploads AND $FFFF,Div(u.bytesUpload,1000))
  aePuts(string)
  StringF(string,'Todays Bytes Available: \d\b\n',bytesADL)
  aePuts(string)
ENDPROC

PROC bStrC(bstr: PTR TO CHAR,buf: PTR TO CHAR)
 DEF str: PTR TO CHAR
 DEF loop,counter

  counter:=0
  str:=Shl(bstr,2)
  SetStr(buf,str[0])
  FOR loop:=1 TO str[0]
    buf[counter]:=str[loop]
    counter++
  ENDFOR
ENDPROC


PROC findAssign(name: PTR TO CHAR)
  DEF db: doslibrary
  DEF rootnode: PTR TO rootnode
  DEF dosinfo: PTR TO dosinfo
  DEF devicelist: PTR TO devlist
  DEF temp[256]:STRING
  DEF temp2[256]:STRING
  DEF i=0
 
  StrCopy(temp,name)
  WHILE temp[i]
   IF(temp[i]=":")
     SetStr(temp,i)
     i:=-1
     JUMP bk
   ENDIF
   i++
  ENDWHILE
 bk:
 
  IF i<>-1 THEN RETURN 20

 db:=dosbase
 rootnode:=db.root
 dosinfo:=Shl(rootnode.info,2)
 devicelist:=Shl(dosinfo.devinfo,2)
 Forbid()
 WHILE(devicelist.next)
   bStrC(devicelist.name,temp2)
   IF(strCmpi(temp2,temp,ALL)/* && devicelist->dl_Type!=DLT_DEVICE*/)
     Permit()
     RETURN 0
   ENDIF 
   devicelist:=Shl(devicelist.next,2)
 ENDWHILE
 Permit()
ENDPROC 20

PROC checkForFileSize(fn: PTR TO CHAR, cfn:PTR TO CHAR, z)

  DEF stat,pstat=1
  DEF fflag=0,wflag=0,doflag=0
  DEF tsec,min,secs
  DEF path[255]:STRING,str[255]:STRING,final[255]:STRING,tempstr[100]:STRING,tempstr2[100]:STRING, p,dp
  DEF clog[200]:STRING
  DEF ft
  
  DEF fBlock: PTR TO fileinfoblock
  DEF fLock
  DEF drivenum
  
  FOR min:=0 TO StrLen(fn)-1
    IF((fn[min]="?") OR (fn[min]="*")) THEN wflag:=1
  ENDFOR
  StrCopy(tempstr2,fn)
  UpperStr(tempstr2)

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)) = NIL) 
    myError(1)  ->// MemError()
    RETURN RESULT_FAILURE
  ENDIF
  IF(z=1) THEN JUMP jumpIn

  IF(sysopdl)
    z:=1
    wflag:=0
    JUMP jumpIn
  ENDIF

  drivenum:=1
  StringF(tempstr,'DLPATH.\d',drivenum++)
  REPEAT
  c1:
    IF(z=0)
      IF readToolType(TOOLTYPE_CONF,currentConf,tempstr,path)
        pstat:=1 /* shouldnt this be 251 ?*/
      ELSE
        pstat:=0
      ENDIF
    ENDIF
    StrCopy(final,path)
    IF(StrLen(path)=0) THEN JUMP c1
    IF (pstat=0) THEN JUMP outst

 jumpIn:
    IF(wflag=0) 
      IF(sysopdl=0)
         StrCopy(final,path)
         StrAdd(final,fn)
       ELSE
         StrCopy(final,fn)
         IF(findAssign(final)) THEN JUMP outst
       ENDIF
       ft:=Open(final,MODE_OLDFILE)
       IF(ft>0)
         Close(ft)
         doflag:=1
       ELSE
         IF(sysopdl) THEN JUMP outst
       ENDIF
    ELSE
      doflag:=1
    ENDIF

    IF(doflag)
       IF((fLock:=Lock(final,ACCESS_READ))=0)
         FreeDosObject(DOS_FIB,fBlock)
         StringF(str,'Error, Path \s missing, adjust paths file..',path)
         aePuts(str)
         aePuts('\b\n\b\n')
         callersLog(str)
         RETURN RESULT_FAILURE
       ENDIF

       IF((Examine(fLock,fBlock))=NIL)
           FreeDosObject(DOS_FIB,fBlock)
           myError(1)
           UnLock(fLock)
           RETURN RESULT_FAILURE
       ENDIF
       
       IF(wflag=0) THEN JUMP gotit

       WHILE (ExNext(fLock,fBlock))     /* my change.. prior to this we had a blank file name */
          IF(fBlock.direntrytype<0)
 gotit:
            StrCopy(tempstr,fBlock.filename)
            UpperStr(tempstr)
            stat:=stcsma(tempstr,tempstr2)
            IF((stat<>0) OR sysopdl) 
              fflag:=1
              IF(sysopdl) 
                StrCopy(final,fn)
              ELSE
                StrCopy(final,path)
                StrAdd(final,fBlock.filename)
              ENDIF
              fsize:=fBlock.size
              tsec:=Div(Div(fsize,onlineBaud),10)
              min:=tsec/60
              secs:=tsec-(min*60)
              StringF(str,' \r\d[4]k,\r\d[3] mins \z\r\d[2] secs \s\t',Div(fsize,1024),min,secs,fBlock.filename)
              IF(str[16]=" ") THEN SetStr(str,16)
              aePuts(str)
              IF((fBlock.comment[0]="F") OR (freeDownloads))
                aePuts('  >>Free Download!\b\n')
                tfsize:=tfsize-fsize
              ELSE
                freeDFlag++
                aePuts('\b\n')
              ENDIF
              IF((z<>1) OR sysopdl)
                 /***** SYSTEM SECURITY ADDED BY JOSEPH HODGE *****/
                  IF(strCmpi(fBlock.comment,'Restricted',10))
                   aePuts('    >>Restricted File<< Updating CallersLog\b\n')
                   StringF(clog,'\t\tAttempt to download RESTRICTED file [\s]',fn)
                   callersLog(clog)
                   FreeDosObject(DOS_FIB,fBlock)
                   UnLock(fLock)
                   RETURN 11
                 ENDIF

                 IF(StrLen(final)+StrLen(cfn)>2000)
                   aePuts(' Too many entries!!  The remainder was left off.\b\n')
                   numFiles--
                   FreeDosObject(DOS_FIB,fBlock)
                   UnLock(fLock)
                   RETURN 11
                 ENDIF
                 IF((dp:=isInList(cfn,final)))=FALSE
                   numFiles++
                   IF StrLen(cfn)>0 THEN StrAdd(cfn,' ')
                   StrAdd(cfn,final)
                   IF((p:=isInList(flaglist,fBlock.filename)))=FALSE
                     addFlagtoList(fBlock.filename)
                   ENDIF
                 ELSE
                   aePuts('   File is already selected!\b\n')
                 ENDIF
              ENDIF

              IF(dp=NIL) 
                  tfsize:=tfsize+fsize
                  dtfsize:=dtfsize+fsize
              ENDIF
              IF(wflag=0)
                FreeDosObject(DOS_FIB,fBlock)
                UnLock(fLock)
                IF(dp<>NIL) THEN RETURN RESULT_FAILURE ELSE RETURN RESULT_SUCCESS
              ENDIF
            ENDIF
          ENDIF

          IF(sCheckInput())
            stat:=readChar(1)
            IF(stat<0)
              FreeDosObject(DOS_FIB,fBlock)
              UnLock(fLock)
              RETURN RESULT_NO_CARRIER
            ENDIF
            SELECT stat
              CASE 23 /* Pause */
                stat:=readChar(INPUT_TIMEOUT)
                IF(stat<0)
                  FreeDosObject(DOS_FIB,fBlock)
                  UnLock(fLock)
                  RETURN RESULT_NO_CARRIER
                ENDIF
              CASE 3 /* ^C */
                aePuts('**Break\b\n')
                FreeDosObject(DOS_FIB,fBlock)
                UnLock(fLock)
                RETURN 10
            ENDSELECT
          ENDIF
       ENDWHILE
       
       UnLock(fLock)
       IF(z=1) THEN JUMP outst
    ENDIF
    StringF(tempstr,'DLPATH.\d',drivenum++)

  UNTIL pstat=0

 outst:

  FreeDosObject(DOS_FIB,fBlock)

  IF(fflag=0)
    StringF(str,'       File (\s) not found.\b\n',fn)
    aePuts(str)
    RETURN RESULT_FAILURE
  ENDIF
  
  IF(dp<>NIL) THEN RETURN RESULT_FAILURE

ENDPROC RESULT_SUCCESS

PROC statCursorTo(x,y)
  DEF statbuf[20]:STRING
  IF (dStatBar AND(statWriteIO<>NIL))
    StringF(statbuf,'[\d;\dH',y,x)    
    statWriteIO.data:=statbuf
    statWriteIO.length:=-1
    statWriteIO.command:=CMD_WRITE
    DoIO(statWriteIO)
  ENDIF
ENDPROC


PROC statPrint(s: PTR TO CHAR)
  DEF str[25]:STRING

  IF(dStatBar AND (statWriteIO<>NIL))
     IF(bitPlanes<3)
        stripAnsi(s,str,0,0)
        statWriteIO.data:=str
        statWriteIO.length:=-1
        statWriteIO.command:=CMD_WRITE
        DoIO(statWriteIO)
        RETURN
    ENDIF
    statWriteIO.data:=s
    statWriteIO.length:=-1
    statWriteIO.command:=CMD_WRITE
    DoIO(statWriteIO)
  ENDIF
ENDPROC


PROC statParkCursor()
  statCursorTo(1,3)
  statPrint('[0 p')
ENDPROC

PROC statClearTime()
  statMessage(1,3,'                               ')
ENDPROC

PROC statMessage(x,y,s: PTR TO CHAR)
  statCursorTo(x,y)
  statPrint(s)
  statParkCursor()
ENDPROC

PROC decodeCmds(cmdsPtr: PTR TO CHAR)
  DEF iptr: PTR TO INT
  DEF lptr: PTR TO LONG
  DEF i
 
  CopyMem(cmdsPtr,cmds.acLvl,100)     ->copy cmdsptr to cmds.aclvl
  cmdsPtr:=cmdsPtr+100
  cmds.serDevUnit:=cmdsPtr[0]
  cmdsPtr++
  strCpy(cmds.serDev,cmdsPtr,40)
  cmdsPtr:=cmdsPtr+40
  strCpy(cmds.newUserPw,cmdsPtr,15)
  cmdsPtr:=cmdsPtr+15
  lptr:=cmdsPtr
  cmds.openingBaud:=lptr[0]
  cmdsPtr:=cmdsPtr+4
  cmds.taskPri:=cmdsPtr[0]
  cmdsPtr++
  strCpy(cmds.conf1Name,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf2Name,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf3Name,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf4Name,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf5Name,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf6Name,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf7Name,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf8Name,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf9Name,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf10Name,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf1Loc,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf2Loc,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf3Loc,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf4Loc,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf5Loc,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf6Loc,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf7Loc,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf8Loc,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf9Loc,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.conf10Loc,cmdsPtr,54)
  cmdsPtr:=cmdsPtr+54
  strCpy(cmds.bbsName,cmdsPtr,41)
  cmdsPtr:=cmdsPtr+41
  strCpy(cmds.bbsLoc,cmdsPtr,41)
  cmdsPtr:=cmdsPtr+41
  strCpy(cmds.sysopName,cmdsPtr,41)
  cmdsPtr:=cmdsPtr+41
  strCpy(cmds.pSAcLvl,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pSRType,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pSRatio,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  IF (cmdsPtr AND 1)<>0 THEN cmdsPtr++
  lptr:=cmdsPtr
  FOR i:=0 TO 5 
    cmds.pSDBytes[i]:=lptr[0]
    lptr++
  ENDFOR
  FOR i:=0 TO 5 
    cmds.pSTime[i]:=lptr[0]
    lptr++
  ENDFOR
  cmdsPtr:=lptr
  strCpy(cmds.pSCnfAc1,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pSCnfAc2,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pSCnfAc3,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pSCnfAc4,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pSCnfAc5,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pSCnfAc6,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pSCnfAc7,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pSCnfAc8,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pSCnfAc9,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.pPSCnfAc10,cmdsPtr,6)
  cmdsPtr:=cmdsPtr+6
  strCpy(cmds.mInit,cmdsPtr,101)
  cmdsPtr:=cmdsPtr+101
  strCpy(cmds.mReset,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  strCpy(cmds.mRing,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  strCpy(cmds.mAnswer,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  strCpy(cmds.mC300,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  strCpy(cmds.mC1200,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  strCpy(cmds.mC2400,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  strCpy(cmds.mC4800,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  strCpy(cmds.mC9600,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  strCpy(cmds.mC19200,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  IF (cmdsPtr AND 1)<>0 THEN cmdsPtr++
  iptr:=cmdsPtr
  cmds.numConf:=iptr[0]
  iptr++
  cmdsPtr:=iptr
  strCpy(cmds.sysPass,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  strCpy(cmds.remotePass,cmdsPtr,31)
  cmdsPtr:=cmdsPtr+31
  IF (cmdsPtr AND 1)<>0 THEN cmdsPtr++
  iptr:=cmdsPtr
  FOR i:=0 TO 9
    cmds.baudTimes[i]:=iptr[0]
    iptr++
  ENDFOR
  cmdsPtr:=iptr
  cmdsPtr:=cmdsPtr+22
ENDPROC

PROC createServerRP()
  
  DEF mstrServe[10]:STRING
  DEF multiRP[10]:STRING
  
  StringF(mstrServe,'ServerRP\d',node)
  StringF(multiRP,'MultiRP\d',node)

  IF(FindPort(mstrServe)) THEN RETURN RESULT_FAILURE
  serverRP:=createPort(mstrServe,0)
  masterMsg.node:=node
  masterMsg.command:=1
  masterMsg.msg.ln.type:=NT_MESSAGE
  masterMsg.msg.length:=SIZEOF master
  masterMsg.msg.replyport:=serverRP
  regServer()
ENDPROC RESULT_SUCCESS

PROC regServer()
  DEF port:PTR TO mp
  DEF tempstr[255]:STRING

  IF debug
    strCpy(cmds.bbsLoc,'BBS:',41)

    loadAccount(1,tempUser,tempUserKeys,tempUserMisc)

    strCpy(cmds.bbsName,'somebbs',41)

    strCpy(cmds.sysopName,tempUser.name,31)

    StringF(mybbsLoc,'\s','someplace')

    sopt.leftEdge:=0
    sopt.topEdge:=0
    sopt.width:=640
    sopt.height:=256
    sopt.bitPlanes:=3

    readToolType(TOOLTYPE_NODE,node,'SCREENS',tempstr)
    strCpy(sopt.nodeScreens,tempstr,ALL)

    sopt.statBar:=0

    sopt.toggles[TOGGLES_RED1]:=FALSE
    sopt.toggles[TOGGLES_MULTICOM]:=FALSE
    sopt.iconify:=FALSE

    cmds.openingBaud:=115200
    cmds.taskPri:=240
    RETURN
  ENDIF

  masterMsg.command:=SV_START
  WHILE(port:=FindPort('AE.Master'))=NIL 
    Delay(25)
  ENDWHILE

  PutMsg(port,masterMsg)
  WaitPort(serverRP)
	GetMsg(serverRP)
  StrCopy(mybbsLoc,masterMsg.user)

  decodeCmds(masterMsg.myCmds)
  ->cmds:=masterMsg.myCmds
  sopt:=masterMsg.sopt
  masterMsg.command:=1
ENDPROC

PROC deleteServerRP()
  deletePort(serverRP)
  serverRP:=NIL
ENDPROC

PROC createResControl()
  StringF(resPortName,'AEServer.\d',node)
  resmp:=createPort(resPortName,0)
ENDPROC

PROC deleteResControl()
 IF(resmp) THEN deletePort(resmp)
 resmp:=0
ENDPROC

PROC createRexxPort()
  DEF sig
  StringF(rexxPortName,'AmiExpress_Node.\d',node)

  Forbid()
  IF FindPort(rexxPortName)=FALSE
    NEW rexxmp
    rexxmp.sigtask:=FindTask(0)
    rexxmp.flags:=PA_SIGNAL
    rexxmp::ln.name:=rexxPortName
    rexxmp::ln.type:=NT_MSGPORT
    IF (sig:=AllocSignal(-1))
      rexxmp.sigbit:=sig
      AddPort(rexxmp)
    ENDIF
  ENDIF
  Permit()
ENDPROC

PROC deleteRexxPort()
  IF rexxmp
    FreeSignal(rexxmp.sigbit)
    RemPort(rexxmp)
    Dispose(rexxmp)
  ENDIF
  rexxmp:=NIL
ENDPROC

PROC rxGetMsg(port)
  DEF mes:PTR TO rexxmsg
  IF mes:=GetMsg(port)
    rexxsysbase:=mes.libbase
    RETURN mes,Long(mes.args)
  ENDIF
ENDPROC NIL,NIL

PROC rxReplyMsg(mes:PTR TO rexxmsg,rc=0,resultstring=NIL)
  mes.result1:=rc
  mes.result2:=NIL
  IF (mes.action AND RXFF_RESULT) AND (rc=0) AND (resultstring<>NIL)
    mes.result2:=CreateArgstring(resultstring,StrLen(resultstring))
  ENDIF
  ReplyMsg(mes)
ENDPROC


PROC setEnvStat(statCode)
  DEF environ[200]:STRING
  DEF status[200]:STRING
  currentStat:=statCode
  IF (sopt.toggles[TOGGLES_MULTICOM]<>0) AND (singleNode<>0) 
    ObtainSemaphore(singleNode)

    IF loggedOnUser<>NIL
      strCpy(singleNode.handle,loggedOnUser.name,ALL)
      strCpy(singleNode.location-1,loggedOnUser.location,ALL)
    ELSE
      strCpy(singleNode.handle,'',ALL)
      strCpy(singleNode.location-1,'',ALL)
    ENDIF

    strCpy(singleNode.misc1,'',ALL)
    strCpy(singleNode.misc2,'',ALL)

    IF(quietFlag) THEN singleNode.status:=0-(statCode+2) ELSE singleNode.status:=statCode
    singleNode.misc2[0]:=IF allowOLM THEN 0 ELSE 1
    ReleaseSemaphore(singleNode)
  ENDIF

   
  StringF(environ,'STATS@\d',node)
  IF loggedOnUser<>NIL
    StringF(status,'\l\s[35]-\d[2]',loggedOnUser.name,statCode)
  ELSE
    StringF(status,'\l\s[35]-\d[2]','',statCode)
  ENDIF
  SetVar(environ,status,-1,LV_VAR OR GVF_GLOBAL_ONLY)
 
  sendMaster()
ENDPROC 1

PROC setEnvMsg(s: PTR TO CHAR)
  DEF temp[10]:STRING
  DEF debugstr[255]:STRING
  DEF port: PTR TO mp

  IF (serverRP=NIL) THEN RETURN
  StringF(debugstr,'setenvmsg: \s',s)
  debugLog(LOG_DEBUG,debugstr)
  strCpy(masterMsg.user,s,ALL)
  StringF(temp,'\d',SV_NEWMSG)

  IF(sopt.toggles[TOGGLES_MULTICOM])
    ObtainSemaphore(singleNode)
    strCpy(singleNode.misc1,s,ALL)
    ReleaseSemaphore(singleNode)
  ENDIF
  strCpy(masterMsg.action,temp,ALL)

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
	  GetMsg(serverRP)
  ENDIF
ENDPROC


PROC sendACPCommand(string:PTR TO CHAR,command,node)
  DEF port: PTR TO mp
  strCpy(masterMsg.user,string,ALL)
  strCpy(masterMsg.location,'',ALL)
  strCpy(masterMsg.action,'',ALL)
  masterMsg.command:=8
  masterMsg.node:=node
  masterMsg.data:=command

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
    GetMsg(serverRP)
  ENDIF
  masterMsg.node:=node
  masterMsg.command:=1
ENDPROC

PROC sendACPCommand2(string:PTR TO CHAR,command)
  DEF port: PTR TO mp
  strCpy(masterMsg.user,string,ALL)
  strCpy(masterMsg.location,'',ALL)
  strCpy(masterMsg.action,'',ALL)
  masterMsg.command:=command
  masterMsg.node:=node
  masterMsg.data:=command

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
    GetMsg(serverRP)
  ENDIF
  masterMsg.node:=node
  masterMsg.command:=1
ENDPROC

PROC sendMaster()
  DEF temp[10]:STRING
  DEF port:PTR TO mp

  IF (serverRP=NIL)  THEN RETURN

  IF loggedOnUser<>NIL
    strCpy(masterMsg.user,loggedOnUser.name,ALL)
    strCpy(masterMsg.location,loggedOnUser.location,ALL)
    StringF(temp,'\d[6]',onlineBaud)
    strCpy(masterMsg.baud,temp,ALL)
  ELSE
    strCpy(masterMsg.user,'',ALL)
    strCpy(masterMsg.location,'',ALL)
    StringF(temp,'\d[6]',cmds.openingBaud)
    strCpy(masterMsg.baud,temp,ALL)
  ENDIF
 
  StringF(temp,'\d',currentStat)
  strCpy(masterMsg.action,temp,ALL)
  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
	  GetMsg(serverRP)
  ENDIF
ENDPROC


PROC sendMasterUpload(filename:PTR TO CHAR)

  DEF temp[10]:STRING
  DEF temp1[43]:STRING
  DEF port:PTR TO mp

  StringF(temp1,'\s[16]',FilePart(filename))
  strCpy(masterMsg.user,temp1,ALL)
  strCpy(masterMsg.location,loggedOnUser.location,ALL)

  StringF(temp,'\d',currentStat)
  strCpy(masterMsg.action,temp,ALL)
  masterMsg.command:=3

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
	  GetMsg(serverRP)
  ENDIF

  IF(sopt.toggles[TOGGLES_MULTICOM])
    ObtainSemaphore(singleNode)
    strCpy(singleNode.misc1,FilePart(filename),ALL)
    strCpy(singleNode.misc2,'1111',ALL)
    ReleaseSemaphore(singleNode);
  ENDIF
  masterMsg.command:=1
ENDPROC

PROC sendMasterDownload(filename: PTR TO CHAR)
  DEF temp[10]:STRING
  DEF temp1[43]:STRING
  DEF port:PTR TO mp

  StringF(temp1,'\s[16]',FilePart(filename))
  strCpy(masterMsg.user,temp1,ALL)
  strCpy(masterMsg.location,loggedOnUser.location,ALL)

  StringF(temp,'\d',currentStat)
  strCpy(masterMsg.action,temp,ALL)
  masterMsg.command:=2

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
	  GetMsg(serverRP)
  ENDIF

  IF(sopt.toggles[TOGGLES_MULTICOM])
    ObtainSemaphore(singleNode)
    strCpy(singleNode.misc1,FilePart(filename),ALL)
    ReleaseSemaphore(singleNode);
  ENDIF
  masterMsg.command:=1
ENDPROC

PROC sendChatFlag(opt)
  DEF port:PTR TO mp

  IF serverRP=NIL THEN RETURN  
  strCpy(masterMsg.user,'',ALL)
  strCpy(masterMsg.location,'',ALL)
  strCpy(masterMsg.action,'',ALL)
  masterMsg.command:=opt+4

  IF((port:=FindPort('AE.Master')))
     PutMsg(port,masterMsg)
     WaitPort(serverRP)
     GetMsg(serverRP)
  ENDIF
  masterMsg.command:=1
ENDPROC

PROC sendQuietFlag(opt)
  DEF port:PTR TO mp
  
  IF serverRP=NIL THEN RETURN

  strCpy(masterMsg.user,'',ALL)
  strCpy(masterMsg.location,'',ALL)
  strCpy(masterMsg.action,'',ALL)
  masterMsg.command:=IF quietFlag THEN 7 ELSE 6

  IF((port:=FindPort('AE.Master')))
     PutMsg(port,masterMsg)
     WaitPort(serverRP)
     GetMsg(serverRP)
  ENDIF
  masterMsg.command:=1
  IF(sopt.toggles[TOGGLES_MULTICOM])
    ObtainSemaphore(singleNode)
    IF loggedOnUser<>NIL
      strCpy(singleNode.handle,loggedOnUser.name,ALL)
      strCpy(singleNode.location,loggedOnUser.location,ALL)
    ELSE
      strCpy(singleNode.handle,'',ALL)
      strCpy(singleNode.location,'',ALL)
    ENDIF
    strCpy(singleNode.misc1,'',ALL)
    strCpy(singleNode.misc2,'',ALL)
    IF(opt) THEN singleNode.status:=0-(currentStat+2) ELSE singleNode.status:=currentStat
    singleNode.misc2[0]:=IF allowOLM THEN 0 ELSE 1
    ReleaseSemaphore(singleNode)
  ENDIF
ENDPROC

PROC updateTitle(hoozer: PTR TO user)
  DEF aflag,pflag

  IF pagedFlag THEN pflag:="*" ELSE pflag:=" "
  IF sysopAvail THEN aflag:="*" ELSE aflag:=" "

  StringF(titlebar,'    AmiExpress BBS (c)\s  \s                      Node \d \c',expressDate,expressVer,node,aflag)

  IF hoozer=NIL
    IF window<>NIL THEN SetWindowTitles(window,titlebar,titlebar)
    RETURN
  ENDIF
  
  IF(scropen)
    StringF(ititlebar,'   \c\s, \s, (\d \s[10] [\d]) \d mins, \d \c',pflag,hoozer.name,hoozer.phoneNumber,hoozer.secStatus,hoozer.conferenceAccess,currentConf,Div(timeLimit,60),onlineBaud,aflag) ->//(RTS) was Online_BaudR
    IF(dStatBar=NIL)
      SetWindowTitles(window,ititlebar,ititlebar)
    
    ELSE
      SetWindowTitles(window,titlebar,titlebar)
    ENDIF
  ENDIF
ENDPROC

PROC statChatFlag()
  IF(sysopAvail)
    statMessage(79,1,'*')
    sendChatFlag(1)
  ELSE
    statMessage(79,1,' ')
    sendChatFlag(0)
  ENDIF
ENDPROC

PROC statPrintTime(s: PTR TO CHAR)
  DEF str[32]:STRING
 
  StringF(str,'\s[18]',s)
  statMessage(1,3,str)
ENDPROC


PROC statPrintUser(hoozer: PTR TO user,hoozer2: PTR TO userKeys,hoozer3: PTR TO userMisc)
  DEF string[82]:STRING

  statChatFlag()
  IF scropen=FALSE THEN RETURN
 
  IF hoozer=NIL
    SetWindowTitles(window,titlebar,titlebar)
    RETURN
  ENDIF
  
  statMessage(1,1,'[37m')

  ->statMessage(1,1,'                               ')
  IF(pagedFlag)
    IF(bitPlanes<>1)  THEN statMessage(1,1,'[31m')
  ENDIF

/* if user hit chat & window is no color, add * infront of user name */
  IF((bitPlanes=1) AND (pagedFlag)) THEN StringF(string,'*\s[14]',hoozer.name) ELSE StringF(string,'\s[15]',hoozer.name)
  statMessage(1,1,string)
  ->statChatFlag()
  updateTitle(hoozer)

  StringF(string,'\s[15]',hoozer3.realName)
  statMessage(17,1,string)

  StringF(string,'\d[3]',hoozer.slotNumber)
  statMessage(33,1,string)

  StringF(string,'\d[3]',hoozer.secStatus)
  statMessage(37,1,string)

  StringF(string,'\s[9]',hoozer.conferenceAccess)
  statMessage(41,1,string)

  StringF(string,'\s[12]',hoozer.phoneNumber)
  statMessage(51,1,string)

->what goes in here? seems blank

  StringF(string,'\d[6]',onlineBaud)
  statMessage(73,1,string)

  StringF(string,'\s[31]',hoozer.location)
  statMessage(1,2,string)


  ->statChatFlag()
  StringF(string,'\d[2]',hoozer.secLibrary)
  statMessage(36,2,string)

  StringF(string,'\d[2]',hoozer.secBoard)
  statMessage(33,2,string)

  StringF(string,'\d[5]',hoozer.downloads AND $FFFF)
  statMessage(39,2,string)

  StringF(string,'\d[5]',hoozer.uploads AND $FFFF)
  statMessage(45,2,string)

  StringF(string,'\d[12]',hoozer.bytesDownload)
  statMessage(51,2,string)

  StringF(string,'\d[12]',hoozer.bytesUpload)
  statMessage(64,2,string)

  StringF(string,'\r\z\d[3]',currentConf)
  statMessage(77,2,string)

  StringF(string,'\d[8]',hoozer.dailyBytesLimit)
  statMessage(36,3,string)

  StringF(string,'\d[5]',hoozer.timesCalled AND $FFFF)
  statMessage(45,3,string)

  statMessage(51,3,'                           ')

  IF(hoozer.newUser = FALSE) 
    formatLongDateTime(loggedOnUser.timeLastOn,string)
  ELSE
    IF(validUser=0)
      StringF(string,' * * Account Not Saved * * ')
    ELSE
      StringF(string,' * * New User Account  * * ')
    ENDIF
  ENDIF
  statMessage(51,3,string)

  StringF(string,'\d Min & \d[2] Secs', Div(timeLimit,60), timeLimit-(Mul(Div(timeLimit,60),60)))
  statPrintTime(string)

  StringF(string,' \r\s[15]',hostIP)
  statMessage(19,3,string)

ENDPROC

PROC pGoodbye()
  DEF i,stat
  DEF tempStr[70]:STRING

  FOR i:=10 TO 1 STEP -1
    StringF(tempStr,'Last chance!  Auto LOGOFF in \d SECS.  Abort: (Enter)=yes? ',i)
    aePuts('\b\n')
      ->//if(AnsiColor)
    aePuts('[A')
    aePuts(tempStr)
    stat:=readChar(1)
    IF(stat>0)
      IF (stat="n") OR (stat="N")
        aePuts('No\b\n\b\n')
        RETURN RESULT_GOODBYE
      ELSEIF (stat="y") OR (stat="T") OR (stat=13) OR (stat=10)
        aePuts('Yes\b\n\b\n')
        RETURN RESULT_SUCCESS
      ENDIF
    ENDIF
  ENDFOR
  aePuts('\b\n')  
ENDPROC RESULT_GOODBYE

PROC xprfopenAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfopen();
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfopen()
  DEF fn,am,i,res,filemode,task: PTR TO tc
  DEF tempstr[255]:STRING
->(*xpr_fopen)(char *filename, char *accessmode)
->        D0                     A0              A1
  MOVE.L A0,fn
  MOVE.L A1,am

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4


  IF strCmpi(am,'r',ALL) 
    filemode:=MODE_OLDFILE
  ELSEIF strCmpi(am,'w',ALL) 
    filemode:=MODE_NEWFILE
  ELSEIF strCmpi(am,'rw',ALL) 
    filemode:=MODE_READWRITE
  ELSEIF strCmpi(am,'a',ALL) 
    filemode:=MODE_READWRITE
  ELSEIF strCmpi(am,'w+',ALL) 
    filemode:=MODE_READWRITE
  ELSEIF strCmpi(am,'a+',ALL) 
    filemode:=MODE_READWRITE
  ELSE
    filemode:=MODE_READWRITE
  ENDIF

  IF (filemode=MODE_OLDFILE) AND (zModemInfo.inProgress=ZMODEM_UPLOAD)
    ->check for dupes when the xpr lib asks us to open file in read mode and we are uploading
    IF checkForFile(FilePart(fn))
      strCpy(skipdFiles+(numSkipd*32),FilePart(fn),31)
      numSkipd++
      res:=-1     ->return -1 which is not actually a file handle but xpr lib should see it as being a file that exists
      StringF(tempstr,'xprfopen: oldfile dupe \s - mode - \s, res - \d',fn, am, res)
      debugLog(LOG_DEBUG,tempstr)
      JUMP dupe 
    ENDIF
  ENDIF
  
  IF (zModemInfo.inProgress=ZMODEM_UPLOAD)
    FOR i:=numSkipd-1 TO 0 STEP -1
      ->if its a dupe file then we dont want to try and resume so return an error
      IF strCmpi(skipdFiles+(i*32),FilePart(fn),ALL)
        res:=0
        StringF(tempstr,'xprfopen: readwrite dupe \s - mode - \s, res - \d',fn, am, res)
        debugLog(LOG_DEBUG,tempstr)
        JUMP dupe 
      ENDIF
    ENDFOR
  ENDIF
 

 res:=Open(fn,filemode)

  IF strCmpi(am,'a',ALL) OR strCmpi(am,'a+',ALL)
    Seek(res,0,OFFSET_END)
  ENDIF
  StringF(tempstr,'xprfopen: \s - mode - \s, res - \d',fn, am, res)
  debugLog(LOG_DEBUG,tempstr)
dupe:
ENDPROC res

PROC xprfcloseAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfclose()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfclose()
  DEF fp,res,task: PTR TO tc
  DEF tempstr[255]:STRING
->        (*xpr_fclose)(long filepointer)
->                      A0
  MOVE.L A0,fp

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4

  StringF(tempstr,'xprfclose \d',fp)
  debugLog(LOG_DEBUG,tempstr)
  IF fp<>-1 THEN Close(fp)
ENDPROC FALSE

PROC xprchkabortAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprchkabort()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprchkabort()
  DEF winmsg:PTR TO intuimessage,res,task: PTR TO tc
  DEF tempstr[255]:STRING

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4


  res:=0
  IF windowZmodem<NIL
    IF (winmsg:=GetMsg(windowZmodem.userport))<>NIL
        ReplyMsg(winmsg)
        IF winmsg.class=IDCMP_CLOSEWINDOW THEN res:=-1
    ENDIF
  ENDIF
  
  ->StringF(tempstr,'xprchkabort, res=\d',res)
  ->debugLog(LOG_DEBUG,tempstr)
ENDPROC res

PROC xprfreadAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfread()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfread()
  DEF buf,bsize,bcount,fp,res,task: PTR TO tc
  DEF tempstr[255]:STRING
->      long count = (*xpr_fread)(char *buffer, long size, long count,
->        -D0                        A0            D0         D1
->                                  long fileptr)
->                                  A1

  MOVE.L A0,buf
  MOVE.L D0,bsize
  MOVE.L D1,bcount
  MOVE.L A1,fp

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4

  ->StringF(tempstr,'xprfread: \d bytes',bsize*bcount)
  ->debugLog(LOG_DEBUG,tempstr)

  res:=Read(fp,buf,Mul(bsize,bcount))

  ->calculate number of items read
  res:=Div(res,bsize)
ENDPROC res

PROC xprfwriteAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfwrite()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfwrite()
  DEF buf,bsize,bcount,fp,res,task: PTR TO tc
  DEF tempstr[255]:STRING
->        long count = (*xpr_fwrite)(char *buffer, long size, long count,
->        D0                         A0            D0         D1
->                                  long fileptr)
->                                  A1

  MOVE.L A0,buf
  MOVE.L D0,bsize
  MOVE.L D1,bcount
  MOVE.L A1,fp

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4

  ->StringF(tempstr,'xprfwrite: \d bytes',Mul(bsize,bcount))
  ->debugLog(LOG_DEBUG,tempstr)

  res:=Write(fp,buf,Mul(bsize,bcount))
  
  ->calculate number of items written
  res:=Div(res,bsize)
ENDPROC res

PROC xprsreadAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
   xprsread()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprsread()
  DEF buf,bsize,timeout,serialsig,i,signals,task: PTR TO tc,res,timersig,ch
  DEF tempstr[255]:STRING
  DEF waiting,status
->        long count = (*xpr_sread)(char *buffer, long size, long timeout)
->        D0                        A0            D0         D1

  MOVE.L A0,buf
  MOVE.L D0,bsize
  MOVE.L D1,timeout

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4

  ->StringF(tempstr,'xprsread: \d bytes \d timeout',bsize,timeout)
  ->debugLog(LOG_DEBUG,tempstr)

    /* Valid size parameter? */

  IF(bsize > 0)
  
    waiting,status:=getSerialInfo()

      /* Return error if carrier is lost. */

    IF(checkCarrier())=FALSE
      i:=-1
      JUMP sreaddone
    ENDIF

      /* Is there data waiting to be read? */

    IF(waiting > 0)
        /* No timeout specified? Read as many
         * bytes as available.
         */

      IF(timeout = 0)
        IF(waiting > bsize) THEN waiting:=bsize

        IF(doSerialRead(buf,waiting))
          IF(serialErrorReport(serialReadIO))
            i:=-1
            JUMP sreaddone
          ELSE
            waiting:=serialReadIO.iostd.actual
          ENDIF
        ENDIF

        ->BytesIn += Waiting

        i:=waiting
        JUMP sreaddone
      ENDIF

        /* Enough data pending to be read? */

      IF(waiting >= bsize)
        IF(doSerialRead(buf,bsize))
          IF(serialErrorReport(serialReadIO))
            i:=-1
            JUMP sreaddone
          ELSE
            bsize:=serialReadIO.iostd.actual
          ENDIF
        ENDIF

        ->BytesIn += Size

        i:=bsize
        JUMP sreaddone
      ENDIF
    ELSE
        /* No timeout and no data available:
         * return immediately.
         */

      IF(timeout=0)
        i:=0
        JUMP sreaddone
      ENDIF
    ENDIF

    serialsig:=0
    timersig:=0

    IF serialReadMP<>NIL THEN serialsig:=Shl(1, serialReadMP.sigbit)
    IF timerport<>NIL THEN timersig:=Shl(1, timerport.sigbit)

      /* Set up the timer. */

    setTimer(timeout)

      /* Set up the read request. */

    IF readQueued THEN stopSerialRead()

    ->clear the serial signal
    SetSignal(0,serialsig)

    readQueued:=TRUE
    queueRead(serialReadIO,buf,bsize)

      /* We'll need them in a minute */

    WHILE(TRUE)
      signals:=Wait(serialsig OR timersig)

        /* Receive buffer filled? */

      IF(signals AND serialsig)
          /* Abort the timer request. */


        stopTime()


          /* Did the request terminate gracefully? */

        IF(waitSerialRead())
          IF(serialErrorReport(serialReadIO))
            i:=-1
            JUMP sreaddone
          ELSE
            bsize:=serialReadIO.iostd.actual
          ENDIF
        ENDIF

        ->BytesIn += Size

        i:=bsize
        JUMP sreaddone
      ENDIF

        /* Hit by timeout? */

      IF(signals AND timersig)
          /* Abort the read request. */

        stopSerialRead()

          /* Remove the timer request. */

        waitTime()

          /* Did the driver receive any
           * data?
           */

        IF(serialReadIO.iostd.actual > 0)
          ->BytesIn += ReadRequest->IOSer.io_Actual
          i:=serialReadIO.iostd.actual
          JUMP sreaddone
        ELSE
            /* Take a second look and query the number of
             * bytes ready to be received, there may
             * still be some bytes in the buffer.
             * Note: this depends on the way the
             * driver handles read abort.
             */

          waiting,status:=getSerialInfo()

            /* Don't read too much. */

          IF(bsize > waiting) THEN bsize:=waiting

            /* Are there any bytes to be transferred? */

          IF(bsize > 0)
              /* Read the data. */

            IF(doSerialRead(buf,bsize))
              IF(serialErrorReport(serialReadIO))
                i:=-1
                JUMP sreaddone
              ELSE
                bsize:=serialReadIO.iostd.actual
              ENDIF
            ENDIF

            ->BytesIn += Size
          ELSE
              /* Ok, so there is no data in the buffer. */
              /* Check if the carrier signal is still */
              /* present */

            IF(checkCarrier())=FALSE
              i:=-1
              JUMP sreaddone
            ENDIF
          ENDIF

          i:=bsize
          JUMP sreaddone
        ENDIF
      ENDIF
    ENDWHILE
  ELSE
    i:=0
  ENDIF

sreaddone:
  ->StringF(tempstr,'xprsread complete: \d bytes',i)
  ->debugLog(LOG_DEBUG,tempstr)
ENDPROC i

PROC xprswriteAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprswrite()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprswrite()
  DEF buf,bsize,task:PTR TO tc,res
  DEF tempstr[255]:STRING
->        long status = (*xpr_swrite)(char *buffer, long size)
->        D0                          A0            D0

  MOVE.L A0,buf
  MOVE.L D0,bsize

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4

  ->StringF(tempstr,'xprswrite: \d bytes',bsize)
  ->debugLog(LOG_DEBUG,tempstr)

  serPuts(buf,bsize,TRUE)

ENDPROC FALSE

PROC xprfseekAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfseek()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfseek()
  DEF fp,offset,origin,task:PTR TO tc,res
  DEF tempstr[255]:STRING
->       long status = (*xpr_fseek)(long fileptr, long offset, long origin)
->              D0                     A0            D0         D1


  MOVE.L A0,fp
  MOVE.L D0,offset
  MOVE.L D1,origin

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4

  StringF(tempstr,'xprfseek: \d offset',offset)
  debugLog(LOG_DEBUG,tempstr)
  
  Seek(fp,offset,origin)
ENDPROC FALSE

PROC xprsflushAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprsflush()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprsflush()
  DEF task:PTR TO tc,res

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4

  debugLog(LOG_DEBUG,'xprsflush')

ENDPROC FALSE

PROC xprupdateAsm()
  MOVEM.L D0-D7/A0-A6,-(A7)
  xprupdate()
  MOVEM.L (A7)+,D0-D7/A0-A6
 ENDPROC D0

PROC xprupdate()
  DEF xpru: PTR TO xpr_update
  DEF task:PTR TO tc,updateTime
  DEF res,update=FALSE
  DEF outmsg[255]:STRING

  MOVE.L A0,xpru
  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4
  
  IF(xpru.xpru_updatemask AND XPRU_ERRORMSG)<>0
    strCpy(zModemInfo.zStat,xpru.xpru_errormsg,60)
    update:=TRUE
    
    debugLog(LOG_DEBUG,xpru.xpru_errormsg)
  ENDIF
  IF(xpru.xpru_updatemask AND XPRU_FILENAME)<>0
    update:=TRUE
    IF xpru.xpru_filename<>NIL
      IF StrCmp(zModemInfo.fileName,FilePart(xpru.xpru_filename),40)=FALSE 
        strCpy(zModemInfo.fileName,FilePart(xpru.xpru_filename),40)
        sendMasterUpload(zModemInfo.fileName)
      ENDIF
    ENDIF
  ENDIF
  
  IF(xpru.xpru_updatemask AND XPRU_EXPECTTIME)<>0
    IF xpru.xpru_expecttime<>0 THEN strCpy(zModemInfo.apxTime,xpru.xpru_expecttime,40)
  ENDIF

  IF(xpru.xpru_updatemask AND XPRU_ELAPSEDTIME)<>0
    IF xpru.xpru_expecttime<>0 THEN strCpy(zModemInfo.elapsedTime,xpru.xpru_elapsedtime,40)
  ENDIF

  IF(xpru.xpru_updatemask AND XPRU_FILESIZE)<>0
    update:=TRUE
    IF xpru.xpru_filesize<>-1
      IF zModemInfo.filesize<>xpru.xpru_filesize
        zModemInfo.filesize:=xpru.xpru_filesize
        IF zModemInfo.downloading
          StringF(outmsg,'\t\sDownloading \s[12] \d bytes',IF freeDFlag THEN 'Free ' ELSE '',zModemInfo.fileName,xpru.xpru_filesize)
        ELSE
          StringF(outmsg,'\tUploading \s[12] \d bytes',zModemInfo.fileName,xpru.xpru_filesize)
        ENDIF
        callersLog(outmsg)
        udLog(outmsg)
      ENDIF
    ENDIF
  ENDIF
  
  IF(xpru.xpru_updatemask AND XPRU_ERRORS)<>0
    IF xpru.xpru_bytes<>-1 THEN zModemInfo.errorPos:=xpru.xpru_bytes
    zModemInfo.errorCount:=xpru.xpru_errors
  ENDIF

  IF(xpru.xpru_updatemask AND XPRU_BYTES)<>0
    IF xpru.xpru_bytes<>-1
      zModemInfo.recPos:=xpru.xpru_bytes    
      IF zModemInfo.recPos=zModemInfo.filesize THEN strCpy(zModemInfo.lastTime,xpru.xpru_elapsedtime,40)
    ENDIF
  ENDIF
  IF(xpru.xpru_updatemask AND XPRU_MSG)<>0
    IF xpru.xpru_msg<>NIL
      strCpy(zModemInfo.zStat,xpru.xpru_msg,60)
      debugLog(LOG_DEBUG,xpru.xpru_msg)
    ENDIF
  ENDIF
  IF(xpru.xpru_updatemask AND XPRU_DATARATE)<>0
    IF xpru.xpru_datarate<>-1
      zModemInfo.cps:=xpru.xpru_datarate
      zModemInfo.eff:=Div(Mul(zModemInfo.cps,100),Div(onlineBaud,10))
    ENDIF
    
  ENDIF

  IF(xpru.xpru_updatemask AND XPRU_BLOCKS)<>0
    update:=TRUE
    ->StringF(outmsg,'\d blocks transferred',xpru.xpru_blocks)
    ->debugLog(LOG_DEBUG,outmsg)
  ENDIF
  /*IF(xpru.xpru_updatemask AND XPRU_BLOCKSIZE)<>0
    StringF(outmsg,'current block size: \d',xpru.xpru_blocksize)
    debugLog(LOG_DEBUG,outmsg)
  ENDIF*/

  IF update
    updateTime:=getSystemTime()
    IF zModemInfo.lastUpdate<>updateTime
      updateZDisplay()
      debugLog(LOG_DEBUG,'xpru display update')
      StringF(outmsg,'current block size: \d',xpru.xpru_blocksize)
      debugLog(LOG_DEBUG,outmsg)
      zModemInfo.lastUpdate:=updateTime

      processWindowMessage(-1)
      processCommodityMessage(-1)
      checkDoorMsg(0)
      IF servercmd=SV_UNICONIFY
          IF scropen THEN expressToFront() ELSE openExpressScreen()
        servercmd:=-1
      ENDIF

    ENDIF
  ENDIF
 ENDPROC

PROC xprsetserialAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprsetserial()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0
 
PROC xprsetserial()
  DEF task:PTR TO tc,res,newstatus,oldstatus
  DEF tempstr[255]:STRING

  MOVE.L D0,newstatus
  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4

  StringF(tempstr,'xprsetserial \d',newstatus)
  debugLog(LOG_DEBUG,tempstr)
  oldstatus:=newstatus

ENDPROC oldstatus

PROC xprfinfoAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfinfo()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfinfo()
  DEF task:PTR TO tc,i,res,fn,fitype,fp
  DEF tempstr[255]:STRING
->long info = (*xpr_finfo)(char *filename, long typeofinfo)
->        D0                       A0              D0

  MOVE.L A0,fn
  MOVE.L D0,fitype

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4

  StringF(tempstr,'xprsfinfo - fitype \d \s',fitype,fn)
  debugLog(LOG_DEBUG,tempstr)

  IF fitype=1
    ->file size

    FOR i:=numSkipd-1 TO 0 STEP -1
      ->if its a dupe file then we dont want to try and resume so return 2gb filesize

      StringF(tempstr,'xprsfinfo - dupecheck \s \s - res \d',skipdFiles+(i*32),FilePart(fn),strCmpi(skipdFiles+(i*32),FilePart(fn),ALL))
      debugLog(LOG_DEBUG,tempstr)

      IF strCmpi(skipdFiles+(i*32),FilePart(fn),ALL)
        StringF(tempstr,'xprsfinfo - dupe - \s',fn)
        debugLog(LOG_DEBUG,tempstr)
        res:=$7fffffff
        JUMP dupe 
      ENDIF
    ENDFOR

    fp:=Open(fn,MODE_OLDFILE)
    Seek(fp,0,OFFSET_END)
    res:=Seek(fp,0,OFFSET_CURRENT)
    Close(fp)
  ELSE
    ->file type
    res:=1 ->always binary
  ENDIF

  ->debugLog(LOG_DEBUG,'xprsfinfo')
ENDPROC res

PROC xprunlinkAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprunlink()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprunlink()
  DEF task:PTR TO tc,res,fn,tempstr[255]:STRING

  MOVE.L A0,fn
  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -294(A6)  ->LVO FindTask
  MOVE.L D0,task

  res:=task.userdata
  MOVE.L res,A4

  StringF(tempstr,'xprunlink \s',fn)
  debugLog(LOG_DEBUG,tempstr)

  res:=0
  ->partial upload, move it as a partial upload rather than deleting it
  IF ownPartFiles
    StringF(tempstr,'\sPartUpload/\s@\d-\d',currentConfDir,FilePart(fn),node,loggedOnUser.slotNumber)
  ELSE
    StringF(tempstr,'\sPartUpload/\s@\d',currentConfDir,FilePart(fn),loggedOnUser.slotNumber)
  ENDIF
  IF(Rename(fn,tempstr))=FALSE
    fileCopy(fn,tempstr)
    SetProtection(fn,FIBF_OTR_DELETE)
    IF DeleteFile(fn)=0 THEN res:=-1
  ENDIF
ENDPROC res

PROC waitSerialRead()
  DEF res
  IF readQueued
    readQueued:=FALSE
    WaitIO(serialReadIO)
  ELSE
    res:=0
  ENDIF
ENDPROC res

PROC waitTime()
  DEF res
  IF timerQueued
    timerQueued:=FALSE
    res:=WaitIO(timermsg)
  ELSE
    res:=0
  ENDIF
ENDPROC res

PROC doSerialRead(data,length)
  IF(readQueued) THEN stopSerialRead()

	serialReadIO.iostd.command:=CMD_READ
	serialReadIO.iostd.length:=length
	serialReadIO.iostd.data:=data
ENDPROC DoIO(serialReadIO)

PROC stopSerialRead()
  IF readQueued
    IF(CheckIO(serialReadIO))=FALSE THEN AbortIO(serialReadIO)
    WaitIO(serialReadIO)
    readQueued:=FALSE
  ENDIF
ENDPROC 

PROC serialErrorReport(request: PTR TO ioextser)
  DEF isFatal=FALSE,error

  error:=request.iostd.error
  SELECT error
		CASE SERERR_LINEERR
      debugLog(LOG_ERROR,'serial error: hardware data overrun')
			->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_HARDWARE_DATA_OVERRUN_TXT)
			isFatal:=FALSE
		CASE SERERR_PARITYERR
      debugLog(LOG_ERROR,'serial error: parity error')
			->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_PARITY_ERROR_TXT)
			isFatal:=TRUE
		CASE SERERR_TIMERERR
      debugLog(LOG_ERROR,'serial error: timer error')
			->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_TIMER_ERROR_TXT)
			isFatal:=FALSE
		CASE SERERR_BUFOVERFLOW
      debugLog(LOG_ERROR,'serial error: read buffer overflow')
			->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_READ_BUFFER_OVERFLOWED_TXT)
			isFatal:=FALSE
		CASE SERERR_NODSR
      debugLog(LOG_ERROR,'serial error: no dsr')
			->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_NO_DSR_TXT)
			isFatal:=TRUE
		CASE SERERR_DETECTEDBREAK
      debugLog(LOG_ERROR,'serial error: break detected')
			->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_BREAK_DETECTED_TXT)
			isFatal:=TRUE
		DEFAULT
      ->debugLog(LOG_ERROR,'serial error: unknown error')
			->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_UNKNOWN_CAUSE_TXT)
			isFatal:=FALSE
  ENDSELECT
ENDPROC isFatal

PROC getSerialInfo()
  DEF waiting,status
	IF(serialWriteIO)
    serialWriteIO.iostd.command:=SDCMD_QUERY
		DoIO(serialWriteIO)

		waiting:=serialWriteIO.iostd.actual
		status:=serialWriteIO.status
	ELSE
		waiting:=0
		status:=(CIAF_COMCD OR CIAF_COMDSR)
	ENDIF
ENDPROC waiting,status

PROC setTimer(timeval)
  timermsg.io.command:=TR_ADDREQUEST /* add a new timer request */
  timermsg.time.secs:=Div(timeval,1000000)          /* seconds */
  timermsg.time.micro:=Mod(timeval,1000000)        /* microseconds */
  timermsg.io.mn.replyport:=timerport
  timerQueued:=TRUE
  SendIO(timermsg)     /* post the request to the timer device */
ENDPROC

PROC stopTime()
  IF timerQueued
    IF(CheckIO(timermsg))=FALSE THEN AbortIO(timermsg)
    WaitIO(timermsg)
    timerQueued:=FALSE
  ENDIF
ENDPROC

/*PROC checkTimer()
  IF timermsg=NIL THEN RETURN FALSE
ENDPROC CheckIO(timermsg)*/

PROC openTimer()
  DEF error

  IF(timerport:=createPort(0,0))=NIL THEN RETURN TRUE

  IF(timermsg:=(createExtIO(timerport,SIZEOF timerequest)))=FALSE THEN RETURN TRUE

  timermsg.io.mn.replyport:=timerport
  IF(error:=OpenDevice('timer.device',UNIT_VBLANK,timermsg,0)) THEN RETURN error
ENDPROC FALSE

PROC closeTimer()
  IF(timermsg)	
    stopTime()
	  CloseDevice(timermsg)
	  deleteExtIO(timermsg)
    timermsg:=NIL
	  IF(timerport) THEN deletePort(timerport)
    timerport:=NIL
	ENDIF
ENDPROC

PROC zmodemStatPrint(s:PTR TO CHAR)
  IF(windowZmodem<>NIL)
	  zModemStatWriteIO.data:=s
	  zModemStatWriteIO.length:=-1
	  zModemStatWriteIO.command:=CMD_WRITE
	  DoIO(zModemStatWriteIO)
  ENDIF
ENDPROC

PROC updateZDisplay()
  DEF tempstr[255]:STRING
  
    /* transfer window not open */

  IF(windowZmodem<>NIL)

     zmodemStatPrint('[H[J[0 p')
     StringF(tempstr,'[H\n FileName: \s\n',zModemInfo.fileName)
     zmodemStatPrint(tempstr)
     StringF(tempstr,' FileSize: \d\n',zModemInfo.filesize)
     zmodemStatPrint(tempstr)
     StringF(tempstr,' ETA Time: \s\n',zModemInfo.apxTime)
     zmodemStatPrint(tempstr)
     StringF(tempstr,' Curr Time: \s\n',zModemInfo.elapsedTime)
     zmodemStatPrint(tempstr)
     StringF(tempstr,' Position: \d\n',zModemInfo.recPos)
     zmodemStatPrint(tempstr)
     IF(zModemInfo.filesize=0) 
       zmodemStatPrint(' Complete: N/A\n')
     ELSE
       StringF(tempstr,' Complete: \d%\n',Div(Mul(zModemInfo.recPos,100),zModemInfo.filesize))
       zmodemStatPrint(tempstr)
     ENDIF
     ->StringF(tempstr,' Resume P: \d\n\n',zModemInfo.resumePos)
     ->zmodemStatPrint(tempstr)
     StringF(tempstr,' LastTime: \s\n',zModemInfo.lastTime)
     zmodemStatPrint(tempstr)
     StringF(tempstr,'      CPS: \d Efficency \d%\n\n',zModemInfo.cps,zModemInfo.eff)
     zmodemStatPrint(tempstr)
     StringF(tempstr,' Z Status: \s\n',zModemInfo.zStat)
     zmodemStatPrint(tempstr)
     StringF(tempstr,' Errors: \d\n',zModemInfo.errorCount)
     zmodemStatPrint(tempstr)
     StringF(tempstr,' ErrorPos: \d ',zModemInfo.errorPos)
     zmodemStatPrint(tempstr)

  ENDIF
  StringF(tempstr,'\d[6]',zModemInfo.cps)
  sendACPCommand2(tempstr,9)
ENDPROC

PROC checkFree(fname)
  DEF fileComment[255]:STRING

  getFileComment(fname,fileComment)
  IF fileComment[0]="F" THEN RETURN TRUE
ENDPROC freeDownloads

->this returns 0 = fail, 1 = success unlike most of the routines
PROC downloadFile(str: PTR TO CHAR)
  DEF tempstr[255]:STRING
  DEF debugstr[255]:STRING
  DEF xprio: PTR TO xprIO
  DEF templist: PTR TO LONG
  DEF i,result
  DEF task:PTR TO tc
  DEF time1,time2

  IF (logonType<>LOGON_TYPE_REMOTE) AND (checkSecurity(ACS_LOCAL_DOWNLOADS)=FALSE)
    aePuts('\b\nNot supported locally...')
    RETURN 0
  ENDIF

  IF (strCmpi(xprLib[loggedOnUser.xferProtocol],'HYDRA',ALL))
    aePuts('\b\nHYDRA protocol is not currently supported')
    RETURN 0
  ENDIF
    
  IF(strCmpi(xprLib[loggedOnUser.xferProtocol],'INTERNAL',ALL))
    StringF(tempstr,'XPR Zmodem: Ready to Send\b\n')
  ELSE
    StringF(tempstr,'\s: Ready to Send\b\n',xprTitle[loggedOnUser.xferProtocol])
  ENDIF
  
  aePuts(tempstr)
  aePuts('Control-X to Cancel\b\n')
  
  IF(strCmpi(xprLib[loggedOnUser.xferProtocol],'INTERNAL',ALL))
    StrCopy(tempstr,'xprzmodem.library')
  ELSEIF(strCmpi(xprLib[loggedOnUser.xferProtocol],'HYDRA',ALL))
    aePuts('\b\nHYDRA transfers are not currently supported\b\n')
    RETURN 0
  ELSE
    StringF(tempstr,'\s.library',xprLib[loggedOnUser.xferProtocol])
  ENDIF

  IF (xprotocolbase:=OpenLibrary(tempstr,0))=NIL
    aePuts('\b\nUnable to open the xpr library\b\n')
    RETURN 0
  ENDIF

  StringF(tempstr,'[Node \d] Send Window',node)
  strCpy(zModemInfo.titleBar,tempstr,ALL)
  zModemInfo.recPos:=0;zModemInfo.filesize:=0;zModemInfo.errorCount:=0;zModemInfo.errorPos:=0;zModemInfo.cps:=0; zModemInfo.eff:=0; zModemInfo.resumePos:=0
  strCpy(zModemInfo.zStat,'',ALL)
  strCpy(zModemInfo.fileName,'',ALL)
  strCpy(zModemInfo.lastTime,'',ALL)

  IF scropen
    openZmodemStat()
  ENDIF
  zModemInfo.inProgress:=ZMODEM_DOWNLOAD
  
  xprio:=NEW xprio

  MOVE.L A4,result
  task:=FindTask(NIL)
  task.userdata:=result

  xprio.xpr_extension:=4
  xprio.xpr_fopen:={xprfopenAsm}
  xprio.xpr_fclose:={xprfcloseAsm}
  xprio.xpr_fread:={xprfreadAsm}
  xprio.xpr_fwrite:={xprfwriteAsm}
  xprio.xpr_sread:={xprsreadAsm}
  xprio.xpr_swrite:={xprswriteAsm}
  xprio.xpr_sflush:={xprsflushAsm}
  xprio.xpr_update:={xprupdateAsm}
  xprio.xpr_chkabort:={xprchkabortAsm}
  xprio.xpr_chkmisc:=0 
  xprio.xpr_gets:=0
  xprio.xpr_setserial:={xprsetserialAsm}
  xprio.xpr_ffirst:=0
  xprio.xpr_fnext:=0
  xprio.xpr_finfo:={xprfinfoAsm}
  xprio.xpr_fseek:={xprfseekAsm}
  xprio.xpr_data:=0
  xprio.xpr_options:=0
  xprio.xpr_unlink:={xprunlink}
  xprio.xpr_squery:=0
  xprio.xpr_getptr:=0

  StrCopy(tempstr,'')
  IF(strCmpi(xprLib[loggedOnUser.xferProtocol],'INTERNAL',ALL))
    StrCopy(tempstr,'TN,AY,OR,E99,KN,SN,RN,DN,B64')
  ELSE
    readToolType(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'OPTIONS',tempstr)
  ENDIF
  
  StringF(debugstr,'xpr setup options = \s',tempstr)
  debugLog(LOG_DEBUG,debugstr)
  xprio.xpr_filename:=tempstr
  IF XprotocolSetup(xprio)=0
    CloseLibrary(xprotocolbase)
    END xprio
    zModemInfo.inProgress:=ZMODEM_NONE
    closezModemStats()
    RETURN 0
  ENDIF
  
  templist:=List(2048)
  parseList(str,templist)
  
  IF openTimer()
    debugLog(LOG_ERROR,'Can''t re-open Timer Device!')
    CloseLibrary(xprotocolbase)
    zModemInfo.inProgress:=ZMODEM_NONE
    closezModemStats()
    END xprio
    RETURN 0
  ENDIF

  ->cancel current queued serial read request
  readQueued:=TRUE
  stopSerialRead()

  i:=0
  result:=TRUE
  time1:=getSystemTime()
  REPEAT
    xprio.xpr_filename:=templist[i]
    sendMasterDownload(templist[i])

    freeDFlag:=checkFree(templist[i])
    zModemInfo.downloading:=TRUE

    result:=XprotocolSend(xprio)
    IF result
      onlineNFiles++
      removeFileList(FilePart(templist[i]))
      IF(freeDFlag=FALSE) THEN donf++
      tBT:=tBT+zModemInfo.filesize
      dTBT:=dTBT+zModemInfo.filesize
    ENDIF
    time2:=getSystemTime()
    i++
  UNTIL (result=0) OR (i=ListLen(templist))
  tTTM:=time2-time1;
  XprotocolCleanup(xprio)

  END xprio

  closeTimer()
  FOR i:=0 TO ListLen(templist)-1
    DisposeLink(templist[i])
  ENDFOR
  DisposeLink(templist)
  
  CloseLibrary(xprotocolbase)
  zModemInfo.inProgress:=ZMODEM_NONE
  closezModemStats()
  
  ->restart normal serial 
  queueRead(serialReadIO,{serbuff})

  aePuts(xprTitle[loggedOnUser.xferProtocol])
  IF result THEN aePuts(' download successful\b\n') ELSE aePuts(' download unsuccessful\b\n')
ENDPROC result

PROC checklist(lfnames: PTR TO CHAR, clrfinal: PTR TO CHAR)

  DEF x,cnt,status
  DEF str[255]:STRING

  cnt:=0
  FOR x:=0 TO StrLen(lfnames)-1
    IF(lfnames[x]<>" ")
      str[cnt]:=lfnames[x]
      cnt++
    ELSE
      str[cnt]:=0
      IF(StrLen(str)>1)
        status:=checkForFileSize(str,clrfinal,0)
        IF((status=11) OR (status=10)) THEN RETURN RESULT_SUCCESS
        cnt:=0
      ENDIF
    ENDIF
  ENDFOR
ENDPROC RESULT_SUCCESS

PROC displayUserToCallersLog(udonly)
  DEF tempStr[255]:STRING
  DEF tempStr2[10]:STRING
  DEF calltime
  
  IF(udonly=FALSE)
    callersLogDivider()
    callerIDLog(0)
  ELSE
   udLogDivider()
  ENDIF

  calltime:=getSystemTime()
  formatLongDate(calltime,tempStr)
  formatLongTime(calltime,tempStr2)
  IF(loggedOnUser.timesCalled=0)
    my_struct.newuser:=TRUE
    StringF(tempStr,'\s (\s) NEW [\d] \s (\s) \s',tempStr,tempStr2,loggedOnUser.slotNumber,loggedOnUser.name,connectString,loggedOnUser.location)
  ELSE
    StringF(tempStr,'\s (\s) [\d] \s (\s) \s',tempStr,tempStr2,loggedOnUser.slotNumber,loggedOnUser.name,connectString,loggedOnUser.location)
    my_struct.newuser:=FALSE
  ENDIF
 
  IF(udonly=FALSE)
    loggedOnUser.timesCalled:=loggedOnUser.timesCalled+1
    callersLog(tempStr)
    IF(logonType>=LOGON_TYPE_REMOTE) AND (checkToolTypeExists(TOOLTYPE_NODE,node,'LOG_HOST'))
      StringF(tempStr,'\tTelnet login address: \s (\s)',hostName,hostIP)
      callersLog(tempStr)
    ENDIF
  ELSE
    udLog(tempStr)
  ENDIF

ENDPROC

PROC isascii(n)
ENDPROC n<=127

PROC getFileSize(s: PTR TO CHAR)
  DEF fBlock: fileinfoblock
  DEF fLock
  DEF fsize=8192

  IF((fLock:=Lock(s,ACCESS_READ)))=NIL
    RETURN 8192
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN 8192
  ENDIF
  IF(Examine(fLock,fBlock)) THEN fsize:=fBlock.size
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC fsize

->gets the actual name of a file (eg. you pass it a filename and it finds the correct case for it, so you can preserve the case)
PROC getFileName(s: PTR TO CHAR)
  DEF fBlock: fileinfoblock
  DEF fLock

  IF((fLock:=Lock(s,ACCESS_READ)))=NIL
    RETURN
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN
  ENDIF
  IF(Examine(fLock,fBlock)) THEN StrCopy(s,fBlock.filename)
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC

PROC getFileComment(s: PTR TO CHAR,outString)
  DEF fBlock: fileinfoblock
  DEF fLock

  StrCopy(outString,'')
  IF((fLock:=Lock(s,ACCESS_READ)))=NIL
    RETURN
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN
  ENDIF
  IF(Examine(fLock,fBlock)) THEN StrCopy(outString,fBlock.comment)
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC

PROC dynAllocate(maxbufsize)
  DEF pbuf
  DEF maxBuf
  DEF avail
  
  maxBuf:=readToolTypeInt(TOOLTYPE_NODE,node,'COPYBUFFER')
  IF (maxBuf>0) AND (maxbufsize>maxBuf) THEN maxbufsize:=maxBuf
  
  avail:=AvailMem(MEMF_LARGEST)
  IF maxbufsize>avail THEN maxbufsize:=avail-65536

 /* first try Fast mem allocate */
 WHILE((pbuf:=AllocMem(maxbufsize,MEMF_PUBLIC OR MEMF_CLEAR)))=FALSE
    maxbufsize:=maxbufsize-65536;
    EXIT (maxbufsize<65536)
    Delay(5)
 ENDWHILE
 IF(maxbufsize<8192)  THEN RETURN 0,0
ENDPROC pbuf,maxbufsize


PROC fileCopy(from,to)
  DEF buf:PTR TO CHAR
  DEF bufsize,stat1,stat2
  DEF fhs,fhd
  DEF tempstr[255]:STRING
 ->if(Rename(from,to)) return(2);
 
  buf,bufsize:=dynAllocate(getFileSize(from)+8192)
  IF(buf<>NIL) 
      /* got a buffer full of mem */
	  IF(fhs:=Open(to,MODE_OLDFILE)) 
		    Close(fhs);                 /* file exists so return */
 	    FreeMem(buf,bufsize);       
		  RETURN RESULT_SUCCESS
		ENDIF

	  IF(fhs:=Open(from,MODE_OLDFILE)) 
		  IF(fhd:=Open(to,MODE_NEWFILE))
			  REPEAT
				  stat1:=Read(fhs,buf,bufsize)   /* Read from file */
				  IF(stat1>0)	THEN stat2:=Write(fhd,buf,stat1) /* write to file*/
        UNTIL (stat1<=0) OR (stat2<=0)

 			  IF(stat1<0)
    			StringF(tempstr,'\b\nERROR while reading from \s!\b\n',from)
          aePuts(tempstr)
				ENDIF
	      IF(stat2<0)
 				  StringF(tempstr,'\b\nERROR while writing to \s!\b\n',to)
	    		aePuts(tempstr);
				ENDIF
 			  Close(fhd)
			ENDIF
	    Close(fhs)
		ENDIF
	  FreeMem(buf,bufsize)
	ENDIF

 IF(((stat1>=0) AND (stat2>=0)))
    RETURN 1
 ENDIF
 
ENDPROC 0

PROC moveFile(filename,filesize)
  DEF stat
  DEF pathnum
  DEF goodtogo=0
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF tempstr3[255]:STRING
  
  IF(filesize=0) 
    errorLog('(mf 518)')
    RETURN 0
  ENDIF

  filesize:=filesize+16384
  filesize:=Shr(filesize,10)       ->changed to take account of disk space now in kb

  pathnum:=1
  StringF(tempstr3,'ULPATH.\d',pathnum)
  pathnum++
  
  WHILE(readToolType(TOOLTYPE_CONF,currentConf,tempstr3,tempstr3))
    stat:=rFreeSpace(tempstr3)
    IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'\s/\s',sopt.ramPen,filename) ELSE StringF(tempstr,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,filename)
    StringF(tempstr2,'\s\s',tempstr3,filename)
    IF(Rename(tempstr,tempstr2))
      SetProtection(tempstr,FIBF_OTR_DELETE)
      DeleteFile(tempstr)
      StringF(tempstr,'\tUpload moved to \s',tempstr2)
      callersLog(tempstr)
      aePuts(' File Posted\b\n\b\n')
      RETURN 1
    ELSE
      StringF(tempstr3,'WARNING could not rename file \s to \s, \s, code: \d',tempstr,tempstr2,IoErr())
      ->debugLog(LOG_WARN,tempstr3)
      errorLog(tempstr3)
    ENDIF
    IF(stat>filesize)
      goodtogo:=1
      IF(stat:=fileCopy(tempstr,tempstr2))
        SetProtection(tempstr,FIBF_OTR_DELETE)
        DeleteFile(tempstr)
        StringF(tempstr,'\tUpload moved to \s',tempstr2)
        callersLog(tempstr)
        aePuts(' File Posted\b\n\b\n')
        RETURN 1
      ENDIF
    ELSE
      StringF(tempstr3,'stat: \d, filesize: \d',stat,filesize)
      ->debugLog(LOG_WARN,tempstr3)
      errorLog(tempstr3)
    ENDIF
    StringF(tempstr3,'ULPATH.\d',pathnum)
    pathnum++
  ENDWHILE 
  IF(goodtogo=FALSE)
    aePuts('WARNING!\b\nNO FREE SPACE on any path!  While moving to upload dir...')
    errorLog('WARNING!NO FREE SPACE on any path!  While moving to upload dir...')
  ENDIF

  aePuts('FAILURE!!!  unable to move file!\b\n\b\n')
  StringF(tempstr,'\tFAILURE!, unable to move file \s from PlayPen',filename)
  callersLog(tempstr);
  IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'\s/\s',sopt.ramPen,filename) ELSE StringF(tempstr,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,filename)
  SetProtection(tempstr,FIBF_OTR_DELETE)
  DeleteFile(tempstr)
ENDPROC 0

PROC xprReceive(file)
  DEF tempstr[255]:STRING,debugstr[255]:STRING
  DEF result
  DEF xprio: PTR TO xprIO
  DEF task:PTR TO tc
  DEF i,time1,time2

  IF(strCmpi(xprLib[loggedOnUser.xferProtocol],'INTERNAL',ALL))
    StrCopy(tempstr,'xprzmodem.library')
  ELSEIF(strCmpi(xprLib[loggedOnUser.xferProtocol],'HYDRA',ALL))
    aePuts('\b\nHYDRA transfers are not currently supported\b\n')
    RETURN RESULT_FAILURE
  ELSE
    StringF(tempstr,'\s.library',xprLib[loggedOnUser.xferProtocol])
  ENDIF
  ->StrCopy(tempstr,xprLib[loggedOnUser.xferProtocol])
  
  IF (xprotocolbase:=OpenLibrary(tempstr,0))=NIL
    aePuts('\b\nUnable to open the xpr library\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  xprio:=NEW xprio

  StringF(tempstr,'[Node \d] Receive Window',node)
  strCpy(zModemInfo.titleBar,tempstr,ALL)
  zModemInfo.recPos:=0; zModemInfo.filesize:=0; zModemInfo.errorCount:=0; zModemInfo.errorPos:=0; zModemInfo.cps:=0; zModemInfo.eff:=0; zModemInfo.resumePos:=0
  strCpy(zModemInfo.zStat,'',ALL)
  strCpy(zModemInfo.fileName,'',ALL)
  strCpy(zModemInfo.apxTime,'',ALL)
  strCpy(zModemInfo.lastTime,'',ALL)

  IF scropen
    openZmodemStat()
  ENDIF
  zModemInfo.inProgress:=ZMODEM_UPLOAD

  MOVE.L A4,result
  task:=FindTask(NIL)
  task.userdata:=result

  xprio.xpr_extension:=4
  xprio.xpr_fopen:={xprfopenAsm}
  xprio.xpr_fclose:={xprfcloseAsm}
  xprio.xpr_fread:={xprfreadAsm}
  xprio.xpr_fwrite:={xprfwriteAsm}
  xprio.xpr_sread:={xprsreadAsm}
  xprio.xpr_swrite:={xprswriteAsm}
  xprio.xpr_sflush:={xprsflushAsm}
  xprio.xpr_update:={xprupdateAsm}
  xprio.xpr_chkabort:={xprchkabortAsm}
  xprio.xpr_chkmisc:=0 
  xprio.xpr_gets:=0
  xprio.xpr_setserial:={xprsetserialAsm}
  xprio.xpr_ffirst:=0
  xprio.xpr_fnext:=0
  xprio.xpr_finfo:={xprfinfoAsm}
  xprio.xpr_fseek:={xprfseekAsm}
  xprio.xpr_data:=0
  xprio.xpr_options:=0
  xprio.xpr_unlink:={xprunlinkAsm}
  xprio.xpr_squery:=0
  xprio.xpr_getptr:=0

  StrCopy(tempstr,'')
  IF(strCmpi(xprLib[loggedOnUser.xferProtocol],'INTERNAL',ALL))
    StrCopy(tempstr,'TN,AY,OR,E99,KN,SN,RN,DN,B64')
  ELSE
    readToolType(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'OPTIONS',tempstr)
  ENDIF
  
  StringF(debugstr,'xpr setup options = \s',tempstr)
  debugLog(LOG_DEBUG,debugstr)
  xprio.xpr_filename:=tempstr
  IF XprotocolSetup(xprio)=0
    CloseLibrary(xprotocolbase)
    zModemInfo.inProgress:=ZMODEM_NONE
    closezModemStats()
    END xprio
    RETURN RESULT_FAILURE
  ENDIF
  
  ->override options with thsee (P = upload folder, KN dont keep partial uploads - actually our xprlink routine moves them into partial uploads
  IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'KN,P\s',sopt.ramPen) ELSE StringF(tempstr,'KN,P\sNode\d/PlayPen',cmds.bbsLoc,node)
  xprio.xpr_filename:=tempstr
  IF XprotocolSetup(xprio)=0
    CloseLibrary(xprotocolbase)
    zModemInfo.inProgress:=ZMODEM_NONE
    closezModemStats()
    END xprio
    RETURN RESULT_FAILURE
  ENDIF

  IF openTimer()
    debugLog(LOG_ERROR,'Can''t re-open Timer Device!')
    CloseLibrary(xprotocolbase)
    zModemInfo.inProgress:=ZMODEM_NONE
    closezModemStats()
    END xprio
    RETURN RESULT_FAILURE
  ENDIF

  ->cancel current queued serial read request
  readQueued:=TRUE
  stopSerialRead()

  i:=0
  time1:=getSystemTime()
  zModemInfo.downloading:=FALSE

  result:=XprotocolReceive(xprio)
  time2:=getSystemTime()
  tTTM:=time2-time1;
  XprotocolCleanup(xprio)
  
  receivePlayPen()
 
  tTEFF:=Div(Mul(Div(tBT,tTTM),100),Div(onlineBaud,10))

  Delay(50)

  aePuts(xprTitle[loggedOnUser.xferProtocol])
  IF(result) THEN aePuts(' upload successful\b\n') ELSE aePuts(' upload unsuccessful\b\n')

  END xprio

  closeTimer()

  CloseLibrary(xprotocolbase)
  zModemInfo.inProgress:=ZMODEM_NONE
  closezModemStats()

  ->restart normal serial IO
  queueRead(serialReadIO,{serbuff})
ENDPROC

PROC freeDiskSpace()
->now returns free space in kb not bytes
  DEF string[200]:STRING,path[100]:STRING
  DEF tempstr[255]:STRING
  
  DEF tfs,fsu
  DEF drivenum=1
 
  tfs:=0
  StringF(path,'DRIVE.\d',drivenum)
  drivenum++
  IF readToolType(TOOLTYPE_DRIVES,'',path,string)
    WHILE(readToolType(TOOLTYPE_DRIVES,'',path,string))
      fsu:=rFreeSpace(string)
      tfs:=tfs+fsu
      StringF(path,'DRIVE.\d',drivenum)
      drivenum++
    ENDWHILE
  ELSE
    StringF(tempstr,'\b\nThe file \sDRIVES.info is missing!!!\b\n\b\n',cmds.bbsLoc)
    aePuts(tempstr)
    RETURN RESULT_FAILURE
  ENDIF
 
ENDPROC tfs

PROC rFreeSpace(path: PTR TO CHAR)
->now returns space in kb not bytes
  DEF fLock
  DEF i_data: PTR TO infodata
  DEF tempstr[255]:STRING
  DEF stat=0
 
  IF(i_data:=AllocMem(SIZEOF infodata,MEMF_CHIP))
    IF(fLock:=Lock(path,ACCESS_READ))
      IF(stat:=Info(fLock,i_data))
        stat:=Mul(Shr((i_data.numblocks-i_data.numblocksused),10),i_data.bytesperblock)     ->changed to get kbytes free instead of bytes
        ->stat:=(Mul(i_data.numblocks,i_data.bytesperblock))-(Mul(i_data.numblocksused,i_data.bytesperblock))
      ELSE
        StringF(tempstr,'\b\nCan not get info from \s for free space\b\n',path)
        aePuts(tempstr)
      ENDIF
      UnLock(fLock)
    ELSE
      StringF(tempstr,'\b\nCan not find free space for \s\b\n',path)
      aePuts(tempstr)
    ENDIF
    FreeMem(i_data,SIZEOF infodata)
  ELSE
    myError(0)
  ENDIF
ENDPROC stat

/*
static void ListProtocols(void)
{
 AEPutStr("\b\n                              [Z] AMI-Zmodem Batch");
//AEPutStr("\b\n                              [X] XPR-Zmodem Batch\b\n");
}
*/

PROC setProtocol(str: PTR TO CHAR)
-> int status;

 /* added this till we add protocols (RTS) */
 loggedOnUser.protocol:="Z"
 RETURN

/*
#ifdef RTS_NOPROTOCOLS
if(str[0]=='\0')
	{
	ListProtocols();
	}
for(;;)
	{
	if(str[0]=='\0')
		{
          sprintf(str,"\b\nProtocol: (Enter)= %c? ",User.Protocol);
		AEPutStr(str);
		str[0]='\0';
		status=LineInput("",str,1,KEYBOARD_TIMEOUT);
		if(status<0) { return; }
		}
	if(strlen(str)!=0)
		{
		strupr(str);
		switch(str[0])
			{
			case 'Z':
//			case 'X':
				AEPutStr("\b\n");
				User.Protocol=(UBYTE)str[0];
				return;
				break;
			default:
				str[0]='\0';
				AEPutStr("\b\nInvalid protocol select another\b\n");
				ListProtocols();
				break;
			}
		}
	else
		{
		return;
		}
	}
#endif

*/
ENDPROC

PROC stripReturn(str: PTR TO CHAR)
  DEF i,t
  i:=StrLen(str)-1
  WHILE(i>0)
    t:=str[i]
    IF(t<=32) THEN str[i]:=0 ELSE RETURN
    i--
  ENDWHILE
ENDPROC

PROC scanHoldDesc()
  DEF fi
  DEF string[200]:STRING, text[200]:STRING
  DEF tempstr[255]:STRING
  
  lcFileXfr:=FALSE
  
  StringF(purgeScanNM,'\d',loggedOnUser.slotNumber)
  StringF(string,'\sLCFILES/\s.lc',currentConfDir,purgeScanNM)
  IF(fi:=Open(string,MODE_OLDFILE))>0
    lcFileXfr:=TRUE
    WHILE((ReadStr(fi,string)<>-1) OR (StrLen(string)>0))
      IF(string[0]<>" ")
        string[13]:=0
        StringF(text,'\sLCFILES/\s',currentConfDir,string)
        stripReturn(text)
        IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'\s/\s',sopt.ramPen,string) ELSE StringF(tempstr,'\sNode\d/PlayPen/\s',cmds.bbsLoc,node,string)
        stripReturn(tempstr)

        IF(checkForFile(FilePart(text))<>RESULT_FAILURE)
          IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'\s/\s',sopt.ramPen,string) ELSE StringF(tempstr,'\sNode\d/PlayPen/\s',cmds.bbsLoc,node,string)
          stripReturn(tempstr)

          IF(Rename(text,tempstr))=FALSE THEN fileCopy(text,tempstr)
        ENDIF
        SetProtection(text,FIBF_OTR_DELETE)
        DeleteFile(text)
      ENDIF
    ENDWHILE
    Close(fi)
    StringF(string,'\sLCFILES/\s.lc',currentConfDir,purgeScanNM)
    SetProtection(string,FIBF_OTR_DELETE)
    DeleteFile(string);
    uploadaFile(1,'','')
  ENDIF   /* end if fi != NL */
  lcFileXfr:=FALSE
  aePuts('\b\n')
ENDPROC

PROC partUploadOK(option)

  DEF fib=NIL:PTR TO fileinfoblock
  DEF fLock
  DEF status,ch
  DEF rts_stat = RESULT_SUCCESS    /* Tue Jan 28 10:37:46 1992 */
  DEF path[100]:STRING,str[100]:STRING,ray2[100]:STRING
  DEF cnt = 0
  DEF s:PTR TO CHAR
 
  StrCopy(path,currentConfDir);
  StrAdd(path,'PartUpload/')
  IF(maxDirs=0) THEN RETURN RESULT_SUCCESS
  
  IF(logonType=LOGON_TYPE_LOCAL) THEN RETURN RESULT_SUCCESS
 
  IF((fLock:=Lock(path,ACCESS_READ)))=FALSE
    StringF(str,'\b\nTell \s the bbs can''t access the \s dir\b\n',cmds.sysopName,path)
    aePuts(str)
    RETURN RESULT_SUCCESS ->// success = 0
  ENDIF
                              ->//(RTS) was chip
  IF((fib:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)             ->//(RTS)
    myError(0)
    RETURN RESULT_SUCCESS
  ENDIF
 
  IF((Examine(fLock,fib)))=FALSE
    UnLock(fLock)
    FreeDosObject(DOS_FIB,fib)
    RETURN RESULT_SUCCESS
  ENDIF
 
  IF(fib.direntrytype > 0)   /* make sure we locked a directory */
    WHILE(ExNext(fLock,fib))     /* my change.. prior to this we had a blank file name */
      IF(StrLen(fib.filename) = 0)   /* check for filename > 0 length */
        JUMP inoh
      ENDIF

      cnt:=0
      s:=fib.filename
      WHILE((s[0]) AND (cnt < 30))      /* check for valid file name */
          IF(s[0] = " ")     /* check for spaces at beginning of filename */
            JUMP inoh
          ENDIF
          IF(s[0] = "/")
            JUMP inoh
          ENDIF
          IF((isascii(s[0])))=FALSE
            JUMP inoh
          ENDIF
          cnt++
          s++
      ENDWHILE
 
 /** END ERROR CKING */
      StrCopy(str,fib.filename)
      StrCopy(ray2,str)
      status:=getUN(str)       /* remove the @(num at end of file. Return user number */
      IF(status=loggedOnUser.slotNumber)
        aePuts('There are some incompleted uploads of yours\b\n')
        IF(option=FALSE) THEN aePuts('Would you like to leave anyway (Y/N)? ')

        WHILE TRUE
          ch:=checkOnlineStatus()
          IF(ch<0)
            rts_stat:=ch
            JUMP outoh
          ENDIF
          IF(option=FALSE)
            ch:=readChar(INPUT_TIMEOUT)
            IF(ch=RESULT_TIMEOUT)
              rts_stat:=RESULT_NO_CARRIER
              JUMP outoh/* Tue Jan 28 10:33:54 1992 RTS */
            ENDIF
            IF(logonType>=LOGON_TYPE_REMOTE)
              status:=checkCarrier()
              IF(status=FALSE) 
                rts_stat:=RESULT_NO_CARRIER
                JUMP outoh
              ENDIF
            ENDIF
          ELSE
            ch:="N"
          ENDIF

          IF((ch="N") OR (ch="n"))
            IF(option=FALSE) THEN aePuts('No!   View them (Y/N)? ') ELSE aePuts('View them (Y/N)? ')
            purgeLine()
            WHILE TRUE
                ch:=checkOnlineStatus()
                IF(ch<0)
                  rts_stat:=ch
                  JUMP outoh
                ENDIF
                ch:=readChar(INPUT_TIMEOUT);
                IF(ch=RESULT_TIMEOUT)
                  rts_stat:=RESULT_NO_CARRIER
                  JUMP outoh
                ENDIF
                IF((ch="N") OR (ch="n")) 
                  aePuts('No!\b\n')
                  rts_stat:=RESULT_ABORT
                  JUMP outoh
                ENDIF
                EXIT ((ch="Y") OR (ch="y"))
            ENDWHILE
            ->// AEPutStr("Yes..\b\n");
            rts_stat:=RESULT_FAILURE
            JUMP outoh
          ENDIF   /* end if ch == 'n' */
          EXIT ((ch="Y") OR (ch="y"))
        ENDWHILE          /* end forever */
        JUMP outoh
      ENDIF
      ->//AEPutStr("Yes..\b\n");
inoh:
    ENDWHILE  /* end while (ExNext(FLock,Fib)) */
  ENDIF     /* end if(Fib->fib_DirEntryType > 0) */
outoh:
  IF(fLock) THEN UnLock(fLock)
  IF(fib) THEN FreeDosObject(DOS_FIB,fib)
ENDPROC rts_stat

PROC uploadDesc()
  DEF status,x,count
  DEF str[255]:STRING,str2[255]:STRING,odate[50]:STRING,str3[200]:STRING,str4[200]:STRING,buff[255]:STRING
  DEF udf
  DEF brk=0
  DEF seglist=0
 
  cleanItUp()
  aePuts('Batch UpLoading.....\b\n')
  aePuts('\b\nUnlimited files.  Blank Line to start transfer.\b\n')
 
  count:=0
  WHILE(TRUE)
updesccont:
    count++
    StringF(str,'\b\nFileName \d: ',count)
    aePuts(str)
    ->status:=lineInput('','',12,INPUT_TIMEOUT,str);
    status:=lineInput('','',100,INPUT_TIMEOUT,str)
    IF(status<0) THEN RETURN status
    IF(((str[0]="A") OR (str[0]="a")) AND (StrLen(str)=1))
      aePuts('\b\n')
      RETURN RESULT_FAILURE
    ENDIF
    
    brk:=(StrLen(str)=0)
    IF(brk) THEN aePuts('\b\n')
    EXIT brk
    
    StrCopy(str2,str)
    UpperStr(str2)
    IF Not((strCmpi(str2,'HTTP://',7)) OR (strCmpi(str2,'HTTPS://',8)) OR (strCmpi(str2,'FTP://',6)))
      IF StrLen(str)>12
        aePuts('Files longer than 12 characters are not allowed.\b\n')
        count--
        JUMP updesccont
      ENDIF
      status:=checkForFile(str)   /* is file online ?? */
      IF(status=RESULT_FAILURE)
        aePuts('File Exists, or has a symbol (#?*).\b\n')
        count--
        JUMP updesccont
      ENDIF
    ENDIF

    IF (strCmpi(str2,'HTTP://',7)) OR (strCmpi(str2,'HTTPS://',8)) OR (strCmpi(str2,'FTP://',6))
      StrCopy(str2,str)
      StrCopy(str,FilePart(str2),ALL)

      IF(StrLen(sopt.ramPen)>0) THEN StringF(str4,'\s/\s',sopt.ramPen,str) ELSE StringF(str4,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,str)
      StringF(str3,'curl -# -f -k \s -o \s',str2,str4)
      Execute(str3,NIL,NIL)
      IF fileExists(str4)
        lcFileXfr:=TRUE
      ELSE
        aePuts('File download was not successful.\b\n')
        count--
        JUMP updesccont
      ENDIF
    ENDIF
    
    StringF(str4,'\s\s',nodeWorkDir,str)             /* 11w add */
    
    udf:=Open(str4,MODE_OLDFILE)
    IF(udf>0) 
      aePuts('You can''t Upload a duplicate.\b\n')
      count--
      Close(udf)
      JUMP updesccont
    ENDIF
    formatLongDate(getSystemTime(),odate)
  
    StringF(buff,'\b\nPlease enter a description, you only have \d lines.',my_struct.max_desclines)
    aePuts(buff)
 /* renamed Spazm to sysops */ ->//JOE 26-Jun
    aePuts('\b\nPress return alone to end.  Begin  with (/) to make upload ''Private'' to Sysop.\b\n')
    aePuts('                                [--------------------------------------------]\b\n')
    StringF(str2,'\l\s[13]                   :',str)
    aePuts(str2)
    /*---11 w */
     /*-- end  11w */
    status:=lineInput('','',44,INPUT_TIMEOUT,str2)
    IF(status<0) THEN RETURN status
    IF(StrLen(str2)=0)
      count--
      JUMP updesccont
    ENDIF
    udf:=Open(str4,MODE_NEWFILE)
    IF(udf<=0) 
      myError(7)
      ->//aePuts('Tell sysop the system can''t open a file in the work dirs\b\n\b\n')
      RETURN RESULT_FAILURE
    ENDIF
    fileWriteLn(udf,str2)
    x:=0
    REPEAT
      aePuts('                                :')
      status:=lineInput('','',44,INPUT_TIMEOUT,str2)
      IF(status<0)
        Close(udf)
        SetProtection(str4,FIBF_OTR_DELETE)
        DeleteFile(str4)
        RETURN status
      ENDIF
      IF(StrLen(str2)<>0) THEN fileWriteLn(udf,str2)
      x++
    UNTIL ((StrLen(str2)=0) OR (x>=(my_struct.max_desclines-1)))
    Close(udf)
 
  ENDWHILE
  aePuts('Okay:   (Enter) to Start, (G)oodbye after transfer, (A)bort? ')
 
  REPEAT
    status:=checkOnlineStatus()
    IF(status<0) THEN RETURN status
    status:=readChar(INPUT_TIMEOUT)
    IF(status<(-1)) THEN RETURN status

    IF((status=65) OR (status=97))
      aePuts('Abort!\b\n\b\n')
      RETURN RESULT_FAILURE
    ENDIF
    IF(((status="L") OR (status="l")) AND (ximPort=CONSOLE_PORT))
      status:=13
      localUpload:=1
    ENDIF
  UNTIL (status=13) OR (status=71) OR (status=103)
 
  IF(status<>13)
    aePuts('Goodbye!\b\n\b\n')
    RETURN 2
  ELSE
    aePuts('\b\n\b\n')
  ENDIF
ENDPROC 1

PROC cleanItUp()
  DEF fLock
  DEF fib: PTR TO fileinfoblock
  DEF i
  DEF s: PTR TO CHAR
  DEF cnt = 0
  DEF tempstr[255]:STRING
 
  StrCopy(tempstr,nodeWorkDir)
  i:=StrLen(tempstr)-1
  WHILE(i)
    IF((tempstr[i]<=" ") OR (tempstr[i]="/"))
      tempstr[i]:=0
    ELSE
      i:=1    ->break
    ENDIF
    i--
  ENDWHILE
 
  IF((fib:=AllocDosObject(DOS_FIB,NIL)))=NIL 
    myError(0)
    RETURN
  ENDIF
  
  /* lock the directory (Playpen or RamPen) */
  IF((fLock:=Lock(tempstr,ACCESS_READ)))=0
    myError(8)
    JUMP ef
  ENDIF
 
  IF((Examine(fLock,fib)))=0
    myError(6)
    JUMP ef
  ENDIF
 
  IF(fib.direntrytype > 0)   /* make sure we locked a directory */
    WHILE(ExNext(fLock,fib))
      IF(fib.direntrytype < 0)   /* found a file */
 /* * * ERROR CHECKING * * */
        /* or we can change to &Fib->fib_FileName[0] */
        IF(StrLen(fib.filename) = 0)    /* check for filename > 0 length */
          JUMP ef
        ENDIF

        cnt:=0
        s:=fib.filename
        WHILE((s[0]) AND (cnt < 30))     /* check for valid file name */
          IF(s[0] = " ")      /* check for spaces at beginning of filename */
            JUMP ef
          ENDIF
          IF(s[0] = "/") 
            JUMP ef
          ENDIF
          IF(isascii(s[0]))=FALSE
            JUMP ef
          ENDIF
          cnt++
          s++
        ENDWHILE
 
 /* * * END ERROR CHECKING * * */
 
 
        StringF(tempstr,'\s\s',nodeWorkDir,fib.filename)   /* 11w */
        SetProtection(tempstr,FIBF_OTR_DELETE)
        DeleteFile(tempstr)
      
 
      ENDIF /* end if(Fib->fib_DirEntryType < 0) */
 
    ENDWHILE   /* end while(ExNext(FLock,Fib)) */
 
  ENDIF     /* end  if(Fib->fib_DirEntryType > 0) */
 
ef:
  IF(fLock) THEN UnLock(fLock)
  IF(fib) THEN FreeDosObject(DOS_FIB,fib)
ENDPROC

PROC batchasl(where: PTR TO CHAR) HANDLE
  DEF fr:filerequester
  DEF frargs: PTR TO wbarg
  DEF src[102]:STRING
  DEF dest[102]:STRING
  DEF debugstr[255]:STRING
  DEF aslDir[255]:STRING
  DEF x,tags=NIL
  DEF returnval

  StrCopy(aslDir,cmds.bbsLoc)
  IF readToolType(TOOLTYPE_CONF,currentConf,'LOCAL_UPLOAD_PATH',aslDir)=FALSE
    IF readToolType(TOOLTYPE_NODE,node,'LOCAL_UPLOAD_PATH',aslDir)=FALSE
      readToolType(TOOLTYPE_CONFCONFIG,'','LOCAL_UPLOAD_PATH',aslDir)
    ENDIF
  ENDIF
  
  KickVersion(37)  -> E-Note: requires V37   
  aslbase:=OpenLibrary('asl.library',37)
  IF aslbase=NIL THEN Raise(ERR_LIB)
    tags:=NEW [ASL_HAIL,'/X Local Upload FileRequest',
       ASL_WINDOW, window,      ->breaks it for some reason
       ASL_PATTERN,'#?',
       ASL_FUNCFLAGS, FILF_MULTISELECT OR FILF_PATGAD,
       ASL_DIR,aslDir,
       NIL]
  fr:=AllocAslRequest(ASL_FILEREQUEST,tags)
  
  returnval:=0
  aePuts('\b\nBatch Local upload in progress, Please Stand by!\b\n')
  IF(AslRequest(fr,0))
    returnval:=(fr.numargs)+1
    aePuts('\b\n')
    IF(fr.numargs)
      frargs:=fr.arglist

      FOR x:=0 TO fr.numargs-1
        StrCopy(src,fr.drawer)
        AddPart(src,frargs[x].name,100)
        StrCopy(dest,where)
        AddPart(dest,frargs[x].name,100)
        IF((rzmsg=FALSE) AND (checkForFile(frargs[x].name)))
          aePuts('[0mFile ')
          aePuts(frargs[x].name)
          aePuts(' already exists\b\n')
        ELSE
          aePuts('[0mCopying ')
          aePuts(frargs[x].name)
          aePuts('[0m\b\n')
          fileCopy(src,dest)
        ENDIF
      ENDFOR
    ELSE
      StrCopy(src,fr.drawer)
      AddPart(src,fr.file,100)
      StrCopy(dest,where)
      AddPart(dest,fr.file,100)
      IF((rzmsg=FALSE) AND (checkForFile(fr.file)))
        aePuts('[0mFile ')
        aePuts(fr.file)
        aePuts(' already exists\b\n')
      ELSE
        aePuts('[0mCopying ')
        aePuts('[0m\b\n')
        aePuts(fr.file)
        fileCopy(src,dest)
      ENDIF
    ENDIF
  ELSE
    StringF(debugstr,'error: \d',IoErr())
    debugLog(LOG_ERROR,debugstr)
  ENDIF
EXCEPT DO
  IF fr THEN FreeAslRequest(fr)
  IF tags THEN END tags
  IF aslbase THEN CloseLibrary(aslbase)
  SELECT exception
    CASE ERR_ASL
      debugLog(LOG_ERROR,'Error: Could not allocate ASL request')
    CASE ERR_KICK
      debugLog(LOG_ERROR,'Error: Requires V37')
    CASE ERR_LIB
      debugLog(LOG_ERROR,'Error: Could not open ASL library')
  ENDSELECT
ENDPROC returnval

PROC zmodemReceive(flname:PTR TO CHAR,uLFType)
  DEF c
 	DEF p:PTR TO CHAR
  DEF temp[100]:STRING
  IF((logonType>=LOGON_TYPE_REMOTE) AND (localUpload=FALSE) AND (lcFileXfr=FALSE))
  
    IF ((strCmpi(xprLib[loggedOnUser.xferProtocol],'HYDRA',ALL)))
      aePuts('\b\nHYDRA protocol is not currently supported')
      RETURN RESULT_FAILURE
    ENDIF
    
    IF(uLFType=FALSE) 
      IF(strCmpi(xprLib[loggedOnUser.xferProtocol],'INTERNAL',ALL))
        StringF(temp,'\b\nXPR Zmodem: Ready to Receive\b\n')
      ELSE
        StringF(temp,'\b\n\s: Ready to Receive\b\n',xprTitle[loggedOnUser.xferProtocol])
      ENDIF
      aePuts(temp);
      aePuts('Control-X to Cancel\b\n')
    ENDIF

    IF(checkSecurity(ACS_XPR_RECEIVE))
      xprReceive(flname)
      RETURN 1
    ENDIF
    
/* still to do
    StringF(temp,'[Node \d] Receive Window',node)
    strCpy(zModemInfo.titleBar,temp,ALL)
    zModemInfo.recPos:=0; zModemInfo.filesize:=0; zModemInfo.errorCount:=0; zModemInfo.errorPos:=0; zModemInfo.lastTime:=0
    zModemInfo.cps:=0; zModemInfo.eff:=0; zModemInfo.resumePos:=0
    strCpy(zModemInfo.zStat,'',ALL)
    strCpy(zModemInfo.fileName,'',ALL)
    strCpy(zModemInfo.apxTime,'',ALL)
    openZDisplay()
    zWindow:=1;
    Delay(50)
    AbortIO(serialReadIO)
    WaitIO(serialReadIO)

    p:=StrLen(flname)+flname
    WHILE((p>=flname) AND (p[0]<>":") AND (p[0]<>"/"))
      p[0]=0
      p--
    ENDWHILE

   ->  if(!CheckIO(TimerMsg)) AbortIO(TimerMsg);
   ->      WaitIO(TimerMsg);
    ->c:=proto(serialReadIO, serialWriteIO, TimerMsg, &diskbuff[0], DSKBUFF,onlineBaud, flname, 0, 0)

    queueRead(serialReadIO,{serbuff})
    closeZDisplay()     /* close the transfer widow */
    zWindow:=0
    Delay(70)
    IF(uLFType) THEN aePuts('\b\n\b\n')

    aePuts(xprTitle[loggedOnUser.xferProtocol])
    IF(c) THEN aePuts(' upload successful\b\n') ELSE aePuts(' upload unsuccessful\b\n')
    RETURN c*/
  ELSE
    IF(lcFileXfr=FALSE)
      IF(batchasl(flname)) THEN receivePlayPen()
    ELSE
      receivePlayPen()
    ENDIF
    lcFileXfr:=0
    ->AEPutStr("\b\nNot supported locally...");
  ENDIF
  localUpload:=0
ENDPROC 0

PROC receivePlayPen()
  DEF fLock
  DEF fib: PTR TO fileinfoblock
  DEF s:PTR TO CHAR
  DEF cnt = 0
  DEF tempstr[255]:STRING
  
  onlineNFiles:=0
  tBT:=0
  StrCopy(recFileNames,'')
  
  IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'\s/',sopt.ramPen) ELSE StringF(tempstr,'\sNode\d/Playpen',cmds.bbsLoc,node)
 
  IF((fib:=AllocDosObject(DOS_FIB,NIL)))=NIL
    myError(0)
    RETURN
  ENDIF

    /* lock the directory (Playpen or RamPen) */
  IF((fLock:=Lock(tempstr,ACCESS_READ)))=0
    myError(8)
    JUMP fx
  ENDIF
 
  IF((Examine(fLock,fib)))=0
    myError(6)
    JUMP fx;
  ENDIF
 
  IF(fib.direntrytype > 0)   /* make sure we locked a directory */
    WHILE(ExNext(fLock,fib))
      IF(fib.direntrytype < 0)   /* found a file */
          /* or we can change to &Fib->fib_FileName[0] */
        IF(StrLen(fib.filename) = 0)   /* check for filename > 0 length */
          errorLog('(cpp - 631) Strlen')
          JUMP fx;
        ENDIF

        cnt:=0
        s:=fib.filename
        WHILE((s[0]) AND (cnt < 30))     /* check for valid file name */
          IF(s[0] = " ")     /* check for spaces at beginning of filename */
            JUMP fx
          ENDIF
          IF(s[0]="/")
            JUMP fx
          ENDIF
          IF((isascii(s[0]))=FALSE)
            JUMP fx
          ENDIF
          cnt++
          s++
        ENDWHILE
        onlineNFiles++
        tBT:=tBT+fib.size
        StrAdd(recFileNames,fib.filename)
        StrAdd(recFileNames,' ')
      ENDIF                    /* end if(Fib->fib_DirEntryType < 0)  */
    ENDWHILE                      /* end while(ExNext(FLock,Fib))       */
  ENDIF                               /* end if(Fib->fib_DirEntryType > 0)  */
 
 fx:
   IF(fLock) THEN UnLock(fLock)
   IF(fib) THEN FreeDosObject(DOS_FIB,fib)

ENDPROC

PROC getUN(sa: PTR TO CHAR)
  DEF x=0,x2=0,n=0
  WHILE((sa[x])<>0) AND (n=0)
    IF((sa[x])="@")
      n:=1
      sa[x]:=0
    ENDIF
    x++
  ENDWHILE
  IF(n)
    IF ownPartFiles
      IF(x2:=InStr(sa,'-',x))<>-1
        IF Val(sa+x)=node
          RETURN Val(sa+x2+1)
        ENDIF
      ENDIF
    ELSE
      RETURN Val(sa+x)
    ENDIF
  ENDIF
ENDPROC 0

PROC resumeStuff(tfs,fsuploading)
  DEF status,ch
  DEF string[256]:STRING,path[256]:STRING,ray2[256]:STRING,ray[256]:STRING,str[256]:STRING
  DEF fBlock:PTR TO fileinfoblock
  DEF fLock
  DEF stat,removeAll=FALSE
 
  StrCopy(path,currentConfDir)
  StrAdd(path,'PartUpload/')
 
  IF((fLock:=Lock(path,ACCESS_READ)))=0    ->//(RTS) replaced no err cking version below
    myError(8)
    RETURN -1
  ENDIF
                                                     ->// was MEMF_CHIP
  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    myError(0) ->(RTS)
    UnLock(fLock)
    RETURN -1
  ENDIF
 
  IF((Examine(fLock,fBlock)))=0
    FreeDosObject(DOS_FIB,fBlock)
    UnLock(fLock)
    myError(6)
    RETURN -1
  ENDIF
 
 ->ADD THIS !!
 
  WHILE ((ExNext(fLock,fBlock))<>0)   ->(RTS)
    StrCopy(str,fBlock.filename)
    StrCopy(ray2,str)
    status:=getUN(str)  /* returns user number from end of file name */
    IF(status=loggedOnUser.slotNumber)
      IF removeAll
        StringF(string,'Delete \s[12] [\d[6]] ',str,fBlock.size)
      ELSE
        StringF(string,'Resume \s[12] [\d[6]] (Y/N)? ',str,fBlock.size)
      ENDIF
      aePuts(string)
      WHILE(TRUE)
        ch:=checkOnlineStatus()
        IF(ch<0)
          FreeDosObject(DOS_FIB,fBlock)
          IF(fLock) THEN UnLock(fLock) ->//(RTS) Lock held
          RETURN ch
        ENDIF
        IF removeAll
          ch:="N"
        ELSE
          ch:=readChar(INPUT_TIMEOUT)
        ENDIF
        IF(ch=RESULT_TIMEOUT)
          FreeDosObject(DOS_FIB,fBlock)
          IF(fLock) THEN UnLock(fLock)  ->//(RTS) Lock held
          RETURN RESULT_NO_CARRIER
        ENDIF
        IF((ch="N") OR (ch="n"))
          IF removeAll=FALSE THEN aePuts('No!   Delete (Y/N/All)? ')
          purgeLine()
          WHILE (TRUE)
              IF removeAll
                ch:="Y"
              ELSE  
                ch:=readChar(INPUT_TIMEOUT);
              ENDIF
              IF(ch=RESULT_TIMEOUT)
                FreeDosObject(DOS_FIB,fBlock)
                IF(fLock) THEN UnLock(fLock)  ->//(RTS) Lock held
                RETURN RESULT_NO_CARRIER
              ENDIF
              IF(logonType>=LOGON_TYPE_REMOTE)
                status:=checkCarrier()
                IF(status=FALSE) 
                  FreeDosObject(DOS_FIB,fBlock)
                  IF(fLock) THEN UnLock(fLock)  ->(RTS) Lock held
                  RETURN RESULT_NO_CARRIER
                ENDIF
              ENDIF
              IF((ch="N") OR (ch="n"))
                aePuts('No!\b\n')
                JUMP dirCont
              ENDIF
              IF ((ch="A") OR (ch="a"))
                removeAll:=TRUE
                ch:="Y"
              ENDIF
              EXIT ((ch="Y") OR (ch="y"))
          ENDWHILE        /* end first forever */
          IF removeAll
            aePuts('All.. Deleted!\b\n')          
          ELSE
            aePuts('Yes.. Deleted!\b\n')
          ENDIF
          StrCopy(string,path)
          StrAdd(string,ray2)
          SetProtection(string,FIBF_OTR_DELETE)
          DeleteFile(string)
          JUMP dirCont
        ENDIF  /* end if ch == 'n */
        
        EXIT (ch="Y") OR (ch="y")
      ENDWHILE   /* end 2nd forever */
      aePuts('Yes..\b\n')
      StringF(string,'\b\nResuming upload: \s\b\n\b\n',str)
      aePuts(string)      /* filename */
      StrAdd(path,ray2)     /* conf_loc:filename/ */

      IF(StrLen(sopt.ramPen)>0)
        StrCopy(ray,sopt.ramPen)  /* should be filename without @name */
        StrAdd(ray,'/');
        StrAdd(ray,str)    /* should be old partial file with @num on end */
        stat:=fileCopy(path,ray)  /* path = filename +@num */
      ELSE
        StringF(ray,'\sNode\d/Playpen/',cmds.bbsLoc,node)
        StrAdd(ray,str)       /* filename */
        stat:=fileCopy(path,ray)      /* rename file */
      ENDIF
      IF(stat=1)
        SetProtection(path,FIBF_OTR_DELETE)
        DeleteFile(path)
      ENDIF

      IF(fBlock) THEN FreeDosObject(DOS_FIB,fBlock)
      IF(fLock) THEN UnLock(fLock)
      RETURN 1
dirCont:
     ENDIF            /* if status & user name */
  ENDWHILE
  IF(fBlock) THEN FreeDosObject(DOS_FIB,fBlock)
  IF(fLock) THEN UnLock(fLock)
ENDPROC 0

PROC cleanPlayPen()
  DEF stat,err
  DEF fLock
  DEF fib: PTR TO fileinfoblock
  DEF s: PTR TO CHAR
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF tempstr3[255]:STRING
  DEF cnt = 0
 
  IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'\s/',sopt.ramPen) ELSE StringF(tempstr,'\sNode\d/Playpen/',cmds.bbsLoc,node)

  IF(fib:= AllocDosObject(DOS_FIB,NIL))=NIL
    myError(0)
    RETURN
  ENDIF
  
  /* lock the directory (Playpen or RamPen) */
  IF((fLock:=Lock(tempstr,ACCESS_READ)))=0
    myError(8)
    JUMP fx2
  ENDIF
 
  IF((Examine(fLock,fib)))=0
      myError(6)
      JUMP fx2;
  ENDIF
 
  IF(fib.direntrytype > 0)   /* make sure we locked a directory */
    WHILE(ExNext(fLock,fib))
      IF(fib.direntrytype < 0)   /* found a file */
        /* or we can change to &Fib->fib_FileName[0] */
        IF(StrLen(fib.filename) = 0)   /* check for filename > 0 length */
          JUMP fx2
        ENDIF
 
         cnt:=0
         s:=fib.filename;
         WHILE((s[0]) AND (cnt < 30))     /* check for valid file name */
          IF(s[0] = " ")      /* check for spaces at beginning of filename */
            JUMP fx2
          ENDIF
          IF(s[0] = "/")
           JUMP fx2
          ENDIF
          IF((isascii(s[0])))=FALSE
            JUMP fx2;
          ENDIF
          cnt++
          s++
         ENDWHILE

          /* get our copy to Filename */
          IF ownPartFiles
            StringF(tempstr2,'\sPartUpload/\s@\d-\d',currentConfDir,fib.filename,node,loggedOnUser.slotNumber)
          ELSE
            StringF(tempstr2,'\sPartUpload/\s@\d',currentConfDir,fib.filename,loggedOnUser.slotNumber)
          ENDIF

          IF(StrLen(sopt.ramPen)>0)
            StringF(tempstr,'\s/\s',sopt.ramPen,fib.filename)
            REPEAT
              IF(tempstr[StrLen(tempstr)-1] = "/")
                 JUMP fx2
              ENDIF

              /* again not error, only for testing */
              /* check for valid copy */
              stat:=fileCopy(tempstr,tempstr2)
              IF(stat=FALSE) THEN StrAdd(tempstr2,'_')
            UNTIL (stat<>0) OR (StrLen(tempstr2)>=40)
              /* end if RamPen */
          ELSE    /* uploading to hdrive */
            StringF(tempstr,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,fib.filename)
            stat:=Rename(tempstr,tempstr2)
            err:=IoErr()
            IF((stat=0) AND (err=213))
 /* sx:  */   REPEAT
                IF(tempstr[StrLen(tempstr)-1] = "/")
                  JUMP fx2
                ENDIF
                /* again not error, only for testing */
                /* check for valid filename */
                stat:=fileCopy(tempstr,tempstr2)
                IF(stat=FALSE)
                  StrAdd(tempstr2,'_')
                ELSE
-> #ifdef RTS
->//(RTS) Sat Jun  6 21:23:40 1992  .. set cause we never knew we lost carrier with a parcial
->// upload, there for when we went back from upload_a_file we didnt return goodbye or lost_carrier
 
->//               partupload:=TRUE
->#endif
                ENDIF
              UNTIL (stat<>0) OR (StrLen(tempstr2)>=40)
            ENDIF          /* end if(!stat&&err==213 */
          ENDIF            /* end else */
          IF(stat)
            SetProtection(tempstr,FIBF_OTR_DELETE)
            DeleteFile(tempstr)
          ENDIF
       ENDIF                       /* end if(Fib->fib_DirEntryType < 0)  */
    ENDWHILE                      /* end while(ExNext(FLock,Fib))       */
  ENDIF                           /* end if(Fib->fib_DirEntryType > 0)  */
 
fx2:
  IF(fLock) THEN UnLock(fLock)
  IF(fib) THEN FreeDosObject(DOS_FIB,fib)
ENDPROC

PROC checkOurList(fname: PTR TO CHAR, str: PTR TO CHAR)
  DEF fp;
  DEF buff[255]:STRING
  DEF dest[255]:STRING
 
  IF((fp:=Open(fname,MODE_OLDFILE)))<=0     /* can't find our file */
     RETURN RESULT_SUCCESS
  ENDIF
 
  WHILE((ReadStr(fp,buff)<>-1)) OR (StrLen(buff)>0)
     IF(ParsePatternNoCase(buff,dest,200)<>-1)
       IF(MatchPatternNoCase(dest,str))
          Close(fp)
        RETURN RESULT_FAILURE
       ENDIF
     ENDIF
  ENDWHILE
  Close(fp)
ENDPROC RESULT_SUCCESS

PROC checkForFile(fn: PTR TO CHAR)
  DEF path[255]:STRING,final[255]:STRING
  DEF ft
  DEF x
 
  IF((InStr(fn,'%')>=0) OR ((InStr(fn,'#'))>=0) OR ((InStr(fn,'?'))>=0) OR ((InStr(fn,' '))>=0) OR ((InStr(fn,'/'))>=0) OR
    ((InStr(fn,'('))>=0) OR ((InStr(fn,')'))>=0)) THEN RETURN RESULT_FAILURE
  
  /* here we can add our own file list of files to check */
  IF(StrLen(sopt.filesNot)>0)
    x:=checkOurList(sopt.filesNot,fn)   /* a list of files not to allow up */
    IF(x = RESULT_FAILURE) THEN RETURN RESULT_FAILURE
  ENDIF
  IF(lcFileXfr=FALSE)
    StrCopy(path,currentConfDir)
    StrAdd(path,'LcFiles/')
    StringF(final,'\s\s',path,fn)
    IF(ft:=Open(final,MODE_OLDFILE))>0
      Close(ft)
      RETURN RESULT_FAILURE
    ENDIF
  ENDIF
 ->//---------------- lcfiles checking finished
   x:=1;
   StringF(path,'DLPATH.\d',x)
   x++
 	 WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,path))
     StrCopy(final,path)
     StrAdd(final,fn)
     ft:=Open(final,MODE_OLDFILE)
     IF(ft>0)  /* Found the file so return fail */
       Close(ft)
       RETURN RESULT_FAILURE
     ENDIF
     StringF(path,'DLPATH.\d',x)
     x++
  ENDWHILE
  /*=== 11w add */
   x:=1
   StringF(path,'ULPATH.\d',x)
   x++
   WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,path))
    StrCopy(final,path)
    StrAdd(final,fn)
    ft:=Open(final,MODE_OLDFILE)
    IF(ft>0)
      Close(ft)
      RETURN RESULT_FAILURE
    ENDIF
    StringF(path,'ULPATH.\d',x)
    x++
 	ENDWHILE
            
 /*-- 11w end addition */

ENDPROC RESULT_SUCCESS

PROC displayOutPutofTest()
  DEF tempstr[255]:STRING
  StringF(tempstr,'\sOutPut_Of_Test',nodeWorkDir)
  nonStopDisplayFlag:=TRUE
  displayFile(tempstr,FALSE,FALSE)
ENDPROC

PROC checkFileExternal(temp: PTR TO CHAR, checkFile: PTR TO CHAR)
  DEF stat
  DEF fi
  DEF fi1
  DEF s[255]:STRING
  DEF i
  DEF fileName[256]:STRING,options[256]:STRING, image[256]:STRING
  DEF filetags
  DEF stack,pri

  stat:=RESULT_SUCCESS

  IF readToolType(TOOLTYPE_FCHECK,temp,'CHECKER',s)
    StrCopy(options,s)
  ELSE
    RETURN 0,stat
  ENDIF
  
  IF readToolType(TOOLTYPE_FCHECK,temp,'OPTIONS',s)
    StrAdd(options,' ')
    StrAdd(options,s)
  ENDIF

  IF(readToolType(TOOLTYPE_FCHECK,temp,'STACK',s))
    stack:=Val(s)
  ELSE
    stack:=4096
  ENDIF

  IF(readToolType(TOOLTYPE_FCHECK,temp,'PRIORITY',s))
    pri:=Val(s)
  ELSE
    pri:=0
  ENDIF
->(RTS)
  StrAdd(options,' ')
  StrAdd(options,checkFile)
  StringF(fileName,'\sOutPut_Of_Test',nodeWorkDir)
  IF((fi:=Open(fileName,MODE_NEWFILE)))>0
    filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,fi,NP_STACKSIZE,stack,NP_PRIORITY,pri,NIL]:LONG
    SystemTagList(options,filetags)
    END filetags
    Close(fi)
   
    displayOutPutofTest()
    
    IF(readToolType(TOOLTYPE_FCHECK,temp,'SCRIPT',s))
      IF(fi:=Open('NIL:',MODE_NEWFILE))>0
        filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,fi,NP_STACKSIZE,stack,NP_PRIORITY,pri,NIL]:LONG
        StringF(options,'\s \s \s \d',s,checkFile,FilePart(checkFile),node)
        SystemTagList(options,filetags)
        END filetags
        Close(fi)
      ENDIF
    ENDIF
    StringF(options,'\sOutPut_Of_Test',nodeWorkDir)
    i:=1
    StringF(fileName,'ERROR.\d',i)
    i++
    WHILE(readToolType(TOOLTYPE_FCHECK,temp,fileName,s))
       fi1:=Open(options,MODE_OLDFILE)
       WHILE((ReadStr(fi1,image)<>-1)) OR (StrLen(image)>0)
         IF(InStr(image,s))<>-1
           stat:=RESULT_FAILURE
         ENDIF
         EXIT stat=RESULT_FAILURE
       ENDWHILE
       Close(fi1);
       EXIT stat=RESULT_FAILURE
       StringF(fileName,'ERROR.\d',i)
       i++
    ENDWHILE
    SetProtection(options,FIBF_OTR_DELETE)
    DeleteFile(options)
  ELSE
    RETURN 0,stat
  ENDIF
ENDPROC 1,stat

PROC testFile(str: PTR TO CHAR, path: PTR TO CHAR)
  DEF x,x2,stat,r
  DEF temp[100]:STRING,temp2[100]:STRING
  ->DEF temp3[100]:STRNG
  DEF temp4[100]:STRING
  DEF options[200]:STRING
  
  StrCopy(temp,str)
  x:=0
 
  ->StringF(temp3,'\scommands/syscmd/",cmds.bbsLoc)
  REPEAT
    IF(temp[x]=".")
      x2:=0;
      REPEAT
        temp2[x2]:=temp[x+x2+1]
        x2++
      UNTIL temp[x+x2+1]=0
      temp2[x2]:=0
      UpperStr(temp2)
      IF(StrLen(temp2)=3)
        StrCopy(options,path)
        stat:=RESULT_NOT_ALLOWED
        aeGoodFile:=RESULT_NOT_ALLOWED
        StringF(temp4,'FILECHECK \s',temp)
        IF(processSysCommand(temp4))=FALSE
          aePuts('Testing ...')
          aePuts(FilePart(str))
          aePuts('\b\n')
          StrAdd(options,temp)
          r,stat:=checkFileExternal(temp2,options)
        ELSE
          stat:=aeGoodFile
          IF(stat:=RESULT_NOT_TESTED)
            stat:=RESULT_NOT_ALLOWED
            StrAdd(options,temp)
            r,stat:=checkFileExternal(temp2,options)
          ENDIF 
        ENDIF
        RETURN stat
      ENDIF             /* end if strlen */
    ENDIF                 /* end if temp */
    x++
  UNTIL x>=StrLen(temp) /* end do */
ENDPROC RESULT_NOT_ALLOWED

PROC displaySysopULStats()
 
  DEF i,num,num2
  DEF str[100]:STRING,str2[100]:STRING
  DEF fp
 
  IF(checkSecurity(ACS_ULSTATS))=FALSE THEN RETURN
 
  FOR i:=1 TO cmds.numConf
    num:=0
    num2:=0
    StringF(str,'\sSysopStats/NumULs_\d',cmds.bbsLoc,i)
    IF((fp:=Open(str,MODE_OLDFILE)))>0
      ReadStr(fp,str2)
      Close(fp)
      IF(loggedOnUser.slotNumber=1)
        SetProtection(str,FIBF_OTR_DELETE)
        DeleteFile(str)
      ENDIF
      num:=Val(str2)
    ENDIF

    StrAdd(str,'HOLD')
    IF((fp:=Open(str,MODE_OLDFILE)))>0
      ReadStr(fp,str2)
      Close(fp)
      IF(loggedOnUser.slotNumber=1)
        SetProtection(str,FIBF_OTR_DELETE)
        DeleteFile(str)
      ENDIF
      num2:=Val(str2)
    ENDIF
    IF((num<>0) OR (num2<>0))
        StringF(str2,'\b\n\s has \d new uploads, \d upload, \d hold\b\n',getConfName(i),(num+num2),num,num2)
        aePuts(str2)
    ENDIF
  ENDFOR
ENDPROC

PROC sysopULStats(holdflag)
  DEF num
  DEF str[256]:STRING,str2[256]:STRING
  DEF ff
 
  StringF(str,'\sSysopStats/NumULs_\d',cmds.bbsLoc,currentConf)
  IF(holdflag) THEN StrAdd(str,'HOLD')
 
  num:=0
  IF((ff:=Open(str,MODE_OLDFILE)))>0
    ReadStr(ff,str2)
    num:=Val(str2)
    Close(ff)
  ENDIF
  num++
  ff:=Open(str,MODE_NEWFILE)
  IF(ff<=0) THEN RETURN
  StringF(str,'\d\n',num)
  fileWrite(ff,str)
  Close(ff)
ENDPROC

PROC sysopUpload()
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF destpath[255]:STRING
  DEF string[255]:STRING
  DEF str[255]:STRING
  DEF list[1024]:STRING
  DEF stat,cnt
  DEF space,space2
  DEF path[255]:STRING
  DEF status,x,ch
  
  aePuts('\b\nDestination path for upload? ')
  stat:=lineInput('','',250,INPUT_TIMEOUT,destpath)
  IF((stat<0) OR (StrLen(destpath)=0))	
    aePuts('\b\n')
    RETURN
  ENDIF

  IF(findAssign(destpath))
    aePuts('\b\nDevice not Mounted.\b\n')
    aePuts('\b\n')
    RETURN
  ENDIF

  space:=rFreeSpace(destpath)                /* check free space - now in kb instead of bytes */
  IF(space=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
 
  IF(StrLen(sopt.ramPen)>0) THEN StringF(path,'\s/',sopt.ramPen) ELSE StringF(path,'\sNode\d/Playpen/',cmds.bbsLoc,node)
 
  space2:=rFreeSpace(path)
 
  IF((space2)<2048)    /* Do we have 2 megs or free space ?? */
    IF checkToolTypeExists(TOOLTYPE_NODE,node,'RAMWORK')=FALSE
      myError(9)            /* no free space */
      RETURN RESULT_SUCCESS
    ENDIF
  ENDIF

  aePuts('\b\n')
  formatSpaceValue(space,tempstr)
  formatSpaceValue(space2,tempstr2)
  StringF(string,'\s available for uploading.  \s at one time.\b\n',tempstr,tempstr2)   ->changed to indicate space in kb instead of bytes
  aePuts(string)

  onlineNFiles:=0
  numSkipd:=0
  dTBT:=0
  tBT:=0
  tTTM:=0
  tTEFF:=0
  tTCPS:=0
  cnt:=0

  displayUserToCallersLog(1)
  zmodemReceive(path,1)     /* path of upload */

  aePuts('\b\n\b\nFile Uploading Complete...\b\n')
     
  StringF(string,' \d file(s), \dk bytes, \d minute(s). \d second(s), \d cps, \d% efficiency.',onlineNFiles,Div(tBT,1024),Div(tTTM,60),Mod(tTTM,60),zModemInfo.cps,zModemInfo.eff)
 
  aePuts(string)
  aePuts('\b\n\b\n')

  StrCopy(str,'\t')
  StrAdd(str,string)
 
  IF(onlineNFiles>0)
    callersLog(str)
    udLog(str)
  ELSE
    callersLog('\tUpload Failed..')
    udLog('\tUpload Failed..')
  ENDIF

  IF(logonType>=LOGON_TYPE_REMOTE)
    IF checkCarrier()=FALSE
      cleanPlayPen()
      RETURN RESULT_SUCCESS
    ENDIF
  ENDIF
  
  StrCopy(list,recFileNames)

  FOR x:=0 TO StrLen(list)-1
 
    IF(list[x]<>" ")
        str[cnt]:=list[x]
        cnt++
    ELSE
      SetStr(str,cnt)

      IF(StrLen(sopt.ramPen)>0)
        StringF(tempstr,'\s/\s',sopt.ramPen,str)
      ELSE
        StringF(tempstr,'\sNode\d/PLAYPEN/\s',cmds.bbsLoc,node,str)
      ENDIF
      StringF(tempstr2,'copying \s to \s',str,destpath)
      aePuts(tempstr2)

      ch:=tempstr2[StrLen(tempstr2)-1];
      IF((ch<>":") AND (ch<>"/"))
        StringF(tempstr2,'\s/\s',destpath,str)
      ELSE
        StringF(tempstr2,'\s\s',destpath,str)
      ENDIF
      
      IF fileExists(tempstr2)
        StringF(string,' - file exists, do you wish to overwrite? ',FilePart(tempstr2))
        aePuts(string)
        ch:=readChar(INPUT_TIMEOUT)
        IF(ch<0) THEN RETURN ch
        IF((ch="Y") OR (ch="y"))
          aePuts('Yes\b\n')
          DeleteFile(tempstr2) 
        ELSE
          aePuts('No\b\n')
        ENDIF
      ELSE
        aePuts('\b\n')
      ENDIF

      status:=0
      WHILE((StrLen(FilePart(tempstr2))<35) AND (status=FALSE))
        status:=Rename(tempstr,tempstr2)
        IF(status=FALSE)
          status:=fileCopy(tempstr,tempstr2)
          IF(status=FALSE) THEN StrAdd(tempstr2,'_')
          IF(status)
            SetProtection(tempstr,FIBF_OTR_DELETE)
            DeleteFile(tempstr) 
          ENDIF
        ENDIF
      ENDWHILE
    ENDIF
  ENDFOR
  cleanPlayPen()
ENDPROC RESULT_SUCCESS

PROC uploadaFile(uLFType,cmd,params)            -> JOE
  DEF fBlock: fileinfoblock
  DEF fLock
  DEF i,x,x2,x3,cnt,status,moveToLCFILES,hold,cstat,noF,lcfile
  DEF status2,gstat
  DEF peff,pcps,tFS,fSUploading
  DEF path[256]:STRING,str[255]:STRING,istr[255]:STRING,str2[255]:STRING
  DEF list[1024]:STRING,fmtstr[256]:STRING
  DEF odate[20]:STRING,fcomment[256]:STRING
  DEF ray[256]:STRING,ray2[256]:STRING,temp[256]:STRING,string[256]:STRING
  DEF buff[255]:STRING
  DEF tempstr[255]:STRING,tempstr2[255]:STRING,tempstr3[255]:STRING
  DEF uaf,f
  DEF protocol
  DEF foundDupe=0
  DEF mstat      /* check for carrier. trying to stop upload guru from parcial upload */
  DEF filetags
  DEF fsstr[11]:STRING
 
   /* these two for testing asCII chars */
  DEF cnt1 = 0
  DEF s:PTR TO CHAR
 
  onlineNFiles:=0
  numSkipd:=0
  
  IF(maxDirs=0)
      aePuts('\b\n');
      myError(5)             ->Sorry no files in conf
      RETURN RESULT_FAILURE
  ENDIF
 
  IF(uLFType=0)
      displayScreen(SCREEN_UPLOAD)
  ENDIF
 
  tFS:=freeDiskSpace()                /* check free space - now in kb instead of bytes */
  IF(tFS=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
 
  IF(StrLen(sopt.ramPen)>0) THEN StringF(path,'\s/',sopt.ramPen) ELSE StringF(path,'\sNode\d/Playpen/',cmds.bbsLoc,node)
 
  fSUploading:=rFreeSpace(path)
 
  IF((fSUploading)<2048)    /* Do we have 2 megs or free space ?? */
    IF checkToolTypeExists(TOOLTYPE_NODE,node,'RAMWORK')=FALSE
      myError(9)            /* no free space */
      RETURN RESULT_SUCCESS
    ENDIF
  ENDIF
  
  IF(uLFType=0) 
      parseParams(params)
      IF(ListLen(parsedParams)>0)
          StrCopy(string,params[0])
          setProtocol(string)
      ELSE
          setProtocol('')
      ENDIF
      protocol:=loggedOnUser.protocol
      SELECT protocol
          CASE "Z"
              IF(StrLen(sopt.ramPen)>0)                     /* are we uploading to a diff device */
                  StringF(buff,'\s UPLOADING to \s..\b\n',xprTitle[loggedOnUser.xferProtocol],sopt.ramPen)
              ELSE                        /* otherwise normal upload to playpen dir */
                  StringF(buff,'\s UPLOADING....\b\n',xprTitle[loggedOnUser.xferProtocol])
              ENDIF
 
              aePuts(buff)                              /* show it to the user */
      ENDSELECT
      
      formatSpaceValue(tFS,tempstr)
      formatSpaceValue(fSUploading,tempstr2)
      StringF(string,'\s available for uploading.  \s at one time.\b\n',tempstr,tempstr2)   ->changed to indicate space in kb instead of bytes
      aePuts(string)
      aePuts('Filename lengths above 12 are not allowed.\b\n\b\n')
 
      SELECT protocol
          CASE "Z"
              zresume:=resumeStuff(tFS,fSUploading)
              IF(zresume<0) THEN RETURN zresume
              IF((zresume=0) AND strCmpi(cmd,'RG',ALL))
                  aePuts('\b\nThere are no more files to resume on.\b\n\b\n')
                  RETURN RESULT_SUCCESS
              ENDIF
              IF(zresume=0)
                  gstat:=uploadDesc()
                  IF(gstat<0)
                      cleanItUp()
                      RETURN gstat
                  ENDIF
              ENDIF
      ENDSELECT
  ENDIF
 
 
 /* if user used 'rz' it never entered the above loop so gstat never got set */
 
  /* uploading to another device?? */
  IF(StrLen(sopt.ramPen)>0) THEN StringF(path,'\s/',sopt.ramPen) ELSE StringF(path,'\sNode\d/Playpen/',cmds.bbsLoc,node)
 
  dTBT:=0
  tBT:=0
  tTTM:=0
  tTEFF:=0
  tTCPS:=0
 
  IF(beenUDd=0)
      displayUserToCallersLog(1)
      beenUDd:=1
  ENDIF
 
  protocol:=loggedOnUser.protocol
  SELECT protocol
      CASE "Z"
          zmodemReceive(path,uLFType)     /* path of upload */
  ENDSELECT
 
  aePuts('\b\n\b\nFile Uploading Complete...\b\n')
 
  peff:=NIL
  pcps:=NIL
  IF(onlineNFiles<>NIL)
      ->peff:=Div(tTEFF,onlineNFiles)
      ->pcps:=Div(tTCPS,onlineNFiles)
      peff:=zModemInfo.eff
      pcps:=zModemInfo.cps
  ENDIF
 
  IF pcps>65535 THEN pcps:=65535

  IF (pcps > loggedOnUserKeys.upCPS)
     loggedOnUserKeys.upCPS:=pcps
  ENDIF
  
  StringF(string,' \d file(s), \dk bytes, \d minute(s). \d second(s), \d cps, \d% efficiency.',onlineNFiles,Div(tBT,1024),Div(tTTM,60),Mod(tTTM,60),pcps,peff)
 
  aePuts(string)
  aePuts('\b\n\b\n')
 
  StrCopy(str,'\t')
  StrAdd(str,string)
 
  IF(onlineNFiles>0)
    callersLog(str)
    udLog(str)
    IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ON_UPLOAD',str))
      filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,NIL]:LONG
      processMci2(str,string)
      SystemTagList(string,filetags)
      END filetags
    ENDIF
    IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ASYNC_ON_UPLOAD',str))
      filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,TRUE,NIL]:LONG
      processMci2(str,string)
      SystemTagList(string,filetags)
      END filetags
    ENDIF

    IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_UPLOAD')) AND (StrLen(mailOptions.sysopEmail)>0)
      StringF(str,'\s: Ami-Express logoff notification',cmds.bbsName)
      StringF(string,'This is a notification that \s from \s has logged off\n\n',loggedOnUser.name,loggedOnUser.location)
      sendMail(str,string,TRUE, mailOptions.sysopEmail)
    ENDIF
  ELSE
    callersLog('\tUpload Failed..')
    udLog('\tUpload Failed..')
  ENDIF
 
  peff:=(Div(Mul(tTTM,3),2)+60)
  IF(onlineNFiles<1) THEN peff:=0
 
  IF(numSkipd>0)
      aePuts('The file(s) :\b\n')
      x:=0
      WHILE(x<numSkipd)
        StringF(str,'\t\t\s\b\n',skipdFiles+(x*32))
        aePuts(str)
        StringF(str,'\tSkipped \s',skipdFiles+(x*32))
          callersLog(str)
          udLog(str)
          x:=x+1
      ENDWHILE
      aePuts('\b\n\t\tSKIPPED.  They already exist or have symbols.\b\n')
  ENDIF
 
  StringF(str,'Time increased by \d mins.\b\n\b\n',Div(peff,60))
  aePuts(str)
 
  timeLimit:=timeLimit+peff    /* add time to user while online */
 
  /* dunno why cause we dont return shit */
  checkOnlineStatus()    /* can return no carrier */
 
  IF(cmds.acLvl[LVL_KEEP_UPLOAD_CREDIT]>0) THEN loggedOnUser.timeTotal:=loggedOnUser.timeTotal+(Div(peff,2))
 
  moveToLCFILES:=0
  hold:=0
  lcfile:=0
  StrCopy(list,recFileNames)
  IF(cmds.acLvl[LVL_CAPITOLS_in_FILE]=1) THEN UpperStr(list)
  
  noF:=0
  cnt:=0
 
  /* loop thru uploaded (ing) list of files & move to where they belong*/
 /* this gets the list of files uploaded */
 
  FOR x:=0 TO StrLen(list)-1
 nx:  
 
    IF(list[x]<>" ")
        str[cnt]:=list[x]
        cnt++
    ELSE
      SetStr(str,cnt)
      noF:=noF+1
      moveToLCFILES:=0
      hold:=0
      lcfile:=0
      IF(noF>onlineNFiles) THEN JUMP eit
     
      cnt:=0;   /* reset to zero */

      IF(StrLen(str)>0)
        IF((StrLen(str)>12) AND (moveToLCFILES=NIL))
          /* if we loose carrier here with a +++, it will show up as
          the file name so check for carrier now */

          StringF(fmtstr,'\s is too long a name, please rename.\b\n\b\n',str)
          aePuts(fmtstr)
          aePuts('             [------------]')
inpAgain:
          IF(logonType>=LOGON_TYPE_REMOTE)
              cstat:=checkCarrier()
              IF(cstat=FALSE)
                moveToLCFILES:=1
                JUMP clgo
              ENDIF
          ENDIF
          aePuts('\b\nNew Filename: ')
          status:=lineInput('','',12,INPUT_TIMEOUT,istr)
          IF(status<0)
            moveToLCFILES:=1
            modemOffHook()
          ENDIF
          IF(StrLen(istr)=0) THEN JUMP inpAgain 
          IF( ((istr[0]="R") AND (istr[1]="Z")) AND (StrLen(istr)= 2))
            aePuts('\b\nRZ is an invalid name for a file\b\n')
            JUMP inpAgain
          ENDIF

          x2:=0
          REPEAT          /* CHECK THE STRING */
            IF((istr[x2]=":") OR (istr[x2]="/") OR (istr[x2]="*") OR (istr[x2]=" ") OR (istr[x2]="#") OR (istr[x2] = "+") OR (istr[x2] = "?"))
               myError(10)  -> aePuts("\b\nYou may not include any special symbols\b\n");
               JUMP inpAgain
            ENDIF
            x2:=x2+1
          UNTIL x2>=StrLen(istr)

          status:=checkForFile(istr) /* should include RZ */
          IF(status=RESULT_FAILURE)
            StringF(tempstr,'The name \s is used, please rename.\b\n',istr)
            aePuts(tempstr)
            JUMP inpAgain
          ENDIF

          IF(StrLen(sopt.ramPen)>0)                       /* check Ram dir */
              StringF(tempstr,'\s/\s',sopt.ramPen,istr)
              StringF(tempstr2,'\s/\s',sopt.ramPen,str)
          ELSE
              StringF(tempstr,'\sNode\d/PlayPen/\s',cmds.bbsLoc,node,istr)
              StringF(tempstr2,'\sNode\d/PlayPen/\s',cmds.bbsLoc,node,str)
          ENDIF

          status:=Rename(tempstr2,tempstr)        /* oldstr, newstr */
          IF(status=NIL)
            StringF(tempstr2,'The name \s is used, please rename.\b\n',istr)
            aePuts(tempstr2)
            JUMP inpAgain
          ENDIF
          StrCopy(str,istr)
          IF(cmds.acLvl[LVL_CAPITOLS_in_FILE]=1) THEN UpperStr(str)  /* use upper case only */

          aePuts('\b\n')
        ENDIF    /* end if str > 12 */

        /*===================== jump here if we also lost carrier ========*/
ax:
        formatLongDate(getSystemTime(),fmtstr)

        StrCopy(odate,fmtstr)

        /* add our check for ram playpen */
        IF(StrLen(sopt.ramPen)>0) THEN StringF(str2,'\s/\s',sopt.ramPen,str) ELSE StringF(str2,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,str)

        IF((fLock:=Lock(str2,ACCESS_READ))=NIL) 
            myError(8)
            JUMP nx
        ENDIF

        IF(fBlock:=(AllocDosObject(DOS_FIB,NIL))) = NIL
            myError(11)
            UnLock(fLock)
            RETURN RESULT_FAILURE
        ENDIF
        IF( Examine(fLock,fBlock) ) THEN fsize:=fBlock.size
        IF fsize<=9999999
          StringF(fsstr,'\r\d[7]',fsize)
        ELSEIF fsize<=99999999
          StringF(fsstr,'\d',fsize)
        ELSE
          IF checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'CONVERT_TO_MB')=FALSE
            StringF(fsstr,'\d',fsize)
          ELSE
            StringF(fsstr,'\r\d[4].\dM',Shr(fsize,20),Div(fsize-Shl(Shr(fsize,20),20),104858))
          ENDIF
        ENDIF

        UnLock(fLock)
        FreeDosObject(DOS_FIB,fBlock)
->#ifdef OLDCODE
->      IF(moveToLCFILES) THEN JUMP clgo
->#endif
cinpAgain:
        IF(logonType>=LOGON_TYPE_REMOTE)
          cstat:=checkCarrier()
          IF(cstat=FALSE) 
              moveToLCFILES:=1
              JUMP clgo
          ENDIF
        ENDIF
        
        IF runSysCommand('EXAMINE',str2)
          i:=1
          REPEAT
            StringF(tempstr,'EXAMINE\d',i)
            i++
          UNTIL(runSysCommand(tempstr,str2))=FALSE
        ENDIF

        StringF(fmtstr,'\s\s',nodeWorkDir,str)   /* 11w */

        uaf:=Open(fmtstr,MODE_OLDFILE)
        IF(uaf<=0) 
                
        
->#ifdef JOE_AECODE
->             aePuts('\b\nPlease enter a description, you have eight lines for your description.')
->             aePuts('\b\nPress return alone to end.  Begin description with (/) to make upload 'Private'.\b\n')
->             aePuts('                                [--------------------------------------------]\b\n')
->#else

          StringF(buff,'\b\nEnter a description, you only have \d lines.',my_struct.max_desclines)
          aePuts(buff)

          aePuts('\b\nPress return alone to end.  Begin description with (/) to make upload ''Private''.\b\n')
          aePuts('                                [--------------------------------------------]\b\n')
->#endif
          StringF(fmtstr,'\l\s[13] \s  \s :',str,fsstr,odate)
          aePuts(fmtstr)
clgo:
          IF(moveToLCFILES=1)

            x2:=0

            StrCopy(fcomment,'LOST CARRIER ')
            StrAdd(fcomment,loggedOnUser.name)
            JUMP cNext
          ENDIF
          status:=lineInput('','',44,INPUT_TIMEOUT,fcomment)
          IF(status<0)
            moveToLCFILES:=1
            modemOffHook()
            JUMP clgo
          ENDIF
          IF(StrLen(fcomment)=0) THEN JUMP cinpAgain

          IF( ((fcomment[0]) = "R" OR (fcomment[0] = "r")) AND ((fcomment[1] = "Z") OR (fcomment[1] = "z")) AND (StrLen(fcomment) < 4) ) THEN JUMP cinpAgain

          /* stop that B0 shit */
          IF((fcomment[0] = "B") AND (fcomment[1] ="0")) THEN JUMP cinpAgain

          s:=fcomment
          cnt1:=0
          WHILE(s[0] AND (cnt1 < 20))
            IF((isascii((s[0])))=FALSE) THEN JUMP cinpAgain
            cnt1++
            s++
          ENDWHILE

          x2:=0
          REPEAT
            aePuts('                                :')
            status:=lineInput('','',44,INPUT_TIMEOUT,scomment[x2])
            IF(status<0)
              moveToLCFILES:=1
              modemOffHook()
              FOR i:=0 TO x2
                StrCopy(scomment[i],'')
              ENDFOR 
              JUMP clgo
            ENDIF
            x2:=x2+1
          UNTIL ((StrLen(scomment[x2-1])=0) OR (x2>= (my_struct.max_desclines-1)))
        ELSE
          ReadStr(uaf,fcomment)
          x2:=0
          WHILE(ReadStr(uaf,scomment[x2])<>-1) OR (StrLen(scomment[x2])>0)
            x2:=x2+1
            EXIT (x2>=(my_struct.max_desclines-1))
          ENDWHILE
          IF(uaf>0) THEN Close(uaf)
        ENDIF
cNext:
        status2:=RESULT_NOT_ALLOWED
        IF((moveToLCFILES=FALSE) AND (rzmsg=FALSE))
          StringF(fmtstr,'\b\nTesting... \s...\b\n',str)
          status2:=testFile(str,path)
          IF((status2=RESULT_NOT_ALLOWED) OR (status2=RESULT_SUCCESS)) THEN aePuts('\b\nTested Ok...')
        ENDIF
        status:=checkForFile(str)

        IF(moveToLCFILES=1) 
          status:=RESULT_LCFILES
        ELSE
          IF((fcomment[0]="/") AND (rzmsg=NIL)) THEN status:=RESULT_PRIVATE
        ENDIF

        IF(status2=RESULT_FAILURE)            /* Move to a Hold AREA */
            hold:=1
            StringF(tempstr,'Requires review, possibly bad format\b\n\t  Moving to \s''s private Directory.\b\n\b\n',cmds.sysopName)
            aePuts(tempstr)
            JUMP move_It
        ENDIF

        IF(status=RESULT_FAILURE)             /* Move to a Hold AREA */
            IF(foundDupe)              /* 11w */
                StringF(tempstr,'\b\nFile already exists, moving to \s''s private directory\b\n',cmds.sysopName)
                aePuts(tempstr)
                hold:=1
            ENDIF
        ENDIF
        
        IF(status=RESULT_SUCCESS)            /* Move to Upload AREA */
          hold:=NIL
          IF creditAccountTrackUploads(loggedOnUser)
            loggedOnUser.uploads:=loggedOnUser.uploads+1
          ENDIF
        ENDIF
        IF(status=RESULT_LCFILES)            /* 11w */
          lcfile:=1
          rzmsg:=NIL
          aePuts('\b\nCarrier lost, moving to lost carrier directory.\b\n')
        ENDIF

        IF(status=RESULT_PRIVATE)             /* Private Upload */
          hold:=1
          rzmsg:=NIL
          StringF(tempstr,'\b\nMoving to \s''s private directory.\b\n\b\n',cmds.sysopName)
          aePuts(tempstr)
        ENDIF
        
        IF(rzmsg)
           aePuts('\b\nMoving to message base file directory.\b\n')
        ENDIF
move_It:     /* gets here if lostcarrier, and file is complete but not when file is incomplete */

        IF(hold OR lcfile OR rzmsg)       /* 11w added lcfile */
          IF(lcfile) THEN StringF(tempstr2,'\sLCFILES/\s',currentConfDir,str)
          IF(hold) THEN StringF(tempstr2,'\sHOLD/\s',currentConfDir,str)
          IF(rzmsg) THEN StringF(tempstr2,'\sF\d/\s',msgBaseLocation,mailHeader.msgNumb,str)
          
          IF(StrLen(sopt.ramPen)>0)
            StringF(tempstr,'\s/\s',sopt.ramPen,str)
          ELSE
            StringF(tempstr,'\sNode\d/PLAYPEN/\s',cmds.bbsLoc,node,str)
          ENDIF
            
          status:=0
          WHILE((StrLen(FilePart(tempstr2))<35) AND (status=FALSE))
            status:=Rename(tempstr,tempstr2)
            IF(status=FALSE)
              status:=fileCopy(tempstr,tempstr2)
              IF(status=FALSE) THEN StrAdd(tempstr2,'_')
              IF(status)
                SetProtection(tempstr,FIBF_OTR_DELETE)
                DeleteFile(tempstr) 
              ENDIF
            ENDIF
          ENDWHILE
            
          StrCopy(tempstr,'\tUpload ')
          IF(status=NIL)
            StringF(tempstr2,'WARNING!\b\nUnable to move file!\b\n')
            aePuts(tempstr2)
            StrAdd(tempstr,'unable to be ')
          ENDIF
          StringF(tempstr3,'moved to \s',tempstr2)
          StrAdd(tempstr,tempstr3)
          callersLog(tempstr)
        ELSE
          moveFile(str,fsize)
        ENDIF

        sysopULStats(hold)
        /* Add Uploaded Bytes to Users Account */
        IF((hold=NIL) AND (lcfile=NIL) AND (rzmsg=NIL)) 
          IF creditAccountTrackUploads(loggedOnUser) 
            loggedOnUser.bytesUpload:=loggedOnUser.bytesUpload+fsize
         ENDIF
        ENDIF

        /* Build the first line to send to upload dir */
        IF(lcfile AND (StrLen(str) > 12))
          StringF(fmtstr,'\s \s  \s  \s\n',str,fsstr,odate,fcomment)
        ELSE
          StringF(fmtstr,'\l\s[13] \s  \s  \s\n',str,fsstr,odate,fcomment)
        ENDIF

        IF(StrLen(str) < 13)       /* for big file name on lost carrier */
           IF(checksym)
             fmtstr[13]:=checksym
           ELSE               
             IF(status2=RESULT_FAILURE) THEN fmtstr[13]:="F"
             IF(status2=RESULT_SUCCESS) THEN fmtstr[13]:="P"
             IF(status2=RESULT_NOT_ALLOWED) THEN fmtstr[13]:="N"
           ENDIF
        ENDIF
        IF(foundDupe)
          fmtstr[13]:="D"
          foundDupe:=0
        ENDIF
        
        IF((hold=NIL) AND (lcfile=NIL)) 
          IF(rzmsg=FALSE) 
            StrCopy(ray,currentConfDir);
            StrAdd(ray,'DIR')
            StringF(ray2,'\d',maxDirs)
            StrAdd(ray,ray2)
          ELSE
            StringF(ray,'\sF\d/\s.dis',msgBaseLocation,mailHeader.msgNumb,str)
          ENDIF
        ELSE
          StrCopy(ray,currentConfDir)
          IF(lcfile)
            StrAdd(ray,'LCFILES/')
            StrAdd(ray,purgeScanNM)
            StrAdd(ray,'.lc')
          ELSE
             StrAdd(ray,'HOLD/HELD')
          ENDIF
        ENDIF

        f:=Open(ray,MODE_READWRITE)
        Seek(f,0,OFFSET_END)
        fileWrite(f,fmtstr)
        x3:=0;
        WHILE(x2)
            /* Print the comment lines */
            IF(StrLen(scomment[x3])>0)
              StringF(tempstr,'                                 \s\n',scomment[x3])
              fileWrite(f,tempstr)
              StrCopy(scomment[x3],'')
              x3:=x3+1
            ENDIF
            x2:=x2-1
        ENDWHILE
        IF(checkToolTypeExists(TOOLTYPE_NODE,node,'SENTBY_FILES'))   /* Print the Sent by: line */
          StringF(tempstr,'                                 Sent by: \s\n',loggedOnUser.name)
          fileWrite(f,tempstr)  
        ENDIF
        Close(f)
      ENDIF   /*if strlen > 1 */ 
    ENDIF
  ENDFOR       /* else */
   
 eit:
 ->purgeLine();
 
  cleanPlayPen()
  
  cleanItUp()
 
 /* we get here after lcfile but gugued*/
  IF(lcfile=FALSE) THEN bytesADL:=bytesADL+tBT     /* dont add bytes if files moved to LCFILES DIR */
 
  displayULStats(loggedOnUser)          /* Show User stats.. Num Dnloads, uploads */
  aePuts('\b\n')
 
  mstat:=checkOnlineStatus()
  IF(mstat<0)
    RETURN mstat
  ENDIF
 
  IF(uLFType=FALSE)     /* nor a rz upload */
    IF(gstat=2)
      RETURN pGoodbye()
    ENDIF
  ENDIF
 
ENDPROC RESULT_SUCCESS

PROC creditAccountEnabled(hoozer: PTR TO user)
  IF hoozer.creditDays=0 THEN RETURN FALSE
  IF getSystemTime()>(hoozer.creditStartDate+Mul(hoozer.creditDays,86400)) THEN RETURN FALSE
ENDPROC TRUE

PROC creditAccountTrackDownloads(hoozer: PTR TO user)
  IF (creditAccountEnabled(hoozer)=FALSE) THEN RETURN TRUE
  IF (hoozer.creditTracking AND TRACK_DOWNLOADS_BIT) THEN RETURN TRUE
ENDPROC FALSE

PROC creditAccountTrackUploads(hoozer: PTR TO user)
  IF creditAccountEnabled(hoozer)=FALSE THEN RETURN TRUE
  IF (hoozer.creditTracking AND TRACK_UPLOADS_BIT) THEN RETURN TRUE
ENDPROC FALSE

PROC downloadPrompt(ratioType, mins, bytes, filespec, files, str:PTR TO CHAR)

 IF(ratioType=0) THEN StringF(str,'\b\n\d mins, \d bytes, Filespec(\d): ',mins,bytes,filespec)
 IF(ratioType=2) THEN StringF(str,'\b\n\d mins, \d files, Filespec(\d): ',mins,files,filespec)
 IF(ratioType=1) THEN StringF(str,'\b\n\d mins, \d bytes, \d files, Filespec(\d): ',mins,bytes,files,filespec)
ENDPROC

PROC beginDLF(cmdcode,params)      /* begin downloading */
  DEF stat
  DEF str[3072]:STRING
  stat:=downloadAFile(str,cmdcode,params)
ENDPROC stat


PROC downloadAFile(str: PTR TO CHAR, cmdcode: PTR TO CHAR, params)
  DEF string[300]:ARRAY OF CHAR
  DEF tsec,min,secs,x,status,mystat,nad,proto
  DEF peff,pcps,bad,tbad
  
 -> DEF tempStr[255]:STRING
 ->extern BYTE FreeDownloads,BeenUDd
 
  proto:=0
  nad:=0
  numFiles:=0
  freeDFlag:=0
  StrCopy(rFinal,'')
  StrCopy(str,'')
 
  aePuts('\b\n')
  IF(maxDirs=0)
    myError(5) ->Sorry()
    RETURN RESULT_FAILURE
  ENDIF

  IF (displayScreen(SCREEN_DOWNLOAD)) 
    doPause()
    aePuts('\b\n')
  ENDIF

  tfsize:=0
  dtfsize:=0

  displayULStats(loggedOnUser)              /* Show User stats.. Num Dnloads, uploads */

  tbad:=bytesADL    /* User Daily Limit of bytes to dnload */
  IF(loggedOnUser.secLibrary<>0)     /* Dont have a zero ratio */
    IF((loggedOnUser.secBoard>0) AND (creditAccountEnabled(loggedOnUser)=FALSE))
      nad:=(loggedOnUser.secLibrary*(loggedOnUser.uploads+1))-loggedOnUser.downloads
      StringF(string,'Files Avail before UL : \d\b\n',nad)
      aePuts(string)
      IF(nad<1)
          exceedRatio()
          RETURN RESULT_SUCCESS
      ENDIF
    ENDIF
    IF(loggedOnUser.secBoard<2)
      bad:=(loggedOnUser.secLibrary*loggedOnUser.bytesUpload)-loggedOnUser.bytesDownload
      StringF(string,'Bytes Avail before UL : \d\b\n',bad)
      aePuts(string)
      IF(bad<1)
        exceedRatio()
        RETURN RESULT_SUCCESS
      ENDIF
      IF (bad<bytesADL) THEN tbad:=bad
    ENDIF
  ELSE
    aePuts('Download to Upload Ratio Disabled.\b\n')
  ENDIF
/*
// We can replace this with User.Protocol = 'Z'

 mystat=CommandSplit()

 if(mystat>1&&(strlen(Command[1])==1)) {
  PROTO=2
      strcpy(str,Command[1])
  SetProtocol(str)
  } else  {
  str[0]=0
      SetProtocol(str)
  }*/


  aePuts('Space between filenames.  ')
  IF checkSecurity(ACS_FILE_EXPANSION)=FALSE THEN aePuts('No ')
  aePuts('Wildcards permitted.\b\n')
  ->AEPutStr("      Zmodem Uploading & Downloading only\b\n")
  StrCopy(str,'')
  sysopdl:=FALSE

  IF (strCmpi(cmdcode,'DS',ALL)) AND (checkSecurity(ACS_SYSOP_DOWNLOAD))
    sysopdl:=TRUE
    StringF(string,'\tSYSOP DOWNLOAD: \s',cmdcode)
    callersLog(string)
    udLog(string)
    IF(StrLen(params)>0) THEN StrCopy(str,params)
  ELSE
    StrCopy(str,'')
    IF(mystat>1)
      StrCopy(str,params)
      StrAdd(str,' ')
    ENDIF
    IF(StrLen(flaglist)>0) THEN StrAdd(str,flaglist)
  
  ENDIF


 IF(StrLen(str)<>0) THEN JUMP skip1
 arestart:
 
 WHILE TRUE
   tsec:=Div(Div(dtfsize,onlineBaud),10)
   min:=tsec/60
   IF(((Div(timeLimit,60))-min)<0)
     aePuts('Not enough time for requested downloads.\b\n\b\n')
     RETURN RESULT_SUCCESS
   ENDIF
 
  IF(((tbad-tfsize)<0) AND (loggedOnUser.secBoard<2) AND (loggedOnUser.secLibrary<>0) AND (creditAccountEnabled(loggedOnUser)=FALSE))
    aePuts('Not enough free bytes for requested downloads.\b\n\b\n')
    RETURN RESULT_SUCCESS
  ENDIF
  
  IF(nad<freeDFlag) AND (loggedOnUser.secBoard>0) AND (loggedOnUser.secLibrary<>0) AND (creditAccountEnabled(loggedOnUser)=FALSE)
    aePuts('Not enough free files for requested number of downloads.\b\n\b\n')
    RETURN RESULT_SUCCESS
  ENDIF
  
  IF((nad=freeDFlag) AND ((loggedOnUser.secLibrary<>0) AND (loggedOnUser.secBoard>0))) THEN JUMP astart

  IF((loggedOnUser.secLibrary=0) OR (creditAccountEnabled(loggedOnUser)))
      StringF(str,'\b\n\d mins, (Ratio Disabled), Filespec(\d): ',(Div(timeLimit,60))-min,(numFiles+1))
  ELSE
      downloadPrompt(loggedOnUser.secBoard,(Div(timeLimit,60))-min,tbad-tfsize,(numFiles+1),nad-freeDFlag,str)
  ENDIF
  aePuts(str)

  status:=lineInput('','',200,INPUT_TIMEOUT,str)
  IF(status<0) THEN RETURN RESULT_NO_CARRIER
  
  IF((StrLen(str)=0) AND (numFiles=0))
    aePuts('\b\n')
    RETURN RESULT_SUCCESS
  ENDIF
  
  IF(StrLen(str)=0) THEN JUMP astart
  IF((((str[0]="q") OR (str[0]="Q")) OR ((str[0]="a") OR (str[0]="A"))) AND (StrLen(str)=1))
    aePuts('Aborting...\b\n\b\n')
    RETURN RESULT_SUCCESS
  ENDIF

  skip1:
  aePuts('\b\nChecking...\b\n')
  IF(sysopdl=FALSE) 
    FOR x:=0 TO StrLen(str)-1
      IF((str[x]=":") OR (str[x]="/") OR
        (((str[x]="?") OR (str[x]="#") OR (str[x]="*")) AND (checkSecurity(ACS_FILE_EXPANSION)=FALSE)))
        aePuts('\b\nYou may not include any special symbols\b\n')
        JUMP arestart
      ENDIF
    ENDFOR
    IF((str[0]="?") OR (str[0]="*"))
      aePuts('\b\nToo ambigious, start with at least one character.\b\n')
      JUMP arestart
    ENDIF
  ELSE
    FOR x:=0 TO StrLen(str)-1
      IF((str[x]="?") OR (str[x]="*") OR (str[x]="#"))
        aePuts('\b\nSysop download doesn''t support wildcards\b\n')
        JUMP arestart
      ENDIF
    ENDFOR 
  ENDIF
  StrAdd(str,' ')
  status:=checklist(str,rFinal)
  IF(status=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
 ENDWHILE


 astart:

 IF(numFiles=0) THEN RETURN RESULT_NO_CARRIER
 
 IF loggedOnUser.protocol="Z"
    aePuts('\b\nZmodem ')
 ELSEIF loggedOnUser.protocol="C"
    aePuts('\b\nXmodem/CRC ')
 ENDIF
   
 aePuts(' Batch Download Estimate:\b\n')
  astart2:
  tsec:=Div(Div(dtfsize,onlineBaud),10)
  min:=tsec/60
  secs:=tsec-(min*60)
  StringF(str,'   \d files, \dk bytes, \d mins \d secs\b\n',numFiles,Div(dtfsize,1024),min,secs)
  aePuts(str)

 IF(tbad<tfsize)
   aePuts('Exceeded bytes limit.\b\n\b\n')
   RETURN RESULT_SUCCESS
 ENDIF

  IF((my_struct.maxdbytes < tfsize) OR ((my_struct.sessiondbytes+dtfsize) > my_struct.maxdbytes))
    aePuts('Exceeded BBS Max Download Limit!!\b\n\b\n')
    RETURN RESULT_SUCCESS
  ENDIF

  IF(min>(Div(timeLimit,60)))
    aePuts('  Insufficent time for transfer.\b\n\b\n')
    RETURN RESULT_SUCCESS
  ENDIF
  
  aePuts('\b\nLAST CHANCE!   (Enter) to Start, (G)oodbye after transfer, (A)bort? ')
  REPEAT
      mystat:=checkOnlineStatus()
      IF(mystat<0) THEN RETURN mystat
      mystat:=readChar(INPUT_TIMEOUT)

      IF(mystat<(-1)) THEN RETURN RESULT_NO_CARRIER

      IF((mystat=65) OR (mystat=97))
        aePuts('Abort!\b\n\b\n')
        RETURN RESULT_SUCCESS
      ENDIF
      IF (((status="l") OR (status="L")) AND (logonType<LOGON_TYPE_REMOTE))
         localUpload:=TRUE
         status:=13
         JUMP breakd
      ENDIF
  UNTIL (mystat=13) OR (mystat=71) OR (mystat=103)
  breakd:
  
  IF (mystat<>13) THEN aePuts('Goodbye!\b\n\b\n') ELSE aePuts('\b\n\b\n')
  

sysopDL:

 dTBT:=0
 tBT:=0
 tTTM:=0
 tTEFF:=0
 tTCPS:=0

  IF(beenUDd=FALSE)
    displayUserToCallersLog(1)
    beenUDd:=TRUE
  ENDIF

 status:=downloadFile(rFinal)

 IF(status<>0) THEN StrCopy(flaglist,'')

 aePuts('\b\n\b\nFile transfer Completed.\b\n')
 peff:=NIL
 pcps:=NIL
 IF(onlineNFiles<>0)
      ->peff:=Div(tTEFF,onlineNFiles)
      ->pcps:=Div(tTCPS,onlineNFiles)
      peff:=zModemInfo.eff
      pcps:=zModemInfo.cps
 ENDIF
->// (RTS) added dnload cps rate Fri Mar 27 13:13:29 1992

 IF pcps>65535 THEN pcps:=65535

 IF(pcps > loggedOnUserKeys.dnCPS)
    loggedOnUserKeys.dnCPS:=pcps
        /* is this baud higher then max cps up ? */
 ENDIF
 
 IF(status=0)
   IF(zModemInfo.filesize=zModemInfo.recPos)
      tBT:=tBT+zModemInfo.filesize
      dTBT:=dTBT+zModemInfo.filesize
      donf++
      callersLog('\tIncomplete 100% Transfer, accumulating Maximum Bytes Downloaded')
      udLog('\tIncomplete 100% Transfer, accumulating Maximum Bytes Downloaded')
   ENDIF
      
 ENDIF
 
 StringF(string,' \d files, \dk bytes, \d minutes \d seconds \d cps, \d% efficiency at \d',onlineNFiles,Div(tBT,1024),Div(tTTM,60),Mod(tTTM,60),pcps,peff,onlineBaud)

  IF(freeDownloads=FALSE)
    my_struct.sessiondbytes:=my_struct.sessiondbytes+dTBT   /* add dnloaded bytes to totalsession bytes */
    IF creditAccountTrackDownloads(loggedOnUser)
      loggedOnUser.bytesDownload:=loggedOnUser.bytesDownload+dTBT
      loggedOnUser.downloads:=loggedOnUser.downloads+donf
    ENDIF
  ENDIF
  loggedOnUser.dailyBytesDld:=loggedOnUser.dailyBytesDld+dTBT
  bytesADL:=bytesADL-dTBT

  aePuts(string)
  aePuts('\b\n\b\n')

  StrCopy(str,'\t')
  StrAdd(str,string)
  
  IF(onlineNFiles>0)
     callersLog(str)
     udLog(str)
  ELSE
    callersLog('\tDownload Failed..')
    udLog('\tDownload Failed..')
  ENDIF

  displayULStats(loggedOnUser)          /* Show User stats.. Num Dnloads, uploads */
  aePuts('\b\n')

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  IF((mystat=71) OR (mystat=103)) THEN RETURN(pGoodbye())
ENDPROC RESULT_SUCCESS
  
PROC ccom()
  DEF i,i2,stat
  DEF str[81]:STRING
  DEF display_time[30]:STRING
  DEF string[200]:STRING
  DEF date[20]:STRING
  DEF buff[255]: STRING
 
  formatLongDateTime(getSystemTime(),display_time)
  
  StringF(str,'\tOperator Paged at (\s)',display_time)
  callersLog(str)
 
  conPuts('\b\nF1 Toggles chat\b\n',-1)
 
  /* show our page sign to user */
  StringF(buff,'\s\b\n\b\nPaging \s (CTRL-C to Abort). .',display_time,cmds.sysopName)
  aePuts(buff)
  FOR i:=0 TO 19 
    DisplayBeep(NIL)
    aePuts(' .')
    FOR i2:=1 TO 50
      Delay(1)
      IF(logonType>=LOGON_TYPE_REMOTE)
        stat:=checkCarrier()
        IF(stat=FALSE) THEN RETURN RESULT_NO_CARRIER
      ENDIF
      IF(checkInput()) 
        stat:=readChar(1)
        IF(chatF=1)
          aePuts('\b\n\b\n')
          RETURN RESULT_SUCCESS
        ENDIF
        IF(stat=3)
            aePuts('Aborted!\b\n\b\n')
          RETURN RESULT_SUCCESS
        ENDIF
      ENDIF
    ENDFOR
  ENDFOR
 
  aePuts('\b\n\b\nThe Sysop has been paged\b\n')
  aePuts('You may continue using the system\b\n')
  aePuts('until ')
  aePuts(cmds.sysopName)
  aePuts(' answers your request.\b\n\b\n')
  statMessage(1,1,'                            ')
  StringF(str,'[37m\s[0m',loggedOnUser.name)
  statMessage(1,1,str)
 
ENDPROC RESULT_SUCCESS

PROC viewAFile(cmdcode,params)
  DEF stat,x
  DEF path[255]:STRING, final[255]:STRING, fn[100]:STRING, clog[100]:STRING
  DEF f,ft=NIL
  DEF drivenum=1
  DEF tempStr[255]:STRING
  
  nonStopDisplayFlag:=FALSE
  lineCount:=0

  aePuts('\b\n')
  IF(maxDirs=0)
  	aePuts('No files available in this conference.\b\n\b\n')
  	RETURN RESULT_FAILURE
  ENDIF
  
  parseParams(params)
  
  nonStopDisplayFlag:=paramsContains('NS')

  IF ListLen(parsedParams)>0
    StrCopy(fn,parsedParams[0])
    JUMP some
  ENDIF
  
  aePuts('Enter filename of file to view? ')
  stat:=lineInput('','',40,INPUT_TIMEOUT,fn)
  IF(stat<0) THEN RETURN RESULT_NO_CARRIER

  IF(StrLen(fn)=0)
    aePuts('\b\n')
    RETURN RESULT_SUCCESS
  ENDIF
  
  
some:
  StrCopy(path,currentConfDir)
  IF(path[StrLen(path)-1]="/") THEN SetStr(path,StrLen(path)-1)
  JUMP skipMe

skipToIt:
  	StringF(tempStr,'File \s not found.\b\n\b\n',path)
  	aePuts(tempStr)
  	RETURN RESULT_FAILURE
  
skipMe:
  
  IF((checkSecurity(ACS_SYSOP_VIEW)) AND (strCmpi(cmdcode,'VS',ALL)))
    IF(findAssign(fn))
      StrCopy(path,fn)
      JUMP skipToIt
    ENDIF

  	f:=Open(fn,MODE_OLDFILE)
  	IF(f<=0)
  		StrCopy(path,fn)
      JUMP skipToIt
    ENDIF
    Close(f)
  	StringF(tempStr,'\tSysopView \s',fn)
  	callersLog(tempStr)
  	StrCopy(final,fn)
    JUMP skipit
  ENDIF
  
  FOR x:=0 TO StrLen(fn)-1
  	IF((fn[x]=":") OR (fn[x]="/") OR (fn[x]="*") OR (fn[x]="@"))
  		aePuts('You may not include any special symbols\b\n\b\n')
  		RETURN RESULT_FAILURE
    ENDIF
  ENDFOR
  
  
  StringF(path,'DLPATH.\d',drivenum++)
  WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,path))

    StrCopy(final,path)
  	StrAdd(final,fn)
skipit:
  	ft:=Open(final,MODE_OLDFILE)
  	IF(ft>0)
  /**************** ADDED SECURITY FOR VS ******************
      CODE REVISION BY JOSEPH HODGE
   *********************************************************/
      IF restricted(final)
         aePuts('\b\nAttempt to read RESTRICTED file denied\b\n')
         aePuts('Updating Callerslog\b\n')
         StringF(clog,'\t\tAttempt to read RESTRICTED file [\s]',fn)
         callersLog(clog)
         Close(ft)
        RETURN RESULT_FAILURE
      ENDIF
        WHILE ((ReadStr(ft,tempStr))<>-1) OR (StrLen(tempStr)>0)
  				IF((tempStr[0]>128) OR (tempStr[1]>128) OR (tempStr[2]>128))
  					Close(ft)
  					aePuts('\b\nThis file is not a text file.\b\n\b\n')
  					RETURN RESULT_FAILURE
  				ENDIF
  				aePuts(tempStr)
  				aePuts('\b\n')
          IF(stat:=checkForPause())
            Close(ft)
            aePuts('\b\n')
            RETURN stat
          ENDIF
          IF(checkInput())
            stat:=readChar(1)
            SELECT stat
              CASE 23 /* Pause */
                stat:=readChar(INPUT_TIMEOUT)
                IF(stat<0)
                  Close(ft)
                  RETURN RESULT_NO_CARRIER
                ENDIF
              CASE 3 /* ^C */
                aePuts('**Break\b\n\b\n')
                Close(ft)
                RETURN RESULT_FAILURE
            ENDSELECT
          ENDIF
  		  ENDWHILE
  			Close(ft)
  			aePuts('\b\n\b\n')
  			RETURN RESULT_SUCCESS
  	  ENDIF
      EXIT ft<>NIL
      StringF(path,'DLPATH.\d',drivenum++)
    ENDWHILE
  aePuts('File not found.\b\n\b\n')
ENDPROC RESULT_SUCCESS

PROC findLastAccount()
  DEF fh,size

  IF((fh:=Open(userDataFile,MODE_OLDFILE)))<=0 THEN RETURN RESULT_FAILURE

  Seek(fh,0,OFFSET_END)
  size:=Seek(fh,0,OFFSET_CURRENT)
  Close(fh)
ENDPROC Div(size,SIZEOF user)

PROC numberInputNoDefault()
  DEF tempStr[20]:STRING
  lineInput('','',5,INPUT_TIMEOUT,tempStr)
ENDPROC Val(tempStr)

PROC numberInput(n)
  DEF tempStr[20]:STRING
  StringF(tempStr,'\d',n AND 65535)
  lineInput('',tempStr,5,INPUT_TIMEOUT,tempStr)
ENDPROC Val(tempStr)

PROC longNumberInput(n)
  DEF tempStr[20]:STRING
  StringF(tempStr,'\d',n)
  lineInput('',tempStr,10,INPUT_TIMEOUT,tempStr)
ENDPROC Val(tempStr)

PROC uucpNumberInput(n)
  DEF tempStr[4]:STRING
  StringF(tempStr,'\d',n)
  lineInput('',tempStr,1,INPUT_TIMEOUT,tempStr)
ENDPROC Val(tempStr)

PROC editInfo(which:LONG, hoozer:PTR TO user, hoozer2:PTR TO userKeys, hoozer3: PTR TO userMisc,f6)

  DEF flag, command
  DEF tempStr[255]:STRING
  DEF temp,stat,i

  nofkeys:=1
  displayAccount(which,hoozer,hoozer2,hoozer3,f6)
  StrCopy(tempStr,hoozer.name)
  UpperStr(tempStr)
  strCpy(hoozer2.userName,tempStr,31)
 
 	REPEAT
 	 	flag:=0
 	 	command:=readChar(INPUT_TIMEOUT)
 	 	IF(command<0) THEN RETURN command
    command:=charToUpper(command)
    IF (command>="1") AND (command<="8")
      StringF(tempStr,'\c ',command)
      stat:=Val(tempStr)
      aePuts('[JPreset ')
      aePuts(tempStr)
      aePuts('\b\n')
      hoozer.newUser:=0
      hoozer.confRJoin:=readToolTypeInt(TOOLTYPE_PRESET,stat,'PRESET.CONFRJOIN')
      hoozer.secStatus:=readToolTypeInt(TOOLTYPE_PRESET,stat,'PRESET.ACCESS')
      hoozer.secLibrary:=readToolTypeInt(TOOLTYPE_PRESET,stat,'PRESET.RATIO')
      hoozer.timeLimit:=readToolTypeInt(TOOLTYPE_PRESET,stat,'PRESET.TIME_LIMIT')
      hoozer.secBoard:=readToolTypeInt(TOOLTYPE_PRESET,stat,'PRESET.RATIO_TYPE')
      readToolType(TOOLTYPE_PRESET,stat,'PRESET.AREA',tempStr)
      strCpy(hoozer.conferenceAccess,tempStr,10)
      hoozer.dailyBytesLimit:=readToolTypeInt(TOOLTYPE_PRESET,stat,'PRESET.DAILY_BYTE_LIMIT')
      hoozer.timeUsed:=0
      hoozer.timeTotal:=hoozer.timeLimit
      hoozer2.upCPS:=0
      hoozer2.dnCPS:=0
      ->//(RTS)             hoozer2->baud_rate = 0
      saveAccount(hoozer,hoozer2,hoozer3,0,0)
      displayAccountInfo(which,hoozer,hoozer2,hoozer3,f6)
    ENDIF
 	 	SELECT command
 			CASE "X"         /* NO-SAVE */
 				aePuts('[JNo-Save\b\n')
 				flag:=1
 			CASE "\t"
 				flag:=2
 			CASE 177                    /* DELETE */
 				aePuts('[JDelete\b\n')
 				stat:=which
 				hoozer.slotNumber:=0
 				hoozer2.number:=0
 
              /* changed from ForceSave_Account Thu Jan 30 04:17:48 1992 */
 				stat:=saveAccount(hoozer,hoozer2,hoozer3,stat,1)
 				IF(stat<>RESULT_SUCCESS) THEN  aePuts('Can''t Save account\b\n')
        deleteConfAccess(stat)
 				displayAccountInfo(which,hoozer,hoozer2,hoozer3,f6)
 				flag:=0
 			CASE " "
 				displayAccountInfo(which,hoozer,hoozer2,hoozer3,f6)
 			CASE "+"
 				IF(onlineEdit=FALSE)
 					which:=which+1
 					IF(loadAccount(which,hoozer,hoozer2,hoozer3)<>RESULT_FAILURE)
 						displayAccountInfo(which,hoozer,hoozer2,hoozer3,f6)
 					ELSE
 						which:=1
 						loadAccount(which,hoozer,hoozer2,hoozer3)
 						displayAccountInfo(which,hoozer,hoozer2,hoozer3,f6)
 					ENDIF
 				ENDIF
 			CASE "-"
 				IF(onlineEdit=FALSE)
 					which:=which-1
 					IF(which<1) THEN which:=findLastAccount()
 					loadAccount(which,hoozer,hoozer2,hoozer3)
 					displayAccountInfo(which,hoozer,hoozer2,hoozer3,f6)
 				ENDIF
 			CASE "!" /* Credit Maintenance */
        creditMaintenance(which,hoozer,hoozer2,hoozer3,f6)
        displayAccount(which,hoozer,hoozer2,hoozer3,f6)
        flag:=0
 			CASE "@" /* Conference Accounting */
        IF checkToolTypeExists(TOOLTYPE_ACCESS,hoozer.secStatus,ListItem(securityNames,ACS_CONFERENCE_ACCOUNTING))
          conferenceAccounting(which,hoozer,hoozer2,hoozer3,f6)
          displayAccount(which,hoozer,hoozer2,hoozer3,f6)
        ENDIF
        flag:=0
 			CASE "~" /* SAVE */
 				aePuts('[JSave\b\n')
        hoozer.newUser:=0
        displayAccountInfo(which,hoozer,hoozer2,hoozer3,f6)
 				IF(hoozer.slotNumber=0)
 					hoozer2.number:=0
 					stat:=saveAccount(hoozer,hoozer2,hoozer3,which,1) /* 1 = FORCE SAVE */
 
 					IF(stat<>RESULT_SUCCESS) THEN aePuts('Can''t Save account\b\n')
 				ELSE
 					hoozer2.number:=hoozer.slotNumber
                  /* save using Slot_number */
 					stat:=saveAccount(hoozer,hoozer2,hoozer3,0,0) /* Not forced */
 					IF(stat<>RESULT_SUCCESS) THEN aePuts('Can''t Save account\b\n')
 				ENDIF

        IF logonType>=LOGON_TYPE_REMOTE
          StringF(tempStr,'\tREMOTE Account Maintenance on Account \d',hoozer.slotNumber)
        ELSE
          StringF(tempStr,'\tLOCAL  Account Maintenance on Account \d',hoozer.slotNumber)
        ENDIF
        callersLog(tempStr)

 			CASE "9"                       /* RE-ACTIVATE */
 				aePuts('[JRe-Activate\b\n')
 				hoozer.slotNumber:=which
 				flag:=0
 			CASE "A"             /* NAME */
 				aePuts('[2;10H')
        StrCopy(tempStr,hoozer.name)
 			  lineInput('',tempStr,30,INPUT_TIMEOUT,tempStr)
        strCpy(hoozer.name,tempStr,31)
 				UpperStr(tempStr)
 				strCpy(hoozer2.userName,tempStr,31)
 				flag:=0
 			CASE "B"             /* Real Name */
 				aePuts('[2;56H')
        StrCopy(tempStr,hoozer3.realName)
 				lineInput('',tempStr,25,INPUT_TIMEOUT,tempStr)
 				strCpy(hoozer3.realName,tempStr,26)
 				flag:=0
 			CASE "C"             /* Location */
 				aePuts('[3;10H')
        StrCopy(tempStr,hoozer.location)
 				lineInput('',tempStr,29,INPUT_TIMEOUT,tempStr)
 				strCpy(hoozer.location,tempStr,30)
 				flag:=0
 			CASE "D" /* PASS */
        IF((logonType>=LOGON_TYPE_REMOTE) AND (f6=FALSE))
          IF(loggedOnUser.slotNumber=1)
 				    aePuts('[3;56H')

            StrCopy(tempStr,'')
            StrAdd(tempStr,'         ')
            FOR i:=1 TO 9
              strAddChar(tempStr,8)
            ENDFOR
            aePuts(tempStr)
 				    lineInput('','',50,INPUT_TIMEOUT,tempStr)
            UpperStr(tempStr)
            hoozer.pwdHash:=calcPasswordHash(tempStr)
          ENDIF
        ELSE
          StrCopy(tempStr,'[3;56H')
          StrAdd(tempStr,'         ')
          FOR i:=1 TO 9
            strAddChar(tempStr,8)
          ENDFOR
          aePuts(tempStr)
 				  lineInput('','',50,INPUT_TIMEOUT,tempStr)
          UpperStr(tempStr)
          hoozer.pwdHash:=calcPasswordHash(tempStr)
        ENDIF
 				flag:=0
 			CASE "E" /* Phone number */
 				aePuts('[4;21H')
        StrCopy(tempStr,hoozer.phoneNumber)
 				lineInput('',tempStr,12,INPUT_TIMEOUT,tempStr)
        strCpy(tempStr,hoozer.phoneNumber,13)
 				flag:=0
 			CASE "F" /* conference access */
 				aePuts('[4;56H')
        StrCopy(tempStr,hoozer.conferenceAccess)
 				lineInput('',tempStr,9,INPUT_TIMEOUT,tempStr)
        strCpy(hoozer.conferenceAccess,tempStr,10)
        flag:=0
 			CASE "G" /* RATIO */
 				aePuts('[5;21H')
 				hoozer.secLibrary:=numberInput(hoozer.secLibrary)
 				flag:=0
 			CASE "H" /* SEC_Level */
        IF((logonType>=LOGON_TYPE_REMOTE) AND (f6=FALSE))
          IF(loggedOnUser.slotNumber=1)
 				    aePuts('[5;56H')
 				    hoozer.secStatus:=numberInput(hoozer.secStatus)
 				  ENDIF
        ELSE
 				  aePuts('[5;56H')
 				  hoozer.secStatus:=numberInput(hoozer.secStatus)
        ENDIF
 				flag:=0
 			CASE "I"  /* Ratio Type */
 				aePuts('[6;21H')
 				hoozer.secBoard:=numberInput(hoozer.secBoard)
        IF((hoozer.secBoard<0) OR (hoozer.secBoard > 2)) 
          sendBELL()
          hoozer.secBoard:=0
        ENDIF
        StringF(tempStr,'[6;1H[33mG> [32mRatio Type ....[36m:[0m \l\d[5]',hoozer.secBoard)
        aePuts(tempStr)
        IF(hoozer.secBoard=0) THEN aePuts(' [32m<-[33mByte[32m)[0m')
        IF(hoozer.secBoard=1) THEN aePuts(' [32m<-[33mB/F[32m)[0m ')
        IF(hoozer.secBoard=2) THEN aePuts(' [32m<-[33mFile[32m)[0m') 
 				flag:=0
 			CASE "J"                 /* conference ReJoin */
 				aePuts('[6;56H')
 				hoozer.confRJoin:=numberInput(hoozer.confRJoin)
        flag:=0
 			CASE "K"                 /* UPLOADS */
 				aePuts('[7;21H')
 				hoozer.uploads:=numberInput(hoozer.uploads)
 				flag:=0
 			CASE "L" /* MESSAGES_POSTED */
 				aePuts('[7;56H')
 				hoozer.messagesPosted:=numberInput(hoozer.messagesPosted)
 				flag:=0
 			CASE "M" /* DOWNLOADS */
 				aePuts('[8;21H')
 				hoozer.downloads:=numberInput(hoozer.downloads)
 				flag:=0
 			CASE "N" /* New user ??  */
 				aePuts('[8;56H   [8;56H')
 				command:=yesNo(0)
 				IF(command)	THEN hoozer.newUser:=1 ELSE hoozer.newUser:=0
 				flag:=0
      CASE "#"
        aePuts('[8;68H')
        hoozer.timesCalled:=longNumberInput(hoozer.timesCalled)
        flag:=0
 			CASE "O" /* Bytes Uploaded */
 				aePuts('[9;21H')
 				hoozer.bytesUpload:=longNumberInput(hoozer.bytesUpload)
 				flag:=0
 			CASE "P" /* Bytes Downloaded */
 				aePuts('[10;21H')
 				hoozer.bytesDownload:=longNumberInput(hoozer.bytesDownload)
 				flag:=0
 			CASE "Q" /* Daily Bytes Limit */
 				aePuts('[11;21H')
 				hoozer.dailyBytesLimit:=longNumberInput(hoozer.dailyBytesLimit)
 				flag:=0
 			CASE "R" /* Time_Total */
 				aePuts('[12;17H')
 				hoozer.timeTotal:=Mul(longNumberInput(Div(hoozer.timeTotal,60)),60)
 				IF(hoozer.timeTotal<hoozer.timeLimit)
   				hoozer.timeTotal:=hoozer.timeLimit
 				ELSE
 					IF(cmds.acLvl[LVL_KEEP_UPLOAD_CREDIT]<2)
 						hoozer.timeTotal:=hoozer.timeLimit
          ENDIF
 				ENDIF
      CASE "S"         /* zero upcps rate */
        aePuts('[12;47H')          /* offset by 11 */
 			 	hoozer2.upCPS:=numberInput(hoozer2.upCPS)
        flag:=0;
      CASE "T"         /* zero dncps rate */
        aePuts('[12;68H')          /* offset by 11 */
 				hoozer2.dnCPS:=numberInput(hoozer2.dnCPS)
        flag:=0
 			CASE "U" /* Time_Limit */
 				aePuts('[13;17H')
 				hoozer.timeLimit:=Mul(longNumberInput(Div(hoozer.timeLimit,60)),60)
 				IF(hoozer.timeTotal<hoozer.timeLimit)
   				hoozer.timeTotal:=hoozer.timeLimit
 				ELSE
 					IF(cmds.acLvl[LVL_KEEP_UPLOAD_CREDIT]<2)
 						hoozer.timeTotal:=hoozer.timeLimit
          ENDIF
 				ENDIF
 				IF(loggedOnUser.slotNumber=hoozer.slotNumber)
 					timeLimit:=hoozer.timeTotal-hoozer.timeUsed
        ENDIF
 				flag:=0
      CASE "V" /* TIME_USED */
 				aePuts('[13;51H')
 				hoozer.timeUsed:=Mul(longNumberInput(Div(hoozer.timeUsed,60)),60)
 				IF(loggedOnUser.slotNumber=hoozer.slotNumber)
 					timeLimit:=hoozer.timeTotal-hoozer.timeUsed
        ENDIF
 				flag:=0;
 			CASE "W" /*uucpa*/
 				aePuts('[13;76H')
 				hoozer.uucpa:=uucpNumberInput(hoozer.uucpa)
 				flag:=0
 			CASE "Y" /* chat limit */
 				aePuts('[14;17H')
        temp:=hoozer.chatLimit-hoozer.chatRemain
 				hoozer.chatLimit:=Mul(longNumberInput(Div(hoozer.chatLimit,60)),60)
        hoozer.chatRemain:=hoozer.chatLimit-temp
        IF hoozer.chatRemain<0 THEN hoozer.chatRemain:=0
 				flag:=0
 			CASE "Z" /* chat used */
 				aePuts('[14;51H')
 				hoozer.chatRemain:=hoozer.chatLimit-Mul(longNumberInput(Div(hoozer.chatLimit-hoozer.chatRemain,60)),60)
        IF hoozer.chatRemain<0 THEN hoozer.chatRemain:=0      
 				flag:=0
 			DEFAULT
 				flag:=0
 		ENDSELECT
    
 		aePuts('[18;1H')
  UNTIL flag
  nofkeys:=0

ENDPROC flag

PROC listNewAccounts(f6)
  DEF foflag,x,maximum,stat
  DEF fh
  DEF tempStr[255]:STRING
  DEF i

  onlineEdit:=1
  foflag:=0
  send017()
  sendCLS()
  aePuts('Searching...')
  maximum:=findLastAccount()
  IF(fh:=Open(userKeysFile,MODE_OLDFILE))>0
    FOR x:=1 TO maximum
      stat:=Read(fh,tempUserKeys,SIZEOF userKeys)
      ->//		printf("Name %-31s New User = %d\b\n",GHoozer2.UserName,GHoozer2.New_User)
      IF(stat<>SIZEOF userKeys)
        StringF(tempStr,'FILE-FAULT[\d], ',x)
        aePuts(tempStr)
      ELSE
        IF((tempUserKeys.newUser=1) AND (tempUserKeys.number<>0))
          foflag:=1
          loadAccount(x,tempUser,tempUserKeys,tempUserMisc)
          stat:=editInfo(x,tempUser,tempUserKeys,tempUserMisc,f6)
          IF(stat=1)	
            aePuts('\b\nAbort\b\n')
            JUMP acctMark1
          ENDIF
          aePuts('Searching...')
        ENDIF
      ENDIF
      IF((logonType>=LOGON_TYPE_REMOTE) AND (checkOnlineStatus()<0))
        Close(fh)
        onlineEdit:=0
        RETURN RESULT_NO_CARRIER
      ENDIF
      IF(checkInput())
        stat:=readChar(INPUT_TIMEOUT)
        SELECT stat
          CASE 23
            purgeLine()
            aePuts('Any key..')
            stat:=readChar(INPUT_TIMEOUT)
            IF((stat=RESULT_TIMEOUT) OR (stat=RESULT_NO_CARRIER))
              Close(fh)
              onlineEdit:=0
              RETURN stat
            ENDIF
            StrCopy(tempStr,'')
            
            FOR i:=1 TO 9
              strAddChar(tempStr,8)
            ENDFOR
            StrAdd(tempStr,'         ')
            FOR i:=1 TO 9
              strAddChar(tempStr,8)
            ENDFOR
            aePuts(tempStr)
          CASE 3 /* ^C */
            aePuts('\b\nAbort\b\n')
            JUMP acctMark1
          DEFAULT
            purgeLine()
        ENDSELECT
      ENDIF
    ENDFOR
acctMark1:
    IF(foflag=FALSE) THEN	aePuts('[0mNo new users.')
    Close(fh)
  ENDIF
  aePuts('\b\n\b\n')
  onlineEdit:=0
ENDPROC RESULT_SUCCESS

PROC onlineEditor(f6)
  DEF temp,t=0
  DEF str[255]:STRING
  temp:=loggedOnUser.timeLimit

  StrCopy(str,'\d',loggedOnUser.slotNumber)
  IF runSysCommand('ACCOUNTS',str)=FALSE
    t:=1
    editInfo(loggedOnUser.slotNumber,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,f6)
  ENDIF
  IF(loggedOnUser.timeLimit<>temp) 
 	  IF(loggedOnUser.timeLimit>temp) THEN loggedOnUser.timeTotal:=loggedOnUser.timeLimit
    timeLimit:=loggedOnUser.timeLimit-loggedOnUser.timeUsed
 	ENDIF
 
  bytesADL:=loggedOnUser.dailyBytesLimit-loggedOnUser.dailyBytesDld
  IF(t) THEN aePuts('\b\nCompleted Edit\b\n')
ENDPROC

PROC listCreditAccounts(f6)
  DEF foflag,x,maximum,stat
  DEF fh
  DEF tempStr[255]:STRING

  onlineEdit:=1
  foflag:=0
  maximum:=findLastAccount()
  IF(fh:=Open(userDataFile,MODE_OLDFILE))>0
    FOR x:=1 TO maximum
      stat:=Read(fh,tempUser,SIZEOF user)
      ->//		printf("Name %-31s New User = %d\b\n",GHoozer2.UserName,GHoozer2.New_User)
      IF(stat<>SIZEOF user)
        StringF(tempStr,'FILE-FAULT[\d], ',x)
        aePuts(tempStr)
      ELSE
        IF((tempUser.creditDays>0) AND (tempUser.slotNumber<>0))
          foflag:=1
          loadAccount(x,tempUser,tempUserKeys,tempUserMisc)
          stat:=creditMaintenance(x,tempUser,tempUserKeys,tempUserMisc,f6)
          IF(stat=1) THEN JUMP exitcreditlist
        ENDIF
      ENDIF
      IF((logonType>=LOGON_TYPE_REMOTE) AND (checkOnlineStatus()<0))
        Close(fh)
        onlineEdit:=0
        RETURN RESULT_NO_CARRIER
      ENDIF
    ENDFOR
exitcreditlist:
    Close(fh)
  ENDIF
  aePuts('\b\n\b\n')
  onlineEdit:=0
ENDPROC RESULT_SUCCESS

PROC creditMaintenance(which:LONG, hoozer:PTR TO user, hoozer2:PTR TO userKeys, hoozer3: PTR TO userMisc,f6)
  DEF tempstr[255]:STRING
  DEF datestr[15]:STRING,datestr2[15]:STRING,currdatestr[15]:STRING,currtimestr[15]:STRING
  DEF yesno[3]:STRING
  DEF flag=FALSE,remain,ch,stat

  IF (logonType=LOGON_TYPE_REMOTE) AND (checkSecurity(ACS_CREDIT_ACCESS)=FALSE) AND (f6=FALSE)
    RETURN 0
  ENDIF

  sendCLS()
  REPEAT

    aePuts('[2;1H                      [33mACCOUNT CREDIT MAINTENANCE[0m')

    conPuts('[0 p')

    aePuts('[4;2H[0m')

    StringF(tempstr,'[\z\d[4]] \s[32]',hoozer.slotNumber,hoozer.name)
    aePuts(tempstr)

    aePuts('[6;2H[33mCREDIT STATUS [0m')
     
    IF hoozer.creditDays=0 THEN aePuts('[37mINACTIVE      [0m') ELSE aePuts('[32mACTIVE        [0m')
    
    StringF(tempstr,'[8;2H[33m1.>[32m Days Credited  [33m[[0m\d[7][33m][0m',hoozer.creditDays AND $FFFF)
    aePuts(tempstr)

    StringF(tempstr,'[9;2H[33m2.>[32m Amount Paid    [33m[[0m\d[7][33m][0m',hoozer.creditAmount AND $FFFF)
    aePuts(tempstr)
    
    formatLongDate(hoozer.creditTotalDate,datestr)
    StringF(tempstr,'[10;2H[33m3.>[32m Amount Paid to Date [33m[[0m\d[7][33m][32m as of [0m\s',hoozer.creditTotalToDate AND $FFFF,datestr)
    aePuts(tempstr)

    IF (hoozer.creditTracking AND TRACK_UPLOADS_BIT) THEN StrCopy(yesno,'Yes') ELSE StrCopy(yesno,'No ')
    IF hoozer.creditStartDate=0
      StrCopy(datestr,'')
    ELSE
      formatLongDate(hoozer.creditStartDate,datestr)
    ENDIF
    StringF(tempstr,'[11;2H[33m4.> [32mTrack Uploads   [0m\s [32m Beginning Date [0m\s',yesno,datestr)
    aePuts(tempstr)

    IF (hoozer.creditTracking AND TRACK_DOWNLOADS_BIT) THEN StrCopy(yesno,'Yes') ELSE StrCopy(yesno,'No ')
    IF hoozer.creditStartDate=0
      StrCopy(datestr2,'')
    ELSE
      formatLongDate(hoozer.creditStartDate+Mul(hoozer.creditDays,86400),datestr2)
    ENDIF
    StringF(tempstr,'[12;2H[33m5.> [32mTrack Downloads [0m\s [32m Ending Date    [0m\s',yesno,datestr2)
    aePuts(tempstr)

    IF (hoozer.creditStartDate=0) OR (hoozer.creditDays=0)
      remain:=0
    ELSE
      remain:=((Div(hoozer.creditStartDate,86400))+hoozer.creditDays)-(Div(getSystemDate(),86400))
    ENDIF
    StringF(tempstr,'[13;2H[33m   [32m Days Remaining. [0m\d[7]',remain)
    aePuts(tempstr)

    aePuts('[15;2H[33mX[36m=[0mEXIT [33mR[36m=[0mRESET/SET BEGINNING DATE [0m')
    aePuts('[33mT[36m=[0mTERMINATE CREDIT ACCOUNT [0m')
    aePuts('[16;2H[33mU[36m=[0mUPDATE CREDIT TOTAL [33m~[36m=[0mSAVE ACCOUNT [0m')
    aePuts('[33m<TAB>[36m=[0mCONT[0m')

    conPuts('[ p')
    aePuts('[17;2H')

    ch:=readChar(INPUT_TIMEOUT)

    aePuts('[17;2H                                     ')

 	 	IF(ch<0) THEN RETURN ch
    ch:=charToUpper(ch)
 
    SELECT ch
      CASE "1"
        aePuts('[8;22H')
 				hoozer.creditDays:=numberInput(hoozer.creditDays)      
      CASE "2"
        aePuts('[9;22H')
 				hoozer.creditAmount:=numberInput(hoozer.creditAmount)
      CASE "3"
        aePuts('[10;27H')
 				hoozer.creditTotalToDate:=numberInput(hoozer.creditTotalToDate)
        hoozer.creditTotalDate:=getSystemDate()
      CASE "4"
        hoozer.creditTracking:=Eor(hoozer.creditTracking,TRACK_UPLOADS_BIT)
      CASE "5"
        hoozer.creditTracking:=Eor(hoozer.creditTracking,TRACK_DOWNLOADS_BIT)
      CASE "U"
        hoozer.creditTotalToDate:=hoozer.creditTotalToDate+hoozer.creditAmount
        hoozer.creditTotalDate:=getSystemDate()
      CASE "R"
        hoozer.creditStartDate:=getSystemDate()
      CASE "T"
        hoozer.creditDays:=0
      CASE "X"
        flag:=1
      CASE "~"
        IF (logonType<LOGON_TYPE_REMOTE) OR (f6=TRUE)
          IF (hoozer.creditDays>0) AND (hoozer.creditStartDate=0) THEN hoozer.creditStartDate:=getSystemDate()

          aePuts('[17;2HSaving Account...')

          formatLongDate(getSystemDate(),currdatestr)
          formatLongTime(getSystemDate(),currtimestr)
          
          IF(hoozer.creditDays=0)
            StringF(tempstr,'\s \s \s [\d[4]] CREDIT ACCOUNT INACTIVATED\n',currdatestr,currtimestr,hoozer.name,hoozer.slotNumber)
            creditLog(tempstr)
          ELSE
            StringF(tempstr,'\s \s \s [\d[4]]\n\tDAYS [\d[7]] AMOUNT [\d[7]] STARTDATE \s ENDDATE \s\n',currdatestr,currtimestr,hoozer.name,hoozer.slotNumber,hoozer.creditDays,hoozer.creditAmount,datestr,datestr2)
            creditLog(tempstr)
            formatLongDate(hoozer.creditTotalDate,datestr)
            StringF(tempstr,'\tAMOUNT PAID TO DATE [\d[7]] AS OF \s\n',hoozer.creditTotalToDate,datestr)
            creditLog(tempstr)
          ENDIF
          
          IF(hoozer.slotNumber=0)
            hoozer2.number:=0
            stat:=saveAccount(hoozer,hoozer2,hoozer3,which,1) /* 1 = FORCE SAVE */
   
            IF(stat<>RESULT_SUCCESS) THEN aePuts('Can''t Save account\b\n')
          ELSE
            hoozer2.number:=hoozer.slotNumber
                    /* save using Slot_number */
            stat:=saveAccount(hoozer,hoozer2,hoozer3,0,0) /* Not forced */
            IF(stat<>RESULT_SUCCESS) THEN aePuts('Can''t Save account\b\n')
          ENDIF

        ENDIF

      CASE "\t"
        flag:=2
    ENDSELECT

  UNTIL flag

ENDPROC flag


PROC conferenceAccounting(which:LONG, hoozer:PTR TO user, hoozer2:PTR TO userKeys, hoozer3: PTR TO userMisc,f6)
  DEF tempstr[255]:STRING,tempstr2[255]:STRING
  DEF cb: PTR TO confBase
  DEF i,flag=0,conf,ch,oldval

  IF loggedOnUser<>NIL THEN masterSavePointers(loggedOnUser)

  masterLoadPointers(hoozer)

  IF f6=FALSE
  ->recalculate totals
    hoozer.uploads:=0
    hoozer.downloads:=0
    hoozer.bytesUpload:=0
    hoozer.bytesDownload:=0
    hoozer.messagesPosted:=0
    FOR i:=1 TO cmds.numConf
      cb:=confBases[i-1]
      IF (isTempConf(hoozer,i-1))
        hoozer.uploads:=hoozer.uploads+cb.upload
        hoozer.downloads:=hoozer.downloads+cb.downloads
        hoozer.bytesUpload:=hoozer.bytesUpload+cb.bytesUpload
        hoozer.bytesDownload:=hoozer.bytesDownload+cb.bytesDownload
        hoozer.messagesPosted:=hoozer.messagesPosted+cb.messagesPosted
      ENDIF
    ENDFOR
  ENDIF

  conf:=hoozer.confRJoin

  IF isTempConf(hoozer,conf-1)
    i:=0
    REPEAT
      conf++
      IF conf>cmds.numConf THEN conf:=1
      i++
    UNTIL (isTempConf(hoozer,conf-1)) OR (i>cmds.numConf)
  ENDIF

  IF (i>cmds.numConf)
    RETURN 1
  ENDIF

  sendCLS()

  REPEAT
    conPuts('[0 p')
    
    cb:=confBases[conf-1]

    StringF(tempstr,'[2;1H [32mName[36m:[0m \s[32] ',hoozer.name)
    aePuts(tempstr)

    StringF(tempstr,'[3;1H [32mLoc.[36m:[0m \s[29]\b\n',hoozer.location)
    aePuts(tempstr)

    StringF(tempstr,'[4;1H [32mConf[36m:[0m \s[29]\b\n',getConfName(conf))
    aePuts(tempstr)

    StringF(tempstr,'[6;2H[33mE>[32mRatio .........[36m:[0m \d[7]\b\n',cb.ratio)
    aePuts(tempstr)

    StringF(tempstr,'[7;2H[33mG>[32mRatio Type ....[36m:[0m \d[5]',cb.ratioType)
    aePuts(tempstr)
    IF(cb.ratioType=0) THEN aePuts(' [32m<-[33mByte[32m)[0m')
    IF(cb.ratioType=1) THEN aePuts(' [32m<-[33mB/F[32m)[0m ')
    IF(cb.ratioType=2) THEN aePuts(' [32m<-[33mFile[32m)[0m')

    StringF(tempstr,'[8;2H[33mI>[32mUploads .......[36m:[0m \d[10]\b\n',cb.upload)
    aePuts(tempstr)

    StringF(tempstr,'[9;2H[33mK>[32mDownloads .....[36m:[0m \d[10]\b\n',cb.downloads)
    aePuts(tempstr)

    formatUnsignedLong(cb.bytesUpload,tempstr2)
    StringF(tempstr,'[10;2H[33mM>[32mBytes Uled ....[36m:[0m \s[10]\b\n',tempstr2)
    aePuts(tempstr)

    formatUnsignedLong(cb.bytesDownload,tempstr2)
    StringF(tempstr,'[11;2H[33mO>[32mBytes Dled ....[36m:[0m \s[10]\b\n',tempstr2)
    aePuts(tempstr)

    StringF(tempstr,'[12;2H[33mL>[32mMessages Posted[36m:[0m \d[10]',cb.messagesPosted)
    aePuts(tempstr)

    aePuts('[6;40H[33mAccumulated Total[0m')

    StringF(tempstr,'[8;40H[32mUploads .......[36m:[0m \d[10]\b\n',hoozer.uploads)
    aePuts(tempstr)

    StringF(tempstr,'[9;40H[32mDownloads .....[36m:[0m \d[10]\b\n',hoozer.downloads)
    aePuts(tempstr)

    formatUnsignedLong(hoozer.bytesUpload,tempstr2)
    StringF(tempstr,'[10;40H[32mBytes Uled ....[36m:[0m \s[10]\b\n',tempstr2)
    aePuts(tempstr)

    formatUnsignedLong(hoozer.bytesDownload,tempstr2)
    StringF(tempstr,'[11;40H[32mBytes Dled ....[36m:[0m \s[10]\b\n',tempstr2)
    aePuts(tempstr)

    StringF(tempstr,'[12;40H[32mMessages_Posted[36m:[0m \d[10]',hoozer.messagesPosted)
    aePuts(tempstr)

    aePuts('[14;1H  [33m-/+[36m=[0mPrev/Next Conference      [33m~[36m=[0mSAVE[0m\n')

    aePuts('[15;1H  [33mTAB[36m=[0mEXIT Conference Accounting[0m\b\n')

    aePuts('[16;1H')

    conPuts('[ p')

    ch:=readChar(INPUT_TIMEOUT)
 	 	IF(ch<0) THEN RETURN ch

    ch:=charToUpper(ch)

    SELECT ch
      CASE "E"
        aePuts('[6;21H')
 				cb.ratio:=numberInput(cb.ratio)
      CASE "G"
        aePuts('[7;21H')
 				cb.ratioType:=numberInput(cb.ratioType)
        IF((cb.ratioType<0) OR (cb.ratioType > 2)) 
          sendBELL()
          cb.ratioType:=0
        ENDIF
      CASE "I"
        aePuts('[8;21H')
        oldval:=cb.upload
 				cb.upload:=numberInput(cb.upload)
        hoozer.uploads:=hoozer.uploads-oldval+cb.upload
      CASE "K"
        aePuts('[9;21H')
        oldval:=cb.downloads
 				cb.downloads:=numberInput(cb.downloads)
        hoozer.downloads:=hoozer.downloads-oldval+cb.downloads
      CASE "M"
        aePuts('[10;21H')
        oldval:=cb.bytesUpload
 				cb.bytesUpload:=numberInput(cb.bytesUpload)
        hoozer.bytesUpload:=hoozer.bytesUpload-oldval+cb.bytesUpload
      CASE "O"
        aePuts('[11;21H')
        oldval:=cb.bytesDownload
 				cb.bytesDownload:=numberInput(cb.bytesDownload)
        hoozer.bytesDownload:=hoozer.bytesDownload-oldval+cb.bytesDownload
      CASE "L"
        aePuts('[12;21H')
        oldval:=cb.messagesPosted
 				cb.messagesPosted:=numberInput(cb.messagesPosted)
        hoozer.messagesPosted:=hoozer.messagesPosted-oldval+cb.messagesPosted
      CASE "+"
        REPEAT
          conf++
          IF conf>cmds.numConf THEN conf:=1
        UNTIL isTempConf(hoozer,conf-1)
      CASE "-"
        REPEAT
          conf--
          IF conf<1 THEN conf:=cmds.numConf
        UNTIL isTempConf(hoozer,conf-1)
      CASE "~"
        aePuts('[JSave\b\n')

        masterSavePointers(hoozer)

        IF (logonType>=LOGON_TYPE_REMOTE)
          StringF(tempstr,'\tREMOTE Conference Maintenance on Account \d, Conference \s',hoozer.slotNumber,conf)
          callersLog(tempstr)
        ELSE
          StringF(tempstr,'\tLOCAL  Conference Maintenance on Account \d, Conference \s',hoozer.slotNumber,conf)
          callersLog(tempstr)
        ENDIF

      CASE "\t"
        flag:=1
    ENDSELECT

  UNTIL flag<>0
  IF loggedOnUser<>NIL THEN masterLoadPointers(loggedOnUser)
ENDPROC flag

PROC doOnLineEdit(f6)
  DEF charStr[1]:STRING

  StrCopy(charStr,' ')
  charStr[0]:=12
  onlineEdit:=1
  IF(logonType>=LOGON_TYPE_REMOTE)
 	  ioFlags[IOFLAG_SER_IN]:=0
 	  ioFlags[IOFLAG_SER_OUT]:=0
	ENDIF
  conPuts(charStr)
  onlineEditor(f6)
  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  IF(logonType>=LOGON_TYPE_REMOTE)
   	ioFlags[IOFLAG_SER_IN]:=-1
   	ioFlags[IOFLAG_SER_OUT]:=-1
	ENDIF
  onlineEdit:=0
ENDPROC



PROC deleteConfAccess(slot)
  DEF bi
  DEF t:confBase
  DEF i
  DEF temp[100]:STRING
  DEF conferenceLocation[100]:STRING
  
  FOR i:=0 TO cmds.numConf-1
  
    getConfDbFileName(i,temp)

    bi:=Open(temp,MODE_OLDFILE)
    IF(bi>0)
      Seek(bi,(slot-1)*SIZEOF confBase,OFFSET_BEGINNING)
      Read(bi,t,SIZEOF confBase)
         t.confRead:=0
         t.newSinceDate:=0
         t.confRead:=0
         t.confYM:=0
         t.bytesDownload:=0
         t.bytesUpload:=0
         t.lastEMail:=0
         t.dailyBytesDld:=0
         t.upload:=0
         t.downloads:=0
         t.ratioType:=0
         t.ratio:=0
         t.messagesPosted:=0
         t.active:=0
         t.access:=0
      Seek(bi,(slot-1)*SIZEOF confBase,OFFSET_BEGINNING)
      Write(bi,t,SIZEOF confBase)

      Close(bi)
    ENDIF
  ENDFOR
ENDPROC


PROC checkNEdit(which,f6)
  DEF stat

  stat:=findLastAccount()
  IF(which>stat)
	  aePuts('Higher Than Maximum Account\b\n')
	  RETURN RESULT_FAILURE
  ENDIF
  
  sendCLS()
  stat:=loadAccount(which,tempUser,tempUserKeys,tempUserMisc)
  IF(stat=RESULT_FAILURE)
	  aePuts('Warning, error while loading account\b\n')
	  RETURN RESULT_FAILURE
	ENDIF
  send017()
  sendCLS()
  stat:=editInfo(which,tempUser,tempUserKeys,tempUserMisc,f6)
ENDPROC stat

PROC editAccounts(f6)
  DEF stat
  DEF which,lw
  DEF tempStr[255]:STRING

  setEnvStat(ENV_ACCOUNT)  
  IF runSysCommand('ACCOUNTS','')=FALSE
  
    WHILE TRUE
      aePuts('\b\nS>earch by name  N>ew account editing  C>redit Accounts\b\nEdit which account? ')
 		  stat:=lineInput('','',5,INPUT_TIMEOUT,tempStr)
 	    IF(stat) THEN JUMP returnf 
 	    IF(charToUpper(tempStr[0])="N")
       	listNewAccounts(f6)
      ELSEIF(charToUpper(tempStr[0])="C")
       	listCreditAccounts(f6)
 	    ELSEIF(charToUpper(tempStr[0])="S")
 		    aePuts('\b\nUserName: ')
 		    stat:=lineInput('','',30,INPUT_TIMEOUT,tempStr)
 		    IF(stat) THEN JUMP returnf
 		    lw:=0
 		    REPEAT
 			    lw++
 			    which:=findUserFromName(lw,NAME_TYPE_USERNAME,tempStr,tempUser,tempUserKeys,tempUserMisc)
 			    IF(which<=0)
 			    	aePuts('\b\nSorry no user under that name.\b\n')
          ELSE
            lw:=which
 	  		    stat:=checkNEdit(which,f6)
            IF stat<0 THEN JUMP returnf
 		      ENDIF
        UNTIL (which<=0) OR (stat<>2)
 	    ELSE
   	    which:=Val(tempStr)
 	      IF(which<=0) THEN JUMP returnf
 	      stat:=checkNEdit(which,f6)
            IF stat<0 THEN JUMP returnf
      ENDIF
 	  ENDWHILE
returnf:
    aePuts('\b\n')
  ENDIF

ENDPROC RESULT_SUCCESS

PROC updateAllUsers(confnum,updateType, newVal)
  DEF fh,stat
  DEF cb: PTR TO confBase
  DEF confDbFile[255]:STRING

  getConfDbFileName(confnum,confDbFile)

  cb:=NEW cb

  fh:=Open(confDbFile,MODE_READWRITE)
  
  IF fh>0
    REPEAT
      stat:=Read(fh,cb,SIZEOF confBase)
      IF stat=SIZEOF confBase
        Seek(fh,-stat,OFFSET_CURRENT)

        SELECT updateType
          CASE UPDATE_RATIO
            cb.ratio:=newVal
          CASE UPDATE_RATIO_TYPE
            cb.ratioType:=newVal
          CASE UPDATE_MAILSCAN_PTRS
            cb.confRead:=newVal
          CASE UPDATE_NEW_MAIL_SCAN
            IF newVal 
              cb.handle[0]:=cb.handle[0] OR MAIL_SCAN_MASK
            ELSE
              cb.handle[0]:=cb.handle[0] AND Not(MAIL_SCAN_MASK)
            ENDIF
          CASE UPDATE_NEW_FILE_SCAN
            IF newVal 
              cb.handle[0]:=cb.handle[0] OR FILE_SCAN_MASK
            ELSE
              cb.handle[0]:=cb.handle[0] AND Not(FILE_SCAN_MASK)
            ENDIF
          CASE UPDATE_DEFAULT_ZOOM_FLAG
            IF newVal 
              cb.handle[0]:=cb.handle[0] OR ZOOM_SCAN_MASK
            ELSE
              cb.handle[0]:=cb.handle[0] AND Not(ZOOM_SCAN_MASK)
            ENDIF
          CASE UPDATE_LAST_MESSAGE
            cb.confYM:=newVal
          CASE UPDATE_MESSAGES_POSTED
            cb.messagesPosted:=newVal
        ENDSELECT

        stat:=Write(fh,cb,SIZEOF confBase)
      ENDIF
    UNTIL stat<>SIZEOF confBase
    Close(fh)
  ENDIF
  END cb

ENDPROC

PROC dumpUserStats(confnum)
  DEF fh,fhs
  DEF cb: PTR TO confBase
  DEF confDbFile[255]:STRING
  DEF confStatFile[255]:STRING
  DEF tempstr[255]:STRING
  DEF n,stat

  StringF(confStatFile,'\sConf\d.Stats',cmds.bbsLoc,confnum)

  fhs:=Open(confStatFile,MODE_NEWFILE)
  IF fhs>0
    getConfDbFileName(confnum,confDbFile)

    cb:=NEW cb

    fh:=Open(confDbFile,MODE_READWRITE)
    
    IF fh>0
      n:=1
      StringF(tempstr,'Conference Name: \s',getConfName(confnum))
      fileWriteLn(fhs,tempstr)
      fileWriteLn(fhs,'==========================================')
      REPEAT
        stat:=Read(fh,cb,SIZEOF confBase)
        IF stat=SIZEOF confBase
          IF loadAccount(n,tempUser,NIL,NIL)=RESULT_SUCCESS
            StringF(tempstr,'Name            : \s',tempUser.name)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Location        : \s',tempUser.location)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Area Access     : \s',tempUser.conferenceAccess)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Ratio           : \d',cb.ratio)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'RatioType       : \d',cb.ratioType)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Files Uploaded  : \d',cb.upload)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Files Downloaded: \d',cb.downloads)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Bytes Uploaded  : \d',cb.bytesUpload)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Bytes Downloaded: \d',cb.bytesDownload)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Messages Posted : \d',cb.messagesPosted)
            fileWriteLn(fhs,tempstr)
            fileWriteLn(fhs,'------------------------------------------')
          ENDIF
        ENDIF
        n++
      UNTIL stat<>SIZEOF confBase
      Close(fh)
    ENDIF

    Close(fhs)
    END cb
  ENDIF 
ENDPROC

PROC resizeConfDB(confnum,newSize)
  DEF confDbFile[255]:STRING
  DEF oldConfDbFile[255]:STRING
  DEF cb: PTR TO confBase
  DEF cb2: PTR TO confBase
  DEF fh1,fh2

  cb:= NEW cb
  cb2:= NEW cb2

    getConfDbFileName(confnum,confDbFile)

    StrCopy(oldConfDbFile,confDbFile)
    StrAdd(oldConfDbFile,'.old')

    DeleteFile(oldConfDbFile)

    Rename(confDbFile,oldConfDbFile)
    
    IF (fh1:=Open(confDbFile,MODE_NEWFILE))>0
      IF (fh2:=Open(oldConfDbFile,MODE_OLDFILE))>0
        WHILE newSize>0
          IF (Read(fh2,cb,SIZEOF confBase)=SIZEOF confBase)
            Write(fh1,cb,SIZEOF confBase)
          ELSE
            Write(fh1,cb2,SIZEOF confBase)
          ENDIF
          newSize--
        ENDWHILE

        Close(fh1)
        Close(fh2)
        DeleteFile(oldConfDbFile)
      ELSE
        Close(fh1)
        DeleteFile(confDbFile)

        ->put the old file back
        Rename(oldConfDbFile,confDbFile)
      ENDIF
    ELSE
      ->put the old file back
      Rename(oldConfDbFile,confDbFile)
    ENDIF
  END cb
  END cb2
ENDPROC

PROC conferenceMaintenance()
  DEF conf,flag=0,ch,size,n,f,m
  DEF tempstr[255]:STRING
  
  conf:=1
  m:=findLastAccount()
  loadMsgPointers(conf)
  getConfLocation(conf,tempstr)
  getMailStatFile()
  getConfDbFileName(conf,tempstr)
  size:=Div(getFileSize(tempstr),SIZEOF confBase)

  REPEAT
    conPuts('[0 p')
    aePuts('[2;1H                      [33mCONFERENCE MAINTENANCE[0m')

    StringF(tempstr,'[4;1H [32mConference [34m[[0m\d[3][34m][36m:[0m \s[29]\b\n',conf,getConfName(conf))
    aePuts(tempstr)
    aePuts('[6;1H[0m THE FOLLOWING OPTIONS EFFECT ALL USERS FOR THIS CONFERENCE!\b\n')
    aePuts('[8;2H[33m1.>[32m Ratio[0m')
    aePuts('[9;2H[33m2.>[32m Ratio Type[0m')
    aePuts('[10;2H[33m3.>[32m Reset New Mail Scan Pointers[0m')
    aePuts('[11;2H[33m4.>[32m Reset Last Message Read Pointers[0m')
    aePuts('[12;2H[33m5.>[32m Dump all user stats to Conf.Stats[0m')
    aePuts('[13;2H[33m6.>[32m Set Default New Mail Scan[0m')
    aePuts('[14;2H[33m7.>[32m Set Default New File Scan[0m')
    aePuts('[8;40H[33m8.>[32m Set Default Zoom Flag[0m')
    aePuts('[9;40H[33m9.>[32m Reset Messages Posted[0m')
    aePuts('[10;40H[33mA.>[32m Reset Voting Booth[0m')
    StringF(tempstr,'[11;40H[33mB.>[32m Next   Msg # [0m\z\r\d[8]',mailStat.highMsgNum)
    aePuts(tempstr)
    StringF(tempstr,'[12;40H[33mC.>[32m Lowest Msg # [0m\z\r\d[8]',mailStat.lowestKey)
    aePuts(tempstr)
    StringF(tempstr,'[13;40H[33mD.>[32m Capacity [0m\d[4] [32mUsers',size)
    aePuts(tempstr)
    f:=Mul(Mod(Mul(m,100),size),1000)
    n:=Div(Mul(m,100),size)
    IF (n<90)
      StringF(tempstr,'[14;44H[33m\r\d[2].\z\r\d[3]% In use',n,f)
    ELSE
      StringF(tempstr,'[14;44H[31m\r\d[2].\z\r\d[3]% In use',n,f)
    ENDIF
    aePuts(tempstr)
    aePuts('[16;2H[33m<TAB>[36m to exit [33m-/+[36m=[0mPrev/Next Conference [0m')

    aePuts('[17;2H')
    aePuts('[ p')
  
    ch:=readChar(INPUT_TIMEOUT)
 	 	IF(ch<0) THEN RETURN ch

    ch:=charToUpper(ch)

    SELECT ch
      CASE "1"
        aePuts('[0mRatio > ')
        n:=numberInputNoDefault()
        aePuts('[17;2H [0mWorking....')
        IF n>=0 THEN updateAllUsers(conf,UPDATE_RATIO,n)
      CASE "2"
        aePuts('[0mRatio Type > ')
        n:=numberInputNoDefault()
        aePuts('[17;2H [0mWorking....')
        IF n>=0 THEN updateAllUsers(conf,UPDATE_RATIO_TYPE,n)
      CASE "3"
        aePuts('[17;2H [0mWorking....')
        updateAllUsers(conf,UPDATE_MAILSCAN_PTRS,-1)
      CASE "4"
        aePuts('[17;2H [0mWorking....')
        updateAllUsers(conf,UPDATE_LAST_MESSAGE,-1)
      CASE "5"
        aePuts('[17;2H [0mWorking....')
        dumpUserStats(conf)
      CASE "6"
        aePuts('[17;2H [0mDefault ON ')
        n:=yesNo(1)
        aePuts('[17;2H [0mWorking....')
        IF n
          updateAllUsers(conf,UPDATE_NEW_MAIL_SCAN,TRUE)
        ELSE
          updateAllUsers(conf,UPDATE_NEW_MAIL_SCAN,FALSE)
        ENDIF
      CASE "7"
        aePuts('[17;2H [0mDefault ON ')
        n:=yesNo(1)
        aePuts('[17;2H [0mWorking....')
        IF n
          updateAllUsers(conf,UPDATE_NEW_FILE_SCAN,TRUE)
        ELSE
          updateAllUsers(conf,UPDATE_NEW_FILE_SCAN,FALSE)
        ENDIF
      CASE "8"
        aePuts('[17;2H [0mDefault ON ')
        n:=yesNo(1)
        aePuts('[17;2H [0mWorking....')
        IF n
          updateAllUsers(conf,UPDATE_DEFAULT_ZOOM_FLAG,TRUE)
        ELSE
          updateAllUsers(conf,UPDATE_DEFAULT_ZOOM_FLAG,FALSE)
        ENDIF
      CASE "9"
        aePuts('[17;2H [0mWorking....')
        updateAllUsers(conf,UPDATE_MESSAGES_POSTED,0)
      CASE "A"
        aePuts('[17;2H [0mNot yet implemented....')
        Delay(60)
      CASE "B"
        aePuts('[0mNext Message > ')
        n:=numberInputNoDefault()
        IF n>=0
          mailStat.highMsgNum:=n
          saveStatOnly()
        ENDIF
      CASE "C"
        aePuts('[0mLow Message  > ')
        n:=numberInputNoDefault()
        IF n>=0
          mailStat.lowestKey:=n
          saveStatOnly()
        ENDIF
      CASE "D"
        aePuts('[0mSize in records > ')
        n:=numberInputNoDefault()
        IF n>0
          aePuts('[17;2H[0mResizing, Please Standby')
          resizeConfDB(conf,n)
          getConfDbFileName(conf,tempstr)
          size:=Div(getFileSize(tempstr),SIZEOF confBase)
        ENDIF
      CASE "\t"
        flag:=1
      CASE "-"
        conf:=conf-1
        IF conf<1 THEN conf:=cmds.numConf
        loadMsgPointers(conf)
        getMailStatFile()
        getConfDbFileName(conf,tempstr)
        size:=Div(getFileSize(tempstr),SIZEOF confBase)
      CASE "+"
        conf:=conf+1
        IF conf>cmds.numConf THEN conf:=1
        getMailStatFile()
        getConfDbFileName(conf,tempstr)
        size:=Div(getFileSize(tempstr),SIZEOF confBase)
    ENDSELECT
    aePuts('[17;2H                                     ')
    
  UNTIL flag

ENDPROC

PROC findOpenAccount(hoozer:PTR TO user, hoozer2: PTR TO userKeys, hoozer3: PTR TO userMisc)
  DEF slot

  slot:=findFreeSlot()
  IF loadAccount(slot,hoozer,hoozer2,hoozer3)<>RESULT_SUCCESS
    initNewUser(hoozer,hoozer2,hoozer3,slot)
  ENDIF
ENDPROC

PROC displayAccount(who:LONG, hoozer:PTR TO user, hoozer2: PTR TO userKeys, hoozer3: PTR TO userMisc, f6:LONG)
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF temp
  DEF baud
  sendCLS()

  baud:=hoozer2.baud AND $ffff

  SELECT baud
    CASE 49664
      baud:=115200
    CASE 33792
      baud:=230400
    CASE 17920
      baud:=345600
    CASE 2048
      baud:=460800
    CASE 51712
      baud:=576000
    CASE 24576
      baud:=614400
    CASE 35840
    baud:=691200
    CASE 19968
      baud:=806400
    CASE 4096
      baud:=921600
  ENDSELECT  
  
  IF(hoozer.slotNumber=who)
 	  StringF(tempStr,'[0;0H[33m  ACTIVE[0m [\d]   [32mBAUD[36m:[0m \d\b\n',hoozer.slotNumber,baud)
 	  aePuts(tempStr)
 	ELSE
  	StringF(tempStr,'[0;0H[37mINACTIVE[0m [\d]     \b\n',who)
 	  aePuts(tempStr)
 	ENDIF
 
  StringF(tempStr,'[2;1H[33mA> [32mName[36m:[0m \l\s[32] ',hoozer.name)
  aePuts(tempStr)
  
  StringF(tempStr,'[2;42H[33mB> [32mReal Name[36m:[0m \l\s[25]',hoozer3.realName)
  aePuts(tempStr)
  StringF(tempStr,'[3;1H[33mC> [32mLoc.[36m:[0m \l\s[29]',hoozer.location)
  aePuts(tempStr)
  IF((logonType>=LOGON_TYPE_REMOTE) AND (f6=FALSE))
    IF(loggedOnUser.slotNumber=1)
      StringF(tempStr,'[3;42H[33mD> [32mPass ....[36m: [44mENCRYPTED[0m')
      aePuts(tempStr)
    ELSE
      aePuts('[3;42H[33mD> [32mPass ....[34m: [31mDISABLED[0m')
    ENDIF
  ELSE
    StringF(tempStr,'[3;42H[33mD> [32mPass ....[36m: [44mENCRYPTED[0m')
    aePuts(tempStr)
  ENDIF
 
  StringF(tempStr,'[4;1H[33mE> [32mPhone Number ..[36m:[0m \l\s[13]',hoozer.phoneNumber)
  aePuts(tempStr)

  StringF(tempStr,'[4;36H[33mF> [32mArea Name......[36m:[0m \l\s',hoozer.conferenceAccess)
  aePuts(tempStr)

  StringF(tempStr,'[5;1H[33mG> [32mRatio .........[36m:[0m \l\d[7]',hoozer.secLibrary)
  aePuts(tempStr)

  StringF(tempStr,'[5;36H[33mH> [32mSec_Level .....[36m:[0m \l\d[5]',hoozer.secStatus)
  aePuts(tempStr)
 
  StringF(tempStr,'[6;1H[33mI> [32mRatio Type ....[36m:[0m \l\d[5]',hoozer.secBoard)
  aePuts(tempStr)
  IF(hoozer.secBoard=0) THEN aePuts(' [32m<-[33mByte[32m)[0m')
  IF(hoozer.secBoard=1) THEN aePuts(' [32m<-[33mB/F[32m)[0m ')
  IF(hoozer.secBoard=2) THEN aePuts(' [32m<-[33mFile[32m)[0m')

  StringF(tempStr,'[6;36H[33mJ> [32mAutoReJoin ....[36m:[0m \l\d[10]',hoozer.confRJoin)
  aePuts(tempStr)
  
  StringF(tempStr,'[7;1H[33mK> [32mUploads .......[36m:[0m \l\d[10]',hoozer.uploads AND $FFFF)
  aePuts(tempStr)

  StringF(tempStr,'[7;36H[33mL> [32mMessages Posted[36m:[0m \l\d[7]',hoozer.messagesPosted AND $FFFF)
  aePuts(tempStr)
 
  StringF(tempStr,'[8;1H[33mM> [32mDownloads .....[36m:[0m \l\d[10]\b\n',hoozer.downloads AND $FFFF)
  aePuts(tempStr)

  IF hoozer.newUser THEN StrCopy(tempStr2,'Yes') ELSE StrCopy(tempStr2,'No')
  StringF(tempStr,'[8;36H[33mN> [32mNew_User ......[36m:[0m \s[3] [33m#[32mCalls[36m: [0m\l\d[12]',tempStr2,hoozer.timesCalled AND $FFFF)
  aePuts(tempStr)
 
  formatUnsignedLong(hoozer.bytesUpload,tempStr2)
  StringF(tempStr,'[9;1H[33mO> [32mBytes Uled ....[36m:[0m \l\s[10]',tempStr2)
  aePuts(tempStr)
 
  formatLongDateTime(hoozer.timeLastOn,tempStr2)
  StringF(tempStr,'[9;39H[32mLast Called ...[36m:[0m \s',tempStr2)
  aePuts(tempStr)
 
  formatUnsignedLong(hoozer.bytesDownload,tempStr2)
  StringF(tempStr,'[10;1H[33mP> [32mBytes Dled ....[36m:[0m \l\s[10]',tempStr2)
  aePuts(tempStr)

  temp:=ListLen(computerTypes)
  IF temp=0
    StringF(tempStr,'[10;39H[32mComputer Type .[36m:[0m ')
  ELSEIF hoozer.secBulletin>=temp
    StringF(tempStr,'[10;39H[32mComputer Type .[36m:[0m NOT VALID!',computerTypes[hoozer.secBulletin])
  ELSE
    StringF(tempStr,'[10;39H[32mComputer Type .[36m:[0m \l\s[16]',computerTypes[hoozer.secBulletin])
  ENDIF
  aePuts(tempStr)

  formatUnsignedLong(hoozer.dailyBytesLimit,tempStr2)
  StringF(tempStr,'[11;1H[33mQ> [32mByte Limit ....[36m:[0m \l\s[10]',tempStr2)
  aePuts(tempStr)
 
  temp:=ListLen(screenTypeTitle)
  IF temp=0
    StringF(tempStr,'[11;39H[32mScreen Type  ..[36m:[0m ')
  ELSEIF hoozer.screenType>=temp
    StringF(tempStr,'[11;39H[32mScreen Type  ..[36m:[0m NOT VALID!')
  ELSE
    StringF(tempStr,'[11;39H[32mScreen Type  ..[36m:[0m \l\s',screenTypeTitle[hoozer.screenType])
  ENDIF
  aePuts(tempStr)

  StringF(tempStr,'[12;1H[33mR> [32mTime_Total[36m:[0m [36m[[0m\l\d[8][36m][0m mins    ',Div(hoozer.timeTotal,60))
  aePuts(tempStr)

  StringF(tempStr,'[12;36H[33mS> [32mCps UP[36m:[0m \l\d[7] ',hoozer2.upCPS AND $FFFF)
  aePuts(tempStr)
  
  StringF(tempStr,'[12;57H[33mT> [32mCps DN[36m:[0m \l\d[7] ',hoozer2.dnCPS AND $FFFF)
  aePuts(tempStr)

  StringF(tempStr,'[13;1H[33mU> [32mTime_Limit[36m:[0m [36m[[0m\l\d[8][36m][0m mins    ',Div(hoozer.timeLimit,60))
  aePuts(tempStr)
  StringF(tempStr,' [33mV> [32mTime_Used[36m:[0m [36m[[0m\l\d[8][36m][0m mins  [33mW> [32mUUCP[36m: [0m\d  ',Div(hoozer.timeUsed,60),hoozer.uucpa)
  aePuts(tempStr)

  StringF(tempStr,'[14;1H[33mY> [32mChat_Limit[36m:[0m [36m[[0m\l\d[8][36m][0m mins    ',Div(hoozer.chatLimit,60))
  aePuts(tempStr)
  StringF(tempStr,' [33mZ> [32mChat_Used[36m:[0m [36m[[0m\l\d[8][36m][0m mins    ',Div((hoozer.chatLimit-hoozer.chatRemain),60))
  aePuts(tempStr)

  aePuts('\b\n')
 
  aePuts('[16;1H[33mX  [36m=[0mEXIT-NOSAVE [33m~[36m=[0mSAVE  [33m1-8[36m=[0mPRESETS  [33m9[36m=[0mRE-ACTIVATE  [33mDEL[36m=[0mDELETE[0\b\n')
  aePuts('[33mTAB[36m=[0mCONT [33m@[36m=[0mCONFERENCE ACCOUNTING [33m![36m=[0mCREDIT ACCOUNT MAINTENANCE\b\n')
ENDPROC


PROC displayAccountInfo(who:LONG, hoozer:PTR TO user, hoozer2:PTR TO userKeys, hoozer3:PTR TO userMisc,f6:LONG)
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF baud,temp
 
  baud:=hoozer2.baud AND $ffff

  SELECT baud
    CASE 49664
      baud:=115200
    CASE 33792
      baud:=230400
    CASE 17920
      baud:=345600
    CASE 2048
      baud:=460800
    CASE 51712
      baud:=576000
    CASE 24576
      baud:=614400
    CASE 35840
    baud:=691200
    CASE 19968
      baud:=806400
    CASE 4096
      baud:=921600
  ENDSELECT  
  
  IF(hoozer.slotNumber=who)
 	  StringF(tempStr,'[0;0H[33m  ACTIVE[0m [\d]   [32mBAUD[36m:[0m \d    \b\n',hoozer.slotNumber,baud)
 	  aePuts(tempStr)
 	ELSE
  `	StringF(tempStr,'[0;0H[37mINACTIVE[0m [\d]     \b\n',who)
 	  aePuts(tempStr)
 	ENDIF
 
  StringF(tempStr,'[2;10H\l\s[32]',hoozer.name)
  aePuts(tempStr)
  StringF(tempStr,'[2;56H\l\s[25]',hoozer3.realName)
  aePuts(tempStr)
  StringF(tempStr,'[3;10H\l\s[29]',hoozer.location)
  aePuts(tempStr)

  IF((logonType>=LOGON_TYPE_REMOTE) AND (f6=FALSE))
  
    IF(loggedOnUser.slotNumber=1)
      StringF(tempStr,'[3;56H[36m[44mENCRYPTED[0m')
      aePuts(tempStr)
    ELSE
      aePuts('[3;56H[36m[44mDISABLED[0m\b\n')
    ENDIF
  ELSE
    StringF(tempStr,'[3;56H[36m[44mENCRYPTED[0m')
    aePuts(tempStr)
  ENDIF
  StringF(tempStr,'[4;21H\l\s[13]',hoozer.phoneNumber)
  aePuts(tempStr)
 
  StringF(tempStr,'[4;56H\l\s[10]',hoozer.conferenceAccess)
  aePuts(tempStr)

  StringF(tempStr,'[5;21H\l\d[7]',hoozer.secLibrary)
  aePuts(tempStr)

  StringF(tempStr,'[5;56H\l\d[5]',hoozer.secStatus)
  aePuts(tempStr)
 
 
  StringF(tempStr,'[6;21H\l\d[5]',hoozer.secBoard)
  aePuts(tempStr) 
  IF(hoozer.secBoard=0) THEN aePuts(' [32m<-[33mByte[32m)[0m')
  IF(hoozer.secBoard=1) THEN aePuts(' [32m<-[33mB/F[32m)[0m ')
  IF(hoozer.secBoard=2) THEN aePuts(' [32m<-[33mFile[32m)[0m')

  StringF(tempStr,'[6;56H\l\d[7]',hoozer.confRJoin)
  aePuts(tempStr)
 
  StringF(tempStr,'[7;21H\l\d[10]',hoozer.uploads AND $FFFF)
  aePuts(tempStr)

  StringF(tempStr,'[7;56H\l\d[7]',hoozer.messagesPosted AND $FFFF)
  aePuts(tempStr)

   StringF(tempStr,'[8;21H\l\d[10]',hoozer.downloads AND $FFFF)
  aePuts(tempStr)

  IF hoozer.newUser THEN StrCopy(tempStr2,'Yes') ELSE StrCopy(tempStr2,'No ')
  StringF(tempStr,'[8;56H\s [33m#[32mCalls[36m: [0m\l\d[12]',tempStr2,hoozer.timesCalled AND $FFFF)
  aePuts(tempStr)

  formatUnsignedLong(hoozer.bytesUpload,tempStr2)
  StringF(tempStr,'[9;21H\l\s[10]',tempStr2)
  aePuts(tempStr)

  formatLongDateTime(hoozer.timeLastOn,tempStr2)
  StringF(tempStr,'[9;56H\s',tempStr2)
  aePuts(tempStr)
 
  formatUnsignedLong(hoozer.bytesDownload,tempStr2)
  StringF(tempStr,'[10;21H\l\s[10]',tempStr2)
  aePuts(tempStr)

  temp:=ListLen(computerTypes)
  IF temp=0
    StringF(tempStr,'[10;56H')
  ELSEIF hoozer.secBulletin>=temp
    StringF(tempStr,'[10;56HNOT VALID!')
  ELSE
    StringF(tempStr,'[10;56H\l\s[16]',computerTypes[hoozer.secBulletin])
  ENDIF
  aePuts(tempStr)

  formatUnsignedLong(hoozer.dailyBytesLimit,tempStr2)
  StringF(tempStr,'[11;21H\l\s[10]',tempStr2)
  aePuts(tempStr)

  temp:=ListLen(screenTypeTitle)
  IF temp=0
    StringF(tempStr,'[11;56H')
  ELSEIF (hoozer.screenType>=temp)
    StringF(tempStr,'[11;56HNOT VALID!')
  ELSE
    StringF(tempStr,'[11;56H\l\s[16]',screenTypeTitle[hoozer.screenType])
  ENDIF
  aePuts(tempStr)

  StringF(tempStr,'[12;17H\l\d[6]',Div(hoozer.timeTotal,60))
  aePuts(tempStr)
  
  StringF(tempStr,'[12;39H[32mCps UP[36m:[0m \l\d[7] ',hoozer2.upCPS AND $FFFF)
  aePuts(tempStr)
 
  StringF(tempStr,'[12;60H[32mCps DN[36m:[0m \l\d[7] ',hoozer2.dnCPS AND $FFFF)
  aePuts(tempStr)
 
  StringF(tempStr,'[13;17H\l\d[6]',Div(hoozer.timeLimit,60))
  aePuts(tempStr)
  StringF(tempStr,'[13;51H\l\d[6]',Div(hoozer.timeUsed,60))
  aePuts(tempStr)
 
  StringF(tempStr,'[13;76H\d',hoozer.uucpa)
  aePuts(tempStr)

  StringF(tempStr,'[14;17H\l\d[6]',Div(hoozer.chatLimit,60))
  aePuts(tempStr)
  StringF(tempStr,'[14;51H\l\d[6]',Div((hoozer.chatLimit-hoozer.chatRemain),60))
  aePuts(tempStr)
ENDPROC

PROC fileStatus(opt)
  DEF i,s,j=0,n
  DEF tmp[200]:STRING
  DEF bytesup[15]:STRING
  DEF bytesdown[15]:STRING
  DEF bytesavail[15]:STRING
  DEF k 
  DEF ca=FALSE

  IF(opt=FALSE) THEN s:=cmds.numConf ELSE s:=currentConf

  IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING)) THEN ca:=TRUE

  aePuts('\b\n')
  aePuts('[32m              Uploads             Downloads\b\n')
  aePuts('[32m     Conf  Files    Bytes     Files    Bytes     Bytes Avail  Ratio\b\n')
  aePuts('[0m     ----  -------  --------- -------  --------- -----------  -----\b\n')
  saveMsgPointers(currentConf)

  FOR i:=1 TO s
    IF (opt=FALSE) OR (i=currentConf)
      IF i=(currentConf) THEN n:=3 ELSE n:=6
      IF checkConfAccess(i)
        j++
        IF(ca) THEN k:=j ELSE k:=i
        IF (ca=TRUE) OR (i=currentConf)
          IF (ca) THEN loadMsgPointers(i)
          formatUnsignedLong(loggedOnUser.bytesUpload,bytesup)
          formatUnsignedLong(loggedOnUser.bytesDownload,bytesdown)
          formatUnsignedLong((loggedOnUser.dailyBytesLimit-loggedOnUser.dailyBytesDld),bytesavail)
          IF(loggedOnUser.secLibrary)
            StringF(tmp,'[33m     \r\d[4][0m> [3\dm\d[7]  \r\s[9] \r\d[7]  \r\s[9]   \r\s[9]   \d[0m:[3\dm1\b\n', relConf(k), n,loggedOnUser.uploads AND $FFFF,bytesup,loggedOnUser.downloads AND $FFFF AND $FFFF,bytesdown,bytesavail,loggedOnUser.secLibrary,n)
          ELSE
            StringF(tmp,'[33m     \r\d[4][0m> [3\dm\d[7]  \r\s[9] \r\d[7]  \r\s[9]   \r\s[9]  [31mDSBLD\b\n', relConf(k), n,loggedOnUser.uploads AND $FFFF,bytesup,loggedOnUser.downloads AND $FFFF,bytesdown,bytesavail)
          ENDIF
          aePuts(tmp)
        ENDIF
      ENDIF
    ENDIF
  ENDFOR
  aePuts('[0m\b\n\b\n')
  loadMsgPointers(currentConf)
ENDPROC

PROC who(opt)
  DEF fileName[100]:STRING
  DEF mes[100]:STRING   
  DEF mes2[100]:STRING
  DEF mes1[100]:STRING
  DEF name[100]:STRING
  DEF location[100]:STRING
  DEF chatstr[10]:STRING

  DEF s:PTR TO singlePort
  DEF singles[MAXNODES]:ARRAY OF LONG
  DEF status,i,blockOLM

/*  aePuts('[32m.---+----------------------+---------------------------+----------------------.[0m\b\n')
  aePuts('[32m|[33mNd#[32m|[36m Name/Handle          [32m| [36mLocation         ')
  aePuts('[32m         |[36m Action               [32m|[0m\b\n')
  aePuts('[32m)---+----------------------+---------------------------+----------------------([0m\b\n')
      aePuts('[32m|---+----------------------+---------------------------+----------------------|[0m\b\n')
  aePuts('[34m|---+---------------------+---------------------+---------------------+----|[0m\b\n')

*/

  aePuts('\b\n')
  aePuts('\b\n')
  aePuts('[34m.---+---------------------+---------------------+---------------------+----.[0m\b\n')



  aePuts('[34m|[33mNd#[34m|[36m Name/Handle         [34m|[36m Location   [34m         |[36m Action              [34m|[36mChat[0m[34m|[0m\b\n')
  aePuts('[34m)---+---------------------+---------------------+---------------------+----([0m\b\n')

  ObtainSemaphore(masterNode)
  FOR i:=0 TO MAXNODES-1
    singles[i]:=(masterNode.myNode[i].s)
  ENDFOR
  ReleaseSemaphore(masterNode)
  FOR i:=0 TO MAXNODES-1
    s:=singles[i]
    ObtainSemaphore(s)
   
    status:=s.status
    StrCopy(name,s.handle)
    StrCopy(location,s.location)
    StrCopy(fileName,s.misc1)
    IF(opt)
      StringF(mes, '[34m| [0m\l\d[20] [32m|[0m \l\d[25] [32m|[0m',s,masterNode)
      StringF(mes1,' \l\d[20] [32m|[0m',s.semi.nestcount)
      StringF(mes2,'[34m| [0m\d ',i)
      aePuts(mes2)
      aePuts(mes)
      aePuts(mes1)
      aePuts('\b\n')
      aePuts('[34m|---+---------------------+---------------------+---------------------+----|[0m\b\n')

      ReleaseSemaphore(s)
      JUMP whonext
    ENDIF
    ReleaseSemaphore(s)

    blockOLM:=s.misc2[0]
    IF blockOLM THEN StrCopy(chatstr,'[31mNO') ELSE StrCopy(chatstr,'[32mYES')

    SELECT status
       CASE 0
                StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
                StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','IDLE',chatstr)
       CASE 1
                StringF(mes, '[34m| [33m\l\s[20] [34m|[35m \l\s[19] [34m|[0m',name,location)
                IF checkSecurity(ACS_HIDE_FILES)
                  StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','DOWNLOADING',chatstr)
                ELSEIF(StrLen(fileName)>0)
                  StringF(mes1,' DL: \l\s[16] [34m|[0m',fileName,chatstr)
                ELSE
                  StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','BEGINNING DL',chatstr)
                ENDIF
       CASE 2
                StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
                IF checkSecurity(ACS_HIDE_FILES)
                  StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','UPLOADING',chatstr)
                ELSEIF(StrLen(fileName)>0)
                  StringF(mes1,' UL: \l\s[16] [34m|[0m',fileName,chatstr)
                ELSE
                  StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','BEGINNING UL',chatstr)
                ENDIF
       CASE 3
                StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
                IF(i=node)
                  StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','WHO',chatstr)
                ELSE
                  StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','MODULE',chatstr)
                ENDIF
       CASE 4
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','READING MAIL',chatstr)
       CASE 5
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','REVIEWING STATS',chatstr)
       CASE 6
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','ACCOUNT EDITING',chatstr)
       CASE 7
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','ZOOMING',chatstr)
       CASE 8
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','VIEWING DIRS',chatstr)
       CASE 9
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','READING BULLS',chatstr)
       CASE 10
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','VIEWING FILES',chatstr)
       CASE 11
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','');StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','ACCOUNT SEQUENCE',chatstr)
       CASE 12
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','LOGGING OFF',chatstr)
       CASE 13
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','SYSOPING',chatstr)
       CASE 14
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','USING SHELL',chatstr)
       CASE 15
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','EDITING',chatstr)
       CASE 16
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','JOINING CONF',chatstr)
       CASE 17 
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','CHATTING',chatstr)
       CASE 18
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','');StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','NODE INACTIVE.',chatstr)
       CASE 19
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','REQUESTING CHAT',chatstr)
       CASE 20
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','CONNECTING',chatstr)
       CASE 21
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','LOGGING ON',chatstr)
       CASE 22
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','');StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','AWAITING CONNECT',chatstr)
       CASE 23
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','SCANNING MAIL',chatstr)
       CASE 24
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','');StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','SHUTDOWN',chatstr)
       CASE 25
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location);StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','MULTICHAT',chatstr)
       CASE 26
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','');StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','SUSPENDED',chatstr)
       CASE 27
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','');StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','RESERVED',chatstr)
       CASE 28
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','');StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','ONLINE MESSAGE',chatstr)
       CASE -1
          StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','');StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','UNAVAILABLE',chatstr)
       DEFAULT
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','');StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','',chatstr)
    ENDSELECT
    StringF(mes2,'[34m| [0m\z\r\d[2]',i)
    IF((status<>27) AND (status>=0) AND (status<>24) AND (status<>18))
      aePuts(mes2)
      aePuts(mes)
      aePuts(mes1)
      aePuts('\b\n')
      IF cmds.acLvl[LVL_LONGWHO] THEN aePuts('[34m|---+---------------------+---------------------+---------------------+----|[0m\b\n')
    ENDIF

whonext:
  ENDFOR
  IF cmds.acLvl[LVL_LONGWHO]=FALSE THEN aePuts('[34m|---+---------------------+---------------------+---------------------+----|[0m\b\n')
  aePuts('[34m`--------------------------------------------------------------------------''[0m\b\n')
 aePuts('\b\n')
ENDPROC

PROC sendOlmPacket(nodenum,msg:PTR TO CHAR,last)
  DEF np: PTR TO mp
  DEF olmMsg:PTR TO jhMessage
  DEF singleNode: PTR TO singlePort
  DEF nodeserverport[15]:STRING

  StringF(nodeserverport,'AEServer.\d',nodenum)
  IF (np:=FindPort(nodeserverport))=NIL THEN RETURN RESULT_FAILURE

  IF(olmMsg:=AllocMem(256,MEMF_ANY OR MEMF_CLEAR))
    olmMsg.command:=SV_INCOMING_MSG
    olmMsg.msg.ln.type:=NT_FREEMSG
    olmMsg.msg.length:=256
    olmMsg.msg.replyport:=0
    
    olmMsg.data:=0
    olmMsg.lineNum:=last
    strCpy(olmMsg.string,msg,200)
  
    PutMsg(np,olmMsg)
  ELSE
    aePuts('Insufficient Memory\b\n')
    RETURN RESULT_FAILURE
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommand0()
  DEF status
  DEF string[32]:STRING
  DEF str[255]:STRING

  IF (checkSecurity(ACS_REMOTE_SHELL)=FALSE)
    RETURN RESULT_NOT_ALLOWED
  ENDIF
  setEnvStat(ENV_SHELL)

  IF(StrLen(cmds.remotePass)>0)
    status:=getPass2('\b\nEnter Remote Shell Password: ',cmds.remotePass,0,30,string)
    IF(status<0) THEN RETURN RESULT_SLEEP_LOGOFF
    IF(status<>RESULT_SUCCESS)
      aePuts('\b\n')
      aePuts('Remote password failed\b\n\b\n')
      StringF(str,'\tRemote password (\s) failed.\n',string)
      callersLog(str)
      RETURN RESULT_FAILURE
		ENDIF

    IF(logonType>=LOGON_TYPE_REMOTE) 
      status:=checkCarrier()
      IF(status=FALSE) THEN RETURN RESULT_SLEEP_LOGOFF
    ENDIF
  ENDIF
  remoteShell()
ENDPROC RESULT_SUCCESS

PROC internalCommand1(params)
  IF (checkSecurity(ACS_ACCOUNT_EDITING)=FALSE)
    RETURN RESULT_NOT_ALLOWED
  ENDIF
  editAccounts(FALSE)
ENDPROC RESULT_SUCCESS
 
PROC internalCommand2(params)
  DEF temp[255]:STRING
  DEF n,loop,fh,stat
  IF (checkSecurity(ACS_LIST_NODES)=FALSE)
    RETURN RESULT_NOT_ALLOWED
  ENDIF

  setEnvStat(ENV_SYSOP)
  aePuts('\b\n')

  parseParams(params)

  IF ListLen(parsedParams)>0
    n:=Val(parsedParams[0])
    StringF(temp,'\sNode\d/Callerslog',cmds.bbsLoc,n)
    displayCallersLog(temp,paramsContains('NS')) 
  ELSE
     loop:=0
     REPEAT
       StringF(temp,'\sNode\d/Callerslog',cmds.bbsLoc,loop)
       IF(fh:=Open(temp,MODE_OLDFILE))>0
         Close(fh)
         StringF(temp,'\d - Callerslog for Node \d\b\n',loop,loop)
         aePuts(temp)
         loop++
       ENDIF
     UNTIL fh=NIL

    aePuts('\b\nWhich node to view? ')
    stat:=lineInput('','',5,INPUT_TIMEOUT,temp)
    IF (stat<0) OR (StrLen(temp)=0)
      aePuts('\b\n')
      RETURN
    ENDIF

    n:=Val(temp)

    StringF(temp,'\sNode\d/Callerslog',cmds.bbsLoc,n)
    IF(fh:=Open(temp,MODE_OLDFILE))>0
      Close(fh)
      StringF(temp,'\d - Callerslog for Node \d\b\n',n,n)
      aePuts(temp)
      StringF(temp,'\sNode\d/Callerslog',cmds.bbsLoc,n)
      displayCallersLog(temp,FALSE)
    ELSE
      aePuts('\b\nNot a valid node!\b\n')
    ENDIF
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommand3(params)
  setEnvStat(ENV_EMACS)
  IF(checkSecurity(ACS_EDIT_DIRS)=FALSE) THEN RETURN RESULT_NOT_ALLOWED
  editDirFile(params)
ENDPROC

PROC internalCommand4(params)
  setEnvStat(ENV_EMACS)
  IF(checkSecurity(ACS_SYSOP_COMMANDS)=FALSE) THEN RETURN RESULT_NOT_ALLOWED
  editAnyFile(params)
ENDPROC RESULT_SUCCESS
  
PROC internalCommand5(params)
  setEnvStat(ENV_SYSOP)
  IF(checkSecurity(ACS_SYSOP_COMMANDS)=FALSE) THEN RETURN RESULT_NOT_ALLOWED
  myDirAnyWhere(params)
ENDPROC RESULT_SUCCESS

PROC internalCommandLT()
  DEF newConf
  IF checkSecurity(ACS_JOIN_CONFERENCE)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  saveMsgPointers(currentConf)

  setEnvStat(ENV_JOIN)
  newConf:=currentConf-1
  WHILE (newConf>0) AND (checkConfAccess(newConf)=FALSE)
    newConf--
  ENDWHILE

  IF newConf<1
    internalCommandJ('')
  ELSE
    joinConf(newConf,FALSE,FALSE)
  ENDIF

ENDPROC RESULT_SUCCESS
  
PROC internalCommandGT()
  DEF newConf
  IF checkSecurity(ACS_JOIN_CONFERENCE)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  saveMsgPointers(currentConf)
  
  setEnvStat(ENV_JOIN)
  newConf:=currentConf+1
  WHILE (newConf<=cmds.numConf) AND (checkConfAccess(newConf)=FALSE)
    newConf++
  ENDWHILE

  IF newConf>cmds.numConf
    internalCommandJ('')
  ELSE
    joinConf(newConf,FALSE,FALSE)
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandQuestionMark()
    IF (loggedOnUser.expert="X")
      checkScreenClear()
      displayScreen(SCREEN_MENU)
    ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandA(params)
  IF checkSecurity(ACS_DOWNLOAD)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_FILES)
  alterFlags(params)
ENDPROC  RESULT_SUCCESS

PROC internalCommandB(params)
  DEF stat,stat2
  DEF str[81]:STRING
  DEF screenFilename[255]:STRING
  DEF fh
  
  IF checkSecurity(ACS_READ_BULLETINS)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_BULLETINS)

  StrCopy(str,confScreenDir)
  StrAdd(str,'Bulletins/BullHelp.txt')
  IF((fh:=Open(str,MODE_OLDFILE)))<=0
     myError(ERR_NO_BULLS)
     RETURN RESULT_SUCCESS
  ENDIF
  Close(fh)

  parseParams(params)
  IF ListLen(parsedParams)>0
    stat:=Val(ListItem(parsedParams,0))
    nonStopDisplayFlag:=paramsContains('NS')
  ELSE
helpAgain:
     StrCopy(str,confScreenDir)
     StrAdd(str,'Bulletins/BullHelp.txt')
     displayFile(str)
inputAgain:
     StringF(str,'Which Bulletin (?)=List, (Enter)=none? ')
     aePuts(str)
     stat2:=lineInput('','',8,INPUT_TIMEOUT,str)
     IF(stat2<0) THEN RETURN stat2
     IF(StrLen(str)=0)
       aePuts('\b\n')
       RETURN RESULT_SUCCESS
     ENDIF
     IF(StrCmp(str,'?')) THEN JUMP helpAgain
     parseParams(str)
     nonStopDisplayFlag:=paramsContains('NS')
     stat:=Val(ListItem(parsedParams,0))
  ENDIF

  StringF(str,'\sBulletins/Bull\d',confScreenDir,stat)
  IF findSecurityScreen(str,screenFilename)
    displayFile(screenFilename)
  ELSE
    StringF(str,'\b\nSorry there is no bulletin #\d\b\n\b\n',stat)
    aePuts(str)
  ENDIF
  JUMP inputAgain
ENDPROC RESULT_SUCCESS

PROC internalCommandC(params)
  IF checkSecurity(ACS_COMMENT_TO_SYSOP)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_MAIL)
  parseParams(params)
ENDPROC commentToSYSOP()

PROC internalCommandCF()
  DEF i,loop=TRUE,editmask
  DEF confNums[255]:STRING
  DEF tempstr[255]:STRING
  DEF c1,c2,c3
  DEF cb: PTR TO confBase
  DEF ch
  DEF stat
  DEF p:PTR TO CHAR
  DEF v

  IF checkSecurity(ACS_CONFFLAGS)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  REPEAT
    sendCLS()
    aePuts('\b\n')
    IF (0)
      aePuts('[32m       M F Z Conference                       M F Z Conference[0m\b\n')
      aePuts('[33m       ~ ~ ~ ~~~~~~~~~~~~~~~~~~~~~~~~~        ~ ~ ~ ~~~~~~~~~~~~~~~~~~~~~~~~~[0m\b\n\b\n')
    ELSE
      aePuts('[32m            M F Z   Conference[0m\b\n')
      aePuts('[33m            ~ ~ ~   ~~~~~~~~~~~~~~~~~~~~~~~~~[0m\b\n\b\n')
    ENDIF

    FOR i:=1 TO cmds.numConf
      IF checkConfAccess(i)
        cb:=ListItem(confBases,i-1)

    
        IF (cb.handle[0] AND MAIL_SCAN_MASK) THEN c1:="*" ELSE c1:=" "

        IF (cb.handle[0] AND FILE_SCAN_MASK) THEN c2:="*" ELSE c2:=" "

        IF (cb.handle[0] AND ZOOM_SCAN_MASK) THEN c3:="*" ELSE c3:=" "

        IF(0)
          StringF(tempstr,' [34m[[0m\z\r\d[3][34m] [36m\c \c \c [0m\l\s[25] ',relConf(i),c1,c2,c3,getConfName(i))
        ELSE
          StringF(tempstr,'   [34m[[0m\z\r\d[3][34m]    [36m\c \c \c   [0m\l\s[25]\b\n',relConf(i),c1,c2,c3,getConfName(i))
        ENDIF
        aePuts(tempstr)
      ENDIF
    ENDFOR

    aePuts('\b\n\b\nEnter Flag Type New [M]ailScan, New [F]ileScan, [Z]oom >: ')
    ch:=readChar(INPUT_TIMEOUT)
    IF (ch="m") OR (ch="M")
      editmask:=4
    ELSEIF (ch="f") OR (ch="F" )
      editmask:=8
    ELSEIF (ch="z") OR (ch="Z")
      editmask:=2
    ELSE
      editmask:=-1
      loop:=FALSE
    ENDIF
    StrCopy(tempstr,' ')
    tempstr[0]:=ch
    aePuts(tempstr)
    aePuts('\b\n')

    IF (editmask<>-1)
      aePuts('Enter Conference Numbers,''*'' toggle all,''-'' All off,''+'' All on >: ')
      stat:=lineInput('','',200,INPUT_TIMEOUT,confNums)
      IF stat<>RESULT_SUCCESS THEN RETURN stat
      
      IF StrLen(confNums)=0 THEN RETURN RESULT_SUCCESS
      
      IF StrCmp(confNums,'+')
        FOR i:=0 TO cmds.numConf-1
          IF checkConfAccess(i+1)
            cb:=ListItem(confBases,i)
            cb.handle[0]:=cb.handle[0] OR editmask
          ENDIF
        ENDFOR
      ELSEIF StrCmp(confNums,'-')
        FOR i:=0 TO cmds.numConf-1
          IF checkConfAccess(i+1)
            cb:=ListItem(confBases,i)
            cb.handle[0]:=cb.handle[0] AND (Not(editmask))
          ENDIF
        ENDFOR
      ELSEIF StrLen(confNums)>0
        p:=confNums
        WHILE((i:=InStr(p,','))<>-1) AND ((p-confNums)<StrLen(confNums))
          IF ((v:=Val(p))>0)
            v:=getInverse(v)
            IF v<=cmds.numConf
              IF checkConfAccess(v)
                cb:=ListItem(confBases,v-1)
                cb.handle[0]:=Eor(cb.handle[0],editmask)
              ENDIF
            ENDIF
          ENDIF
          p:=p+i+1
        ENDWHILE
        IF ((p-confNums)<StrLen(confNums)) AND ((v:=Val(p))>0)
          v:=getInverse(v)
          IF v<=cmds.numConf
            IF checkConfAccess(v)
              cb:=ListItem(confBases,v-1)
              cb.handle[0]:=Eor(cb.handle[0],editmask)
            ENDIF
          ENDIF
        ENDIF
        
      ENDIF
    ENDIF
  UNTIL loop=FALSE
ENDPROC

PROC internalCommandD(cmdcode,params)
  IF checkSecurity(ACS_DOWNLOAD)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_DOWNLOADING)

  beginDLF(cmdcode,params)
ENDPROC RESULT_SUCCESS

PROC internalCommandE(params)
  IF checkSecurity(ACS_ENTER_MESSAGE)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_MAIL)
  parseParams(params)
ENDPROC callMsgFuncs(2,0) ->EnterMSG()
  
PROC internalCommandFS()
  IF checkSecurity(ACS_CONFERENCE_ACCOUNTING)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  fileStatus(0)
ENDPROC RESULT_SUCCESS

PROC internalCommandF(params)
  IF checkSecurity(ACS_FILE_LISTINGS)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  
  setEnvStat(ENV_FILES) 
ENDPROC displayFileList(params);

PROC internalCommandFM(params)
  DEF stat,fLLoop,mystat
  DEF str[200]:STRING,ss[80]:STRING,ray[200]:STRING
  DEF tempfile[256]:STRING
  DEF fcopy = FALSE
  DEF startDir,dirScan,action
  DEF foundfile[12]:STRING
  DEF foundDateStr[20]:STRING

  IF checkSecurity(ACS_EDIT_FILES)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  
  setEnvStat(ENV_FILES) 
  
  lineCount:=0
  nonStopDisplayFlag:=FALSE

  aePuts('\b\n')
  IF(maxDirs=0)
 	  myError(5); ->Sorry();
 	  RETURN RESULT_FAILURE
 	ENDIF

  parseParams(params)

  IF(ListLen(parsedParams)>0)
  	StrCopy(ss,parsedParams[0])
    JUMP fmSkip1
  ENDIF
 
  aePuts('Enter filename to search for: ')
  stat:=lineInput('','',78,INPUT_TIMEOUT,ss)
  IF(stat<0) THEN RETURN RESULT_NO_CARRIER
  IF(StrLen(ss)=0)
    aePuts('\b\n')
    RETURN RESULT_SUCCESS
  ENDIF

fmSkip1:
  UpperStr(ss)
  
  IF(ListLen(parsedParams)>1)
 		stat,startDir,dirScan:=getDirSpan(parsedParams[1])
  ELSE
    stat,startDir,dirScan:=getDirSpan('');      /* chg to "A' to search all dirs */
  ENDIF
 
  IF(stat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
 
  IF(StrLen(ss)>0)
 
 	  fLLoop:=startDir
 	  WHILE(fLLoop<=dirScan)
 		  StrCopy(str,currentConfDir)   /* get BBS conf locale dir */
 		  IF(dirScan<>(-1))                /* add 'DIR' */
 ->(RTS) buff copy
        IF(fLLoop = maxDirs)    /* at upload dir */
          StrAdd(str,'DIR')
 	     	  StringF(ray,'\d',fLLoop)
 		      StrAdd(str,ray)
          StringF(ray,'Scanning directory \d\b\n',fLLoop)
          aePuts(ray)
           /*  sprintf(tempfile,"T:tdir.%d",Cmds->AcLvl[LVL_NODE_NUMBER]);
             /* now copy to T: and use the T: */
             if((FileCopy(str,tempfile))) {
                  strcpy(str,tempfile);
                  fcopy = TRUE;
             }
           */
        ELSE
 			    StrAdd(str,'DIR')
 			    StringF(ray,'\d',fLLoop)      /* add dir Number */
 			    StrAdd(str,ray)               /* add path & name */
 			    StringF(ray,'Scanning directory \d\b\n',fLLoop)
 			    aePuts(ray)
        ENDIF
 			  lineCount++
 	    ELSE
 			  StrAdd(str,'hold/held')
 			  aePuts('\b\nScanning directory HOLD\b\n')
 			ENDIF
 		  stat,action:=maintenanceFileSearch(dirScan=-1,str,ss,foundfile,foundDateStr)
 		  IF(stat<0)
 			  aePuts('\b\n')
        IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
 			  RETURN stat
 			ENDIF

      IF (stat<>RESULT_NOT_FOUND)
          aePuts('\b\n')
          IF (action="D") OR (action="d")
            maintenanceFileDelete(str,dirScan=-1,foundfile)
            IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
            RETURN RESULT_SUCCESS
          ELSEIF (action="M") OR (action="m")
            maintenanceFileMove(str,dirScan=-1,foundfile,foundDateStr)
            IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
            RETURN RESULT_SUCCESS
          ELSEIF (action="V") OR (action="v")
            IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
            IF dirScan=-1
              aePuts('\b\nView option is not available for hold directory\b\n')
            ELSE
              internalCommandV('V',foundfile)
            ENDIF
            RETURN RESULT_SUCCESS
          ELSEIF (action="q") OR (action="q")
            IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
            RETURN RESULT_SUCCESS
          ENDIF      
      ENDIF
           
      fLLoop++
 		  ->if(DirScan!=-1) FLLoop+=1;
 		ENDWHILE
 	ENDIF
  aePuts('\b\n')
  IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
ENDPROC RESULT_SUCCESS

PROC internalCommandG()
  DEF mystat

  IF partUploadOK(0)=RESULT_ABORT THEN RETURN RESULT_SUCCESS
  
    mystat:=checkFlagged()
    IF(mystat=0)
      aePuts('\b\n')
      RETURN RESULT_SUCCESS
    ENDIF
    saveFlagged()
    IF StrLen(historyFolder)>0 THEN saveHistory()
    reqState:=REQ_STATE_LOGOFF
   setEnvStat(ENV_LOGOFF)

ENDPROC RESULT_SUCCESS

PROC internalCommandH(params)
  DEF stat
  DEF tempstr[255]:STRING,screen[255]:STRING
  
  parseParams(params)
  IF ListLen(parsedParams)>0
    nonStopDisplayFlag:=paramsContains('NS')
  ENDIF
  
  StringF(tempstr,'\sBBSHelp',cmds.bbsLoc)
  IF findSecurityScreen(tempstr,screen)
    displayFile(screen)
  ELSE
    aePuts('\b\n\b\nSorry Help is unavailable at this time.\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF
  
ENDPROC RESULT_SUCCESS

PROC internalCommandUpHat(params)
  DEF tempstr[255]:STRING
  DEF screen[255]:STRING
  DEF ch

  StringF(tempstr,'\shelp/\s',cmds.bbsLoc,params)
  WHILE TRUE
    IF findSecurityScreen(tempstr,screen)
      displayFile(screen)
      ch:=doPause()
      IF(ch<0) THEN RETURN ch
      aePuts('\b\n')
      RETURN RESULT_SUCCESS
    ELSE
      IF(StrLen(params)>0)
        params[StrLen(params)-1]:=0
        StringF(tempstr,'\shelp/\s',cmds.bbsLoc,params)
      ELSE
        RETURN RESULT_SUCCESS
      ENDIF
    ENDIF
  ENDWHILE
ENDPROC RESULT_SUCCESS

PROC internalCommandJ(params)
  DEF newConfStr[5]:STRING
  DEF newConf,stat
  IF checkSecurity(ACS_JOIN_CONFERENCE)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  saveMsgPointers(currentConf)
  
  setEnvStat(ENV_JOIN)

  parseParams(params)
  
  newConf:=-1
  IF ListLen(parsedParams)>0
    IF StrLen(parsedParams[0])>0 THEN newConf:=Val(parsedParams[0])
  ENDIF

  newConf:=getInverse(newConf)

  IF (newConf<1) OR (newConf>cmds.numConf)
    displayScreen(SCREEN_JOINCONF)
    stat:=lineInput('Conference Number: ','',5,INPUT_TIMEOUT,newConfStr)
    IF stat<>RESULT_SUCCESS THEN RETURN stat

    IF StrLen(newConfStr)=0 THEN RETURN RESULT_SUCCESS
  
    newConf:=getInverse(Val(newConfStr))
  ENDIF

  IF newConf<1 THEN newConf:=1
  IF newConf>cmds.numConf THEN newConf:=cmds.numConf
  
  IF(checkConfAccess(newConf)=FALSE)
    aePuts('\b\nYou do not have access to the requested conference\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  joinConf(newConf,FALSE,FALSE)
ENDPROC RESULT_SUCCESS

PROC internalCommandM()
  ansiColour:=Not(ansiColour)
ENDPROC RESULT_SUCCESS

PROC internalCommandN(params)
  IF checkSecurity(ACS_FILE_LISTINGS)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  
  setEnvStat(ENV_FILES) 
ENDPROC myNewFiles(params)

PROC internalCommandO()
  DEF result
  DEF string[255]:STRING
  DEF string2[255]:STRING
  DEF filetags

  IF(pagesAllowed=0)
    setEnvStat(ENV_MAIL)
    IF((checkSecurity(ACS_COMMENT_TO_SYSOP)=FALSE)) THEN RETURN RESULT_NOT_ALLOWED
    ->MCIViewSafe=FALSE
    result:=commentToSYSOP()
    ->MCIViewSafe=TRUE
    RETURN result
  ENDIF
  
  IF(pagesAllowed<>-1) THEN pagesAllowed--
  /* no chat unless validated */
  IF((checkSecurity(ACS_PAGE_SYSOP))=FALSE) THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_REQ_CHAT)
  pagedFlag:=1
  
  IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ON_SYSOP_PAGE',string))
    filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,NIL]:LONG
    processMci2(string,string2)
    SystemTagList(string2,filetags)
    END filetags
  ENDIF
  
  IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ASYNC_ON_SYSOP_PAGE',string))
    filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,TRUE,NIL]:LONG
    processMci2(string,string2)
    SystemTagList(string2,filetags)
    END filetags
  ENDIF

  IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_SYSOP_PAGE')) AND (StrLen(mailOptions.sysopEmail)>0)
    StringF(string,'\s: Ami-Express page notification',cmds.bbsName)
    
    StringF(string2,'This is a notification that you were paged by \s.',loggedOnUser.name)
    sendMail(string,string2,FALSE,mailOptions.sysopEmail)
  ENDIF

  result:=RESULT_SUCCESS
  
  IF((sysopAvail=FALSE) AND (checkSecurity(ACS_OVERRIDE_CHAT))=FALSE)
      StringF(string,'\b\nSorry, \s, is not around right now\b\n',cmds.sysopName)
      aePuts(string)
      aePuts('You can use ''C'' to leave a comment.\b\n\b\n')
  ELSE
    result:=ccom()
  ENDIF

ENDPROC result

PROC internalCommandOLM(params)
  DEF nodenumstr[2]:STRING
  DEF msgsent
  DEF tempStr[255]:STRING
  DEF blockOLM
  DEF nodenum
  DEF userstatus
  DEF i
  
  IF((checkSecurity(ACS_OLM))=FALSE) OR (sopt.toggles[TOGGLES_MULTICOM]=FALSE) THEN RETURN RESULT_NOT_ALLOWED
  
  setEnvStat(ENV_ONLINEMSG)
  aePuts('\b\n[34m*[0mOLM MESSAGE SYSTEM[34m*[0m\b\n')

  parseParams(params)
  IF(ListLen(parsedParams)>0)
    StrCopy(nodenumstr,parsedParams[0])
  ELSE
    lineInput('\b\n[32m-[0m OLM to Which Node? [36m[[0mNode [33m#[36m][0m Or [36m[[0mQ[36m][0m To Quit[32m:[0m ','',2,INPUT_TIMEOUT,nodenumstr)
  ENDIF

  IF (StrLen(nodenumstr)=0) OR (strCmpi(nodenumstr,'Q',ALL)) THEN RETURN RESULT_SUCCESS

  fileattach:=FALSE
  aePuts('\b\n')

  IF(ListLen(parsedParams)<2)
    FOR i:=0 TO ListLen(msgBuf)-1
      StrCopy(msgBuf[i],'')
    ENDFOR
    lines:=0
    IF edit()<>RESULT_SUCCESS THEN RETURN RESULT_SUCCESS
  ENDIF

  nodenum:=Val(nodenumstr)

  IF (nodenum<0) OR (nodenum>=MAXNODES)
    userstatus:=-1
    blockOLM:=1
  ELSE
    blockOLM:=FALSE
    ObtainSemaphore(masterNode)
    IF masterNode.myNode[nodenum]<>NIL
      singleNode:=masterNode.myNode[nodenum].s
      IF singleNode<>NIL
        userstatus:=singleNode.status
        blockOLM:=singleNode.misc2[0]
      ENDIF
    ENDIF
    ReleaseSemaphore(masterNode)

    IF blockOLM 
      StringF(tempStr,'\b\n[34m*[0m--[33mNODE [0m\d[33m HAS MESSAGES SUPPRESSED[0m--[34m*[0m\b\n',node)
      aePuts(tempStr)
    ENDIF
  ENDIF

  IF (userstatus<0) OR (blockOLM)
    aePuts('\b\n[34m*[0mOLM UNSUCCESSFUL[34m*[0m\b\n')
    RETURN RESULT_SUCCESS
  ENDIF  

  msgsent:=TRUE

  StringF(tempStr,'\b\n\b\n[34m*[0mOnline Message![0m From Node[32m:[36m( [33m\d[36m )[0m User[32m: [36m[[0m\s[36m][0m\b\n\b\n',node,loggedOnUser.name)
  IF sendOlmPacket(nodenum,tempStr,0)<>RESULT_SUCCESS THEN msgsent:=FALSE
  IF(ListLen(parsedParams)<2)
    FOR i:=0 TO lines-1
      StringF(tempStr,'\s\b\n',msgBuf[i])
      IF sendOlmPacket(nodenum,tempStr,0)<>RESULT_SUCCESS THEN msgsent:=FALSE
    ENDFOR
  ELSE
    StrCopy(tempStr,'')
    FOR i:=1 TO ListLen(parsedParams)-1
      StrAdd(tempStr,parsedParams[i])
      StrAdd(tempStr,' ')
    ENDFOR
    StrAdd(tempStr,'\b\n')
    IF sendOlmPacket(nodenum,tempStr,0)<>RESULT_SUCCESS THEN msgsent:=FALSE
  ENDIF
  StringF(tempStr,'\b\n[34m*[0mPress [36m[[33mReturn[36m][0m To Resume BBS Operations.\b\n\b\n')
  IF sendOlmPacket(nodenum,tempStr,-1)<>RESULT_SUCCESS THEN msgsent:=FALSE

  IF msgsent
    aePuts('[34m*[0mOLM SENT[34m*[0m\b\n')
  ELSE
    aePuts('[34m*[0mOLM UNSUCCESSFUL[34m*[0m')
  ENDIF
  
ENDPROC RESULT_SUCCESS

PROC internalCommandQ()
  IF checkSecurity(ACS_QUIET_NODE)
    quietFlag:=Not(quietFlag)
    sendQuietFlag(quietFlag)
  ELSE
    RETURN RESULT_NOT_ALLOWED
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandR(params)
  IF checkSecurity(ACS_READ_MESSAGE)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_MAIL)
  parseParams(params)

  getMailStatFile()
ENDPROC callMsgFuncs(MAIL_READ,0)

PROC internalCommandRL()
  IF checkSecurity(ACS_RELOGON)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  relogon:=TRUE
  internalCommandG()
ENDPROC RESULT_SUCCESS

PROC internalCommandS()
  DEF tmp[150]:STRING
  DEF tmp2[25]:STRING
  DEF n,i
 
  IF checkSecurity(ACS_DISPLAY_USER_STATS)=FALSE THEN RETURN RESULT_NOT_ALLOWED
 
  setEnvStat(ENV_STATS)

  aePuts('\b\n')

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'USERNUMBER_LOGIN')
    StringF(tmp,'[32mUser Number[33m:[0m \d\b\n',loggedOnUser.slotNumber)
    aePuts(tmp)
  ENDIF
  IF sopt.toggles[TOGGLES_CONFRELATIVE]=FALSE
    StringF(tmp,'[32mArea Name  [33m:[0m \s\b\n',loggedOnUser.conferenceAccess)
    aePuts(tmp)
  ENDIF
  StringF(tmp,'[32mCaller Num.[33m:[0m \d\b\n',callerNum)
  aePuts(tmp)
  formatLongDateTime(loggedOnUser.timeLastOn,tmp2)
  StringF(tmp,'[32mLst Date On[33m:[0m \s\b\n',tmp2)
  aePuts(tmp)
  StringF(tmp,'[32mSecurity Lv[33m:[0m \d\b\n',loggedOnUser.secStatus)
  aePuts(tmp)
  StringF(tmp,'[32m# Times On [33m:[0m \d\b\n',loggedOnUser.timesCalled AND $FFFF)
  aePuts(tmp)
  StringF(tmp,'[32mMsgs Posted[33m:[0m \d\b\n',loggedOnUser.messagesPosted AND $FFFF)
  aePuts(tmp)
  StringF(tmp,'[32mOnline Baud[33m:[0m \d\b\n',onlineBaud)
  aePuts(tmp)
  StringF(tmp,'[32mRate CPS UP[33m:[0m \d\b\n',loggedOnUserKeys.upCPS AND $FFFF)
  aePuts(tmp)
  StringF(tmp,'[32mRate CPS DN[33m:[0m \d\b\n',loggedOnUserKeys.dnCPS AND $FFFF)
  aePuts(tmp)
  IF(loggedOnUserKeys.userFlags AND USER_SCRNCLR)
    StrCopy(tmp,'[32mScreen  Clr[33m:[0m YES\b\n')
  ELSE
    StrCopy(tmp,'[32mScreen  Clr[33m:[0m NO\b\n')
  ENDIF
  aePuts(tmp)
  StringF(tmp,'[32mProtocol   [33m:[0m \s\b\n',xprTitle[loggedOnUser.xferProtocol])
  aePuts(tmp)

  IF (checkSecurity(ACS_SHOW_PAYMENTS)) AND (loggedOnUser.creditDays>0)
    IF creditAccountEnabled(loggedOnUser)
      formatLongDate(loggedOnUser.creditStartDate+Mul(loggedOnUser.creditDays,86400),tmp2)
      StringF(tmp,'[32mCredit Account Expires[33m:[0m \s\b\n',tmp2)
      aePuts(tmp)
    ELSE
      aePuts('[31mCredit Account has EXPIRED[0m\b\n')
    ENDIF
  ENDIF

  IF(pagesAllowed<>-1)
    StringF(tmp,'[32mSysop Pages Remaining[33m:[0m \d\b\n',pagesAllowed)
    aePuts(tmp)
  ENDIF

  aePuts('\b\n')
  fileStatus(1)
ENDPROC RESULT_SUCCESS

PROC internalCommandRZ(cmdcode,params)
  IF checkSecurity(ACS_UPLOAD)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_UPLOADING)

  uploadaFile(1,cmdcode,params)
ENDPROC RESULT_SUCCESS

PROC internalCommandT()
  DEF datestring[20]:STRING
  DEF timestring[20]:STRING
  DEF dt : datetime

  DateStamp(dt.stamp)

  dt.format:=FORMAT_USA
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=datestring
  dt.strtime:=timestring

  IF DateToStr(dt)
    aePuts('\b\nIt is ')
    aePuts(datestring)
    aePuts(' ')
    aePuts(timestring)
    aePuts('\b\n')
  ELSE
    aePuts('Unable to get system time\b\n')
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandU(cmdcode,params)
  IF checkSecurity(ACS_UPLOAD)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_UPLOADING)

  uploadaFile(0,cmdcode,params)
ENDPROC RESULT_SUCCESS

PROC internalCommandUS()
  IF checkSecurity(ACS_SYSOP_COMMANDS)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_UPLOADING)

  sysopUpload()
ENDPROC RESULT_SUCCESS

PROC internalCommandV(cmdcode,params)
  IF checkSecurity(ACS_VIEW_A_FILE)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_VIEWING)
  viewAFile(cmdcode,params)
ENDPROC RESULT_SUCCESS

PROC internalCommandW()
  DEF stat,option
  DEF str[100]:STRING
  DEF str2[100]:STRING
  DEF temp
  
  IF checkSecurity(ACS_EDIT_USER_INFO)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_STATS)
  WHILE (TRUE)
      IF(logonType>=LOGON_TYPE_REMOTE)
        stat:=checkCarrier()
        IF(stat=FALSE) THEN RETURN RESULT_SLEEP_LOGOFF
      ENDIF

     /* FormFeed Line since user indicates he wants this option */
     checkScreenClear()

      aePuts('\b\n')

      aePuts('                       [34m*[0m--[33mUSER CONFIGURATION[0m--[34m*[0m\b\n')
      aePuts('\b\n')

      IF((checkSecurity(ACS_EDIT_USER_NAME))=FALSE)
        aePuts('[34m[[0m  1[34m][31m [DISABLED][0m\b\n')
      ELSE
        StringF(str,'[34m[[0m  1[34m][35m LOGIN NAME.............. [33m\s[0m\b\n',loggedOnUser.name)
        aePuts(str)
      ENDIF

      IF((checkSecurity(ACS_EDIT_REAL_NAME))=FALSE)
        aePuts('[34m[[0m  2[34m][31m [DISABLED][0m\b\n')
      ELSE
        StringF(str,'[34m[[0m  2[34m][35m REAL NAME............... [33m\s[0m\b\n',loggedOnUserMisc.realName)
        aePuts(str)
      ENDIF

      IF((checkSecurity(ACS_EDIT_INTERNET_NAME))=FALSE)
        aePuts('[34m[[0m  3[34m][31m [DISABLED][0m\b\n')
      ELSE
        StringF(str,'[34m[[0m  3[34m][35m INTERNET NAME........... [33m\s[0m\b\n',loggedOnUserMisc.internetName)
        aePuts(str)
      ENDIF

      IF((checkSecurity(ACS_EDIT_USER_LOCATION))=FALSE)
        aePuts('[34m[[0m  4[34m][31m [DISABLED][0m\b\n')
      ELSE
        StringF(str,'[34m[[0m  4[34m][35m LOCATION................ [33m\s[0m\b\n',loggedOnUser.location)
        aePuts(str)
      ENDIF

      IF((checkSecurity(ACS_EDIT_PHONE_NUMBER))=FALSE)
        aePuts('[34m[[0m  5[34m][31m [DISABLED][0m\b\n')
      ELSE
        StringF(str,'[34m[[0m  5[34m][35m PHONE NUMBER............ [33m\s[0m\b\n',loggedOnUser.phoneNumber)
        aePuts(str)
      ENDIF

      IF((checkSecurity(ACS_EDIT_PASSWORD))=FALSE)
        aePuts('[34m[[0m  6[34m][31m [DISABLED][0m\b\n')
      ELSE
        StringF(str,'[34m[[0m  6[34m][35m PASSWORD................ [36mENCRYPTED[0m\b\n')
        aePuts(str)
      ENDIF

      StringF(str,'[34m[[0m  7[34m][35m LINES PER SCREEN........ [33m\d[0m\b\n',loggedOnUser.lineLength)
      aePuts(str)

      temp:=ListLen(computerEntries)
      IF temp=0
        StringF(str,'[34m[[0m  8[34m][35m COMPUTER................ [33m[0m\b\n')
      ELSEIF(loggedOnUser.secBulletin>=temp)
        StringF(str,'[34m[[0m  8[34m][35m COMPUTER................ [33mNOT VALID![0m\b\n')
      ELSE
        StringF(str,'[34m[[0m  8[34m][35m COMPUTER................ [33m\s[0m\b\n',computerTypes[loggedOnUser.secBulletin])
      ENDIF
      aePuts(str)

      temp:=ListLen(screenTypeTitle)
      IF temp=0
        StringF(str,'[34m[[0m  9[34m][35m SCREEN TYPE............. [33m[0m\b\n')
      ELSEIF(loggedOnUser.screenType>=ListLen(screenTypeTitle))
        StringF(str,'[34m[[0m  9[34m][35m SCREEN TYPE............. [33mNOT VALID![0m\b\n')
      ELSE
        StringF(str,'[34m[[0m  9[34m][35m SCREEN TYPE............. [33m\s[0m\b\n',screenTypeTitle[loggedOnUser.screenType])
      ENDIF
      aePuts(str)

      IF (loggedOnUserKeys.userFlags AND USER_SCRNCLR) 
        StringF(str,'[34m[[0m 10[34m][35m SCREEN CLEAR............ [32mYES[0m\b\n')
      ELSE
        StringF(str,'[34m[[0m 10[34m][35m SCREEN CLEAR............ [37mNO[0m\b\n')
      ENDIF
      aePuts(str)

      IF((checkSecurity(ACS_XPR_SEND)) OR (checkSecurity(ACS_XPR_RECEIVE)))
        temp:=ListLen(xprTitle)
        IF temp=0
          StringF(str,'[34m[[0m 11[34m][35m TRANSFER PROTOCOL....... [33m[0m\b\n')
        ELSEIF(loggedOnUser.xferProtocol>=temp)
          StringF(str,'[34m[[0m 11[34m][35m TRANSFER PROTOCOL....... [33mNOT VALID![0m\b\n')
        ELSE
          StringF(str,'[34m[[0m 11[34m][35m TRANSFER PROTOCOL....... [33m\s[0m\b\n',xprTitle[loggedOnUser.xferProtocol])
        ENDIF
        aePuts(str)
      ELSE
        aePuts('[34m[[0m 11[34m][31m [DISABLED][0m\b\n')
      ENDIF

      option:=loggedOnUser.editorType
      IF(checkSecurity(ACS_FULL_EDIT))
        SELECT option
            CASE 0
              StringF(str,'[34m[[0m 12[34m][35m EDITOR TYPE............. [33mPROMPT[0m\b\n')
            CASE 1
              StringF(str,'[34m[[0m 12[34m][35m EDITOR TYPE............. [33mLINE EDITOR[0m\b\n')
            DEFAULT
              StringF(str,'[34m[[0m 12[34m][35m EDITOR TYPE............. [33mFULLSCREEN EDITOR[0m\b\n')
        ENDSELECT
      ELSE
        aePuts('[34m[[0m 12[34m][31m [DISABLED][0m\b\n')
      ENDIF

      option:=loggedOnUser.zoomType
      IF(checkSecurity(ACS_ZOOM_MAIL))
        SELECT option
            CASE 1
              StringF(str,'[34m[[0m 13[34m][35m ZOOM TYPE............... [33mASCII[0m\b\n')
            CASE 0
              StringF(str,'[34m[[0m 13[34m][35m ZOOM TYPE............... [33mQWK[0m\b\n')
        ENDSELECT
        aePuts(str)
    ELSE
        aePuts('[34m[[0m 13[34m][31m [DISABLED][0m\b\n')
      ENDIF

      IF(checkSecurity(ACS_OLM))
        IF allowOLM
              StringF(str,'[34m[[0m 14[34m][35m AVAILABLE FOR CHAT/OLM.. [32mYES[0m\b\n')
        ELSE
              StringF(str,'[34m[[0m 14[34m][35m AVAILABLE FOR CHAT/OLM.. [37mNO[0m\b\n')
        ENDIF
      ELSE
        aePuts('[34m[[0m 14[34m][31m [DISABLED][0m\b\n')
      ENDIF

     aePuts(str)
     aePuts('\b\n')

    aePuts('Which to change <CR>=QUIT ? ')

    stat:=lineInput('','',2,INPUT_TIMEOUT,str)
    IF(stat<0) THEN RETURN stat
    IF (StrLen(str)=0)
      aePuts('\b\n')
      saveAccount(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,0,0)
      checkUserOnLine(loggedOnUser,0)
      RETURN RESULT_SUCCESS
    ENDIF

    aePuts('\b\n')
    option:=Val(str)

    SELECT option
       CASE 1
          ->EDIT USER NAME
         IF (checkSecurity(ACS_EDIT_USER_NAME)=FALSE) THEN JUMP cant
         loop1:
         aePuts('Name: ')
         StrCopy(str,loggedOnUser.name,31)
         stat:=lineInput('',str,30,INPUT_TIMEOUT,str)
         IF(stat<0) THEN RETURN stat
         IF(strCmpi(loggedOnUserKeys.userName,str,ALL)) THEN JUMP cant
         IF(stat:=checkIfNameAllowed(str)) THEN JUMP loop1
         StrCopy(str2,str)
         aePuts('\b\nChecking for duplicate name...')
         stat:=checkForAst(str2)
         IF(stat) 
           aePuts('No wildcards allowed in a name.\b\n\b\n')
           JUMP loop1
         ENDIF
         stat:=findUserFromName(1,NAME_TYPE_USERNAME,str2,tempUser,tempUserKeys,tempUserMisc)
         IF(stat<>0)
           aePuts('Already in use!, try another.\b\n\b\n')
           JUMP loop1
         ENDIF
         aePuts('Ok!\b\n')
         strCpy(loggedOnUser.name,str,31)
         UpperStr(str)
         strCpy(loggedOnUserKeys.userName,str,31)
         saveAccount(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,0,0)
       CASE 2
          ->EDIT REAL NAME
         IF (checkSecurity(ACS_EDIT_REAL_NAME)=FALSE) THEN JUMP cant
         aePuts('Real Name: (Alpha Numeric) ')
         StrCopy(str,loggedOnUserMisc.realName,26)
         stat:=lineInput('',str,25,INPUT_TIMEOUT,str)
         IF(stat<0) THEN RETURN stat
         IF(strCmpi(loggedOnUserMisc.realName,str,ALL)) THEN JUMP cant
         aePuts('\b\nChecking for duplicate name...')
         stat:=checkForAst(str)
         IF(stat) 
           aePuts('No wildcards allowed in a name.\b\n\b\n')
           JUMP loop1
         ENDIF
         stat:=findUserFromName(1,NAME_TYPE_REALNAME,str,tempUser,tempUserKeys,tempUserMisc)
         IF(stat<>0)
           aePuts('Already in use!, try another.\b\n\b\n')
           JUMP loop1
         ENDIF
         aePuts('Ok!\b\n')
         strCpy(loggedOnUserMisc.realName,str,26)
       CASE 3
          ->EDIT INTERNET NAME
         IF (checkSecurity(ACS_EDIT_INTERNET_NAME)=FALSE) THEN JUMP cant
         aePuts('Internet Name: (Alpha Numeric No Spaces) ')
         StrCopy(str,loggedOnUserMisc.internetName,10)
         stat:=lineInput('',str,9,INPUT_TIMEOUT,str)
         IF(stat<0) THEN RETURN stat
         IF(strCmpi(loggedOnUserMisc.realName,str,ALL)) THEN JUMP cant
         aePuts('\b\nChecking for duplicate name...')
         stat:=checkForAst(str)
         IF(stat) 
           aePuts('No wildcards allowed in a name.\b\n\b\n')
           JUMP loop1
         ENDIF
         stat:=findUserFromName(1,NAME_TYPE_INTERNETNAME,str,tempUser,tempUserKeys,tempUserMisc)
         IF(stat<>0)
           aePuts('Already in use!, try another.\b\n\b\n')
           JUMP loop1
         ENDIF
         aePuts('Ok!\b\n')
         strCpy(loggedOnUserMisc.internetName,str,10)
       CASE 4
          ->EDIT LOCATION
         IF (checkSecurity(ACS_EDIT_USER_LOCATION)=FALSE) THEN JUMP cant
         aePuts('From: ')
         StrCopy(str,loggedOnUser.location,30)
         stat:=lineInput('',str,29,INPUT_TIMEOUT,str)
         IF(stat<0) THEN RETURN stat
         IF(StrLen(str)=0) THEN JUMP cant
         strCpy(loggedOnUser.location,str,30)
       CASE 5
          ->EDIT PHONE NUMBER
         IF (checkSecurity(ACS_EDIT_PHONE_NUMBER)=FALSE) THEN JUMP cant
         aePuts('Phone: ')
         StrCopy(str,loggedOnUser.phoneNumber,13)
         stat:=lineInput('',str,12,INPUT_TIMEOUT,str)
         IF(stat<0) THEN RETURN stat
         IF(StrLen(str)=0) THEN JUMP cant
         strCpy(loggedOnUser.phoneNumber,str,13)
       CASE 6
          ->EDIT PASSWORD
         IF (checkSecurity(ACS_EDIT_PASSWORD)=FALSE) THEN JUMP cant
         aePuts('Password: ')
         stat:=lineInput('','',50,INPUT_TIMEOUT,str)
         IF(stat<0) THEN RETURN stat
         IF(StrLen(str)=0) THEN JUMP cant
         UpperStr(str)
         stat:=calcPasswordHash(str)
         StringF(str,'new hash: \h',stat)
         debugLog(LOG_DEBUG,str)
         loggedOnUser.pwdHash:=stat
       CASE 7
          ->EDIT NUMBER OF SCREEN LINES
          REPEAT
            stat:=numberOfLinesTest()
            IF(stat<0) THEN RETURN stat
          UNTIL stat=RESULT_SUCCESS
       CASE 8
          ->EDIT COMPUTER
          IF((ListLen(computerEntries)>0))
            IF (stat:=chooseComputer()) 
              IF(stat<0) THEN RETURN stat
            ENDIF 
          ENDIF
       CASE 9
          ->EDIT SCREEN TYPE
          IF(ListLen(screenTypeTitle)>0)
            IF (stat:=chooseScreenType())
              IF(stat<0) THEN RETURN stat
            ENDIF
          ENDIF
       CASE 10
          ->EDIT SCREEN CLEAR
          loggedOnUserKeys.userFlags:=Eor(loggedOnUserKeys.userFlags,USER_SCRNCLR)
       CASE 11
          ->EDIT TRANSFER PROTOCOL
          IF(ListLen(xprTitle)>0)
            IF (stat:=chooseProtocol())
              IF(stat<0) THEN RETURN stat
            ENDIF
          ENDIF
       CASE 12
          ->EDIT EDITOR TYPE
        loggedOnUser.editorType:=loggedOnUser.editorType+1
        IF loggedOnUser.editorType=3 THEN loggedOnUser.editorType:=0
       CASE 13
          ->EDIT ZOOM MAIL 
          loggedOnUser.zoomType:=((loggedOnUser.zoomType+1) AND 1)
       CASE 14
          ->EDIT AVAILABLE FOR CHAT/OLM 
          allowOLM:=Not(allowOLM)
    ENDSELECT
  
   cant:
  ENDWHILE
ENDPROC RESULT_SUCCESS

PROC internalCommandWHO()
  IF (checkSecurity(ACS_WHO_IS_ONLINE) AND (sopt.toggles[TOGGLES_MULTICOM]<>0))
    setEnvStat(ENV_DOORS)
    who(0)
  ELSE
    RETURN RESULT_NOT_ALLOWED
  ENDIF
  
ENDPROC RESULT_SUCCESS

PROC internalCommandWHD()
  IF (checkSecurity(ACS_WHO_IS_ONLINE) AND (sopt.toggles[TOGGLES_MULTICOM]<>0))
    setEnvStat(ENV_DOORS)
    who(1)
  ELSE
    RETURN RESULT_NOT_ALLOWED
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandX()
    IF loggedOnUser.expert="X" 
      aePuts('\b\nExpert mode disabled\b\n')
      loggedOnUser.expert:="N"
    ELSE
      aePuts('\b\nExpert mode enabled\b\n')
      loggedOnUser.expert:="X"
    ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandZ(params)
  DEF stat,fLLoop,mystat
  DEF str[200]:STRING,ss[80]:STRING,ray[200]:STRING
  DEF tempfile[256]:STRING
  DEF fcopy = FALSE
  DEF startDir,dirScan

  IF((checkSecurity(ACS_ZIPPY_TEXT_SEARCH)))=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_FILES)
  
  lineCount:=0
  nonStopDisplayFlag:=FALSE

  aePuts('\b\n')
  IF(maxDirs=0)
 	  myError(5); ->Sorry();
 	  RETURN RESULT_FAILURE
 	ENDIF

  ->dupy:=0
  parseParams(params)

  IF(ListLen(parsedParams)>0)
  	StrCopy(ss,parsedParams[0])
    JUMP zSkip1
  ENDIF
 
  aePuts('Enter string to search for: ')
  stat:=lineInput('','',78,INPUT_TIMEOUT,ss)
  IF(stat<0) THEN RETURN RESULT_NO_CARRIER
  IF(StrLen(ss)=0)
    aePuts('\b\n')
    RETURN RESULT_SUCCESS
  ENDIF

zSkip1:
  UpperStr(ss)
  
  IF(ListLen(parsedParams)>1)
 		stat,startDir,dirScan:=getDirSpan(parsedParams[1])
  ELSE
    stat,startDir,dirScan:=getDirSpan('');      /* chg to "A' to search all dirs */
  ENDIF
 
  IF(stat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
 
  nonStopDisplayFlag:=paramsContains('NS')
 
  IF(StrLen(ss)>0)
 
 	  fLLoop:=startDir
 	  WHILE(fLLoop<=dirScan)
 		  StrCopy(str,currentConfDir)   /* get BBS conf locale dir */
 		  IF(dirScan<>(-1))                /* add 'DIR' */
 ->(RTS) buff copy
        IF(fLLoop = maxDirs)    /* at upload dir */
          StrAdd(str,'DIR')
 	     	  StringF(ray,'\d',fLLoop)
 		      StrAdd(str,ray)
          StringF(ray,'Scanning directory \d\b\n',fLLoop)
          aePuts(ray)
           /*  sprintf(tempfile,"T:tdir.%d",Cmds->AcLvl[LVL_NODE_NUMBER]);
             /* now copy to T: and use the T: */
             if((FileCopy(str,tempfile))) {
                  strcpy(str,tempfile);
                  fcopy = TRUE;
             }
           */
        ELSE
 			    StrAdd(str,'DIR')
 			    StringF(ray,'\d',fLLoop)      /* add dir Number */
 			    StrAdd(str,ray)               /* add path & name */
 			    StringF(ray,'Scanning directory \d\b\n',fLLoop)
 			    aePuts(ray)
        ENDIF
 			  lineCount++
 	    ENDIF 
 			IF(dirScan=-1) 
 			  StrAdd(str,'hold/held')
 			  aePuts('Scanning directory HOLD\b\n')
 			ENDIF
 		  stat:=zippy(str,ss)
 		  IF(stat<0)
 			  aePuts('\b\n')
        IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
 			  RETURN stat
 			ENDIF
           
      fLLoop++
 		  ->if(DirScan!=-1) FLLoop+=1;
 		ENDWHILE
 	ENDIF
  aePuts('\b\n')
  IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
ENDPROC RESULT_SUCCESS

->#define ln(x,y) current=myzip+(y*100)+x;

PROC getDirSpan(pass:PTR TO CHAR)
  DEF str[200]:STRING
  DEF mystat
  DEF dirScan=0,startDir=0

  IF(StrLen(pass)=0)
    IF loggedOnUser.secStatus>200
      StringF(str,'Directories: (1-\d), (A)ll, (U)pload, (H)old, (Enter)=none? ',maxDirs)
    ELSE
      StringF(str,'Directories: (1-\d), (A)ll, (U)pload, (Enter)=none? ',maxDirs)
    ENDIF
 	  aePuts(str)
	  mystat:=lineInput('','',8,INPUT_TIMEOUT,str)
	  IF(mystat<0) THEN RETURN RESULT_NO_CARRIER
	  IF(StrLen(str)=0)
		  aePuts('\b\n')
		  RETURN RESULT_FAILURE,startDir,dirScan
		ENDIF
	ELSE
	  StrCopy(str,pass)
  ENDIF
 
->  gnsflag=CheckForNS(str);             /* check for Non-Stop */

  IF((str[0]="U") OR (str[0]="u"))   /* Scan only upload directory */
	  dirScan:=maxDirs
	  startDir:=dirScan
	  JUMP mNCont
 	ENDIF
  IF((str[0]="A") OR (str[0]="a"))                /* scan all dirs */
	  dirScan:=maxDirs
	  startDir:=1
	  JUMP mNCont
 	ENDIF
  IF((str[0]="L") OR (str[0]="l"))
    dirScan:=0
    startDir:=0
	  JUMP mNCont
  ENDIF
  IF(((str[0]="H") OR (str[0]="h")) AND (loggedOnUser.secStatus>200)) 
	  dirScan:=-1
	  startDir:=-1
	  JUMP mNCont
	ENDIF
  ->strcat(str," ");
  dirScan:=Val(str)
  ->sscanf(str,"%d",&DirScan);
  IF((dirScan>maxDirs) OR (dirScan<1))
	  aePuts('No such directory.\b\n\b\n')
	  RETURN RESULT_FAILURE
 	ENDIF
  startDir:=dirScan

mNCont:
->  nonStopDisplayFlag:=CheckForNS(str);
ENDPROC RESULT_SUCCESS,startDir,dirScan

PROC maintenanceFileDelete(dirname:PTR TO CHAR, srchold, fname:PTR TO CHAR)
  DEF oldDirName[255]:STRING
  DEF fh1,fh2
  DEF dirline[255]:STRING
  DEF compareFname[255]:STRING
  DEF padfname[255]:STRING
  DEF path[255]:STRING
  DEF found,drivenum

    StrCopy(padfname,fname)
    UpperStr(padfname)

    ->pad fname to 12 charactesr
    StrAdd(padfname,'            ')
    SetStr(padfname,12)

    StrCopy(path,dirname)
    getFileName(path)      ->get the actual name for the file so we can preserve the casing
    StringF(dirname,'\s\s',currentConfDir,path)

    StrCopy(oldDirName,dirname)
    StrAdd(oldDirName,'.old')

    aePuts('\b\nRemoving from directory list, please wait..')

    DeleteFile(oldDirName)

    IF Rename(dirname,oldDirName) = FALSE
      aePuts('\b\nError during operation, delete operation aborted.\b\n')
      RETURN
    ENDIF
    
    IF (fh1:=Open(dirname,MODE_NEWFILE))>0
      IF (fh2:=Open(oldDirName,MODE_OLDFILE))>0
        found:=0
        WHILE(Fgets(fh2,dirline,255)<>NIL)
          IF(dirline[0]<>" ")
            StrCopy(compareFname,dirline,12)
            UpperStr(compareFname)
            IF(StrCmp(compareFname,padfname)) THEN found:=1 ELSE found:=0
          ENDIF

          IF found=0
            Fputs(fh1,dirline)
          ENDIF
        ENDWHILE

        Close(fh1)
        Close(fh2)
        DeleteFile(oldDirName)

        IF srchold
          aePuts('\b\nRemoving from hold folder, please wait..')
          StringF(path,'\sHold/\s',currentConfDir,fname)
          DeleteFile(path)
        ELSE
          aePuts('\b\nRemoving from download folder, please wait..')
          drivenum:=1
          StringF(path,'DLPATH.\d',drivenum++)
          WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,path))
            StrAdd(path,fname)
            DeleteFile(path)
            StringF(path,'DLPATH.\d',drivenum++)
          ENDWHILE
        ENDIF
        aePuts('\b\n\b\nDelete operation complete \b\n')

      ELSE
        Close(fh1)
        DeleteFile(dirname)

        ->put the old file back
        Rename(oldDirName,dirname)
        aePuts('\b\nError reading directory list, delete operation aborted.\b\n')
      ENDIF
    ELSE
      ->put the old file back
      Rename(oldDirName,dirname)
      aePuts('\b\nError creating the new directory list, delete operation aborted.\b\n')
    ENDIF

ENDPROC

PROC maintenanceFileMove(dirname:PTR TO CHAR, srchold, fname:PTR TO CHAR,datestr:PTR TO CHAR)
  DEF oldDirName[255]:STRING
  DEF oldDestDirName[255]:STRING
  DEF fh1,fh2,fh3,fh4
  DEF dirline[255]:STRING
  DEF dirline2[255]:STRING
  DEF tempstr[255]:STRING
  DEF destFile[255]:STRING
  DEF destDate[20]:STRING
  DEF compareFname[255]:STRING
  DEF padfname[255]:STRING
  DEF path[255]:STRING
  DEF found,drivenum
  DEF destConfStr[255]:STRING
  DEF destDirStr[255]:STRING
  DEF d1,d2,brk,filemoved,status,n
  DEF destConf,destDir,stat,maxConfDir

  REPEAT
    stat:=lineInput('\b\nConference Number to move to (L to List): ','',5,INPUT_TIMEOUT,destConfStr)
    IF stat<>RESULT_SUCCESS THEN RETURN stat

    IF StrLen(destConfStr)=0 THEN RETURN RESULT_SUCCESS

    IF ((StrCmp(destConfStr,'L')) OR (StrCmp(destConfStr,'l')))
      aePuts('\b\n')
      aePuts('                                 [32mConference List\b\n')
      aePuts('\b\n')
      processMciCmd('~CL|',4,0)
      n:=FALSE
    ELSE
      n:=TRUE
    ENDIF
  UNTIL n
  
  datestr[2]:=" "
  datestr[5]:=" "
  d1:=getDateCompareVal(datestr)

  destConf:=getInverse(Val(destConfStr))

  IF destConf<1 THEN destConf:=1
  IF destConf>cmds.numConf THEN destConf:=cmds.numConf
  
  IF(checkConfAccess(destConf)=FALSE)
    aePuts('\b\nYou do not have access to the requested conference\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  StringF(tempstr,'\b\nYou have chosen conference: \s\b\n',getConfName(destConf))
  aePuts(tempstr)

  maxConfDir:=readToolTypeInt(TOOLTYPE_CONF,destConf,'NDIRS')

  StringF(tempstr,'\b\nDirectory to move to: (1-\d), (A)uto, (Enter)=abort? ',maxConfDir)
  aePuts(tempstr)
  stat:=lineInput('','',5,INPUT_TIMEOUT,destDirStr)

  IF stat<>RESULT_SUCCESS THEN RETURN stat

  IF StrLen(destDirStr)=0 THEN RETURN RESULT_SUCCESS

  IF (destDirStr[0]="A") OR (destDirStr[0]="a")
    destDir:=-1
    stat:=maxConfDir
    WHILE (destDir=-1) AND (stat>0)
      StringF(path,'\sDIR\d',getConfLocation(destConf),stat)
      IF (fh1:=Open(path,MODE_OLDFILE))>0
        Fgets(fh1,dirline,255)
        parseParams(dirline)
        FOR n:=2 TO 4
          StrCopy(destDate,parsedParams[n])
          IF (StrLen(destDate)=8) AND (destDate[2]="-") AND (destDate[5]="-")
            destDate[2]:=" "
            destDate[5]:=" "
            d2:=getDateCompareVal(destDate)
          ENDIF
        ENDFOR
        IF d1>=d2 THEN destDir:=stat

        Close(fh1)
      ENDIF
      stat--
    ENDWHILE
    IF destDir=-1 THEN destDir:=1
  ELSE
    destDir:=Val(destDirStr)
    IF (destDir<1) OR (destDir>maxConfDir) THEN RETURN RESULT_SUCCESS
  ENDIF

  StrCopy(padfname,fname)  
  UpperStr(padfname)

  ->pad fname to 12 charactesr
  StrAdd(padfname,'            ')
  SetStr(padfname,12)

  StringF(path,'\sDIR\d',getConfLocation(destConf),destDir)
  getFileName(path)      ->get the actual name for the file so we can preserve the casing
  StringF(destDirStr,'\s\s',getConfLocation(destConf),path)

  StrCopy(path,dirname)
  getFileName(path)      ->get the actual name for the file so we can preserve the casing
  StringF(dirname,'\s\s',currentConfDir,path)

  StrCopy(oldDirName,dirname)
  StrAdd(oldDirName,'.old')

  StrCopy(oldDestDirName,destDirStr)
  StrAdd(oldDestDirName,'.old')

  aePuts('\b\nUpdating directory list, please wait..')

  DeleteFile(oldDirName)
  IF Rename(dirname,oldDirName)=FALSE
    aePuts('\b\nError accessing the directory list, move operation aborted.\b\n')
    RETURN
  ENDIF

  DeleteFile(oldDestDirName)
  IF Rename(destDirStr,oldDestDirName)=FALSE
    Rename(oldDirName,dirname)
    aePuts('\b\nError accessing the destination directory list, move operation aborted.\b\n')
    RETURN
  ENDIF
   
  IF (fh1:=Open(dirname,MODE_NEWFILE))>0
    IF (fh2:=Open(oldDirName,MODE_OLDFILE))>0
      IF (fh3:=Open(destDirStr,MODE_NEWFILE))>0
        IF (fh4:=Open(oldDestDirName,MODE_OLDFILE))>0
          found:=0
          WHILE(Fgets(fh2,dirline,255)<>NIL)
            IF(dirline[0]<>" ")
              StrCopy(compareFname,dirline,12)
              UpperStr(compareFname)
              IF(StrCmp(compareFname,padfname))
                found:=1
                brk:=FALSE
                ->we've found our file in the source dir, scan the dest dir for the correct position to put it
                WHILE(Fgets(fh4,dirline2,255)<>NIL)
                  IF(dirline2[0]<>" ")

                    parseParams(dirline2)
                    
                    FOR n:=2 TO 4
                      StrCopy(destDate,parsedParams[n])
                      IF (StrLen(destDate)=8) AND (destDate[2]="-") AND (destDate[5]="-")
                        destDate[2]:=" "
                        destDate[5]:=" "
                        d2:=getDateCompareVal(destDate)
                      ENDIF
                    ENDFOR
                    brk:=(d2>=d1)
                  ENDIF
                  EXIT brk
                  ->copy the line from the old dest dir to the new dest dir
                  Fputs(fh3,dirline2)
                ENDWHILE
              ELSE
                IF (found=1)
                  ->we've found the end of the file being moved in the source dir, copy the remainder of the dest dir over
                  IF brk THEN Fputs(fh3,dirline2)
                  WHILE(Fgets(fh4,dirline2,255)<>NIL)
                    Fputs(fh3,dirline2)
                  ENDWHILE
                  found:=0
                ENDIF
              ENDIF
            ENDIF

            IF found=1
              ->copy the line from the old source dir to the new dest dir
              Fputs(fh3,dirline)
            ELSE
              ->copy the line back to the new source dir
              Fputs(fh1,dirline)
            ENDIF
          ENDWHILE

          IF (found=1)
            ->if we still haven't copied over the remainder of the dest file then do it now
            IF brk THEN Fputs(fh3,dirline2)
            WHILE(Fgets(fh4,dirline2,255)<>NIL)
              Fputs(fh3,dirline2)
            ENDWHILE
            found:=0
          ENDIF

          Close(fh1)
          Close(fh2)
          Close(fh3)
          Close(fh4)

          drivenum:=1
          StringF(path,'ULPATH.\d',drivenum)
          IF(readToolType(TOOLTYPE_CONF,destConf,path,tempstr))=FALSE
            DeleteFile(dirname)

            ->put the old file back
            Rename(oldDirName,dirname)

            DeleteFile(destDirStr)

            ->put the old file back
            Rename(oldDestDirName,destDirStr)

            aePuts('\b\n Error reading upload directory, move operation aborted.\b\n')
            
          ENDIF

          aePuts('\b\nMoving file, please wait..')
          drivenum:=1
          filemoved:=FALSE

          IF srchold
            StringF(path,'\sHold/\s',currentConfDir,fname)

            StringF(destFile,'\s\s',tempstr,fname)

            IF (fileExists(path))
              status:=Rename(path,destFile)
              IF(status=FALSE)
                status:=fileCopy(path,destFile)
                IF(status)
                  SetProtection(path,FIBF_OTR_DELETE)
                  DeleteFile(path) 
                  filemoved:=TRUE
                ENDIF
              ELSE
                filemoved:=TRUE
              ENDIF
            ENDIF
          ELSE
            StringF(path,'DLPATH.\d',drivenum++)
            WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,path)) AND (filemoved=FALSE)
              IF strCmpi(path,tempstr,ALL)=FALSE
                StrAdd(path,fname)

                StringF(destFile,'\s\s',tempstr,fname)

                IF (fileExists(path))
                  status:=Rename(path,destFile)
                  IF(status=FALSE)
                    status:=fileCopy(path,destFile)
                    IF(status)
                      SetProtection(path,FIBF_OTR_DELETE)
                      DeleteFile(path) 
                      filemoved:=TRUE
                    ENDIF
                  ELSE
                    filemoved:=TRUE
                  ENDIF
                ENDIF
              ELSE
                filemoved:=TRUE
              ENDIF
              StringF(path,'DLPATH.\d',drivenum++)
            ENDWHILE
          ENDIF
          
          IF (filemoved)
            DeleteFile(oldDirName)
            DeleteFile(oldDestDirName)
            aePuts('\b\n\b\nMove operation successful \b\n')
          ELSE
            DeleteFile(dirname)

            ->put the old file back
            Rename(oldDirName,dirname)

            DeleteFile(destDirStr)

            ->put the old file back
            Rename(oldDestDirName,destDirStr)

            aePuts('\b\n\b\nMove operation failed, restoring directories \b\n')
          ENDIF

        ELSE
          Close(fh3)
          Close(fh2)
          Close(fh1)

          DeleteFile(dirname)

          ->put the old file back
          Rename(oldDirName,dirname)

          DeleteFile(destDirStr)

          ->put the old file back
          Rename(oldDestDirName,destDirStr)

          aePuts('\b\n Error reading directory list, move operation aborted.\b\n')
        ENDIF
      ELSE
        Close(fh2)
        Close(fh1)

        DeleteFile(dirname)

        ->put the old file back
        Rename(oldDirName,dirname)

        ->put the old file back
        Rename(oldDestDirName,destDirStr)
        aePuts('\b\n Error creating the new directory list, move operation aborted.\b\n')
      ENDIF
    ELSE
      Close(fh1)
      DeleteFile(dirname)

      ->put the old file back
      Rename(oldDirName,dirname)
      aePuts('\b\nError reading directory list, delete operation aborted.\b\n')
    ENDIF
  ELSE
    ->put the old file back
    Rename(oldDirName,dirname)
    aePuts('\b\nError creating the new directory list, delete operation aborted.\b\n')
  ENDIF

ENDPROC

PROC maintenanceFileSearch(holddir,fname:PTR TO CHAR,search_string: PTR TO CHAR,outfname: PTR TO CHAR, outfiledate: PTR TO CHAR)
  DEF fi,found=FALSE
  DEF image[258]:ARRAY OF CHAR
  DEF dirfname[12]:STRING
  DEF gi1,count=0,loop,ch
  DEF datestr[20]:STRING
  DEF test:PTR TO CHAR
  DEF viewAllowed

  UpperStr(search_string);

  fi:=Open(fname,MODE_OLDFILE)
  IF(fi<=0)
    RETURN RESULT_SUCCESS
  ENDIF

  viewAllowed:=checkSecurity(ACS_VIEW_A_FILE)
  IF holddir THEN viewAllowed:=FALSE

  WHILE(Fgets(fi,image,252)<>NIL)
    stripReturn(image)
    IF(checkInput())
      gi1:=readChar(1)
      IF gi1=3	/*  ctrl-c */
          Close(fi)
          aePuts('**Break\b\n')
          RETURN RESULT_FAILURE
      ENDIF
    ENDIF
    IF(image[0]<>" ")
      StrCopy(dirfname,image,12)
      UpperStr(dirfname)
      IF(InStr(dirfname,search_string))>=0 THEN found:=1
      parseParams(image)
      FOR count:=2 TO 4
        test:=parsedParams[count]
        IF (StrLen(test)=8) AND (test[2]="-") AND (test[5]="-")
          StrCopy(datestr,parsedParams[count])
        ENDIF
      ENDFOR
    ENDIF

    IF found
      count:=0
      aePuts('\b\n')
      aePuts(image)
      aePuts('\b\n')
      WHILE(Fgets(fi,image,252)<>NIL) AND (image[0]=" ") AND (count<my_struct.max_desclines)
        stripReturn(image)
        aePuts(image)
        aePuts('\b\n')
        count++
      ENDWHILE
      aePuts('\b\n')
      IF (viewAllowed=TRUE)
        aePuts('[32m([33mC[32m)[36montinue, [32m([33mD[32m)[36melete, [32m([33mM[32m)[36move, [32m([33mV[32m)[36miew, [32m([33mQ[32m)[36muit[0m? ')
      ELSE
        aePuts('[32m([33mC[32m)[36montinue, [32m([33mD[32m)[36melete, [32m([33mM[32m)[36move, [32m([33mQ[32m)[36muit[0m? ')
      ENDIF
      loop:=TRUE
      WHILE(loop)
        ch:=readChar(INPUT_TIMEOUT)
        IF(ch<0) 
          RETURN ch
        ENDIF
        IF (ch="C") OR (ch="c")
          aePuts('\b\n')
          found:=FALSE
          loop:=FALSE
        ELSEIF (ch="d") OR (ch="D") OR (ch="m") OR (ch="M") OR (((ch="v") OR (ch="V")) AND (viewAllowed=TRUE)) OR (ch="q") OR (ch="Q")
          Close(fi)
          StrCopy(outfname,dirfname)
          IF (count:=InStr(dirfname,' '))>=0 THEN SetStr(outfname,count)
          StrCopy(outfiledate,datestr)
          RETURN RESULT_SUCCESS,ch
        ENDIF
      ENDWHILE
    ENDIF
  ENDWHILE
  Close(fi)
ENDPROC RESULT_NOT_FOUND,0

PROC zippy(fname:PTR TO CHAR,search_string: PTR TO CHAR)
  DEF fi;
  DEF current:PTR TO CHAR
  DEF image[258]:ARRAY OF CHAR
  DEF found=0
  DEF x=1
  DEF gi1
  DEF myzip
  
  myzip:=AllocMem(25600,MEMF_CLEAR OR MEMF_PUBLIC)
  IF(myzip=FALSE) THEN RETURN RESULT_SUCCESS
  
  current:=myzip+257 ->ln(1,1);
  UpperStr(search_string);

  fi:=Open(fname,MODE_OLDFILE)
  IF(fi<=0)
    FreeMem(myzip,25600)
    RETURN RESULT_SUCCESS
  ENDIF

  WHILE(Fgets(fi,image,252)<>NIL)
    IF(checkInput())
      gi1:=readChar(1)
      SELECT gi1
        CASE 23	/* ctrl-s */
          gi1:=readChar(INPUT_TIMEOUT)
          IF(gi1<0)
            Close(fi);
            FreeMem(myzip,25600)          
            RETURN gi1
          ENDIF
        CASE 3	/*  ctrl-c */
          Close(fi)
          aePuts('**Break\b\n')
          FreeMem(myzip,25600)
          RETURN RESULT_FAILURE
      ENDSELECT
    ENDIF
    stripReturn(image)
    IF(image[0]<>" ")
      IF (x<100)
        current:=myzip+Shl(x,8)+1   ->ln(1,x)
        current[0]:=0
      ENDIF
      IF(found)
        found:=1
        WHILE(1)
          current:=myzip+Shl(found,8)+1    ->ln(1,found)
          EXIT (current[0]=0) OR (found>=99)
          aePuts(current)
          aePuts('\b\n')
          found++
          gi1:=flagPause(1)
          IF(gi1<0)
            Close(fi)
            FreeMem(myzip,25600)
            RETURN gi1
          ENDIF
        ENDWHILE
      ENDIF
      found:=0
      x:=1
      current:=myzip+Shl(x,8)+1   ->ln(1,x)
    ENDIF
    IF x<100
      strCpy(current,image,ALL)
    ENDIF
    UpperStr(image)
    IF(InStr(image,search_string))>=0 THEN found:=1
    x++;
    current:=myzip+Shl(x,8)+1   ->ln(1,x); 
  ENDWHILE
    
  current:=myzip+Shl(x,8)+1    ->ln(1,x)
  current[0]:=0
  IF(found)
    found:=1
    WHILE(1)
      current:=myzip+Shl(found,8)+1   ->  ln(1,found)
      EXIT current[0]=0
      aePuts(current)
      aePuts('\b\n')
      found++
      gi1:=flagPause(1)
      IF(gi1<0)
				Close(fi)
        FreeMem(myzip,25600)
				RETURN gi1
      ENDIF
    ENDWHILE
  ENDIF
   
  Close(fi)
  aePuts('\b\n')
  FreeMem(myzip,25600)
ENDPROC RESULT_SUCCESS

PROC displayFileList(params)
  DEF stat,stat2,fLLoop
  DEF str[81]:STRING,ray[200]:STRING
  DEF tempfile[256]:STRING
  DEF fcopy = FALSE
  DEF startDir,dirScan
 
  nonStopDisplayFlag:=0
  lineCount:=0
 
  aePuts('\b\n')
  IF(maxDirs=0) 
 	  myError(5); ->Sorry();
 	  RETURN RESULT_FAILURE
 	ENDIF
 
  parseParams(params)
  IF(ListLen(parsedParams)>0)
 		stat,startDir,dirScan:=getDirSpan(parsedParams[0])
  ELSE
    displayScreen(SCREEN_FILEHELP) ->IF(displayScreen(SCREEN_FILEHELP))=FALSE THEN unAvailNotice(GSTR3,GSTR1);
 	  stat,startDir,dirScan:=getDirSpan('')
 	ENDIF
 
  IF(stat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
 
  nonStopDisplayFlag:=paramsContains('NS')
 
  fLLoop:=startDir
  WHILE(fLLoop<=dirScan)
 	  StrCopy(str,currentConfDir)
 	  IF(dirScan<>(-1))
      IF(fLLoop = maxDirs)    /* at upload dir */
        StrAdd(str,'DIR')
 	     	StringF(ray,'\d',fLLoop)
 		    StrAdd(str,ray)
  		  StringF(ray,'Scanning directory \d\b\n',fLLoop)
        aePuts(ray)
 
        /* now copy to T: and use T: copy */
        StringF(tempfile,'T:tdir.\d',node)
        IF((fileCopy(str,tempfile)))
          StrCopy(str,tempfile)
          fcopy:=TRUE
        ENDIF
      ELSE
  		  StrAdd(str,'DIR')
 	    	StringF(ray,'\d',fLLoop)
 		    StrAdd(str,ray)
  		  StringF(ray,'Scanning directory \d\b\n',fLLoop)
 	    	aePuts(ray)
      ENDIF
 		ELSE
 		  StrAdd(str,'hold/held')
 		  aePuts('Scanning directory HOLD\b\n')
 		ENDIF
 	  stat:=flagPause(1)
 	  IF(stat<0) 
      IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
  	  RETURN stat
    ENDIF
    stat:=displayIt(str)
    IF(fcopy)
      DeleteFile(tempfile) ->(RTS)
      fcopy:=FALSE
    ENDIF
    IF(stat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
  	IF(stat=RESULT_NO_CARRIER) THEN RETURN RESULT_NO_CARRIER
 	  IF(stat=RESULT_TIMEOUT) THEN RETURN stat
    ->if(DirScan == MaxDirs)  return(stat);
 
 	  aePuts('\b\n')
 	  fLLoop++
 	ENDWHILE
  IF(fcopy) THEN DeleteFile(tempfile);  ->(RTS)
ENDPROC RESULT_SUCCESS

PROC displayIt(fname: PTR TO CHAR)
  DEF fp,res

  fp:=Open(fname,MODE_OLDFILE)
  IF(fp<=0)
 	  myError(4) ->(RTS) FileListError();
 	  RETURN RESULT_SUCCESS
 	ENDIF
 
 /* We should check for the file in ram: if there, show it, if not, copy it */
 
  res:=displayIt2(fp)
  Close(fp)
ENDPROC res

PROC displayIt2(fp)
  DEF moreStat,stat,color = 0
  DEF str[200]:STRING

  WHILE(Fgets(fp,str,180)<>NIL)
   	str[181]:=0
    SetStr(str,StrLen(str))
 	  IF(str[StrLen(str)-1]="\n")
  		IF(nonStopDisplayFlag=FALSE) THEN	lineCount++
 	    StrAdd(str,'\b')
 		ENDIF
 
    IF(color=1) THEN aePuts('[0m')
    aePuts(str)
 
 	  IF(sCheckInput())	
  		stat:=readChar(1)
 	    IF(stat<0) 
        RETURN stat
      ENDIF
 		  SELECT stat
        CASE 23  /* Pause */
          stat:=readChar(INPUT_TIMEOUT)
          IF(stat<0)
            RETURN RESULT_NO_CARRIER
          ENDIF
        CASE 3 /* ^C */
          aePuts('**Break\b\n\b\n')
          RETURN RESULT_FAILURE
 			ENDSELECT
 		ENDIF
  	moreStat:=flagPause(0)
 	  IF(moreStat<0) 
  		RETURN moreStat
    ENDIF
 	ENDWHILE 
ENDPROC RESULT_SUCCESS

PROC myNewFiles(params)
  DEF month,day,year
  DEF tv,mystat,stat,comstat
  DEF fLLoop
  DEF tempfile[256]:STRING         ->(RTS) for buffer of upload dir
  DEF c[256]:STRING
  DEF str[200]:STRING,ray[200]:STRING
  DEF fn[81]:STRING,sz[81]:STRING,dt[81]:STRING,cmt[81]:STRING
  DEF mdt,ddt,ydt
  DEF timeVar;
  DEF fcopy = FALSE
  DEF pchar: PTR TO CHAR
  DEF startDir,dirScan
  DEF fp1
 
  nonStopDisplayFlag:=0
  lineCount:=0
 
  aePuts('\b\n')
  IF(maxDirs=0)
  	myError(5) -> Sorry();
 	  RETURN RESULT_FAILURE
 	ENDIF
 
  timeVar:=loggedOnUser.newSinceDate
  formatLongDate(timeVar,ray)
  StrCopy(str,'')
 
  parseParams(params)
  IF(ListLen(parsedParams)>0)
    pchar:=parsedParams[0]
  	IF(pchar[0]="s") OR (pchar[0]="S")
      StrCopy(str,ray)
  	ELSE
      StrCopy(str,parsedParams[0])
    ENDIF
 	ENDIF

  nonStopDisplayFlag:=paramsContains('NS')
 
  WHILE(StrLen(str)<>8)
  	comstat:=1
 	  StringF(str,'Date as (mm-dd-yy) to search from (Enter)=\s: ',ray)
  	aePuts(str)
 	  mystat:=lineInput('','',8,INPUT_TIMEOUT,str)
  	IF(mystat<0) THEN RETURN RESULT_NO_CARRIER
 	  IF(StrLen(str)=0) THEN StrCopy(str,ray)
  	IF(StrLen(str)<>8) THEN aePuts('\b\n')
 	ENDWHILE
  StringF(c,'\tDirectory Scan for (\s)',str)
  callersLog(c)
 
  str[2]:=" "
  str[5]:=" "
  month:=Val(str)
  day:=Val(str+3)
  year:=Val(str+6)

  IF (year>TWODIGITYEARSWITCHOVER) THEN year:=1900+year ELSE year:=2000+year

  ->sscanf(str,"%d %d %d",&month,&day,&year);
 
  tv:=0

  StrCopy(c,'')
  IF(ListLen(parsedParams)>1)
    StrCopy(c,parsedParams[1])
  ENDIF
  IF(ListLen(parsedParams)>2)
  	StrAdd(c,' ')
 	  StrAdd(c,parsedParams[2]);
  ENDIF
  mystat,startDir,dirScan:=getDirSpan(c)
  IF(mystat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
 
  nonStopDisplayFlag:=paramsContains('NS');
 
  newSinceFlag:=1
  fcopy:=FALSE
 
  fLLoop:=startDir;
  WHILE(fLLoop<=dirScan)
  	StrCopy(str,currentConfDir)
 	  IF(dirScan<>(-1)) 
 ->(RTS)   buffer upload dir
      IF(fLLoop = maxDirs) 
        StrAdd(str,'DIR')
 	     	StringF(ray,'\d',fLLoop)
 		    StrAdd(str,ray)
  		  StringF(ray,'Scanning directory \d\b\n',fLLoop)
        aePuts(ray)
         
        StringF(tempfile,'T:tdir.\d',node)
             /* now copy to T: and use T: copy */
        IF((fileCopy(str,tempfile)))
          StrCopy(str,tempfile)
          fcopy:=TRUE
        ENDIF
  		ELSE
        StrAdd(str,'DIR')
 	     	StringF(ray,'\d',fLLoop)
 		    StrAdd(str,ray)
  		  StringF(ray,'Scanning directory \d\b\n',fLLoop)
 	    	aePuts(ray)
      ENDIF
 		ELSE
      StrAdd(str,'hold/held')
 	    aePuts('Scanning directory HOLD\b\n')
 		ENDIF
  	stat:=flagPause(1)
 	  IF(stat<0)
      IF(fcopy) THEN DeleteFile(tempfile)
      RETURN stat
    ENDIF
  	fp1:=Open(str,MODE_OLDFILE)
 	  IF(fp1<=0)
  		aePuts('No Files are available.\b\n\b\n')
      IF(fcopy) THEN DeleteFile(tempfile)
 	    RETURN RESULT_SUCCESS
 		ENDIF
 
  	WHILE(Fgets(fp1,c,250)<>NIL) 
  		c[250]:=0
      SetStr(c,StrLen(c))
 	    IF((c[0]=" ") OR (c[0]=0) OR(c[0]="\n")) THEN JUMP fgetnext

      parseParams(c)
      IF(ListLen(parsedParams)>0) THEN StrCopy(fn,parsedParams[0])
      IF(ListLen(parsedParams)>1) THEN StrCopy(sz,parsedParams[1])
      IF(ListLen(parsedParams)>2) THEN StrCopy(dt,parsedParams[2])
      IF(ListLen(parsedParams)>3) THEN StrCopy(cmt,parsedParams[3])
  		->scanf(c,"%s %s %s %s",&fn,&sz,&dt,&cmt);

 	    IF((dt[0]<="9") AND (dt[0]>="0") AND (StrLen(dt)=8))
  			IF(Not((dt[2]="-") AND (dt[5]="-") AND (dt[6]<="9") AND (dt[6]>="0")))
  				StrCopy(sz,dt)
 	    		StrCopy(dt,cmt)
 				ENDIF
 			ELSE
  			StrCopy(sz,dt)
 	    	StrCopy(dt,cmt)
 			ENDIF
 		  
      dt[2]:=" "
 			dt[5]:=" "
      mdt:=Val(dt)
      ddt:=Val(dt+3)
      ydt:=Val(dt+6)
      IF (ydt>TWODIGITYEARSWITCHOVER) THEN ydt:=1900+ydt ELSE ydt:=2000+ydt
      
  		->sscanf(dt,"%d %d %d",&mdt,&ddt,&ydt);
 	    
      IF(ydt>year)
        tv:=1
   		ELSE
  			IF(ydt=year)
  				IF(mdt>month)
            tv:=1
  				ELSEIF(mdt=month) 	
  					IF(ddt>=day) THEN	tv:=1
 					ENDIF
 				ENDIF
 			ENDIF
  		EXIT tv
fgetnext:
 		ENDWHILE 
 
  	IF(tv<>0)
  		c[StrLen(c)-1]:=0
 	    aePuts(c)
 		  aePuts('\b\n')
  		stat:=flagPause(1)
 	    IF(stat<0)
 		    Close(fp1)
        IF(fcopy) THEN DeleteFile(tempfile)
 			  RETURN stat
  		ENDIF
 
 ->    	stat=DisplayIt();      /* Mikes unbuffered */
      stat:=displayIt2(fp1)   /* my buffered dir code */
     	Close(fp1)
      tv:=0
      IF(stat<0)
        IF(fcopy) THEN DeleteFile(tempfile)
        RETURN stat
      ENDIF
 		ELSE
      Close(fp1)
    ENDIF
    tv:=0
  	fLLoop++
 	ENDWHILE
  aePuts('\b\n')
  nonStopDisplayFlag:=0
  IF(fcopy) THEN DeleteFile(tempfile)
ENDPROC RESULT_SUCCESS

PROC flagPause(count)
  DEF moreStat
  DEF str[200]:STRING
 
  IF(nonStopDisplayFlag=FALSE) THEN	lineCount:=lineCount+count
 
  IF((nonStopDisplayFlag=FALSE) AND (lineCount>=(IF loggedOnUser.lineLength THEN loggedOnUser.lineLength ELSE 22)))
  	lineCount:=0;
    WHILE TRUE
      aePuts('[32m([33mPause[32m)[34m...[32m([33mf[32m)[36mlags, More[32m([33mY[32m/[33mn[32m/[33mns[32m)[0m? ')
      moreStat:=lineInput('','',190,INPUT_TIMEOUT,str)
      IF(moreStat<0) THEN RETURN moreStat

      EXIT (str[0]=0) OR (str[0]="y") OR (str[0]="Y")

      IF(logonType>=LOGON_TYPE_REMOTE)
        moreStat:=checkCarrier()
        IF(moreStat=FALSE) THEN RETURN RESULT_NO_CARRIER
      ENDIF
      IF((str[0]="N") OR (str[0]="n"))
        IF((str[1]="S") OR (str[1]="s")) 
          nonStopDisplayFlag:=1
          JUMP fpbrk
        ELSE
          aePuts('\b\n')
          RETURN RESULT_FAILURE
        ENDIF
      ENDIF
      IF((str[0]="F") OR (str[0]="f"))
        IF(StrLen(str)>2) THEN moreStat:=flagFiles(str+2) ELSE moreStat:=flagFiles(NIL)
        IF(moreStat<RESULT_FAILURE)	THEN RETURN moreStat
          ->if(AnsiColor)
          aePuts('[A[K')
      ENDIF
 		ENDWHILE
fpbrk:
  	->if(AnsiColor)
 		aePuts('[1A[K')
	ENDIF
ENDPROC RESULT_SUCCESS


PROC confScan()
  DEF mystat,conf
  DEF prompt=FALSE
  DEF mscan=TRUE
  DEF fscan=TRUE
  setEnvStat(ENV_SCANNING)

  IF (prompt:=checkToolTypeExists(TOOLTYPE_NODE,node,'MAILSCAN_PROMPT'))
    aePuts('\b\n[0mScan for Mail ')
    mystat:=yesNo(1)
    IF mystat<0 THEN RETURN mystat
    mscan:=(mystat=1)
  ENDIF

  IF (prompt=FALSE) OR (mscan=TRUE)
  
    aePuts('\b\nScanning conferences for mail...\b\n\b\n')
    FOR conf:=1 TO cmds.numConf
      IF (checkConfAccess(conf))

        IF prompt=FALSE
          mscan:=checkMailConfScan(conf)
        ENDIF
        fscan:=checkFileConfScan(conf)

        mystat:=joinConf(conf,TRUE,FALSE,mscan=FALSE)
        IF (mystat=RESULT_SUCCESS) AND (fscan)
          runSysCommand('N','S U')
        ELSE
          mystat:=RESULT_SUCCESS
        ENDIF
      ENDIF
      EXIT mystat=RESULT_FAILURE
      IF (mystat=RESULT_TIMEOUT) OR (mystat=RESULT_NO_CARRIER) THEN RETURN mystat
    ENDFOR

    IF checkSecurity(ACS_UPLOAD)
      ->//AEPutStr("\b\n[35m  --[32mChecking for PartUploads\b\n[0m");
      FOR conf:=1 TO cmds.numConf
        IF (checkConfAccess(conf))
           mystat:=joinConf(conf,TRUE,FALSE,TRUE)
          IF (mystat=RESULT_SUCCESS)

            mystat:=partUploadOK(1)
            IF(mystat=RESULT_FAILURE)
              currentConf:=conf
              setEnvStat(ENV_UPLOADING)
              IF(checkSecurity(ACS_UPLOAD))
                uploadaFile(0,'URG','')
              ENDIF
            ELSEIF(mystat=RESULT_ABORT)
              aePuts('\b\n')
            ENDIF
          ENDIF
        ENDIF
        EXIT mystat=RESULT_FAILURE
        IF (mystat=RESULT_TIMEOUT) OR (mystat=RESULT_NO_CARRIER) THEN RETURN mystat
      ENDFOR
      mystat:=doPause()
      IF(mystat<0) THEN RETURN mystat
    ENDIF
  ENDIF  
ENDPROC RESULT_SUCCESS

PROC captureRealAndInternetNames()
  DEF i,stat,valid
  DEF realNamesUsed=FALSE,internetNamesUsed=FALSE
  DEF tempstr[30]:STRING
  
  FOR i:=1 TO cmds.numConf
    IF checkConfAccess(i) 
      IF checkToolTypeExists(TOOLTYPE_CONF,i,'REALNAME') THEN realNamesUsed:=TRUE
      IF checkToolTypeExists(TOOLTYPE_CONF,i,'INTERNETNAME') THEN internetNamesUsed:=TRUE
    ENDIF
  ENDFOR

  IF ((realNamesUsed=TRUE) AND (StrLen(loggedOnUserMisc.realName)=0))
    valid:=FALSE
    aePuts('\b\nReal Names are required in some conferences\b\non this system\b\n\b\n')
    REPEAT
      aePuts('Real Name	(Alpha Numeric): ')
      stat:=lineInput('','',25,INPUT_TIMEOUT,tempstr)
      IF stat<0 THEN RETURN stat

      IF (StrLen(tempstr)<>1) AND (strCmpi(tempstr,loggedOnUserMisc.realName,ALL)=FALSE)
        aePuts('\b\nChecking for duplicate name...')
        stat:=checkForAst(tempstr)
        IF(stat) 
          aePuts('No wildcards allowed in a name.\b\n')
        ELSEIF findUserFromName(1,NAME_TYPE_REALNAME,tempstr,tempUser,tempUserKeys,tempUserMisc)
            aePuts('Already in use!, try another.\b\n\b\n')
        ELSE
          aePuts('Ok!\b\n')
          valid:=TRUE
        ENDIF
      ENDIF
    UNTIL valid
    strCpy(loggedOnUserMisc.realName,tempstr,26)
  ENDIF

  IF ((internetNamesUsed=TRUE) AND (StrLen(loggedOnUserMisc.internetName)=0))
    valid:=FALSE
    aePuts('\b\nInternet Names are required in some conferences\b\non this system\b\n\b\n')
    REPEAT
      aePuts('Internet Name (Alpha Numeric No Spaces): ')
      stat:=lineInput('','',9,INPUT_TIMEOUT,tempstr)
      IF stat<0 THEN RETURN stat

      IF (StrLen(tempstr)<>1) AND (strCmpi(tempstr,loggedOnUserMisc.internetName,ALL)=FALSE)
        aePuts('\b\nChecking for duplicate name...')
        stat:=checkForAst(tempstr)
        IF(stat) 
          aePuts('No wildcards allowed in a name.\b\n')
        ELSEIF findUserFromName(1,NAME_TYPE_INTERNETNAME,tempstr,tempUser,tempUserKeys,tempUserMisc)
            aePuts('Already in use!, try another.\b\n\b\n')
        ELSE
          aePuts('Ok!\b\n')
          valid:=TRUE
        ENDIF
      ENDIF
    UNTIL valid
    strCpy(loggedOnUserMisc.internetName,tempstr,10)
  ENDIF

ENDPROC

PROC processCommand(cmdtext,internalOnly=FALSE)
  DEF cmdcode[255]:STRING
  DEF cmdparams[255]:STRING
  DEF spacepos

  IF EstrLen(cmdtext)=0 THEN RETURN RESULT_SUCCESS

  spacepos:=InStr(cmdtext,' ')

  IF spacepos>=0
    MidStr(cmdcode,cmdtext,0,spacepos)
    MidStr(cmdparams,cmdtext,spacepos+1,ALL)
  ELSE
    StrCopy(cmdcode,cmdtext,ALL)
    StrCopy(cmdparams,'',ALL)
  ENDIF
  UpperStr(cmdcode)
  
  -> try running it as a bbscommand first
  IF (internalOnly=FALSE)
    IF runBbsCommand(cmdcode,cmdparams) THEN RETURN RESULT_SUCCESS
  ENDIF
ENDPROC processInternalCommand(cmdcode,cmdparams)

PROC processSysCommand(cmdtext)
  DEF cmdcode[255]:STRING
  DEF cmdparams[255]:STRING
  DEF spacepos

  IF EstrLen(cmdtext)=0 THEN RETURN

  IF (spacepos:=InStr(cmdtext,' '))>=0
    MidStr(cmdcode,cmdtext,0,spacepos)
    MidStr(cmdparams,cmdtext,spacepos+1,ALL)
  ELSE
    StrCopy(cmdcode,cmdtext,ALL)
    StrCopy(cmdparams,'',ALL)
  ENDIF

  -> try running it as a sysommand first
  IF runSysCommand(cmdcode,cmdparams) THEN RETURN TRUE

  -> try running it as a sysommand first
  IF runBbsCommand(cmdcode,cmdparams) THEN RETURN TRUE

ENDPROC processInternalCommand(cmdcode,cmdparams,TRUE)

PROC processInternalCommand(cmdcode,cmdparams,silentFail=FALSE)
  DEF res=RESULT_SUCCESS

  IF (StrCmp(cmdcode,'0'))
    res:=internalCommand0()
  ELSEIF (StrCmp(cmdcode,'1'))
    res:=internalCommand1(cmdparams)
  ELSEIF (StrCmp(cmdcode,'2'))
    res:=internalCommand2(cmdparams)
  ELSEIF (StrCmp(cmdcode,'3'))
    res:=internalCommand3(cmdparams)
  ELSEIF (StrCmp(cmdcode,'4'))
    res:=internalCommand4(cmdparams)
  ELSEIF (StrCmp(cmdcode,'5'))
    res:=internalCommand5(cmdparams)
  ELSEIF (StrCmp(cmdcode,'D'))
    res:=internalCommandD(cmdcode,cmdparams)
  ELSEIF (StrCmp(cmdcode,'DS'))
    res:=internalCommandD(cmdcode,cmdparams)
  ELSEIF (StrCmp(cmdcode,'S'))
    res:=internalCommandS()
  ELSEIF (StrCmp(cmdcode,'T'))
    res:=internalCommandT()
  ELSEIF (StrCmp(cmdcode,'F'))
    res:=internalCommandF(cmdparams)
  ELSEIF (StrCmp(cmdcode,'FM'))
    res:=internalCommandFM(cmdparams)
  ELSEIF (StrCmp(cmdcode,'FS'))
    res:=internalCommandFS()
  ELSEIF (StrCmp(cmdcode,'G'))
    res:=internalCommandG()
  ELSEIF (StrCmp(cmdcode,'J'))
    res:=internalCommandJ(cmdparams)
  ELSEIF (StrCmp(cmdcode,'<'))
    res:=internalCommandLT()
  ELSEIF (StrCmp(cmdcode,'>'))
    res:=internalCommandGT()
  ELSEIF (StrCmp(cmdcode,'R'))
    res:=internalCommandR(cmdparams)
  ELSEIF (StrCmp(cmdcode,'A'))
    res:=internalCommandA(cmdparams)
  ELSEIF (StrCmp(cmdcode,'B'))
    res:=internalCommandB(cmdparams)
  ELSEIF (StrCmp(cmdcode,'C'))
    res:=internalCommandC(cmdparams)
  ELSEIF (StrCmp(cmdcode,'CF'))
    res:=internalCommandCF()
  ELSEIF (StrCmp(cmdcode,'E'))
    res:=internalCommandE(cmdparams)
  ELSEIF (StrCmp(cmdcode,'H'))
    res:=internalCommandH(cmdparams)
  ELSEIF (StrCmp(cmdcode,'M'))
    res:=internalCommandM()
  ELSEIF (StrCmp(cmdcode,'N'))
    res:=internalCommandN(cmdparams)
  ELSEIF (StrCmp(cmdcode,'O'))
    res:=internalCommandO()
  ELSEIF (StrCmp(cmdcode,'OLM'))
    res:=internalCommandOLM(cmdparams)
  ELSEIF (StrCmp(cmdcode,'Q'))
    res:=internalCommandQ()
  ELSEIF (StrCmp(cmdcode,'RL'))
    res:=internalCommandRL()
  ELSEIF (StrCmp(cmdcode,'U'))
    res:=internalCommandU(cmdcode,cmdparams)
  ELSEIF (StrCmp(cmdcode,'US'))
    res:=internalCommandUS()
  ELSEIF (StrCmp(cmdcode,'RZ'))
    res:=internalCommandRZ(cmdcode,cmdparams)
  ELSEIF (StrCmp(cmdcode,'V'))
    res:=internalCommandV(cmdcode,cmdparams)
  ELSEIF (StrCmp(cmdcode,'VS'))
    res:=internalCommandV(cmdcode,cmdparams)
  ELSEIF (StrCmp(cmdcode,'W'))
    res:=internalCommandW()
  ELSEIF (StrCmp(cmdcode,'WHO'))
    res:=internalCommandWHO()
  ELSEIF (StrCmp(cmdcode,'WHD'))
    res:=internalCommandWHD()
  ELSEIF (StrCmp(cmdcode,'X'))
    res:=internalCommandX()
  ELSEIF (StrCmp(cmdcode,'Z'))
    res:=internalCommandZ(cmdparams)
  ELSEIF (StrCmp(cmdcode,'?'))
    res:=internalCommandQuestionMark()
  ELSEIF (StrCmp(cmdcode,'^'))
    res:=internalCommandUpHat(cmdparams)
  ELSEIF silentFail=FALSE
    aePuts('\b\nNo such command!!  Use ''?'' for command list.\b\n\b\n')
  ENDIF

  IF ((res=RESULT_NOT_ALLOWED) AND (silentFail=FALSE)) THEN higherAccess()

ENDPROC

PROC displayMenuPrompt()
  DEF mPrompt[255]:STRING  
  
  IF StrLen(menuPrompt)>0
    aePuts('[0m')
    processMci(menuPrompt)
    aePuts(' ')
  ELSE
    StringF(mPrompt,'[0m[35m\s [0m[[36m\d[34m:[36m\s[0m] Menu ([33m\d[0m mins. left): ',cmds.bbsName,relConfNum,currentConfName,Div((loggedOnUser.timeTotal-loggedOnUser.timeUsed),60))
    aePuts(mPrompt)
  ENDIF
ENDPROC

PROC processLoggedOnUser()
    DEF subState: PTR TO loggedOnState
    DEF wasControl,ch
    DEF string[255]:STRING
    DEF temp
    DEF lastDay,currDay
    DEF currTime
    IF (stateData=0)
        StrCopy(securityFlags,'')
        statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
        IF(cmds.acLvl[LVL_SCREEN_TO_FRONT] AND scropen) THEN expressToFront()

        newSinceFlag:=0

        currTime:=getSystemTime()
        currDay:=Div(currTime-21600,86400)
        lastDay:=Div(loggedOnUser.timeLastOn-21600,86400)
        IF (lastDay<>currDay)
          StringF(string,'timeused debug: \s logon new day reset,  currday \d, lastday \d',loggedOnUser.name, currDay,lastDay)
          debugLog(LOG_WARN,string)

          loggedOnUser.timeUsed:=0
          loggedOnUser.chatRemain:=loggedOnUser.chatLimit
          loggedOnUser.dailyBytesDld:=0
          loggedOnUser.timeTotal:=loggedOnUser.timeLimit
          loggedOnUser.timeLastOn:=currTime
        ELSE
          StringF(string,'timeused debug: \s logon same day,  currday \d, lastday \d, timeused \d',loggedOnUser.name,currDay,lastDay,loggedOnUser.timeUsed)
          debugLog(LOG_WARN,string)
        ENDIF

        my_struct.sessiondbytes:= 0    /* DOwnloaded Bytes for this user, this session */
        logonTime:=getSystemTime()
        timeLimit:=loggedOnUser.timeTotal-loggedOnUser.timeUsed
        lastTimeUpdate:=logonTime
        bytesADL:=loggedOnUser.dailyBytesLimit
        updateTimeUsed()

        pagesAllowed:=readToolTypeInt(TOOLTYPE_ACCESS,acsLevel,'ACS.MAX_PAGES')
        chatF:=0
        currentConf:=0
        subState:=NEW subState
        IF reqState<>REQ_STATE_LOGOFF THEN subState.subState:=SUBSTATE_DISPLAY_BULL ELSE subState.subState:=-1
        relogon:=FALSE
        nonStopDisplayFlag:=FALSE
        doorTimeout:=INPUT_TIMEOUT
        
        stateData:=subState
    ELSE
        subState:=stateData
    ENDIF

    IF subState.subState=SUBSTATE_DISPLAY_BULL
        IF (displayScreen(SCREEN_BULL)) THEN doPause()
        IF (displayScreen(SCREEN_NODE_BULL)) THEN doPause()
        confScan()
        captureRealAndInternetNames()
        subState.subState:=SUBSTATE_DISPLAY_CONF_BULL
    ELSEIF subState.subState=SUBSTATE_DISPLAY_CONF_BULL
      joinConf(loggedOnUser.confRJoin,FALSE,TRUE)
      loadFlagged()
      IF StrLen(historyFolder)>0 THEN loadHistory()

      subState.subState:=SUBSTATE_DISPLAY_MENU
    ELSEIF subState.subState=SUBSTATE_DISPLAY_MENU
      IF (loggedOnUser.expert="N")
        doPause()
        checkScreenClear()
        displayScreen(SCREEN_MENU)
      ENDIF
      aePuts('\b\n')
      IF checkOnlineStatus()<>RESULT_SUCCESS THEN reqState:=REQ_STATE_LOGOFF
      updateTimeUsed()

      ->show queued olm messages
      IF ListLen(olmQueue)>0
        aePuts('\b\nDisplaying Message Queue\b\n')
        FOR temp:=0 TO ListLen(olmQueue)-1
          aePuts(olmQueue[temp])
          DisposeLink(olmQueue[temp])
        ENDFOR
        SetList(olmQueue,0)
      ENDIF

      setEnvStat(ENV_IDLE)
      displayMenuPrompt()
      subState.subState:=SUBSTATE_READ_COMMAND
      StrCopy(commandText,'',ALL)
    ELSEIF subState.subState=SUBSTATE_READ_COMMAND
      temp:=rawArrow
      rawArrow:=FALSE
      temp:=lineInput('','',255,INPUT_TIMEOUT,commandText)
      IF temp<>RESULT_SUCCESS
        aePuts('Input timeout\b\n')
        aePuts('Goodbye\b\n\b\n')
        aePuts('Disconnecting..\b\n')
        saveFlagged()
        IF StrLen(historyFolder)>0 THEN saveHistory()
        quickFlag:=TRUE
        IF reqState=REQ_STATE_NONE THEN reqState:=REQ_STATE_LOGOFF
      ENDIF
      rawArrow:=temp
      IF state=STATE_SHUTDOWN THEN RETURN

      subState.subState:=SUBSTATE_PROCESS_COMMAND
    ELSEIF subState.subState=SUBSTATE_PROCESS_COMMAND
      IF (debugLogLevel>LOG_NONE)
        StringF(string,'\tMenu Command >: \s',commandText)
        callersLog(string)
      ENDIF

      UpperStr(commandText)
      processCommand(commandText)
      subState.subState:=SUBSTATE_DISPLAY_MENU
    ENDIF
  
  IF reqState<>REQ_STATE_NONE THEN END subState
ENDPROC

PROC processSysopLogon()
    setEnvStat(ENV_CONNECT)
    loggedOnUser:=NEW loggedOnUser
    loggedOnUserKeys:=NEW loggedOnUserKeys
    loggedOnUserMisc:=NEW loggedOnUserMisc
    -> load sysop user data
    loadAccount(1,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
    masterLoadPointers(loggedOnUser)
    acsLevel:=findAcsLevel()
    logonType:=LOGON_TYPE_SYSOP
    displayUserToCallersLog(0)
    updateCallerNum()
    checkUserOnLine(loggedOnUser,0)
    validUser:=1
    ximPort:=CONSOLE_PORT
    state:=STATE_LOGGEDON
    setEnvStat(ENV_LOGGINGON)
    sendCLS()

    stateData:=0
ENDPROC

PROC displayReserveNotice()
  DEF tempstr[255]:STRING
  
  StringF(tempstr,'\b\nNode \d is reserved right now, please try again later\b\n',node)
  aePuts(tempstr)
 ENDPROC

PROC doReserve(username:PTR TO CHAR)
  IF(StrLen(reservedName)>0) 
	  IF(strCmpi(username,reservedName,ALL))=FALSE
		  displayReserveNotice()
		  Delay(60)
		  RETURN 1
		ENDIF
	ENDIF
ENDPROC 0


PROC checkPassword()
  DEF tries=0,stat
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  WHILE TRUE
         
	    displayUserToCallersLog(0)
         
	    REPEAT
		    IF(tries>2)
			    aePuts('\b\nExcessive Password Failure\b\n')
          runSysCommand('PWFAIL','')
			    JUMP logoffErr
			  ENDIF
		    stat:=getPass2('PassWord: ',0,loggedOnUser.pwdHash,50,tempStr)
		    IF(stat<0) THEN RETURN RESULT_SLEEP_LOGOFF
        IF(stat<>RESULT_SUCCESS)
			    StringF(tempStr2,'\tPassword Failure (\s)',tempStr)
			    callersLog(tempStr2)
			    aePuts('Invalid PassWord\b\n')
			    tries++
			  ENDIF
      UNTIL stat=RESULT_SUCCESS
	
	    IF(checkToolTypeExists(TOOLTYPE_NODE,node,'PHONECHECK'))
		    tries:=0
		    REPEAT
			    IF(tries>2)	
				    aePuts('\b\nExcessive PhoneNumber Failure\b\n')
				    JUMP logoffErr
				  ENDIF
			    StrCopy(tempStr,loggedOnUser.phoneNumber)
			    RightStr(tempStr2,tempStr,4)

			    aePuts('Last 4 digits of your PhoneNumber: ')
			    stat:=lineInput('','',4,INPUT_TIMEOUT,tempStr)
			    IF(stat<0) THEN RETURN RESULT_SLEEP_LOGOFF
			    IF(logonType>=LOGON_TYPE_REMOTE) 
				    stat:=checkCarrier()
				    IF(stat=FALSE) THEN RETURN RESULT_SLEEP_LOGOFF
				  ENDIF
            
			    stat:=stringCompare(tempStr,tempStr2)
			    IF(stat<>RESULT_SUCCESS)
				    StringF(tempStr2,'\tPhoneNumber Failure (\s)',tempStr)
				    callersLog(tempStr2)
				    aePuts('Invalid PhoneNumber\b\n')
				    tries++
          ENDIF
			 UNTIL stat=RESULT_SUCCESS
		 ENDIF
	   statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)

/*
#ifdef RTS
	    if(UUCP) {
		    if(User.UUCPA) {
			    ValidUser=3
			    conPuts("\b\nSystem dropping to UUCP...")
			    CallersLog("\tReceiving UUCP feed")
			    PurgeLineEnd()
			    if(lfh=Open("NIL:",MODE_OLDFILE))>0 {
				    sprintf(GSTR2,"uucico -D %s -U %u -Getty -7 -xx",Cmds->SerDev,Cmds->SerDevUnit)
				    Execute(GSTR2,(DeBuG?0:lfh),(DeBuG?0:lfh))
				    Close(lfh)
				}
			    PurgeLineStart()
			    DropDTR()
			    return(FAILURE)
			}
		    AEPutStr("UUCP access has been denied!\b\n\b\n")
		}
#endif*/
    RETURN RESULT_SUCCESS
  ENDWHILE
logoffErr:
  callersLog('\t* Password Failure *')
ENDPROC RESULT_FAILURE

PROC checkBaudCallingTime()

  DEF tempstr[255]:STRING
  DEF startTime,endTime,time


  time:=Div(getSystemTime(),60) ->remove seconds
  time:=Mod(time,1440)   ->hours and minutes only
  time:= Mod(time,60) + Mul(Div(time,60),100)   ->convert to number between 0000 and 2359

  IF(checkSecurity(ACS_OVERRIDE_TIMES)) THEN RETURN TRUE

  StringF(tempstr,'START.\d',onlineBaud)
  startTime:=readToolTypeInt(TOOLTYPE_NODE_TIMES,node,tempstr)
  IF startTime=-1 THEN startTime:=0

  StringF(tempstr,'END.\d',onlineBaud)
  endTime:=readToolTypeInt(TOOLTYPE_NODE_TIMES,node,tempstr)
  IF endTime=-1 THEN endTime:=2359

  IF (endTime<startTime)
    IF((time>=endTime) AND (time<startTime)) THEN RETURN FALSE
    RETURN TRUE
  ENDIF
  
  IF(time>=startTime) THEN IF(time<=endTime) THEN RETURN TRUE ELSE RETURN FALSE
ENDPROC

PROC baudTime()
  DEF stat
  DEF tempstr[255]:STRING

  stat:=checkBaudCallingTime()
  IF(stat=FALSE)
 	  IF(stat:=displayScreen(SCREEN_NOT_TIME)=FALSE)
  		StringF(tempstr,'\b\n\d baud is not allowed at this time.\b\n\b\n',onlineBaud)
 	    aePuts(tempstr)
 		ENDIF
  	stat:=FALSE
  	Delay(120)
 	ENDIF
ENDPROC stat

PROC processLogon()
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF userName[28]:STRING
  DEF dateStr[20]:STRING
  DEF retryCount
  DEF userFound
  DEF newUser
  DEF userNum
  DEF tries,stat
  DEF sysprompt[255]:STRING
  DEF filetags

  state:=STATE_CONNECTING
  stateData:=0
  setEnvStat(ENV_CONNECT)

  conCLS()

  IF((StrLen(cmds.sysPass)>0) AND (checkToolTypeExists(TOOLTYPE_NODE,node,'STEALTH_MODE')))
    IF readToolType(TOOLTYPE_NODE,node,'SYS_PWRD_PROMPT',sysprompt)=FALSE THEN StrCopy(sysprompt,'>: ')

    tries:=1
    WHILE tries<4
      displayScreen(SCREEN_PRIVATE)
      stat:=getPass2(sysprompt,cmds.sysPass,0,30)
		  IF(stat<0)
        state:=STATE_LOGGING_OFF
        RETURN
      ENDIF
	    EXIT stat=RESULT_SUCCESS
      aePuts('Invalid PassWord\b\n')
      tries++
		ENDWHILE

	  IF(tries=4)
		  callersLog('System Password Failure')
      state:=STATE_LOGGING_OFF
		  RETURN
    ENDIF
    aePuts('\b\n')
	ENDIF

  conPuts('[ p',-1)

  
  IF displayScreen(SCREEN_NOCALLERSATBAUD)
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  IF (StrLen(mybbsLoc)>0) 
    StringF(tempStr,'\b\n\b\n[0mWelcome to \s, located in \s',cmds.bbsName,mybbsLoc)
  ELSE
  StringF(tempStr,'\b\n\b\nu[0mWelcome to \s.',cmds.bbsName)
  ENDIF
  aePuts(tempStr)

 StringF(tempStr,'\b\n\b\nRunning AmiExpress \s Copyright (C)2018 Darren Coles\b\n',expressVer)
 aePuts(tempStr)
 aePuts('Original Version (C)1992-95 LightSpeed Technologies Inc.\b\n')
 StringF(tempStr,'Registration \s. You are connected to Node \d at \d baud',regKey,node,onlineBaud)
 aePuts(tempStr)
 ->strcpy(GSTR2,GetTheTime(Time_system))
 ->strcpy(GSTR3,GetTheDate(Time_system))
 formatLongDateTime(getSystemTime(),dateStr)
 StringF(tempStr,'\b\nConnection occured at \s.\b\n',dateStr)

   aePuts(tempStr)
   aePuts('\b\n')


   runSysCommand('FRONTEND','')

   IF (runSysCommand('ANSI','')=FALSE)

     aePuts('ANSI, RIP or No graphics (A/r/n)? ')
    
     stat:=lineInput('','',10,INPUT_TIMEOUT/2,tempStr,FALSE)
     IF stat<>RESULT_SUCCESS
       state:=STATE_LOGGING_OFF
       RETURN
     ENDIF

     UpperStr(tempStr)

     IF (InStr(tempStr,'N',0)>=0)
       ansiColour:=FALSE
       my_struct.ansiColor:=0
     ENDIF

     IF (InStr(tempStr,'Q',0)>=0) AND (sopt.qLogon<>0) THEN quickFlag:=TRUE
   ENDIF
 
  IF((StrLen(cmds.sysPass)>0) AND (Not(checkToolTypeExists(TOOLTYPE_NODE,node,'STEALTH_MODE'))))
    IF readToolType(TOOLTYPE_NODE,node,'SYS_PWRD_PROMPT',sysprompt)=FALSE THEN StrCopy(sysprompt,'>: ')

    tries:=1
    WHILE tries<4
      displayScreen(SCREEN_PRIVATE)
      stat:=getPass2(sysprompt,cmds.sysPass,0,30)
		  IF(stat<0)
        state:=STATE_LOGGING_OFF
        RETURN
      ENDIF
	    EXIT stat=RESULT_SUCCESS
      aePuts('Invalid PassWord\b\n')
      tries++
		ENDWHILE

	  IF(tries=4)
		  callersLog('System Password Failure')
      state:=STATE_LOGGING_OFF
		  RETURN
    ENDIF
    aePuts('\b\n')
	ENDIF

  displayScreen(SCREEN_BBSTITLE)

 IF logonType=LOGON_TYPE_REMOTE THEN ximPort:=SERIAL_PORT ELSE ximPort:=CONSOLE_PORT
 retryCount:=0
 userFound:=FALSE
 newUser:=FALSE
 
 updateCallerNum()

 validUser:=2

logonLoop:
 REPEAT

  ->StrCopy(tempStr,'Name')
  ->readToolType(TOOLTYPE_NODE,node,'NAME_PROMPT',tempStr)
  StringF(sysprompt,'\b\nEnter your \s: ',sopt.namePrompt)
 
 stat:=lineInput(sysprompt,'',28,INPUT_TIMEOUT/2,userName)
 IF stat<>RESULT_SUCCESS
   state:=STATE_LOGGING_OFF
   RETURN
 ENDIF

 IF (StrLen(userName)>0)
 
   userNum:=Val(userName)
   IF (checkToolTypeExists(TOOLTYPE_NODE,node,'USERNUMBER_LOGIN')) AND (userNum>0)
     IF loadAccount(userNum,tempUser,tempUserKeys,tempUserMisc)=RESULT_SUCCESS THEN stat:=userNum ELSE stat:=0
   ELSE
     stat:=findUserFromName(1,NAME_TYPE_USERNAME,userName,tempUser,tempUserKeys,tempUserMisc)
   ENDIF

   setEnvStat(ENV_ACCOUNTSEQ)

   IF (stat=0)
    StringF(tempStr,'\b\nThe name \s is not used on this BBS.\b\n',userName)
    aePuts(tempStr)
    stat:=lineInput('[R]etry your name or [C]ontinue as a new user? ','',28,INPUT_TIMEOUT/2,tempStr)
    IF stat<>RESULT_SUCCESS 
      state:=STATE_LOGGING_OFF
      RETURN
    ENDIF

    UpperStr(tempStr)
    IF StrCmp(tempStr,'C') THEN newUser:=TRUE ELSE retryCount++
   ELSE
     userNum:=stat
     userFound:=TRUE
   ENDIF
 ELSE
   retryCount++
 ENDIF

 UNTIL (userFound) OR (newUser) OR (retryCount=5)

 IF retryCount=5
    aePuts('\b\nToo Many Errors, Goodbye!\b\n')
    Delay(50)
    state:=STATE_LOGGING_OFF
    RETURN
 ENDIF

 stat:=doReserve(userName)
 IF(stat)
  state:=STATE_LOGGING_OFF
  RETURN
 ENDIF

 IF newUser
   IF newUserAccount(userName)<>RESULT_SUCCESS
     state:=STATE_LOGGING_OFF
     RETURN
   ENDIF
 ELSE
   loggedOnUser:=NEW loggedOnUser
   loggedOnUserKeys:=NEW loggedOnUserKeys
   loggedOnUserMisc:=NEW loggedOnUserMisc
   
   stat:=loadAccount(userNum,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
   IF(stat=RESULT_FAILURE) 
	   aePuts('That account has problems\b\n')
	   retryCount++
	   JUMP logonLoop
	 ENDIF
 ENDIF

 setEnvStat(ENV_LOGGINGON)
 sendQuietFlag(quietFlag)
 
 IF(loggedOnUser.slotNumber=0)
	  aePuts('That account has been deleted.\b\n')
    END loggedOnUser
    loggedOnUser:=NIL
    END loggedOnUserKeys
    loggedOnUserKeys:=NIL
    END loggedOnUserMisc
    loggedOnUserMisc:=NIL

    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

 IF logonType>=LOGON_TYPE_REMOTE
    stat:=checkPassword()
    IF stat<>RESULT_SUCCESS
      END loggedOnUser
      loggedOnUser:=NIL
      END loggedOnUserKeys
      loggedOnUserKeys:=NIL
      END loggedOnUserMisc
      loggedOnUserMisc:=NIL
      state:=STATE_LOGGING_OFF
      RETURN
    ENDIF
 ELSE
   displayUserToCallersLog(0)
 ENDIF

 validUser:=1

 convertAccess()

 acsLevel:=findAcsLevel()

 loggedOnUserKeys.baud:=onlineBaud
 masterLoadPointers(loggedOnUser) 

 stat:=baudTime()
 IF(stat=FALSE)
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  IF (loggedOnUser.secStatus<=1)
    acsLevel:=loggedOnUser.secStatus
    IF (acsLevel=0) THEN displayScreen(SCREEN_LOCKOUT0) ELSE displayScreen(SCREEN_LOCKOUT1)
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

 stat:=checkUserOnLine(loggedOnUser,1)
 IF(stat=FALSE)
      StringF(tempStr,'User \s already on another node!',loggedOnUser.name)
	    callersLog(tempStr)
      IF displayScreen(SCREEN_ONENODE)=FALSE THEN aePuts('You are already logged into another node!\b\n')
      state:=STATE_LOGGING_OFF
      Delay(50)
	    RETURN
 ENDIF

  IF logonType>=LOGON_TYPE_REMOTE
    IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ON_LOGON',tempStr))
      filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,NIL]:LONG
      processMci2(tempStr,tempStr2)
      SystemTagList(tempStr2,filetags)
      END filetags
    ENDIF

    IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ASYNC_ON_LOGON',tempStr))
      filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,TRUE,NIL]:LONG
      processMci2(tempStr,tempStr2)
      SystemTagList(tempStr2,filetags)
      END filetags
    ENDIF

    IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_LOGON')) AND (StrLen(mailOptions.sysopEmail)>0)
      StringF(tempStr,'\s: Ami-Express logon notification',cmds.bbsName)
      StringF(tempStr2,'This is a notification that \s from \s has logged on\n\n',loggedOnUser.name,loggedOnUser.location)
      sendMail(tempStr,tempStr2,TRUE, mailOptions.sysopEmail)
    ENDIF
  ENDIF

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
 
  IF (quickFlag=FALSE)
    IF (displayScreen(SCREEN_LOGON)) THEN doPause()
  ENDIF

  state:=STATE_LOGGEDON
  stateData:=0
ENDPROC

PROC processAwait()
    DEF obuf[255]:STRING
    DEF tempstr[255]:STRING
    DEF wasControl,ch
    DEF subState: PTR TO awaitState

    IF (stateData=0)
        ansiColour:=TRUE
        quickFlag:=FALSE
        lostCarrier:=FALSE
        subState:=NEW subState
        subState.subState:=SUBSTATE_DISPLAY_AWAIT
        IF(sopt.trapDoor=FALSE) THEN resetSystem(1)

        stateData:=subState
        logonType:=LOGON_TYPE_LOGGED_OFF
        servercmd:=-1
    ELSE
        subState:=stateData
    ENDIF
    
    IF (subState.subState=SUBSTATE_DISPLAY_AWAIT)
        ioFlags[IOFLAG_SCR_OUT]:=-1
        ioFlags[IOFLAG_SER_OUT]:=0
        setEnvStat(ENV_AWAITCONNECT)
        statPrintUser(NIL,NIL,NIL)
        IF dStatBar THEN clearStatusPane()

        IF (sopt.trapDoor=FALSE)
          aePuts('[37m[ s')
          aePuts('[0 p')

          send017()
          sendCLS()     

          StringF(tempstr,'\b\n           [33m© 1992-1995 AmiExpress [37mby[35m Light Speed Technologies Inc.[0m\b\n')
          aePuts(tempstr)
          StringF(tempstr,'\b\n                             [33m Version 5 © 2018[0m\b\n')
          aePuts(tempstr)

          StringF(tempstr,'\b\n                       [37m Programming by: [33m Darren Coles')
          aePuts(tempstr)
          aePuts('\b\n  [33m\b\n')

          IF displayScreen(SCREEN_AWAIT)=FALSE        
            aePuts('            [44;33m F1 [40;35m}- [33mSysop Login            [44;33m F2 [40;35m}- [33mLocal Login\b\n')
            aePuts('            [44;33m F3 [40;35m}- [33mInstant Remote Logon   [44;33m F4 [40;35m}- [33mReserve for a user\b\n')
            aePuts('            [44;33m F5 [40;35m}- [33mConference Maintenance [44;33m F6 [40;35m}- [33mAccount Editing\b\n')
            aePuts('            [44;33m F7 [40;35m}- [33mChat Toggle            [44;33m F8 [40;35m}- [33mReprogram modem\b\n')
            aePuts('            [44;33m F9 [40;35m}- [33mExit BBS               [44;33m F0 [40;35m}- [33mExit BBS [33m([37moff hook[33m)[0m\b\n\b\n')

            IF(StrLen(reservedName)>0)
              StringF(tempstr,'         [44;33m     The BBS is reserved for [31m\s[30]  [0m\b\n',reservedName)
              aePuts(tempstr)
            ENDIF
          ENDIF
        ENDIF
      
        subState.subState:=SUBSTATE_INPUT
        ioFlags[IOFLAG_SCR_OUT]:=0
        ioFlags[IOFLAG_SER_IN]:=0
    ENDIF

    IF (sopt.trapDoor=FALSE)
      wasControl,ch:=processInputMessage(1)
      IF dStatBar THEN clearStatusPane()
    ENDIF
    
    IF (checkSer()) OR (sopt.trapDoor)
      IF checkIncomingCall()=RESULT_CONNECT
        debugLog(LOG_DEBUG,'REMOTE LOGON')
        ioFlags[IOFLAG_SCR_OUT]:=-1

        logonType:=LOGON_TYPE_REMOTE
        reqState:=REQ_STATE_LOGON
      ENDIF
    ENDIF

    IF reqState=REQ_STATE_DISPLAY_AWAIT
      subState.subState:=SUBSTATE_DISPLAY_AWAIT
      reqState:=REQ_STATE_NONE
    ENDIF

    IF reqState<>REQ_STATE_NONE
      END subState
      IF loggedOnUser<>NIL THEN state:=STATE_LOGGING_OFF
      stateData:=0
      IF reqState=REQ_STATE_SYSOPLOGON 
        state:=STATE_SYSOPLOGON
        reqState:=REQ_STATE_NONE
      ENDIF
      IF reqState=REQ_STATE_LOGON 
        state:=STATE_LOGON
        reqState:=REQ_STATE_NONE
      ENDIF
      RETURN
    ENDIF
ENDPROC

PROC newUserAccount(userName: PTR TO CHAR)
  DEF tempStr[100]:STRING,tempStr2[255]:STRING
  DEF stat,tries=0
  DEF filetags

  IF StrLen(cmds.newUserPw)>0
    displayScreen(SCREEN_NEWUSERPW)

    REPEAT
		
      aePuts('Enter New User Password: ')
      stat:=lineInput('','',30,INPUT_TIMEOUT,tempStr)
      IF(stat<0) THEN RETURN RESULT_SLEEP_LOGOFF
      
      IF(logonType>=LOGON_TYPE_REMOTE)
        stat:=checkCarrier()
        IF(stat=FALSE) THEN RETURN RESULT_SLEEP_LOGOFF
      ENDIF
      
      IF(strCmpi(tempStr,cmds.newUserPw,ALL)) THEN stat:=RESULT_SUCCESS ELSE stat:=RESULT_FAILURE

      IF(stat<>RESULT_SUCCESS)
        IF checkToolTypeExists(TOOLTYPE_NODE,node,'SHOWPWFAIL')
          StringF(tempStr2,'\tPassword Failure (\s)',tempStr)
        ELSE
          StrCopy(tempStr2,'\tPassword Failure (xxxx)')
        ENDIF  
        callersLog(tempStr2)
        aePuts('Invalid PassWord\b\n')
        tries++   
		    IF(tries>2)
			    aePuts('\b\nExcessive Password Failure\b\n')
			    RETURN RESULT_SLEEP_LOGOFF
			  ENDIF
      ENDIF
    UNTIL (stat=RESULT_SUCCESS)

    aePuts('Correct\b\n')
  ENDIF

  IF displayScreen(SCREEN_NONEWUSERS) THEN RETURN RESULT_SLEEP_LOGOFF

  IF displayScreen(SCREEN_NONEWATBAUD)  THEN RETURN RESULT_SLEEP_LOGOFF

  displayScreen(SCREEN_GUESTLOGON)

  createNewAccount()
  
  strCpy(loggedOnUser.name,userName,31)

  doPause()

  displayScreen(SCREEN_JOIN)

  stat:=doNewUser()
  IF stat<>RESULT_SUCCESS THEN RETURN stat

  stat:=doNewUserQuestions()
  IF stat<>RESULT_SUCCESS THEN RETURN stat

  strCpy(loggedOnUserKeys.userName,loggedOnUser.name,31)
  UpperStr(loggedOnUserKeys.userName)

  displayUserToCallersLog(0)
  
  validUser:=1  /* ok script done */
  saveAccount(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,0,0)
  sendQuietFlag(quietFlag)
  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  clearMsgPointers()
  masterSavePointers(loggedOnUser)

  IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ON_NEW_USER',tempStr2))
    filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,NIL]:LONG
    processMci2(tempStr2,tempStr)
    SystemTagList(tempStr,filetags)
    END filetags
  ENDIF

  IF (readToolType(TOOLTYPE_BBSCONFIG,0,'EXECUTE_ASYNC_ON_NEW_USER',tempStr2))
    filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,TRUE,NIL]:LONG
    processMci2(tempStr2,tempStr)
    SystemTagList(tempStr,filetags)
    END filetags
  ENDIF

  IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_NEW_USER')) AND (StrLen(mailOptions.sysopEmail)>0)
    StringF(tempStr,'\s: Ami-Express new user notification',cmds.bbsName)
    StringF(tempStr2,'This is a notification that a new user called \s from \s has registered.',loggedOnUser.name,loggedOnUser.location)
    sendMail(tempStr,tempStr2,FALSE,mailOptions.sysopEmail)
  ENDIF

  displayScreen(SCREEN_JOINED)

  doPause()
ENDPROC stat

PROC doNewUser()
  DEF ch,i,stat
  DEF string[255]:STRING
  ->DEF namePrompt[255]:STRING

  ->StrCopy(namePrompt,'Name')
  ->readToolType(TOOLTYPE_NODE,node,'NAME_PROMPT',namePrompt)
  
jLoop1:
  aePuts('\b\n')
  aePuts('Blank line to retreat\b\n')

  ch:=0
iJLoop:

  FOR i:=0  TO 4
    StringF(string,'\b\nenter your \s: ',sopt.namePrompt)
    aePuts(string)
                                         /*** MAKE KEYBOARD_TIMEOUT A VARIABLE */
    stat:=lineInput('',loggedOnUser.name,30,INPUT_TIMEOUT,string)
    IF(stat<0) THEN RETURN stat
    strCpy(loggedOnUser.name,string,31)

    IF(StrLen(loggedOnUser.name)=0)
 	    ch++
	    IF(ch>5)
 		    aePuts('\b\nToo Many Errors, Goodbye!\b\n')
	    	RETURN RESULT_FAILURE
		  ENDIF
      JUMP floopc
	  ENDIF

    IF(StrLen(loggedOnUser.name)=1)
 	    aePuts('Get REAL!!  One Character???\b\n')
      JUMP floopc
	  ENDIF
    strCpy(string,loggedOnUser.name,31)

    IF(stat:=checkIfNameAllowed(string))
      JUMP floopc
    ENDIF

    strCpy(string,loggedOnUser.name,31)

    aePuts('\b\nChecking for duplicate name...')
    stat:=checkForAst(string)

    IF(stat) 
 	    aePuts('No wildcards allowed in a name.\b\n')
      JUMP floopc
	  ENDIF

    stat:=findUserFromName(1,NAME_TYPE_USERNAME,string,tempUser,tempUserKeys,tempUserMisc)
    IF(stat<>0)
 	    aePuts('Already in use!, try another.\b\n')
      JUMP floopc
	  ENDIF
    aePuts('Ok!\b\n\b\n')
    JUMP jLoop2

floopc:
  ENDFOR

  aePuts('\b\nToo Many Errors, Goodbye!\b\n')
  RETURN RESULT_FAILURE

->//--- end new loop1

jLoop2:
  aePuts('City, State: ')
  stat:=lineInput('','',29,INPUT_TIMEOUT,string)
  IF(stat<0) THEN RETURN stat
  strCpy(loggedOnUser.location,string,30)
  IF(StrLen(loggedOnUser.location)=0)
    aePuts('\b\n')
    JUMP iJLoop
  ENDIF

jLoop3:
  aePuts('Phone Number: ')
  stat:=lineInput('','',12,INPUT_TIMEOUT,string)
  IF(stat<0) THEN RETURN stat
  strCpy(loggedOnUser.phoneNumber,string,13)

  IF(StrLen(loggedOnUser.phoneNumber)=0)
    aePuts('\b\n')
    JUMP jLoop2
  ENDIF

  aePuts('Enter a PassWord: ')
  stat:=lineInput('','',50,INPUT_TIMEOUT,string)
  IF(stat<0) THEN RETURN stat
  IF(StrLen(string)=0)
    aePuts('\b\n')
    JUMP jLoop3
  ENDIF
  UpperStr(string)
  loggedOnUser.pwdHash:=calcPasswordHash(string)

  stat:=numberOfLinesTest()
  IF(stat<0) THEN RETURN stat

  aePuts('\b\n')
  stat:=chooseComputer()
  IF(stat<0) THEN RETURN stat
  aePuts('\b\n')


  loggedOnUserKeys.baud:=onlineBaud
  loggedOnUserKeys.userFlags:=USER_NEWMSG
  aePuts('You want Screen Clears after Messages ? ')
  ch:=checkOnlineStatus()
  IF(ch<0) THEN RETURN ch
 	ch:=readChar(INPUT_TIMEOUT)
  IF(ch<0) THEN RETURN ch
 	IF((ch="Y") OR (ch="y"))
    loggedOnUserKeys.userFlags:=loggedOnUserKeys.userFlags OR USER_SCRNCLR         /* screen clear code sent */
    aePuts('Yes..\b\n\b\n')
 	ELSE
    aePuts('No!\b\n\b\n')
  ENDIF

  StringF(string,'Handle: \s\b\n',loggedOnUser.name)
  aePuts(string)
  StringF(string,'City, St.: \s\b\n',loggedOnUser.location)
  aePuts(string)
  StringF(string,'Phone Num: \s\b\n',loggedOnUser.phoneNumber)
  aePuts(string)
  StringF(string,'Num Lines: \d\b\n',loggedOnUser.lineLength)
  aePuts(string)
  StringF(string,'PassWord : \s\b\n','ENCRYPTED')
  aePuts(string)
  StringF(string,'Computer : \s\b\n',computerTypes[loggedOnUser.secBulletin])
  aePuts(string)
  aePuts('Scrn Clr : ')
  IF(loggedOnUserKeys.userFlags AND USER_SCRNCLR) THEN aePuts('YES\b\n') ELSE aePuts('NO\b\n')
  aePuts('\b\n')
  purgeLine()
  aePuts('Is the above Correct? ')

  WHILE TRUE
  	ch:=checkOnlineStatus()
  	IF(ch<0) THEN RETURN ch
	  ch:=readChar(INPUT_TIMEOUT)
  	IF(ch<0) THEN RETURN ch
	  IF((ch="N") OR (ch="n") OR (ch="Q") OR (ch="q"))
      aePuts('No!\b\n\b\n')
	    JUMP jLoop1
		ENDIF
    EXIT ((ch="Y") OR (ch="y"))
  ENDWHILE
  aePuts('Yes..\b\n\b\n')

ENDPROC

PROC doNewUserQuestions()
  DEF filename[200]:STRING, afilename[200]:STRING
  DEF ch,stat
  DEF c[200]:STRING,string[200]:STRING,datestr[20]:STRING
  DEF p: PTR TO CHAR
  DEF fp2,fp1
  DEF temp1[255]:STRING
  DEF temp2[255]:STRING

  StringF(filename,'\sNode\d/Script\d',cmds.bbsLoc,node,onlineBaud)
  StringF(afilename,'\sNode\d/Answers',cmds.bbsLoc,node)

qAgain:
 
  StringF(string,'\sNode\d/TempAns',cmds.bbsLoc,node)

  IF((fp1:=Open(string,MODE_READWRITE))<=0) THEN RETURN RESULT_GOODBYE
  Seek(fp1,0,OFFSET_END)

  formatLongDateTime(getSystemTime(),datestr)

  fileWriteLn(fp1,'**************************************************************')
  StringF(temp1,'\s [\d] \s (\s) \s',datestr,loggedOnUser.slotNumber,loggedOnUser.name,connectString,loggedOnUser.location)
  fileWriteLn(fp1,temp1)
  Close(fp1)

  IF (runSysCommand('SCRIPT','')=FALSE)

    fp2:=Open(filename,MODE_OLDFILE)
    IF(fp2<=0) THEN RETURN RESULT_SUCCESS
    
    IF((fp1:=Open(string,MODE_READWRITE)))<=0 THEN RETURN RESULT_GOODBYE
    Seek(fp1,0,OFFSET_END)
  
    -> read & verify Questionaire
    WHILE(ReadStr(fp2,c)<>-1) OR (StrLen(c)>0)
      IF (StrLen(c)=0) OR (c[StrLen(c)-1]<>"~")
        aePuts(c)
        aePuts('\b\n')
        fileWriteLn(fp1,c)
      ELSE
        SetStr(c,StrLen(c)-1)
        aePuts(c)
        fileWrite(fp1,c)
        stat:=lineInput('','',70,INPUT_TIMEOUT,string)
        IF(stat<0)
          Close(fp1)
          Close(fp2)
          RETURN stat
        ENDIF
        fileWriteLn(fp1,string)
      ENDIF
    ENDWHILE
    Close(fp1)
    Close(fp2)
  ENDIF
  
  aePuts('\b\n')
 
  aePuts('Is the above Correct? ')
 
  WHILE TRUE
  	ch:=checkOnlineStatus()
 	  IF(ch<0) THEN RETURN ch
  	ch:=readChar(INPUT_TIMEOUT)
 	  IF(ch<0) THEN RETURN ch
  	IF((ch="N") OR (ch="n") OR (ch="Q") OR (ch="q"))
  		aePuts('No!\b\n\b\n')
 	   JUMP qAgain
 		ENDIF
  	IF((ch="Y") OR (ch="y")) THEN JUMP qbreak
 	ENDWHILE
qbreak:
  aePuts('Yes..\b\n\b\n')
 
  IF(fp1:=Open(afilename,MODE_READWRITE))<=0
    fp1:=Open(afilename,MODE_NEWFILE)
  ELSE
    Seek(fp1,0,OFFSET_END)
 	ENDIF
 
  StringF(string,'\sNode\d/TempAns',cmds.bbsLoc,node)
  IF((fp2:=Open(string,MODE_OLDFILE)))>0
  	WHILE(TRUE)
      EXIT ((ReadStr(fp2,c))=-1) AND (StrLen(c)=0)
      fileWriteLn(fp1,c)
 		ENDWHILE
 	  Close(fp1)
 	  Close(fp2)
 	ENDIF
ENDPROC RESULT_SUCCESS

PROC initNewUser(userData:PTR TO user,userKeys: PTR TO userKeys,userMisc: PTR TO userMisc,slotNumber)
  DEF ttdata[255]:STRING

  userData.secStatus:=readToolTypeInt(TOOLTYPE_PRESET,1,'PRESET.ACCESS')
  userData.secBoard:=readToolTypeInt(TOOLTYPE_PRESET,1,'PRESET.RATIO_TYPE')
  userData.secLibrary:=readToolTypeInt(TOOLTYPE_PRESET,1,'PRESET.RATIO')
  userData.timeLimit:=readToolTypeInt(TOOLTYPE_PRESET,1,'PRESET.TIME_LIMIT')
  userData.messagesPosted:=0
  userData.newUser:=1
  userData.newSinceDate:=0
  userData.uploads:=0
  userData.downloads:=0
  userData.confRJoin:=readToolTypeInt(TOOLTYPE_PRESET,1,'PRESET.CONFRJOIN')
  IF(userData.confRJoin=NIL) THEN userData.confRJoin:=1
  userData.timeLastOn:=0
  userData.timeUsed:=0
  userData.timeTotal:=userData.timeLimit
  userData.timesCalled:=0
  userData.bytesDownload:=0
  userData.bytesUpload:=0
  userData.protocol:="Z"
  userData.timeLastOn:=getSystemTime()
  userData.dailyBytesLimit:=readToolTypeInt(TOOLTYPE_PRESET,1,'PRESET.DAILY_BYTE_LIMIT')

  userData.dailyBytesDld:=0
  userData.chatLimit:=0; userData.chatRemain:=0; userData.creditDays:=0
  userData.creditAmount:=0; userData.creditStartDate:=0; userData.creditTotalToDate:=0
  userData.creditTotalDate:=0; userData.creditTracking:=0; userData.confYM9:=0

  userData.accountDate:=getSystemTime(); userData.screenType:=0
  userData.editorType:=0

  /*userData.confRead1:=0*/ userData.confRead2:=0; userData.confRead3:=0
  userData.zoomType:=0; userData.unknown:=0; userData.unknown2:=0; userData.unknown3:=0
  userData.xferProtocol:=0; userData.filler2:=0
  userData.lcFiles:=0; userData.badFiles:=0 
  userData.expert:="N"
  
  readToolType(TOOLTYPE_PRESET,1,'PRESET.AREA',ttdata)
  strCpy(userData.conferenceAccess,ttdata,10)
  strCpy(userData.location,' ',ALL)

  userData.slotNumber:=slotNumber
  userKeys.number:=slotNumber
  strCpy(userKeys.userName,userData.name,ALL)

  userKeys.dnCPS:=0
  userKeys.upCPS:=0
  userKeys.baud:=0    /* hold last logged on baud rate */
  
ENDPROC

PROC createNewAccount()

  loggedOnUser:=NEW loggedOnUser
  loggedOnUserKeys:=NEW loggedOnUserKeys
  loggedOnUserMisc:=NEW loggedOnUserMisc

  loggedOnUser.pass0:=0
  ->strCpy(loggedOnUser.pass,'',ALL)

  loggedOnUser.slotNumber:=0
  initNewUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,findFreeSlot())

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)

  loggedOnUserKeys.baud:=onlineBaud
  validUser:=0

  bytesADL:=loggedOnUser.dailyBytesLimit

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
ENDPROC

PROC findFreeSlot()
  DEF slot, stat, fh
  DEF tempStr[255]:STRING

  fh:=Open(userDataFile,MODE_OLDFILE)
  IF(fh<=0) THEN RETURN 0

  IF (sopt.toggles[TOGGLES_APPENDNEW])
    Seek(fh,0,OFFSET_END)
    slot:=Div(Seek(fh,0,OFFSET_CURRENT),SIZEOF user)
    Close(fh)
    RETURN slot+1
  ENDIF

  slot:=0
  REPEAT
   stat:=Read(fh,tempUser,SIZEOF user)
   slot++
     IF stat<>0
       IF(stat<>SIZEOF user)
         Close(fh)
         RETURN 0
       ENDIF
       IF (tempUser.slotNumber=0)
         Close(fh)
         RETURN slot
       ENDIF
     ENDIF
  UNTIL stat<>SIZEOF user
ENDPROC slot

PROC expressToFront()
  IF screen<>NIL
    ScreenToFront(screen)
  ELSEIF window<>NIL
    WindowToFront(window)
  ENDIF
ENDPROC

PROC expressToBack()
  IF screen<>NIL
    ScreenToBack(screen)
  ELSEIF window<>NIL
    WindowToBack(window)
  ENDIF
ENDPROC

PROC initZmodemStatCon()
  IF zModemStatWriteMP=NIL THEN zModemStatWriteMP:=createPort(0,0)
  IF zModemStatWriteIO=NIL THEN zModemStatWriteIO:=createStdIO(zModemStatWriteMP)
  zModemStatWriteIO.data:=windowZmodem
  OpenDevice('console.device', 0, zModemStatWriteIO, 0)
ENDPROC

PROC closezModemStats()
  IF zModemStatWriteIO<>NIL
    CloseDevice(zModemStatWriteIO)
    deleteStdIO(zModemStatWriteIO)
    zModemStatWriteIO:=NIL
  ENDIF
  IF zModemStatWriteMP<>NIL
    deletePort(zModemStatWriteMP)
    zModemStatWriteMP:=NIL
  ENDIF
  
 	IF(windowZmodem<>NIL) THEN CloseWindow(windowZmodem)
  windowZmodem:=NIL
ENDPROC

PROC openZmodemStat()
  DEF tags
  tags:=NEW [WA_CLOSEGADGET,1,
        WA_CUSTOMSCREEN,screen,
        WA_SIZEGADGET,1,
        WA_DRAGBAR,1,
        WA_LEFT,170,
        WA_TOP,50,
        WA_WIDTH,350,
        WA_HEIGHT,125,
        WA_DETAILPEN,0,
        WA_BLOCKPEN,7,
        WA_TITLE,
        zModemInfo.titleBar,
        WA_IDCMP,IDCMP_CLOSEWINDOW,
        WA_FLAGS,WFLG_ACTIVATE,NIL]
  IF (windowZmodem=NIL) AND (screen<>NIL)
      windowZmodem:=OpenWindowTagList(NIL,tags)
    initZmodemStatCon()
    zmodemStatPrint('[H[J[0 p[H\n FileName:\n FileSize: 0\n ETA Time:\n Curr Time:\n Position: 0\n Complete: 0%\n LastTime:\n      CPS: 0\n\n Z Status: Starting\n Errors: 0\n ErrorPos: 0')	
  ENDIF
  END tags
ENDPROC

PROC openExpressScreen()
  DEF error
  DEF width,height,top,left,dispId,colourcount
  DEF blockpen
  DEF pubScreen[255]:STRING
  DEF debugstr[255]:STRING
  DEF pub=FALSE
  DEF pubLock
  DEF opentags,temp
  
  IF scropen THEN RETURN
    
  IF readToolType(TOOLTYPE_WINDOW,node,'WINDOW.PUBSCREEN',pubScreen)
    pub:=TRUE
  ENDIF

  IF pub
    IF StrLen(pubScreen)>0
      pubLock:=LockPubScreen(pubScreen)
    ELSE
      pubLock:=LockPubScreen(NIL)
    ENDIF
    IF pubLock=FALSE THEN pub:=FALSE
    StringF(debugstr,'pubscreen \s \d',pubScreen,pubLock)
    debugLog(LOG_DEBUG,debugstr)
  ENDIF

  IF((sopt.statBar<>FALSE) AND (pub=FALSE)) THEN dStatBar:=1
  ->IF (checkToolTypeExists(TOOLTYPE_WINDOW,node,'WINDOW.STATBAR')) THEN dStatBar:=1

  /*width:=readToolTypeInt(TOOLTYPE_WINDOW,node,'WINDOW.WIDTH')
  IF width=-1 THEN width:=640
  
  height:=readToolTypeInt(TOOLTYPE_WINDOW,node,'WINDOW.HEIGHT')
  IF width=-1 THEN width:=640
  
  top:=readToolTypeInt(TOOLTYPE_WINDOW,node,'WINDOW.TOPEDGE')
  IF top=-1 THEN top:=12
  
  left:=readToolTypeInt(TOOLTYPE_WINDOW,node,'WINDOW.LEFTEDGE')
  IF left=-1 THEN left:=0

  colourcount:=readToolTypeInt(TOOLTYPE_WINDOW,node,'WINDOW.NUM_COLORS')
  SELECT colourcount
    CASE 2
      bitPlanes:=1
    CASE 4
      bitPlanes:=2
    CASE 8
      bitPlanes:=3
    CASE 16
      bitPlanes:=4
    DEFAULT
      bitPlanes:=3
  ENDSELECT*/
  top:=sopt.topEdge
  left:=sopt.leftEdge
  width:=sopt.width
  height:=sopt.height
  bitPlanes:=sopt.bitPlanes
  
  readToolType(TOOLTYPE_NODE,node,'EXPFONT',fontName)
  defaultfontattr.name:=fontName
  defaultfontattr.ysize:=8

  fontHandle:=OpenFont(defaultfontattr)
  IF fontHandle=NIL THEN fontHandle:=OpenDiskFont(defaultfontattr)

  IF pub=FALSE
    IF screen=NIL  
         
      dispId:=V_HIRES
      IF sopt.interlace THEN dispId:=dispId OR V_LACE
      
      temp:=readToolTypeInt(TOOLTYPE_WINDOW,node,'WINDOW.DISPLAYID')
      IF temp<>-1 THEN dispId:=temp

      ->IF(sopt.toggles[TOGGLES_RED1]=FALSE)
      ->debugLog(LOG_DEBUG,'red1=false')
      ->blockpen:=1
      ->screen:=OpenScreenTagList(NIL,
      ->  
      ->    [SA_TYPE,CUSTOMSCREEN,SA_LEFT,0,SA_TOP,0,SA_WIDTH,width,SA_HEIGHT,height,SA_DEPTH,bitPlanes,SA_TITLE,titlebar,SA_DISPLAYID,dispId,
      ->        SA_DETAILPEN,0,SA_BLOCKPEN,blockpen, 
      ->        SA_PENS,[0,1,1,1,6,4,1,0,4,1,4,1,-1]:INT,
      ->        SA_INTERLEAVED,1,
  ->  ->            SA_FULLPALETTE,1,
      ->          SA_FONT,defaultfontattr,
      ->          SA_COLORS,[0,0,0,0,1,15,15,15,2,0,15,0,3,15,15,0,4,0,0,15,5,15,0,15,6,0,15,15,7,15,0,0,-1,0,0,0]:INT,NIL])
      ->ELSE
      ->  debugLog(LOG_DEBUG,'red1=true')
        blockpen:=7
        opentags:=NEW [SA_TYPE,CUSTOMSCREEN,SA_LEFT,0,SA_TOP,0,SA_WIDTH,width,SA_HEIGHT,height,SA_DEPTH,bitPlanes,SA_TITLE,titlebar,SA_DISPLAYID,dispId,
                SA_DETAILPEN,1,SA_BLOCKPEN,blockpen, 
                SA_PUBNAME,IF StrLen(pubScreen)>0 THEN pubScreen ELSE 0,
                SA_PENS,[0,7,7,7,6,4,7,0,4,7,4,7,-1]:INT,
                SA_INTERLEAVED,1,
  ->              SA_FULLPALETTE,1,
                SA_FONT,defaultfontattr,
                SA_COLORS,[0,0,0,0,1,15,0,0,2,0,15,0,3,15,15,0,4,0,0,15,5,15,0,15,6,0,15,15,7,15,15,15,-1,0,0,0]:INT,NIL]
        screen:=OpenScreenTagList(NIL,opentags)
        END opentags

        IF StrLen(pubScreen)>0
          PubScreenStatus(screen,0)
          pubLock:=LockPubScreen(pubScreen)
          IF pubLock<>FALSE THEN pub:=TRUE
        ENDIF

      ->ENDIF
    ENDIF

    IF screen=NIL THEN RETURN ERR_SCREEN
        
    IF windowClose=NIL
      opentags:=NEW [WA_CLOSEGADGET,1,WA_BORDERLESS,1,WA_CUSTOMSCREEN,screen,
         WA_TOP,0,
         WA_LEFT,0,
         WA_WIDTH,18,
         WA_HEIGHT,12,
         WA_DETAILPEN,0,
         WA_BLOCKPEN,blockpen,
       WA_IDCMP,IDCMP_CLOSEWINDOW,NIL]
      windowClose:=OpenWindowTagList(NIL,opentags)
      END opentags
    ENDIF
    
    IF windowClose=NIL THEN RETURN ERR_WINDOW
  ENDIF
 
  IF window=NIL
    IF pub
      opentags:= NEW [WA_PUBSCREEN,pubLock,
        WA_CLOSEGADGET,1,
        WA_SIZEGADGET,1,
        WA_DEPTHGADGET,1,
        WA_DRAGBAR,1,
        WA_TOP,top,
        WA_LEFT,left,
        WA_WIDTH,width,
        WA_HEIGHT,height+30,
        WA_MINWIDTH,-1,
        WA_MAXWIDTH,-1,
        WA_MINHEIGHT,-1,
        WA_MAXHEIGHT,-1,
        WA_DETAILPEN,0,
        WA_BLOCKPEN,blockpen,
        WA_IDCMP,IDCMP_CLOSEWINDOW,
        WA_FLAGS,WFLG_ACTIVATE,NIL]
      window:=OpenWindowTagList(NIL,opentags)
      END opentags
      UnlockPubScreen(NIL,pubLock)
      IF fontHandle<>NIL THEN SetFont(window.rport,fontHandle)
    ELSE
      opentags:=NEW [WA_BORDERLESS,1,WA_CUSTOMSCREEN,screen,
        WA_TOP,top+12,
        WA_LEFT,left,
        WA_WIDTH,width,
        WA_HEIGHT,height-12,
        WA_DETAILPEN,0,
        WA_BLOCKPEN,blockpen,
        WA_FLAGS,WFLG_ACTIVATE,NIL]
      window:=OpenWindowTagList(NIL,opentags)
      END opentags
    ENDIF
  ENDIF 
  IF window=NIL THEN RETURN

  IF zModemInfo.inProgress<>ZMODEM_NONE
    openZmodemStat()
  ENDIF

  IF state=STATE_AWAIT THEN reqState:=REQ_STATE_DISPLAY_AWAIT
    
  -> Create reply port and io block for writing to console
  IF consoleMP=NIL THEN consoleMP:=createPort(0, 0)
  IF consoleMP=NIL THEN RETURN ERR_PORT
  
  IF consoleIO=NIL THEN consoleIO:=createExtIO(consoleMP,SIZEOF iostd)
  IF consoleIO=NIL THEN RETURN ERR_IO
  
  -> Create reply port and io block for reading from console
  IF consoleReadMP=NIL THEN consoleReadMP:=createPort(0, 0)
  IF consoleReadMP=NIL  THEN RETURN ERR_PORT
  IF consoleReadIO=NIL THEN consoleReadIO:=createExtIO(consoleReadMP, SIZEOF iostd)
  IF consoleReadIO=NIL THEN RETURN ERR_IO

  consoleIO.data:=window
  consoleIO.length:=SIZEOF window
  IF error:=OpenDevice('console.device', 0, consoleIO, 0) THEN RETURN ERR_DEV
 
  consoleReadIO.device:=consoleIO.device  -> Clone required parts
  consoleReadIO.unit:=consoleIO.unit
  queueRead(consoleReadIO, {ibuf})  -> Send the first console read request
  scropen:=TRUE
  conPuts('[37m[ s')
  conPuts('[0 p')
  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
ENDPROC ERR_NONE

PROC closeExpressScreen()
  IF scropen=FALSE THEN RETURN

    closeAEStats()
    closezModemStats()
    
    IF consoleIO
      IF CheckIO(consoleIO)=FALSE THEN AbortIO(consoleIO)
->    WaitIO(consoleIO)
      CloseDevice(consoleIO)
      deleteExtIO(consoleIO)
    consoleIO:=NIL
    ENDIF 
  IF consoleReadIO
    IF CheckIO(consoleReadIO)=FALSE THEN AbortIO(consoleReadIO)
->    WaitIO(consoleReadIO)
    deleteExtIO(consoleReadIO)
  consoleReadIO:=NIL
  ENDIF  

  IF consoleMP 
  deletePort(consoleMP)
  consoleMP:=NIL
  ENDIF

  IF consoleReadMP
  deletePort(consoleReadMP)
  consoleReadMP:=NIL
  ENDIF 
  

  IF windowClose
    CloseWindow(windowClose)
    windowClose:=NIL
  ENDIF
  
  IF window 
    CloseWindow(window)
    window:=NIL
  ENDIF
  
  IF screen
  IF CloseScreen(screen) THEN screen:=NIL
  ENDIF
  
  IF fontHandle
    CloseFont(fontHandle)
    fontHandle:=NIL
  ENDIF

  scropen:=FALSE
ENDPROC
     
PROC main() HANDLE
  DEF temppath[255]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF msg,cb: PTR TO confBase
  DEF i,notfound
  DEF p : PTR TO CHAR
  DEF tempfh
   
  StrCopy(expressVer,'v5.0.0-b8',ALL)
  StrCopy(expressDate,'03-Aug-2018',ALL)

  stripAnsi(0,0,1,0)
  
    securityNames:=[
     'ACS.ACCOUNT_EDITING','ACS.READ_BULLETINS','ACS.COMMENT_TO_SYSOP','ACS.DOWNLOAD','ACS.UPLOAD','ACS.ENTER_MESSAGE','ACS.FILE_LISTINGS','ACS.JOIN_CONFERENCE','ACS.NEW_FILES_SINCE',
     'ACS.PAGE_SYSOP','ACS.READ_MESSAGE','ACS.REMOTE_SHELL','ACS.DISPLAY_USER_STATS','ACS.VIEW_A_FILE','ACS.EDIT_USER_INFO','ACS.EDIT_INTERNET_NAME','ACS.EDIT_USER_LOCATION',
     'ACS.EDIT_PHONE_NUMBER','ACS.EDIT_PASSWORD','ACS.ZIPPY_TEXT_SEARCH','ACS.OVERRIDE_CHAT','ACS.SYSOP_DOWNLOAD','ACS.SYSOP_VIEW','ACS.SYSOP_READ','ACS.KEEP_UPLOAD_CREDIT',
     'ACS.OVERRIDE_TIMES','ACS.CLEAR_SCREEN_MSG','ACS.FREE_RESUMING','ACS.ONE_TIME_BULLETINS','ACS.DO_CALLERSLOG','ACS.SENTBY_FILES','ACS.DO_UD_LOG','ACS.SCREEN_TO_FRONT',
     'ACS.DEFAULT_CHAT_ON','ACS.EALL_MESSAGES','ACS.DUPE_FILECHECK','ACS.MESSAGE_EDIT','ACS.LIST_NODES','ACS.MSG_LEVEL','ACS.MSG_EXPERATION','ACS.DELETE_MESSAGE','ACS.ATTACH_FILES',
     'ACS.CUSTOMCOMMANDS','ACS.JOIN_SUB_CONFERENCE','ACS.ZOOM_MAIL','ACS.MCI_MSG','ACS.EDIT_DIRS','ACS.EDIT_FILES','ACS.BREAK_CHAT','ACS.QUIET_NODE','ACS.SYSOP_COMMANDS','ACS.WHO_IS_ONLINE',
     'ACS.RELOGON','ACS.ULSTATS','ACS.XPR_RECEIVE','ACS.XPR_SEND','ACS.WILDCARDS','ACS.CONFERENCE_ACCOUNTING','ACS.PRI_MSGFILES','ACS.PUB_MSGFILES','ACS.FULL_EDIT','ACS.CONFFLAGS',
     'ACS.OLM','ACS.HIDE_FILES','ACS.SHOW_PAYMENTS','ACS.CREDIT_ACCESS','ACS.VOTE','ACS.MODIFY_VOTE','ACS.FILE_EXPANSION','ACS.EDIT_REAL_NAME','ACS.EDIT_USER_NAME','ACS.CENSORED',
     'ACS.ACCOUNT_VIEW','ACS.TRANSLATION','ACS.UNKNOWN','ACS.CREATE_CONFERENCE','ACS.LOCAL_DOWNLOADS','ACS.MAX_PAGES','ACS.OVERRIDE_DEFAULTS']

    
    my_struct.zoom_mailcnt:=0
    my_struct.zoom_mailfile:=NIL
    my_struct.zoom_path:=NIL
    my_struct.maxdbytes:=99000000
    my_struct.sessiondbytes:=0
    my_struct.newuser:=0
    my_struct.times_on:=0
    my_struct.ansiColor:=0
    my_struct.startchatfile:=NIL
    my_struct.stopchatfile:=NIL
    my_struct.quotefile:=NIL
    my_struct.startchatnum:=0
    my_struct.stopchatnum:=0
    my_struct.quotenum:=0
    my_struct.numlastcallers:=0
    my_struct.lastcallerlevel:=255
    my_struct.callerlist:=NIL
    my_struct.newuserfile:=NIL
    my_struct.max_desclines:=12
    my_struct.uPcps:=0
    my_struct.dNcps:=0
    my_struct.uPcps_name:=NIL
    my_struct.uPcps_place:=NIL
    my_struct.dNcps_name:=NIL
    my_struct.dNcps_place:=NIL
    my_struct.flags:=0
    my_struct.cosysop_level:=250
    my_struct.countryname:=NIL
    my_struct.notallowedfiles:=NIL
    my_struct.skiplcaller:=NIL
    my_struct.menu_say:=NIL
    my_struct.nozoom[0]:=0;my_struct.nozoom[1]:=0;my_struct.nozoom[2]:=0;my_struct.nozoom[3]:=0;my_struct.nozoom[4]:=0
    my_struct.nozoom[5]:=0;my_struct.nozoom[6]:=0;my_struct.nozoom[7]:=0;my_struct.nozoom[8]:=0
    
    my_struct.zoommax:=0
    
  IF (iconbase:=OpenLibrary('icon.library',33))=NIL THEN Raise(ERR_NOICON)

   IF (diskfontbase:=OpenLibrary('diskfont.library', 37))=NIL THEN Raise(ERR_NO_DISKFONT)

  IF (cxbase:=OpenLibrary('commodities.library', 37))=NIL THEN Raise(ERR_LIB)
  
  -> Commodities talks to a Commodities application through an Exec Message
  -> port, which the application provides
  broker_mp:=CreateMsgPort()

  StringF(tempstr,'Express Node \d',node)
  
  broker:=CxBroker(
           [NB_VERSION,   -> Version of the NewBroker object
            0,  -> E-Note: pad byte
           tempstr,  -> Name: commodities uses for this commodity
           'Express',      -> Title of commodity that appears in CXExchange
           'Broker for express',  -> Description
            0,  -> Unique: tells CX not to launch a commodity with the same name
            COF_SHOW_HIDE,  -> Flags: tells CX if this commodity has a window
            0,  -> Pri: this commodity's priority
            0,  -> E-Note: pad byte
            broker_mp, -> Port: mp CX talks to
            0   -> ReservedChannel: reserved for later use
           ]:newbroker, NIL)
  cxsigflag:=Shl(1, broker_mp.sigbit)

  historyBuf:=List(20)
  historyNum:=0
  historyCycle:=0

  scomment:=List(my_struct.max_desclines)
  FOR i:=1 TO my_struct.max_desclines
    msg:=String(200)
    ListAdd(scomment,[msg])
  ENDFOR

  msgBuf:=List(100)
  FOR i:=1 TO 100 
  msg:=String(80)
    ListAdd(msgBuf,[msg])
  ENDFOR
  
  skipdFiles:=AllocMem(32000,MEMF_CLEAR OR MEMF_PUBLIC)
 
  StrCopy(flaglist,'')
 
  StrCopy(fontName,'')

  StrCopy(securityFlags,'')

  parsedParams:=List(100)

  -> After it's set up correctly, the broker has to be activated
  ActivateCxObj(broker, TRUE)
  
  node:=0
  IF StrLen(arg)>0
    node:=Val(arg)
  ELSE
    debug:=TRUE
  ENDIF

  ioFlags[IOFLAG_FIL_IN]:=0
  ioFlags[IOFLAG_KBD_IN]:=-1
  ioFlags[IOFLAG_SER_IN]:=-1
  ioFlags[IOFLAG_FIL_OUT]:=0
  ioFlags[IOFLAG_PRT_OUT]:=0
  ioFlags[IOFLAG_SCR_OUT]:=0
  ioFlags[IOFLAG_SER_OUT]:=-1

  doorExtSig:=AllocSignal(-1)

  mailStat:=NEW mailStat
  mailHeader:=NEW mailHeader

  tempUser:=NEW tempUser
  tempUserKeys:=NEW tempUserKeys
  tempUserMisc:=NEW tempUserMisc
  
  IF createServerRP()=RESULT_FAILURE THEN Raise(ERR_SERVERRP)

  createResControl()
  createRexxPort()

  IF readToolType(TOOLTYPE_NODE,node,'FIRSTCOMMAND',tempstr)   
    processMci2(tempstr,tempstr2)
    Execute(tempstr2,NIL,NIL)
  ENDIF
  
  ringCount:=readToolTypeInt(TOOLTYPE_NODE,node,'RINGCOUNT')

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'TELNETD')
    ringCount:=2;
    strCpy(cmds.mInit,'',ALL)
    strCpy(cmds.mReset,'AT*C1\b',ALL)
    strCpy(cmds.mRing,'RING',ALL)
    strCpy(cmds.mAnswer,'ATA',ALL)
    strCpy(sopt.offHook,'',ALL)
  ENDIF
  
  IF(openSerial(cmds.openingBaud,8,1)<>0)
    StringF(tempstr,'Can''t open \s!',cmds.serDev)
    debugLog(LOG_ERROR,tempstr)
    Raise(ERR_NOSERIAL)
  ENDIF
 
  IF(sopt.trapDoor)
    IF (i:=InStr(arg,' '))<>-1
      StringF(trapConnect,'CONNECT \s',arg+i+1)
    ELSE
      StrCopy(trapConnect,'CONNECT 19200')
    ENDIF
  ELSE
    intDoReset(sopt.offHook)
    Delay(60)
    StringF(tempstr,'\s\b',cmds.mInit)
    serPuts(tempstr)
    Delay(60)
  ENDIF
  purgeLine()
  ioFlags[IOFLAG_SER_OUT]:=0

  /**** If MultiCom port initialized in ACP then setup appropriate links ****/
 IF(sopt.toggles[TOGGLES_MULTICOM])
    singleNode:=sopt.s
    masterNode:=sopt.t
 ENDIF

  IF(StrLen(sopt.offHook)=0)
    strCpy(sopt.offHook,'ATM0H1',ALL)
  ENDIF

  IF (StrLen(sopt.namePrompt)=0)
    strCpy(sopt.namePrompt,'Name',ALL)
  ENDIF
 
  timeoutOverride:=readToolTypeInt(TOOLTYPE_NODE,node,'OVERRIDE_TIMEOUT')

  i:=readToolTypeInt(TOOLTYPE_NODE,node,'MAX_MSG_QUE')
  IF i=-1 THEN i:=5
  olmQueue:=List(i)

  olmBuf:=List(100)
 
  cmds.numConf:=readToolTypeInt(TOOLTYPE_CONFCONFIG,'','NCONFS')

  sysopAvail:=checkToolTypeExists(TOOLTYPE_NODE,node,'CHAT_ON')

  StrCopy(historyFolder,'')
  readToolType(TOOLTYPE_BBSCONFIG,'','HISTORY',historyFolder)
  
  IF checkToolTypeExists(TOOLTYPE_NODE,node,'NO_EMAILS')=FALSE
    mailOptions.smtpPort:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'SMTP_PORT')
    IF readToolType(TOOLTYPE_BBSCONFIG,0,'SMTP_HOST',tempstr) THEN strCpy(mailOptions.smtpHost,tempstr,255)
    IF readToolType(TOOLTYPE_BBSCONFIG,0,'SMTP_USERNAME',tempstr) THEN strCpy(mailOptions.username,tempstr,255)
    IF readToolType(TOOLTYPE_BBSCONFIG,0,'SMTP_PASSWORD',tempstr) THEN strCpy(mailOptions.password,tempstr,255)
    IF readToolType(TOOLTYPE_BBSCONFIG,0,'SYSOP_EMAIL',tempstr) THEN strCpy(mailOptions.sysopEmail,tempstr,255)
    IF readToolType(TOOLTYPE_BBSCONFIG,0,'BBS_EMAIL',tempstr) THEN strCpy(mailOptions.bbsEmail,tempstr,255)
    IF checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'SMTP_SSL') THEN mailOptions.ssl:=TRUE ELSE mailOptions.ssl:=FALSE
  ENDIF

  IF StrLen(mailOptions.smtpHost)>0 
    IF initssl(mailOptions.ssl)=FALSE
      Raise(ERR_SSL)
    ENDIF
  ENDIF

  timeoutLC:=checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'TIMEOUT_LC');

  consoleDebugLevel:=readToolTypeInt(TOOLTYPE_NODE,node,'CONSOLE_DEBUG')
  IF checkToolTypeExists(TOOLTYPE_NODE,node,'DEBUG_LOG') THEN debugLogLevel:=LOG_WARN ELSE debugLogLevel:=LOG_NONE
  
  confBases:=List(cmds.numConf)
  FOR i:=1 TO cmds.numConf
    cb:=NEW cb
    ListAdd(confBases,[cb])
  ENDFOR

  xprTitle:=List(100)
  xprLib:=List(100)
  i:=1
  REPEAT
    notfound:=FALSE
    StringF(temppath,'TITLE.\d',i)
    IF readToolType(TOOLTYPE_XPRTYPES,'',temppath,tempstr)=FALSE
      notfound:=TRUE
    ENDIF

    StringF(temppath,'LIBRARY.\d',i)
    IF readToolType(TOOLTYPE_XPRTYPES,'',temppath,tempstr2)=FALSE
      notfound:=TRUE
    ENDIF

    IF notfound=FALSE
      msg:=String(80)
      StrCopy(msg,tempstr)
      ListAdd(xprTitle,[msg])

      msg:=String(80)
      StrCopy(msg,tempstr2)
      ListAdd(xprLib,[msg])

    ENDIF
    i++
  UNTIL notfound
  
  screenTypeTitle:=List(100)
  screenTypeExt:=List(100)
  i:=1
  REPEAT
    notfound:=FALSE
    StringF(temppath,'TITLE.\d',i)
    IF readToolType(TOOLTYPE_SCREENTYPES,'',temppath,tempstr)=FALSE
      notfound:=TRUE
    ENDIF

    StringF(temppath,'TYPE.\d',i)
    IF readToolType(TOOLTYPE_SCREENTYPES,'',temppath,tempstr2)=FALSE
      notfound:=TRUE
    ENDIF
    
    IF (StrLen(tempstr)=0) OR (StrLen(tempstr2)=0) THEN notfound:=TRUE

    IF notfound=FALSE
      msg:=String(80)
      StrCopy(msg,tempstr)
      ListAdd(screenTypeTitle,[msg])

      msg:=String(80)
      IF (tempstr2[0]<>".")
        StringF(msg,'.\s',tempstr2)
      ELSE
        StrCopy(msg,tempstr2)
      ENDIF
      ListAdd(screenTypeExt,[msg])

    ENDIF
    i++
  UNTIL notfound

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'OWN_PARTFILES') THEN ownPartFiles:=TRUE

  StrCopy(confDBName,'Conf.DB')
  readToolType(TOOLTYPE_NODE,node,'CONF_DB',confDBName)
 
  IF readToolType(TOOLTYPE_NODE,node,'USERDATA_NAME',temppath)
    StrCopy(userDataFile,temppath)
  ELSE
    StringF(userDataFile,'\suser.data',cmds.bbsLoc)
  ENDIF
  
  IF readToolType(TOOLTYPE_NODE,node,'USERKEYS_NAME',temppath)
    StrCopy(userKeysFile,temppath)
  ELSE
    StringF(userKeysFile,'\suser.keys',cmds.bbsLoc)
  ENDIF

  IF readToolType(TOOLTYPE_NODE,node,'USERMISC_NAME',temppath)
    StrCopy(userMiscFile,temppath)
  ELSE
    StringF(userMiscFile,'\suser.misc',cmds.bbsLoc)
  ENDIF

  confNames:=List(cmds.numConf)
  confDirs:=List(cmds.numConf)
  FOR i:=1 TO cmds.numConf
    msg:=String(255)
    StringF(tempstr,'NAME.\d',i)
    readToolType(TOOLTYPE_CONFCONFIG,'',tempstr,msg)
    ListAdd(confNames,[msg])
    IF i<11
      p:=cmds.conf1Name
      strCpy(p+((i-1)*54),msg,54)
    ENDIF

    msg:=String(255)
    StringF(tempstr,'LOCATION.\d',i)
    readToolType(TOOLTYPE_CONFCONFIG,'',tempstr,msg)
    ListAdd(confDirs,[msg])
    IF i<11
      p:=cmds.conf1Loc
      strCpy(p+((i-1)*54),msg,54)
    ENDIF
  ENDFOR

  computerEntries:=readToolTypeInt(TOOLTYPE_COMPUTERLIST,'','COMPUTER.NUM')

  onlineBaud:=cmds.openingBaud
  onlineBaudR:=cmds.openingBaud

  IF (computerEntries>0)
    computerTypes:=List(computerEntries)
    FOR i:=1 TO computerEntries
      msg:=String(255)
      StringF(temppath,'COMPUTER.\d',i)
      readToolType(TOOLTYPE_COMPUTERLIST,'',temppath,msg)
      ListAdd(computerTypes,[msg])
    ENDFOR
  ENDIF

  sysopAvail:=IF cmds.acLvl[LVL_DEFAULT_CHAT_ON] THEN TRUE ELSE FALSE
  updateTitle(NIL)

  IF(sopt.toggles[TOGGLES_QUIETSTART])
    quietFlag:=TRUE
  ELSE
    quietFlag:=FALSE
  ENDIF

  sendQuietFlag(quietFlag)    

  IF readToolType(TOOLTYPE_CONFCONFIG,'','REGKEY',regKey)=FALSE
    StrCopy(regKey,'NONE')
  ENDIF

  ->readToolType(TOOLTYPE_NODE,node,'SCREENS',temppath)
  StrCopy(nodeScreenDir,sopt.nodeScreens,ALL)  
  
  StringF(nodeWorkDir,'\sNode\d/Work/',cmds.bbsLoc,node)
  
  -> E-Note: E automatically opens the Intuition library

  IF (debug) OR (sopt.iconify=FALSE) THEN openExpressScreen()

  formatLongDateTime(getSystemTime(),tempstr)
  StringF(tempstr2,'####### BBS Node \d started on \s #######\n',node,tempstr)
  startLog(tempstr2)

  displayInitialisingLogo()
 
  state:=STATE_AWAIT
  reqState:=REQ_STATE_NONE
  WHILE state<>STATE_SHUTDOWN
    IF state=STATE_AWAIT THEN processAwait()
    IF state=STATE_SYSOPLOGON THEN processSysopLogon()
    IF (state=STATE_LOGON) THEN processLogon()
    IF state=STATE_LOGGEDON THEN processLoggedOnUser()
    IF state=STATE_LOGGING_OFF THEN processLoggingOff()

    IF reqState<>REQ_STATE_NONE
      IF (state<>STATE_LOGGING_OFF) AND (state<>STATE_AWAIT) THEN state:=STATE_LOGGING_OFF

      IF reqState=REQ_STATE_LOGOFF
        reqState:=REQ_STATE_NONE
      ELSEIF (state=STATE_AWAIT)
        state:=STATE_SHUTDOWN
      ENDIF
    ENDIF

  ENDWHILE

  IF reqState=REQ_STATE_SHUTDOWN_OFFHOOK
    -> go offhook
  ENDIF
  
 EXCEPT DO
  setEnvStat(ENV_SHUTDOWN)

  StringF(tempstr,'####### BBS Node \d shutdown @ \s#######\n',node,shutDownMsg)
  startLog(tempstr)
  IF(StrLen(sopt.shutDown)>0)
    StringF(tempstr,'execute \s \d',sopt.shutDown,node)
    IF(tempfh:=Open('NIL:',MODE_OLDFILE))
      Execute(tempstr,tempfh,tempfh)
      Close(tempfh)
    ENDIF
  ENDIF

  IF(captureFP)
    Close(captureFP)
    captureFP:=NIL
  ENDIF

  FOR i:=0 TO ListLen(scomment)-1
    DisposeLink(ListItem(scomment,i))
  ENDFOR
  END scomment

  FOR i:=0 TO ListLen(parsedParams)-1
    DisposeLink(ListItem(parsedParams,i))
  ENDFOR
  END parsedParams

  FOR i:=0 TO ListLen(computerTypes)-1
    DisposeLink(ListItem(computerTypes,i))
  ENDFOR
  END computerTypes

  FOR i:=0 TO ListLen(historyBuf)-1
    DisposeLink(ListItem(historyBuf,i))
  ENDFOR
  END historyBuf

  FOR i:=0 TO ListLen(msgBuf)-1
    DisposeLink(ListItem(msgBuf,i))
  ENDFOR
  END msgBuf

  FOR i:=0 TO ListLen(confBases)-1
    cb:=ListItem(confBases,i)
    END cb
  ENDFOR
  END confBases

  FOR i:=0 TO ListLen(confNames)-1
    DisposeLink(ListItem(confNames,i))
  ENDFOR
  END confNames

  FOR i:=0 TO ListLen(confDirs)-1
    DisposeLink(ListItem(confDirs,i))
  ENDFOR
  END confDirs

  FOR i:=0 TO ListLen(olmBuf)-1
    DisposeLink(ListItem(olmBuf,i))
  ENDFOR
  END olmBuf

  FOR i:=0 TO ListLen(olmQueue)-1
    DisposeLink(ListItem(olmQueue,i))
  ENDFOR
  END olmQueue

  FOR i:=0 TO ListLen(xprLib)-1
    DisposeLink(ListItem(xprLib,i))
  ENDFOR
  END xprLib

  FOR i:=0 TO ListLen(xprTitle)-1
    DisposeLink(ListItem(xprTitle,i))
  ENDFOR
  END xprTitle

  FOR i:=0 TO ListLen(screenTypeTitle)-1
    DisposeLink(ListItem(screenTypeTitle,i))
  ENDFOR
  END screenTypeTitle

  FOR i:=0 TO ListLen(screenTypeExt)-1
    DisposeLink(ListItem(screenTypeExt,i))
  ENDFOR
  END screenTypeExt

  FreeMem(skipdFiles,32000)
  
  IF (loggedOnUser) THEN END loggedOnUser
  IF (loggedOnUserKeys) THEN END loggedOnUserKeys
  IF (loggedOnUserMisc) THEN END loggedOnUserMisc
  IF (mailStat) THEN END mailStat
  IF (mailHeader) THEN END mailHeader
  
  IF(tempUser) THEN END tempUser
  IF(tempUserKeys) THEN END tempUserKeys
  IF(tempUserMisc) THEN END tempUserMisc

  cleanupssl()
  
  closeExpressScreen()
  IF iconbase THEN CloseLibrary(iconbase)
  IF diskfontbase THEN CloseLibrary(diskfontbase)

  IF broker THEN DeleteCxObj(broker)
  IF broker_mp
    -> Empty the port of CxMsgs
    WHILE msg:=GetMsg(broker_mp) DO ReplyMsg(msg)
    DeleteMsgPort(broker_mp) -> E-Note: C version incorrectly uses DeletePort()
  ENDIF
  IF cxbase THEN CloseLibrary(cxbase)

  IF serverRP THEN deleteServerRP()
  IF resmp THEN deleteResControl()
  IF rexxmp THEN deleteRexxPort()

  closeSerial()

  IF (doorExtSig<>NIL) THEN FreeSignal(doorExtSig)
  doorExtSig:=NIL
  
  -> E-Note: we can print a minimal error message
  SELECT exception
  CASE ERR_SSL
    debugLog(LOG_ERROR,'Error: failed during ssl setup (open AmiSSL library or create ssl context')
  CASE ERR_SCREEN
    debugLog(LOG_ERROR,'Error: Failed to open custom screen')
  CASE ERR_BRKR
    debugLog(LOG_ERROR,'Error: Could not create broker')
  CASE ERR_CXERR
    debugLog(LOG_ERROR,'Error: Could not activate broker')
  CASE ERR_LIB
    debugLog(LOG_ERROR,'Error: Could not open commodities.library')
  CASE ERR_PORT
    debugLog(LOG_ERROR,'Error: Could not create message port')
  ENDSELECT
ENDPROC
