OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','dos/dos','libraries/asl'
MODULE 'utility/tagitem' , 'utility/hooks', 'tools/installhook'
MODULE '*axedit','*frmBase'

EXPORT OBJECT frmAddItem OF frmBase
  lblItemDetail1: LONG
  lblItemDetail2: LONG
  txtItemDetail1: LONG
  txtItemDetail2: LONG
  grpItemDetail2: LONG  
  btnSave: LONG
  btnCancel: LONG
  changeHook: hook 
ENDOBJECT

PROC changed() OF frmAddItem
  MOVE.L (A1),self
  GetA4()

  set( self.btnSave , MUIA_Disabled , FALSE)
ENDPROC

PROC addNotifications() OF frmAddItem
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

  domethod( self.txtItemDetail1, [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.changeHook, self ])

  domethod( self.txtItemDetail2, [
    MUIM_Notify , MUIA_String_Contents , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.changeHook, self ])

  installhook( self.changeHook, {changed})

ENDPROC

PROC removeNotifications() OF frmAddItem
  domethod(self.btnCancel,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnSave,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.txtItemDetail1,[MUIM_KillNotify,MUIA_String_Contents])
  domethod(self.txtItemDetail2,[MUIM_KillNotify,MUIA_String_Contents])
ENDPROC

PROC create(app:PTR TO app_obj) OF frmAddItem
  DEF group
  SUPER self.create(app)
  self.winMain:=app.wi_add_item

  self.btnSave:=app.bt_new_item_save
  self.btnCancel:=app.bt_new_item_cancel
  self.lblItemDetail1:=app.la_item_detail1
  self.lblItemDetail2:=app.la_item_detail2
  self.txtItemDetail1:=app.stR_item_detail1e 
  self.txtItemDetail2:=app.stR_item_detail2
  self.grpItemDetail2:=app.gr_item_detail2
ENDPROC

PROC addScreen(title) OF frmAddItem
  DEF res,v1=0,v2=0
  set( self.winMain, MUIA_Window_Title,'Add Screen')
  set( self.lblItemDetail1, MUIA_Text_Contents,'Screen Title')
  set( self.lblItemDetail2, MUIA_Text_Contents,'Extension')

  set( self.btnSave,MUIA_Disabled,FALSE)

  set( self.txtItemDetail1, MUIA_String_Contents,title)
  set( self.txtItemDetail2, MUIA_String_Contents,'')

  self.addNotifications()
  
  res:=self.showModal()
  IF res
    get( self.txtItemDetail1, MUIA_String_Contents,{v1})
    get( self.txtItemDetail2, MUIA_String_Contents,{v2})
  ENDIF
  self.removeNotifications()

ENDPROC res,v1,v2

PROC editScreen(title,extension) OF frmAddItem
  DEF res,v1=0,v2=0
  set( self.winMain, MUIA_Window_Title,'Edit Screen')
  set( self.lblItemDetail1, MUIA_Text_Contents,'Screen Title')
  set( self.lblItemDetail2, MUIA_Text_Contents,'Extension')

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  set( self.txtItemDetail1, MUIA_String_Contents,title)
  set( self.txtItemDetail2, MUIA_String_Contents,extension)

  self.addNotifications()
  
  res:=self.showModal()
  IF res
    get( self.txtItemDetail1, MUIA_String_Contents,{v1})
    get( self.txtItemDetail2, MUIA_String_Contents,{v2})
  ENDIF
  self.removeNotifications()

ENDPROC res,v1,v2

PROC editConnectionString(connectString,baudString) OF frmAddItem
  DEF res,v1=0,v2=0
  set( self.winMain, MUIA_Window_Title,'Edit Connection String')
  set( self.lblItemDetail1, MUIA_Text_Contents,'Connection String')
  set( self.lblItemDetail2, MUIA_Text_Contents,'Baud Rate')

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)

  set( self.txtItemDetail1, MUIA_String_Contents,connectString)
  set( self.txtItemDetail2, MUIA_String_Contents,baudString)

  self.addNotifications()
  
  res:=self.showModal()
  IF res
    get( self.txtItemDetail1, MUIA_String_Contents,{v1})
    get( self.txtItemDetail2, MUIA_String_Contents,{v2})
  ENDIF
  self.removeNotifications()

ENDPROC res,v1,v2

PROC editSingleItem(title,itemDesc,value) OF frmAddItem
  DEF res,v1=0,v2=0
  set( self.winMain, MUIA_Window_Title,title)
  
  set( self.grpItemDetail2, MUIA_ShowMe , FALSE)
  
  set( self.lblItemDetail1, MUIA_Text_Contents,itemDesc)
  set( self.txtItemDetail1, MUIA_String_Contents,value)

  set( self.btnSave,MUIA_Disabled,MUI_TRUE)


  self.addNotifications()
  
  res:=self.showModal()
  IF res
    get( self.txtItemDetail1, MUIA_String_Contents,{v1})
  ENDIF
  self.removeNotifications()
  set( self.grpItemDetail2, MUIA_ShowMe , MUI_TRUE)

ENDPROC res,v1
