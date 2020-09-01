-> EXPORT EXPORT ENUMs for express

  OPT MODULE

EXPORT ENUM STATE_AWAIT, STATE_CONNECTING, STATE_SYSOPLOGON, STATE_LOGON, STATE_LOGGEDON, STATE_HANGUP, STATE_LOGGING_OFF, STATE_SHUTDOWN, STATE_CHECK,STATE_SUSPEND

EXPORT ENUM REQ_STATE_NONE, REQ_STATE_LOGOFF, REQ_STATE_SHUTDOWN, REQ_STATE_SHUTDOWN_OFFHOOK, REQ_STATE_SYSOPLOGON, REQ_STATE_LOGON, REQ_STATE_RESUME

EXPORT ENUM SUBSTATE_DISPLAY_AWAIT, SUBSTATE_INPUT, SUBSTATE_DISPLAY_BULL, SUBSTATE_DISPLAY_CONF_BULL, SUBSTATE_DISPLAY_MENU, SUBSTATE_READ_COMMAND,  SUBSTATE_PROCESS_COMMAND

EXPORT ENUM CMDTYPE_BBSCMD,CMDTYPE_SYSCMD,CMDTYPE_CUSTOM

EXPORT ENUM TOOLTYPE_PRESET, TOOLTYPE_NODE,TOOLTYPE_CONFCONFIG,TOOLTYPE_CONF,TOOLTYPE_BBSCMD,TOOLTYPE_CONFCMD,TOOLTYPE_NODECMD,TOOLTYPE_SYSCMD,TOOLTYPE_DRIVES,TOOLTYPE_NAMESNOTALLOWED,TOOLTYPE_COMPUTERLIST,TOOLTYPE_ACCESS,TOOLTYPE_AREA,TOOLTYPE_FCHECK,TOOLTYPE_NODE_WINDOW,TOOLTYPE_NODE_TIMES,TOOLTYPE_WINDOW,TOOLTYPE_CONNECT,TOOLTYPE_XPRTYPES,TOOLTYPE_XFERLIB,TOOLTYPE_SCREENTYPES,TOOLTYPE_NRAMS, TOOLTYPE_BBSCONFIG,TOOLTYPE_ASCPACK,TOOLTYPE_QWKPACK,TOOLTYPE_QWKCONFIG,TOOLTYPE_DEFAULT_ACCESS,TOOLTYPE_LANGUAGES,TOOLTYPE_USER_ACCESS, TOOLTYPE_NODE_PRESET,TOOLTYPE_CONFCMD2,TOOLTYPE_CONFSYSCMD,TOOLTYPE_NODESYSCMD, TOOLTYPE_MSGBASE

EXPORT ENUM DOORTYPE_XIM, DOORTYPE_AIM, DOORTYPE_SIM, DOORTYPE_TIM, DOORTYPE_IIM, DOORTYPE_MCI, DOORTYPE_AEM, DOORTYPE_SUP

EXPORT ENUM LOG_NONE=0, LOG_ERROR=1, LOG_WARN=2, LOG_DEBUG=3

EXPORT ENUM SCREEN_AWAIT, SCREEN_BBSTITLE, SCREEN_LOGON, SCREEN_JOIN, SCREEN_JOINCONF, SCREEN_JOINMSGBASE, SCREEN_JOINED, SCREEN_BULL, SCREEN_NODE_BULL, SCREEN_CONF_BULL, SCREEN_MENU, SCREEN_LOGOFF, SCREEN_DOWNLOAD, SCREEN_UPLOAD, SCREEN_NEWUSERPW, SCREEN_NONEWUSERS, SCREEN_NONEWATBAUD, SCREEN_GUESTLOGON, SCREEN_NOCALLERSATBAUD, SCREEN_LOCKOUT0, SCREEN_LOCKOUT1, SCREEN_PRIVATE, SCREEN_ONENODE, SCREEN_LOGON24, SCREEN_NOT_TIME, SCREEN_FILEHELP,SCREEN_LANGUAGES,SCREEN_REALNAMES,SCREEN_INTERNETNAMES, SCREEN_MAILSCAN

EXPORT ENUM LOGON_TYPE_LOGGED_OFF=0, LOGON_TYPE_SYSOP=1, LOGON_TYPE_LOCAL=2, LOGON_TYPE_REMOTE=3

EXPORT ENUM RESULT_FAILURE=-1, RESULT_SUCCESS=0, RESULT_NOT_ALLOWED=1, RESULT_ABORT=-2, RESULT_TIMEOUT=-3, RESULT_NO_CARRIER=-4, RESULT_GOODBYE=-5, RESULT_SLEEP_LOGOFF=-6, RESULT_STANDARD_LOGOFF=-7, RESULT_CONNECT=-8, RESULT_NOT_TESTED=2, RESULT_LCFILES=9,RESULT_PRIVATE=10, RESULT_SIGNALLED=11, RESULT_NOT_FOUND=12

EXPORT ENUM ERR_MEMORY,ERR_MEMORY2,ERR_MSGBASE,ERR_MEMORY3,ERR_FILELIST,ERR_NOFILES,ERR_FILEEXAMINE,ERR_WORKDIROPEN,ERR_LOCK,ERR_FREESPACE,ERR_SYMBOLS,ERR_FIB_MEMORY,ERR_NO_BULLS,ERR_NO_CONFFLAGS

EXPORT ENUM MAIL_READ=1,MAIL_CREATE=2, MAIL_SCAN=3

EXPORT ENUM CONSOLE_PORT=1, SERIAL_PORT=2

EXPORT ENUM ZMODEM_NONE, ZMODEM_UPLOAD, ZMODEM_DOWNLOAD

EXPORT ENUM NAME_TYPE_USERNAME, NAME_TYPE_REALNAME, NAME_TYPE_INTERNETNAME
EXPORT ENUM UPDATE_RATIO,UPDATE_RATIO_TYPE,UPDATE_MAILSCAN_PTRS,UPDATE_NEW_MAIL_SCAN,UPDATE_NEW_FILE_SCAN,UPDATE_DEFAULT_ZOOM_FLAG,UPDATE_LAST_MESSAGE,UPDATE_MESSAGES_POSTED, UPDATE_RESET_VOTING

EXPORT ENUM CACHE_RESET_NEVER, CACHE_RESET_LOGON

EXPORT ENUM TRANS_NONE,TRANS_HOST_TO_DEFINED,TRANS_DEFINED_TO_HOST

EXPORT ENUM FORCE_MAILSCAN_NOFORCE, FORCE_MAILSCAN_ALL, FORCE_MAILSCAN_SKIP


-> User Keys Flags
   /* show new user message */       /* show all users only once */
EXPORT ENUM USER_NEWMSG=1,USER_TOCONF1=2, USER_ONETIME_MSG=4,USER_SCRNCLR=8,USER_DONATED=16,USER_ED_FULLSCREEN=32,USER_ED_PROMPT=64,USER_BGFILECHECK=128
