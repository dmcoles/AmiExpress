OPT MODULE
OPT LARGE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui','dos/dos','dos/dostags','dos/dosextens'
MODULE 'tools/boopsi','workbench/workbench','icon','intuition/classusr'
MODULE 'utility/tagitem','utility/hooks','exec/lists','tools/installhook'
MODULE '*axedit','*frmBase','*tooltypes','*controls','*miscfuncs','*helpText'

OBJECT timeItem
  baudStr:PTR TO CHAR
  startControl:PTR TO LONG
  endControl:PTR TO LONG
ENDOBJECT

EXPORT OBJECT frmNodeEdit OF frmBase
  controlList1       : LONG
  controlList2       : LONG
  controlList3       : LONG
  controlList4       : LONG
  
  grpNodePages       : PTR TO LONG

  strNodeNumber      : PTR TO LONG
  btnFirstNode        : PTR TO LONG
  btnLastNode        : PTR TO LONG
  btnPrevNode        : PTR TO LONG
  btnNextNode        : PTR TO LONG
  btnAddNode         : PTR TO LONG
  btnCloneNode       : PTR TO LONG
  btnRemoveNode      : PTR TO LONG
  btnNodeSave        : PTR TO LONG
  btnNodeCancel      : PTR TO LONG
  grpNodeSettings    : PTR TO LONG
  grpNodeSettings2   : PTR TO LONG
  grpNodeSettings3   : PTR TO LONG
  grpNodeSettings4   : PTR TO LONG

  intPriority        : PTR TO control
  strNodeStart       : PTR TO control
  strSystemPassword  : PTR TO control
  strSystemPasswordPrompt: PTR TO control
  strNewuserPassword : PTR TO control
  strNamePrompt      : PTR TO control
  strNamePrompt2     : PTR TO control
  strPasswordPrompt  : PTR TO control
  paScreens          : PTR TO control
  intAutoValPreset   : PTR TO control
  intAutoValDelay    : PTR TO control
  strAutoValPassword : PTR TO control
  strFtpPort         : PTR TO control
  strFtpDataPort     : PTR TO control
  strHttpPort        : PTR TO control
  intKeepUlCredit    : PTR TO control
  intMaxMsgQueue     : PTR TO control
  paPlaypen          : PTR TO control
  intRingCount       : PTR TO control
  strRemotePassword  : PTR TO control
  intSysopChatColour : PTR TO control
  intUserChatColour  : PTR TO control
  fnUserDataName     : PTR TO control
  fnUserMiscName     : PTR TO control
  fnUserKeysName     : PTR TO control
  paLocalUlPath      : PTR TO control
  intOverrideTimeout : PTR TO control
  //needs to be a cycle
  strForceAnsi       : PTR TO control
  intBGFilecheckStack: PTR TO control
  strConInputDev     : PTR TO control
  strConOutputDev    : PTR TO control
  strScreenPens      : PTR TO control
  strConfDb          : PTR TO control
  fnFilesNotAllowed  : PTR TO control
  strFirstCommand    : PTR TO control
  intSerialCacheSize : PTR TO control
  boolCallersLog     : PTR TO control
  boolCapitalFilenames: PTR TO control
  boolDefScreens     : PTR TO control
  boolDebugLog       : PTR TO control
  boolDoorLog        : PTR TO control
  boolStartLog       : PTR TO control
  boolUDLog          : PTR TO control
  boolChatOn         : PTR TO control
  boolDisableQuickLogon: PTR TO control
  boolIdleNode       : PTR TO control
  boolMailscanPrompt : PTR TO control
  boolNoTimeout      : PTR TO control
  boolQuietNode      : PTR TO control
  boolStealthNode    : PTR TO control
  boolShowPwFail     : PTR TO control
  boolSentByFiles    : PTR TO control
  boolTelnet         : PTR TO control
  boolFtp            : PTR TO control
  boolTelnetD        : PTR TO control
  boolTelserD        : PTR TO control
  boolUserNumLogin   : PTR TO control
  boolViewPassword   : PTR TO control
  boolLogHost        : PTR TO control
  boolLogInputs      : PTR TO control
  boolNoCx           : PTR TO control
  boolCentralAnswers : PTR TO control
  boolDisableIemsi   : PTR TO control
  boolNoMciMsg       : PTR TO control
  boolNoWildcard     : PTR TO control
  boolOwnPartFiles   : PTR TO control
  boolPhoneCheck     : PTR TO control
  boolRamWork        : PTR TO control
  boolConsoleDebug   : PTR TO control
  boolNoEmails       : PTR TO control
  boolOwnDevunit     : PTR TO control
  boolShowCacheStats : PTR TO control
  boolTrapDoor       : PTR TO control
  boolTrapSerial     : PTR TO control
  boolNoRadBoogie    : PTR TO control

  //serial device settings
  strSerialDevice    : PTR TO control
  intSerialUnit      : PTR TO control
  intSerialBaud      : PTR TO control
  boolA2232Patch     : PTR TO control
  boolNoPurgeLine    : PTR TO control
  boolRepurge        : PTR TO control
  boolLogoffReset    : PTR TO control
  boolTrueReset      : PTR TO control
  
  //modem settings
  strModemInit       : PTR TO control
  strModemReset      : PTR TO control
  strModemRing       : PTR TO control
  strModemAnswer     : PTR TO control
  strModemOffhook    : PTR TO control

  strNRAMS1          : PTR TO control
  strNRAMS2          : PTR TO control
  strNRAMS3          : PTR TO control
  strNRAMS4          : PTR TO control


  //window settings
  intNumColours      : PTR TO control
  intWinLeftEdge     : PTR TO control
  intWinTopEdge      : PTR TO control
  intWinWidth        : PTR TO control
  intWinHeight        : PTR TO control
  strWinPubScreen    : PTR TO control
  boolWinIconified   : PTR TO control
  boolWinInterlace   : PTR TO control
  boolWinStatusBar   : PTR TO control
  boolWinToFront     : PTR TO control
  strDisplayId       : PTR TO control

  btnFirstNodeClick: hook
  btnLastNodeClick: hook
  btnNextNodeClick: hook
  btnPrevNodeClick: hook
  btnAddNodeClick: hook
  btnCloneNodeClick: hook
  btnRemoveNodeClick: hook
  setChangedHook:hook

  //evo bug here
  //timesList:PTR TO PTR TO timeItem
  //do this instead
  timesList:PTR TO LONG

  acpName:PTR TO CHAR
  changed:INT
  nodeCount:INT  
  currNode:INT
  newNode:INT
ENDOBJECT

PROC create(app:PTR TO app_obj) OF frmNodeEdit
  DEF group
  SUPER self.create(app)
  self.winMain:=app.wi_nodeEdit

  self.strNodeNumber:=app.str_Node_Number
  self.btnFirstNode:=app.btnFirstNode
  self.btnLastNode:=app.btnLastNode
  self.btnPrevNode:=app.btnPrevNode
  self.btnNextNode:=app.btnNextNode
  self.btnAddNode:=app.btnAddNode
  self.btnCloneNode:=app.btnNodeClone
  self.btnRemoveNode:=app.btnRemoveNode
  self.btnNodeSave:=app.btnNodeSave
  self.btnNodeCancel:=app.btnNodeCancel

  set(self.winMain,MUIA_Window_Width,MUIV_Window_Width_Screen(75))

  self.grpNodePages:=app.gr_node_pages

  get(app.gr_node_settings,MUIA_Scrollgroup_Contents,{group})
  self.grpNodeSettings:=group
  set(self.grpNodeSettings, MUIA_Group_Columns , 4)

  get(app.gr_node_more_settings,MUIA_Scrollgroup_Contents,{group})
  self.grpNodeSettings2:=group
  set(self.grpNodeSettings2, MUIA_Group_Columns , 4)

  get(app.gr_node_serial_settings,MUIA_Scrollgroup_Contents,{group})
  self.grpNodeSettings3:=group
  set(self.grpNodeSettings3, MUIA_Group_Columns , 4)

  get(app.gr_node_window_settings,MUIA_Scrollgroup_Contents,{group})
  self.grpNodeSettings4:=group
  set(self.grpNodeSettings4, MUIA_Group_Columns , 4)

ENDPROC

PROC cloneNewNode() OF frmNodeEdit
  DEF tempStr[255]:STRING
  MOVE.L (A1),self
  GetA4()

  IF self.loadNode(self.currNode)
    self.changed:=TRUE
    self.newNode:=TRUE
    self.nodeCount:=self.nodeCount+1
    self.currNode:=self.nodeCount-1

    StringF(tempStr,'\d',self.currNode)
    set(self.strNodeNumber, MUIA_String_Contents,tempStr)

    set( self.btnPrevNode, MUIA_Disabled , FALSE)
    set( self.btnNextNode, MUIA_Disabled , MUI_TRUE)
    set( self.btnRemoveNode, MUIA_Disabled , FALSE)

    set( self.btnNodeSave,MUIA_Disabled,FALSE)
    set( self.btnAddNode,MUIA_Disabled,MUI_TRUE)
    set( self.btnCloneNode,MUIA_Disabled,MUI_TRUE)
  ENDIF
ENDPROC

PROC createNewNode() OF frmNodeEdit
  MOVE.L (A1),self
  GetA4()

  IF self.loadNode(self.nodeCount)
    self.changed:=TRUE
    self.newNode:=TRUE
    self.nodeCount:=self.nodeCount+1
    set( self.btnNodeSave,MUIA_Disabled,FALSE)
    set( self.btnAddNode,MUIA_Disabled,MUI_TRUE)
    set( self.btnCloneNode,MUIA_Disabled,MUI_TRUE)
  ENDIF
ENDPROC

PROC deleteNodeFolder(node) OF frmNodeEdit
  DEF deleteStr[255]:STRING
  DEF bbsPath[255]:STRING
  readToolType(self.acpName,'BBS_LOCATION',bbsPath)

  StringF(deleteStr,'DELETE \sNode\d ALL',bbsPath,node)
  Execute(deleteStr,0,0)

  StringF(deleteStr,'DELETE \sNode\d.info',bbsPath,node)
  Execute(deleteStr,0,0)
ENDPROC

PROC deleteCurrentNode() OF frmNodeEdit
  DEF deleteOption
  DEF nodeStr[255]:STRING
  MOVE.L (A1),self
  GetA4()

  get (self.app.mnlabel1Donotremovefolder2, MUIA_Menuitem_Checked, {deleteOption})
  IF deleteOption
    deleteOption:=1
  ELSE
    get (self.app.mnlabel1Removefolder2, MUIA_Menuitem_Checked, {deleteOption})
    IF deleteOption
      deleteOption:=2
    ELSE
      deleteOption:=3
    ENDIF
  ENDIF

  IF self.deleteNodeWarning()=FALSE THEN RETURN

  IF self.loadNode(self.nodeCount-2)
    self.nodeCount:=self.currNode+1

    //update node count
    StringF(nodeStr,'\d',self.nodeCount)
    writeToolType(self.acpName,'NODES',nodeStr)

    StringF(nodeStr,'NODE\d_NAME',self.nodeCount)
    deleteToolType(self.acpName,nodeStr)
    StringF(nodeStr,'NODE\d_SYSOP',self.nodeCount)
    deleteToolType(self.acpName,nodeStr)
    StringF(nodeStr,'NODE\d_LOCATION',self.nodeCount)
    deleteToolType(self.acpName,nodeStr)

    set( self.btnNextNode, MUIA_Disabled , MUI_TRUE)
    set( self.btnRemoveNode, MUIA_Disabled , (self.currNode<self.nodeCount) OR (self.currNode=0))
    IF deleteOption=3
      IF self.deleteNodeFolderRequest() THEN deleteOption:=2
    ENDIF
    
    IF deleteOption=2 THEN self.deleteNodeFolder(self.currNode+1)
  ENDIF
ENDPROC

PROC setChangedFlag() OF frmNodeEdit
  MOVE.L (A1),self
  GetA4()
  IF (self.changed=FALSE)
    self.changed:=TRUE
    set( self.btnNodeSave,MUIA_Disabled,FALSE)
  ENDIF
ENDPROC

PROC addNotifications() OF frmNodeEdit
  domethod( self.btnNodeCancel , [
    MUIM_Notify , MUIA_Pressed , FALSE ,
    self.app.app,
    2 ,
    MUIM_Application_ReturnID ,  MUIA_Window_CloseRequest ] )

  domethod( self.btnNodeSave , [
    MUIM_Notify , MUIA_Pressed , FALSE ,
    self.app.app,
    2 ,
    MUIM_Application_ReturnID ,  ID_SAVE ] )
    
  self.setupButtonClick(self.btnFirstNode,self.btnFirstNodeClick,{firstNode})
  self.setupButtonClick(self.btnLastNode,self.btnLastNodeClick,{lastNode})
  self.setupButtonClick(self.btnNextNode,self.btnNextNodeClick,{nextNode})
  self.setupButtonClick(self.btnPrevNode,self.btnPrevNodeClick,{prevNode})
  self.setupButtonClick(self.btnAddNode,self.btnAddNodeClick,{createNewNode})
  self.setupButtonClick(self.btnCloneNode,self.btnCloneNodeClick,{cloneNewNode})
  self.setupButtonClick(self.btnRemoveNode,self.btnRemoveNodeClick,{deleteCurrentNode})
ENDPROC

PROC removeNotifications() OF frmNodeEdit
  domethod(self.btnNodeCancel,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnNodeSave,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnFirstNode,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnLastNode,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnNextNode,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnPrevNode,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnAddNode,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnCloneNode,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnRemoveNode,[MUIM_KillNotify,MUIA_Pressed])
ENDPROC

PROC addControls() OF frmNodeEdit
  DEF control: PTR TO control

  NEW control.createStringInt('Node Priority',NODE_PRIORITY,self.app.app,self.setChangedHook,self)
  self.intPriority:=control
  NEW control.createString('bExpress file',NODE_EXPRESS_FILE,self.app.app,self.setChangedHook,self)
  self.strNodeStart:=control
  NEW control.createString('System Password',NODE_SYSTEM_PASSWORD,self.app.app,self.setChangedHook,self)
  self.strSystemPassword:=control
  NEW control.createString('System Password Prompt',NODE_SYSTEM_PASSWORD_PROMPT,self.app.app,self.setChangedHook,self)
  self.strSystemPasswordPrompt:=control
  NEW control.createString('New User Password',NODE_NEW_USER_PASSWORD,self.app.app,self.setChangedHook,self) 
  self.strNewuserPassword:=control
  NEW control.createString('Name Prompt',NODE_NAME_PROMPT,self.app.app,self.setChangedHook,self) 
  self.strNamePrompt:=control
  NEW control.createString('Name Prompt2',NODE_NAME_PROMPT2,self.app.app,self.setChangedHook,self) 
  self.strNamePrompt2:=control
  NEW control.createString('Password Prompt',NODE_PASSWORD_PROMPT,self.app.app,self.setChangedHook,self) 
  self.strPasswordPrompt:=control
  NEW control.createDirSelect('Screens Path',NODE_SCREENS_PATH,self.app.app,self.setChangedHook,self) 
  self.paScreens:=control
  NEW control.createStringInt('Auto Validate Preset',NODE_AUTO_VAL_PRESET,self.app.app,self.setChangedHook,self) 
  self.intAutoValPreset:=control
  NEW control.createStringInt('Auto Validate Delay',NODE_AUTO_VAL_DELAY,self.app.app,self.setChangedHook,self) 
  self.intAutoValDelay:=control
  NEW control.createString('Auto Validate Password',NODE_AUTO_VAL_PASSWORD,self.app.app,self.setChangedHook,self) 
  self.strAutoValPassword:=control
  NEW control.createString('FTP Port(s)',NODE_FTP_PORT,self.app.app,self.setChangedHook,self) 
  self.strFtpPort:=control
  NEW control.createString('FTP Data Port(s)',NODE_FTP_DATA_PORT,self.app.app,self.setChangedHook,self) 
  self.strFtpDataPort:=control
  NEW control.createString('HTTP Port(s)',NODE_HTTP_PORT,self.app.app,self.setChangedHook,self) 
  self.strHttpPort:=control
  NEW control.createCycle('UL Credit',NODE_KEEP_UL_CREDIT,['Default','Grant additional time',0],self.app.app,self.setChangedHook,self) 
  self.intKeepUlCredit:=control
  NEW control.createStringInt('Max Message Queue',NODE_MAX_MSG_QUEUE,self.app.app,self.setChangedHook,self) 
  self.intMaxMsgQueue:=control
  NEW control.createDirSelect('Playpen Path',NODE_PLAYPEN_PATH,self.app.app,self.setChangedHook,self) 
  self.paPlaypen:=control
  NEW control.createStringInt('Ring Count',NODE_RING_COUNT,self.app.app,self.setChangedHook,self) 
  self.intRingCount:=control
  NEW control.createString('Remote Password',NODE_REMOTE_PASSWORD,self.app.app,self.setChangedHook,self) 
  self.strRemotePassword:=control
  NEW control.createStringInt('Sysop Chat Colour',NODE_SYSOP_CHAT_COLOUR,self.app.app,self.setChangedHook,self) 
  self.intSysopChatColour:=control
  NEW control.createStringInt('User Chat Colour',NODE_USER_CHAT_COLOUR,self.app.app,self.setChangedHook,self) 
  self.intUserChatColour:=control
  NEW control.createFileSelect('User Data File',NODE_USER_DATA_FILE,self.app.app,self.setChangedHook,self) 
  self.fnUserDataName:=control
  NEW control.createFileSelect('User Misc file',NODE_USER_MISC_FILE,self.app.app,self.setChangedHook,self) 
  self.fnUserMiscName:=control
  NEW control.createFileSelect('User Keys File',NODE_USER_KEYS_FILE,self.app.app,self.setChangedHook,self) 
  self.fnUserKeysName:=control
  NEW control.createDirSelect('Local Upload Path',NODE_LOCAL_UPLOAD_PATH,self.app.app,self.setChangedHook,self) 
  self.paLocalUlPath:=control
  NEW control.createStringInt('Timeout override',NODE_OVERRIDE_TIMEOUT,self.app.app,self.setChangedHook,self) 
  self.intOverrideTimeout:=control
  NEW control.createString('Force Ansi',NODE_FORCE_ANSI,self.app.app,self.setChangedHook,self) 
  self.strForceAnsi:=control
  NEW control.createStringInt('BG Checker Stack',NODE_BG_FILECHECK_STACK,self.app.app,self.setChangedHook,self) 
  self.intBGFilecheckStack:=control
  NEW control.createString('Console Input Device',NODE_CON_IN_DEVICE,self.app.app,self.setChangedHook,self) 
  self.strConInputDev:=control
  NEW control.createString('Console Output Device',NODE_CON_OUT_DEVICE,self.app.app,self.setChangedHook,self) 
  self.strConOutputDev:=control
  NEW control.createString('Screen Pens',NODE_SCREEN_PENS,self.app.app,self.setChangedHook,self) 
  self.strScreenPens:=control
  NEW control.createString('Conf DB',NODE_CONF_DB_FILE,self.app.app,self.setChangedHook,self) 
  self.strConfDb:=control
  NEW control.createFileSelect('Files Not Allowed',NODE_NOT_ALLOWED_FILE,self.app.app,self.setChangedHook,self) 
  self.fnFilesNotAllowed:=control
  NEW control.createString('First Command',NODE_FIRST_COMMAND,self.app.app,self.setChangedHook,self) 
  self.strFirstCommand:=control
  NEW control.createStringInt('Serial Cache Size',NODE_SERIAL_CACHE_SIZE,self.app.app,self.setChangedHook,self) 
  self.intSerialCacheSize:=control
  
  NEW control.createCheckBox('Callers Log',NODE_CALLERSLOG,self.app.app,self.setChangedHook,self)
  self.boolCallersLog:=control

  NEW control.createCheckBox('Capitalise Filenames',NODE_CAPS_FILENAMES,self.app.app,self.setChangedHook,self)
  self.boolCapitalFilenames:=control
  
  NEW control.createCheckBox('Def Screens',NODE_DEF_SCREENS,self.app.app,self.setChangedHook,self)
  self.boolDefScreens:=control
  
  NEW control.createCheckBox('Debug Logs',NODE_DEBUG_LOGS,self.app.app,self.setChangedHook,self)
  self.boolDebugLog:=control

  NEW control.createCheckBox('Door Logs',NODE_DOOR_LOGS,self.app.app,self.setChangedHook,self)
  self.boolDoorLog:=control
  NEW control.createCheckBox('Startup Logs',NODE_STARTUP_LOGS,self.app.app,self.setChangedHook,self)
  self.boolStartLog:=control
  NEW control.createCheckBox('UL/DL Logs',NODE_UD_LOGS,self.app.app,self.setChangedHook,self)
  self.boolUDLog:=control
  NEW control.createCheckBox('Chat on',NO_CHAT_ON,self.app.app,self.setChangedHook,self)
  self.boolChatOn:=control
  NEW control.createCheckBox('No Quick Logons',NODE_NO_QUICK_LOGON,self.app.app,self.setChangedHook,self)
  self.boolDisableQuickLogon:=control
  NEW control.createCheckBox('Node Idle',NODE_IDLE,self.app.app,self.setChangedHook,self)
  self.boolIdleNode:=control
  NEW control.createCheckBox('Prompt For Mailscan',NODE_MSCAN_PROMPT,self.app.app,self.setChangedHook,self)
  self.boolMailscanPrompt:=control
  NEW control.createCheckBox('Disable Timeout',NODE_NO_TIMEOUT,self.app.app,self.setChangedHook,self)
  self.boolNoTimeout:=control
  NEW control.createCheckBox('Quiet',NODE_QUIET,self.app.app,self.setChangedHook,self)
  self.boolQuietNode:=control
  NEW control.createCheckBox('Stealth',NODE_STEALTH,self.app.app,self.setChangedHook,self)
  self.boolStealthNode:=control
  NEW control.createCheckBox('Show Password Fails',NODE_SHOW_PWFAILS,self.app.app,self.setChangedHook,self)
  self.boolShowPwFail:=control
  NEW control.createCheckBox('Sentby Files',NODE_SENTBY_FILES,self.app.app,self.setChangedHook,self)
  self.boolSentByFiles:=control
  NEW control.createCheckBox('Enable Native Telnet',NODE_TELNET,self.app.app,self.setChangedHook,self)
  self.boolTelnet:=control
  NEW control.createCheckBox('Enable Ftp',NODE_FTP,self.app.app,self.setChangedHook,self)
  self.boolFtp:=control
  NEW control.createCheckBox('Enable TelnetD',NODE_TELNETD,self.app.app,self.setChangedHook,self)
  self.boolTelnetD:=control
  NEW control.createCheckBox('Enable TelserD',NODE_TELSERD,self.app.app,self.setChangedHook,self)
  self.boolTelserD:=control
  NEW control.createCheckBox('Usernumber Logon',NODE_USERNUM_LOGON,self.app.app,self.setChangedHook,self)
  self.boolUserNumLogin:=control
  NEW control.createCheckBox('View Passwords',NODE_VIEW_PWDS,self.app.app,self.setChangedHook,self)
  self.boolViewPassword:=control
  NEW control.createCheckBox('Log IP/Hostnames',NODE_LOG_IP,self.app.app,self.setChangedHook,self)
  self.boolLogHost:=control
  NEW control.createCheckBox('Log Inputs',NODE_LOG_INPUTS,self.app.app,self.setChangedHook,self)
  self.boolLogInputs:=control
  NEW control.createCheckBox('No node commodity',NODE_DISABLE_COMMODITY,self.app.app,self.setChangedHook,self)
  self.boolNoCx:=control
  NEW control.createCheckBox('Central Answers',NODE_CENTRAL_ANSWERS,self.app.app,self.setChangedHook,self)
  self.boolCentralAnswers:=control
  NEW control.createCheckBox('Disable IEMSI',NODE_DISABLE_IEMSI,self.app.app,self.setChangedHook,self)
  self.boolDisableIemsi:=control
  NEW control.createCheckBox('No MCI Messages',NODE_NO_MCI_MSG,self.app.app,self.setChangedHook,self)
  self.boolNoMciMsg:=control
  NEW control.createCheckBox('No wildcards',NODE_NO_WILDCARDS,self.app.app,self.setChangedHook,self)
  self.boolNoWildcard:=control
  NEW control.createCheckBox('Own partuploads',NODE_OWN_PARTUPLOADS,self.app.app,self.setChangedHook,self)
  self.boolOwnPartFiles:=control
  NEW control.createCheckBox('Phone Check',NODE_PHONE_CHECK,self.app.app,self.setChangedHook,self)
  self.boolPhoneCheck:=control
  NEW control.createCheckBox('RAM Work',NODE_RAM_WORK,self.app.app,self.setChangedHook,self)
  self.boolRamWork:=control
  NEW control.createCheckBox('Console Debug',NODE_CONSOLE_DEBUG,self.app.app,self.setChangedHook,self)
  self.boolConsoleDebug:=control
  NEW control.createCheckBox('No Emails',NODE_NO_EMAILS,self.app.app,self.setChangedHook,self)
  self.boolNoEmails:=control
  NEW control.createCheckBox('OwnDevUnit',NODE_OWNDEVUNIT,self.app.app,self.setChangedHook,self)
  self.boolOwnDevunit:=control
  NEW control.createCheckBox('Show Cache Stats',NODE_SHOW_CACHE_STATS,self.app.app,self.setChangedHook,self)
  self.boolShowCacheStats:=control
  NEW control.createCheckBox('Trapdoor',NODE_TRAPDOOR,self.app.app,self.setChangedHook,self)
  self.boolTrapDoor:=control
  NEW control.createCheckBox('Trap Serial',NODE_TRAP_SERIAL,self.app.app,self.setChangedHook,self)
  self.boolTrapSerial:=control
  NEW control.createCheckBox('No Rad Boogie',NODE_NORADBOOGIE,self.app.app,self.setChangedHook,self)
  self.boolNoRadBoogie:=control

  //serial device settings
  NEW control.createString('Serial Device',NODE_SERIAL_DEVICE,self.app.app,self.setChangedHook,self) 
  self.strSerialDevice:=control
  NEW control.createStringInt('Serial Device Unit',NODE_SERIAL_DEV_UNIT,self.app.app,self.setChangedHook,self) 
  self.intSerialUnit:=control
  NEW control.createStringInt('Serial Baud',NODE_SERIAL_BAUD,self.app.app,self.setChangedHook,self) 
  self.intSerialBaud:=control
  NEW control.createCheckBox('2232Patch',NODE_A2232PATCH,self.app.app,self.setChangedHook,self)
  self.boolA2232Patch:=control
  NEW control.createCheckBox('No Purge Line',NODE_NO_PURGE_LINE,self.app.app,self.setChangedHook,self)
  self.boolNoPurgeLine:=control
  NEW control.createCheckBox('Repurge',NODE_REPURGE,self.app.app,self.setChangedHook,self)
  self.boolRepurge:=control
  NEW control.createCheckBox('Logoff Reset',NODE_LOGOFF_RESET,self.app.app,self.setChangedHook,self)
  self.boolLogoffReset:=control
  NEW control.createCheckBox('True Reset',NODE_TRUE_RESET,self.app.app,self.setChangedHook,self)
  self.boolTrueReset:=control
  
  //modem settings
  NEW control.createString('Modem Init String',NODE_MODEM_INIT,self.app.app,self.setChangedHook,self) 
  self.strModemInit:=control
  NEW control.createString('Modem Reset String',NODE_MODEM_RESET,self.app.app,self.setChangedHook,self) 
  self.strModemReset:=control
  NEW control.createString('Modem Ring String',NODE_MODEM_RING,self.app.app,self.setChangedHook,self) 
  self.strModemRing:=control
  NEW control.createString('Modem Answer String',NODE_MODEM_ANSWER,self.app.app,self.setChangedHook,self) 
  self.strModemAnswer:=control
  NEW control.createString('Modem Offhook String',NODE_MODEM_OFFHOOK,self.app.app,self.setChangedHook,self) 
  self.strModemOffhook:=control

  NEW control.createString('NRAMS1',NODE_MODEM_NRAMS,self.app.app,self.setChangedHook,self) 
  self.strNRAMS1:=control
  NEW control.createString('NRAMS2',NODE_MODEM_NRAMS,self.app.app,self.setChangedHook,self) 
  self.strNRAMS2:=control
  NEW control.createString('NRAMS3',NODE_MODEM_NRAMS,self.app.app,self.setChangedHook,self) 
  self.strNRAMS3:=control
  NEW control.createString('NRAMS4',NODE_MODEM_NRAMS,self.app.app,self.setChangedHook,self) 
  self.strNRAMS4:=control


  //window settings
  NEW control.createCycle('Number of Colours',NODE_WIN_COLOURS,['2','4','8','16',0],self.app.app,self.setChangedHook,self) 
  self.intNumColours:=control
  NEW control.createStringInt('Left Edge',NODE_WIN_LEFT,self.app.app,self.setChangedHook,self) 
  self.intWinLeftEdge:=control
  NEW control.createStringInt('Top Edge',NODE_WIN_TOP,self.app.app,self.setChangedHook,self) 
  self.intWinTopEdge:=control
  NEW control.createStringInt('Width',NODE_WIN_WIDTH,self.app.app,self.setChangedHook,self) 
  self.intWinWidth:=control
  NEW control.createStringInt('Height',NODE_WIN_HEIGHT,self.app.app,self.setChangedHook,self) 
  self.intWinHeight:=control
  NEW control.createString('Pubscreen',NODE_WIN_PUBSCREEN,self.app.app,self.setChangedHook,self) 
  self.strWinPubScreen:=control
  NEW control.createCheckBox('Iconified',NODE_WIN_ICONIFIED,self.app.app,self.setChangedHook,self)
  self.boolWinIconified:=control
  NEW control.createCheckBox('Interlace',NODE_WIN_INTERLACE,self.app.app,self.setChangedHook,self)
  self.boolWinInterlace:=control
  NEW control.createCheckBox('Status bar',NODE_WIN_STATUSBAR,self.app.app,self.setChangedHook,self)
  self.boolWinStatusBar:=control
  NEW control.createCheckBox('Bring To Front',NODE_WIN_TO_FRONT,self.app.app,self.setChangedHook,self)
  self.boolWinToFront:=control
  NEW control.createModeSelect('DisplayId',NODE_DISPLAY_ID,self.app.app,self.setChangedHook,self)
  self.strDisplayId:=control

  self.controlList1:= [self.intPriority,self.strNodeStart,self.strSystemPassword,self.strSystemPasswordPrompt,self.strNewuserPassword,
                       self.strNamePrompt,self.strNamePrompt2,self.strPasswordPrompt,self.paScreens,self.intAutoValPreset,self.intAutoValDelay,
                       self.strAutoValPassword,self.strFtpPort,self.strFtpDataPort,self.strHttpPort,self.intKeepUlCredit,
                       self.intMaxMsgQueue,self.paPlaypen,self.intRingCount,self.strRemotePassword,self.intSysopChatColour,self.intUserChatColour,
                       self.fnUserDataName,self.fnUserMiscName,self.fnUserKeysName,self.paLocalUlPath,self.strForceAnsi,self.intOverrideTimeout,
                       self.intBGFilecheckStack,self.strConInputDev,self.strConOutputDev,self.strScreenPens,self.strConfDb,self.fnFilesNotAllowed,
                       self.strFirstCommand,self.intSerialCacheSize]
  
  domethod(self.grpNodeSettings,[MUIM_Group_InitChange])
  ForAll({control},self.controlList1,`control.addToGroup(self.grpNodeSettings))
  domethod(self.grpNodeSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpNodeSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpNodeSettings,[MUIM_Group_ExitChange])
  
  self.controlList2:= [self.boolCallersLog,self.boolCapitalFilenames,self.boolDefScreens,self.boolDebugLog,self.boolDoorLog,self.boolStartLog,
                       self.boolUDLog,self.boolChatOn,self.boolDisableQuickLogon,self.boolIdleNode,self.boolMailscanPrompt,self.boolNoTimeout,
                       self.boolQuietNode,self.boolStealthNode,self.boolShowPwFail,self.boolSentByFiles,self.boolTelnet,self.boolFtp,self.boolTelnetD,
                       self.boolTelserD,self.boolUserNumLogin,self.boolViewPassword,self.boolLogHost,self.boolLogInputs,self.boolNoCx,self.boolCentralAnswers,
                       self.boolDisableIemsi,self.boolNoMciMsg,self.boolNoWildcard,self.boolOwnPartFiles,self.boolPhoneCheck,self.boolRamWork,
                       self.boolConsoleDebug,self.boolNoEmails,self.boolOwnDevunit,self.boolShowCacheStats,self.boolTrapDoor,self.boolTrapSerial,self.boolNoRadBoogie]

  domethod(self.grpNodeSettings2,[MUIM_Group_InitChange])
  ForAll({control},self.controlList2,`control.addToGroup(self.grpNodeSettings2))
  domethod(self.grpNodeSettings2,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpNodeSettings2,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpNodeSettings2,[MUIM_Group_ExitChange])

  self.controlList3:=[self.strSerialDevice,self.intSerialUnit,self.intSerialBaud,0,0,self.boolA2232Patch,self.boolNoPurgeLine,self.boolRepurge,
                      self.boolLogoffReset,self.boolTrueReset,0,0,0,0,0,0,self.strModemInit,self.strModemReset,self.strModemRing,self.strModemAnswer,
                      self.strModemOffhook,0,0,0,0,0,0,self.strNRAMS1,self.strNRAMS2,self.strNRAMS3,self.strNRAMS4]

  domethod(self.grpNodeSettings3,[MUIM_Group_InitChange])

  ForAll({control},self.controlList3,`IF control THEN control.addToGroup(self.grpNodeSettings3) ELSE domethod(self.grpNodeSettings3,[OM_ADDMEMBER,HVSpace]))
  domethod(self.grpNodeSettings3,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpNodeSettings3,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpNodeSettings3,[MUIM_Group_ExitChange])

  domethod(self.grpNodeSettings4,[MUIM_Group_InitChange])

  self.controlList4:= [self.intNumColours,self.intWinLeftEdge,self.intWinTopEdge,self.intWinWidth,self.intWinHeight,self.strWinPubScreen,
                       self.strDisplayId,self.boolWinIconified,self.boolWinInterlace,self.boolWinStatusBar,self.boolWinToFront]

  ForAll({control},self.controlList4,`control.addToGroup(self.grpNodeSettings4))
  domethod(self.grpNodeSettings4,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpNodeSettings4,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpNodeSettings4,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpNodeSettings4,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpNodeSettings4,[MUIM_Group_ExitChange])
ENDPROC

PROC freeControl(control:PTR TO control,group) OF frmNodeEdit
  IF control
    control.removeFromGroup(group)
    END control
  ENDIF
ENDPROC

PROC removeControls() OF frmNodeEdit
  DEF list:PTR TO lh,state,obj
  DEF control:PTR TO control

  ForAll({control},self.controlList1,`self.freeControl(control,self.grpNodeSettings))
  ForAll({control},self.controlList2,`self.freeControl(control,self.grpNodeSettings2))
  ForAll({control},self.controlList3,`self.freeControl(control,self.grpNodeSettings3))
  ForAll({control},self.controlList4,`self.freeControl(control,self.grpNodeSettings4))

  get(self.grpNodeSettings,MUIA_Group_ChildList,{list})
  domethod(self.grpNodeSettings,[MUIM_Group_InitChange])
  state:=list.head
  WHILE (obj:=NextObject({state}))
    domethod(self.grpNodeSettings,[OM_REMMEMBER,obj])
    Mui_DisposeObject(obj)
  ENDWHILE
  domethod(self.grpNodeSettings,[MUIM_Group_ExitChange])
  
  get(self.grpNodeSettings2,MUIA_Group_ChildList,{list})
  domethod(self.grpNodeSettings2,[MUIM_Group_InitChange])
  state:=list.head
  WHILE (obj:=NextObject({state}))
    domethod(self.grpNodeSettings2,[OM_REMMEMBER,obj])
    Mui_DisposeObject(obj)
  ENDWHILE
  domethod(self.grpNodeSettings2,[MUIM_Group_ExitChange])
  
  get(self.grpNodeSettings3,MUIA_Group_ChildList,{list})
  domethod(self.grpNodeSettings3,[MUIM_Group_InitChange])
  state:=list.head
  WHILE (obj:=NextObject({state}))
    domethod(self.grpNodeSettings3,[OM_REMMEMBER,obj])
    Mui_DisposeObject(obj)
  ENDWHILE
  domethod(self.grpNodeSettings3,[MUIM_Group_ExitChange])

  get(self.grpNodeSettings4,MUIA_Group_ChildList,{list})
  domethod(self.grpNodeSettings4,[MUIM_Group_InitChange])
  state:=list.head
  WHILE (obj:=NextObject({state}))
    domethod(self.grpNodeSettings4,[OM_REMMEMBER,obj])
    Mui_DisposeObject(obj)
  ENDWHILE
  domethod(self.grpNodeSettings4,[MUIM_Group_ExitChange])
ENDPROC

PROC firstNode() OF frmNodeEdit
  MOVE.L (A1),self
  GetA4()
  self.loadNode(0)
ENDPROC

PROC prevNode() OF frmNodeEdit
  MOVE.L (A1),self
  GetA4()
  self.loadNode(self.currNode-1)
ENDPROC

PROC nextNode() OF frmNodeEdit
  MOVE.L (A1),self
  GetA4()
  self.loadNode(self.currNode+1)
ENDPROC

PROC lastNode() OF frmNodeEdit
  MOVE.L (A1),self
  GetA4()
  self.loadNode(self.nodeCount-1)
ENDPROC

PROC canClose() OF frmNodeEdit
  MOVE.L (A1),self
  GetA4()
  IF self.changed
    IF self.unsavedChangesWarning()=0 THEN RETURN FALSE
  ENDIF
ENDPROC TRUE

PROC unsavedChangesWarning() OF frmNodeEdit
  IF Mui_RequestA(0,self.winMain,0,'Unsaved changes',
    '*OK|CANCEL','You have unsaved changes,\nif you continue you will lose them.',0)=0 THEN RETURN FALSE
ENDPROC TRUE

PROC deleteNodeWarning() OF frmNodeEdit
  IF Mui_RequestA(0,self.winMain,0,'Warning','*Yes|No','Are you sure you wish to delete this node?',0)=0 THEN RETURN FALSE
ENDPROC TRUE

PROC deleteNodeFolderRequest() OF frmNodeEdit
  IF Mui_RequestA(0,self.winMain,0,'Warning','*Yes|No','Do you wish to also remove the Node folder contents?',0)=0 THEN RETURN FALSE
ENDPROC TRUE

PROC validateTime(timeStr:PTR TO CHAR,startControl,endControl) OF frmNodeEdit
  DEF timeVal,timeEntry
  DEF errorText[255]:STRING

  get(startControl, MUIA_String_Contents,{timeEntry})
  
  IF StrLen(timeEntry)>0
    timeVal:=Val(timeEntry)
    IF (Mod(timeVal,100)>59) OR (timeVal>2359) OR (timeVal<0)
      StringF(errorText,'You have entered an invalid time for \s baud start time',timeStr)
      Mui_RequestA(0,self.winMain,0,'Error','*OK',errorText,0)
      RETURN FALSE
    ENDIF
  ENDIF

  get(endControl, MUIA_String_Contents,{timeEntry})
  
  IF StrLen(timeEntry)>0
    timeVal:=Val(timeEntry)
    IF (Mod(timeVal,100)>59) OR (timeVal>2359) OR (timeVal<0)
      StringF(errorText,'You have entered an invalid time for \s baud end time',timeStr)
      Mui_RequestA(0,self.winMain,0,'Error','*OK',errorText,0)
      RETURN FALSE
    ENDIF
  ENDIF

ENDPROC TRUE

PROC saveChanges() OF frmNodeEdit
  DEF nodeStr[255]:STRING
  DEF bbsPath[255]:STRING
  DEF folderStr[255]:STRING
  DEF tempStr[255]:STRING
  DEF toolTypePath[255]:STRING
  DEF windowTooltype[255]:STRING
  DEF timeTooltype[255]:STRING
  DEF timeItem:PTR TO timeItem
  DEF val
  
  MOVE.L (A1),self
  GetA4()
  

  fullTrim(self.strNodeStart.getValue(),tempStr)
  IF EstrLen(tempStr)=0
    Mui_RequestA(0,self.winMain,0,'Error','*OK','Express File is a mandatory field',0)
    RETURN
  ENDIF

  IF Exists({timeItem},self.timesList,`self.validateTime(timeItem.baudStr,timeItem.startControl,timeItem.endControl)=FALSE) THEN RETURN

  self.sleep()
  StringF(nodeStr,'\d',self.nodeCount)
  writeToolType(self.acpName,'NODES',nodeStr)
  
  readToolType(self.acpName,'BBS_LOCATION',bbsPath)
  StringF(nodeStr,'\sNode\d',bbsPath,self.currNode)
  
  IF (self.newNode)
    //create the folder structure
    makeDir(nodeStr)
    StringF(folderStr,'\s/work',nodeStr)
    makeDir(folderStr)
    StringF(folderStr,'\s/playpen',nodeStr)
    makeDir(folderStr)
    StringF(folderStr,'\s/serial',nodeStr)
    makeDir(folderStr)
    StringF(folderStr,'\s/modem',nodeStr)
    makeDir(folderStr)
    StringF(folderStr,'\s/nrams',nodeStr)
    makeDir(folderStr)
    val:=self.paScreens.getValue()
    IF StrLen(val)>0
      makeDir(val)
    ENDIF
    val:=self.paPlaypen.getValue()
    IF StrLen(val)>0
      makeDir(val)
    ENDIF
  ENDIF

  writeToolType(nodeStr,'PRIORITY',self.intPriority.getValue())
  writeToolType(nodeStr,'NODESTART',self.strNodeStart.getValue())
  writeToolType(nodeStr,'SYSTEM_PASSWORD',self.strSystemPassword.getValue())
  writeToolType(nodeStr,'SYS_PWRD_PROMPT',self.strSystemPasswordPrompt.getValue())
  writeToolType(nodeStr,'NEWUSER_PASSWORD',self.strNewuserPassword.getValue())
  writeToolType(nodeStr,'NAME_PROMPT',self.strNamePrompt.getValue())
  writeToolType(nodeStr,'NAME_PROMPT2',self.strNamePrompt2.getValue())
  writeToolType(nodeStr,'PASSWORD_PROMPT',self.strPasswordPrompt.getValue())
  writeToolType(nodeStr,'SCREENS',self.paScreens.getValue())
  writeToolType(nodeStr,'AUTOVAL_PRESET',self.intAutoValPreset.getValue())
  writeToolType(nodeStr,'AUTOVAL_DELAY',self.intAutoValDelay.getValue())
  writeToolType(nodeStr,'AUTOVAL_PASSWORD',self.strAutoValPassword.getValue())
  writeToolType(nodeStr,'FTPPORT',self.strFtpPort.getValue())
  writeToolType(nodeStr,'FTPDATAPORT',self.strFtpDataPort.getValue())
  writeToolType(nodeStr,'HTTPPORT',self.strHttpPort.getValue())

  val:=self.intKeepUlCredit.getValueIndex()
  StringF(tempStr,'\d',val)
  writeToolType(nodeStr,'KEEP_UPLOAD_CREDIT',tempStr)

  writeToolType(nodeStr,'MAX_MSG_QU',self.intMaxMsgQueue.getValue())
  writeToolType(nodeStr,'PLAYPEN',self.paPlaypen.getValue())
  writeToolType(nodeStr,'RINGCOUNT',self.intRingCount.getValue())
  writeToolType(nodeStr,'REMOTE_PASSWORD',self.strRemotePassword.getValue())
  writeToolType(nodeStr,'SYSOP_CHAT_COLOR',self.intSysopChatColour.getValue())
  writeToolType(nodeStr,'USER_CHAT_COLOR',self.intUserChatColour.getValue())
  writeToolType(nodeStr,'USERDATA_NAME',self.fnUserDataName.getValue())
  writeToolType(nodeStr,'USERKEYS_NAME',self.fnUserMiscName.getValue())
  writeToolType(nodeStr,'USERMISC_NAME',self.fnUserKeysName.getValue())
  writeToolType(nodeStr,'LOCAL_UPLOAD_PATH',self.paLocalUlPath.getValue())

  writeToolType(nodeStr,'OVERRIDE_TIMEOUT',self.intOverrideTimeout.getValue())
  writeToolType(nodeStr,'FORCE_ANSI',self.strForceAnsi.getValue())
  writeToolType(nodeStr,'BGFILECHECKSTACK',self.intBGFilecheckStack.getValue())
  writeToolType(nodeStr,'CONSOLE_INPUT_DEVICE',self.strConInputDev.getValue())
  writeToolType(nodeStr,'CONSOLE_OUTPUT_DEVICE',self.strConOutputDev.getValue())
  writeToolType(nodeStr,'SCREENPENS',self.strScreenPens.getValue())
  writeToolType(nodeStr,'CONF_DB',self.strConfDb.getValue())
  writeToolType(nodeStr,'FILESNOTALLOWED',self.fnFilesNotAllowed.getValue())
  writeToolType(nodeStr,'FIRSTCOMMAND',self.strFirstCommand.getValue())
  writeToolType(nodeStr,'SERIAL_CACHE_SIZE',self.intSerialCacheSize.getValue())

  IF self.boolCallersLog.getValue() THEN writeToolType(nodeStr,'CALLERS_LOG') ELSE deleteToolType(nodeStr,'CALLERS_LOG')
  IF self.boolCapitalFilenames.getValue() THEN writeToolType(nodeStr,'CAPITOL_FILES') ELSE deleteToolType(nodeStr,'CAPITOL_FILES')
  IF self.boolDebugLog.getValue() THEN writeToolType(nodeStr,'DEBUG_LOG') ELSE deleteToolType(nodeStr,'DEBUG_LOG')
  IF self.boolDefScreens.getValue() THEN writeToolType(nodeStr,'DEF_SCREENS') ELSE deleteToolType(nodeStr,'DEF_SCREENS')
  IF self.boolDebugLog.getValue() THEN writeToolType(nodeStr,'DEBUG_LOG') ELSE deleteToolType(nodeStr,'DEBUG_LOG')
  IF self.boolDoorLog.getValue() THEN writeToolType(nodeStr,'DOOR_LOG') ELSE deleteToolType(nodeStr,'DOOR_LOG')
  IF self.boolStartLog.getValue() THEN writeToolType(nodeStr,'START_LOG') ELSE deleteToolType(nodeStr,'START_LOG')
  IF self.boolUDLog.getValue() THEN writeToolType(nodeStr,'UD_LOG') ELSE deleteToolType(nodeStr,'UD_LOG')
  IF self.boolChatOn.getValue() THEN writeToolType(nodeStr,'CHAT_ON') ELSE deleteToolType(nodeStr,'CHAT_ON')
  IF self.boolDisableQuickLogon.getValue() THEN writeToolType(nodeStr,'DISABLE_QUICK_LOGONS') ELSE deleteToolType(nodeStr,'DISABLE_QUICK_LOGONS')
  IF self.boolIdleNode.getValue() THEN writeToolType(nodeStr,'IDLENODE') ELSE deleteToolType(nodeStr,'IDLENODE')
  IF self.boolMailscanPrompt.getValue() THEN writeToolType(nodeStr,'MAILSCAN_PROMPT') ELSE deleteToolType(nodeStr,'MAILSCAN_PROMPT')
  IF self.boolNoTimeout.getValue() THEN writeToolType(nodeStr,'NO_TIMEOUT') ELSE deleteToolType(nodeStr,'NO_TIMEOUT')
  IF self.boolQuietNode.getValue() THEN writeToolType(nodeStr,'QUIETNODE') ELSE deleteToolType(nodeStr,'QUIETNODE')
  IF self.boolStealthNode.getValue() THEN writeToolType(nodeStr,'STEALTH_MODE') ELSE deleteToolType(nodeStr,'STEALTH_MODE')
  IF self.boolShowPwFail.getValue() THEN writeToolType(nodeStr,'SHOWPWFAIL') ELSE deleteToolType(nodeStr,'SHOWPWFAIL')
  IF self.boolSentByFiles.getValue() THEN writeToolType(nodeStr,'SENTBY_FILES') ELSE deleteToolType(nodeStr,'SENTBY_FILES')
  IF self.boolTelnet.getValue() THEN writeToolType(nodeStr,'TELNET') ELSE deleteToolType(nodeStr,'TELNET')
  IF self.boolFtp.getValue() THEN writeToolType(nodeStr,'FTP') ELSE deleteToolType(nodeStr,'FTP')
  IF self.boolTelnetD.getValue() THEN writeToolType(nodeStr,'TELSERD') ELSE deleteToolType(nodeStr,'TELSERD')
  IF self.boolTelserD.getValue() THEN writeToolType(nodeStr,'TELNETD') ELSE deleteToolType(nodeStr,'TELNETD')
  IF self.boolUserNumLogin.getValue() THEN writeToolType(nodeStr,'USERNUMBER_LOGIN') ELSE deleteToolType(nodeStr,'USERNUMBER_LOGIN')
  IF self.boolViewPassword.getValue() THEN writeToolType(nodeStr,'VIEW_PASSWORD') ELSE deleteToolType(nodeStr,'VIEW_PASSWORD')
  IF self.boolLogHost.getValue() THEN writeToolType(nodeStr,'LOG_HOST') ELSE deleteToolType(nodeStr,'LOG_HOST')
  IF self.boolLogInputs.getValue() THEN writeToolType(nodeStr,'LOG_INPUTS') ELSE deleteToolType(nodeStr,'LOG_INPUTS')
  IF self.boolNoCx.getValue() THEN writeToolType(nodeStr,'NO_CX') ELSE deleteToolType(nodeStr,'NO_CX')
  IF self.boolCentralAnswers.getValue() THEN writeToolType(nodeStr,'CENTRAL_ANSWERS') ELSE deleteToolType(nodeStr,'CENTRAL_ANSWERS')
  IF self.boolDisableIemsi.getValue() THEN writeToolType(nodeStr,'DISABLE_IEMSI') ELSE deleteToolType(nodeStr,'DISABLE_IEMSI')
  IF self.boolNoMciMsg.getValue() THEN writeToolType(nodeStr,'NO_MCI_MSG') ELSE deleteToolType(nodeStr,'NO_MCI_MSG')
  IF self.boolNoWildcard.getValue() THEN writeToolType(nodeStr,'NO_WILDCARD_EXPANSION') ELSE deleteToolType(nodeStr,'NO_WILDCARD_EXPANSION')
  IF self.boolOwnPartFiles.getValue() THEN writeToolType(nodeStr,'OWN_PARTFILES') ELSE deleteToolType(nodeStr,'OWN_PARTFILES')
  IF self.boolPhoneCheck.getValue() THEN writeToolType(nodeStr,'PHONECHECK') ELSE deleteToolType(nodeStr,'PHONECHECK')
  IF self.boolRamWork.getValue() THEN writeToolType(nodeStr,'RAMWORK') ELSE deleteToolType(nodeStr,'RAMWORK')
  IF self.boolConsoleDebug.getValue() THEN writeToolType(nodeStr,'CONSOLE_DEBUG') ELSE deleteToolType(nodeStr,'CONSOLE_DEBUG')
  IF self.boolNoEmails.getValue() THEN writeToolType(nodeStr,'NO_EMAILS') ELSE deleteToolType(nodeStr,'NO_EMAILS')
  IF self.boolOwnDevunit.getValue() THEN writeToolType(nodeStr,'OWNDEVUNIT') ELSE deleteToolType(nodeStr,'OWNDEVUNIT')
  IF self.boolShowCacheStats.getValue() THEN writeToolType(nodeStr,'SHOW_CACHE_STATS') ELSE deleteToolType(nodeStr,'SHOW_CACHE_STATS')
  IF self.boolTrapDoor.getValue() THEN writeToolType(nodeStr,'TRAPDOOR') ELSE deleteToolType(nodeStr,'TRAPDOOR')
  IF self.boolTrapSerial.getValue() THEN writeToolType(nodeStr,'TRAP_SERIAL') ELSE deleteToolType(nodeStr,'TRAP_SERIAL')
  IF self.boolNoRadBoogie.getValue() THEN writeToolType(nodeStr,'NORADBOOGIE') ELSE deleteToolType(nodeStr,'NORADBOOGIE')

  //serial device settings
  StringF(toolTypePath,'\sNode\d/Serial',bbsPath,self.currNode)
  IF(self.getToolTypeFileName(toolTypePath,tempStr)=FALSE)
    StrCopy(tempStr,'serial')
  ELSE
    SetStr(tempStr)
  ENDIF
  StringF(toolTypePath,'\sNode\d/Serial/\s',bbsPath,self.currNode,tempStr)

  writeToolType(toolTypePath,'SERIAL.DRIVER',self.strSerialDevice.getValue())
  writeToolType(toolTypePath,'SERIAL.UNIT',self.intSerialUnit.getValue())
  writeToolType(toolTypePath,'SERIAL.BAUD',self.intSerialBaud.getValue())
  
  IF self.boolA2232Patch.getValue() THEN writeToolType(nodeStr,'SERIAL.A2232_PATCH') ELSE deleteToolType(nodeStr,'SERIAL.A2232_PATCH')
  IF self.boolNoPurgeLine.getValue() THEN writeToolType(nodeStr,'SERIAL.NO_PURGELINE') ELSE deleteToolType(nodeStr,'SERIAL.NO_PURGELINE')
  IF self.boolRepurge.getValue() THEN writeToolType(nodeStr,'SERIAL.REPURGE') ELSE deleteToolType(nodeStr,'SERIAL.REPURGE')
  IF self.boolLogoffReset.getValue() THEN writeToolType(nodeStr,'SERIAL.LOGOFF_RESET') ELSE deleteToolType(nodeStr,'SERIAL.LOGOFF_RESET')
  IF self.boolTrueReset.getValue() THEN writeToolType(nodeStr,'SERIAL.TRUE_RESET') ELSE deleteToolType(nodeStr,'SERIAL.TRUE_RESET')

  StringF(toolTypePath,'\sNode\d/Modem',bbsPath,self.currNode)
  IF(self.getToolTypeFileName(toolTypePath,tempStr))=FALSE
    StrCopy(tempStr,'modem')
  ELSE
    SetStr(tempStr)
  ENDIF
  StringF(toolTypePath,'\sNode\d/Modem/\s',bbsPath,self.currNode,tempStr)

  //modem settings
  writeToolType(toolTypePath,'MODEM.INIT',self.strModemInit.getValue())
  writeToolType(toolTypePath,'MODEM.RESET',self.strModemReset.getValue())
  writeToolType(toolTypePath,'MODEM.RING',self.strModemRing.getValue())
  writeToolType(toolTypePath,'MODEM.ANSWER',self.strModemAnswer.getValue())
  writeToolType(toolTypePath,'MODEM.OFFHOOK',self.strModemOffhook.getValue())

  StringF(toolTypePath,'\sNode\d/NRAMS',bbsPath,self.currNode)
  IF(self.getToolTypeFileName(toolTypePath,tempStr))=FALSE
    StrCopy(tempStr,'nrams')
  ELSE
    SetStr(tempStr)
  ENDIF
  StringF(toolTypePath,'\sNode\d/Modem/\s',bbsPath,self.currNode,tempStr)

  //NRAM settings
  writeToolType(toolTypePath,'NRAM.1',self.strNRAMS1.getValue())
  writeToolType(toolTypePath,'NRAM.2',self.strNRAMS2.getValue())
  writeToolType(toolTypePath,'NRAM.3',self.strNRAMS3.getValue())
  writeToolType(toolTypePath,'NRAM.4',self.strNRAMS4.getValue())


  StringF(windowTooltype,'\s/WINDOW.DEF',nodeStr)
  val:=self.intNumColours.getValueIndex()
  SELECT val
    CASE 0
      writeToolType(windowTooltype,'WINDOW.NUM_COLORS','2')
    CASE 1
      writeToolType(windowTooltype,'WINDOW.NUM_COLORS','4')
    CASE 2
      writeToolType(windowTooltype,'WINDOW.NUM_COLORS','8')
    CASE 3
      writeToolType(windowTooltype,'WINDOW.NUM_COLORS','16')
    DEFAULT
      writeToolType(windowTooltype,'WINDOW.NUM_COLORS','8')
  ENDSELECT
      
  writeToolType(windowTooltype,'WINDOW.LEFTEDGE',self.intWinLeftEdge.getValue())
  writeToolType(windowTooltype,'WINDOW.TOPEDGE',self.intWinTopEdge.getValue())
  writeToolType(windowTooltype,'WINDOW.WIDTH',self.intWinWidth.getValue())
  writeToolType(windowTooltype,'WINDOW.HEIGHT',self.intWinHeight.getValue())
  writeToolType(windowTooltype,'WINDOW.PUBSCREEN',self.strWinPubScreen.getValue())
  IF self.boolWinIconified.getValue() THEN writeToolType(windowTooltype,'WINDOW.ICONIFIED') ELSE deleteToolType(windowTooltype,'WINDOW.ICONIFIED')
  IF self.boolWinInterlace.getValue() THEN writeToolType(windowTooltype,'WINDOW.INTERLACE') ELSE deleteToolType(windowTooltype,'WINDOW.INTERLACE')
  IF self.boolWinStatusBar.getValue() THEN writeToolType(windowTooltype,'WINDOW.STATBAR') ELSE deleteToolType(windowTooltype,'WINDOW.STATBAR')
  IF self.boolWinToFront.getValue() THEN writeToolType(windowTooltype,'WINDOW.TO_FRONT') ELSE deleteToolType(windowTooltype,'WINDOW.TO_FRONT')
  writeToolType(windowTooltype,'WINDOW.DISPLAYID',self.strDisplayId.getValue())

  StringF(timeTooltype,'\s/TIMES.DEF',nodeStr)
  ForAll({timeItem},self.timesList,`self.saveTimes(timeTooltype,timeItem.baudStr,timeItem.startControl,timeItem.endControl))
  saveCachedChanges()


  set( self.btnNodeSave,MUIA_Disabled,MUI_TRUE)
  set( self.btnAddNode,MUIA_Disabled,FALSE)
  set( self.btnCloneNode,MUIA_Disabled,FALSE)
  self.changed:=FALSE
  self.newNode:=FALSE
  self.wake()
ENDPROC

PROC getToolTypeFileName(path:PTR TO CHAR,buf:PTR TO CHAR) OF frmNodeEdit
  DEF returnval=0
  DEF dir_info:PTR TO fileinfoblock
  DEF pdir  
  
  IF ((dir_info:=AllocDosObject(DOS_FIB,NIL)) = NIL)
    RETURN 0
  ENDIF
  
  IF ((pdir:=Lock(path,ACCESS_READ)))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF
  
  IF(Examine(pdir, dir_info))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    UnLock(pdir)
    RETURN 0
  ENDIF
  
  IF(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0)
      returnval:=1
      AstrCopy(buf,dir_info.filename)
      stripInfo(buf)
    ENDIF
  ENDIF
  
  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)
ENDPROC returnval

PROC saveTimes(toolType,baudStr,startControl,endControl) OF frmNodeEdit
  DEF toolTypeName[255]:STRING
  DEF timeVal
  get(startControl, MUIA_String_Contents,{timeVal})
  StringF(toolTypeName,'START.\s',baudStr)
  writeToolType(toolType,toolTypeName,timeVal)

  get(endControl, MUIA_String_Contents,{timeVal})
  StringF(toolTypeName,'END.\s',baudStr)
  writeToolType(toolType,toolTypeName,timeVal)
ENDPROC

PROC loadTimes(toolType,baudStr,startControl,endControl) OF frmNodeEdit
  DEF toolTypeName[255]:STRING
  DEF tempStr[255]:STRING
   
  StringF(toolTypeName,'START.\s',baudStr)
  readToolType(toolType,toolTypeName,tempStr)
  domethod(startControl,[MUIM_NoNotifySet,MUIA_String_Contents,tempStr])

  StringF(toolTypeName,'END.\s',baudStr)
  readToolType(toolType,toolTypeName,tempStr)
  domethod(endControl,[MUIM_NoNotifySet,MUIA_String_Contents,tempStr])
ENDPROC


PROC loadNode(node) OF frmNodeEdit
  DEF nodeStr[255]:STRING,val
  DEF windowTooltype[255]:STRING
  DEF timeTooltype[255]:STRING
  DEF bbsPath[255]:STRING
  DEF tooltypeValue[255]:STRING
  DEF toolTypePath[255]:STRING
  DEF tempStr[255]:STRING
  DEF timeItem:PTR TO timeItem

  IF self.changed
    IF self.unsavedChangesWarning()=FALSE THEN RETURN FALSE
  ENDIF

  IF self.newNode THEN self.nodeCount:=self.nodeCount-1

  StringF(nodeStr,'\d',node)
  self.currNode:=node

  set(self.strNodeNumber, MUIA_String_Contents,nodeStr)
  set( self.btnPrevNode, MUIA_Disabled , node=0)
  set( self.btnNextNode, MUIA_Disabled , node>=(self.nodeCount-1))
  set( self.btnRemoveNode, MUIA_Disabled , (node<(self.nodeCount-1)) OR (node=0))

  readToolType(self.acpName,'BBS_LOCATION',bbsPath)

  StringF(nodeStr,'\snode\d',bbsPath,node)

  val:=readToolTypeInt(nodeStr,'PRIORITY')
  self.intPriority.setValue(val)
  readToolType(nodeStr,'NODESTART',tooltypeValue)
  self.strNodeStart.setValue(tooltypeValue)
  readToolType(nodeStr,'SYSTEM_PASSWORD',tooltypeValue)
  self.strSystemPassword.setValue(tooltypeValue)
  readToolType(nodeStr,'SYS_PWRD_PROMPT',tooltypeValue)
  self.strSystemPasswordPrompt.setValue(tooltypeValue)
  readToolType(nodeStr,'NEWUSER_PASSWORD',tooltypeValue)
  self.strNewuserPassword.setValue(tooltypeValue)
  readToolType(nodeStr,'NAME_PROMPT',tooltypeValue)
  self.strNamePrompt.setValue(tooltypeValue)
  readToolType(nodeStr,'NAME_PROMPT2',tooltypeValue)
  self.strNamePrompt2.setValue(tooltypeValue)
  readToolType(nodeStr,'PASSWORD_PROMPT',tooltypeValue)
  self.strPasswordPrompt.setValue(tooltypeValue)
  readToolType(nodeStr,'SCREENS',tooltypeValue)
  self.paScreens.setValue(tooltypeValue)
  val:=readToolTypeInt(nodeStr,'AUTOVAL_PRESET')
  self.intAutoValPreset.setValue(val)
  val:=readToolTypeInt(nodeStr,'AUTOVAL_DELAY')
  self.intAutoValDelay.setValue(val)
  readToolType(nodeStr,'AUTOVAL_PASSWORD',tooltypeValue)
  self.strAutoValPassword.setValue(tooltypeValue)

  readToolType(nodeStr,'FTPPORT',tooltypeValue)
  self.strFtpPort.setValue(tooltypeValue)
  readToolType(nodeStr,'FTPDATAPORT',tooltypeValue)
  self.strFtpDataPort.setValue(tooltypeValue)
  readToolType(nodeStr,'HTTPPORT',tooltypeValue)
  self.strHttpPort.setValue(tooltypeValue)
  val:=readToolTypeInt(nodeStr,'KEEP_UPLOAD_CREDIT')
  IF val<>1 THEN val:=0
  self.intKeepUlCredit.setValueIndex(val)
  val:=readToolTypeInt(nodeStr,'MAX_MSG_QUE')
  self.intMaxMsgQueue.setValue(val)
  readToolType(nodeStr,'PLAYPEN',tooltypeValue)
  self.paPlaypen.setValue(tooltypeValue)
  val:=readToolTypeInt(nodeStr,'RINGCOUNT')
  self.intRingCount.setValue(val)
  readToolType(nodeStr,'REMOTE_PASSWORD',tooltypeValue)
  self.strRemotePassword.setValue(tooltypeValue)
  val:=readToolTypeInt(nodeStr,'SYSOP_CHAT_COLOR')
  self.intSysopChatColour.setValue(val)
  val:=readToolTypeInt(nodeStr,'USER_CHAT_COLOR')
  self.intUserChatColour.setValue(val)
  readToolType(nodeStr,'USERDATA_NAME',tooltypeValue)
  self.fnUserDataName.setValue(tooltypeValue)
  readToolType(nodeStr,'USERKEYS_NAME',tooltypeValue)
  self.fnUserMiscName.setValue(tooltypeValue)
  readToolType(nodeStr,'USERMISC_NAME',tooltypeValue)
  self.fnUserKeysName.setValue(tooltypeValue)
  readToolType(nodeStr,'LOCAL_UPLOAD_PATH',tooltypeValue)
  self.paLocalUlPath.setValue(tooltypeValue)
  val:=readToolTypeInt(nodeStr,'OVERRIDE_TIMEOUT')
  self.intOverrideTimeout.setValue(val)
  readToolType(nodeStr,'FORCE_ANSI',tooltypeValue)
  self.strForceAnsi.setValue(tooltypeValue)
  val:=readToolTypeInt(nodeStr,'BGFILECHECKSTACK')
  self.intBGFilecheckStack.setValue(val)
  readToolType(nodeStr,'CONSOLE_INPUT_DEVICE',tooltypeValue)
  self.strConInputDev.setValue(tooltypeValue)
  readToolType(nodeStr,'CONSOLE_OUTPUT_DEVICE',tooltypeValue)
  self.strConOutputDev.setValue(tooltypeValue)
  readToolType(nodeStr,'SCREENPENS',tooltypeValue)
  self.strScreenPens.setValue(tooltypeValue)
  readToolType(nodeStr,'CONF_DB',tooltypeValue)
  self.strConfDb.setValue(tooltypeValue)
  readToolType(nodeStr,'FILESNOTALLOWED',tooltypeValue)
  self.fnFilesNotAllowed.setValue(tooltypeValue)
  readToolType(nodeStr,'FIRSTCOMMAND',tooltypeValue)
  self.strFirstCommand.setValue(tooltypeValue)
  val:=readToolTypeInt(nodeStr,'SERIAL_CACHE_SIZE')
  self.intSerialCacheSize.setValue(val)
  self.boolCallersLog.setValue(IF checkToolTypeExists(nodeStr,'CALLERS_LOG') THEN MUI_TRUE ELSE FALSE)
  self.boolCapitalFilenames.setValue(IF checkToolTypeExists(nodeStr,'CAPITOL_FILES') THEN MUI_TRUE ELSE FALSE)
  self.boolDebugLog.setValue(IF checkToolTypeExists(nodeStr,'DEBUG_LOG') THEN MUI_TRUE ELSE FALSE)
  self.boolDefScreens.setValue(IF checkToolTypeExists(nodeStr,'DEF_SCREENS') THEN MUI_TRUE ELSE FALSE)
  self.boolDebugLog.setValue(IF checkToolTypeExists(nodeStr,'DEBUG_LOG') THEN MUI_TRUE ELSE FALSE)
  self.boolDoorLog.setValue(IF checkToolTypeExists(nodeStr,'DOOR_LOG') THEN MUI_TRUE ELSE FALSE)
  self.boolStartLog.setValue(IF checkToolTypeExists(nodeStr,'START_LOG') THEN MUI_TRUE ELSE FALSE)
  self.boolUDLog.setValue(IF checkToolTypeExists(nodeStr,'UD_LOG') THEN MUI_TRUE ELSE FALSE)
  self.boolChatOn.setValue(IF checkToolTypeExists(nodeStr,'CHAT_ON') THEN MUI_TRUE ELSE FALSE)
  self.boolDisableQuickLogon.setValue(IF checkToolTypeExists(nodeStr,'DISABLE_QUICK_LOGONS') THEN MUI_TRUE ELSE FALSE)
  self.boolIdleNode.setValue(IF checkToolTypeExists(nodeStr,'IDLENODE') THEN MUI_TRUE ELSE FALSE)
  self.boolMailscanPrompt.setValue(IF checkToolTypeExists(nodeStr,'MAILSCAN_PROMPT') THEN MUI_TRUE ELSE FALSE)
  self.boolNoTimeout.setValue(IF checkToolTypeExists(nodeStr,'NO_TIMEOUT') THEN MUI_TRUE ELSE FALSE)
  self.boolQuietNode.setValue(IF checkToolTypeExists(nodeStr,'QUIETNODE') THEN MUI_TRUE ELSE FALSE)
  self.boolStealthNode.setValue(IF checkToolTypeExists(nodeStr,'STEALTH_MODE') THEN MUI_TRUE ELSE FALSE)
  self.boolShowPwFail.setValue(IF checkToolTypeExists(nodeStr,'SHOWPWFAIL') THEN MUI_TRUE ELSE FALSE)
  self.boolSentByFiles.setValue(IF checkToolTypeExists(nodeStr,'SENTBY_FILES') THEN MUI_TRUE ELSE FALSE)
  self.boolTelnet.setValue(IF checkToolTypeExists(nodeStr,'TELNET') THEN MUI_TRUE ELSE FALSE)
  self.boolFtp.setValue(IF checkToolTypeExists(nodeStr,'FTP') THEN MUI_TRUE ELSE FALSE)
  self.boolTelnetD.setValue(IF checkToolTypeExists(nodeStr,'TELSERD') THEN MUI_TRUE ELSE FALSE)
  self.boolTelserD.setValue(IF checkToolTypeExists(nodeStr,'TELNETD') THEN MUI_TRUE ELSE FALSE)
  self.boolUserNumLogin.setValue(IF checkToolTypeExists(nodeStr,'USERNUMBER_LOGIN') THEN MUI_TRUE ELSE FALSE)
  self.boolViewPassword.setValue(IF checkToolTypeExists(nodeStr,'VIEW_PASSWORD') THEN MUI_TRUE ELSE FALSE)
  self.boolLogHost.setValue(IF checkToolTypeExists(nodeStr,'LOG_HOST') THEN MUI_TRUE ELSE FALSE)
  self.boolLogInputs.setValue(IF checkToolTypeExists(nodeStr,'LOG_INPUTS') THEN MUI_TRUE ELSE FALSE)
  self.boolNoCx.setValue(IF checkToolTypeExists(nodeStr,'NO_CX') THEN MUI_TRUE ELSE FALSE)
  self.boolCentralAnswers.setValue(IF checkToolTypeExists(nodeStr,'CENTRAL_ANSWERS') THEN MUI_TRUE ELSE FALSE)
  self.boolDisableIemsi.setValue(IF checkToolTypeExists(nodeStr,'DISABLE_IEMSI') THEN MUI_TRUE ELSE FALSE)
  self.boolNoMciMsg.setValue(IF checkToolTypeExists(nodeStr,'NO_MCI_MSG') THEN MUI_TRUE ELSE FALSE)
  self.boolNoWildcard.setValue(IF checkToolTypeExists(nodeStr,'NO_WILDCARD_EXPANSION') THEN MUI_TRUE ELSE FALSE)
  self.boolOwnPartFiles.setValue(IF checkToolTypeExists(nodeStr,'OWN_PARTFILES') THEN MUI_TRUE ELSE FALSE)
  self.boolPhoneCheck.setValue(IF checkToolTypeExists(nodeStr,'PHONECHECK') THEN MUI_TRUE ELSE FALSE)
  self.boolRamWork.setValue(IF checkToolTypeExists(nodeStr,'RAMWORK') THEN MUI_TRUE ELSE FALSE)
  self.boolConsoleDebug.setValue(IF checkToolTypeExists(nodeStr,'CONSOLE_DEBUG') THEN MUI_TRUE ELSE FALSE)
  self.boolNoEmails.setValue(IF checkToolTypeExists(nodeStr,'NO_EMAILS') THEN MUI_TRUE ELSE FALSE)
  self.boolOwnDevunit.setValue(IF checkToolTypeExists(nodeStr,'OWNDEVUNIT') THEN MUI_TRUE ELSE FALSE)
  self.boolShowCacheStats.setValue(IF checkToolTypeExists(nodeStr,'SHOW_CACHE_STATS') THEN MUI_TRUE ELSE FALSE)
  self.boolTrapDoor.setValue(IF checkToolTypeExists(nodeStr,'TRAPDOOR') THEN MUI_TRUE ELSE FALSE)
  self.boolTrapSerial.setValue(IF checkToolTypeExists(nodeStr,'TRAP_SERIAL') THEN MUI_TRUE ELSE FALSE)
  self.boolNoRadBoogie.setValue(IF checkToolTypeExists(nodeStr,'NORADBOOGIE') THEN MUI_TRUE ELSE FALSE)

  //serial device settings
  StringF(toolTypePath,'\sNode\d/Serial',bbsPath,node)
  IF(self.getToolTypeFileName(toolTypePath,tempStr)=FALSE)
    StrCopy(tempStr,'serial')
  ELSE
    SetStr(tempStr)
  ENDIF
  StringF(toolTypePath,'\sNode\d/Serial/\s',bbsPath,node,tempStr)

  readToolType(toolTypePath,'SERIAL.DRIVER',tooltypeValue)
  self.strSerialDevice.setValue(tooltypeValue)
  
  val:=readToolTypeInt(toolTypePath,'SERIAL.UNIT')
  self.intSerialUnit.setValue(val)

  val:=readToolTypeInt(toolTypePath,'SERIAL.BAUD')
  self.intSerialBaud.setValue(val)
  
  self.boolA2232Patch.setValue(IF checkToolTypeExists(toolTypePath,'SERIAL.A2232_PATCH') THEN MUI_TRUE ELSE FALSE)

  self.boolNoPurgeLine.setValue(IF checkToolTypeExists(toolTypePath,'SERIAL.NO_PURGELINE') THEN MUI_TRUE ELSE FALSE)

  self.boolRepurge.setValue(IF checkToolTypeExists(toolTypePath,'SERIAL.REPURGE') THEN MUI_TRUE ELSE FALSE)

  self.boolLogoffReset.setValue(IF checkToolTypeExists(toolTypePath,'SERIAL.LOGOFF_RESET') THEN MUI_TRUE ELSE FALSE)

  self.boolTrueReset.setValue(IF checkToolTypeExists(toolTypePath,'SERIAL.TRUE_RESET') THEN MUI_TRUE ELSE FALSE)

  StringF(toolTypePath,'\sNode\d/Modem',bbsPath,node)
  IF(self.getToolTypeFileName(toolTypePath,tempStr))=FALSE
    StrCopy(tempStr,'modem')
  ELSE
    SetStr(tempStr)
  ENDIF
  StringF(toolTypePath,'\sNode\d/Modem/\s',bbsPath,node,tempStr)

  //modem settings
  readToolType(toolTypePath,'MODEM.INIT',tooltypeValue)
  self.strModemInit.setValue(tooltypeValue)
  readToolType(toolTypePath,'MODEM.RESET',tooltypeValue)
  self.strModemReset.setValue(tooltypeValue)
  readToolType(toolTypePath,'MODEM.RING',tooltypeValue)
  self.strModemRing.setValue(tooltypeValue)
  readToolType(toolTypePath,'MODEM.ANSWER',tooltypeValue)
  self.strModemAnswer.setValue(tooltypeValue)
  readToolType(toolTypePath,'MODEM.OFFHOOK',tooltypeValue)
  self.strModemOffhook.setValue(tooltypeValue)


  StringF(windowTooltype,'\s/WINDOW.DEF',nodeStr)
  val:=readToolTypeInt(windowTooltype,'WINDOW.NUM_COLORS')
  SELECT val
    CASE 2
      self.intNumColours.setValueIndex(0)
    CASE 4
      self.intNumColours.setValueIndex(1)
    CASE 8
      self.intNumColours.setValueIndex(2)
    CASE 16
      self.intNumColours.setValueIndex(3)
    DEFAULT
      self.intNumColours.setValueIndex(8)
  ENDSELECT
      
  val:=readToolTypeInt(windowTooltype,'WINDOW.LEFTEDGE')
  self.intWinLeftEdge.setValue(val)
  val:=readToolTypeInt(windowTooltype,'WINDOW.TOPEDGE')
  self.intWinTopEdge.setValue(val)
  val:=readToolTypeInt(windowTooltype,'WINDOW.WIDTH')
  self.intWinWidth.setValue(val)
  val:=readToolTypeInt(windowTooltype,'WINDOW.HEIGHT')
  self.intWinHeight.setValue(val)
  readToolType(windowTooltype,'WINDOW.PUBSCREEN',tooltypeValue)
  self.strWinPubScreen.setValue(tooltypeValue)
  self.boolWinIconified.setValue(IF checkToolTypeExists(windowTooltype,'WINDOW.ICONIFIED') THEN MUI_TRUE ELSE FALSE)
  self.boolWinInterlace.setValue(IF checkToolTypeExists(windowTooltype,'WINDOW.INTERLACE') THEN MUI_TRUE ELSE FALSE)
  self.boolWinStatusBar.setValue(IF checkToolTypeExists(windowTooltype,'WINDOW.STATBAR') THEN MUI_TRUE ELSE FALSE)
  self.boolWinToFront.setValue(IF checkToolTypeExists(windowTooltype,'WINDOW.TO_FRONT') THEN MUI_TRUE ELSE FALSE)
  readToolType(windowTooltype,'WINDOW.DISPLAYID',tooltypeValue)
  self.strDisplayId.setValue(tooltypeValue)

  StringF(timeTooltype,'\s/TIMES.DEF',nodeStr)
  ForAll({timeItem},self.timesList,`self.loadTimes(timeTooltype,timeItem.baudStr,timeItem.startControl,timeItem.endControl))

  self.changed:=FALSE
  set( self.btnNodeSave, MUIA_Disabled , MUI_TRUE)
  set( self.btnAddNode,MUIA_Disabled,FALSE)
  set( self.btnCloneNode,MUIA_Disabled,FALSE)
  self.newNode:=FALSE
ENDPROC TRUE

PROC editNodes(acpName) OF frmNodeEdit
  DEF count,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  DEF timeItem:PTR TO timeItem

  NEW saveHook
  installhook( saveHook, {saveChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  set( self.btnFirstNode, MUIA_ShortHelp , getHelpText(NODE_FIRST))
  set( self.btnPrevNode, MUIA_ShortHelp , getHelpText(NODE_PREV))
  set( self.btnNextNode, MUIA_ShortHelp , getHelpText(NODE_NEXT))
  set( self.btnLastNode, MUIA_ShortHelp , getHelpText(NODE_LAST))
  set( self.btnAddNode, MUIA_ShortHelp , getHelpText(NODE_ADD))
  set( self.btnCloneNode, MUIA_ShortHelp , getHelpText(NODE_CLONE))
  set( self.btnRemoveNode, MUIA_ShortHelp , getHelpText(NODE_DEL))

  self.timesList:=[
    ['300',self.app.str300start,self.app.str300end]:timeItem,
    ['1200',self.app.str1200start,self.app.str1200end]:timeItem,
    ['2400',self.app.str2400start,self.app.str2400end]:timeItem,
    ['4800',self.app.str4800start,self.app.str4800end]:timeItem,
    ['9600',self.app.str9600start,self.app.str9600end]:timeItem,
    ['12000',self.app.str12000start,self.app.str12000end]:timeItem,
    ['14400',self.app.str14400start,self.app.str14400end]:timeItem,
    ['16800',self.app.str16800start,self.app.str16800end]:timeItem,
    ['19200',self.app.str19200start,self.app.str19200end]:timeItem,
    ['21600',self.app.str21600start,self.app.str21600end]:timeItem,
    ['24000',self.app.str24000start,self.app.str24000end]:timeItem,
    ['26400',self.app.str26400start,self.app.str26400end]:timeItem,
    ['28800',self.app.str28800start,self.app.str28800end]:timeItem,
    ['31200',self.app.str31200start,self.app.str31200end]:timeItem,
    ['33600',self.app.str33600start,self.app.str33600end]:timeItem,
    ['38400',self.app.str38400start,self.app.str38400end]:timeItem,
    ['57600',self.app.str57600start,self.app.str57600end]:timeItem,
    ['115200',self.app.str115200start,self.app.str115200end]:timeItem]

  ForAll({timeItem},self.timesList,`set( timeItem.startControl, MUIA_ShortHelp , getHelpText(NODE_TIME_START)))
  ForAll({timeItem},self.timesList,`set( timeItem.endControl, MUIA_ShortHelp , getHelpText(NODE_TIME_END)))
  ForAll({timeItem},self.timesList,`domethod( timeItem.startControl,[MUIM_Notify,MUIA_String_Contents,MUIV_EveryTime,self.app.app,3,MUIM_CallHook,self.setChangedHook,self]))
  ForAll({timeItem},self.timesList,`domethod( timeItem.endControl,[MUIM_Notify,MUIA_String_Contents,MUIV_EveryTime,self.app.app,3,MUIM_CallHook,self.setChangedHook,self]))

  self.acpName:=acpName  

  set( self.btnRemoveNode, MUIA_Disabled , MUI_TRUE)

  self.nodeCount:=readToolTypeInt(acpName,'NODES')

  installhook( self.setChangedHook, {setChangedFlag})    
  self.addControls()
  self.addNotifications()

  set(self.grpNodePages,MUIA_Group_ActivePage,MUIV_Group_ActivePage_First)
 
  self.changed:=FALSE
  self.loadNode(0)
  
  self.showModal()
  self.removeNotifications()
  self.removeControls()

  ForAll({timeItem},self.timesList,`domethod( timeItem.startControl,[MUIM_KillNotify,MUIA_String_Contents]))
  ForAll({timeItem},self.timesList,`domethod( timeItem.endControl,[MUIM_KillNotify,MUIA_String_Contents]))

  END saveHook
  END closeHook
ENDPROC

