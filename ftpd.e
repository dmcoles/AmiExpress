/*
** simple ftpd
** Amiga E version
*/

OPT LARGE,MODULE

CONST LISTENQ=100
CONST EINTR=4
CONST MAX_LINE=255
CONST FIONBIO=$8004667e

MODULE	'socket',
        'net/netdb',
        'net/in',
        'net/socket',
        'dos/dostags',
        'dos/dosextens',
        'dos/datetime',
        'dos/dos',
       'exec/tasks',
       'exec/alerts'
 
OBJECT ftpData
  rest:LONG
  tcount:LONG
  scount:LONG
  hostName:PTR TO CHAR
  workingPath:PTR TO CHAR
  uploadMode:LONG
  port:LONG
  restPos:LONG
  sockId:LONG
  aePuts:LONG
  readChar:LONG
  sCheckInput:LONG
  fileStart:LONG
  fileEnd:LONG
  fileProgress:LONG
  xprInfo:LONG
ENDOBJECT
 

PROC errno(sb)
  MOVE.L sb,A6
  JSR -$A2(A6)    ->errno
ENDPROC D0

PROC ioctlSocket(sb,s,v,tags)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L v,D1
  MOVE.L tags,A0
  JSR -$72(A6)
ENDPROC D0

PROC recv(sb,s,buf,len,flags)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L buf,A0
  MOVE.L len,D1
  MOVE.L flags,D2
  JSR -$4E(A6)    ->recv
ENDPROC D0

PROC send(sb,s,msg,len,flags)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L msg,A0
  MOVE.L len,D1
  MOVE.L flags,D2
  JSR -$42(A6)    ->send
ENDPROC D0

PROC accept(sb,s,addr,addrlen)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L addr,A0
  MOVE.L addrlen,A1
  JSR -$30(A6)   ->Accept(s,addr,addrlen)
ENDPROC D0

PROC releaseCopyOfSocket(sb,fd,id)
  MOVE.L sb,A6
  MOVE.L fd,D0
  MOVE.L id,D1
  JSR -$9C(A6)   ->ReleaseCopyOfSocket(fd,id)
ENDPROC D0

PROC closeSocket(sb,s)
  MOVE.L sb,A6
  MOVE.L s,D0
  JSR -$78(A6)   ->CloseSocket(s)
ENDPROC D0

PROC socket(sb,domain, type, protocol)
  MOVE.L sb,A6
  MOVE.L domain,D0
  MOVE.L type,D1
  MOVE.L protocol,D2
  
  JSR -$1E(A6)   ->Socket(domain,type,protocol)
ENDPROC D0

PROC bind(sb,s, name, namelen)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L name,A0
  MOVE.L namelen,D1
  
  JSR -$24(A6)   ->Bind(domain,type,protocol)
ENDPROC D0

PROC listen(sb,s, backlog)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L backlog,D1
  
  JSR -$2A(A6)   ->Listen(s,backlog)
ENDPROC D0

PROC getHostByName(sb,name)
  MOVE.L sb,A6
  MOVE.L name,A0
  
  JSR -$D2(A6)   ->GetHostByName(name)
ENDPROC D0

PROC obtainSocket(sb,id,domain, type, protocol)
  MOVE.L sb,A6
  MOVE.L id,D0
  MOVE.L domain,D1
  MOVE.L type,D2
  MOVE.L protocol,D3
  
  JSR -$90(A6)   ->ObtainSocket(id,domain,type,protocol)
ENDPROC D0

PROC setSockOpt(sb,s,level,optname,optval,optlen )
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L level,D1
  MOVE.L optname,D2
  LEA optval,A0
  MOVE.L optlen,D3

  JSR -$5A(A6)   ->setSockOpt(s,level,optname,optval,optlen)
ENDPROC D0

PROC fileStart(ftpData:PTR TO ftpData,fn,pos)
  DEF fs,xprInfo
  DEF xi
  fs:=ftpData.fileStart
  xi:=ftpData.xprInfo
  MOVE.L xi,-(A7)
  MOVE.L fn,-(A7)
  MOVE.L pos,-(A7)
  fs()
  ADD.L #12,A7
ENDPROC

PROC fileEnd(ftpData:PTR TO ftpData,fn)
  DEF fe
  DEF xprInfo
  fe:=ftpData.fileEnd
  xprInfo:=ftpData.xprInfo

  MOVE.L xprInfo,-(A7)
  MOVE.L fn,-(A7)
  fe()
  ADDQ.L #8,A7
ENDPROC

PROC fileProgress(ftpData:PTR TO ftpData,fn,pos)
  DEF fp
  DEF xprInfo
  fp:=ftpData.fileProgress
  xprInfo:=ftpData.xprInfo
  
  MOVE.L xprInfo,-(A7)
  MOVE.L fn,-(A7)
  MOVE.L pos,-(A7)
  fp()
  ADD.L #12,A7
ENDPROC

PROC aePuts(ftpData:PTR TO ftpData, s:PTR TO CHAR)
  DEF puts
  puts:=ftpData.aePuts
  MOVE.L s,-(A7)
  CLR.L -(A7)
  puts()
  ADDQ.L #8,A7
ENDPROC

PROC sCheckInput(ftpData:PTR TO ftpData)
  DEF chk,r
  chk:=ftpData.sCheckInput
ENDPROC chk()

PROC readChar(ftpData:PTR TO ftpData)
  DEF rdChar,r
  rdChar:=ftpData.readChar
  MOVE.L #1,-(A7)
  r:=rdChar()
  ADDQ.L #4,A7
ENDPROC r

PROC openSocket(sb,port, reuseable,ftpData:PTR TO ftpData)
  DEF server_s
  DEF servaddr=0:PTR TO sockaddr_in
  DEF tempStr[255]:STRING

  servaddr:=NEW servaddr

	IF((server_s:=socket(sb,AF_INET, SOCK_STREAM, 0)) < 0)
    StringF(tempStr,'/XFTP: Error creating listening socket. (\d)\b\n',errno(sb))
		aePuts(ftpData,tempStr)
    END servaddr
		RETURN FALSE,-1
	ENDIF


  /*IF reuseable
    IF setSockOpt(sb,server_s, SOL_SOCKET, SO_REUSEADDR, 1, SIZEOF LONG)<>0
      StringF(tempStr,'/XFTP: error setting socket options SO_REUSEADDR, error=\d\b\n',errno(sb))
      aePuts(ftpData,tempStr)
    ENDIF
  ENDIF*/
  
  servaddr.sin_len:=SIZEOF sockaddr_in
  servaddr.sin_family:=AF_INET
  servaddr.sin_port:=port
  servaddr.sin_addr:=INADDR_ANY

	IF(bind(sb,server_s, servaddr, SIZEOF sockaddr_in) < 0)
		StringF(tempStr,'/XFTP: Error calling bind() for port \d, error=\d\b\n',port,errno(sb));
    aePuts(ftpData,tempStr)
    closeSocket(sb,server_s)
    END servaddr
		RETURN FALSE,-1
	ENDIF

	IF(listen(sb,server_s, LISTENQ) < 0)
		StringF(tempStr,'/XFTP: Error calling listen() for port \d, error=\d\b\n',port,errno(sb));
    aePuts(ftpData,tempStr)
    closeSocket(sb,server_s)
    END servaddr
    RETURN FALSE,-1
	ENDIF

  END servaddr
  ftpData.scount:=ftpData.scount+1
ENDPROC TRUE,server_s

PROC readLine(sb,sockd, vptr:PTR TO CHAR, maxlen)
  DEF n, rc
  DEF c[1]:STRING
  DEF buffer:PTR TO CHAR

  buffer:=vptr

  FOR n:=0 TO maxlen-1 
    rc:=recv(sb,sockd, c, 1,0)
		IF ( rc = 1 )
			IF(c[] = "\b") THEN JUMP next
			IF (c[] = "\n") THEN JUMP brk
			buffer[]++:=c[]
		ELSEIF ( rc = 0 )
			IF ( n = 1 )
				RETURN 0
			ELSE
				JUMP brk
      ENDIF
		ELSE
			IF ( errno(sb) = EINTR ) THEN JUMP next
			RETURN -1
		ENDIF
next:
  ENDFOR
brk:
  buffer[]:=0
ENDPROC n

PROC writeLine(sb,sockd, vptr:PTR TO CHAR, n)
  send(sb,sockd, vptr, n,0)
ENDPROC n

PROC writeLineEx(sb,sockd, vptr:PTR TO CHAR)
ENDPROC writeLine(sb,sockd, vptr, StrLen(vptr))

PROC getFileDate(s: PTR TO CHAR,outdate:PTR TO datestamp)
  DEF fBlock: fileinfoblock
  DEF fLock

  IF((fLock:=Lock(s,ACCESS_READ)))=NIL
    RETURN
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN
  ENDIF
  IF(Examine(fLock,fBlock))
    CopyMem(fBlock.datestamp,outdate,SIZEOF datestamp)
  ENDIF
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC

PROC formatLongDate(dts: PTR TO datestamp,outDateStr)
  DEF datestr[10]:STRING
  DEF timestr[10]:STRING
  DEF dt:datetime

  CopyMem(dts,dt.stamp,SIZEOF datestamp)
  dt.format:=FORMAT_DOS
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=datestr
  dt.strtime:=timestr

  IF DateToStr(dt)
    StringF(outDateStr,'\s[3]-\s[2]-\s[2]\s[2] \s[2]:\s[2]',datestr+3,datestr,IF dt.stamp.days>=8035 THEN '20' ELSE '19',datestr+7,timestr,timestr+3)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

PROC formatLongDate2(dts: PTR TO datestamp,outDateStr)
  DEF datestr[10]:STRING
  DEF timestr[10]:STRING
  DEF dt:datetime

  CopyMem(dts,dt.stamp,SIZEOF datestamp)
  dt.format:=FORMAT_USA
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=datestr
  dt.strtime:=timestr

  IF DateToStr(dt)
    StringF(outDateStr,'\s[2]\s[2]\s[2]\s[2]\s[2]\s[2]\s[2]',IF dt.stamp.days>=8035 THEN '20' ELSE '19',datestr+6,datestr,datestr+3,timestr,timestr+3,timestr+6)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

PROC cmdPasv(sb,ftp_c,serverHost:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF temp[255]:STRING
  DEF addr: PTR TO LONG
  DEF hostEnt: PTR TO hostent
  DEF r,data_c,data_s
	 
  hostEnt:=getHostByName(sb,serverHost)
  addr:=hostEnt.h_addr_list[]
  addr:=addr[]
  
  ftpData.rest:=0  

  r,data_s:=openSocket(sb,ftpData.port+1,1,ftpData)
  IF r=FALSE 
    writeLineEx(sb,ftp_c, '425 Can''t open data connection\b\n')
    RETURN -1,-1
  ENDIF
  
  StringF(temp,'227 Entering Passive Mode (\d,\d,\d,\d,\d,\d)\b\n',Shr(addr[] AND $FF000000,24)AND $FF,Shr(addr[] AND $FF0000,16) AND $FF,Shr(addr[] AND $FF00,8) AND $FF,addr[] AND $FF,Shr(ftpData.port+1,8) AND $FF,ftpData.port+1 AND $FF)
  ->WriteF(temp)
  writeLineEx(sb,ftp_c, temp)
  ftpData.restPos:=0
  
  IF((data_c:=accept(sb,data_s, NIL, NIL) ) < 0)
    aePuts(ftpData,'/XFTP: Error calling accept()\b\n')
    ftpData.scount:=ftpData.scount-1
    closeSocket(sb,data_s)
    writeLineEx(sb,ftp_c, '425 Can''t open data connection\b\n')
    RETURN -1,-1
  ELSE
    ftpData.scount:=ftpData.scount+1
    StringF(temp,'Data connection at port \d accepted\b\n', ftpData.port+1)
    aePuts(ftpData,temp)
    RETURN data_s,data_c
  ENDIF      
ENDPROC

PROC myDir(sb,data_c, path: PTR TO CHAR)
  DEF lock
  DEF f_info: PTR TO fileinfoblock
  DEF tempstr[255]:STRING
  DEF dirline[255]:STRING
  DEF fn[255]:STRING
  DEF fh,size

  f_info:=AllocDosObject(DOS_FIB,NIL)
  IF(f_info)=NIL THEN RETURN

  lock:=Lock(path,ACCESS_READ)
  IF(lock)=0
    FreeDosObject(DOS_FIB,f_info)
    RETURN
  ENDIF

  IF(Examine(lock,f_info))=0
    UnLock(lock)
    FreeDosObject(DOS_FIB,f_info)
    RETURN FALSE
  ENDIF

  
  IF(f_info.entrytype>0)
    WHILE((ExNext(lock,f_info))<>0)
      formatLongDate(f_info.datestamp,tempstr)

      size:=-1
      StringF(fn,'\s\s',path,f_info.filename)
      fh:=Open(fn,MODE_OLDFILE)
      IF fh>=0
        Seek(fh,0,OFFSET_END)
        size:=Seek(fh,0,OFFSET_END)
        Close(fh)
      ENDIF

      StringF(dirline,'-rw-rw-rw-   1 root  root \r\d[10] \s \s\b\n',size,tempstr,f_info.filename)
      writeLineEx(sb,data_c, dirline)
    ENDWHILE
  ENDIF

  UnLock(lock)
  FreeDosObject(DOS_FIB,f_info)
ENDPROC TRUE


PROC cmdUser(sb,ftp_c,params:PTR TO CHAR)
  ->WriteF('user=\s\b\n',params)
  writeLineEx(sb,ftp_c, '331 user accepted\b\n')
ENDPROC

PROC cmdPass(sb,ftp_c,params)
  ->WriteF('user=\s\b\n',params)
  writeLineEx(sb,ftp_c, '230 password accepted\b\n')
ENDPROC

PROC cmdPwd(sb,ftp_c)
  DEF temp[255]:STRING
  StrCopy(temp, '257 "\\"\b\n')
  writeLineEx(sb,ftp_c, temp)
ENDPROC

PROC cmdCwd(sb,ftp_c,path:PTR TO CHAR)
  DEF temp[255]:STRING
  IF StrCmp(path,'\\')=FALSE
    StringF(temp,'550 \s: No such file or directory\b\n',path)
    writeLineEx(sb,ftp_c,temp)
  ELSE
    writeLineEx(sb,ftp_c, '257 "\\" is the current directory\b\n')
  ENDIF
ENDPROC

PROC cmdType(sb,ftp_c,params)
  DEF temp[255]:STRING
  StringF(temp,'200 Type set to \s!!!\b\n',params)
  writeLineEx(sb,ftp_c,temp)
ENDPROC

PROC cmdMdtm(sb,ftp_c,filename:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF fn[500]:STRING
  DEF ds:datestamp
  DEF temp[255]:STRING
  DEF outDateStr[255]:STRING

  IF filename[0]="\\" THEN filename++
  StringF(fn,'\s\s',ftpData.workingPath,filename)
  IF getFileDate(fn,ds)
    formatLongDate2(ds,outDateStr)
    StringF(temp,'213 \s\b\n',outDateStr)
    writeLineEx(sb,ftp_c,temp)
  ELSE
    StringF(temp,'550 \s: No such file or directory\b\n',filename)
    writeLineEx(sb,ftp_c,temp)
  ENDIF
ENDPROC

PROC cmdSize(sb,ftp_c,filename:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF fn[500]:STRING
  DEF temp[255]:STRING
  DEF len

  IF filename[0]="\\" THEN filename++
  StringF(fn,'\s\s',ftpData.workingPath,filename)
  
  len:=FileLength(fn)
  
  IF len<>-1
    StringF(temp,'213 \s\b\n',len)
    writeLineEx(sb,ftp_c,temp)
  ELSE
    StringF(temp,'550 \s: No such file or directory\b\n',filename)
    writeLineEx(sb,ftp_c,temp)
  ENDIF
ENDPROC

PROC cmdRest(sb,ftp_c,params:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF tempstr[255]:STRING
  
  ftpData.restPos:=Val(params)
  StringF(tempstr,'350 Restarting at \d. Send STORE or RETRIEVE to initiate transfer\b\n',ftpData.restPos)
  writeLineEx(sb,ftp_c,tempstr)
ENDPROC

PROC cmdStor(sb,ftp_c,data_s,data_c,filename:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF temp[255]:STRING
  DEF fail=FALSE
  DEF buff
  DEF fn[500]:STRING
  DEF r,l
  DEF fh,pos

  IF ftpData.uploadMode=FALSE
    StringF(temp,'550 \s: Not expecting any uploads\b\n',filename)
    writeLineEx(sb,ftp_c,temp)
    RETURN
  ENDIF

  IF (data_c>=0)
    IF filename[0]="\\" THEN filename++
    StringF(fn,'\s\s',ftpData.workingPath,filename)
    
    writeLineEx(sb,ftp_c, '150 Opening BINARY connection\b\n')
    
    fh:=Open(fn,MODE_READWRITE)
    Seek(fh,ftpData.restPos,OFFSET_BEGINNING)
    IF fh<=0
      StringF(temp,'550 \s: No such file or directory\b\n',filename)
      writeLineEx(sb,ftp_c,temp)
    ELSE
      IF ftpData.fileStart<>NIL
        fileStart(ftpData,filename,0)
      ENDIF
      
      buff:=New(10240)
      REPEAT
        l:=recv(sb,data_c, buff,10240,0)
        Fwrite(fh,buff,1,l)
        IF ftpData.fileProgress<>NIL
          pos:=Seek(fh,0,OFFSET_CURRENT)
          fileProgress(ftpData,filename,pos)
        ENDIF

      UNTIL l=0
      Dispose(buff)
      Close(fh)

      IF ftpData.fileEnd<>NIL
        fileEnd(ftpData,filename)
      ENDIF

      fail:=FALSE

      StringF(temp, '\d \s ... \s\b\n', 
      IF (fail=FALSE) THEN 226 ELSE 426, 
      filename, 
      IF (fail=FALSE) THEN 'Transfer Complete' ELSE 'Transfer aborted')

      writeLineEx(sb,ftp_c, temp)
    ENDIF
    
  ELSE
    writeLineEx(sb,ftp_c, '425 Can''t open data connection\b\n')
  ENDIF

  IF (data_c>=0)
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_c)
  ENDIF
  
  IF (data_s>=0)
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_s)
  ENDIF
  aePuts(ftpData,'Data connection closed\b\n')
ENDPROC

PROC cmdRetr(sb,ftp_c,data_s,data_c,filename:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF temp[255]:STRING
  DEF fail=FALSE
  DEF buff
  DEF fn[500]:STRING
  DEF r,l,pos
  DEF fh

  IF ftpData.uploadMode
    StringF(temp,'550 \s: No such file or directory\b\n',filename)
    writeLineEx(sb,ftp_c,temp)
    RETURN
  ENDIF

  IF (data_c>=0)
    IF filename[0]="\\" THEN filename++
    StringF(fn,'\s\s',ftpData.workingPath,filename)
    
    writeLineEx(sb,ftp_c, '150 Opening BINARY connection\b\n')
    
    fh:=Open(fn,MODE_OLDFILE)
    IF fh<=0
      StringF(temp,'/XFTP: open error \s \d\b\n',fn,IoErr())
      aePuts(ftpData,temp)
      StringF(temp,'550 \s: No such file or directory\b\n',filename)
       
      writeLineEx(sb,ftp_c,temp)
    ELSE
      IF ftpData.fileStart<>NIL
        Seek(fh,0,OFFSET_END)
        pos:=Seek(fh,0,OFFSET_CURRENT)
        Seek(fh,0,OFFSET_BEGINNING)
        fileStart(ftpData,filename,pos)
      ENDIF
      Seek(fh,ftpData.restPos,OFFSET_BEGINNING)
      buff:=New(10240)
      REPEAT
        l:=Fread(fh,buff,1,10240)
        IF l>0 THEN send(sb,data_c, buff, l, 0)
        IF ftpData.fileProgress<>NIL
          pos:=Seek(fh,0,OFFSET_CURRENT)
          fileProgress(ftpData,filename,pos)
        ENDIF
      UNTIL l=0
      Dispose(buff)
      Close(fh)
      fail:=FALSE
      IF ftpData.fileEnd<>NIL
        fileEnd(ftpData,filename)
      ENDIF

      StringF(temp, '\d \s ... \s\b\n', 
      IF (fail=FALSE) THEN 226 ELSE 426, 
      filename, 
      IF (fail=FALSE) THEN 'Transfer Complete' ELSE 'Transfer aborted')

      writeLineEx(sb,ftp_c, temp)
    ENDIF
    
  ELSE
    writeLineEx(sb,ftp_c, '425 Can''t open data connection\b\n')
  ENDIF

  IF (data_c>=0)
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_c)
  ENDIF
  
  IF (data_s>=0)
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_s)
  ENDIF
  aePuts(ftpData,'Data connection closed\b\n')
ENDPROC


PROC cmdList(sb,ftp_c,data_s,data_c,ftpData:PTR TO ftpData)
  DEF r
  DEF temp[255]:STRING
  ->WriteF('list\b\n')

  IF (data_c>=0)  
    myDir(sb,data_c,ftpData.workingPath)
    writeLineEx(sb,ftp_c, '226 Transfer Complete\b\n')
  ELSE
    writeLineEx(sb,ftp_c, '425 Can''t open data connection\b\n')
  ENDIF
  IF data_c>=0
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_c)
  ENDIF
  IF data_s>=0
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_s)
  ENDIF
  aePuts(ftpData,'Data connection closed\b\n')
ENDPROC

PROC ftpThread()
  DEF ftp_c,sockid
  DEF request[255]:STRING
  DEF sb,r
  DEF data_s=-1,data_c=-1
  DEF ftpData:PTR TO ftpData
  DEF t,svA4
  DEF temp[255]:STRING

  ftpData:=loadA4()

  sockid:=ftpData.sockId
  
	sb:=OpenLibrary('bsdsocket.library',2)
  ftp_c:=obtainSocket(sb,sockid,AF_INET,SOCK_STREAM,0)

  ioctlSocket(sb,ftp_c,FIONBIO,[0])

  ftpData.scount:=ftpData.scount+1
  writeLineEx(sb,ftp_c, '220 Hi, I''m your Amiga FTP server.\b\n')
    
  WHILE((readLine(sb,ftp_c, request, MAX_LINE-1) > 0) AND (StrCmp(request, 'QUIT', 4)=FALSE))
    ->WriteF('Request: \s\b\n', request)
    
    IF(StrCmp(request, 'USER ', 5))
      cmdUser(sb,ftp_c,request+5)
    ELSEIF(StrCmp(request, 'PASS ', 5))
      cmdPass(sb,ftp_c,request+5)
    ELSEIF(StrCmp(request, 'LIST', 4))
      cmdList(sb,ftp_c,data_s,data_c,ftpData)
      data_c:=-1
      data_s:=-1
    ELSEIF(StrCmp(request, 'PWD', 3))
      cmdPwd(sb,ftp_c)
    ELSEIF(StrCmp(request, 'CWD ', 4))
      cmdCwd(sb,ftp_c,request+4)
    ELSEIF(StrCmp(request, 'TYPE ', 5))
      cmdType(sb,ftp_c,request+5)
    ELSEIF(StrCmp(request, 'MDTM ', 5))
      cmdMdtm(sb,ftp_c,request+5,ftpData)
    ELSEIF(StrCmp(request, 'SIZE ', 5))
      cmdSize(sb,ftp_c,request+5,ftpData)
    ELSEIF(StrCmp(request, 'REST ', 5))
      cmdRest(sb,ftp_c,request+5,ftpData)
    ELSEIF(StrCmp(request, 'STOR ', 5))
      cmdStor(sb,ftp_c,data_s,data_c,request+5,ftpData)
      data_c:=-1
      data_s:=-1
    ELSEIF(StrCmp(request, 'RETR ', 5))
      cmdRetr(sb,ftp_c,data_s,data_c,request+5,ftpData)
      data_c:=-1
      data_s:=-1
    ELSEIF(StrCmp(request, 'PASV', 4))
      IF (data_s>=0)
        ftpData.scount:=ftpData.scount-1
        r:=closeSocket(sb,data_s)
      ENDIF
      IF (data_c>=0)
        ftpData.scount:=ftpData.scount-1
        r:=closeSocket(sb,data_c)
      ENDIF
      data_s,data_c:=cmdPasv(sb,ftp_c,ftpData.hostName,ftpData)
    ELSE
      writeLineEx(sb,ftp_c, '500 command not recognized\b\n')
      ->WriteF('UNKNOWN command: \s\b\n', request);
    ENDIF
    ->IF errno<>0 THEN WriteF('error \d\b\n',errno)    
  ENDWHILE
  writeLineEx(sb,ftp_c, '200 Byebye!\b\n')
  IF (ftp_c>=0) 
    ftpData.scount:=ftpData.scount-1
    closeSocket(sb,ftp_c)
  ENDIF

  IF (data_s>=0)
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_s)
  ENDIF
  IF (data_c>=0) 
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_c)
  ENDIF
  CloseLibrary(sb)

  ftpData.tcount:=ftpData.tcount-1
  aePuts(ftpData,'FTP connection closed\b\n')
ENDPROC

PROC saveA4(taskID,ftpData,node)
  DEF pa,nd
  MOVEM.L D0-D7/A0-A6,-(A7)
  MOVE.L taskID,D7
  pa:=ftpData
  nd:=node
  
  LEA regA4(PC),A0
  LEA tasksA4(PC),A1
  LEA procarg(PC),A2
  MOVE.L nd,D0
  ADD.W D0,D0
  ADD.W D0,D0
  MOVE.L A4,0(A0,D0.W)
  MOVE.L D7,0(A1,D0.W)
  MOVE.L pa,0(A2,D0.W)
  MOVEM.L (A7)+,D0-D7/A0-A6
ENDPROC

PROC loadA4()
DEF pa
  MOVEM.L D0-D7/A0-A3/A5-A6,-(A7)
  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -$126(A6)     ->findtask
  MOVE.L D0,D1

  LEA regA4(PC),A0
  LEA tasksA4(PC),A1
  LEA procarg(PC),A2
  CLR.L D0
findA4task:
  MOVE.L 0(A1,D0.W),D2
  CMP.L D1,D2
  BEQ taskfound

  ADD.L #4,D0
  CMP.L #128,D0
  BNE findA4task

  MOVE.L #AG_BADPARM,D7
  JSR  -$6c(A6)   ->Alert(AG_BADPARM)

taskfound:
  MOVE.L 0(A0,D0),A4
  MOVE.L 0(A2,D0),pa
  MOVEM.L (A7)+,D0-D7/A0-A3/A5-A6
ENDPROC pa


PROC createThread(node,sockid,ftpData:PTR TO ftpData)
  DEF tags,proc:PTR TO process
  DEF tempstr[255]:STRING
  tags:=NEW [NP_ENTRY,{ftpThread},NP_STACKSIZE,10000,0]:LONG
 
  ftpData.sockId:=sockid

  Forbid()
  proc:=CreateNewProc(tags)
  saveA4(proc,ftpData,node)
  Permit()
 END tags
ENDPROC

EXPORT PROC doftp(node,ftphost,ftpport,ftppath,aePutsPtr, readCharPtr, sCheckInputPtr, xprInfo, ftpFileStartPtr, ftpFileEndPtr, ftpFileProgressPtr, uploadMode)
  DEF r,ftp_s,ftp_c,s,sb,myargs:PTR TO LONG,rdargs
  DEF temp[255]:STRING
  DEF ftpData:PTR TO ftpData
  DEF flg,rchar
  
  ftpData:=NEW ftpData
  ftpData.rest:=0
  ftpData.tcount:=0
  ftpData.scount:=0
  ftpData.port:=-1
  ftpData.uploadMode:=uploadMode
  ftpData.restPos:=0
  ftpData.aePuts:=aePutsPtr
  ftpData.readChar:=readCharPtr
  ftpData.sCheckInput:=sCheckInputPtr
  ftpData.fileStart:=ftpFileStartPtr
  ftpData.fileEnd:=ftpFileEndPtr
  ftpData.fileProgress:=ftpFileProgressPtr
  ftpData.workingPath:=String(255)
  ftpData.hostName:=String(255)
  ftpData.xprInfo:=xprInfo


  StrCopy(ftpData.hostName,ftphost)
  ftpData.port:=ftpport
  StrCopy(ftpData.workingPath,ftppath)
  
	sb:=OpenLibrary('bsdsocket.library',2)
	IF (sb)
    StringF(temp,'\b\nFTP processor started on \s port \d...\b\n',ftpData.hostName,ftpData.port)
    aePuts(ftpData,temp)
    aePuts(ftpData,'Transfer will finish on CTRL-C or when all connections are closed\b\n\b\n')
  
    r,ftp_s:=openSocket(sb,ftpport,1,ftpData)

    flg:=FALSE
    IF r
      ioctlSocket(sb,ftp_s,FIONBIO,[1])
      WHILE ((flg=FALSE) OR (ftpData.tcount<>0))
        Delay(10)
        rchar:=0
        IF sCheckInput(ftpData)
          rchar:=readChar(ftpData)
        ENDIF
        EXIT rchar=3
        
        ftp_c:=accept(sb,ftp_s,NIL,NIL)
        IF(ftp_c< 0)
          IF errno(sb)<>35
            StringF(temp,'/XFTP: Error calling accept() errno=\d\b\n',errno(sb))
            aePuts(ftpData,temp)
          ENDIF
        ELSE
          flg:=TRUE
          ftpData.tcount:=ftpData.tcount+1
          StringF(temp,'FTP connection at port \d accepted\b\n', ftpData.port)
          aePuts(ftpData,temp)

          s:=releaseCopyOfSocket(sb,ftp_c,UNIQUE_ID)
          r:=closeSocket(sb,ftp_c)
          createThread(node,s,ftpData)
        ENDIF
      ENDWHILE
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,ftp_s)
    ENDIF
    CloseLibrary(sb)
    IF flg THEN aePuts(ftpData,'\b\n')
    IF rchar=3
      aePuts(ftpData,'CTRL-C detected, FTP transfer aborted\b\n')
    ELSE
      aePuts(ftpData,'FTP transfers complete, all ftp connections closed\b\n')
    ENDIF
	ENDIF
  DisposeLink(ftpData.hostName)
  DisposeLink(ftpData.workingPath)
  END ftpData
ENDPROC


tasksA4:
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL

regA4:
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL

procarg:
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL
