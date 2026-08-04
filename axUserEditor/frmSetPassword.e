OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','dos/dos','libraries/asl','dos/var'
MODULE 'utility/tagitem' , 'utility/hooks', 'tools/installhook','libraries/gadtools'

MODULE '*frmBase','*axuseredit'


EXPORT OBJECT frmSetPassword OF frmBase
  btnOkClickHook: hook
  btnCancelClickHook: hook
ENDOBJECT


PROC create(app:PTR TO app_obj) OF frmSetPassword
  SUPER self.create(app)
  self.winMain:=app.winSetPassword
ENDPROC

PROC canClose() OF frmSetPassword
  MOVE.L (A1),self
  GetA4() 
ENDPROC TRUE

PROC okbuttonPressed() OF frmSetPassword
  DEF entry1,entry2
  MOVE.L (A1),self
  GetA4()
  
  //check both password boxes match
  get(self.app.strPassword1, MUIA_Text_Contents,{entry1})
  get(self.app.strPassword2, MUIA_Text_Contents,{entry2})

  IF StrLen(entry1)=0
    set ( self.winMain,MUIA_Window_ActiveObject,self.app.strPassword1)
    Mui_RequestA(0,self.winMain,0,'Error','*OK','Passwords cannot be blank.',0)   
    RETURN
  ENDIF
  
  IF StrCmp(entry1,entry2)
    domethod(self.app.app,[MUIM_Application_ReturnID,ID_SAVE])
  ELSE
    set ( self.winMain,MUIA_Window_ActiveObject,self.app.strPassword1)
    Mui_RequestA(0,self.winMain,0,'Error','*OK','Passwords entered do not match.',0)
  ENDIF
ENDPROC

PROC cancelbuttonPressed() OF frmSetPassword
  MOVE.L (A1),self
  GetA4()
  domethod(self.app.app,[MUIM_Application_ReturnID,MUIA_Window_CloseRequest])
ENDPROC


PROC setPassword(newPassword:PTR TO CHAR) OF frmSetPassword
  DEF tempval,res=0

  set( self.winMain, MUIA_Window_ID, "AXPW")
  set ( self.winMain,MUIA_Window_ActiveObject,self.app.strPassword1)

  self.setupButtonClick(self.app.btnPwdOk,self.btnOkClickHook,{okbuttonPressed})
  self.setupButtonClick(self.app.btnPwdCancel,self.btnCancelClickHook,{cancelbuttonPressed})

  set(self.app.strPassword1, MUIA_Text_Contents,'')
  set(self.app.strPassword2, MUIA_Text_Contents,'')

  res:=self.showModal()
  IF res
    get(self.app.strPassword1, MUIA_Text_Contents,{tempval})
    StrCopy(newPassword,tempval)
  ENDIF
  
  domethod(self.app.btnPwdOk,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.btnPwdCancel,[MUIM_KillNotify,MUIA_Pressed])
  
ENDPROC res
