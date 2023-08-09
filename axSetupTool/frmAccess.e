OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','workbench/workbench','icon','intuition/classusr'
MODULE 'utility/tagitem','utility/hooks','tools/installhook','exec/lists'
MODULE '*axedit','*frmBase','*frmPresetsEdit','*frmEditList'

EXPORT OBJECT frmAccess OF frmBase
  btnAccess      : PTR TO LONG
  btnAreas       : PTR TO LONG
  btnPresets     : PTR TO LONG

  acpConfigName  : PTR TO CHAR
  
  btnAccessClick: hook
  btnAreasClick: hook
  btnPresetsClick: hook
ENDOBJECT

PROC create(app:PTR TO app_obj) OF frmAccess
  DEF group
  SUPER self.create(app)
  self.winMain:=app.wi_security

  self.btnAccess:=app.btnAccess
  self.btnAreas:=app.btnAreas
  self.btnPresets:=app.btnPresets
ENDPROC

PROC goAccess() OF frmAccess
  DEF editList:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW editList.create(self.app)
  editList.editAccessLevel(self.acpConfigName)
  END editList
  self.wake()
ENDPROC

PROC goAreas() OF frmAccess
  DEF editList:PTR TO frmEditList
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW editList.create(self.app)
  editList.editAreas(self.acpConfigName)
  END editList
  self.wake()
ENDPROC

PROC goPresets() OF frmAccess
  DEF presetsEdit:PTR TO frmPresetsEdit
  MOVE.L (A1),self
  GetA4()

  self.sleep()
  NEW presetsEdit.create(self.app)
  presetsEdit.editPresets(self.acpConfigName)
  END presetsEdit
  self.wake()
ENDPROC

PROC addNotifications() OF frmAccess

  self.setupButtonClick(self.btnAccess,self.btnAccessClick,{goAccess})
  self.setupButtonClick(self.btnAreas,self.btnAreasClick,{goAreas})
  self.setupButtonClick(self.btnPresets,self.btnPresetsClick,{goPresets})
ENDPROC

PROC removeNotifications() OF frmAccess
  domethod(self.btnAccess,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnAreas,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.btnPresets,[MUIM_KillNotify,MUIA_Pressed])
ENDPROC

PROC editAccess(acpConfigName:PTR TO CHAR) OF frmAccess
  self.addNotifications()

  self.acpConfigName:=acpConfigName

  self.showModal()
  self.removeNotifications()
ENDPROC
