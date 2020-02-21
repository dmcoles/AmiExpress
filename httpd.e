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
       'libraries/asyncio',
       '*axcommon',
       '*axobjects',
       '*stringlist'     
 
OBJECT httpData
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

PROC releaseCopyOfSocket(sb,fd,id)
  MOVEM.L D1-D7/A0-A6,-(A7)
  MOVE.L sb,A6
  MOVE.L fd,D0
  MOVE.L id,D1
  JSR -$9C(A6)   ->ReleaseCopyOfSocket(fd,id)
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

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

PROC fileStart(httpData:PTR TO httpData,fn,pos)
  DEF fs,xprInfo
  DEF xi
  fs:=httpData.fileStart
  xi:=httpData.xprInfo
  MOVE.L xi,-(A7)
  MOVE.L fn,-(A7)
  MOVE.L pos,-(A7)
  fs()
  ADD.L #12,A7
ENDPROC

PROC fileEnd(httpData:PTR TO httpData,fn)
  DEF fe
  DEF xprInfo
  fe:=httpData.fileEnd
  xprInfo:=httpData.xprInfo

  MOVE.L xprInfo,-(A7)
  MOVE.L fn,-(A7)
  fe()
  ADDQ.L #8,A7
ENDPROC

PROC fileProgress(httpData:PTR TO httpData,fn,pos,cps)
  DEF fp
  DEF xprInfo
  fp:=httpData.fileProgress
  xprInfo:=httpData.xprInfo
  
  MOVE.L xprInfo,-(A7)
  MOVE.L fn,-(A7)
  MOVE.L pos,-(A7)
  MOVE.L cps,-(A7)
  fp()
  ADD.L #12,A7
ENDPROC

PROC aePuts(httpData:PTR TO httpData, s:PTR TO CHAR)
  DEF puts
  puts:=httpData.aePuts
  MOVE.L s,-(A7)
  CLR.L -(A7)
  puts()
  ADDQ.L #8,A7
ENDPROC

PROC sCheckInput(httpData:PTR TO httpData)
  DEF chk,r
  chk:=httpData.sCheckInput
ENDPROC chk()

PROC readChar(httpData:PTR TO httpData)
  DEF rdChar,r
  rdChar:=httpData.readChar
  CLR.L -(A7)
  CLR.L -(A7)
  r:=rdChar()
  ADDQ.L #8,A7
ENDPROC r

PROC fastSystemTime()
  DEF currDate: datestamp
  DEF startds:PTR TO datestamp

  startds:=DateStamp(currDate)

ENDPROC Mul(startds.minute,3000)+startds.tick

PROC openSocket(sb,port, reuseable,httpData:PTR TO httpData)
  DEF server_s
  DEF servaddr=0:PTR TO sockaddr_in
  DEF tempStr[255]:STRING
  DEF optval:PTR TO LONG,optlen:PTR TO LONG

  servaddr:=NEW servaddr

	IF((server_s:=socket(sb,AF_INET, SOCK_STREAM, 0)) < 0)
    StringF(tempStr,'/XFTP: Error creating listening socket. (\d)\b\n',errno(sb))
		aePuts(httpData,tempStr)
    END servaddr
		RETURN FALSE,-1
	ENDIF

  IF reuseable
    IF setSockOpt(sb,server_s, SOL_SOCKET, SO_REUSEADDR, [1]:LONG, 4)<>0
      StringF(tempStr,'/XFTP: error setting socket options SO_REUSEADDR, error=\d\b\n',errno(sb))
      aePuts(httpData,tempStr)
    ENDIF

    optval:=NEW [0,0]:LONG
    optlen:=NEW [8]:LONG
    IF getSockOpt(sb,server_s, SOL_SOCKET, SO_LINGER, optval,optlen)<>0
      StringF(tempStr,'/XFTP: error getting socket options SO_LINGER, error=\d\b\n',errno(sb))
      aePuts(httpData,tempStr)
    ENDIF
    IF optlen[0]=4
      optval[0]:=$10000
    ELSEIF optlen[0]=8
      optval[0]:=1
      optval[1]:=0
    ELSE
      aePuts(httpData,'/XFTP: error setting socket options SO_LINGER, bad size\b\n')
    ENDIF

    IF setSockOpt(sb,server_s, SOL_SOCKET, SO_LINGER, optval,optlen[0])<>0
      StringF(tempStr,'/XFTP: error setting socket options SO_LINGER, error=\d\b\n',errno(sb))
      aePuts(httpData,tempStr)
    ENDIF
    END optval
    END optlen

  ENDIF
  
  servaddr.sin_len:=SIZEOF sockaddr_in
  servaddr.sin_family:=AF_INET
  servaddr.sin_port:=port
  servaddr.sin_addr:=INADDR_ANY

	IF(bind(sb,server_s, servaddr, SIZEOF sockaddr_in) < 0)
		StringF(tempStr,'/XFTP: Error calling bind() for port \d, error=\d\b\n',port,errno(sb));
    aePuts(httpData,tempStr)
    closeSocket(sb,server_s)
    END servaddr
		RETURN FALSE,-1
	ENDIF

	IF(listen(sb,server_s, LISTENQ) < 0)
		StringF(tempStr,'/XFTP: Error calling listen() for port \d, error=\d\b\n',port,errno(sb));
    aePuts(httpData,tempStr)
    closeSocket(sb,server_s)
    END servaddr
    RETURN FALSE,-1
	ENDIF

  END servaddr
  httpData.scount:=httpData.scount+1
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

EXPORT PROC doHttpd(node,httphost,httpport,httppath,aePutsPtr, readCharPtr, sCheckInputPtr, xprInfo:PTR TO xprData, ftpFileStartPtr, ftpFileEndPtr, ftpFileProgressPtr, uploadMode)
  DEF r,http_s,http_c,s,sb,myargs:PTR TO LONG,rdargs
  DEF temp[255]:STRING
  DEF httpData:PTR TO httpData
  DEF flg,rchar
  DEF request[255]:STRING
  DEF getCmd[255]:STRING
  DEF spcPos,i
  DEF fl:PTR TO stdlist
  DEF fi:PTR TO flagFileItem
  DEF fh,buff,l
  
  httpData:=NEW httpData
  httpData.rest:=0
  httpData.tcount:=0
  httpData.scount:=0
  httpData.port:=-1
  httpData.uploadMode:=uploadMode
  httpData.restPos:=0
  httpData.aePuts:=aePutsPtr
  httpData.readChar:=readCharPtr
  httpData.sCheckInput:=sCheckInputPtr
  httpData.fileStart:=ftpFileStartPtr
  httpData.fileEnd:=ftpFileEndPtr
  httpData.fileProgress:=ftpFileProgressPtr
  httpData.workingPath:=String(255)
  httpData.hostName:=String(255)
  httpData.xprInfo:=xprInfo

  StrCopy(httpData.hostName,httphost)
  httpData.port:=httpport
  StrCopy(httpData.workingPath,httppath)
  
	sb:=OpenLibrary('bsdsocket.library',2)
	IF (sb)
    StringF(temp,'\b\nHTTP processor started on \s port \d...\b\n',httpData.hostName,httpData.port)
    aePuts(httpData,temp)
    aePuts(httpData,'Use Ctrl-C to continue when transfers are complete\b\n\b\n')
  
    r,http_s:=openSocket(sb,httpport,1,httpData)

    flg:=FALSE
    IF r
      ioctlSocket(sb,http_s,FIONBIO,[1])
      rchar:=0
      WHILE (rchar<>3)
        Delay(10)
        rchar:=0
        IF sCheckInput(httpData)
          rchar:=readChar(httpData)
        ENDIF
        EXIT rchar=3
        
        http_c:=accept(sb,http_s,NIL,NIL)
        IF(http_c< 0)
          IF errno(sb)<>35
            StringF(temp,'/XFTP: Error calling accept() errno=\d\b\n',errno(sb))
            aePuts(httpData,temp)
          ENDIF
        ELSE
          flg:=TRUE
          httpData.tcount:=httpData.tcount+1
          StringF(temp,'HTTP connection at port \d accepted\b\n', httpData.port)
          aePuts(httpData,temp)

          StrCopy(getCmd,'')
          WHILE(readLine(sb,http_c, request, MAX_LINE-1) > 0)
            IF StrCmp(request,'GET ',4) THEN StrCopy(getCmd,request+4)
          ENDWHILE
          IF StrLen(getCmd)>0
            IF (spcPos:=InStr(getCmd,' '))>=0 THEN SetStr(getCmd,spcPos)
            IF StrCmp(getCmd,'/',ALL)
              writeLineEx(sb,http_c,'HTTP/1.1 200 OK\b\n')
              writeLineEx(sb,http_c,'content-type: text/html; charset=UTF-8\b\n')
              writeLineEx(sb,http_c,'\b\n')
              writeLineEx(sb,http_c,'<html>\b\n')
              writeLineEx(sb,http_c,'<head>\b\n')
              writeLineEx(sb,http_c,'<meta http-equiv="content-type" content="text/html; charset=UTF-8"><title>Ami-Express downloads</title>\b\n')
              writeLineEx(sb,http_c,'</head>\b\n')
              writeLineEx(sb,http_c,'<body>\b\n')
              StringF(temp,'<h1>Ami-Express downloads - node \d</h1>\b\n',node)
              writeLineEx(sb,http_c,temp)
              writeLineEx(sb,http_c,'<hr>\b\n')
              writeLineEx(sb,http_c,'<ol>\b\n')
              fl:=xprInfo.fileList
              FOR i:=0 TO fl.count()-1
                fi:=fl.item(i)
                StringF(temp,'<pre><li><a href="\s">\s</a></li></pre>\b\n',FilePart(fi.fileName),FilePart(fi.fileName))
                writeLineEx(sb,http_c,temp)
              ENDFOR
              writeLineEx(sb,http_c,'</ol>\b\n')
              writeLineEx(sb,http_c,'<hr>\b\n')
              writeLineEx(sb,http_c,'</body>\b\n')
              writeLineEx(sb,http_c,'</html>\b\n')
            ELSEIF (StrCmp(getCmd,'/',1))
              StringF(temp,'\s\s',httppath,getCmd+1)
              fh:=Open(temp,MODE_OLDFILE)
              IF fh>=0
                writeLineEx(sb,http_c,'HTTP/1.1 200 OK\b\n')
                writeLineEx(sb,http_c,'content-type: binary/octet-stream\b\n')
                writeLineEx(sb,http_c,'\b\n')
                
                buff:=New(32768)
                REPEAT
                  l:=Fread(fh,buff,1,32768)
                  IF l>0 
                    writeLine(sb,http_c,buff,l)
                  ENDIF
                UNTIL l=0
                Dispose(buff)

                Close(fh)
              ENDIF
            ENDIF
          ENDIF

          r:=closeSocket(sb,http_c)
        ENDIF
      ENDWHILE
      httpData.scount:=httpData.scount-1
      r:=closeSocket(sb,http_s)
    ENDIF
    IF flg THEN aePuts(httpData,'\b\n')
    IF rchar=3
      aePuts(httpData,'CTRL-C detected, HTTP processor closed\b\n')
    ELSE
      aePuts(httpData,'HTTP transfers complete, all connections closed\b\n')
    ENDIF
    CloseLibrary(sb)
	ENDIF
  DisposeLink(httpData.hostName)
  DisposeLink(httpData.workingPath)
  END httpData
ENDPROC

