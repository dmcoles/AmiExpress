/*
** simple httpd
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
  fs:=httpData.fileStart
  xprInfo:=httpData.xprInfo
  MOVE.L xprInfo,-(A7)
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
  DEF chk
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
    StringF(tempStr,'/XHTTP: Error creating listening socket. (\d)\b\n',errno(sb))
		aePuts(httpData,tempStr)
    END servaddr
		RETURN FALSE,-1
	ENDIF

  IF reuseable
    IF setSockOpt(sb,server_s, SOL_SOCKET, SO_REUSEADDR, [1]:LONG, 4)<>0
      StringF(tempStr,'/XHTTP: error setting socket options SO_REUSEADDR, error=\d\b\n',errno(sb))
      aePuts(httpData,tempStr)
    ENDIF

    optval:=NEW [0,0]:LONG
    optlen:=NEW [8]:LONG
    IF getSockOpt(sb,server_s, SOL_SOCKET, SO_LINGER, optval,optlen)<>0
      StringF(tempStr,'/XHTTP: error getting socket options SO_LINGER, error=\d\b\n',errno(sb))
      aePuts(httpData,tempStr)
    ENDIF
    IF optlen[0]=4
      optval[0]:=$10000
    ELSEIF optlen[0]=8
      optval[0]:=1
      optval[1]:=0
    ELSE
      aePuts(httpData,'/XHTTP: error setting socket options SO_LINGER, bad size\b\n')
    ENDIF

    IF setSockOpt(sb,server_s, SOL_SOCKET, SO_LINGER, optval,optlen[0])<>0
      StringF(tempStr,'/XHTTP: error setting socket options SO_LINGER, error=\d\b\n',errno(sb))
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
		StringF(tempStr,'/XHTTP: Error calling bind() for port \d, error=\d\b\n',port,errno(sb));
    aePuts(httpData,tempStr)
    closeSocket(sb,server_s)
    END servaddr
		RETURN FALSE,-1
	ENDIF

	IF(listen(sb,server_s, LISTENQ) < 0)
		StringF(tempStr,'/XHTTP: Error calling listen() for port \d, error=\d\b\n',port,errno(sb));
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
  n:=0
  WHILE (n<(maxlen-1)) AND (c[] <> "\n")
    rc:=recv(sb,sockd, c, 1,0)
		IF ( rc = 1 )
      IF(c[] <> "\b") AND (c[] <> "\n")
        buffer[]++:=c[]
        n++
      ENDIF
		ELSE
			IF ( errno(sb)<>EINTR )
        RETURN -1
      ENDIF
		ENDIF
  ENDWHILE
  buffer[]:=0
ENDPROC n

PROC writeLine(sb,sockd, vptr:PTR TO CHAR, n)
  send(sb,sockd, vptr, n,0)
ENDPROC n

PROC writeLineEx(sb,sockd, vptr:PTR TO CHAR)
ENDPROC writeLine(sb,sockd, vptr, StrLen(vptr))

PROC listFiles(path: PTR TO CHAR,sb,http_c)
  DEF lock
  DEF f_info: PTR TO fileinfoblock
  DEF tempstr[255]:STRING

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
    RETURN
  ENDIF

  writeLineEx(sb,http_c,'<hr>\b\n')
  writeLineEx(sb,http_c,'<ol>\b\n')
    
  WHILE((ExNext(lock,f_info))<>0)
    StringF(tempstr,'<pre><li>\s</li></pre>\b\n',f_info.filename)
    writeLineEx(sb,http_c,tempstr)
  ENDWHILE

  writeLineEx(sb,http_c,'</ol>\b\n')
  writeLineEx(sb,http_c,'<hr>\b\n')
  UnLock(lock)
  FreeDosObject(DOS_FIB,f_info)
ENDPROC

PROC generatePage(sb,http_c,httppath:PTR TO CHAR, xprInfo:PTR TO xprData,node,uploadMode)
  DEF temp[255]:STRING
  DEF fl:PTR TO stdlist
  DEF fi:PTR TO flagFileItem
  DEF i

  writeLineEx(sb,http_c,'HTTP/1.1 200 OK\b\n')
  writeLineEx(sb,http_c,'content-type: text/html; charset=UTF-8\b\n')
  writeLineEx(sb,http_c,'\b\n')
  writeLineEx(sb,http_c,'<html>\b\n')
  writeLineEx(sb,http_c,'<head>\b\n')
  IF uploadMode
    writeLineEx(sb,http_c,'<meta http-equiv="content-type" content="text/html; charset=UTF-8"><title>Ami-Express uploads</title>\b\n')
  ELSE
    writeLineEx(sb,http_c,'<meta http-equiv="content-type" content="text/html; charset=UTF-8"><title>Ami-Express downloads</title>\b\n')
  ENDIF

  writeLineEx(sb,http_c,'</head>\b\n')
  writeLineEx(sb,http_c,'<body>\b\n')
  IF uploadMode
    StringF(temp,'<h1>Ami-Express uploads - node \d</h1>\b\n',node)
    writeLineEx(sb,http_c,temp)
    listFiles(httppath,sb,http_c)
    writeLineEx(sb,http_c,'<form enctype="multipart/form-data" action="/" method="post">\b\n')
    writeLineEx(sb,http_c,'<input multiple id="image-file" name="files" type="file" /><br/>\b\n')
    writeLineEx(sb,http_c,'<input type="reset" value="Clear"/>')
    writeLineEx(sb,http_c,'<input type="submit" value="Upload"/>\b\n')
    writeLineEx(sb,http_c,'</form>\b\n')
  ELSE
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
  ENDIF           

  writeLineEx(sb,http_c,'</body>\b\n')
  writeLineEx(sb,http_c,'</html>\b\n')
ENDPROC

PROC readMemLine(outBuf:PTR TO CHAR,sb,socket,inBuf:PTR TO CHAR,bufsize:PTR TO LONG,pos:PTR TO LONG,maxlen,maxbuf,contentLength:PTR TO LONG)
  DEF loop=TRUE
  DEF len
  DEF r
  
  IF pos[]>=(bufsize[]-maxlen)
    len:=bufsize[]-pos[]
    CopyMem(inBuf+pos[],inBuf,len)
    r:=maxbuf-len
    IF contentLength[]<r THEN r:=contentLength[]
    r:=recv(sb,socket, inBuf+len, r,0)
    IF r<0 THEN r:=0
    bufsize[]:=r
    contentLength[]:=contentLength[]-r
    r:=r+len
    bufsize[]:=r
    pos[]:=0
  ENDIF
  
  StrCopy(outBuf,'')
  WHILE (pos[]<bufsize[]) AND loop
    IF inBuf[pos[]]<>"\n"
      IF inBuf[pos[]]<>"\b" THEN StrAdd(outBuf,inBuf+pos[],1)
    ELSE
      loop:=FALSE
    ENDIF
    IF StrLen(outBuf)=maxlen THEN loop:=FALSE
    pos[]:=pos[]+1
  ENDWHILE
ENDPROC StrLen(outBuf)

PROC extractFileData(sb,socket,httpData:PTR TO httpData,boundary:PTR TO CHAR,contentLength,asynclib)
  DEF buff,fh
  DEF pos,p,readSize,boundaryLen
  DEF fname[255]:STRING
  DEF lineBuff[255]:STRING
  DEF loop,morefiles=TRUE
  DEF bufsize
  DEF t,t2,filepos,lastfilepos,cps
  
  boundaryLen:=StrLen(boundary) 
  bufsize:=32768+boundaryLen
  readSize:=bufsize
  buff:=New(readSize)
  
  ->dupecheck
  
  IF contentLength<readSize THEN readSize:=contentLength
  readSize:=recv(sb,socket, buff, readSize,0)
  IF readSize=-1 THEN RETURN
  
  contentLength:=contentLength-readSize
  pos:=0
  REPEAT
    StrCopy(fname,'')
       
    WHILE((readMemLine(lineBuff,sb,socket,buff,{readSize},{pos},255,bufsize,{contentLength})) > 0)
      IF (p:=InStr(lineBuff,'filename="'))>=0
        StrCopy(fname,httpData.workingPath)
        StrAdd(fname,lineBuff+p+10,ALL)
        p:=InStr(fname,'"')
        SetStr(fname,p)
      ENDIF
    ENDWHILE
    fh:=0
    IF StrLen(fname)>0
      IF asynclib<>NIL
        DeleteFile(fname)
        fh:=OpenAsync(fname,MODE_APPEND,32768)
      ELSE
        fh:=Open(fname,MODE_NEWFILE)
      ENDIF
      IF httpData.fileStart<>NIL
        fileStart(httpData,fname,0)
      ENDIF
      t:=fastSystemTime()
      lastfilepos:=0
    ENDIF

    loop:=TRUE
    REPEAT
      p:=pos
      WHILE (p<(readSize-boundaryLen)) AND (StrCmp(buff+p,boundary,boundaryLen)=FALSE) DO p++
      IF fh>0
        IF asynclib<>NIL
          WriteAsync(fh,buff+pos,p-pos)
        ELSE
          Write(fh,buff+pos,p-pos)
        ENDIF

        t2:=fastSystemTime()
        ->only call update maximum every 1 second
        IF (Abs(t2-t))>=50
          IF asynclib<>NIL
            filepos:=SeekAsync(fh,0,MODE_CURRENT)
          ELSE
            filepos:=Seek(fh,0,OFFSET_CURRENT)
          ENDIF
          IF (t<t2) THEN cps:=Div(Mul((filepos-lastfilepos),50),(t2-t))
          lastfilepos:=filepos
          fileProgress(httpData,fname,filepos,cps)
          t:=t2
        ENDIF
      ENDIF
      
      IF StrCmp(buff+p,boundary,boundaryLen)
        loop:=FALSE
        pos:=p+boundaryLen
        IF StrCmp(buff+pos,'--\b\n',4) THEN morefiles:=FALSE
        IF StrCmp(buff+pos,'\b\n',2) THEN pos:=pos+2
      ELSE
        IF contentLength>0
          CopyMem(buff+readSize-boundaryLen,buff,boundaryLen)
          readSize:=bufsize-boundaryLen
          IF contentLength<readSize THEN readSize:=contentLength
          readSize:=recv(sb,socket, buff+boundaryLen, readSize,0)
          IF readSize<0 THEN readSize:=0
          contentLength:=contentLength-readSize
          readSize:=readSize+boundaryLen
          pos:=0
        ELSE
          loop:=FALSE
        ENDIF
      ENDIF
    UNTIL loop=FALSE
    IF fh>0
      IF asynclib<>NIL
        CloseAsync(fh)
      ELSE
        Close(fh)
      ENDIF
      IF httpData.fileEnd<>NIL
        fileEnd(httpData,fname)
      ENDIF
    ENDIF

  UNTIL morefiles=FALSE
  Dispose(buff)
ENDPROC


EXPORT PROC doHttpd(node,httphost,httpport,httppath,aePutsPtr, readCharPtr, sCheckInputPtr, xprInfo:PTR TO xprData, httpFileStartPtr, httpFileEndPtr, httpFileProgressPtr, uploadMode)
  DEF r,http_s,http_c,sb
  DEF temp[255]:STRING
  DEF httpData:PTR TO httpData
  DEF flg,rchar
  DEF request[255]:STRING
  DEF getCmd[255]:STRING
  DEF postCmd[255]:STRING
  DEF boundary[255]:STRING
  DEF spcPos
  DEF fh,buff,l,t,t2,lastpos,pos,cps
  DEF asynclib
  DEF p,contentLength
  
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
  httpData.fileStart:=httpFileStartPtr
  httpData.fileEnd:=httpFileEndPtr
  httpData.fileProgress:=httpFileProgressPtr
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
            StringF(temp,'/XHTTP: Error calling accept() errno=\d\b\n',errno(sb))
            aePuts(httpData,temp)
          ENDIF
        ELSE
          flg:=TRUE
          httpData.tcount:=httpData.tcount+1
          StringF(temp,'HTTP connection at port \d accepted\b\n', httpData.port)
          aePuts(httpData,temp)

          StrCopy(getCmd,'')
          StrCopy(postCmd,'')
          WHILE(readLine(sb,http_c, request, MAX_LINE-1) > 0)
            IF StrCmp(request,'GET ',4) THEN StrCopy(getCmd,request+4)
            IF StrCmp(request,'POST ',5) THEN StrCopy(postCmd,request+5)
            IF (InStr(request,'Content-Type:')>=0) AND (InStr(request,'multipart/form-data;')>=0) AND ((p:=InStr(request,'boundary='))>=0)
              StrCopy(boundary,'\b\n--')
              StrAdd(boundary,TrimStr(request+p+9))
            ENDIF
            IF ((p:=InStr(request,'Content-Length:'))>=0)
              contentLength:=Val(request+p+15)
            ENDIF
          ENDWHILE
          
          IF StrLen(getCmd)>0
            IF (spcPos:=InStr(getCmd,' '))>=0 THEN SetStr(getCmd,spcPos)
            IF StrCmp(getCmd,'/',ALL)
              generatePage(sb,http_c,httppath,xprInfo,node,uploadMode)
              
            ELSEIF (StrCmp(getCmd,'/',1))
              StringF(temp,'\s\s',httppath,getCmd+1)
            
              asynclib:=OpenLibrary('asyncio.library',0)
              asynciobase:=asynclib
              
              IF httpData.fileStart<>NIL
                fileStart(httpData,temp,FileLength(temp))
              ENDIF

              IF asynclib<>NIL
                fh:=OpenAsync(temp,MODE_READ,32768)
              ELSE
                fh:=Open(temp,MODE_OLDFILE)
              ENDIF
              
              IF fh>=0
                writeLineEx(sb,http_c,'HTTP/1.1 200 OK\b\n')
                writeLineEx(sb,http_c,'content-type: binary/octet-stream\b\n')
                writeLineEx(sb,http_c,'\b\n')
                
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
                  IF l>0 
                    writeLine(sb,http_c,buff,l)
                    IF (httpData.fileProgress<>NIL)
                      t2:=fastSystemTime()
                      ->only call update maximum every 1 second
                      IF (Abs(t2-t))>=50
                        IF asynclib<>NIL
                          pos:=SeekAsync(fh,0,MODE_CURRENT)
                        ELSE
                          pos:=Seek(fh,0,OFFSET_CURRENT)
                        ENDIF
                        IF (t<t2) THEN cps:=Div(Mul((pos-lastpos),50),(t2-t))
                        lastpos:=pos
                        fileProgress(httpData,temp,pos,cps)
                        t:=t2
                      ENDIF
                    ENDIF
                  ENDIF
                UNTIL l=0
                Dispose(buff)

                IF asynclib<>NIL
                  CloseAsync(fh)
                ELSE
                  Close(fh)
                ENDIF
                IF httpData.fileEnd<>NIL
                  fileEnd(httpData,temp)
                ENDIF
                
              ENDIF
            ENDIF
          ENDIF
          
          IF StrLen(postCmd)>0
            IF (spcPos:=InStr(postCmd,' '))>=0 THEN SetStr(postCmd,spcPos)
            IF StrCmp(postCmd,'/',ALL)
              extractFileData(sb,http_c,httpData,boundary,contentLength,asynclib)
              generatePage(sb,http_c,httppath,xprInfo,node,uploadMode)
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

