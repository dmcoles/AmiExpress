OPT MODULE
  MODULE 'dos/dos'

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

EXPORT PROC makeDir(folderStr)
  DEF lock
 
  lock:=Lock(folderStr,ACCESS_READ)
  IF lock=0
    lock:=CreateDir(folderStr)
  ENDIF
  IF lock THEN UnLock(lock)
ENDPROC

EXPORT PROC stripInfo(y:PTR TO CHAR)
  DEF x,brk=FALSE
  
  x:=StrLen(y)-1
  WHILE(x>-1)
    IF(y[x]=".")
      y[x]:=0
      brk:=TRUE
    ENDIF
    EXIT brk
    x--
  ENDWHILE
ENDPROC x
