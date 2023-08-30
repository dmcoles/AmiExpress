OPT OSVERSION = 37,STACK=60000,LARGE,RUNBG
OPT PREPROCESS

/*
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
MODULE 'icon','intuition/classusr'

MODULE '*frmMain','*axedit','*helpText'

PROC main() HANDLE
  DEF frmMain=NIL: PTR TO frmMain
  DEF app=NIL: PTR TO app_obj

  IF ( muimasterbase := OpenLibrary( 'muimaster.library' , MUIMASTER_VMIN ) ) = NIL THEN Throw( "LIB" , "muim" )
  IF (iconbase := OpenLibrary( 'icon.library' , 0 )) = NIL THEN Throw( "LIB" , "icon" )

  NEW app.create(NIL)
  helpTextInitialise()
  
  domethod(app.gr_ax_image,[OM_ADDMEMBER,BodychunkObject,
		MUIA_Frame , MUIV_Frame_ImageButton ,
    MUIA_Bodychunk_Body,
    [$FF,$00,$03,$FE,$03,$F8,$00,$FB,$00,$05,$00,$01,$FF,$07,$FC,
    $00,$FB,$00,$05,$00,$03,$F1,$8F,$C6,$00,$FF,$00,$03,$0E,$00,
    $38,$00,$05,$00,$07,$E0,$DF,$8C,$00,$FF,$00,$03,$1F,$00,$70,
    $00,$05,$00,$0F,$C4,$7F,$18,$00,$FF,$00,$03,$3B,$80,$E0,$00,
    $05,$00,$1F,$8E,$3E,$30,$00,$FF,$00,$03,$71,$C1,$C0,$00,$05,
    $00,$3F,$1F,$1C,$60,$00,$FF,$00,$03,$E0,$E3,$80,$00,$05,$00,
    $7E,$3F,$88,$C0,$00,$05,$00,$01,$C0,$77,$00,$00,$05,$00,$FC,
    $6F,$C1,$80,$00,$05,$00,$03,$80,$3E,$00,$00,$05,$01,$F8,$C7,
    $E3,$00,$00,$05,$00,$07,$00,$1C,$00,$00,$05,$03,$F1,$8F,$C1,
    $80,$00,$05,$00,$0E,$00,$3E,$00,$00,$05,$07,$E3,$1F,$88,$C0,
    $00,$05,$00,$1C,$00,$77,$00,$00,$05,$0F,$C6,$3F,$1C,$60,$00,
    $05,$00,$38,$00,$E3,$80,$00,$05,$1F,$8C,$7E,$3E,$30,$00,$05,
    $00,$70,$01,$C1,$C0,$00,$05,$3F,$18,$FC,$7F,$18,$00,$05,$00,
    $E0,$03,$80,$E0,$00,$05,$7E,$31,$F8,$DF,$8C,$00,$05,$01,$C0,
    $07,$00,$70,$00,$05,$FC,$63,$F1,$8F,$C6,$00,$05,$03,$80,$0E,
    $00,$38,$00,$05,$FC,$C3,$F3,$07,$E6,$00,$05,$03,$00,$0C,$00,
    $18,$00,$05,$FF,$83,$FE,$03,$FE,$00,$FB,$00,$05,$7F,$01,$FC,
    $01,$FC,$00,$FB,$00,$FB,$00,$FB,$00]:CHAR,
    MUIA_Bodychunk_Masking,     2,
    MUIA_Bodychunk_Compression, 1,
    MUIA_Bodychunk_Depth,       2,
    MUIA_Bitmap_Height,         21,
    MUIA_Bitmap_Width,          40,
    MUIA_FixHeight,             21,
    MUIA_FixWidth,              40,
    End])


  NEW frmMain.create(app)

  frmMain.doMain()

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

  IF app 
    app.dispose()
    END app
  ENDIF
  IF frmMain THEN END frmMain
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
