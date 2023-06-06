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

CONST TIMEOUT=300

ENUM CMDTYPE_LIST=1,CMDTYPE_NLST=2,CMDTYPE_MLSD=3
ENUM MODE_UPLOAD, MODE_DOWNLOAD, MODE_FULLSERVER

MODULE	'socket',
        'net/netdb',
        'net/in',
        'net/socket',
        'dos/dostags',
        'dos/dosextens',
        'dos/datetime',
        'dos/dos',
        'devices/timer',
       'exec/tasks',
       'exec/alerts',
       'asyncio',
       'libraries/asyncio',
       '*stringlist',
       '*axobjects',
       '*axenums',
       '*tooltypes',
       '*miscfuncs',
       '*bcd'
       
 
EXPORT OBJECT ftpData
  rest:LONG
  tcount:LONG
  scount:LONG
  hostName:PTR TO CHAR
  workingPath:PTR TO CHAR
  uploadPath:PTR TO CHAR
  subDirPath:PTR TO CHAR
  fileList:PTR TO stdlist
  port:LONG
  dataPorts:PTR TO LONG
  restPos:LONG
  sockId:LONG
  aePuts:LONG
  conPuts:LONG
  readChar:LONG
  sCheckInput:LONG
  uploadFileStart:LONG
  uploadFileEnd:LONG
  uploadFileProgress:LONG
  downloadFileStart:LONG
  downloadFileEnd:LONG
  downloadFileProgress:LONG
  checkDownloadRatio:LONG
  fileDupeCheck:LONG
  ftpCheckConnection:LONG
  callersLog:LONG
  processMessages:LONG
  startFileCheck:LONG
  waitFileCheck:LONG
  getSigs:LONG
  ftpAuth:LONG
  ftpDir:LONG
  getPath:LONG
  findFile:LONG
  authUser[255]:ARRAY OF CHAR
  transType:CHAR
  confNames:PTR TO stringlist
  confDirs:PTR TO stringlist
  confNums:PTR TO stdlist
  confULBlock:PTR TO stringlist
  currentConf:LONG
  setReuseAddr:INT
  filenameCAPS:INT
  mode:INT
ENDOBJECT
 

PROC errno(sb)
  MOVE.L sb,A6
  JSR -$A2(A6)    ->errno
ENDPROC D0

PROC waitSelect(sb,s,readfds,writefds,exceptfds,timeout,signals)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L readfds,A0
  MOVE.L writefds,A1
  MOVE.L exceptfds,A2
  MOVE.L timeout,A3
  MOVE.L signals,D1
  JSR -$7e(A6)
  MOVEM.L (A7)+,D1-D7/A0-A6
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

PROC uploadFileStart(ftpData:PTR TO ftpData,fn,resumepos)
  DEF fs
  fs:=ftpData.uploadFileStart
  MOVE.L fn,-(A7)
  MOVE.L resumepos,-(A7)
  fs()
  ADD.L #8,A7
ENDPROC

PROC checkDownloadRatio(ftpData:PTR TO ftpData,fn,flen,res:PTR TO CHAR)
  DEF cdr
  cdr:=ftpData.checkDownloadRatio
  MOVE.L fn,-(A7)
  MOVE.L flen,-(A7)
  MOVE.L res,-(A7)
  cdr()
  ADD.L #12,A7
ENDPROC D0

PROC downloadFileStart(ftpData:PTR TO ftpData,fn,flen,pos)
  DEF fs
  fs:=ftpData.downloadFileStart
  MOVE.L fn,-(A7)
  MOVE.L flen,-(A7)
  MOVE.L pos,-(A7)
  fs()
  ADD.L #12,A7
ENDPROC

PROC uploadFileEnd(ftpData:PTR TO ftpData,fn,result)
  DEF fe
  fe:=ftpData.uploadFileEnd

  MOVE.L fn,-(A7)
  MOVE.L result,-(A7)  
  fe()
  ADDQ.L #8,A7
ENDPROC

PROC downloadFileEnd(ftpData:PTR TO ftpData,fn,result)
  DEF fe
  fe:=ftpData.downloadFileEnd

  MOVE.L fn,-(A7)
  MOVE.L result,-(A7)  
  fe()
  ADDQ.L #8,A7
ENDPROC

PROC uploadFileProgress(ftpData:PTR TO ftpData,fn,pos,cps)
  DEF fp
  fp:=ftpData.uploadFileProgress
  
  MOVE.L fn,-(A7)
  MOVE.L pos,-(A7)
  MOVE.L cps,-(A7)
  fp()
  ADD.L #12,A7
ENDPROC

PROC downloadFileProgress(ftpData:PTR TO ftpData,fn,pos,cps)
  DEF fp
  fp:=ftpData.downloadFileProgress
  
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
  ADDQ.L #4,A7
ENDPROC D0

PROC getPath(ftpData:PTR TO ftpData,confNum,subDir:PTR TO CHAR,outpath)
  DEF gp
  
  gp:=ftpData.getPath
  gp(confNum,subDir,outpath)
ENDPROC

PROC findFile(ftpData:PTR TO ftpData,fileName,subDirs,outpath)
  DEF ff
  
  ff:=ftpData.findFile
  ff(fileName,subDirs,outpath)
ENDPROC

PROC aePuts(ftpData:PTR TO ftpData, s:PTR TO CHAR)
  DEF puts

  puts:=ftpData.aePuts
  IF puts
    MOVE.L s,-(A7)
    CLR.L -(A7)
    puts()
    ADDQ.L #8,A7
  ENDIF
ENDPROC

PROC conPuts(ftpData:PTR TO ftpData, s:PTR TO CHAR)
  DEF puts

  puts:=ftpData.conPuts
  MOVE.L s,-(A7)
  MOVEQ.L #-1,D0
  MOVE.L D0,-(A7)
  CLR.L -(A7)
  puts()
  ADD.L #12,A7
ENDPROC

PROC sCheckInput(ftpData:PTR TO ftpData)
  DEF chk
  chk:=ftpData.sCheckInput
ENDPROC chk()

PROC callersLog(ftpData:PTR TO ftpData,logtext)
  DEF clog
  clog:=ftpData.callersLog
  clog(logtext,TRUE)
ENDPROC

PROC processMessages(ftpData:PTR TO ftpData)
  DEF procm
  
  procm:=ftpData.processMessages
  procm()
ENDPROC

PROC getSigs(ftpData:PTR TO ftpData)
  DEF gsigs
  
  gsigs:=ftpData.getSigs
ENDPROC gsigs()

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

PROC startFileCheck(ftpData:PTR TO ftpData,filename:PTR TO CHAR,success)
  DEF startCheck
  
  startCheck:=ftpData.startFileCheck
  IF startCheck<>NIL
    startCheck(filename,success)
  ENDIF
ENDPROC

PROC waitFileCheck(ftpData:PTR TO ftpData,timeout)
  DEF waitCheck
  DEF res=0
  
  waitCheck:=ftpData.waitFileCheck
  IF waitCheck<>NIL
    res:=waitCheck(timeout)
  ENDIF
ENDPROC res

PROC freeFileList(fileList:PTR TO stdlist)
  DEF i
  DEF item:PTR TO flagFileItem
  IF fileList<>NIL
    FOR i:=0 TO fileList.count()-1
      item:=fileList.item(i)
      END item
    ENDFOR
    END fileList
  ENDIF
ENDPROC

PROC calcCPS(pd,t,t2)
  DEF cps,td
  DEF bcdVal[8]:ARRAY OF CHAR
  cps:=0
  td:=t2-t
  IF td
    convertToBCD(pd,bcdVal)
    mulBCD(bcdVal,50)
    cps:=divBCD(bcdVal,td)
  ELSE
    cps:=pd
  ENDIF
ENDPROC cps

PROC invalidFn(fn:PTR TO CHAR)
  IF StrLen(fn)>12 THEN RETURN TRUE
  
  IF((InStr(fn,'%')>=0) OR ((InStr(fn,'#'))>=0) OR ((InStr(fn,'?'))>=0) OR ((InStr(fn,' '))>=0) OR ((InStr(fn,'/'))>=0) OR
   ((InStr(fn,'('))>=0) OR ((InStr(fn,')'))>=0) OR ((InStr(fn,':'))>=0) OR ((InStr(fn,'*'))>=0)) THEN TRUE
ENDPROC FALSE

->setting SO_REUSEADDR on windows allows the same socket to be opened twice - BAD BAD BAD!
PROC testSocket(sb,ftpData:PTR TO ftpData,port)
  DEF r
  DEF sock1,sock2
  
  r,sock1:=openSocket(sb,port,1,ftpData)
  
  IF r
    r,sock2:=openSocket(sb,port,1,ftpData)
    IF r
      ftpData.setReuseAddr:=FALSE
      closeSocket(sb,sock2)
    ENDIF
    closeSocket(sb,sock1)     
  ENDIF
ENDPROC

PROC getFileName(ftpData:PTR TO ftpData, filename:PTR TO CHAR,outFilename:PTR TO CHAR)
  DEF i
  DEF fileList:PTR TO stdlist
  DEF item:PTR TO flagFileItem

  StrCopy(outFilename,'')
  fileList:=ftpData.fileList

  IF fileList<>NIL
    FOR i:=0 TO fileList.count()-1
      item:=fileList.item(i)
      IF StriCmp(FilePart(item.fileName),filename) THEN StrCopy(outFilename,item.fileName)
    ENDFOR
  ELSEIF ftpData.findFile<>NIL
    findFile(ftpData,filename,ftpData.subDirPath,outFilename)
  ENDIF
ENDPROC

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
    IF ftpData.setReuseAddr
      IF setSockOpt(sb,server_s, SOL_SOCKET, SO_REUSEADDR, [1]:LONG, 4)<>0
        StringF(tempStr,'/XFTP: error setting socket options SO_REUSEADDR, error=\d\b\n',errno(sb))
        aePuts(ftpData,tempStr)
      ENDIF
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

PROC readLine(ftpData:PTR TO ftpData,sb,sockd,vptr:PTR TO CHAR, maxlen)
  DEF n, rc
  DEF c[1]:STRING
  DEF buffer:PTR TO CHAR
  DEF tv:timeval
  DEF fds,res
  DEF sigs=0
  DEF sigsPtr=0
  DEF string[255]:STRING

  buffer:=vptr

  FOR n:=0 TO maxlen-1 

    tv.secs:=TIMEOUT
    tv.micro:=0
    fds:=NEW [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]:LONG
    setSingleFDS(fds,sockd)
    IF ftpData<>NIL THEN sigs:=getSigs(ftpData)
    IF sigs<>0 THEN sigsPtr:={sigs}
    res:=waitSelect(sb,sockd+1,fds,NIL,NIL,tv,sigsPtr)
    IF ftpData<>NIL THEN processMessages(ftpData)
    END fds[32]
    CONT (res<1) AND (sigs<>0)
    IF res<=0 THEN RETURN -1

    rc:=recv(sb,sockd, c, 1,0)
		IF ( rc = 1 )
			CONT c[] = "\b"
			EXIT c[] = "\n"
			buffer[]++:=c[]
		ELSEIF ( rc = 0 )
          EXIT TRUE
		ELSE
          rc:=errno(sb)
		  CONT rc = EINTR
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
  DEF res=FALSE

  IF((fLock:=Lock(s,ACCESS_READ)))=NIL
    RETURN res
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN res
  ENDIF
  IF(Examine(fLock,fBlock))
    CopyMem(fBlock.datestamp,outdate,SIZEOF datestamp)
    res:=TRUE
  ENDIF
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC res

PROC formatFileDate(dts: PTR TO datestamp,outDateStr)
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

PROC formatFileDate2(dts: PTR TO datestamp,outDateStr)
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
  DEF addr: LONG
  DEF hostEnt: PTR TO hostent
  DEF r,data_c,data_s
  DEF i,port
  DEF tv:timeval
  DEF fds,res
  DEF sigs=0
  DEF sigsPtr=0
	 
  hostEnt:=getHostByName(sb,serverHost)

  addr:=Long(hostEnt.h_addr_list)
  addr:=Long(addr)
  
  ftpData.rest:=0  

  i:=0
  r:=0
  REPEAT
    port:=ftpData.dataPorts[i]
    r,data_s:=openSocket(sb,port,1,ftpData)
    i++
  UNTIL (r OR (i>=ListLen(ftpData.dataPorts)))

  IF r=FALSE 
    writeLineEx(sb,ftp_c, '425 Can''t open data connection\b\n')
    RETURN -1,-1
  ENDIF
  
  StringF(temp,'227 Entering Passive Mode (\d,\d,\d,\d,\d,\d)\b\n',Shr(addr AND $FF000000,24)AND $FF,Shr(addr AND $FF0000,16) AND $FF,Shr(addr AND $FF00,8) AND $FF,addr AND $FF,Shr(port,8) AND $FF,port AND $FF)
  ->WriteF(temp)
  writeLineEx(sb,ftp_c, temp)
  ftpData.restPos:=0

  REPEAT
    tv.secs:=TIMEOUT
    tv.micro:=0
    fds:=NEW [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]:LONG
    setSingleFDS(fds,data_s)
    IF ftpData<>NIL THEN sigs:=getSigs(ftpData)
    IF sigs<>0 THEN sigsPtr:={sigs}
    res:=waitSelect(sb,data_s+1,fds,NIL,NIL,tv,sigsPtr)
    IF ftpData<>NIL THEN processMessages(ftpData)
    END fds[32]
    IF (res<1) AND (sigs=0)
      ftpData.scount:=ftpData.scount-1
      closeSocket(sb,data_s)
      writeLineEx(sb,ftp_c, '425 Timed out waiting for data connection\b\n')
      RETURN -1,-1
    ENDIF
  UNTIL res>0
  
  IF((data_c:=accept(sb,data_s, NIL, NIL) ) < 0)
    ->aePuts(ftpData,'/XFTP: Error calling accept()\b\n')
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

PROC uploadDir(sb,data_c, ftpData:PTR TO ftpData, cmdType)
  DEF lock
  DEF f_info: PTR TO fileinfoblock
  DEF tempstr[255]:STRING
  DEF dirline[255]:STRING
  DEF size,i

  IF(StrLen(ftpData.workingPath)=0) THEN RETURN

  f_info:=AllocDosObject(DOS_FIB,NIL)
  IF(f_info)=NIL THEN RETURN

  lock:=Lock(ftpData.workingPath,ACCESS_READ)
  IF(lock)=0
    FreeDosObject(DOS_FIB,f_info)
    RETURN
  ENDIF

  IF(Examine(lock,f_info))=0
    UnLock(lock)
    FreeDosObject(DOS_FIB,f_info)
    RETURN FALSE
  ENDIF
  
  IF(f_info.direntrytype>0)
    WHILE((ExNext(lock,f_info))<>0)
      size:=f_info.size

      IF cmdType=CMDTYPE_MLSD
        formatFileDate2(f_info.datestamp,tempstr)
        StringF(dirline,'type=file;size=\d;modify=\s;perm=rw; \s\b\n',size,tempstr,f_info.filename)
      ELSEIF cmdType=CMDTYPE_NLST
        StrCopy(dirline,f_info.filename)
      ELSE /*cmdtype = CMDTYPE_LIST as default */
        formatFileDate(f_info.datestamp,tempstr)
        StringF(dirline,'-rw-rw-rw-   1 root  root \r\d[10] \s \s\b\n',size,tempstr,f_info.filename)
      ENDIF
      writeLineEx(sb,data_c, dirline)
    ENDWHILE
  ENDIF

  UnLock(lock)
  FreeDosObject(DOS_FIB,f_info)
ENDPROC TRUE

PROC downloadDir(sb,data_c, ftpData:PTR TO ftpData,cmdType)
  DEF lock
  DEF f_info: PTR TO fileinfoblock
  DEF tempstr[255]:STRING
  DEF dirline[255]:STRING
  DEF fn
  DEF i,size
  DEF item:PTR TO flagFileItem
  DEF fileList:PTR TO stdlist
    
  fileList:=ftpData.fileList 

  f_info:=AllocDosObject(DOS_FIB,NIL)
  IF(f_info)=NIL THEN RETURN 

  FOR i:=0 TO fileList.count()-1
    item:=fileList.item(i)
    fn:=item.fileName
    lock:=Lock(fn,ACCESS_READ)
    size:=0
    StrCopy(tempstr,'JAN-01-0001 00:00')
    IF(lock)<>0
      IF(Examine(lock,f_info))<>0
        size:=f_info.size
      ENDIF
      UnLock(lock)
    ENDIF

    IF cmdType=CMDTYPE_MLSD
      formatFileDate2(f_info.datestamp,tempstr)
      StringF(dirline,'Type=file;Size=\d;Modify=\s;Perm=r; \s\b\n',size,tempstr,f_info.filename)
    ELSEIF cmdType=CMDTYPE_NLST
      StrCopy(dirline,f_info.filename)
    ELSE /*cmdType=CMDTYPE_LIST as default*/
      formatFileDate(f_info.datestamp,tempstr)
      StringF(dirline,'-r--r--r--   1 root  root \r\d[10] \s \s\b\n',size,tempstr,f_info.filename)
    ENDIF
    writeLineEx(sb,data_c, dirline)
  ENDFOR
  FreeDosObject(DOS_FIB,f_info) 
ENDPROC TRUE

PROC fullDir(sb,data_c, ftpData:PTR TO ftpData,cmdType)
  DEF i
  DEF tempstr[255]:STRING
  DEF dirline[255]:STRING
  DEF filedate:datestamp

  IF (ftpData.currentConf=0)
    dateTimeToDateStamp(getSystemTime(),filedate)
    
    FOR i:=0 TO ftpData.confNames.count()-1
      IF cmdType=CMDTYPE_MLSD
        formatFileDate2(filedate,tempstr)
        StringF(dirline,'type=dir;Modify=\s;perm=rw; \r\z\d[3]-\s\b\n',tempstr,i+1,ftpData.confNames.item(i))
      ELSEIF cmdType=CMDTYPE_NLST
        StringF(dirline,'\r\z\d[3]-\s\b\n',ftpData.confNames.item(i))
      ELSE /*cmdtype = CMDTYPE_LIST as default */
        formatFileDate(filedate,tempstr)
        StringF(dirline,'drw-rw-rw-   1 root  root \r\d[10] \s \r\z\d[3]-\s\b\n',0,tempstr,i+1,ftpData.confNames.item(i))
      ENDIF
      writeLineEx(sb,data_c, dirline)
    ENDFOR
    RETURN TRUE
  ENDIF

  IF ftpData.callersLog      
    callersLog(ftpData,'\tDirectory Scan via ftp')
  ENDIF
  
  makeConfFileList(ftpData,cmdType,sb,data_c)

ENDPROC

PROC sendFileDetails(filename:PTR TO CHAR, fileSize, fileDate, cmdType, sb, data_c, output)
  DEF filedatets:datestamp
  DEF tempstr[255]:STRING
  DEF dirline[255]:STRING

  dateTimeToDateStamp(fileDate,filedatets)
  
  IF fileSize=-1
    IF cmdType=CMDTYPE_MLSD
      formatFileDate2(filedatets,tempstr)
      StringF(dirline,'Type=dir;Modify=\s;Perm=r; \s\b\n',tempstr,FilePart(filename))
    ELSEIF cmdType=CMDTYPE_NLST
      StrCopy(dirline,filename)
    ELSE /*cmdType=CMDTYPE_LIST as default*/
      formatFileDate(filedatets,tempstr)
      StringF(dirline,'dr--r--r--   1 root  root \r\d[10] \s \s\b\n',0,tempstr,FilePart(filename))
    ENDIF
  ELSE
    IF cmdType=CMDTYPE_MLSD
      formatFileDate2(filedatets,tempstr)
      StringF(dirline,'Type=file;Size=\d;Modify=\s;Perm=r; \s\b\n',fileSize,tempstr,FilePart(filename))
    ELSEIF cmdType=CMDTYPE_NLST
      StrCopy(dirline,filename)
    ELSE /*cmdType=CMDTYPE_LIST as default*/
      formatFileDate(filedatets,tempstr)
      StringF(dirline,'-r--r--r--   1 root  root \r\d[10] \s \s\b\n',fileSize,tempstr,FilePart(filename))
    ENDIF
  ENDIF
  IF output
    IF ((EstrLen(output)+EstrLen(dirline))>StrMax(output))
      writeLineEx(sb,data_c, output)
      StrCopy(output,'')
    ENDIF
    StrAdd(output,dirline)
  ELSE
    writeLineEx(sb,data_c, dirline)
  ENDIF

ENDPROC

PROC makeList(path:PTR TO CHAR,dirCache:PTR TO CHAR,fib:PTR TO fileinfoblock, startDate, cmdType, sb, data_c)
  DEF fLock
  DEF d,fh
  DEF dirLine[40]:STRING
  DEF tmp[10]:STRING
  DEF c=FALSE
  DEF mem,fs,p,cnt
  DEF output
  
  output:=String(10000)
  
  fs:=FileLength(dirCache)
  IF fs>0
    /*IF (mem:=New(fs+1))
      fh:=Open(dirCache,MODE_OLDFILE)
      Read(fh,mem,fs)
      p:=0
      WHILE (p<fs)
        StrCopy(dirLine,'')
        IF (cnt:=InStr(mem+p,'\n'))>=0
          StrCopy(dirLine,mem+p,cnt)
          p:=p+cnt+1
        ELSE
          StrCopy(dirLine,mem+p)
          p:=fs
        ENDIF
        IF StrLen(dirLine)>18
          c:=TRUE
          StrCopy(tmp,'$')
          StrAdd(tmp,dirLine,8)
          d:=Val(tmp)
          IF d>=startDate
            StrCopy(tmp,'$')
            StrAdd(tmp,dirLine+9,8)
            sendFileDetails(dirLine+18,Val(tmp),d,cmdType, sb, data_c, output)
          ENDIF
        ENDIF        
      ENDWHILE
      Close(fh)
      Dispose(mem)
    ELSE*/
      fh:=Open(dirCache,MODE_OLDFILE)
      IF fh<>0
        WHILE(Fgets(fh,dirLine,40)<>NIL)
          IF StrLen(dirLine)>18
            c:=TRUE
            StrCopy(tmp,'$')
            StrAdd(tmp,dirLine,8)
            d:=Val(tmp)
            IF d>=startDate
              StrCopy(tmp,'$')
              StrAdd(tmp,dirLine+9,8)
              sendFileDetails(dirLine+18,Val(tmp),d,cmdType, sb, data_c, output)
            ENDIF
          ENDIF
        ENDWHILE
        Close(fh)
      ENDIF
    //ENDIF
    IF (output ANDALSO (EstrLen(output)>0))
      writeLineEx(sb,data_c, output)
    ENDIF
    IF c 
      DisposeLink(output) 
      RETURN
    ENDIF

  ENDIF

  IF((fLock:=Lock(path,ACCESS_READ)))   
    IF((Examine(fLock,fib)))
      IF(fib.direntrytype > 0)
        WHILE(ExNext(fLock,fib))
          IF StrCmp(fib.filename,'.dircache')=FALSE
            d:=dateStampToDateTime(fib.datestamp)
            IF d>=startDate
              sendFileDetails(fib.filename,IF fib.direntrytype>0 THEN -1 ELSE fib.size,d,cmdType, sb, data_c, output)
            ENDIF
          ENDIF
        ENDWHILE
      ENDIF
    ENDIF
    UnLock(fLock)
  ENDIF
  IF (output ANDALSO (EstrLen(output)>0)) THEN writeLineEx(sb,data_c, output)
  DisposeLink(output) 
ENDPROC
   

PROC makeFtpListFromDlDirs(ftpData:PTR TO ftpData, startDate, cmdType, sb, data_c)
  DEF path[255]:STRING
  DEF dirCache[255]:STRING
  DEF fib:PTR TO fileinfoblock
  DEF dirNum,i

  IF((fib:=AllocDosObject(DOS_FIB,NIL)))=NIL
    RETURN FALSE
  ENDIF

  dirNum:=1
  StringF(path,'DLPATH.\d',dirNum++)
  WHILE(readToolType(TOOLTYPE_CONF,ftpData.confNums.item(ftpData.currentConf-1),path,path))
    checkPathSlash(path)
    IF StrLen(ftpData.subDirPath)
      StrAdd(path,ftpData.subDirPath)
      checkPathSlash(path)
    ENDIF
    
    StringF(dirCache,'RAM:DirCaches/Conf\dDir\d\s\s',ftpData.currentConf,dirNum-1,IF StrLen(ftpData.subDirPath)>0 THEN '_' ELSE '', ftpData.subDirPath)
    FOR i:=14 TO StrLen(dirCache)-1 DO IF dirCache[i]="/" THEN dirCache[i]:="_"
    
    makeList(path,dirCache,fib,startDate,cmdType,sb,data_c)
    StringF(path,'DLPATH.\d',dirNum++)
  ENDWHILE

  FreeDosObject(DOS_FIB,fib)

ENDPROC

PROC makeFtpListFromDirList(ftpData:PTR TO ftpData, startDate, cmdType, sb, data_c)
  DEF dtStr[20]:STRING
  DEF sizeStr[20]:STRING
  DEF dtcomp1,dtcomp2
  DEF dirNum,found=FALSE,spPos
  DEF dirFile[255]:STRING
  DEF tempstr[255]:STRING
  DEF fh,t,sz,m,d,y
  DEF output

  DEF maxDirs

  output:=String(10000)

  maxDirs:=readToolTypeInt(TOOLTYPE_CONF,ftpData.confNums.item(ftpData.currentConf-1),'NDIRS')

  formatLongDate(startDate,dtStr)
  dtcomp1:=getDateCompareVal(dtStr)

  dirNum:=maxDirs+1
  REPEAT
    dirNum--
    StringF(dirFile,'\sDIR\d',ftpData.confDirs.item(ftpData.currentConf-1),dirNum)   
    fh:=Open(dirFile,MODE_OLDFILE)
    IF fh<>0
    
      IF(Fgets(fh,tempstr,255)<>NIL) AND (StrLen(tempstr)>0)
        tempstr[255]:=0
        SetStr(tempstr,StrLen(tempstr))      
        IF (dirLineNewFile(tempstr))
          t:=TrimStr(tempstr+14)
          spPos:=InStr(t,' ')               
          StrCopy(dtStr,TrimStr(t+spPos))

          IF (StrLen(dtStr)>=8) AND (dtStr[2]="-") AND (dtStr[5]="-")
            dtcomp2:=getDateCompareVal(dtStr)
          
            IF dtcomp2<dtcomp1 THEN found:=TRUE
          ENDIF
        ENDIF
      ENDIF
    
      IF (found=FALSE) AND (dirNum>1) THEN Close(fh)
    ENDIF
  UNTIL (found) OR (dirNum=1)
  
  WHILE (dirNum<=maxDirs) AND (fh<>0)
    found:=FALSE
    REPEAT
      IF StrLen(tempstr)>0
        IF dirLineNewFile(tempstr)
        
          IF found=FALSE
            t:=TrimStr(tempstr+14)
            spPos:=InStr(t,' ')               
            StrCopy(dtStr,TrimStr(t+spPos))
            
            IF (StrLen(dtStr)>=8) AND (dtStr[2]="-") AND (dtStr[5]="-")
              dtcomp2:=getDateCompareVal(dtStr)
            
              IF dtcomp2>=dtcomp1 THEN found:=TRUE
            ENDIF
          ENDIF
          
          IF found
            StrCopy(sizeStr,TrimStr(tempstr+14))
            spPos:=InStr(sizeStr,' ')
            SetStr(sizeStr,spPos)
            StrCopy(dtStr,TrimStr(tempstr+23))
            SetStr(dtStr,8)
            m,d,y:=decodeDateStr(dtStr)
            
            sz:=Val(sizeStr)
            IF (InStr(sizeStr,'.')>=0) THEN sz:=sz+1
            IF (InStr(sizeStr,'M')>=0) THEN sz:=Mul(sz,1048576)
            
            spPos:=InStr(tempstr,' ')
            SetStr(tempstr,spPos)
            sendFileDetails(tempstr,sz,encodeDate(m,d,y),cmdType, sb, data_c, output)
          ENDIF
        ENDIF
      ENDIF
    UNTIL (Fgets(fh,tempstr,255)=0)
    Close(fh)
    dirNum++
    IF dirNum<=maxDirs
      StringF(dirFile,'\sDIR\d',ftpData.confDirs.item(ftpData.currentConf-1),dirNum)   
      fh:=Open(dirFile,MODE_OLDFILE)
    ENDIF
  ENDWHILE
  IF (output ANDALSO (EstrLen(output)>0)) THEN writeLineEx(sb,data_c, output)
  DisposeLink(output)
ENDPROC

PROC makeConfFileList(ftpData:PTR TO ftpData, cmdType, sb, data_c)
  DEF startDate,dayOffset
  
  dayOffset:=readToolTypeInt(TOOLTYPE_CONF,ftpData.confNums.item(ftpData.currentConf-1),'FTP_DIR_DAYS')
  IF dayOffset=-1 THEN dayOffset:=10
  dayOffset:=Mul(dayOffset,86400)
  
  startDate:=getSystemDate()-dayOffset

 
  IF ftpData.currentConf>0
    IF (StrLen(ftpData.subDirPath)>0)
      makeFtpListFromDlDirs(ftpData,startDate,cmdType, sb, data_c)
    ELSEIF checkToolTypeExists(TOOLTYPE_CONF,ftpData.confNums.item(ftpData.currentConf-1),'FTP_NO_DIRLIST')
      makeFtpListFromDlDirs(ftpData,startDate,cmdType, sb, data_c)
    ELSE
      makeFtpListFromDirList(ftpData,startDate,cmdType, sb, data_c)
    ENDIF
  ENDIF
ENDPROC

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

PROC cmdPwd(sb,ftp_c,ftpData:PTR TO ftpData)
  DEF sendStr[300]:STRING
  DEF dirName[255]:STRING
  IF ftpData.mode=MODE_FULLSERVER
    IF ftpData.currentConf=0
      StrCopy(sendStr, '257 "/" is current directory.\b\n')
      writeLineEx(sb,ftp_c,sendStr)
    ELSE
     
      StringF(dirName,'/\r\z\d[3]-\s',ftpData.currentConf,ftpData.confNames.item(ftpData.currentConf-1))
      IF StrLen(ftpData.subDirPath)>0
        StrAdd(dirName,'/')
        StrAdd(dirName,ftpData.subDirPath)
      ENDIF
      StringF(sendStr, '257 "\s" is current directory.\b\n',dirName)
      writeLineEx(sb,ftp_c,sendStr)
    ENDIF
  ELSE
    writeLineEx(sb,ftp_c, '257 "/" is the current directory\b\n')
  ENDIF
ENDPROC

PROC cmdSyst(sb,ftp_c)
  writeLineEx(sb,ftp_c, '215 AmigaOS\b\n')
ENDPROC

PROC cmdFeat(sb,ftp_c)
  writeLineEx(sb,ftp_c, '211-Extensions supported:\b\n')
  writeLineEx(sb,ftp_c, ' REST STREAM\b\n')
  writeLineEx(sb,ftp_c, ' SIZE\b\n')
  writeLineEx(sb,ftp_c, ' MDTM\b\n')
  writeLineEx(sb,ftp_c, ' MLST type*;size*;modify*;perm*;\b\n')
  writeLineEx(sb,ftp_c, '211 END\b\n')
ENDPROC

PROC cmdNoop(sb,ftp_c)
  writeLineEx(sb,ftp_c, '200 OK\b\n')
ENDPROC

PROC cmdCwd(sb,ftp_c,ftpData:PTR TO ftpData,path:PTR TO CHAR)
  DEF sendStr[255]:STRING
  DEF temp[255]:STRING
  DEF outFileName[255]:STRING
  DEF stat,i,p

  IF ftpData.mode=MODE_FULLSERVER
    IF StrCmp(path,'/')
      StrCopy(sendStr, '250 CWD command successful.\b\n')
      writeLineEx(sb,ftp_c,sendStr) 
      StrCopy(ftpData.subDirPath,'')
      ftpData.currentConf:=0
    ELSEIF StrCmp(path,'..')
      IF ftpData.currentConf<>0
        StrCopy(sendStr, '250 CWD command successful.\b\n')
        writeLineEx(sb,ftp_c,sendStr) 
        
        IF StrLen(ftpData.subDirPath)>0
          IF InStr(ftpData.subDirPath,'/')>=0
            p:=StrLen(ftpData.subDirPath)-1
            WHILE ftpData.subDirPath[p]<>"/" DO p--
            SetStr(ftpData.subDirPath,p)
          ELSE
            StrCopy(ftpData.subDirPath,'')
          ENDIF
        ELSE
          ftpData.currentConf:=0
        ENDIF
      ELSE
        StringF(sendStr, '550 \s: No such file or directory.\b\n',path)
        writeLineEx(sb,ftp_c,sendStr) 
      ENDIF
    ELSE
      stat:=-1
      FOR i:=0 TO ftpData.confNames.count()-1
        StringF(temp,'/\r\z\d[3]-\s',i+1,ftpData.confNames.item(i))
        IF StrCmp(temp,path) THEN stat:=i
      ENDFOR
      
      IF stat=-1
        IF ftpData.currentConf=0
          FOR i:=0 TO ftpData.confNames.count()-1
            StringF(temp,'\r\z\d[3]-\s',i+1,ftpData.confNames.item(i))
            IF StrCmp(temp,path) THEN stat:=i
          ENDFOR
        ENDIF
      ENDIF

      IF stat>=0
        StrCopy(sendStr, '250 CWD command successful.\b\n')
        writeLineEx(sb,ftp_c,sendStr) 
        ftpData.currentConf:=stat+1
        getPath(ftpData,ftpData.confNums.item(ftpData.currentConf-1),'',outFileName)
        StrCopy(ftpData.subDirPath,'')
        RETURN
      ENDIF

      FOR i:=0 TO ftpData.confNames.count()-1
        StringF(temp,'/\r\z\d[3]-\s/',i+1,ftpData.confNames.item(i))
        IF StrCmp(temp,path,StrLen(temp))
          stat:=i
          StrCopy(path,path+StrLen(temp))
        ENDIF
      ENDFOR

      IF stat=-1
        IF ftpData.currentConf=0
          FOR i:=0 TO ftpData.confNames.count()-1
            StringF(temp,'\r\z\d[3]-\s/',i+1,ftpData.confNames.item(i))
            IF StrCmp(temp,path,StrLen(temp))
              stat:=i
              StrCopy(path,path+StrLen(temp))
            ENDIF
          ENDFOR
        ENDIF
      ENDIF

      IF stat>=0
        ftpData.currentConf:=stat+1
        getPath(ftpData,ftpData.confNums.item(ftpData.currentConf-1),path,outFileName)
        IF StrLen(outFileName)>0
          StrCopy(ftpData.subDirPath,path)
        ELSE
          stat:=-1
        ENDIF
      ELSE
        IF ftpData.currentConf<>0
          IF StrLen(ftpData.subDirPath)>0 THEN StringF(path,'\s/\s',ftpData.subDirPath,path)
          getPath(ftpData,ftpData.confNums.item(ftpData.currentConf-1),path,outFileName)
          IF StrLen(outFileName)>0
            StrCopy(ftpData.subDirPath,path)
            stat:=1
          ENDIF
        ENDIF
      ENDIF

      IF stat>=0
        StrCopy(sendStr, '250 CWD command successful.\b\n')
        writeLineEx(sb,ftp_c,sendStr) 
      ELSE
        StringF(sendStr, '550 \s: No such file or directory.\b\n',path)
        writeLineEx(sb,ftp_c,sendStr) 
      ENDIF
    ENDIF  
  ELSE
    IF StrCmp(path,'/')=FALSE
      StringF(sendStr,'550 \s: No such file or directory\b\n',path)
      writeLineEx(sb,ftp_c,sendStr)
    ELSE
      writeLineEx(sb,ftp_c, '250 CWD command successful\b\n') 
    ENDIF
  ENDIF
ENDPROC

PROC cmdType(sb,ftp_c,params,ftpData:PTR TO ftpData)
  DEF temp[255]:STRING
  IF StriCmp(params,'I') OR StriCmp(params,'A')
    ftpData.transType:=params[0]
    StringF(temp,'200 Type set to \s!!!\b\n',params)
  ELSE
    StringF(temp,'502 Type not implemented\b\n',params)
  ENDIF
  writeLineEx(sb,ftp_c,temp)
ENDPROC

PROC cmdPort(sb,ftp_c)
  writeLineEx(sb,ftp_c, '502 Only passive mode allowed\b\n')
ENDPROC

PROC cmdMode(sb,ftp_c,params)
  DEF temp[255]:STRING
  IF StriCmp(params,'S')
    StringF(temp,'200 Mode set to \s!!!\b\n',params)
  ELSE
    StringF(temp,'502 Mode not implemented\b\n',params)
  ENDIF
  writeLineEx(sb,ftp_c,temp)
ENDPROC

PROC cmdStru(sb,ftp_c,params)
  DEF temp[255]:STRING
  IF StriCmp(params,'F')
    StringF(temp,'200 Structure set to \s!!!\b\n',params)
  ELSE
    StringF(temp,'502 Strucrure not implemented\b\n',params)
  ENDIF
  writeLineEx(sb,ftp_c,temp)
ENDPROC

PROC cmdMdtm(sb,ftp_c,filename:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF fn[255]:STRING
  DEF ds:datestamp
  DEF temp[255]:STRING
  DEF outDateStr[255]:STRING

  IF filename[0]="/" THEN filename++
  getFileName(ftpData,filename,fn)
  IF StrLen(fn) AND (getFileDate(fn,ds))
    formatFileDate2(ds,outDateStr)
    StringF(temp,'213 \s\b\n',outDateStr)
    writeLineEx(sb,ftp_c,temp)
  ELSE
    StringF(temp,'550 \s: No such file or directory\b\n',filename)
    writeLineEx(sb,ftp_c,temp)
  ENDIF
ENDPROC

PROC cmdSize(sb,ftp_c,filename:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF fn[255]:STRING
  DEF temp[255]:STRING
  DEF len

  IF filename[0]="/" THEN filename++
  getFileName(ftpData,filename,fn)
  
  IF StrLen(fn)
    len:=FileLength(fn)
  ELSE
    len:=-1   
  ENDIF
    
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
  DEF fh,pos,t,t2,startTime
  DEF cps,lastpos
  DEF asynclib
  DEF i,n,done

  IF ftpData.filenameCAPS THEN upperChars(filename)

  IF (ftpData.transType<>"I") AND (ftpData.transType<>"A")
    StringF(temp,'550 This server only supports binary or acii transfers\b\n',filename)
    writeLineEx(sb,ftp_c,temp)

    IF (data_c>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_c)
      data_c:=-1
    ENDIF
    
    IF (data_s>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_s)
      data_s:=-1
    ENDIF
    RETURN
  ENDIF

  IF invalidFn(filename)
    StringF(temp,'553 \s: Invalid filename\b\n',filename)
    writeLineEx(sb,ftp_c,temp)

    IF (data_c>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_c)
      data_c:=-1
    ENDIF
    
    IF (data_s>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_s)
      data_s:=-1
    ENDIF

    IF ftpData.callersLog      
      callersLog(ftpData,'\tUpload Failed..')
      StringF(temp,'\tInvalid filename \s',filename)
      callersLog(ftpData,temp)
    ENDIF
    RETURN
  ENDIF

  IF (ftpData.fileDupeCheck<>NIL)
    IF fileDupeCheck(ftpData,filename)=TRUE
      StringF(temp,'553 \s: Duplicate file skipped\b\n',filename)
      writeLineEx(sb,ftp_c,temp)

      IF (data_c>=0)
        ftpData.scount:=ftpData.scount-1
        r:=closeSocket(sb,data_c)
        data_c:=-1
      ENDIF
      
      IF (data_s>=0)
        ftpData.scount:=ftpData.scount-1
        r:=closeSocket(sb,data_s)
        data_s:=-1
      ENDIF

      IF ftpData.callersLog      
        callersLog(ftpData,'\tUpload Failed..')
        StringF(temp,'\tSkipped \s',filename)
        callersLog(ftpData,temp)
      ENDIF

      RETURN
    ENDIF
  ENDIF

  IF (ftpData.mode=MODE_FULLSERVER) AND (ftpData.currentConf=0)
    StrCopy(temp,'550 Cant upload here\b\n')
    writeLineEx(sb,ftp_c,temp)

    IF (data_c>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_c)
      data_c:=-1
    ENDIF
    
    IF (data_s>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_s)
      data_s:=-1
    ENDIF

    RETURN
  ENDIF

  IF ftpData.confULBlock<>NIL
    IF ftpData.currentConf>0
      IF StrLen(ftpData.confULBlock.item(ftpData.currentConf-1))
        StringF(temp,'550 \s\b\n',ftpData.confULBlock.item(ftpData.currentConf-1))
        writeLineEx(sb,ftp_c,temp)
        IF (data_c>=0)
          ftpData.scount:=ftpData.scount-1
          r:=closeSocket(sb,data_c)
          data_c:=-1
        ENDIF
        
        IF (data_s>=0)
          ftpData.scount:=ftpData.scount-1
          r:=closeSocket(sb,data_s)
          data_s:=-1
        ENDIF
        RETURN
      ENDIF
    ENDIF
  ENDIF


  IF ftpData.mode=MODE_DOWNLOAD
    StringF(temp,'550 \s: Not expecting any uploads\b\n',filename)
    writeLineEx(sb,ftp_c,temp)

    IF (data_c>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_c)
      data_c:=-1
    ENDIF
    
    IF (data_s>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_s)
      data_s:=-1
    ENDIF

    RETURN
  ENDIF

  asynclib:=OpenLibrary('asyncio.library',0)
  asynciobase:=asynclib

  IF (data_c>=0)
    IF filename[0]="/" THEN filename++
    StringF(fn,'\s\s',ftpData.uploadPath,filename)
    StringF(temp,'150 Opening \s connection\b\n',IF (ftpData.transType="I") THEN 'Binary' ELSE 'Ascii')
    writeLineEx(sb,ftp_c,temp)

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
      IF ftpData.uploadFileStart<>NIL
        uploadFileStart(ftpData,filename,ftpData.restPos)
      ENDIF
      
      buff:=New(32768)
      t:=fastSystemTime()
      startTime:=t
      lastpos:=ftpData.restPos
      cps:=0
      REPEAT
        l:=recv(sb,data_c, buff,32768,0)
        
        IF (l>0)
          IF (ftpData.transType="A")
            ->ascii transfer remove all CR characters
            n:=0
            FOR i:=0 TO l-1
              IF n<>i THEN buff[n]:=buff[i]
              IF buff[i]<>13 THEN n++
            ENDFOR
            l:=n
          ENDIF
          
          IF asynclib<>NIL
            WriteAsync(fh,buff,l)
          ELSE
            Fwrite(fh,buff,1,l)
          ENDIF
          IF ftpData.uploadFileProgress<>NIL
            t2:=fastSystemTime()
            ->only call update maximum every 1 second
            IF (Abs(t2-t))>=50
              processMessages(ftpData)
              IF asynclib<>NIL
                pos:=SeekAsync(fh,0,MODE_CURRENT)
              ELSE
                pos:=Seek(fh,0,OFFSET_CURRENT)
              ENDIF
              cps:=calcCPS(pos-lastpos,t,t2)
              lastpos:=pos
              uploadFileProgress(ftpData,filename,pos,cps)
              t:=t2
            ENDIF
          ENDIF
          break:=CtrlC()
         ENDIF
         
         IF (l=-1) AND (errno(sb)=EINTR) THEN l:=1
      UNTIL (l<=0) OR (break)
      Dispose(buff)

      IF ftpData.uploadFileProgress<>NIL
        IF asynclib<>NIL
          pos:=SeekAsync(fh,0,MODE_CURRENT)
        ELSE
          pos:=Seek(fh,0,OFFSET_CURRENT)
        ENDIF
        t2:=fastSystemTime()
        cps:=calcCPS(pos-ftpData.restPos,startTime,t2)
        uploadFileProgress(ftpData,filename,pos,cps)
      ENDIF
      IF asynclib<>NIL
        CloseAsync(fh)
      ELSE
        Close(fh)
      ENDIF

      success:=(break=FALSE) AND (l=0)

      IF ftpData.uploadFileEnd<>NIL
        uploadFileEnd(ftpData,filename,success)
      ENDIF

      StringF(temp, '226-\s ... Upload complete, file check in progress.. \b\n', filename)
      writeLineEx(sb,ftp_c,temp)

      IF ftpData.startFileCheck<>NIL
        startFileCheck(ftpData,filename,success)
      ENDIF

      REPEAT
        IF ftpData.waitFileCheck<>NIL
          done:=waitFileCheck(ftpData,10)
        ELSE
          done:=TRUE
        ENDIF
        IF (done=FALSE) AND (success)
          StringF(temp, '226-Please wait, Checking..\b\n')
          writeLineEx(sb,ftp_c,temp)
        ENDIF
      UNTIL done
      
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
    data_c:=-1
  ENDIF
  
  IF (data_s>=0)
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_s)
    data_s:=-1
  ENDIF
  /*aePuts(ftpData,'Data connection closed\b\n')*/
  IF asynclib<>NIL THEN CloseLibrary(asynclib)
ENDPROC

PROC cmdRetr(sb,ftp_c,data_s,data_c,filename:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF temp[255]:STRING
  DEF res[255]:STRING
  DEF success=FALSE
  DEF break=FALSE
  DEF buff
  DEF asynclib
  DEF fn[255]:STRING
  DEF r,l,pos,cps,lastpos,flen
  DEF fh
  DEF t,t2,startTime
  DEF candl=TRUE


  IF (ftpData.transType<>"I") AND (ftpData.transType<>"A")
    StringF(temp,'550 This server only supports binary or acii transfers\b\n',filename)
    writeLineEx(sb,ftp_c,temp)
    RETURN
  ENDIF

  asynclib:=OpenLibrary('asyncio.library',0)
  asynciobase:=asynclib
  
  IF ftpData.mode=MODE_UPLOAD
    StringF(temp,'550 \s: No such file or directory\b\n',filename)
    writeLineEx(sb,ftp_c,temp)
    IF (data_c>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_c)
      data_c:=-1
    ENDIF
    
    IF (data_s>=0)
      ftpData.scount:=ftpData.scount-1
      r:=closeSocket(sb,data_s)
      data_s:=-1
    ENDIF
    RETURN
  ENDIF

  IF (data_c>=0)
    IF filename[0]="/" THEN filename++   
   
    getFileName(ftpData,filename,fn)
    fh:=0
    flen:=0
    IF StrLen(fn)
      flen:=FileLength(fn)
      IF asynclib<>NIL
        writeLineEx(sb,ftp_c, '150 Opening BINARY connection with ASYNC\b\n')
        fh:=OpenAsync(fn,MODE_READ,32768)
      ELSE
        writeLineEx(sb,ftp_c, '150 Opening BINARY connection with no ASYNC\b\n')

        fh:=Open(fn,MODE_OLDFILE)
      ENDIF
    ENDIF
    IF fh=0
      StringF(temp,'/XFTP: open error \s \d\b\n',fn,IoErr())
      aePuts(ftpData,temp)
      StringF(temp,'550 \s: No such file or directory\b\n',filename)
      writeLineEx(sb,ftp_c,temp)
    ELSE
   
      IF (ftpData.downloadFileStart<>NIL) OR (ftpData.checkDownloadRatio<>NIL)
        
        pos:=ftpData.restPos
        IF asynclib<>NIL
          SeekAsync(fh,pos,MODE_START)
        ELSE
          Seek(fh,pos,OFFSET_BEGINNING)
        ENDIF
        IF (ftpData.checkDownloadRatio<>NIL) ANDALSO (checkDownloadRatio(ftpData,fn,flen,res)=FALSE)
          StringF(temp,'550 \s\b\n',res)
          writeLineEx(sb,ftp_c,temp)
          candl:=FALSE
        ENDIF
        IF (ftpData.downloadFileStart<>NIL) THEN downloadFileStart(ftpData,fn,flen,pos)
      ENDIF
      IF candl
        buff:=New(32768)
        t:=fastSystemTime()
        startTime:=t
        lastpos:=ftpData.restPos
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
            IF (r>0) AND (ftpData.downloadFileProgress<>NIL)
              t2:=fastSystemTime()
              ->only call update maximum every 1 second
              IF (Abs(t2-t))>=50
                processMessages(ftpData)
                IF asynclib<>NIL
                  pos:=SeekAsync(fh,0,MODE_CURRENT)
                ELSE
                  pos:=Seek(fh,0,OFFSET_CURRENT)
                ENDIF
                cps:=calcCPS(pos-lastpos,t,t2)
                lastpos:=pos
                downloadFileProgress(ftpData,filename,pos,cps)
                t:=t2
              ENDIF
            ENDIF
          ENDIF
          break:=CtrlC() OR (r<>l)
        UNTIL (l=0) OR (break)
        Dispose(buff)

        IF ftpData.downloadFileProgress<>NIL
          IF asynclib<>NIL
            pos:=SeekAsync(fh,0,MODE_CURRENT)
          ELSE
            pos:=Seek(fh,0,OFFSET_CURRENT)
          ENDIF
          t2:=fastSystemTime()
          cps:=calcCPS(pos-ftpData.restPos,startTime,t2)
          downloadFileProgress(ftpData,fn,pos,cps)
        ENDIF
        IF asynclib<>NIL
          CloseAsync(fh)
        ELSE
          Close(fh)
        ENDIF
        success:=(break=FALSE)
        IF ftpData.downloadFileEnd<>NIL
          downloadFileEnd(ftpData,fn,success)
        ENDIF

        StringF(temp, '\d \s ... \s\b\n', 
        IF (success) THEN 226 ELSE 426, 
        filename, 
        IF (success) THEN 'Transfer Complete' ELSE 'Transfer aborted')

        writeLineEx(sb,ftp_c, temp)
      ENDIF
    ENDIF
    
  ELSE
    writeLineEx(sb,ftp_c, '425 Can''t open data connection\b\n')
  ENDIF

  IF (data_c>=0)
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_c)
    data_c:=-1
  ENDIF
  
  IF (data_s>=0)
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_s)
    data_s:=-1
  ENDIF
  IF asynclib<>NIL 
    CloseLibrary(asynclib)
  ENDIF
  /*aePuts(ftpData,'Data connection closed\b\n')*/
ENDPROC

PROC cmdMlst(sb,ftp_c,data_s,data_c,filename:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF fn[255]:STRING
  DEF ds:datestamp
  DEF temp[255]:STRING
  DEF outDateStr[255]:STRING
  DEF size

  IF filename[0]="/" THEN filename++
  getFileName(ftpData,filename,fn)
  IF StrLen(fn) AND (getFileDate(fn,ds))
    size:=FileLength(fn)
    formatFileDate2(ds,outDateStr)
    StringF(temp,'250- Listing \s\b\n',FilePart(fn))
    writeLineEx(sb,ftp_c,temp)   
    StringF(temp,' type=file;size=\d;modify=\s;perm=rw; \s\b\n',size,outDateStr,FilePart(fn))
    writeLineEx(sb,ftp_c,temp)   
    writeLineEx(sb,ftp_c,'250 End\b\n')
  ELSE
    StringF(temp,'550 \s: No such file or directory\b\n',filename)
    writeLineEx(sb,ftp_c,temp)
  ENDIF
ENDPROC

PROC cmdMlsd(sb,ftp_c,data_s,data_c,params:PTR TO CHAR,ftpData:PTR TO ftpData)
  DEF r
  DEF temp[255]:STRING
  DEF ftpDir

  IF (StrLen(params)=0) OR StrCmp(params,'/')
    StringF(temp, '150 Opening \s connection for directory listing\b\n', IF ftpData.transType="I" THEN 'Binary' ELSE 'ASCII')
    writeLineEx(sb,ftp_c,temp)

    ftpDir:=ftpData.ftpDir
    ftpDir(sb,data_c,ftpData,CMDTYPE_MLSD)

    writeLineEx(sb,ftp_c, '226 Transfer Complete\b\n')
  ELSE
    StringF(temp,'550 \s: No such file or directory\b\n',params)
    writeLineEx(sb,ftp_c,temp)
  ENDIF
  IF data_c>=0
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_c)
    data_c:=-1
  ENDIF
  IF data_s>=0
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_s)
    data_s:=-1
  ENDIF
ENDPROC

PROC cmdList(sb,ftp_c,data_s,data_c,ftpData:PTR TO ftpData,cmdType)
  DEF r
  DEF temp[255]:STRING
  DEF ftpDir
  
  IF (data_c>=0)  
    StringF(temp, '150 Opening \s connection for directory listing\b\n', IF ftpData.transType="I" THEN 'Binary' ELSE 'ASCII')
    writeLineEx(sb,ftp_c,temp)

    ftpDir:=ftpData.ftpDir
    ftpDir(sb,data_c,ftpData,cmdType)

    writeLineEx(sb,ftp_c, '226 Transfer Complete\b\n')
  ELSE
    writeLineEx(sb,ftp_c, '425 Can''t open data connection\b\n')
  ENDIF
  IF data_c>=0
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_c)
    data_c:=-1
  ENDIF
  IF data_s>=0
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_s)
    data_s:=-1
  ENDIF
  /*aePuts(ftpData,'Data connection closed\b\n')*/
ENDPROC

PROC mainFtpLoop(sb,ftp_c,ftpData:PTR TO ftpData)
  DEF request[255]:ARRAY OF CHAR
  DEF string[255]:STRING
  DEF r
  DEF data_s=-1,data_c=-1
   
  WHILE(((readLine(ftpData,sb,ftp_c, request, MAX_LINE-1)) > 0) AND (StrCmp(request, 'QUIT', 4)=FALSE)) AND (CtrlC()=FALSE)
    StringF(string,'\tFTP Command >: \s',request)
    IF ftpData.callersLog
      callersLog(ftpData,string)    
    ENDIF
    StrAdd(string,'\b\n')
    IF ftpData.conPuts THEN conPuts(ftpData,string)
    IF(StrCmp(request, 'USER ', 5))
      cmdUser(sb,ftp_c,request+5,ftpData)
    ELSEIF(StrCmp(request, 'PASS ', 5))
      cmdPass(sb,ftp_c,request+5,ftpData)
    ELSEIF(StrCmp(request, 'LIST'))
      cmdList(sb,ftp_c,data_s,data_c,ftpData,CMDTYPE_LIST)
      data_c:=-1
      data_s:=-1
    ELSEIF(StrCmp(request, 'NLST'))
      cmdList(sb,ftp_c,data_s,data_c,ftpData,CMDTYPE_NLST)
      data_c:=-1
      data_s:=-1     
    ELSEIF(StrCmp(request, 'MLSD'))
      cmdMlsd(sb,ftp_c,data_s,data_c,'',ftpData)
      data_c:=-1
      data_s:=-1
    ELSEIF(StrCmp(request, 'MLSD ',5))
      cmdMlsd(sb,ftp_c,data_s,data_c,request+5,ftpData)
      data_c:=-1
      data_s:=-1
    ELSEIF(StrCmp(request, 'MLST ',5))
      cmdMlst(sb,ftp_c,data_s,data_c,request+5,ftpData)
    ELSEIF(StrCmp(request, 'MLST'))
      cmdMlst(sb,ftp_c,data_s,data_c,'',ftpData)
    ELSEIF(StrCmp(request, 'FEAT'))
      cmdFeat(sb,ftp_c)
    ELSEIF(StrCmp(request, 'NOOP'))
      cmdNoop(sb,ftp_c)
    ELSEIF(StrCmp(request, 'PWD'))
      cmdPwd(sb,ftp_c,ftpData)
    ELSEIF(StrCmp(request, 'SYST'))
      cmdSyst(sb,ftp_c)
    ELSEIF(StrCmp(request, 'XPWD'))
      cmdPwd(sb,ftp_c,ftpData)
    ELSEIF(StrCmp(request, 'CDUP'))
      cmdCwd(sb,ftp_c,ftpData,'..')
    ELSEIF(StrCmp(request, 'CWD ', 4))
      cmdCwd(sb,ftp_c,ftpData,request+4)
    ELSEIF(StrCmp(request, 'XCWD ', 5))
      cmdCwd(sb,ftp_c,ftpData,request+5)
    ELSEIF(StrCmp(request, 'TYPE ', 5))
      cmdType(sb,ftp_c,request+5,ftpData)
    ELSEIF(StrCmp(request, 'MODE ', 5))
      cmdMode(sb,ftp_c,request+5)
    ELSEIF(StrCmp(request, 'STRU ', 5))
      cmdStru(sb,ftp_c,request+5)
    ELSEIF(StrCmp(request, 'PORT ', 5))
      cmdPort(sb,ftp_c)
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
    ELSEIF(StrCmp(request, 'PASV'))
      IF (data_s>=0)
        ftpData.scount:=ftpData.scount-1
        r:=closeSocket(sb,data_s)
      ENDIF
      IF (data_c>=0)
        ftpData.scount:=ftpData.scount-1
        r:=closeSocket(sb,data_c)
      ENDIF
      data_s,data_c:=cmdPasv(sb,ftp_c,ftpData.hostName,ftpData)
    ELSEIF StrLen(request)>0
      writeLineEx(sb,ftp_c, '500 command not recognized\b\n')
      ->WriteF('UNKNOWN command: \s\b\n', request);
    ENDIF
    ->IF errno<>0 THEN WriteF('error \d\b\n',errno)
  ENDWHILE
  writeLineEx(sb,ftp_c, '200 Byebye!\b\n')
  
  IF (data_s>=0)
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_s)
    data_s:=-1
  ENDIF
  IF (data_c>=0) 
    ftpData.scount:=ftpData.scount-1
    r:=closeSocket(sb,data_c)
    data_c:=-1
  ENDIF
ENDPROC
  

PROC ftpThread()
  DEF ftp_c,sockid
  DEF sb
  DEF ftpData:PTR TO ftpData

  ftpData:=loadA4()

  sockid:=ftpData.sockId
  
	sb:=OpenLibrary('bsdsocket.library',2)
  ftp_c:=obtainSocket(sb,sockid,AF_INET,SOCK_STREAM,0)

  ioctlSocket(sb,ftp_c,FIONBIO,[0])

  ftpData.scount:=ftpData.scount+1
  writeLineEx(sb,ftp_c, '220 Welcome to Ami-Express FTP server.\b\n')
     
  mainFtpLoop(sb,ftp_c,ftpData)
  
  IF (ftp_c>=0) 
    ftpData.scount:=ftpData.scount-1
    closeSocket(sb,ftp_c)
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
  tags:=NEW [NP_ENTRY,{ftpThread},NP_NAME,name,NP_STACKSIZE,10000,0]
 
  ftpData.sockId:=sockid

  Forbid()
  proc:=CreateNewProc(tags)
  saveA4(proc,ftpData,node)
  Permit()
  FastDisposeList(tags)
ENDPROC

EXPORT PROC ftpServerMode(ftpData:PTR TO ftpData, ftp_c,ftpHost:PTR TO CHAR,uploadPath:PTR TO CHAR,ftpDataPorts:PTR TO LONG,filenameCAPS)

  ftpData.rest:=0
  ftpData.tcount:=0
  ftpData.scount:=0
  ftpData.port:=-1
  ftpData.mode:=MODE_FULLSERVER
  ftpData.fileList:=NIL
  ftpData.restPos:=0
  ftpData.filenameCAPS:=filenameCAPS

  ftpData.workingPath:=String(255)
  ftpData.uploadPath:=String(255)
  ftpData.hostName:=String(255)
  ftpData.subDirPath:=String(1000)
  ftpData.dataPorts:=ftpDataPorts
  ftpData.ftpDir:={fullDir}
  ftpData.currentConf:=0
  ftpData.setReuseAddr:=TRUE

  IF ListLen(ftpDataPorts)>0 THEN testSocket(socketbase,ftpData,ftpDataPorts[0])

  StrCopy(ftpData.hostName,ftpHost)
  
  StrCopy(ftpData.workingPath,'')
  StrCopy(ftpData.uploadPath,uploadPath)

  ioctlSocket(socketbase,ftp_c,FIONBIO,[0])

  mainFtpLoop(socketbase,ftp_c,ftpData)

  freeFileList(ftpData.fileList)
  
  DisposeLink(ftpData.workingPath)
  DisposeLink(ftpData.uploadPath)
  DisposeLink(ftpData.hostName)
  DisposeLink(ftpData.subDirPath)
ENDPROC

EXPORT PROC ftpDoLogin(sb,ftp_c,userName:PTR TO CHAR,password:PTR TO CHAR)
  DEF authDone=FALSE
  DEF request[255]:ARRAY OF CHAR
  DEF sendStr[255]:STRING

  WHILE (authDone=FALSE) ANDALSO (CtrlC()=FALSE) ANDALSO (readLine(NIL,sb,ftp_c,request, MAX_LINE-1) > 0)
    IF StrLen(request)>0
      IF(StrCmp(request, 'USER ', 5))
        StrCopy(userName,request+5)
        StrCopy(sendStr,'331 user accepted\b\n')    
        writeLineEx(sb,ftp_c,sendStr)
        IF EstrLen(password)>0 THEN authDone:=TRUE
      ELSEIF(StrCmp(request, 'PASS ', 5))
        StrCopy(password,request+5)
        IF (EstrLen(userName)>0) AND (EstrLen(password)>0) THEN authDone:=TRUE
      ELSE
        StrCopy(sendStr,'500 command not recognized\b\n')    
        writeLineEx(sb,ftp_c,sendStr)
      ENDIF
    ENDIF
  ENDWHILE
ENDPROC authDone

EXPORT PROC doftp(ftpData:PTR TO ftpData,node,ftphost,ftpports:PTR TO LONG,ftpdataports:PTR TO LONG,fileList: PTR TO stdlist,uploadpath,filenameCAPS,uploadMode)
  DEF r,ftp_s,ftp_c,s,sb
  DEF temp[255]:STRING
  DEF flg,rchar
  DEF tcount=0,i,t
  DEF connected=TRUE
  DEF port
  
  ftpData.rest:=0
  ftpData.tcount:=0
  ftpData.scount:=0
  ftpData.port:=-1
  ftpData.mode:=IF uploadMode THEN MODE_UPLOAD ELSE MODE_DOWNLOAD
  ftpData.fileList:=fileList
  ftpData.restPos:=0
  ftpData.filenameCAPS:=filenameCAPS

  ftpData.workingPath:=String(255)
  ftpData.uploadPath:=String(255)
  ftpData.hostName:=String(255)
  ftpData.dataPorts:=ftpdataports
  ftpData.setReuseAddr:=TRUE
  
  IF uploadMode
    ftpData.ftpDir:={uploadDir}
  ELSE
    ftpData.ftpDir:={downloadDir}
  ENDIF

  StrCopy(ftpData.hostName,ftphost) 
  StrCopy(ftpData.workingPath,uploadpath)
  StrCopy(ftpData.uploadPath,uploadpath)
  
	sb:=OpenLibrary('bsdsocket.library',2)
	IF (sb)
    testSocket(sb,ftpData,ftpports[0])
    
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
        
        IF ftpData.ftpCheckConnection<>NIL THEN connected:=ftpData.ftpCheckConnection()
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
  DisposeLink(ftpData.uploadPath)
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
