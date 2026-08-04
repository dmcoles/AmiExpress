OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','dos/dos','libraries/asl','dos/var'
MODULE 'utility/tagitem' , 'utility/hooks', 'tools/installhook','libraries/gadtools'

MODULE '*frmBase','*axuseredit','*frmEditUser','*axuserobjects','*/stringlist'


EXPORT OBJECT frmMain OF frmBase
  bbsPath[200]:ARRAY OF CHAR
  aboutwin:LONG
  currentSlot:LONG
  btnExitClickHook: hook
  btnAboutClickHook: hook
  btnAddClickHook: hook
  btnEditClickHook: hook
  btnApplyFilterClickHook: hook
  mnuAboutMuiClickHook: hook
  userNames:PTR TO stringlist
  userIds:PTR TO stringlist
  userLocations:PTR TO stringlist
ENDOBJECT

DEF self2:PTR TO frmMain

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
  Mui_RequestA(0,self.winMain,0,'About Ami-Express User Editor' ,'*Ok','This tool can assist you in editing your Ami-Express users\n\n(c)2026 Darren Coles.',0)
ENDPROC

PROC addbuttonPressed() OF frmMain
  DEF frmEditUser:PTR TO frmEditUser,res
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW frmEditUser.create(self.app)
  res:=frmEditUser.addUser(self.bbsPath)
  END frmEditUser
  IF res THEN self.loadUsers()

  self.wake()
  
ENDPROC

PROC editbuttonPressed() OF frmMain
  DEF frmEditUser:PTR TO frmEditUser,res
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW frmEditUser.create(self.app)
  res:=frmEditUser.editUser(self.bbsPath,self.currentSlot)
  END frmEditUser
  IF res THEN self.loadUsers()
  self.wake()
  
ENDPROC


PROC filterbuttonPressed() OF frmMain
  DEF filter
  MOVE.L (A1),self
  GetA4()
  
  get(self.app.strFilter, MUIA_String_Contents,{filter})
  self.buildUserDisplayList(filter)
ENDPROC


PROC formShow() OF frmMain
  MOVE.L (A1),self
  GetA4() 
ENDPROC

PROC buildUserDisplayList(filter:PTR TO CHAR) OF frmMain
  DEF i
  
  set(self.app.lvUsers, MUIA_List_Quiet, MUI_TRUE)
  domethod( self.app.lvUsers , [ MUIM_List_Clear] )
  IF StrLen(filter)=0
    FOR i:=0 TO self.userIds.count()-1
      domethod( self.app.lvUsers , [ MUIM_List_InsertSingle , self.userIds.item(i) , MUIV_List_Insert_Bottom ] )
    ENDFOR  
  ELSE
    FOR i:=0 TO self.userIds.count()-1
      IF InStri(self.userNames.item(i),filter)>=0 THEN domethod( self.app.lvUsers , [ MUIM_List_InsertSingle , self.userIds.item(i) , MUIV_List_Insert_Bottom ] )
    ENDFOR
  ENDIF
  set(self.app.lvUsers, MUIA_List_Quiet, FALSE)
ENDPROC

PROC create(app:PTR TO app_obj) OF frmMain
  SUPER self.create(app)
  self.winMain:=app.winUserList
  self2:=self

  /*set (app.mnlabel1Donotremovefolder1, MUIA_Menuitem_Exclude, 6)
  set (app.mnlabel1Removefolder1, MUIA_Menuitem_Exclude, 5)
  set (app.mnlabel1Ask1, MUIA_Menuitem_Exclude, 3)
  
  
  set (app.mnlabel1Donotremovefolder2, MUIA_Menuitem_Exclude, 6)
  set (app.mnlabel1Removefolder2, MUIA_Menuitem_Exclude, 5)
  set (app.mnlabel1Ask2, MUIA_Menuitem_Exclude, 3)*/
ENDPROC

PROC canClose() OF frmMain
  MOVE.L (A1),self
  GetA4() 
ENDPROC TRUE

PROC displayData() OF frmMain
  DEF a:PTR TO LONG,e,index
  
  GetA4()
  MOVE.L self2,self

  MOVE.L A1,e
  MOVE.L A2,a
  
  IF e=0
    a[]++:='Slot'
    a[]++:='Username'
    a[]++:='Location'
  ELSE
    index:=Val(e)-1
    IF index<self.userIds.count()
      a[]++:=self.userIds.item(index)
    ELSE
      a[]++:=''
    ENDIF
    IF index<self.userNames.count()
      a[]++:=self.userNames.item(index)
    ELSE
      a[]++:=''
    ENDIF
    IF index<self.userLocations.count()
      a[]++:=self.userLocations.item(index)
    ELSE
      a[]++:=''
    ENDIF
    
  ENDIF
  
ENDPROC

PROC listChange() OF frmMain
  DEF entry,entryText
  MOVE.L (A1),self
  GetA4()

  get(self.app.lvUsers,MUIA_List_Active,{entry})
  set( self.app.btnEdit , MUIA_Disabled , IF entry=MUIV_List_Active_Off THEN MUI_TRUE ELSE FALSE)
  set( self.app.mnlabel1EditUser , MUIA_Menuitem_Enabled , IF entry=MUIV_List_Active_Off THEN FALSE ELSE MUI_TRUE)

  IF entry=MUIV_List_Active_Off
    self.currentSlot:=0
  ELSE
    domethod(self.app.lvUsers,[MUIM_List_GetEntry,entry, {entryText}])
    self.currentSlot:=Val(entryText)
  ENDIF
ENDPROC

PROC loadUsers() OF frmMain
  DEF fh,f
  DEF userData:PTR TO user
  DEF tempStr[200]:STRING
  DEF totalUserCount=0
  DEF fname[200]:STRING
  
  NEW userData
  self.userNames.clear()
  self.userIds.clear()
  self.userLocations.clear()
  
  StringF(fname,'\suser.data',self.bbsPath)
  fh:=Open(fname,MODE_OLDFILE)
  IF fh
    REPEAT
      f:=Fread(fh,userData,SIZEOF user,1)
      IF f=1
        self.userNames.add(userData.name)
        self.userLocations.add(userData.location)
        StringF(tempStr,'\d',totalUserCount+1)
        self.userIds.add(tempStr)
        totalUserCount++
      ENDIF
    UNTIL f=0
    Close(fh)
  ENDIF
  self.buildUserDisplayList('')  

  StringF(tempStr,'Total Users: \d',totalUserCount)
  set( self.app.txtUserCount, MUIA_Text_Contents,tempStr)
  
  END userData
ENDPROC

PROC doMain() OF frmMain
  DEF closeHook:PTR TO hook
  DEF showHook:PTR TO hook
  DEF displayHook:PTR TO hook
  DEF listChangeHook:PTR TO hook
  DEF aboutClickHook:PTR TO hook

  NEW closeHook
  NEW showHook
  NEW displayHook
  NEW listChangeHook
  NEW aboutClickHook

  AstrCopy(self.bbsPath,'BBS:')

  self.userNames:=NEW stringlist.stringlist(1000)
  self.userIds:=NEW stringlist.stringlist(1000)
  self.userLocations:=NEW stringlist.stringlist(1000)
 
  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  set( self.winMain, MUIA_Window_ID, "AXUM")

  installhook( showHook, {formShow})
  self.showHook:=showHook

  installhook( displayHook, {displayData})

  self.aboutwin:=0
  
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
    MUIM_CallHook , aboutClickHook, self ] )

	domethod( self.app.mnlabel1AddUser     , [
		MUIM_Notify , MUIA_Menuitem_Trigger, MUIV_EveryTime,
		self.app.mnlabel1AddUser    ,
		3,
    MUIM_CallHook , self.btnAddClickHook, self ] )

	domethod( self.app.mnlabel1EditUser     , [
		MUIM_Notify , MUIA_Menuitem_Trigger, MUIV_EveryTime,
		self.app.mnlabel1EditUser    ,
		3,
    MUIM_CallHook , self.btnEditClickHook, self ] )

  domethod( self.app.lvUsers , [
    MUIM_Notify ,  MUIA_List_Active , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , listChangeHook, self] )
  installhook( listChangeHook, {listChange})

  domethod( self.app.lvUsers , [
    MUIM_Notify ,  MUIA_Listview_DoubleClick , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , self.btnEditClickHook, self] )

  self.setupButtonClick(self.app.btnExit,self.btnExitClickHook,{exitbuttonPressed})
  self.setupButtonClick(self.app.btnAdd,self.btnAddClickHook,{addbuttonPressed})
  self.setupButtonClick(self.app.btnEdit,self.btnEditClickHook,{editbuttonPressed})
  self.setupButtonClick(self.app.btnApplyFilter,self.btnApplyFilterClickHook,{filterbuttonPressed})

  installhook( aboutClickHook, {aboutbuttonPressed})
  installhook( self.mnuAboutMuiClickHook, {aboutMui})

  set(self.app.mnlabel1barlabel,MUIA_Menuitem_Title,NM_BARLABEL)
  
  set(self.app.lvUsers,MUIA_List_Title,MUI_TRUE)
  set(self.app.lvUsers,MUIA_List_DisplayHook,displayHook)
  set(self.app.btnEdit,MUIA_Disabled,MUI_TRUE)
  set(self.app.mnlabel1EditUser,MUIA_Menuitem_Enabled,FALSE)
 
  self.loadUsers()
  
  self.showModal()

  END self.userNames
  END self.userIds
  END self.userLocations

  END closeHook
  END showHook
  END displayHook
  END listChangeHook
  END aboutClickHook
ENDPROC
