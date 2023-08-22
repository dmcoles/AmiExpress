OPT MODULE,LARGE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','workbench/workbench','icon','intuition/classusr'
MODULE 'utility/tagitem','utility/hooks','tools/installhook','exec/lists'
MODULE '*axedit','*frmBase','*tooltypes','*controls','*miscfuncs','*/stringlist','*helpText'


EXPORT OBJECT frmSettingsEdit OF frmBase
  acpName          : PTR TO CHAR
  bbsConfigName    : PTR TO CHAR
  zoomDirPath      : PTR TO CHAR
  btnSave          : PTR TO LONG
  btnCancel        : PTR TO LONG
  grpSettings      : PTR TO LONG
  changed
  setChangedHook   : hook
  controlList      : LONG
  languages        : PTR TO LONG
  languagesConfigName:PTR TO CHAR
  nodeCount        : INT
  
  //system settings
  strBBSName       : PTR TO control
  strBBSLocation   : PTR TO control
  strSysopName     : PTR TO control
  strDefaultMenu   : PTR TO control
  paLocalULPath    : PTR TO control
  intAutoValPreset : PTR TO control
  intAutoValDelay  : PTR TO control
  strAutoValPassword: PTR TO control
  cyLanguage       : PTR TO control
  boolCreditByKb   : PTR TO control
  boolLongWho      : PTR TO control
  cyNewAccounts    : PTR TO control
  strRegKey        : PTR TO control
  boolConvertToMb  : PTR TO control
  boolTimeoutLc    : PTR TO control
  boolQuietJoin    : PTR TO control
  boolRelativeConfs: PTR TO control
  strSmtpHost      : PTR TO control
  intSmtpPort      : PTR TO control
  strSmtpUsername  : PTR TO control
  strSmtpPassword  : PTR TO control
  boolSmtpSSL      : PTR TO control
  strSysopEmail    : PTR TO control
  strBbsEmail      : PTR TO control
  boolMailOnPage   : PTR TO control
  boolMailOnComment: PTR TO control
  boolMailOnLogon  : PTR TO control
  boolMailOnLogoff : PTR TO control
  boolMailOnNewUser: PTR TO control
  boolMailOnUpload : PTR TO control
  boolMailOnPwdFail: PTR TO control
  paLanguageBase   : PTR TO control
  paHistory        : PTR TO control
  paUserNotes      : PTR TO control
  intHoldAccess    : PTR TO control
  strFileDizSysCmd : PTR TO control
  strFtpHost       : PTR TO control
  strFtpPort       : PTR TO control
  strFtpDataPort   : PTR TO control
  strHttpPort      : PTR TO control
  strExecOnNewUser : PTR TO control
  strExecAOnNewUser: PTR TO control
  strExecOnPage    : PTR TO control
  strExecAOnPage   : PTR TO control
  strExecOnConnect : PTR TO control
  strExecAOnConnect: PTR TO control
  strExecOnLogon   : PTR TO control
  strExecAOnLogon  : PTR TO control
  strExecOnLogoff  : PTR TO control
  strExecAOnLogoff : PTR TO control
  strExecOnComment : PTR TO control
  strExecAOnComment: PTR TO control
  strExecOnUpload  : PTR TO control
  strExecAOnUpload : PTR TO control

  //server settings
  paBBSPath        : PTR TO control
  intStack       : PTR TO control
  intPriority    : PTR TO control
  boolIconified  : PTR TO control
  intIconifyLeft : PTR TO control
  intIconifyTop  : PTR TO control
  boolDoNotMove  : PTR TO control
  boolMulticom   : PTR TO control
  boolAEShell    : PTR TO control
  boolNoCx       : PTR TO control
  boolNoSaveState: PTR TO control
  intTelnetPort  : PTR TO control
  intFtpPort     : PTR TO control
  strAcpFont     : PTR TO control
  strExecOnStart : PTR TO control
  intDosCheckTime: PTR TO control
  intDosBanTime  : PTR TO control
  intDosCheckTrig: PTR TO control
  nodeLocs       : PTR TO stdlist
  nodeNames      : PTR TO stdlist
  nodeSysops     : PTR TO stdlist
  buttonNames    : PTR TO stdlist
  buttonCommands : PTR TO stdlist
  nuttonNames    : PTR TO stdlist
  nuttonCommands : PTR TO stdlist
  
  //zoom settings
  strBbsNumber   : PTR TO control
  strBbsAddress  : PTR TO control
  strBbsId       : PTR TO control
  strQwkZip      : PTR TO control
  strQwkLha      : PTR TO control
  strAscZip      : PTR TO control
  strAscLha      : PTR TO control
ENDOBJECT

PROC create(app:PTR TO app_obj) OF frmSettingsEdit
  DEF group
  SUPER self.create(app)
  self.winMain:=app.wi_systemdata

  self.setChangedHook.data:=self
  
  self.btnSave:=app.btnSettingsSave
  self.btnCancel:=app.btnSettingsCancel

  get(app.gr_settings,MUIA_Scrollgroup_Contents,{group})
  self.grpSettings:=group

  set(self.winMain,MUIA_Window_Width,MUIV_Window_Width_Screen(50))
ENDPROC

PROC setChangedFlag() OF frmSettingsEdit
  MOVE.L (A1),self
  GetA4()
  
  IF self.changed=FALSE
    self.changed:=TRUE
    set( self.btnSave,MUIA_Disabled,FALSE)
  ENDIF
ENDPROC

PROC freeControl(control:PTR TO control) OF frmSettingsEdit
  control.removeFromGroup(self.grpSettings)
  END control
ENDPROC

PROC addNotifications() OF frmSettingsEdit
  domethod( self.btnCancel , [
    MUIM_Notify , MUIA_Pressed , FALSE ,
    self.app.app,
    2 ,
    MUIM_Application_ReturnID ,  MUIA_Window_CloseRequest ] )

  domethod( self.btnSave , [
    MUIM_Notify , MUIA_Pressed , FALSE ,
    self.app.app,
    2 ,
    MUIM_Application_ReturnID ,  ID_SAVE ] )
ENDPROC

PROC removeNotifications() OF frmSettingsEdit
  domethod(self.btnCancel,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnSave,[MUIM_KillNotify,MUIA_Pressed])
ENDPROC

PROC addSystemControls() OF frmSettingsEdit
  DEF control: PTR TO control
  DEF languageList:PTR TO LONG
  DEF i

  NEW control.createString('bBBS Name',SYS_BBS_NAME,self.app.app,self.setChangedHook,self)
  self.strBBSName:=control

  NEW control.createString('bBBS Location',SYS_BBS_LOCATION,self.app.app,self.setChangedHook,self)
  self.strBBSLocation:=control
  
  NEW control.createString('bSysop Name',SYS_SYSOP_NAME,self.app.app,self.setChangedHook,self)
  self.strSysopName:=control

  NEW control.createString('Default Menu',SYS_DEFAULT_MENU,self.app.app,self.setChangedHook,self)
  self.strDefaultMenu:=control

  NEW control.createDirSelect('Local Upload Path',SYS_LOCAL_UPLOAD_PATH,self.app.app,self.setChangedHook,self)
  self.paLocalULPath:=control

  NEW control.createStringInt('Auto Validate Preset',SYS_AUTO_VAL_PRESET,self.app.app,self.setChangedHook,self)
  self.intAutoValPreset:=control

  NEW control.createStringInt('Auto Validate Delay',SYS_AUTO_VAL_DELAY,self.app.app,self.setChangedHook,self)
  self.intAutoValDelay:=control

  NEW control.createString('Auto Validate Password',SYS_AUTO_VAL_PASSWORD,self.app.app,self.setChangedHook,self)
  self.strAutoValPassword:=control
  
  self.cyLanguage:=0
  IF ListLen(self.languages)>1
      NEW control.createCycle('Host Language',SYS_LANGUAGE,self.languages,self.app.app,self.setChangedHook,self)
    self.cyLanguage:=control
  ENDIF

  NEW control.createCheckBox('Credit by KB',SYS_CREDIT_BY_KB,self.app.app,self.setChangedHook,self)
  self.boolCreditByKb:=control

  NEW control.createCheckBox('Long who',SYS_LONG_WHO,self.app.app,self.setChangedHook,self)
  self.boolLongWho:=control

  NEW control.createCycle('New Accounts',SYS_NEW_ACCOUNTS,['Append','Overwrite',0],self.app.app,self.setChangedHook,self)
  self.cyNewAccounts:=control

  NEW control.createCycle('Timeout Recorded as',SYS_TIMEOUT_LC,['Lost Carrier','Normal Logoff',0],self.app.app,self.setChangedHook,self)
  self.boolTimeoutLc:=control
  
  NEW control.createString('Registered to',SYS_REGKEY,self.app.app,self.setChangedHook,self)
  self.strRegKey:=control
  
  NEW control.createCheckBox('Convert to MB',SYS_CONVERT_TO_MB,self.app.app,self.setChangedHook,self)
  self.boolConvertToMb:=control

  NEW control.createCheckBox('Quiet Join',SYS_QUIET_JOIN,self.app.app,self.setChangedHook,self)
  self.boolQuietJoin:=control

  NEW control.createCheckBox('Relative Conferences',SYS_RELATIVE_CONFS,self.app.app,self.setChangedHook,self)
  self.boolRelativeConfs:=control

  NEW control.createString('SMTP server address',SYS_SMTP_SERVER,self.app.app,self.setChangedHook,self)
  self.strSmtpHost:=control
  NEW control.createStringInt('SMTP server port',SYS_SMTP_PORT,self.app.app,self.setChangedHook,self)
  self.intSmtpPort:=control
  NEW control.createString('SMTP server username',SYS_SMTP_USERNAME,self.app.app,self.setChangedHook,self)
  self.strSmtpUsername:=control
  NEW control.createString('SMTP server password',SYS_SMTP_PASSWORD,self.app.app,self.setChangedHook,self)
  self.strSmtpPassword:=control
  NEW control.createCheckBox('Use SSL for emails',SYS_SSL_EMAILS,self.app.app,self.setChangedHook,self)
  self.boolSmtpSSL:=control
  NEW control.createString('Sysops email address',SYS_SYSOP_EMAIL,self.app.app,self.setChangedHook,self)
  self.strSysopEmail:=control
  NEW control.createString('BBS email address',SYS_BBS_EMAIL,self.app.app,self.setChangedHook,self)
  self.strBbsEmail:=control
  NEW control.createCheckBox('Email on sysop page',SYS_EMAIL_ON_SYSOP_PAGE,self.app.app,self.setChangedHook,self)
  self.boolMailOnPage:=control
  NEW control.createCheckBox('Email on comment',SYS_EMAIL_ON_COMMENT,self.app.app,self.setChangedHook,self)
  self.boolMailOnComment:=control
  NEW control.createCheckBox('Email on logon',SYS_EMAIL_ON_LOGON,self.app.app,self.setChangedHook,self)
  self.boolMailOnLogon:=control
  NEW control.createCheckBox('Email on logoff',SYS_EMAIL_ON_LOGOFF,self.app.app,self.setChangedHook,self)
  self.boolMailOnLogoff:=control
  NEW control.createCheckBox('Email on new user',SYS_EMAIL_ON_NEW_USER,self.app.app,self.setChangedHook,self)
  self.boolMailOnNewUser:=control
  NEW control.createCheckBox('Email on upload',SYS_EMAIL_ON_UPLOAD,self.app.app,self.setChangedHook,self)
  self.boolMailOnUpload:=control
  NEW control.createCheckBox('Email on password fail',SYS_EMAIL_ON_PW_FAIL,self.app.app,self.setChangedHook,self)
  self.boolMailOnPwdFail:=control
  NEW control.createDirSelect('Language base folder',SYS_LANG_BASE_PATH,self.app.app,self.setChangedHook,self)
  self.paLanguageBase:=control
  NEW control.createDirSelect('History folder',SYS_HISTORY_PATH,self.app.app,self.setChangedHook,self)
  self.paHistory:=control
  NEW control.createDirSelect('User notes folder',SYS_USER_NOTES_PATH,self.app.app,self.setChangedHook,self)
  self.paUserNotes:=control
  NEW control.createStringInt('Hold access level',SYS_HOLD_ACCESS_LEVEL,self.app.app,self.setChangedHook,self)
  self.intHoldAccess:=control
  NEW control.createString('File Diz Cmd',SYS_FILEDIZ_CMD,self.app.app,self.setChangedHook,self)
  self.strFileDizSysCmd:=control
  NEW control.createString('FTP host name',SYS_FTP_HOST,self.app.app,self.setChangedHook,self)
  self.strFtpHost:=control
  NEW control.createString('FTP port(s)',SYS_FTP_PORT,self.app.app,self.setChangedHook,self)
  self.strFtpPort:=control
  NEW control.createString('FTP data port(s)',SYS_FTP_DATA_PORT,self.app.app,self.setChangedHook,self)
  self.strFtpDataPort:=control
  NEW control.createString('HTTP port(s)',SYS_HTTP_PORT,self.app.app,self.setChangedHook,self)
  self.strHttpPort:=control
  NEW control.createString('Execute on new user',SYS_EXEC_ON_NEW_USER,self.app.app,self.setChangedHook,self)
  self.strExecOnNewUser:=control
  NEW control.createString('Execute async on new user',SYS_EXECA_ON_NEW_USER,self.app.app,self.setChangedHook,self)
  self.strExecAOnNewUser:=control
  NEW control.createString('Execute on sysop page',SYS_EXEC_ON_SYSOP_PAGE,self.app.app,self.setChangedHook,self)
  self.strExecOnPage:=control
  NEW control.createString('Execute async on sysop page',SYS_EXECA_ON_SYSOP_PAGE,self.app.app,self.setChangedHook,self)
  self.strExecAOnPage:=control
  NEW control.createString('Execute on connect',SYS_EXEC_ON_CONNECT,self.app.app,self.setChangedHook,self)
  self.strExecOnConnect:=control
  NEW control.createString('Execute async on connect',SYS_EXECA_ON_CONNECT,self.app.app,self.setChangedHook,self)
  self.strExecAOnConnect:=control
  NEW control.createString('Execute on logon',SYS_EXEC_ON_LOGON,self.app.app,self.setChangedHook,self)
  self.strExecOnLogon:=control
  NEW control.createString('Execute async on logon',SYS_EXECA_ON_LOGON,self.app.app,self.setChangedHook,self)
  self.strExecAOnLogon:=control
  NEW control.createString('Execute on logoff',SYS_EXEC_ON_LOGOFF,self.app.app,self.setChangedHook,self)
  self.strExecOnLogoff:=control
  NEW control.createString('Execute async on logoff',SYS_EXECA_ON_LOGOFF,self.app.app,self.setChangedHook,self)
  self.strExecAOnLogoff:=control
  NEW control.createString('Execute on comment',SYS_EXEC_ON_COMMENT,self.app.app,self.setChangedHook,self)
  self.strExecOnComment:=control
  NEW control.createString('Execute async on comment',SYS_EXECA_ON_COMMENT,self.app.app,self.setChangedHook,self)
  self.strExecAOnComment:=control
  NEW control.createString('Execute on upload',SYS_EXEC_ON_UPLOAD,self.app.app,self.setChangedHook,self)
  self.strExecOnUpload:=control
  NEW control.createString('Execute async on upload',SYS_EXECA_ON_UPLOAD,self.app.app,self.setChangedHook,self)
  self.strExecAOnUpload:=control

  self.controlList:=[self.strBBSName,self.strBBSLocation,self.strSysopName,self.strRegKey,self.cyNewAccounts,self.strDefaultMenu,
                    self.paLocalULPath,self.intAutoValPreset,self.intAutoValDelay,self.strAutoValPassword,self.cyLanguage,
                    self.strSmtpHost,self.intSmtpPort,self.strSmtpUsername,self.strSmtpPassword,self.boolSmtpSSL,self.strSysopEmail,
                    self.strBbsEmail,self.boolMailOnPage,self.boolMailOnComment,self.boolMailOnLogon,self.boolMailOnLogoff,self.boolMailOnNewUser,
                    self.boolMailOnUpload,self.boolMailOnPwdFail,self.paLanguageBase,self.paHistory,self.paUserNotes,self.intHoldAccess,
                    self.strFileDizSysCmd,self.strFtpHost,self.strFtpPort,self.strFtpDataPort,self.strHttpPort,self.strExecOnNewUser,
                    self.strExecAOnNewUser,self.strExecOnPage,self.strExecAOnPage,self.strExecOnConnect,self.strExecAOnConnect,
                    self.strExecOnLogon,self.strExecAOnLogon,self.strExecOnLogoff,self.strExecAOnLogoff,
                    self.strExecOnComment,self.strExecAOnComment,self.strExecOnUpload,self.strExecAOnUpload,
                    self.boolCreditByKb,self.boolLongWho,self.boolConvertToMb,self.boolQuietJoin,self.boolRelativeConfs]

  //domethod(self.grpSettings,[MUIM_Group_InitChange])
  ForAll({control},self.controlList,`IF control THEN control.addToGroup(self.grpSettings) ELSE FALSE)
  domethod(self.grpSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpSettings,[OM_ADDMEMBER,HVSpace])
  //domethod(self.grpSettings,[MUIM_Group_ExitChange])
ENDPROC

PROC removeSystemControls() OF frmSettingsEdit
  DEF list:PTR TO lh,state,obj
  DEF control: PTR TO control
  
  //domethod(self.grpSettings,[MUIM_Group_InitChange])
  ForAll({control},self.controlList,`IF control THEN self.freeControl(control) ELSE FALSE)
 
  get(self.grpSettings,MUIA_Group_ChildList,{list})
  state:=list.head
  WHILE (obj:=NextObject({state}))
    domethod(self.grpSettings,[OM_REMMEMBER,obj])
    Mui_DisposeObject(obj)
  ENDWHILE
  //domethod(self.grpSettings,[MUIM_Group_ExitChange])
ENDPROC

PROC addServerControls() OF frmSettingsEdit
  DEF control: PTR TO control
  DEF list:PTR TO stdlist
  DEF sublist:PTR TO control
  DEF tempStr[255]:STRING
  DEF i

  NEW control.createDirSelect('bBBS Path',SYS_BBS_PATH,self.app.app,self.setChangedHook,self)
  self.paBBSPath:=control

  NEW control.createStringInt('Stack size',SYS_STACK,self.app.app,self.setChangedHook,self)
  self.intStack:=control

  NEW control.createStringInt('Priority',SYS_PRIORITY,self.app.app,self.setChangedHook,self)
  self.intPriority:=control

  NEW control.createCheckBox('Start Iconified',SYS_START_ICONIFIED,self.app.app,self.setChangedHook,self)
  self.boolIconified:=control

  NEW control.createStringInt('Iconify Left',SYS_ICONIFY_LEFT,self.app.app,self.setChangedHook,self)
  self.intIconifyLeft:=control

  NEW control.createStringInt('Iconify Top',SYS_ICONIFY_TOP,self.app.app,self.setChangedHook,self)
  self.intIconifyTop:=control
 
  NEW control.createCheckBox('Do not move',SYS_DO_NOT_MOVE,self.app.app,self.setChangedHook,self)
  self.boolDoNotMove:=control

  NEW control.createCheckBox('Multicom port',SYS_MULTICOM,self.app.app,self.setChangedHook,self)
  self.boolMulticom:=control

  NEW control.createCheckBox('AE Shell',SYS_AE_SHELL,self.app.app,self.setChangedHook,self)
  self.boolAEShell:=control

  NEW control.createCheckBox('Disable commodity',SYS_NO_COMMODITY,self.app.app,self.setChangedHook,self)
  self.boolNoCx:=control

  NEW control.createCheckBox('Don''t save state',SYS_DONT_SAVE_STATE,self.app.app,self.setChangedHook,self)
  self.boolNoSaveState:=control

  NEW control.createStringInt('Telnet Port Number',SYS_TELNET_PORT,self.app.app,self.setChangedHook,self)
  self.intTelnetPort:=control

  NEW control.createStringInt('FTP Port Number',SYS_FTP_PORT2,self.app.app,self.setChangedHook,self)
  self.intFtpPort:=control

  NEW control.createString('ACP Font',SYS_ACP_FONT,self.app.app,self.setChangedHook,self)
  self.strAcpFont:=control

  NEW control.createString('Execute on startup',SYS_EXEC_ON_STARTUP,self.app.app,self.setChangedHook,self)
  self.strExecOnStart:=control

  NEW control.createStringInt('DOS check time',SYS_DOS_CHECK_TIME,self.app.app,self.setChangedHook,self)
  self.intDosCheckTime:=control

  NEW control.createStringInt('DOS ban time',SYS_DOS_BAN_TIME,self.app.app,self.setChangedHook,self)
  self.intDosBanTime:=control

  NEW control.createStringInt('DOS check trigger',SYS_DOS_CHECK_TRIGGER,self.app.app,self.setChangedHook,self)
  self.intDosCheckTrig:=control

  NEW list.stdlist(self.nodeCount)
  self.nodeLocs:=list
  
  NEW list.stdlist(self.nodeCount)
  self.nodeNames:=list

  NEW list.stdlist(self.nodeCount)
  self.nodeSysops:=list

  NEW list.stdlist(15)
  self.buttonNames:=list

  NEW list.stdlist(15)
  self.buttonCommands:=list

  NEW list.stdlist(15)
  self.nuttonNames:=list

  NEW list.stdlist(15)
  self.nuttonCommands:=list

  FOR i:=0 TO self.nodeCount-1
    StringF(tempStr,'Node \d Location',i)
    NEW control.createString(tempStr,SYS_NODE_X_LOC,self.app.app,self.setChangedHook,self)
    self.nodeLocs.add(control)
    StringF(tempStr,'Node \d Name',i)
    NEW control.createString(tempStr,SYS_NODE_X_NAME,self.app.app,self.setChangedHook,self)
    self.nodeNames.add(control)
    StringF(tempStr,'Node \d Sysop',i)
    NEW control.createString(tempStr,SYS_NODE_X_SYSOP,self.app.app,self.setChangedHook,self)
    self.nodeSysops.add(control)
  ENDFOR
  
  FOR i:=1 TO 15
    StringF(tempStr,'Button \d Name',i)
    NEW control.createString(tempStr,SYS_BUTTON_NAME,self.app.app,self.setChangedHook,self)
    self.buttonNames.add(control)
    StringF(tempStr,'Button \d Command',i)
    NEW control.createString(tempStr,SYS_BUTTON_COMMAND,self.app.app,self.setChangedHook,self)
    self.buttonCommands.add(control)

    StringF(tempStr,'Nutton \d Name',i)
    NEW control.createString(tempStr,SYS_NUTTON_NAME,self.app.app,self.setChangedHook,self)
    self.nuttonNames.add(control)
    StringF(tempStr,'Nutton \d Command',i)
    NEW control.createString(tempStr,SYS_NUTTON_COMMAND,self.app.app,self.setChangedHook,self)
    self.nuttonCommands.add(control)
  ENDFOR

  self.controlList:=[self.paBBSPath,self.intStack,self.intPriority,self.intTelnetPort,self.intFtpPort,
                     self.boolIconified,self.intIconifyLeft,self.intIconifyTop,self.strAcpFont,self.strExecOnStart,
                     self.intDosCheckTime,self.intDosBanTime,self.intDosCheckTrig,self.boolDoNotMove,
                     self.boolMulticom,self.boolAEShell,self.boolNoCx,self.boolNoSaveState]

  domethod(self.grpSettings,[MUIM_Group_InitChange])

  sublist:=[self.paBBSPath,self.intStack,self.intPriority,self.intTelnetPort,self.intFtpPort,
                     self.boolIconified,self.intIconifyLeft,self.intIconifyTop,self.strAcpFont,self.strExecOnStart,
                     self.intDosCheckTime,self.intDosBanTime,self.intDosCheckTrig]

  ForAll({control},sublist,`control.addToGroup(self.grpSettings)) 

  FOR i:=0 TO self.nodeCount-1
    control:=self.nodeLocs.item(i)
    control.addToGroup(self.grpSettings)
    control:=self.nodeNames.item(i)
    control.addToGroup(self.grpSettings)
    control:=self.nodeSysops.item(i)
    control.addToGroup(self.grpSettings)
  ENDFOR
  
  FOR i:=0 TO 14
    control:=self.buttonNames.item(i)
    control.addToGroup(self.grpSettings)
    control:=self.buttonCommands.item(i)
    control.addToGroup(self.grpSettings)
  ENDFOR

  FOR i:=0 TO 14
    control:=self.nuttonNames.item(i)
    control.addToGroup(self.grpSettings)
    control:=self.nuttonCommands.item(i)
    control.addToGroup(self.grpSettings)
  ENDFOR
  
  sublist:=[self.boolDoNotMove,self.boolMulticom,self.boolAEShell,self.boolNoCx,self.boolNoSaveState]
  ForAll({control},sublist,`control.addToGroup(self.grpSettings)) 


  domethod(self.grpSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpSettings,[MUIM_Group_ExitChange])
ENDPROC

PROC removeServerControls() OF frmSettingsEdit
  DEF list:PTR TO lh,state,obj,i
  DEF control: PTR TO control
  
  domethod(self.grpSettings,[MUIM_Group_InitChange])
  ForAll({control},self.controlList,`self.freeControl(control))

  FOR i:=0 TO self.nodeCount-1
    control:=self.nodeLocs.item(i)
    self.freeControl(control)
    control:=self.nodeNames.item(i)
    self.freeControl(control)
    control:=self.nodeSysops.item(i)
    self.freeControl(control)
  ENDFOR

  FOR i:=0 TO 14
    control:=self.buttonNames.item(i)
    self.freeControl(control)
    control:=self.buttonCommands.item(i)
    self.freeControl(control)
    control:=self.nuttonNames.item(i)
    self.freeControl(control)
    control:=self.nuttonCommands.item(i)
    self.freeControl(control)
  ENDFOR

  END self.nodeLocs
  END self.nodeNames
  END self.nodeSysops
  END self.buttonNames
  END self.buttonCommands
  END self.nuttonNames
  END self.nuttonCommands

  get(self.grpSettings,MUIA_Group_ChildList,{list})
  state:=list.head
  WHILE (obj:=NextObject({state}))
    domethod(self.grpSettings,[OM_REMMEMBER,obj])
    Mui_DisposeObject(obj)
  ENDWHILE
  domethod(self.grpSettings,[MUIM_Group_ExitChange])
ENDPROC

PROC addZoomControls() OF frmSettingsEdit
  DEF control: PTR TO control

  NEW control.createString('BBS Number',SYS_QWK_BBS_NUMBER,self.app.app,self.setChangedHook,self)
  self.strBbsNumber:=control
  NEW control.createString('BBS Address',SYS_QWK_BBS_ADDRESS,self.app.app,self.setChangedHook,self)
  self.strBbsAddress:=control
  NEW control.createString('BBS ID',SYS_QWK_BBS_ID,self.app.app,self.setChangedHook,self)
  self.strBbsId:=control
  NEW control.createString('QWK Zip command',SYS_QWK_ZIP_COMMAND,self.app.app,self.setChangedHook,self)
  self.strQwkZip:=control
  NEW control.createString('QWK LHA command',SYS_QWK_LHA_COMMAND,self.app.app,self.setChangedHook,self)
  self.strQwkLha:=control
  NEW control.createString('ASCII Zip command',SYS_ASC_ZIP_COMMAND,self.app.app,self.setChangedHook,self)
  self.strAscZip:=control
  NEW control.createString('ASCII LHA command',SYS_ASC_LHA_COMMAND,self.app.app,self.setChangedHook,self)
  self.strAscLha:=control

  self.controlList:=[self.strBbsNumber,self.strBbsAddress,self.strBbsId, self.strQwkZip, self.strQwkLha, self.strAscZip, self.strAscLha]

  domethod(self.grpSettings,[MUIM_Group_InitChange])
  ForAll({control},self.controlList,`control.addToGroup(self.grpSettings)) 
  domethod(self.grpSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpSettings,[MUIM_Group_ExitChange])
ENDPROC

PROC removeZoomControls() OF frmSettingsEdit
  DEF list:PTR TO lh,state,obj
  DEF control: PTR TO control
  
  domethod(self.grpSettings,[MUIM_Group_InitChange])
  ForAll({control},self.controlList,`self.freeControl(control))

  get(self.grpSettings,MUIA_Group_ChildList,{list})
  state:=list.head
  WHILE (obj:=NextObject({state}))
    domethod(self.grpSettings,[OM_REMMEMBER,obj])
    Mui_DisposeObject(obj)
  ENDWHILE
  domethod(self.grpSettings,[MUIM_Group_ExitChange])
ENDPROC

PROC canClose() OF frmSettingsEdit
  MOVE.L (A1),self
  GetA4()
  IF self.changed
    IF self.unsavedChangesWarning()=0 THEN RETURN FALSE
  ENDIF
ENDPROC TRUE

PROC unsavedChangesWarning() OF frmSettingsEdit
  DEF win
  get(self.winMain,MUIA_Window_Window,{win})
  IF EasyRequestArgs(	win , [ 20 , 0 ,
									'Unsaved changes' ,
									'You have unsaved changes,\nif you continue you will lose them.',
									'_OK|_CANCEL' ] , NIL , NIL )=0 THEN RETURN FALSE
ENDPROC TRUE

PROC saveSystemChanges() OF frmSettingsEdit
  DEF tempStr[255]:STRING
  DEF win
  
  MOVE.L (A1),self
  GetA4()

  get(self.winMain,MUIA_Window_Window,{win})

  fullTrim(self.strBBSName.getValue(),tempStr)
  IF EstrLen(tempStr)=0
    EasyRequestArgs(  win , [ 20 , 0 ,
                  'Error' ,
                  'BBS Name is a mandatory field',
                  '_OK' ] , NIL , NIL )
    RETURN
  ENDIF

  fullTrim(self.strBBSLocation.getValue(),tempStr)
  IF EstrLen(tempStr)=0
    EasyRequestArgs(  win , [ 20 , 0 ,
                  'Error' ,
                  'BBS Location is a mandatory field',
                  '_OK' ] , NIL , NIL )
    RETURN
  ENDIF

  fullTrim(self.strSysopName.getValue(),tempStr)
  IF EstrLen(tempStr)=0
    EasyRequestArgs(  win , [ 20 , 0 ,
                  'Error' ,
                  'Sysop Name is a mandatory field',
                  '_OK' ] , NIL , NIL )
    RETURN
  ENDIF

  self.sleep()
  writeToolType(self.acpName,'BBS_NAME',self.strBBSName.getValue())
  writeToolType(self.acpName,'BBS_GEOGRAPHIC',self.strBBSLocation.getValue())
  writeToolType(self.acpName,'SYSOP_NAME',self.strSysopName.getValue())
  IF self.cyNewAccounts.getValueIndex()=0 THEN writeToolType(self.acpName,'NEW_ACCOUNTS','APPEND') ELSE deleteToolType(self.acpName,'NEW_ACCOUNTS')
  writeToolType(self.bbsConfigName,'REGKEY',self.strRegKey.getValue())
  writeToolType(self.bbsConfigName,'DEFAULT_MENUNAME',self.strDefaultMenu.getValue())
  writeToolType(self.bbsConfigName,'LOCAL_UPLOAD_PATH',self.paLocalULPath.getValue())
  writeToolType(self.bbsConfigName,'AUTOVAL_PRESET',self.intAutoValPreset.getValue())
  writeToolType(self.bbsConfigName,'AUTOVAL_DELAY',self.intAutoValDelay.getValue())
  writeToolType(self.acpName,'AUTOVAL_PASSWORD',self.strAutoValPassword.getValue())
  
  IF self.cyLanguage
    writeToolType(self.languagesConfigName,'HOSTLANGUAGE',self.languages[self.cyLanguage.getValueIndex()])
  ENDIF

  IF self.boolCreditByKb.getValue() THEN writeToolType(self.acpName,'CREDIT_BY_KBYTES') ELSE deleteToolType(self.acpName,'CREDIT_BY_KBYTES')
  IF self.boolLongWho.getValue() THEN writeToolType(self.acpName,'LONG_WHO') ELSE deleteToolType(self.acpName,'LONG_WHO')
  IF self.boolConvertToMb.getValue() THEN writeToolType(self.bbsConfigName,'CONVERT_TO_MB') ELSE deleteToolType(self.bbsConfigName,'CONVERT_TO_MB')
  IF self.boolTimeoutLc.getValueIndex() THEN deleteToolType(self.bbsConfigName,'TIMEOUT_LC') ELSE writeToolType(self.bbsConfigName,'TIMEOUT_LC')
  IF self.boolQuietJoin.getValue() THEN writeToolType(self.bbsConfigName,'QUIET_JOIN') ELSE deleteToolType(self.bbsConfigName,'QUIET_JOIN')
  IF self.boolRelativeConfs.getValue() THEN writeToolType(self.bbsConfigName,'RELATIVE_CONFERENCES') ELSE deleteToolType(self.bbsConfigName,'RELATIVE_CONFERENCES')

  writeToolType(self.bbsConfigName,'SMTP_HOST',self.strSmtpHost.getValue())
  writeToolType(self.bbsConfigName,'SMTP_PORT',self.intSmtpPort.getValue())
  writeToolType(self.bbsConfigName,'SMTP_USERNAME',self.strSmtpUsername.getValue())
  writeToolType(self.bbsConfigName,'SMTP_PASSWORD',self.strSmtpPassword.getValue())
  IF self.boolSmtpSSL.getValue() THEN writeToolType(self.bbsConfigName,'SMTP_SSL') ELSE deleteToolType(self.bbsConfigName,'SMTP_SSL')
  writeToolType(self.bbsConfigName,'SYSOP_EMAIL',self.strSysopEmail.getValue())
  writeToolType(self.bbsConfigName,'BBS_EMAIL',self.strBbsEmail.getValue())
  IF self.boolMailOnPage.getValue() THEN writeToolType(self.bbsConfigName,'MAIL_ON_SYSOP_PAGE') ELSE deleteToolType(self.bbsConfigName,'MAIL_ON_SYSOP_PAGE')
  IF self.boolMailOnComment.getValue() THEN writeToolType(self.bbsConfigName,'MAIL_ON_SYSOP_COMMENT') ELSE deleteToolType(self.bbsConfigName,'MAIL_ON_SYSOP_COMMENT')
  IF self.boolMailOnLogon.getValue() THEN writeToolType(self.bbsConfigName,'MAIL_ON_LOGON') ELSE deleteToolType(self.bbsConfigName,'MAIL_ON_LOGON')
  IF self.boolMailOnLogoff.getValue() THEN writeToolType(self.bbsConfigName,'MAIL_ON_LOGOFF') ELSE deleteToolType(self.bbsConfigName,'MAIL_ON_LOGOFF')
  IF self.boolMailOnNewUser.getValue() THEN writeToolType(self.bbsConfigName,'MAIL_ON_NEW_USER') ELSE deleteToolType(self.bbsConfigName,'MAIL_ON_NEW_USER')
  IF self.boolMailOnUpload.getValue() THEN writeToolType(self.bbsConfigName,'MAIL_ON_UPLOAD') ELSE deleteToolType(self.bbsConfigName,'MAIL_ON_UPLOAD')
  IF self.boolMailOnPwdFail.getValue() THEN writeToolType(self.bbsConfigName,'MAIL_ON_PWD_FAIL') ELSE deleteToolType(self.bbsConfigName,'MAIL_ON_PWD_FAIL')

  writeToolType(self.bbsConfigName,'LANGUAGE_BASE',self.paLanguageBase.getValue())
  writeToolType(self.bbsConfigName,'HISTORY',self.paHistory.getValue())
  writeToolType(self.bbsConfigName,'USERNOTES',self.paUserNotes.getValue())
  writeToolType(self.bbsConfigName,'HOLD_ACCESS_LEVEL',self.intHoldAccess.getValue())
  writeToolType(self.bbsConfigName,'FILEDIZ_SYSCMD',self.strFileDizSysCmd.getValue())
  writeToolType(self.bbsConfigName,'FTPHOST',self.strFtpHost.getValue())
  writeToolType(self.bbsConfigName,'FTPPORT',self.strFtpPort.getValue())
  writeToolType(self.bbsConfigName,'FTPDATAPORT',self.strFtpDataPort.getValue())
  writeToolType(self.bbsConfigName,'HTTPPORT',self.strHttpPort.getValue()) 
  writeToolType(self.bbsConfigName,'EXECUTE_ON_NEW_USER',self.strExecOnNewUser.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_NEW_USER',self.strExecAOnNewUser.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ON_SYSOP_PAGE',self.strExecOnPage.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_SYSOP_PAGE',self.strExecAOnPage.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ON_CONNECT',self.strExecOnConnect.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ON_CONNECT_ASYNC',self.strExecAOnConnect.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ON_LOGON',self.strExecOnLogon.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_LOGON',self.strExecAOnLogon.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ON_LOGOFF',self.strExecOnLogoff.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_LOGOFF',self.strExecAOnLogoff.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ON_SYSOP_COMMENT',self.strExecOnComment.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_SYSOP_COMMENT',self.strExecAOnComment.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ON_UPLOAD',self.strExecOnUpload.getValue())
  writeToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_UPLOAD',self.strExecAOnUpload.getValue())
  saveCachedChanges()

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC saveServerChanges() OF frmSettingsEdit
  DEF tempStr[255]:STRING
  DEF win,i
  DEF control:PTR TO control
  DEF toolName[255]:STRING

  MOVE.L (A1),self
  GetA4()

  get(self.winMain,MUIA_Window_Window,{win})

  fullTrim(self.paBBSPath.getValue(),tempStr)
  IF EstrLen(tempStr)=0
    EasyRequestArgs(  win , [ 20 , 0 ,
                  'Error' ,
                  'BBS Path is a mandatory field',
                  '_OK' ] , NIL , NIL )
    RETURN
  ENDIF

  self.sleep()
  writeToolType(self.acpName,'BBS_LOCATION',self.paBBSPath.getValue())
  writeToolType(self.acpName,'BBS_STACK',self.intStack.getValue())
  writeToolType(self.acpName,'PRIORITY',self.intPriority.getValue())
  IF self.boolIconified.getValue() THEN writeToolType(self.acpName,'ICONIFIED') ELSE deleteToolType(self.acpName,'ICONIFIED')
  writeToolType(self.acpName,'ICONIFY.LEFTEDGE',self.intIconifyLeft.getValue())
  writeToolType(self.acpName,'ICONIFY.TOPEDGE',self.intIconifyTop.getValue())
  IF self.boolDoNotMove.getValue() THEN writeToolType(self.acpName,'SHORT_DONOTMOVE') ELSE deleteToolType(self.acpName,'SHORT_DONOTMOVE')
  IF self.boolMulticom.getValue() THEN writeToolType(self.acpName,'MULTICOM_PORT') ELSE deleteToolType(self.acpName,'MULTICOM_PORT')
  IF self.boolAEShell.getValue() THEN writeToolType(self.acpName,'AESHELL') ELSE deleteToolType(self.acpName,'AESHELL')
  IF self.boolNoCx.getValue() THEN writeToolType(self.acpName,'NO_CX') ELSE deleteToolType(self.acpName,'NO_CX')
  IF self.boolNoSaveState.getValue() THEN writeToolType(self.acpName,'NO_SAVESTATE') ELSE deleteToolType(self.acpName,'NO_SAVESTATE')
  writeToolType(self.acpName,'TELNETPORT',self.intTelnetPort.getValue())
  writeToolType(self.acpName,'FTPPORT',self.intFtpPort.getValue())

  writeToolType(self.acpName,'ACPFONT',self.strAcpFont.getValue())
  writeToolType(self.acpName,'EXECUTE_ON_STARTUP_COMPLETE',self.strExecOnStart.getValue())
  writeToolType(self.acpName,'DOSCHECKTIME',self.intDosCheckTime.getValue())
  writeToolType(self.acpName,'DOSBANTIME',self.intDosBanTime.getValue())
  writeToolType(self.acpName,'DOSCHECKTRIGGER',self.intDosCheckTrig.getValue())
  
  FOR i:=0 TO self.nodeCount-1
    control:=self.nodeLocs.item(i)
    StringF(toolName,'NODE\d_LOCATION',i)
    writeToolType(self.acpName,toolName,control.getValue())

    control:=self.nodeNames.item(i)
    StringF(toolName,'NODE\d_NAME',i)
    writeToolType(self.acpName,toolName,control.getValue())

    control:=self.nodeSysops.item(i)
    StringF(toolName,'NODE\d_SYSOP',i)
    writeToolType(self.acpName,toolName,control.getValue())
  ENDFOR
  
  FOR i:=0 TO 14
    control:=self.buttonNames.item(i)
    StringF(toolName,'BUTTON_NAME.\d',i)
    writeToolType(self.acpName,toolName,control.getValue())

    control:=self.buttonCommands.item(i)
    StringF(toolName,'BUTTON_COMMAND.\d',i)
    writeToolType(self.acpName,toolName,control.getValue())

    control:=self.nuttonNames.item(i)
    StringF(toolName,'NUTTON_NAME.\d',i)
    writeToolType(self.acpName,toolName,control.getValue())

    control:=self.nuttonCommands.item(i)
    StringF(toolName,'NUTTON_COMMAND.\d',i)
    writeToolType(self.acpName,toolName,control.getValue())
  ENDFOR
  saveCachedChanges()

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC saveZoomChanges() OF frmSettingsEdit
  DEF tempStr[255]:STRING
  DEF zoomToolType[255]:STRING

  MOVE.L (A1),self
  GetA4()

  self.sleep()

  StrCopy(zoomToolType,self.zoomDirPath)
  AddPart(zoomToolType,'qwkcfg',255)
  writeToolType(zoomToolType,'BBS.NUMBER',self.strBbsNumber.getValue())
  writeToolType(zoomToolType,'BBS.ADDRESS',self.strBbsAddress.getValue())
  writeToolType(zoomToolType,'BBS.ID',self.strBbsId.getValue())

  StrCopy(zoomToolType,self.zoomDirPath)
  AddPart(zoomToolType,'qwkpack',255)
  writeToolType(zoomToolType,'ZIP',self.strQwkZip.getValue())
  writeToolType(zoomToolType,'LHA',self.strQwkLha.getValue())
  
  StrCopy(zoomToolType,self.zoomDirPath)
  AddPart(zoomToolType,'ascpack',255)
  writeToolType(zoomToolType,'ZIP',self.strAscZip.getValue())
  writeToolType(zoomToolType,'LHA',self.strAscLha.getValue())
  saveCachedChanges()

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC editSystemSettings(acpName:PTR TO CHAR) OF frmSettingsEdit
  DEF loop,val,count,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF bbsPath[200]:STRING
  DEF languagesTooltype[255]:STRING
  DEF languages:PTR TO stringlist


  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook

  NEW saveHook
  installhook( saveHook, {saveSystemChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.acpName:=acpName
  self.bbsConfigName:=String(255)

  readToolType(self.acpName,'BBS_LOCATION',bbsPath)
  StringF(self.bbsConfigName,'\sBBSCONFIG',bbsPath)
  
  StringF(languagesTooltype,'\sLanguages',bbsPath)
  NEW languages.stringlist(20)

  loop:=TRUE
  count:=0
  WHILE (loop)
    StringF(temppath,'LANGUAGE.\d',count+1)
    readToolType(languagesTooltype,temppath,tempstr)
    IF StrLen(tempstr)>0
      languages.add(tempstr)
      count++   
    ELSE
      loop:=FALSE
    ENDIF
  ENDWHILE
  
  self.languages:=List(count+1)
  FOR count:=0 TO languages.count()-1 DO ListAddItem(self.languages,languages.item(count))
  ListAddItem(self.languages,0)
  
  self.languagesConfigName:=languagesTooltype
  
  installhook( self.setChangedHook, {setChangedFlag})    
  self.addSystemControls()
  self.addNotifications()
 
  set( self.winMain, MUIA_Window_Title,'Edit System Settings')
  set( self.winMain, MUIA_Window_ID, "FSYS")

  readToolType(self.acpName,'BBS_NAME',tempstr)
  self.strBBSName.setValue(tempstr)

  readToolType(self.acpName,'BBS_GEOGRAPHIC',tempstr)
  self.strBBSLocation.setValue(tempstr)
  
  readToolType(self.acpName,'SYSOP_NAME',tempstr)
  self.strSysopName.setValue(tempstr)

  readToolType(self.acpName,'NEW_ACCOUNTS',tempstr)
  self.cyNewAccounts.setValueIndex(IF StriCmp(tempstr,'APPEND') THEN 0 ELSE 1)

  readToolType(self.bbsConfigName,'REGKEY',tempstr)
  self.strRegKey.setValue(tempstr)

  readToolType(self.bbsConfigName,'DEFAULT_MENUNAME',tempstr)
  self.strDefaultMenu.setValue(tempstr)

  readToolType(self.bbsConfigName,'LOCAL_UPLOAD_PATH',tempstr)
  self.paLocalULPath.setValue(tempstr)

  val:=readToolTypeInt(self.bbsConfigName,'AUTOVAL_PRESET')
  self.intAutoValPreset.setValue(val)

  val:=readToolTypeInt(self.bbsConfigName,'AUTOVAL_DELAY')
  self.intAutoValDelay.setValue(val)

  readToolType(self.acpName,'AUTOVAL_PASSWORD',tempstr)
  self.strAutoValPassword.setValue(tempstr)
  
  IF languages.count()
    readToolType(languagesTooltype,'HOSTLANGUAGE',tempstr)
    FOR count:=0 TO languages.count()-1 
      IF StriCmp(languages.item(count),tempstr) THEN  self.cyLanguage.setValueIndex(count)
    ENDFOR
  ENDIF

  self.boolCreditByKb.setValue(IF checkToolTypeExists(self.acpName,'CREDIT_BY_KBYTES') THEN MUI_TRUE ELSE FALSE)
  self.boolLongWho.setValue(IF checkToolTypeExists(self.acpName,'LONG_WHO') THEN MUI_TRUE ELSE FALSE)
  self.boolConvertToMb.setValue(IF checkToolTypeExists(self.bbsConfigName,'CONVERT_TO_MB') THEN MUI_TRUE ELSE FALSE)
  self.boolTimeoutLc.setValueIndex(IF checkToolTypeExists(self.bbsConfigName,'TIMEOUT_LC') THEN 0 ELSE 1)
  self.boolQuietJoin.setValue(IF checkToolTypeExists(self.bbsConfigName,'QUIET_JOIN') THEN MUI_TRUE ELSE FALSE)
  self.boolRelativeConfs.setValue(IF checkToolTypeExists(self.bbsConfigName,'RELATIVE_CONFERENCES') THEN MUI_TRUE ELSE FALSE)

  readToolType(self.bbsConfigName,'SMTP_HOST',tempstr)
  self.strSmtpHost.setValue(tempstr)
  val:=readToolTypeInt(self.bbsConfigName,'SMTP_PORT')
  self.intSmtpPort.setValue(val)
  readToolType(self.bbsConfigName,'SMTP_USERNAME',tempstr)
  self.strSmtpUsername.setValue(tempstr)
  readToolType(self.bbsConfigName,'SMTP_PASSWORD',tempstr)
  self.strSmtpPassword.setValue(tempstr)
  self.boolSmtpSSL.setValue(IF checkToolTypeExists(self.bbsConfigName,'SMTP_SSL') THEN MUI_TRUE ELSE FALSE)
  readToolType(self.bbsConfigName,'SYSOP_EMAIL',tempstr)
  self.strSysopEmail.setValue(tempstr)
  readToolType(self.bbsConfigName,'BBS_EMAIL',tempstr)
  self.strBbsEmail.setValue(tempstr)
  self.boolMailOnPage.setValue(IF checkToolTypeExists(self.bbsConfigName,'MAIL_ON_SYSOP_PAGE') THEN MUI_TRUE ELSE FALSE)
  self.boolMailOnComment.setValue(IF checkToolTypeExists(self.bbsConfigName,'MAIL_ON_SYSOP_COMMENT') THEN MUI_TRUE ELSE FALSE)
  self.boolMailOnLogon.setValue(IF checkToolTypeExists(self.bbsConfigName,'MAIL_ON_LOGON') THEN MUI_TRUE ELSE FALSE)
  self.boolMailOnLogoff.setValue(IF checkToolTypeExists(self.bbsConfigName,'MAIL_ON_LOGOFF') THEN MUI_TRUE ELSE FALSE)
  self.boolMailOnNewUser.setValue(IF checkToolTypeExists(self.bbsConfigName,'MAIL_ON_NEW_USER') THEN MUI_TRUE ELSE FALSE)
  self.boolMailOnUpload.setValue(IF checkToolTypeExists(self.bbsConfigName,'MAIL_ON_UPLOAD') THEN MUI_TRUE ELSE FALSE)
  self.boolMailOnPwdFail.setValue(IF checkToolTypeExists(self.bbsConfigName,'MAIL_ON_PWD_FAIL') THEN MUI_TRUE ELSE FALSE)
  readToolType(self.bbsConfigName,'LANGUAGE_BASE',tempstr)
  self.paLanguageBase.setValue(tempstr)
  readToolType(self.bbsConfigName,'HISTORY',tempstr)
  self.paHistory.setValue(tempstr)
  readToolType(self.bbsConfigName,'USERNOTES',tempstr)
  self.paUserNotes.setValue(tempstr)
  val:=readToolTypeInt(self.bbsConfigName,'HOLD_ACCESS_LEVEL')
  self.intHoldAccess.setValue(val)
  readToolType(self.bbsConfigName,'FILEDIZ_SYSCMD',tempstr)
  self.strFileDizSysCmd.setValue(tempstr)
  readToolType(self.bbsConfigName,'FTPHOST',tempstr)
  self.strFtpHost.setValue(tempstr)
  readToolType(self.bbsConfigName,'FTPPORT',tempstr)
  self.strFtpPort.setValue(tempstr)
  readToolType(self.bbsConfigName,'FTPDATAPORT',tempstr)
  self.strFtpDataPort.setValue(tempstr)
  readToolType(self.bbsConfigName,'HTTPPORT',tempstr)
  self.strHttpPort.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ON_NEW_USER',tempstr)
  self.strExecOnNewUser.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_NEW_USER',tempstr)
  self.strExecAOnNewUser.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ON_SYSOP_PAGE',tempstr)
  self.strExecOnPage.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_SYSOP_PAGE',tempstr)
  self.strExecAOnPage.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ON_CONNECT',tempstr)
  self.strExecOnConnect.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ON_CONNECT_ASYNC',tempstr)
  self.strExecAOnConnect.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ON_LOGON',tempstr)
  self.strExecOnLogon.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_LOGON',tempstr)
  self.strExecAOnLogon.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ON_LOGOFF',tempstr)
  self.strExecOnLogoff.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_LOGOFF',tempstr)
  self.strExecAOnLogoff.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ON_SYSOP_COMMENT',tempstr)
  self.strExecOnComment.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_SYSOP_COMMENT',tempstr)
  self.strExecAOnComment.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ON_UPLOAD',tempstr)
  self.strExecOnUpload.setValue(tempstr)
  readToolType(self.bbsConfigName,'EXECUTE_ASYNC_ON_UPLOAD',tempstr)
  self.strExecAOnUpload.setValue(tempstr)

  self.changed:=FALSE
  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  self.showModal()

  self.removeNotifications()
  self.removeSystemControls()
  END saveHook
  END closeHook
  END languages
  DisposeLink(self.languages)
  DisposeLink(self.bbsConfigName)
ENDPROC

PROC editServerSettings(acpName:PTR TO CHAR) OF frmSettingsEdit
  DEF count,val,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF control:PTR TO control
  DEF toolName[255]:STRING

  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook

  NEW saveHook
  installhook( saveHook, {saveServerChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.acpName:=acpName
  self.nodeCount:=readToolTypeInt(self.acpName,'NODES')

  installhook( self.setChangedHook, {setChangedFlag})    
  self.addServerControls()
  self.addNotifications()
 
  set( self.winMain, MUIA_Window_Title,'Edit Server Settings')
  set( self.winMain, MUIA_Window_ID, "FSER")

  readToolType(self.acpName,'BBS_LOCATION',tempstr)
  self.paBBSPath.setValue(tempstr)

  val:=readToolTypeInt(self.acpName,'BBS_STACK')
  self.intStack.setValue(val)

  val:=readToolTypeInt(self.acpName,'PRIORITY')
  self.intPriority.setValue(val)

  self.boolIconified.setValue(IF checkToolTypeExists(self.acpName,'ICONIFIED') THEN MUI_TRUE ELSE FALSE)

  val:=readToolTypeInt(self.acpName,'ICONIFY.LEFTEDGE')
  self.intIconifyLeft.setValue(val)

  val:=readToolTypeInt(self.acpName,'ICONIFY.TOPEDGE')
  self.intIconifyTop.setValue(val)

  self.boolDoNotMove.setValue(IF checkToolTypeExists(self.acpName,'SHORT_DONOTMOVE') THEN MUI_TRUE ELSE FALSE)
  self.boolMulticom.setValue(IF checkToolTypeExists(self.acpName,'MULTICOM_PORT') THEN MUI_TRUE ELSE FALSE)

  self.boolAEShell.setValue(IF checkToolTypeExists(self.acpName,'AESHELL') THEN MUI_TRUE ELSE FALSE)
  self.boolNoCx.setValue(IF checkToolTypeExists(self.acpName,'NO_CX') THEN MUI_TRUE ELSE FALSE)
  self.boolNoSaveState.setValue(IF checkToolTypeExists(self.acpName,'NO_SAVESTATE') THEN MUI_TRUE ELSE FALSE)

  val:=readToolTypeInt(self.acpName,'TELNETPORT')
  self.intTelnetPort.setValue(val)

  val:=readToolTypeInt(self.acpName,'FTPPORT')
  self.intFtpPort.setValue(val)

  readToolType(self.acpName,'ACPFONT',tempstr)
  self.strAcpFont.setValue(tempstr)

  readToolType(self.acpName,'EXECUTE_ON_STARTUP_COMPLETE',tempstr)
  self.strExecOnStart.setValue(tempstr)

  val:=readToolTypeInt(self.acpName,'DOSCHECKTIME')
  self.intDosCheckTime.setValue(val)

  val:=readToolTypeInt(self.acpName,'DOSBANTIME')
  self.intDosBanTime.setValue(val)


  val:=readToolTypeInt(self.acpName,'DOSCHECKTRIGGER')
  self.intDosCheckTrig.setValue(val)
  
  FOR i:=0 TO self.nodeCount-1
    control:=self.nodeLocs.item(i)
    StringF(toolName,'NODE\d_LOCATION',i)
    readToolType(self.acpName,toolName,tempstr)
    control.setValue(tempstr)

    control:=self.nodeNames.item(i)
    StringF(toolName,'NODE\d_NAME',i)
    readToolType(self.acpName,toolName,tempstr)
    control.setValue(tempstr)

    control:=self.nodeSysops.item(i)
    StringF(toolName,'NODE\d_SYSOP',i)
    readToolType(self.acpName,toolName,tempstr)
    control.setValue(tempstr)
  ENDFOR
  
  FOR i:=0 TO 14
    control:=self.buttonNames.item(i)
    StringF(toolName,'BUTTON_NAME.\d',i)
    readToolType(self.acpName,toolName,tempstr)
    control.setValue(tempstr)

    control:=self.buttonCommands.item(i)
    StringF(toolName,'BUTTON_COMMAND.\d',i)
    readToolType(self.acpName,toolName,tempstr)
    control.setValue(tempstr)

    control:=self.nuttonNames.item(i)
    StringF(toolName,'NUTTON_NAME.\d',i)
    readToolType(self.acpName,toolName,tempstr)
    control.setValue(tempstr)

    control:=self.nuttonCommands.item(i)
    StringF(toolName,'NUTTON_COMMAND.\d',i)
    readToolType(self.acpName,toolName,tempstr)
    control.setValue(tempstr)
  ENDFOR

  self.changed:=FALSE
  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  self.showModal()
  self.removeNotifications()
  self.removeServerControls()
  END saveHook
  END closeHook
ENDPROC

PROC editZoomSettings(acpName:PTR TO CHAR) OF frmSettingsEdit
  DEF count,val,i,entry,temppath[255]:STRING,tempStr[255]:STRING
  DEF zoomToolType[255]:STRING

  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook

  NEW saveHook
  installhook( saveHook, {saveZoomChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.acpName:=acpName
  self.zoomDirPath:=String(255)

  installhook( self.setChangedHook, {setChangedFlag})    
  self.addZoomControls()
  self.addNotifications()
 
  set( self.winMain, MUIA_Window_Title,'Edit Zoom Settings')
  set( self.winMain, MUIA_Window_ID, "FZOM")

  readToolType(self.acpName,'BBS_LOCATION',self.zoomDirPath)
  AddPart(self.zoomDirPath,'Zoom',255)
  SetStr(self.zoomDirPath)
  
  StrCopy(zoomToolType,self.zoomDirPath)
  AddPart(zoomToolType,'qwkcfg',255)
  readToolType(zoomToolType,'BBS.NUMBER',tempStr)
  self.strBbsNumber.setValue(tempStr)
  
  readToolType(zoomToolType,'BBS.ADDRESS',tempStr)
  self.strBbsAddress.setValue(tempStr)
  readToolType(zoomToolType,'BBS.ID',tempStr)
  self.strBbsId.setValue(tempStr)

  StrCopy(zoomToolType,self.zoomDirPath)
  AddPart(zoomToolType,'qwkpack',255)
  readToolType(zoomToolType,'ZIP',tempStr)
  self.strQwkZip.setValue(tempStr)
  readToolType(zoomToolType,'LHA',tempStr)
  self.strQwkLha.setValue(tempStr)
  
  StrCopy(zoomToolType,self.zoomDirPath)
  AddPart(zoomToolType,'ascpack',255)
  readToolType(zoomToolType,'ZIP',tempStr)
  self.strAscZip.setValue(tempStr)
  readToolType(zoomToolType,'LHA',tempStr)
  self.strAscLha.setValue(tempStr)

  self.changed:=FALSE
  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  self.showModal()
  self.removeNotifications()
  self.removeZoomControls()
  END saveHook
  END closeHook
  DisposeLink(self.zoomDirPath)
ENDPROC
