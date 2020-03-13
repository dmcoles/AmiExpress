
  MODULE 'dos/dos','dos/dostags','dos/datetime'
  MODULE '*stringlist'

  DEF confIds=NIL:PTR TO stringlist
  DEF confNames=NIL:PTR TO stringlist
  DEF msgBasePaths=NIL:PTR TO stringlist
  DEF bbsName[255]:STRING
  DEF bbsLocation[255]:STRING
  DEF bbsNumber[255]:STRING
  DEF sysopName[255]:STRING
  DEF userName[255]:STRING
  DEF bbsId[255]:STRING
  DEF msgNum

  ENUM ERR_NOCFG,ERR_QWK_GRAB,ERR_QWK_UNPACK,ERR_QWK_PACK,ERR_WRITE_MAILSTAT,ERR_READ_MESSAGES_DAT,ERR_READ_MAILSTAT,ERR_READ_HEADERFILE

  CONST RESULT_SUCCESS=-1,RESULT_FAILURE=0

OBJECT qwkHeader
  status:CHAR
  num:LONG
  to[26]:ARRAY OF CHAR
  msgdate[14]:ARRAY OF CHAR
  from[26]:ARRAY OF CHAR
  subject[26]:ARRAY OF CHAR
  password[13]:ARRAY OF CHAR
  inReplyTo:LONG
  blockCount:LONG
  active: CHAR
  confNum: INT
  relativeMsgNum: INT
  netTag: CHAR
ENDOBJECT

OBJECT mailStat
  lowestKey : LONG
  highMsgNum : LONG
  lowestNotDel : LONG
  pad[6]:ARRAY OF CHAR
ENDOBJECT

OBJECT mailHeader
  status: CHAR
  msgNumb: LONG
  toName[31]: ARRAY OF CHAR
  fromName[31]: ARRAY OF CHAR
  subject[31]: ARRAY OF CHAR
  msgDate: LONG
  recv: LONG
  pad: CHAR
ENDOBJECT

PROC exec(fileName:PTR TO CHAR)
  DEF tags,r
  tags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,NIL]:LONG
  r:=SystemTagList(fileName,tags)
  IF r=-1
    WriteF('Error executing \s\n\n',fileName)
  ENDIF
  END tags
ENDPROC r

PROC replacestr(sourcestring,searchtext,replacetext)
  DEF newstring,tempstring,oldpos, pos,len
  newstring:=String(255)
  tempstring:=String(255)
  len:=StrLen(searchtext) /* not estrlen since this is likely to be a hard coded constant */
  pos:=InStr(sourcestring,searchtext)
  IF pos<>-1
    oldpos:=0
    WHILE pos<>-1
      IF pos<>oldpos
        MidStr(tempstring,sourcestring,oldpos,pos-oldpos)
        StrAdd(newstring,tempstring)
      ENDIF
      StrAdd(newstring,replacetext)
      pos:=pos+len
      oldpos:=pos
      pos:=InStr(sourcestring,searchtext,oldpos)
    ENDWHILE
    pos:=EstrLen(sourcestring)
    IF pos<>oldpos
      MidStr(tempstring,sourcestring,oldpos,pos-oldpos)
      StrAdd(newstring,tempstring)
    ENDIF
    StrCopy(sourcestring,newstring)
  ENDIF
  DisposeLink(newstring)
  DisposeLink(tempstring)
ENDPROC

PROC trimRight(src:PTR TO CHAR,dest:PTR TO CHAR)
  DEF n,v=0
  StrCopy(dest,src)
  n:=EstrLen(dest)
  IF n>0 THEN v:=dest[n-1]
  WHILE (n>0) AND (v=" ")
    SetStr(dest,n-1)
    n:=EstrLen(dest)
    IF n>0 THEN v:=dest[n-1]
  ENDWHILE
ENDPROC

PROC fillStrCopy(src:PTR TO CHAR,dest:PTR TO CHAR,len)
  DEF i
  FOR i:=0 TO len-1
    dest[i]:=0
  ENDFOR
  AstrCopy(dest,src,len)
ENDPROC

PROC saveMh(fh,mailHeader)
  DEF result
  
  result:=Write(fh,mailHeader,1)    -> STATUS
  result:=result+Write(fh,mailHeader+110,1)   ->PAD
  result:=result+Write(fh,mailHeader+2,4)   ->MsgNum
  result:=result+Write(fh,mailHeader+6,31)   ->toName
  result:=result+Write(fh,mailHeader+38,31)   ->fromName
  result:=result+Write(fh,mailHeader+70,31)   ->subject
  result:=result+Write(fh,mailHeader+110,1)   ->PAD
  result:=result+Write(fh,mailHeader+102,9)  ->msgdate, recv & pad
  result:=result+Write(fh,mailHeader+110,1)   ->PAD
ENDPROC result

PROC getMsgBasePath(confNum,msgBasePath:PTR TO CHAR)
  DEF i
  FOR i:=0 TO confIds.count()-1
    IF Val(confIds.item(i))=confNum
      StrCopy(msgBasePath,msgBasePaths.item(i),ALL)
    ENDIF
  ENDFOR
ENDPROC

PROC createMessageDat2(confNum,msgDatFilename:PTR TO CHAR, srcFilename:PTR TO CHAR)
  DEF fh,fh2
  DEF tempStr[255]:STRING
  DEF fromName[255]:STRING
  DEF toName[255]:STRING
  DEF subject[255]:STRING
  DEF msgDateTime[255]:STRING
  DEF msgDate[10]:STRING
  DEF msgTime[10]:STRING
  DEF msgId[20]:STRING
  DEF msgbuf, msgsz,bufsz
  DEF status,p,i
  fh:=Open(msgDatFilename,MODE_READWRITE)
  
  IF fh>0
    Seek(fh,0,OFFSET_END)
    IF Seek(fh,0,OFFSET_CURRENT)=0
      StringF(tempStr,'\l\s[128]',bbsId,'')
      Write(fh,tempStr,128)      
    ENDIF
    
    fh2:=Open(srcFilename,MODE_OLDFILE)
    IF fh2>0
    
      ReadStr(fh2,fromName)
      ReadStr(fh2,toName)
      ReadStr(fh2,subject)
      ReadStr(fh2,msgDateTime)
      ReadStr(fh2,msgId)
    
      p:=Seek(fh2,0,OFFSET_END)
      msgsz:=Seek(fh2,p,OFFSET_BEGINNING)-p
      
      bufsz:=(msgsz+127)/128*128
      msgbuf:=New(bufsz)
      Read(fh2,msgbuf,msgsz)
      FOR i:=msgsz TO bufsz-1 DO msgbuf[i]:=32
      Close(fh2)

      status:=" "
      StrCopy(msgDate,msgDateTime,8)
      IF (p:=InStr(msgDateTime,' '))>=0
        StrCopy(msgTime,msgDateTime+p+1,5)
      ELSE
        StrCopy(msgTime,'')
      ENDIF
      
      StringF(tempStr,'\c\l\d[7]\l\s[8]\l\s[5]\l\s[25]\l\s[25]\l\s[25]                    \l\d[6]\c     ',status,confNum,
          msgDate,msgTime,toName,fromName,subject,(bufsz/128)+1,$E1)
      tempStr[123]:=confNum AND $FF
      tempStr[124]:=Shr(confNum,8) AND $FF
      tempStr[125]:=msgNum AND $FF
      tempStr[126]:=Shr(msgNum,8) AND $FF
      
      Write(fh,tempStr,128)
      msgNum++
      
      Write(fh,msgbuf,bufsz)

      Dispose(msgbuf)
    ENDIF
    Close (fh)
  ENDIF
ENDPROC

PROC createMessagesDat(msgFilename:PTR TO CHAR)
  DEF i
  DEF msgOutPath[255]:STRING
  DEF fBlock:PTR TO fileinfoblock
  DEF fLock
  DEF msgFile[255]:STRING
  DEF confNum

  IF(fBlock:=AllocDosObject(DOS_FIB,NIL))
    FOR i:=0 TO confIds.count()-1
      confNum:=Val(confIds.item(i))
      StringF(msgOutPath,'\sEXT-OUT',msgBasePaths.item(i))
      IF(fLock:=Lock(msgOutPath,ACCESS_READ))
        IF(Examine(fLock,fBlock))
          WHILE(ExNext(fLock,fBlock))
            StringF(msgFile,'\s/\s',msgOutPath,fBlock.filename)
            createMessageDat2(confNum,msgFilename,msgFile)
            SetProtection(msgFile,FIBF_OTR_DELETE)
            DeleteFile(msgFile)
          ENDWHILE
        ENDIF
        UnLock(fLock)
              
      ENDIF
    ENDFOR
    FreeDosObject(DOS_FIB,fBlock)
  ENDIF

ENDPROC

PROC fileWriteLn(fh,str: PTR TO CHAR)
  DEF stat
  IF (stat:=fileWrite(fh,str))<>RESULT_SUCCESS THEN RETURN stat
ENDPROC fileWrite(fh,'\n')

PROC fileWrite(fh,str: PTR TO CHAR)
  DEF s

  s:=Write(fh,str,StrLen(str))
  IF s<>StrLen(str) THEN RETURN RESULT_FAILURE
ENDPROC RESULT_SUCCESS

PROC formatLongDateTime2(cDateVal,outDateStr,seperatorChar)
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

PROC createControlDat(controlFilename:PTR TO CHAR)
  DEF fo,conf
  DEF tempstr[255]:STRING
  
  fo:=Open(controlFilename,MODE_NEWFILE)
  IF(fo=0)
    RETURN 0
  ENDIF
  
  fileWriteLn(fo,bbsName)
  fileWriteLn(fo,bbsLocation)
  fileWriteLn(fo,bbsNumber)
  StringF(tempstr,'\s, Sysop',sysopName)
  fileWriteLn(fo,tempstr)

  StringF(tempstr,'000000,\s',bbsId)
  fileWriteLn(fo,tempstr)
  
  formatLongDateTime2(getSystemTime(),tempstr,",")
  fileWriteLn(fo,tempstr)
  
  fileWriteLn(fo,userName)
  
  fileWriteLn(fo,'')
  fileWriteLn(fo,'0')
  fileWriteLn(fo,'0')

  StringF(tempstr,'\d\b\n',confIds.count())
  fileWrite(fo,tempstr)
  FOR conf:=0 TO confIds.count()-1
    StringF(tempstr,'\s\b\n',confIds.item(conf))
    fileWrite(fo,tempstr)
    StringF(tempstr,'\s',confNames.item(conf))
    IF StrLen(tempstr)>10 THEN SetStr(tempstr,10)
    StrAdd(tempstr,'\b\n')
    fileWrite(fo,tempstr)
  ENDFOR
  fileWrite(fo,'HELLO\b\n')
  fileWrite(fo,'NEWS\b\n')
  fileWrite(fo,'GOODBYE\b\n')
  Close(fo)
ENDPROC

->returns system time converted to c time format
PROC getSystemTime()
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


PROC getEncodedDate(dateStr:PTR TO CHAR)
  DEF dt:datetime
  DEF strDate[20]:STRING
  DEF strTime[20]:STRING
  DEF dval

  
  StrCopy(strDate,dateStr,8)
  StrCopy(strTime,dateStr+8,5)
  StrAdd(strTime,':00')

  dt.format:=FORMAT_USA
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=strDate
  dt.strtime:=strTime

  IF StrToDate(dt)=0 THEN RETURN 0

  dval:=Mul(Mul(dt.stamp.days+2922,1440),60)+(dt.stamp.minute*60)+(dt.stamp.tick/50)

  ->2922 days between 1/1/70 and 1/1/78

ENDPROC dval+21600

PROC trimStr(src:PTR TO CHAR)
  DEF i
  DEF tempStr[255]:STRING
  
  StrCopy(tempStr,TrimStr(src))

  i:=EstrLen(tempStr)-1
  WHILE (i>=0)
    IF tempStr[i]<>" "
      i:=-1
    ELSE
      SetStr(tempStr,i)
      i--
    ENDIF
  ENDWHILE

  StrCopy(src,tempStr)
ENDPROC

PROC processConfigLine(inString,categoryStr,optName,optValue)
  DEF t[255]:STRING
  DEF l
  StrCopy(t,inString)
  trimStr(t)
  l:=EstrLen(t)
  IF l>1
    IF (t[0]="[") AND (t[l-1]="]")
      StrCopy(categoryStr,t+1,l-2)
      trimStr(categoryStr)
      UpperStr(categoryStr)
      StrCopy(optName,'')
      StrCopy(optValue,'')
      RETURN
    ENDIF
  ENDIF
  l:=InStr(t,'=')
  IF l>0
    StrCopy(optName,t,l)
    trimStr(optName)
    UpperStr(optName)
    StrCopy(optValue,t+l+1,ALL)
    trimStr(optValue)
  ELSE
    StrCopy(optName,'')
    StrCopy(optValue,'')
  ENDIF
ENDPROC

PROC main() HANDLE
  DEF qh: qwkHeader
  DEF ms: mailStat
  DEF mh: mailHeader
  DEF buf=0:PTR TO CHAR
  DEF buf2=0:PTR TO CHAR,bufsz
  DEF mf=0,fh=0,fh2=0
  DEF n,c,i
  DEF tempStr[255]:STRING
  DEF newMsgNum
  DEF fname[255]:STRING
  DEF msgBase[255]:STRING
  DEF qwkConfId
  DEF lastConfId=-1
  DEF mode[255]:STRING
  DEF qwkFilename[255]:STRING
  DEF qwkGetCommand[255]:STRING
  DEF qwkPutCommand[255]:STRING
  DEF qwkPackCommand[255]:STRING
  DEF qwkUnpackCommand[255]:STRING
  DEF qwkMessageFilename[255]:STRING
  DEF qwkControlFilename[255]:STRING
  DEF qwkRepMessageFilename[255]:STRING
  DEF qwkOutputFilename[255]:STRING
  DEF cfgFile[255]:STRING
  DEF needToSave
  DEF myargs:PTR TO LONG,rdargs

  DEF category[255]:STRING
  DEF optionName[255]:STRING
  DEF optionValue[255]:STRING

  WriteF('Ami-Express QWK file processor Copyright 2020 Darren Coles\n')
  
  myargs:=[0,0]:LONG
  IF rdargs:=ReadArgs('CFG/A',myargs,NIL)
    IF myargs[0]<>NIL 
      AstrCopy(cfgFile,myargs[0],255)
    ENDIF
    FreeArgs(rdargs)
  ELSE
    RETURN
  ENDIF
  
  confIds:=NEW confIds.stringlist(100)
  confNames:=NEW confNames.stringlist(100)
  msgBasePaths:=NEW msgBasePaths.stringlist(100)

  fh:=Open(cfgFile,MODE_OLDFILE)
  IF fh>0
  
    REPEAT
      ReadStr(fh,tempStr)
      processConfigLine(tempStr,category,optionName,optionValue)

      IF StrCmp('MAIN',category) AND StrCmp('MODE',optionName) THEN StrCopy(mode,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('BBSNAME',optionName) THEN StrCopy(bbsName,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('BBSLOCATION',optionName) THEN StrCopy(bbsLocation,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('BBSNUMBER',optionName) THEN StrCopy(bbsNumber,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('BBSID',optionName) THEN StrCopy(bbsId,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('SYSOPNAME',optionName) THEN StrCopy(sysopName,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('USERNAME',optionName) THEN StrCopy(userName,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('GETCMD',optionName) THEN StrCopy(qwkGetCommand,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('PUTCMD',optionName) THEN StrCopy(qwkPutCommand,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('UNPACKCMD',optionName) THEN StrCopy(qwkUnpackCommand,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('PACKCMD',optionName) THEN StrCopy(qwkPackCommand,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('PACKEDTEMP',optionName) THEN StrCopy(qwkFilename,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('MSGTEMP',optionName) THEN StrCopy(qwkMessageFilename,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('CONTROLTEMP',optionName) THEN StrCopy(qwkControlFilename,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('MSGFILE',optionName) THEN StrCopy(qwkRepMessageFilename,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('REPFILE',optionName) THEN StrCopy(qwkOutputFilename,optionValue)

    UNTIL StrCmp(category,'CONFS')
    UpperStr(mode)

    replacestr(qwkGetCommand,'{bbsid}',bbsId)
    replacestr(qwkPutCommand,'{bbsid}',bbsId)
    replacestr(qwkUnpackCommand,'{bbsid}',bbsId)
    replacestr(qwkPackCommand,'{bbsid}',bbsId)
    replacestr(qwkFilename,'{bbsid}',bbsId)
    replacestr(qwkMessageFilename,'{bbsid}',bbsId)
    replacestr(qwkControlFilename,'{bbsid}',bbsId)
    replacestr(qwkRepMessageFilename,'{bbsid}',bbsId)
    replacestr(qwkOutputFilename,'{bbsid}',bbsId)

    WHILE(ReadStr(fh,tempStr)<>-1) OR (StrLen(tempStr)>0)
      confIds.add(tempStr)
      ReadStr(fh,tempStr)
      confNames.add(tempStr)
      ReadStr(fh,tempStr)
      msgBasePaths.add(tempStr)
    ENDWHILE
    Close(fh)
    fh:=0
  ELSE
    WriteF('Error opening Qwk.cfg\n\n')
    Raise(ERR_NOCFG)
  ENDIF
  
  IF StrCmp(mode,'OUT') OR StrCmp(mode,'BOTH')
    WriteF('Processing outgoing messages\n')
    IF FileLength(qwkOutputFilename)=-1
      ->no qwk output file so create item
      
      msgNum:=1
      
      DeleteFile(qwkRepMessageFilename)
      DeleteFile(qwkControlFilename)
      
      ->create messages.dat by scraping confs
      createMessagesDat(qwkRepMessageFilename)
      
      createControlDat(qwkControlFilename)
      
      IF FileLength(qwkRepMessageFilename)<>-1
        exec(qwkPackCommand)
        
        IF FileLength(qwkOutputFilename)=-1
          WriteF('Error packing qwk file\n\n')
          Raise(ERR_QWK_PACK)
        ENDIF
      ENDIF
      DeleteFile(qwkRepMessageFilename)
      DeleteFile(qwkControlFilename)
    ELSE
      WriteF('Processing already existing qwk output file (\s)\n\n',qwkOutputFilename)     
    ENDIF

    IF FileLength(qwkOutputFilename)<>-1
      IF exec(qwkPutCommand)=0
        DeleteFile(qwkOutputFilename)
      ELSE
        WriteF('Failure when sending qwk file to remote server\n\n')
      ENDIF
    ELSE
      WriteF('No messages to post\n\n')
    ENDIF
  ENDIF
  
  IF StrCmp(mode,'IN') OR StrCmp(mode,'BOTH')
    WriteF('Processing incoming messages\n')

    IF FileLength(qwkFilename)=-1
      ->no qwk file to process so grab a new one
      
      exec(qwkGetCommand)
      IF FileLength(qwkFilename)=-1
        WriteF('No qwk file to process\n\n')
        Raise(ERR_QWK_GRAB)
      ENDIF
      
    ELSE
      WriteF('Processing already existing qwk file (\s)\n\n',qwkFilename)
    ENDIF

    DeleteFile(qwkMessageFilename)
    exec(qwkUnpackCommand)     

    IF FileLength(qwkMessageFilename)=-1
      WriteF('Error unpacking qwk file\n\n')
      Raise(ERR_QWK_UNPACK)
    ENDIF
    DeleteFile(qwkFilename)
       
    needToSave:=FALSE
    mf:=Open(qwkMessageFilename,MODE_OLDFILE)
    IF mf>0
      Seek(mf,128,OFFSET_BEGINNING)
      buf:=New(128)
      c:=0
      REPEAT
        n:=Read(mf,buf,128)
        IF n>0
          qh.status:=buf[0]
          StrCopy(tempStr,buf+1,7)
          qh.num:=Val(tempStr)
          AstrCopy(qh.msgdate,buf+8,14)
          AstrCopy(qh.to,buf+21,26)
          AstrCopy(qh.from,buf+46,26)
          AstrCopy(qh.subject,buf+71,26)
          AstrCopy(qh.password,buf+96,13)
          StrCopy(tempStr,buf+108,8)
          qh.inReplyTo:=Val(tempStr)
          StrCopy(tempStr,buf+116,8)
          qh.blockCount:=Val(tempStr)
          qh.active:=buf[122]
          qh.confNum:=buf[123]+(256*buf[124])
          qh.relativeMsgNum:=buf[125]+(256*buf[126])
          qh.netTag:=buf[127]
          bufsz:=128*(qh.blockCount-1)
          WriteF('id: \d\n',c)
          WriteF('message: \d\n',qh.num)
          WriteF('conf: \d\n',qh.confNum)
          WriteF('to: \s\n',qh.to)
          WriteF('from: \s\n',qh.from)
          WriteF('subject: \s\n',qh.subject)
          WriteF('\n')
          
          IF qh.confNum<>lastConfId 

            IF fh>0
              Close(fh)
              fh:=0
            ENDIF
            IF needToSave
              ms.highMsgNum:=newMsgNum+1
              StringF(fname,'\sMailStats',msgBase)
              fh:=Open(fname,MODE_NEWFILE)
              IF fh>0
                Write(fh,ms,SIZEOF mailStat)
                Close(fh)
                fh:=0
              ELSE
                WriteF('Error saving MailStats\n\n')
                Raise(ERR_WRITE_MAILSTAT)
              ENDIF
              needToSave:=FALSE
            ENDIF

            getMsgBasePath(qh.confNum,msgBase)
            IF StrLen(msgBase)=0
              WriteF('Qwk conf \d not configured, skipping messages for this conf\n\n',qh.confNum)
              qwkConfId:=-1
            ELSE
              qwkConfId:=qh.confNum

              StringF(fname,'\sMailStats',msgBase)
              IF fh>0 THEN Close(fh)
              fh:=Open(fname,MODE_READWRITE)
              IF fh>0
                IF Read(fh,ms,SIZEOF mailStat)=0
                  ms.lowestKey:=1
                  ms.lowestNotDel:=1
                  ms.highMsgNum:=1
                  ms.pad[0]:=0;ms.pad[1]:=0;ms.pad[2]:=0;ms.pad[3]:=0;ms.pad[4]:=0;ms.pad[5]:=0
                  Write(fh,ms,SIZEOF mailStat)
                  Close(fh)
                  fh:=0
                ELSE
                  Close(fh)
                  fh:=0
                ENDIF
              ELSE
                WriteF('Error opening MailStats (\s)\n\n',fname)
                Raise(ERR_READ_MAILSTAT)
              ENDIF
              
              newMsgNum:=ms.highMsgNum-1
              StringF(fname,'\sHeaderFile',msgBase)
              fh:=Open(fname,MODE_READWRITE)
              IF fh>0
                Seek(fh,0,OFFSET_END)
              ELSE
                WriteF('Error opening HeaderFile\n\n')
                Raise(ERR_READ_HEADERFILE)
              ENDIF

            ENDIF
            
          ENDIF
          
          lastConfId:=qh.confNum
          
          IF qh.confNum=qwkConfId
            newMsgNum++

            buf2:=New(bufsz)
            Read(mf,buf2,bufsz)
     
            mh.pad:=0
            mh.status:="P"
            mh.msgNumb:=newMsgNum
         
            trimRight(qh.to,tempStr)
            fillStrCopy(tempStr,mh.toName,31)

            trimRight(qh.from,tempStr)
            fillStrCopy(tempStr,mh.fromName,31)

            trimRight(qh.subject,tempStr)
            fillStrCopy(tempStr,mh.subject,31)

            mh.msgDate:=getEncodedDate(qh.msgdate)
            mh.recv:=0

            IF saveMh(fh,mh)<>110
              WriteF('Error saving mail header for message \d\n',newMsgNum)
            ENDIF
            
            needToSave:=TRUE
            
            StringF(fname,'\s\d',msgBase,newMsgNum)
            fh2:=Open(fname,MODE_NEWFILE)
            IF fh2>0
              FOR i:=0 TO bufsz-1
                IF buf2[i]=$e3 THEN buf2[i]:=10
              ENDFOR
              Write(fh2,buf2,bufsz)
              Close(fh2)
              fh2:=0
            ELSE
              WriteF('Error saving message body for message \d\n\n',newMsgNum)
            ENDIF
            Dispose(buf2)
            buf2:=0
          ELSE
            Seek(mf,bufsz,OFFSET_CURRENT)
          ENDIF
        ENDIF
        c++
      UNTIL (n=0) OR (CtrlC())
      
      Close(fh)
      fh:=0
     
      IF needToSave
        ms.highMsgNum:=newMsgNum+1
        StringF(fname,'\sMailStats',msgBase)
        fh:=Open(fname,MODE_NEWFILE)
        IF fh>0
          Write(fh,ms,SIZEOF mailStat)
          Close(fh)
          fh:=0
        ELSE
          WriteF('Error saving MailStats\n\n')
          Raise(ERR_WRITE_MAILSTAT)
        ENDIF
        needToSave:=FALSE
      ENDIF

      IF mf>0 THEN Close(mf)
      mf:=0
      DeleteFile(qwkMessageFilename)
       
    ELSE
      WriteF('Error opening MESSAGES.DAT\n\n')
      Raise(ERR_READ_MESSAGES_DAT)
    ENDIF
  ENDIF

EXCEPT DO
  IF confIds<>NIL THEN END confIds
  IF confNames<>NIL THEN END confNames
  IF msgBasePaths<>NIL THEN END msgBasePaths
  IF fh>0 THEN Close(fh)
  IF fh2>0 THEN Close(fh2)
  IF mf>0 THEN Close(mf)
  IF buf<>0 THEN Dispose(buf)
  IF buf2<>0 THEN Dispose(buf2)
ENDPROC