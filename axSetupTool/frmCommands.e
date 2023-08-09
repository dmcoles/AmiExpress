OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','workbench/workbench','icon','intuition/classusr'
MODULE 'utility/tagitem','utility/hooks','tools/installhook','exec/lists'
MODULE '*axedit','*frmBase','*frmEditList','*tooltypes','*/stringlist'

EXPORT OBJECT frmCommands OF frmBase
  btnBBSCmd      : PTR TO LONG
  btnSysCmd      : PTR TO LONG
  btnList        : PTR TO stdlist

  acpConfigName  : PTR TO CHAR
  
  btnBBSCmdClick: hook
  btnSysCmdClick: hook
  editBtnClick  : hook
ENDOBJECT

PROC create(app:PTR TO app_obj) OF frmCommands
  DEF group
  SUPER self.create(app)
  self.winMain:=app.wi_commands

  self.btnBBSCmd:=app.btnBBSCmd
  self.btnSysCmd:=app.btnSysCmd
ENDPROC

PROC btnClick() OF frmCommands
  DEF editList:PTR TO frmEditList
  DEF btn,text
  MOVE.L (A1),self
  MOVE.L 4(A1),btn
  
  btn:=self.btnList.item(btn)
  get( btn, MUIA_Text_Contents, {text})

  self.sleep()
  NEW editList.create(self.app)
  editList.editCommands(self.acpConfigName,text+5)
  END editList
  self.wake()
  GetA4()
ENDPROC

PROC goBBSCmd() OF frmCommands
  DEF editList:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW editList.create(self.app)
  editList.editCommands(self.acpConfigName,'BBSCmd')
  END editList
  self.wake()
ENDPROC

PROC goSysCmd() OF frmCommands
  DEF editList:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW editList.create(self.app)
  editList.editCommands(self.acpConfigName,'SysCmd')
  END editList
  self.wake()
ENDPROC


PROC addNotifications() OF frmCommands
  DEF i
  self.setupButtonClick(self.btnBBSCmd,self.btnBBSCmdClick,{goBBSCmd})
  self.setupButtonClick(self.btnSysCmd,self.btnSysCmdClick,{goSysCmd})

  FOR i:=0 TO self.btnList.count()-1
    domethod( self.btnList.item(i) , [
      MUIM_Notify , MUIA_Pressed , FALSE ,
      self.app.app,
      4,
      MUIM_CallHook , self.editBtnClick, self, i ] )
  ENDFOR

ENDPROC

PROC removeNotifications() OF frmCommands
  DEF i
  domethod(self.btnBBSCmd,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnSysCmd,[MUIM_KillNotify,MUIA_Pressed])
  FOR i:=0 TO self.btnList.count()-1
    domethod(self.btnList.item(i),[MUIM_KillNotify,MUIA_Pressed])
  ENDFOR

ENDPROC

PROC editCommands(acpConfigName:PTR TO CHAR) OF frmCommands
  DEF nodeCount,confCount,i
  DEF btn:PTR TO LONG
  DEF btnText[255]:STRING
  DEF btnList:stdlist
  DEF bbsPath[255]:STRING
  DEF confConfig[255]:STRING
  
  self.acpConfigName:=acpConfigName
  set(self.app.grpCommands, MUIA_Group_Columns , 3)
  
  nodeCount:=readToolTypeInt(acpConfigName,'NODES')
  
  readToolType(acpConfigName,'BBS_LOCATION',bbsPath)
  StringF(confConfig,'\sCONFCONFIG',bbsPath) 
  confCount:=readToolTypeInt(confConfig,'NCONFS')
  
  NEW btnList.stdlist(20)
  self.btnList:=btnList

  installhook( self.editBtnClick, {btnClick})
  
  FOR i:=0 TO nodeCount-1
    StringF(btnText,'Edit Node\dCmd',i)
    btn:=SimpleButton(btnText)
    btnList.add(btn)
    domethod(self.app.grpCommands,[OM_ADDMEMBER,btn])
    StringF(btnText,'Edit Node\dSysCmd',i)
    btn:=SimpleButton(btnText)
    btnList.add(btn)
    domethod(self.app.grpCommands,[OM_ADDMEMBER,btn])
  ENDFOR

  FOR i:=1 TO confCount-1
    StringF(btnText,'Edit Conf\dCmd',i)
    btn:=SimpleButton(btnText)
    btnList.add(btn)
    domethod(self.app.grpCommands,[OM_ADDMEMBER,btn])
    StringF(btnText,'Edit Conf\dSysCmd',i)
    btn:=SimpleButton(btnText)
    btnList.add(btn)
    domethod(self.app.grpCommands,[OM_ADDMEMBER,btn])
  ENDFOR
  self.addNotifications()

  self.showModal()

  self.removeNotifications()
  FOR i:=0 TO btnList.count()-1
    btn:=btnList.item(i)
    domethod(self.app.grpCommands,[OM_REMMEMBER,btn])
    Mui_DisposeObject(btn)
  ENDFOR
  END btnList
  
ENDPROC
