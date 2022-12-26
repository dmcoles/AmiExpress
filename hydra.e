OPT LARGE,MODULE

  MODULE 'dos/dos','*miscfuncs','devices/timer'


CONST EOF=-1

CONST CHATSTART = '\!\! * Chat mode start\b\n'
CONST CHATEND   = '\!\!\b\n * Chat mode end\r\n'
CONST CHATTIME  = '\!\!\b\n * Chat mode end - timeout\b\n'

/* HYDRA Specification Revision/Timestamp ---------Revision------Date------- */
CONST H_REVSTAMP=$2b1aab00                /* 001           01 Dec 1992 */
CONST H_REVISION=1
CONST HC_OS='AMIGA'
CONST PRGNAME='HydraCom'
CONST LOGID='HCom'
CONST VERSION='1.00'

/* HYDRA Basic Values ------------------------------------------------------ */

CONST FNAMELEN=31

CONST CHAT_TIMEOUT=60
CONST CHATLEN=256

CONST HEXDIGIT='0123456789abcdef'
CONST ABORTSTR='\x18\x18\x18\x18\x18\x18\x18\x18\x08\x08\x08\x08\x08\x08\x08\x08\x08\x08'
CONST AUTOSTR='hydra\b'
CONST PKTPREFIX='\0' ->fix this
CONST HDXMSG='Fallback to one-way xfer'

CONST H_MINBLKLEN=64               /* Min. length of a HYDRA data block */
CONST H_MAXBLKLEN=2048               /* Max. length of a HYDRA data block */
CONST H_OVERHEAD=8               /* Max. no. control bytes in a pkt   */
CONST H_MAXPKTLEN=6183              ->((H_MAXBLKLEN + H_OVERHEAD + 5) * 3)     /* Encoded pkt */
CONST H_BUFLEN=6199             ->(H_MAXPKTLEN + 16) /* Buffer sizes: max.enc.pkt + slack */
CONST XON=17                          /* Ctrl-Q (^Q) xmit-on character     */
CONST XOFF=19                         /* Ctrl-S (^S) xmit-off character    */
CONST H_DLE=24                        /* Ctrl-X (^X) HYDRA DataLinkEscape  */
CONST H_PKTPREFIX=31               /* Max length of pkt prefix string   */
CONST H_FLAGLEN=3               /* Length of a flag field            */
CONST H_RETRIES=10               /* No. retries in case of an error   */
CONST H_MINTIMER=10               /* Minimum timeout period            */
CONST H_MAXTIMER=60               /* Maximum timeout period            */
CONST H_START=5               /* Timeout for re-sending startstuff */
CONST H_IDLE=20               /* Idle? tx IDLE pkt every 20 secs   */
CONST H_BRAINDEAD=120               /* Braindead in 2 mins (120 secs)    */

CONST H_CRC16POLY=$8408
CONST H_CRC32POLY=$edb88320

/* HYDRA Transmitter States ------------------------------------------------ */

CONST HTX_DONE=0               /* All over and done                 */
CONST HTX_START=1               /* Send start autostr + START pkt    */
CONST HTX_SWAIT=2               /* Wait for any pkt or timeout       */
CONST HTX_INIT=3               /* Send INIT pkt                     */
CONST HTX_INITACK=4               /* Wait for INITACK pkt              */
CONST HTX_RINIT=5               /* Wait for HRX_INIT -> HRX_FINFO    */
CONST HTX_FINFO=6               /* Send FINFO pkt                    */
CONST HTX_FINFOACK=7               /* Wait for FINFOACK pkt             */
CONST HTX_XDATA=8               /* Send next packet with file data   */
CONST HTX_DATAACK=9               /* Wait for DATAACK packet           */
CONST HTX_XWAIT=10               /* Wait for HRX_END                  */
CONST HTX_EOF=11               /* Send EOF pkt                      */
CONST HTX_EOFACK=12               /* End of file, wait for EOFACK pkt  */
CONST HTX_REND=13               /* Wait for HRX_END && HTD_DONE      */
CONST HTX_END=14               /* Send END pkt (finish session)     */
CONST HTX_ENDACK=15               /* Wait for END pkt from other side  */

/* HYDRA Device Packet Transmitter States ---------------------------------- */
CONST HTD_DONE=0               /* No device data pkt to send        */
CONST HTD_DATA=1               /* Send DEVDATA pkt                  */
CONST HTD_DACK=2               /* Wait for DEVDACK pkt              */

/* HYDRA Receiver States --------------------------------------------------- */
CONST HRX_DONE=0               /* All over and done                 */
CONST HRX_INIT=1               /* Wait for INIT pkt                 */
CONST HRX_FINFO=2               /* Wait for FINFO pkt of next file   */
CONST HRX_DATA=3               /* Wait for next DATA pkt            */

/* HYDRA Packet Types ------------------------------------------------------ */
CONST HPKT_START="A"              /* Startup sequence                  */
CONST HPKT_INIT="B"              /* Session initialisation            */
CONST HPKT_INITACK="C"              /* Response to INIT pkt              */
CONST HPKT_FINFO="D"              /* File info (name, size, time)      */
CONST HPKT_FINFOACK="E"              /* Response to FINFO pkt             */
CONST HPKT_DATA="F"              /* File data packet                  */
CONST HPKT_DATAACK="G"              /* File data position ACK packet     */
CONST HPKT_RPOS="H"              /* Transmitter reposition packet     */
CONST HPKT_EOF="I"              /* End of file packet                */
CONST HPKT_EOFACK="J"              /* Response to EOF packet            */
CONST HPKT_END="K"              /* End of session                    */
CONST HPKT_IDLE="L"              /* Idle - just saying I'm alive      */
CONST HPKT_DEVDATA="M"              /* Data to specified device          */
CONST HPKT_DEVDACK="N"              /* Response to DEVDATA pkt           */
CONST HPKT_HIGHEST="N"              /* Highest known pkttype in this imp */

/* HYDRA Internal Pseudo Packet Types -------------------------------------- */
CONST H_NOPKT=0               /* No packet (yet)                   */
CONST H_CANCEL=-1              /* Received cancel sequence 5*Ctrl-X */
CONST H_CARRIER=-2              /* Lost carrier                      */
CONST H_SYSABORT=-3              /* Aborted by operator on this side  */
CONST H_TXTIME=-4              /* Transmitter timeout               */
CONST H_DEVTXTIME=-5              /* Device transmitter timeout        */
CONST H_BRAINTIME=-6              /* Braindead timeout (quite fatal)   */

/* HYDRA Packet Format: START[<data>]<type><crc>END ------------------------ */
CONST HCHR_PKTEND="a"              /* End of packet (any format)        */
CONST HCHR_BINPKT="b"              /* Start of binary packet            */
CONST HCHR_HEXPKT="c"              /* Start of hex encoded packet       */
CONST HCHR_ASCPKT="d"              /* Start of shifted 7bit encoded pkt */
CONST HCHR_UUEPKT="e"              /* Start of uuencoded packet         */

/* HYDRA Local Storage of INIT Options (Bitmapped) ------------------------- */
CONST HOPT_XONXOFF=1  /* Escape XON/XOFF                   */
CONST HOPT_TELENET=2  /* Escape CR-'@'-CR (Telenet escape) */
CONST HOPT_CTLCHRS=4  /* Escape ASCII 0-31 and 127         */
CONST HOPT_HIGHCTL=8  /* Escape above 3 with 8th bit too   */
CONST HOPT_HIGHBIT=16 /* Escape ASCII 128-255 + strip high */
CONST HOPT_CANBRK=32  /* Can transmit a break signal       */
CONST HOPT_CANASC=64  /* Can transmit/handle ASC packets   */
CONST HOPT_CANUUE=128 /* Can transmit/handle UUE packets   */
CONST HOPT_CRC32=256  /* Packets with CRC-32 allowed       */
CONST HOPT_DEVICE=512 /* DEVICE packets allowed            */
CONST HOPT_FPT=1024   /* Can handle filenames with paths   */

/* What we can do */
CONST HCAN_OPTIONS=HOPT_XONXOFF OR HOPT_TELENET OR HOPT_CTLCHRS OR HOPT_HIGHCTL OR HOPT_HIGHBIT OR HOPT_CANASC OR HOPT_CANUUE OR HOPT_CRC32 OR HOPT_DEVICE
/* Vital options if we ask for any; abort if other side doesn't support them */
CONST HNEC_OPTIONS=HOPT_XONXOFF OR HOPT_TELENET OR HOPT_CTLCHRS OR HOPT_HIGHCTL OR HOPT_HIGHBIT OR HOPT_CANBRK
/* Non-vital options; nice if other side supports them, but doesn't matter */
CONST HUNN_OPTIONS=HOPT_CANASC OR HOPT_CANUUE OR HOPT_CRC32 OR HOPT_DEVICE
/* Default options */
CONST HDEF_OPTIONS=0
/* rxoptions during init (needs to handle ANY link yet unknown at that point */
CONST HRXI_OPTIONS=HOPT_XONXOFF OR HOPT_TELENET OR HOPT_CTLCHRS OR HOPT_HIGHCTL OR HOPT_HIGHBIT
/* ditto, but this time txoptions */
CONST HTXI_OPTIONS=0

/* HYDRA Return codes ------------------------------------------------------ */
CONST XFER_ABORT=-1              /* Failed on this file & abort xfer  */
CONST XFER_SKIP=0               /* Skip this file but continue xfer  */
CONST XFER_OK=1               /* File was sent, continue transfer  */

#define h_uuenc(c)         (((c) AND $3f) + "!")
#define h_uudec(c)         (((c) - "!") AND $3f)
->#define h_long1(buf)       (*((long *) (buf)))
->#define h_long2(buf)       (*((long *) ((buf) + ((int) sizeof (long)))))
->#define h_long3(buf)       (*((long *) ((buf) + (2 * ((int) sizeof (long))))))

->static  char    abortstr[] = { 24,24,24,24,24,24,24,24,8,8,8,8,8,8,8,8,8,8,0 };
->static  char   *hdxmsg     = "Fallback to one-way xfer";
->static  char   *pktprefix  = "";
->static  char   *autostr    = "hydra\r";


OBJECT h_dev
  dev:PTR TO CHAR
  func:LONG
ENDOBJECT

OBJECT h_flags
  str:PTR TO CHAR
  val:LONG
ENDOBJECT

EXPORT OBJECT hydra_t
  recv_dir:PTR TO CHAR
  txbuf:PTR TO CHAR     /* packet buffers            */
  rxbuf:PTR TO CHAR     /* packet buffers            */
  crc16tab:PTR TO INT   /* CRC-16 table              */
  crc32tab:PTR TO LONG  /* CRC-32 table              */
  txbufin:LONG          /* read data from disk here  */
  rxbufmax:LONG
  originator:CHAR   /* are we the orig side?     */
  hdxlink:CHAR      /* hdx link & not orig side  */
  options:LONG      /* INIT options hydra_init() */
  timeout:LONG      /* general timeout in secs   */
  chatfill:LONG
  chattimer:LONG
  lasttimer:LONG 
  batchesdone:LONG  /* No. HYDRA batches done    */
  txoptions:LONG    /* HYDRA options (INIT seq)  */
  rxoptions:LONG    /* HYDRA options (INIT seq)  */
  txpktprefix[H_PKTPREFIX + 1]:ARRAY OF CHAR /* pkt prefix str they want  */
  txwindow:LONG    /* window size (0=streaming) */
  rxwindow:LONG    /* window size (0=streaming) */
  txlastc:CHAR     /* last byte put in txbuf    */
  rxdle:CHAR       /* count of received H_DLEs  */
  rxpktformat:CHAR  /* format of pkt receiving   */
  braindead:LONG    /* braindead timer           */
  rxbufptr:PTR TO CHAR    /* current position in rxbuf */
  txfname[FNAMELEN]:ARRAY OF CHAR /* fname of current files   */
  rxfname[FNAMELEN]:ARRAY OF CHAR /* fname of current files   */
  rxpathname:PTR TO CHAR    /* pointer to rx pathname    */
  txftime:LONG        /* file timestamp (UNIX)     */
  rxftime:LONG        /* file timestamp (UNIX)     */
  txfsize:LONG        /* file length               */
  rxfsize:LONG        /* file length               */
  txfd:LONG           /* file handles              */
  rxfd:LONG           /* file handles              */
  rxpktlen:INT        /* length of last packet     */
  rxblklen:INT        /* len of last good data blk */
  txblklen:INT        /* length of last block sent */
  txstate:CHAR        /* xmit/recv states          */
  rxstate:CHAR        /* xmit/recv states          */
  txpos:LONG          /* current position in files */
  rxpos:LONG          /* current position in files */
  txmaxblklen:INT     /* max block length allowed  */
  txgoodbytes:INT     /* no. sent at this blk size */
  txgoodneeded:INT    /* to send before larger blk */
  txlastack:LONG      /* last dataack received     */
  txstart1:LONG        /* time we started this file */
  txstart2:LONG        /* time we started this file */
  rxstart1:LONG        /* time we started this file */
  rxstart2:LONG        /* time we started this file */
  txoffset:LONG       /* offset in file we begun   */
  rxoffset:LONG       /* offset in file we begun   */
  txtimer:LONG        /* retry timers              */
  rxtimer:LONG        /* retry timers              */
  txretries:INT       /* retry counters            */
  rxretries:INT       /* retry counters            */
  rxlastsync:LONG     /* filepos last sync retry   */
  txsyncid:LONG       /* id of last resync         */
  rxsyncid:LONG       /* id of last resync         */
  rxnewfile:CHAR
  txnewfile:CHAR
  warned:CHAR
  nobell:CHAR

  h_dev:PTR TO LONG
  h_flags:PTR TO LONG

  chatbuf1[256+5]:ARRAY OF CHAR
  curbuf:PTR TO CHAR

  xfer_real[FNAMELEN]:ARRAY OF CHAR
  xfer_temp[FNAMELEN]:ARRAY OF CHAR
  single_file[FNAMELEN]:ARRAY OF CHAR
  xfer_pathname[FNAMELEN]:ARRAY OF CHAR
  xfer_log[FNAMELEN]:ARRAY OF CHAR
  download[FNAMELEN]:ARRAY OF CHAR
  xfer_fsize:LONG
  xfer_ftime:LONG
  cur_speed:LONG
  mailer:CHAR
  single_done:CHAR
  noresume:CHAR
  xfer_logged:CHAR
  nostamp:CHAR
  loglevel:CHAR
  opuslog:PTR TO CHAR
  result:PTR TO CHAR

  outbuff[4096]: ARRAY OF CHAR
  datalen:LONG

  txstatus[40]:ARRAY OF CHAR
  rxstatus[40]:ARRAY OF CHAR
  txresumepos:LONG
  rxresumepos:LONG
  txerrorpos:LONG

  hydra_txwindow:LONG
  hydra_rxwindow:LONG

  bytes_recv_ptr:LONG
  bytes_sent_ptr:LONG
  ultime_taken_ptr:PTR TO LONG
  dltime_taken_ptr:PTR TO LONG
  err:INT
  
  hyd_open:LONG
  hyd_close:LONG
  hyd_seek:LONG
  hyd_read:LONG
  hyd_write:LONG  
  hyd_firstfile:LONG
  hyd_nextfile:LONG
  hyd_uploadcompleted:LONG
  hyd_uploadfailed:LONG
  hyd_downloadcompleted:LONG
  hyd_dupecheck:LONG
  hyd_logmessage:LONG
  hyd_recvbyte:LONG
  hyd_flush:LONG
  hyd_isconnected:LONG
  hyd_iscancelled:LONG
  hyd_sysidle:LONG
  hyd_chatwrite:LONG
  hyd_getkey:LONG
  hyd_status:LONG
  
  devtxstate:INT     /* dev xmit state            */
  devtxtimer:LONG    /* dev xmit retry timer      */
  devtxretries:INT   /* dev xmit retry counter    */
  devtxid:LONG      /* id of last devdata pkt    */
  devrxid:LONG      /* id of last devdata pkt    */
  devtxdev[H_FLAGLEN + 1]:ARRAY OF CHAR        /* xmit device ident flag    */
  devtxbuf:PTR TO CHAR  /* ptr to usersupplied dbuf  */
  devtxlen:INT      /* len of data in xmit buf   */
ENDOBJECT


->crc16tab[(       crc ^ (c)) & 0xff] ^ ((crc >> 8) & 0x00ff)

PROC h_updcrc16(hyd:PTR TO hydra_t,crc,c) IS Eor(hyd.crc16tab[(Eor(crc,c)) AND 255],((Shr(crc,8)) AND 255)) AND $FFFF
PROC h_updcrc32(hyd:PTR TO hydra_t,crc,c) IS Eor(hyd.crc32tab[(Eor(crc,c)) AND 255],((Shr(crc,8)) AND $00ffffff))

PROC h_crc32test(crc)
  IF(crc=$debb20e3) THEN RETURN 1
ENDPROC 0

PROC h_crc16test(crc)
  IF(crc=$f0b8) THEN RETURN 1
ENDPROC 0

EXPORT PROC time() IS getSystemTime()

PROC h_timer_running(t) IS t<>0

PROC h_timer_expired(t) IS time() > t

PROC h_revdate(date,c:PTR TO CHAR) IS formatCDateTime(date,c)

PROC intell(x) IS (((x AND $FF) << 24) OR ((x AND $FF00) << 8) OR ((x AND $FF0000) >> 8) OR (((x AND $FF000000) >> 24)AND $FF))

PROC isdigit(ch) IS (ch>='0') AND (ch<='9')

PROC loc_puts(hyd:PTR TO hydra_t,s:PTR TO CHAR)
  DEF p
  p:=hyd.hyd_chatwrite
  IF p THEN p(s)
ENDPROC

PROC com_putbyte(hyd:PTR TO hydra_t,v)
  hyd.outbuff[hyd.datalen]:=v
  hyd.datalen:=hyd.datalen+1
  IF hyd.datalen=4096 THEN com_flush(hyd)
ENDPROC

PROC com_flush(hyd:PTR TO hydra_t)
  DEF p
  p:=hyd.hyd_flush
  IF p
    p(hyd.outbuff,hyd.datalen)
    hyd.datalen:=0
  ENDIF
/* com_flush(VOID):
	 *
	 *	Make sure all pending data gets written.
	 */
ENDPROC

PROC com_purge()
/* com_purge(VOID):
	 *
	 *	Clear the read/write buffers.
	 */
  ->WriteF('com_purge\n')

ENDPROC

PROC com_dump(hyd)
	com_flush(hyd)
ENDPROC

PROC com_getbyte(hyd:PTR TO hydra_t)
  DEF p
	/* com_getbyte(VOID):
	 *
	 *	Read a single byte from the serial line. If not available,
	 *	return EOF.
	 */
  p:=hyd.hyd_recvbyte
  IF p
    RETURN p(0)
  ENDIF
ENDPROC -1

PROC com_outfull()
/* com_outfull(VOID):
	 *
	 *	Return number of bytes still to be transferred.
	 */
ENDPROC 0

PROC com_putblock(hyd:PTR TO hydra_t,b,l)
  DEF i
	/* com_putblock(byte *s,word len):
	 *
	 *	Send a data block asynchronously.
	 */
   FOR i:=0 TO l-1 DO com_putbyte(hyd,b[]++)
  com_flush(hyd)
ENDPROC

PROC dologmessage(hyd:PTR TO hydra_t,code,msg)
  DEF p
  p:=hyd.hyd_logmessage
  IF p
    p(code,msg)
  ENDIF
ENDPROC

PROC get_key(hyd:PTR TO hydra_t)
  DEF p
  p:=hyd.hyd_getkey
  IF p THEN RETURN p()
ENDPROC -1

PROC keyabort(hyd:PTR TO hydra_t)
  DEF p:PTR TO CHAR
  DEF esc=FALSE
  DEF s[255]:STRING
  DEF c

  IF (hyd.chattimer > 0)
     IF (time() > hyd.chattimer)
        hyd.chattimer:=0
        hyd.lasttimer:=0
        hydra_devsend(hyd,'CON',CHATTIME,StrLen(CHATTIME))
        loc_puts(hyd,CHATTIME+2)
     ELSEIF (((time() + 10) > hyd.chattimer) AND (hyd.warned=FALSE))
        loc_puts(hyd,'\!\b\n * Warning: chat mode timeout in 10 seconds\b\n')
        hyd.warned:=TRUE
     ENDIF
  ELSEIF (hyd.chattimer <> hyd.lasttimer)
     IF (hyd.chattimer=0)
        IF (hyd.nobell) 
          p:=' * Remote has chat facility with bell disabled\n';
        ELSE 
          p:= ' * Remote has chat facility with bell enabled\n';
        ENDIF
        hydra_devsend(hyd,'CON',p,StrLen(p))
        loc_puts(hyd,' * Hydra session in progress, chat facility now available\b\n')
     ELSEIF (hyd.chattimer = -1)
        loc_puts(hyd,' * Hydra session in init state, can''t chat yet\b\n')
     ELSEIF (hyd.chattimer = -2)
        loc_puts(hyd,' * Remote has no chat facility available\b\n')
     ELSEIF (hyd.chattimer = -3)
        IF (hyd.lasttimer > 0) THEN loc_puts(hyd,'\b\n')
        loc_puts(hyd,' * Hydra session in exit state, can''t chat anymore\b\n')
     ENDIF
     hyd.lasttimer:=hyd.chattimer
  ENDIF

  c:=get_key(hyd)
  IF c=27
      esc:=TRUE
  ELSEIF (c="\b") OR (c=8) OR (c=7) OR ((c >= " ") AND (c < 127))
    IF (hyd.chattimer>0)

      hyd.chattimer:=time() + CHAT_TIMEOUT
      hyd.warned:=FALSE

      IF (hyd.chatfill >= CHATLEN)
         loc_puts(hyd,'\!')
      ELSE
        IF (c="\b")
          hyd.curbuf[hyd.chatfill]:="\n"
          hyd.chatfill:=hyd.chatfill+1
          loc_puts(hyd,'\b\n')
        ELSEIF(c=8)

          IF ((hyd.chatfill > 0) AND (hyd.curbuf[hyd.chatfill - 1] <> "\n"))
              hyd.chatfill:=hyd.chatfill-1
          ELSE
            hyd.curbuf[hyd.chatfill]:=8
            hyd.chatfill:=hyd.chatfill+1
            hyd.curbuf[hyd.chatfill]:=" "
            hyd.chatfill:=hyd.chatfill+1
            hyd.curbuf[hyd.chatfill]:=8
            hyd.chatfill:=hyd.chatfill+1
          ENDIF
          loc_puts(hyd,'\h08 \h08')
        ELSE
          hyd.curbuf[hyd.chatfill]:=c
          hyd.chatfill:=hyd.chatfill+1
          IF (c <> 7)
            StringF(s,'\c',c)
            loc_puts(hyd,s)
          ENDIF
        ENDIF
      ENDIF
    
    ENDIF
  ELSEIF (c=3)
    IF (hyd.chattimer=0)
       hydra_devsend(hyd,'CON',CHATSTART,StrLen(CHATSTART))
       loc_puts(hyd,CHATSTART+2)
       hyd.chattimer:=time() + CHAT_TIMEOUT
       hyd.lasttimer:=hyd.chattimer
    ELSEIF (hyd.chattimer > 0)
       hyd.chattimer:=0
       hyd.lasttimer:=0
       hydra_devsend(hyd,'CON',CHATEND,StrLen(CHATEND))
       loc_puts(hyd,CHATEND+2)
    ELSE
      loc_puts(hyd,'\!')
    ENDIF
  ELSE
  ENDIF
  

  IF (hyd.chatfill > 0)
    IF hydra_devsend(hyd,'CON',hyd.curbuf,hyd.chatfill)
      hyd.curbuf:=hyd.chatbuf1
      hyd.chatfill:=0
    ENDIF
  ENDIF

ENDPROC esc

PROC carrier(hyd:PTR TO hydra_t)
  DEF p
  p:=hyd.hyd_isconnected
  IF p
    RETURN p()
  ENDIF
ENDPROC TRUE


PROC setstamp(name:PTR TO CHAR,time)
  DEF ds:datestamp
  dateTimeToDateStamp(time,ds)
  SetFileDate(name,ds)
ENDPROC

PROC stat(fn:PTR TO CHAR)
  DEF fsize=-1,fdate=-1
  DEF fBlock: fileinfoblock
  DEF fLock

  IF((fLock:=Lock(fn,ACCESS_READ)))=NIL
    RETURN -1,-1
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN -1,-1
  ENDIF
  IF(Examine(fLock,fBlock))
    fsize:=fBlock.size
    fdate:=dateStampToDateTime(fBlock.datestamp)    
  ENDIF
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC fsize,fdate

PROC dosys_idle(hyd:PTR TO hydra_t)
  DEF p
  p:=hyd.hyd_sysidle
  IF p THEN p()
ENDPROC

PROC freespace(s)
ENDPROC 10000000

PROC getFileDate(fn:PTR TO CHAR)
  DEF fdate=-1
  DEF fBlock: fileinfoblock
  DEF fLock

  IF((fLock:=Lock(fn,ACCESS_READ)))=NIL
    RETURN -1,-1
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN -1,-1
  ENDIF
  IF(Examine(fLock,fBlock))
    fdate:=dateStampToDateTime(fBlock.datestamp)    
  ENDIF
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC fdate

PROC resultlog(hyd:PTR TO hydra_t,xmit, fname:PTR TO CHAR, bytes, xfertime)
  DEF fp
  DEF s[255]:STRING

  IF (hyd.opuslog)
    IF ((fp:=Open(hyd.opuslog,MODE_READWRITE))>0)
      Seek(fp,0,OFFSET_END)
      IF (fname)
         PutF(fp, '\s \s\s \d', IF xmit THEN 'Sent' ELSE 'Got',
                     IF xmit THEN '' ELSE hyd.download, fname, bytes)
         IF (hyd.mailer) THEN PutF(fp,' \d',xfertime)
         PutF(fp,'\n')
      ENDIF
      Close(fp)
    ELSE
      StringF(s,'-Couldn''t append opus log-file \s',hyd.opuslog)
      dologmessage(hyd,3,s)
    ENDIF
  ENDIF

  IF (hyd.result)
    IF ((fp:=Open(hyd.result,MODE_READWRITE))>0)
      Seek(fp,0,OFFSET_END)
      IF (fname)
        PutF(fp,'\c \d[6] \u[5] bps \d[4] cps 0 errors     0 1024 \s -1\n',
                     IF xmit THEN "H" ELSE "R",
                     bytes, hyd.cur_speed,
                     IF xfertime THEN (bytes / xfertime) ELSE 9999,
                     fname)
      ENDIF
      Close(fp)
    ELSE
      StringF(s,'-Couldn''t append result-file \s',hyd.result)
      dologmessage(hyd,3,s)
    ENDIF
  ENDIF
ENDPROC

PROC xfer_bad(hyd:PTR TO hydra_t)
  DEF fsize,fp,n
  IF (hyd.single_file[0]) THEN hyd.single_done:=TRUE
  
  IF (hyd.xfer_logged) THEN RETURN TRUE                        /* Already a logged bad-xfer */
  
  n:=StrLen(hyd.xfer_real) - 1
  IF ((n > 3) AND ((StrCmp(hyd.xfer_real+n-3,'.PKT')=FALSE) OR ((StrCmp(hyd.xfer_real+n-3,'.REQ')=FALSE))))
    xfer_del(hyd)
    RETURN FALSE                      /* don't recover .PKT / .REQ */
  ENDIF
  
  fsize:=FileLength(hyd.xfer_pathname)
  IF (hyd.noresume OR (fsize < 1024))     /* not allowed/worth saving */
    xfer_del(hyd)
    RETURN FALSE
  ENDIF
  
  IF ((fp:=Open(hyd.xfer_log,MODE_READWRITE))>=0)
    Seek(fp,0,OFFSET_END)
    PutF(fp, '\s \s \d \d\n',hyd.xfer_real, hyd.xfer_temp, hyd.xfer_fsize, hyd.xfer_ftime)
    Close(fp)
  
    RETURN TRUE                             /* bad-xfer logged now */
  ENDIF
  
  xfer_del(hyd)
  /* Couldn't log bad-xfer */
ENDPROC FALSE

PROC xfer_del(hyd:PTR TO hydra_t)
  DEF new_log[FNAMELEN]:ARRAY OF CHAR
  DEF linebuf[256]:STRING
  DEF bad_real[FNAMELEN]:ARRAY OF CHAR
  DEF bad_temp[FNAMELEN]:ARRAY OF CHAR
  DEF bad_fsize,bad_ftime;
  DEF fp,new_fp
  DEF left
  DEF p,lb

  IF (FileLength(hyd.xfer_pathname)>=0) THEN DeleteFile(hyd.xfer_pathname)
  IF ((fp:=Open(hyd.xfer_log,MODE_OLDFILE))>=0)
    AstrCopy(new_log,hyd.download)
    AddPart(new_log,'BAD-XFER.$$$',256)
    IF ((new_fp:=Open(new_log, MODE_NEWFILE))>=0)
      left:=FALSE
      WHILE (ReadStr(fp,linebuf)<>-1) OR (StrLen(linebuf)>0)
            StrCopy(bad_real,'')
            StrCopy(bad_temp,'')
            bad_fsize:=0
            bad_ftime:=0
            IF (p:=InStr(linebuf,' '))>=0
              StrCopy(bad_real,linebuf,p)
              lb:=p+1
              IF (p:=InStr(linebuf+lb,' '))>=0
                StrCopy(bad_temp,linebuf+lb,p)
                lb:=lb+p+1
                bad_fsize:=Val(linebuf+lb)
                IF (p:=InStr(linebuf+lb,' '))>=0
                  bad_ftime:=Val(linebuf+lb+p)
                ENDIF
              ENDIF
            ENDIF
            /*sscanf(linebuf,"%s %s %ld %lo",
                           bad_real, bad_temp, &bad_fsize, &bad_fime);*/
                           ->this
            IF (StrCmp(hyd.xfer_real,bad_real) OR StrCmp(hyd.xfer_temp,bad_temp) OR (hyd.xfer_fsize <> bad_fsize) OR (hyd.xfer_ftime <> bad_ftime))
              PutF(new_fp,'\s',linebuf)
              left:=TRUE
            ENDIF
      ENDWHILE
      Close(fp)
      Close(new_fp)
      DeleteFile(hyd.xfer_log)
      IF (left)
        Rename(new_log,hyd.xfer_log)
      ELSE
        DeleteFile(new_log)
      ENDIF
    
    ELSE
      Close(fp)
    ENDIF
  ENDIF

ENDPROC

PROC xfer_init(hyd:PTR TO hydra_t,fname:PTR TO CHAR,fsize,ftime)
  DEF linebuf[256]:STRING
  DEF bad_real[FNAMELEN]:ARRAY OF CHAR
  DEF bad_temp[FNAMELEN]:ARRAY OF CHAR
  DEF  bad_fsize, bad_ftime, p:PTR TO CHAR, fp
  DEF lb

  IF (hyd.single_done) THEN RETURN NIL
  
  AstrCopy(hyd.xfer_real,fname)
  hyd.xfer_fsize:=fsize
  hyd.xfer_ftime:=ftime

  AstrCopy(hyd.xfer_pathname,hyd.download)
  AddPart(hyd.xfer_pathname,hyd.xfer_real,256)

  IF (FileLength(hyd.xfer_pathname)>=0)
     /* already have file */
     IF ((hyd.xfer_fsize = FileLength(hyd.xfer_pathname)) AND (hyd.xfer_ftime = getFileDate(hyd.xfer_pathname))) THEN RETURN NIL
  ENDIF

  AstrCopy(hyd.xfer_log,hyd.download)
  AddPart(hyd.xfer_log,'BAD-XFER.LOG',256)

  IF ((fp:=Open(hyd.xfer_log,MODE_OLDFILE))>0)
     WHILE (ReadStr(fp,linebuf)<>-1) OR (StrLen(linebuf)>0)
          StrCopy(bad_real,'')
          StrCopy(bad_temp,'')
          bad_fsize:=0
          bad_ftime:=0
          IF (p:=InStr(linebuf,' '))>=0
            StrCopy(bad_real,linebuf,p)
            lb:=p+1
            IF (p:=InStr(linebuf+lb,' '))>=0
              StrCopy(bad_temp,linebuf+lb,p)
              lb:=lb+p+1
              bad_fsize:=Val(linebuf+lb)
              IF (p:=InStr(linebuf+lb,' '))>=0
                bad_ftime:=Val(linebuf+lb+p)
              ENDIF
            ENDIF
          ENDIF
           /*sscanf(linebuf,"%s %s %ld %lo",
                          bad_real, bad_temp, &bad_fsize, &bad_ftime);
                          */
                          ->this
           IF ((StrCmp(hyd.xfer_real,bad_real)=FALSE) AND (hyd.xfer_fsize = bad_fsize) AND (hyd.xfer_ftime = bad_ftime))
              AstrCopy(hyd.xfer_pathname,hyd.download)
              AddPart(hyd.xfer_pathname,bad_temp,255);
              IF (FileLength(hyd.xfer_pathname)>=0)
                Close(fp)
                AstrCopy(hyd.xfer_temp,bad_temp)

                hyd.xfer_logged:=TRUE
                RETURN hyd.xfer_pathname
              ENDIF
           ENDIF
     ENDWHILE

     Close(fp)
  ENDIF

  AstrCopy(hyd.xfer_pathname,hyd.download)
  p:=hyd.xfer_pathname + StrLen(hyd.xfer_pathname)
  AddPart(hyd.xfer_pathname,'BAD-XFER.000',FNAMELEN)
  unique_name(hyd.xfer_pathname);
  AstrCopy(hyd.xfer_temp,p)

  hyd.xfer_logged:=FALSE
ENDPROC hyd.xfer_pathname

PROC xfer_okay(hyd:PTR TO hydra_t)
  DEF new_pathname[FNAMELEN]:ARRAY OF CHAR
  DEF p:PTR TO CHAR

  AstrCopy(new_pathname,hyd.download)
  p:= new_pathname + StrLen(new_pathname);   /* start of fname */
  IF (hyd.single_file[0])
    AddPart(new_pathname,hyd.single_file,FNAMELEN)  /* add override fname */
    hyd.single_done:=TRUE
  ELSE
    AddPart(new_pathname,hyd.xfer_real,FNAMELEN)                 /* add real fname */
    unique_name(new_pathname)                      /* make it unique */
  ENDIF
  
  Rename(hyd.xfer_pathname,new_pathname)           /* rename temp to real */
  IF ((hyd.nostamp=0) AND hyd.xfer_ftime)
     setstamp(new_pathname,hyd.xfer_ftime);               /* set timestamp */
  ENDIF

  IF (hyd.xfer_logged) THEN xfer_del(hyd)              /* delete from bad-xfer log */

  IF StrCmp(p,hyd.xfer_real)=FALSE THEN RETURN hyd.xfer_real    /* dup rename? */
ENDPROC 0

PROC unique_name(pathname:PTR TO CHAR)
  DEF p:PTR TO CHAR, n
  DEF suffix[4]:STRING
  
  StrCopy(suffix,'.000')

  IF (FileLength(pathname)>=0)
    p:=pathname
    WHILE (p[] AND (p[]<>'.')) DO p++ 
    FOR n:=0 TO 3
      IF (p[]=0)
        p[]:=suffix[n]
        p++
        p[]:=0
      ELSE
        p++
      ENDIF
    ENDFOR

    WHILE(FileLength(pathname)>=0)
      p:=pathname + (StrLen(pathname)) - 1
      IF (isdigit(p[])=0)
        p[]:=0
      ELSE
        FOR n:=3 TO 0 STEP -1
          IF (isdigit(p[])=0) THEN p[]:=0
          p++
          EXIT p[]<='9'
          p[]:=0
          p--
        ENDFOR
      ENDIF
    ENDWHILE
  ENDIF

ENDPROC

->hydracommui speed 115200 port 0 line 2400 device serial.device nocarrier receive dl: size 0/235/652/170 nologwin term

PROC hydra_devfree(hyd:PTR TO hydra_t)
  IF (hyd.devtxstate OR ((hyd.txoptions AND HOPT_DEVICE)=0) OR (hyd.txstate >= HTX_END))
    RETURN FALSE                      /* busy or not allowed       */
  ELSE
    RETURN TRUE                       /* allowed to send a new pkt */
  ENDIF
ENDPROC/*hydra_devfree()*/


/*---------------------------------------------------------------------------*/
PROC hydra_devsend(hyd:PTR TO hydra_t,dev:PTR TO CHAR, data:PTR TO CHAR,len)

  IF ((dev=0) OR (data=0) OR (len=0) OR (hydra_devfree(hyd)=FALSE)) THEN RETURN FALSE


  AstrCopy(hyd.devtxdev,dev,H_FLAGLEN+1)

  hyd.devtxbuf:=data
  hyd.devtxlen:=IF (len > H_MAXBLKLEN) THEN H_MAXBLKLEN ELSE len

  hyd.devtxid:=hyd.devtxid+1
  hyd.devtxtimer:=0
  hyd.devtxretries:=0
  hyd.devtxstate:=HTD_DATA

  /* special for chat, only prolong life if our side keeps typing! */
  IF ((hyd.chattimer > 0) AND (OstrCmp(hyd.devtxdev,'CON')=FALSE) AND (hyd.txstate = HTX_REND))
     hyd.braindead:=time()+H_BRAINDEAD
  ENDIF

ENDPROC TRUE/*hydra_devsend()*/


/*---------------------------------------------------------------------------*/
PROC hydra_devfunc(hyd:PTR TO hydra_t,dev:PTR TO CHAR,func)
  DEF i
  DEF dv:PTR TO h_dev

  i:=0;
  dv:=hyd.h_dev[i]
  WHILE (dv.dev)
    IF (OstrCmp(dev,dv.dev,H_FLAGLEN))
       dv.func:=func
       RETURN TRUE
    ENDIF
    i++
    dv:=hyd.h_dev[i]
  ENDWHILE

ENDPROC FALSE/*hydra_devfunc()*/


/*---------------------------------------------------------------------------*/
PROC hydra_devrecv(hyd:PTR TO hydra_t)
  DEF i,p,len,f
  DEF dv:PTR TO h_dev
  
  p:=hyd.rxbuf
  len:=hyd.rxpktlen

  p+=SIZEOF LONG                       /* skip the id long  */
  len-=SIZEOF LONG
  i:=0
  dv:=hyd.h_dev[i]
  WHILE (dv.dev)                /* walk through devs */
    IF (OstrCmp(p,dv.dev,H_FLAGLEN))
      IF (dv.func)
         len-=StrLen(p)+1         /* sub devstr len    */
         p+=StrLen(p)+1           /* skip devtag       */
         p[len]:=0;                        /* NUL terminate     */
         f:=dv.func
         f(hyd,p,len)                   /* call output func  */
      ENDIF
     EXIT TRUE
    ENDIF
    i++
    dv:=hyd.h_dev[i]
  ENDWHILE
ENDPROC/*hydra_devrecv()*/


/*---------------------------------------------------------------------------*/
PROC put_flags(buf:PTR TO CHAR,flags:PTR TO LONG,val)
  DEF i,p:PTR TO CHAR
  DEF fl:PTR TO h_flags

  p:=buf;
  i:=0
  fl:=flags[i]
  WHILE  (fl.val)
    IF (val AND fl.val)
      IF (p > buf) THEN p[]++:=","
      AstrCopy(p,fl.str)
      p+=H_FLAGLEN
    ENDIF
    i++
    fl:=flags[i]
  ENDWHILE
  p[]:=0
ENDPROC/*put_flags()*/


/*---------------------------------------------------------------------------*/
PROC get_flags(buf:PTR TO CHAR, flags:PTR TO LONG)
  DEF val,p:PTR TO CHAR,i
  DEF fl:PTR TO h_flags
  DEF s[255]:STRING
  
  val:=0
  REPEAT
    IF (p:=InStr(buf,','))>=0
      StrCopy(s,buf,p)
      buf:=buf+p+1
    ELSE
      StrCopy(s,buf)
      buf:=0
    ENDIF
    i:=0
    fl:=flags[i]
    WHILE (fl.val)
      IF (StrCmp(s,fl.str))
        val:=val OR fl.val
        EXIT TRUE
      ENDIF
      i++
      fl:=flags[i]
    ENDWHILE
  UNTIL buf=0

ENDPROC val /*get_flags()*/


/*---------------------------------------------------------------------------*/
PROC crc16block(hyd:PTR TO hydra_t,buf:PTR TO CHAR,len)
  DEF crc=$ffff,i

  FOR i:=0 TO len-1
    crc:=h_updcrc16(hyd,crc,buf[]++)
  ENDFOR
  
ENDPROC crc/*crc16block()*/


/*---------------------------------------------------------------------------*/
PROC crc32block(hyd:PTR TO hydra_t,buf:PTR TO CHAR,len)
  DEF crc=$ffffffff,i

  FOR i:=0 TO len-1
    crc:=h_updcrc32(hyd,crc,buf[]++)
  ENDFOR
ENDPROC crc/*crc32block()*/


/*---------------------------------------------------------------------------*/
PROC put_binbyte(hyd:PTR TO hydra_t,p:PTR TO CHAR,c)
  DEF n

  n:=c
  IF (hyd.txoptions AND HOPT_HIGHCTL) THEN n:=n AND $7f

  IF ((n = H_DLE) OR
        (((hyd.txoptions AND HOPT_XONXOFF) AND ((n = XON) OR (n = XOFF))) OR
        ((hyd.txoptions AND HOPT_TELENET) AND (n = "\b") AND (hyd.txlastc = "@")) OR
        ((hyd.txoptions AND HOPT_CTLCHRS) AND ((n < 32) OR (n = 127))))
      )
     p[]++:=H_DLE
     c:=Eor(c,$40)
  ENDIF

  p[]++:=c
  hyd.txlastc:=n

ENDPROC p/*put_binbyte()*/


PROC rem_chat(hyd:PTR TO hydra_t,data:PTR TO CHAR,len)
  DEF c
  DEF s[10]:STRING
  WHILE data[]
    c:=data[]
    SELECT c
      CASE 7
        IF (hyd.nobell=FALSE)
          loc_puts(hyd,'\!')
        ENDIF
      CASE "\n"
        loc_puts(hyd,'\b\n')

      DEFAULT
        StringF(s,'\c',c)
        loc_puts(hyd,s)
    ENDSELECT
    data++
  ENDWHILE
ENDPROC

PROC hydra_msgdev(hyd:PTR TO hydra_t,data:PTR TO CHAR,len)
  DEF s
  /* text is already NUL terminated by calling func hydra_devrecv() */
  s:=String(StrLen(data)+20)
  StrCopy(s,'*HMSGDEV: \s',data)
  dologmessage(hyd,3,s)
  DisposeLink(s)
ENDPROC /*hydra_msgdev()*/

/*---------------------------------------------------------------------------*/
PROC dohydra_status(hyd:PTR TO hydra_t,xmit)
  DEF p
  p:=hyd.hyd_status
  IF p THEN p(hyd,xmit)
  
  IF xmit
    hyd.txnewfile:=FALSE
  ELSE
    hyd.rxnewfile:=FALSE
  ENDIF
ENDPROC

/*---------------------------------------------------------------------------*/
PROC hydra_pct(hyd:PTR TO hydra_t,xmit)

  DEF offset,fsize,start1,start2,elapsed,bytes,cps,pct
  DEF t1,t2
  DEF s[255]:STRING
  
  IF xmit
    offset:=hyd.txoffset
    fsize:=hyd.txfsize
    start1:=hyd.txstart1
    start2:=hyd.txstart2
  ELSE
    offset:=hyd.rxoffset
    fsize:=hyd.rxfsize
    start1:=hyd.rxstart1
    start2:=hyd.rxstart2
  ENDIF
  
  t1,t2:=time()
  elapsed:=Div(Mul((t1-start1),50)+t2-start2,50)
  bytes:=fsize-offset
  IF ((bytes < 1024) OR (elapsed = 0)) THEN RETURN

  cps:=Div(bytes,elapsed)
  pct:= Div(Mul(cps,1000),hyd.cur_speed)

  StringF(s,'+\s-H CPS: \d (\d bytes), \d:\d[2] min.  Eff: \d%',
          IF xmit THEN 'Sent' ELSE 'Rcvd', cps, bytes,
          Div(elapsed,60),Mod(elapsed,60), pct)

  dologmessage(hyd,2,s)
ENDPROC/*hydra_pct()*/


/*---------------------------------------------------------------------------*/
PROC hydra_badxfer(hyd:PTR TO hydra_t)
  DEF proc
  IF (hyd.rxfd >= 0)
    proc:=hyd.hyd_close
    proc(hyd.rxfd)
    hyd.rxfd:=-1
    IF (xfer_bad(hyd))
      dologmessage(hyd,1,'+HRECV: Bad xfer recovery-info saved')
    ELSE
      dologmessage(hyd,0,'-HRECV: Bad xfer - file deleted')
    ENDIF
  ENDIF
ENDPROC/*hydra_badxfer()*/


/*---------------------------------------------------------------------------*/
PROC txpkt (hyd:PTR TO hydra_t,len, type)
  DEF in:PTR TO CHAR, out:PTR TO CHAR
  DEF c,n
  DEF crc32=FALSE
  DEF format,crc,i
  DEF hxd:PTR TO CHAR
->#ifdef H_DEBUG
  DEF s1:PTR TO CHAR
  DEF s2:PTR TO CHAR
  DEF s3:PTR TO CHAR
  DEF s4:PTR TO CHAR
  DEF s[255]:STRING
  DEF t
->#endif
  
  hxd:=HEXDIGIT

  hyd.txbufin[len++]:=type

  IF (type=HPKT_START) OR (type=HPKT_INIT) OR (type=HPKT_INITACK) OR (type=HPKT_END) OR (type=HPKT_IDLE)
    format:=HCHR_HEXPKT
  ELSE
    /* COULD do smart format selection depending on data and options! */
    IF (hyd.txoptions AND HOPT_HIGHBIT)
      IF ((hyd.txoptions AND HOPT_CTLCHRS) AND (hyd.txoptions AND HOPT_CANUUE))
        format:=HCHR_UUEPKT
      ELSEIF (hyd.txoptions AND HOPT_CANASC)
        format:=HCHR_ASCPKT
      ELSE
        format:=HCHR_HEXPKT
      ENDIF
    ELSE
      format:=HCHR_BINPKT
    ENDIF
  ENDIF

  IF ((format <> HCHR_HEXPKT) AND (hyd.txoptions AND HOPT_CRC32)) THEN crc32:=TRUE


->#ifdef H_DEBUG
    IF (hyd.loglevel=0) 

      StringF(s,' -> PKT (format=''\c''  type=''\c''  crc=\d  len=\d)',format, type, IF crc32 THEN 32 ELSE 16, len - 1)
      dologmessage(hyd,0,s)

      SELECT type
              CASE HPKT_START
                dologmessage(hyd,0,'    <autostr>START')
              CASE HPKT_INIT
                s1:=(hyd.txbufin) + (StrLen(hyd.txbufin)) + 1
                s2:=s1+(StrLen(s1)) + 1
                s3:=s2+(StrLen(s2)) + 1
                s4:=s3+(StrLen(s3)) + 1
                StringF(s,'    INIT (appinfo=''\s''  can=''\s''  want=''\s''  options=''\s''  pktprefix=''\s'')',hyd.txbufin, s1, s2, s3, s4)
                dologmessage(hyd,0,s)
              CASE HPKT_INITACK
                dologmessage(hyd,0,'    INITACK')
              CASE HPKT_FINFO
                StringF(s,'    FINFO (\s)',hyd.txbufin)
                dologmessage(hyd,0,s)
              CASE HPKT_FINFOACK
                IF (hyd.rxfd >= 0)
                  IF (hyd.rxpos > 0)
                    s1:='RES'
                  ELSE
                    s1:='BOF'
                  ENDIF
                ELSEIF (hyd.rxpos = -1)
                  s1:='HAVE'
                ELSEIF (hyd.rxpos = -2)
                  s1:='SKIP'
                
                ELSE 
                  s1:='EOB'
                ENDIF
                StringF(s,'    FINFOACK (pos=\d \s  rxstate=\d  rxfd=\d)',hyd.rxpos,s1,hyd.rxstate,hyd.rxfd)
                dologmessage(hyd,0,s)
              CASE HPKT_DATA
                StringF(s,'    DATA (ofs=\d  len=\d)',intell(Long(hyd.txbufin)), len - 5)
                dologmessage(hyd,0,s)
              CASE HPKT_DATAACK
                StringF(s,'    DATAACK (ofs=\d)',intell(Long(hyd.txbufin)))
                dologmessage(hyd,0,s)
              CASE HPKT_RPOS
                StringF(s,'    RPOS (pos=\d\s  blklen=\d  syncid=\d)',hyd.rxpos, IF hyd.rxpos < 0 THEN ' SKIP' ELSE '',intell(Long(hyd.txbufin+4)), hyd.rxsyncid)
                dologmessage(hyd,0,s)
              CASE HPKT_EOF
                StringF(s,'    EOF (ofs=\d\s)',hyd.txpos, IF hyd.txpos < 0 THEN ' SKIP' ELSE '')
                dologmessage(hyd,0,s)
              CASE HPKT_EOFACK
                dologmessage(hyd,0,'    EOFACK')
              CASE HPKT_IDLE
                dologmessage(hyd,0,'    IDLE')
              CASE HPKT_END
                dologmessage(hyd,0,'    END')
              CASE HPKT_DEVDATA
                StringF(s,'    DEVDATA (id=\d  dev=''\s''  len=\u)',hyd.devtxid, hyd.devtxdev, hyd.devtxlen)
                dologmessage(hyd,0,s)
              CASE HPKT_DEVDACK
                StringF(s,'    DEVDACK (id=\d)',intell(Long(hyd.rxbuf)))
                dologmessage(hyd,0,s)
              DEFAULT
              /* This couldn't possibly happen! ;-) */

      ENDSELECT
    ENDIF
->#endif


  IF(crc32)
     crc:=Not(crc32block(hyd,hyd.txbufin,len))

     hyd.txbufin[len++]:=crc
     hyd.txbufin[len++]:=Shr(crc,8)
     hyd.txbufin[len++]:=Shr(crc,16)
     hyd.txbufin[len++]:=Shr(crc,24)
  ELSE
     crc:=Not(crc16block(hyd,hyd.txbufin,len))

     hyd.txbufin[len++]:=crc
     hyd.txbufin[len++]:= Shr(crc,8)
  ENDIF

  in:=hyd.txbufin
  out:=hyd.txbuf
  hyd.txlastc:=0
  out[]++:=H_DLE
  out[]++:=format

  SELECT (format)
    CASE HCHR_HEXPKT
      FOR i:=1 TO len
        IF (in[] AND $80)
          out[]++:="\\"
          out[]++:=hxd[(Shr(in[],4)) AND $f]
          out[]++:=hxd[in[] AND $f]
        ELSEIF ((in[] < 32) OR (in[] = 127))
          out[]++:=H_DLE
          out[]++:=Eor(in[],$40)
        ELSEIF (in[] = "\\")
          out[]++:="\\"
          out[]++:="\\"
        ELSE
          out[]++:=in[]
        ENDIF
        in++
      ENDFOR
    
    CASE HCHR_BINPKT
      FOR i:=1 TO len
        out:=put_binbyte(hyd,out,in[]++)
      ENDFOR
    
    CASE HCHR_ASCPKT
      c:=0
      n:=0
      FOR i:=0 TO len-1
        c:=c OR (Shl((in[]++),n))
        out:=put_binbyte(hyd,out,c AND $7f)
        c:=Shr(c,7)
        n++
        IF (n>= 7)
           out:=put_binbyte(hyd,out,c AND $7f)
           n:=0
           c:=0
        ENDIF
      ENDFOR
      IF  (n > 0) THEN out:=put_binbyte(hyd,out,c AND $7f)
    
    CASE HCHR_UUEPKT
      WHILE len>=3
      
        out[]++:=h_uuenc(Shr(in[0],2))
        out[]++:=h_uuenc((Shl(in[0],4) AND $30) OR ((Shr(in[1],4)) AND $f))
        out[]++:=h_uuenc((Shl(in[1],2) AND $3c) OR ((Shr(in[2],6)) AND $3))
        out[]++:=h_uuenc(in[2] AND $3f)

        in+=3
        len-=3
      ENDWHILE

      IF (len > 0)
         out[]++:=h_uuenc(Shr(in[0],2))
         out[]++:=h_uuenc(((Shl(in[0],4)) AND $30) OR ((Shr(in[1],4)) AND $f))
         IF (len = 2) THEN out[]++:=h_uuenc((Shl(in[1],2)) AND $3c)
      ENDIF
  ENDSELECT

  out[]++:=H_DLE
  out[]++:=HCHR_PKTEND

  IF ((type<>HPKT_DATA) AND (format<>HCHR_BINPKT))
    out[]++:="\b"
    out[]++:="\n"
  ENDIF

  in:=hyd.txpktprefix
  WHILE in[]
    SELECT in[]
      CASE 221 /* transmit break signal for one second */
        NOP
      CASE 222
        t:=time()+2
        WHILE (h_timer_expired(t)=FALSE) DO dosys_idle(hyd)
      CASE 223
        com_putbyte(hyd,0)
      DEFAULT
        com_putbyte(hyd,in[])
    ENDSELECT
    in++
  ENDWHILE

  com_putblock(hyd,hyd.txbuf,(out - hyd.txbuf))
ENDPROC/*txpkt()*/

PROC rxpkt(hyd:PTR TO hydra_t)
  DEF p:PTR TO CHAR, q:PTR TO CHAR
  DEF c,n,i
->#ifdef H_DEBUG
  DEF s1:PTR TO CHAR
  DEF s2:PTR TO CHAR
  DEF s3:PTR TO CHAR
  DEF s4:PTR TO CHAR
->#endif
  DEF s[255]:STRING

  dosys_idle(hyd)
  dohydra_status(hyd,FALSE)
  IF (keyabort(hyd)) THEN RETURN H_SYSABORT
  IF (carrier(hyd)=FALSE) THEN RETURN H_CARRIER

  p:=hyd.rxbufptr;

        WHILE ((c:=com_getbyte(hyd)) >= 0)
              IF (hyd.rxoptions AND HOPT_HIGHBIT) THEN c:=c AND $7f

              n:=c
              IF (hyd.rxoptions AND HOPT_HIGHCTL) THEN n:=n AND $7f
              
              IF ((n <> H_DLE) AND
                  (((hyd.rxoptions AND HOPT_XONXOFF) AND ((n = XON) OR (n = XOFF))) OR
                   ((hyd.rxoptions AND HOPT_CTLCHRS) AND ((n < 32) OR (n = 127)))))
                CONT TRUE
              ENDIF

              IF (hyd.rxdle OR (c = H_DLE))
                ->SELECT c
                        IF c=H_DLE
                          hyd.rxdle:=hyd.rxdle+1
                          IF (hyd.rxdle >= 5) THEN RETURN H_CANCEL

                        ELSEIF c=HCHR_PKTEND
                             hyd.rxbufptr:=p

                             SELECT hyd.rxpktformat
                                CASE HCHR_BINPKT
                                  q:=hyd.rxbufptr

                                CASE HCHR_HEXPKT
                                    q:=hyd.rxbuf
                                    p:=q
                                    WHILE p<hyd.rxbufptr
                                      IF ((p[] = 92 ) AND (p[1] <> 92))  -> 92 = \
                                        p++
                                        i:=p[]++
                                        n:=p[]
                                        i-="0"
                                        n-="0"
                                        IF (i > 9) THEN i -= ("a" - ":")
                                        IF (n > 9) THEN n -= ("a" - ":")
                                        IF ((i AND (Not($f))) OR (n AND (Not($f))))
                                           i:=H_NOPKT
                                           JUMP brk2
                                        ENDIF
                                        q[]++:=Shl(i,4) OR n
                                      ELSE
                                        q[]++:=p[]
                                      ENDIF
                                      p++
                                    ENDWHILE
                                    IF (p > hyd.rxbufptr) THEN c:=H_NOPKT

                                CASE HCHR_ASCPKT
                                  n:=0
                                  i:=0
                                  p:=hyd.rxbuf
                                  q:=p
                                  WHILE (p<hyd.rxbufptr)
                                      i:=i OR (Shl(p[] AND $7f,n))
                                      IF ((n += 7) >= 8)
                                         q[]++:=(i AND $ff)
                                         i:=Shr(i,8)
                                         n -= 8
                                      ENDIF
                                    p++
                                  ENDWHILE

                                CASE HCHR_UUEPKT
                                  n:=hyd.rxbufptr - hyd.rxbuf
                                  q:=hyd.rxbuf
                                  p:=q
                                  WHILE n>=4
                                    IF ((p[0] <= " ") OR (p[0] >= "a") OR
                                        (p[1] <= " ") OR (p[1] >= "a") OR
                                        (p[2] <= " ") OR (p[2] >= "a"))
                                      c:=H_NOPKT
                                      JUMP brk2
                                    ENDIF
                                    q[]++:=((Shl(h_uudec(p[0]),2)) OR (Shr(h_uudec(p[1]),4)));
                                    q[]++:=((Shl(h_uudec(p[1]),4)) OR (Shr(h_uudec(p[2]),2)));
                                    q[]++:=((Shl(h_uudec(p[2]),6)) OR h_uudec(p[3]));
                                    n-=4
                                    p+=4
                                  ENDWHILE
                                  IF (n >= 2)
                                    IF ((p[0] <= " ") OR (p[0] >= "a"))
                                      c:=H_NOPKT
                                      JUMP brk2
                                    ENDIF
                                    q[]++:=((Shl(h_uudec(p[0]),2)) OR (Shr(h_uudec(p[1]),4)))
                                    IF (n = 3)
                                      IF ((p[0] <= ' ') || (p[0] >= 'a'))
                                        c:=H_NOPKT
                                        JUMP brk2
                                      ENDIF
                                      q[]++:=((Shl(h_uudec(p[1]),4)) OR (Shr(h_uudec(p[2]),2)))
                                    ENDIF
                                  ENDIF
                   
                                DEFAULT   /* This'd mean internal fluke */
->#ifdef H_DEBUG
                                  IF (hyd.loglevel=0)
                                    StringF(s,' <- <PKTEND> (pktformat=''\c'' dec=\d hex=\h) ??',hyd.rxpktformat, hyd.rxpktformat, hyd.rxpktformat)
                                    dologmessage(hyd,0,s)
                                  ENDIF
->#endif
                                  c:=H_NOPKT
                             ENDSELECT
                             brk2:

                             hyd.rxbufptr:=NIL

                             IF (c=H_NOPKT) THEN JUMP brk

                             hyd.rxpktlen:=(q - hyd.rxbuf)
                             IF ((hyd.rxpktformat <> HCHR_HEXPKT) AND ((hyd.rxoptions AND HOPT_CRC32)))
                                IF (hyd.rxpktlen < 5)
                                   c:=H_NOPKT
                                   JUMP brk
                                ENDIF
                                n:=h_crc32test(crc32block(hyd,hyd.rxbuf,hyd.rxpktlen))
                                hyd.rxpktlen:=hyd.rxpktlen-SIZEOF LONG  /* remove CRC-32 */
                             ELSE
                                IF (hyd.rxpktlen < 3)
                                   c:=H_NOPKT
                                   JUMP brk
                                ENDIF
                                n:=h_crc16test(crc16block(hyd,hyd.rxbuf,hyd.rxpktlen))
                                hyd.rxpktlen:=hyd.rxpktlen-SIZEOF INT  /* remove CRC-16 */
                             ENDIF

                             hyd.rxpktlen:=hyd.rxpktlen-1                     /* remove type  */

                             IF (n)
->#ifdef H_DEBUG
                              IF (hyd.loglevel=0)
                                StringF(s,' <- PKT (format=''\c''  type=''\c''  len=\d)',hyd.rxpktformat, hyd.rxbuf[hyd.rxpktlen], hyd.rxpktlen)
                                dologmessage(hyd,0,s)

                                SELECT hyd.rxbuf[hyd.rxpktlen]
                                  CASE HPKT_START
                                    dologmessage(hyd,0,'    START')
                                  CASE HPKT_INIT
                                    s1:=(hyd.rxbuf) + (StrLen(hyd.rxbuf)) + 1
                                    s2:=s1+(StrLen(s1)) + 1
                                    s3:=s2+(StrLen(s2)) + 1
                                    s4:=s3+(StrLen(s3)) + 1
                                    StringF(s,'    INIT (appinfo=''\s''  can=''\s''  want=''\s''  options=''\s''  pktprefix=''\s'')',hyd.rxbuf, s1, s2, s3, s4)
                                    dologmessage(hyd,0,s)
                                  CASE HPKT_INITACK
                                    dologmessage(hyd,0,'    INITACK')
                                  CASE HPKT_FINFO
                                    StringF(s,'    FINFO (''\s''  rxstate=\d)',hyd.rxbuf,hyd.rxstate);
                                    dologmessage(hyd,0,s)
                                  CASE HPKT_FINFOACK
                                    StringF(s,'    FINFOACK (pos=\d  txstate=\d  txfd=\d)',intell(Long(hyd.rxbuf)), hyd.txstate, hyd.txfd)
                                    dologmessage(hyd,0,s)
                                  CASE HPKT_DATA
                                    StringF(s,'    DATA (rxstate=\d  pos=\d  len=\u)',hyd.rxstate, intell(Long(hyd.rxbuf)),(hyd.rxpktlen - (SIZEOF LONG)))
                                    dologmessage(hyd,0,s)
                                  CASE HPKT_DATAACK
                                    StringF(s,'    DATAACK (rxstate=\d  pos=\d)',hyd.rxstate, intell(Long(hyd.rxbuf)))
                                    dologmessage(hyd,0,s)
                                  CASE HPKT_RPOS
                                    StringF(s,'    RPOS (pos=\d\s  blklen=\u->\d  syncid=\d\s  txstate=\d  txfd=\d)',
                                        intell(Long(hyd.rxbuf)),
                                        IF intell(Long(hyd.rxbuf)) < 0 THEN ' SKIP' ELSE '',
                                        hyd.txblklen, intell(Long(hyd.rxbuf+4)),
                                        intell(Long(hyd.rxbuf+8)),
                                        IF intell(Long(hyd.rxbuf+8)) = hyd.rxsyncid THEN ' DUP' ELSE '',
                                        hyd.txstate, hyd.txfd)
                                    dologmessage(hyd,0,s)
                                  CASE HPKT_EOF
                                    StringF(s,'    EOF (rxstate=\d  pos=\d\s)',hyd.rxstate, intell(Long(hyd.rxbuf)),IF intell(Long(hyd.rxbuf)) < 0 THEN ' SKIP' ELSE '')
                                    dologmessage(hyd,0,s)
                                  CASE HPKT_EOFACK
                                    StringF(s,'    EOFACK (txstate=\d)', hyd.txstate)
                                    dologmessage(hyd,0,s)
                                  CASE HPKT_IDLE
                                    dologmessage(hyd,0,'    IDLE')
                                  CASE HPKT_END
                                    dologmessage(hyd,0,'    END')
                                  CASE HPKT_DEVDATA
                                    s1:=(hyd.rxbuf) + (SIZEOF LONG)
                                    StringF(s,'    DEVDATA (id=\d  dev=\s  len=\u',intell(Long(hyd.rxbuf)), s1,hyd.rxpktlen - ((SIZEOF LONG) + (StrLen(s1)) + 1))
                                    dologmessage(hyd,0,s)
                                  CASE HPKT_DEVDACK
                                    StringF(s,'    DEVDACK (devtxstate=\d  id=\d)',hyd.devtxstate, intell(Long(hyd.rxbuf)))
                                    dologmessage(hyd,0,s)
                                  DEFAULT
                                    StringF(s,'    Unkown pkttype \d (txstate=\d  rxstate=\d)',hyd.rxbuf[hyd.rxpktlen], hyd.txstate, hyd.rxstate)
                                    dologmessage(hyd,0,s)
                                ENDSELECT
                              ENDIF
->#endif

                              RETURN hyd.rxbuf[hyd.rxpktlen]
                            ENDIF/*goodpkt*/

->#ifdef H_DEBUG
                            IF (hyd.loglevel=0)
                              StringF(s,' Bad CRC (format=''\c''  type=''\c''  len=\d)',hyd.rxpktformat,hyd.rxbuf[hyd.rxpktlen], hyd.rxpktlen)
                              dologmessage(hyd,0,s)
                            ENDIF
->#endif

                        ELSEIF (c=HCHR_BINPKT) OR (c=HCHR_HEXPKT) OR (c=HCHR_ASCPKT) OR (c=HCHR_UUEPKT)
                          
->#ifdef H_DEBUG
                          IF (hyd.loglevel=0)
                            StringF(s,' <- <PKTSTART> (pktformat=''\c'')',c)
                            dologmessage(hyd,0,s)
                          ENDIF
->#endif
                          hyd.rxpktformat:=c
                          hyd.rxbufptr:=hyd.rxbuf
                          p:=hyd.rxbufptr
                          hyd.rxdle:=0
                        ELSE
                          IF (p)
                            IF (p < hyd.rxbufmax)
                              p[]++:=Eor(c,$40)
                            ELSE
->#ifdef H_DEBUG
                              IF (hyd.loglevel=0)
                                dologmessage(hyd,0,' <- Pkt too long - discarded')
                              ENDIF
->#endif
                              p:=NIL
                            ENDIF
                          ENDIF
                          hyd.rxdle:=0
                        ENDIF
                ->ENDSELECT
                brk:
              ELSEIF (p) 
                IF (p < hyd.rxbufmax)
                  p[]++:=c
                ELSE
->#ifdef H_DEBUG
                  IF (hyd.loglevel=0)
                    dologmessage(hyd,0,' <- Pkt too long - discarded')
                  ENDIF
->#endif
                  p:=NIL
                ENDIF
              ENDIF

        ENDWHILE
        hyd.rxbufptr:=p


        IF (h_timer_running(hyd.braindead) AND h_timer_expired(hyd.braindead))
->#ifdef H_DEBUG
        IF (hyd.loglevel=0)
          StringF(s,' <- BrainDead (timer=\z\r\h[8]  time=\z\r\h[8])',hyd.braindead,time())
          dologmessage(hyd,0,s)        
        ENDIF
->#endif
          RETURN H_BRAINTIME
        ENDIF
        IF (h_timer_running(hyd.txtimer) AND h_timer_expired(hyd.txtimer))
->#ifdef H_DEBUG
        IF (hyd.loglevel=0)
          StringF(s,' <- TxTimer (timer=\z\r\h[8]  time=\z\r\h[8])',hyd.txtimer,time())
          dologmessage(hyd,0,s)
        ENDIF
->#endif
          RETURN H_TXTIME
        ENDIF
        IF(h_timer_running(hyd.devtxtimer) AND h_timer_expired(hyd.devtxtimer))
->#ifdef H_DEBUG
        IF (hyd.loglevel=0)
          StringF(s,' <- DevTxTimer (timer=\z\r\h[8]  time=\z\r\h[8])',hyd.devtxtimer,time())
          dologmessage(hyd,0,s)
        ENDIF
->#endif
          RETURN H_DEVTXTIME
        ENDIF
ENDPROC H_NOPKT/*rxpkt()*/

EXPORT PROC hydra_init(hyd: PTR TO hydra_t,want_options,nooriginator,hdxsession,txwinsize,rxwinsize)
  DEF i,j,crc16,crc32
  DEF cur_speed=115200
  DEF s[255]:STRING

  hyd.curbuf:=hyd.chatbuf1
  
  hyd.nobell:=FALSE
  hyd.mailer:=FALSE
  hyd.noresume:=FALSE
  hyd.nostamp:=FALSE
  hyd.opuslog:=0
  AstrCopy(hyd.download,'')
  hyd.single_file[0]:=0
  hyd.single_done:=FALSE
  hyd.loglevel:=1
  hyd.hydra_txwindow:=txwinsize
  hyd.hydra_rxwindow:=rxwinsize
  
  StringF(s,'+\s v\s \s : begin',PRGNAME,VERSION,HC_OS);
  dologmessage(hyd,1,s)

  hyd.txbuf:=New(H_BUFLEN) 
  hyd.rxbuf:=New(H_BUFLEN)
  
  hyd.crc16tab:=New(512)
  hyd.crc32tab:=New(1024)
  
  hyd.cur_speed:=cur_speed

  hyd.rxnewfile:=0
  hyd.txnewfile:=0

  hyd.txbufin:= hyd.txbuf + ((H_MAXBLKLEN + H_OVERHEAD + 5) * 2)
  hyd.rxbufmax:= hyd.rxbuf + H_MAXPKTLEN

  FOR i:=0 TO 255
    crc16:=i
    crc32:=i
    FOR j:=0 TO 7
      IF (crc16 AND 1) THEN crc16:=Eor((Shr(crc16,1)),H_CRC16POLY) ELSE crc16:=Shr(crc16,1)
      IF (crc32 AND 1) THEN crc32:=Eor((Shr(crc32,1) AND $7FFFFFFF),H_CRC32POLY) ELSE crc32:=Shr(crc32,1) AND $7FFFFFFF;     
    ENDFOR
    hyd.crc16tab[i]:=crc16
    hyd.crc32tab[i]:=crc32
  ENDFOR
  
  hyd.batchesdone:=0
  hyd.originator:=IF nooriginator THEN FALSE ELSE TRUE

    IF (hyd.originator)
       hyd.hdxlink:=FALSE
    ELSEIF (hdxsession)
       hyd.hdxlink:=TRUE
    ENDIF

    hyd.options:=(want_options AND HCAN_OPTIONS) AND (Not(HUNN_OPTIONS))

    hyd.timeout:=40960/cur_speed

    IF (hyd.timeout < H_MINTIMER) THEN hyd.timeout:=H_MINTIMER
    IF (hyd.timeout > H_MAXTIMER) THEN hyd.timeout:=H_MAXTIMER

    hyd.txmaxblklen:=(cur_speed / 300) * 128
    IF (hyd.txmaxblklen < 256) THEN hyd.txmaxblklen:=256
    IF (hyd.txmaxblklen > H_MAXBLKLEN) THEN hyd.txmaxblklen:=H_MAXBLKLEN

    hyd.rxblklen:=IF (cur_speed < 2400) THEN 256 ELSE 512
    hyd.txblklen:=hyd.rxblklen

    hyd.txgoodbytes:=0
    hyd.txgoodneeded:=1024

    hyd.txstate:=HTX_DONE
  
    hyd.h_dev:= [
      ['MSG',{hydra_msgdev}]:h_dev,
      ['CON',NIL]:h_dev,
      ['PRN',NIL]:h_dev,
      ['ERR',NIL]:h_dev,
      [NIL,NIL]:h_dev
    ]  
    
    hyd.h_flags:=[
        ['XON', HOPT_XONXOFF ]:h_flags,
        ['TLN', HOPT_TELENET ]:h_flags,
        ['CTL', HOPT_CTLCHRS ]:h_flags,
        ['HIC', HOPT_HIGHCTL ]:h_flags,
        ['HI8', HOPT_HIGHBIT ]:h_flags,
        ['BRK', HOPT_CANBRK  ]:h_flags,
        ['ASC', HOPT_CANASC  ]:h_flags,
        ['UUE', HOPT_CANUUE  ]:h_flags,
        ['C32', HOPT_CRC32   ]:h_flags,
        ['DEV', HOPT_DEVICE  ]:h_flags,
        ['FPT', HOPT_FPT     ]:h_flags,
        [ 0 , 0        ]:h_flags
        ]
    

    hydra_devfunc(hyd,'CON',{rem_chat})

    hyd.chatfill:=0
    hyd.chattimer:=-1
    hyd.lasttimer:=0
ENDPROC


PROC hydra(hyd:PTR TO hydra_t,txpathname:PTR TO CHAR,txalias:PTR TO CHAR)
  DEF res,pkttype,i,revstamp
  DEF p:PTR TO CHAR, q:PTR TO CHAR
  DEF s[255]:STRING
  DEF fds[20]:STRING
  DEF f_st_size,f_st_mtime
  DEF diskfree
  DEF proc
  DEF t1,t2,t

        /*-------------------------------------------------------------------*/
        IF (hyd.txstate = HTX_DONE)
          hyd.txstate:=HTX_START
          AstrCopy(hyd.txstatus,'Init')
          hyd.txoptions:=HTXI_OPTIONS
          hyd.txpktprefix[0]:=0

          hyd.rxstate:=HRX_INIT
          AstrCopy(hyd.rxstatus,'Init')
          hyd.rxoptions:=HRXI_OPTIONS
          hyd.rxfd:=-1
          hyd.rxdle:=0
          hyd.rxbufptr:=NIL
          hyd.rxtimer:=0

          hyd.devtxid:=0
          hyd.devrxid:=0
          hyd.devtxtimer:=0
          hyd.devtxstate:=HTD_DONE

          hyd.braindead:=time()+H_BRAINDEAD
        ELSE
          hyd.txstate:=HTX_FINFO
        ENDIF

        hyd.txtimer:=0
        hyd.txretries:=0
        AstrCopy(hyd.txstatus,'')


        /*-------------------------------------------------------------------*/
        IF (txpathname)
           f_st_size,f_st_mtime:=stat(txpathname)
           hyd.txfsize:=f_st_size
           hyd.txftime:=f_st_mtime

           proc:=hyd.hyd_open
           IF ((hyd.txfd:=proc(txpathname,MODE_OLDFILE)) < 0)
              StringF(s,'-HSEND: Unable to open \s',txpathname)
              dologmessage(hyd,3,s)
              RETURN XFER_SKIP
           ENDIF

           AstrCopy(hyd.txfname,FilePart(txpathname))
           AstrCopy(hyd.txstatus,'')
           hyd.txstart1:=0
           hyd.txstart2:=0
           hyd.txsyncid:=0
           hyd.txnewfile:=TRUE
        ELSE
          hyd.txfd:=-1
          AstrCopy(hyd.txfname,'')
        ENDIF

        /*-------------------------------------------------------------------*/
        REPEAT
           /*----------------------------------------------------------------*/
           IF hyd.devtxstate=HTD_DATA
                 IF (hyd.txstate > HTX_RINIT)
                    PutLong(hyd.txbufin,intell(hyd.devtxid))
                    p:=hyd.txbufin+SIZEOF LONG
                    AstrCopy(p,hyd.devtxdev)
                    p+=H_FLAGLEN + 1
                    CopyMem(hyd.devtxbuf,p,hyd.devtxlen)
                    txpkt(hyd,SIZEOF LONG + H_FLAGLEN + 1 + hyd.devtxlen,HPKT_DEVDATA)
                    hyd.devtxtimer:=time()+hyd.timeout
                    hyd.devtxstate:=HTD_DACK
                 ENDIF
           ENDIF

           /*----------------------------------------------------------------*/
           SELECT hyd.txstate
                  /*---------------------------------------------------------*/
                  CASE HTX_START
                       com_putblock(hyd,AUTOSTR,StrLen(AUTOSTR))
                       txpkt(hyd,0,HPKT_START)
                       hyd.txtimer:=time()+H_START
                       hyd.txstate:=HTX_SWAIT

                  /*---------------------------------------------------------*/
                  CASE HTX_INIT
                       p:=hyd.txbufin
                       StringF(s,'\z\r\h[8]\s,\s \s',H_REVSTAMP,PRGNAME,VERSION,HC_OS)
                       AstrCopy(p,s)
                       p+=(StrLen(p)) + 1/* our app info & HYDRA rev. */
                       put_flags(p,hyd.h_flags,HCAN_OPTIONS)    /* what we CAN  */
                       p+=(StrLen(p)) + 1
                       put_flags(p,hyd.h_flags,hyd.options);         /* what we WANT */
                       p+=(StrLen(p)) + 1
                       StringF(s,'\z\r\h[8]\z\r\h[8]',               /* TxRx windows */
                                 hyd.hydra_txwindow,hyd.hydra_rxwindow)
                       AstrCopy(p,s)
                                 
                       p+=(StrLen(p)) + 1
                       AstrCopy(p,PKTPREFIX)     /* pkt prefix string we want */
                       p+=(StrLen(p)) + 1

                       hyd.txoptions:=HTXI_OPTIONS;
                       txpkt(hyd,p - hyd.txbufin, HPKT_INIT)
                       hyd.txoptions:=hyd.rxoptions
                       hyd.txtimer:=time()+(hyd.timeout / 2)
                       hyd.txstate:=HTX_INITACK

                  /*---------------------------------------------------------*/
                  CASE HTX_FINFO
                    IF (hyd.txfd >= 0)
                      IF (hyd.txretries=0)
                        ->hydra_gotoxy(1,13,1)
                        ->hydra_printf(1,hyd.txfname)
                        IF (txalias)
                           ->hydra_gotoxy(1,25,1);
                           ->StringF(s,'  ->  \s',txalias)
                           ->hydra_printf(1,s)
                        ENDIF
                        dohydra_status(hyd,TRUE)

                        ->hydra_clreol(1)
                        StringF(s,'+HSEND: \s\s\s (\db), \d min.',
                                txpathname, IF txalias THEN ' -> ' ELSE '', IF txalias THEN txalias ELSE '',
                                hyd.txfsize,((hyd.txfsize * 10 / hyd.cur_speed + 27) / 54))
                        dologmessage(hyd,2,s)
                      ENDIF
                      StringF(s,'\z\r\h[8]\z\r\h[8]\z\r\h[8]\z\r\h[8]\z\r\h[8]\s',
                              hyd.txftime, hyd.txfsize, 0, 0, 0,
                              IF txalias THEN txalias ELSE hyd.txfname)
                      AstrCopy(hyd.txbufin,s)
                    ELSE
                      IF (hyd.txretries=0)
                        AstrCopy(hyd.txstatus,'End of batch')
                        dohydra_status(hyd,TRUE)

                        ->hydra_gotoxy(1,13,1)
                        ->hydra_printf(1,'End of batch')
                        ->hydra_clreol(1)
                        dologmessage(hyd,1,'+HSEND: End of batch')
                      ENDIF
                      AstrCopy(hyd.txbufin,hyd.txfname)
                    ENDIF
                    txpkt(hyd,StrLen(hyd.txbufin) + 1,HPKT_FINFO)
                    hyd.txtimer:=time()+(IF hyd.txretries THEN hyd.timeout / 2 ELSE hyd.timeout)
                    hyd.txstate:=HTX_FINFOACK

                  /*---------------------------------------------------------*/
                  CASE HTX_XDATA
                       IF (com_outfull() < hyd.txmaxblklen)

                         IF (hyd.txpos < 0)
                          i:=-1                                    /* Skip */
                         ELSE
                            PutLong(hyd.txbufin,intell(hyd.txpos))
                            proc:=hyd.hyd_read
                            i:=proc(hyd.txfd,hyd.txbufin + (SIZEOF LONG),hyd.txblklen)
                            IF (i < 0)
                               dologmessage(hyd,6,'!HSEND: File read error')
                               proc:=hyd.hyd_close
                               proc(hyd.txfd)
                               hyd.txfd:=-1
                               hyd.txpos:=-2                            /* Skip */
                            ENDIF
                         ENDIF

                         IF (i > 0)
                            hyd.txpos:=hyd.txpos+i
                            txpkt(hyd,(SIZEOF LONG) + i, HPKT_DATA)

                            IF ((hyd.txblklen < hyd.txmaxblklen) ANDALSO ((hyd.txgoodbytes:=hyd.txgoodbytes+i) >= hyd.txgoodneeded))
                               hyd.txblklen:=Shl(hyd.txblklen,1)
                               IF (hyd.txblklen >= hyd.txmaxblklen)
                                  hyd.txblklen:=hyd.txmaxblklen
                                  hyd.txgoodneeded:=0
                               ENDIF
                               hyd.txgoodbytes:=0
                            ENDIF

                            IF (hyd.txwindow AND (hyd.txpos >= (hyd.txlastack + hyd.txwindow)))
                               hyd.txtimer:=time()+(IF hyd.txretries THEN hyd.timeout / 2 ELSE hyd.timeout)
                               hyd.txstate:=HTX_DATAACK
                            ENDIF

                            IF (hyd.txstart1=0)
                              t1,t2:=time()
                              hyd.txstart1:=t1
                              hyd.txstart2:=t2
                            ENDIF
                            dohydra_status(hyd,TRUE)
                         ELSE

                           /* fallthrough to HTX_EOF */
                           PutLong(hyd.txbufin,intell(hyd.txpos))
                           txpkt(hyd,SIZEOF LONG,HPKT_EOF)
                           hyd.txtimer:=time()+(IF hyd.txretries THEN hyd.timeout / 2 ELSE hyd.timeout)
                           hyd.txstate:=HTX_EOFACK
                        ENDIF
                      ENDIF

                  /*---------------------------------------------------------*/
                  CASE HTX_EOF

                       PutLong(hyd.txbufin,intell(hyd.txpos))
                       txpkt(hyd,SIZEOF LONG,HPKT_EOF)
                       hyd.txtimer:=time()+(IF hyd.txretries THEN hyd.timeout / 2 ELSE hyd.timeout)
                       hyd.txstate:=HTX_EOFACK

                  /*---------------------------------------------------------*/
                  CASE HTX_END
                       txpkt(hyd,0,HPKT_END)
                       txpkt(hyd,0,HPKT_END)
                       hyd.txtimer:=time()+(hyd.timeout / 2)
                       hyd.txstate:=HTX_ENDACK
                  /*---------------------------------------------------------*/
           ENDSELECT
           /*----------------------------------------------------------------*/
           IF ((hyd.txstate) AND ((pkttype:=rxpkt(hyd)) <> H_NOPKT))
                 /*----------------------------------------------------------*/
                 ->SELECT pkttype
                        /*---------------------------------------------------*/
                        IF (pkttype=H_CARRIER) OR (pkttype=H_CANCEL) OR (pkttype=H_SYSABORT) OR (pkttype=H_BRAINTIME)
                            SELECT pkttype
                              CASE H_CARRIER
                                p:='Carrier lost'
                              CASE H_CANCEL
                                p:='Aborted by other side'
                              CASE H_SYSABORT
                                p:='Aborted by operator'
                              CASE H_BRAINTIME
                                p:='Other end died'
                             ENDSELECT
                             StringF(s,'-HYDRA: \s',p)
                             dologmessage(hyd,3,s)
                             hyd.txstate:=HTX_DONE
                             res:=XFER_ABORT

                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=H_TXTIME)
                          IF ((hyd.txstate = HTX_XWAIT) OR (hyd.txstate = HTX_REND))
                             txpkt(hyd,0,HPKT_IDLE);
                             hyd.txtimer:=time()+H_IDLE
                             JUMP brk5
                          ENDIF

                          hyd.txretries:=hyd.txretries+1
                          IF (hyd.txretries > H_RETRIES)
                             dologmessage(hyd,3,'-HSEND: Too many errors')
                             hyd.txstate:=HTX_DONE
                             res:=XFER_ABORT;
                             JUMP brk5
                          ENDIF

                          StringF(s,'Timeout - Retry \u',hyd.txretries)
                          AstrCopy(hyd.txstatus,s)
                          StringF(s,'-HSEND: Timeout - Retry \u',hyd.txretries)
                          dologmessage(hyd,0,s)

                          hyd.txtimer:=0

                          SELECT hyd.txstate
                            CASE HTX_SWAIT
                              hyd.txstate:=HTX_START
                            CASE HTX_INITACK
                              hyd.txstate:=HTX_INIT
                            CASE HTX_FINFOACK
                              hyd.txstate:=HTX_FINFO
                            CASE HTX_DATAACK
                              hyd.txstate:=HTX_XDATA
                            CASE HTX_EOFACK
                              hyd.txstate:=HTX_EOF
                            CASE HTX_ENDACK
                              hyd.txstate:=HTX_END
                          ENDSELECT

                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=H_DEVTXTIME)
                          hyd.devtxretries:=hyd.devtxretries+1
                          IF (hyd.devtxretries > H_RETRIES)
                             dologmessage(hyd,3,'-HDEVTX: Too many errors')
                             hyd.txstate:=HTX_DONE
                             res:=XFER_ABORT
                             JUMP brk5
                          ENDIF


                          StringF(s,'Timeout - Retry \u',hyd.devtxretries)
                          AstrCopy(hyd.txstatus,s)
                          StringF(s,'-HDEVTX: Timeout - Retry \u',hyd.devtxretries)
                          dologmessage(hyd,0,s)

                          hyd.devtxtimer:=0
                          hyd.devtxstate:=HTD_DATA

                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_START)
                          IF ((hyd.txstate = HTX_START) OR (hyd.txstate = HTX_SWAIT))
                             hyd.txtimer:=0
                             hyd.txretries:=0
                             AstrCopy(hyd.txstatus,'')
                             hyd.txstate:=HTX_INIT
                             hyd.braindead:=time()+H_BRAINDEAD
                          ENDIF
                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_INIT)
                          IF (hyd.rxstate = HRX_INIT)
                            p:=hyd.rxbuf
                            p+=(StrLen(p)) + 1
                            q:=p+(StrLen(p)) + 1
                            hyd.rxoptions:=hyd.options OR HUNN_OPTIONS
                            hyd.rxoptions:=hyd.rxoptions OR get_flags(q,hyd.h_flags)
                            hyd.rxoptions:= hyd.rxoptions AND get_flags(p,hyd.h_flags)
                            hyd.rxoptions:= hyd.rxoptions AND HCAN_OPTIONS
                            
                            IF (hyd.rxoptions < (hyd.options AND HNEC_OPTIONS))
                               dologmessage(hyd,6,'!HYDRA: Incompatible on this link')
                               hyd.txstate:=HTX_DONE
                               res:=XFER_ABORT
                               JUMP brk5
                            ENDIF
                            
                            p:=q + (StrLen(q)) + 1
                            hyd.txwindow:=0
                            hyd.rxwindow:=0
                            StringF(s,'$\s[8]',p)
                            UpperStr(s)
                            hyd.rxwindow:=Val(s)
                            
                            StringF(s,'$\s[8]',p+8)
                            UpperStr(s)
                            hyd.txwindow:=Val(s)
                            ->sscanf(p,"%08lx%08lx", &rxwindow,&txwindow);
                            
                            IF (hyd.rxwindow < 0) THEN hyd.rxwindow:=0
                            
                            IF (hyd.hydra_rxwindow AND ((hyd.rxwindow=0) OR (hyd.hydra_rxwindow < hyd.rxwindow))) THEN hyd.rxwindow:=hyd.hydra_rxwindow
                            
                            IF (hyd.txwindow < 0) THEN hyd.txwindow:=0
                            IF (hyd.hydra_txwindow AND ((hyd.txwindow=0) OR (hyd.hydra_txwindow < hyd.txwindow))) THEN hyd.txwindow:=hyd.hydra_txwindow
                            p+= (StrLen(p)) + 1
                            AstrCopy(hyd.txpktprefix,p,H_PKTPREFIX+1)

                            IF (hyd.batchesdone=FALSE)
                              p:=hyd.rxbuf
                              StringF(s,'$\s[8]',p)
                              UpperStr(s)
                              revstamp:=Val(p)
                              
                              h_revdate(revstamp,fds)
                              StringF(s,'*HYDRA: Other''s HydraRev=\s',fds)
                              dologmessage(hyd,0,s)
                              p+=8
                              IF ((q:=InStr(p,','))>=0) THEN p[q]:=" "
                              IF ((q:=InStr(p,','))>=0) THEN p[q]:="/"
                              
                              StringF(s,'*HYDRA: Other''s App.Info ''\s''',p)
                              dologmessage(hyd,0,s)
                              put_flags(hyd.rxbuf,hyd.h_flags,hyd.rxoptions)
                              StringF(s,'*HYDRA: Using link options ''\s''',hyd.rxbuf)
                              dologmessage(hyd,1,s)
                              IF(hyd.txwindow OR hyd.rxwindow)
                                StringF(s,'*HYDRA: Window tx=\d rx=\d',hyd.txwindow,hyd.rxwindow)
                                dologmessage(hyd,0,s)
                              ENDIF
                            ENDIF

                            hyd.chattimer:=IF (hyd.rxoptions AND HOPT_DEVICE) THEN 0 ELSE -2

                            hyd.txoptions:=hyd.rxoptions
                            hyd.rxstate:=HRX_FINFO
                          ENDIF

                          txpkt(hyd,0,HPKT_INITACK)

                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_INITACK)
                          IF ((hyd.txstate = HTX_INIT) OR (hyd.txstate = HTX_INITACK))
                             hyd.braindead:=time()+H_BRAINDEAD
                             hyd.txtimer:=0
                             hyd.txretries:=0
                             AstrCopy(hyd.txstatus,'')
                             hyd.txstate:=HTX_RINIT
                          ENDIF
                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_FINFO)
                          IF (hyd.rxstate = HRX_FINFO)
                            hyd.braindead:=time()+H_BRAINDEAD
                            IF (hyd.rxbuf[0]=0)
                               AstrCopy(hyd.rxstatus,'End of batch')
                               dohydra_status(hyd,FALSE)
                               ->hydra_gotoxy(0,13,1)
                               ->hydra_printf(0,'End of batch')
                               ->hydra_clreol(0)
                               dologmessage(hyd,1,'*HRECV: End of batch')
                               hyd.rxpos:=0
                               hyd.rxstate:=HRX_DONE
                               hyd.batchesdone:=hyd.batchesdone+1
                            ELSE
                              hyd.rxftime:=0
                              hyd.rxfsize:=0
                              hyd.rxfname[0]:=0
                              
                              StringF(s,'$\s[8]',hyd.rxbuf)
                              UpperStr(s)
                              hyd.rxftime:=Val(s)
                            
                              StringF(s,'$\s[8]',hyd.rxbuf+8)
                              UpperStr(s)
                              hyd.rxfsize:=Val(s)
                                                         
                              ->sscanf((char *) rxbuf,"%08lx%08lx%*08lx%*08lx%*08lx%s",
                              ->       &rxftime, &rxfsize, rxfname);

                              AstrCopy(hyd.rxfname,hyd.rxbuf+(5 * 8))	/* Gets the full filename even if there are spaces in it. */

                              dohydra_status(hyd,FALSE)
                              ->hydra_gotoxy(0,13,1)
                              ->hydra_printf(0,hyd.rxfname)
                              ->hydra_clreol(0)

                              hyd.rxpathname:=xfer_init(hyd,hyd.rxfname,hyd.rxfsize,hyd.rxftime)

                              diskfree:=freespace(hyd.rxpathname)

                              IF hyd.rxfname
                                proc:=hyd.hyd_dupecheck
                                IF proc
                                  IF proc(hyd.rxfname) THEN hyd.rxpathname:=0
                                ENDIF
                              ENDIF
                              hyd.rxnewfile:=TRUE

                              IF (hyd.rxpathname=0)   /* Already have file */
                                IF (hyd.single_done)
                                  AstrCopy(hyd.rxstatus,'Skipping additional files')
                                  dohydra_status(hyd,FALSE)
                                  ->hydra_gotoxy(0,29,1)
                                  ->hydra_printf(0,'Skipping additional files')
                                  StringF(s,'+HRECV: Skipping additional files (file \s)',hyd.rxfname);
                                  dologmessage(hyd,1,s)
                                  hyd.rxpos:=-2
                                ELSE
                                  AstrCopy(hyd.rxstatus,'Already have file')
                                  dohydra_status(hyd,FALSE)
                                  ->hydra_gotoxy(0,29,1);
                                  ->hydra_printf(0,'Already have file');
                                  StringF(s,'+HRECV: Already have \s',hyd.rxfname)
                                  dologmessage(hyd,1,s)
                                  hyd.rxpos:=-1
                                ENDIF
                              ELSEIF ((hyd.rxfsize + 10240) > diskfree)
                                AstrCopy(hyd.rxstatus,'Not enough diskspace')
                                dohydra_status(hyd,FALSE)
                                ->hydra_gotoxy(0,29,1)
                                ->hydra_printf(0,'Not enough diskspace');
                                StringF(s,'!HRECV: \s not enough diskspace: \d > \d',hyd.rxfname, hyd.rxfsize + 10240, diskfree)
                                dologmessage(hyd,6,s)
                                hyd.rxpos:=-2
                              ELSE
                                proc:=hyd.hyd_open
                                IF(FileLength(hyd.rxpathname)>0) /* Resuming? */
                                  IF ((hyd.rxfd:=proc(hyd.rxpathname,MODE_READWRITE)) < 0)
                                    StringF(s,'!HRECV: Unable to re-open \s',hyd.rxpathname)
                                     dologmessage(hyd,6,s)
                                     hyd.rxpos:=-2
                                  ENDIF
                                ELSEIF ((hyd.rxfd:=proc(hyd.rxpathname,MODE_NEWFILE)) < 0)
                                  StringF(s,'!HRECV: Unable to create \s',hyd.rxpathname)
                                  dologmessage(hyd,6,s)
                                  hyd.rxpos:=-2
                                ENDIF

                                IF (hyd.rxfd >= 0)
                                  StringF(s,'+HRECV: \s (\db), \d min.',hyd.rxfname, hyd.rxfsize,(hyd.rxfsize * 10 / hyd.cur_speed + 27) / 54)
                                  dologmessage(hyd,2,s)
                                  proc:=hyd.hyd_seek
                                  IF (proc(hyd.rxfd,0,OFFSET_END) < 0)
                                    dologmessage(hyd,6,'!HRECV: File seek error')
                                    hydra_badxfer(hyd)
                                    hyd.rxpos:=-2
                                  ELSE
                                    hyd.rxpos:=proc(hyd.rxfd,0,OFFSET_CURRENT)
                                    hyd.rxoffset:=hyd.rxpos
                                    
                                    IF (hyd.rxpos < 0)
                                      dologmessage(hyd,6,'!HRECV: File tell error')
                                      hydra_badxfer(hyd)
                                      hyd.rxpos:=-2
                                    ELSE
                                      hyd.rxstart1:=0
                                      hyd.rxstart2:=0
                                      hyd.rxtimer:=0
                                      hyd.rxretries:=0
                                      hyd.rxlastsync:=0
                                      hyd.rxsyncid:=0
                                      hyd.rxresumepos:=hyd.rxpos
                                      AstrCopy(hyd.rxstatus,'')

                                      dohydra_status(hyd,FALSE)
                                      IF (hyd.rxpos > 0)
                                         ->hydra_gotoxy(0,46,1)
                                         ->StringF(s,'\d/\d',hyd.rxpos,hyd.rxfsize)
                                         ->hydra_printf(0,s)
                                         StringF(s,'+HRECV: Resuming from offset \d (\d min. to go)',
                                                 hyd.rxpos, ((hyd.rxfsize - hyd.rxoffset) * 10 / hyd.cur_speed + 27) / 54)
                                         dologmessage(hyd,1,s)
                                      ENDIF
                                      hyd.rxstate:=HRX_DATA
                                    ENDIF
                                  ENDIF
                                ENDIF
                              ENDIF
                            ENDIF
                          ELSEIF (hyd.rxstate = HRX_DONE)
                            hyd.rxpos:= IF (hyd.rxbuf[0]=0) THEN 0 ELSE -2
                          ENDIF

                          PutLong(hyd.txbufin,intell(hyd.rxpos))
                          txpkt(hyd,SIZEOF LONG,HPKT_FINFOACK)
                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_FINFOACK)
                          IF  ((hyd.txstate = HTX_FINFO) OR (hyd.txstate = HTX_FINFOACK))
                            hyd.braindead:=time()+H_BRAINDEAD
                            hyd.txretries:=0
                            AstrCopy(hyd.txstatus,'')
                            IF (hyd.txfname[0]=0)
                              hyd.txtimer:=time()+H_IDLE
                              hyd.txstate:=HTX_REND
                            ELSE
                              hyd.txtimer:=0
                              hyd.txpos:=intell(Long(hyd.rxbuf))

                              IF (hyd.txpos >= 0) 
                                hyd.txoffset:=hyd.txpos
                                hyd.txlastack:=hyd.txpos
                                hyd.txresumepos:=hyd.txpos
                                dohydra_status(hyd,TRUE)
                                IF (hyd.txpos > 0)
                                  StringF(s,'+HSEND: Transmitting from offset \d (\d min. to go)',hyd.txpos, ((hyd.txfsize - hyd.txoffset) * 10 / hyd.cur_speed + 27) / 54)
                                  dologmessage(hyd,1,s)
                                  proc:=hyd.hyd_seek
                                  IF (proc(hyd.txfd,hyd.txpos,OFFSET_BEGINING) < 0)
                                     dologmessage(hyd,6,'!HSEND: File seek error')
                                     proc:=hyd.hyd_close
                                     proc(hyd.txfd)
                                     hyd.txfd:=-1
                                     hyd.txpos:=-2
                                     hyd.txstate:=HTX_EOF
                                    JUMP brk5
                                  ENDIF
                                ENDIF
                                hyd.txstate:=HTX_XDATA
                              ELSE
                                proc:=hyd.hyd_close
                                proc(hyd.txfd)
                                IF (hyd.txpos = -1)
                                   AstrCopy(hyd.txstatus,'They already have file')
                                   dohydra_status(hyd,TRUE)
                                   ->hydra_gotoxy(1,29,1)
                                   ->hydra_printf(1,'They already have file')
                                   StringF(s,'+HSEND: They already have \s',hyd.txfname)
                                   dologmessage(hyd,1,s)
                                   IF (hyd.mailer) THEN resultlog(hyd,TRUE,txpathname,hyd.txfsize,0)
                                   RETURN XFER_OK
                                ELSE  /* (txpos < -1L) file NOT sent */
                                   AstrCopy(hyd.txstatus,'Skipping')
                                   dohydra_status(hyd,TRUE)
                                   ->hydra_gotoxy(1,29,1)
                                   ->hydra_printf(1,'Skipping')
                                   StringF(s,'+HSEND: Skipping \s',hyd.txfname)
                                   dologmessage(hyd,1,s)
                                   RETURN XFER_SKIP
                                ENDIF
                              ENDIF
                            ENDIF
                          ENDIF
                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_DATA)
                          IF (hyd.rxstate = HRX_DATA)
                            IF ((intell(Long(hyd.rxbuf)) <> hyd.rxpos) OR (intell(Long(hyd.rxbuf)) < 0))
                               IF (intell(Long(hyd.rxbuf)) <= hyd.rxlastsync)
                                  hyd.rxtimer:=0
                                  hyd.rxretries:=0
                               ENDIF
                               hyd.rxlastsync:=intell(Long(hyd.rxbuf))

                               IF ((h_timer_running(hyd.rxtimer)=FALSE) OR (h_timer_expired(hyd.rxtimer)))
                                  IF (hyd.rxretries > 4)
                                     IF ((hyd.txstate < HTX_REND) AND (hyd.originator=FALSE) AND (hyd.hdxlink=FALSE))
                                        hyd.hdxlink:=TRUE
                                        hyd.rxretries:=0
                                     ENDIF
                                  ENDIF
                                  hyd.rxretries:=hyd.rxretries+1
                                  IF (hyd.rxretries > H_RETRIES)
                                     dologmessage(hyd,3,'-HRECV: Too many errors')
                                     hyd.txstate:=HTX_DONE
                                     res:=XFER_ABORT
                                     JUMP brk5
                                  ENDIF
                                  IF (hyd.rxretries = 1) THEN hyd.rxsyncid:=hyd.rxsyncid+1

                                  hyd.rxblklen:=hyd.rxblklen / 2
                                  i:=hyd.rxblklen
                                  
                                  IF (i <=  64)
                                    i:=64
                                  ELSEIF (i <= 128)
                                    i:=128
                                  ELSEIF (i <= 256)
                                    i:=256
                                  ELSEIF (i <= 512)
                                    i:=512
                                  ELSE
                                    i:=1024
                                  ENDIF
                                  StringF(s,'Bad pkt at \d - Retry \u (newblklen=\u)',hyd.rxpos,hyd.rxretries,i)
                                  AstrCopy(hyd.rxstatus,s)
                                  StringF(s,'-HRECV: Bad pkt at \d - Retry \u (newblklen=\u)',hyd.rxpos,hyd.rxretries,i)
                                  dologmessage(hyd,0,s)
                                  PutLong(hyd.txbufin,intell(hyd.rxpos))
                                  PutLong(hyd.txbufin+4,intell(i))
                                  PutLong(hyd.txbufin+8,intell(hyd.rxsyncid))
                                  txpkt(hyd,3*(SIZEOF LONG),HPKT_RPOS)
                                  hyd.rxtimer:=time()+hyd.timeout
                               ENDIF
                            ELSE
                               hyd.braindead:=time()+H_BRAINDEAD
                               hyd.rxpktlen:=hyd.rxpktlen-SIZEOF LONG
                               hyd.rxblklen:=hyd.rxpktlen
                               proc:=hyd.hyd_write
                               IF(proc(hyd.rxfd,hyd.rxbuf + SIZEOF LONG,hyd.rxpktlen) <>hyd.rxpktlen)
                                  dologmessage(hyd,6,'!HRECV: File write error')
                                  hydra_badxfer(hyd)
                                  hyd.rxpos:=-2
                                  hyd.rxretries:=1
                                  hyd.rxsyncid:=hyd.rxsyncid+1
                                  PutLong(hyd.txbufin,intell(hyd.rxpos))
                                  PutLong(hyd.txbufin+4,intell(0))
                                  PutLong(hyd.txbufin+8,intell(hyd.rxsyncid))
                                  txpkt(hyd,3 * (SIZEOF LONG),HPKT_RPOS)
                                  hyd.rxtimer:=time()+hyd.timeout
                                  JUMP brk5
                               ENDIF
                               hyd.rxretries:=0
                               hyd.rxtimer:=0
                               hyd.rxlastsync:=hyd.rxpos;
                               hyd.rxpos:=hyd.rxpos+hyd.rxpktlen
                               IF (hyd.rxwindow)
                                  PutLong(hyd.txbufin,intell(hyd.rxpos))
                                  txpkt(hyd,SIZEOF LONG,HPKT_DATAACK)
                               ENDIF
                               IF (hyd.rxstart1=0)
                                 t1,t2:=time()
                                 hyd.rxstart1:=t1 - ((hyd.rxpktlen * 10) / hyd.cur_speed)
                                 hyd.rxstart2:=t2
                               ENDIF
                               dohydra_status(hyd,FALSE)
                               
                            ENDIF/*badpkt*/
                          ENDIF/*rxstate==HRX_DATA*/
                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_DATAACK)
                          IF ((hyd.txstate = HTX_XDATA) OR (hyd.txstate = HTX_DATAACK) OR (hyd.txstate = HTX_XWAIT) OR (hyd.txstate = HTX_EOF) OR (hyd.txstate = HTX_EOFACK))
                            IF ((hyd.txwindow) AND (intell(Long(hyd.rxbuf)) > hyd.txlastack))
                              hyd.txlastack:=intell(Long(hyd.rxbuf))
                              IF ((hyd.txstate = HTX_DATAACK) AND ((hyd.txpos < (hyd.txlastack + hyd.txwindow))))
                                hyd.txstate:=HTX_XDATA
                                hyd.txretries:=0
                                AstrCopy(hyd.txstatus,'')
                                hyd.txtimer:=0
                              ENDIF
                            ENDIF
                          ENDIF
                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_RPOS)
                          IF ((hyd.txstate = HTX_XDATA) OR (hyd.txstate = HTX_DATAACK) OR (hyd.txstate = HTX_XWAIT) OR (hyd.txstate = HTX_EOF) OR (hyd.txstate = HTX_EOFACK))
                             IF (intell(Long(hyd.rxbuf)) <> hyd.txsyncid)
                                hyd.txsyncid:=intell(Long(hyd.rxbuf))
                                hyd.txretries:=1
                                hyd.txtimer:=0
                                hyd.txpos:=intell(Long(hyd.rxbuf))
                                IF (hyd.txpos < 0)
                                   IF (hyd.txfd >= 0)
                                      AstrCopy(hyd.txstatus,'Skipping')
                                      dohydra_status(hyd,TRUE)
                                      ->hydra_gotoxy(1,29,1)
                                      ->hydra_printf(1,'Skipping')
                                      StringF(s,'+HSEND: Skipping \s',hyd.txfname)
                                      dologmessage(hyd,1,s)
                                      proc:=hyd.hyd_close
                                      proc(hyd.txfd)
                                      hyd.txfd:=-1
                                      hyd.txstate:=HTX_EOF
                                   ENDIF
                                   hyd.txpos:=-2
                                   JUMP brk5
                                ENDIF

                                IF (hyd.txblklen > intell(Long(hyd.rxbuf)))
                                   hyd.txblklen:=intell(Long(hyd.rxbuf))
                                ELSE
                                   hyd.txblklen:=Shr(hyd.txblklen,1)
                                ENDIF
                                
                                IF (hyd.txblklen <=  64)
                                  hyd.txblklen:=64
                                ELSEIF (hyd.txblklen <= 128)
                                  hyd.txblklen:=128
                                ELSEIF (hyd.txblklen <= 256)
                                  hyd.txblklen:=256
                                ELSEIF (hyd.txblklen <= 512)
                                  hyd.txblklen:=512
                                ELSE
                                  hyd.txblklen:=1024
                                ENDIF
                                hyd.txgoodbytes:=0
                                hyd.txgoodneeded:=hyd.txgoodneeded+1024
                                IF (hyd.txgoodneeded > 8192) THEN hyd.txgoodneeded:=8192
                                hyd.txerrorpos:=hyd.txpos
                                dohydra_status(hyd,TRUE)
                                StringF(s,'+HSEND: Resending from offset \d (newblklen=\u)',hyd.txpos,hyd.txblklen)
                                dologmessage(hyd,0,s)
                                proc:=hyd.hyd_seek
                                IF (proc(hyd.txfd,hyd.txpos,OFFSET_BEGINING) < 0)
                                   dologmessage(hyd,6,'!HSEND: File seek error')
                                   proc:=hyd.hyd_close
                                   proc(hyd.txfd)
                                   hyd.txfd:=-1
                                   hyd.txpos:=-2
                                   hyd.txstate:=HTX_EOF
                                   JUMP brk5
                                ENDIF

                                IF (hyd.txstate <> HTX_XWAIT) THEN hyd.txstate:=HTX_XDATA
                             ELSE
                                hyd.txretries:=hyd.txretries+1
                                IF (hyd.txretries > H_RETRIES)
                                   dologmessage(hyd,3,'-HSEND: Too many errors')
                                   hyd.txstate:=HTX_DONE
                                   res:=XFER_ABORT
                                ENDIF
                             ENDIF
                          ENDIF
                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_EOF)
                          IF (hyd.rxstate = HRX_DATA)
                             IF (intell(Long(hyd.rxbuf)) < 0)
                                hydra_badxfer(hyd)
                                AstrCopy(hyd.rxstatus,'Skipping')
                                dohydra_status(hyd,FALSE)
                                ->hydra_gotoxy(0,29,1)
                                ->hydra_printf(0,'Skipping')
                                ->hydra_clreol(0)
                                StringF(s,'+HRECV: Skipping \s',hyd.rxfname)
                                dologmessage(hyd,1,s)
                                hyd.rxstate:=HRX_FINFO
                                hyd.braindead:=time()+H_BRAINDEAD
                             ELSEIF (intell(Long(hyd.rxbuf)) <> hyd.rxpos)
                                IF (intell(Long(hyd.rxbuf)) <= hyd.rxlastsync)
                                   hyd.rxtimer:=0
                                   hyd.rxretries:=0
                                ENDIF
                                hyd.rxlastsync:=intell(Long(hyd.rxbuf))

                                IF ((h_timer_running(hyd.rxtimer)=FALSE) OR (h_timer_expired(hyd.rxtimer)))
                                   hyd.rxretries:=hyd.rxretries+1
                                   IF (hyd.rxretries > H_RETRIES)
                                      dologmessage(hyd,3,'-HRECV: Too many errors')
                                      hyd.txstate:=HTX_DONE
                                      res:=XFER_ABORT
                                      JUMP brk5
                                   ENDIF
                                   IF (hyd.rxretries = 1) THEN hyd.rxsyncid:=hyd.rxsyncid+1

                                   hyd.rxblklen:=hyd.rxblklen / 2
                                   i:=hyd.rxblklen
                                   
                                   IF (i <=  64)
                                    i:=64
                                   ELSEIF(i <= 128)
                                    i:=128
                                   ELSEIF(i <= 256)
                                    i:=256
                                   ELSEIF(i <= 512)
                                    i:=512
                                   ELSE
                                    i:=1024
                                   ENDIF
                                   StringF(s,'-HRECV: Bad EOF at \d - Retry \u (newblklen=\u)',hyd.rxpos,hyd.rxretries,i)
                                   dologmessage(hyd,0,s)
                                           
                                   PutLong(hyd.txbufin,intell(hyd.rxpos))
                                   PutLong(hyd.txbufin,intell(i))
                                   PutLong(hyd.txbufin,intell(hyd.rxsyncid))
                                   txpkt(hyd,3 * (SIZEOF LONG),HPKT_RPOS)
                                   hyd.rxtimer:=time()+hyd.timeout
                                ENDIF
                             ELSE
                                hyd.rxfsize:=hyd.rxpos
                                proc:=hyd.hyd_close
                                proc(hyd.rxfd)
                                hyd.rxfd:=-1
                                hydra_pct(hyd,FALSE)

                                p:=xfer_okay(hyd)
                                IF (p)
                                  ->hydra_gotoxy(0,25,1)
                                  ->StringF(s,'  -> \s',p)
                                  ->hydra_printf(0,s)
                                  StringF(s,'+HRECV: Dup file renamed: \s',p)
                                  dologmessage(hyd,1,s)
                                ENDIF
                                
                                proc:=hyd.hyd_uploadcompleted
                                IF proc THEN proc(hyd.rxfname,hyd.rxfsize)

                                dohydra_status(hyd,0)
                                StringF(s,'+Rcvd-H \s',IF p THEN p ELSE hyd.rxfname)
                                dologmessage(hyd,1,s)
                                t1,t2:=time()
                                t:=Mul((t1-hyd.rxstart1),50)+t2-hyd.rxstart2
                                IF hyd.ultime_taken_ptr THEN hyd.ultime_taken_ptr[]:=hyd.ultime_taken_ptr[]+t
                                resultlog(hyd,FALSE,IF p THEN p ELSE hyd.rxfname,hyd.rxfsize - hyd.rxoffset,Div(t,50))
                                hyd.rxstate:=HRX_FINFO
                                hyd.braindead:=time()+H_BRAINDEAD
                             ENDIF/*skip/badeof/eof*/
                          ENDIF/*rxstate==HRX_DATA*/

                          IF (hyd.rxstate = HRX_FINFO) THEN txpkt(hyd,0,HPKT_EOFACK)

                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_EOFACK)
                          IF ((hyd.txstate = HTX_EOF) OR (hyd.txstate = HTX_EOFACK))
                            hyd.braindead:=time()+H_BRAINDEAD
                            IF (hyd.txfd >= 0)
                               hyd.txfsize:=hyd.txpos
                               proc:=hyd.hyd_close
                               proc(hyd.txfd)
                               proc:=hyd.hyd_downloadcompleted
                               IF proc THEN proc(hyd.txfsize)
                               hydra_pct(hyd,TRUE)
                               t1,t2:=time()
                               t:=Mul((t1-hyd.txstart1),50)+t2-hyd.txstart2
                               IF hyd.dltime_taken_ptr THEN hyd.dltime_taken_ptr[]:=hyd.dltime_taken_ptr[]+t
                               resultlog(hyd,TRUE,txpathname,hyd.txfsize - hyd.txoffset,Div(t,50))
                               RETURN XFER_OK
                            ELSE
                              RETURN XFER_SKIP
                            ENDIF
                          ENDIF
                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_IDLE)
                          IF (hyd.txstate = HTX_XWAIT)
                            hyd.hdxlink:=FALSE
                            hyd.txtimer:=0
                            hyd.txretries:=0
                            AstrCopy(hyd.txstatus,'')
                            hyd.txstate:=HTX_XDATA
                          ELSEIF ((hyd.txstate >= HTX_FINFO) AND (hyd.txstate < HTX_REND))
                            hyd.braindead:= time()+H_BRAINDEAD
                          ENDIF

                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_END)
                          /* special for chat, other side wants to quit */
                          IF ((hyd.chattimer > 0) AND (hyd.txstate = HTX_REND))
                            hyd.chattimer:=-3
                            JUMP brk5
                          ENDIF

                          IF ((hyd.txstate = HTX_END) OR (hyd.txstate = HTX_ENDACK))
                            txpkt(hyd,0,HPKT_END)
                            txpkt(hyd,0,HPKT_END)
                            txpkt(hyd,0,HPKT_END)
                            AstrCopy(hyd.txstatus,'Completed')
                            dologmessage(hyd,1,'+HYDRA: Completed')
                            hyd.txstate:=HTX_DONE
                            res:=XFER_OK
                          ENDIF
                        /*---------------------------------------------------*/

                        ELSEIF (pkttype=HPKT_DEVDATA)
                          IF (hyd.devrxid <> intell(Long(hyd.rxbuf)))
                             hydra_devrecv(hyd)
                             hyd.devrxid:=intell(Long(hyd.rxbuf))
                          ENDIF
                          PutLong(hyd.txbufin,intell(hyd.devrxid))
                          txpkt(hyd,SIZEOF LONG,HPKT_DEVDACK)

                        /*---------------------------------------------------*/
                        ELSEIF (pkttype=HPKT_DEVDACK)
                          IF (hyd.devtxstate AND (hyd.devtxid = intell(Long(hyd.rxbuf))))
                            hyd.devtxtimer:=0
                            hyd.devtxstate:=HTD_DONE
                          ENDIF

                        /*---------------------------------------------------*/
                        /* unknown packet types: IGNORE, no error! */

                        /*---------------------------------------------------*/
                        ENDIF
                 ->ENDSELECT/*switch(pkttype)*/
brk5:
                 /*----------------------------------------------------------*/
                  SELECT hyd.txstate
                        /*---------------------------------------------------*/
                        CASE HTX_START
                          IF (hyd.rxstate = HRX_FINFO)
                            hyd.txtimer:=0
                            hyd.txretries:=0
                            hyd.txstate:=HTX_INIT
                          ENDIF
                        CASE HTX_SWAIT
                          IF (hyd.rxstate = HRX_FINFO)
                            hyd.txtimer:=0
                            hyd.txretries:=0
                            hyd.txstate:=HTX_INIT
                          ENDIF

                        /*---------------------------------------------------*/
                        CASE HTX_RINIT
                          IF (hyd.rxstate = HRX_FINFO)
                             hyd.txtimer:=0
                             hyd.txretries:=0
                             hyd.txstate:=HTX_FINFO;
                          ENDIF

                        /*---------------------------------------------------*/
                        CASE HTX_XDATA
                          IF (hyd.rxstate AND hyd.hdxlink)
                            StringF(s,'*HYDRA: \s',HDXMSG)
                            dologmessage(hyd,3,s)
                            hydra_devsend(hyd,'MSG',HDXMSG,StrLen(HDXMSG))

                            hyd.txtimer:=time()+H_IDLE
                            hyd.txstate:=HTX_XWAIT
                          ENDIF

                        /*---------------------------------------------------*/
                        CASE HTX_XWAIT
                          IF (hyd.rxstate=0)
                             hyd.txtimer:=0
                             hyd.txretries:=0
                             hyd.txstate:=HTX_XDATA
                          ENDIF

                        /*---------------------------------------------------*/
                        CASE HTX_REND
                          IF ((hyd.rxstate=0) AND (hyd.devtxstate=0))
                             /* special for chat, braindead will protect */
                             IF (hyd.chattimer > 0) THEN JUMP brk4
                             IF (hyd.chattimer = 0) THEN hyd.chattimer:=-3

                             hyd.txtimer:=0
                             hyd.txretries:=0
                             hyd.txstate:=HTX_END
                          ENDIF

                        /*---------------------------------------------------*/
                 ENDSELECT/*switch(txstate)*/
brk4:
          ENDIF/*while(txstate&&pkttype)*/
          
        UNTIL hyd.txstate=0

        IF (hyd.txfd >= 0)
          proc:=hyd.hyd_close
          proc(hyd.txfd)
        ENDIF
        hydra_badxfer(hyd)
        IF (res = XFER_ABORT)
           com_dump(hyd)
           IF (carrier(hyd))
              com_putblock(hyd,ABORTSTR,StrLen(ABORTSTR))
              com_flush(hyd)
           ENDIF
           com_purge()
        ELSE
           com_flush(hyd)
        ENDIF
ENDPROC res

EXPORT PROC hydra_do_transfer(hyd: PTR TO hydra_t, recv_dir:PTR TO CHAR, bytes_received: PTR TO LONG,bytes_sent: PTR TO LONG, dltimetaken:PTR TO LONG, ultimetaken:PTR TO LONG)
  DEF fname[255]:STRING
  DEF msg[255]:STRING
  DEF p,res
  DEF abort=FALSE
  DEF r
  
  hyd.datalen:=0

  AstrCopy(hyd.download,recv_dir)
  hyd.bytes_sent_ptr:=bytes_sent
  hyd.bytes_recv_ptr:=bytes_received
  hyd.ultime_taken_ptr:=ultimetaken
  hyd.dltime_taken_ptr:=dltimetaken

  hyd.err:=FALSE  
  IF dltimetaken<>NIL THEN dltimetaken[]:=0
  IF ultimetaken<>NIL THEN ultimetaken[]:=0
  
  p:=hyd.hyd_firstfile
  IF p<>NIL
    IF p(fname)
      REPEAT
        r:=hydra(hyd,fname,NIL)
        SELECT r
          CASE XFER_ABORT
            abort:=TRUE
          CASE XFER_SKIP
          CASE XFER_OK
            StringF(msg,'+Sent-H \s',FilePart(fname))
            dologmessage(hyd,1,msg)
        ENDSELECT
        res:=FALSE
        IF abort=FALSE
          p:=hyd.hyd_nextfile
          IF p<>NIL THEN res:=p(fname)
        ENDIF
      UNTIL res=FALSE
    ENDIF
  ENDIF
  res:=(hyd.err=FALSE) AND (abort=FALSE)
  IF res THEN hydra(hyd,NIL,NIL)               /* end of batch stuff */
  IF hyd.err THEN res:=FALSE
ENDPROC res

EXPORT PROC hydra_cleanup(hyd: PTR TO hydra_t)
  Dispose(hyd.txbuf)
  Dispose(hyd.rxbuf)
  Dispose(hyd.crc16tab)
  Dispose(hyd.crc32tab)
ENDPROC

