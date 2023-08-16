OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui','dos'
MODULE 'tools/boopsi','workbench/workbench','icon','intuition/classusr'
MODULE 'utility/tagitem','utility/hooks','tools/installhook','exec/lists'
MODULE '*axedit','*frmBase','*tooltypes','*controls','*miscfuncs','*frmAddComplexItem','*configObject','*/stringlist','*helpText'

EXPORT OBJECT frmConfEdit OF frmBase
  confConfig         : PTR TO CHAR
  controlList        : LONG
  
  strConfNumber      : PTR TO LONG
  strConfName        : PTR TO LONG
  grpConfSettings    : PTR TO LONG
  grpConfPages       : PTR TO LONG
  strConfName2       : PTR TO control
  paConfPath         : PTR TO control
  boolFreeDownloads  : PTR TO control
  strForwardMail     : PTR TO control
  boolForceNewscan     : PTR TO control
  boolUseUsernames   : PTR TO control
  boolUseInternetNames : PTR TO control
  strMenuPrompt      : PTR TO control
  strUploadPrompt    : PTR TO control
  paLocalULPath      : PTR TO control
  intFtpDirDays      : PTR TO control
  strFtpDirName      : PTR TO control
  boolCustomMail     : PTR TO control
  boolNoNewscan      : PTR TO control
  boolDefaultNewscan : PTR TO control
  boolDefaultNewfiles: PTR TO control
  boolDefaultZoom    : PTR TO control
  boolUseRealname    : PTR TO control
  boolShowNewFiles   : PTR TO control
  boolNoNewFiles     : PTR TO control
  boolNoFtpUploads   : PTR TO control
  boolFtpNoDirlist   : PTR TO control
  lvDownloadPaths    : PTR TO LONG
  strDownloadPath    : PTR TO LONG
  lvUploadPaths      : PTR TO LONG
  strUploadPath      : PTR TO LONG
  btnFirstConf        : PTR TO LONG
  btnPrevConf        : PTR TO LONG
  btnNextConf        : PTR TO LONG
  btnLastConf        : PTR TO LONG
  btnAddConf         : PTR TO LONG
  btnCloneConf         : PTR TO LONG
  btnRemoveConf      : PTR TO LONG
  btnConfSave        : PTR TO LONG
  btnConfCancel      : PTR TO LONG
  btnUlPathAdd      : PTR TO LONG
  btnUlPathRemove      : PTR TO LONG
  btnDlPathAdd      : PTR TO LONG
  btnDlPathRemove      : PTR TO LONG
  btnAddMsgbase      : PTR TO LONG
  btnEditMsgbase      : PTR TO LONG
  btnRemoveMsgbase      : PTR TO LONG

  lvMsgBases      : PTR TO LONG

  btnFirstConfClick: hook
  btnLastConfClick: hook
  btnNextConfClick: hook
  btnPrevConfClick: hook
  btnAddConfClick: hook
  btnCloneConfClick: hook
  btnRemoveConfClick: hook
  btnDlPathAddClick: hook
  btnDlPathRemoveClick: hook
  btnUlPathAddClick: hook
  btnUlPathRemoveClick: hook

  btnAddMsgbasesClick: hook
  btnEditMsgbasesClick: hook
  btnRemoveMsgbasesClick: hook

  setChangedHook:hook
  strDlPathOnChange: hook
  strUlPathOnChange: hook
  uploadListOnChange: hook
  downloadListOnChange: hook
  msgbaseListOnChange: hook

  acpName:PTR TO CHAR
  confCount:INT
  currConf:INT
  changed:INT
  newConf:INT
  olddlpathcount:INT
  oldulpathcount:INT
  oldmsgbasecount:INT
  msgbaseLists: PTR TO stdlist
ENDOBJECT

PROC dlPathChange() OF frmConfEdit
  DEF str
  MOVE.L (A1),self
  GetA4()
  get(self.strDownloadPath, MUIA_String_Contents,{str})
  set( self.btnDlPathAdd , MUIA_Disabled , IF StrLen(str)=0 THEN MUI_TRUE ELSE FALSE)
  self.changed:=TRUE
ENDPROC

PROC dlpathlistChange() OF frmConfEdit
  DEF entry
  MOVE.L (A1),self
  GetA4()
  get(self.lvDownloadPaths,MUIA_List_Active,{entry})
  set( self.btnDlPathRemove , MUIA_Disabled , IF entry=MUIV_List_Active_Off THEN MUI_TRUE ELSE FALSE)
ENDPROC

PROC ulPathChange() OF frmConfEdit
  DEF str
  MOVE.L (A1),self
  GetA4()
  get(self.strUploadPath, MUIA_String_Contents,{str})
  set( self.btnUlPathAdd , MUIA_Disabled , IF StrLen(str)=0 THEN MUI_TRUE ELSE FALSE)
  self.changed:=TRUE
ENDPROC

PROC ulpathlistChange() OF frmConfEdit
  DEF entry
  MOVE.L (A1),self
  GetA4()
  get(self.lvUploadPaths,MUIA_List_Active,{entry})
  set( self.btnUlPathRemove , MUIA_Disabled , IF entry=MUIV_List_Active_Off THEN MUI_TRUE ELSE FALSE)
ENDPROC

PROC msgBaseChange() OF frmConfEdit
  DEF entry
  MOVE.L (A1),self
  GetA4()
  get(self.lvMsgBases,MUIA_List_Active,{entry})
  set( self.btnEditMsgbase , MUIA_Disabled , IF entry=MUIV_List_Active_Off THEN MUI_TRUE ELSE FALSE)
  set( self.btnRemoveMsgbase , MUIA_Disabled , IF entry=MUIV_List_Active_Off THEN MUI_TRUE ELSE FALSE)
ENDPROC

PROC ulpathItemAdd() OF frmConfEdit
  DEF str
  MOVE.L (A1),self
  GetA4()
  
  get(self.strUploadPath, MUIA_String_Contents,{str})
  domethod( self.lvUploadPaths , [ MUIM_List_InsertSingle , str , MUIV_List_Insert_Bottom ] )
  get (self.strUploadPath,MUIA_Popstring_String,{str})
  set(str, MUIA_String_Contents,'')
  set( self.btnConfSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC ulpathItemRemove() OF frmConfEdit
  DEF entry
  MOVE.L (A1),self
  GetA4()

  get(self.lvUploadPaths,MUIA_List_Active,{entry})

  domethod(self.lvUploadPaths, [ MUIM_List_Remove, entry] )
  set( self.btnConfSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC dlpathItemAdd() OF frmConfEdit
  DEF str
  MOVE.L (A1),self
  GetA4()

  get(self.strDownloadPath, MUIA_String_Contents,{str})
  domethod( self.lvDownloadPaths , [ MUIM_List_InsertSingle , str , MUIV_List_Insert_Bottom ] )
  get (self.strDownloadPath,MUIA_Popstring_String,{str})
  set(str, MUIA_String_Contents,'')
  
  set( self.btnConfSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC dlpathItemRemove() OF frmConfEdit
  DEF entry
  MOVE.L (A1),self
  GetA4()

  get(self.lvDownloadPaths,MUIA_List_Active,{entry})

  domethod(self.lvDownloadPaths, [ MUIM_List_Remove, entry] )
  set( self.btnConfSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC msgBaseItemAdd() OF frmConfEdit
  DEF str,res,v1,v2
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF msgbase:PTR TO msgbase
  MOVE.L (A1),self
  GetA4()

  NEW frmAddComplexItem.create(self.app)
  res,v1,msgbase:=frmAddComplexItem.editMsgbase(self.acpName,'',NIL)
  IF res
    domethod( self.lvMsgBases , [ MUIM_List_InsertSingle , v1 , MUIV_List_Insert_Bottom ] )
    self.msgbaseLists.add(msgbase)
    self.changed:=TRUE
    set( self.btnConfSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddComplexItem 
ENDPROC

PROC msgBaseItemEdit() OF frmConfEdit
  DEF str,res,v1,v2,entry
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF msgbase:PTR TO msgbase
  DEF msgbase2:PTR TO msgbase
  DEF i

  MOVE.L (A1),self
  GetA4()

  NEW frmAddComplexItem.create(self.app)

  get(self.lvMsgBases,MUIA_List_Active,{entry})
  domethod(self.lvMsgBases,[MUIM_List_GetEntry,entry,{str}])

  msgbase2:=self.msgbaseLists.item(entry)
  
  res,v1,msgbase:=frmAddComplexItem.editMsgbase(self.acpName,str,msgbase2)
  IF res
    domethod( self.lvMsgBases , [ MUIM_List_InsertSingle , v1 , entry+1 ] )
    domethod( self.lvMsgBases , [ MUIM_List_Remove, entry ] )
    self.changed:=TRUE
    set( self.btnConfSave , MUIA_Disabled , FALSE)

    //copy protocol to protocol2
    StrCopy(msgbase2.location,msgbase.location)
    msgbase2.extSend:=msgbase.extSend
    msgbase2.username:=msgbase.username
    msgbase2.realname:=msgbase.realname
    msgbase2.internetname:=msgbase.internetname
  ENDIF
  END frmAddComplexItem
ENDPROC

PROC msgBaseItemRemove() OF frmConfEdit
  DEF entry,v1
  DEF msgbase:PTR TO msgbase
  MOVE.L (A1),self
  GetA4()

  get(self.lvMsgBases,MUIA_List_Active,{entry})

  domethod(self.lvMsgBases,[MUIM_List_GetEntry,entry,{v1}])

  msgbase:=self.msgbaseLists.item(entry)
  END msgbase
  self.msgbaseLists.remove(entry)
  domethod( self.lvMsgBases , [ MUIM_List_Remove, entry] )
  set( self.btnConfSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC


PROC create(app:PTR TO app_obj) OF frmConfEdit
  DEF list,group
  SUPER self.create(app)
  self.winMain:=app.wi_conf_edit

  self.strConfName:=app.strConfName
  self.strConfNumber:=app.strConfNum
  self.btnFirstConf:=app.btnFirstConf
  self.btnPrevConf:=app.btnPrevConf
  self.btnNextConf:=app.btnNextConf
  self.btnLastConf:=app.btnLastConf
  self.btnAddConf:=app.btnAddConf
  self.btnCloneConf:=app.btnConfClone
  self.btnRemoveConf:=app.btnRemoveConf
  self.btnConfSave:=app.btnSaveConf
  self.btnConfCancel:=app.btnCancelConf
  
  self.btnAddMsgbase:=app.btnMsgbaseAdd
  self.btnEditMsgbase:=app.btnMsgbaseEdit
  self.btnRemoveMsgbase:=app.btnMsgbaseDelete

  self.lvMsgBases:=app.lvMsgbases

  self.lvDownloadPaths:=app.lv_download_paths
  self.strDownloadPath:=app.pa_downloadpath
  self.lvUploadPaths:=app.lv_upload_paths
  self.strUploadPath:=app.pa_uploadpath

  self.btnUlPathAdd:=app.bt_ulpath_add
  self.btnUlPathRemove:=app.bt_ulpath_remove
  self.btnDlPathAdd:=app.bt_dlpath_add
  self.btnDlPathRemove:=app.bt_dlpath_remove

  self.grpConfPages:=app.gr_conf_pages
  get(app.gr_conf_settings,MUIA_Scrollgroup_Contents,{group})
  self.grpConfSettings:=group

  set(self.grpConfSettings, MUIA_Group_Columns , 4)
  set(self.winMain,MUIA_Window_Width,MUIV_Window_Width_Screen(75))
  
  get(self.lvDownloadPaths,MUIA_Listview_List,{list})
  set(list,MUIA_List_ConstructHook,MUIV_List_ConstructHook_String)
  set(list,MUIA_List_DestructHook,MUIV_List_DestructHook_String)

  get(self.lvUploadPaths,MUIA_Listview_List,{list})
  set(list,MUIA_List_ConstructHook,MUIV_List_ConstructHook_String)
  set(list,MUIA_List_DestructHook,MUIV_List_DestructHook_String)
  
  get(self.lvMsgBases,MUIA_Listview_List,{list})
  set(list,MUIA_List_ConstructHook,MUIV_List_ConstructHook_String)
  set(list,MUIA_List_DestructHook,MUIV_List_DestructHook_String)

ENDPROC

PROC cloneNewConf() OF frmConfEdit
  DEF tempStr[255]:STRING
  MOVE.L (A1),self
  GetA4()

  IF self.loadConf(self.currConf)
    set(self.strConfName, MUIA_String_Contents,'**NEW**')
    

    self.changed:=TRUE
    self.newConf:=TRUE
    self.confCount:=self.confCount+1
    self.currConf:=self.confCount

    StringF(tempStr,'\d',self.currConf)
    set(self.strConfNumber, MUIA_String_Contents,tempStr)

    set( self.btnPrevConf, MUIA_Disabled , FALSE)
    set( self.btnNextConf, MUIA_Disabled , MUI_TRUE)
    set( self.btnRemoveConf, MUIA_Disabled , FALSE)


    set( self.btnConfSave,MUIA_Disabled,FALSE)
    set( self.btnAddConf,MUIA_Disabled,MUI_TRUE)
    set( self.btnCloneConf,MUIA_Disabled,MUI_TRUE)
  ENDIF
ENDPROC

PROC createNewConf() OF frmConfEdit
  MOVE.L (A1),self
  GetA4()

  IF self.loadConf(self.confCount+1)
    set(self.strConfName, MUIA_String_Contents,'**NEW**')
    self.changed:=TRUE
    self.newConf:=TRUE
    self.confCount:=self.confCount+1
    set( self.btnConfSave,MUIA_Disabled,FALSE)
    set( self.btnAddConf,MUIA_Disabled,MUI_TRUE)
    set( self.btnCloneConf,MUIA_Disabled,MUI_TRUE)
  ENDIF
ENDPROC

PROC deleteConfFolder(conf) OF frmConfEdit
  DEF deleteStr[255]:STRING
  DEF confPath[255]:STRING
  DEF tempStr[255]:STRING

  StringF(tempStr,'LOCATION.\d',conf)
  readToolType(self.confConfig,tempStr,confPath)
  IF EstrLen(confPath)>0
    StringF(deleteStr,'DELETE \s ALL',confPath)
    Execute(deleteStr,0,0)

    StringF(deleteStr,'DELETE \s.info ALL',confPath)
    Execute(deleteStr,0,0)
  ENDIF
ENDPROC

PROC deleteCurrentConf() OF frmConfEdit
  DEF deleteOption
  DEF tempStr[255]:STRING
  MOVE.L (A1),self
  GetA4()

  get (self.app.mnlabel1Donotremovefolder1 , MUIA_Menuitem_Checked, {deleteOption})
  IF deleteOption
    deleteOption:=1
  ELSE
    get (self.app.mnlabel1Removefolder1, MUIA_Menuitem_Checked, {deleteOption})
    IF deleteOption
      deleteOption:=2
    ELSE
      deleteOption:=3
    ENDIF
  ENDIF

  IF self.deleteConfWarning()=FALSE THEN RETURN

  IF self.loadConf(self.confCount-1)
    self.confCount:=self.currConf
    
    //update confconfig
    StringF(tempStr,'\d',self.confCount)
    writeToolType(self.confConfig,'NCONFS',tempStr)

    StringF(tempStr,'NAME.\d',self.currConf+1)
    deleteToolType(self.confConfig,tempStr)

    StringF(tempStr,'LOCATION.\d',self.currConf+1)
    deleteToolType(self.confConfig,tempStr)

    set( self.btnNextConf, MUIA_Disabled , MUI_TRUE)
    set( self.btnRemoveConf, MUIA_Disabled , (self.currConf<self.confCount) OR (self.currConf=1))
    IF deleteOption=3
      IF self.deleteConfFolderRequest() THEN deleteOption:=2
    ENDIF
    
    IF deleteOption=2 THEN self.deleteConfFolder(self.currConf+1)
  ENDIF
  
ENDPROC

PROC setChangedFlag() OF frmConfEdit
  MOVE.L (A1),self
  GetA4()
  IF self.changed=FALSE
    self.changed:=TRUE
    set( self.btnConfSave,MUIA_Disabled,FALSE)
  ENDIF
ENDPROC

PROC addNotifications() OF frmConfEdit
  domethod( self.btnConfCancel , [
    MUIM_Notify , MUIA_Pressed , FALSE ,
    self.app.app,
    2 ,
    MUIM_Application_ReturnID ,  MUIA_Window_CloseRequest ] )

  domethod( self.btnConfSave , [
    MUIM_Notify , MUIA_Pressed , FALSE ,
    self.app.app,
    2 ,
    MUIM_Application_ReturnID ,  ID_SAVE ] )

  domethod( self.strDownloadPath  , [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.strDlPathOnChange, self] )
  installhook( self.strDlPathOnChange, {dlPathChange})

  domethod( self.strUploadPath  , [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.strUlPathOnChange, self] )
  installhook( self.strUlPathOnChange, {ulPathChange})

  domethod( self.lvDownloadPaths , [
    MUIM_Notify ,  MUIA_List_Active , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.downloadListOnChange, self] )
  installhook( self.downloadListOnChange, {dlpathlistChange})

  domethod( self.lvUploadPaths , [
    MUIM_Notify ,  MUIA_List_Active , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.uploadListOnChange, self] )
  installhook( self.uploadListOnChange, {ulpathlistChange})

  domethod( self.lvMsgBases , [
    MUIM_Notify ,  MUIA_List_Active , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.msgbaseListOnChange, self] )
  installhook( self.msgbaseListOnChange, {msgBaseChange})

  self.setupButtonClick(self.btnFirstConf,self.btnFirstConfClick,{firstConf})
  self.setupButtonClick(self.btnLastConf,self.btnLastConfClick,{lastConf})
  self.setupButtonClick(self.btnNextConf,self.btnNextConfClick,{nextConf})
  self.setupButtonClick(self.btnPrevConf,self.btnPrevConfClick,{prevConf})
  self.setupButtonClick(self.btnAddConf,self.btnAddConfClick,{createNewConf})
  self.setupButtonClick(self.btnCloneConf,self.btnCloneConfClick,{cloneNewConf})
  self.setupButtonClick(self.btnRemoveConf,self.btnRemoveConfClick,{deleteCurrentConf})

  self.setupButtonClick(self.btnUlPathAdd,self.btnUlPathAddClick,{ulpathItemAdd})
  self.setupButtonClick(self.btnUlPathRemove,self.btnUlPathRemoveClick,{ulpathItemRemove})
  self.setupButtonClick(self.btnDlPathAdd,self.btnDlPathAddClick,{dlpathItemAdd})
  self.setupButtonClick(self.btnDlPathRemove,self.btnDlPathRemoveClick,{dlpathItemRemove})
  self.setupButtonClick(self.btnAddMsgbase,self.btnAddMsgbasesClick,{msgBaseItemAdd})
  self.setupButtonClick(self.btnEditMsgbase,self.btnEditMsgbasesClick,{msgBaseItemEdit})
  self.setupButtonClick(self.btnRemoveMsgbase,self.btnRemoveMsgbasesClick,{msgBaseItemRemove})

ENDPROC

PROC removeNotifications() OF frmConfEdit
  domethod(self.btnConfCancel,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnConfSave,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnFirstConf,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnLastConf,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnNextConf,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnPrevConf,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnAddConf,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnCloneConf,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnRemoveConf,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnUlPathAdd,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnAddMsgbase,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnEditMsgbase,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnRemoveMsgbase,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnUlPathRemove,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnDlPathAdd,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnDlPathRemove,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.strDownloadPath,[MUIM_KillNotify,MUIA_String_Contents])
  domethod(self.strUploadPath,[MUIM_KillNotify,MUIA_String_Contents])
  domethod(self.lvDownloadPaths ,[MUIM_KillNotify,MUIA_List_Active])
  domethod(self.lvUploadPaths ,[MUIM_KillNotify,MUIA_List_Active])
  domethod(self.lvMsgBases,[MUIM_KillNotify,MUIA_List_Active])
ENDPROC

PROC addControls() OF frmConfEdit
  DEF control: PTR TO control

  NEW control.createString('bConference Name',CONF_NAME,self.app.app,self.setChangedHook,self)
  self.strConfName2:=control

  NEW control.createDirSelect('bConference Path',CONF_PATH,self.app.app,self.setChangedHook,self)
  self.paConfPath:=control

  NEW control.createCheckBox('Free Downloads',CONF_FREE_DL,self.app.app,self.setChangedHook,self)
  self.boolFreeDownloads:=control

  NEW control.createString('Forward Systop Mail',CONF_FORWARD_MAIL,self.app.app,self.setChangedHook,self)
  self.strForwardMail:=control

  NEW control.createCheckBox('Always Do Mail Scan',CONF_FORCE_MSCAN,self.app.app,self.setChangedHook,self)
  self.boolForceNewscan:=control

  NEW control.createCheckBox('Use Usernames',CONF_USE_USERNAMES,self.app.app,self.setChangedHook,self)
  self.boolUseUsernames:=control
  
  NEW control.createCheckBox('Use Internet Names',CONF_USE_INETNAMES,self.app.app,self.setChangedHook,self)
  self.boolUseInternetNames:=control

  NEW control.createCheckBox('Use Real Names',CONF_USE_REALNAMES,self.app.app,self.setChangedHook,self)
  self.boolUseRealname:=control 

  NEW control.createString('Menu Prompt',CONF_MENU_PROMPT,self.app.app,self.setChangedHook,self)
  self.strMenuPrompt:=control

  NEW control.createString('Upload Prompt',CONF_UPLOAD_PROMPT,self.app.app,self.setChangedHook,self)
  self.strUploadPrompt:=control

  NEW control.createDirSelect('Local Upload Path',CONF_LOCAL_UPLOAD_PATH,self.app.app,self.setChangedHook,self)
  self.paLocalULPath:=control

  NEW control.createStringInt('FTP Dir Days',FTP_DIR_DAYS,self.app.app,self.setChangedHook,self)
  self.intFtpDirDays:=control

  NEW control.createString('FTP Dir Name',CONF_FTP_DIR_NAME,self.app.app,self.setChangedHook,self)
  self.strFtpDirName:=control

  NEW control.createCheckBox('Custom Mail',CONF_CUSTOM_MAIL,self.app.app,self.setChangedHook,self)
  self.boolCustomMail:=control

  NEW control.createCheckBox('Never Do Mailscan',CONF_NEVER_MSCAN,self.app.app,self.setChangedHook,self)
  self.boolNoNewscan:=control

  NEW control.createCheckBox('Default New Mailscan',CONF_DEFAULT_NEW_MSCAN,self.app.app,self.setChangedHook,self)
  self.boolDefaultNewscan:=control 
  
  NEW control.createCheckBox('Default New Filescan',CONF_DEFAULT_NEW_FSCAN,self.app.app,self.setChangedHook,self)
  self.boolDefaultNewfiles:=control 
  
  NEW control.createCheckBox('Default Zoom',CONF_DEFAULT_ZOOM,self.app.app,self.setChangedHook,self)
  self.boolDefaultZoom:=control 
 
  NEW control.createCheckBox('Always Show New Files',CONF_ALWAYS_NEW_FILES,self.app.app,self.setChangedHook,self)
  self.boolShowNewFiles:=control 

  NEW control.createCheckBox('Never Show New Files',CONF_NEVER_NEW_FILES,self.app.app,self.setChangedHook,self)
  self.boolNoNewFiles:=control 

  NEW control.createCheckBox('Disable FTP Uploads',CONF_FTP_UL_DISABLE,self.app.app,self.setChangedHook,self)
  self.boolNoFtpUploads:=control 
  
  NEW control.createCheckBox('Ftp Dirlist',CONF_FTP_DIRLIST,self.app.app,self.setChangedHook,self)
  self.boolFtpNoDirlist:=control 

  self.controlList:=[self.strConfName2,self.paConfPath,self.strForwardMail,self.strMenuPrompt,self.strUploadPrompt,self.paLocalULPath,
                     self.intFtpDirDays,self.strFtpDirName,self.boolFreeDownloads,self.boolUseUsernames,self.boolUseRealname,self.boolUseInternetNames,
                     self.boolCustomMail,self.boolDefaultNewscan,self.boolDefaultNewfiles,self.boolDefaultZoom,self.boolForceNewscan,
                     self.boolShowNewFiles,self.boolNoNewscan,self.boolNoNewFiles,self.boolNoFtpUploads,self.boolFtpNoDirlist]


  domethod(self.grpConfSettings,[MUIM_Group_InitChange])
  ForAll({control},self.controlList,`control.addToGroup(self.grpConfSettings))
  domethod(self.grpConfSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpConfSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpConfSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpConfSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpConfSettings,[MUIM_Group_ExitChange])
ENDPROC

PROC freeControl(control:PTR TO control) OF frmConfEdit
  control.removeFromGroup(self.grpConfSettings)
  END control
ENDPROC

PROC removeControls() OF frmConfEdit
  DEF list:PTR TO lh,state,obj
  DEF control:PTR TO control
  
  domethod(self.grpConfSettings,[MUIM_Group_InitChange])
  ForAll({control},self.controlList,`self.freeControl(control))
  
  get(self.grpConfSettings,MUIA_Group_ChildList,{list})
  state:=list.head
  WHILE (obj:=NextObject({state}))
    domethod(self.grpConfSettings,[OM_REMMEMBER,obj])
    Mui_DisposeObject(obj)
  ENDWHILE
  domethod(self.grpConfSettings,[MUIM_Group_ExitChange])
ENDPROC

PROC firstConf() OF frmConfEdit
  MOVE.L (A1),self
  GetA4()
  self.loadConf(1)
ENDPROC

PROC prevConf() OF frmConfEdit
  MOVE.L (A1),self
  GetA4()
  self.loadConf(self.currConf-1)
ENDPROC

PROC nextConf() OF frmConfEdit
  MOVE.L (A1),self
  GetA4()
  self.loadConf(self.currConf+1)
ENDPROC

PROC lastConf() OF frmConfEdit
  MOVE.L (A1),self
  GetA4()
  self.loadConf(self.confCount)
ENDPROC

PROC canClose() OF frmConfEdit
  MOVE.L (A1),self
  GetA4()
  IF self.changed
    IF self.unsavedChangesWarning()=0 THEN RETURN FALSE
  ENDIF
ENDPROC TRUE

PROC unsavedChangesWarning() OF frmConfEdit
  DEF win
  get(self.winMain,MUIA_Window_Window,{win})
  IF EasyRequestArgs( win , [ 20 , 0 ,
                  'Unsaved changes' ,
                  'You have unsaved changes,\nif you continue you will lose them.',
                  '_OK|_CANCEL' ] , NIL , NIL )=0 THEN RETURN FALSE
ENDPROC TRUE

PROC deleteConfWarning() OF frmConfEdit
  DEF win
  get(self.winMain,MUIA_Window_Window,{win})
    IF EasyRequestArgs(	win , [ 20 , 0 ,
									'Warning' ,
									'Are you sure you wish to delete this conference?',
									'_Yes|No' ] , NIL , NIL )=0 THEN RETURN FALSE
ENDPROC TRUE

PROC deleteConfFolderRequest() OF frmConfEdit
  DEF win
  get(self.winMain,MUIA_Window_Window,{win})
    IF EasyRequestArgs(	win , [ 20 , 0 ,
									'Warning' ,
									'Do you wish to also remove the Conf folder contents?',
									'_Yes|No' ] , NIL , NIL )=0 THEN RETURN FALSE
ENDPROC TRUE

PROC saveChanges() OF frmConfEdit
  DEF confPath[255]:STRING
  DEF tempStr[255]:STRING
  DEF temppath[255]:STRING
  DEF window,count,i,entry
  DEF folderStr[255]:STRING
  DEF msgbase:PTR TO msgbase

  MOVE.L (A1),self
  GetA4()

  get(self.winMain,MUIA_Window_Window,{window})

  fullTrim(self.strConfName2.getValue(),tempStr)
  IF EstrLen(tempStr)=0
    EasyRequestArgs(  window , [ 20 , 0 ,
                  'Error' ,
                  'Conference Name is a mandatory field',
                  '_OK' ] , NIL , NIL )
    RETURN
  ENDIF

  fullTrim(self.paConfPath.getValue(),tempStr)
  IF EstrLen(tempStr)=0
    EasyRequestArgs(  window , [ 20 , 0 ,
                  'Error' ,
                  'Conference Path is a mandatory field',
                  '_OK' ] , NIL , NIL )
    RETURN
  ENDIF


  self.sleep()
  StringF(tempStr,'\d',self.confCount)
  writeToolType(self.confConfig,'NCONFS',tempStr)

  StringF(tempStr,'NAME.\d',self.currConf)
  writeToolType(self.confConfig,tempStr,self.strConfName2.getValue())

  StringF(tempStr,'LOCATION.\d',self.currConf)
  StrCopy(confPath,self.paConfPath.getValue())

  writeToolType(self.confConfig,tempStr,confPath)
  IF confPath[StrLen(confPath)-1]="/" THEN SetStr(confPath,StrLen(confPath)-1)
 
   IF (self.newConf)
    //create the folder structure
    makeDir(confPath)
    StrCopy(folderStr,confPath)
    AddPart(folderStr,'hold',255)
    SetStr(folderStr)
    makeDir(folderStr)
    StrCopy(folderStr,confPath)
    AddPart(folderStr,'lcfiles',255)
    SetStr(folderStr)
    makeDir(folderStr)
    StrCopy(folderStr,confPath)
    AddPart(folderStr,'msgbase',255)
    SetStr(folderStr)
    makeDir(folderStr)
    StrCopy(folderStr,confPath)
    AddPart(folderStr,'partupload',255)
    SetStr(folderStr)
    makeDir(folderStr)
    StrCopy(folderStr,confPath)
    AddPart(folderStr,'vote',255)
    SetStr(folderStr)
    makeDir(folderStr)

    get(self.lvUploadPaths,MUIA_List_Entries,{count})  
    FOR i:=1 TO count
      domethod(self.lvUploadPaths,[MUIM_List_GetEntry,i-1,{entry}])
      makeDir(entry)
    ENDFOR

    get(self.lvDownloadPaths,MUIA_List_Entries,{count})  
    FOR i:=1 TO count
      domethod(self.lvDownloadPaths,[MUIM_List_GetEntry,i-1,{entry}])
      makeDir(entry)
    ENDFOR

    get(self.lvMsgBases,MUIA_List_Entries,{count})  

    FOR i:=1 TO count
      msgbase:=self.msgbaseLists.item(i-1)
      IF EstrLen(msgbase.location)>0
        makeDir(msgbase.location)
      ENDIF
    ENDFOR
    
  ENDIF

  IF self.boolFreeDownloads.getValue() THEN writeToolType(confPath,'FREEDOWNLOADS') ELSE deleteToolType(confPath,'FREEDOWNLOADS')  
    
  writeToolType(confPath,'FORWARDMAIL',self.strForwardMail.getValue())

  IF self.boolForceNewscan.getValue() THEN writeToolType(confPath,'FORCE_NEWSCAN') ELSE deleteToolType(confPath,'FORCE_NEWSCAN')  
  IF self.boolUseUsernames.getValue() THEN writeToolType(confPath,'USERNAME') ELSE deleteToolType(confPath,'USERNAME')  
  IF self.boolUseInternetNames.getValue() THEN writeToolType(confPath,'INTERNETNAME') ELSE deleteToolType(confPath,'INTERNETNAME')  

  writeToolType(confPath,'MENU_PROMPT',self.strMenuPrompt.getValue())
  writeToolType(confPath,'ULPROMPT',self.strUploadPrompt.getValue())
  writeToolType(confPath,'LOCAL_UPLOAD_PATH',self.paLocalULPath.getValue())
  writeToolType(confPath,'FTP_DIR_DAYS',self.intFtpDirDays.getValue())
  writeToolType(confPath,'FTPDIRNAME',self.strFtpDirName.getValue())

  
  IF self.boolCustomMail.getValue() THEN writeToolType(confPath,'CUSTOM') ELSE deleteToolType(confPath,'CUSTOM')
  IF self.boolNoNewscan.getValue() THEN writeToolType(confPath,'NO_NEWSCAN') ELSE deleteToolType(confPath,'NO_NEWSCAN')
  IF self.boolDefaultNewscan.getValue() THEN writeToolType(confPath,'DEFAULT_NEWSCAN') ELSE deleteToolType(confPath,'DEFAULT_NEWSCAN')
  IF self.boolDefaultNewfiles.getValue() THEN writeToolType(confPath,'DEFAULT_NEW_FILES') ELSE deleteToolType(confPath,'DEFAULT_NEW_FILES')
  IF self.boolDefaultZoom.getValue() THEN writeToolType(confPath,'DEFAULT_ZOOM') ELSE deleteToolType(confPath,'DEFAULT_ZOOM')
  IF self.boolUseRealname.getValue() THEN writeToolType(confPath,'REALNAME') ELSE deleteToolType(confPath,'REALNAME')
  IF self.boolShowNewFiles.getValue() THEN writeToolType(confPath,'SHOW_NEW_FILES') ELSE deleteToolType(confPath,'SHOW_NEW_FILES')
  IF self.boolNoNewFiles.getValue() THEN writeToolType(confPath,'NO_NEW_FILES') ELSE deleteToolType(confPath,'NO_NEW_FILES')
  IF self.boolNoFtpUploads.getValue() THEN writeToolType(confPath,'NO_FTP_UPLOADS') ELSE deleteToolType(confPath,'NO_FTP_UPLOADS')
  IF self.boolFtpNoDirlist.getValue() THEN writeToolType(confPath,'FTP_NO_DIRLIST') ELSE deleteToolType(confPath,'FTP_NO_DIRLIST')

  get(self.lvDownloadPaths,MUIA_List_Entries,{count})  
  FOR i:=1 TO count
    domethod(self.lvDownloadPaths,[MUIM_List_GetEntry,i-1,{entry}])
    StringF(temppath,'DLPATH.\d',i)
    writeToolType(confPath,temppath,entry)
  ENDFOR
  
  FOR i:=count+1 TO self.olddlpathcount
    StringF(temppath,'DLPATH.\d',i)
    deleteToolType(confPath,temppath)
  ENDFOR

  get(self.lvUploadPaths,MUIA_List_Entries,{count})  
  FOR i:=1 TO count
    domethod(self.lvUploadPaths,[MUIM_List_GetEntry,i-1,{entry}])
    StringF(temppath,'ULPATH.\d',i)
    writeToolType(confPath,temppath,entry)
  ENDFOR
  
  FOR i:=count+1 TO self.oldulpathcount
    StringF(temppath,'ULPATH.\d',i)
    deleteToolType(confPath,temppath)
  ENDFOR
  
  StrCopy(temppath,confPath)
  AddPart(temppath,'msgbases',255)
  SetStr(temppath)
  get(self.lvMsgBases,MUIA_List_Entries,{count})  

  FOR i:=1 TO count
    domethod(self.lvMsgBases,[MUIM_List_GetEntry,i-1,{entry}])   
    
    StringF(tempStr,'NAME.\d',i)
    IF (count=1) AND StrCmp(entry,'Default')
      writeToolType(temppath,tempStr,'')
    ELSE
      writeToolType(temppath,tempStr,entry)
    ENDIF
    
    msgbase:=self.msgbaseLists.item(i-1)
    StringF(tempStr,'LOCATION.\d',i)
    writeToolType(temppath,tempStr,msgbase.location)
    StringF(tempStr,'EXTSEND.\d',i)
    writeToolType(temppath,tempStr,IF msgbase.extSend THEN -1 ELSE FALSE)
    StringF(tempStr,'USERNAME.\d',i)
    writeToolType(temppath,tempStr,IF msgbase.username THEN -1 ELSE FALSE)
    StringF(tempStr,'REALNAME.\d',i)
    writeToolType(temppath,tempStr,IF msgbase.realname THEN -1 ELSE FALSE)
    StringF(tempStr,'INTERNETNAME.\d',i)
    writeToolType(temppath,tempStr,IF msgbase.internetname THEN -1 ELSE FALSE)
  ENDFOR

  FOR i:=count+1 TO self.oldmsgbasecount
    StringF(tempStr,'NAME.\d',i)
    deleteToolType(temppath,tempStr)
    StringF(tempStr,'LOCATION.\d',i)
    deleteToolType(temppath,tempStr)
    StringF(tempStr,'EXTSEND.\d',i)
    deleteToolType(temppath,tempStr)
    StringF(tempStr,'USERNAME.\d',i)
    deleteToolType(temppath,tempStr)
    StringF(tempStr,'REALNAME.\d',i)
    deleteToolType(temppath,tempStr)
    StringF(tempStr,'INTERNETNAME.\d',i)
    deleteToolType(temppath,tempStr)
  ENDFOR
  saveCachedChanges()

  
  set( self.btnConfSave,MUIA_Disabled,MUI_TRUE)
  set( self.btnAddConf,MUIA_Disabled,FALSE)
  set( self.btnCloneConf,MUIA_Disabled,FALSE)
  self.changed:=FALSE
  self.newConf:=FALSE
  self.wake()

ENDPROC

PROC loadConf(conf) OF frmConfEdit
  DEF tempStr[255]:STRING
  DEF bbsPath[255]:STRING
  DEF confName[100]:STRING
  DEF confPath[255]:STRING
  DEF temppath[255]:STRING
  DEF tempTooltype[255]:STRING
  DEF i,val
  DEF msgbase:PTR TO msgbase
  
  IF self.changed
    IF self.unsavedChangesWarning()=FALSE THEN RETURN FALSE
  ENDIF
  
  IF self.newConf THEN self.confCount:=self.confCount-1
  self.currConf:=conf

  StringF(tempStr,'NAME.\d',conf)
  readToolType(self.confConfig,tempStr,confName)

  StringF(tempStr,'LOCATION.\d',conf)
  readToolType(self.confConfig,tempStr,confPath)

  StringF(tempStr,'\d',conf)
  set(self.strConfNumber, MUIA_String_Contents,tempStr)
  set(self.strConfName, MUIA_String_Contents,confName)
  self.strConfName2.setValue(confName)
  self.paConfPath.setValue(confPath)
  set( self.btnPrevConf, MUIA_Disabled , conf<=1)
  set( self.btnNextConf, MUIA_Disabled , conf>=self.confCount)
  set( self.btnRemoveConf, MUIA_Disabled , (conf<self.confCount) OR (conf=1))

  IF confPath[StrLen(confPath)-1]="/" THEN SetStr(confPath,StrLen(confPath)-1)

  self.boolFreeDownloads.setValue(IF checkToolTypeExists(confPath,'FREEDOWNLOADS') THEN MUI_TRUE ELSE FALSE)
    
  readToolType(confPath,'FORWARDMAIL',tempStr)
  self.strForwardMail.setValue(tempStr)
  self.boolForceNewscan.setValue(IF checkToolTypeExists(confPath,'FORCE_NEWSCAN') THEN MUI_TRUE ELSE FALSE)
  self.boolUseUsernames.setValue(IF checkToolTypeExists(confPath,'USERNAME') THEN MUI_TRUE ELSE FALSE)
  self.boolUseInternetNames.setValue(IF checkToolTypeExists(confPath,'INTERNETNAME') THEN MUI_TRUE ELSE FALSE)
  readToolType(confPath,'MENU_PROMPT',tempStr)
  self.strMenuPrompt.setValue(tempStr)

  readToolType(confPath,'ULPROMPT',tempStr)
  self.strUploadPrompt.setValue(tempStr)

  readToolType(confPath,'LOCAL_UPLOAD_PATH',tempStr)
  self.paLocalULPath.setValue(tempStr)

  val:=readToolTypeInt(confPath,'FTP_DIR_DAYS')
  self.intFtpDirDays.setValue(val)

  readToolType(confPath,'FTPDIRNAME',tempStr)
  self.strFtpDirName.setValue(tempStr)

  self.boolCustomMail.setValue(IF checkToolTypeExists(confPath,'CUSTOM') THEN MUI_TRUE ELSE FALSE)
  self.boolNoNewscan.setValue(IF checkToolTypeExists(confPath,'NO_NEWSCAN') THEN MUI_TRUE ELSE FALSE)
  self.boolDefaultNewscan.setValue(IF checkToolTypeExists(confPath,'DEFAULT_NEWSCAN') THEN MUI_TRUE ELSE FALSE)
  self.boolDefaultNewfiles.setValue(IF checkToolTypeExists(confPath,'DEFAULT_NEW_FILES') THEN MUI_TRUE ELSE FALSE)
  self.boolDefaultZoom.setValue(IF checkToolTypeExists(confPath,'DEFAULT_ZOOM') THEN MUI_TRUE ELSE FALSE)
  self.boolUseRealname.setValue(IF checkToolTypeExists(confPath,'REALNAME') THEN MUI_TRUE ELSE FALSE)
  self.boolShowNewFiles.setValue(IF checkToolTypeExists(confPath,'SHOW_NEW_FILES') THEN MUI_TRUE ELSE FALSE)
  self.boolNoNewFiles.setValue(IF checkToolTypeExists(confPath,'NO_NEW_FILES') THEN MUI_TRUE ELSE FALSE)
  self.boolNoFtpUploads.setValue(IF checkToolTypeExists(confPath,'NO_FTP_UPLOADS') THEN MUI_TRUE ELSE FALSE)
  self.boolFtpNoDirlist.setValue(IF checkToolTypeExists(confPath,'FTP_NO_DIRLIST') THEN MUI_TRUE ELSE FALSE)
 
  domethod( self.lvDownloadPaths , [ MUIM_List_Clear] )
  domethod( self.lvUploadPaths , [ MUIM_List_Clear] )
  
  i:=1
  REPEAT
    StringF(temppath,'DLPATH.\d',i)
    readToolType(confPath,temppath,tempStr)
    IF EstrLen(tempStr)>0
      domethod( self.lvDownloadPaths , [ MUIM_List_InsertSingle , tempStr , MUIV_List_Insert_Bottom ] )
      i++
    ENDIF
  UNTIL EstrLen(tempStr)=0
  self.olddlpathcount:=i
  
  i:=1
  REPEAT
    StringF(temppath,'ULPATH.\d',i)
    readToolType(confPath,temppath,tempStr)
    IF EstrLen(tempStr)>0
      domethod( self.lvUploadPaths , [ MUIM_List_InsertSingle , tempStr , MUIV_List_Insert_Bottom ] )
      i++
    ENDIF
  UNTIL EstrLen(tempStr)=0
  self.oldulpathcount:=i

  domethod( self.lvMsgBases , [ MUIM_List_Clear] )
  
  FOR i:=0 TO self.msgbaseLists.count()-1
    msgbase:=self.msgbaseLists.item(i)
    END msgbase
  ENDFOR
  self.msgbaseLists.clear()
  
  StrCopy(temppath,confPath)
  AddPart(temppath,'MSGBASES',200)
  SetStr(temppath)
  val:=readToolTypeInt(temppath,'NMSGBASES')
  IF val=-1
    domethod( self.lvMsgBases , [ MUIM_List_InsertSingle , 'Default' , MUIV_List_Insert_Bottom ] )
    NEW msgbase.create()
    self.msgbaseLists.add(msgbase)
    self.oldmsgbasecount:=0
  ELSE
    FOR i:=1 TO val
      StringF(tempTooltype,'NAME.\d',i)
      readToolType(temppath,tempTooltype,tempStr)
      domethod( self.lvMsgBases , [ MUIM_List_InsertSingle , tempStr , MUIV_List_Insert_Bottom ] )

      NEW msgbase.create()
      StringF(tempTooltype,'LOCATION.\d',i)
      readToolType(temppath,tempTooltype,tempStr)
      StrCopy(msgbase.location,tempStr)
      
      StringF(tempTooltype,'EXTSEND.\d',i)
      msgbase.extSend:=checkToolTypeExists(temppath,tempTooltype)

      StringF(tempTooltype,'USERNAME.\d',i)
      msgbase.username:=checkToolTypeExists(temppath,tempTooltype)

      StringF(tempTooltype,'REALNAME.\d',i)
      msgbase.realname:=checkToolTypeExists(temppath,tempTooltype)

      StringF(tempTooltype,'INTERNETNAME.\d',i)
      msgbase.internetname:=checkToolTypeExists(temppath,tempTooltype)
      self.msgbaseLists.add(msgbase)
    ENDFOR
    self.oldmsgbasecount:=val
  ENDIF
  

  self.changed:=FALSE
  set( self.btnConfSave, MUIA_Disabled , MUI_TRUE)
  set( self.btnAddConf,MUIA_Disabled,FALSE)
  set( self.btnCloneConf,MUIA_Disabled,FALSE)
  self.newConf:=FALSE
  
ENDPROC TRUE

PROC editConfs(acpName) OF frmConfEdit
  DEF count,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  DEF bbsPath[255]:STRING
  DEF msgbaseList:PTR TO stdlist
  DEF msgbase:PTR TO msgbase
  
  NEW saveHook
  installhook( saveHook, {saveChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.acpName:=acpName  

  set( self.btnEditMsgbase , MUIA_Disabled , MUI_TRUE)
  set( self.btnRemoveMsgbase , MUIA_Disabled , MUI_TRUE)

  set( self.btnRemoveConf, MUIA_Disabled , MUI_TRUE)
  set( self.btnUlPathAdd , MUIA_Disabled , MUI_TRUE)
  set( self.btnDlPathAdd , MUIA_Disabled , MUI_TRUE)
  set( self.btnUlPathRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnDlPathRemove , MUIA_Disabled , MUI_TRUE)

  installhook( self.setChangedHook, {setChangedFlag})    
  self.addControls()
  self.addNotifications()

  set(self.grpConfPages,MUIA_Group_ActivePage,MUIV_Group_ActivePage_First)

  self.changed:=FALSE
  readToolType(self.acpName,'BBS_LOCATION',bbsPath)
  self.confConfig:=String(255)
  StringF(self.confConfig,'\sCONFCONFIG',bbsPath) 
  self.confCount:=readToolTypeInt(self.confConfig,'NCONFS')

  NEW msgbaseList.stdlist(20)
  
  self.msgbaseLists:=msgbaseList

  self.loadConf(1)

  self.showModal()

  FOR i:=0 TO self.msgbaseLists.count()-1
    msgbase:=self.msgbaseLists.item(i)
    END msgbase
  ENDFOR
  END self.msgbaseLists

  self.removeNotifications()
  self.removeControls()
  END saveHook
  END closeHook
  DisposeLink(self.confConfig)
ENDPROC
