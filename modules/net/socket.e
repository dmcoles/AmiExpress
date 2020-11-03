OPT MODULE
OPT EXPORT

MODULE	'exec/types'
MODULE	'socket'

CONST FD_ACCEPT=$001	/* there is a connection to accept() */
CONST FD_CONNECT=$002	/* connect() completed */
CONST FD_OOB=$004	/* socket has out-of-band data */
CONST FD_READ=$008	/* socket is readable */
CONST FD_WRITE=$010	/* socket is writeable */
CONST FD_ERROR=$020	/* asynchronous error on socket */
CONST FD_CLOSE=$040	/* connection closed (graceful or not) */

CONST UNIQUE_ID=-1

CONST SOCK_STREAM=1		/* stream socket */
CONST SOCK_DGRAM=2		/* datagram socket */
CONST SOCK_RAW=3		/* raw-protocol interface */
CONST SOCK_RDM=4		/* reliably-delivered message */
CONST SOCK_SEQPACKET=5		/* sequenced packet stream */

CONST SO_DEBUG=$0001		/* turn on debugging info recording */
CONST SO_ACCEPTCONN=$0002		/* socket has had listen() */
CONST SO_REUSEADDR=$0004		/* allow local address reuse */
CONST SO_KEEPALIVE=$0008		/* keep connections alive */
CONST SO_DONTROUTE=$0010		/* just use interface addresses */
CONST SO_BROADCAST=$0020		/* permit sending of broadcast msgs */
CONST SO_USELOOPBACK=$0040		/* bypass hardware when possible */
CONST SO_LINGER=$0080		/* linger on close if data present */
CONST SO_OOBINLINE=$0100		/* leave received OOB data in line */

CONST SO_SNDBUF=$1001		/* send buffer size */
CONST SO_RCVBUF=$1002		/* receive buffer size */
CONST SO_SNDLOWAT=$1003		/* send low-water mark */
CONST SO_RCVLOWAT=$1004		/* receive low-water mark */
CONST SO_SNDTIMEO=$1005		/* send timeout */
CONST SO_RCVTIMEO=$1006		/* receive timeout */
CONST SO_ERROR=$1007		/* get error status and clear */
CONST SO_TYPE=$1008		/* get socket type */

CONST SO_EVENTMASK=$2001		/* socket event mask,     */

/*
 * Structure used for manipulating linger option.
 */
OBJECT linger   /* option on/off */
	l_onoff:INT   /* linger time */
	l_linger:INT
ENDOBJECT

/*
 * Level number for (get/set)sockopt() to apply to socket itself.
 */
CONST SOL_SOCKET=$ffff		/* options for socket level */

/*
 * Address families.
 */
CONST AF_UNSPEC=0		/* unspecified */
CONST AF_UNIX=1		/* local to host (pipes, portals) */
CONST AF_INET=2		/* internetwork: UDP, TCP, etc. */
CONST AF_IMPLINK=3		/* arpanet imp addresses */
CONST AF_PUP=4		/* pup protocols: e.g. BSP */
CONST AF_CHAOS=5		/* mit CHAOS protocols */
CONST AF_NS=6		/* XEROX NS protocols */
CONST AF_ISO=7		/* ISO protocols */
CONST AF_OSI=AF_ISO
CONST AF_ECMA=8		/* european computer manufacturers */
CONST AF_DATAKIT=9		/* datakit protocols */
CONST AF_CCITT=10		/* CCITT protocols, X.25 etc */
CONST AF_SNA=11		/* IBM SNA */
CONST AF_DECnet=12		/* DECnet */
CONST AF_DLI=13		/* DEC Direct data link interface */
CONST AF_LAT=14		/* LAT */
CONST AF_HYLINK=15		/* NSC Hyperchannel */
CONST AF_APPLETALK=16		/* Apple Talk */
CONST AF_ROUTE=17		/* Internal Routing Protocol */
CONST AF_LINK=18		/* Link layer interface */
CONST PSEUDO_AF_XTP=19		/* eXpress Transfer Protocol (no AF) */
CONST AF_MAX=20

/*
 * Structure used by kernel to store most
 * addresses.
 */

OBJECT sockaddr
	sa_len:CHAR 			/* total length */
	sa_family:CHAR 		/* address family */
	sa_data[14]:ARRAY OF CHAR;		/* actually longer; address value */
ENDOBJECT

/*
 * Structure used by kernel to pass protocol
 * information in raw sockets.
 */
OBJECT sockproto
	sp_family:INT		/* address family */
	sp_protocol:INT		/* protocol */
ENDOBJECT

/*
 * Protocol families, same as address families for now.
 */
CONST PF_UNSPEC=AF_UNSPEC
CONST PF_UNIX=AF_UNIX
CONST PF_INET=AF_INET
CONST PF_IMPLINK=AF_IMPLINK
CONST PF_PUP=AF_PUP
CONST PF_CHAOS=AF_CHAOS
CONST PF_NS=AF_NS
CONST PF_ISO=AF_ISO
CONST PF_OSI=AF_ISO
CONST PF_ECMA=AF_ECMA
CONST PF_DATAKIT=AF_DATAKIT
CONST PF_CCITT=AF_CCITT
CONST PF_SNA=AF_SNA
CONST PF_DECnet=AF_DECnet
CONST PF_DLI=AF_DLI
CONST PF_LAT=AF_LAT
CONST PF_HYLINK=AF_HYLINK
CONST PF_APPLETALK=AF_APPLETALK
CONST PF_ROUTE=AF_ROUTE
CONST PF_LINK=AF_LINK
CONST PF_XTP=PSEUDO_AF_XTP	/* really just proto family, no AF */

CONST PF_MAX=AF_MAX

/*
 * Maximum queue length specifiable by listen.
 */
CONST SOMAXCONN=5

/*
 * Message header for recvmsg and sendmsg calls.
 * Used value-result for recvmsg, value only for sendmsg.
 */
OBJECT iovec
	iov_base:LONG
	iov_len:INT
ENDOBJECT
/*
OBJECT msghdr
	msg_name:LONG					/* optional address */
	msg_namelen:INT				/* size of address */
	struct	iovec *msg_iov;		/* scatter/gather array */
	u_int	msg_iovlen;		/* # elements in msg_iov */
	caddr_t	msg_control;		/* ancillary data, see below */
	u_int	msg_controllen;		/* ancillary data buffer len */
	int	msg_flags;		/* flags on received message */
};
*/
CONST MSG_OOB=$1		/* process out-of-band data */
CONST MSG_PEEK=$2		/* peek at incoming message */
CONST MSG_DONTROUTE=$4		/* send without using routing tables */
CONST MSG_EOR=$8		/* data completes record */
CONST MSG_TRUNC=$10		/* data discarded before delivery */
CONST MSG_CTRUNC=$20		/* control data lost before delivery */
CONST MSG_WAITALL=$40		/* wait for full request or error */

/*
/*
 * Header for ancillary data objects in msg_control buffer.
 * Used for additional information with/about a datagram
 * not expressible by flags.  The format is a sequence
 * of message elements headed by cmsghdr structures.
 */
struct cmsghdr {
	u_int	cmsg_len;		/* data byte count, including hdr */
	int	cmsg_level;		/* originating protocol */
	int	cmsg_type;		/* protocol-specific type */
/* followed by	u_char  cmsg_data[]; */
};

/* given pointer to struct adatahdr, return pointer to data */
CONST CMSG_DATA(cmsg)		((u_char *)((cmsg) + 1))

/* given pointer to struct adatahdr, return pointer to next adatahdr */
CONST CMSG_NXTHDR(mhdr, cmsg)	\
	(((caddr_t)(cmsg) + (cmsg)->cmsg_len + sizeof(struct cmsghdr) > \
	    (mhdr)->msg_control + (mhdr)->msg_controllen) ? \
	    (struct cmsghdr *)NULL : \
	    (struct cmsghdr *)((caddr_t)(cmsg) + ALIGN((cmsg)->cmsg_len)))

CONST CMSG_FIRSTHDR(mhdr)	((struct cmsghdr *)(mhdr)->msg_control)

/* "Socket"-level control message types: */
CONST SCM_RIGHTS	$01		/* access rights (array of int) */

/*
 * 4.3 compat sockaddr, move to compat file later
 */
struct osockaddr {
	u_short	sa_family;		/* address family */
	char	sa_data[14];		/* up to 14 bytes of direct address */
};

/*
 * 4.3-compat message header (move to compat file later).
 */
struct omsghdr {
	caddr_t	msg_name;		/* optional address */
	int	msg_namelen;		/* size of address */
	struct	iovec *msg_iov;		/* scatter/gather array */
	int	msg_iovlen;		/* # elements in msg_iov */
	caddr_t	msg_accrights;		/* access rights sent/received */
	int	msg_accrightslen;
};

#ifndef KERNEL

/*
 * Include socket protos/inlines/pragmas
 */
#ifndef BSDSOCKET_H
#include <bsdsocket.h>
#endif

#endif /* !KERNEL */

#endif /* !SYS_SOCKET_H */

*/