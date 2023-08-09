OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','workbench/workbench','icon','intuition/classusr'
MODULE 'utility/tagitem','utility/hooks','tools/installhook','exec/lists','dos/dos'
MODULE '*axedit','*frmBase','*tooltypes','*controls','*miscfuncs','*/stringlist'


EXPORT OBJECT frmPresetsEdit OF frmBase
  acpName          : PTR TO CHAR
  bbsConfigName    : PTR TO CHAR
  btnSave          : PTR TO LONG
  btnCancel        : PTR TO LONG
  raPreset         : PTR TO LONG   
  grpSettings      : PTR TO LONG
  changed

  areaNames:PTR TO LONG
  setChangedHook   : hook
  presetListOnChange : hook
  currPreset        : INT
  controlList      : LONG

  strAreaName      : PTR TO control
  intAccessLevel   : PTR TO control
  intConfrJoin     : PTR TO control
  intMsgbaserJoin  : PTR TO control
  intDailyBytes    : PTR TO control
  intRatioType     : PTR TO control
  intRatio         : PTR TO control
  intTimeLimit     : PTR TO control
ENDOBJECT

PROC create(app:PTR TO app_obj) OF frmPresetsEdit
  DEF group
  SUPER self.create(app)
  self.winMain:=app.wi_presets

  self.btnSave:=app.btnPresetSave
  self.btnCancel:=app.btnPresetClose
  self.raPreset:=app.ra_presets

  self.grpSettings:=app.gr_preset_settings

  set(self.winMain,MUIA_Window_Width,MUIV_Window_Width_Screen(50))
ENDPROC

PROC setChangedFlag() OF frmPresetsEdit
  MOVE.L (A1),self
  GetA4()
  IF self.changed=FALSE
    self.changed:=TRUE
    set( self.btnSave,MUIA_Disabled,FALSE)
  ENDIF
ENDPROC

PROC freeControl(control:PTR TO control) OF frmPresetsEdit
  control.removeFromGroup(self.grpSettings)
  END control
ENDPROC

PROC addNotifications() OF frmPresetsEdit
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

  domethod( self.raPreset , [
    MUIM_Notify ,  MUIA_Radio_Active , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.presetListOnChange, self] )
  installhook( self.presetListOnChange, {presetChange})

ENDPROC

PROC removeNotifications() OF frmPresetsEdit
  domethod(self.btnCancel,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnSave,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.raPreset ,[MUIM_KillNotify,MUIA_Radio_Active])
ENDPROC

PROC addPresetControls() OF frmPresetsEdit
  DEF control: PTR TO control

  NEW control.createCycle('bArea Name','strAreaName',['',0],self.app.app,self.setChangedHook,self)
  self.strAreaName:=control

  NEW control.createStringInt('bAccess Level','intAccessLevel',self.app.app,self.setChangedHook,self)
  self.intAccessLevel:=control

  NEW control.createStringInt('bInitial Conf','intConfrJoin',self.app.app,self.setChangedHook,self)
  self.intConfrJoin:=control

  NEW control.createStringInt('Initial Msgbase','intMsgbaserJoin',self.app.app,self.setChangedHook,self)
  self.intMsgbaserJoin:=control
  
  NEW control.createStringInt('Daily Byte Limit','intDailyBytes',self.app.app,self.setChangedHook,self)
  self.intDailyBytes:=control
  
  NEW control.createStringInt('Ratio Type','intRatioType',self.app.app,self.setChangedHook,self)
  self.intRatioType:=control

  NEW control.createStringInt('Ratio','intRatio',self.app.app,self.setChangedHook,self)
  self.intRatio:=control

  NEW control.createStringInt('Time Limit','intTimeLimit',self.app.app,self.setChangedHook,self)
  self.intTimeLimit:=control

  self.controlList:=[self.strAreaName,self.intAccessLevel,self.intConfrJoin,self.intMsgbaserJoin,
                     self.intDailyBytes,self.intRatioType,self.intRatio,self.intTimeLimit]

  domethod(self.grpSettings,[MUIM_Group_InitChange])
  ForAll({control},self.controlList,`control.addToGroup(self.grpSettings)) 
  domethod(self.grpSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpSettings,[OM_ADDMEMBER,HVSpace])
  domethod(self.grpSettings,[MUIM_Group_ExitChange])
ENDPROC

PROC removePresetControls() OF frmPresetsEdit
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

PROC presetChange()  OF frmPresetsEdit
  DEF entry
  MOVE.L (A1),self
  GetA4()

  get(self.raPreset,MUIA_Radio_Active,{entry})

  IF self.loadPreset(entry+1)=FALSE
    //restore old prest
    domethod(self.raPreset,[MUIM_NoNotifySet,MUIA_Radio_Active,self.currPreset])
  ENDIF

ENDPROC

PROC canClose() OF frmPresetsEdit
  MOVE.L (A1),self
  GetA4()
  IF self.changed
    IF self.unsavedChangesWarning()=0 THEN RETURN FALSE
  ENDIF
ENDPROC TRUE

PROC unsavedChangesWarning() OF frmPresetsEdit
  DEF win
  get(self.winMain,MUIA_Window_Window,{win})
  IF EasyRequestArgs(	win , [ 20 , 0 ,
									'Unsaved changes' ,
									'You have unsaved changes,\nif you continue you will lose them.',
									'_OK|_CANCEL' ] , NIL , NIL )=0 THEN RETURN FALSE
ENDPROC TRUE

PROC savePresetChanges() OF frmPresetsEdit
  DEF tempStr[255]:STRING
  DEF bbsPath[255]:STRING
  DEF presetStr[20]:STRING
  DEF win

  MOVE.L (A1),self
  GetA4()

  get(self.winMain,MUIA_Window_Window,{win})

  fullTrim(self.areaNames[self.strAreaName.getValueIndex()],tempStr)
  IF EstrLen(tempStr)=0
    EasyRequestArgs(  win , [ 20 , 0 ,
                  'Error' ,
                  'Area Name is a mandatory field',
                  '_OK' ] , NIL , NIL )
    RETURN
  ENDIF

  fullTrim(self.intAccessLevel.getValue(),tempStr)
  IF EstrLen(tempStr)=0
    EasyRequestArgs(  win , [ 20 , 0 ,
                  'Error' ,
                  'Acces Level is a mandatory field',
                  '_OK' ] , NIL , NIL )
    RETURN
  ENDIF

  fullTrim(self.intConfrJoin.getValue(),tempStr)
  IF EstrLen(tempStr)=0
    EasyRequestArgs(  win , [ 20 , 0 ,
                  'Error' ,
                  'Initial Conf is a mandatory field',
                  '_OK' ] , NIL , NIL )
    RETURN
  ENDIF
 
  readToolType(self.acpName,'BBS_LOCATION',bbsPath)
  StringF(presetStr,'\saccess/preset.\d',bbsPath,self.currPreset)

  writeToolType(presetStr,'PRESET.AREA',self.areaNames[self.strAreaName.getValueIndex()])
  writeToolType(presetStr,'PRESET.ACCESS',self.intAccessLevel.getValue())
  writeToolType(presetStr,'PRESET.CONFRJOIN',self.intConfrJoin.getValue())
  writeToolType(presetStr,'PRESET.MSGBASERJOIN',self.intMsgbaserJoin.getValue())
  writeToolType(presetStr,'PRESET.DAILY_BYTE_LIMIT',self.intDailyBytes.getValue())
  writeToolType(presetStr,'PRESET.RATIO_TYPE',self.intRatioType.getValue())
  writeToolType(presetStr,'PRESET.RATIO',self.intRatio.getValue())
  writeToolType(presetStr,'PRESET.TIME_LIMIT',self.intTimeLimit.getValue())
  saveCachedChanges()

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
ENDPROC

PROC findAreaIndex(areaName:PTR TO CHAR) OF frmPresetsEdit
  DEF res,i
  res:=-1

  FOR i:=0 TO ListLen(self.areaNames)-2 DO IF StriCmp(areaName,self.areaNames[i]) THEN res:=i
ENDPROC res

PROC loadAreaNames(bbsPath:PTR TO CHAR) OF frmPresetsEdit
  DEF accessPath[255]:STRING
  DEF dir_info:PTR TO fileinfoblock
  DEF pdir,r,entry

  DEF buf[255]:STRING
  DEF parseBuf[100]:STRING

  StringF(accessPath,'\saccess/',bbsPath)
 
  IF ((dir_info:=AllocDosObject(DOS_FIB,NIL)) = NIL)
    RETURN 0
  ENDIF
  
  IF ((pdir:=Lock(accessPath,ACCESS_READ)))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF
  
  IF(Examine(pdir, dir_info))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    UnLock(pdir)
    RETURN 0
  ENDIF

  IF ParsePatternNoCase('AREA.#?.info',parseBuf,100) =-1 THEN RETURN
  
  ForAll({entry},self.areaNames,`DisposeLink(entry))
  SetList(self.areaNames,0)


  WHILE(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0)

      IF MatchPatternNoCase(parseBuf,dir_info.filename)
        buf:=String(255)
        StrCopy(buf,dir_info.filename+5)
        stripInfo(buf)
        ListAddItem(self.areaNames,buf)
      ENDIF
    ENDIF
  ENDWHILE

  ListAddItem(self.areaNames,String(0))
  ListAddItem(self.areaNames,0)
  
  set(self.strAreaName.muiControl,MUIA_Cycle_Entries,self.areaNames)
  
  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)
  

ENDPROC

PROC loadPreset(presetNum) OF frmPresetsEdit
 DEF bbsPath[255]:STRING
 DEF presetStr[20]:STRING
 DEF tempStr[255]:STRING
 DEF val
  
  IF self.changed
    IF self.unsavedChangesWarning()=FALSE THEN RETURN FALSE
  ENDIF

  readToolType(self.acpName,'BBS_LOCATION',bbsPath)

  StringF(presetStr,'\saccess/preset.\d',bbsPath,presetNum)

  readToolType(presetStr,'PRESET.AREA',tempStr)
  IF EstrLen(tempStr)=0 THEN StrCopy(tempStr,'')
  self.strAreaName.setValueIndex(self.findAreaIndex(tempStr))
  
  val:=readToolTypeInt(presetStr,'PRESET.ACCESS')
  self.intAccessLevel.setValue(val)
  
  val:=readToolTypeInt(presetStr,'PRESET.CONFRJOIN')
  self.intConfrJoin.setValue(val)
    
  val:=readToolTypeInt(presetStr,'PRESET.MSGBASERJOIN')
  self.intMsgbaserJoin.setValue(val)
  
  val:=readToolTypeInt(presetStr,'PRESET.DAILY_BYTE_LIMIT')
  self.intDailyBytes.setValue(val)
  
  val:=readToolTypeInt(presetStr,'PRESET.RATIO_TYPE')
  self.intRatioType.setValue(val)

  val:=readToolTypeInt(presetStr,'PRESET.RATIO')
  self.intRatio.setValue(val)
    
  val:=readToolTypeInt(presetStr,'PRESET.TIME_LIMIT')
  self.intTimeLimit.setValue(val)

  self.currPreset:=presetNum

  self.changed:=FALSE
  set( self.btnSave, MUIA_Disabled , MUI_TRUE)

ENDPROC TRUE

PROC editPresets(acpName:PTR TO CHAR) OF frmPresetsEdit
  DEF count,val,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF bbsPath[255]:STRING

  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook

  NEW saveHook
  installhook( saveHook, {savePresetChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.acpName:=acpName
  
  self.areaNames:=List(100)

  readToolType(self.acpName,'BBS_LOCATION',bbsPath)


  installhook( self.setChangedHook, {setChangedFlag})    
  self.addPresetControls()
  self.addNotifications()
 
  self.loadAreaNames(bbsPath)

  set( self.winMain, MUIA_Window_Title,'Edit Presets')
  set(self.raPreset,MUIA_Radio_Active,0)

  self.changed:=FALSE
  self.loadPreset(1)

  self.changed:=FALSE
  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  self.showModal()
  self.removeNotifications()
  self.removePresetControls()
  END saveHook
  END closeHook
  ForAll({entry},self.areaNames,`IF entry THEN DisposeLink(entry) ELSE 0)
  DisposeLink(self.areaNames)
ENDPROC
