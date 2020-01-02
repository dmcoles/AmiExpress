-> Converted from C to E by Leon Woestenberg (leon@sascha.esrac.ele.tue.nl)

OPT MODULE
OPT EXPORT

MODULE 'exec/ports'
MODULE 'dos/dosextens'

-> This object is private; don't muck with it, or you're looking for trouble.
OBJECT asyncfile PRIVATE
  file:LONG
  blocksize:LONG
  handler:PTR TO mp
  offset:PTR TO CHAR
  bytesleft:LONG
  buffersize:LONG
  buffers[2]:ARRAY OF LONG
  packet:standardpacket
  packetport:mp
  currentbuf:LONG
  seekoffset:LONG
  sysbase:LONG
  dosbase:LONG
  packetpending:CHAR
  readmode:CHAR
  closefh:CHAR
ENDOBJECT

ENUM
  MODE_READ,
  MODE_WRITE,
  MODE_APPEND   

ENUM MODE_START=$ffffffff,
  MODE_CURRENT,
  MODE_END


