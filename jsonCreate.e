/*
JSON parser

IF you are saving icons you must open icon library in advance

*/
OPT OSVERSION=37
OPT MODULE

  MODULE 'dos/dos','workbench/workbench','icon','wb','dos/dosextens'
  MODULE '*jsonParser','*miscfuncs'

EXPORT PROC createdata(folderpath: PTR TO CHAR, js:PTR TO CHAR, t, count,doit,iconFiles=TRUE)
	DEF i, j, k,s,n,s2,s3,l1,l2,tot,dobj:PTR TO diskobject
  DEF fh,lock,toolTypes
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF folderpath2[255]:ARRAY OF CHAR
  DEF tok:PTR TO jsmntok_t,tok2:PTR TO jsmntok_t
	IF (count = 0)
		RETURN 0,NIL,0
	ENDIF
  tok:=t
	IF (tok.type = JSMN_PRIMITIVE)
    IF js[tok.start]="n"
      ->null
      RETURN 1,js+tok.start,0
    ELSE
      RETURN 1,js+tok.start,tok.end - tok.start
    ENDIF
	ELSEIF (tok.type = JSMN_STRING)
		RETURN 1,js+tok.start,tok.end - tok.start
	ELSEIF (tok.type = JSMN_OBJECT)
		j:=0
    tot:=0
		FOR i:=0 TO tok.size-1
			n,s2,l1:=createdata(folderpath,js, t+((1+j)*SIZEOF jsmntok_t), count-j,FALSE,iconFiles)
      j:=j+n
      tot:=tot+l1

			n,s2,l2:=createdata(folderpath,js, t+((1+j)*SIZEOF jsmntok_t), count-j,FALSE,iconFiles)
      tok2:=t+((1+j)*SIZEOF jsmntok_t)
      IF (tok2.type=JSMN_PRIMITIVE) OR (tok2.type=JSMN_STRING)
        tot:=tot+l2+1
      ELSE
        DisposeLink(s2)
      ENDIF
      j:=j+n
      tot++
		ENDFOR
    s:=String(tot)
		j:=0
		FOR i:=0 TO tok.size-1
			n,s2,l1:=createdata(folderpath,js, t+((1+j)*SIZEOF jsmntok_t), count-j,doit,iconFiles)
      j:=j+n

      AstrCopy(folderpath2,folderpath)
      StrCopy(tempstr,s2,l1)
      AddPart(folderpath2,tempstr,255)

      tok2:=t+((1+j)*SIZEOF jsmntok_t)
      IF ((tok2.type=JSMN_OBJECT) OR (tok2.type=JSMN_ARRAY)) AND doit
        lock:=CreateDir(folderpath)
        IF lock
          UnLock(lock)
        ELSEIF IoErr()<>203 
          WriteF('Could not create directory \s error \d\n',folderpath,IoErr())
        ENDIF
      ENDIF

			n,s3,l2:=createdata(folderpath2,js, t+((1+j)*SIZEOF jsmntok_t), count-j,doit,iconFiles)
      IF (tok2.type=JSMN_PRIMITIVE) OR (tok2.type=JSMN_STRING)
        IF l2>0
          IF l1>0
            StrAdd(s,s2,l1)
            StrAdd(s,'=')  
          ENDIF
          StrAdd(s,s3,l2)
          StrAdd(s,'\n')
        ELSE
          IF l1>0
            StrAdd(s,s2,l1)
            StrAdd(s,'\n')
          ENDIF
        ENDIF
      ELSE
        IF l2<>0
          IF doit

            IF iconFiles
              l1:=StrLen(s3)
              tot:=0
              FOR k:=0 TO l1-1
                IF s3[k]="\n"
                  s3[k]:=0
                  tot++
                ENDIF
              ENDFOR

              toolTypes:=List(tot+1)
              k:=0
              REPEAT
                ListAdd(toolTypes,[s3+k])
                k:=k+StrLen(s3+k)+1
                tot--
              UNTIL tot=0
              ListAdd(toolTypes,[NIL])

              dobj:=GetDiskObject(folderpath2)
              IF dobj=NIL 
                IF findAssign('BBS:')=FALSE
                  StringF(tempstr2,'bbs:storage/icons/\s',tempstr)
                  dobj:=GetDiskObject(tempstr2)
                  IF dobj=NIL
                    IF dirExists(folderpath2)
                      StrCopy(tempstr,'bbs:storage/icons/drawer')
                    ELSE
                      StrCopy(tempstr,'bbs:storage/icons/default')
                    ENDIF
                    dobj:=GetDiskObject(tempstr)
                  ENDIF
                ENDIF
                IF dobj=NIL
                  IF dirExists(folderpath2)
                    dobj:=GetDefDiskObject(WBDRAWER)
                  ELSE
                    dobj:=GetDefDiskObject(WBTOOL)
                  ENDIF
                ENDIF
                IF dobj=NIL
                  WriteF('Could not create an icon for file \s.info\n',folderpath2)
                ENDIF
              ENDIF
              IF dobj<>NIL
                dobj.tooltypes:=toolTypes
                IF PutDiskObject(folderpath2,dobj)=FALSE
                  WriteF('Could not write icon to file \s.info error \d\n',folderpath2,IoErr())
                ENDIF
                FreeDiskObject(dobj)
              ENDIF
              END toolTypes
            ELSE
              StrCopy(tempstr,folderpath2)
              StrAdd(tempstr,'.cfg')
              fh:=Open(tempstr,MODE_NEWFILE)
              IF fh<>0
                Write(fh,s3,EstrLen(s3))
                Close(fh)
              ELSE
                WriteF('Could not write to file \s error \d\n',tempstr,IoErr())
              ENDIF
            ENDIF
          ENDIF
          DisposeLink(s3)
        ELSE
          IF doit
            lock:=CreateDir(folderpath2)
            IF lock 
              UnLock(lock)
            ELSEIF IoErr()<>203
              WriteF('Could not create directory \s error \d\n',folderpath2,IoErr()) 
            ENDIF
          ENDIF
        ENDIF
      ENDIF
      j:=j+n
		ENDFOR

		RETURN j+1,s,EstrLen(s)
	ELSEIF (tok.type = JSMN_ARRAY)
		j:=0
    tot:=0
		FOR i:=0 TO tok.size-1
			n,s2,l1:=createdata(folderpath,js, t+((1+j)*SIZEOF jsmntok_t), count-j,FALSE,iconFiles)
      j:=j+n
      tot:=tot+l1+1
		ENDFOR
    s:=String(tot)
		j:=0
		FOR i:=0 TO tok.size-1
      n,s2,l1:=createdata(folderpath,js, t+((1+j)*SIZEOF jsmntok_t), count-j,TRUE,iconFiles)
      j:=j+n
      StrAdd(s,s2,l1)
      StrAdd(s,'\n')
    ENDFOR
		RETURN j+1,s,EstrLen(s)
	ENDIF
ENDPROC 0
