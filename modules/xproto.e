OPT MODULE
OPT EXPORT

OPT PREPROCESS

OBJECT xprIO
  xpr_filename: PTR TO CHAR /* File name(s) */
  xpr_fopen: LONG    /* Open file */ ->long (* __asm xpr_fopen)(register __a0 char *filename,register __a1 char *accessmode);
  xpr_fclose: LONG   /* Close file */ ->long (* __asm xpr_fclose)(register __a0 long filepointer);
  xpr_fread: LONG    /* Get char from file */ ->long (* __asm xpr_fread)(register __a0 char *buffer,register __d0 long size,register __d1 long count,register __a1 long fileptr);
  xpr_fwrite: LONG   /* Put string to file */ ->long (* __asm xpr_fwrite)(register __a0 char *buffer,register __d0 long size,register __d1 long count,register __a1 long fileptr);
  xpr_sread: LONG    /* Get char from serial */ ->long (* __asm)(register __a0 char *buffer,register __d0 long size,register __d1 long timeout);
  xpr_swrite: LONG   /* Put string to serial */ ->long (* __asm xpr_swrite)(register __a0 char *buffer,register __d0 long size);
  xpr_sflush: LONG   /* Flush serial input buffer */ ->long (*xpr_sflush)(void);
  xpr_update:LONG    /* Print stuff */ ->long (* __asm xpr_update)(register __a0 struct XPR_UPDATE *updatestruct);
  xpr_chkabort:LONG  /* Check for abort */ ->long (*xpr_chkabort)(void);
  xpr_chkmisc:LONG   /* Check misc. stuff */ ->		  void (*xpr_chkmisc)(void);
  xpr_gets:LONG      /* Get string interactively */ ->	long (* __asm xpr_gets)(register __a0 char *prompt,register __a1 char *buffer);
  xpr_setserial:LONG /* Set and Get serial info */ ->long (* __asm xpr_setserial)(register __d0 long newstatus);
  xpr_ffirst:LONG    /* Find first file name */ ->long (* __asm xpr_ffirst)(register __a0 char *buffer,register __a1 char *pattern);
  xpr_fnext:LONG     /* Find next file name */ ->long (* __asm xpr_fnext)(register __d0 long oldstate,register __a0 char *buffer,register __a1 char *pattern);
  xpr_finfo:LONG     /* Return file info */ ->long (* __asm xpr_finfo)(register __a0 char *filename,register __d0 long typeofinfo);
  xpr_fseek:LONG     /* Seek in a file */ ->long (* __asm xpr_fseek)(register __a0 long fileptr,register __d0 long offset,register __d1 long origin);
  xpr_extension:LONG /* Number of extensions */
  xpr_data: PTR TO LONG /* Initialized by Setup. */
  xpr_options: LONG  /* Multiple XPR options. */ ->long (* __asm xpr_options)(register __d0 long n,register __a0 struct xpr_option **opt);
  xpr_unlink:LONG    /* Delete a file. */ ->long (* __asm xpr_unlink)(register __a0 char *filename);
  xpr_squery: LONG   /* Query serial device */ ->		  long (*xpr_squery)(void);
  xpr_getptr: LONG   /* Get various host ptrs */ ->long (* __asm xpr_getptr)(register __d0 long type);
ENDOBJECT
	      
/*
*   Number of defined extensions
*/
CONST XPR_EXTENSION=6

/*
*   Flags returned by XProtocolSetup()
*/
CONST XPRS_FAILURE=0
CONST XPRS_SUCCESS=1
CONST XPRS_NORECREQ=2
CONST XPRS_NOSNDREQ=4
CONST XPRS_HOSTMON=8
CONST XPRS_USERMON=16
CONST XPRS_HOSTNOWAIT=32
CONST XPRS_NOUPDATE=$8000
CONST XPRS_SMARTXFER=$10000
CONST XPRS_DOUBLE=$20000

OBJECT xpr_update
  xpru_updatemask: LONG
	xpru_protocol: PTR TO CHAR
	xpru_filename: PTR TO CHAR
	xpru_filesize: LONG
	xpru_msg: PTR TO CHAR
	xpru_errormsg: PTR TO CHAR
	xpru_blocks:LONG
	xpru_blocksize:LONG
	xpru_bytes:LONG
	xpru_errors:LONG
	xpru_timeouts:LONG
	xpru_packettype:LONG
	xpru_packetdelay:LONG
	xpru_chardelay:LONG
	xpru_blockcheck:PTR TO CHAR
	xpru_expecttime:PTR TO CHAR
	xpru_elapsedtime:PTR TO CHAR
	xpru_datarate:LONG
	xpru_reserved1:LONG
	xpru_reserved2:LONG
	xpru_reserved3:LONG
	xpru_reserved4:LONG
	xpru_reserved5:LONG
ENDOBJECT

/*
*   The possible bit values for the xpru_updatemask are:
*/
CONST XPRU_UPLOAD=$80000000
CONST XPRU_DNLOAD=$40000000
CONST XPRU_PROTOCOL=1
CONST XPRU_FILENAME=2
CONST XPRU_FILESIZE=4
CONST XPRU_MSG=8
CONST XPRU_ERRORMSG=16
CONST XPRU_BLOCKS=32
CONST XPRU_BLOCKSIZE=64
CONST XPRU_BYTES=128
CONST XPRU_ERRORS=256
CONST XPRU_TIMEOUTS	=512
CONST XPRU_PACKETTYPE=1024
CONST XPRU_PACKETDELAY=2048
CONST XPRU_CHARDELAY=4096
CONST XPRU_BLOCKCHECK=8192
CONST XPRU_EXPECTTIME=16384
CONST XPRU_ELAPSEDTIME=32768
CONST XPRU_DATARATE=65536

/*
*   The xpro_option structure
*/

OBJECT xpr_option
   xpro_description:PTR TO CHAR	/* description of the option		      */
   xpro_type:LONG		/* type of option			      */
   xpro_value:PTR TO CHAR		/* pointer to a buffer with the current value */
   xpro_length:LONG		/* buffer size				      */
ENDOBJECT

/*
*   Valid values for xpro_type are:
*/
CONST XPRO_BOOLEAN=1 	/* xpro_value is "yes", "no", "on" or "off"   */
CONST XPRO_LONG=2   	/* xpro_value is string representing a number */
CONST XPRO_STRING=3 	/* xpro_value is a string		      */
CONST XPRO_HEADER=4  	/* xpro_value is ignored		      */
CONST XPRO_COMMAND=5 	/* xpro_value is ignored		      */
CONST XPRO_COMMPAR=6 	/* xpro_value contains command parameters     */
