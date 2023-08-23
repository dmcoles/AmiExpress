OPT OSVERSION = 37,STACK=60000,LARGE
OPT PREPROCESS

/*
  window.pubscreen can be WINDOW.PUBSCREEN or WINDOW.PUBSCREEN=

  help screen
  add warning about incorrect rexxdoor if nodes>10
  add warning to restart on exit if ACP running
  restart bbs

  user editor
  callers log viewer
  msgbase viewer
  screens viewer
*/

->/////////////////////////////////////////////////////////////////////////////
->//////////////////////////////////////////////////////////// MODULE ... /////
->/////////////////////////////////////////////////////////////////////////////
MODULE 'locale'
MODULE 'muimaster' , 'libraries/mui'
MODULE 'utility/tagitem'
MODULE 'tools/boopsi'
MODULE 'icon'

MODULE '*frmMain','*axedit','*helpText'

PROC main() HANDLE
  DEF frmMain: PTR TO frmMain
  DEF app: PTR TO app_obj
  IF ( muimasterbase := OpenLibrary( 'muimaster.library' , MUIMASTER_VMIN ) ) = NIL THEN Throw( "LIB" , "muim" )
  IF (iconbase := OpenLibrary( 'icon.library' , 0 )) = NIL THEN Throw( "LIB" , "icon" )

  NEW app.create(NIL)

  helpTextInitialise()

  NEW frmMain.create(app)
  frmMain.domain()

EXCEPT DO

  SELECT exception

    CASE "HLP"
      SELECT exceptioninfo
        CASE "LIST"
          error_simple( 'error: Increase help text list size' )
      ENDSELECT

    CASE "LIB"

      SELECT exceptioninfo

        CASE "muim"

          error_simple( 'Can''t open muimaster.library !' )

        CASE "icon"

          error_simple( 'Can''t open icon.library !' )

      ENDSELECT

    CASE "MEM"

      error_simple( 'Not enough memory !' )

    CASE "MUI"

      SELECT exceptioninfo

        CASE MUIE_OutOfMemory

          error_simple( 'Not enough memory !' )

        CASE MUIE_OutOfGfxMemory

          error_simple( 'Not enough chip memory !' )

        CASE MUIE_MissingLibrary

          error_simple( 'Can''t open a needed library !' )

        CASE MUIE_NoARexx

          error_simple( 'Can''t create arexx port !' )

        DEFAULT

          error_simple( 'Internal problem !' )

      ENDSELECT

  ENDSELECT

  app.dispose()
  END app
  END frmMain
  helpTextDeinitialise()

	IF iconbase		THEN CloseLibrary( iconbase )
  IF muimasterbase  THEN CloseLibrary( muimasterbase )
ENDPROC


->/////////////////////////////////////////////////////////////////////////////
->/////////////////// Prints an error message with an intuition requester /////
->/////////////////////////////////////////////////////////////////////////////
PROC error_simple( message : PTR TO CHAR ) IS EasyRequestArgs(  NIL , [ 20 , 0 ,
                  'error !' ,
                  message ,
                  '_OK' ] , NIL , NIL )
