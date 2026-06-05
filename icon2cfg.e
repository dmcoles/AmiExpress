-> Convert icon with tooltypes to a .cfg file 

OPT OSVERSION=37

  MODULE 'dos/dos','workbench/workbench','icon','wb','dos/dosextens'
  MODULE '*miscfuncs'

ENUM ERR_NOICON=1
ENUM SOURCE_ICON,SOURCE_CFG

PROC main() HANDLE
  DEF tempstr[255]:STRING
  DEF inFile
  DEF sourceFile[255]:STRING
  DEF destFile[255]:STRING
  DEF fn2[255]:STRING
  DEF len,off,lineCount
  DEF source,fileBuf
  DEF toolTypes:PTR TO LONG
  DEF dobj:PTR TO diskobject
  DEF tt:PTR TO LONG
  DEF fh,i
  WriteF('Icon2cfg: Ami-Express icon to cfg file converter\n')
  WriteF('Converts icon to cfg files or cfg to icon\n\n')

  IF StrLen(arg)=0
    WriteF('Please specify the icon or cfg file')
  ENDIF

  IF (iconbase:=OpenLibrary('icon.library',33))=NIL THEN Raise(ERR_NOICON)

  inFile:=arg

  source:=SOURCE_ICON
  IF StrLen(inFile)>5
    StrCopy(tempstr,inFile)
    UpperStr(tempstr)
    IF StrCmp(tempstr+StrLen(tempstr)-5,'.INFO')
      StrCopy(sourceFile,inFile,StrLen(tempstr)-5)
      StringF(destFile,'\s.cfg',sourceFile)
    ENDIF
  ENDIF
  
  IF (StrLen(inFile)>4) AND (StrLen(destFile)=0)
    StrCopy(tempstr,inFile)
    UpperStr(tempstr)
    IF StrCmp(tempstr+StrLen(tempstr)-4,'.CFG')
      StrCopy(sourceFile,inFile)
      StrCopy(destFile,inFile,StrLen(tempstr)-4)
      source:=SOURCE_CFG
    ENDIF
  ENDIF

  IF source=SOURCE_ICON
    WriteF('Reading icon file\s..',sourceFile)
    dobj:=GetDiskObject(sourceFile)
    IF dobj THEN WriteF('done\n') ELSE WriteF('failed, error: \d',IoErr())

    IF dobj=NIL THEN RETURN

    WriteF('Writing cfg file \s..',destFile)
    fh:=Open(destFile,MODE_NEWFILE)
    IF fh<>0
      tt:=dobj.tooltypes
      i:=0
      WHILE tt[i]<>0
        StringF(tempstr,'\s\n',tt[i])
        Write(fh,tempstr,StrLen(tempstr))
        i++
      ENDWHILE
      WriteF('done\n')
    ELSE
      WriteF('failed, error:\d\n',fh)
    ENDIF
    Close(fh)
    IF dobj<>NIL THEN FreeDiskObject(dobj)
  ELSEIF source=SOURCE_CFG
    WriteF('Reading cfg file \s..',sourceFile)

    toolTypes:=NIL
    dobj:=GetDiskObject(destFile)
    IF dobj=NIL
      StringF(tempstr,'bbs:storage/icons/\s',tempstr)
      dobj:=GetDiskObject(tempstr)
      IF dobj=NIL
        IF dirExists(destFile)
          StrCopy(tempstr,'bbs:storage/icons/drawer')
        ELSE
          StrCopy(tempstr,'bbs:storage/icons/default')
        ENDIF
        dobj:=GetDiskObject(tempstr)
        IF dobj=NIL
          dobj:=GetDefDiskObject(WBPROJECT)
        ENDIF
      ENDIF
    ENDIF

    fileBuf:=New(FileLength(fn2)+1)     ->allow an extra char in case file does not end in LF
    IF fileBuf<>NIL
      fh:=Open(sourceFile,MODE_OLDFILE)
      IF fh<>0
        off:=0
        lineCount:=0
        WHILE(ReadStr(fh,fn2)<>-1) OR (StrLen(fn2)>0)
          len:=0
          WHILE (fn2[len]<>0) AND (fn2[len]<>";")
            len++
          ENDWHILE

          ->trim trailing space
          WHILE (fn2[len-1]<=32) AND (len>0)
            len--
            EXIT len=0    ->this is just here to prevent the fn2[len-1] causing a buffer underrun in the absence of short circuit evaluation
          ENDWHILE
          SetStr(fn2,len)

          AstrCopy(fileBuf+off,fn2,len+1)
          lineCount++
          off:=off+len+1
        ENDWHILE
        
        toolTypes:=List(lineCount+1)
        off:=0
        FOR i:=1 TO lineCount
          ListAdd(toolTypes,[fileBuf+off])
          off:=off+StrLen(fileBuf+off)+1
        ENDFOR
        ListAdd(toolTypes,[NIL])
        dobj.tooltypes:=toolTypes
        Close(fh)
        WriteF('done\n')
      ELSE
        WriteF('failed, could not open source file, error: \d\n',fh)
        Dispose(fileBuf)
        FreeDiskObject(dobj)
        dobj:=NIL
      ENDIF
    ELSE
      WriteF('failed, could not allocate file buffer memory\n')
    ENDIF

    IF (dobj=NIL) OR (toolTypes=NIL) THEN RETURN

    WriteF('Writing icon file \s..',destFile)
    IF PutDiskObject(destFile,dobj)=FALSE
      WriteF('failed, could not save icon file, error:\d\n',IoErr())
    ELSE
      WriteF('done\n')
    ENDIF
    FreeDiskObject(dobj)
  ENDIF

EXCEPT DO
  IF iconbase<>NIL THEN CloseLibrary(iconbase)
  SELECT exception
    CASE ERR_NOICON
      WriteF('unable to open icon.library\n')
  ENDSELECT
ENDPROC