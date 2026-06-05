
OPT MODULE

  MODULE '*/stringlist'

EXPORT OBJECT fChecker
  filename:PTR TO CHAR
  checker:PTR TO CHAR
  error1:PTR TO CHAR
  error2:PTR TO CHAR
  error3:PTR TO CHAR
  error4:PTR TO CHAR
  error5:PTR TO CHAR
  error6:PTR TO CHAR
  error7:PTR TO CHAR
  error8:PTR TO CHAR
  error9:PTR TO CHAR
  error10:PTR TO CHAR
  options:PTR TO CHAR
  priority:PTR TO CHAR
  script:PTR TO CHAR
  stack:PTR TO CHAR
ENDOBJECT

EXPORT PROC create() OF fChecker
  self.filename:=String(255)
  self.checker:=String(255)
  self.error1:=String(255)
  self.error2:=String(255)
  self.error3:=String(255)
  self.error4:=String(255)
  self.error5:=String(255)
  self.error6:=String(255)
  self.error7:=String(255)
  self.error8:=String(255)
  self.error9:=String(255)
  self.error10:=String(255)
  self.options:=String(255)
  self.priority:=String(255)
  self.script:=String(255)
  self.stack:=String(255)
ENDPROC

EXPORT PROC end() OF fChecker
  DisposeLink(self.filename)
  DisposeLink(self.checker)
  DisposeLink(self.error1)
  DisposeLink(self.error2)
  DisposeLink(self.error3)
  DisposeLink(self.error4)
  DisposeLink(self.error5)
  DisposeLink(self.error6)
  DisposeLink(self.error7)
  DisposeLink(self.error8)
  DisposeLink(self.error9)
  DisposeLink(self.error10)
  DisposeLink(self.options)
  DisposeLink(self.priority)
  DisposeLink(self.script)
  DisposeLink(self.stack)
ENDPROC

EXPORT OBJECT protocol
  filename:PTR TO CHAR
  options:PTR TO CHAR
  httpHost:PTR TO CHAR
  httpTemp:PTR TO CHAR
  ftpHost:PTR TO CHAR
  ftpAuth:CHAR
  txWindow:PTR TO CHAR
  rxWindow:PTR TO CHAR
ENDOBJECT

EXPORT PROC create() OF protocol
  self.filename:=String(255)
  self.options:=String(255)
  self.httpHost:=String(255)
  self.httpTemp:=String(255)
  self.ftpHost:=String(255)
  self.ftpAuth:=0
  self.txWindow:=String(255)
  self.rxWindow:=String(255)
ENDPROC

EXPORT PROC end() OF protocol
  DisposeLink(self.filename)
  DisposeLink(self.options)
  DisposeLink(self.httpHost)
  DisposeLink(self.httpTemp)
  DisposeLink(self.ftpHost)
  DisposeLink(self.txWindow)
  DisposeLink(self.rxWindow)
ENDPROC

EXPORT OBJECT command
  filename:PTR TO CHAR
  name:PTR TO CHAR
  location:PTR TO CHAR
  access:PTR TO CHAR
  internal:PTR TO CHAR
  mimicVer:PTR TO CHAR
  password:PTR TO CHAR
  passParams:PTR TO CHAR
  priority:PTR TO CHAR
  resident:CHAR
  quickMode:CHAR
  stack:PTR TO CHAR
  type:PTR TO CHAR
  trapon:CHAR
  expertMode:CHAR
  doorSilent:CHAR
  logInputs:CHAR
  scriptCheck:CHAR
  multiNode:CHAR
  banner:PTR TO CHAR
ENDOBJECT

EXPORT PROC create() OF command
  self.filename:=String(255)
  self.name:=String(255)
  self.location:=String(255)
  self.access:=String(255)
  self.internal:=String(255)
  self.mimicVer:=String(255)
  self.password:=String(255)
  self.passParams:=String(255)
  self.priority:=String(255)
  self.resident:=0
  self.quickMode:=0
  self.stack:=String(255)
  self.type:=String(255)
  self.trapon:=0
  self.expertMode:=0
  self.doorSilent:=0
  self.logInputs:=0
  self.scriptCheck:=0
  self.multiNode:=0
  self.banner:=String(255)
ENDPROC

EXPORT PROC end() OF command
  DisposeLink(self.filename)
  DisposeLink(self.name)
  DisposeLink(self.location)
  DisposeLink(self.access)
  DisposeLink(self.internal)
  DisposeLink(self.mimicVer)
  DisposeLink(self.password)
  DisposeLink(self.passParams)
  DisposeLink(self.priority)
  DisposeLink(self.stack)
  DisposeLink(self.type)
  DisposeLink(self.banner)  
ENDPROC

EXPORT OBJECT msgbase
  name:PTR TO CHAR
  location:PTR TO CHAR
  extSend:CHAR
  username:CHAR
  realname:CHAR
  internetname:CHAR
ENDOBJECT

EXPORT PROC create() OF msgbase
  self.name:=String(255)
  self.location:=String(255)
  self.extSend:=0
  self.username:=0
  self.realname:=0
  self.internetname:=0
ENDPROC

EXPORT PROC end() OF msgbase
  DisposeLink(self.name)
  DisposeLink(self.location)
ENDPROC

EXPORT OBJECT area
  filename:PTR TO CHAR
  confList:PTR TO LONG
ENDOBJECT

EXPORT PROC create() OF area
  self.filename:=String(255)
  self.confList:=0
ENDPROC

EXPORT PROC end() OF area
  DisposeLink(self.filename)
ENDPROC


EXPORT OBJECT accessLevel
  filename:PTR TO CHAR
  accessList:PTR TO stringlist
ENDOBJECT

EXPORT PROC create() OF accessLevel
  DEF newList:PTR TO stringlist
  self.filename:=String(255)
  
  NEW newList.stringlist(200)
  self.accessList:=newList

ENDPROC

EXPORT PROC end() OF accessLevel
  DisposeLink(self.filename)
  END self.accessList
ENDPROC

EXPORT PROC getAccessLevels()
  DEF result:PTR TO LONG
  result:=
     ['ACS.MAX_PAGES','ACS.ACCOUNT_EDITING','ACS.READ_BULLETINS','ACS.COMMENT_TO_SYSOP','ACS.DOWNLOAD','ACS.UPLOAD','ACS.ENTER_MESSAGE','ACS.FILE_LISTINGS','ACS.JOIN_CONFERENCE','ACS.NEW_FILES_SINCE',
     'ACS.PAGE_SYSOP','ACS.READ_MESSAGE','ACS.REMOTE_SHELL','ACS.DISPLAY_USER_STATS','ACS.VIEW_A_FILE','ACS.EDIT_USER_INFO','ACS.EDIT_INTERNET_NAME','ACS.EDIT_USER_LOCATION',
     'ACS.EDIT_PHONE_NUMBER','ACS.EDIT_PASSWORD','ACS.ZIPPY_TEXT_SEARCH','ACS.OVERRIDE_CHAT','ACS.SYSOP_DOWNLOAD','ACS.SYSOP_VIEW','ACS.SYSOP_READ','ACS.KEEP_UPLOAD_CREDIT',
     'ACS.OVERRIDE_TIMES','ACS.CLEAR_SCREEN_MSG','ACS.FREE_RESUMING','ACS.ONE_TIME_BULLETINS','ACS.DO_CALLERSLOG','ACS.SENTBY_FILES','ACS.DO_UD_LOG','ACS.SCREEN_TO_FRONT',
     'ACS.DEFAULT_CHAT_ON','ACS.EALL_MESSAGES','ACS.DUPE_FILECHECK','ACS.MESSAGE_EDIT','ACS.LIST_NODES','ACS.MSG_LEVEL','ACS.MSG_EXPERATION','ACS.DELETE_MESSAGE','ACS.ATTACH_FILES',
     'ACS.CUSTOMCOMMANDS','ACS.JOIN_SUB_CONFERENCE','ACS.ZOOM_MAIL','ACS.MCI_MSG','ACS.EDIT_DIRS','ACS.EDIT_FILES','ACS.BREAK_CHAT','ACS.QUIET_NODE','ACS.SYSOP_COMMANDS','ACS.WHO_IS_ONLINE',
     'ACS.RELOGON','ACS.ULSTATS','ACS.XPR_RECEIVE','ACS.XPR_SEND','ACS.WILDCARDS','ACS.CONFERENCE_ACCOUNTING','ACS.PRI_MSGFILES','ACS.PUB_MSGFILES','ACS.FULL_EDIT','ACS.CONFFLAGS',
     'ACS.OLM','ACS.HIDE_FILES','ACS.SHOW_PAYMENTS','ACS.CREDIT_ACCESS','ACS.VOTE','ACS.MODIFY_VOTE','ACS.FILE_EXPANSION','ACS.EDIT_REAL_NAME','ACS.EDIT_USER_NAME','ACS.CENSORED',
     'ACS.ACCOUNT_VIEW','ACS.TRANSLATION','ACS.UNKNOWN','ACS.CREATE_CONFERENCE','ACS.LOCAL_DOWNLOADS','ACS.OVERRIDE_DEFAULTS','ACS.HOLD_ACCESS','ACS.EDIT_EMAIL',
     'ACS.READ_PRIV_EALL','ACS.READ_PRIV_ALL','ACS.OVERRIDE_TIMELIMIT','ACS.OVERRIDE_CHATLIMIT','ACS.NO_TIMEOUT','ACS.USER_ULSTATS']
ENDPROC result

EXPORT PROC getAccessNames()
  DEF result:PTR TO LONG
  result:=
     ['Max sysop pages','Account editing','Read bulletins','Comment to sysop','Download files','Upload files','Send message','View file listings','Join a conference','View new files',
     'Page sysop','Read messages','Remote shell','Display user stats','View a file','Edit user info','Edit internet name','Edit location',
     'Edit phone number','Edit password','Text search (zippy)','Override chat','Sysop download','Sysop view','Sysop read','Upload credit (unused)',
     'Override times','Clear screen (unused)','Free resuming (unused)','One time bulletins (unused)','Enable callerslog (unused)','Add sentby line (unused)','Enable UD log (unused)','Bring screen to front (unused)',
     'Default chat on (unused)','Send EALL messages','dupe filecheck (unused)','Edit messages','View callerslogs','Message Level (unused)','Message expiration (unused)','Delete Messages','Attach files to messages',
     'Custom commands (unused)','Join sub conf (unused)','Zoom mail','Enable MCI messages','Edit Dirs','Edit Files','Break from chat','Allow quiet mode','Sysop commands','See node users (WHO)',
     'Relogon','Show sysop UL stats','External protocol upload','External protocol download','Wildcards (unused)','Enable conference accounting','Private messages','Public messages','Change screen editor','Edit conf flags',
     'Online messages','Hide filenames in WHO','Show Payments','Credit Account Access','Voting','Edit Votes','Enable file expansion','Edit real name','Edit user name','User censored',
     'Account view (unused)','Enable translation','Unknown (unused)','Create conference (unused)','Local downloads','Override defaults','Allow hold access','Edit emails',
     'Read private EALL msgs','Read private ALL msgs','Override time limits','Override chat limits','Don''t time out','Show user upload stats']
ENDPROC result