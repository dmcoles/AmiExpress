
  MODULE 'dos/dos','dos/dostags','dos/datetime'
  MODULE '*stringlist','*axobjects'

#ifndef EVO_3_4_0
  FATAL 'This should only be compiled with E-VO Amiga E Compiler'
#endif

  DEF confNames=NIL:PTR TO stringlist
  DEF msgBasePaths=NIL:PTR TO stringlist

  ENUM ERR_NOCFG,ERR_WRITE_MAILSTAT,ERR_READ_MESSAGES_DAT,ERR_READ_MAILSTAT,ERR_READ_HEADERFILE

  CONST RESULT_SUCCESS=-1,RESULT_FAILURE=0

OBJECT ftnHeader
  msgdate[21]:ARRAY OF CHAR
  to[37]:ARRAY OF CHAR
  from[37]:ARRAY OF CHAR
  subject[73]:ARRAY OF CHAR
  confId[255]:ARRAY OF CHAR
ENDOBJECT

PROC exec(fileName:PTR TO CHAR)
  DEF r
  r:=SystemTagList(fileName,[SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,NIL]:LONG)
  IF r=-1
    WriteF('Error executing \s\n\n',fileName)
  ENDIF
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
  DEF result,size

  size:=SIZEOF mailHeader
  result:=Write(fh,mailHeader,size)
ENDPROC result

PROC getMsgBasePath(confName,msgBasePath:PTR TO CHAR)
  DEF i
  FOR i:=0 TO confNames.count()-1
    IF StrCmp(confNames.item(i),confName)
      StrCopy(msgBasePath,msgBasePaths.item(i),ALL)
    ENDIF
  ENDFOR
ENDPROC

PROC createMessagePacket(originNode,destNode,originNet,destNet,originZone,destZone,originPoint,destPoint,attr,cost,packetPass:PTR TO CHAR,msgPktFileHandle, srcFilename:PTR TO CHAR,confId:PTR TO CHAR,tearLine:PTR TO CHAR, originLine:PTR TO CHAR,tzOffset:PTR TO CHAR)
  DEF fh2
  DEF tempStr[255]:STRING
  DEF fromName[255]:STRING
  DEF toName[255]:STRING
  DEF subject[255]:STRING
  DEF msgDateTime[255]:STRING
  DEF msgbuf:PTR TO CHAR, msgsz
  DEF mhdr[14]:ARRAY OF CHAR
  DEF null[1]:ARRAY OF CHAR
  DEF phdr[58]:ARRAY OF CHAR
  DEF status,p,i
  DEF year,month,day,hour,minute,second
  DEF monthCodes[40]:STRING
  DEF msgId[10]:STRING
  DEF originStr[100]:STRING
  
  IF originPoint<>0
    StringF(originStr,'\d:\d/\d.\d',originZone,originNet,originNode,originPoint)
  ELSE
    StringF(originStr,'\d:\d/\d',originZone,originNet,originNode)
  ENDIF
  
  formatLongDateTime2(getSystemTime(),msgDateTime,",")
  StrCopy(tempStr,msgDateTime,2)
  month:=Val(tempStr)
  StrCopy(tempStr,msgDateTime+3,2)
  day:=Val(tempStr)
  StrCopy(tempStr,msgDateTime+6,2)
  year:=Val(tempStr)
  IF year<38 THEN year:=year+2000 ELSE year:=year+1900
  StrCopy(tempStr,msgDateTime+9,2)
  hour:=Val(tempStr)
  StrCopy(tempStr,msgDateTime+12,2)
  minute:=Val(tempStr)
  StrCopy(tempStr,msgDateTime+15,2)
  second:=Val(tempStr)
  
  IF msgPktFileHandle>0
    IF Seek(msgPktFileHandle,0,OFFSET_CURRENT)=0
      
      ->create packet header
      phdr[0]:=originNode AND 255
      phdr[1]:=Shr(originNode,8) AND 255
      phdr[2]:=destNode AND 255
      phdr[3]:=Shr(destNode,8) AND 255
      phdr[4]:=year AND 255
      phdr[5]:=Shr(year,8) AND 255
      phdr[6]:=month AND 255
      phdr[7]:=Shr(month,8) AND 255
      phdr[8]:=day AND 255
      phdr[9]:=Shr(day,8) AND 255
      phdr[10]:=hour AND 255
      phdr[11]:=Shr(hour,8) AND 255
      phdr[12]:=minute AND 255
      phdr[13]:=Shr(minute,8) AND 255
      phdr[14]:=second AND 255
      phdr[15]:=Shr(second,8) AND 255
      phdr[16]:=0 ->baud low
      phdr[17]:=0 ->baud hi
      phdr[18]:=2 ->type
      phdr[19]:=0 ->type
      phdr[20]:=originNet AND 255
      phdr[21]:=Shr(originNet,8) AND 255
      phdr[22]:=destNet AND 255
      phdr[23]:=Shr(destNet,8) AND 255
      phdr[24]:=0 ->prodCode
      phdr[25]:=1 ->prodVersionMajor
      phdr[26]:=0;phdr[27]:=0;phdr[28]:=0;phdr[29]:=0; ->password
      phdr[30]:=0;phdr[31]:=0;phdr[32]:=0;phdr[33]:=0; ->password
      AstrCopy(phdr+26,packetPass,9)
      phdr[34]:=originZone AND 255
      phdr[35]:=Shr(originZone,8) AND 255
      phdr[36]:=destZone AND 255
      phdr[37]:=Shr(destZone,8) AND 255
      phdr[38]:=0 ->reserved
      phdr[39]:=0 ->reserved
      phdr[40]:=0 ->capvalid
      phdr[41]:=1 ->capvalid
      phdr[42]:=1 ->prodcodehi
      phdr[43]:=0 ->prodversionminor
      phdr[44]:=1 ->capword
      phdr[45]:=0 ->capword
      phdr[46]:=originZone AND 255
      phdr[47]:=Shr(originZone,8) AND 255
      phdr[48]:=destZone AND 255
      phdr[49]:=Shr(destZone,8) AND 255
      phdr[50]:=originPoint AND 255
      phdr[51]:=Shr(originPoint,8) AND 255
      phdr[52]:=destPoint AND 255
      phdr[53]:=Shr(destPoint,8) AND 255
      phdr[54]:=0
      phdr[55]:=0
      phdr[56]:=0
      phdr[57]:=0
      
      ->write packet header
      Write(msgPktFileHandle,phdr,58)      
    ENDIF
    
    fh2:=Open(srcFilename,MODE_OLDFILE)
    IF fh2<>0
    
      ReadStr(fh2,fromName)
      IF EstrLen(fromName)>35 THEN SetStr(fromName,35)
      ReadStr(fh2,toName)
      IF EstrLen(toName)>35 THEN SetStr(toName,35)
      ReadStr(fh2,subject)
      IF EstrLen(subject)>71 THEN SetStr(toName,71)
      ReadStr(fh2,msgDateTime)
      ReadStr(fh2,msgId)
    
      p:=Seek(fh2,0,OFFSET_END)
      msgsz:=Seek(fh2,p,OFFSET_BEGINNING)-p
      
      msgbuf:=New(msgsz)
      Read(fh2,msgbuf,msgsz)
      Close(fh2)

      status:=" "

      ->write message header
      mhdr[0]:=2
      mhdr[1]:=0
      mhdr[2]:=originNode AND 255
      mhdr[3]:=Shr(originNode,8) AND 255
      mhdr[4]:=destNode AND 255
      mhdr[5]:=Shr(destNode,8) AND 255
      mhdr[6]:=originNet AND 255
      mhdr[7]:=Shr(originNet,8) AND 255
      mhdr[8]:=destNet AND 255
      mhdr[9]:=Shr(destNet,8) AND 255
      mhdr[10]:=attr AND 255
      mhdr[11]:=Shr(attr,8) AND 255
      mhdr[12]:=cost AND 255
      mhdr[13]:=Shr(cost,8) AND 255
      Write(msgPktFileHandle,mhdr,14)

      null[0]:=0

      StrCopy(monthCodes,'JanFebMarAprMayJunJulAugSepOctNovDec')
      StrCopy(tempStr,msgDateTime,2)
      month:=Val(tempStr)-1
      
      StringF(tempStr,'\s[2] \s[3] \s[2]  \s[2]:\s[2]:\s[2]',msgDateTime+3,monthCodes+(month*3),msgDateTime+6,msgDateTime+9,msgDateTime+12,msgDateTime+15)
      Write(msgPktFileHandle,tempStr,19)
      Write(msgPktFileHandle,null,1)
      
      Write(msgPktFileHandle,toName,EstrLen(toName))
      Write(msgPktFileHandle,null,1)

      Write(msgPktFileHandle,fromName,EstrLen(fromName))
      Write(msgPktFileHandle,null,1)

      Write(msgPktFileHandle,subject,EstrLen(subject))
      Write(msgPktFileHandle,null,1)

      StringF(tempStr,'AREA:\s\b',confId)
      Write(msgPktFileHandle,tempStr,EstrLen(tempStr))

      StringF(tempStr,'\cCHRS: LATIN-1 2\b',1)
      Write(msgPktFileHandle,tempStr,EstrLen(tempStr))

      IF StrLen(msgId)>0
        StringF(tempStr,'\cMSGID: \s \z\h[8]\b',1,originStr,Val(msgId))
        Write(msgPktFileHandle,tempStr,EstrLen(tempStr))
      ENDIF

      StringF(tempStr,'\cTZUTC: \s\b',1,IF StrLen(tzOffset)=0 THEN '0000' ELSE tzOffset)
      Write(msgPktFileHandle,tempStr,EstrLen(tempStr))

      FOR i:=0 TO msgsz-1
        IF msgbuf[i]=10 THEN msgbuf[i]:=13
      ENDFOR
      
      ->write tear line
      StringF(tempStr,'--- \s\b',tearLine)
      Write(msgPktFileHandle,tempStr,EstrLen(tempStr))

      ->write origin line
      StringF(tempStr,'  * Origin: \s (\s)\b',originLine,originStr)
      Write(msgPktFileHandle,tempStr,EstrLen(tempStr))
      
      ->write seen by line
      StringF(tempStr,'SEEN-BY: \d/\d \d/\d\b',originNet,originNode,destNet,destNode)
      Write(msgPktFileHandle,tempStr,EstrLen(tempStr))
      
      StringF(tempStr,'\cPATH: \d/\d\b',1,originNet,originNode)
      Write(msgPktFileHandle,tempStr,EstrLen(tempStr))
      
      ->nul terminate
      StrCopy(tempStr,'')
      Write(msgPktFileHandle,tempStr,1)
      
      Dispose(msgbuf)
    ENDIF
  ENDIF
ENDPROC

PROC createMessagesBundle(originNode,destNode,originNet,destNet,originZone,destZone,originPoint,destPoint,attr,cost,packetPass,msgFilename:PTR TO CHAR,tearLine:PTR TO CHAR, originLine:PTR TO CHAR,tzOffset:PTR TO CHAR)
  DEF i,fh=0
  DEF msgOutPath[255]:STRING
  DEF fBlock:PTR TO fileinfoblock
  DEF fLock
  DEF msgFile[255]:STRING
  DEF null[2]:ARRAY OF CHAR

  IF(fBlock:=AllocDosObject(DOS_FIB,NIL))
    FOR i:=0 TO msgBasePaths.count()-1
      StringF(msgOutPath,'\sEXT-OUT',msgBasePaths.item(i))
      IF(fLock:=Lock(msgOutPath,ACCESS_READ))
        IF(Examine(fLock,fBlock))
          WHILE(ExNext(fLock,fBlock))
            StringF(msgFile,'\s/\s',msgOutPath,fBlock.filename)
            
            IF fh=0
              fh:=Open(msgFilename,MODE_READWRITE)
              IF fh<>0 THEN Seek(fh,-2,OFFSET_END)
            ENDIF
            
            IF fh>0
              createMessagePacket(originNode,destNode,originNet,destNet,originZone,destZone,originPoint,destPoint,attr,cost,packetPass,fh,msgFile,confNames.item(i),tearLine,originLine,tzOffset)
              SetProtection(msgFile,FIBF_OTR_DELETE)
              DeleteFile(msgFile)
            ENDIF
          ENDWHILE
        ENDIF
        UnLock(fLock)
              
      ENDIF
    ENDFOR
    FreeDosObject(DOS_FIB,fBlock)
  ENDIF 

  IF fh>0
    null[0]:=0
    null[1]:=0
    Write(fh,null,2)
    Close(fh)
  ENDIF
ENDPROC

PROC formatLongDateTime2(cDateVal,outDateStr,seperatorChar)
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
  DEF tempStr[30]:STRING
  DEF strDate[20]:STRING
  DEF strTime[20]:STRING
  DEF dval

  
  StrCopy(strDate,TrimStr(dateStr),9)
  strDate[2]:="-"
  strDate[6]:="-"

  StrCopy(tempStr,dateStr)
  RightStr(strTime,tempStr,8)

  dt.format:=FORMAT_DOS
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=strDate
  dt.strtime:=strTime

  IF StrToDate(dt)=0 THEN RETURN 0

  dval:=Mul(Mul(dt.stamp.days+2922,1440),60)+(dt.stamp.minute*60)+(dt.stamp.tick/50)

  ->2922 days between 1/1/70 and 1/1/78

ENDPROC dval+21600

PROC readString(fileHandle,buffer,maxLength)
  DEF char,cnt,i
  
  cnt:=0
  FOR i:=0 TO maxLength-1 DO buffer[i]:=0
  
  REPEAT
    char:=FgetC(fileHandle)
    IF (char=-1) OR (char=0) THEN RETURN
    buffer[cnt]:=char
    cnt++
  UNTIL (cnt=maxLength)
ENDPROC

PROC findBodyLength(fileHandle)
  DEF cnt,char
  cnt:=0
  REPEAT
    char:=FgetC(fileHandle)
    IF char<>-1 THEN cnt++
  UNTIL char<=0
  Seek(fileHandle,-cnt,OFFSET_CURRENT)
ENDPROC cnt

PROC writeMailLine(fh2,lineBuff:PTR TO CHAR)
  DEF i,lineLen,ansi=FALSE
  DEF lastSpace,s,partlen
  
  IF (StrCmp(TrimStr(lineBuff),'SEEN-BY: ',9)=FALSE) AND (StrCmp(TrimStr(lineBuff),'AREA: ',6)=FALSE) AND (lineBuff[0]<>1)
    lineLen:=EstrLen(lineBuff)
    FOR i:=0 TO lineLen-1 DO IF lineBuff[i]=27 THEN ansi:=TRUE
    IF (ansi=FALSE) AND (lineLen>75)
      partlen:=0
      lastSpace:=-1
      s:=0
      FOR i:=0 TO lineLen-1
        IF lineBuff[i]=" " THEN lastSpace:=i
        IF partlen>=75
          IF lastSpace>=0
            lineBuff[lastSpace]:=10
            partlen:=i-lastSpace-1
            lastSpace:=-1
          ELSE
            Write(fh2,lineBuff+s,i-s)
            Write(fh2,'\n',1)
            s:=i
            partlen:=0
          ENDIF
        ENDIF
        partlen++
      ENDFOR
      StrAdd(lineBuff,'\n')
      Write(fh2,lineBuff+s,lineLen-s+1)
    ELSE
      StrAdd(lineBuff,'\n')
      Write(fh2,lineBuff,lineLen+1)
    ENDIF
  ENDIF
ENDPROC

PROC processPacketFile(filename:PTR TO CHAR) HANDLE
  DEF ftnh: ftnHeader
  DEF ms: mailStat
  DEF mh: mailHeader
  DEF buf=0:PTR TO CHAR
  DEF buf2=0:PTR TO CHAR,bufsz
  DEF mf=0,fh=0,fh2=0
  DEF n,c,i
  DEF tempStr[255]:STRING
  DEF lineBuff:PTR TO CHAR
  DEF newMsgNum
  DEF fname[255]:STRING
  DEF msgBase[255]:STRING
  DEF ftnConfId[255]:STRING
  DEF lastConfId[255]:STRING
  DEF needToSave
  DEF cnt,maxCnt

  needToSave:=FALSE
  StrCopy(lastConfId,'######')
  
  mf:=Open(filename,MODE_OLDFILE)
  IF mf<>0
    Seek(mf,58,OFFSET_BEGINNING)
    buf:=New(35)
    c:=0
    REPEAT
      n:=Fread(mf,buf,2,1)
      IF (buf[0]=2) AND (buf[1]=0)
        n:=Fread(mf,buf+2,32,1)
        buf[34]:=0
        IF n>0

          AstrCopy(ftnh.msgdate,buf+14,21)

          readString(mf,ftnh.to,36)
          readString(mf,ftnh.from,36)
          readString(mf,ftnh.subject,72)

          bufsz:=findBodyLength(mf)

          buf2:=New(bufsz+1)
          Fread(mf,buf2,bufsz,1)
          
          StrCopy(tempStr,'')
          n:=0
          WHILE (n<bufsz) AND (buf2[n]<>0) AND (buf2[n]<>10) AND (buf2[n]<>13)
            StrAdd(tempStr,buf2+n,1)
            n++
          ENDWHILE
          WHILE (n<bufsz) AND ((buf2[n]=0) OR (buf2[n]=10) OR (buf2[n]=13)) DO n++
          IF StrCmp(tempStr,'AREA:',5)
            AstrCopy(ftnh.confId,tempStr+5)
          ELSE
            AstrCopy(ftnh.confId,'')
          ENDIF

          WriteF('id: \d\n',c)
          WriteF('conf: \s\n',ftnh.confId)
          WriteF('to: \s\n',ftnh.to)
          WriteF('from: \s\n',ftnh.from)
          WriteF('subject: \s\n',ftnh.subject)
          WriteF('\n')
          
          UpperStr(ftnh.confId)

          IF StrCmp(ftnh.confId,lastConfId)=FALSE

            IF fh>0
              Close(fh)
              fh:=0
            ENDIF
            IF needToSave
              ms.highMsgNum:=newMsgNum+1
              StringF(fname,'\sMailStats',msgBase)
              fh:=Open(fname,MODE_NEWFILE)
              IF fh<>0
                Write(fh,ms,SIZEOF mailStat)
                Close(fh)
                fh:=0
              ELSE
                WriteF('Error saving MailStats\n\n')
                Raise(ERR_WRITE_MAILSTAT)
              ENDIF
              needToSave:=FALSE
            ENDIF

            getMsgBasePath(ftnh.confId,msgBase)
            IF StrLen(msgBase)=0
              WriteF('FTN conf \s not configured, skipping messages for this conf\n\n',ftnh.confId)
              StrCopy(ftnConfId,'######')
            ELSE
              StrCopy(ftnConfId,ftnh.confId)

              StringF(fname,'\sMailStats',msgBase)
              IF fh>0 THEN Close(fh)
              fh:=Open(fname,MODE_READWRITE)
              IF fh<>0
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
              IF fh<>0
                Seek(fh,0,OFFSET_END)
              ELSE
                WriteF('Error opening HeaderFile\n\n')
                Raise(ERR_READ_HEADERFILE)
              ENDIF

            ENDIF
            
          ENDIF
          
          StrCopy(lastConfId,ftnh.confId)
          
          IF StrCmp(ftnh.confId,ftnConfId)
            newMsgNum++
    
            mh.status:="P"
            mh.msgNumb:=newMsgNum
         
            trimRight(ftnh.to,tempStr)
            fillStrCopy(tempStr,mh.toName,31)

            trimRight(ftnh.from,tempStr)
            fillStrCopy(tempStr,mh.fromName,31)

            trimRight(ftnh.subject,tempStr)
            fillStrCopy(tempStr,mh.subject,31)

            mh.msgDate:=getEncodedDate(ftnh.msgdate)
            mh.recv:=0
            mh.extMsgNum:=0

            IF saveMh(fh,mh)<>110
              WriteF('Error saving mail header for message \d\n',newMsgNum)
            ENDIF
            
            needToSave:=TRUE
            
            StringF(fname,'\s\d',msgBase,newMsgNum)
            fh2:=Open(fname,MODE_NEWFILE)
            IF fh2<>0
              i:=n
              n:=0
              WHILE i<bufsz
                IF buf2[i]<>10
                  buf2[n]:=buf2[i]
                  n++
                ENDIF
                i++
              ENDWHILE
              FOR i:=0 TO n-1
                IF buf2[i]=13 THEN buf2[i]:=10
              ENDFOR
              
              StrCopy(tempStr,'')

              cnt:=0
              maxCnt:=0
              FOR i:=0 TO n-1
                IF buf2[i]=10
                  IF cnt>maxCnt THEN maxCnt:=cnt
                  cnt:=0
                ELSE 
                  cnt++
                ENDIF
              ENDFOR
              IF cnt>maxCnt THEN maxCnt:=cnt
              
              lineBuff:=String(maxCnt+1)
              i:=0
              WHILE (i<n)
                IF (buf2[i]<>10)
                  StrAdd(lineBuff,buf2+i,1)
                  i++
                ELSE
                  writeMailLine(fh2,lineBuff)
                  StrCopy(lineBuff,'')
                  i++
                ENDIF
              ENDWHILE
              IF StrLen(lineBuff)>0
                writeMailLine(fh2,lineBuff)
              ENDIF
              DisposeLink(lineBuff)
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
        n:=1
        c++
      ELSEIF (buf[0]=0) AND (buf[1]=0)
        ->double null indicates no more data
        n:=0
      ELSE
        WriteF('Error reading message header from \s invalid message type found\n\n',filename)
        Raise(ERR_READ_MESSAGES_DAT)
      ENDIF
    UNTIL (n=0) OR (CtrlC())
    
    Close(fh)
    fh:=0
   
    IF needToSave
      ms.highMsgNum:=newMsgNum+1
      StringF(fname,'\sMailStats',msgBase)
      fh:=Open(fname,MODE_NEWFILE)
      IF fh<>0
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
    RETURN TRUE
     
  ELSE
    WriteF('Error opening \s\n\n',filename)
    Raise(ERR_READ_MESSAGES_DAT)
  ENDIF
EXCEPT DO
  IF fh>0 THEN Close(fh)
  IF fh2>0 THEN Close(fh2)
  IF mf>0 THEN Close(mf)
  IF buf<>0 THEN Dispose(buf)
  IF buf2<>0 THEN Dispose(buf2)
ENDPROC

PROC processPackets(scanPath:PTR TO CHAR)
  DEF packetFilename[255]:STRING
  DEF fname[255]:STRING
  DEF fBlock:PTR TO fileinfoblock
  DEF tempStr[255]:STRING
  DEF fLock
  
  IF(fBlock:=AllocDosObject(DOS_FIB,NIL))
    IF(fLock:=Lock(scanPath,ACCESS_READ))

      IF(Examine(fLock,fBlock))
        WHILE(ExNext(fLock,fBlock))
          StrCopy(fname,fBlock.filename)
          RightStr(tempStr,fname,4)
          UpperStr(tempStr)
          IF StrCmp(tempStr,'.PKT')
            StringF(packetFilename,'\s\s',scanPath,fBlock.filename)
            IF processPacketFile(packetFilename)
              SetProtection(packetFilename,FIBF_OTR_DELETE)
              DeleteFile(packetFilename)
            ENDIF
          ENDIF
        ENDWHILE
      ENDIF
      UnLock(fLock)
    ENDIF
    FreeDosObject(DOS_FIB,fBlock)
  ENDIF
ENDPROC

PROC processBundles(unpackCommand:PTR TO CHAR, scanPath:PTR TO CHAR, tempDir:PTR TO CHAR)
  DEF cleanUp[255]:STRING
  DEF unpack[255]:STRING
  DEF fname[255]:STRING
  DEF fBlock:PTR TO fileinfoblock
  DEF tempStr[255]:STRING
  DEF bundleFilename[255]:STRING
  DEF fLock
  
  IF(fBlock:=AllocDosObject(DOS_FIB,NIL))
    IF(fLock:=Lock(scanPath,ACCESS_READ))

      IF(Examine(fLock,fBlock))
        WHILE(ExNext(fLock,fBlock))
          IF fBlock.direntrytype < 0
            StrCopy(fname,fBlock.filename)
            RightStr(tempStr,fname,4)
            UpperStr(tempStr)
            IF StrCmp(tempStr,'.PKT')=FALSE
              StringF(bundleFilename,'\s\s',scanPath,fBlock.filename)

              StrCopy(unpack,unpackCommand)
              replacestr(unpack,'{filename}',bundleFilename)
              exec(unpack)
              processPackets(tempDir)
              StringF(cleanUp,'delete \s ALL',tempDir)
              exec(cleanUp)

              SetProtection(bundleFilename,FIBF_OTR_DELETE)
              DeleteFile(bundleFilename)
            ENDIF
          ENDIF
        ENDWHILE
      ENDIF
      UnLock(fLock)
    ENDIF
    FreeDosObject(DOS_FIB,fBlock)
  ENDIF

  
  
ENDPROC

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
  DEF mode[255]:STRING
  DEF inboundDir[255]:STRING
  DEF inboundInsecureDir[255]:STRING
  DEF outboundDir[255]:STRING
  
  DEF ftnUnpackCommand[255]:STRING
  
  DEF tempDir[255]:STRING
 
 
  DEF pktPass[8]:STRING
  
  DEF cfgFile[255]:STRING
  DEF myargs:PTR TO LONG,rdargs
  
  DEF fh
  DEF tempStr[255]:STRING
  DEF msgPacketFilename[255]:STRING
  
  DEF category[255]:STRING
  DEF optionName[255]:STRING
  DEF optionValue[255]:STRING

  DEF originNode,destNode,originNet,destNet,originZone,destZone,originPoint,destPoint,attr,cost
  DEF tearLine[255]:STRING
  DEF originLine[255]:STRING
  DEF tzOffset[10]:STRING
  
  DEF eof=FALSE

  WriteF('Ami-Express FTN file processor Copyright 2020 Darren Coles\n')
  
  myargs:=[0,0]:LONG
  IF rdargs:=ReadArgs('CFG/A',myargs,NIL)
    IF myargs[0]<>NIL 
      AstrCopy(cfgFile,myargs[0],255)
    ENDIF
    FreeArgs(rdargs)
  ELSE
    RETURN
  ENDIF
  
  confNames:=NEW confNames.stringlist(100)
  msgBasePaths:=NEW msgBasePaths.stringlist(100)

  fh:=Open(cfgFile,MODE_OLDFILE)
  IF fh<>0

    REPEAT
      eof:=(ReadStr(fh,tempStr)=-1) AND (StrLen(tempStr)=0)
      processConfigLine(tempStr,category,optionName,optionValue)

      IF StrCmp('MAIN',category) AND StrCmp('MODE',optionName) THEN StrCopy(mode,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('INBOUND',optionName) THEN StrCopy(inboundDir,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('INBOUNDINSEC',optionName) THEN StrCopy(inboundInsecureDir,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('OUTBOUND',optionName) THEN StrCopy(outboundDir,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('UNPACKCMD',optionName) THEN StrCopy(ftnUnpackCommand,optionValue)
      IF StrCmp('MAIN',category) AND StrCmp('TEMPDIR',optionName) THEN StrCopy(tempDir,optionValue)

      IF StrCmp('ORIGINNET',category) AND StrCmp('ZONE',optionName) THEN originZone:=Val(optionValue)
      IF StrCmp('ORIGINNET',category) AND StrCmp('NET',optionName) THEN originNet:=Val(optionValue)
      IF StrCmp('ORIGINNET',category) AND StrCmp('NODE',optionName) THEN originNode:=Val(optionValue)
      IF StrCmp('ORIGINNET',category) AND StrCmp('POINT',optionName) THEN originPoint:=Val(optionValue)

      IF StrCmp('DESTNET',category) AND StrCmp('ZONE',optionName) THEN destZone:=Val(optionValue)
      IF StrCmp('DESTNET',category) AND StrCmp('NET',optionName) THEN destNet:=Val(optionValue)
      IF StrCmp('DESTNET',category) AND StrCmp('NODE',optionName) THEN destNode:=Val(optionValue)
      IF StrCmp('DESTNET',category) AND StrCmp('POINT',optionName) THEN destPoint:=Val(optionValue)

      IF StrCmp('MISC',category) AND StrCmp('PASSWORD',optionName) THEN StrCopy(pktPass,optionValue)
      IF StrCmp('MISC',category) AND StrCmp('COST',optionName) THEN cost:=Val(optionValue)
      IF StrCmp('MISC',category) AND StrCmp('ATTR',optionName) THEN attr:=Val(optionValue)
      IF StrCmp('MISC',category) AND StrCmp('TEAR',optionName) THEN StrCopy(tearLine,optionValue)
      IF StrCmp('MISC',category) AND StrCmp('ORIGIN',optionName) THEN StrCopy(originLine,optionValue)
      IF StrCmp('MISC',category) AND StrCmp('TZOFFSET',optionName) THEN StrCopy(tzOffset,optionValue)
    UNTIL StrCmp(category,'CONFS') OR eof
    UpperStr(mode)

    IF StrCmp(category,'CONFS')=FALSE
      WriteF('Error reading CONFS data in FTN.cfg\n\n')
      Raise(ERR_NOCFG)
    ENDIF

    WHILE(ReadStr(fh,tempStr)<>-1) OR (StrLen(tempStr)>0)
      confNames.add(tempStr)
      ReadStr(fh,tempStr)
      msgBasePaths.add(tempStr)
    ENDWHILE
    Close(fh)
    fh:=0
  ELSE
    WriteF('Error opening FTN.cfg\n\n')
    Raise(ERR_NOCFG)
  ENDIF
  
  IF StrCmp(mode,'OUT') OR StrCmp(mode,'BOTH')
    WriteF('Processing outgoing messages\n')
    
    StringF(msgPacketFilename,'\s\z\h[4]\z\h[4].Out',outboundDir,destNet,destNode)

    ->create messages bundle by scraping confs
    createMessagesBundle(originNode,destNode,originNet,destNet,originZone,destZone,originPoint,destPoint,attr,cost,pktPass,msgPacketFilename,tearLine,originLine,tzOffset)    
  ENDIF
  
  IF StrCmp(mode,'IN') OR StrCmp(mode,'BOTH')
    WriteF('Processing incoming messages\n')
    IF StrLen(inboundDir)>0 THEN processBundles(ftnUnpackCommand,inboundDir,tempDir)
    IF StrLen(inboundInsecureDir)>0 THEN processBundles(ftnUnpackCommand,inboundInsecureDir,tempDir)
    IF StrLen(inboundDir)>0 THEN processPackets(inboundDir)
    IF StrLen(inboundInsecureDir)>0 THEN processPackets(inboundInsecureDir)
  ENDIF
  WriteF('All done\n')

EXCEPT DO
  IF confNames<>NIL THEN END confNames
  IF msgBasePaths<>NIL THEN END msgBasePaths
ENDPROC