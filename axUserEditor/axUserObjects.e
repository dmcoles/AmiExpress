OPT MODULE

EXPORT OBJECT user
  name[31]:ARRAY OF CHAR
  pass[9]:ARRAY OF CHAR
  location[30]:ARRAY OF CHAR
  phoneNumber[13]:ARRAY OF CHAR
  slotNumber: INT
  secStatus: INT
  secBoard: INT                   /* File or Byte Ratio */
  secLibrary: INT                 /* Ratio              */
  secBulletin: INT                /* Computer Type      */
  messagesPosted: INT
 /* Note ConfYM = the last msg you actually read, ConfRead is the same ?? */
  newSinceDate: LONG
  pwdHash: LONG
  confRead2: LONG   ->not used
  confRead3: LONG   ->not used
  zoomType: INT
  unknown: INT      ->not used
  unknown2: INT     ->not used
  unknown3: INT     ->not used
  xferProtocol: INT
  filler2: INT      ->not used
  lcFiles: INT      ->not used
  badFiles: INT     ->not used
  accountDate: LONG
  screenType: INT
  editorType: INT
  conferenceAccess[10]: ARRAY OF CHAR
  uploads: INT
  downloads: INT
  confRJoin: INT
  timesCalled: INT
  timeLastOn: LONG
  timeUsed: LONG
  timeLimit: LONG
  timeTotal: LONG
  bytesDownload: LONG
  bytesUpload: LONG
  dailyBytesLimit: LONG
  dailyBytesDld: LONG
  expert: CHAR
  chatRemain: LONG
  chatLimit: LONG
  creditDays: LONG -> used to store days credited credit account
  creditAmount: LONG -> used to store amount paid credit account
  creditStartDate: LONG -> start date credit account
  creditTotalToDate: LONG ->  used to store amount paid to date credit account
  creditTotalDate: LONG -> credit total to date date
  creditTracking: CHAR ->  track uploads/downloads flags in credit account
  translatorID: CHAR
  msgBaseRJoin:INT
  confYM9: LONG ->not used
  todaysBytesLimit : LONG
  protocol: CHAR  ->not really used
  uucpa: CHAR
  lineLength: CHAR
  newUser: CHAR
ENDOBJECT

EXPORT OBJECT userKeys
  userName[31]: ARRAY OF CHAR
  number: LONG
  newUser: CHAR
  oldUpCPS: INT            /* highest upload cps rate (max 64k) */
  oldDnCPS: INT            /* highest dnload cps rate (max 64k)*/
  userFlags: INT           /*                         */
  baud: INT                /* last online baud rate   */
  upCPS2: LONG             /* new high upload cps with support for >64k */
  dnCPS2: LONG             /* new high download cps with support for >64k */
  timesOnToday: INT        /* number of times user has been online today */
ENDOBJECT

EXPORT OBJECT userMisc
  internetName[10]:ARRAY OF CHAR
  realName[26]:ARRAY OF CHAR
  downloadBytesBCD[8]:ARRAY OF CHAR
  uploadBytesBCD[8]:ARRAY OF CHAR
  eMail[50]:ARRAY OF CHAR
  lastDlCPS:LONG
  pwdHash[32]:ARRAY OF CHAR
  salt[8]:ARRAY OF CHAR
  pwdType:CHAR
  forcePwdReset:CHAR
  accountLocked:CHAR
  invalidAttempts:CHAR
  pwdLastUpdated:LONG     
  lastIP:LONG
  ipMask:LONG
  unused[86]:ARRAY OF CHAR
ENDOBJECT


EXPORT OBJECT confBase
  handle[16]: ARRAY OF CHAR
  downloadBytesBCD[8]:ARRAY OF CHAR
  uploadBytesBCD[8]:ARRAY OF CHAR
  newSinceDate: LONG
  confRead: LONG
  confYM: LONG
  bytesDownload: LONG
  bytesUpload: LONG
  uploadTracking: INT
  unused: INT
  unused2:LONG  ->dailyBytesDld: LONG
  upload: INT
  downloads: INT
  ratioType: INT
  ratio: INT
  messagesPosted: INT
  access: INT
  active:INT
ENDOBJECT
