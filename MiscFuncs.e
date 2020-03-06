/* Miscellaneous helper functions */

  OPT MODULE

  MODULE 'dos/dos','dos/dosextens'

EXPORT PROC getFileSize(s: PTR TO CHAR)
/* returns the file size of a given file or 8192 if an error occured */
  DEF fBlock: fileinfoblock
  DEF fLock
  DEF fsize=8192

  IF((fLock:=Lock(s,ACCESS_READ)))=NIL
    RETURN 8192
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN 8192
  ENDIF
  IF(Examine(fLock,fBlock)) THEN fsize:=fBlock.size
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC fsize

EXPORT PROC fileExists(filename)
/* checks to see if a file exists and returns TRUE OR FALSE */
  DEF lh
  IF lh:=Lock(filename,ACCESS_READ)
    UnLock(lh)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

EXPORT PROC dirExists(path: PTR TO CHAR)
/* checks to see if a directory exists and is a directory and not a file and returns TRUE OR FALSE */
  DEF pdir: PTR TO filelock
  DEF dir_info: PTR TO fileinfoblock
  DEF returnval=0

  IF ((dir_info:=(AllocDosObject(DOS_FIB,NIL)))=NIL)
    Delay(300)
    RETURN 0
  ENDIF
  
  IF((pdir:=(Lock(path,ACCESS_READ)))=FALSE)
    UnLock(pdir)
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF

  IF(Examine(pdir,dir_info))=FALSE
    UnLock(pdir)
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF

  IF(dir_info.direntrytype > 0 )
    returnval:=1
  ENDIF
  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)
ENDPROC returnval

EXPORT PROC strCmpi(test1: PTR TO CHAR, test2: PTR TO CHAR, len)
  /* case insensitive string compare */
  DEF i,l1,l2

  IF len=ALL
    l1:=StrLen(test1)
    l2:=StrLen(test2)
    IF l1<>l2 THEN RETURN FALSE
    len:=l1
  ENDIF

  FOR i:=0 TO len-1
    IF charToLower(test1[i])<>charToLower(test2[i]) THEN RETURN FALSE
  ENDFOR
ENDPROC TRUE

EXPORT PROC charToLower(c)
  /* convert a given char to lowercase */
  DEF str[1]:STRING
  str[0]:=c
  LowerStr(str)
ENDPROC str[0]

EXPORT PROC charToUpper(c)
  /* convert a given char to uppercase */
  DEF str[1]:STRING
  str[0]:=c
  UpperStr(str)
ENDPROC str[0]

/* trim spaces from both ends of a string and puts it in the destination estring*/
EXPORT PROC fullTrim(src:PTR TO CHAR,dest:PTR TO CHAR)
  DEF n,v=0
  StrCopy(dest,TrimStr(src))
  n:=EstrLen(dest)
  IF n>0 THEN v:=dest[n-1]
  WHILE (n>0) AND (v=" ")
    SetStr(dest,n-1)
    n:=EstrLen(dest)
    IF n>0 THEN v:=dest[n-1]
  ENDWHILE
ENDPROC

EXPORT PROC findAssign(name: PTR TO CHAR)
/* checks to see if a specified assign exists, returns 0 if it exists otherwise it returns 20 */
  DEF db: doslibrary
  DEF rootnode: PTR TO rootnode
  DEF dosinfo: PTR TO dosinfo
  DEF devicelist: PTR TO devlist
  DEF temp[256]:STRING
  DEF temp2[256]:STRING
  DEF i=0
 
  StrCopy(temp,name)
  WHILE temp[i]
   IF(temp[i]=":")
     SetStr(temp,i)
     i:=-1
   ENDIF
   EXIT i=-1
   i++
  ENDWHILE
 
  IF i<>-1 THEN RETURN 20

  db:=dosbase
  rootnode:=db.root
  dosinfo:=Shl(rootnode.info,2)
  devicelist:=Shl(dosinfo.devinfo,2)
  Forbid()
  WHILE(devicelist.next)
    bStrC(devicelist.name,temp2)
    IF(strCmpi(temp2,temp,ALL)/* && devicelist->dl_Type!=DLT_DEVICE*/)
      Permit()
      RETURN 0
    ENDIF 
    devicelist:=Shl(devicelist.next,2)
  ENDWHILE
  Permit()
ENDPROC 20

PROC bStrC(bstr: PTR TO CHAR,outbuf: PTR TO CHAR)
/* take a BStr pointer and copy the characters to a new EString) */

 DEF str: PTR TO CHAR
 DEF loop,counter

  counter:=0
  str:=Shl(bstr,2)
  SetStr(outbuf,str[0])
  FOR loop:=1 TO str[0]
    outbuf[counter]:=str[loop]
    counter++
  ENDFOR
ENDPROC
