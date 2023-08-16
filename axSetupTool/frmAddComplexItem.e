OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','dos/dos','libraries/asl'
MODULE 'utility/tagitem' , 'utility/hooks', 'tools/installhook'
MODULE '*axedit','*frmBase','*controls','*/stringlist','*tooltypes','*configobject','*helpText'

EXPORT OBJECT frmAddComplexItem OF frmBase
  lblAreaName: LONG
  txtAreaName: LONG
  grpAreaSettings: LONG
  confControls: PTR TO stdlist
  accessControls: PTR TO stdlist
  fCheckControls: PTR TO stdlist
  protocolControls: PTR TO stdlist
  commandControls: PTR TO stdlist
  msgbaseControls: PTR TO stdlist
  acpName: PTR TO CHAR
  confConfig: PTR TO CHAR
  changed: LONG
  btnSave: LONG
  btnCancel: LONG
  setChangedHook:hook
  existingItems:PTR TO stringlist
ENDOBJECT

PROC setChangedFlag() OF frmAddComplexItem
  DEF txtval
  MOVE.L (A1),self
  GetA4()
  self.changed:=TRUE
  get(self.txtAreaName, MUIA_String_Contents,{txtval})

  IF ((self.changed) AND (StrLen(txtval)>0))
    set( self.btnSave,MUIA_Disabled,FALSE)
  ELSE
    set( self.btnSave,MUIA_Disabled,MUI_TRUE)
  ENDIF
ENDPROC

PROC addNotifications() OF frmAddComplexItem
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

  domethod( self.txtAreaName , [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.setChangedHook, self] )

ENDPROC

PROC removeNotifications() OF frmAddComplexItem
  domethod(self.btnCancel,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnSave,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.txtAreaName,[MUIM_KillNotify,MUIA_String_Contents])
ENDPROC

PROC create(app:PTR TO app_obj) OF frmAddComplexItem
  DEF group
  SUPER self.create(app)
  self.winMain:=app.wi_areas

  self.btnSave:=app.bt_area_save
  self.btnCancel:=app.bt_area_cancel

  get(app.gr_area_main,MUIA_Scrollgroup_Contents,{group})
  self.grpAreaSettings:=group
  self.lblAreaName:=app.la_area
  self.txtAreaName:=app.stR_area
ENDPROC

PROC freeControl(control:PTR TO control) OF frmAddComplexItem
  control.removeFromGroup(self.grpAreaSettings)
  END control
ENDPROC

PROC canClose() OF frmAddComplexItem
  MOVE.L (A1),self
  GetA4()
  IF self.changed
    IF self.unsavedChangesWarning()=0 THEN RETURN FALSE
  ENDIF
ENDPROC TRUE

PROC canSave() OF frmAddComplexItem
  DEF win,newName,i
  
  MOVE.L (A1),self
  GetA4()

  get(self.winMain,MUIA_Window_Window,{win})
  get(self.txtAreaName, MUIA_String_Contents,{newName})

  IF self.existingItems ANDALSO self.existingItems.contains(newName)
    EasyRequestArgs( win , [ 20 , 0 ,
                  'Error' ,
                  'An item already exists with this name.',
                  '_OK' ] , NIL , NIL )
    RETURN FALSE
  ENDIF
ENDPROC TRUE

PROC unsavedChangesWarning() OF frmAddComplexItem
  DEF win
  get(self.winMain,MUIA_Window_Window,{win})
  IF EasyRequestArgs( win , [ 20 , 0 ,
                  'Unsaved changes' ,
                  'You have unsaved changes,\nif you continue you will lose them.',
                  '_OK|_CANCEL' ] , NIL , NIL )=0 THEN RETURN FALSE
ENDPROC TRUE

PROC editArea(acpName,areaName,oldArea:PTR TO area, existingAreas:PTR TO stdlist) OF frmAddComplexItem
  DEF res,v1=0,v2=0
  DEF confControls:PTR TO stdlist
  DEF bbsPath[255]:STRING
  DEF confCount,i
  DEF tempStr[255]:STRING
  DEF confName[100]:STRING
  DEF control:PTR TO control
  DEF closeHook:PTR TO hook
  DEF canSaveHook:PTR TO hook
  DEF newArea:PTR TO area
  DEF existingList:PTR TO stringlist
  DEF areaItem:PTR TO area
  
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  NEW canSaveHook
  installhook(canSaveHook,{canSave})
  self.canSaveHook:=canSaveHook

  set( self.winMain, MUIA_Window_Title,'Edit Area Access')
  set( self.winMain, MUIA_Window_ID, "FARE")

  set( self.lblAreaName, MUIA_Text_Contents,'Area Name')

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  NEW existingList.stringlist(existingAreas.count())
  self.existingItems:=existingList
  FOR i:=0 TO existingAreas.count()-1
    areaItem:=existingAreas.item(i)
    IF areaItem<>oldArea THEN existingList.add(areaItem.filename)
  ENDFOR

  self.acpName:=acpName
  newArea:=0

  readToolType(self.acpName,'BBS_LOCATION',bbsPath)
  self.confConfig:=String(255)
  StringF(self.confConfig,'\sCONFCONFIG',bbsPath) 

  confCount:=readToolTypeInt(self.confConfig,'NCONFS')
  
  set(self.txtAreaName, MUIA_String_Contents,areaName)

  domethod(self.grpAreaSettings,[MUIM_Group_InitChange])

  set(self.grpAreaSettings, MUIA_Group_Columns , 2)

  NEW confControls.stdlist(25)
  self.confControls:=confControls

  FOR i:=1 TO confCount

    StringF(tempStr,'NAME.\d',i)
    readToolType(self.confConfig,tempStr,confName)

    NEW control.createCheckBox(confName,ACCESS_AREA_NAME,self.app.app,self.setChangedHook,self)

    self.confControls.add(control)
    control.addToGroup(self.grpAreaSettings)

    IF oldArea
      IF oldArea.confList
        control.setValue(IF oldArea.confList[i-1] THEN MUI_TRUE ELSE FALSE)
      ENDIF
    ENDIF
  ENDFOR
  domethod(self.grpAreaSettings,[MUIM_Group_ExitChange])

  installhook( self.setChangedHook, {setChangedFlag})    
  self.addNotifications()
  
  res:=self.showModal()
  IF res
    NEW newArea.create()
    newArea.confList:=List(confCount)
    get(self.txtAreaName, MUIA_String_Contents,{v1})
    StrCopy(newArea.filename,v1)
    FOR i:=0 TO confCount-1
      control:=confControls.item(i)
      ListAddItem(newArea.confList,IF control.getValue() THEN TRUE ELSE FALSE)
    ENDFOR
  ENDIF
  
  self.removeNotifications()
  FOR i:=0 TO confCount-1
    control:=confControls.item(i)
    self.freeControl(control)
  ENDFOR


  END existingList
  END confControls
  END closeHook
  END canSaveHook

  DisposeLink(self.confConfig) 
ENDPROC res,v1,newArea

PROC editAccess(acpName,accessName,oldAccessLevel:PTR TO accessLevel, existingAccessLevels:PTR TO stdlist) OF frmAddComplexItem
  DEF res,v1=0,v2=0
  DEF accessControls:PTR TO stdlist
  DEF accessControlCodes:PTR TO stringlist
  DEF bbsPath[255]:STRING
  DEF i
  DEF tempStr[255]:STRING
  DEF control:PTR TO control
  DEF canSaveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  DEF newAccessLevel:PTR TO accessLevel
  DEF acsNames:PTR TO LONG
  DEF acsValues:PTR TO LONG
  DEF existingList:PTR TO stringlist
  DEF accessLevel:PTR TO accessLevel
  
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  NEW canSaveHook
  installhook(canSaveHook,{canSave})
  self.canSaveHook:=canSaveHook

  set( self.winMain, MUIA_Window_Title,'Edit Area Access')
  set( self.winMain, MUIA_Window_ID, "FACS")
  
  set( self.lblAreaName, MUIA_Text_Contents,'Access Level')

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  NEW existingList.stringlist(existingAccessLevels.count())
  self.existingItems:=existingList
  FOR i:=0 TO existingAccessLevels.count()-1
    accessLevel:=existingAccessLevels.item(i)
    IF accessLevel<>oldAccessLevel THEN existingList.add(accessLevel.filename)
  ENDFOR

  self.acpName:=acpName
  newAccessLevel:=0

  readToolType(self.acpName,'BBS_LOCATION',bbsPath)

  set(self.txtAreaName, MUIA_String_Contents,accessName)

  domethod(self.grpAreaSettings,[MUIM_Group_InitChange])

  set(self.grpAreaSettings, MUIA_Group_Columns , 4)

  NEW accessControlCodes.stringlist(25)

  NEW accessControls.stdlist(25)
  self.accessControls:=accessControls

  acsNames:=getAccessNames()
  acsValues:=getAccessLevels()

  FOR i:=0 TO ListLen(acsValues)-1
    IF i=0
      NEW control.createStringInt(acsNames[i],ACCESS_NAME_MAX_PAGES,self.app.app,self.setChangedHook,self)
    ELSE
      NEW control.createCheckBox(acsNames[i],ACCESS_NAME,self.app.app,self.setChangedHook,self)
    ENDIF
    accessControls.add(control)
    accessControlCodes.add(acsValues[i])
    control.addToGroup(self.grpAreaSettings)
  ENDFOR

  IF oldAccessLevel
    FOR i:=0 TO accessControlCodes.count()-1
      control:=accessControls.item(i)
      IF i=0
        control.setValueStr(oldAccessLevel.accessList.item(0))
      ELSE
        control.setValue(IF oldAccessLevel.accessList.contains(accessControlCodes.item(i)) THEN MUI_TRUE ELSE FALSE)
      ENDIF
    ENDFOR
  ENDIF

  domethod(self.grpAreaSettings,[MUIM_Group_ExitChange])

  installhook( self.setChangedHook, {setChangedFlag})    
  self.addNotifications()
  
  res:=self.showModal()
  IF res
    NEW newAccessLevel.create()

    get(self.txtAreaName, MUIA_String_Contents,{v1})
    StrCopy(newAccessLevel.filename,v1)
    FOR i:=0 TO accessControls.count()-1
      control:=accessControls.item(i)
      IF i=0
          newAccessLevel.accessList.add(control.getValue())
      ELSE
        IF control.getValue()
          newAccessLevel.accessList.add(accessControlCodes.item(i))
        ENDIF
      ENDIF
    ENDFOR
  ENDIF
  
  FOR i:=0 TO accessControls.count()-1
    control:=accessControls.item(i)
    self.freeControl(control)
  ENDFOR
  self.removeNotifications()

  END existingList
  END accessControls
  END accessControlCodes
  END closeHook
  END canSaveHook
ENDPROC res,v1,newAccessLevel

PROC editFileCheck(acpName,fCheckName,oldfCheck:PTR TO fChecker,existingFcheckers:PTR TO stdlist) OF frmAddComplexItem
  DEF res,v1=0,v2=0
  DEF fCheckControls:PTR TO stdlist
  DEF bbsPath[255]:STRING
  DEF i
  DEF tempStr[255]:STRING
  DEF control:PTR TO control
  DEF closeHook:PTR TO hook
  DEF canSaveHook:PTR TO hook
  DEF newfChecker:PTR TO fChecker
  DEF controlChecker:PTR TO control
  DEF controlError1:PTR TO control
  DEF controlError2:PTR TO control
  DEF controlError3:PTR TO control
  DEF controlError4:PTR TO control
  DEF controlError5:PTR TO control
  DEF controlError6:PTR TO control
  DEF controlError7:PTR TO control
  DEF controlError8:PTR TO control
  DEF controlError9:PTR TO control
  DEF controlError10:PTR TO control
  DEF controlOptions:PTR TO control
  DEF controlPriority:PTR TO control
  DEF controlScript:PTR TO control
  DEF controlStack:PTR TO control
  DEF existingList:PTR TO stringlist
  DEF fCheckItem:PTR TO command

  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  NEW canSaveHook
  installhook(canSaveHook,{canSave})
  self.canSaveHook:=canSaveHook

  set( self.winMain, MUIA_Window_Title,'Edit File Checker')
  set( self.winMain, MUIA_Window_ID, "EFCH")
  
  set( self.lblAreaName, MUIA_Text_Contents,'File Type')

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  NEW existingList.stringlist(existingFcheckers.count())
  self.existingItems:=existingList
  FOR i:=0 TO existingFcheckers.count()-1
    fCheckItem:=existingFcheckers.item(i)
    IF fCheckItem<>oldfCheck THEN existingList.add(fCheckItem.filename)
  ENDFOR

  self.acpName:=acpName

  readToolType(self.acpName,'BBS_LOCATION',bbsPath)

  set(self.txtAreaName, MUIA_String_Contents,fCheckName)

  domethod(self.grpAreaSettings,[MUIM_Group_InitChange])

  set(self.grpAreaSettings, MUIA_Group_Columns , 2)

  NEW fCheckControls.stdlist(25)
  self.fCheckControls:=fCheckControls

  newfChecker:=0

  NEW controlChecker.createString('Checker',CHECKER_NAME,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlChecker)
  NEW controlError1.createString('Error 1',CHECKER_ERROR,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlError1)
  NEW controlError2.createString('Error 2',CHECKER_ERROR,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlError2)
  NEW controlError3.createString('Error 3',CHECKER_ERROR,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlError3)
  NEW controlError4.createString('Error 4',CHECKER_ERROR,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlError4)
  NEW controlError5.createString('Error 5',CHECKER_ERROR,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlError5)
  NEW controlError6.createString('Error 6',CHECKER_ERROR,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlError6)
  NEW controlError7.createString('Error 7',CHECKER_ERROR,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlError7)
  NEW controlError8.createString('Error 8',CHECKER_ERROR,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlError8)
  NEW controlError9.createString('Error 9',CHECKER_ERROR,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlError9)
  NEW controlError10.createString('Error 10',CHECKER_ERROR,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlError10)
  
  NEW controlOptions.createString('Options',CHECKER_OPTIONS,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlOptions)
  
  NEW controlPriority.createStringInt('Priority',CHECKER_PRIORITY,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlPriority)
  
  NEW controlScript.createString('Script',CHECKER_SCRIPT,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlScript)
  
  NEW controlStack.createStringInt('Stack',CHECKER_STACK,self.app.app,self.setChangedHook,self)
  fCheckControls.add(controlStack)

  FOR i:=0 TO fCheckControls.count()-1
    control:=fCheckControls.item(i)
    control.addToGroup(self.grpAreaSettings)
  ENDFOR

  domethod(self.grpAreaSettings,[MUIM_Group_ExitChange])

  installhook( self.setChangedHook, {setChangedFlag})    
  self.addNotifications()

  IF oldfCheck
    //set controls according to oldfcheck

    controlChecker.setValue(oldfCheck.checker)
    controlError1.setValue(oldfCheck.error1)
    controlError2.setValue(oldfCheck.error2)
    controlError3.setValue(oldfCheck.error3)
    controlError4.setValue(oldfCheck.error4)
    controlError5.setValue(oldfCheck.error5)
    controlError6.setValue(oldfCheck.error6)
    controlError7.setValue(oldfCheck.error7)
    controlError8.setValue(oldfCheck.error8)
    controlError9.setValue(oldfCheck.error9)
    controlError10.setValue(oldfCheck.error10)
    controlOptions.setValue(oldfCheck.options)
    controlPriority.setValueStr(oldfCheck.priority)
    controlScript.setValue(oldfCheck.script)
    controlStack.setValueStr(oldfCheck.stack)
  ENDIF
  self.changed:=FALSE
  
  res:=self.showModal()
  IF res
    
    NEW newfChecker.create()
    //set fchecker according to controls
    get(self.txtAreaName, MUIA_String_Contents,{v1})
    StrCopy(newfChecker.filename,v1)
    StrCopy(newfChecker.checker,controlChecker.getValue())
    StrCopy(newfChecker.error1,controlError1.getValue())
    StrCopy(newfChecker.error2,controlError2.getValue())
    StrCopy(newfChecker.error3,controlError3.getValue())
    StrCopy(newfChecker.error4,controlError4.getValue())
    StrCopy(newfChecker.error5,controlError5.getValue())
    StrCopy(newfChecker.error6,controlError6.getValue())
    StrCopy(newfChecker.error7,controlError7.getValue())
    StrCopy(newfChecker.error8,controlError8.getValue())
    StrCopy(newfChecker.error9,controlError9.getValue())
    StrCopy(newfChecker.error10,controlError10.getValue())
    StrCopy(newfChecker.options,controlOptions.getValue())
    StrCopy(newfChecker.priority,controlPriority.getValue())
    StrCopy(newfChecker.script,controlScript.getValue())
    StrCopy(newfChecker.stack,controlStack.getValue())
  ENDIF
  
  FOR i:=0 TO fCheckControls.count()-1
    control:=fCheckControls.item(i)
    self.freeControl(control)
  ENDFOR
  self.removeNotifications()

  END existingList
  END fCheckControls
  END closeHook
  END canSaveHook
ENDPROC res,v1,newfChecker

PROC editProtocol(acpName,protocolName,oldProtocol:PTR TO protocol,existingProtocols:PTR TO stdlist) OF frmAddComplexItem
  DEF res,v1=0,v2=0
  DEF protocolControls:PTR TO stdlist
  DEF bbsPath[255]:STRING
  DEF i
  DEF tempStr[255]:STRING
  DEF control:PTR TO control
  DEF closeHook:PTR TO hook
  DEF canSaveHook:PTR TO hook
  DEF newProtocol:PTR TO protocol
  DEF controlOptions:PTR TO control
  DEF controlHttpHost:PTR TO control
  DEF controlHttpTemp:PTR TO control
  DEF controlFtpAuth:PTR TO control
  DEF controlFtpHost:PTR TO control
  DEF controlRxWindow:PTR TO control
  DEF controlTxWindow:PTR TO control
  DEF existingList:PTR TO stringlist
  DEF protocolItem:PTR TO protocol

  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  NEW canSaveHook
  installhook(canSaveHook,{canSave})
  self.canSaveHook:=canSaveHook

  set( self.winMain, MUIA_Window_Title,'Edit Protocol')
  set( self.winMain, MUIA_Window_ID, "EPCL")
  
  set( self.lblAreaName, MUIA_Text_Contents,'Protocol')

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  NEW existingList.stringlist(existingProtocols.count())
  self.existingItems:=existingList
  FOR i:=0 TO existingProtocols.count()-1
    protocolItem:=existingProtocols.item(i)
    IF protocolItem<>oldProtocol THEN existingList.add(protocolItem.filename)
  ENDFOR

  self.acpName:=acpName

  readToolType(self.acpName,'BBS_LOCATION',bbsPath)

  set(self.txtAreaName, MUIA_String_Contents,protocolName)

  domethod(self.grpAreaSettings,[MUIM_Group_InitChange])

  set(self.grpAreaSettings, MUIA_Group_Columns , 2)

  NEW protocolControls.stdlist(25)
  self.protocolControls:=protocolControls

  newProtocol:=0

  NEW controlOptions.createString('Options',PROTOCOL_OPTIONS,self.app.app,self.setChangedHook,self)
  protocolControls.add(controlOptions)
  NEW controlRxWindow.createStringInt('Hydra Rx Window',HYDRA_RX_WINDOW,self.app.app,self.setChangedHook,self)
  protocolControls.add(controlRxWindow)
  NEW controlTxWindow.createStringInt('Hydra Tx Window',HYDRA_TX_WINDOW,self.app.app,self.setChangedHook,self)
  protocolControls.add(controlTxWindow)
  NEW controlHttpHost.createString('Http Host',HTTP_HOSTNAME,self.app.app,self.setChangedHook,self)
  protocolControls.add(controlHttpHost)
  NEW controlHttpTemp.createDirSelect('Http TempDir',HTTP_TEMPDIR,self.app.app,self.setChangedHook,self)
  protocolControls.add(controlHttpTemp)
  NEW controlFtpHost.createString('Ftp Host',FTP_HOSTNAME,self.app.app,self.setChangedHook,self)
  protocolControls.add(controlFtpHost)
  NEW controlFtpAuth.createCheckBox('Ftp Authentication',FTP_AUTH,self.app.app,self.setChangedHook,self)
  protocolControls.add(controlFtpAuth)
  
  FOR i:=0 TO protocolControls.count()-1
    control:=protocolControls.item(i)
    control.addToGroup(self.grpAreaSettings)
  ENDFOR

  domethod(self.grpAreaSettings,[MUIM_Group_ExitChange])

  installhook( self.setChangedHook, {setChangedFlag})    
  self.addNotifications()

  IF oldProtocol
    //set controls according to oldProtocol

    controlOptions.setValue(oldProtocol.options)
    controlHttpHost.setValue(oldProtocol.httpHost)
    controlHttpTemp.setValue(oldProtocol.httpTemp)
    controlFtpAuth.setValue(oldProtocol.ftpAuth)
    controlFtpHost.setValue(oldProtocol.ftpHost)
    controlRxWindow.setValueStr(oldProtocol.rxWindow)
    controlTxWindow.setValueStr(oldProtocol.txWindow)
  ENDIF
  self.changed:=FALSE
  
  res:=self.showModal()
  IF res
    get(self.txtAreaName, MUIA_String_Contents,{v1})
    NEW newProtocol.create()
    //set protocol according to controls
    StrCopy(newProtocol.filename,v1)
    StrCopy(newProtocol.options,controlOptions.getValue())
    StrCopy(newProtocol.httpHost,controlHttpHost.getValue())
    StrCopy(newProtocol.httpTemp,controlHttpTemp.getValue())
    newProtocol.ftpAuth:=controlFtpAuth.getValue()
    StrCopy(newProtocol.ftpHost,controlFtpHost.getValue())
    StrCopy(newProtocol.rxWindow,controlRxWindow.getValue())
    StrCopy(newProtocol.txWindow,controlTxWindow.getValue())

  ENDIF
  
  FOR i:=0 TO protocolControls.count()-1
    control:=protocolControls.item(i)
    self.freeControl(control)
  ENDFOR
  self.removeNotifications()


  END existingList
  END protocolControls
  END closeHook
  END canSaveHook
ENDPROC res,v1,newProtocol


PROC editCommand(acpName,commandName,commandFolder,oldCommand:PTR TO command,existingCommands:PTR TO stdlist) OF frmAddComplexItem
  DEF res,v1=0,v2=0
  DEF commandControls:PTR TO stdlist
  DEF bbsPath[255]:STRING
  DEF i,item
  DEF tempStr[255]:STRING
  DEF control:PTR TO control
  DEF closeHook:PTR TO hook
  DEF canSaveHook:PTR TO hook
  DEF newCommand:PTR TO command
  DEF controlName:PTR TO control
  DEF controlLocation:PTR TO control
  DEF controlAccess:PTR TO control
  DEF controlInternal:PTR TO control
  DEF controlMimicVer:PTR TO control
  DEF controlPassword:PTR TO control
  DEF controlPassParams:PTR TO control
  DEF controlPriority:PTR TO control
  DEF controlResident:PTR TO control
  DEF controlQuickMode:PTR TO control
  DEF controlStack:PTR TO control
  DEF controlType:PTR TO control
  DEF controlTrapon:PTR TO control
  DEF controlExpertMode:PTR TO control
  DEF controlDoorSilent:PTR TO control
  DEF controlLogInputs:PTR TO control
  DEF controlScriptCheck:PTR TO control
  DEF controlMultiNode:PTR TO control
  DEF controlBanner:PTR TO control
  DEF typeList:PTR TO LONG
  DEF existingList:PTR TO stringlist
  DEF cmdItem:PTR TO command

  NEW closeHook
  installhook( closeHook, {canClose})
  self.closeHook:=closeHook

  NEW canSaveHook
  installhook(canSaveHook,{canSave})
  self.canSaveHook:=canSaveHook

  set( self.winMain, MUIA_Window_Title,'Edit Command')
  set( self.winMain, MUIA_Window_ID, "ECMD")
  
  set( self.lblAreaName, MUIA_Text_Contents,'Command')

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  NEW existingList.stringlist(existingCommands.count())
  self.existingItems:=existingList
  FOR i:=0 TO existingCommands.count()-1
    cmdItem:=existingCommands.item(i)
    IF cmdItem<>oldCommand THEN existingList.add(cmdItem.filename)
  ENDFOR

  self.acpName:=acpName

  readToolType(self.acpName,'BBS_LOCATION',bbsPath)

  set(self.txtAreaName, MUIA_String_Contents,commandName)

  domethod(self.grpAreaSettings,[MUIM_Group_InitChange])

  set(self.grpAreaSettings, MUIA_Group_Columns , 2)

  NEW commandControls.stdlist(25)
  self.commandControls:=commandControls

  newCommand:=0

  typeList:=['XIM','AIM','TIM','IIM','SIM','MCI',0]

  installhook( self.setChangedHook, {setChangedFlag})    

  NEW controlName.createString('Name',COMMAND_NAME,self.app.app,self.setChangedHook,self)
  commandControls.add(controlName)
  NEW controlLocation.createString('Location',COMMAND_LOCATION,self.app.app,self.setChangedHook,self)
  commandControls.add(controlLocation)
  NEW controlAccess.createStringInt('Access',COMMAND_ACCESS,self.app.app,self.setChangedHook,self)
  commandControls.add(controlAccess)
  NEW controlInternal.createString('Internal',COMMAND_INTERNAL,self.app.app,self.setChangedHook,self)
  commandControls.add(controlInternal)
  NEW controlMimicVer.createString('Mimic Version',COMMAND_MIMIC_VER,self.app.app,self.setChangedHook,self)
  commandControls.add(controlMimicVer)
  NEW controlPassword.createString('Password',COMMAND_PASSWORD,self.app.app,self.setChangedHook,self)
  commandControls.add(controlPassword)
  NEW controlPassParams.createCycle('Pass Params',COMMAND_PASS_PARAMS,['N/A','No execute','Swap and retain','Swap, retain and redo','Bypass BBSCMD',0],self.app.app,self.setChangedHook,self)
  commandControls.add(controlPassParams)
  NEW controlPriority.createStringInt('Priority',COMMAND_PRIORITY,self.app.app,self.setChangedHook,self)
  commandControls.add(controlPriority)
  NEW controlStack.createStringInt('Stack',COMMAND_STACK,self.app.app,self.setChangedHook,self)
  commandControls.add(controlStack)
  NEW controlType.createCycle('Type',COMMAND_TYPE,typeList,self.app.app,self.setChangedHook,self)
  commandControls.add(controlType)
  NEW controlBanner.createString('Banner',COMMAND_BANNER,self.app.app,self.setChangedHook,self)
  commandControls.add(controlBanner)

  NEW controlResident.createCheckBox('Resident',COMMAND_RESIDENT,self.app.app,self.setChangedHook,self)
  commandControls.add(controlResident)
  NEW controlQuickMode.createCheckBox('Quick Mode',COMMAND_QUICK_MODE,self.app.app,self.setChangedHook,self)
  commandControls.add(controlQuickMode)
  NEW controlTrapon.createCheckBox('Trap On',COMMAND_TRAP_ON,self.app.app,self.setChangedHook,self)
  commandControls.add(controlTrapon)
  NEW controlExpertMode.createCheckBox('Expert mode',COMMAND_EXPERT_MODE,self.app.app,self.setChangedHook,self)
  commandControls.add(controlExpertMode)
  NEW controlDoorSilent.createCheckBox('Silent',COMMAND_SILENT,self.app.app,self.setChangedHook,self)
  commandControls.add(controlDoorSilent)
  NEW controlLogInputs.createCheckBox('Log Inputs',COMMAND_LOG_INPUTS,self.app.app,self.setChangedHook,self)
  commandControls.add(controlLogInputs)
  NEW controlScriptCheck.createCheckBox('Script Check',COMMAND_SCRIPT_CHECK,self.app.app,self.setChangedHook,self)
  commandControls.add(controlScriptCheck)
  NEW controlMultiNode.createCheckBox('Multinode',COMMAND_MULTINODE,self.app.app,self.setChangedHook,self)
  commandControls.add(controlMultiNode)

  FOR i:=0 TO commandControls.count()-1
    control:=commandControls.item(i)
    control.addToGroup(self.grpAreaSettings)
  ENDFOR

  domethod(self.grpAreaSettings,[MUIM_Group_ExitChange])

  self.addNotifications()

  IF oldCommand
    //set controls according to oldCommand
    controlName.setValue(oldCommand.name)
    controlLocation.setValue(oldCommand.location)
    controlAccess.setValueStr(oldCommand.access)
    controlInternal.setValue(oldCommand.internal)
    controlMimicVer.setValue(oldCommand.mimicVer)
    controlPassword.setValue(oldCommand.password)
    
    IF EstrLen(oldCommand.passParams)=0
      controlPassParams.setValueIndex(0)
    ELSE
      controlPassParams.setValueIndex(Val(oldCommand.passParams))
    ENDIF
    controlPriority.setValueStr(oldCommand.priority)
    controlResident.setValue(oldCommand.resident)
    controlQuickMode.setValue(oldCommand.quickMode)
    controlStack.setValueStr(oldCommand.stack)

    i:=0
    ForAll({item},typeList,`IF item ANDALSO StriCmp(item,oldCommand.type) THEN controlType.setValueIndex(i++) ELSE i++)
    controlTrapon.setValue(oldCommand.trapon)
    controlExpertMode.setValue(oldCommand.expertMode)
    controlDoorSilent.setValue(oldCommand.doorSilent)
    controlLogInputs.setValue(oldCommand.logInputs)
    controlScriptCheck.setValue(oldCommand.scriptCheck)
    controlMultiNode.setValue(oldCommand.multiNode)
    controlBanner.setValue(oldCommand.banner)
  ENDIF
  self.changed:=FALSE
  
  res:=self.showModal()
  IF res
    NEW newCommand.create()
    //set command according to controls

    get(self.txtAreaName, MUIA_String_Contents,{v1})

    StrCopy(newCommand.filename,v1)
    StrCopy(newCommand.name,controlName.getValue())
    StrCopy(newCommand.location,controlLocation.getValue())
    StrCopy(newCommand.access,controlAccess.getValue())
    StrCopy(newCommand.internal,controlInternal.getValue())
    StrCopy(newCommand.mimicVer,controlMimicVer.getValue())
    StrCopy(newCommand.password,controlPassword.getValue())
    v2:=controlPassParams.getValueIndex()
    IF v2=0
      StrCopy(newCommand.passParams,'')
    ELSE
      StringF(newCommand.passParams,'\d',v2)
    ENDIF
   
    StrCopy(newCommand.priority,controlPriority.getValue())
    newCommand.resident:=controlResident.getValue()
    newCommand.quickMode:=controlQuickMode.getValue()
    StrCopy(newCommand.stack,controlStack.getValue())
    StrCopy(newCommand.type,typeList[controlType.getValueIndex()])
    newCommand.trapon:=controlTrapon.getValue()
    newCommand.expertMode:=controlExpertMode.getValue()
    newCommand.doorSilent:=controlDoorSilent.getValue()
    newCommand.logInputs:=controlLogInputs.getValue()
    newCommand.scriptCheck:=controlScriptCheck.getValue()
    newCommand.multiNode:=controlMultiNode.getValue()
    StrCopy(newCommand.banner,controlBanner.getValue())
  ENDIF
  
  FOR i:=0 TO commandControls.count()-1
    control:=commandControls.item(i)
    self.freeControl(control)
  ENDFOR
  self.removeNotifications()

  END commandControls
  END existingList
  END closeHook
  END canSaveHook
ENDPROC res,v1,newCommand


PROC editMsgbase(acpName,msgbaseName,oldMsgbase:PTR TO msgbase) OF frmAddComplexItem
  DEF res,v1=0,v2=0
  DEF msgbaseControls:PTR TO stdlist
  DEF bbsPath[255]:STRING
  DEF i
  DEF tempStr[255]:STRING
  DEF control:PTR TO control
  DEF closeHook:PTR TO hook
  DEF newMsgbase:PTR TO msgbase
  DEF controlMsgbaseLocation:PTR TO control
  DEF controlExtSend:PTR TO control
  DEF controlUserNames:PTR TO control
  DEF controlRealNames:PTR TO control
  DEF controlInternetNames:PTR TO control
  

  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook
  
  set( self.winMain, MUIA_Window_Title,'Edit Messagebase')
  set( self.winMain, MUIA_Window_ID, "EMBS")
  
  set( self.lblAreaName, MUIA_Text_Contents,'Name')

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  self.acpName:=acpName

  readToolType(self.acpName,'BBS_LOCATION',bbsPath)

  set(self.txtAreaName, MUIA_String_Contents,msgbaseName)

  domethod(self.grpAreaSettings,[MUIM_Group_InitChange])

  set(self.grpAreaSettings, MUIA_Group_Columns , 2)

  NEW msgbaseControls.stdlist(10)
  self.msgbaseControls:=msgbaseControls

  newMsgbase:=0

  NEW controlMsgbaseLocation.createDirSelect('Location',MSGBASE_LOCATION,self.app.app,self.setChangedHook,self)
  msgbaseControls.add(controlMsgbaseLocation)
  NEW controlExtSend.createCheckBox('Send External',MSGBASE_SEND_EXTERNAL,self.app.app,self.setChangedHook,self)
  msgbaseControls.add(controlExtSend)
  NEW controlUserNames.createCheckBox('Uses Usernames',MSGBASE_USES_USERNAMES,self.app.app,self.setChangedHook,self)
  msgbaseControls.add(controlUserNames)
  NEW controlRealNames.createCheckBox('Uses real names',MSGBASE_USES_REALNAMES,self.app.app,self.setChangedHook,self)
  msgbaseControls.add(controlRealNames)
  NEW controlInternetNames.createCheckBox('Uses internet names',MSGBASE_USES_INETNAMES,self.app.app,self.setChangedHook,self)
  msgbaseControls.add(controlInternetNames)

  FOR i:=0 TO msgbaseControls.count()-1
    control:=msgbaseControls.item(i)
    control.addToGroup(self.grpAreaSettings)
  ENDFOR

  domethod(self.grpAreaSettings,[MUIM_Group_ExitChange])

  installhook( self.setChangedHook, {setChangedFlag})    
  self.addNotifications()

  IF oldMsgbase
    //set controls according to oldMsgbase
    controlMsgbaseLocation.setValue(oldMsgbase.location)
    controlExtSend.setValue(oldMsgbase.extSend)
    controlUserNames.setValue(oldMsgbase.username)
    controlRealNames.setValue(oldMsgbase.realname)
    controlInternetNames.setValue(oldMsgbase.internetname)
  ENDIF
  self.changed:=FALSE
  
  res:=self.showModal()
  IF res
    NEW newMsgbase.create()
    //set protocol according to controls
    StrCopy(newMsgbase.location,controlMsgbaseLocation.getValue())
    newMsgbase.extSend:=controlExtSend.getValue()
    newMsgbase.username:=controlUserNames.getValue()
    newMsgbase.realname:=controlRealNames.getValue()
    newMsgbase.internetname:=controlInternetNames.getValue()
  ENDIF
  
  FOR i:=0 TO msgbaseControls.count()-1
    control:=msgbaseControls.item(i)
    self.freeControl(control)
  ENDFOR
  self.removeNotifications()

  get(self.txtAreaName, MUIA_String_Contents,{v1})

  END msgbaseControls
  END closeHook
ENDPROC res,v1,newMsgbase
