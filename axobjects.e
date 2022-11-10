  -> EXPORT EXPORT OBJECTs for express

  OPT MODULE

  MODULE 'exec/ports'
  MODULE 'exec/semaphores'
  MODULE '*axconsts'
  MODULE '*stringlist'


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
  unused[94]:ARRAY OF CHAR
ENDOBJECT

EXPORT OBJECT tempAccess
  accessLevel: INT
  ratioType: INT
  ratio: INT
  timeTotal: LONG
  confAc[10]: ARRAY OF CHAR
ENDOBJECT

EXPORT OBJECT zModem
  fileName[255]:ARRAY OF CHAR
  titleBar[60]:ARRAY OF CHAR
  zStat[60]:ARRAY OF CHAR
  filesize:LONG
  cps:LONG
  eff:LONG
  transPos:LONG
  errorCount: LONG
  errorPos:LONG
  resumePos:LONG
  elapsedTime[40]:ARRAY OF CHAR
  apxTime[40]:ARRAY OF CHAR
  lastTime[40]:ARRAY OF CHAR
  pad[2]:ARRAY OF CHAR
  lastUpdate: LONG
  currentOperation: LONG
  freeDFlag: LONG
  fileList:PTR TO stdlist
  current: LONG
  total: LONG
  shouldUpdateDownloadStats: CHAR
  needUpdateDownloadStats: CHAR
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

EXPORT OBJECT doorMsg
  door_Msg: mn
  command:INT
  data:INT
  string[80]:ARRAY OF CHAR
  carrier:INT
ENDOBJECT

EXPORT OBJECT awaitState
  subState: LONG
  redrawScreen: LONG
ENDOBJECT

EXPORT OBJECT loggedOnState
  subState: LONG
ENDOBJECT

EXPORT OBJECT ansi
  ansicode: INT
  buf[80]: ARRAY OF CHAR
ENDOBJECT

EXPORT OBJECT mailHeader
  status: CHAR
  msgNumb: LONG
  toName[31]: ARRAY OF CHAR
  fromName[31]: ARRAY OF CHAR
  subject[31]: ARRAY OF CHAR
  msgDate: LONG
  recv: LONG
  extMsgNum: INT
ENDOBJECT  ->110
->1+1+4+31+31+31+1+4+4+1


EXPORT OBJECT mailStat
  lowestKey : LONG
  highMsgNum : LONG
  lowestNotDel : LONG
  pad[6]:ARRAY OF CHAR
ENDOBJECT

EXPORT OBJECT txt
  next:PTR TO txt
  txt: PTR TO CHAR
ENDOBJECT

EXPORT OBJECT rndsay
  saying[MAX_SAYINGS]: ARRAY OF LONG
  rnum:CHAR                            /* num of random sayings */
  type:CHAR
ENDOBJECT

->0 word - left
->2 word - top
->4 word - width
->6 word - height
->8 long - bitplanes ? and interlace?
->12 word -statbar
->14 Interlace
->16DupeCheck
->18QLogon
->20TakeCredits
->22SeenIt
->24 word trapdoor
->26 ?
->28
->30 word
->32 word ??? probably toggles[0]
->34 word
->36 word toggles[2]
->38 word toggles[3] startuplog START_LOG
->40 word toggles[4]
->42 word
->44 word toggles[6]
->46 word
->48 word
->50 word toggles[9]
->52 word Toggles[10]
->54 word toggles[11]
->56 word toggles[12]
->58 word toggles[13]
->60 word toggles[14]
->62 word toggles[15]
->64 word toggles[16]
->66 word toggles[17]
->68 word toggles[18]
->70 word toggles[19] credit by kb
->72 [80] array of char
->152 shutdown [80] array of char
->232 [80] array of char
->312 byte  - rampen[80] array of char
->392 name prompt [80]
->472 files not allowed [80] array of char
->552  [80] array of char
->632 [80] array of char
->712  offHook[80]:ARRAY OF CHAR     -> should be 712
->792 nodeScreen[80]:ARRAY OF CHAR -> should be 792
->872  t: PTR TO LONG  -> should be 872
->876  s: PTR TO LONG  -> should be 876
->880  unknown4: PTR TO LONG -> should be 880 - translator list (currently always null)
->884  unknown5: PTR TO LONG -> should be 884 - acp window

EXPORT OBJECT editor
  maxFileLength:INT
  maxScrLength:CHAR
  editorTop:CHAR
  editorMaxWidth:CHAR
  editorFlags:LONG       -> // Flags for the editor, duh!
  editorFile: PTR TO CHAR
  editorIncludeFile:PTR TO CHAR
  editorPrependFile: PTR TO CHAR
  editorPostPendFile: PTR TO CHAR
ENDOBJECT

EXPORT OBJECT qwkNDX
  recNum:LONG
  conf:CHAR
ENDOBJECT

EXPORT OBJECT bgCheckData
  semi: ss
  checkedCount: LONG
  checkedBytes: LONG
ENDOBJECT

EXPORT OBJECT diskObjectCacheItem
  fileName:PTR TO CHAR
  diskObject: LONG
  ownsToolTypes: CHAR
ENDOBJECT

EXPORT OBJECT flagFileItem
  fileName:PTR TO CHAR
  confNum: LONG
ENDOBJECT
