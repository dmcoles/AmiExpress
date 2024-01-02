OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','dos/dos','libraries/asl','dos/var'
MODULE 'utility/tagitem' , 'utility/hooks', 'tools/installhook'
MODULE '*axedit','*frmBase','*frmEditList','*frmNodeEdit','*frmConfEdit','*frmSettingsEdit','*frmAccess','*frmCommands','*frmTools','*tooltypes'

EXPORT OBJECT frmMain OF frmBase
  aboutwin:LONG
  missingMandatory:INT
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
  btnToolsClickHook: hook
  mnuAboutMuiClickHook: hook
ENDOBJECT

PROC aboutMui() OF frmMain
  MOVE.L (A1),self
  GetA4()
  IF (self.aboutwin=0)
    self.aboutwin:=AboutmuiObject,
            MUIA_Window_RefWindow, self.winMain,
            MUIA_Aboutmui_Application, self.app.app,
            End
  ENDIF
  IF (self.aboutwin) THEN set(self.aboutwin,MUIA_Window_Open,TRUE)
ENDPROC

PROC exitbuttonPressed() OF frmMain
  MOVE.L (A1),self
  GetA4()
  domethod(self.app.app,[MUIM_Application_ReturnID,MUIA_Window_CloseRequest])
ENDPROC


PROC aboutbuttonPressed() OF frmMain
  MOVE.L (A1),self
  GetA4()
  Mui_RequestA(0,self.winMain,0,'About Ami-Express Setup Tool' ,'*Ok','This tool can assist you in configuring\nalmost every aspect of Ami-Express.\n\n(c)2023 Darren Coles.',0)
ENDPROC

PROC toolsbuttonPressed() OF frmMain
  DEF frmTools:PTR TO frmTools
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW frmTools.create(self.app)
  frmTools.tools(self.acpConfigName)
  END frmTools
  self.wake()
  
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

PROC formShow() OF frmMain
  DEF frmSettingsEdit:PTR TO frmSettingsEdit
  MOVE.L (A1),self
  GetA4()
  IF self.missingMandatory
    NEW frmSettingsEdit.create(self.app)
    frmSettingsEdit.editSystemSettings(self.acpConfigName,TRUE)
    END frmSettingsEdit

  ENDIF
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

PROC canClose() OF frmMain
  DEF tempStr[255]:STRING
  DEF configOk=TRUE

  MOVE.L (A1),self
  GetA4()

  readToolType(self.acpConfigName,'SYSOP_NAME',tempStr)
  IF StrLen(tempStr)=0 THEN configOk:=FALSE

  readToolType(self.acpConfigName,'BBS_LOCATION',tempStr)
  IF StrLen(tempStr)=0 THEN configOk:=FALSE

  readToolType(self.acpConfigName,'BBS_NAME',tempStr)
  IF StrLen(tempStr)=0 THEN configOk:=FALSE

  readToolType(self.acpConfigName,'BBS_GEOGRAPHIC',tempStr)
  IF StrLen(tempStr)=0 THEN configOk:=FALSE

  IF configOk=FALSE
    IF Mui_RequestA(0,self.winMain,0,'Warning' ,'*Ok|Cancel','You have not cofigured the minimal settings to allow Ami-Express to start up.. Are you sure you wish to exit?',0)=0 THEN RETURN FALSE
  ENDIF
  
  IF(FindPort('AE.Master')) AND getChangeFlag()
    Mui_RequestA(0,self.winMain,0,'Warning','*OK','ACP is running and changes have been made.\nA restart of the bbs is recommended.',0)
  ENDIF
  
ENDPROC TRUE

PROC doMain() OF frmMain
  DEF fh,fr:PTR TO filerequester
  DEF tempStr[200]:STRING
  DEF nodeCount
  DEF closeHook:PTR TO hook
  DEF showHook:PTR TO hook

  DEF v

  NEW closeHook
  NEW showHook

  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  installhook( showHook, {formShow})
  self.showHook:=showHook

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
    Mui_RequestA(0,self.winMain,0,'Error' ,'*Ok','Ami-Express setup tool is unable to proceed\nbecause we cannot find the acp.info file',0)
    Throw("ACP","icon")
  ENDIF

  self.aboutwin:=0

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
  self.setupButtonClick(self.app.btnTools,self.btnToolsClickHook,{toolsbuttonPressed})

  installhook( self.mnuAboutMuiClickHook, {aboutMui})

	domethod( self.app.mnlabel1AboutMui, [
		MUIM_Notify , MUIA_Menuitem_Trigger, MUIV_EveryTime,
		self.app.mnlabel1AboutMui,
		3,
    MUIM_CallHook , self.mnuAboutMuiClickHook, self ] )

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

  nodeCount:=readToolTypeInt(self.acpConfigName,'NODES')
  IF nodeCount=-1
    Mui_RequestA(0,self.winMain,0,'Error' ,'*Ok','Ami-Express setup tool is unable to proceed\nbecause the number of nodes is not defined in the acp.info file',0)
    Throw("ACP","icon")
  ENDIF

  self.missingMandatory:=FALSE
  readToolType(self.acpConfigName,'BBS_LOCATION',tempStr)
  IF EstrLen(tempStr)=0 THEN self.missingMandatory:=TRUE
  readToolType(self.acpConfigName,'BBS_NAME',tempStr)
  IF EstrLen(tempStr)=0 THEN self.missingMandatory:=TRUE
  readToolType(self.acpConfigName,'BBS_GEOGRAPHIC',tempStr)
  IF EstrLen(tempStr)=0 THEN self.missingMandatory:=TRUE
  readToolType(self.acpConfigName,'SYSOP_NAME',tempStr)
  IF EstrLen(tempStr)=0 THEN self.missingMandatory:=TRUE
  
  IF (nodeCount>10) AND (FileLength('bbs:utils/rexxdoor')=16068)
    Mui_RequestA(self.app.app,0,0,'Warning','*OK','The version of rexxdoor you are using\nis not compatible with more than 10 nodes.',0)
  ENDIF

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
  
  SetVar('axSetupEditor_prefs',tempStr,-1,GVF_SAVE_VAR OR GVF_GLOBAL_ONLY)
  IF KickVersion(39)=FALSE THEN Execute('Copy env:axSetupEditor_prefs envarc:',0,0)

  clearDiskObjectCache()
  deInitialiseCache()

  DisposeLink(self.acpConfigName)
  END closeHook
  END showHook
ENDPROC
