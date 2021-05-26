/* Miscellaneous helper functions - used by express only */

  OPT MODULE

  MODULE 'dos/dos','dos/dosextens','dos/datetime'
  MODULE '*axenums','*axconsts','*axobjects','*errors'

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

EXPORT PROC checkPathSlash(path)
  DEF c
  c:=path[StrLen(path)-1]
  IF (c<>":") AND (c<>"/")
    StrAdd(path,'/')
  ENDIF
ENDPROC 

EXPORT PROC makeIntList(src:PTR TO CHAR)
  DEF res
  DEF m=1
  DEF tmp,i
  
  tmp:=String(StrLen(src))
  
  FOR i:=0 TO StrLen(src)-1
    IF src[i]="," THEN m++
  ENDFOR
  
  res:=List(m)
  FOR i:=0 TO StrLen(src)-1
    IF src[i]=","
      listAdd2(res,Val(tmp))
      StrCopy(tmp,'')
    ELSE
      strAddChar(tmp,src[i])
    ENDIF
  ENDFOR
  IF StrLen(tmp)>0
    listAdd2(res,Val(tmp))
  ENDIF
  
  DisposeLink(tmp)
  
ENDPROC res

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

EXPORT PROC midStr2(dest,src,pos,len)
  IF len>0 THEN MidStr(dest,src,pos,len) ELSE StrCopy(dest,'')
ENDPROC

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

EXPORT PROC stringCompare(nam: PTR TO CHAR,pat: PTR TO CHAR)
  DEF p,loop=TRUE

  WHILE loop
    IF charToLower(nam[0])=charToLower(pat[0])
      IF nam[0]=0 THEN RETURN RESULT_SUCCESS
      nam++
      pat++
    ELSEIF (pat[0]="?") AND (nam[0]<>0)
      nam++
      pat++
    ELSE
      loop:=FALSE
    ENDIF
  ENDWHILE

  IF pat[0]<>"*" THEN RETURN RESULT_FAILURE

  WHILE pat[0]="*"
    pat++
    IF pat[0]=0 THEN RETURN RESULT_SUCCESS
  ENDWHILE

  FOR p:=StrLen(nam)-1 TO 0 STEP -1
    IF charToLower(nam[p]) = charToLower(pat[0])
      IF stringCompare(nam+p,pat) = RESULT_SUCCESS THEN RETURN RESULT_SUCCESS
    ENDIF
  ENDFOR
ENDPROC RESULT_FAILURE

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

EXPORT PROC formatSpaceValue(spaceInMB,spacelo,outstr)
  DEF frac,whole
  IF (spaceInMB<10240)
    frac:=Shr(Mul((spacelo AND $FFFFF),10),20)
    StringF(outstr,'\d.\d MB',spaceInMB,frac)
  ELSEIF(spaceInMB<1048576)
    frac:=Shr(Mul((spaceInMB AND 1023),10),10)
    whole:=Shr(spaceInMB,10)
    StringF(outstr,'\d.\d GB',whole,frac)
  ELSE
    spaceInMB:=Shr(spaceInMB,10)
    frac:=Shr(Mul((spaceInMB AND 1023),10),10)
    whole:=Shr(spaceInMB,10)
    StringF(outstr,'\d.\d TB',whole,frac)
  ENDIF
ENDPROC

PROC asmputchar()
  MOVE.B D0,(A3)+
ENDPROC

EXPORT PROC formatUnsignedLong(val,outStr)
  DEF outputTxt[10]:ARRAY OF CHAR
  
  RawDoFmt('%lu',{val},{asmputchar},outputTxt)
  StrCopy(outStr,outputTxt)
EXPORT ENDPROC

EXPORT PROC formatLongDate(cDateVal,outDateStr)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF datestr[10]:STRING
  DEF dateVal

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
  DEF dateVal

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
  DEF dateVal

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
    StringF(outDateStr,'\s[3] \s[7]\d\s \s',daystr,datestr,IF dt.stamp.days>=8035 THEN 20 ELSE 19,datestr+7,timestr)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

EXPORT PROC formatCDateTime(cDateVal,outDateStr)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF datestr[10]:STRING
  DEF daystr[10]:STRING
  DEF timestr[10]:STRING
  DEF dateVal

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
    StringF(outDateStr,'\s[3] \s[3] \s[2] \s \d\s',daystr,datestr+3,datestr,timestr,IF dt.stamp.days>=8035 THEN 20 ELSE 19,datestr+7)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

EXPORT PROC formatLongDateTime2(cDateVal,outDateStr,seperatorChar)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF datestr[10]:STRING
  DEF timestr[10]:STRING
  DEF dateVal

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
  DEF s4

  startds:=DateStamp(currDate)

  s4:=(Mul(Mul(startds.days+2922,1440),60)+(startds.minute*60)+(startds.tick/50))+21600
  ->2922 days between 1/1/70 and 1/1/78
ENDPROC Mul(Div(s4,86400),86400)

->returns system time converted to c time format
EXPORT PROC getSystemTime()
  DEF currDate: datestamp
  DEF startds:PTR TO datestamp

  startds:=DateStamp(currDate)
  ->2922 days between 1/1/70 and 1/1/78

ENDPROC (Mul(Mul(startds.days+2922,1440),60)+(startds.minute*60)+(startds.tick/50))+21600,Mod(startds.tick,50)

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

EXPORT PROC mulu64(src1,src2)
  DEF res1,res2
-> umult64 - mulu.l d0,d0:d1

  MOVE.L src1,D0
  MOVE.L src2,D1

  MOVE.L D2,-(A7)
  MOVE.W D0,D2
  MULU D1,D2
  MOVE.L D2,-(A7)
  MOVE.L D1,D2
  SWAP D2
  MOVE.W D2,-(A7)
  MULU D0,D2
  SWAP D0
  MULU D0,D1
  MULU (A7)+,D0
  ADD.L D2,D1
  MOVEQ #0,D2
  ADDX.W D2,D2
  SWAP D2
  SWAP D1
  MOVE.W D1,D2
  CLR.W D1
  ADD.L (A7)+,D1
  ADDX.L D2,D0
  MOVE.L (A7)+,D2
  MOVE.L D0,res1
  MOVE.L D1,res2
ENDPROC res1,res2

EXPORT PROC addWO(x,y)
  MOVE.L x,D0
  ADD.L y,D0
  BCC noover
  MOVEQ.L #-1,D0
noover:
ENDPROC D0

EXPORT PROC findFirst(path: PTR TO CHAR,buf: PTR TO CHAR) HANDLE
  DEF pdir=NIL: PTR TO filelock
  DEF dir_info=NIL: PTR TO fileinfoblock
  DEF returnval=0

  IF ((dir_info:=(AllocDosObject(DOS_FIB,NIL)))=NIL)
    Delay(300)
    RETURN 0
  ENDIF

  IF((pdir:=(Lock(path,ACCESS_READ)))=FALSE)
    Raise(ERR_EXCEPT)
  ENDIF

  IF(Examine(pdir,dir_info))=FALSE
    Raise(ERR_EXCEPT)
  ENDIF

  IF(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0 )
      returnval:=1
      StrCopy(buf,dir_info.filename)
    ENDIF
  ENDIF
  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)
EXCEPT
  IF pdir THEN UnLock(pdir)
  IF dir_info THEN FreeDosObject(DOS_FIB,dir_info)
  RETURN 0
ENDPROC returnval

EXPORT PROC byteSignExtend(n)
  DEF r
  r:=n AND 255
  IF r>127 THEN r:=-(256-r)
ENDPROC r

EXPORT PROC parsePatternNoCase2(source:PTR TO CHAR,dest:PTR TO CHAR, len)
  DEF s:PTR TO CHAR
  DEF t[1]:STRING
  DEF c,i,r
  
  c:=StrLen(source)
  FOR i:=0 TO c-1
    StrCopy(t,source+i,1)
    IF InStr('()|~[]%',t)>=0 THEN c++
  ENDFOR

  s:=String(c)
  FOR i:=0 TO StrLen(source)-1
    StrCopy(t,source+i,1)
    IF InStr('()|~[]%',t)>=0 THEN strAddChar(s,39)
    StrAdd(s,t)
  ENDFOR
  r:=ParsePatternNoCase(s,dest,len)
  DisposeLink(s)
ENDPROC r

EXPORT PROC stripAnsi(s: PTR TO CHAR, d: PTR TO CHAR, resetit, strip, ansi:PTR TO ansi)
  DEF i,j,k,p,c
  IF resetit
    ansi.ansicode:=0
    RETURN
  ENDIF

  i:=StrLen(s)
  j:=0
  k:=0
  WHILE(j<i)
    c:=s[j]
    IF((c=13) AND (strip<>0))
      j++
      ansi.ansicode:=0
    ELSEIF((ansi.ansicode=0) AND (c<>""))
      d[k]:=c
      j++
      k++
    ELSE
      IF(ansi.ansicode)
        ansi.buf[ansi.ansicode]:=c
        IF((ansi.ansicode=1) AND (c<>"["))
          ansi.ansicode:=ansi.ansicode+1

          p:=0
          ansi.buf[ansi.ansicode]:=0
          WHILE(ansi.buf[p]<>0)
            d[k]:=ansi.buf[p]
            k++
            p++
          ENDWHILE
          ansi.ansicode:=0
        ELSE
          SELECT c
            CASE "m"
              ansi.ansicode:=0
            DEFAULT
              ansi.ansicode:=ansi.ansicode+1
              IF(((c>="A") AND (c<="Z")) OR ((c>="a") AND (c<="z")) OR (ansi.ansicode>30))
                p:=0
                ansi.buf[ansi.ansicode]:=0
                WHILE(ansi.buf[p]<>0)
                  d[k]:=ansi.buf[p]
                  k++
                  p++
                ENDWHILE
                ansi.ansicode:=0
              ENDIF
          ENDSELECT
        ENDIF
      ELSEIF(c="")
        ansi.buf[0]:=""
        ansi.ansicode:=1
      ENDIF
      j++
    ENDIF
  ENDWHILE
  d[k]:=0

  ->ensure estring length is updated
  SetStr(d,StrLen(d))
ENDPROC
