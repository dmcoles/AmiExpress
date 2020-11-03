
OPT MODULE
OPT EXPORT

CONST 	IPPROTO_IP=0		/* dummy for IP */
CONST 	IPPROTO_ICMP=1		/* control message protocol */
CONST 	IPPROTO_GGP=3		/* gateway^2 (deprecated) */
CONST 	IPPROTO_TCP=6		/* tcp */
CONST 	IPPROTO_EGP=8		/* exterior gateway protocol */
CONST 	IPPROTO_PUP=12		/* pup */
CONST 	IPPROTO_UDP=17		/* user datagram protocol */
CONST 	IPPROTO_IDP=22		/* xns idp */
CONST 	IPPROTO_TP=29 		/* tp-4 w/ class negotiation */
CONST 	IPPROTO_EON=80		/* ISO cnlp */

CONST 	IPPROTO_RAW=255		/* raw IP packet */
CONST 	IPPROTO_MAX=256


CONST 	IPPORT_RESERVED=1024
CONST 	IPPORT_USERRESERVED=5000

/*OBJECT in_addr
	s_addr:LONG
ENDOBJECT*/

->CONST 	IN_CLASSA(i)		(((long)(i) & 0x80000000) == 0)
PROC in_classa(i) IS IF (i AND $80000000) THEN FALSE ELSE TRUE
CONST 	IN_CLASSA_NET=$ff000000
CONST 	IN_CLASSA_NSHIFT=4
CONST 	IN_CLASSA_HOST=$00ffffff
CONST 	IN_CLASSA_MAX=128

->CONST 	IN_CLASSB(i)		(((long)(i) & 0xc0000000) == 0x80000000)
PROC in_classb(i) IS IF (i AND $c0000000)=$80000000 THEN TRUE ELSE FALSE
CONST 	IN_CLASSB_NET=$ffff0000
CONST 	IN_CLASSB_NSHIFT=16
CONST 	IN_CLASSB_HOST=$0000ffff
CONST 	IN_CLASSB_MAX=65536

->CONST 	IN_CLASSC(i)		(((long)(i) & 0xe0000000) == 0xc0000000)
PROC in_classc(i) IS IF (i AND $e0000000)=$c0000000 THEN TRUE ELSE FALSE
CONST 	IN_CLASSC_NET=$ffffff00
CONST 	IN_CLASSC_NSHIFT=8
CONST 	IN_CLASSC_HOST=$000000ff

->CONST 	IN_CLASSD(i)		(((long)(i) & 0xf0000000) == 0xe0000000)
PROC in_classd(i) IS IF (i AND $f0000000)=$e0000000 THEN TRUE ELSE FALSE
->CONST 	IN_MULTICAST(i)		IN_CLASSD(i)
PROC in_multicast(i) IS in_classd(i)

->CONST 	IN_EXPERIMENTAL(i)	(((long)(i) & 0xe0000000) == 0xe0000000)
PROC in_experimental(i) IS IF (i AND $e0000000)=$e0000000 THEN TRUE ELSE FALSE
->CONST 	IN_BADCLASS(i)		(((long)(i) & 0xf0000000) == 0xf0000000)
PROC in_badclass(i) IS IF (i AND $f0000000)=$f0000000 THEN TRUE ELSE FALSE

CONST 	INADDR_ANY=0
CONST		 INADDR_BROADCAST=$ffffffff	/* must be masked */
CONST					INADDR_NONE=$ffffffff		/* -1 return */
CONST 	IN_LOOPBACKNET=127			/* official! */

/*
 * Socket address, internet style.
 */
OBJECT sockaddr_in
	sin_len:CHAR
	sin_family:CHAR
	sin_port:INT
	sin_addr:LONG
	sin_zero[8]:ARRAY OF CHAR
ENDOBJECT

/*
 * Structure used to describe IP options.
 * Used to store options internally, to pass them to a process,
 * or to restore options retrieved earlier.
 * The ip_dst is used for the first-hop gateway when using a source route
 * (this gets put into the header proper).
 */
OBJECT ip_opts
	ip_dst:LONG;		/* first hop, 0 w/o src rt */
	ip_opts[40]:ARRAY OF CHAR;		/* actually variable in size */
ENDOBJECT

/*
 * Options for use with [gs]etsockopt at the IP level.
 * First word of comment is data type; bool is stored in int.
 */
CONST 	IP_OPTIONS=1	/* buf/ip_opts; set/get IP per-packet options */
CONST 	IP_HDRINCL=2	/* int; header is included with data (raw) */
CONST 	IP_TOS=3	/* int; IP type of service and precedence */
CONST 	IP_TTL=4	/* int; IP time to live */
CONST 	IP_RECVOPTS=5	/* bool; receive all IP options w/datagram */
CONST 	IP_RECVRETOPTS=6	/* bool; receive IP options for response */
CONST 	IP_RECVDSTADDR=7	/* bool; receive IP dst addr w/datagram */
CONST 	IP_RETOPTS=8	/* ip_opts; set/get IP per-packet options */

