OPT LARGE,MODULE

 MODULE 'dos/dos'

EXPORT CONST LOG_DEBUG=4
EXPORT CONST LOG_INFO=3
EXPORT CONST LOG_NOTICE=2
EXPORT CONST LOG_WARNING=1
EXPORT CONST LOG_ERR=0

CONST MAX_PATH=512

CONST CTRL_Z=26

CONST CPMEOF=2  ->CPM End of file (^Z)
CONST XMODEM_MIN_BLOCK_SIZE=128
CONST XMODEM_MAX_BLOCK_SIZE=1024
CONST XMODEM_2K_BLOCK_SIZE=2048

CONST NOINP=-1
CONST FAILURE=-2
CONST NOT_YMODEM=-3
CONST NOT_XMODEM=-4

CONST SEND = 0
CONST RECV = 1
CONST XMODEM = 2
CONST YMODEM = 4
CONST ZMODEM = 8
CONST CRC = 16
CONST GMODE = 32
CONST B2K = 64
CONST OVERWRITE=512

CONST SUCCESS=0

CONST SOH=1
CONST STX=2
CONST ETX=3
CONST EOT=4
CONST ACK=6
CONST NAK=21
CONST CAN=24

EXPORT OBJECT xymodem_t

  mode:CHAR
  g_mode_supported:CHAR
  crc_mode_supported:CHAR
  iacEncode:CHAR

  sendBuffer:PTR TO CHAR
  sendBufferSize
  sendBufferPtr:PTR TO CHAR
  sendBufferEnd
  
  cancelled
  send_timeout
  recv_timeout
  byte_timeout
  ack_timeout
  success

  crc16tbl:PTR TO INT

  zm_lputs
  zm_progress
  zm_recv_byte
  zm_is_connected
  zm_is_cancelled
  zm_upload_completed
  zm_upload_failed
  zm_dupecheck
  zm_data_waiting
  zm_flush
  zm_duplicate_filename
  zm_fopen
  zm_fclose
  zm_fread
  zm_fwrite
  zm_fseek
  zm_firstfile
  zm_nextfile

  current_file_name[MAX_PATH]:ARRAY OF CHAR
  new_file
  transfer_start_time1
  transfer_start_time2
  current_file_pos
  current_file_size
  total_files
  total_bytes
  errors
  fallback_to_xmodem

  g_delay
  max_errors:LONG
  block_size:LONG
  max_block_size:LONG
  max_file_size:LONG    /* 0 = unlimited */
  log_level:PTR TO INT

  user_data:LONG
  /* Callbacks */
  cbdata: PTR TO CHAR
ENDOBJECT

PROC memset(addr:PTR TO CHAR,val,len)
  WHILE (len--)>=0 DO addr[]++:=val
ENDPROC

->#define ucrc16(ch,crc) (crc16tbl[((crc>>8)&0xff)^(unsigned char)ch]^(crc << 8))
PROC ucrc16(zm:PTR TO xymodem_t,ch,crc) IS Eor(zm.crc16tbl[Eor(Shr(crc,8) AND $ff,ch)],Shl(crc,8)) AND $ffff

PROC getXYmSystemTime()
  DEF currDate: datestamp 
  DateStamp(currDate)
ENDPROC Mul(Mul(currDate.days,1440),60)+(currDate.minute*60)+(currDate.tick/50),Mod(currDate.tick,50)

PROC fexist(file)
  DEF lh
  IF lh:=Lock(file,ACCESS_READ)
    UnLock(lh)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

PROC lprintf(xym:PTR TO xymodem_t, level, str:PTR TO CHAR)
  DEF p
  IF(xym.zm_lputs=NIL) THEN RETURN -1

  IF(xym.log_level<>NIL)
    IF(level > xym.log_level) THEN RETURN 0
  ENDIF
  p:=xym.zm_lputs
ENDPROC p(level,str)


PROC is_connected(xym: PTR TO xymodem_t)
  DEF p
  p:=xym.zm_is_connected
  IF(p<>NIL) THEN RETURN p()
ENDPROC TRUE

PROC is_cancelled(xym: PTR TO xymodem_t)
  DEF p
  p:=xym.zm_is_cancelled
  IF(p<>NIL) 
    xym.cancelled:=xym.cancelled OR p()
    RETURN xym.cancelled
  ENDIF
ENDPROC xym.cancelled

PROC upload_completed(xym:PTR TO xymodem_t,fname:PTR TO CHAR)
  DEF p
  p:=xym.zm_upload_completed
  IF (p<>NIL) THEN p(fname)
ENDPROC

PROC upload_failed(xym:PTR TO xymodem_t,fname:PTR TO CHAR)
  DEF p
  p:=xym.zm_upload_failed
  IF (p<>NIL) THEN p(fname)
ENDPROC

PROC dupe_check(xym:PTR TO xymodem_t,fname)
  DEF res=FALSE
  DEF p
  p:=xym.zm_dupecheck
  IF (p<>NIL) THEN res:=p(fname)
ENDPROC res

PROC xmodem_duplicate(xym:PTR TO xymodem_t,fname:PTR TO CHAR)
  DEF res=FALSE
  DEF p
  p:=xym.zm_duplicate_filename
  IF (p<>NIL) THEN res:=p(fname) 
ENDPROC res

PROC xmodem_progress(xym:PTR TO xymodem_t)
  DEF p

  p:=xym.zm_progress
  IF(p<>NIL) THEN p(xym.current_file_pos,xym.current_file_size,xym.transfer_start_time1,xym.transfer_start_time2,xym.errors,0,xym.current_file_name,xym.new_file,xym.block_size)
ENDPROC

PROC putcom(xym:PTR TO xymodem_t,ch)
  IF (xym.iacEncode AND (ch=255))
    IF xym.sendBufferPtr>(xym.sendBufferEnd-2) THEN xmodem_flush(xym)
    xym.sendBufferPtr[]:=ch
    xym.sendBufferPtr:=xym.sendBufferPtr+1
    xym.sendBufferPtr[]:=ch
    xym.sendBufferPtr:=xym.sendBufferPtr+1
    IF xym.sendBufferPtr=xym.sendBufferEnd THEN xmodem_flush(xym)
  ELSE
    xym.sendBufferPtr[]:=ch
    xym.sendBufferPtr:=xym.sendBufferPtr+1
    IF xym.sendBufferPtr=xym.sendBufferEnd THEN xmodem_flush(xym)
  ENDIF
ENDPROC

PROC getcom(xym:PTR TO xymodem_t,timeout)
  DEF p
  p:=xym.zm_recv_byte
ENDPROC p(timeout)

EXPORT PROC xmodem_flush(xym: PTR TO xymodem_t)
  DEF p

 IF (xym.sendBufferPtr>xym.sendBuffer)
    p:=xym.zm_flush
    IF(p<>NIL) THEN p(xym.sendBuffer,xym.sendBufferPtr-xym.sendBuffer)
    xym.sendBufferPtr:=xym.sendBuffer
  ENDIF
ENDPROC

PROC chr(ch,output)
  SELECT ch
    CASE SOH
      StrCopy(output,'SOH')
      RETURN
    CASE STX
      StrCopy(output,'STX')
      RETURN
    CASE ETX
      StrCopy(output,'ETX')
      RETURN
    CASE EOT
      StrCopy(output,'EOT')
      RETURN
    CASE ACK
      StrCopy(output,'ACK')
      RETURN
    CASE NAK
      StrCopy(output,'NAK')
      RETURN
    CASE CAN
      StrCopy(output,'CAN')
      RETURN
  ENDSELECT

  IF((ch>=" ") AND (ch<="~"))
    StringF(output,'''\c'' (\h[2])',ch,ch)
  ELSE
    StringF(output,'\d (\h[2])',ch,ch)
  ENDIF
ENDPROC

PROC xmodem_put_ack(xym:PTR TO xymodem_t)

  WHILE ((getcom(xym,0)<>NOINP) AND (is_connected(xym)))
  ENDWHILE
 
  putcom(xym,ACK)

  xmodem_flush(xym)

ENDPROC

PROC xmodem_put_nak(xym:PTR TO xymodem_t, block_num)
  DEF tempstr[255]:STRING
  DEF dump_count=0

  /* wait for any trailing data */
  WHILE(((getcom(xym,0))<>NOINP) AND (is_connected(xym)))
    dump_count++
    ->StringF(tempstr,'Block \d: Dumping byte: \h[2]',block_num,i)
    ->lprintf(xym,LOG_DEBUG,tempstr)
    Delay(1)
  ENDWHILE
  
  IF(dump_count)
    StringF(tempstr,'Block \d: Dumped \d bytes',block_num, dump_count)
    lprintf(xym,LOG_INFO,tempstr)
  ENDIF

  IF(block_num<=1)
    IF((xym.mode AND (B2K OR GMODE))=(B2K OR GMODE))  -> A for X/Ymodem-G with 2-K block
      StringF(tempstr,'Block \d: Requesting mode: Streaming, 16-bit CRC, 2K Block', block_num)
      lprintf(xym,LOG_INFO,tempstr)
      putcom(xym,"A")
    ELSEIF((xym.mode) AND GMODE)  -> G for X/Ymodem-G
      StringF(tempstr,'Block \d: Requesting mode: Streaming, 16-bit CRC', block_num)
      lprintf(xym,LOG_INFO,tempstr)
      putcom(xym,"G")
    ELSEIF ((xym.mode) AND CRC)  -> C for CRC
      StringF(tempstr,'Block \d: Requesting mode: 16-bit CRC', block_num)
      lprintf(xym,LOG_INFO,tempstr)
      putcom(xym,"C")
    ELSE        -> NAK for checksum
      StringF(tempstr,'Block \d: Requesting mode: 8-bit Checksum', block_num)
      lprintf(xym,LOG_INFO,tempstr)
      putcom(xym,NAK)
    ENDIF
  ELSE
    putcom(xym,NAK)
  ENDIF

  xmodem_flush(xym)
ENDPROC


PROC xmodem_cancel(xym:PTR TO xymodem_t)
  DEF i

  IF((is_cancelled(xym)=FALSE) AND (is_connected(xym)))
    xym.cancelled:=TRUE
    i:=0
    WHILE(i<8) AND (is_connected(xym))
      putcom(xym,CAN)
      i++
    ENDWHILE
    i:=0
    WHILE((i<10) AND (is_connected(xym)))
      putcom(xym,2)
      i++
    ENDWHILE
  ENDIF
  xmodem_flush(xym)
ENDPROC SUCCESS


->****************************************************************************/
->* Return 0 on success                            */
->****************************************************************************/
PROC xmodem_get_block(xym:PTR TO xymodem_t, block:PTR TO CHAR, expected_block_num)
  DEF block_num        -> Block number received in header
  DEF block_inv
  DEF chksum,calc_chksum
  DEF i,eot=0,can=0
  DEF b,errors
  DEF crc,calc_crc
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

  StringF(tempstr,'Requesting data block \d', expected_block_num)
  lprintf(xym, LOG_DEBUG, tempstr)
  
  errors:=0
  WHILE((errors<=xym.max_errors) AND (is_connected(xym)))
    i:=getcom(xym,IF expected_block_num<=1 THEN 3 ELSE 10)
    
    IF(eot AND (i<>EOT) AND (i<>NOINP)) THEN eot:=0
    
    IF(can AND (i<>CAN)) THEN can:=0     
    
    SELECT i
      CASE SOH -> 128-byte blocks 
        xym.block_size:=XMODEM_MIN_BLOCK_SIZE
      CASE ETX -> 2048-byte blocks
        IF(xym.max_block_size < XMODEM_2K_BLOCK_SIZE) 
          StringF(tempstr,'Block \d: 2048-byte blocks not supported',expected_block_num)
          lprintf(xym,LOG_WARNING,tempstr)
          RETURN FAILURE
        ENDIF
        xym.block_size:=XMODEM_2K_BLOCK_SIZE
      CASE STX -> 1024-byte blocks 
        IF(xym.max_block_size < XMODEM_MAX_BLOCK_SIZE) 
          StringF(tempstr,'Block \d: 1024-byte blocks not supported',expected_block_num)
          lprintf(xym,LOG_WARNING,tempstr)
          RETURN FAILURE
        ENDIF
        xym.block_size:=XMODEM_MAX_BLOCK_SIZE
      CASE EOT
        StringF(tempstr,'Block \d: EOT received', expected_block_num)
        lprintf(xym,LOG_DEBUG,tempstr)
        IF(eot=FALSE)
          lprintf(xym,LOG_INFO,'NAKing first EOT')
          eot:=1 
          xmodem_put_nak(xym,expected_block_num) -> chuck's double EOT trick 
          JUMP lp 
        ENDIF
        RETURN EOT
      CASE CAN
        IF(can=FALSE)      -> must get two CANs in a row
          can:=1
          StringF(xym,LOG_WARNING,'Block \d: Received CAN  Expected SOH, STX, or EOT',expected_block_num)
          lprintf(xym,LOG_WARNING,tempstr)
          JUMP lp
        ENDIF
        StringF(tempstr,'Block \d: Canceled remotely', expected_block_num)
        lprintf(xym,LOG_WARNING,tempstr)
        RETURN CAN
      CASE NOINP   -> Nothing came in
        IF(eot) THEN RETURN EOT
        RETURN NOINP
      DEFAULT
        chr(i,tempstr2)
        StringF(tempstr,'Block \d: Received \s  Expected SOH, STX, or EOT',expected_block_num,tempstr2)
        lprintf(xym,LOG_WARNING,tempstr)
        IF (eot) THEN RETURN EOT
        RETURN NOINP
    ENDSELECT
    
    IF ((i:=getcom(xym,xym.byte_timeout))=NOINP) THEN RETURN FAILURE

    block_num:=i
    
    IF ((i:=getcom(xym,xym.byte_timeout))=NOINP) THEN RETURN FAILURE

    block_inv:=i
    calc_crc:=0
    calc_chksum:=0
    
    b:=0
    WHILE((b<xym.block_size) AND (is_connected(xym)))
      IF((i:=getcom(xym,xym.byte_timeout))=NOINP) THEN RETURN FAILURE
     
      block[b]:=i
      IF (xym.mode AND B2K)=0
        IF(xym.mode AND CRC)
          calc_crc:=ucrc16(xym,block[b],calc_crc)
        ELSE
          calc_chksum:=calc_chksum+block[b]
        ENDIF
      ENDIF
        
      b++
    ENDWHILE

    IF (b<xym.block_size) THEN RETURN FAILURE

    IF(block_num<>(Eor(block_inv,255)))
      StringF(tempstr,'Block \d: Block number bit error (0x\h[2] vs 0x\h[2])',expected_block_num, block_num,Eor(block_inv,255))
      lprintf(xym,LOG_WARNING,tempstr)
      RETURN FAILURE
    ENDIF

    IF(xym.mode AND B2K)=0
      IF(xym.mode AND CRC) 
        crc:=Shl(getcom(xym,xym.byte_timeout),8)
        crc:=crc OR getcom(xym,xym.byte_timeout)
        IF(crc<>calc_crc)
          StringF(tempstr,'Block \d: CRC ERROR', block_num)
          lprintf(xym,LOG_WARNING,tempstr)
          RETURN FAILURE
        ENDIF
      ELSE  -> CHKSUM
        chksum:=getcom(xym,xym.byte_timeout)
        IF(chksum<>calc_chksum)
          StringF(tempstr,'Block \d: CHECKSUM ERROR', block_num)
          lprintf(xym,LOG_WARNING,tempstr)
          RETURN FAILURE
        ENDIF
      ENDIF
    ENDIF

    IF(block_num<>(expected_block_num AND 255))
      StringF(tempstr,'Block number error (\d received, expected \d)',block_num,expected_block_num AND 255)
      lprintf(xym,LOG_WARNING,tempstr)
      
      IF (((xym.mode) AND XMODEM) AND (expected_block_num=1) AND (block_num=0)) THEN RETURN NOT_XMODEM
      
      IF ((expected_block_num=0) AND (block_num=1)) THEN RETURN NOT_YMODEM
      
      IF((expected_block_num) AND (block_num=((expected_block_num-1) AND 255)))
        JUMP lp -> silently discard repeated packets (ymodem.doc 7.3.2) 
      ENDIF
      
      RETURN FAILURE
    ENDIF

    RETURN SUCCESS -> Success
lp:
    errors++
  ENDWHILE
ENDPROC FAILURE   -> Failure


->****************/
-> Sends a block */
/*****************/
PROC xmodem_put_block(xym:PTR TO xymodem_t, block:PTR TO CHAR, block_size, block_num)
  DEF   ch,chksum
  DEF crc

  IF xym.sendBufferPtr>(xym.sendBufferEnd-(Shl(block_size+5,1))) THEN xmodem_flush(xym)
  
  IF(block_size=XMODEM_MIN_BLOCK_SIZE)
    putcom(xym,SOH)
  ELSEIF block_size=XMODEM_MAX_BLOCK_SIZE
    -> 1024
    putcom(xym,STX)
  ELSE
    -> 2048
    putcom(xym,ETX)
  ENDIF
  
  ch:=(block_num AND 255)
  
  putcom(xym,ch)
  putcom(xym,Eor(ch,255))

  IF((xym.mode) AND B2K)=FALSE
      IF((xym.mode) AND CRC)
        crc:=0
        WHILE (block_size--)>=0
          putcom(xym,ch:=block[]++)
          crc:=ucrc16(xym,ch,crc)
        ENDWHILE
        putcom(xym,(Shr(crc,8)))
        putcom(xym,(crc AND 255))
      ELSE
        chksum:=0
        WHILE (block_size--)>=0
          putcom(xym,ch:=block[]++)
          chksum:=(chksum+ch) AND 255
        ENDWHILE
        putcom(xym,chksum)
      ENDIF     
  ELSE
    WHILE (block_size--)>=0 DO putcom(xym,block[]++)
  ENDIF
  
  IF((xym.mode) AND GMODE)=FALSE THEN xmodem_flush(xym)

ENDPROC


->************************************************************/
->* Gets an acknowledgement - usually after sending a block  */
->* Returns ACK if ack received                */
->************************************************************/
PROC xmodem_get_ack(xym:PTR TO xymodem_t, tries, block_num)

  DEF  i=NOINP,can=0
  DEF errors
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  
  errors:=0
  WHILE((errors<tries) AND (is_connected(xym)))

    IF((xym.mode) AND GMODE) -> Don't wait for ACK on X/Ymodem-G 
      IF xym.g_delay>0 THEN Delay(xym.g_delay)
      IF(getcom(xym,0)=CAN)
        StringF(tempstr,'Block \d: !Canceled remotely', block_num)
        lprintf(xym,LOG_WARNING,tempstr)
        xmodem_cancel(xym)
        RETURN CAN
      ENDIF
      RETURN ACK
    ENDIF

    i:=getcom(xym,xym.ack_timeout)
    IF(can AND (i<>CAN)) THEN can:=0
    
    IF (i=ACK) THEN RETURN ACK

    IF(i=CAN)
      IF(can)  -> 2 CANs in a row 
        StringF(tempstr,'Block \d: !Canceled remotely', block_num)
        lprintf(xym,LOG_WARNING,tempstr)
        xmodem_cancel(xym)
        RETURN CAN
      ENDIF
      can:=1
    ENDIF
    
    IF(i<>NOINP)
      chr(i,tempstr2)
      StringF(tempstr,'Block \d: !Received \s  Expected ACK',block_num, tempstr2)
      lprintf(xym,LOG_WARNING,tempstr)
      IF (i<>CAN) THEN RETURN i
    ENDIF
    
    IF (i<>CAN) THEN errors++
  ENDWHILE

ENDPROC i


PROC xmodem_get_mode(xym:PTR TO xymodem_t)
  DEF i
  DEF errors
  DEF can
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

  lprintf(xym,LOG_INFO,'Waiting for transfer mode request...')

  xym.mode:=xym.mode AND Eor(GMODE OR CRC,255)
  errors:=0
  can:=0
  WHILE((errors<=xym.max_errors) AND (is_connected(xym)))
lp2:
    i:=getcom(xym,xym.recv_timeout)
    IF(can AND (i<>CAN)) THEN can:=0
    
    SELECT i
      CASE NAK     -> checksum 
        lprintf(xym,LOG_INFO,'Receiver requested mode: 8-bit Checksum')
        RETURN TRUE
      CASE "C"
        lprintf(xym,LOG_INFO,'Receiver requested mode: 16-bit CRC')
        IF(xym.crc_mode_supported=FALSE) THEN JUMP lp2

        xym.mode:=xym.mode OR CRC
        RETURN TRUE
      CASE "A"
        lprintf(xym,LOG_INFO,'Receiver requested mode: Streaming, 2k-block, 16-bit CRC')
        IF ((xym.crc_mode_supported=FALSE) OR (xym.g_mode_supported=FALSE)) THEN JUMP lp2

        xym.mode:=xym.mode OR (GMODE OR CRC OR B2K)
        xym.max_block_size:=XMODEM_2K_BLOCK_SIZE
        xym.block_size:=XMODEM_2K_BLOCK_SIZE
        RETURN TRUE
      CASE "G"
        lprintf(xym,LOG_INFO,'Receiver requested mode: Streaming, 16-bit CRC')
        IF ((xym.crc_mode_supported=FALSE) OR (xym.g_mode_supported=FALSE)) THEN JUMP lp2

        xym.mode:=xym.mode OR (GMODE OR CRC)
        RETURN TRUE
      CASE CAN
        IF(can)
          lprintf(xym,LOG_WARNING,'Canceled remotely')
          RETURN FALSE
        ENDIF
        can:=1 
      CASE NOINP
        ->do nothing
      DEFAULT
        chr(i,tempstr2)
        StringF(tempstr,'Received \s  Expected NAK, C, or G',tempstr2)
        lprintf(xym,LOG_WARNING,tempstr)
    ENDSELECT
    errors++
  ENDWHILE 

  lprintf(xym,LOG_ERR,'Failed to get transfer mode request from receiver')
ENDPROC FALSE

PROC xmodem_put_eot(xym:PTR TO xymodem_t)
  DEF ch
  DEF errors
  DEF cans=0
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

  errors:=0
  WHILE((errors<=xym.max_errors) AND (is_connected(xym)))

    StringF(tempstr,'Sending End-of-Text (EOT) indicator (\d)',errors+1)
    lprintf(xym,LOG_INFO,tempstr)

    WHILE(((ch:=getcom(xym,0))<>NOINP) AND (is_connected(xym)))
      chr(ch,tempstr2)
      lprintf(tempstr,'Throwing out received: \s',tempstr2)
      lprintf(xym,LOG_INFO,tempstr)
    ENDWHILE

    putcom(xym,EOT)
    xmodem_flush(xym)
    
    IF((ch:=getcom(xym,xym.recv_timeout))=NOINP) THEN JUMP lp3

    chr(ch,tempstr2)
    StringF(tempstr,'Received \s',tempstr2)
    lprintf(xym,LOG_INFO,tempstr)
    IF(ch=ACK) THEN RETURN TRUE
    
    IF ((ch=CAN) AND (cans>0)) THEN RETURN FALSE

    IF((ch=NAK) AND (errors=0) AND (((xym.mode) AND (YMODEM OR GMODE))=YMODEM))
      JUMP lp3  -> chuck's double EOT trick so don't complain 
    ENDIF
    
    lprintf(xym,LOG_WARNING,'Expected ACK')

lp3:    
    errors++
  ENDWHILE
ENDPROC FALSE

PROC xmodem_send_file(xym:PTR TO xymodem_t, fname:PTR TO CHAR, sent:PTR TO LONG, timetaken:PTR TO LONG)

  DEF success=FALSE
  DEF sent_bytes=0
  DEF block[XMODEM_2K_BLOCK_SIZE]: ARRAY OF CHAR
  DEF block_len
  DEF block_num
  DEF i
  DEF rd
  DEF sent_header=FALSE
  DEF fp,fsize
  DEF t,t1,t2,t3,t4
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF ch
  DEF p
  DEF fname2:PTR TO CHAR

  
  StringF(tempstr,'Sending file \s',fname)
  lprintf(xym,LOG_ERR,tempstr)

  xym.success:=FALSE
  fname2:=FilePart(fname)

  IF StrLen(fname)>0
    fp:=doOpen(xym,fname,MODE_OLDFILE)
    IF fp=NIL
      StringF(tempstr,'Error opening file \s',fname)
      lprintf(xym,LOG_ERR,tempstr)
      RETURN FALSE
    ENDIF
    fsize:=getFileSize(xym,fp)
    t1,t2:=getXYmSystemTime()
  ELSE
    fp:=0
    fsize:=0
  ENDIF

  IF(xym.total_files=0) THEN xym.total_files:=1

  IF(xym.total_bytes=0) THEN xym.total_bytes:=fsize

  -> try 
    IF((xym.mode) AND YMODEM)

      IF(xmodem_get_mode(xym)=FALSE) THEN JUMP sbr3

      memset(block,0,XMODEM_MAX_BLOCK_SIZE)
      AstrCopy(block,fname2,XMODEM_MAX_BLOCK_SIZE)
      
      
      StringF(tempstr,'\d \d 0 0 \d \d'
        ,fsize
        ,0 ->(uintmax_t)st.st_mtime
        ,xym.total_files  ->-xym.sent_files
        ,xym.total_bytes  ->-xym.sent_bytes
        )
      AstrCopy(block+StrLen(block)+1,tempstr)
      block_len:=StrLen(block)+1+StrLen(tempstr)
      
      StringF(tempstr,'Sending YMODEM header block: ''\s''',block+StrLen(block)+1)
      lprintf(xym,LOG_INFO,tempstr)
      
      xym.errors:=0
      WHILE((xym.errors<=xym.max_errors) AND (is_cancelled(xym)=FALSE) AND (is_connected(xym)))
        
        WHILE(((ch:=getcom(xym,0))<>NOINP) AND (is_connected(xym)))
          chr(ch,tempstr2)
          StringF(tempstr,'Throwing out received: \s',tempstr2)
          lprintf(xym,LOG_INFO,tempstr)
        ENDWHILE
        xmodem_put_block(xym, block, IF block_len <=XMODEM_MIN_BLOCK_SIZE  THEN XMODEM_MIN_BLOCK_SIZE ELSE xym.block_size, 0)
        xmodem_flush(xym)
        
        IF((i:=xmodem_get_ack(xym,1, 0)) = ACK)
          sent_header:=TRUE
          JUMP sbr2
        ENDIF
        
        IF(((i=NAK) OR (i="C") OR (i="G")) AND (xym.fallback_to_xmodem) AND ((xym.errors+1) = xym.fallback_to_xmodem))
          StringF(tempstr,'Falling back to XMODEM mode after \d attempts',xym.fallback_to_xmodem)
          lprintf(xym,LOG_NOTICE,tempstr)
          xym.mode:=xym.mode AND Not(YMODEM)
          JUMP sbr2
        ENDIF
        xym.errors:=xym.errors+1
      ENDWHILE
sbr2:
      IF((xym.errors>xym.max_errors) OR (is_cancelled(xym)))
        lprintf(xym,LOG_ERR,'Failed to send header block')
        JUMP sbr3
      ENDIF
    ENDIF

    ->file handle is 
    IF fp=0 THEN RETURN TRUE

    IF(xmodem_get_mode(xym)=FALSE) THEN JUMP sbr3

    p:=xym.zm_progress
    IF(p<>NIL) THEN p(sent_bytes,fsize,t1,t2,xym.errors,0,fname2,TRUE,xym.block_size)

    block_num:=1
    xym.errors:=0
    
    WHILE((sent_bytes < fsize) AND (xym.errors<=xym.max_errors) AND (is_cancelled(xym)=FALSE) AND (is_connected(xym)))
      doSeek(xym,fp,sent_bytes,OFFSET_BEGINNING)
      IF(sent_header=FALSE)
        IF(xym.block_size>XMODEM_MIN_BLOCK_SIZE)
          IF((sent_bytes+xym.block_size) > fsize)
            IF((sent_bytes+xym.block_size-XMODEM_MIN_BLOCK_SIZE) >= fsize)
              lprintf(xym,LOG_INFO,'Falling back to 128-byte blocks for end of file')
              xym.block_size:=XMODEM_MIN_BLOCK_SIZE
            ENDIF
          ENDIF
        ENDIF
      ENDIF
      
      

      IF(((rd:=doRead(xym,fp,block,xym.block_size))<>xym.block_size) AND ((sent_bytes + rd) <> fsize))
        StringF(tempstr,'ERROR reading \d bytes at file offset \d',xym.block_size,sent_bytes)
        lprintf(xym,LOG_ERR,tempstr)
        xym.errors:=xym.errors+1
        JUMP lp4
      ENDIF
      memset(block+rd,CPMEOF,xym.block_size-rd)
     
      xmodem_put_block(xym, block, xym.block_size, block_num)
      IF(xmodem_get_ack(xym, 5,block_num) <> ACK)
        xym.errors:=xym.errors+1
        StringF(tempstr,'Block \d: Error #\d at offset \d',block_num, xym.errors,(sent_bytes-xym.block_size))
        lprintf(xym,LOG_WARNING,tempstr)
        IF((xym.errors=3) AND (block_num=1) AND (xym.block_size>XMODEM_MIN_BLOCK_SIZE))
          StringF(tempstr,'Block \d: Falling back to 128-byte blocks', block_num)
          lprintf(xym,LOG_NOTICE,tempstr)
          xym.block_size:=XMODEM_MIN_BLOCK_SIZE
        ENDIF
      ELSE
        block_num++
        sent_bytes:=sent_bytes+rd
      ENDIF
      p:=xym.zm_progress
      IF(p<>NIL) THEN p(sent_bytes,fsize,t1,t2,xym.errors,0,fname2,FALSE,xym.block_size)

lp4:
    ENDWHILE
    
    IF((sent_bytes >= fsize) AND  (is_cancelled(xym)=FALSE) AND (is_connected(xym)))

  ->#if 0 /* !SINGLE_THREADED */
  ->    lprintf(LOG_DEBUG,"Waiting for output buffer to empty... ")
  ->    if(WaitForEvent(outbuf_empty,5000)<>WAIT_OBJECT_0)
  ->      lprintf(xym,LOG_WARNING,"FAILURE")
  ->#endif
      IF (xmodem_put_eot(xym))  -> end-of-text, wait for ACK 
        success:=TRUE
      ENDIF
    ENDIF
    

sbr3:
  /* finally */

  IF (success=FALSE) THEN xmodem_cancel(xym)

  IF(sent<>NIL) THEN sent[]:=sent[]+sent_bytes

  t3,t4:=getXYmSystemTime()
  t:=Mul((t3-t1),50)+t4-t2
  
  IF(timetaken<>NIL) THEN timetaken[]:=timetaken[]+t
  xym.success:=success

  doClose(xym,fp)

ENDPROC success

EXPORT PROC xymodem_send_files(xym: PTR TO xymodem_t,sent: PTR TO LONG, timetaken:PTR TO LONG)
  DEF p,res,init=TRUE
  DEF fname[255]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF ch

  xym.mode:=YMODEM OR SEND

  WHILE(((ch:=getcom(xym,0))<>NOINP) AND (is_connected(xym)))
    chr(ch,tempstr2)
    lprintf(tempstr,'Throwing out received: \s',tempstr2)
    lprintf(xym,LOG_INFO,tempstr)
  ENDWHILE

   
  IF timetaken<>NIL THEN timetaken[]:=0
  IF sent<>NIL THEN sent[]:=0
  p:=xym.zm_firstfile
  IF p<>NIL
    IF p(fname)
      REPEAT
        res:=xmodem_send_file(xym, fname, sent, timetaken)
        IF res=FALSE THEN RETURN res
        init:=FALSE
        IF res
          p:=xym.zm_nextfile
          res:=FALSE
          IF p<>NIL THEN res:=p(fname)
        ENDIF
      UNTIL res=FALSE
      xmodem_send_file(xym, '', sent, timetaken)
      xmodem_flush(xym)
      
    ENDIF
  ENDIF
ENDPROC TRUE

EXPORT PROC xymodem_recv_files(xym: PTR TO xymodem_t, download_dir:PTR TO CHAR,bytes_received: PTR TO LONG,timetaken:PTR TO LONG)

  DEF str[255]:STRING
  DEF fname[255]:STRING
  DEF logtmp[255]:STRING
  DEF i=0
  DEF fnum=0
  DEF total_files=0
  DEF cps,wr
  DEF success=FALSE
  DEF fmode
  DEF serial_num=-1
  DEF tmpftime
  DEF file_bytes=0,file_bytes_left=0
  DEF total_bytes=0
  DEF fp=NIL
  DEF t,t1,t2,ftime=0
  DEF old_hold
  DEF tmp,s,r,pos

  DEF hold_update=FALSE

  DEF block[2048]:ARRAY OF CHAR
  DEF block_num
  DEF fcount=0

  xym.mode:=YMODEM OR CRC OR GMODE OR B2K OR RECV OR OVERWRITE

  old_hold:=hold_update
  IF timetaken<>NIL THEN timetaken[]:=0
  IF bytes_received<>NIL THEN bytes_received[]:=0

  WHILE(is_connected(xym))
    IF(xym.mode AND XMODEM)
      StrCopy(str,download_dir)
      
      file_bytes:=$7fffffff
      file_bytes_left:=file_bytes
    ELSE
      lprintf(xym,LOG_INFO,'Fetching YMODEM header block')
      xym.errors:=0
      WHILE((xym.errors<=xym.max_errors) AND (xym.cancelled=FALSE))
        xmodem_put_nak(xym,0)
        i:=xmodem_get_block(xym, block, 0)
        IF(i=SUCCESS)
          IF((xym.mode AND GMODE)=FALSE) 
            putcom(xym,ACK)
            xmodem_flush(xym)
          ENDIF
          JUMP rbr1
        ENDIF
        IF(((xym.errors+1)>(xym.max_errors/3)) AND (i=NOINP) AND ((xym.mode AND (B2K OR GMODE))=(B2K OR GMODE)))      /* Timeout */
          xym.mode:=xym.mode AND Not(B2K)
          StringF(logtmp,'Falling back to Streaming \s',IF (xym.mode AND CRC) THEN 'CRC-16' ELSE 'Checksum')
          lprintf(xym,LOG_WARNING,logtmp)
          xym.errors:=-1
        ELSEIF(((xym.errors+1)>(xym.max_errors/3)) AND (i=NOINP) AND (xym.mode AND GMODE))      /* Timeout */
          xym.mode:=xym.mode AND Not(GMODE)
          StringF(logtmp,'Falling back to \s',IF (xym.mode AND CRC) THEN 'CRC-16' ELSE 'Checksum')
          lprintf(xym,LOG_WARNING,logtmp)
          xym.errors:=-1
        ENDIF
        IF(i=NOT_YMODEM)
          StringF(logtmp,'Falling back to XMODEM\s',IF (xym.mode AND GMODE) THEN '-g' ELSE '')
          lprintf(xym,LOG_WARNING,logtmp)
          xym.mode:=xym.mode AND Not(YMODEM)
          xym.mode:=xym.mode OR XMODEM OR CRC
          hold_update:=0
          ->if(uifc.input(WIN_MID|WIN_SAV,0,0,"XMODEM Filename",fname,sizeof(fname),0)==-1) {
            xmodem_cancel(xym);
            JUMP end
          ->
          hold_update:=old_hold

          StringF(logtmp,'Falling back to XMODEM\s',IF (xym.mode AND GMODE) THEN '-g' ELSE '')
          lprintf(xym,LOG_WARNING,logtmp)
          StrCopy(str,fname)
          file_bytes:=$7fffffff
          file_bytes_left:=file_bytes
          JUMP rbr1
        ENDIF
        IF(((xym.errors+1)>(xym.max_errors/3)) AND (xym.mode AND CRC) AND ((xym.mode AND GMODE)=FALSE))
          lprintf(xym,LOG_NOTICE,'Falling back to 8-bit Checksum mode')
          xym.mode:=xym.mode AND Not(CRC)
        ENDIF
        xym.errors:=xym.errors+1
      ENDWHILE
rbr1:
      IF((xym.errors>xym.max_errors) OR xym.cancelled)
        xmodem_cancel(xym)
        JUMP end
      ENDIF
      IF(i<>NOT_YMODEM)
        IF(block[0]=FALSE) 
          lprintf(xym,LOG_INFO,'Received YMODEM termination block')
          JUMP end
        ENDIF
        file_bytes:=0
        total_bytes:=0
        total_files:=0
        /*i=sscanf(((char *)block)+strlen((char *)block)+1,"%"PRId64" %lo %lo %lo %d %"PRId64
          ,&file_bytes      /* file size (decimal) */
          ,&tmpftime        /* file time (octal unix format) */
          ,&fmode         /* file mode (not used) */
          ,&serial_num      /* program serial number */
          ,&total_files     /* remaining files to be sent */
          ,&total_bytes     /* remaining bytes to be sent */
          );*/
          
        s:=block+StrLen(block)+1
        tmp,r:=Val(s)
        file_bytes:=tmp
        s:=s+r
        tmpftime,r:=Val(s)
        s:=s+r
        fmode,r:=Val(s)
        s:=s+r
        serial_num,r:=Val(s)
        tmp,r:=Val(s)
        total_files:=tmp
        s:=s+r
        tmp,r:=Val(s)
        total_bytes:=tmp
                  
        ftime:=tmpftime
        StringF(logtmp,'YMODEM header (\d fields): \s', i, block+StrLen(block)+1)
        lprintf(xym,LOG_DEBUG,logtmp)
        StrCopy(fname,block)

        IF (file_bytes=0) THEN file_bytes:=$7fffffff
        file_bytes_left:=file_bytes
        IF (total_files=0) THEN total_files:=1
        IF (total_bytes<file_bytes) THEN total_bytes:=file_bytes

        StringF(logtmp,'Incoming filename: \s ',FilePart(fname))
        lprintf(xym,LOG_DEBUG,logtmp)

        StringF(str,'\s\s',download_dir,FilePart(fname))
        StringF(logtmp,'File size: \d bytes', file_bytes)
        lprintf(xym,LOG_INFO,logtmp)
        IF(total_files>1)
          StringF(logtmp,'Remaining: \d bytes in \d files', total_bytes, total_files)
          lprintf(xym,LOG_INFO,logtmp)
        ENDIF
      ENDIF
    ENDIF

    StringF(logtmp,'Receiving: \s ',str)
    lprintf(xym,LOG_DEBUG,logtmp)
    xym.current_file_size:=file_bytes

    fnum++

    IF dupe_check(xym,str)
      lprintf(xym,LOG_WARNING,'dupe check triggered')
      xmodem_cancel(xym)
      JUMP end
    ENDIF

    WHILE(fexist(str) AND ((xym.mode AND OVERWRITE)=FALSE))
      StringF(logtmp,'\s already exists',str)
      lprintf(xym,LOG_WARNING,logtmp)
      IF(xmodem_duplicate(xym, str)=FALSE)
        xmodem_cancel(xym)
        JUMP end
      ENDIF
    ENDWHILE
    
    fp:=doOpen(xym,str,MODE_NEWFILE)
    IF(fp=NIL)
      StringF(logtmp,'Error \d creating \s',IoErr(),str)
      lprintf(xym,LOG_ERR,logtmp)
      xmodem_cancel(xym)
      JUMP end
    ENDIF

    IF(xym.mode AND XMODEM)
      StringF(logtmp,'Receiving \s via \s \s'
        ,str
        ,IF xym.mode AND GMODE THEN 'XMODEM-g' ELSE 'XMODEM'
        ,IF xym.mode AND CRC THEN 'CRC-16' ELSE 'Checksum')
        
      lprintf(xym,LOG_INFO,logtmp)
    ELSE
      StringF(logtmp,'Receiving \s (\d KB) via \s \s'
        ,str
        ,Shr(file_bytes,10) AND $3ffffff
        ,IF xym.mode AND GMODE THEN 'YMODEM-g' ELSE 'YMODEM'
        ,IF xym.mode AND CRC THEN 'CRC-16' ELSE 'Checksum')
      lprintf(xym,LOG_INFO,logtmp)
    ENDIF
    
    t1,t2:=getXYmSystemTime()
    xym.transfer_start_time1:=t1
    xym.transfer_start_time2:=t2
    success:=FALSE

    AstrCopy(xym.current_file_name,FilePart(fname),MAX_PATH)
    xym.new_file:=TRUE
    xym.errors:=0
    block_num:=1
    pos:=0
    IF (i<>NOT_YMODEM) THEN xmodem_put_nak(xym, block_num)
    
    WHILE(is_connected(xym))
c1:
      xym.current_file_pos:=pos
      
      xmodem_progress(xym)
      xym.new_file:=FALSE
      
      IF(is_cancelled(xym)) 
        lprintf(xym,LOG_WARNING,'Cancelled locally')
        xmodem_cancel(xym)
        JUMP end
      ENDIF
      IF(i=NOT_YMODEM)
        i:=SUCCESS
      ELSE
        i:=xmodem_get_block(xym, block, block_num)
      ENDIF

      IF(i<>SUCCESS)
        IF(i=EOT)     /* end of transfer */
          success:=TRUE
          xmodem_put_ack(xym)
          JUMP rbr2
        ENDIF
        
        IF(i=CAN)   /* Cancel */
          xym.cancelled:=TRUE
          JUMP rbr2
        ENDIF
        
        xym.errors:=xym.errors+1
        IF(xym.mode AND GMODE)
          StringF(logtmp,'Too many errors (\d)',xym.errors)
          lprintf(xym,LOG_ERR,logtmp)
          JUMP end
        ENDIF

        IF(xym.errors>xym.max_errors) 
          StringF(logtmp,'Too many errors (\d)',xym.errors)
          lprintf(xym,LOG_ERR,logtmp)
          xmodem_cancel(xym)
          JUMP rbr2
        ENDIF
        
        IF((i<>NOT_XMODEM) AND (block_num=1) AND (xym.errors>(Div(xym.max_errors,3))) AND (xym.mode AND CRC) AND ((xym.mode AND GMODE)=FALSE)) 
          StringF(logtmp,'Falling back to 8-bit Checksum mode (error=\d)', i)
          lprintf(xym,LOG_NOTICE,logtmp)
          xym.mode:=xym.mode AND Not(CRC)
        ENDIF
        xmodem_put_nak(xym, block_num)
        JUMP c1
      ENDIF
      
      IF((xym.mode AND GMODE)=FALSE) 
        putcom(xym,ACK)
        xmodem_flush(xym)
      ENDIF
      
      IF(file_bytes_left<=0) /* No more bytes to receive */
        lprintf(xym,LOG_WARNING,'Sender attempted to send more bytes than were specified in header')
        JUMP rbr2
      ENDIF
      
      wr:=xym.block_size
      IF (wr>file_bytes_left) THEN wr:=file_bytes_left
        
      IF(doWrite(xym,fp,block,wr)<>wr)
        StringF(logtmp,'Error writing \d bytes to file at offset \d',wr,pos)
        lprintf(xym,LOG_ERR,logtmp)
        xmodem_cancel(xym)
        JUMP end
      ENDIF
      IF(bytes_received<>NIL) THEN bytes_received[]:=bytes_received[]+wr
      
      pos:=pos+wr
      file_bytes_left:=file_bytes_left-wr
      block_num++
    ENDWHILE
rbr2:

    /* Use correct file size */
    ->fflush(fp);

    StringF(logtmp,'file_bytes=\d', file_bytes)
    lprintf(xym,LOG_DEBUG,logtmp)
    StringF(logtmp,'file_bytes_left=\d', file_bytes_left)
    lprintf(xym,LOG_DEBUG,logtmp)
    StringF(logtmp,'filelength=\d', getFileSize(xym,fp))
    lprintf(xym,LOG_DEBUG,logtmp)

    IF(file_bytes < getFileSize(xym,fp))
      StringF(logtmp,'Truncating file to \d bytes', file_bytes)
      lprintf(xym,LOG_INFO,logtmp)
      ->chsize(fileno(fp),(ulong)file_bytes); /* 4GB limit! */
    ELSE
      file_bytes:=getFileSize(xym,fp)
    ENDIF
    doClose(xym,fp)
    fp:=NIL
  
    t1,t2:=getXYmSystemTime()
    t:=Mul((t1-xym.transfer_start_time1),50)+t2-xym.transfer_start_time2

    IF(t=0) THEN t:=1
    IF timetaken<>NIL THEN timetaken[]:=timetaken[]+t
    
    IF t>0
      IF file_bytes>40000000
        cps:=Div(file_bytes,Div(t,50)) 
      ELSE
        cps:=Div(Mul(file_bytes,50),t) 
      ENDIF
    ELSE
      cps:=file_bytes
    ENDIF

    IF(success)
      upload_completed(xym,str)
      StringF(logtmp,'Successful - Time: \d:\d  CPS: \d',Div(t,50),Mod(t,50),cps)
      lprintf(xym,LOG_INFO,logtmp)
      fcount++
    ELSE
      upload_failed(xym,str)
      StringF(logtmp,'File Transfer \s', IF xym.cancelled THEN 'Cancelled' ELSE 'Failure')
      lprintf(xym,LOG_ERR,logtmp)
    ENDIF

    ->IF(!(modexymODEM) && ftime) THEN setfdate(str,ftime);

    IF((success=FALSE) AND (file_bytes=0)) 
      IF (DeleteFile(str)=FALSE)
        StringF(logtmp,'Unable to remove empty file \s', str)
        lprintf(xym,LOG_ERR,logtmp)
      ENDIF
    ENDIF

    IF(xym.mode AND XMODEM) THEN JUMP end /* maximum of one file */

    total_files--
    total_bytes:=total_bytes-file_bytes
    
    IF((total_files>1) AND total_bytes)
      StringF(logtmp,'Remaining - Time: \d:\d  Files: \d  KBytes: \d'
        ,Div(Div(total_bytes,cps),50)
        ,Mod(Div(total_bytes,cps),50)
        ,total_files
        ,Shr(total_bytes,10) AND $3ffffff)
      lprintf(xym,LOG_INFO,logtmp)
    ENDIF
  ENDWHILE

end:
  IF(fp) THEN doClose(xym,fp)
ENDPROC fcount

EXPORT PROC xymodem_init(xym: PTR TO xymodem_t, cbdata: PTR TO CHAR,
        lputs,progress,recv_byte,is_connected,is_cancelled,
        data_waiting,upload_completed,upload_failed,dupecheck,
        flush,duplicate_filename,fileopen,fileclose,fileseek,
        fileread,filewrite,firstfile,nextfile,
        block_size,max_errors,iacEncode)
  
  ->Use sane default values
  xym.send_timeout:=10   -> seconds
  xym.recv_timeout:=10   -> seconds
  xym.byte_timeout:=3    -> seconds
  xym.ack_timeout:=10    -> seconds

  xym.iacEncode:=iacEncode

  xym.crc16tbl:={crc16tbl}


  IF block_size<>0 
    xym.block_size:=block_size
    xym.max_block_size:=block_size
  ELSE
    xym.block_size:=XMODEM_MAX_BLOCK_SIZE
    xym.max_block_size:=XMODEM_MAX_BLOCK_SIZE
  ENDIF

  IF max_errors<>0 THEN xym.max_errors:=max_errors ELSE xym.max_errors:=9
  xym.g_delay:=0

  xym.fallback_to_xmodem:=0

  xym.cbdata:=cbdata
  xym.zm_lputs:=lputs
  xym.zm_progress:=progress
  xym.zm_recv_byte:=recv_byte
  xym.zm_is_connected:=is_connected
  xym.zm_is_cancelled:=is_cancelled
  xym.zm_data_waiting:=data_waiting
  xym.zm_upload_completed:=upload_completed
  xym.zm_upload_failed:=upload_failed
  xym.zm_dupecheck:=dupecheck
  xym.zm_flush:=flush
  xym.zm_duplicate_filename:=duplicate_filename
  xym.zm_fopen:=fileopen
  xym.zm_fclose:=fileclose
  xym.zm_fseek:=fileseek
  xym.zm_fread:=fileread
  xym.zm_fwrite:=filewrite
  xym.zm_firstfile:=firstfile
  xym.zm_nextfile:=nextfile

  xym.g_mode_supported:=TRUE
  xym.crc_mode_supported:=TRUE

  xym.sendBufferSize:=(xym.max_block_size+512)*2
  xym.sendBuffer:=New(xym.sendBufferSize)
  xym.sendBufferPtr:=xym.sendBuffer
  xym.sendBufferEnd:=xym.sendBuffer+xym.sendBufferSize
ENDPROC

EXPORT PROC xymodem_cleanup(xym: PTR TO xymodem_t)
  Dispose(xym.sendBuffer)
ENDPROC

PROC getFileSize(xym,fp)
  DEF p
  p:=doSeek(xym,fp,0,OFFSET_END)
ENDPROC doSeek(xym,fp,p,OFFSET_BEGINING)

PROC doOpen(xym:PTR TO xymodem_t,fname,mode)
  DEF p
  p:=xym.zm_fopen
  IF p<>NIL
    RETURN p(fname,mode)
  ENDIF
  lprintf(xym,LOG_WARNING,'zm_fopen not set, defaulting to dos library Open')
ENDPROC Open(fname,mode)

PROC doClose(xym:PTR TO xymodem_t,fhandle)
  DEF p
  p:=xym.zm_fclose
  IF p<>NIL
    RETURN p(fhandle,xym.success)
  ENDIF
  lprintf(xym,LOG_WARNING,'zm_fclose not set, defaulting to dos library Close') 
ENDPROC Close(fhandle)

PROC doSeek(xym:PTR TO xymodem_t,fhandle,pos,origin)
  DEF p
  p:=xym.zm_fseek
  IF p<>NIL
    RETURN p(fhandle,pos,origin)
  ENDIF
  lprintf(xym,LOG_WARNING,'zm_fseek not set, defaulting to dos library Seek')
ENDPROC Seek(fhandle,pos,origin)

PROC doRead(xym:PTR TO xymodem_t,fhandle,buffer,length)
  DEF p
  p:=xym.zm_fread
  IF p<>NIL
    RETURN p(fhandle,buffer,length)
  ENDIF
  ->lprintf(xym,LOG_WARNING,'zm_fread not set, defaulting to dos library FRead')
ENDPROC Fread(fhandle,buffer,1,length)

PROC doWrite(xym:PTR TO xymodem_t,fhandle,buffer,length)
  DEF p
  p:=xym.zm_fwrite
  IF p<>NIL
    RETURN p(fhandle,buffer,length)
  ENDIF
  ->lprintf(xym,LOG_WARNING,'zm_fwrite not set, defaulting to dos library FWrite')
ENDPROC Fwrite(fhandle,buffer,1,length)

crc16tbl: INT $0000, $1021, $2042, $3063, $4084, $50A5, $60C6, $70E7,
  $8108, $9129, $A14A, $B16B, $C18C, $D1AD, $E1CE, $F1EF,
  $1231, $0210, $3273, $2252, $52B5, $4294, $72F7, $62D6,
  $9339, $8318, $B37B, $A35A, $D3BD, $C39C, $F3FF, $E3DE,
  $2462, $3443, $0420, $1401, $64E6, $74C7, $44A4, $5485,
  $A56A, $B54B, $8528, $9509, $E5EE, $F5CF, $C5AC, $D58D,
  $3653, $2672, $1611, $0630, $76D7, $66F6, $5695, $46B4,
  $B75B, $A77A, $9719, $8738, $F7DF, $E7FE, $D79D, $C7BC,
  $48C4, $58E5, $6886, $78A7, $0840, $1861, $2802, $3823,
  $C9CC, $D9ED, $E98E, $F9AF, $8948, $9969, $A90A, $B92B,
  $5AF5, $4AD4, $7AB7, $6A96, $1A71, $0A50, $3A33, $2A12,
  $DBFD, $CBDC, $FBBF, $EB9E, $9B79, $8B58, $BB3B, $AB1A,
  $6CA6, $7C87, $4CE4, $5CC5, $2C22, $3C03, $0C60, $1C41,
  $EDAE, $FD8F, $CDEC, $DDCD, $AD2A, $BD0B, $8D68, $9D49,
  $7E97, $6EB6, $5ED5, $4EF4, $3E13, $2E32, $1E51, $0E70,
  $FF9F, $EFBE, $DFDD, $CFFC, $BF1B, $AF3A, $9F59, $8F78,
  $9188, $81A9, $B1CA, $A1EB, $D10C, $C12D, $F14E, $E16F,
  $1080, $00A1, $30C2, $20E3, $5004, $4025, $7046, $6067,
  $83B9, $9398, $A3FB, $B3DA, $C33D, $D31C, $E37F, $F35E,
  $02B1, $1290, $22F3, $32D2, $4235, $5214, $6277, $7256,
  $B5EA, $A5CB, $95A8, $8589, $F56E, $E54F, $D52C, $C50D,
  $34E2, $24C3, $14A0, $0481, $7466, $6447, $5424, $4405,
  $A7DB, $B7FA, $8799, $97B8, $E75F, $F77E, $C71D, $D73C,
  $26D3, $36F2, $0691, $16B0, $6657, $7676, $4615, $5634,
  $D94C, $C96D, $F90E, $E92F, $99C8, $89E9, $B98A, $A9AB,
  $5844, $4865, $7806, $6827, $18C0, $08E1, $3882, $28A3,
  $CB7D, $DB5C, $EB3F, $FB1E, $8BF9, $9BD8, $ABBB, $BB9A,
  $4A75, $5A54, $6A37, $7A16, $0AF1, $1AD0, $2AB3, $3A92,
  $FD2E, $ED0F, $DD6C, $CD4D, $BDAA, $AD8B, $9DE8, $8DC9,
  $7C26, $6C07, $5C64, $4C45, $3CA2, $2C83, $1CE0, $0CC1,
  $EF1F, $FF3E, $CF5D, $DF7C, $AF9B, $BFBA, $8FD9, $9FF8,
  $6E17, $7E36, $4E55, $5E74, $2E93, $3EB2, $0ED1, $1EF0
