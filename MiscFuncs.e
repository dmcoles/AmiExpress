/* Miscellaneous helper functions - used by express only */

  OPT MODULE

  MODULE 'dos/dos','dos/dosextens','dos/datetime'
  MODULE '*axenums','*axconsts'

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

EXPORT PROC fileExists(filename, addInfo = FALSE)
/* checks to see if a file exists and returns TRUE OR FALSE */
  DEF lh
  DEF fn[255]:STRING
  
  StrCopy(fn,filename)
  IF addInfo THEN StrAdd(fn,'.info')
  IF lh:=Lock(fn,ACCESS_READ)
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

EXPORT PROC listAdd2(list:PTR TO LONG, v)
  ListAdd(list,[0])
  list[ListLen(list)-1]:=v
ENDPROC

/*must be called with EString*/
EXPORT PROC removeCR(str:PTR TO CHAR)
  DEF i,n=0
  FOR i:=0 TO EstrLen(str)-1
    IF str[i]<>13
      str[n]:=str[i]
      n++
    ENDIF
  ENDFOR
  SetStr(str,n)
ENDPROC

EXPORT PROC stcsma(s: PTR TO CHAR,p: PTR TO CHAR)
  DEF ret,len
  DEF buf

  len:=StrLen(p)*2+2
  buf:=New(len)

  IF(buf=NIL)
    ret:=0
  ELSE
    IF (ParsePatternNoCase(p, buf, len) < 0)
      ret:=0
    ELSE
      ret:=MatchPatternNoCase(buf, s)
    ENDIF
  ENDIF
  Dispose(buf)
ENDPROC ret

EXPORT PROC formatSpaceValue(spaceInKB,outstr)
  DEF frac,whole
  IF (spaceInKB<10240)
    StringF(outstr,'\d KB',spaceInKB)
  ELSEIF(spaceInKB<1048576)
    frac:=Shr(Mul((spaceInKB AND 1023),10),10)
    whole:=Shr(spaceInKB,10)
    StringF(outstr,'\d.\d MB',whole,frac)
  ELSE
    spaceInKB:=Shr(spaceInKB,10)
    frac:=Shr(Mul((spaceInKB AND 1023),10),10)
    whole:=Shr(spaceInKB,10)
    StringF(outstr,'\d.\d GB',whole,frac)
  ENDIF
ENDPROC

PROC asmputchar()
  MOVE.B D0,(A3)+
ENDPROC

EXPORT PROC formatUnsignedLong(val,outStr)
  DEF outputTxt
  
  outputTxt:=NEW [0,0,0,0,0,0,0,0,0,0]:CHAR
  RawDoFmt('%lu',{val},{asmputchar},outputTxt)
  StrCopy(outStr,outputTxt)
  END outputTxt
EXPORT ENDPROC

EXPORT PROC formatBCD(valArrayBCD:PTR TO CHAR, outStr)
  DEF tempStr[2]:STRING
  DEF i,n,start=FALSE

  StrCopy(outStr,'')
  FOR i:=0 TO 7
    n:=valArrayBCD[i]
    IF (n<>0) OR (start) OR (i=7)
      IF (start) OR (n>=$10)
        StringF(tempStr,'\d\d',Shr(n AND $F0,4),n AND $F)
      ELSE
        StringF(tempStr,'\d',n AND $F)
      ENDIF
      StrAdd(outStr,tempStr)
      start:=TRUE
    ENDIF
  ENDFOR
ENDPROC

EXPORT PROC formatLongDate(cDateVal,outDateStr)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF datestr[10]:STRING
  DEF r,dateVal

  dateVal:=cDateVal-21600

  d:=dt.stamp
  d.tick:=(dateVal-Mul(Div(dateVal,60),60))
  d.tick:=Mul(d.tick,50)
  dateVal:=Div(dateVal,60)
  d.days:=Div((dateVal),1440)-2922   ->-2922 days between 1/1/70 and 1/1/78
  d.minute:=dateVal-(Mul(d.days+2922,1440))

  dt.format:=FORMAT_USA
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=datestr
  dt.strtime:=0

  IF DateToStr(dt)
    StringF(outDateStr,'\s',datestr)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

EXPORT PROC formatLongTime(cDateVal,outDateStr)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF time[10]:STRING
  DEF r,dateVal

  dateVal:=cDateVal-21600

  d:=dt.stamp
  d.tick:=(dateVal-Mul(Div(dateVal,60),60))
  d.tick:=Mul(d.tick,50)
  dateVal:=Div(dateVal,60)
  d.days:=Div((dateVal),1440)-2922   ->-2922 days between 1/1/70 and 1/1/78
  d.minute:=dateVal-(Mul(d.days+2922,1440))

  dt.format:=FORMAT_USA
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=0
  dt.strtime:=time

  IF DateToStr(dt)
    StringF(outDateStr,'\s',time)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

EXPORT PROC formatLongDateTime(cDateVal,outDateStr)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF datestr[10]:STRING
  DEF daystr[10]:STRING
  DEF timestr[10]:STRING
  DEF r,dateVal

  dateVal:=cDateVal-21600

  d:=dt.stamp
  d.tick:=(dateVal-Mul(Div(dateVal,60),60))
  d.tick:=Mul(d.tick,50)
  dateVal:=Div(dateVal,60)
  d.days:=Div((dateVal),1440)-2922   ->-2922 days between 1/1/70 and 1/1/78
  d.minute:=dateVal-(Mul(d.days+2922,1440))

  dt.format:=FORMAT_DOS
  dt.flags:=0
  dt.strday:=daystr
  dt.strdate:=datestr
  dt.strtime:=timestr

  IF DateToStr(dt)
    StringF(outDateStr,'\s[3] \s \s',daystr,datestr,timestr)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

EXPORT PROC formatLongDateTime2(cDateVal,outDateStr,seperatorChar)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF datestr[10]:STRING
  DEF timestr[10]:STRING
  DEF r,dateVal

  dateVal:=cDateVal-21600

  d:=dt.stamp
  d.tick:=(dateVal-Mul(Div(dateVal,60),60))
  d.tick:=Mul(d.tick,50)
  dateVal:=Div(dateVal,60)
  d.days:=Div((dateVal),1440)-2922   ->-2922 days between 1/1/70 and 1/1/78
  d.minute:=dateVal-(Mul(d.days+2922,1440))

  dt.format:=FORMAT_USA
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=datestr
  dt.strtime:=timestr

  IF DateToStr(dt)
    StringF(outDateStr,'\s\c\s',datestr,seperatorChar,timestr)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

->returns a numeric value of the date suitable for comparing to other dates
EXPORT PROC getDateCompareVal(datestr:PTR TO CHAR)
  DEF month,day,year

  month:=Val(datestr)
  day:=Val(datestr+3)
  year:=Val(datestr+6)

  IF (year>TWODIGITYEARSWITCHOVER) THEN year:=1900+year ELSE year:=2000+year

ENDPROC Mul(year,10000)+Mul(month,100)+day

EXPORT PROC isupper(c)
ENDPROC (c>="A") AND (c<="Z")

->returns system date converted to c time format
EXPORT PROC getSystemDate()
  DEF currDate: datestamp
  DEF startds:PTR TO datestamp
  DEF s1,s2,s3,s4

  startds:=DateStamp(currDate)

  s1:=startds.days+2922
  s1:=Mul(1440,s1)
  s1:=Mul(60,s1)
  s2:=Mul(60,startds.minute)
  s3:=startds.tick/50
  s4:=Mul(Mul(startds.days+2922,1440),60)+(startds.minute*60)+(startds.tick/50)

  s4:=s4+21600

  s4:=Mul(Div(s4,86400),86400)
  ->2922 days between 1/1/70 and 1/1/78

ENDPROC s4

->returns system time converted to c time format
EXPORT PROC getSystemTime()
  DEF currDate: datestamp
  DEF startds:PTR TO datestamp
  DEF s1,s2,s3,s4

  startds:=DateStamp(currDate)

  s1:=startds.days+2922
  s1:=Mul(1440,s1)
  s1:=Mul(60,s1)
  s2:=Mul(60,startds.minute)
  s3:=startds.tick/50
  s4:=Mul(Mul(startds.days+2922,1440),60)+(startds.minute*60)+(startds.tick/50)

  ->2922 days between 1/1/70 and 1/1/78

ENDPROC s4+21600

->returns system time converted to c time format and ticks
EXPORT PROC getSystemTime2()
  DEF currDate: datestamp
  DEF startds:PTR TO datestamp
  DEF s1,s2,s3,s4

  startds:=DateStamp(currDate)

  s1:=startds.days+2922
  s1:=Mul(1440,s1)
  s1:=Mul(60,s1)
  s2:=Mul(60,startds.minute)
  s3:=startds.tick/50
  s4:=Mul(Mul(startds.days+2922,1440),60)+(startds.minute*60)+(startds.tick/50)

  ->2922 days between 1/1/70 and 1/1/78

ENDPROC s4+21600,Mod(startds.tick,50)

EXPORT PROC fileWriteLn(fh,str: PTR TO CHAR)
  DEF stat
  IF (stat:=fileWrite(fh,str))<>RESULT_SUCCESS THEN RETURN stat
ENDPROC fileWrite(fh,'\n')

EXPORT PROC fileWrite(fh,str: PTR TO CHAR)
  DEF s

  s:=Write(fh,str,StrLen(str))
  IF s<>StrLen(str) THEN RETURN RESULT_FAILURE
ENDPROC RESULT_SUCCESS

EXPORT PROC strCpy(dest: PTR TO CHAR, source: PTR TO CHAR, len)
  DEF c,endfound=FALSE
  DEF i
  IF len=ALL
    AstrCopy(dest,source,ALL)
  ELSE
    FOR i:=0 TO len-1
      c:=source[i]
      IF (c=0) OR (i=(len-1)) THEN endfound:=TRUE
      IF endfound THEN c:=0
      dest[i]:=c
    ENDFOR
  ENDIF
ENDPROC

EXPORT PROC strAddChar(dest,source)
  StrAdd(dest,' ')
  dest[EstrLen(dest)-1]:=source
ENDPROC

EXPORT PROC countSpaces(str:PTR TO CHAR)
  DEF i,count=0

  FOR i:=0 TO StrLen(str)-1
    IF str[i]=" "
      count++
    ENDIF
  ENDFOR
ENDPROC count

EXPORT PROC readIntFromFile(filename: PTR TO CHAR)
  DEF fh
  DEF v[100]:STRING
  IF((fh:=Open(filename,MODE_OLDFILE)))<>0
    ReadStr(fh,v)
    Close(fh)
    RETURN Val(v)
  ENDIF
ENDPROC -1

EXPORT PROC readFloatFromFile(filename: PTR TO CHAR)
  DEF fh
  DEF v[100]:STRING
  IF((fh:=Open(filename,MODE_OLDFILE)))<>0
    ReadStr(fh,v)
    Close(fh)
    RETURN RealVal(v)
  ENDIF
ENDPROC 0.0

EXPORT PROC writeIntToFile(filename: PTR TO CHAR, v: LONG)
  DEF fh
  DEF vStr[100]:STRING
  IF((fh:=Open(filename,MODE_NEWFILE)))<>0
    StringF(vStr,'\d',v)
    fileWriteLn(fh,vStr)
    Close(fh)
    RETURN RESULT_SUCCESS
  ENDIF
ENDPROC RESULT_FAILURE

EXPORT PROC writeFloatToFile(filename: PTR TO CHAR, v: LONG)
  DEF fh
  DEF vStr[100]:STRING
  IF((fh:=Open(filename,MODE_NEWFILE)))<>0
    RealF(vStr,v,8)
    fileWriteLn(fh,vStr)
    Close(fh)
    RETURN RESULT_SUCCESS
  ENDIF
ENDPROC RESULT_FAILURE
