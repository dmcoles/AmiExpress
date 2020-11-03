OPT MODULE
OPT EXPORT

->MODULE 'socket'
->MODULE 'usergroup'

/*CONST _PATH_DB="AmiTCP:db"
CONST _PATH_AMITCP_CONFIG="AmiTCP:db/AmiTCP.config"
CONST _PATH_HEQUIV="AmiTCP:db/hosts.equiv"
CONST _PATH_INETDCONF="AmiTCP:db/inetd.conf" */
CONST HOST_NOT_FOUND=1 /* Authoritative Answer Host not found */
CONST TRY_AGAIN=2 /* Non-Authoritive Host not found, or SERVERFAIL */
CONST NO_RECOVERY=3 /* Non recoverable errors, FORMERR, REFUSED, NOTIMP */
CONST NO_DATA=4 /* Valid name, no data record of requested type */
CONST NO_ADDRESS=NO_DATA      /* no address, look for MX record */

/*
 * Structures returned by network data base library.  All addresses are
 * supplied in host order, and returned in network order (suitable for
 * use in system calls).
 */

EXPORT OBJECT namearray
   names[15]:ARRAY OF LONG
ENDOBJECT

EXPORT OBJECT hostent
   h_name:LONG
   h_aliases:LONG
   h_addrtype:LONG
   h_length:LONG
   h_addr_list:LONG
ENDOBJECT


/*
struct   hostent {
   char  *h_name; /* official name of host */
   char  **h_aliases;   /* alias list */
   int   h_addrtype; /* host address type */
   int   h_length;   /* length of address */
   char  **h_addr_list; /* list of addresses from name server */
#define  h_addr   h_addr_list[0] /* address, for backward compatiblity */
};
*/

/*
 * Assumption here is that a network number
 * fits in 32 bits -- probably a poor one.
 */

EXPORT OBJECT netent
   n_name:LONG
   n_aliases:LONG
   n_addrtype:INT
   n_net:LONG
ENDOBJECT

/*
struct   netent {
   char     *n_name; /* official name of net */
   char     **n_aliases;   /* alias list */
   int      n_addrtype; /* net address type */
   unsigned long  n_net;      /* network # */
};
*/

EXPORT OBJECT servent
   s_name:LONG
   s_aliases:LONG
   s_port:INT
   s_proto:LONG
ENDOBJECT

/*
struct   servent {
   char  *s_name; /* official service name */
   char  **s_aliases;   /* alias list */
   int   s_port;     /* port # */
   char  *s_proto;   /* protocol to use */
};
*/

OBJECT protoent
   p_name:LONG
   p_aliases:LONG
   p_proto:INT
ENDOBJECT

/*
struct   protoent {
   char  *p_name; /* official protocol name */
   char  **p_aliases;   /* alias list */
   int   p_proto; /* protocol # */
};
*/

