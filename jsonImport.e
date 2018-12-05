/*
JSON parser
*/
OPT OSVERSION=37

  MODULE 'dos/dos','asl','libraries/asl','workbench/workbench','icon','wb',
        '*jsonParser'


ENUM ERR_NONE, ERR_ASL, ERR_KICK, ERR_LIB

RAISE ERR_ASL  IF AllocAslRequest()=NIL,
      ERR_KICK IF KickVersion()=FALSE,
      ERR_LIB  IF OpenLibrary()=NIL


PROC main() HANDLE
	DEF r
  DEF p:jsmn_parser
  DEF tok:PTR TO jsmntok_t
  DEF tokcount
  DEF fh,lock
  DEF fib:PTR TO fileinfoblock
  DEF filesize,buf
  DEF infile[255]:ARRAY OF CHAR
  DEF outpath[255]:ARRAY OF CHAR
  DEF fr:PTR TO filerequester
  DEF myargs:PTR TO LONG,rdargs
  DEF iconFiles=TRUE
  KickVersion(37)  -> E-Note: requires V37

  fr:=NIL

  AstrCopy(infile,'',ALL)
  AstrCopy(outpath,'',ALL)

  myargs:=[0,0,0]:LONG
  IF rdargs:=ReadArgs('CONFIG/K,WRITEPATH/K,CFGFILES/S',myargs,NIL)
    IF myargs[0]<>NIL THEN AstrCopy(infile,myargs[0],255)
    IF myargs[1]<>NIL THEN AstrCopy(outpath,myargs[1],255)
    IF myargs[2]<>NIL THEN iconFiles:=FALSE
    FreeArgs(rdargs)
  ENDIF

  WriteF('\nAmi-Express v5.0.0 BBS Import Tool (c)2018 Darren Coles\n\n')

  aslbase:=OpenLibrary('asl.library',37)
  iconbase:=OpenLibrary('icon.library',33)

  IF StrLen(infile)=0
    fr:=AllocAslRequest(ASL_FILEREQUEST,
                       [ASL_HAIL,       'Select /X config file',
                        ->ASL_WINDOW,window,
                        ASL_PATTERN,'#?.json',
                        ASL_FUNCFLAGS, FILF_PATGAD,
                        NIL])

    IF AslRequest(fr, NIL)=FALSE
      WriteF('No file was selected.\n\n')
      RETURN
    ENDIF
    AstrCopy(infile,fr.drawer,255)
    AddPart(infile,fr.file,255)
    FreeAslRequest(fr)
    fr:=NIL
  ENDIF

  IF StrLen(outpath)=0
    fr:=AllocAslRequest(ASL_FILEREQUEST,
                       [ASL_HAIL,       'Select output path',
                        ->ASL_WINDOW,window,
                        ASL_DIR,'ram:json',
                        NIL])

    IF AslRequest(fr, NIL)=FALSE
      WriteF('No output folder was selected.\n\n')
      RETURN
    ENDIF
    AstrCopy(outpath,fr.drawer,255)
    FreeAslRequest(fr)
    fr:=NIL
  ENDIF

  lock:=CreateDir(outpath)
  IF lock THEN UnLock(lock) 

	/* Prepare parser */
	jsmn_init(p)
  
  fh:=Open(infile,MODE_OLDFILE)
  IF fh<1
		WriteF('Could not open json file\n\n')
    RETURN
  ENDIF

  IF ((fib:=(AllocDosObject(DOS_FIB,NIL)))=NIL)
		WriteF('Could not allocate dos object\n\n')
    RETURN 4
  ENDIF
  
  IF ExamineFH(fh,fib)=NIL
		WriteF('Could not examine json file\n\n')
    FreeDosObject(DOS_FIB,fib)
    RETURN 5
  ENDIF

  filesize:=fib.size
  FreeDosObject(DOS_FIB,fib)

  buf:=New(filesize)
	IF (buf = NIL)
		WriteF('Could not allocate enough memory to read json file\n\n')
		RETURN 6
	ENDIF
  
  /* Read json into memory */
  r:=Read(fh,buf, filesize)
  Close(fh)
  IF (r <> filesize)
		WriteF('Error reading json config file\n\n')
    RETURN 1
  ENDIF

  tokcount:=jsmn_parse(p, buf, filesize, 0, 0)

	tok:=New(SIZEOF jsmntok_t * tokcount)
	IF (tok = NIL)
		WriteF('Could not allocate enough memory to parse json file\n\n')
		RETURN 7
	ENDIF
  
	jsmn_init(p)
  r:=jsmn_parse(p, buf, filesize, tok, tokcount)
  IF (r>=0)
    createdata(outpath, buf, tok, p.toknext,TRUE,iconFiles)
    WriteF('Files created in: \s\n\n',outpath)   
  ELSE
    SELECT r
      CASE JSMN_ERROR_NOMEM
        WriteF('Error Parsing json file - not enough memory to proceed\n\n')
      CASE JSMN_ERROR_INVAL
        WriteF('Error Parsing json file - invalid data found\n\n')
      CASE JSMN_ERROR_PART
        WriteF('Error Parsing json file - incomplete data found\n\n')
    ENDSELECT
  ENDIF
EXCEPT DO
  IF fr THEN FreeAslRequest(fr)
  IF aslbase THEN CloseLibrary(aslbase)
  IF iconbase THEN CloseLibrary(iconbase)
  SELECT exception
    CASE ERR_ASL;  WriteF('Error: Could not allocate ASL request\n\n')
    CASE ERR_KICK; WriteF('Error: Requires V37\n\n')
    CASE ERR_LIB;  WriteF('Error: Could not open ASL library\n\n')
  ENDSELECT
ENDPROC
