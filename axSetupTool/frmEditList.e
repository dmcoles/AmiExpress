OPT MODULE,LARGE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','workbench/workbench','icon','dos/dos'
MODULE 'utility/tagitem' , 'utility/hooks','tools/installhook'

MODULE '*axedit','*frmBase','*tooltypes','*frmAddItem','*frmAddComplexItem','*/stringlist','*miscfuncs','*configobject','*helpText'

EXPORT OBJECT frmEditList OF frmBase
  oldcount           : INT
  computersTooltype  : PTR TO CHAR
  namesTooltype      : PTR TO CHAR
  drivesTooltype     : PTR TO CHAR
  languagesTooltype     : PTR TO CHAR
  screenTypesTooltype: PTR TO CHAR
  connectDefToolType : PTR TO CHAR
  lvList             : PTR TO LONG
  lList              : PTR TO LONG
  strItem            : PTR TO LONG
  btnItemAdd         : PTR TO LONG
  btnItemEdit        : PTR TO LONG
  btnItemRemove      : PTR TO LONG
  btnItemsSave   : PTR TO LONG
  btnItemsCancel : PTR TO LONG

  acpName: PTR TO CHAR
  
  titles: PTR TO stringlist
  extensions: PTR TO stringlist

  connectlist: PTR TO stringlist
  connectbaud: PTR TO stringlist
  oldconnectionstrings: PTR TO stringlist

  areaLists: PTR TO stdlist
  deleteAreas:PTR TO stringlist
  accessLists: PTR TO stdlist
  deleteAccessLevels:PTR TO stringlist

  fCheckLists: PTR TO stdlist
  deletefCheckLists:PTR TO stringlist
  
  protocolLists: PTR TO stdlist
  deleteProtocolLists:PTR TO stringlist

  commandLists: PTR TO stdlist
  deleteCommandLists:PTR TO stringlist
  commandPath:PTR TO CHAR

  editCaption1: PTR TO CHAR
  editCaption2: PTR TO CHAR

  bbsPath:PTR TO CHAR

  strOnChange: hook 
  btnAddClick: hook
  btnEditClick: hook
  btnRemoveClick: hook
  lvChange: hook
  changed
ENDOBJECT

PROC create(app:PTR TO app_obj) OF frmEditList
  DEF list
  SUPER self.create(app)
  self.winMain:=app.wi_listEdit
  self.lvList:=app.lv_list
  get(self.lvList,MUIA_Listview_List,{list})
  self.lList:=list
  self.strItem:=app.strListItem
  self.btnItemAdd:=app.btnItemAdd
  self.btnItemEdit:=app.btnItemEdit
  self.btnItemRemove:=app.btnItemRemove
  self.btnItemsSave:=app.btnListSave
  self.btnItemsCancel:=app.btnListCancel

  set(self.lList,MUIA_List_ConstructHook,MUIV_List_ConstructHook_String)
  set(self.lList,MUIA_List_DestructHook,MUIV_List_DestructHook_String)
  set(self.winMain,MUIA_Window_Width,MUIV_Window_Width_Screen(50))
ENDPROC

PROC stringChange() OF frmEditList
  DEF str
  MOVE.L (A1),self
  GetA4()
  
  get(self.strItem, MUIA_String_Contents,{str})
  set( self.btnItemAdd , MUIA_Disabled , IF StrLen(str)=0 THEN MUI_TRUE ELSE FALSE)
ENDPROC

PROC listChange() OF frmEditList
  DEF entry
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})
  set( self.btnItemRemove , MUIA_Disabled , IF entry=MUIV_List_Active_Off THEN MUI_TRUE ELSE FALSE)
  set( self.btnItemEdit , MUIA_Disabled , IF entry=MUIV_List_Active_Off THEN MUI_TRUE ELSE FALSE)
ENDPROC

PROC connectionitemAdd() OF frmEditList
  DEF str,res,v1,v2
  DEF tempStr[255]:STRING
  DEF frmAddItem: PTR TO frmAddItem
  MOVE.L (A1),self
  GetA4()

  NEW frmAddItem.create(self.app)
  get(self.strItem, MUIA_String_Contents,{str})
  res,v1,v2:=frmAddItem.editConnectionString(str,'')
  IF res
    StringF(tempStr,'\s=\s',v1,v2)
    domethod( self.lList , [ MUIM_List_InsertSingle , tempStr , MUIV_List_Insert_Bottom ] )
    self.connectlist.add(v1)
    self.connectbaud.add(v2)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddItem
  
  set(self.strItem, MUIA_String_Contents,'')
ENDPROC

PROC connectionitemEdit() OF frmEditList
  DEF str,res,v1,v2,entry
  DEF tempStr[255]:STRING
  DEF frmAddItem: PTR TO frmAddItem
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})
  
  NEW frmAddItem.create(self.app)
  res,v1,v2:=frmAddItem.editConnectionString(self.connectlist.item(entry),self.connectbaud.item(entry))
  IF res
    StringF(tempStr,'\s=\s',v1,v2)
    domethod( self.lList , [ MUIM_List_Remove, entry ] )
    domethod( self.lList , [ MUIM_List_InsertSingle , tempStr , entry ] )
    set(self.lList,MUIA_List_Active,entry)
    set(self.lList,MUIA_List_Active,entry)
    self.connectlist.setItem(entry,v1)
    self.connectbaud.setItem(entry,v2)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddItem
ENDPROC

PROC connectionitemRemove() OF frmEditList
  DEF entry
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})

  self.connectlist.remove(entry)
  self.connectbaud.remove(entry)
  domethod( self.lList , [ MUIM_List_Remove, entry] )
  set( self.btnItemsSave , MUIA_Disabled , FALSE)
  
  self.changed:=TRUE
ENDPROC

PROC commanditemAdd() OF frmEditList
  DEF str,res,v1,v2
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF command:PTR TO command
  MOVE.L (A1),self
  GetA4()

  NEW frmAddComplexItem.create(self.app)
  get(self.strItem, MUIA_String_Contents,{str})
  res,v1,command:=frmAddComplexItem.editCommand(self.acpName,str,self.commandPath,NIL,self.commandLists)
  IF res
    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , MUIV_List_Insert_Bottom ] )
    self.commandLists.add(command)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddComplexItem
  
  set(self.strItem, MUIA_String_Contents,'')
ENDPROC

PROC commanditemEdit() OF frmEditList
  DEF str,res,v1,v2,entry
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF command:PTR TO command
  DEF command2:PTR TO command
  DEF i
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})
  domethod(self.lList,[MUIM_List_GetEntry,entry,{str}])
  
  NEW frmAddComplexItem.create(self.app)
  command2:=self.commandLists.item(entry)
  res,v1,command:=frmAddComplexItem.editCommand(self.acpName,str,self.commandPath,command2,self.commandLists)
  IF res
    IF StriCmp(v1,str)=FALSE
      //if we change the identifier then delete the old one
      self.deleteCommandLists.add(str)
    ENDIF
    
    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , entry+1 ] )
    domethod( self.lList , [ MUIM_List_Remove, entry ] )
    set(self.lList,MUIA_List_Active,entry)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)

    //copy command to command2
    StrCopy(command2.name,command.name)
    StrCopy(command2.location,command.location)
    StrCopy(command2.access,command.access)
    StrCopy(command2.internal,command.internal)
    StrCopy(command2.mimicVer,command.mimicVer)
    StrCopy(command2.password,command.password)
    StrCopy(command2.passParams,command.passParams)
    StrCopy(command2.priority,command.priority)
    command2.resident:=command.resident
    command2.quickMode:=command.quickMode
    StrCopy(command2.stack,command.stack)
    StrCopy(command2.type,command.type)
    command2.trapon:=command.trapon
    command2.expertMode:=command.expertMode
    command2.doorSilent:=command.doorSilent
    command2.logInputs:=command.logInputs
    command2.scriptCheck:=command.scriptCheck
    command2.multiNode:=command.multiNode
    StrCopy(command2.banner,command.banner)
    END command
  ENDIF
  END frmAddComplexItem
ENDPROC

PROC commanditemRemove() OF frmEditList
  DEF entry,v1
  DEF command:PTR TO command
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})

  domethod(self.lList,[MUIM_List_GetEntry,entry,{v1}])
  self.deleteCommandLists.add(v1)

  command:=self.commandLists.item(entry)
  END command
  self.commandLists.remove(entry)
  domethod( self.lList , [ MUIM_List_Remove, entry] )
  set( self.btnItemsSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC protocolitemAdd() OF frmEditList
  DEF str,res,v1,v2
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF protocol:PTR TO protocol
  MOVE.L (A1),self
  GetA4()

  NEW frmAddComplexItem.create(self.app)
  get(self.strItem, MUIA_String_Contents,{str})
  res,v1,protocol:=frmAddComplexItem.editProtocol(self.acpName,str,NIL,self.protocolLists)
  IF res
    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , MUIV_List_Insert_Bottom ] )
    self.protocolLists.add(protocol)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddComplexItem
  
  set(self.strItem, MUIA_String_Contents,'')
ENDPROC

PROC protocolitemEdit() OF frmEditList
  DEF str,res,v1,v2,entry
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF protocol:PTR TO protocol
  DEF protocol2:PTR TO protocol
  DEF i
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})
  domethod(self.lList,[MUIM_List_GetEntry,entry,{str}])
  
  NEW frmAddComplexItem.create(self.app)
  protocol2:=self.protocolLists.item(entry)
  res,v1,protocol:=frmAddComplexItem.editProtocol(self.acpName,str,protocol2,self.protocolLists)
  IF res
    IF StriCmp(v1,str)=FALSE
      //if we change the identifier then delete the old one
      self.deleteProtocolLists.add(str)
    ENDIF

    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , entry+1 ] )
    domethod( self.lList , [ MUIM_List_Remove, entry ] )
    set(self.lList,MUIA_List_Active,entry)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)

    //copy protocol to protocol2
    StrCopy(protocol2.filename,protocol.filename)
    StrCopy(protocol2.options,protocol.options)
    StrCopy(protocol2.httpHost,protocol.httpHost)
    StrCopy(protocol2.httpTemp,protocol.httpTemp)
    protocol2.ftpAuth:=protocol.ftpAuth
    StrCopy(protocol2.ftpHost,protocol.ftpHost)
    StrCopy(protocol2.rxWindow,protocol.rxWindow)
    StrCopy(protocol2.txWindow,protocol.txWindow)
    END protocol
  ENDIF
  END frmAddComplexItem
ENDPROC

PROC protocolitemRemove() OF frmEditList
  DEF entry,v1
  DEF protocol:PTR TO protocol
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})

  domethod(self.lList,[MUIM_List_GetEntry,entry,{v1}])
  self.deleteProtocolLists.add(v1)

  protocol:=self.protocolLists.item(entry)
  END protocol
  self.protocolLists.remove(entry)
  domethod( self.lList , [ MUIM_List_Remove, entry] )
  set( self.btnItemsSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC fileCheckitemAdd() OF frmEditList
  DEF str,res,v1,v2
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF fChecker:PTR TO fChecker
  MOVE.L (A1),self
  GetA4()

  NEW frmAddComplexItem.create(self.app)
  get(self.strItem, MUIA_String_Contents,{str})
  res,v1,fChecker:=frmAddComplexItem.editFileCheck(self.acpName,str,NIL,self.fCheckLists)
  IF res
    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , MUIV_List_Insert_Bottom ] )
    self.fCheckLists.add(fChecker)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddComplexItem
  
  set(self.strItem, MUIA_String_Contents,'')
ENDPROC

PROC fileCheckitemEdit() OF frmEditList
  DEF str,res,v1,v2,entry
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF fChecker:PTR TO fChecker
  DEF fChecker2:PTR TO fChecker
  DEF i
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})
  domethod(self.lList,[MUIM_List_GetEntry,entry,{str}])
  
  NEW frmAddComplexItem.create(self.app)
  fChecker2:=self.fCheckLists.item(entry)
  res,v1,fChecker:=frmAddComplexItem.editFileCheck(self.acpName,str,fChecker2,self.fCheckLists)
  IF res
    IF StriCmp(v1,str)=FALSE
      //if we change the identifier then delete the old one
      self.deletefCheckLists.add(str)
    ENDIF

    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , entry+1 ] )
    domethod( self.lList , [ MUIM_List_Remove, entry ] )
    set(self.lList,MUIA_List_Active,entry)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)

    //copy fchecker to fchecker2
    StrCopy(fChecker2.filename,fChecker.filename)
    StrCopy(fChecker2.checker,fChecker.checker)
    StrCopy(fChecker2.error1,fChecker.error1)
    StrCopy(fChecker2.error2,fChecker.error2)
    StrCopy(fChecker2.error3,fChecker.error3)
    StrCopy(fChecker2.error4,fChecker.error4)
    StrCopy(fChecker2.error5,fChecker.error5)
    StrCopy(fChecker2.error6,fChecker.error6)
    StrCopy(fChecker2.error7,fChecker.error7)
    StrCopy(fChecker2.error8,fChecker.error8)
    StrCopy(fChecker2.error9,fChecker.error9)
    StrCopy(fChecker2.error10,fChecker.error10)
    StrCopy(fChecker2.options,fChecker.options)
    StrCopy(fChecker2.priority,fChecker.priority)
    StrCopy(fChecker2.script,fChecker.script)
    StrCopy(fChecker2.stack,fChecker.stack)
    END fChecker
  ENDIF
  END frmAddComplexItem
ENDPROC

PROC fileCheckitemRemove() OF frmEditList
  DEF entry,v1
  DEF fChecker:PTR TO fChecker
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})

  domethod(self.lList,[MUIM_List_GetEntry,entry,{v1}])
  self.deletefCheckLists.add(v1)

  fChecker:=self.fCheckLists.item(entry)
  END fChecker
  self.fCheckLists.remove(entry)
  domethod( self.lList , [ MUIM_List_Remove, entry] )
  set( self.btnItemsSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC accessLevelitemAdd() OF frmEditList
  DEF str,res,v1,v2
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF accessLevel:PTR TO accessLevel
  MOVE.L (A1),self
  GetA4()

  NEW frmAddComplexItem.create(self.app)
  get(self.strItem, MUIA_String_Contents,{str})
  res,v1,accessLevel:=frmAddComplexItem.editAccess(self.acpName,str,NIL,self.accessLists)
  IF res
    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , MUIV_List_Insert_Bottom ] )
    self.accessLists.add(accessLevel)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddComplexItem
  
  set(self.strItem, MUIA_String_Contents,'')
ENDPROC

PROC accessLevelitemEdit() OF frmEditList
  DEF str,res,v1,v2,entry
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF accessLevel:PTR TO accessLevel
  DEF accessLevel2:PTR TO accessLevel
  DEF i
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})
  domethod(self.lList,[MUIM_List_GetEntry,entry,{str}])
  
  NEW frmAddComplexItem.create(self.app)
  accessLevel2:=self.accessLists.item(entry)
  res,v1,accessLevel:=frmAddComplexItem.editAccess(self.acpName,str,accessLevel2,self.accessLists)
  IF res
    IF StriCmp(v1,str)=FALSE
      //if we change the identifier then delete the old one
      self.deleteAccessLevels.add(str)
    ENDIF
    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , entry+1 ] )
    domethod( self.lList , [ MUIM_List_Remove, entry ] )
    set(self.lList,MUIA_List_Active,entry)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
    StrCopy(accessLevel2.filename,accessLevel.filename)
    accessLevel2.accessList.clear()
    FOR i:=0 TO accessLevel.accessList.count()-1
      accessLevel2.accessList.add(accessLevel.accessList.item(i))
    ENDFOR
    END accessLevel
  ENDIF
  END frmAddComplexItem
ENDPROC

PROC accessLevelitemRemove() OF frmEditList
  DEF entry,v1
  DEF accessLevel:PTR TO accessLevel
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})

  domethod(self.lList,[MUIM_List_GetEntry,entry,{v1}])
  self.deleteAccessLevels.add(v1)

  accessLevel:=self.accessLists.item(entry)
  END accessLevel
  self.accessLists.remove(entry)
  domethod( self.lList , [ MUIM_List_Remove, entry] )
  set( self.btnItemsSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC areaitemAdd() OF frmEditList
  DEF str,res,v1,v2
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF area:PTR TO area
  MOVE.L (A1),self
  GetA4()

  NEW frmAddComplexItem.create(self.app)
  get(self.strItem, MUIA_String_Contents,{str})
  res,v1,area:=frmAddComplexItem.editArea(self.acpName,str,NIL,self.areaLists)
  IF res
    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , MUIV_List_Insert_Bottom ] )
    self.areaLists.add(area)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddComplexItem
  
  set(self.strItem, MUIA_String_Contents,'')
ENDPROC

PROC areaitemEdit() OF frmEditList
  DEF str,res,v1,v2,entry
  DEF tempStr[255]:STRING
  DEF frmAddComplexItem: PTR TO frmAddComplexItem
  DEF area:PTR TO area
  DEF area2:PTR TO area
  DEF i
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})
  domethod(self.lList,[MUIM_List_GetEntry,entry,{str}])
  
  NEW frmAddComplexItem.create(self.app)
  area2:=self.areaLists.item(entry)
  res,v1,area:=frmAddComplexItem.editArea(self.acpName,str,area2, self.areaLists)
  IF res
    IF StriCmp(v1,str)=FALSE
      //if we change the identifier then delete the old one
      self.deleteAreas.add(str)
    ENDIF
    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , entry+1 ] )
    domethod( self.lList , [ MUIM_List_Remove, entry ] )
    set(self.lList,MUIA_List_Active,entry)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
    StrCopy(area2.filename,area.filename)
    FOR i:=0 TO ListLen(area.confList)-1
      area2.confList[i]:=area.confList[i]
    ENDFOR
    END area
  ENDIF
  END frmAddComplexItem
ENDPROC

PROC areaitemRemove() OF frmEditList
  DEF entry,v1
  DEF area:PTR TO area
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})

  domethod(self.lList,[MUIM_List_GetEntry,entry,{v1}])
  self.deleteAreas.add(v1)

  area:=self.areaLists.item(entry)
  END area
  self.areaLists.remove(entry)
  domethod( self.lList , [ MUIM_List_Remove, entry] )
  set( self.btnItemsSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC screenitemAdd() OF frmEditList
  DEF str,res,v1,v2
  DEF tempStr[255]:STRING
  DEF frmAddItem: PTR TO frmAddItem
  MOVE.L (A1),self
  GetA4()

  NEW frmAddItem.create(self.app)
  get(self.strItem, MUIA_String_Contents,{str})
  res,v1,v2:=frmAddItem.addScreen(str)
  IF res
    StringF(tempStr,'\s (\s)',v1,v2)
    domethod( self.lList , [ MUIM_List_InsertSingle , tempStr , MUIV_List_Insert_Bottom ] )
    self.extensions.add(v2)
    self.titles.add(v1)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddItem
  
  set(self.strItem, MUIA_String_Contents,'')
ENDPROC

PROC screenitemEdit() OF frmEditList
  DEF str,res,v1,v2,entry
  DEF tempStr[255]:STRING
  DEF frmAddItem: PTR TO frmAddItem
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})
  
  NEW frmAddItem.create(self.app)
  res,v1,v2:=frmAddItem.editScreen(self.titles.item(entry),self.extensions.item(entry))
  IF res
    StringF(tempStr,'\s (\s)',v1,v2)
    domethod( self.lList , [ MUIM_List_Remove, entry ] )
    domethod( self.lList , [ MUIM_List_InsertSingle , tempStr , entry ] )
    self.extensions.setItem(entry,v2)
    self.titles.setItem(entry,v1)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddItem
ENDPROC

PROC screenitemRemove() OF frmEditList
  DEF entry
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})

  self.extensions.remove(entry)
  self.titles.remove(entry)
  domethod( self.lList , [ MUIM_List_Remove, entry] )
  set( self.btnItemsSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC itemAdd() OF frmEditList
  DEF str
  MOVE.L (A1),self
  GetA4()

  get(self.strItem, MUIA_String_Contents,{str})
  domethod( self.lList , [ MUIM_List_InsertSingle , str , MUIV_List_Insert_Bottom ] )
  set(self.strItem, MUIA_String_Contents,'')
  set( self.btnItemsSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC itemEdit() OF frmEditList
  DEF str,res,v1,entry
  DEF tempStr[255]:STRING
  DEF frmAddItem: PTR TO frmAddItem
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})
  domethod(self.lList,[MUIM_List_GetEntry,entry,{v1}])

  
  NEW frmAddItem.create(self.app)
  res,v1:=frmAddItem.editSingleItem(self.editCaption1,self.editCaption2,v1)
  IF res
    domethod( self.lList , [ MUIM_List_Remove, entry ] )
    domethod( self.lList , [ MUIM_List_InsertSingle , v1 , entry ] )
    set(self.lList,MUIA_List_Active,entry)
    self.changed:=TRUE
    set( self.btnItemsSave , MUIA_Disabled , FALSE)
  ENDIF
  END frmAddItem
ENDPROC

PROC itemRemove() OF frmEditList
  DEF entry
  MOVE.L (A1),self
  GetA4()

  get(self.lList,MUIA_List_Active,{entry})

  domethod( self.lList , [ MUIM_List_Remove, entry] )
  set( self.btnItemsSave , MUIA_Disabled , FALSE)
  self.changed:=TRUE
ENDPROC

PROC addNotifications(customAdd=FALSE) OF frmEditList
  domethod( self.btnItemsCancel , [
    MUIM_Notify , MUIA_Pressed , FALSE ,
    self.app.app,
    2 ,
    MUIM_Application_ReturnID ,  MUIA_Window_CloseRequest ] )

  domethod( self.btnItemsSave , [
    MUIM_Notify , MUIA_Pressed , FALSE ,
    self.app.app,
    2 ,
    MUIM_Application_ReturnID ,  ID_SAVE ] )
    
  domethod( self.strItem , [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.strOnChange, self] )
  installhook( self.strOnChange, {stringChange})


  domethod( self.lList , [
    MUIM_Notify ,  MUIA_List_Active , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.lvChange, self] )
  installhook( self.lvChange, {listChange})

  IF customAdd=FALSE
    self.setupButtonClick(self.btnItemAdd,self.btnAddClick,{itemAdd})
    self.setupButtonClick(self.btnItemEdit,self.btnEditClick,{itemEdit})
    self.setupButtonClick(self.btnItemRemove,self.btnRemoveClick,{itemRemove})
  ENDIF
ENDPROC

PROC removeNotifications(customAdd=FALSE) OF frmEditList
  domethod(self.btnItemsCancel,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemsSave,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.strItem,[MUIM_KillNotify,MUIA_String_Contents])
  domethod(self.lList,[MUIM_KillNotify,MUIA_List_Active])
  IF (customAdd=FALSE)
    domethod(self.btnItemAdd,[MUIM_KillNotify,MUIA_Pressed])
    domethod(self.btnItemEdit,[MUIM_KillNotify,MUIA_Pressed])
    domethod(self.btnItemRemove,[MUIM_KillNotify,MUIA_Pressed])
  ENDIF
ENDPROC

PROC canClose() OF frmEditList
  MOVE.L (A1),self
  GetA4()
  IF self.changed
    IF self.unsavedChangesWarning()=0 THEN RETURN FALSE
  ENDIF
ENDPROC TRUE

PROC unsavedChangesWarning() OF frmEditList
  IF Mui_RequestA(0,self.winMain,0,'Unsaved changes',
    '*OK|CANCEL','You have unsaved changes,\nif you continue you will lose them.',0)=0 THEN RETURN FALSE
ENDPROC TRUE


PROC saveComputersChanges() OF frmEditList
  DEF i,count,entry
  DEF  temppath[255]:STRING
  DEF newCountStr[10]:STRING
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  
  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{entry}])
    StringF(temppath,'COMPUTER.\d',i)
    writeToolType(self.computersTooltype,temppath,entry)
  ENDFOR
  FOR i:=count+1 TO self.oldcount
    StringF(temppath,'COMPUTER.\d',i)
    deleteToolType(self.computersTooltype,temppath)
  ENDFOR
  StringF(newCountStr,'\d',count)
  writeToolType(self.computersTooltype,'COMPUTER.NUM',newCountStr)
  self.oldcount:=count
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC editComputers(acpName) OF frmEditList
  DEF count,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF bbsPath[200]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook

  self.changed:=FALSE

  NEW saveHook
  installhook( saveHook, {saveComputersChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook
  
  self.editCaption1:='Edit Computers'
  self.editCaption2:='Computer'
  
  set(self.app.grp_arrange,MUIA_Group_Columns,1)
  set(self.strItem,MUIA_ShowMe,MUI_TRUE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,MUI_TRUE)

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  self.computersTooltype:=String(255)
  StringF(self.computersTooltype,'\sComputerList',bbsPath)

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , MUI_TRUE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(COMPS_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(COMPS_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(COMPS_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(COMPS_DELETE))
  set(self.strItem, MUIA_ShortHelp , getHelpText(COMPS_NAME))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Computers')
  set( self.winMain, MUIA_Window_ID, "FCPS")

  self.addNotifications()

  count:=readToolTypeInt(self.computersTooltype,'COMPUTER.NUM')
  IF (count>0)
    FOR i:=1 TO count
      StringF(temppath,'COMPUTER.\d',i)
      readToolType(self.computersTooltype,temppath,tempstr)
      domethod( self.lList , [ MUIM_List_InsertSingle , tempstr , MUIV_List_Insert_Bottom ] )
    ENDFOR
  ENDIF
  self.oldcount:=count

  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)
  
  self.showModal()
  self.removeNotifications()
  END saveHook
  END closeHook
  DisposeLink(self.computersTooltype)
ENDPROC

PROC saveNamesNotAllowedChanges() OF frmEditList
  DEF i,count,entry
  DEF  temppath[255]:STRING

  MOVE.L (A1),self
  GetA4()

  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  
  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{entry}])
    StringF(temppath,'NAME.\d',i)
    writeToolType(self.namesTooltype,temppath,entry)
  ENDFOR
  FOR i:=count+1 TO self.oldcount
    StringF(temppath,'NAME.\d',i)
    deleteToolType(self.namesTooltype,temppath)
  ENDFOR
  self.oldcount:=count
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC editNamesNotAllowed(acpName) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF bbsPath[200]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  
  self.changed:=FALSE

  NEW saveHook
  installhook( saveHook, {saveNamesNotAllowedChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  
  self.editCaption1:='Edit Names Not Allowed'
  self.editCaption2:='Name'

  set(self.app.grp_arrange,MUIA_Group_Columns,1)
  set(self.strItem,MUIA_ShowMe,MUI_TRUE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,MUI_TRUE)

  self.namesTooltype:=String(255)
  StringF(self.namesTooltype,'\sNamesNotAllowed',bbsPath)

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , MUI_TRUE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(NNA_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(NNA_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(NNA_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(NNA_DELETE))
  set(self.strItem, MUIA_ShortHelp , getHelpText(NNA_NAME))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Names Not Allowed')
  set( self.winMain, MUIA_Window_ID, "FNNS")

  self.addNotifications()

  loop:=TRUE
  count:=0
  WHILE (loop)
    StringF(temppath,'NAME.\d',count+1)
    readToolType(self.namesTooltype,temppath,tempstr)
    IF StrLen(tempstr)>0
      domethod( self.lList , [ MUIM_List_InsertSingle , tempstr , MUIV_List_Insert_Bottom ] )
      count++   
    ELSE
      loop:=FALSE
    ENDIF
  ENDWHILE
  self.oldcount:=count
  
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  self.showModal()
  self.removeNotifications()
  END saveHook
  END closeHook
  DisposeLink(self.namesTooltype)
ENDPROC

PROC saveDrivesChanges() OF frmEditList
  DEF i,count,entry
  DEF  temppath[255]:STRING

  MOVE.L (A1),self
  GetA4()

  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  
  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{entry}])
    StringF(temppath,'DRIVE.\d',i)
    writeToolType(self.drivesTooltype,temppath,entry)
  ENDFOR
  FOR i:=count+1 TO self.oldcount
    StringF(temppath,'DRIVE.\d',i)
    deleteToolType(self.drivesTooltype,temppath)
  ENDFOR
  self.oldcount:=count
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC editDrives(acpName) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF bbsPath[200]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook

  self.changed:=FALSE

  NEW saveHook
  installhook( saveHook, {saveDrivesChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.editCaption1:='Edit Drives'
  self.editCaption2:='Drive'

  set(self.app.grp_arrange,MUIA_Group_Columns,1)
  set(self.strItem,MUIA_ShowMe,MUI_TRUE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,MUI_TRUE)

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  self.drivesTooltype:=String(255)
  StringF(self.drivesTooltype,'\sDrives',bbsPath)

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , MUI_TRUE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(DRV_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(DRV_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(DRV_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(DRV_DELETE))
  set(self.strItem, MUIA_ShortHelp , getHelpText(DRV_NAME))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Drives')
  set( self.winMain, MUIA_Window_ID, "FDRS")

  self.addNotifications()

  loop:=TRUE
  count:=0
  WHILE (loop)
    StringF(temppath,'DRIVE.\d',count+1)
    readToolType(self.drivesTooltype,temppath,tempstr)
    IF StrLen(tempstr)>0
      domethod( self.lList , [ MUIM_List_InsertSingle , tempstr , MUIV_List_Insert_Bottom ] )
      count++   
    ELSE
      loop:=FALSE
    ENDIF
  ENDWHILE
  self.oldcount:=count
  
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  IF self.showModal()
  ENDIF
  self.removeNotifications()
  END saveHook
  END closeHook
  DisposeLink(self.drivesTooltype)
ENDPROC

PROC saveLanguagesChanges() OF frmEditList
  DEF i,count,entry
  DEF  temppath[255]:STRING

  MOVE.L (A1),self
  GetA4()

  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  
  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{entry}])
    StringF(temppath,'LANGUAGE.\d',i)
    writeToolType(self.languagesTooltype,temppath,entry)
  ENDFOR
  FOR i:=count+1 TO self.oldcount
    StringF(temppath,'LANGUAGE.\d',i)
    deleteToolType(self.languagesTooltype,temppath)
  ENDFOR
  self.oldcount:=count
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC editLanguages(acpName) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF bbsPath[200]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook

  self.changed:=FALSE

  NEW saveHook
  installhook( saveHook, {saveLanguagesChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.editCaption1:='Edit Languages'
  self.editCaption2:='Language'

  set(self.app.grp_arrange,MUIA_Group_Columns,1)
  set(self.strItem,MUIA_ShowMe,MUI_TRUE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,MUI_TRUE)

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  self.languagesTooltype:=String(255)
  StringF(self.languagesTooltype,'\sLanguages',bbsPath)

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , MUI_TRUE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(LANG_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(LANG_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(LANG_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(LANG_DELETE))
  set(self.strItem, MUIA_ShortHelp , getHelpText(LANG_NAME))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Languages')
  set( self.winMain, MUIA_Window_ID, "FLNS")

  self.addNotifications()

  loop:=TRUE
  count:=0
  WHILE (loop)
    StringF(temppath,'LANGUAGE.\d',count+1)
    readToolType(self.languagesTooltype,temppath,tempstr)
    IF StrLen(tempstr)>0
      domethod( self.lList , [ MUIM_List_InsertSingle , tempstr , MUIV_List_Insert_Bottom ] )
      count++   
    ELSE
      loop:=FALSE
    ENDIF
  ENDWHILE
  self.oldcount:=count
  
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  IF self.showModal()
  ENDIF
  self.removeNotifications()
  END saveHook
  END closeHook
  DisposeLink(self.languagesTooltype)
ENDPROC

PROC saveScreenTypesChanges() OF frmEditList
  DEF i,count,entry
  DEF  temppath[255]:STRING

  MOVE.L (A1),self
  GetA4()

  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  
  FOR i:=1 TO count
    StringF(temppath,'TYPE.\d',i)
    writeToolType(self.screenTypesTooltype,temppath,self.extensions.item(i-1))

    StringF(temppath,'TITLE.\d',i)
    writeToolType(self.screenTypesTooltype,temppath,self.titles.item(i-1))
  ENDFOR
  FOR i:=count+1 TO self.oldcount
    StringF(temppath,'TYPE.\d',i)
    deleteToolType(self.screenTypesTooltype,temppath)

    StringF(temppath,'TITLE.\d',i)
    deleteToolType(self.screenTypesTooltype,temppath)
  ENDFOR
  self.oldcount:=count
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC editScreens(acpName) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING,tempstr2[255]:STRING
  DEF bbsPath[200]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  DEF titles:PTR TO stringlist
  DEF extensions:PTR TO stringlist

  self.changed:=FALSE

  NEW saveHook
  installhook( saveHook, {saveScreenTypesChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.editCaption1:='Edit Screentypes'
  self.editCaption2:='Screentype'

  set(self.app.grp_arrange,MUIA_Group_Columns,2)
  set(self.strItem,MUIA_ShowMe,FALSE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,FALSE)

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  self.screenTypesTooltype:=String(255)
  StringF(self.screenTypesTooltype,'\sScreenTypes',bbsPath)

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , FALSE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(SCRN_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(SCRN_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(SCRN_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(SCRN_DELETE))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Screentypes')
  set( self.winMain, MUIA_Window_ID, "FSTS")

  self.setupButtonClick(self.btnItemAdd,self.btnAddClick,{screenitemAdd})
  self.setupButtonClick(self.btnItemEdit,self.btnEditClick,{screenitemEdit})
  self.setupButtonClick(self.btnItemRemove,self.btnRemoveClick,{screenitemRemove})
  self.addNotifications(TRUE)

  NEW titles.stringlist(100)
  self.titles:=titles
  NEW extensions.stringlist(100)
  self.extensions:=extensions
  
  loop:=TRUE
  count:=0
  WHILE (loop)
    StringF(temppath,'TYPE.\d',count+1)
    readToolType(self.screenTypesTooltype,temppath,tempstr)

    StringF(temppath,'TITLE.\d',count+1)
    readToolType(self.screenTypesTooltype,temppath,tempstr2)
    
    IF StrLen(tempstr2)>0
      self.extensions.add(tempstr)
      self.titles.add(tempstr2)
      IF StrLen(tempstr)>0
        StringF(tempstr,'\s (\s)',tempstr2,tempstr)
      ELSE
        StrCopy(tempstr,'\s',tempstr2)
      ENDIF
    ENDIF

    IF StrLen(tempstr)>0
      domethod( self.lList , [ MUIM_List_InsertSingle , tempstr , MUIV_List_Insert_Bottom ] )
      count++   
    ELSE
      loop:=FALSE
    ENDIF
  ENDWHILE
  self.oldcount:=count
  
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  self.showModal()
  self.removeNotifications(TRUE)
  domethod(self.btnItemAdd,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemEdit,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemRemove,[MUIM_KillNotify,MUIA_Pressed])
  END saveHook
  END closeHook
  END titles
  END extensions
  DisposeLink(self.screenTypesTooltype)
ENDPROC

PROC saveAreasChanges() OF frmEditList
  DEF i,j,count
  DEF  temppath[255]:STRING
  DEF accessPath[255]:STRING
  DEF areaToolType[255]:STRING
  DEF area:PTR TO area
  DEF confToolType[20]:STRING

  MOVE.L (A1),self
  GetA4()
  
  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  

  StringF(accessPath,'\saccess/',self.bbsPath)

  FOR i:=0 TO self.deleteAreas.count()-1
    StringF(areaToolType,'\sArea.\s.info',accessPath,self.deleteAreas.item(i))
    deleteFileFromCache(areaToolType)
    DeleteFile(areaToolType)
  ENDFOR
  self.deleteAreas.clear()

  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{area}])
    StringF(areaToolType,'\sArea.\s',accessPath,area)

    area:=self.areaLists.item(i-1)
    FOR j:=1 TO ListLen(area.confList)
      StringF(confToolType,'CONF.\d',j)
      IF area.confList[j-1]
        writeToolType(areaToolType,confToolType,-1)
      ELSE 
        deleteToolType(areaToolType,confToolType)
      ENDIF
    ENDFOR
  ENDFOR
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC loadAreaNames(confCount) OF frmEditList
  DEF accessPath[255]:STRING
  DEF areaToolType[255]:STRING
  DEF confToolType[20]:STRING
  DEF dir_info:PTR TO fileinfoblock
  DEF pdir,r,entry,i,n
  DEF area:PTR TO area

  DEF confList:PTR TO LONG

  DEF buf[255]:STRING
  DEF parseBuf[100]:STRING
  DEF namesList:PTR TO stringlist

  StringF(accessPath,'\saccess/',self.bbsPath)
 
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
  
  domethod( self.lList , [ MUIM_List_Clear] )

  NEW namesList.stringlist(20)

  WHILE(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0)

      IF MatchPatternNoCase(parseBuf,dir_info.filename)
        StrCopy(buf,dir_info.filename+5)
        stripInfo(buf)
        namesList.add(buf)
      ENDIF
    ENDIF
  ENDWHILE
   
  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)

  namesList.sort()
  FOR n:=0 TO namesList.count()-1

    NEW area.create()

    domethod( self.lList , [ MUIM_List_InsertSingle , namesList.item(n) , MUIV_List_Insert_Bottom ] )
    
    StrCopy(area.filename,namesList.item(n))
    area.confList:=List(confCount)
    StringF(areaToolType,'\sArea.\s',accessPath,namesList.item(n))
    FOR i:=0 TO confCount-1
      StringF(confToolType,'CONF.\d',i+1)
      ListAddItem(area.confList,IF checkToolTypeExists(areaToolType,confToolType) THEN TRUE ELSE FALSE)
    ENDFOR
    self.areaLists.add(area)
  ENDFOR
  
  END namesList
ENDPROC

PROC editAreas(acpName) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING,tempstr2[255]:STRING
  DEF bbsPath[255]:STRING
  DEF confConfig[255]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  DEF areaLists:PTR TO stdlist
  DEF deleteAreas:PTR TO stringlist
  DEF area:PTR TO area
  DEF confCount

  self.changed:=FALSE

  self.acpName:=acpName

  NEW saveHook
  installhook( saveHook, {saveAreasChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.editCaption1:='Edit Areas'
  self.editCaption2:='Areas'

  set(self.app.grp_arrange,MUIA_Group_Columns,2)
  set(self.strItem,MUIA_ShowMe,FALSE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,FALSE)

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  self.bbsPath:=bbsPath

  StringF(confConfig,'\sCONFCONFIG',bbsPath) 

  confCount:=readToolTypeInt(confConfig,'NCONFS')

  NEW areaLists.stdlist(25)
  self.areaLists:=areaLists
  
  NEW deleteAreas.stringlist(25)
  self.deleteAreas:=deleteAreas

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , FALSE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(AREAS_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(AREAS_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(AREAS_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(AREAS_DELETE))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Areas')
  set( self.winMain, MUIA_Window_ID, "FARS")

  self.setupButtonClick(self.btnItemAdd,self.btnAddClick,{areaitemAdd})
  self.setupButtonClick(self.btnItemEdit,self.btnEditClick,{areaitemEdit})
  self.setupButtonClick(self.btnItemRemove,self.btnRemoveClick,{areaitemRemove})
  self.addNotifications(TRUE)

  self.loadAreaNames(confCount)
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  self.showModal()
  self.removeNotifications(TRUE)
  domethod(self.btnItemAdd,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemEdit,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemRemove,[MUIM_KillNotify,MUIA_Pressed])
  END saveHook
  END closeHook
  FOR i:=0 TO areaLists.count()-1
    area:=areaLists.item(i)
    END area
  ENDFOR
  END areaLists
  END deleteAreas
ENDPROC

PROC saveAccessLevelChanges() OF frmEditList
  DEF i,j,count
  DEF  temppath[255]:STRING
  DEF accessLevel:PTR TO accessLevel
  DEF accessPath[255]:STRING
  DEF accessToolType[255]:STRING
  DEF acs
  DEF confToolType[20]:STRING
  DEF acsValues:PTR TO LONG
  DEF tempStr[255]:STRING

  MOVE.L (A1),self
  GetA4()
  
  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  

  StringF(accessPath,'\saccess/',self.bbsPath)

  FOR i:=0 TO self.deleteAccessLevels.count()-1
    StringF(accessToolType,'\sACS.\s.info',accessPath,self.deleteAccessLevels.item(i))
    deleteFileFromCache(accessToolType)
    DeleteFile(accessToolType)
  ENDFOR
  self.deleteAccessLevels.clear()
  
  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{acs}])
    StringF(accessToolType,'\sACS.\s',accessPath,acs)

    accessLevel:=self.accessLists.item(i-1)

    acsValues:=getAccessLevels()

    FOR j:=0 TO ListLen(acsValues)-1
      IF j=0
        writeToolType(accessToolType,'ACS.MAX_PAGES',accessLevel.accessList.item(0))
      ELSE
        IF accessLevel.accessList.contains(acsValues[j]) THEN writeToolType(accessToolType,acsValues[j],-1) ELSE deleteToolType(accessToolType,acsValues[j])
      ENDIF
    ENDFOR  
  ENDFOR
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC loadAccessLevels() OF frmEditList
  DEF accessPath[255]:STRING
  DEF accessToolType[255]:STRING
  DEF dir_info:PTR TO fileinfoblock
  DEF pdir,r,entry,i,n
  DEF accessLevel:PTR TO accessLevel
  DEF tempStr[255]:STRING

  DEF buf[255]:STRING
  DEF parseBuf[100]:STRING
  DEF namesList:PTR TO stringlist
  DEF acsValues:PTR TO LONG

  StringF(accessPath,'\saccess/',self.bbsPath)
 
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

  IF ParsePatternNoCase('ACS.#?.info',parseBuf,100) =-1 THEN RETURN
  
  domethod( self.lList , [ MUIM_List_Clear] )

  NEW namesList.stringlist(100)

  WHILE(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0)

      IF MatchPatternNoCase(parseBuf,dir_info.filename)
        StrCopy(buf,dir_info.filename+4)
        stripInfo(buf)
        namesList.add(buf)
      ENDIF
    ENDIF
  ENDWHILE

  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)

  namesList.sort()
  FOR n:=0 TO namesList.count()-1
    domethod( self.lList , [ MUIM_List_InsertSingle , namesList.item(n) , MUIV_List_Insert_Bottom ] )
    NEW accessLevel.create()
    
    StrCopy(accessLevel.filename,namesList.item(n))
    StringF(accessToolType,'\sACS.\s',accessPath,namesList.item(n))
    
    acsValues:=getAccessLevels()

    FOR i:=0 TO ListLen(acsValues)-1
      IF i=0
        readToolType(accessToolType,acsValues[0],tempStr)
        accessLevel.accessList.add(tempStr)
      ELSE
        IF checkToolTypeExists(accessToolType,acsValues[i]) THEN accessLevel.accessList.add(acsValues[i])
      ENDIF
    ENDFOR
   
    self.accessLists.add(accessLevel)
  ENDFOR

  END namesList
ENDPROC

PROC editAccessLevel(acpName) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING,tempstr2[255]:STRING
  DEF bbsPath[255]:STRING
  DEF confConfig[255]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  DEF accessLists:PTR TO stdlist
  DEF deleteAccessLevels:PTR TO stringlist
  DEF accessLevel:PTR TO accessLevel

  self.changed:=FALSE

  self.acpName:=acpName

  NEW saveHook
  installhook( saveHook, {saveAccessLevelChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.editCaption1:='Edit Access Levels'
  self.editCaption2:='Access Level'

  set(self.app.grp_arrange,MUIA_Group_Columns,2)
  set(self.strItem,MUIA_ShowMe,FALSE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,FALSE)

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  self.bbsPath:=bbsPath

  NEW accessLists.stdlist(25)
  self.accessLists:=accessLists

  NEW deleteAccessLevels.stringlist(25)
  self.deleteAccessLevels:=deleteAccessLevels

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , FALSE)
  set(self.strItem, MUIA_String_Contents,'')

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Access Levels')
  set( self.winMain, MUIA_Window_ID, "FALS")

  set( self.lvList , MUIA_ShortHelp , getHelpText(ACS_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(ACS_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(ACS_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(ACS_DELETE))

  self.setupButtonClick(self.btnItemAdd,self.btnAddClick,{accessLevelitemAdd})
  self.setupButtonClick(self.btnItemEdit,self.btnEditClick,{accessLevelitemEdit})
  self.setupButtonClick(self.btnItemRemove,self.btnRemoveClick,{accessLevelitemRemove})
  self.addNotifications(TRUE)

  self.loadAccessLevels()
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  self.showModal()
  self.removeNotifications(TRUE)
  domethod(self.btnItemAdd,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemEdit,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemRemove,[MUIM_KillNotify,MUIA_Pressed])

  END saveHook
  END closeHook

  FOR i:=0 TO accessLists.count()-1
    accessLevel:=accessLists.item(i)
    END accessLevel
  ENDFOR
  END accessLists
  END deleteAccessLevels
ENDPROC

PROC saveFCheckChanges() OF frmEditList
  DEF i,count
  DEF fCheckPath[255]:STRING
  DEF fCheckToolType[255]:STRING
  DEF fcheckName
  DEF fChecker:PTR TO fChecker
  DEF tempStr[255]:STRING

  MOVE.L (A1),self
  GetA4()

  self.sleep()  
  get(self.lList,MUIA_List_Entries,{count})  

  StringF(fCheckPath,'\sfcheck/',self.bbsPath)

  FOR i:=0 TO self.deletefCheckLists.count()-1
    StringF(fCheckToolType,'\s\s.info',fCheckPath,self.deletefCheckLists.item(i))
    deleteFileFromCache(fCheckToolType)
    DeleteFile(fCheckToolType)
  ENDFOR
  self.deletefCheckLists.clear()

  
  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{fcheckName}])
    StringF(fCheckToolType,'\s\s',fCheckPath,fcheckName)

    fChecker:=self.fCheckLists.item(i-1)
  
    writeToolType(fCheckToolType,'CHECKER',fChecker.checker)
    writeToolType(fCheckToolType,'ERROR.1',fChecker.error1)
    writeToolType(fCheckToolType,'ERROR.2',fChecker.error2)
    writeToolType(fCheckToolType,'ERROR.3',fChecker.error3)
    writeToolType(fCheckToolType,'ERROR.4',fChecker.error4)
    writeToolType(fCheckToolType,'ERROR.5',fChecker.error5)
    writeToolType(fCheckToolType,'ERROR.6',fChecker.error6)
    writeToolType(fCheckToolType,'ERROR.7',fChecker.error7)
    writeToolType(fCheckToolType,'ERROR.8',fChecker.error8)
    writeToolType(fCheckToolType,'ERROR.9',fChecker.error9)
    writeToolType(fCheckToolType,'ERROR.10',fChecker.error10)
    writeToolType(fCheckToolType,'OPTIONS',fChecker.options)
    writeToolType(fCheckToolType,'PRIORITY',fChecker.priority)
    writeToolType(fCheckToolType,'SCRIPT',fChecker.script)
    writeToolType(fCheckToolType,'STACK',fChecker.stack)
  ENDFOR
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC loadFileCheckers() OF frmEditList
  DEF fCheckPath[255]:STRING
  DEF fCheckToolType[255]:STRING
  DEF tempStr[255]:STRING
  DEF dir_info:PTR TO fileinfoblock
  DEF pdir,r,entry,i,n
  DEF fileChecker:PTR TO fChecker

  DEF buf[255]:STRING
  DEF parseBuf[100]:STRING
  DEF namesList:PTR TO stringlist

  StringF(fCheckPath,'\sfcheck/',self.bbsPath)
 
  IF ((dir_info:=AllocDosObject(DOS_FIB,NIL)) = NIL)
    RETURN 0
  ENDIF
  
  IF ((pdir:=Lock(fCheckPath,ACCESS_READ)))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF
  
  IF(Examine(pdir, dir_info))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    UnLock(pdir)
    RETURN 0
  ENDIF

  IF ParsePatternNoCase('#?.info',parseBuf,100) =-1 THEN RETURN
  
  domethod( self.lList , [ MUIM_List_Clear] )

  NEW namesList.stringlist(20)

  WHILE(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0)

      IF MatchPatternNoCase(parseBuf,dir_info.filename)
        StrCopy(buf,dir_info.filename)
        stripInfo(buf)
        namesList.add(buf)
      ENDIF
    ENDIF
  ENDWHILE
   
  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)

  namesList.sort()
  FOR n:=0 TO namesList.count()-1
    domethod( self.lList , [ MUIM_List_InsertSingle , namesList.item(n) , MUIV_List_Insert_Bottom ] )
    StringF(fCheckToolType,'\s\s',fCheckPath,namesList.item(n))
    
    NEW fileChecker.create()
    //load fcheck details
    StrCopy(fileChecker.filename,namesList.item(n))
    readToolType(fCheckToolType,'CHECKER',tempStr)
    StrCopy(fileChecker.checker,tempStr)
    readToolType(fCheckToolType,'OPTIONS',tempStr)
    StrCopy(fileChecker.options,tempStr)
    readToolType(fCheckToolType,'SCRIPT',tempStr)
    StrCopy(fileChecker.script,tempStr)
    readToolType(fCheckToolType,'ERROR.1',tempStr)
    StrCopy(fileChecker.error1,tempStr)
    readToolType(fCheckToolType,'ERROR.2',tempStr)
    StrCopy(fileChecker.error2,tempStr)
    readToolType(fCheckToolType,'ERROR.3',tempStr)
    StrCopy(fileChecker.error3,tempStr)
    readToolType(fCheckToolType,'ERROR.4',tempStr)
    StrCopy(fileChecker.error4,tempStr)
    readToolType(fCheckToolType,'ERROR.5',tempStr)
    StrCopy(fileChecker.error5,tempStr)
    readToolType(fCheckToolType,'ERROR.6',tempStr)
    StrCopy(fileChecker.error6,tempStr)
    readToolType(fCheckToolType,'ERROR.7',tempStr)
    StrCopy(fileChecker.error7,tempStr)
    readToolType(fCheckToolType,'ERROR.8',tempStr)
    StrCopy(fileChecker.error8,tempStr)
    readToolType(fCheckToolType,'ERROR.9',tempStr)
    StrCopy(fileChecker.error9,tempStr)
    readToolType(fCheckToolType,'ERROR.10',tempStr)
    StrCopy(fileChecker.error10,tempStr)
    readToolType(fCheckToolType,'PRIORITY',tempStr)
    StrCopy(fileChecker.priority,tempStr)
    readToolType(fCheckToolType,'STACK',tempStr)
    StrCopy(fileChecker.stack,tempStr)

    self.fCheckLists.add(fileChecker)
  ENDFOR
  END namesList
ENDPROC

PROC editFileCheckers(acpName) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING,tempstr2[255]:STRING
  DEF bbsPath[255]:STRING
  DEF confConfig[255]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  DEF fCheckLists:PTR TO stdlist
  DEF deletefCheckLists:PTR TO stringlist
  DEF fileChecker:PTR TO fChecker

  self.changed:=FALSE

  self.acpName:=acpName

  NEW saveHook
  installhook( saveHook, {saveFCheckChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.editCaption1:='Edit File Checkers'
  self.editCaption2:='File Checker'

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  self.bbsPath:=bbsPath

  NEW fCheckLists.stdlist(25)
  self.fCheckLists:=fCheckLists

  NEW deletefCheckLists.stringlist(25)
  self.deletefCheckLists:=deletefCheckLists

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , FALSE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(FCHK_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(FCHK_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(FCHK_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(FCHK_DELETE))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit File Checkers')
  set( self.winMain, MUIA_Window_ID, "FCHK")

  set(self.app.grp_arrange,MUIA_Group_Columns,2)
  set(self.strItem,MUIA_ShowMe,FALSE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,FALSE)

  self.setupButtonClick(self.btnItemAdd,self.btnAddClick,{fileCheckitemAdd})
  self.setupButtonClick(self.btnItemEdit,self.btnEditClick,{fileCheckitemEdit})
  self.setupButtonClick(self.btnItemRemove,self.btnRemoveClick,{fileCheckitemRemove})
  self.addNotifications(TRUE)

  self.loadFileCheckers()
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  self.showModal()
  self.removeNotifications(TRUE)
  domethod(self.btnItemAdd,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemEdit,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemRemove,[MUIM_KillNotify,MUIA_Pressed])
  END saveHook
  END closeHook
  FOR i:=0 TO fCheckLists.count()-1
    fileChecker:=fCheckLists.item(i)
    END fileChecker
  ENDFOR
  END fCheckLists
  END deletefCheckLists
ENDPROC

PROC saveProtocolChanges() OF frmEditList
  DEF i,count
  DEF protocolPath[255]:STRING
  DEF protocolToolType[255]:STRING
  DEF protocolName
  DEF protocol:PTR TO protocol
  DEF tempStr[255]:STRING

  MOVE.L (A1),self
  GetA4()

  self.sleep()  
  get(self.lList,MUIA_List_Entries,{count})  

  StringF(protocolPath,'\sprotocols/',self.bbsPath)

  FOR i:=0 TO self.deleteProtocolLists.count()-1
    StringF(protocolToolType,'\s\s.info',protocolPath,self.deleteProtocolLists.item(i))
    deleteFileFromCache(protocolToolType)
    DeleteFile(protocolToolType)
  ENDFOR
  self.deleteProtocolLists.clear()

  
  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{protocolName}])
    StringF(protocolToolType,'\s\s',protocolPath,protocolName)

    protocol:=self.protocolLists.item(i-1)
  
    writeToolType(protocolToolType,'OPTIONS',protocol.options)
    writeToolType(protocolToolType,'HTTPHOST',protocol.httpHost)
    writeToolType(protocolToolType,'HTTPTEMP',protocol.httpTemp)
    writeToolType(protocolToolType,'FTPHOST',protocol.ftpHost)
    IF protocol.ftpAuth THEN writeToolType(protocolToolType,'FTPAUTH',-1) ELSE deleteToolType(protocolToolType,'FTPAUTH')
    writeToolType(protocolToolType,'RXWINDOW',protocol.rxWindow)
    writeToolType(protocolToolType,'TXWINDOW',protocol.txWindow)
  ENDFOR
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC loadProtocols() OF frmEditList
  DEF protocolPath[255]:STRING
  DEF protocolToolType[255]:STRING
  DEF tempStr[255]:STRING
  DEF dir_info:PTR TO fileinfoblock
  DEF pdir,r,entry,i,n
  DEF protocol:PTR TO protocol

  DEF buf[255]:STRING
  DEF parseBuf[100]:STRING
  DEF namesList:PTR TO stringlist

  StringF(protocolPath,'\sprotocols/',self.bbsPath)
 
  IF ((dir_info:=AllocDosObject(DOS_FIB,NIL)) = NIL)
    RETURN 0
  ENDIF
  
  IF ((pdir:=Lock(protocolPath,ACCESS_READ)))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF
  
  IF(Examine(pdir, dir_info))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    UnLock(pdir)
    RETURN 0
  ENDIF

  IF ParsePatternNoCase('#?.info',parseBuf,100) =-1 THEN RETURN
  
  domethod( self.lList , [ MUIM_List_Clear] )

  NEW namesList.stringlist(20)

  WHILE(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0)

      IF MatchPatternNoCase(parseBuf,dir_info.filename)
        StrCopy(buf,dir_info.filename)
        stripInfo(buf)
        namesList.add(buf)
      ENDIF
    ENDIF
  ENDWHILE

  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)

  namesList.sort()
  FOR n:=0 TO namesList.count()-1

    domethod( self.lList , [ MUIM_List_InsertSingle , namesList.item(n) , MUIV_List_Insert_Bottom ] )
    StringF(protocolToolType,'\s\s',protocolPath,namesList.item(n))
    
    NEW protocol.create()
    //load protocol details
    
    StrCopy(protocol.filename,namesList.item(n))
    
    readToolType(protocolToolType,'OPTIONS',tempStr)
    StrCopy(protocol.options,tempStr)

    readToolType(protocolToolType,'HTTPHOST',tempStr)
    StrCopy(protocol.httpHost,tempStr)

    readToolType(protocolToolType,'HTTPTEMP',tempStr)
    StrCopy(protocol.httpTemp,tempStr)

    readToolType(protocolToolType,'FTPHOST',tempStr)
    StrCopy(protocol.ftpHost,tempStr)

    protocol.ftpAuth:=checkToolTypeExists(protocolToolType,'FTPAUTH')

    readToolType(protocolToolType,'RXWINDOW',tempStr)
    StrCopy(protocol.rxWindow,tempStr)

    readToolType(protocolToolType,'TXWINDOW',tempStr)
    StrCopy(protocol.txWindow,tempStr)

    self.protocolLists.add(protocol)
  ENDFOR   
  END namesList
ENDPROC

PROC editProtocols(acpName) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING,tempstr2[255]:STRING
  DEF bbsPath[255]:STRING
  DEF confConfig[255]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  DEF protocolLists:PTR TO stdlist
  DEF deleteProtocolLists:PTR TO stringlist
  DEF protocol:PTR TO protocol

  self.changed:=FALSE

  self.acpName:=acpName

  NEW saveHook
  installhook( saveHook, {saveProtocolChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.editCaption1:='Edit Protocols'
  self.editCaption2:='Protocol'

  set(self.app.grp_arrange,MUIA_Group_Columns,2)
  set(self.strItem,MUIA_ShowMe,FALSE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,FALSE)

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  self.bbsPath:=bbsPath

  NEW protocolLists.stdlist(25)
  self.protocolLists:=protocolLists

  NEW deleteProtocolLists.stringlist(25)
  self.deleteProtocolLists:=deleteProtocolLists

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , FALSE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(PCOL_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(PCOL_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(PCOL_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(PCOL_DELETE))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Protocols')
  set( self.winMain, MUIA_Window_ID, "PCOL")


  self.setupButtonClick(self.btnItemAdd,self.btnAddClick,{protocolitemAdd})
  self.setupButtonClick(self.btnItemEdit,self.btnEditClick,{protocolitemEdit})
  self.setupButtonClick(self.btnItemRemove,self.btnRemoveClick,{protocolitemRemove})
  self.addNotifications(TRUE)

  self.loadProtocols()
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  self.showModal()
  self.removeNotifications(TRUE)
  domethod(self.btnItemAdd,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemEdit,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemRemove,[MUIM_KillNotify,MUIA_Pressed])
  END saveHook
  END closeHook
  FOR i:=0 TO protocolLists.count()-1
    protocol:=protocolLists.item(i)
    END protocol
  ENDFOR
  END protocolLists
  END deleteProtocolLists
ENDPROC

PROC saveCommandChanges() OF frmEditList
  DEF i,count,val
  DEF commandPath[255]:STRING
  DEF commandToolType[255]:STRING
  DEF commandName
  DEF command:PTR TO command
  DEF tempStr[255]:STRING

  MOVE.L (A1),self
  GetA4()
  
  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  

  StringF(commandPath,'\scommands/\s/',self.bbsPath,self.commandPath)

  FOR i:=0 TO self.deleteCommandLists.count()-1
    StringF(commandToolType,'\s\s.info',commandPath,self.deleteCommandLists.item(i))
    deleteFileFromCache(commandToolType)
    DeleteFile(commandToolType)
  ENDFOR
  self.deleteCommandLists.clear()

  makeDir(self.commandPath)

  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{commandName}])
    StringF(commandToolType,'\s\s',commandPath,commandName)

    command:=self.commandLists.item(i-1)
  
    writeToolType(commandToolType,'NAME',command.name)
    writeToolType(commandToolType,'LOCATION',command.location)
    writeToolType(commandToolType,'ACCESS',command.access)
    writeToolType(commandToolType,'INTERNAL',command.internal)
    writeToolType(commandToolType,'MIMICVER',command.mimicVer)
    writeToolType(commandToolType,'PASSWORD',command.password)

    writeToolType(commandToolType,'PASS_PARAMETERS',command.passParams)
    writeToolType(commandToolType,'PRIORITY',command.priority)
   
    IF command.resident THEN writeToolType(commandToolType,'RESIDENT',-1) ELSE deleteToolType(commandToolType,'RESIDENT')
    IF command.quickMode THEN writeToolType(commandToolType,'QUICKMODE',-1) ELSE deleteToolType(commandToolType,'QUICKMODE')

    writeToolType(commandToolType,'STACK',command.stack)
    writeToolType(commandToolType,'TYPE',command.type)

    IF command.trapon THEN writeToolType(commandToolType,'TRAPON',-1) ELSE deleteToolType(commandToolType,'TRAPON')
    IF command.expertMode THEN writeToolType(commandToolType,'EXPERT_MODE',-1) ELSE deleteToolType(commandToolType,'EXPERT_MODE')
    IF command.doorSilent THEN writeToolType(commandToolType,'DOORSILENT',-1) ELSE deleteToolType(commandToolType,'DOORSILENT')
    IF command.logInputs THEN writeToolType(commandToolType,'LOG_INPUTS',-1) ELSE deleteToolType(commandToolType,'LOG_INPUTS')
    IF command.scriptCheck THEN writeToolType(commandToolType,'SCRIPTCHECK',-1) ELSE deleteToolType(commandToolType,'SCRIPTCHECK')
    
    IF command.multiNode THEN writeToolType(commandToolType,'MULTINODE','YES')
    writeToolType(commandToolType,'BANNER',command.banner)
  ENDFOR
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC loadCommands() OF frmEditList
  DEF commandPath[255]:STRING
  DEF commandToolType[255]:STRING
  DEF tempStr[255]:STRING
  DEF dir_info:PTR TO fileinfoblock
  DEF pdir,r,entry,i,n
  DEF command:PTR TO command
  DEF val
  DEF c=0

  DEF buf[255]:STRING
  DEF parseBuf[100]:STRING
  DEF namesList:PTR TO stringlist

  StringF(commandPath,'\scommands/\s/',self.bbsPath,self.commandPath)
 
  IF ((dir_info:=AllocDosObject(DOS_FIB,NIL)) = NIL)
    RETURN 0
  ENDIF
  
  IF ((pdir:=Lock(commandPath,ACCESS_READ)))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF
  
  IF(Examine(pdir, dir_info))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    UnLock(pdir)
    RETURN 0
  ENDIF

  IF ParsePatternNoCase('#?.info',parseBuf,100) =-1 THEN RETURN
  
  domethod( self.lList , [ MUIM_List_Clear] )

  NEW namesList.stringlist(100)

  WHILE(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0)

      IF MatchPatternNoCase(parseBuf,dir_info.filename)
        StrCopy(buf,dir_info.filename)
        stripInfo(buf)
        namesList.add(buf)
      ENDIF
    ENDIF
  ENDWHILE
   
  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)

  namesList.sort()
  FOR n:=0 TO namesList.count()-1
    domethod( self.lList , [ MUIM_List_InsertSingle , namesList.item(n) , MUIV_List_Insert_Bottom ] )
    StringF(commandToolType,'\s\s',commandPath,namesList.item(n))

    NEW command.create()
   
   StrCopy(command.filename,namesList.item(n))
   
    //load command details
    readToolType(commandToolType,'NAME',tempStr)
    StrCopy(command.name,tempStr)
    readToolType(commandToolType,'LOCATION',tempStr)
    StrCopy(command.location,tempStr)
    readToolType(commandToolType,'ACCESS',tempStr)
    StrCopy(command.access,tempStr)
    readToolType(commandToolType,'INTERNAL',tempStr)
    StrCopy(command.internal,tempStr)
    readToolType(commandToolType,'MIMICVER',tempStr)
    StrCopy(command.mimicVer,tempStr)
    readToolType(commandToolType,'PASSWORD',tempStr)
    StrCopy(command.password,tempStr)
    readToolType(commandToolType,'PASS_PARAMETERS',tempStr)
    StrCopy(command.passParams,tempStr)
    readToolType(commandToolType,'PRIORITY',tempStr)
    StrCopy(command.priority,tempStr)       
    command.resident:=checkToolTypeExists(commandToolType,'RESIDENT')
    command.quickMode:=checkToolTypeExists(commandToolType,'QUICKMODE')

    readToolType(commandToolType,'STACK',tempStr)
    StrCopy(command.stack,tempStr)       

    readToolType(commandToolType,'TYPE',tempStr)
    StrCopy(command.type,tempStr)

    command.trapon:=checkToolTypeExists(commandToolType,'TRAPON')
    command.expertMode:=checkToolTypeExists(commandToolType,'EXPERT_MODE')
    command.doorSilent:=checkToolTypeExists(commandToolType,'DOORSILENT')
    command.logInputs:=checkToolTypeExists(commandToolType,'LOG_INPUTS')
    command.scriptCheck:=checkToolTypeExists(commandToolType,'SCRIPTCHECK')

    readToolType(commandToolType,'MULTINODE',tempStr)
    command.multiNode:=StriCmp(tempStr,'YES')

    readToolType(commandToolType,'BANNER',tempStr)
    StrCopy(command.banner,tempStr)

    self.commandLists.add(command)
  ENDFOR
  END namesList
  
ENDPROC

PROC editCommands(acpName,commandFolder) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING,tempstr2[255]:STRING
  DEF bbsPath[255]:STRING
  DEF confConfig[255]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  DEF commandLists:PTR TO stdlist
  DEF deleteCommandLists:PTR TO stringlist
  DEF command:PTR TO command
  DEF editStr[255]:STRING

  self.changed:=FALSE

  self.acpName:=acpName

  NEW saveHook
  installhook( saveHook, {saveCommandChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  StringF(editStr,'Edit Commands (\s)',commandFolder)
  self.editCaption1:=editStr
  self.editCaption2:='Command'

  set(self.app.grp_arrange,MUIA_Group_Columns,2)
  set(self.strItem,MUIA_ShowMe,FALSE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,FALSE)

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  self.bbsPath:=bbsPath

  NEW commandLists.stdlist(25)
  self.commandLists:=commandLists

  NEW deleteCommandLists.stringlist(25)
  self.deleteCommandLists:=deleteCommandLists
  
  self.commandPath:=commandFolder

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , FALSE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(CMDS_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(CMDS_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(CMDS_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(CMDS_DELETE))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,editStr)
  set( self.winMain, MUIA_Window_ID, "CMDL")


  self.setupButtonClick(self.btnItemAdd,self.btnAddClick,{commanditemAdd})
  self.setupButtonClick(self.btnItemEdit,self.btnEditClick,{commanditemEdit})
  self.setupButtonClick(self.btnItemRemove,self.btnRemoveClick,{commanditemRemove})
  self.addNotifications(TRUE)

  self.loadCommands()
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  self.showModal()
  self.removeNotifications(TRUE)
  domethod(self.btnItemAdd,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemEdit,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemRemove,[MUIM_KillNotify,MUIA_Pressed])
  END saveHook
  END closeHook
  FOR i:=0 TO commandLists.count()-1
    command:=commandLists.item(i)
    END command
  ENDFOR
  END commandLists
  END deleteCommandLists
ENDPROC

PROC saveConnectionChanges() OF frmEditList
  DEF i,count,entry

  MOVE.L (A1),self
  GetA4()

  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  
  
  FOR i:=0 TO self.oldconnectionstrings.count()-1
    IF self.connectlist.contains(self.oldconnectionstrings.item(i))=FALSE
      deleteToolType(self.connectDefToolType,self.oldconnectionstrings.item(i))
    ENDIF
  ENDFOR
  self.oldconnectionstrings.clear()
  FOR i:=0 TO count-1
    writeToolType(self.connectDefToolType,self.connectlist.item(i),self.connectbaud.item(i))
    self.oldconnectionstrings.add(self.connectlist.item(i))
  ENDFOR
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC editConnectionStrings(acpName) OF frmEditList
  DEF count,i,j,entry,temppath[255]:STRING,tempstr[255]:STRING,tempstr2[255]:STRING
  DEF bbsPath[200]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook
  DEF connectionstrings:PTR TO stringlist
  DEF oldconnectionstrings:PTR TO stringlist 
  DEF baudrates:PTR TO stringlist

  self.changed:=FALSE

  NEW saveHook
  installhook( saveHook, {saveConnectionChanges})
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.editCaption1:='Connection String'
  self.editCaption2:='Baud'

  set(self.app.grp_arrange,MUIA_Group_Columns,2)
  set(self.strItem,MUIA_ShowMe,FALSE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,FALSE)

  readToolType(acpName,'BBS_LOCATION',bbsPath)
  self.connectDefToolType:=String(255)
  StringF(self.connectDefToolType,'\sConnect.def',bbsPath)

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , FALSE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(CONN_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(CONN_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(CONN_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(CONN_DELETE))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Connection Strings')
  set( self.winMain, MUIA_Window_ID, "CDEF")

  self.setupButtonClick(self.btnItemAdd,self.btnAddClick,{connectionitemAdd})
  self.setupButtonClick(self.btnItemEdit,self.btnEditClick,{connectionitemEdit})
  self.setupButtonClick(self.btnItemRemove,self.btnRemoveClick,{connectionitemRemove})
  self.addNotifications(TRUE)

  NEW connectionstrings.stringlist(100)
  self.connectlist:=connectionstrings
  NEW baudrates.stringlist(100)
  self.connectbaud:=baudrates
  
  NEW oldconnectionstrings.stringlist(100)
  self.oldconnectionstrings:=oldconnectionstrings

  readAllToolTypes(self.connectDefToolType,connectionstrings)
  FOR j:=0 TO connectionstrings.count()-1
      domethod( self.lList , [ MUIM_List_InsertSingle , connectionstrings.item(j), MUIV_List_Insert_Bottom ] )
      
    StrCopy(tempstr,connectionstrings.item(j))
    StrCopy(tempstr2,'')
    i:=0
    WHILE i<EstrLen(tempstr)
       EXIT tempstr[i]="="
      IF tempstr[i]<>" " THEN StrAddChar(tempstr2,tempstr[i])
      i++
    ENDWHILE
    i++
    connectionstrings.setItem(j,tempstr2)
    oldconnectionstrings.add(tempstr2)

    StrCopy(tempstr2,'')
    WHILE i<EstrLen(tempstr)
      IF tempstr[i]<>" " THEN StrAddChar(tempstr2,tempstr[i])
      i++
    ENDWHILE
    baudrates.setItem(j,tempstr2)
  ENDFOR
  self.oldcount:=count
  
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  self.showModal()
  self.removeNotifications(TRUE)
  domethod(self.btnItemAdd,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemEdit,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnItemRemove,[MUIM_KillNotify,MUIA_Pressed])
  END saveHook
  END closeHook
  END connectionstrings
  END oldconnectionstrings
  END baudrates
  DisposeLink(self.connectDefToolType)
ENDPROC

PROC saveRestrictedChanges() OF frmEditList
  DEF i,count,entry
  DEF  temppath[255]:STRING

  MOVE.L (A1),self
  GetA4()

  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  
  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{entry}])
    StringF(temppath,'RESTRICT.\d',i)
    writeToolType(self.acpName,temppath,entry)
  ENDFOR
  FOR i:=count+1 TO self.oldcount
    StringF(temppath,'RESTRICT.\d',i)
    deleteToolType(self.acpName,temppath)
  ENDFOR
  self.oldcount:=count
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC editRestricted(acpName) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook

  self.changed:=FALSE
  self.acpName:=acpName

  NEW saveHook
  installhook( saveHook, {saveRestrictedChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.editCaption1:='Restricted files'
  self.editCaption2:='File'

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , MUI_TRUE)
  set(self.strItem, MUIA_String_Contents,'')

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Restricted Files')
  set( self.winMain, MUIA_Window_ID, "FRST")

  set( self.lvList , MUIA_ShortHelp , getHelpText(RESTRICT_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(RESTRICT_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(RESTRICT_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(RESTRICT_DELETE))
  set(self.strItem, MUIA_ShortHelp , getHelpText(RESTRICT_TEXT))

  set(self.app.grp_arrange,MUIA_Group_Columns,1)
  set(self.strItem,MUIA_ShowMe,MUI_TRUE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,MUI_TRUE)

  self.addNotifications()

  loop:=TRUE
  count:=0
  WHILE (loop)
    StringF(temppath,'RESTRICT.\d',count+1)
    readToolType(acpName,temppath,tempstr)
    IF StrLen(tempstr)>0
      domethod( self.lList , [ MUIM_List_InsertSingle , tempstr , MUIV_List_Insert_Bottom ] )
      count++   
    ELSE
      loop:=FALSE
    ENDIF
  ENDWHILE
  self.oldcount:=count
  
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  self.showModal()
  self.removeNotifications()
  END saveHook
  END closeHook
ENDPROC

PROC saveBackupChanges() OF frmEditList
  DEF i,count,entry
  DEF  temppath[255]:STRING

  MOVE.L (A1),self
  GetA4()

  self.sleep()
  get(self.lList,MUIA_List_Entries,{count})  
  FOR i:=1 TO count
    domethod(self.lList,[MUIM_List_GetEntry,i-1,{entry}])
    StringF(temppath,'BACKUP.\d',i)
    writeToolType(self.acpName,temppath,entry)
  ENDFOR
  FOR i:=count+1 TO self.oldcount
    StringF(temppath,'BACKUP.\d',i)
    deleteToolType(self.acpName,temppath)
  ENDFOR
  self.oldcount:=count
  saveCachedChanges()

  set( self.btnItemsSave,MUIA_Disabled,MUI_TRUE)
  self.changed:=FALSE
  self.wake()
ENDPROC

PROC editBackup(acpName) OF frmEditList
  DEF count,loop,i,entry,temppath[255]:STRING,tempstr[255]:STRING
  DEF saveHook:PTR TO hook
  DEF closeHook:PTR TO hook

  self.changed:=FALSE
  self.acpName:=acpName

  NEW saveHook
  installhook( saveHook, {saveBackupChanges})    
  self.saveHook:=saveHook
  NEW closeHook
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  self.editCaption1:='Backup files'
  self.editCaption2:='File'

  set(self.app.grp_arrange,MUIA_Group_Columns,1)
  set(self.strItem,MUIA_ShowMe,MUI_TRUE)
  set(self.app.grp_computers_add,MUIA_Group_Horiz,MUI_TRUE)

  set( self.btnItemRemove , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemEdit , MUIA_Disabled , MUI_TRUE)
  set( self.btnItemAdd , MUIA_Disabled , MUI_TRUE)
  set(self.strItem, MUIA_String_Contents,'')

  set( self.lvList , MUIA_ShortHelp , getHelpText(BACKUP_LVIEW))
  set( self.btnItemAdd , MUIA_ShortHelp , getHelpText(BACKUP_ADD))
  set( self.btnItemEdit , MUIA_ShortHelp , getHelpText(BACKUP_EDIT))
  set( self.btnItemRemove , MUIA_ShortHelp , getHelpText(BACKUP_DELETE))
  set(self.strItem, MUIA_ShortHelp , getHelpText(BACKUP_TEXT))

  domethod( self.lList , [ MUIM_List_Clear] )

  set( self.winMain, MUIA_Window_Title,'Edit Backup Files')
  set( self.winMain, MUIA_Window_ID, "FBAK")

  self.addNotifications()

  loop:=TRUE
  count:=0
  WHILE (loop)
    StringF(temppath,'BACKUP.\d',count+1)
    readToolType(acpName,temppath,tempstr)
    IF StrLen(tempstr)>0
      domethod( self.lList , [ MUIM_List_InsertSingle , tempstr , MUIV_List_Insert_Bottom ] )
      count++   
    ELSE
      loop:=FALSE
    ENDIF
  ENDWHILE
  self.oldcount:=count
  
  set( self.btnItemsSave , MUIA_Disabled , MUI_TRUE)

  self.showModal()
  self.removeNotifications()
  END saveHook
  END closeHook
ENDPROC
/*
//hide edit
set(self.app.grp_arrange,MUIA_Group_Columns,2)
set(self.strItem,MUIA_ShowMe,FALSE)
set(self.app.grp_computers_add,MUIA_Group_Horiz,FALSE)

//show edit
set(self.app.grp_arrange,MUIA_Group_Columns,1)
set(self.strItem,MUIA_ShowMe,MUI_TRUE)
set(self.app.grp_computers_add,MUIA_Group_Horiz,MUI_TRUE)
*/