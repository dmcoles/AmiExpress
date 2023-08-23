OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','dos/dos','libraries/asl','dos/var'
MODULE 'utility/tagitem' , 'utility/hooks', 'tools/installhook'
MODULE '*axedit','*frmBase','*frmEditList','*frmNodeEdit','*frmConfEdit','*frmSettingsEdit','*frmAccess','*frmCommands','*tooltypes'

EXPORT OBJECT frmMain OF frmBase
  acpConfigName: PTR TO CHAR
  btnConfsClickHook: hook
  btnNodesClickHook: hook
  btnComputersClickHook: hook
  btnCheckersClickHook: hook
  btnNamesNotAllowedClickHook: hook
  btnDrivesClickHook: hook
  btnSystemClickHook: hook
  btnScreensClickHook: hook
  btnServerClickHook: hook
  btnSecurityClickHook: hook
  btnLanguagesClickHook: hook
  btnProtocolsClickHook: hook
  btnCommandsClickHook: hook
  btnZoomClickHook: hook
  btnConnectClickHook: hook
  btnBackupClickHook: hook
  btnRestrictClickHook: hook
  btnExitClickHook: hook
  btnAboutClickHook: hook
ENDOBJECT

PROC exitbuttonPressed() OF frmMain
  MOVE.L (A1),self
  GetA4()
  domethod(self.app.app,[MUIM_Application_ReturnID,MUIA_Window_CloseRequest])
ENDPROC


PROC aboutbuttonPressed() OF frmMain
  DEF win
  MOVE.L (A1),self
  GetA4()
  Mui_RequestA(0,self.winMain,0,'About Ami-Express Setup Tool' ,'*Ok','This tool can assist you in configuring\nalmost every aspect of Ami-Express.\n\n(c)2023 Darren Coles.',0)
ENDPROC


PROC computersbuttonPressed() OF frmMain
  DEF listEdit:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW listEdit.create(self.app)
  listEdit.editComputers(self.acpConfigName)
  END listEdit
  self.wake()
  
ENDPROC

PROC drivesbuttonPressed() OF frmMain
  DEF listEdit:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW listEdit.create(self.app)
  listEdit.editDrives(self.acpConfigName)
  END listEdit
  self.wake()
  
ENDPROC

PROC screensbuttonPressed() OF frmMain
  DEF listEdit:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW listEdit.create(self.app)
  listEdit.editScreens(self.acpConfigName)
  END listEdit
  self.wake()
  
ENDPROC

PROC connectbuttonPressed() OF frmMain
  DEF listEdit:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW listEdit.create(self.app)
  listEdit.editConnectionStrings(self.acpConfigName)
  END listEdit
  self.wake()
  
ENDPROC

PROC namesnotallowedbuttonPressed() OF frmMain
  DEF listEdit:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW listEdit.create(self.app)
  listEdit.editNamesNotAllowed(self.acpConfigName)
  END listEdit
  self.wake()
  
ENDPROC

PROC nodesbuttonPressed() OF frmMain
  DEF frmNodeEdit:PTR TO frmNodeEdit
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW frmNodeEdit.create(self.app)
  frmNodeEdit.editNodes(self.acpConfigName)
  END frmNodeEdit
  self.wake()
  
ENDPROC

PROC confsbuttonPressed() OF frmMain
  DEF frmConfEdit:PTR TO frmConfEdit
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW frmConfEdit.create(self.app)
  frmConfEdit.editConfs(self.acpConfigName)
  END frmConfEdit
  self.wake()
  
ENDPROC

PROC zoombuttonPressed() OF frmMain
  DEF frmSettingsEdit:PTR TO frmSettingsEdit
  MOVE.L (A1),self
  GetA4()
  self.sleep()
  NEW frmSettingsEdit.create(self.app)
  frmSettingsEdit.editZoomSettings(self.acpConfigName)
  END frmSettingsEdit
  self.wake()
ENDPROC

PROC serverbuttonPressed() OF frmMain
  DEF frmSettingsEdit:PTR TO frmSettingsEdit
  MOVE.L (A1),self
  GetA4()
  self.sleep()
  NEW frmSettingsEdit.create(self.app)
  frmSettingsEdit.editServerSettings(self.acpConfigName)
  END frmSettingsEdit
  self.wake()
ENDPROC

PROC systembuttonPressed() OF frmMain
  DEF frmSettingsEdit:PTR TO frmSettingsEdit
  MOVE.L (A1),self
  GetA4()
  self.sleep()
  NEW frmSettingsEdit.create(self.app)
  frmSettingsEdit.editSystemSettings(self.acpConfigName)
  END frmSettingsEdit
  self.wake()
ENDPROC

PROC securitybuttonPressed() OF frmMain
  DEF frmAccess:PTR TO frmAccess
  MOVE.L (A1),self
  GetA4()
  self.sleep()
  NEW frmAccess.create(self.app)
  frmAccess.editAccess(self.acpConfigName)
  END frmAccess
  self.wake()
ENDPROC


PROC backupbuttonPressed() OF frmMain
  DEF listEdit:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW listEdit.create(self.app)
  listEdit.editBackup(self.acpConfigName)
  END listEdit
  self.wake()
ENDPROC

PROC restrictbuttonPressed() OF frmMain
  DEF listEdit:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW listEdit.create(self.app)
  listEdit.editRestricted(self.acpConfigName)
  END listEdit
  self.wake()
ENDPROC

PROC languagesbuttonPressed() OF frmMain
  DEF listEdit:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW listEdit.create(self.app)
  listEdit.editLanguages(self.acpConfigName)
  END listEdit
  self.wake()
ENDPROC

PROC fcheckbuttonPressed() OF frmMain
  DEF listEdit:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW listEdit.create(self.app)
  listEdit.editFileCheckers(self.acpConfigName)
  END listEdit
  self.wake()
  
ENDPROC

PROC commandsbuttonPressed() OF frmMain
  DEF frmCommands:PTR TO frmCommands
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW frmCommands.create(self.app)
  frmCommands.editCommands(self.acpConfigName)
  END frmCommands
  self.wake()
  
ENDPROC

PROC protocolsbuttonPressed() OF frmMain
  DEF listEdit:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW listEdit.create(self.app)
  listEdit.editProtocols(self.acpConfigName)
  END listEdit
  self.wake()
  
ENDPROC

PROC create(app:PTR TO app_obj) OF frmMain
  SUPER self.create(app)
  self.winMain:=app.winMain

  set (app.mnlabel1Donotremovefolder1, MUIA_Menuitem_Exclude, 6)
  set (app.mnlabel1Removefolder1, MUIA_Menuitem_Exclude, 5)
  set (app.mnlabel1Ask1, MUIA_Menuitem_Exclude, 3)
  
  
  set (app.mnlabel1Donotremovefolder2, MUIA_Menuitem_Exclude, 6)
  set (app.mnlabel1Removefolder2, MUIA_Menuitem_Exclude, 5)
  set (app.mnlabel1Ask2, MUIA_Menuitem_Exclude, 3)
ENDPROC

PROC domain() OF frmMain
  DEF fh,fr:PTR TO filerequester
  DEF tempStr[200]:STRING
  DEF v

  GetVar('axSetupEditor_prefs',tempStr,200,0)
  SetStr(tempStr)
  IF (EstrLen(tempStr)>0) THEN v:=tempStr[0]-48 ELSE v:=0
  SELECT v
    CASE 1
      set (self.app.mnlabel1Donotremovefolder1, MUIA_Menuitem_Checked, MUI_TRUE)
    CASE 2
      set (self.app.mnlabel1Removefolder1, MUIA_Menuitem_Checked, MUI_TRUE)
    CASE 3
      set (self.app.mnlabel1Ask1, MUIA_Menuitem_Checked, MUI_TRUE)
    DEFAULT
      set (self.app.mnlabel1Donotremovefolder1, MUIA_Menuitem_Checked, MUI_TRUE)
  ENDSELECT

  IF (EstrLen(tempStr)>1) THEN v:=tempStr[1]-48 ELSE v:=0
  SELECT v
    CASE 1
      set (self.app.mnlabel1Donotremovefolder2, MUIA_Menuitem_Checked, MUI_TRUE)
    CASE 2
      set (self.app.mnlabel1Removefolder2, MUIA_Menuitem_Checked, MUI_TRUE)
    CASE 3
      set (self.app.mnlabel1Ask2, MUIA_Menuitem_Checked, MUI_TRUE)
    DEFAULT
      set (self.app.mnlabel1Donotremovefolder2, MUIA_Menuitem_Checked, MUI_TRUE)
  ENDSELECT

  self.acpConfigName:=String(200)
  
  IF EstrLen(tempStr)>2
    StrCopy(self.acpConfigName,tempStr+2)
  ENDIF

  StringF(tempStr,'\s.info',self.acpConfigName)

  IF (EstrLen(self.acpConfigName)=0) OR (FileLength(tempStr)<=0)
    fr:=Mui_AllocAslRequest(ASL_FILEREQUEST, [ASLFR_TITLETEXT,'Select ACP file',ASLFR_INITIALDRAWER,'sys:wbstartup',ASLFR_INITIALFILE,'ACP',ASLFR_INITIALPATTERN,'ACP',0])
    IF (fr)
      IF Mui_AslRequest(fr,0)
        StrCopy(self.acpConfigName,fr.drawer)
        AddPart(self.acpConfigName,fr.file,StrMax(self.acpConfigName))
        SetStr(self.acpConfigName)
        StringF(tempStr,'\s.info',self.acpConfigName)
        IF (FileLength(self.acpConfigName)<=0) OR (FileLength(tempStr)<=0)
          StrCopy(self.acpConfigName,'')
        ENDIF
      ELSE
        StrCopy(self.acpConfigName,'')
      ENDIF
      Mui_FreeAslRequest(fr)
    ENDIF
  ENDIF
  IF EstrLen(self.acpConfigName)=0
    Throw("ACP","icon")
  ENDIF

  self.setupButtonClick(self.app.btnComputers,self.btnComputersClickHook,{computersbuttonPressed})
  self.setupButtonClick(self.app.btnCheckers,self.btnCheckersClickHook,{fcheckbuttonPressed})
  self.setupButtonClick(self.app.btnNamesNotAllowed,self.btnNamesNotAllowedClickHook,{namesnotallowedbuttonPressed})
  self.setupButtonClick(self.app.btnDrives,self.btnDrivesClickHook,{drivesbuttonPressed})
  self.setupButtonClick(self.app.btnScreenTypes,self.btnScreensClickHook,{screensbuttonPressed})
  self.setupButtonClick(self.app.btnNodes,self.btnNodesClickHook,{nodesbuttonPressed})
  self.setupButtonClick(self.app.btnConfs,self.btnConfsClickHook,{confsbuttonPressed})
  self.setupButtonClick(self.app.btnSystem,self.btnSystemClickHook,{systembuttonPressed})
  self.setupButtonClick(self.app.btnServer,self.btnServerClickHook,{serverbuttonPressed})
  self.setupButtonClick(self.app.btnSecurity,self.btnSecurityClickHook,{securitybuttonPressed})
  self.setupButtonClick(self.app.btnLanguages,self.btnLanguagesClickHook,{languagesbuttonPressed})
  self.setupButtonClick(self.app.btnProtocols,self.btnProtocolsClickHook,{protocolsbuttonPressed})
  self.setupButtonClick(self.app.btnCommands,self.btnCommandsClickHook,{commandsbuttonPressed})
  self.setupButtonClick(self.app.btnZoom,self.btnZoomClickHook,{zoombuttonPressed})
  self.setupButtonClick(self.app.btnConnect,self.btnConnectClickHook,{connectbuttonPressed})
  self.setupButtonClick(self.app.btnExit,self.btnExitClickHook,{exitbuttonPressed})
  self.setupButtonClick(self.app.btnRestrict,self.btnRestrictClickHook,{restrictbuttonPressed})
  self.setupButtonClick(self.app.btnBackup,self.btnBackupClickHook,{backupbuttonPressed})
  self.setupButtonClick(self.app.btnAbout,self.btnAboutClickHook,{aboutbuttonPressed})

	domethod( self.app.mnlabel1Exit , [
		MUIM_Notify , MUIA_Menuitem_Trigger, MUIV_EveryTime,
		self.app.mnlabel1Exit,
		3,
    MUIM_CallHook , self.btnExitClickHook, self ] )

	domethod( self.app.mnlabel1About , [
		MUIM_Notify , MUIA_Menuitem_Trigger, MUIV_EveryTime,
		self.app.mnlabel1About,
		3,
    MUIM_CallHook , self.btnAboutClickHook, self ] )

  set( self.app.btnUsers, MUIA_Text_Contents,'Unused')
  set( self.app.btnUsers, MUIA_Disabled , MUI_TRUE)

  initialiseCache()
  self.showModal()

  get (self.app.mnlabel1Donotremovefolder1, MUIA_Menuitem_Checked,{v})
  IF v
    StrCopy(tempStr,'1')
  ELSE
    get (self.app.mnlabel1Removefolder1, MUIA_Menuitem_Checked, {v})
    IF v
      StrCopy(tempStr,'2')
    ELSE
      get (self.app.mnlabel1Ask1, MUIA_Menuitem_Checked, {v})
      IF v
        StrCopy(tempStr,'3')
      ELSE
        StrCopy(tempStr,'1')
      ENDIF
    ENDIF
  ENDIF

  get (self.app.mnlabel1Donotremovefolder2, MUIA_Menuitem_Checked,{v})
  IF v
    StrAdd(tempStr,'1')
  ELSE
    get (self.app.mnlabel1Removefolder2, MUIA_Menuitem_Checked, {v})
    IF v
      StrAdd(tempStr,'2')
    ELSE
      get (self.app.mnlabel1Ask2, MUIA_Menuitem_Checked, {v})
      IF v
        StrAdd(tempStr,'3')
      ELSE
        StrAdd(tempStr,'1')
      ENDIF
    ENDIF
  ENDIF
  StrAdd(tempStr,self.acpConfigName)
  SetVar('axSetupEditor_prefs',tempStr,EstrLen(tempStr),GVF_SAVE_VAR OR GVF_GLOBAL_ONLY)

  clearDiskObjectCache()
  deInitialiseCache()

  DisposeLink(self.acpConfigName)

ENDPROC
