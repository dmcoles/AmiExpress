-> SSL and mail sending options
 
  OPT MODULE

  MODULE 'amissl','amisslmaster','socket','net/socket','net/in','net/netdb','*errors','*stringlist'

CONST BIO_CTRL_FLUSH=11
CONST BIO_FLAGS_BASE64_NO_NL=$100
CONST BIO_CTRL_INFO=3

CONST AMISSLMASTER_MIN_VERSION=4
CONST AMISSL_CURRENT_VERSION=6

CONST SSL_VERIFY_PEER=1
CONST SSL_VERIFY_FAIL_IF_NO_PEER_CERT=2

CONST BIO_NOCLOSE=$0
CONST BIO_FP_TEXT=$10

CONST OPENSSL_LINE=0

CONST BIO_SET_FILE_PTR=$6a ->dont know what this is

CONST OPENSSL_INIT_LOAD_SSL_STRINGS=$200000
CONST OPENSSL_INIT_LOAD_CRYPTO_STRINGS=2

CONST AMISSL_SOCKETBASE=$80000001
CONST AMISSL_ERRNOPTR=$8000000B

EXPORT OBJECT mailConfig
  smtpHost[255]:ARRAY OF CHAR
  smtpPort:LONG
  username[255]:ARRAY OF CHAR
  password[255]:ARRAY OF CHAR
  sysopEmail[255]:ARRAY OF CHAR
  bbsEmail[255]:ARRAY OF CHAR
  ssl: INT
  mailOnNewUser: INT
  mailOnSysopComment: INT
  mailOnSysopPage: INT
ENDOBJECT

EXPORT DEF mailOptions: PTR TO mailConfig

DEF sslerrno
DEF ctx: LONG ->PTR TO SSL_CTX
DEF bio_err: LONG ->PTR TO BIO

EXPORT PROC sendMail(subject:PTR TO CHAR,bodytext:PTR TO CHAR, appendMsgBuf, msgBuf:PTR TO stringlist, lines, toemail:PTR TO CHAR)
  DEF ssl,sock=0,errcode=0
  DEF buffer[4096]:STRING; /* This should be dynamically allocated */
  DEF bufsize=4096
  DEF request[512]:STRING
  DEF failed=FALSE,v,i

  /* The following needs to be done once per socket */

  /* Connect to the HTTPS server, directly or through a proxy */
  sock:=connectToServer(mailOptions.smtpHost,mailOptions.smtpPort)

  /* Check if connection was established */
  IF (sock >= 0)
    IF ctx
      IF((ssl:=SsL_new(ctx)) <> NIL)

        /* Associate the socket with the ssl structure */
        SsL_set_fd(ssl, sock)

        /* Perform SSL handshake */
        IF((errcode:=SsL_connect(ssl)) >= 0)

          IF ((errcode:=SsL_read(ssl, buffer,bufsize - 1)) >0)
            buffer[errcode]:=0
            WriteF('\s \d \d\n',buffer, errcode, 1);
          ELSE
            WriteF('Couldn''t read initial server message!\n');
          ENDIF

          StrCopy(request,'EHLO relay.example.com\n')
          IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
            WriteF('error sending EHLO\n');
          ENDIF

          IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
            buffer[errcode]:=0
            v:=Val(buffer)
            failed:=((v<200) OR (v>299))
            WriteF('\s \d \d\n',buffer, errcode, 1);
          ENDIF

          IF (failed=FALSE)
            StringF(request,'\n\s\n\s',mailOptions.username,mailOptions.password)
            v:=StrLen(request)-1
            FOR i:=0 TO v
              IF request[i]="\n" THEN request[i]:=0
            ENDFOR
            base64enc(request,EstrLen(request),buffer)
            StringF(request,'AUTH PLAIN \s\n',buffer)
            IF ((errcode:=SsL_write(ssl, request, EstrLen(request))) <=0 )
              WriteF('error sending AUTH\n');
            ENDIF

            IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
              buffer[errcode]:=0
              v:=Val(buffer)
              failed:=((v<200) OR (v>299))
              WriteF('\s \d \d\n',buffer, errcode, 1);
            ENDIF
          ENDIF

          IF (failed=FALSE)
            StringF(request,'mail from:<\s>\n',mailOptions.bbsEmail)
            IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
              WriteF('error sending FROM\n');
            ENDIF

            IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
              buffer[errcode]:=0
              v:=Val(buffer)
              failed:=((v<200) OR (v>299))
              WriteF('\s \d \d\n',buffer, errcode, 1);
            ENDIF
          ENDIF

          IF (failed=FALSE)
            StringF(request,'rcpt to:<\s>\n',toemail)
            IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
              WriteF('error sending TO\n');
            ENDIF

            IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
              buffer[errcode]:=0
              v:=Val(buffer)
              failed:=((v<200) OR (v>299))
              WriteF('\s \d \d\n',buffer, errcode, 1);
            ENDIF
          ENDIF

          IF (failed=FALSE)
            StrCopy(request,'DATA\n')
            IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
              WriteF('error sending DATA\n');
            ENDIF

            IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
              buffer[errcode]:=0
              v:=Val(buffer)
              failed:=(((v<200) OR (v>299)) AND (v<>354))
              WriteF('\s \d \d\n',buffer, errcode, 1);
            ENDIF
          ENDIF

          IF (failed=FALSE)
            StrCopy(request,'From: <\s>\b\n',mailOptions.bbsEmail)
            IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
              WriteF('error sending msg data\n');
            ENDIF

            StrCopy(request,'To: <toemail>\b\n')
            IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
              WriteF('error sending msg data\n');
            ENDIF

            StringF(request,'Subject: \s\b\n',subject)
            IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
              WriteF('error sending msg data\n');
            ENDIF

            StrCopy(request,'\b\n')
            IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
              WriteF('error sending msg data\n');
            ENDIF

            i:=0
            WHILE(i<StrLen(bodytext))
              IF(v:=InStr('\n',bodytext,i)<0)
                v:=StrLen(bodytext)
                StrCopy(request,bodytext+i,v-i)
                i:=v
              ELSE
                StrCopy(request,bodytext+i,v-i)
                StrAdd(request,'\b\n')
                i:=v+1
              ENDIF
              IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                WriteF('error sending msg data\n');
              ENDIF
            ENDWHILE

            IF appendMsgBuf
              FOR i:=0 TO lines-1
                 StringF(request,'\s\b\n',msgBuf.item(i))
                 IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
                   WriteF('error sending msg data\n');
                 ENDIF
              ENDFOR
            ENDIF

            StrCopy(request,'\b\n.\b\n')
            IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
              WriteF('error sending DATA\n');
            ENDIF

            IF((errcode:=SsL_read(ssl, buffer,bufsize - 1)) > 0)
              buffer[errcode]:=0
              WriteF('\s \d \d\n',buffer, errcode, 1);
            ENDIF


            StrCopy(request,'QUIT\n')
            IF ((errcode:=SsL_write(ssl, request, StrLen(request))) <=0 )
              WriteF('error sending QUIT\n');
            ENDIF
          ENDIF
        ELSE
          WriteF('Couldn''t establish SSL connection!\n');
        ENDIF

        /* If there were errors, print them */
        ->IF (errcode < 0) THEN ErR_print_errors(bio_err);

        /* Send SSL close notification and close the socket */
        SsL_shutdown(ssl);

        SsL_free(ssl);
      ELSE
        WriteF('Couldn''t create new SSL handle!\n');
      ENDIF


    ELSE
      ->standard unencrypted smtp
      IF ((errcode:=Recv(sock,buffer,bufsize - 1,0)) >0)
       buffer[errcode]:=0
        WriteF('\s \d \d\n',buffer, errcode, 1);
      ELSE
        WriteF('Couldn''t read initial server message!\n');
      ENDIF

      StrCopy(request,'EHLO relay.example.com\n')
      IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
        WriteF('error sending EHLO\n');
      ENDIF

      IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
        buffer[errcode]:=0
        v:=Val(buffer)
        failed:=((v<200) OR (v>299))
        WriteF('\s \d \d\n',buffer, errcode, 1);
      ENDIF

      IF (failed=FALSE)
        StringF(request,'\n\s\n\s',mailOptions.username,mailOptions.password)
        v:=StrLen(request)-1
        FOR i:=0 TO v
          IF request[i]="\n" THEN request[i]:=0
        ENDFOR
        base64enc(request,EstrLen(request),buffer)
        StringF(request,'AUTH PLAIN \s\n',buffer)
        IF ((errcode:=Send(sock, request, EstrLen(request),0)) <=0 )
          WriteF('error sending AUTH\n');
        ENDIF

        IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
          buffer[errcode]:=0
          v:=Val(buffer)
          failed:=((v<200) OR (v>299))
          WriteF('\s \d \d\n',buffer, errcode, 1);
        ENDIF
      ENDIF

      IF (failed=FALSE)
        StringF(request,'mail from:<\s>\n',mailOptions.bbsEmail)
        IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
          WriteF('error sending FROM\n');
        ENDIF

        IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
          buffer[errcode]:=0
          v:=Val(buffer)
          failed:=((v<200) OR (v>299))
          WriteF('\s \d \d\n',buffer, errcode, 1);
        ENDIF
      ENDIF

      IF (failed=FALSE)
        StringF(request,'rcpt to:<\s>\n',toemail)
        IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
          WriteF('error sending TO\n');
        ENDIF

        IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
          buffer[errcode]:=0
          v:=Val(buffer)
          failed:=((v<200) OR (v>299))
          WriteF('\s \d \d\n',buffer, errcode, 1);
        ENDIF
      ENDIF

      IF (failed=FALSE)
        StrCopy(request,'DATA\n')
        IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
          WriteF('error sending DATA\n');
        ENDIF

        IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
          buffer[errcode]:=0
          v:=Val(buffer)
          failed:=(((v<200) OR (v>299)) AND (v<>354))
          WriteF('\s \d \d\n',buffer, errcode, 1);
        ENDIF
      ENDIF

      IF (failed=FALSE)
        StrCopy(request,'From: <\s>\b\n',mailOptions.bbsEmail)
        IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
          WriteF('error sending msg data\n');
        ENDIF

        StrCopy(request,'To: <toemail>\b\n')
        IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
          WriteF('error sending msg data\n');
        ENDIF

        StringF(request,'Subject: \s\b\n',subject)
        IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
          WriteF('error sending msg data\n');
        ENDIF

        StrCopy(request,'\b\n')
        IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
          WriteF('error sending msg data\n');
        ENDIF

        i:=0
        WHILE(i<StrLen(bodytext))
          IF(v:=InStr('\n',bodytext,i)<0)
            v:=StrLen(bodytext)
            StrCopy(request,bodytext+i,v-i)
            i:=v
          ELSE
            StrCopy(request,bodytext+i,v-i)
            StrAdd(request,'\b\n')
            i:=v+1
          ENDIF
          IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
            WriteF('error sending msg data\n');
          ENDIF
        ENDWHILE

        IF appendMsgBuf
          FOR i:=0 TO lines-1
             StringF(request,'\s\b\n',msgBuf.item(i))
             IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
               WriteF('error sending msg data\n');
             ENDIF
          ENDFOR
        ENDIF

        StrCopy(request,'\b\n.\b\n')
        IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
          WriteF('error sending DATA\n');
        ENDIF

        IF((errcode:=Recv(sock, buffer,bufsize - 1,0)) > 0)
          buffer[errcode]:=0
          WriteF('\s \d \d\n',buffer, errcode, 1);
        ENDIF


        StrCopy(request,'QUIT\n')
        IF ((errcode:=Send(sock, request, StrLen(request),0)) <=0 )
          WriteF('error sending QUIT\n');
        ENDIF
      ENDIF
    ENDIF
    CloseSocket(sock);
  ELSE
    WriteF('Couldn''t connect to host!\n');
  ENDIF
ENDPROC

PROC base64enc(data:PTR TO CHAR,len,output)
  DEF b64
  DEF mem
  DEF done=FALSE,res=0,outstr,strlen
  -> bio is simply a class that wraps BIO* and it free the BIO in the destructor.

  b64:=BiO_new(BiO_f_base64()); ->// create BIO to perform base64
  BiO_set_flags(b64, BIO_FLAGS_BASE64_NO_NL);

  mem:=BiO_new(BiO_s_mem()); ->// create BIO that holds the result

  ->// chain base64 with mem, so writing to b64 will encode base64 and write to mem.
  BiO_push(b64, mem);

  ->// write data
  WHILE(done=FALSE)
    res:=BiO_write(b64, data, len);

    IF(res <= 0) -> if failed
      IF(BiO_fd_should_retry(b64)=FALSE)
        ->// encoding failed
        /* Handle Error!!! */
        RETURN 0
      ENDIF
    ELSE
     ->// success!
      done:=TRUE;
    ENDIF
  ENDWHILE

  BiO_ctrl(b64,BIO_CTRL_FLUSH,0,NIL)

  strlen:=BiO_ctrl(mem,BIO_CTRL_INFO,0,{outstr})

  StrCopy(output,outstr,strlen)
  BiO_free(mem)
  BiO_free(b64)

ENDPROC

/* Open and initialize AmiSSL */
EXPORT PROC initssl(createctx) HANDLE
  DEF tags

  sslerrno=0
  ctx:=0
  bio_err:=0

  IF socketbase=NIL THEN socketbase:=OpenLibrary('bsdsocket.library', 4)
  IF (socketbase=NIL)
    WriteF('Couldn''t open bsdsocket.library v4!\n')
    Raise(ERR_SSL)
  ENDIF

  amisslmasterbase:=OpenLibrary('amisslmaster.library',AMISSLMASTER_MIN_VERSION)
  IF (amisslmasterbase=NIL)
    WriteF('Couldn''t open amisslmaster.library v\d!\n',AMISSLMASTER_MIN_VERSION);
    Raise(ERR_SSL)
  ENDIF

  IF (InitAmiSSLMaster(AMISSL_CURRENT_VERSION, TRUE))=NIL
    WriteF('AmiSSL version is too old!\n');
    Raise(ERR_SSL)
  ENDIF

  amisslbase:=OpenAmiSSL()
    IF (amisslbase=NIL)
    WriteF('Couldn''t open AmiSSL!\n');
    Raise(ERR_SSL)
  ENDIF

  tags:=NEW [AMISSL_ERRNOPTR,{sslerrno},AMISSL_SOCKETBASE,socketbase,0]
  IF (InitAmiSSLA(tags) <> 0)
    END tags
    WriteF('Couldn''t initialize AmiSSL!\n');
    Raise(ERR_SSL)
  ENDIF
  END tags

  /* Basic intialization. Next few steps (up to SSL_new()) need
   * to be done only once per AmiSSL opener.
   */

   OpENSSL_init_ssl(0,NIL)      ->SSLeay_add_ssl_algorithms();   -$67C8(a6)
   OpENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS OR OPENSSL_INIT_LOAD_CRYPTO_STRINGS, NIL) ->SSL_load_error_strings();

  /* Note: BIO writing routines are prepared for NULL BIO handle */
  IF((bio_err:=BiO_new(BiO_s_file())) <> NIL) THEN BiO_ctrl(bio_err, BIO_SET_FILE_PTR, BIO_NOCLOSE OR BIO_FP_TEXT, Output()); ->BiO_set_fp_amiga(bio_err, Output(), BIO_NOCLOSE OR BIO_FP_TEXT);

  /* Get a new SSL context */
  IF (createctx)
    ctx:=SsL_CTX_new(TlS_client_method())
    IF (ctx=0)
      WriteF('Couldn''t create ssl ctx!\n');
      Raise(ERR_SSL)
    ENDIF
    SsL_CTX_set_default_verify_paths(ctx);
    SsL_CTX_set_verify(ctx, SSL_VERIFY_PEER OR SSL_VERIFY_FAIL_IF_NO_PEER_CERT,NIL);
  ENDIF
EXCEPT
  cleanupssl()
  RETURN FALSE
ENDPROC TRUE

EXPORT PROC cleanupssl()
  IF ctx<>NIL
    SsL_CTX_free(ctx);
    ctx:=NIL
  ENDIF

  IF bio_err<>NIL
    BiO_free(bio_err)
    bio_err:=NIL
  ENDIF

  IF (amisslbase)
    CleanupAmiSSLA([0]);
    CloseAmiSSL();
    amisslbase:=NIL
  ENDIF

  CloseLibrary(amisslmasterbase);
  amisslmasterbase:=NIL;

  IF socketbase<>NIL THEN CloseLibrary(socketbase)
  socketbase:=NIL;
ENDPROC

/* Connect to the specified server, either directly or through the specified
 * proxy using HTTP CONNECT method.
 */

EXPORT PROC connectToServer(host:PTR TO CHAR, port)
  DEF addr: PTR TO sockaddr_in
  DEF is_ok = FALSE;
  DEF sock=NIL;
  DEF hostEnt: PTR TO hostent
  DEF hostaddr: PTR TO LONG

  /* Create a socket and connect to the server */
  IF ((sock:=Socket(AF_INET, SOCK_STREAM, 0)) >= 0)

    hostEnt:=GetHostByName(host)
    hostaddr:=hostEnt.h_addr_list[]
    hostaddr:=hostaddr[]

    NEW addr
    addr.sin_family:=AF_INET;
    addr.sin_addr:=hostaddr[]; /* This should be checked against INADDR_NONE */
    addr.sin_port:=port->htons(port);

    IF (Connect(sock, addr, SIZEOF sockaddr_in) >= 0)
        is_ok:=TRUE
    ELSE
      WriteF('Couldn''t connect to server\n');
    ENDIF
    END addr
    IF (is_ok=FALSE)
      CloseSocket(sock);
      sock:=-1;
    ENDIF
  ENDIF

ENDPROC sock
