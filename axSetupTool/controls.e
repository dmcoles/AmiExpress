  OPT MODULE

MODULE 'muimaster','libraries/mui','tools/boopsi','intuition/classusr','utility/hooks','tools/installhook','libraries/asl'
MODULE '*helpText'

EXPORT ENUM TYPE_STRING,TYPE_INT,TYPE_CYCLE,TYPE_CHECKBOX,TYPE_DIRSELECT,TYPE_FILESELECT,TYPE_MODESELECT
EXPORT OBJECT control
  hook:PTR TO LONG
  hook2:PTR TO LONG
  muiLabel: PTR TO LONG
  group: PTR TO LONG
  muiControl: PTR TO LONG
  type:INT
ENDOBJECT

PROC makeLabel(caption,helpText) OF control
  DEF lbl
  lbl := TextObject ,
    MUIA_Text_PreParse , '\el' ,
    MUIA_Text_Contents , caption ,
    MUIA_ShortHelp,helpText,
    MUIA_Weight,0,
    MUIA_InnerLeft , 0 ,
    MUIA_InnerRight , 0 ,
  End
ENDPROC lbl

EXPORT PROC createString(labelCaption,helpTextId,app,changeHook, window) OF control
  DEF helpText
  
  helpText:=getHelpText(helpTextId)
  self.hook:=0
  self.hook2:=0
  self.muiLabel:=self.makeLabel(labelCaption,helpText)
  self.group:=NIL
  self.muiControl:=StringObject,
    MUIA_Frame,MUIV_Frame_String,
    MUIA_ShortHelp,helpText,
    MUIA_Weight,100,
  End

  domethod( self.muiControl, [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    app,
    3 ,
        MUIM_CallHook , changeHook, window ])

  self.type:=TYPE_STRING
ENDPROC

EXPORT PROC createStringInt(labelCaption,helpTextId,app,changeHook, window) OF control
  DEF helpText
  
  helpText:=getHelpText(helpTextId)
  self.hook:=0
  self.hook2:=0
  self.muiLabel:=self.makeLabel(labelCaption,helpText)
  self.group:=NIL
  self.muiControl:=StringObject,
    MUIA_Frame,MUIV_Frame_String,
    MUIA_ShortHelp,helpText,
    MUIA_Weight,100,
    MUIA_String_Accept , '0123456879',
  End

  domethod( self.muiControl, [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    app,
    3 ,
        MUIM_CallHook , changeHook, window ])
  self.type:=TYPE_INT
ENDPROC

EXPORT PROC createCycle(labelCaption,helpTextId,values,app,changeHook, window) OF control
  DEF helpText
  
  helpText:=getHelpText(helpTextId)
  self.hook:=0
  self.hook2:=0
  self.muiLabel:=self.makeLabel(labelCaption,helpText)
  self.group:=NIL
  self.muiControl:=CycleObject,
    MUIA_Frame,MUIV_Frame_Button,
    MUIA_ShortHelp,helpText,
    MUIA_Weight,100,
    MUIA_Cycle_Entries,values,
  End

  domethod( self.muiControl, [
    MUIM_Notify , MUIA_Cycle_Active , MUIV_EveryTime ,
    app,
    3 ,
        MUIM_CallHook , changeHook, window ])
  
  self.type:=TYPE_CYCLE
ENDPROC

EXPORT PROC createCheckBox(labelCaption,helpTextId,app,changeHook, window) OF control
  DEF helpText
  
  helpText:=getHelpText(helpTextId)
  self.hook:=0
  self.hook2:=0
  self.muiLabel:=self.makeLabel(labelCaption,helpText)
  self.muiControl:=CheckMark( FALSE )
	self.group:=GroupObject ,
    MUIA_ShortHelp,helpText,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , HVSpace ,
		Child , self.muiControl ,
		Child , HVSpace ,
	End

  domethod( self.muiControl, [
    MUIM_Notify , MUIA_Selected   , MUIV_EveryTime ,
    app,
    3 ,
        MUIM_CallHook , changeHook, window ])
  self.type:=TYPE_CHECKBOX
ENDPROC

PROC setaslflags() OF control
  DEF tags:PTR TO LONG
  MOVE.L A1,tags
  
  WHILE tags[]<>0 DO tags++
  tags[]:=ASLFR_DRAWERSONLY
  tags++
  tags[]:=-1
  tags++
  tags[]:=0
  
ENDPROC TRUE

EXPORT PROC createDirSelect(labelCaption,helpTextId,app,changeHook, window) OF control
  DEF hook:PTR TO hook
  DEF helpText
  
  helpText:=getHelpText(helpTextId)
  self.muiLabel:=self.makeLabel(labelCaption,helpText)
  self.group:=NIL
  NEW hook
  self.hook:=hook
  installhook( hook, {setaslflags})
  self.hook2:=0

  self.muiControl:=PopaslObject,
    MUIA_ShortHelp,helpText,
    MUIA_Popasl_Type,0,
    MUIA_Weight,100,
    MUIA_Popasl_StartHook,hook,
    MUIA_Popstring_String,StringMUI( '' , 80 ),
    MUIA_Popstring_Button,PopButton( MUII_PopDrawer ),
  End

  domethod( self.muiControl, [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    app,
    3 ,
        MUIM_CallHook , changeHook, window ])

  self.type:=TYPE_DIRSELECT
ENDPROC

EXPORT PROC createFileSelect(labelCaption,helpTextId,app,changeHook, window) OF control
  DEF helpText
  
  helpText:=getHelpText(helpTextId)
  self.hook:=0
  self.hook2:=0  
  self.muiLabel:=self.makeLabel(labelCaption,helpText)
  self.group:=NIL
  self.muiControl:=PopaslObject,
    MUIA_ShortHelp,helpText,
    MUIA_Popasl_Type,0,
    MUIA_Weight,100,
    MUIA_Popstring_String,StringMUI( '' , 80 ),
    MUIA_Popstring_Button,PopButton( MUII_PopFile ),
  End

  domethod( self.muiControl, [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    app,
    3 ,
        MUIM_CallHook , changeHook, window ])

  self.type:=TYPE_FILESELECT
ENDPROC

PROC setaslmodeflags() OF control
  DEF tags:PTR TO LONG
  DEF control:PTR TO LONG
  DEF str,val
  MOVE.L A1,tags
  MOVE.L A2,control

  get(control,MUIA_String_Contents,{str})
  
  IF StrLen(str)=0
    val:=$8000
  ELSE
    val:=Val(str)
  ENDIF
  
  WHILE tags[]<>0 DO tags++
  tags[]:=ASLSM_INITIALDISPLAYID
  tags++
  tags[]:=val
  tags++
  tags[]:=0
  
ENDPROC TRUE

PROC getmodeid() OF control
  DEF asl:PTR TO screenmoderequester
  DEF control
  DEF str[20]:STRING
  MOVE.L A1,asl
  MOVE.L A2,control
  StringF(str,'\d',asl.displayid)
  set(control,MUIA_String_Contents,str)
ENDPROC 

EXPORT PROC createModeSelect(labelCaption,helpTextId,app,changeHook, window) OF control
  DEF hook:PTR TO hook
  DEF helpText
  
  helpText:=getHelpText(helpTextId)
  NEW hook
  self.hook:=hook
  NEW hook
  self.hook2:=hook
  installhook( self.hook, {setaslmodeflags})
  installhook( self.hook2, {getmodeid})
  self.muiLabel:=self.makeLabel(labelCaption,helpText)
  self.group:=NIL
  self.muiControl:=PopaslObject,
    MUIA_ShortHelp,helpText,
    MUIA_Popasl_Type,2,
    MUIA_Popasl_StartHook,self.hook,
    MUIA_Popasl_StopHook,self.hook2,
    MUIA_Weight,100,
    MUIA_Popstring_String,StringMUI( '' , 80 ),
    MUIA_Popstring_Button,PopButton( MUII_PopFile ),
  End

  domethod( self.muiControl, [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    app,
    3 ,
        MUIM_CallHook , changeHook, window])

  self.type:=TYPE_MODESELECT
ENDPROC

EXPORT PROC addToGroup(group) OF control
  domethod(group,[OM_ADDMEMBER,self.muiLabel])
  IF self.group
    domethod(group,[OM_ADDMEMBER,self.group])
  ELSE
    domethod(group,[OM_ADDMEMBER,self.muiControl])
  ENDIF
ENDPROC

EXPORT PROC removeFromGroup(group) OF control
  domethod(group,[OM_REMMEMBER,self.muiLabel])
  IF self.group
    domethod(group,[OM_REMMEMBER,self.group])
  ELSE
    domethod(group,[OM_REMMEMBER,self.muiControl])
  ENDIF
ENDPROC

EXPORT PROC setValueStr(newValue) OF control
  SELECT self.type
    CASE TYPE_STRING
      domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Contents,newValue])
    CASE TYPE_DIRSELECT
      domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Contents,newValue])
    CASE TYPE_FILESELECT
      domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Contents,newValue])
    CASE TYPE_MODESELECT
      domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Contents,newValue])
    CASE TYPE_INT
      domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Contents,newValue])
    //CASE TYPE_CHECKBOX
      //do nothing
    //CASE TYPE_CYCLE
      //do nothing
  ENDSELECT    
ENDPROC

EXPORT PROC setValue(newValue) OF control
  SELECT self.type
    CASE TYPE_STRING
      domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Contents,newValue])
    CASE TYPE_DIRSELECT
      domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Contents,newValue])
    CASE TYPE_FILESELECT
      domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Contents,newValue])
    CASE TYPE_MODESELECT
      domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Contents,newValue])
    CASE TYPE_INT
      IF newValue=-1
        domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Contents,''])
      ELSE
        domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_String_Integer,newValue])
      ENDIF
    CASE TYPE_CHECKBOX
      domethod(self.muiControl,[MUIM_NoNotifySet,MUIA_Selected,IF newValue THEN MUI_TRUE ELSE FALSE])
    //CASE TYPE_CYCLE
    //do nothing
  ENDSELECT    
ENDPROC

EXPORT PROC getValue() OF control
  DEF currVal,index,items:PTR TO LONG
  SELECT self.type
    CASE TYPE_STRING
      get(self.muiControl, MUIA_String_Contents,{currVal})
    CASE TYPE_DIRSELECT
      get(self.muiControl, MUIA_String_Contents,{currVal})
    CASE TYPE_FILESELECT
      get(self.muiControl, MUIA_String_Contents,{currVal})
    CASE TYPE_INT
      get(self.muiControl, MUIA_String_Contents,{currVal})
    CASE TYPE_CHECKBOX
      get(self.muiControl,MUIA_Selected,{currVal})
    CASE TYPE_CYCLE
      get(self.muiControl,MUIA_Cycle_Active,{index})
      IF index>=0
        get(self.muiControl,MUIA_Cycle_Entries,{items})
        currVal:=items[index]
      ENDIF
    CASE TYPE_MODESELECT
      get(self.muiControl, MUIA_String_Contents,{currVal})
  ENDSELECT
ENDPROC currVal

EXPORT PROC setValueIndex(newIndex) OF control
  IF self.type=TYPE_CYCLE
    set(self.muiControl,MUIA_Cycle_Active,newIndex)
  ENDIF
ENDPROC

EXPORT PROC getValueIndex() OF control
  DEF index=-1
  IF self.type=TYPE_CYCLE
    get(self.muiControl,MUIA_Cycle_Active,{index})
  ENDIF
ENDPROC index

EXPORT PROC disable(newVal) OF control
  set( self.muiControl, MUIA_Disabled , IF newVal THEN MUI_TRUE ELSE FALSE)
ENDPROC

EXPORT PROC end() OF control
  Mui_DisposeObject(self.muiLabel)
  IF self.group
    Mui_DisposeObject(self.group)
  ELSE
    Mui_DisposeObject(self.muiControl)
  ENDIF
  IF self.hook THEN END self.hook
  IF self.hook2 THEN END self.hook2
ENDPROC

