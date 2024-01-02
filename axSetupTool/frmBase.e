OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','tools/installhook','amigalib/boopsi'
MODULE 'utility/tagitem' , 'utility/hooks','*axedit'

EXPORT CONST ID_SAVE=1

EXPORT OBJECT frmBase
  app                       : PTR TO app_obj
	winMain                   :	PTR TO LONG
  showHook                  : PTR TO hook
  saveHook                  : PTR TO hook
  canSaveHook               : PTR TO hook
  closeHook                 : PTR TO hook
ENDOBJECT

PROC create(app:PTR TO app_obj) OF frmBase
  self.app:=app 
  self.saveHook:=NIL
  self.showHook:=NIL
  self.canSaveHook:=NIL
  self.closeHook:=NIL
ENDPROC

PROC show() OF frmBase
  set( self.winMain ,MUIA_Window_Open , MUI_TRUE )
ENDPROC

PROC hide() OF frmBase
  set( self.winMain ,MUIA_Window_Open , FALSE )
ENDPROC

PROC sleep() OF frmBase
  set( self.winMain ,MUIA_Window_Sleep , MUI_TRUE )
ENDPROC

PROC wake() OF frmBase
  set( self.winMain ,MUIA_Window_Sleep , FALSE )
ENDPROC

PROC setupButtonClick(button, hook, code) OF frmBase
	domethod( button , [
		MUIM_Notify , MUIA_Pressed , FALSE ,
		self.app.app,
		3,
    MUIM_CallHook , hook, self ] )
  installhook( hook , code)
ENDPROC

PROC showModal() OF frmBase
  DEF running = TRUE , result_domethod , signal,result = FALSE

  self.show()

	domethod( self.winMain , [
		MUIM_Notify , MUIA_Window_CloseRequest , MUI_TRUE ,
		self.app.app,
		2 ,
		MUIM_Application_ReturnID , MUIA_Window_CloseRequest ] )

  IF self.showHook THEN callHookA(self.showHook,0,{self})
  
  WHILE running

    result_domethod := domethod( self.app.app, [ MUIM_Application_Input , {signal} ] )
    SELECT result_domethod

      CASE MUIA_Window_CloseRequest
        IF self.closeHook 
          IF callHookA(self.closeHook,0,{self})
            running := FALSE
            result:=FALSE
          ENDIF
        ELSE
          running := FALSE
          result:=FALSE
        ENDIF

      CASE ID_SAVE
        IF self.saveHook 
          callHookA(self.saveHook,0,{self})
        ELSE
          IF self.canSaveHook
            IF callHookA(self.canSaveHook,0,{self})
              running := FALSE
              result:=TRUE
            ENDIF
          ELSE
            running := FALSE
            result:=TRUE
          ENDIF
        ENDIF

      CASE MUIV_Application_ReturnID_Quit
        running := FALSE
        result:=FALSE
    ENDSELECT

		IF ( signal AND running ) THEN Wait( signal )
  ENDWHILE
  domethod(self.winMain,[MUIM_KillNotify,MUIA_Window_CloseRequest])
  
  self.hide()
ENDPROC result
