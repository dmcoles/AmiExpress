OPT LARGE,MODULE

 MODULE 'dos/dos','socket'

/*
way to update errors, error/resume position
*/

/* crc16.c */

/* CCITT 16-bit CRC table and calculation function */

/* $Id: crc16.c,v 1.7 2014/02/10 04:44:31 deuce Exp $ */

EXPORT CONST ZM_LOG_DEBUG=4
EXPORT CONST ZM_LOG_INFO=3
EXPORT CONST ZM_LOG_NOTICE=2
EXPORT CONST ZM_LOG_WARNING=1
EXPORT CONST ZM_LOG_ERR=0

CONST MAX_PATH=512

CONST NOINP=-1			/* input buffer empty (incom only) */
CONST TELNET_IAC=255

CONST RXSUBPACKETSIZE=8192
CONST TXSUBPACKETSIZE=8192

/****************************************************************************
 * @format.tab-size 4		(Plain Text/Source Code File Header)			*
 * @format.use-tabs true	(see http://www.synchro.net/ptsc_hdr.html)		*
 *																			*
 * Copyright 2007 Rob Swindell - http://www.synchro.net/copyright.html		*
 *																			*
 * This program is free software; you can redistribute it and/or			*
 * modify it under the terms of the GNU General Public License				*
 * as published by the Free Software Foundation; either version 2			*
 * of the License, or (at your option) any later version.					*
 * See the GNU General Public License for more details: gpl.txt or			*
 * http://www.fsf.org/copyleft/gpl.html										*
 *																			*
 * Anonymous FTP access to the most recent released source is available at	*
 * ftp://vert.synchro.net, ftp://cvs.synchro.net and ftp://ftp.synchro.net	*
 *																			*
 * Anonymous CVS access to the development source and modification history	*
 * is available at cvs.synchro.net:/cvsroot/sbbs, example:					*
 * cvs -d :pserver:anonymous@cvs.synchro.net:/cvsroot/sbbs login			*
 *     (just hit return, no password is necessary)							*
 * cvs -d :pserver:anonymous@cvs.synchro.net:/cvsroot/sbbs checkout src		*
 *																			*
 * For Synchronet coding style and modification guidelines, see				*
 * http://www.synchro.net/source.html										*
 *																			*
 * You are encouraged to submit any modifications (preferably in Unix diff	*
 * format) via e-mail to mods@synchro.net									*
 *																			*
 * Note: If this box doesn't appear square, then you need to fix your tabs.	*
 ****************************************************************************/

PROC strcopy(dest: PTR TO CHAR,src: PTR TO CHAR,len=-1)
  DEF i,c
  i:=0
  REPEAT
    dest[i]:=(c:=src[i])
    i++
  UNTIL (i=len) OR (c=0)
ENDPROC

PROC fexist(file)
  DEF lh
  IF lh:=Lock(file,ACCESS_READ)
    UnLock(lh)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

PROC flength(file)
  DEF fBlock: fileinfoblock
  DEF fLock
  DEF fsize=8192

  IF((fLock:=Lock(file,ACCESS_READ)))=NIL
    RETURN 8192
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN 8192
  ENDIF
  IF(Examine(fLock,fBlock)) THEN fsize:=fBlock.size
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC fsize

->todo proper disk space check
PROC getFreeDiskSpace() IS 300000000

EXPORT PROC getZmSystemTime()
  DEF currDate: datestamp 
  DateStamp(currDate)
ENDPROC Mul(Mul(currDate.days,1440),60)+(currDate.minute*60)+(currDate.tick/50),Mod(currDate.tick,50)

PROC getFileSize(zm,fp)
  DEF p
  p:=doSeek(zm,fp,0,OFFSET_END)
ENDPROC doSeek(zm,fp,p,OFFSET_BEGINING)


/* zmodem.c */

/* Synchronet ZMODEM Functions */

/* $Id: zmodem.c,v 1.122 2018/02/20 11:44:53 rswindell Exp $ */

/******************************************************************************/
/* Project : Unite!       File : zmodem general        Version : 1.02         */
/*                                                                            */
/* (C) Mattheij Computer Service 1994                                         */
/*
 *	Date: Thu, 19 Nov 2015 10:10:02 +0100
 *	From: Jacques Mattheij
 *	Subject: Re: zmodem license
 *	To: Stephen Hurd, Fernando Toledo
 *	CC: Rob Swindell
 *
 *	Hello there to all of you,
 *
 *	So, this email will then signify as the transfer of any and all rights I
 *	held up to this point with relation to the copyright of the zmodem
 *	package as released by me many years ago and all associated files to
 *	Stephen Hurd. Fernando Toledo and Rob Swindell are named as
 *	witnesses to this transfer.
 *
 *	...
 *
 *	best regards,
 *
 *	Jacques Mattheij
 ******************************************************************************/

/*
 * zmodem primitives and other code common to zmtx and zmrx
 */

 /*
 * zmodem.h
 * zmodem constants
 * (C) Mattheij Computer Service 1994
 *
 *	Date: Thu, 19 Nov 2015 10:10:02 +0100
 *	From: Jacques Mattheij
 *	Subject: Re: zmodem license
 *	To: Stephen Hurd, Fernando Toledo
 *	CC: Rob Swindell
 *
 *	Hello there to all of you,
 *
 *	So, this email will then signify as the transfer of any and all rights I
 *	held up to this point with relation to the copyright of the zmodem
 *	package as released by me many years ago and all associated files to
 *	Stephen Hurd. Fernando Toledo and Rob Swindell are named as
 *	witnesses to this transfer.
 *
 *	...
 *
 *	best regards,
 *
 *	Jacques Mattheij
 */

/* $Id: zmodem.h,v 1.55 2018/02/01 08:20:19 deuce Exp $ */


 CONST	SOH=$01
 CONST	STX=$02
 CONST	EOT=$04
 CONST	ENQ=$05
 CONST	ACK=$06
 CONST	LF=$0a
 CONST	CR=$0d
 CONST  DLE=$10
 CONST	XON=$11
 CONST	XOFF=$13
 CONST	XONOR80=$91
 CONST	XOFFOR80=$93
 CONST	NAK=$15
 CONST	CAN=$18

/*
 * zmodem constants
 */

CONST ZBLOCKLEN=1024		/* "true" Zmodem max subpacket length */

CONST ZMAXHLEN=$10		/* maximum header information length */
CONST ZMAXSPLEN=$400		/* maximum subpacket length */


CONST	ZPAD=$2a		/* pad character; begins frames */
CONST	ZDLE=$18		/* ctrl-x zmodem escape */
CONST	ZDLEE=$58		/* escaped ZDLE */	

CONST	ZBIN=$41		/* binary frame indicator (CRC16) */
CONST	ZHEX=$42		/* hex frame indicator */
CONST	ZBIN32=$43		/* binary frame indicator (CRC32) */
CONST	ZBINR32=$44		/* run length encoded binary frame (CRC32) */

CONST	ZVBIN=$61		/* binary frame indicator (CRC16) */
CONST	ZVHEX=$62		/* hex frame indicator */
CONST	ZVBIN32=$63		/* binary frame indicator (CRC32) */
CONST	ZVBINR32=$64		/* run length encoded binary frame (CRC32) */

CONST	ZRESC=$7e		/* run length encoding flag / escape character */

/*
 * zmodem frame types
 */

CONST	ZRQINIT=$00		/* request receive init (s->r) */
CONST	ZRINIT=$01		/* receive init (r->s) */
CONST	ZSINIT=$02		/* send init sequence (optional) (s->r) */
CONST	ZACK=$03		/* ack to ZRQINIT ZRINIT or ZSINIT (s<->r) */
CONST	ZFILE=$04		/* file name (s->r) */
CONST	ZSKIP=$05		/* skip this file (r->s) */
CONST	ZNAK=$06		/* last packet was corrupted (?) */
CONST	ZABORT=$07		/* abort batch transfers (?) */
CONST	ZFIN=$08		/* finish session (s<->r) */
CONST	ZRPOS=$09		/* resume data transmission here (r->s) */
CONST	ZDATA=$0a		/* data packet(s) follow (s->r) */
CONST	ZEOF=$0b		/* end of file reached (s->r) */
CONST	ZFERR=$0c		/* fatal read or write error detected (?) */
CONST	ZCRC=$0d		/* request for file CRC and response (?) */
CONST	ZCHALLENGE=$0e		/* security challenge (r->s) */
CONST	ZCOMPL=$0f		/* request is complete (?) */	
CONST	ZCAN=$10		/* pseudo frame; 
								   other end cancelled session with 5* CAN */
CONST	ZFREECNT=$11		/* request free bytes on file system (s->r) */
CONST	ZCOMMAND=$12		/* issue command (s->r) */
CONST	ZSTDERR=$13		/* output data to stderr (??) */

/*
 * ZDLE sequences
 */

CONST	ZCRCE=$68		/* CRC next, frame ends, header packet follows */
CONST	ZCRCG=$69		/* CRC next, frame continues nonstop */
CONST	ZCRCQ=$6a		/* CRC next, frame continuous, ZACK expected */
CONST	ZCRCW=$6b		/* CRC next, frame ends,       ZACK expected */
CONST	ZRUB0=$6c		/* translate to rubout $7f */
CONST	ZRUB1=$6d		/* translate to rubout $ff */

/*
 * frame specific data.
 * entries are prefixed with their location in the header array.
 */

/*
 * Byte positions within header array
 */

CONST FTYPE=0					/* frame type */

CONST ZF0=4					/* First flags byte */
CONST ZF1=3
CONST ZF2=2
CONST ZF3=1

CONST ZP0=1					/* Low order 8 bits of position */
CONST ZP1=2
CONST ZP2=3
CONST ZP3=4					/* High order 8 bits of file position */

/*
 * ZRINIT frame
 * zmodem receiver capability flags
 */

CONST	ZF0_CANFDX=$01	/* Receiver can send and receive true full duplex */
CONST	ZF0_CANOVIO=$02	/* receiver can receive data during disk I/O */
CONST	ZF0_CANBRK=$04	/* receiver can send a break signal */
CONST	ZF0_CANCRY=$08	/* Receiver can decrypt DONT USE */
CONST	ZF0_CANLZW=$10	/* Receiver can uncompress DONT USE */
CONST	ZF0_CANFC32=$20	/* Receiver can use 32 bit Frame Check */
CONST	ZF0_ESCCTL=$40	/* Receiver expects ctl chars to be escaped */
CONST	ZF0_ESC8=$80	/* Receiver expects 8th bit to be escaped */

CONST ZF1_CANVHDR=$01	/* Variable headers OK */

/*
 * ZSINIT frame
 * zmodem sender capability
 */

CONST ZF0_TESCCTL=$40	/* Transmitter expects ctl chars to be escaped */
CONST ZF0_TESC8=$80	/* Transmitter expects 8th bit to be escaped */

CONST ZATTNLEN=$20	/* Max length of attention string */
CONST ALTCOFF=ZF1		/* Offset to alternate canit string, 0 if not used */

/*
 * ZFILE frame
 */

/*
 * Conversion options one of these in ZF0
 */

CONST ZF0_ZCBIN=1		/* Binary transfer - inhibit conversion */
CONST ZF0_ZCNL=2		/* Convert NL to local end of line convention */
CONST ZF0_ZCRESUM=3		/* Resume interrupted file transfer */

/*
 * Management include options, one of these ored in ZF1
 */

CONST ZF1_ZMSKNOLOC=$80	/* Skip file if not present at rx */
CONST ZF1_ZMMASK=$1f	/* Mask for the choices below */
CONST ZF1_ZMNEWL=1		/* Transfer if source newer or longer */
CONST ZF1_ZMCRC=2		/* Transfer if different file CRC or length */
CONST ZF1_ZMAPND=3		/* Append contents to existing file (if any) */
CONST ZF1_ZMCLOB=4		/* Replace existing file */
CONST ZF1_ZMNEW=5		/* Transfer if source newer */
CONST ZF1_ZMDIFF=6		/* Transfer if dates or lengths different */
CONST ZF1_ZMPROT=7		/* Protect destination file */
CONST ZF1_ZMCHNG=8		/* Change filename if destination exists */

/*
 * Transport options, one of these in ZF2
 */

CONST ZF2_ZTNOR=0		/* no compression */
CONST ZF2_ZTLZW=1		/* Lempel-Ziv compression */
CONST ZF2_ZTRLE=3		/* Run Length encoding */

/*
 * Extended options for ZF3, bit encoded
 */

CONST ZF3_ZCANVHDR=$01	/* Variable headers OK */
								/* Receiver window size override */
CONST ZF3_ZRWOVR=$04	/* byte position for receive window override/256 */
CONST ZF3_ZXSPARS=$40	/* encoding for sparse file operations */

/*
 * ZCOMMAND frame
 */

CONST ZF0_ZCACK1=$01	/* Acknowledge, then do command */


 CONST ENDOFFRAME=2
 CONST FRAMEOK=1
 CONST TIMEOUT=-1	/* rx routine did not receive a character within timeout */
 CONST INVHDR=-2	/* invalid header received; but within timeout */
 CONST ABORTED=-3	/* Aborted *or* disconnected */
 CONST SUBPKTOVERFLOW=-4	/* Subpacket received more than block length */
 CONST CRCFAILED=-5	/* Failed CRC comparison */
 CONST INVALIDSUBPKT=-6	/* Invalid Subpacket Type */
 CONST ZDLEESC=$8000	/*  one of ZCRCE; ZCRCG; ZCRCQ or ZCRCW was received; ZDLE escaped */
 CONST BADSUBPKT=$80
 CONST HDRLEN=5	/* size of a zmodem header */

EXPORT OBJECT zmodem_t

	rxd_header[ZMAXHLEN]:ARRAY OF CHAR							/* last received header */
	rxd_header_len:INT									/* last received header size */
	rxd_header_pos:LONG									/* last received header position value */

	/*
	 * receiver capability flags
	 * extracted from the ZRINIT frame as received
	 */

	can_full_duplex:CHAR
	can_overlap_io:CHAR
	can_break:CHAR
	can_fcs_32:CHAR
	want_fcs_16:CHAR
	escape_ctrl_chars:CHAR	
	escape_8th_bit:CHAR

  iacEncode:CHAR

	/*
	 * file management options.
	 * only one should be on
	 */

	management_newer:INT
	management_clobber:INT
	management_protect:INT

	/* from zmtx.c */

	tx_data_subpacket:PTR TO CHAR ->[TXSUBPACKETSIZE]:ARRAY OF CHAR
	rx_data_subpacket:PTR TO CHAR ->[RXSUBPACKETSIZE]:ARRAY OF CHAR							/* zzap = 8192 */

  sendBuffer:PTR TO CHAR
  sendBufferSize
  sendBufferPtr:PTR TO CHAR
  sendBufferEnd

  crc16tbl:PTR TO INT
  crc32tbl:PTR TO LONG

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
	current_file_size:LONG
	current_file_pos:LONG
	current_file_time:LONG
	current_file_num:LONG
	total_files:LONG
	total_bytes:LONG
	files_remaining:LONG
	bytes_remaining:LONG
	transfer_start_pos:LONG
	transfer_start_time1:LONG
	transfer_start_time2:INT
  new_file:INT 
	receive_32bit_data:INT
	use_crc16:INT
	ack_file_pos:LONG				/* file position used in acknowledgement of correctly */
										/* received data subpackets */

	last_sent:INT

	n_cans:INT

	/* Stuff added by RRS */

	/* Status */
	cancelled:CHAR
	local_abort:CHAR
	file_skipped:CHAR
  send_successful:CHAR
	no_streaming:CHAR
	frame_in_transit:CHAR
	recv_bufsize:LONG	/* Receiver specified buffer size */
	crc_request:LONG
	errors:LONG
	consecutive_errors:LONG

	/* Configuration */
	escape_telnet_iac:CHAR
	init_timeout:LONG
	send_timeout:LONG
	recv_timeout:LONG
	crc_timeout:LONG
	max_errors:LONG
	block_size:LONG
	max_block_size:LONG
	max_file_size:LONG		/* 0 = unlimited */
	log_level:PTR TO INT

  user_data:LONG
	/* Callbacks */
	/* error C2520: conversion from unsigned __int64 to double not implemented, use signed __int64 */
  cbdata: PTR TO CHAR
	->int			(*lputs)(void*, int level, const char* str)
	->int			(*send_byte)(void*, BYTE ch, unsigned timeout /* seconds */)
	->int			(*recv_byte)(void*, unsigned timeout /* seconds */)
	->void		(*progress)(void*, int64_t current_pos)
	->BOOL		(*is_connected)(void*)
	->BOOL		(*is_cancelled)(void*)
	->BOOL		(*data_waiting)(void*, unsigned timeout /* seconds */)
	->BOOL		(*duplicate_filename)(void*, void *zm)
	->void		(*flush)(void*)
ENDOBJECT

->PROC ucrc16(zm:PTR TO zmodem_t,ch,crc) IS Eor(zm.crc16tbl[Eor(Shr(crc,8) AND $ff,ch)],Shl(crc,8)) AND $ffff
#define ucrc16(ch,crc) Eor(zm.crc16tbl[Eor(Shr(crc,8) AND $ff,ch)],Shl(crc,8)) AND $ffff

->PROC ucrc32(zm:PTR TO zmodem_t,ch,crc) IS Eor(zm.crc32tbl[(Eor(crc,ch)) AND 255],Shr(crc,8) AND $ffffff)
#define ucrc32(ch,crc) Eor(zm.crc32tbl[(Eor(crc,ch)) AND 255],Shr(crc,8) AND $ffffff)

EXPORT PROC crc32str(str:PTR TO CHAR,len)
  DEF crctbl:PTR TO LONG
  DEF crc,i,ch
  DEF tstr[255]:STRING
  StrCopy(tstr,str,len)
  crctbl:={crc32tbl}
  crc:=-1
  FOR i:=0 TO len-1
    ch:=str[i]
    crc:=Eor(crctbl[(Eor(crc,ch)) AND 255],Shr(crc,8) AND $ffffff)
  ENDFOR
ENDPROC  crc

PROC fcrc32(zm:PTR TO zmodem_t,fp,  len)
	DEF crc=$ffffffff
	DEF rl
  DEF i,n,n2: PTR TO CHAR

  doSeek(zm,fp,0,OFFSET_BEGINNING)
  n:=New(32768)
  IF n=0 THEN RETURN $ffffffff
  
  REPEAT
    rl:=doRead(zm,fp,n,IF len>32768 THEN 32768 ELSE len)
    n2:=n
    FOR i:=1 TO rl
      crc:=ucrc32(n2[]++,crc)
    ENDFOR
    len:=len-rl
	UNTIL (rl=0) OR (len=0)
  Dispose(n)
ENDPROC Not(crc)


PROC lprintf(zm:PTR TO zmodem_t, level, str:PTR TO CHAR)
  DEF p
	IF(zm.zm_lputs=NIL) THEN RETURN -1

	IF(zm.log_level<>NIL)
		IF(level > zm.log_level) THEN RETURN 0
  ENDIF
  p:=zm.zm_lputs
ENDPROC p(level,str)

PROC is_connected(zm: PTR TO zmodem_t)
  DEF p
  p:=zm.zm_is_connected
	IF(p<>NIL) THEN RETURN p()
ENDPROC TRUE

PROC is_cancelled(zm: PTR TO zmodem_t)
  DEF p
  IF zm.cancelled THEN RETURN TRUE
  
  p:=zm.zm_is_cancelled
	IF(p<>NIL) 
    zm.cancelled:=zm.cancelled OR p()
    RETURN zm.cancelled
  ENDIF
ENDPROC FALSE

PROC upload_completed(zm:PTR TO zmodem_t,fname:PTR TO CHAR,filebytes)
  DEF p
  p:=zm.zm_upload_completed
  IF (p<>NIL) THEN p(fname,filebytes)
ENDPROC

PROC upload_failed(zm:PTR TO zmodem_t,fname:PTR TO CHAR)
  DEF p
  p:=zm.zm_upload_failed
  IF (p<>NIL) THEN p(fname)
ENDPROC

PROC dupe_check(zm:PTR TO zmodem_t,fname)
  DEF res=FALSE
  DEF p
  p:=zm.zm_dupecheck
  IF (p<>NIL) THEN res:=p(fname)
ENDPROC res

PROC zmodem_data_waiting(zm: PTR TO zmodem_t,timeout)
  DEF p
  
  p:=zm.zm_data_waiting
  IF(p<>NIL) THEN RETURN p(timeout)
ENDPROC FALSE

PROC chr(ch,output)

  SELECT ch
    CASE TIMEOUT
      StrCopy(output,'TIMEOUT')
      RETURN
		CASE ABORTED
      StrCopy(output,'ABORTED')
      RETURN
		CASE SUBPKTOVERFLOW
      StrCopy(output,'Subpacket Overflow')
      RETURN
		CASE CRCFAILED
      StrCopy(output,'CRC Failure')
      RETURN
		CASE INVALIDSUBPKT
      StrCopy(output,'Invalid Subpacket')
      RETURN
		CASE ZRQINIT
      StrCopy(output,'ZRQINIT')
      RETURN
		CASE ZRINIT
      StrCopy(output,'ZRINIT')
      RETURN
		CASE ZSINIT
      StrCopy(output,'ZSINIT')
      RETURN
		CASE ZACK
      StrCopy(output,'ZACK')
      RETURN
		CASE ZFILE
      StrCopy(output,'ZFILE')
      RETURN
		CASE ZSKIP
      StrCopy(output,'ZSKIP')
      RETURN
		CASE ZCRC
      StrCopy(output,'ZCRC')
      RETURN
		CASE ZNAK
      StrCopy(output,'ZNAK')
      RETURN
		CASE ZABORT
      StrCopy(output,'ZABORT')
      RETURN
		CASE ZFIN
      StrCopy(output,'ZFIN')
      RETURN
		CASE ZRPOS
      StrCopy(output,'ZRPOS')
      RETURN
		CASE ZDATA
      StrCopy(output,'ZDATA')
      RETURN
		CASE ZEOF
      StrCopy(output,'ZEOF')
      RETURN
		CASE ZFERR
      StrCopy(output,'ZFERR')
      RETURN
		CASE ZPAD
      StrCopy(output,'ZPAD')
      RETURN
		CASE ZCAN
      StrCopy(output,'ZCAN')
      RETURN
		CASE ZDLE
      StrCopy(output,'ZDLE')
      RETURN
		CASE ZDLEE
      StrCopy(output,'ZDLEE')
      RETURN
		CASE ZBIN
      StrCopy(output,'ZBIN')
      RETURN
		CASE ZHEX
      StrCopy(output,'ZHEX')
      RETURN
		CASE ZBIN32
      StrCopy(output,'ZBIN32')
      RETURN
		CASE ZRESC
      StrCopy(output,'ZRESC')
      RETURN
		CASE ZCRCE
      StrCopy(output,'ZCRCE')
      RETURN
		CASE ZCRCG
      StrCopy(output,'ZCRCG')
      RETURN
		CASE ZCRCQ
      StrCopy(output,'ZCRCQ')
      RETURN
		CASE ZCRCW
      StrCopy(output,'ZCRCW')
      RETURN
	ENDSELECT
	IF(ch<0)
		StringF(output,'\d',ch)
	ELSEIF((ch>=" ") AND (ch<="~"))
		StringF(output,'''\c'' (\h[2])',ch,ch)
	ELSE
		StringF(output,'\d (\h[2])',ch,ch)
  ENDIF
ENDPROC

PROC frame_desc(frame,output)
	DEF str[25]:STRING
  DEF tmp

	IF(frame=TIMEOUT)
    StrCopy(output,'TIMEOUT')
    RETURN
  ENDIF

	IF(frame=INVHDR)
    StrCopy(output,'Invalid Header')
    RETURN
  ENDIF

	IF(frame=ABORTED)
    StrCopy(output,'Aborted')
    RETURN
  ENDIF


	IF(frame>=0)
    IF (frame AND BADSUBPKT) THEN StrCopy(str,'BAD ')
    tmp:=frame AND (Not(BADSUBPKT))
		SELECT tmp 
			CASE ZRQINIT
        StrAdd(str,'ZRQINIT')
			CASE ZRINIT
        StrAdd(str,'ZRINIT')
			CASE ZSINIT
        StrAdd(str,'ZSINIT')
			CASE ZACK
        StrAdd(str,'ZACK')
			CASE ZFILE
        StrAdd(str,'ZFILE')
			CASE ZSKIP
        StrAdd(str,'ZSKIP')
			CASE ZNAK
        StrAdd(str,'ZNAK')
			CASE ZABORT
        StrAdd(str,'ZABORT')
			CASE ZFIN
        StrAdd(str,'ZFIN')
			CASE ZRPOS
        StrAdd(str,'ZRPOS')
			CASE ZDATA
        StrAdd(str,'ZDATA')
			CASE ZEOF
        StrAdd(str,'ZEOF')
			CASE ZFERR
        StrAdd(str,'ZFERR')
			CASE ZCRC
        StrAdd(str,'ZCRC')
			CASE ZCHALLENGE
        StrAdd(str,'ZCHALLENGE')
			CASE ZCOMPL
        StrAdd(str,'ZCOMPL')
			CASE ZCAN
        StrAdd(str,'ZCAN')
			CASE ZFREECNT
        StrAdd(str,'ZFREECNT')
			CASE ZCOMMAND
        StrAdd(str,'ZCOMMAND')
			CASE ZSTDERR
        StrAdd(str,'ZSTDERR')
			DEFAULT 
				StringF(str,'Unknown (\h[8])', frame)
		ENDSELECT
	ELSE
    chr(frame,str)
  ENDIF
  StrCopy(output,str)
 ENDPROC

/*PROC frame_pos(zm: PTR TO zmodem_t,type)
	IF (type=ZRPOS) OR (type=ZACK) OR (type=ZEOF) OR (type=ZDATA) THEN RETURN zm.rxd_header_pos
ENDPROC 0*/

/*
 * read bytes as long as rdchk indicates that
 * more data is available.
 */

PROC zmodem_recv_purge(zm: PTR TO zmodem_t)
  DEF p
  p:=zm.zm_recv_byte
	WHILE p(0)>=0
  ENDWHILE
ENDPROC

/* 
 * Flush the output buffer
 */
EXPORT PROC zmodem_flush(zm: PTR TO zmodem_t)
  DEF p
  p:=zm.zm_flush
  IF (zm.sendBufferPtr>zm.sendBuffer)
    IF(p<>NIL) THEN p(zm.sendBuffer,zm.sendBufferPtr-zm.sendBuffer)
    zm.sendBufferPtr:=zm.sendBuffer
  ENDIF
ENDPROC

/* 
 * transmit a character. 
 * this is the raw modem interface
 */
EXPORT PROC zmodem_send_raw(zm: PTR TO zmodem_t,ch)

  IF (zm.iacEncode AND (ch=255))
    IF zm.sendBufferPtr>=(zm.sendBufferEnd-2) THEN zmodem_flush(zm)
    zm.sendBufferPtr[]:=ch
    zm.sendBufferPtr:=zm.sendBufferPtr+1
    zm.sendBufferPtr[]:=ch
    zm.sendBufferPtr:=zm.sendBufferPtr+1
    IF zm.sendBufferPtr=zm.sendBufferEnd THEN zmodem_flush(zm)
  ELSE
    zm.sendBufferPtr[]:=ch
    zm.sendBufferPtr:=zm.sendBufferPtr+1
    IF zm.sendBufferPtr=zm.sendBufferEnd THEN zmodem_flush(zm)
  ENDIF
	zm.last_sent:=ch

ENDPROC

/*
 * transmit a character ZDLE escaped
 */

PROC zmodem_send_esc(zm: PTR TO zmodem_t,c)
  zmodem_send_raw(zm, ZDLE)
	/*
	 * exclusive or; not an or so ZDLE becomes ZDLEE
	 */
  zmodem_send_raw(zm,Eor(c,64))
ENDPROC 


/*
 * transmit a character; ZDLE escaping if appropriate
 */

PROC zmodem_tx(zm:PTR TO zmodem_t,c)
  IF (c=DLE) OR (c=(DLE+128)) OR (c=XON) OR (c=(XON+128)) OR (c=XOFF) OR (c=(XOFF+128)) OR (c=ZDLE)
		RETURN zmodem_send_esc(zm, c)
  ELSEIF (c=CR) OR (c=(CR+128))
		IF(zm.escape_ctrl_chars AND ((zm.last_sent AND 127) ="@")) THEN RETURN zmodem_send_esc(zm, c)
  ELSEIF (c=TELNET_IAC)
		IF(zm.escape_telnet_iac) 
      zmodem_send_raw(zm, ZDLE)
			RETURN zmodem_send_raw(zm, ZRUB1)
		ENDIF
	ELSE
		IF((zm.escape_ctrl_chars<>0) AND ((c AND 96)=0)) THEN RETURN zmodem_send_esc(zm, c)
	ENDIF
	/*
	 * anything that ends here is so normal we might as well transmit it.
	 */
ENDPROC zmodem_send_raw(zm,c)


/**********************************************/
/* Output single byte as two hex ASCII digits */
/**********************************************/
PROC zmodem_send_hex(zm:PTR TO zmodem_t,val)
  DEF xdigit[16]:STRING
  ->DEF tempstr[255]:STRING
  StrCopy(xdigit,'0123456789abcdef')

  ->StringF(tempstr,'send_hex: \d \h[2] ',val,val)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr)

  zmodem_send_raw(zm, xdigit[Shr(val,4)])
ENDPROC zmodem_send_raw(zm, xdigit[val AND 15])

PROC zmodem_send_padded_zdle(zm: PTR TO zmodem_t)
	
  zmodem_send_raw(zm, ZPAD)
  zmodem_send_raw(zm, ZPAD)
ENDPROC zmodem_send_raw(zm, ZDLE)

/* 
 * transmit a hex header.
 * these routines use tx_raw because we're sure that all the
 * characters are not to be escaped.
 */
PROC zmodem_send_hex_header(zm:PTR TO zmodem_t, p: PTR TO CHAR)
  DEF i
  DEF type
	DEF crc
  ->DEF tempstr[255]:STRING
  ->DEF tempstr2[255]:STRING

  type:=p[]
  ->chr(type,tempstr)
  ->StringF(tempstr2,'send_hex_header: \s', tempstr)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr2)

  zmodem_send_padded_zdle(zm)
  zmodem_send_raw(zm, ZHEX)

	/*
 	 * initialise the crc
	 */

	crc:=0

	/*
 	 * transmit the header
	 */

	FOR i:=0 TO HDRLEN-1
    zmodem_send_hex(zm, p[])
		crc:=ucrc16(p[], crc)
		p++
	ENDFOR

	/*
 	 * update the crc as though it were zero
	 */

	/* 
	 * transmit the crc
	 */

  zmodem_send_hex(zm,(Shr(crc,8)))

  zmodem_send_hex(zm,(crc AND 255))

	/*
	 * end of line sequence
	 */

  zmodem_send_raw(zm, "\b")

	zmodem_send_raw(zm, "\n")	/* FDSZ sends 0x8a instead of 0x0a */

	IF((type<>ZACK) AND (type<>ZFIN)) THEN zmodem_send_raw(zm, XON)

	zmodem_flush(zm)

ENDPROC

/*
 * Send ZMODEM binary header hdr
 */

PROC zmodem_send_bin32_header(zm:PTR TO zmodem_t, p: PTR TO CHAR)
	DEF i
	DEF crc
  ->DEF tempstr[255]:STRING
  ->DEF tempstr2[255]:STRING
  DEF pp

  ->chr(p[],tempstr)
  ->StringF(tempstr2,'"send_bin32_header: \s',tempstr)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr2)

  zmodem_send_padded_zdle(zm)
  zmodem_send_raw(zm, ZBIN32)

	crc:=-1

	FOR i:=0 TO HDRLEN-1
    pp:=p[]
    p++
		crc:=ucrc32(pp,crc)
    zmodem_tx(zm, pp)
	ENDFOR

	crc:= Not(crc)

  zmodem_tx(zm,((crc) AND $ff))
  zmodem_tx(zm,((Shr(crc,8)) AND $ff))

  zmodem_tx(zm,((Shr(crc,16)) AND $ff))
ENDPROC zmodem_tx(zm,((Shr(crc,24)) AND $ff))

PROC zmodem_send_bin16_header(zm:PTR TO zmodem_t, p: PTR TO CHAR)
	DEF i
	DEF crc
  ->DEF tempstr[255]:STRING
  ->DEF tempstr2[255]:STRING
  DEF tmp

  ->chr(p[],tempstr)
  ->StringF(tempstr2,'send_bin16_header: \s',tempstr)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr2)

  zmodem_send_padded_zdle(zm)

  zmodem_send_raw(zm, ZBIN)

	crc:=0

	FOR i:=0 TO HDRLEN-1
		crc:=ucrc16(p[],crc)
    tmp:=p[]
    p++
    zmodem_tx(zm,tmp)
	ENDFOR

  zmodem_tx(zm,(Shr(crc,8)))
ENDPROC zmodem_tx(zm, (crc AND $ff))



/* 
 * transmit a header using either hex 16 bit crc or binary 32 bit crc
 * depending on the receivers capabilities
 * we dont bother with variable length headers. I dont really see their
 * advantage and they would clutter the code unneccesarily
 */

PROC zmodem_send_bin_header(zm: PTR TO zmodem_t, p: PTR TO CHAR)
	IF((zm.can_fcs_32<>0) AND (zm.want_fcs_16=0)) THEN RETURN zmodem_send_bin32_header(zm, p)
ENDPROC	zmodem_send_bin16_header(zm, p)

/*
 * data subpacket transmission
 */

PROC zmodem_send_data32(zm: PTR TO zmodem_t, subpkt_type, p: PTR TO CHAR, l)

	DEF crc
  ->DEF tempstr[255]:STRING
  ->DEF tempstr2[255]:STRING

  ->chr(subpkt_type,tempstr)
  ->StringF(tempstr2,'send_data32: \s (\d bytes)', tempstr,l)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr2)

	crc:=$ffffffff

	WHILE((l--) >=0)
		crc:=ucrc32(p[],crc)
    zmodem_tx(zm, p[]++)
	ENDWHILE

	crc:=ucrc32(subpkt_type, crc)

  zmodem_send_raw(zm, ZDLE)
  zmodem_send_raw(zm, subpkt_type)

	crc:=Not(crc)

  zmodem_tx(zm, ((crc) AND $ff))
  zmodem_tx(zm, ((Shr(crc,8)) AND $ff))
  zmodem_tx(zm, ((Shr(crc,16)) AND $ff))
ENDPROC	zmodem_tx(zm, ((Shr(crc,24)) AND $ff))

PROC zmodem_send_data16(zm: PTR TO zmodem_t, subpkt_type,p: PTR TO CHAR, l)

	DEF crc
  ->DEF tempstr[255]:STRING
  ->DEF tempstr2[255]:STRING
  ->DEF tmp

  ->chr(subpkt_type,tempstr)
  ->StringF(tempstr2,'send_data16: \s (\d bytes)', tempstr,l)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr2)

	crc:=0

	WHILE((l--) >= 0)
		crc:=ucrc16(p[],crc)
    zmodem_tx(zm, p[]++)
	ENDWHILE

	crc:=ucrc16(subpkt_type,crc)

  zmodem_send_raw(zm, ZDLE)
  zmodem_send_raw(zm, subpkt_type)

	zmodem_tx(zm, (Shr(crc,8)))
ENDPROC zmodem_tx(zm, (crc AND $ff))


/*
 * send a data subpacket using crc 16 or crc 32 as desired by the receiver
 */

PROC zmodem_send_data_subpkt(zm: PTR TO zmodem_t, subpkt_type, p: PTR TO CHAR, l)

	IF((subpkt_type = ZCRCW) OR (subpkt_type = ZCRCE))	/* subpacket indicating 'end-of-frame' */
		zm.frame_in_transit:=FALSE
	ELSE	/* other subpacket (mid-frame) */
		zm.frame_in_transit:=TRUE
  ENDIF

	IF((zm.want_fcs_16=0) AND (zm.can_fcs_32<>0))
    zmodem_send_data32(zm, subpkt_type,p,l)
	ELSE
    zmodem_send_data16(zm, subpkt_type,p,l)
	ENDIF

	IF(subpkt_type = ZCRCW) THEN zmodem_send_raw(zm, XON)
	IF (subpkt_type <> ZCRCG) OR (p=NIL) OR (zm.can_overlap_io=FALSE) OR zm.no_streaming
    zmodem_flush(zm)
  ENDIF
ENDPROC

PROC zmodem_send_data(zm: PTR TO zmodem_t, subpkt_type, p: PTR TO CHAR, l)
  ->DEF tempstr[255]:STRING

	IF(zm.frame_in_transit)=0	 /* Start of frame, include ZDATA header */
    ->StringF(tempstr,'send_data: start of frame, offset \d',zm.current_file_pos)
		->lprintf(zm,ZM_LOG_DEBUG,tempstr)
		zmodem_send_pos_header(zm, ZDATA, zm.current_file_pos, /* Hex? */ FALSE)
	ENDIF
ENDPROC zmodem_send_data_subpkt(zm, subpkt_type, p, l)

PROC zmodem_send_pos_header(zm: PTR TO zmodem_t, type,pos, hex)
	DEF header[5]:ARRAY OF CHAR

	header[]:=type
	header[ZP0]:=(pos AND $ff)
	header[ZP1]:=((Shr(pos,8)) AND $ff)
	header[ZP2]:=((Shr(pos,16)) AND $ff)
	header[ZP3]:=((Shr(pos,24)) AND $ff)

	IF(hex)
		RETURN zmodem_send_hex_header(zm, header)
	ELSE
		RETURN zmodem_send_bin_header(zm, header)
  ENDIF
ENDPROC

PROC zmodem_send_ack(zm: PTR TO zmodem_t, pos)
ENDPROC zmodem_send_pos_header(zm, ZACK, pos, /* Hex? */ TRUE)

EXPORT PROC zmodem_send_zfin(zm: PTR TO zmodem_t)
  DEF zfin_header
  zfin_header:=[ ZFIN, 0, 0, 0, 0 ]:CHAR

	lprintf(zm,ZM_LOG_NOTICE,'Finishing Session (Sending ZFIN)')
ENDPROC zmodem_send_hex_header(zm,zfin_header)

PROC zmodem_send_zabort(zm: PTR TO zmodem_t)
	lprintf(zm,ZM_LOG_WARNING,'Aborting Transfer (Sending ZABORT)')
ENDPROC zmodem_send_pos_header(zm, ZABORT, 0, /* Hex? */ TRUE)

PROC zmodem_send_znak(zm: PTR TO zmodem_t)
	lprintf(zm,ZM_LOG_INFO,'Sending ZNAK')
ENDPROC zmodem_send_pos_header(zm, ZNAK, 0, /* Hex? */ TRUE)

PROC zmodem_send_zskip(zm: PTR TO zmodem_t)
	lprintf(zm,ZM_LOG_INFO,'Sending ZSKIP')
ENDPROC zmodem_send_pos_header(zm, ZSKIP, 0, /* Hex? */ TRUE)

PROC zmodem_send_zeof(zm: PTR TO zmodem_t, pos)
  DEF tempstr[255]:STRING

  StringF(tempstr,'Sending End-of-File (ZEOF) frame (pos=\d)', pos)
	lprintf(zm,ZM_LOG_INFO,tempstr)
ENDPROC zmodem_send_pos_header(zm, ZEOF, pos, /* Hex? */ TRUE)

/*
 * rx_raw ; receive a single byte from the line.
 * reads as many are available and then processes them one at a time
 * check the data stream for 5 consecutive CAN characters;
 * and if you see them abort. this saves a lot of clutter in
 * the rest of the code; even though it is a very strange place
 * for an exit. (but that was wat session abort was all about.)
 */

PROC zmodem_recv_raw(zm: PTR TO zmodem_t)
  DEF c
	DEF attempt
  DEF p
 
  p:=zm.zm_recv_byte

  FOR attempt:=0 TO zm.recv_timeout
    c:=p(1 /* second timeout */)    
    BLT noret  
    CMP.L #$18,c
    BEQ noret
    ->IF (c>=0) AND (c<>CAN)
      zm.n_cans:=0
      RETURN c
    ->ENDIF
noret:
    IF(is_cancelled(zm)) THEN RETURN ABORTED

    IF(is_connected(zm)=FALSE) THEN RETURN ABORTED
    EXIT c>=0
  ENDFOR
  IF(attempt>zm.recv_timeout) THEN RETURN TIMEOUT

	IF(c = CAN) 
		zm.n_cans:=zm.n_cans+1
		IF(zm.n_cans = 5) 
			zm.cancelled:=TRUE
			lprintf(zm,ZM_LOG_WARNING,'recv_raw: Cancelled remotely')
/*			return(TIMEOUT)	removed June-12-2005 */
		ENDIF
	ELSE
		zm.n_cans:=0
	ENDIF

ENDPROC c

/*
 * rx; receive a single byte undoing any escaping at the
 * sending site. this bit looks like a mess. sorry for that
 * but there seems to be no other way without incurring a lot
 * of overhead. at least like this the path for a normal character
 * is relatively short.
 */

PROC zmodem_rx2(zm: PTR TO zmodem_t)
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
	DEF c
  DEF loop = TRUE

  REPEAT
    c:=zmodem_recv_raw(zm)
    BLT chkabort
    
    CMP.L #$18,c
    BEQ iszdle
    
    RETURN c
    
chkabort:
    IF is_cancelled(zm) THEN RETURN ABORTED
    RETURN c
    ->IF (c<>ZDLE) THEN RETURN c
iszdle:
    loop:=TRUE
    REPEAT
      c:=zmodem_recv_raw(zm)
      IF (c=ZCRCE) OR (c=ZCRCG) OR (c=ZCRCQ) OR (c=ZCRCW)
				 /* these four are really nasty.
				 * for convenience we just change them into 
				 * special characters by setting a bit outside the
				 * first 8. that way they can be recognized and still
				 * be processed as characters by the rest of the code.
				 */
        ->chr(c,tempstr)
        ->StringF(tempstr2,'x: encoding data subpacket type: \s',tempstr)
        ->lprintf(zm,ZM_LOG_DEBUG,tempstr2)
				RETURN (c OR ZDLEESC)
      ELSEIF (c=ZRUB0)
				RETURN $7f
      ELSEIF (c=ZRUB1)
				RETURN $ff
      ELSEIF  (c=XON) OR (c=(XON OR $80)) OR (c=XOFF) OR (c=(XOFF OR $80)) OR (c=ZDLE)
        chr(c,tempstr)
        StringF(tempstr2,'"rx: dropping escaped flow ctrl char: \s',tempstr)
				lprintf(zm,ZM_LOG_WARNING,tempstr2)
      ELSE
				IF(c < 0) THEN RETURN c

				IF(zm.escape_ctrl_chars AND ((c AND $60) = 0)) 
						/*
						 * a not escaped control character; probably
						 * something from a network. just drop it.
						 */
            ->chr(c,tempstr)
            ->StringF(tempstr2,'rx: dropping unescaped ctrl char: \s',tempstr)
						->lprintf(zm,ZM_LOG_WARNING,tempstr2)
						->JUMP rxcont
				ELSE
					/*
					 * legitimate escape sequence.
					 * rebuild the orignal and return it.
					 */
					IF((c AND $60) = $40)  THEN RETURN Eor(c,$40)
          ->chr(c,tempstr)
          ->StringF(tempstr2,'"rx: illegal sequence: ZDLE \s',tempstr)
					->lprintf(zm,ZM_LOG_WARNING,tempstr2)
          loop:=FALSE
        ENDIF
			ENDIF
		UNTIL (is_cancelled(zm) OR (loop=FALSE))
	UNTIL ((is_connected(zm)=FALSE) OR is_cancelled(zm))

	/*
	 * not reached (unless cancelled).
	 */

ENDPROC ABORTED

EXPORT PROC zmodem_rx(zm: PTR TO zmodem_t)
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
	DEF c
  DEF loop = TRUE

	/*
	 * outer loop for ever so for sure something valid
	 * will come in; a timeout will occur or a session abort
	 * will be received.
	 */

  REPEAT

		REPEAT
      c:=zmodem_recv_raw(zm)
      IF (c=ZDLE)
        loop:=FALSE
      ELSEIF (c=XON) OR (c=(XONOR80)) OR (c=XOFF) OR (c=(XOFFOR80))
        chr(c,tempstr)
        StringF(tempstr2,'rx: dropping flow ctrl char: \s',tempstr)
				lprintf(zm,ZM_LOG_WARNING,tempstr2)
      ELSE
        /*
         * if all control characters should be escaped and 
         * this one wasnt then its spurious and should be dropped.
         */
        IF((zm.escape_ctrl_chars AND (c >= 0) AND ((c AND $60)=0)))
          chr(c,tempstr)
          StringF(tempstr2,'rx: dropping unescaped ctrl char: \s',tempstr)
          lprintf(zm,ZM_LOG_WARNING,tempstr2)
        ELSE
          /*
          * normal character; return it.
          */
          RETURN c
        ENDIF
      ENDIF
		UNTIL (is_cancelled(zm)) OR (loop=FALSE)

		/*
	 	 * ZDLE encoded sequence or session abort.
		 * (or something illegal; then back to the top)
		 */

    loop:=TRUE
    REPEAT
      c:=zmodem_recv_raw(zm)
      IF  (c=XON) OR (c=(XON OR $80)) OR (c=XOFF) OR (c=(XOFF OR $80)) OR (c=ZDLE)
        chr(c,tempstr)
        StringF(tempstr2,'"rx: dropping escaped flow ctrl char: \s',tempstr)
				lprintf(zm,ZM_LOG_WARNING,tempstr2)
      ELSEIF (c=ZCRCE) OR (c=ZCRCG) OR (c=ZCRCQ) OR (c=ZCRCW)
				 /* these four are really nasty.
				 * for convenience we just change them into 
				 * special characters by setting a bit outside the
				 * first 8. that way they can be recognized and still
				 * be processed as characters by the rest of the code.
				 */
        ->chr(c,tempstr)
        ->StringF(tempstr2,'x: encoding data subpacket type: \s',tempstr)
        ->lprintf(zm,ZM_LOG_DEBUG,tempstr2)
				RETURN (c OR ZDLEESC)
      ELSEIF (c=ZRUB0)
				RETURN $7f
      ELSEIF (c=ZRUB1)
				RETURN $ff
      ELSE
				IF(c < 0) THEN RETURN c

				IF(zm.escape_ctrl_chars AND ((c AND $60) = 0)) 
						/*
						 * a not escaped control character; probably
						 * something from a network. just drop it.
						 */
            ->chr(c,tempstr)
            ->StringF(tempstr2,'rx: dropping unescaped ctrl char: \s',tempstr)
						->lprintf(zm,ZM_LOG_WARNING,tempstr2)
						->JUMP rxcont
				ELSE
					/*
					 * legitimate escape sequence.
					 * rebuild the orignal and return it.
					 */
					IF((c AND $60) = $40)  THEN RETURN Eor(c,$40)
          ->chr(c,tempstr)
          ->StringF(tempstr2,'"rx: illegal sequence: ZDLE \s',tempstr)
					->lprintf(zm,ZM_LOG_WARNING,tempstr2)
          loop:=FALSE
        ENDIF
			ENDIF
		UNTIL (is_cancelled(zm) OR (loop=FALSE))
	UNTIL ((is_connected(zm)=FALSE) OR is_cancelled(zm))

	/*
	 * not reached (unless cancelled).
	 */

ENDPROC ABORTED

/*
 * receive a data subpacket as dictated by the last received header.
 * return 2 with correct packet and end of frame
 * return 1 with correct packet frame continues
 * return 0 with incorrect frame.
 * return TIMEOUT with a timeout
 * if an acknowledgement is requested it is generated automatically
 * here. 
 */

/*
 * data subpacket reception
 */

PROC zmodem_recv_data32(zm: PTR TO zmodem_t, p: PTR TO CHAR, maxlen, l: PTR TO LONG)

	DEF c,n
	DEF rxd_crc
	DEF crc
	DEF subpkt_type
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

	->lprintf(zm,ZM_LOG_DEBUG,'recv_data32')

	crc:=$ffffffff

  n:=0
	LOOP
		c:=zmodem_rx2(zm)

    EXIT (c > $ff)
		IF(c < 0) THEN RETURN c

		IF(n >= maxlen) THEN RETURN SUBPKTOVERFLOW
		crc:=ucrc32(c,crc)
    p[]:=c
    p++
    n++
	ENDLOOP
  l[]:=l[]+n

	subpkt_type:=c AND $ff

	crc:=ucrc32(subpkt_type,crc)

	crc:= Not(crc)

	rxd_crc:=zmodem_rx(zm)
	rxd_crc:=rxd_crc OR (Shl(zmodem_rx(zm),8))
	rxd_crc:=rxd_crc OR (Shl(zmodem_rx(zm),16))
	rxd_crc:=rxd_crc OR (Shl(zmodem_rx(zm),24))

	IF(rxd_crc <> crc)
    chr(subpkt_type,tempstr)
    StringF(tempstr2,'CRC32 ERROR (\h[8], expected: \h[8]) Bytes=\d, subpacket-type=\s',rxd_crc, crc, l[], tempstr)
		lprintf(zm,ZM_LOG_WARNING,tempstr2)
		RETURN CRCFAILED
	ENDIF
  /*chr(subpkt_type,tempstr)
  StringF(tempstr2,'GOOD CRC32: \h[8] (Bytes=\d, subpacket-type=\s)',crc, l[], tempstr)
	lprintf(zm,ZM_LOG_DEBUG,tempstr2)*/

	zm.ack_file_pos:=zm.ack_file_pos+l[]
ENDPROC subpkt_type


PROC zmodem_recv_data16(zm: PTR TO zmodem_t, p:PTR TO CHAR,  maxlen, l: PTR TO LONG)

	DEF c,n
	DEF subpkt_type
 	DEF crc
	DEF rxd_crc
  DEF tempstr[255]:STRING
  ->DEF tempstr2[255]:STRING

	->lprintf(zm,ZM_LOG_DEBUG,'recv_data16')

	crc:=0

  n:=0
	LOOP
		c:=zmodem_rx(zm)

		IF(c < 0) THEN RETURN c

		EXIT (c > $ff)

		IF(n >= maxlen) THEN RETURN SUBPKTOVERFLOW
		crc:=ucrc16(c,crc)
		p[]:=c
    p++
    n++
	ENDLOOP
  l[]:=l[]+n

	subpkt_type:= c AND $ff

	crc:=ucrc16(subpkt_type,crc)

	rxd_crc:=Shl(zmodem_rx(zm),8)
	rxd_crc:=rxd_crc OR zmodem_rx(zm)

	IF(rxd_crc <> crc)
    StringF(tempstr,'CRC16 ERROR (\h[4], expected: \h[4]) Bytes=\d',rxd_crc, crc, l[])
		lprintf(zm,ZM_LOG_WARNING,tempstr)
		RETURN CRCFAILED
	ENDIF
  /*StringF(tempstr,'GOOD CRC16: \h[4] (Bytes=\d)', crc, l[])
	lprintf(zm,ZM_LOG_DEBUG,tempstr)*/

	zm.ack_file_pos:=zm.ack_file_pos+l[]

ENDPROC subpkt_type


PROC zmodem_recv_data(zm: PTR TO zmodem_t, p:PTR TO CHAR, maxlen, l: PTR TO LONG, ack)
	DEF subpkt_type
	DEF n=0
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

	IF(l=NIL) THEN l:={n}

  ->StringF(tempstr,'recv_data (\d-bit)', IF zm.receive_32bit_data THEN 32 ELSE 16)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr)

	/*
	 * receive the right type of frame
	 */

	l[]:=0

  IF(zm.receive_32bit_data)
		subpkt_type:=zmodem_recv_data32(zm, p, maxlen, l)
	ELSE
		subpkt_type:=zmodem_recv_data16(zm, p, maxlen, l)
	ENDIF

	IF(subpkt_type <= 0) THEN	RETURN subpkt_type /* e.g. TIMEOUT, SUBPKTOVERFLOW, CRCFAILED */

  ->chr(subpkt_type,tempstr)
  ->StringF(tempstr,'recv_data received subpacket-type: \s',tempstr2)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr2)

	SELECT subpkt_type
		/*
		 * frame continues non-stop
		 */
		CASE ZCRCG
			RETURN FRAMEOK
		/*
		 * frame ends
		 */
		CASE ZCRCE
			RETURN ENDOFFRAME
		/*
 		 * frame continues; ZACK expected
		 */
		CASE ZCRCQ
			IF(ack) THEN zmodem_send_ack(zm, zm.ack_file_pos)
			RETURN FRAMEOK
		/*
		 * frame ends; ZACK expected
		 */
		CASE ZCRCW
			IF(ack) THEN zmodem_send_ack(zm, zm.ack_file_pos)
			RETURN ENDOFFRAME
	ENDSELECT

  chr(subpkt_type,tempstr)
  StringF(tempstr,'Received invalid subpacket-type: \s',tempstr)
	lprintf(zm,ZM_LOG_WARNING,tempstr2)

ENDPROC INVALIDSUBPKT


PROC zmodem_recv_subpacket(zm: PTR TO zmodem_t, ack)
	DEF type

	type:=zmodem_recv_data(zm,zm.rx_data_subpacket,RXSUBPACKETSIZE,NIL,ack)
	IF((type<>FRAMEOK) AND (type<>ENDOFFRAME))
		zmodem_send_znak(zm)
		RETURN FALSE
	ENDIF

ENDPROC TRUE

PROC zmodem_recv_nibble(zm: PTR TO zmodem_t) 
	DEF c

	c:=zmodem_rx(zm)

	IF(c < 0) THEN RETURN c

	IF(c > "9")
		IF((c < "a") OR (c > "f")) 
			/*
			 * illegal hex; different than expected.
			 * we might as well time out.
			 */
			RETURN -1
		ENDIF
    c:=c-("a" - 10)
	ELSE
		IF(c < "0")
			/*
			 * illegal hex; different than expected.
			 * we might as well time out.
			 */
			RETURN -1
		ENDIF
		c:=c-"0"
	ENDIF
ENDPROC c

PROC zmodem_recv_hex(zm: PTR TO zmodem_t)

	DEF n1
	DEF n0
	DEF ret
  ->DEF tempstr[255]:STRING

	n1:=zmodem_recv_nibble(zm)

	IF(n1 < 0) THEN RETURN n1

	n0:=zmodem_recv_nibble(zm)

	IF(n0 < 0) THEN RETURN n0

	ret:=(Shl(n1,4)) OR n0

  ->StringF(tempstr,'recv_hex returning: 0x\h[2]', ret)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr)
ENDPROC ret

/*
 * receive routines for each of the six different styles of header.
 * each of these leaves zm.rxd_header_len set to 0 if the end result is
 * not a valid header.
 */

PROC zmodem_recv_bin16_header(zm: PTR TO zmodem_t)

	DEF c
	DEF n
	DEF crc
	DEF rxd_crc
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

	->lprintf(zm,ZM_LOG_DEBUG,'recv_bin16_header')

	crc:=0

	FOR n:=0 TO HDRLEN-1
		c:=zmodem_rx(zm)
		IF(c < 0)
      chr(c,tempstr)
      StringF(tempstr2,'recv_bin16_header: \s',tempstr)
			lprintf(zm,ZM_LOG_WARNING,tempstr2)
			RETURN FALSE
		ENDIF
		crc:=ucrc16(c,crc)
		zm.rxd_header[n]:= c
	ENDFOR

	rxd_crc:=Shl(zmodem_rx(zm),8)
	rxd_crc:=rxd_crc OR zmodem_rx(zm)

	IF(rxd_crc <> crc)
    StringF(tempstr,'CRC16 ERROR: 0x\h, expected: 0x\h', rxd_crc, crc)
		lprintf(zm,ZM_LOG_WARNING,tempstr)
		RETURN FALSE
	ENDIF
  /*StringF(tempstr,'GOOD CRC16: \h[4]', crc)
	lprintf(zm,ZM_LOG_DEBUG,tempstr)*/

	zm.rxd_header_len:=5

ENDPROC TRUE


PROC zmodem_recv_hex_header(zm: PTR TO zmodem_t)
  DEF c
	DEF i
	DEF crc = 0
	DEF rxd_crc
  DEF tempstr[255]:STRING

	->lprintf(zm,ZM_LOG_DEBUG,'recv_hex_header')

	FOR i:=0 TO HDRLEN-1
		c:=zmodem_recv_hex(zm)
		IF(c<0) THEN RETURN FALSE
		crc:=ucrc16(c,crc)

		zm.rxd_header[i]:=c
	ENDFOR

	/*
	 * receive the crc
	 */

	c:=zmodem_recv_hex(zm)

	IF(c < 0) THEN RETURN FALSE

	rxd_crc:=Shl(c,8)

	c:=zmodem_recv_hex(zm)

	IF(c < 0) THEN RETURN FALSE

	rxd_crc:=rxd_crc OR c

	IF(rxd_crc = crc) 
    ->StringF(tempstr,'GOOD CRC16: \h[4]', crc)
		->lprintf(zm,ZM_LOG_DEBUG,tempstr)
		zm.rxd_header_len:=5
	ELSE
    StringF(tempstr,'CRC16 ERROR: 0x\h, expected: 0x\h', rxd_crc, crc)
		lprintf(zm,ZM_LOG_WARNING,tempstr)
		RETURN FALSE
	ENDIF

	/*
	 * drop the end of line sequence after a hex header
	 */
	c:=zmodem_rx(zm)
	IF(c = "\b")
		/*
		 * both are expected with CR
		 */
		zmodem_rx(zm)	/* drop LF */
	ENDIF

ENDPROC TRUE

PROC zmodem_recv_bin32_header(zm: PTR TO zmodem_t)
	DEF c
	DEF n
	DEF crc
	DEF rxd_crc
  DEF tempstr[255]:STRING

	->lprintf(zm,ZM_LOG_DEBUG,'recv_bin32_header')

	crc:=$ffffffff

	FOR n:=0 TO HDRLEN-1
		c:=zmodem_rx(zm)
		IF(c < 0) THEN RETURN TRUE

		crc:=ucrc32(c,crc)
		zm.rxd_header[n]:=c
	ENDFOR

	crc:=Not(crc)

	rxd_crc:=zmodem_rx(zm)
	rxd_crc:=rxd_crc OR (Shl(zmodem_rx(zm),8))
	rxd_crc:=rxd_crc OR (Shl(zmodem_rx(zm),16))
	rxd_crc:=rxd_crc OR (Shl(zmodem_rx(zm),24))

	IF(rxd_crc<>crc)
    StringF(tempstr,'CRC32 ERROR (\h[8], expected: \h[8]',rxd_crc, crc)
		lprintf(zm,ZM_LOG_WARNING,tempstr)
		RETURN FALSE
	ENDIF
  ->StringF(tempstr,'GOOD CRC32: \h[8]', crc)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr)

	zm.rxd_header_len:=5
ENDPROC TRUE

/*
 * receive any style header
 * if the errors flag is set than whenever an invalid header packet is
 * received INVHDR will be returned. otherwise we wait for a good header
 * also; a flag (receive_32bit_data) will be set to indicate whether data
 * packets following this header will have 16 or 32 bit data attached.
 * variable headers are not implemented.
 */

PROC zmodem_recv_header_raw(zm: PTR TO zmodem_t, errors)
  DEF c
	DEF frame_type
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

	->lprintf(zm,ZM_LOG_DEBUG,'recv_header_raw')

	zm.rxd_header_len:=0

	REPEAT
zmrhcont:
		REPEAT
			IF((c:=zmodem_recv_raw(zm)))<0 THEN RETURN c

			IF(is_cancelled(zm)) THEN RETURN ZCAN
    UNTIL c=ZPAD


		IF((c:=zmodem_recv_raw(zm)))<0 THEN RETURN c

		IF(c = ZPAD)
			IF((c:=zmodem_recv_raw(zm)))<0 THEN RETURN c
		ENDIF

		/*
		 * spurious ZPAD check
		 */

		IF(c<>ZDLE)
      chr(c,tempstr)
      StringF(tempstr2,'recv_header_raw: Expected ZDLE, received: \s',tempstr)
			lprintf(zm,ZM_LOG_WARNING,tempstr2)
      JUMP zmrhcont
		ENDIF

		/*
		 * now read the header style
		 */

		c:=zmodem_rx(zm)

		SELECT c
			CASE ZBIN
				IF(zmodem_recv_bin16_header(zm))=FALSE THEN RETURN INVHDR
				zm.receive_32bit_data:=FALSE
			CASE ZHEX
				IF(zmodem_recv_hex_header(zm))=FALSE THEN RETURN INVHDR
				zm.receive_32bit_data:=FALSE
			CASE ZBIN32

				IF(zmodem_recv_bin32_header(zm))=FALSE THEN RETURN INVHDR
				zm.receive_32bit_data:=TRUE
			DEFAULT
				IF(c < 0)
          chr(c,tempstr)
          StringF(tempstr2,'recv_header_raw: \s', tempstr)
					lprintf(zm,ZM_LOG_WARNING,tempstr2)
					RETURN c
				ENDIF
				/*
				 * unrecognized header style
				 */
        chr(c,tempstr)
        StringF(tempstr2,'recv_header_raw: UNRECOGNIZED header style: \s',tempstr)
				lprintf(zm,ZM_LOG_ERR,tempstr2)
				IF(errors) THEN RETURN INVHDR
        JUMP zmrhcont
		ENDSELECT
		IF(errors AND (zm.rxd_header_len = 0)) THEN RETURN INVHDR

	UNTIL (zm.rxd_header_len <> 0) OR (is_cancelled(zm))

	IF(is_cancelled(zm)) THEN RETURN ZCAN

	/*
 	 * this appears to have been a valid header.
	 * return its type.
	 */

	frame_type:=zm.rxd_header[]

	zm.rxd_header_pos:=(zm.rxd_header[ZP0] OR (Shl(zm.rxd_header[ZP1],8)) OR
				(Shl(zm.rxd_header[ZP2],16)) OR (Shl(zm.rxd_header[ZP3],24)))

	SELECT frame_type
		CASE ZCRC
			zm.crc_request:=zm.rxd_header_pos
		CASE ZDATA
			zm.ack_file_pos:=zm.rxd_header_pos
		CASE ZFILE
			zm.ack_file_pos:=0
			IF(zmodem_recv_subpacket(zm,/* ack? */FALSE))=FALSE THEN frame_type:=frame_type OR BADSUBPKT
		CASE ZSINIT
			IF(zmodem_recv_subpacket(zm,/* ack? */TRUE))=FALSE THEN  frame_type:=frame_type OR BADSUBPKT
		CASE ZCOMMAND
			IF(zmodem_recv_subpacket(zm,/* ack? */TRUE))=FALSE THEN  frame_type:=frame_type OR BADSUBPKT
		CASE ZFREECNT
			zmodem_send_pos_header(zm, ZACK, getFreeDiskSpace(), /* Hex? */ TRUE)
	ENDSELECT

->#if 0 /* def _DEBUG */
  ->frame_desc(frame_type,tempstr)
  ->StringF(tempstr2,'recv_header_raw received header type: \s',tempstr)
	->lprintf(zm,ZM_LOG_DEBUG,tempstr2)
->#endif
ENDPROC frame_type

PROC zmodem_recv_header(zm: PTR TO zmodem_t)
	DEF ret
  ->DEF tempstr[255]:STRING
  ->DEF tempstr2[255]:STRING

  ret:=zmodem_recv_header_raw(zm, FALSE)
	
	SELECT ret
		CASE TIMEOUT
			lprintf(zm,ZM_LOG_WARNING,'recv_header TIMEOUT')
		CASE INVHDR
			lprintf(zm,ZM_LOG_WARNING,'recv_header detected an invalid header')
		DEFAULT
      ->frame_desc(ret,tempstr)
      ->StringF(tempstr2,'recv_header returning: \s (pos=\d)',tempstr, frame_pos(zm, ret))
			->lprintf(zm,ZM_LOG_DEBUG,tempstr2)

			IF(ret=ZCAN)
				zm.cancelled:=TRUE
			ELSEIF(ret=ZRINIT)
				zmodem_parse_zrinit(zm)
      ENDIF
	ENDSELECT

ENDPROC ret

PROC zmodem_recv_header_and_check(zm: PTR TO zmodem_t)
	DEF type=ABORTED
  ->DEF tempstr[255]:STRING
  ->DEF tempstr2[255]:STRING

	WHILE(is_connected(zm) AND (is_cancelled(zm)=FALSE))
		type:=zmodem_recv_header_raw(zm,TRUE)	

		EXIT type = TIMEOUT

		EXIT (type<>INVHDR) AND ((type AND BADSUBPKT) = 0)
		
		zmodem_send_znak(zm)
	ENDWHILE

  ->frame_desc(type,tempstr)
  ->StringF(tempstr2,'recv_header_and_check returning: \s (pos=\d)',tempstr,frame_pos(zm, type))
	->lprintf(zm,ZM_LOG_DEBUG,tempstr2)

	IF(type=ZCAN) THEN zm.cancelled:=TRUE
ENDPROC type

PROC zmodem_request_crc(zm: PTR TO zmodem_t, length)
	zmodem_recv_purge(zm)
	zmodem_send_pos_header(zm,ZCRC,length,TRUE)
ENDPROC TRUE

PROC zmodem_recv_crc(zm: PTR TO zmodem_t, crc:PTR TO LONG)
	DEF type
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

	IF(zmodem_data_waiting(zm,zm.crc_timeout))=FALSE
    StringF(tempstr,'Timeout waiting for response (\d seconds)',zm.crc_timeout)
		lprintf(zm,ZM_LOG_ERR,tempstr)
		RETURN FALSE
	ENDIF

	IF((type:=zmodem_recv_header(zm)))<>ZCRC
    frame_desc(type,tempstr)
    StringF(tempstr2,'Received \s instead of ZCRC', tempstr)
		lprintf(zm,ZM_LOG_ERR,tempstr2)
		RETURN FALSE
	ENDIF
	IF(crc<>NIL) THEN crc[]:=zm.crc_request
ENDPROC TRUE

/*PROC zmodem_get_crc(zm: PTR TO zmodem_t,length, crc:PTR TO LONG)
	IF(zmodem_request_crc(zm, length)) THEN RETURN  zmodem_recv_crc(zm, crc)
ENDPROC FALSE*/

PROC zmodem_parse_zrinit(zm: PTR TO zmodem_t)
  DEF tempstr[255]:STRING

	zm.can_full_duplex:=(zm.rxd_header[ZF0] AND ZF0_CANFDX)
	zm.can_overlap_io:=(zm.rxd_header[ZF0] AND ZF0_CANOVIO)
	zm.can_break:=(zm.rxd_header[ZF0] AND ZF0_CANBRK)
	zm.can_fcs_32:=(zm.rxd_header[ZF0] AND ZF0_CANFC32)
	zm.escape_ctrl_chars:=(zm.rxd_header[ZF0] AND ZF0_ESCCTL)
	zm.escape_8th_bit:=(zm.rxd_header[ZF0] AND ZF0_ESC8)

  StringF(tempstr,'Receiver requested mode (0x\h[2]):\r\n\s-duplex, \s overlap I/O, CRC-\d, Escape: \s',
		zm.rxd_header[ZF0],
		IF(zm.can_full_duplex) THEN 'Full' ELSE 'Half',
		IF(zm.can_overlap_io) THEN 'Can' ELSE 'Cannot',
		IF(zm.can_fcs_32) THEN 32 ELSE 16,
		IF(zm.escape_ctrl_chars) THEN 'ALL' ELSE 'Normal')
	lprintf(zm,ZM_LOG_INFO,tempstr)

  zm.recv_bufsize:=(zm.rxd_header[ZP0] OR (Shl(zm.rxd_header[ZP1],8)))
	IF(zm.recv_bufsize)<>0
    StringF(tempstr,'Receiver specified buffer size of: \d', zm.recv_bufsize)
		lprintf(zm,ZM_LOG_INFO,tempstr)
  ENDIF
ENDPROC

PROC zmodem_get_zrinit(zm: PTR TO zmodem_t)
  DEF zrqinit_header

  zrqinit_header:=[ZRQINIT, /* ZF3: */0, 0, 0, /* ZF0: */0 ]:CHAR
	/* Note: sz/dsz/fdsz sends $80 in ZF3 because it supports var-length headers. */
	/* We do not, so we send $00, resulting in a CRC-16 value of $0000 as well. */

	zmodem_send_raw(zm,"r")
	zmodem_send_raw(zm,"z")
	zmodem_send_raw(zm,"\b")
	zmodem_send_hex_header(zm,zrqinit_header)
	
	IF(zmodem_data_waiting(zm,zm.init_timeout))=FALSE THEN RETURN TIMEOUT

ENDPROC zmodem_recv_header(zm)

PROC zmodem_send_zrinit(zm: PTR TO zmodem_t)
  DEF zrinit_header

  zrinit_header:=[ZRINIT, 0, 0, 0, 0 ]:CHAR
	
	zrinit_header[ZF0]:=ZF0_CANFDX

	IF(zm.no_streaming)=FALSE THEN zrinit_header[ZF0]:=zrinit_header[ZF0] OR ZF0_CANOVIO

	IF(zm.can_break) THEN zrinit_header[ZF0]:=zrinit_header[ZF0] OR ZF0_CANBRK

	IF(zm.want_fcs_16)=FALSE THEN zrinit_header[ZF0]:=zrinit_header[ZF0] OR ZF0_CANFC32

	IF(zm.escape_ctrl_chars) THEN zrinit_header[ZF0]:=zrinit_header[ZF0] OR ZF0_ESCCTL

	IF(zm.escape_8th_bit) THEN zrinit_header[ZF0]:=zrinit_header[ZF0] OR ZF0_ESC8

	IF(zm.no_streaming AND (zm.recv_bufsize=0)) THEN zm.recv_bufsize:=RXSUBPACKETSIZE

	zrinit_header[ZP0]:=( zm.recv_bufsize AND $ff)
	zrinit_header[ZP1]:=Shr(zm.recv_bufsize,8)
ENDPROC zmodem_send_hex_header(zm, zrinit_header)

PROC zmodem_handle_zrpos(zm: PTR TO zmodem_t, pos:PTR TO LONG)
  DEF tempstr[255]:STRING
	IF(zm.rxd_header_pos <= zm.current_file_size)
		IF(pos[] <> zm.rxd_header_pos)
			pos[]:=zm.rxd_header_pos
      StringF(tempstr,'Resuming transfer from offset: \d',pos[])
			lprintf(zm,ZM_LOG_INFO,tempstr)
		ENDIF
		RETURN TRUE
	ENDIF
  StringF(tempstr,'Invalid ZRPOS offset: \d', zm.rxd_header_pos)
	lprintf(zm,ZM_LOG_WARNING,tempstr)
ENDPROC FALSE

PROC zmodem_handle_zack(zm: PTR TO zmodem_t)
  DEF tempstr[255]:STRING
	IF(zm.rxd_header_pos = zm.current_file_pos) THEN RETURN TRUE

  StringF(tempstr,'ZACK for incorrect offset (\d vs \d)',zm.rxd_header_pos, zm.current_file_pos)
	lprintf(zm,ZM_LOG_WARNING,tempstr)
ENDPROC FALSE

/*
 * send from the current position in the file
 * all the way to end of file or until something goes wrong.
 * (ZNAK or ZRPOS received)
 * returns ZRINIT on success.
 */

PROC zmodem_send_from(zm: PTR TO zmodem_t, fp, pos,sent: PTR TO LONG)
	DEF n
	DEF type
	DEF buf_sent=0
	DEF subpkts_sent=0
  DEF ack
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
	DEF rx_type
	DEF c
  DEF p
  DEF startfrom

  startfrom:=pos
  IF doSeek(zm,fp,pos,OFFSET_BEGINING)=-1 
    StringF(tempstr,'ERROR \d seeking to file offset \d',IoErr(), pos)
		lprintf(zm,ZM_LOG_ERR,tempstr)
		zmodem_send_pos_header(zm, ZFERR, pos, /* Hex? */ TRUE)
		RETURN ZFERR
  ENDIF
	zm.current_file_pos:=pos

	/*
	 * send the data in the file
	 */

	WHILE(is_connected(zm))

		/*
		 * read a block from the file
		 */

		n:=doRead(zm,fp,zm.tx_data_subpacket,zm.block_size)
	
		type:=ZCRCW

		/** ZMODEM.DOC:
			ZCRCW data subpackets expect a response before the next frame is sent.
			If the receiver does not indicate overlapped I/O capability with the
			CANOVIO bit, or sets a buffer size, the sender uses the ZCRCW to allow
			the receiver to write its buffer before sending more data.
		***/
		/* Note: we always use ZCRCW for the first frame */
		IF(subpkts_sent OR (n < zm.block_size)) 
			/*  ZMODEM.DOC:
				In the absence of fatal error, the sender eventually encounters end of
				file.  If the end of file is encountered within a frame, the frame is
				closed with a ZCRCE data subpacket which does not elicit a response
				except in case of error.
			*/
      IF(n < zm.block_size)
				type:=ZCRCE
			ELSE
				IF(zm.can_overlap_io AND (zm.no_streaming=FALSE) AND ((zm.recv_bufsize=0) OR ((buf_sent+n) < zm.recv_bufsize)))
					type:=ZCRCG
				ELSE	/* Send a ZCRCW frame */
					buf_sent:=0	
        ENDIF
			ENDIF
		ENDIF

		/* Note: No support for sending ZCRCQ data sub-packets here */

		IF(zmodem_send_data(zm, type, zm.tx_data_subpacket, n))<>0 THEN RETURN TIMEOUT

		zm.current_file_pos:=zm.current_file_pos+n
		IF(zm.current_file_pos > zm.current_file_size) THEN zm.current_file_size:=zm.current_file_pos
		subpkts_sent++

    p:=zm.zm_progress
		IF(p<>NIL) THEN p(zm.current_file_pos,zm.current_file_pos-startfrom,zm.current_file_size,zm.transfer_start_time1,zm.transfer_start_time2,zm.errors,zm.transfer_start_pos,zm.current_file_name,zm.new_file,zm.block_size)
    zm.new_file:=FALSE 

		IF((type = ZCRCW) OR (type = ZCRCE)) 
      ->chr(type,tempstr)
      ->StringF(tempstr2,'Sent end-of-frame (\s sub-packet)', tempstr)
			->lprintf(zm,ZM_LOG_DEBUG,tempstr2)
			IF(type=ZCRCW)	/* ZACK expected */  
				->lprintf(zm,ZM_LOG_DEBUG,'Waiting for ZACK')
				WHILE(is_connected(zm)) 
					IF((ack:=zmodem_recv_header(zm)))<>ZACK THEN RETURN ack

					IF(is_cancelled(zm)) THEN RETURN ZCAN

					EXIT zmodem_handle_zack(zm)
				ENDWHILE 
			ENDIF
		ENDIF

   
		IF(sent<>NIL) THEN sent[]:=sent[]+n

		buf_sent:=buf_sent+n

		IF(n < zm.block_size)
      StringF(tempstr,'send_from: end of file (or read error) reached at offset: \d',zm.current_file_pos)
			lprintf(zm,ZM_LOG_DEBUG,tempstr)
			zmodem_send_zeof(zm, zm.current_file_pos)
      IF pos<>zm.current_file_pos THEN zm.send_successful:=TRUE

      ->send a progress update at end of file just to be safe
      p:=zm.zm_progress
      IF(p<>NIL) THEN p(zm.current_file_size,zm.current_file_size-startfrom,zm.current_file_size,zm.transfer_start_time1,zm.transfer_start_time2,zm.errors,zm.transfer_start_pos,zm.current_file_name,zm.new_file,zm.block_size)
      
			RETURN zmodem_recv_header(zm)	/* If this is ZRINIT, Success */
		ENDIF

		/* 
		 * characters from the other side
		 * check out that header
		 */

		WHILE(zmodem_data_waiting(zm, IF zm.consecutive_errors THEN 1 ELSE 0) AND (is_cancelled(zm)=FALSE) AND (is_connected(zm)))
			lprintf(zm,ZM_LOG_DEBUG,'Back-channel traffic detected:')
			IF((c:=zmodem_recv_raw(zm)))<0 THEN RETURN c

			IF(c = ZPAD)
				/* ZMODEM.DOC: 
					FULL STREAMING WITH SAMPLING
					If one of these characters (CAN or ZPAD) is seen, an
					empty ZCRCE data subpacket is sent.
				*/
				zmodem_send_data(zm, ZCRCE, NIL, 0)
				rx_type:=zmodem_recv_header(zm)
        chr(rx_type,tempstr)
        StringF(tempstr2,'Received back-channel data: \s', tempstr)
				lprintf(zm,ZM_LOG_DEBUG,tempstr2)
				IF(rx_type >= 0) THEN RETURN rx_type
			ELSE
        chr(c,tempstr)
        StringF(tempstr2,'Received: \s',tempstr)
				lprintf(zm,ZM_LOG_DEBUG,tempstr2)
      ENDIF
		ENDWHILE

		IF (is_cancelled(zm)) THEN RETURN ZCAN

		zm.consecutive_errors:=0

		IF(zm.block_size < zm.max_block_size)
			zm.block_size:=zm.block_size*2
			IF(zm.block_size > zm.max_block_size) THEN zm.block_size:=zm.max_block_size
		ENDIF
	ENDWHILE
  zm.new_file:=FALSE
  
	->lprintf(zm,ZM_LOG_DEBUG,'send_from: returning unexpectedly!')

	/*
	 * end of file reached.
	 * should receive something... so fake ZACK
	 */

ENDPROC ZACK

EXPORT PROC zmodem_send_files(zm: PTR TO zmodem_t,sentptr: PTR TO LONG, timetaken:PTR TO LONG)
  DEF p,res,init=TRUE
  DEF fname[255]:STRING
  DEF sent=0

  zm.files_remaining:=zm.total_files
  zm.bytes_remaining:=zm.total_bytes

  timetaken[]:=0

  p:=zm.zm_firstfile
  IF p<>NIL
    IF p(fname)
      REPEAT
        res:=zmodem_send_file(zm, fname, init,{sent}, timetaken)
        IF res=FALSE THEN RETURN res
        init:=FALSE
        IF res
          p:=zm.zm_nextfile
          res:=FALSE
          IF p<>NIL THEN res:=p(fname)
          zm.files_remaining:=zm.files_remaining-1
          zm.bytes_remaining:=zm.bytes_remaining-sent
          IF zm.files_remaining<0 THEN zm.files_remaining:=0
          IF zm.bytes_remaining<0 THEN zm.bytes_remaining:=0
          IF sentptr<>NIL THEN sentptr[]:=sentptr[]+sent
        ENDIF
      UNTIL res=FALSE
      zmodem_send_zfin(zm)
      zmodem_recv_header(zm)
      zmodem_send_raw(zm,"O")
      zmodem_send_raw(zm,"O")
      zmodem_flush(zm)
      
    ENDIF
  ENDIF
ENDPROC TRUE

/*
 * send a file; returns true when session is successful. (or file is skipped)
 */

PROC zmodem_send_file(zm: PTR TO zmodem_t, fname: PTR TO CHAR, request_init,sent: PTR TO LONG, timetaken: PTR TO LONG)

	DEF	pos=0
	DEF	sent_bytes=0
	DEF p: PTR TO CHAR
	DEF	zfile_frame: PTR TO CHAR
	DEF	type
  DEF i
  DEF fp
	DEF attempts
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF loop = TRUE
  DEF t1,t2,t

  fp:=doOpen(zm,fname,MODE_OLDFILE)
  IF fp=NIL
    StringF(tempstr,'Error opening file \s',fname)
    lprintf(zm,ZM_LOG_ERR,tempstr)
    RETURN FALSE
  ENDIF

  zfile_frame:= NEW [ ZFILE, 0, 0, 0, 0 ]:CHAR

  IF(zm.block_size = 0) THEN zm.block_size:=ZBLOCKLEN

	IF(zm.block_size < 128) THEN zm.block_size:=128	

	IF(zm.block_size > TXSUBPACKETSIZE) THEN zm.block_size:=TXSUBPACKETSIZE

	IF(zm.max_block_size < zm.block_size) THEN zm.max_block_size:=zm.block_size

	IF(zm.max_block_size > RXSUBPACKETSIZE) THEN zm.max_block_size:= RXSUBPACKETSIZE

	zm.file_skipped:=FALSE
  zm.send_successful:=FALSE

	IF(zm.no_streaming) THEN lprintf(zm,ZM_LOG_WARNING,'Streaming disabled')

	IF(request_init)
    zm.errors:=0
    WHILE (zm.errors<=zm.max_errors) AND (is_cancelled(zm)=FALSE) AND (is_connected(zm))
			IF(zm.errors)
        StringF(tempstr,'Sending ZRQINIT (\d of \d)',zm.errors+1,zm.max_errors+1)
				lprintf(zm,ZM_LOG_NOTICE,tempstr)
			ELSE
				lprintf(zm,ZM_LOG_INFO,'Sending ZRQINIT')
      ENDIF
			i:=zmodem_get_zrinit(zm)
			EXIT i = ZRINIT
      frame_desc(i,tempstr)
      StringF(tempstr2,'send_file: received \s instead of ZRINIT',tempstr)
			lprintf(zm,ZM_LOG_WARNING,tempstr2)
      zm.errors:=zm.errors+1
		ENDWHILE
		IF((zm.errors>=zm.max_errors) OR (is_cancelled(zm)) OR (is_connected(zm))=FALSE) 
      doClose(zm,fp)
      RETURN FALSE
    ENDIF
	ENDIF
  lprintf(zm,ZM_LOG_INFO,'Sending ZRQINIT done')

	zm.current_file_size:=getFileSize(zm,fp)
	strcopy(zm.current_file_name,fname)

	/*
	 * the file exists. now build the ZFILE frame
	 */

	/*
	 * set conversion option
	 * (not used; always binary)
	 */

	zfile_frame[ZF0]:=ZF0_ZCBIN

	/*
	 * management option
	 */

	IF(zm.management_protect) 
		zfile_frame[ZF1]:=ZF1_ZMPROT
		lprintf(zm,ZM_LOG_DEBUG,'send_file: protecting destination')
	ELSEIF(zm.management_clobber)
		zfile_frame[ZF1]:=ZF1_ZMCLOB
		lprintf(zm,ZM_LOG_DEBUG,'send_file: overwriting destination')
	ELSEIF(zm.management_newer)
		zfile_frame[ZF1]:=ZF1_ZMNEW
		lprintf(zm,ZM_LOG_DEBUG,'send_file: overwriting destination if newer')
	ELSE
		zfile_frame[ZF1]:=ZF1_ZMCRC
  ENDIF

	/*
	 * transport options
	 * (just plain normal transfer)
	 */

	zfile_frame[ZF2]:=ZF2_ZTNOR

	/*
	 * extended options
	 */

	zfile_frame[ZF3]:=0

	/*
 	 * now build the data subpacket with the file name and lots of other
	 * useful information.
	 */

	/*
	 * first enter the name and a 0
	 */

	p:=zm.tx_data_subpacket

	strcopy(zm.tx_data_subpacket,FilePart(fname),TXSUBPACKETSIZE-1)
	zm.tx_data_subpacket[(TXSUBPACKETSIZE)-1]:=0

	p:=p+StrLen(p) + 1

	StringF(tempstr,'\d \d 0 0 \d \d 0',
		zm.current_file_size,	/* use for estimating only, could be zero! */
		0,   ->(uintmax_t)s.st_mtime
		zm.files_remaining,
		zm.bytes_remaining)
  strcopy(p,tempstr,-1)
	p:=p+StrLen(p) + 1

  attempts:=0
  LOOP
zsendcont1:
    attempts++

		IF(attempts > zm.max_errors)
      doClose(zm,fp)
      RETURN FALSE
    ENDIF

		/*
	 	 * send the header and the data
	 	 */

    StringF(tempstr,'Sending ZFILE frame: ''\s''',zm.tx_data_subpacket+StrLen(zm.tx_data_subpacket)+1)
		lprintf(zm,ZM_LOG_DEBUG,tempstr)

		IF((i:=zmodem_send_bin_header(zm,zfile_frame)))<>0
      StringF(tempstr,'zmodem_send_bin_header returned \d',i)
			lprintf(zm,ZM_LOG_DEBUG,tempstr)
			JUMP zsendcont1
		ENDIF

		IF((i:=zmodem_send_data_subpkt(zm,ZCRCW,zm.tx_data_subpacket,p - zm.tx_data_subpacket)))<>0
      StringF(tempstr,'zmodem_send_data_subpkt returned \d',i)
			lprintf(zm,ZM_LOG_DEBUG,tempstr)
			JUMP zsendcont1
		ENDIF
		/*
		 * wait for anything but an ZACK packet
		 */
zsendignore:
		REPEAT
			type:=zmodem_recv_header(zm)
			IF(is_cancelled(zm))
        doClose(zm,fp)
        RETURN FALSE
      ENDIF

    UNTIL (type<>ZACK) OR (is_connected(zm)=FALSE)

		IF(is_connected(zm)=FALSE)
      doClose(zm,fp)
      RETURN FALSE
    ENDIF

->if 0
    ->StringF(tempstr,'type : \d',type)
    ->lprintf(zm,ZM_LOG_INFO,tempstr)
->#endif

		IF(type = ZCRC) 
			IF(zm.crc_request=0)
				lprintf(zm,ZM_LOG_NOTICE,'Receiver requested CRC of entire file')
			ELSE
        StringF(tempstr,'Receiver requested CRC of first \d bytes',zm.crc_request)
				lprintf(zm,ZM_LOG_NOTICE,tempstr)
      ENDIF
			zmodem_send_pos_header(zm,ZCRC,fcrc32(zm,fp,zm.crc_request),TRUE)
			type:=zmodem_recv_header(zm)
		ENDIF
    
		IF(type = ZSKIP)
			zm.file_skipped:=TRUE
			lprintf(zm,ZM_LOG_WARNING,'File skipped by receiver')
      doClose(zm,fp)
			RETURN TRUE
		ENDIF

    IF (type=ZRINIT) 
			lprintf(zm,ZM_LOG_WARNING,'ignoring duplicate ZRINIT')
      JUMP zsendignore
    ENDIF

		EXIT type = ZRPOS
	ENDLOOP

	IF(zmodem_handle_zrpos(zm, {pos}))=FALSE
    doClose(zm,fp)
    RETURN FALSE
  ENDIF

	zm.transfer_start_pos:=pos
  
  t1,t2:=getZmSystemTime()
	zm.transfer_start_time1:=t1
  zm.transfer_start_time2:=t2

  doSeek(zm,fp,0,OFFSET_BEGINNING)
	zm.errors:=0
	zm.consecutive_errors:=0

  StringF(tempstr,'Sending \s from offset \d', fname, pos)
	lprintf(zm,ZM_LOG_DEBUG,tempstr)
  zm.new_file:=TRUE

  loop:=TRUE
	WHILE loop
zsendcont2:
		/*
		 * and start sending
		 */

		type:=zmodem_send_from(zm, fp, pos, {sent_bytes})

    t1,t2:=getZmSystemTime()
    t:=Mul((t1-zm.transfer_start_time1),50)+t2-zm.transfer_start_time2

		IF(sent<>NIL) THEN sent[]:=sent[]+sent_bytes
    IF(timetaken<>NIL) THEN timetaken[]:=timetaken[]+t

		IF(is_connected(zm))=FALSE
      doClose(zm,fp)
      RETURN FALSE
    ENDIF

		EXIT (type = ZFERR) OR (type = ZABORT) OR (is_cancelled(zm))

	  IF(type = ZSKIP)
			zm.file_skipped:=TRUE
      StringF(tempstr,'File skipped by receiver at offset: \d', pos + sent_bytes)
			lprintf(zm,ZM_LOG_WARNING,tempstr)
			/* ZOC sends a ZRINIT after mid-file ZSKIP, so consume the ZRINIT here */
			zmodem_recv_header(zm)
      doClose(zm,fp)
			RETURN TRUE
		ENDIF

		IF(type=ZRINIT) 
      doClose(zm,fp)
      RETURN TRUE /* Success */
    ENDIF

		IF(type=ZACK)
      IF (zmodem_handle_zack(zm))
			  pos:=pos+sent_bytes
			  JUMP zsendcont2
      ENDIF
		ENDIF

		/* Error of some kind */

    chr(type,tempstr)
    StringF(tempstr,'Received \s at offset: \d', tempstr, zm.current_file_pos)
		lprintf(zm,ZM_LOG_ERR,tempstr)

		IF((zm.block_size = zm.max_block_size) AND (zm.max_block_size > ZBLOCKLEN)) THEN zm.max_block_size:=Div(zm.max_block_size,2)

		IF(zm.block_size > 128) THEN zm.block_size:= Div(zm.block_size,2)

		zm.errors:=zm.errors+1
    zm.consecutive_errors:=zm.consecutive_errors+1
		EXIT(zm.consecutive_errors > zm.max_errors) 	/* failure */

		IF(type=ZRPOS) 
			IF(zmodem_handle_zrpos(zm, {pos}))=FALSE THEN loop:=FALSE
		ENDIF
	ENDWHILE

  chr(type,tempstr)
  StringF(tempstr2,'Transfer failed on receipt of: \s', tempstr)
	lprintf(zm,ZM_LOG_WARNING,tempstr2)
  END zfile_frame[5]
  doClose(zm,fp)
ENDPROC FALSE

EXPORT PROC zmodem_recv_files(zm: PTR TO zmodem_t, download_dir:PTR TO CHAR,bytes_received: PTR TO LONG,timetaken:PTR TO LONG)
	DEF fpath[MAX_PATH]:STRING
  DEF fp
	DEF	l
	DEF skip
	DEF loop
	DEF b
	DEF	crc
	DEF	rcrc
	DEF	bytes
	DEF	kbytes
	DEF	start_bytes
	DEF	files_received=0
	DEF	t
	DEF	cps
	DEF	timeout
	DEF	errors
  DEF tempstr[255]:STRING
  DEF brk=FALSE
  DEF p
  DEF t1,t2

  timetaken[]:=0
	zm.current_file_num:=1
	WHILE(zmodem_recv_init(zm)=ZFILE)
		bytes:=zm.current_file_size
		kbytes:=Shr(bytes,10)
		IF(kbytes<1) THEN kbytes:=0
		StringF(tempstr,'Downloading \s \d KBytes) via Zmodem', zm.current_file_name, kbytes)
		lprintf(zm,ZM_LOG_INFO,tempstr)

		REPEAT	/* try */
			skip:=TRUE
			loop:=FALSE

      IF fpath[StrLen(fpath)-1]<>":" THEN StrAdd(fpath,'/')
			StringF(fpath,'\s\s',download_dir,zm.current_file_name)
			StringF(tempstr,'fpath=\s',fpath)
			lprintf(zm,ZM_LOG_DEBUG,tempstr)

			IF(dupe_check(zm,fpath))
        lprintf(zm,ZM_LOG_DEBUG,'dupe check triggered')
        brk:=TRUE
        JUMP zreccont1
      ENDIF

			IF(fexist(fpath))
				l:=flength(fpath)
        StringF(tempstr,'\s already exists (\d bytes)',fpath,l)
				lprintf(zm,ZM_LOG_WARNING,tempstr)
				IF(l>=bytes)
          StringF(tempstr,'Local file size \d >= remote file size \d',l,bytes)
					lprintf(zm,ZM_LOG_WARNING,tempstr)
          p:=zm.zm_duplicate_filename
					IF(p=NIL)
            brk:=TRUE
            JUMP zreccont1
					ELSE
						IF(l > bytes)
							IF(p())
								loop:=TRUE
								JUMP zreccont1
							ENDIF
              brk:=TRUE
              JUMP zreccont1
						ENDIF
					ENDIF
				ENDIF
				IF((fp:=doOpen(zm,fpath,MODE_OLDFILE)))=NIL
          StringF(tempstr,'Error \d opening \s', IoErr(), fpath)
					lprintf(zm,ZM_LOG_ERR,tempstr)
          brk:=TRUE
          JUMP zreccont1
				ENDIF
				->setvbuf(fp,NULL,_IOFBF,$10000)

        StringF(tempstr,'Requesting CRC of remote file: \s', zm.current_file_name)
				lprintf(zm,ZM_LOG_NOTICE,tempstr)
				IF(zmodem_request_crc(zm, l))=FALSE 
					doClose(zm,fp)
					lprintf(zm,ZM_LOG_ERR,'Failed to request CRC of remote file')
          brk:=TRUE
          JUMP zreccont1
				ENDIF
        StringF(tempstr,'Calculating CRC of: \s', fpath)
				lprintf(zm,ZM_LOG_NOTICE,tempstr)
				crc:=fcrc32(zm,fp,l)	/* Warning: 4GB limit! */
				doClose(zm,fp)
        StringF(tempstr,'CRC of \s (\d bytes): \h[8]',fpath, l, crc)
				lprintf(zm,ZM_LOG_INFO,tempstr)
        StringF(tempstr,'Waiting for CRC of remote file: \s', zm.current_file_name)
				lprintf(zm,ZM_LOG_NOTICE,tempstr)
				IF(zmodem_recv_crc(zm,{rcrc}))=FALSE
					lprintf(zm,ZM_LOG_ERR,'Failed to get CRC of remote file')
          ->brk:=TRUE
          ->JUMP zreccont1
          rcrc:=crc
				ENDIF
				IF(crc<>rcrc)
          StringF(tempstr,'Remote file has different CRC value: \h[8]', rcrc)
					lprintf(zm,ZM_LOG_WARNING,tempstr)
          p:=zm.zm_duplicate_filename
					IF(p)
						IF(p())
							loop:=TRUE
              JUMP zreccont1
						ENDIF
					ENDIF
          brk:=TRUE
          JUMP zreccont1
				ENDIF
				IF(l=bytes) 
					lprintf(zm,ZM_LOG_INFO,'CRC, length, and filename match.')
          brk:=TRUE
          JUMP zreccont1
				ENDIF
        StringF(tempstr,'Resuming download of \s',fpath)
        lprintf(zm,ZM_LOG_INFO,tempstr)
			ENDIF

      t1,t2:=getZmSystemTime()
      zm.transfer_start_time1:=t1
      zm.transfer_start_time2:=t2

			IF((fp:=doOpen(zm,fpath,MODE_READWRITE)))=NIL
        StringF(tempstr,'Error \d opening/creating/appending \s',IoErr(),fpath)
				lprintf(zm,ZM_LOG_ERR,tempstr)
        brk:=TRUE
        JUMP zreccont1
			ENDIF

			start_bytes:=getFileSize(zm,fp)
			IF(start_bytes < 0) 
				doClose(zm,fp)

        StringF(tempstr,'Invalid file length \d: \s', start_bytes, fpath)
				lprintf(zm,ZM_LOG_ERR,tempstr)
				brk:=TRUE
        JUMP zreccont1
			ENDIF

			skip:=FALSE
			errors:=zmodem_recv_file_data(zm,fp,start_bytes)

			doClose(zm,fp)
      
      t1,t2:=getZmSystemTime()
      t:=Mul((t1-zm.transfer_start_time1),50)+t2-zm.transfer_start_time2
      IF t<=0 THEN t:=1
      IF timetaken<>NIL THEN timetaken[]:=timetaken[]+t

			l:=flength(fpath)
			IF(errors AND (l=0))	/* aborted/failed download */
				IF(DeleteFile(fpath))	/* don't save 0-byte file */
          StringF(tempstr,'Error \d removing \s',IoErr(),fpath)
					lprintf(zm,ZM_LOG_ERR,tempstr)
				ELSE
          StringF(tempstr,'Deleted 0-byte file \s',fpath)
					lprintf(zm,ZM_LOG_INFO,tempstr)
        ENDIF
			ELSE
				IF(l<bytes)
          StringF(tempstr,'Incomplete download \d bytes received, expected \d',l,bytes)
					lprintf(zm,ZM_LOG_WARNING,tempstr)
          upload_failed(zm,fpath)
				ELSE
					b:=l-start_bytes

          IF t>0
            IF b>40000000
              cps:=Div(b,Div(t,50)) 
            ELSE
              cps:=Div(Mul(b,50),t) 
            ENDIF
          ELSE
            cps:=b
          ENDIF
          IF cps=0 THEN cps:=1
          StringF(tempstr,'Received \d bytes successfully (\d CPS)',b,cps)
					lprintf(zm,ZM_LOG_INFO,tempstr)
					files_received++
					IF(bytes_received<>NIL) THEN bytes_received[]:=bytes_received[]+b
          upload_completed(zm,fpath,l) 
				ENDIF
				IF(zm.current_file_time) THEN SetFileDate(fpath,zm.current_file_time)
			ENDIF 

zreccont1:
    UNTIL (loop=FALSE) OR (brk=TRUE)
		/* finally */
		IF(skip) 
			lprintf(zm,ZM_LOG_DEBUG,'Skipping file')
			zmodem_send_zskip(zm)
		ENDIF
		zm.current_file_num:=zm.current_file_num+1
	ENDWHILE
	IF(zm.local_abort) THEN zmodem_send_zabort(zm)

	/* wait for "over-and-out" */
	timeout:=zm.recv_timeout
	zm.recv_timeout:=2
	IF(zmodem_rx(zm)="O") THEN zmodem_rx(zm)
	zm.recv_timeout:=timeout

ENDPROC files_received


PROC zmodem_recv_init(zm: PTR TO zmodem_t)

	DEF type=CAN
	DEF errors
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

	->lprintf(zm,ZM_LOG_DEBUG,'recv_init')

->#if 0
->	while(is_connected(zm) && !is_cancelled(zm) && (ch=zm.recv_byte(zm,0))!=NOINP)
->		lprintf(zm,ZM_LOG_DEBUG,"Throwing out received: %s",chr((uchar)ch))
->#endif

  errors:=0
  WHILE ((errors<=zm.max_errors) AND (is_cancelled(zm)=FALSE) AND (is_connected(zm)))
		IF(errors)
      StringF(tempstr,'Sending ZRINIT (\d of \d)',errors+1, zm.max_errors+1)
			lprintf(zm,ZM_LOG_NOTICE,tempstr)
		ELSE
			lprintf(zm,ZM_LOG_INFO,'Sending ZRINIT')
    ENDIF
		zmodem_send_zrinit(zm)

		type:=zmodem_recv_header(zm)

    EXIT  zm.local_abort

		IF(type=TIMEOUT) 
      errors++
      JUMP zmicont1
    ENDIF

    chr(type,tempstr)
    StringF(tempstr2,'recv_init: Received \s',tempstr)
		lprintf(zm,ZM_LOG_DEBUG,tempstr2)

		IF(type=ZFILE) 
			zmodem_parse_zfile_subpacket(zm)
			RETURN type
		ENDIF

		IF(type=ZFIN)
			zmodem_send_zfin(zm)	/* ACK */
			RETURN type
		ENDIF

    frame_desc(type,tempstr)
    StringF(tempstr2,'recv_init: Received \s instead of ZFILE or ZFIN',tempstr)
		lprintf(zm,ZM_LOG_WARNING,tempstr2)
    StringF(tempstr,'ZF0=\h[2] ZF1=\h[2] ZF2=\h[2] ZF3=\h[2]',zm.rxd_header[ZF0],zm.rxd_header[ZF1],zm.rxd_header[ZF2],zm.rxd_header[ZF3])
		lprintf(zm,ZM_LOG_DEBUG,tempstr)
    errors++

zmicont1:

	ENDWHILE

ENDPROC type

PROC zmodem_parse_zfile_subpacket(zm: PTR TO zmodem_t)

	DEF i
	DEF	mode=0
	DEF serial=-1
  DEF tempstr[255]:STRING
	DEF	tmptime
  DEF tmp,s,r

	strcopy(zm.current_file_name,zm.rx_data_subpacket)

	zm.current_file_size:=0
	zm.current_file_time:=0
	zm.files_remaining:=0
	zm.bytes_remaining:=0

/*	i=sscanf((char*)zm.rx_data_subpacket+strlen((char*)zm.rx_data_subpacket)+1,"%"SCNd64" %lo %o %lo %u %"SCNd64
		,&zm.current_file_size	/* file size (decimal) */
		,&tmptime				/* file time (octal unix format) */
		,&mode					/* file mode */
		,&serial				/* program serial number */
		,&zm.files_remaining	/* remaining files to be sent */
		,&zm.bytes_remaining	/* remaining bytes to be sent */
		);*/
    
  s:=zm.rx_data_subpacket+StrLen(zm.rx_data_subpacket)+1
  tmp,r:=Val(s)
  zm.current_file_size:=tmp
  s:=s+r
  tmptime,r:=Val(s)
  s:=s+r
  mode,r:=Val(s)
  s:=s+r
  serial,r:=Val(s)
  tmp,r:=Val(s)
  zm.files_remaining:=tmp
  s:=s+r
  tmp,r:=Val(s)
  zm.bytes_remaining:=tmp
    
	zm.current_file_time:=tmptime

  StringF(tempstr,'Zmodem file (ZFILE) data (\d fields): \d',i, zm.rx_data_subpacket+StrLen(zm.rx_data_subpacket)+1)
	lprintf(zm,ZM_LOG_DEBUG,tempstr)

	IF(zm.files_remaining)=FALSE THEN zm.files_remaining:=1
	
  IF(zm.bytes_remaining)=FALSE THEN zm.bytes_remaining:= zm.current_file_size

	IF(zm.total_files)=FALSE THEN zm.total_files:=zm.files_remaining
	
  IF(zm.total_bytes)=FALSE THEN zm.total_bytes:=zm.bytes_remaining
ENDPROC

/*
 * receive file data until the end of the file or until something goes wrong.
 * the name is only used to show progress
 */

PROC zmodem_recv_file_data(zm: PTR TO zmodem_t, fp, offset)
	DEF	type=0
	DEF errors=0
	DEF	pos
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF brk=FALSE
  
	zm.transfer_start_pos:=offset

	IF(doSeek(zm,fp,offset,OFFSET_BEGINNING))<0 
    StringF(tempstr,'ERROR \d seeking to file offset \d',IoErr(), offset)
		lprintf(zm,ZM_LOG_ERR,tempstr)
		zmodem_send_pos_header(zm, ZFERR, offset, /* Hex? */ TRUE)
		RETURN 1 /* errors */
	ENDIF

  zm.new_file:=TRUE
  pos:=offset


	/*  zmodem.doc:

		The zmodem receiver uses the file length [from ZFILE data] as an estimate only.
		It may be used to display an estimate of the transmission time,
		and may be compared with the amount of free disk space.  The
		actual length of the received file is determined by the data
		transfer. A file may grow after transmission commences, and
		all the data will be sent.
	*/

	WHILE((errors<=zm.max_errors) AND (is_connected(zm)) AND (is_cancelled(zm)=FALSE))

		IF(pos>zm.current_file_size) THEN zm.current_file_size:= pos

		IF((zm.max_file_size<>0) AND (pos >= zm.max_file_size))
      StringF(tempstr,'Specified maximum file size (\d bytes) reached at offset \d',zm.max_file_size, pos)
			lprintf(zm,ZM_LOG_WARNING,tempstr)
				
			zmodem_send_pos_header(zm, ZFERR, pos, /* Hex? */ TRUE)
      brk:=TRUE
		ENDIF
    EXIT brk

		IF(type<>ENDOFFRAME) THEN zmodem_send_pos_header(zm, ZRPOS, pos, /* Hex? */ TRUE)

		type:=zmodem_recv_file_frame(zm,fp,{pos})  
    zm.new_file:=FALSE

		EXIT ((type = ZEOF) OR (type = ZFIN))

		IF(type=ENDOFFRAME)
      StringF(tempstr,'Received complete frame at offset: \d', pos)
			lprintf(zm,ZM_LOG_DEBUG,tempstr)
		ELSE
			IF((type>0) AND (zm.local_abort=FALSE))
        chr(type,tempstr)
        StringF(tempstr2,'Received \s at offset: \d', tempstr, pos)
				lprintf(zm,ZM_LOG_DEBUG,tempstr2)
      ENDIF
			errors++
		ENDIF
	ENDWHILE
  zm.new_file:=FALSE

	/*
 	 * wait for the eof header
	 */
  errors:=0
	WHILE (errors<=zm.max_errors) AND (is_cancelled(zm)=FALSE) AND (type<>ZEOF) AND (type<>ZFIN)
		type:=zmodem_recv_header_and_check(zm)
    errors++
  ENDWHILE
ENDPROC errors


PROC zmodem_recv_file_frame(zm: PTR TO zmodem_t, fp,pos:PTR TO LONG)
	DEF n
	DEF type
	DEF attempt
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF p
  DEF offset
  
	/*
	 * wait for a ZDATA header with the right file offset
	 * or a timeout or a ZFIN
	 */
  offset:=pos[]
  attempt:=0
  LOOP
		IF(attempt>=zm.max_errors) THEN RETURN TIMEOUT

		type:=zmodem_recv_header(zm)
    IF (type=ZEOF)
				/* ZMODEM.DOC:
				   If the receiver has not received all the bytes of the file, 
				   the receiver ignores the ZEOF because a new ZDATA is coming.
				*/
				IF(zm.rxd_header_pos=pos[]) THEN RETURN type

        StringF(tempstr,'Ignoring ZEOF as all bytes (\d) have not been received',zm.rxd_header_pos)
				lprintf(zm,ZM_LOG_WARNING,tempstr)
				JUMP recframecont
    ELSEIF (type=ZFIN) OR (type=TIMEOUT)
			RETURN type
		ENDIF
		IF((is_cancelled(zm)) OR (is_connected(zm))=FALSE) THEN RETURN ZCAN

    EXIT type=ZDATA

    frame_desc(type,tempstr)
    StringF(tempstr2,'Received \s instead of ZDATA frame', tempstr)
		lprintf(zm,ZM_LOG_WARNING,tempstr2)

recframecont:

    attempt++
	ENDLOOP

  lprintf(zm,ZM_LOG_WARNING,'received ZDATA frame')
	IF(zm.rxd_header_pos<>pos[])
    StringF(tempstr,'Received wrong ZDATA frame (\d vs \d)"',zm.rxd_header_pos, pos[])
		lprintf(zm,ZM_LOG_WARNING,tempstr)
		RETURN FALSE
	ENDIF
	
	REPEAT
  ->lprintf(zm,ZM_LOG_DEBUG,'recv_file_frame zmodem_recv_data')
		type:=zmodem_recv_data(zm,zm.rx_data_subpacket,RXSUBPACKETSIZE,{n},TRUE)
  ->lprintf(zm,ZM_LOG_DEBUG,'recv_file_frame zmodem_recv_data complete')

/*		fprintf(stderr,"packet len %d type %d\n",n,type)
*/
		IF ((type = ENDOFFRAME) OR (type = FRAMEOK))
			IF(doWrite(zm,fp,zm.rx_data_subpacket,n)<>n) 
        StringF(tempstr,'ERROR \d writing \d bytes at file offset \d',IoErr(), n,pos[])
				lprintf(zm,ZM_LOG_ERR,tempstr)
				zmodem_send_pos_header(zm, ZFERR, pos[], /* Hex? */ TRUE)
				RETURN FALSE
			ENDIF
      pos[]:=pos[]+n
		ENDIF

		IF(type=FRAMEOK) THEN zm.block_size:=n

    p:=zm.zm_progress
		IF(p<>NIL) THEN p(pos[],pos[]-offset,zm.current_file_size,zm.transfer_start_time1,zm.transfer_start_time2,zm.errors,zm.transfer_start_pos,zm.current_file_name,zm.new_file,zm.block_size)    
    zm.new_file:=FALSE

		IF(is_cancelled(zm)) THEN RETURN ZCAN
  UNTIL type<>FRAMEOK
  lprintf(zm,ZM_LOG_DEBUG,'recv_file_frame complete')
ENDPROC type

EXPORT PROC zmodem_init(zm: PTR TO zmodem_t, cbdata: PTR TO CHAR,
        lputs,progress,recv_byte,is_connected,is_cancelled,
        data_waiting,upload_completed,upload_failed,dupecheck,
        flush,duplicate_filename,fileopen,fileclose,fileseek,
        fileread,filewrite,firstfile,nextfile,
        block_size,max_errors,iacEncode,sendbufsize)
  
	->memset(zm,0,SIZEOF zmodem_t)

	/* Use sane default values */
	zm.init_timeout:=10		/* seconds */
	zm.send_timeout:=10		/* seconds (reduced from 15) */
	zm.recv_timeout:=10		/* seconds (reduced from 20) */
	zm.crc_timeout:=120		/* seconds */

  zm.can_break:=TRUE
  zm.can_fcs_32:=TRUE
  zm.want_fcs_16:=FALSE
  zm.escape_ctrl_chars:=FALSE
  zm.escape_8th_bit:=FALSE
  zm.no_streaming:=FALSE

  zm.iacEncode:=iacEncode

  IF block_size<>0 
    zm.block_size:=block_size
    zm.max_block_size:=block_size
  ELSE
    zm.block_size:=ZBLOCKLEN
    zm.max_block_size:=ZBLOCKLEN
  ENDIF

	IF max_errors<>0 THEN zm.max_errors:=max_errors ELSE zm.max_errors:=9

	zm.cbdata:=cbdata
	zm.zm_lputs:=lputs
	zm.zm_progress:=progress
	zm.zm_recv_byte:=recv_byte
	zm.zm_is_connected:=is_connected
	zm.zm_is_cancelled:=is_cancelled
	zm.zm_data_waiting:=data_waiting
  zm.zm_upload_completed:=upload_completed
  zm.zm_upload_failed:=upload_failed
  zm.zm_dupecheck:=dupecheck
	zm.zm_flush:=flush
  zm.zm_duplicate_filename:=duplicate_filename
  zm.zm_fopen:=fileopen
  zm.zm_fclose:=fileclose
  zm.zm_fseek:=fileseek
  zm.zm_fread:=fileread
  zm.zm_fwrite:=filewrite
  zm.zm_firstfile:=firstfile
  zm.zm_nextfile:=nextfile

  zm.tx_data_subpacket:=New(TXSUBPACKETSIZE)
  zm.rx_data_subpacket:=New(RXSUBPACKETSIZE)
  
  IF sendbufsize<(zm.max_block_size+512)*2 THEN sendbufsize:=(zm.max_block_size+512)*2
  zm.sendBufferSize:=sendbufsize
  zm.sendBuffer:=New(zm.sendBufferSize)
  zm.sendBufferPtr:=zm.sendBuffer
  zm.sendBufferEnd:=zm.sendBuffer+zm.sendBufferSize
  
  zm.crc16tbl:={crc16tbl}
  zm.crc32tbl:={crc32tbl}
ENDPROC

EXPORT PROC zmodem_cleanup(zm: PTR TO zmodem_t)
  Dispose(zm.tx_data_subpacket)
  Dispose(zm.rx_data_subpacket)
  Dispose(zm.sendBuffer)
ENDPROC

PROC doOpen(zm:PTR TO zmodem_t,fname,mode)
  DEF p
  p:=zm.zm_fopen
  IF p<>NIL
    RETURN p(fname,mode)
  ENDIF
  lprintf(zm,ZM_LOG_WARNING,'zm_fopen not set, defaulting to dos library Open')
ENDPROC Open(fname,mode)

PROC doClose(zm:PTR TO zmodem_t,fhandle)
  DEF p
  p:=zm.zm_fclose
  IF p<>NIL
    RETURN p(fhandle,(zm.send_successful) AND (zm.file_skipped=FALSE))
  ENDIF
  lprintf(zm,ZM_LOG_WARNING,'zm_fclose not set, defaulting to dos library Close') 
ENDPROC Close(fhandle)

PROC doSeek(zm:PTR TO zmodem_t,fhandle,pos,origin)
  DEF p
  p:=zm.zm_fseek
  IF p<>NIL
    RETURN p(fhandle,pos,origin)
  ENDIF
  lprintf(zm,ZM_LOG_WARNING,'zm_fseek not set, defaulting to dos library Seek')
ENDPROC Seek(fhandle,pos,origin)

PROC doRead(zm:PTR TO zmodem_t,fhandle,buffer,length)
  DEF p
  p:=zm.zm_fread
  IF p<>NIL
    RETURN p(fhandle,buffer,length)
  ENDIF
  ->lprintf(zm,ZM_LOG_WARNING,'zm_fread not set, defaulting to dos library FRead')
ENDPROC Fread(fhandle,buffer,1,length)

PROC doWrite(zm:PTR TO zmodem_t,fhandle,buffer,length)
  DEF p
  p:=zm.zm_fwrite
  IF p<>NIL
    RETURN p(fhandle,buffer,length)
  ENDIF
  ->lprintf(zm,ZM_LOG_WARNING,'zm_fwrite not set, defaulting to dos library FWrite')
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

crc32tbl: LONG  $00000000, $77073096, $ee0e612c, $990951ba, $076dc419, $706af48f, $e963a535, $9e6495a3,
  $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988, $09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91,
  $1db71064, $6ab020f2, $f3b97148, $84be41de, $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
  $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec, $14015c4f, $63066cd9, $fa0f3d63, $8d080df5,
  $3b6e20c8, $4c69105e, $d56041e4, $a2677172, $3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b,
  $35b5a8fa, $42b2986c, $dbbbc9d6, $acbcf940, $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,
  $26d930ac, $51de003a, $c8d75180, $bfd06116, $21b4f4b5, $56b3c423, $cfba9599, $b8bda50f,
  $2802b89e, $5f058808, $c60cd9b2, $b10be924, $2f6f7c87, $58684c11, $c1611dab, $b6662d3d,
  $76dc4190, $01db7106, $98d220bc, $efd5102a, $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
  $7807c9a2, $0f00f934, $9609a88e, $e10e9818, $7f6a0dbb, $086d3d2d, $91646c97, $e6635c01,
  $6b6b51f4, $1c6c6162, $856530d8, $f262004e, $6c0695ed, $1b01a57b, $8208f4c1, $f50fc457,
  $65b0d9c6, $12b7e950, $8bbeb8ea, $fcb9887c, $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,
  $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2, $4adfa541, $3dd895d7, $a4d1c46d, $d3d6f4fb,
  $4369e96a, $346ed9fc, $ad678846, $da60b8d0, $44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9,
  $5005713c, $270241aa, $be0b1010, $c90c2086, $5768b525, $206f85b3, $b966d409, $ce61e49f,
  $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4, $59b33d17, $2eb40d81, $b7bd5c3b, $c0ba6cad,
  $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a, $ead54739, $9dd277af, $04db2615, $73dc1683,
  $e3630b12, $94643b84, $0d6d6a3e, $7a6a5aa8, $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,
  $f00f9344, $8708a3d2, $1e01f268, $6906c2fe, $f762575d, $806567cb, $196c3671, $6e6b06e7,
  $fed41b76, $89d32be0, $10da7a5a, $67dd4acc, $f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5,
  $d6d6a3e8, $a1d1937e, $38d8c2c4, $4fdff252, $d1bb67f1, $a6bc5767, $3fb506dd, $48b2364b,
  $d80d2bda, $af0a1b4c, $36034af6, $41047a60, $df60efc3, $a867df55, $316e8eef, $4669be79,
  $cb61b38c, $bc66831a, $256fd2a0, $5268e236, $cc0c7795, $bb0b4703, $220216b9, $5505262f,
  $c5ba3bbe, $b2bd0b28, $2bb45a92, $5cb36a04, $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,
  $9b64c2b0, $ec63f226, $756aa39c, $026d930a, $9c0906a9, $eb0e363f, $72076785, $05005713,
  $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38, $92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21,
  $86d3d2d4, $f1d4e242, $68ddb3f8, $1fda836e, $81be16cd, $f6b9265b, $6fb077e1, $18b74777,
  $88085ae6, $ff0f6a70, $66063bca, $11010b5c, $8f659eff, $f862ae69, $616bffd3, $166ccf45,
  $a00ae278, $d70dd2ee, $4e048354, $3903b3c2, $a7672661, $d06016f7, $4969474d, $3e6e77db,
  $aed16a4a, $d9d65adc, $40df0b66, $37d83bf0, $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,
  $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6, $bad03605, $cdd70693, $54de5729, $23d967bf,
  $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94, $b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d
