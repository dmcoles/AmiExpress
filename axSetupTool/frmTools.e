OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui','exec/ports','exec/nodes','amigalib/ports'
MODULE 'tools/boopsi','workbench/workbench','icon','intuition/classusr'
MODULE 'utility/tagitem','utility/hooks','tools/installhook','exec/lists'
MODULE '*axedit','*frmBase','*tooltypes'

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
  myCmds:LONG
  sopt:LONG
ENDOBJECT  ->LENGTH 204

CONST SV_ACPSHUTDOWN=202

EXPORT OBJECT frmTools OF frmBase
  btnShutdown     : PTR TO LONG
  btnStart        : PTR TO LONG
  btnRestart      : PTR TO LONG
  btnClose        : PTR TO LONG

  acpConfigName  : PTR TO CHAR
  configOk       : LONG
  
  btnShutdownClick: hook
  btnStartupClick: hook
  btnRestartClick: hook
ENDOBJECT

PROC create(app:PTR TO app_obj) OF frmTools
  DEF group
  SUPER self.create(app)
  self.winMain:=app.winTools

  self.btnShutdown:=app.btnShutdown
  self.btnStart:=app.btnStart
  self.btnRestart:=app.btnRestart
  self.btnClose:=app.btnClose
ENDPROC

PROC acpShutdown() OF frmTools
  DEF port,serverRP,retry
  DEF masterMsg:acpMessage

  serverRP:=createPort(0,0)
  masterMsg.node:=0
  masterMsg.command:=SV_ACPSHUTDOWN
  masterMsg.msg.ln.type:=NT_MESSAGE
  masterMsg.msg.length:=SIZEOF acpMessage
  masterMsg.msg.replyport:=serverRP

  IF(port:=FindPort('AE.Master'))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
    GetMsg(serverRP)
  ENDIF
  
  retry:=0
  WHILE (retry<20) AND (FindPort('AE.Master'))
    Delay(30)
    retry++
  ENDWHILE
  IF FindPort('AE.Master')
    Mui_RequestA(0,self.winMain,0,'Error' ,'*Ok','ACP did not shutdown in a timely manner.',0)
  ELSE
    clearChangeFlag()
  ENDIF
  
  self.refreshAcpStatus()
ENDPROC

PROC acpStartup() OF frmTools
  DEF retry
  DEF execStr[255]:STRING
  
  IF FindPort('AE.Master')=0
    StringF(execStr,'run >NIL: \s',self.acpConfigName)
    Execute(execStr,0,0)
    retry:=0
    WHILE (retry<20) AND (FindPort('AE.Master')=0)
      Delay(30)
      retry++
    ENDWHILE
    IF FindPort('AE.Master')=0 THEN Mui_RequestA(0,self.winMain,0,'Error' ,'*Ok','ACP did not startup in a timely manner.',0)
    self.refreshAcpStatus()
  ENDIF
ENDPROC

PROC doAcpStart() OF frmTools
  MOVE.L (A1),self
  GetA4()

  self.acpStartup() 
ENDPROC

PROC doAcpShutdown() OF frmTools
  MOVE.L (A1),self
  GetA4()

  self.acpShutdown() 
ENDPROC

PROC doAcpRestart() OF frmTools
  MOVE.L (A1),self
  GetA4()
  self.acpShutdown() 
  self.acpStartup()
ENDPROC

PROC refreshAcpStatus() OF frmTools
  DEF tempStr[20]:STRING
  IF(FindPort('AE.Master'))
    StrCopy(tempStr,'Running')
    set( self.btnRestart,MUIA_Disabled,FALSE)
    set( self.btnStart,MUIA_Disabled,MUI_TRUE)
    set( self.btnShutdown,MUIA_Disabled,FALSE)
  ELSE
    StrCopy(tempStr,'Not Running')
    set( self.btnRestart,MUIA_Disabled,MUI_TRUE)
    set( self.btnStart,MUIA_Disabled,FALSE)
    set( self.btnShutdown,MUIA_Disabled,MUI_TRUE)
  ENDIF
  IF self.configOk=FALSE
    set( self.btnRestart,MUIA_Disabled,MUI_TRUE)
    set( self.btnStart,MUIA_Disabled,MUI_TRUE)
    set( self.btnShutdown,MUIA_Disabled,MUI_TRUE)
  ENDIF
  set(self.app.txtAcpStatus, MUIA_Text_Contents,tempStr)
ENDPROC

PROC addNotifications() OF frmTools
  DEF i
  self.setupButtonClick(self.btnShutdown,self.btnShutdownClick,{doAcpShutdown})
  self.setupButtonClick(self.btnStart,self.btnStartupClick,{doAcpStart})
  self.setupButtonClick(self.btnRestart,self.btnRestartClick,{doAcpRestart})

  domethod( self.btnClose , [
    MUIM_Notify , MUIA_Pressed , FALSE ,
    self.app.app,
    2 ,
    MUIM_Application_ReturnID ,  MUIA_Window_CloseRequest ] )

ENDPROC

PROC removeNotifications() OF frmTools
  DEF i
  domethod(self.btnShutdown,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnStart,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnRestart,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnClose,[MUIM_KillNotify,MUIA_Pressed])
ENDPROC

PROC tools(acpConfigName:PTR TO CHAR) OF frmTools
  DEF nodeCount,confCount,i
  DEF bbsPath[255]:STRING
  DEF confConfig[255]:STRING
  DEF tempStr[255]:STRING
  
  self.acpConfigName:=acpConfigName
  
  nodeCount:=readToolTypeInt(acpConfigName,'NODES')
  StringF(tempStr,'\d',nodeCount) 
  set(self.app.txtNodeCount, MUIA_Text_Contents,tempStr)

  self.configOk:=TRUE
  
  readToolType(acpConfigName,'BBS_LOCATION',bbsPath)
  IF StrLen(bbsPath)=0 THEN self.configOk:=FALSE

  StringF(confConfig,'\sCONFCONFIG',bbsPath) 
  confCount:=readToolTypeInt(confConfig,'NCONFS')  
  StringF(tempStr,'\d',confCount)
  set(self.app.txtConfCount, MUIA_Text_Contents,tempStr)

  IF (nodeCount<0) OR (confCount<0) THEN self.configOk:=FALSE

  readToolType(acpConfigName,'SYSOP_NAME',tempStr)
  IF StrLen(tempStr)=0 THEN self.configOk:=FALSE

  readToolType(acpConfigName,'BBS_NAME',tempStr)
  IF StrLen(tempStr)=0 THEN self.configOk:=FALSE

  readToolType(acpConfigName,'BBS_GEOGRAPHIC',tempStr)
  IF StrLen(tempStr)=0 THEN self.configOk:=FALSE
  self.addNotifications()

  self.refreshAcpStatus()
  self.showModal()

  self.removeNotifications()
 
ENDPROC
