->Ami-Express verison info

MODULE 'dos/dos','dos/datetime'

PROC getBuildDateString(buildString:PTR TO CHAR)
  DEF dt : datetime
  DEF datestr[10]:STRING
  DEF timestr[10]:STRING

  DateStamp(dt.stamp)
  dt.format:=FORMAT_USA
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=datestr
  dt.strtime:=timestr
  IF DateToStr(dt)
    StringF(buildString,'\s[2]\s[2]\s[2]\s[2]\s[2]\s[2]\s[2]',IF dt.stamp.days>=8035 THEN '20' ELSE '19',datestr+6,datestr,datestr+3,timestr,timestr+3,timestr+6)
    RETURN TRUE
  ENDIF
  StrCopy(buildString,'')
ENDPROC FALSE
  
PROC fileWriteLine(fh,line)
  DEF l
  l:=EstrLen(line)
  IF Write(fh,line,l)<>l
    WriteF('Error writing to file\n')
    Close(fh)
    RETURN FALSE
  ENDIF
ENDPROC TRUE

PROC main()
  DEF myargs:PTR TO LONG,rdargs
  DEF outFile[255]:STRING
  DEF programName[255]:STRING
  DEF versionString[255]:STRING 
  DEF tempstr[255]:STRING
  DEF p:PTR TO LONG
  DEF buildNumber=0
  DEF buildString[255]:STRING
  DEF useDate=FALSE
  DEF fh
  
  WriteF('Version Info generator - V1.0 (c)2020 Darren Coles\n\n')
  
  myargs:=[0,0,0,0,0]:LONG
  IF rdargs:=ReadArgs('FILE/A,PROGRAM/A,VERSION/A,BUILD/N,USEDATE/S',myargs,NIL)
    IF myargs[0]<>NIL 
      StrCopy(outFile,myargs[0],255)
    ENDIF
    IF myargs[1]<>NIL 
      StrCopy(programName,myargs[1],255)
    ENDIF
    IF myargs[2]<>NIL 
      StrCopy(versionString,myargs[2],255)
    ENDIF
    IF myargs[3]<>NIL 
      p:=myargs[3]
      buildNumber:=p[]
    ENDIF
    IF myargs[4]<>NIL 
      useDate:=TRUE
    ENDIF
    FreeArgs(rdargs)
  ELSE
    WriteF('required argument missing\n')
    RETURN
  ENDIF
  
  IF useDate
    getBuildDateString(buildString)
  ELSE
    StringF(buildString,'\d',buildNumber)
  ENDIF
  
  fh:=Open(outFile,MODE_NEWFILE)
  IF fh=0
    WriteF('unable to open \s for writing\n',outFile)
    RETURN
  ENDIF

  StrCopy(tempstr,'->Version data\n')
  IF fileWriteLine(fh,tempstr)=FALSE THEN RETURN
  
  StrCopy(tempstr,'OPT MODULE\n\n')
  IF fileWriteLine(fh,tempstr)=FALSE THEN RETURN

  StrCopy(tempstr,'EXPORT PROC getBuild()\n')
  IF fileWriteLine(fh,tempstr)=FALSE THEN RETURN

  StrCopy(tempstr,'LEA verdata(PC),A0\n')
  IF fileWriteLine(fh,tempstr)=FALSE THEN RETURN

  StringF(tempstr,'LEA \d(A0),A0\n',EstrLen(programName)+7)
  IF fileWriteLine(fh,tempstr)=FALSE THEN RETURN

  StrCopy(tempstr,'MOVE.L A0,D0\n')
  IF fileWriteLine(fh,tempstr)=FALSE THEN RETURN
  
  StrCopy(tempstr,'ENDPROC D0\n')
  IF fileWriteLine(fh,tempstr)=FALSE THEN RETURN

  StrCopy(tempstr,'verdata:\n')
  IF fileWriteLine(fh,tempstr)=FALSE THEN RETURN

  StringF(tempstr,'  CHAR ''$VER: \s \s \s'',0\n',programName,versionString,buildString)
  IF fileWriteLine(fh,tempstr)=FALSE THEN RETURN

  Close(fh)
ENDPROC