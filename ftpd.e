/*
** simple ftpd
** Amiga E version
*/

OPT LARGE,MODULE

CONST LISTENQ=100
CONST EINTR=4
CONST EWOULDBLOCK=35
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
       'exec/alerts',
       'asyncio',
       'libraries/asyncio'
 
OBJECT ftpData
  rest:LONG
  tcount:LONG
  scount:LONG
  hostName:PTR TO CHAR
  workingPath:PTR TO CHAR
  uploadMode:LONG
  port:LONG
  dataPorts:PTR TO LONG
  restPos:LONG
  sockId:LONG
  aePuts:LONG
  readChar:LONG
  sCheckInput:LONG
  fileStart:LONG
  fileEnd:LONG
  fileProgress:LONG
  fileDupeCheck:LONG
  ftpAuth:LONG
  authUser[255]:ARRAY OF CHAR
ENDOBJECT
 

PROC errno(sb)
  MOVE.L sb,A6
  JSR -$A2(A6)    ->errno
ENDPROC D0

PROC ioctlSocket(sb,s,v,tags)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L v,D1
  MOVE.L tags,A0
  JSR -$72(A6)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC recv(sb,s,buf,len,flags)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L buf,A0
  MOVE.L len,D1
  MOVE.L flags,D2
  JSR -$4E(A6)    ->recv
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC send(sb,s,msg,len,flags)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L msg,A0
  MOVE.L len,D1
  MOVE.L flags,D2
  JSR -$42(A6)    ->send
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC accept(sb,s,addr,addrlen)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L addr,A0
  MOVE.L addrlen,A1
  JSR -$30(A6)   ->Accept(s,addr,addrlen)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC releaseSocket(sb,fd,id)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L fd,D0
  MOVE.L id,D1
  JSR -$96(A6)   ->ReleaseSocket(fd,id)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

/*PROC releaseCopyOfSocket(sb,fd,id)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L fd,D0
  MOVE.L id,D1
  JSR -$9C(A6)   ->ReleaseCopyOfSocket(fd,id)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0*/

PROC closeSocket(sb,s)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L s,D0
  JSR -$78(A6)   ->CloseSocket(s)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC socket(sb,domain, type, protocol)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L domain,D0
  MOVE.L type,D1
  MOVE.L protocol,D2
  
  JSR -$1E(A6)   ->Socket(domain,type,protocol)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC bind(sb,s, name, namelen)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L name,A0
  MOVE.L namelen,D1
  
  JSR -$24(A6)   ->Bind(domain,type,protocol)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC listen(sb,s, backlog)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L backlog,D1
  
  JSR -$2A(A6)   ->Listen(s,backlog)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC getHostByName(sb,name)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L name,A0
  
  JSR -$D2(A6)   ->GetHostByName(name)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC obtainSocket(sb,id,domain, type, protocol)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L id,D0
  MOVE.L domain,D1
  MOVE.L type,D2
  MOVE.L protocol,D3
  
  JSR -$90(A6)   ->ObtainSocket(id,domain,type,protocol)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC getSockOpt(sb,s,level,optname,optval,optlen )
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L level,D1
  MOVE.L optname,D2
  MOVE.L optval,A0
  MOVE.L optlen,A1

  JSR -$60(A6)   ->getSockOpt(s,level,optname,optval,optlen)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0


PROC setSockOpt(sb,s,level,optname,optval,optlen )
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L s,D0
  MOVE.L level,D1
  MOVE.L optname,D2
  MOVE.L optval,A0
  MOVE.L optlen,D3

  JSR -$5A(A6)   ->setSockOpt(s,level,optname,optval,optlen)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC fileStart(ftpData:PTR TO ftpData,fn,pos)
  DEF fs
  fs:=ftpData.fileStart
  MOVE.L fn,-(A7)
  MOVE.L pos,-(A7)
  fs()
  ADD.L #8,A7
ENDPROC

PROC fileEnd(ftpData:PTR TO ftpData,fn,result)
  DEF fe
  fe:=ftpData.fileEnd

  MOVE.L fn,-(A7)
  MOVE.L result,-(A7)  
  fe()
  ADDQ.L #8,A7
ENDPROC

PROC fileProgress(ftpData:PTR TO ftpData,fn,pos,cps)
  DEF fp
  fp:=ftpData.fileProgress
  
  MOVE.L fn,-(A7)
  MOVE.L pos,-(A7)
  MOVE.L cps,-(A7)
  fp()
  ADD.L #12,A7
ENDPROC

PROC fileDupeCheck(ftpData:PTR TO ftpData,fn)
  DEF fdc
  fdc:=ftpData.fileDupeCheck
  
  MOVE.L fn,-(A7)
  fdc()
  ADD.L #4,A7
ENDPROC D0

PROC aePuts(ftpData:PTR TO ftpData, s:PTR TO CHAR)
  DEF puts
  puts:=ftpData.aePuts
  MOVE.L s,-(A7)
  CLR.L -(A7)
  puts()
  ADDQ.L #8,A7
ENDPROC

PROC sCheckInput(ftpData:PTR TO ftpData)
  DEF chk
  chk:=ftpData.sCheckInput
ENDPROC chk()

PROC readChar(ftpData:PTR TO ftpData)
  DEF rdChar,r
  rdChar:=ftpData.readChar
  CLR.L -(A7)
  CLR.L -(A7)
  r:=rdChar()
  ADDQ.L #8,A7
ENDPROC r

PROC doAuth(ftpData:PTR TO ftpData,userName:PTR TO CHAR,password:PTR TO CHAR)
  DEF fAuth,r
  
  fAuth:=ftpData.ftpAuth
  IF fAuth<>NIL
    MOVE.L userName,-(A7)
    MOVE.L password,-(A7)
    r:=fAuth()
    ADDQ.L #8,A7
  ELSE
    r:=TRUE
  ENDIF
ENDPROC r

PROC fastSystemTime()
  DEF currDate: datestamp
  DEF startds:PTR TO datestamp

  startds:=DateStamp(currDate)

ENDPROC Mul(startds.minute,3000)+startds.tick

PROC calcCPS(pd,t,t2)
  DEF cps
  cps:=0
  
  IF t<t2
    IF (pd<0) OR (pd>$1000000)
      pd:=Shr(pd,4) AND $fffffff
      cps:=Div(Mul(pd,50),(t2-t))
      cps:=Shl(cps,4)
    ELSE
      cps:=Div(Mul(pd,50),(t2-t))     
    ENDIF
  ENDIF
ENDPROC cps


PROC openSocket(sb,port, reuseable,ftpData:PTR TO ftpData)
  DEF server_s
  DEF servaddr=0:PTR TO sockaddr_in
  DEF tempStr[255]:STRING
  DEF optval:PTR TO LONG,optlen:PTR TO LONG

  servaddr:=NEW servaddr

	IF((server_s:=socket(sb,AF_INET, SOCK_STREAM, 0)) < 0)
    StringF(tempStr,'/XFTP: Error creating listening socket. (\d)\b\n',errno(sb))
		aePuts(ftpData,tempStr)
    END servaddr
		RETURN FALSE,-1
	ENDIF

  IF reuseable
    IF setSockOpt(sb,server_s, SOL_SOCKET, SO_REUSEADDR, [1]:LONG, 4)<>0
      StringF(tempStr,'/XFTP: error setting socket options SO_REUSEADDR, error=\d\b\n',errno(sb))
      aePuts(ftpData,tempStr)
    ENDIF

    optval:=NEW [0,0]:LONG
    optlen:=NEW [8]:LONG
    IF getSockOpt(sb,server_s, SOL_SOCKET, SO_LINGER, optval,optlen)<>0
      StringF(tempStr,'/XFTP: error getting socket options SO_LINGER, error=\d\b\n',errno(sb))
      aePuts(ftpData,tempStr)
    ENDIF
    IF optlen[0]=4
      optval[0]:=$10000
    ELSEIF optlen[0]=8
      optval[0]:=1
      optval[1]:=0
    ELSE
      aePuts(ftpData,'/XFTP: error setting socket options SO_LINGER, bad size\b\n')
    ENDIF

    IF setSockOpt(sb,server_s, SOL_SOCKET, SO_LINGER, optval,optlen[0])<>0
      StringF(tempStr,'/XFTP: error setting socket options SO_LINGER, error=\d\b\n',errno(sb))
      aePuts(ftpData,tempStr)
    ENDIF
    END optval[2]
    END optlen[1]

  ENDIF
  
  servaddr.sin_len:=SIZEOF sockaddr_in
  servaddr.sin_family:=AF_INET
  servaddr.sin_port:=port
  servaddr.sin_addr:=INADDR_ANY

	IF(bind(sb,server_s, servaddr, SIZEOF sockaddr_in) < 0)
		->StringF(tempStr,'/XFTP: Error calling bind() for port \d, error=\d\b\n',port,errno(sb));
    ->aePuts(ftpData,tempStr)
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
			CONT c[] = "\b"
			EXIT c[] = "\n"
			buffer[]++:=c[]
		ELSEIF ( rc = 0 )
			IF ( n = 1 ) THEN RETURN 0
      EXIT TRUE
		ELSE
			CONT errno(sb) = EINTR
			RETURN -1
		ENDIF
  ENDFOR
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
  DEF i,port
	 
  hostEnt:=getHostByName(sb,serverHost)
  addr:=hostEnt.h_addr_list[]
  addr:=addr[]
  
  ftpData.rest:=0  

  i:=0
  REPEAT
    port:=ftpData.dataPorts[i]
    r,data_s:=openSocket(sb,port,1,ftpData)
    i++
  UNTIL (r OR (i>=ListLen(ftpData.dataPorts)))

  IF r=FALSE 
    writeLineEx(sb,ftp_c, '425 Can''t open data connection\b\n')
    RETURN -1,-1
  ENDIF
  
  StringF(temp,'227 Entering Passive Mode (\d,\d,\d,\d,\d,\d)\b\n',Shr(addr[] AND $FF000000,24)AND $FF,Shr(addr[] AND $FF0000,16) AND $FF,Shr(addr[] AND $FF00,8) AND $FF,addr[] AND $FF,Shr(port,8) AND $FF,port AND $FF)
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
    /*StringF(temp,'Data connection at port \d accepted\b\n', port)
    aePuts(ftpData,temp)*/
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
      IF fh<>0
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


PROC cmdUser(sb,ftp_c,params:PTR TO CHAR,ftpData:PTR TO ftpData)
  ->WriteF('user=\s\b\n',params)
  writeLineEx(sb,ftp_c, '331 user accepted\b\n')
  AstrCopy(ftpData.authUser,params,255)
ENDPROC

PROC cmdPass(sb,ftp_c,params,ftpData:PTR TO ftpData)
  ->WriteF('pass=\s\b\n',params)
  IF doAuth(ftpData,ftpData.authUser,params)
    writeLineEx(sb,ftp_c, '230 password accepted\b\n')
  ELSE
    writeLineEx(sb,ftp_c, '430 Invalid username or password\b\n')
  ENDIF
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
    StringF(temp,'213 \d\b\n',len)
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
  DEF success=FALSE
  DEF break=FALSE
  DEF buff
  DEF fn[500]:STRING
  DEF r,l
  DEF fh,pos,t,t2
  DEF cps,lastpos
  DEF asynclib

  IF (ftpData.fileDupeCheck<>NIL)
    IF fileDupeCheck(ftpData,filename)=TRUE
      StringF(temp,'553 \s: Duplicate file skipped\b\n',filename)
      writeLineEx(sb,ftp_c,temp)

      IF (data_c>=0)
        ftpData.scount:=ftpData.scount-1
        r:=closeSocket(sb,data_c)
      ENDIF
      
      IF (data_s>=0)
        ftpData.scount:=ftpData.scount-1
        r:=closeSocket(sb,data_s)
      ENDIF

      RETURN
    ENDIF
  ENDIF

  IF ftpData.uploadMode=FALSE
    StringF(temp,'550 \s: Not expecting any uploads\b\n',filename)
    writeLineEx(sb,ftp_c,temp)

    IF (data_c>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_c)
    ENDIF
    
    IF (data_s>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_s)
    ENDIF

    RETURN
  ENDIF

  asynclib:=OpenLibrary('asyncio.library',0)
  asynciobase:=asynclib

  IF (data_c>=0)
    IF filename[0]="\\" THEN filename++
    StringF(fn,'\s\s',ftpData.workingPath,filename)
    
    writeLineEx(sb,ftp_c, '150 Opening BINARY connection\b\n')
    
    IF asynclib<>NIL
      fh:=OpenAsync(fn,MODE_APPEND,32768)
    ELSE
      fh:=Open(fn,MODE_READWRITE)
    ENDIF
    IF asynclib<>NIL
      SeekAsync(fh,ftpData.restPos,MODE_START)
    ELSE
      Seek(fh,ftpData.restPos,OFFSET_BEGINNING)
    ENDIF
    IF fh=0
      StringF(temp,'550 \s: No such file or directory\b\n',filename)
      writeLineEx(sb,ftp_c,temp)
    ELSE
      IF ftpData.fileStart<>NIL
        fileStart(ftpData,filename,0)
      ENDIF
      
      buff:=New(32768)
      t:=fastSystemTime()
      lastpos:=0
      cps:=0
      REPEAT
        l:=recv(sb,data_c, buff,32768,0)
        IF asynclib<>NIL
          WriteAsync(fh,buff,l)
        ELSE
          Fwrite(fh,buff,1,l)
        ENDIF
        IF ftpData.fileProgress<>NIL
          t2:=fastSystemTime()
          ->only call update maximum every 1 second
          IF (Abs(t2-t))>=50
            IF asynclib<>NIL
              pos:=SeekAsync(fh,0,MODE_CURRENT)
            ELSE
              pos:=Seek(fh,0,OFFSET_CURRENT)
            ENDIF
            cps:=calcCPS(pos-lastpos,t,t2)
            lastpos:=pos
            fileProgress(ftpData,filename,pos,cps)
            t:=t2
          ENDIF
        ENDIF
        break:=CtrlC()
      UNTIL (l=0) OR (break)
      Dispose(buff)

      IF ftpData.fileProgress<>NIL
        t2:=fastSystemTime()
        IF asynclib<>NIL
          pos:=SeekAsync(fh,0,MODE_CURRENT)
        ELSE
          pos:=Seek(fh,0,OFFSET_CURRENT)
        ENDIF
        cps:=calcCPS(pos-lastpos,t,t2)
        fileProgress(ftpData,filename,pos,cps)
      ENDIF
      IF asynclib<>NIL
        CloseAsync(fh)
      ELSE
        Close(fh)
      ENDIF

      success:=(break=FALSE)
      IF ftpData.fileEnd<>NIL
        fileEnd(ftpData,filename,success)
      ENDIF

      StringF(temp, '\d \s ... \s\b\n', 
      IF (success) THEN 226 ELSE 426, 
      filename, 
      IF (success) THEN 'Transfer Complete' ELSE 'Transfer aborted')

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
  /*aePuts(ftpData,'Data connection closed\b\n')*/
  IF asynclib<>NIL THEN CloseLibrary(asynclib)
ENDPROC

PROC cmdRetr(sb,ftp_c,data_s,data_c,filename:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF temp[255]:STRING
  DEF success=FALSE
  DEF break=FALSE
  DEF buff
  DEF asynclib
  DEF fn[500]:STRING
  DEF r,l,pos,cps,lastpos
  DEF fh
  DEF t,t2

  asynclib:=OpenLibrary('asyncio.library',0)
  asynciobase:=asynclib
  
  IF ftpData.uploadMode
    StringF(temp,'550 \s: No such file or directory\b\n',filename)
    writeLineEx(sb,ftp_c,temp)
    IF (data_c>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_c)
    ENDIF
    
    IF (data_s>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_s)
    ENDIF
    RETURN
  ENDIF

  IF (data_c>=0)
    IF filename[0]="\\" THEN filename++
    StringF(fn,'\s\s',ftpData.workingPath,filename)
    
    
    IF asynclib<>NIL
      writeLineEx(sb,ftp_c, '150 Opening BINARY connection with ASYNC\b\n')
      fh:=OpenAsync(fn,MODE_READ,32768)
    ELSE
      writeLineEx(sb,ftp_c, '150 Opening BINARY connection with no ASYNC\b\n')

      fh:=Open(fn,MODE_OLDFILE)
    ENDIF
    IF fh=0
      StringF(temp,'/XFTP: open error \s \d\b\n',fn,IoErr())
      aePuts(ftpData,temp)
      StringF(temp,'550 \s: No such file or directory\b\n',filename)
       
      writeLineEx(sb,ftp_c,temp)
    ELSE
      IF ftpData.fileStart<>NIL
        
        IF asynclib<>NIL
          SeekAsync(fh,0,MODE_END)
          pos:=SeekAsync(fh,0,MODE_CURRENT)
        ELSE
          Seek(fh,0,OFFSET_END)
          pos:=Seek(fh,0,OFFSET_CURRENT)
        ENDIF
        fileStart(ftpData,filename,pos)
      ENDIF
      IF asynclib<>NIL
        SeekAsync(fh,ftpData.restPos,MODE_START)
      ELSE
        Seek(fh,ftpData.restPos,OFFSET_BEGINNING)
      ENDIF
      buff:=New(32768)
      t:=fastSystemTime()
      lastpos:=0
      cps:=0
      REPEAT
        IF asynclib<>NIL
          l:=ReadAsync(fh,buff,32768)
        ELSE
          l:=Fread(fh,buff,1,32768)
        ENDIF
        r:=0
        IF l>0 
          r:=send(sb,data_c, buff, l, 0)
          IF (r>0) AND (ftpData.fileProgress<>NIL)
            t2:=fastSystemTime()
            ->only call update maximum every 1 second
            IF (Abs(t2-t))>=50
              IF asynclib<>NIL
                pos:=SeekAsync(fh,0,MODE_CURRENT)
              ELSE
                pos:=Seek(fh,0,OFFSET_CURRENT)
              ENDIF
              cps:=calcCPS(pos-lastpos,t,t2)
              lastpos:=pos
              fileProgress(ftpData,filename,pos,cps)
              t:=t2
            ENDIF
          ENDIF
        ENDIF
        break:=CtrlC() OR (r<>l)
      UNTIL (l=0) OR (break)
      Dispose(buff)

      IF ftpData.fileProgress<>NIL
        t2:=fastSystemTime()
        IF asynclib<>NIL
          pos:=SeekAsync(fh,0,MODE_CURRENT)
        ELSE
          pos:=Seek(fh,0,OFFSET_CURRENT)
        ENDIF
        cps:=calcCPS(pos-lastpos,t,t2)
        fileProgress(ftpData,filename,pos,cps)
      ENDIF
      IF asynclib<>NIL
        CloseAsync(fh)
      ELSE
        Close(fh)
      ENDIF
      success:=(break=FALSE)
      IF ftpData.fileEnd<>NIL
        fileEnd(ftpData,filename,success)
      ENDIF

      StringF(temp, '\d \s ... \s\b\n', 
      IF (success) THEN 226 ELSE 426, 
      filename, 
      IF (success) THEN 'Transfer Complete' ELSE 'Transfer aborted')

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
  IF asynclib<>NIL 
    CloseLibrary(asynclib)
  ENDIF
  /*aePuts(ftpData,'Data connection closed\b\n')*/
ENDPROC


PROC cmdList(sb,ftp_c,data_s,data_c,ftpData:PTR TO ftpData)
  DEF r
  
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
  /*aePuts(ftpData,'Data connection closed\b\n')*/
ENDPROC

PROC ftpThread()
  DEF ftp_c,sockid
  DEF request[255]:STRING
  DEF sb,r
  DEF data_s=-1,data_c=-1
  DEF ftpData:PTR TO ftpData

  ftpData:=loadA4()

  sockid:=ftpData.sockId
  
	sb:=OpenLibrary('bsdsocket.library',2)
  ftp_c:=obtainSocket(sb,sockid,AF_INET,SOCK_STREAM,0)

  ioctlSocket(sb,ftp_c,FIONBIO,[0])

  ftpData.scount:=ftpData.scount+1
  writeLineEx(sb,ftp_c, '220 Hi, I''m your Amiga FTP server.\b\n')
    
  WHILE((readLine(sb,ftp_c, request, MAX_LINE-1) > 0) AND (StrCmp(request, 'QUIT', 4)=FALSE)) AND (CtrlC()=FALSE)
    
    IF(StrCmp(request, 'USER ', 5))
      cmdUser(sb,ftp_c,request+5,ftpData)
    ELSEIF(StrCmp(request, 'PASS ', 5))
      cmdPass(sb,ftp_c,request+5,ftpData)
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
  ->aePuts(ftpData,'FTP connection closed\b\n')
  Exit(0)
ENDPROC

PROC saveA4(taskID,ftpData,node)
  DEF pa,nd,tid
  MOVEM.L D0-D7/A0-A6,-(A7)
  tid:=taskID
  pa:=ftpData
  nd:=node
  
  LEA regA4(PC),A0
  LEA tasksA4(PC),A1
  LEA procarg(PC),A2
  MOVE.L nd,D0
  ADD.W D0,D0
  ADD.W D0,D0
  MOVE.L A4,0(A0,D0.W)
  MOVE.L tid,0(A1,D0.W)
  MOVE.L pa,0(A2,D0.W)
  MOVEM.L (A7)+,D0-D7/A0-A6
ENDPROC

PROC loadA4()
  MOVEM.L D1-D7/A0-A3/A5-A6,-(A7)
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
  MOVE.L 0(A2,D0),D0
  MOVEM.L (A7)+,D1-D7/A0-A3/A5-A6
ENDPROC D0


PROC createThread(num,node,sockid,ftpData:PTR TO ftpData)
  DEF tags:PTR TO LONG,proc:PTR TO process
  DEF name[255]:STRING
  
  StringF(name,'ftpThread\d-\d',node,num)
  tags:=NEW [NP_ENTRY,{ftpThread},NP_NAME,name,NP_STACKSIZE,10000,0]:LONG
 
  ftpData.sockId:=sockid

  Forbid()
  proc:=CreateNewProc(tags)
  saveA4(proc,ftpData,node)
  Permit()
 END tags[7]
ENDPROC

EXPORT PROC doftp(node,ftphost,ftpports:PTR TO LONG,ftpdataports:PTR TO LONG,ftppath,aePutsPtr, readCharPtr, sCheckInputPtr, ftpFileStartPtr, ftpFileEndPtr, ftpFileProgressPtr, ftpDupeCheckPtr,ftpCheckConnection,ftpAuthPtr,uploadMode)
  DEF r,ftp_s,ftp_c,s,sb
  DEF temp[255]:STRING
  DEF ftpData:PTR TO ftpData
  DEF flg,rchar
  DEF tcount=0,i,t
  DEF connected=TRUE
  DEF port
  
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
  ftpData.fileDupeCheck:=ftpDupeCheckPtr
  ftpData.workingPath:=String(255)
  ftpData.hostName:=String(255)
  ftpData.dataPorts:=ftpdataports
  ftpData.ftpAuth:=ftpAuthPtr

  StrCopy(ftpData.hostName,ftphost)
  
  StrCopy(ftpData.workingPath,ftppath)
  
	sb:=OpenLibrary('bsdsocket.library',2)
	IF (sb)
    i:=0
    REPEAT
      port:=ftpports[i]
      r,ftp_s:=openSocket(sb,port,1,ftpData)
      i++
    UNTIL (r OR (i>=ListLen(ftpports)))
    
    flg:=FALSE
    IF r
      ftpData.port:=port
      StringF(temp,'\b\nFTP processor started on \s port \d...\b\n',ftpData.hostName,ftpData.port)
      aePuts(ftpData,temp)
      aePuts(ftpData,'Transfer will finish on CTRL-C or when all connections are closed\b\n\b\n')

      ioctlSocket(sb,ftp_s,FIONBIO,[1])
      WHILE ((flg=FALSE) OR (ftpData.tcount<>0))
        Delay(10)
        rchar:=0
        IF sCheckInput(ftpData)
          rchar:=readChar(ftpData)
        ENDIF
        EXIT rchar=3
        
        IF ftpCheckConnection<>NIL THEN connected:=ftpCheckConnection()
        EXIT connected=FALSE
        
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

          s:=releaseSocket(sb,ftp_c,UNIQUE_ID)
          ->r:=closeSocket(sb,ftp_c)
          createThread(tcount,node,s,ftpData)
          tcount++
        ENDIF
      ENDWHILE
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,ftp_s)

      IF flg THEN aePuts(ftpData,'\b\n')
      IF (rchar=3) OR (connected=FALSE)
        StringF(temp,'\s detected, FTP transfer aborted\b\n',IF rchar=3 THEN 'CTRL-C' ELSE 'Disconnect')
        aePuts(ftpData,temp)
        FOR i:=0 TO tcount-1
          StringF(temp,'ftpThread\d-\d',node,i)
          Forbid()
          t:=FindTask(temp)
          IF t<>NIL THEN Signal(t,SIGBREAKF_CTRL_C)
          Permit()       
        ENDFOR
      ELSE
        aePuts(ftpData,'FTP transfers complete, all ftp connections closed\b\n')
      ENDIF
    ENDIF
    CloseLibrary(sb)
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
