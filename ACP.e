-> ACP v5

  OPT LARGE,OSVERSION=37

  MODULE 'workbench/startup',
       'exec/ports',
       'exec/nodes',
       'exec/memory',
       'exec/lists',
       'exec/semaphores',
       'exec/io',
       'exec/lists',
       'dos/datetime',
       'dos/dos',
       'dos/dosextens',
       'commodities',
       'libraries/commodities',
       'dos/dostags',
       'intuition/screens',
       'gadtools',
       'graphics/rastport',
       'graphics/text',
       'diskfont',
       'libraries/gadtools',
       'intuition/intuition',
       'intuition/iobsolete',
       'amigalib/io',
       'amigalib/ports',
       'amigalib/lists',
       'workbench/workbench',
       'asl',
       'libraries/asl',
       'wb',
        'socket',
        'net/netdb',
        'net/in',
        'net/socket',

       'icon'

  MODULE '*axcommon',
         '*jsonParser',
         '*jsonCreate',
         '*stringlist',
        '*acpversion'

ENUM ERR_NONE,ERR_ALREADY_RUNNING,ERR_STARTUP, ERR_VALIDATE,ERR_NO_DISKFONT,ERR_FDS_RANGE

CONST LISTENQ=100
CONST EINTR=4
CONST MAX_LINE=255
CONST FIONBIO=$8004667e
CONST EWOULDBLOCK=35

#ifndef EVO_3_5_0
CONST TAG_END=0    
#endif

CONST NODECONFIG=1
CONST RUNMCP=2

CONST LAST_UPLOADS=1
CONST LAST_DOWNLOADS=2
CONST LAST_CALLERS=0

CONST CHAT_ENTER=5
CONST CHAT_EXIT=4
CONST CHAT_IDLE=3
CONST CHAT_TEXT=2
CONST CHAT_NONE=1
CONST CHAT_NTXT=6

CONST WLEF=0
CONST WTOP=0
CONST WWID=640
CONST WHEI=88

CONST GAD_SYSOPLOGIN=0
CONST GAD_INSTANTLOGIN=1
CONST GAD_AESHELL=2
CONST GAD_TOGGLECHAT=3
CONST GAD_EXITNODE=4
CONST GAD_LOCALLOGIN=5
CONST GAD_RESERVENODE=6
CONST GAD_ACCOUNTS=7
CONST GAD_INITMODEM=8
CONST GAD_NODEOFFHOOK=9
CONST GAD_MCP=10
CONST GAD_NODECONFIG=11
CONST GAD_NODECHAT=12
CONST GAD_SAVEWIN=13
CONST GAD_NRAMS=14
CONST GAD_FLIP=15
CONST GAD_CONTROL=16
CONST GAD_ACTION=17
CONST GAD_USER=18
CONST GAD_LOCATION=19
CONST GAD_BAUD=20
CONST GAD_TOPS=21
CONST GAD_TOPSBOX=22
CONST GAD_SHORT=23
CONST GAD_NODES=24
CONST ALL_GADS=GAD_NODES+MAX_NODES

CONST GLEF_0=5
CONST GTOP_0=24
CONST GWID_0=55
CONST GHEI_0=11

CONST GLEF_ACTION=435
CONST GTOP_ACTION=12
CONST GWID_ACTION=128
CONST GHEI_ACTION=11

CONST GLEF_USER=67
CONST GTOP_USER=12
CONST GWID_USER=183
CONST GHEI_USER=11

CONST GLEF_LOCATION=251
CONST GTOP_LOCATION=12
CONST GWID_LOCATION=183
CONST GHEI_LOCATION=11

CONST GLEF_BAUD=563
CONST GTOP_BAUD=12
CONST GWID_BAUD=70
CONST GHEI_BAUD=11

CONST GLEF_EXITNODE=4
CONST GTOP_EXITNODE=78  ->188
CONST GWID_EXITNODE=109
CONST GHEI_EXITNODE=10

CONST GLEF_NODEOFFHOOK=114
CONST GTOP_NODEOFFHOOK=78  ->188
CONST GWID_NODEOFFHOOK=109
CONST GHEI_NODEOFFHOOK=10

CONST GLEF_INSTANTLOGIN=4
CONST GTOP_INSTANTLOGIN=48   ->158
CONST GWID_INSTANTLOGIN=109
CONST GHEI_INSTANTLOGIN=10

CONST GLEF_AESHELL=4
CONST GTOP_AESHELL=58  ->168
CONST GWID_AESHELL=109
CONST GHEI_AESHELL=10

CONST GLEF_TOGGLECHAT=4
CONST GTOP_TOGGLECHAT=68  ->178
CONST GWID_TOGGLECHAT=109
CONST GHEI_TOGGLECHAT=10

CONST GLEF_SYSOPLOGIN=4
CONST GTOP_SYSOPLOGIN=38  ->148
CONST GWID_SYSOPLOGIN=109
CONST GHEI_SYSOPLOGIN=10

CONST GLEF_NRAMS=224
CONST GTOP_NRAMS=78    ->188
CONST GWID_NRAMS=109
CONST GHEI_NRAMS=10

CONST GLEF_RESERVENODE=114
CONST GTOP_RESERVENODE=48   ->158
CONST GWID_RESERVENODE=109
CONST GHEI_RESERVENODE=10

CONST GLEF_ACCOUNTS=114
CONST GTOP_ACCOUNTS=58 ->168
CONST GWID_ACCOUNTS=109
CONST GHEI_ACCOUNTS=10

CONST GLEF_INITMODEM=114
CONST GTOP_INITMODEM=68   ->178
CONST GWID_INITMODEM=109
CONST GHEI_INITMODEM=10

CONST GLEF_LOCALLOGIN=114
CONST GTOP_LOCALLOGIN=38  ->148
CONST GWID_LOCALLOGIN=109
CONST GHEI_LOCALLOGIN=10

CONST GLEF_MCP=224
CONST GTOP_MCP=38  ->148
CONST GWID_MCP=109
CONST GHEI_MCP=10

CONST GLEF_NODECONFIG=224
CONST GTOP_NODECONFIG=48 ->158
CONST GWID_NODECONFIG=109
CONST GHEI_NODECONFIG=10

CONST GLEF_NODECHAT=224
CONST GTOP_NODECHAT=58 ->168
CONST GWID_NODECHAT=109
CONST GHEI_NODECHAT=10

CONST GLEF_SAVEWIN=224
CONST GTOP_SAVEWIN=68 ->178
CONST GWID_SAVEWIN=109
CONST GHEI_SAVEWIN=10

CONST GLEF_FLIP=4
CONST GTOP_FLIP=27  ->137
CONST GWID_FLIP=14
CONST GHEI_FLIP=10

CONST GLEF_CONTROL=19
CONST GTOP_CONTROL=27 ->137
CONST GWID_CONTROL=314
CONST GHEI_CONTROL=10

CONST GLEF_TOPS=335
CONST GTOP_TOPS=26 ->136
CONST GWID_TOPS=300
CONST GHEI_TOPS=11

CONST GLEF_SHORT=10
CONST GTOP_SHORT=12
CONST GWID_SHORT=37
CONST GHEI_SHORT=9

CONST BLEF_0=66
CONST BTOP_0=24
CONST BWID_0=569
CONST BHEI_0=110

CONST BLEF_TOPSBOX=335
CONST BTOP_TOPSBOX=38 ->148
CONST BWID_TOPSBOX=300
CONST BHEI_TOPSBOX=50

OBJECT itemsList
  PRIVATE lastUsers[5]:ARRAY OF LONG ->array[6,44]
  PRIVATE lastUserDates[5]:ARRAY OF LONG
  num:INT
ENDOBJECT

OBJECT user
  user[50]:ARRAY OF CHAR
  location[50]:ARRAY OF CHAR
  action[50]:ARRAY OF CHAR
  baud[10]:ARRAY OF CHAR
  active:INT
  actionVal:INT
ENDOBJECT

OBJECT pstr
  s1:INT
  s2:INT
  ns:INT
  ne:INT
ENDOBJECT

OBJECT button
  text[100]:ARRAY OF CHAR
  command[100]:ARRAY OF CHAR
  type:CHAR
ENDOBJECT

OBJECT screenPref
  left:INT
  top:INT
  width:INT
  height:INT
  nodes:INT
  ->WORD Zoom[5];
ENDOBJECT

OBJECT connectionItem
  ipAddr: LONG
  connectionTime: LONG
  blocked: CHAR
  blockExpiry: LONG
ENDOBJECT
  
DEF ngAry[ALL_GADS]:ARRAY OF LONG

DEF signals=NIL
DEF mybbslocation[40]:STRING
DEF mp=NIL:PTR TO mp
DEF acpError=FALSE

DEF nport=NIL:PTR TO mp

DEF dim:PTR TO INT   /*** Dimensions of ZIP window default ***/
DEF zim:PTR TO INT
/*  main function to test gadgets  */
DEF masterSig /*** storage for our ports address ***/
DEF scr:PTR TO screen /*** Pointer to our screen ***/
DEF eWin:PTR TO window
DEF gadgets: PTR TO gadget
DEF startNode[MAX_NODES]:ARRAY OF LONG  /*** Node startup scripts ***/
DEF nodeIdle[MAX_NODES]:ARRAY OF CHAR
DEF startUp=FALSE/*** Set startup scripts to none ***/
DEF zipOn=FALSE/*** Turn ZIPPED window off ***/ 
DEF notDone=1
DEF down[MAX_NODES]:ARRAY OF CHAR
DEF activeNodes[MAX_NODES]:ARRAY OF CHAR
DEF publicName[200]:STRING
DEF pens[9]:ARRAY OF INT
DEF myVerStr[255]:STRING
DEF myBuildStr[255]:STRING
DEF myappport=NIL:PTR TO mp
DEF doMultiCom

DEF quietNode[MAX_NODES]:ARRAY OF INT
DEF telnetNode[MAX_NODES]:ARRAY OF INT
DEF ftpNode[MAX_NODES]:ARRAY OF INT
DEF bbsStack

DEF nodes[MAX_NODES]:ARRAY OF INT
DEF suspend[MAX_NODES]:ARRAY OF INT
DEF showAbout=0
DEF edgeX,edgeY
DEF width=0,height=0
DEF theight=0
DEF drawPen = 1
DEF chat[MAX_NODES]:ARRAY OF INT  /*** Default color for nonchat ***/
DEF tChat[MAX_NODES]:ARRAY OF INT
DEF activeNodeCount=0
DEF colourSpecs
DEF amigaSpecs
DEF colours

DEF dosCheckTime=60
DEF dosCheckTrigger=5
DEF dosBanTime=60

DEF masterPort[100]:STRING

DEF cmds[MAX_NODES]:ARRAY OF LONG
DEF sopts[MAX_NODES]:ARRAY OF LONG

DEF msg:PTR TO acpMessage
DEF cpymsg:PTR TO acpMessage

DEF portName[255]:STRING

DEF acpData:PTR TO acpData

DEF lastUsers=NIL: PTR TO itemsList
DEF lastUploads=NIL: PTR TO itemsList
DEF lastDownloads=NIL: PTR TO itemsList

DEF ndUser[MAX_NODES]: ARRAY OF LONG
DEF ndUploads[MAX_NODES]: ARRAY OF LONG
DEF ndDownloads[MAX_NODES]: ARRAY OF LONG

DEF bbsPath[41]:STRING

DEF buttons[20]:ARRAY OF button

DEF users[MAX_NODES]:ARRAY OF user

DEF eWinMenu: PTR TO newmenu

DEF control=0
DEF short=0

DEF bm[20]:ARRAY OF INT

DEF button=FALSE
DEF buttonID=-1  /**** Nutton to be processed when Node Button is selected*/
DEF shortUp=FALSE
DEF setOriText[15]:ARRAY OF LONG    ->char[15][100]/** Original Text for 15 control buttons **/

DEF semiNodes=NIL:PTR TO multiPort
DEF singleNode=NIL:PTR TO singlePort

DEF multiName[8]:STRING
DEF singleName[8]:STRING

DEF eGList=NIL:PTR TO gadget
DEF visInfo=NIL

DEF pref:screenPref

DEF eWinM=NIL:PTR TO menu

DEF dobj=NIL:PTR TO diskobject
DEF appicon=NIL:PTR TO appicon

DEF dir_info:PTR TO fileinfoblock
DEF pdir  

DEF tags:PTR TO LONG

DEF topOption=0

DEF topOffset=0

DEF shorten=0

DEF maxMenus=0

DEF menuset=0

DEF fontName[255]:STRING

DEF defaultfontattr: textattr
DEF fontHandle=NIL

DEF version[200]:STRING

DEF translators=NIL: PTR TO translator
DEF minNode=NIL: PTR TO mln

DEF lockedNodes=-1

DEF persistState=FALSE

DEF shellMode=FALSE

DEF commodityEnabled=TRUE

DEF broker=NIL, broker_mp=NIL:PTR TO mp, cxsigflag=0

DEF starting=TRUE

/* some global variables used to replace the statics from the C version 
they are prefixed with the procdure name to prevent any name clashes
*/

DEF initGadsagain=FALSE
DEF setTheGadsj=0
DEF setTheGadsSet=FALSE
DEF do_appiconi=0
DEF do_appiconj=0
DEF maddItemi=0

DEF startupCompleteScript[255]:STRING

DEF telnetPort=-1
DEF ftpPort=-1
DEF fds=0:PTR TO LONG

PROC init() OF itemsList  ->constructor
  self.lastUsers[0]:=String(36)
  self.lastUsers[1]:=String(36)
  self.lastUsers[2]:=String(36)
  self.lastUsers[3]:=String(36)
  self.lastUsers[4]:=String(36)

  self.lastUserDates[0]:=String(20)
  self.lastUserDates[1]:=String(20)
  self.lastUserDates[2]:=String(20)
  self.lastUserDates[3]:=String(20)
  self.lastUserDates[4]:=String(20)
  
  self.num:=0
ENDPROC

PROC end() OF itemsList       -> destructor
  DisposeLink(self.lastUsers[0])
  DisposeLink(self.lastUsers[1])
  DisposeLink(self.lastUsers[2])
  DisposeLink(self.lastUsers[3])
  DisposeLink(self.lastUsers[4])

  DisposeLink(self.lastUserDates[0])
  DisposeLink(self.lastUserDates[1])
  DisposeLink(self.lastUserDates[2])
  DisposeLink(self.lastUserDates[3])
  DisposeLink(self.lastUserDates[4])
ENDPROC

PROC getItem(num) OF itemsList IS self.lastUsers[num]
PROC getItemDate(num) OF itemsList IS self.lastUserDates[num]

PROC getDisplayText(num,outText:PTR TO CHAR) OF itemsList
  IF EstrLen(self.lastUserDates[num])>0
    StringF(outText,'\s [\s]',self.lastUsers[num],self.lastUserDates[num])
  ELSE
    StrCopy(outText,self.lastUsers[num])
  ENDIF
ENDPROC

PROC add(name:PTR TO CHAR, dateStr:PTR TO CHAR) OF itemsList
  DEF i=0
  
  IF((self.num>0) AND (self.num<6))
    IF(StrCmp(self.lastUsers[self.num-1],name))
->      StrCopy(self.lastUsers[self.num-1],name)
      StrCopy(self.lastUserDates[self.num-1],dateStr)
      RETURN
    ENDIF
  ENDIF
  
  IF(self.num=5)
    WHILE(i<4)
      StrCopy(self.lastUsers[i],self.lastUsers[i+1])
      StrCopy(self.lastUserDates[i],self.lastUserDates[i+1])
      i++
    ENDWHILE
    self.num:=4;
  ENDIF
  StrCopy(self.lastUsers[self.num],name)
  StrCopy(self.lastUserDates[self.num],dateStr)
  self.num:=self.num+1 
ENDPROC

PROC checkPathSlash(path)
  DEF c
  c:=path[StrLen(path)-1]
  IF (c<>":") AND (c<>"/")
    StrAdd(path,'/')
  ENDIF
ENDPROC 

PROC getSystemDate(outDateStr:PTR TO CHAR)
  DEF dt : datetime
  DEF datestr[255]:STRING
  DEF timestr[255]:STRING

  DateStamp(dt.stamp)
  
  dt.format:=FORMAT_DOS
  dt.flags:=0
  dt.strday:=NIL
  dt.strdate:=datestr
  dt.strtime:=timestr

  IF DateToStr(dt)
    StringF(outDateStr,'\s[6] \s[5]',datestr,timestr)
  ENDIF
ENDPROC

->returns system time as a long
PROC getSystemTime()
  DEF currDate: datestamp
  DEF startds:PTR TO datestamp
  startds:=DateStamp(currDate)
ENDPROC Mul(Mul(startds.days,1440),60)+(startds.minute*60)+(startds.tick/50)

PROC trimStr(src:PTR TO CHAR, dest:PTR TO CHAR)
  DEF i
  StrCopy(dest,TrimStr(src))

  i:=StrLen(dest)-1
  WHILE (i>=0)
    IF dest[i]<>" "
      i:=-1
    ELSE
      SetStr(dest,i)
      i--
    ENDIF
  ENDWHILE
  
ENDPROC

PROC myrequest(s:PTR TO CHAR)
  DEF myES:PTR TO LONG
  
  myES:=NEW [20,0,'ACP Notification',s,'Continue']:LONG
  EasyRequestArgs(NIL,myES,NIL,NIL) 
  END myES[5]
ENDPROC

PROC menunum(n)
ENDPROC ((n) AND $1F)

PROC itemnum(n)
ENDPROC (Shr((n),5) AND $3F)

PROC subnum(n)
ENDPROC (Shr((n),11) AND $1F)

->/* ***** Free the Gadlist and return ***** */
PROC freeGads()
  IF eGList THEN FreeGadgets(eGList)
  IF (visInfo) THEN FreeVisualInfo(visInfo)
  visInfo:=NIL
  eGList:=NIL
ENDPROC

PROC waitSocketLib()
  DEF n=0,id=0
  IF socketbase=NIL THEN socketbase:=OpenLibrary('bsdsocket.library', 2)
  WHILE (socketbase=NIL) AND (n<60)
    Delay(50)
    n++
    socketbase:=OpenLibrary('bsdsocket.library', 2)
  ENDWHILE
  IF socketbase
    n:=0
    id:=GetHostId()
    WHILE(id=0) AND (n<60)
      Delay(50)
      n++
      id:=GetHostId()
    ENDWHILE
  ENDIF
ENDPROC

PROC openListenSocket(port)
  DEF server_s
  DEF servaddr=0:PTR TO sockaddr_in
  ->DEF tempStr[255]:STRING

  IF((server_s:=Socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
    ->StringF(tempStr,'/X Telnet: Error creating listening socket. (\d)\b\n',Errno())
    ->aePuts(tempStr)
    RETURN -1
  ENDIF
 
  servaddr:=NEW servaddr
  servaddr.sin_len:=SIZEOF sockaddr_in
  servaddr.sin_family:=AF_INET
  servaddr.sin_port:=port
  servaddr.sin_addr:=INADDR_ANY

  SetSockOpt(server_s, SOL_SOCKET, SO_REUSEADDR, [1]:LONG, SIZEOF LONG)

  IF(Bind(server_s, servaddr, SIZEOF sockaddr_in) < 0)
    ->StringF(tempStr,'/X Telnet: Error calling bind() for port \d, error=\d\b\n',port,Errno());
    ->aePuts(tempStr)
    CloseSocket(server_s)
    END servaddr
    RETURN -1
  ENDIF

  IF(Listen(server_s, LISTENQ) < 0)
    ->StringF(tempStr,'/X Telnet: Error calling listen() for port \d, error=\d\b\n',port,Errno());
    ->aePuts(tempStr)
    CloseSocket(server_s)
    END servaddr
    RETURN -1
  ENDIF

  IoctlSocket(server_s,FIONBIO,[1])

  END servaddr
ENDPROC server_s


->*******************************************************************
-> OpenMaster - This function opens a port for the nodes to interact
->********************************************************************
PROC openMaster()
  mp:=createPort(portName,0)
  myappport:=CreateMsgPort()
ENDPROC

->*******************************************************************
->  ShutDownMaster - This function removes our Master port insuring
-> that there is no pending messages first
->*******************************************************************
PROC shutDownMaster()
  IF mp
    WHILE(cpymsg:=GetMsg((mp)))
      CopyMem(cpymsg,msg,SIZEOF acpMessage)
      ReplyMsg(cpymsg)
    ENDWHILE
    deletePort(mp)
    mp:=0
  ENDIF
  IF myappport
    DeleteMsgPort(myappport)
    myappport:=0
  ENDIF
ENDPROC

->*********************************************************************
-> ClearUsers - initialize all the User storage
->*********************************************************************
PROC clearUsers()
  DEF i
  FOR i:=0 TO MAX_NODES-1
    AstrCopy(users[i].user,'')
    AstrCopy(users[i].location,'')
    AstrCopy(users[i].action,'')
    AstrCopy(users[i].baud,'       ')
    users[i].active:=0
  ENDFOR
ENDPROC

PROC printMyText(rport:PTR TO rastport,text:PTR TO CHAR, x, y)
  DEF t:PTR TO intuitext
  
  t:=[3,0,RP_JAM2,0,0,NIL,NIL,NIL]:intuitext
  t.itext:=text
  PrintIText(rport,t,x,y-6)
ENDPROC

PROC initNgAry()
  DEF i
  DEF nodetext:PTR TO CHAR
  
  ngAry[0]:=[GLEF_SYSOPLOGIN,topOffset+(theight*11)+GTOP_SYSOPLOGIN,GWID_SYSOPLOGIN,GHEI_SYSOPLOGIN,'Sysop Login',NIL,GAD_SYSOPLOGIN,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[1]:=[GLEF_INSTANTLOGIN,topOffset+(theight*11)+GTOP_INSTANTLOGIN,GWID_INSTANTLOGIN,GHEI_INSTANTLOGIN,'Instant Login',NIL,GAD_INSTANTLOGIN,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  IF shellMode
    ngAry[2]:=[GLEF_AESHELL, topOffset+(theight*11)+GTOP_AESHELL, GWID_AESHELL, GHEI_AESHELL,'AEShell',NIL,GAD_AESHELL,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ELSE
    ngAry[2]:=[GLEF_AESHELL, topOffset+(theight*11)+GTOP_AESHELL, GWID_AESHELL, GHEI_AESHELL,'Config',NIL,GAD_AESHELL,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ENDIF
  ngAry[3]:=[GLEF_TOGGLECHAT, topOffset+(theight*11)+GTOP_TOGGLECHAT, GWID_TOGGLECHAT, GHEI_TOGGLECHAT,'Toggle Chat',NIL,GAD_TOGGLECHAT,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[4]:=[GLEF_EXITNODE, topOffset+(theight*11)+GTOP_EXITNODE, GWID_EXITNODE, GHEI_EXITNODE,'Exit Node',NIL,GAD_EXITNODE,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[5]:=[GLEF_LOCALLOGIN, topOffset+(theight*11)+GTOP_LOCALLOGIN, GWID_LOCALLOGIN, GHEI_LOCALLOGIN,'Local Login',NIL,GAD_LOCALLOGIN,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[6]:=[GLEF_RESERVENODE, topOffset+(theight*11)+GTOP_RESERVENODE, GWID_RESERVENODE, GHEI_RESERVENODE,'Reserve Node',NIL,GAD_RESERVENODE,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[7]:=[GLEF_ACCOUNTS, topOffset+(theight*11)+GTOP_ACCOUNTS, GWID_ACCOUNTS, GHEI_ACCOUNTS,'Accounts',NIL,GAD_ACCOUNTS,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[8]:=[GLEF_INITMODEM, topOffset+(theight*11)+GTOP_INITMODEM, GWID_INITMODEM, GHEI_INITMODEM,'Init Modem',NIL,GAD_INITMODEM,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[9]:=[GLEF_NODEOFFHOOK, topOffset+(theight*11)+GTOP_NODEOFFHOOK, GWID_NODEOFFHOOK, GHEI_NODEOFFHOOK,'Node(offhook)',NIL,GAD_NODEOFFHOOK,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[10]:=[GLEF_MCP, topOffset+(theight*11)+GTOP_MCP, GWID_MCP, GHEI_MCP,'Quiet Node',NIL,GAD_MCP,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[11]:=[GLEF_NODECONFIG, topOffset+(theight*11)+GTOP_NODECONFIG, GWID_NODECONFIG, GHEI_NODECONFIG,'Config Node',NIL,GAD_NODECONFIG,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[12]:=[GLEF_NODECHAT, topOffset+(theight*11)+GTOP_NODECHAT, GWID_NODECHAT, GHEI_NODECHAT,'Node Chat',NIL,GAD_NODECHAT,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[13]:=[GLEF_SAVEWIN, topOffset+(theight*11)+GTOP_SAVEWIN, GWID_SAVEWIN, GHEI_SAVEWIN,'Save Win',NIL,GAD_SAVEWIN,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[14]:=[GLEF_NRAMS, topOffset+(theight*11)+GTOP_NRAMS, GWID_NRAMS, GHEI_NRAMS,'Set NRAMS',NIL,GAD_NRAMS,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[15]:=[GLEF_FLIP, topOffset+(theight*11)+GTOP_FLIP, GWID_FLIP, GHEI_FLIP,'X',NIL,GAD_FLIP,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[16]:=[GLEF_CONTROL, topOffset+(theight*11)+GTOP_CONTROL, GWID_CONTROL, GHEI_CONTROL,'Ami Express Master Control',NIL,GAD_CONTROL,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[17]:=[GLEF_ACTION, topOffset+GTOP_ACTION, GWID_ACTION, GHEI_ACTION,'Action',NIL,GAD_ACTION,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[18]:=[GLEF_USER, topOffset+GTOP_USER, GWID_USER, GHEI_USER,'User',NIL,GAD_USER,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[19]:=[GLEF_LOCATION, topOffset+GTOP_LOCATION, GWID_LOCATION, GHEI_LOCATION,'Location',NIL,GAD_LOCATION,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[20]:=[GLEF_BAUD, topOffset+GTOP_BAUD, GWID_BAUD, GHEI_BAUD,'Baud/CPS',NIL,GAD_BAUD,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[21]:=[GLEF_TOPS, topOffset+(theight*11)+GTOP_TOPS, GWID_TOPS, GHEI_TOPS,NIL,NIL,GAD_TOPS,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[22]:=[BLEF_TOPSBOX, topOffset+(theight*11)+BTOP_TOPSBOX, BWID_TOPSBOX, BHEI_TOPSBOX,NIL,NIL,GAD_TOPSBOX,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ngAry[23]:=[GLEF_SHORT, topOffset+GTOP_SHORT, GWID_SHORT, GHEI_SHORT,'/X',NIL,GAD_SHORT,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  FOR i:=0 TO MAX_NODES-1
    nodetext:=String(2)    ->note we dont retain a pointer to these so we rely on E's own cleanup to free them on exit
    StringF(nodetext,'\d',i)
    ngAry[24+i]:=NEW [GLEF_0, topOffset+GTOP_0+(GHEI_0*i), GWID_0, GHEI_0,nodetext,NIL,i+GAD_NODES,PLACETEXT_IN OR NG_HIGHLABEL,NIL,NIL]:newgadget
  ENDFOR
ENDPROC

PROC initCycles()
  lastUsers:=NEW lastUsers.init()
  lastUploads:=NEW lastUploads.init()
  lastDownloads:=NEW lastDownloads.init()
  initNdCycles()
ENDPROC

PROC initNdCycles()
  DEF x
  DEF list:PTR TO itemsList
  FOR x:=0 TO MAX_NODES-1
    ndUser[x]:=NEW list.init()
    ndUploads[x]:=NEW list.init()
    ndDownloads[x]:=NEW list.init()
  ENDFOR
ENDPROC

PROC tLock(str:PTR TO CHAR)
  DEF lock
  IF(lock:=Lock(str,ACCESS_READ))
    UnLock(lock)
    RETURN 1
  ENDIF
ENDPROC 0

PROC free_pdir()
  IF ( pdir )
    UnLock(pdir)
    pdir:=NIL
  ENDIF
ENDPROC

PROC getToolTypes(filename:PTR TO CHAR)
  DEF dobj: PTR TO diskobject,fn[255]:STRING,isCfg
  DEF toolTypes:PTR TO LONG
  DEF fh,fileBuf,off,lineCount
  DEF i,len

  dobj:=GetDiskObject(filename)
  isCfg:=FALSE
  IF(dobj=NIL)
    StringF(fn,'\s.txt',filename)
    IF (len:=FileLength(fn))=-1
      StringF(fn,'\s.cfg',filename)
      IF (len:=FileLength(fn))=-1
        StrCopy(fn,'')
      ENDIF
    ENDIF
    
    IF StrLen(fn)>0
      dobj:=GetDefDiskObject(WBPROJECT)
      IF dobj<>NIL
        fileBuf:=New(len+1)     ->allow an extra char in case file does not end in LF

        fh:=Open(fn,MODE_OLDFILE)
        IF fh<>0
          off:=0
          lineCount:=0
          WHILE(ReadStr(fh,fn)<>-1) OR (StrLen(fn)>0)
            len:=0
            WHILE (fn[len]<>0) AND (fn[len]<>";")
              len++
            ENDWHILE

            ->trim trailing space
            WHILE (fn[len-1]<=32) AND (len>0)
              len--
              EXIT len=0    ->this is just here to prevent the fn2[len-1] causing a buffer underrun in the absence of short circuit evaluation
            ENDWHILE
            SetStr(fn,len)

            AstrCopy(fileBuf+off,fn,len+1)
            lineCount++
            off:=off+len+1
          ENDWHILE        

          toolTypes:=List(lineCount+1)
          off:=0
          FOR i:=1 TO lineCount
            ListAdd(toolTypes,[fileBuf+off])
            off:=off+StrLen(fileBuf+off)+1
          ENDFOR
          ListAdd(toolTypes,[NIL])
          dobj.tooltypes:=toolTypes
          isCfg:=TRUE
          Close(fh)
        ELSE
          Dispose(fileBuf)
          FreeDiskObject(dobj)
          dobj:=NIL
        ENDIF
      ENDIF
    ENDIF
  ENDIF
ENDPROC dobj,isCfg

PROC freeToolTypes(dobj:PTR TO diskobject,isCfg)
  DEF mem

  IF dobj
    IF isCfg
      mem:=dobj.tooltypes[0]      -> release the file buffer (first string pointer points to start of buffer)
      Dispose(mem)
      END dobj.tooltypes            ->our tooltypes is a list that needs to be freed
    ENDIF
    FreeDiskObject(dobj)
  ENDIF
ENDPROC

PROC getFileName(path:PTR TO CHAR,buf:PTR TO CHAR)
  DEF returnval=0
  
  IF ((dir_info:=AllocDosObject(DOS_FIB,NIL)) = NIL)
    Delay(300)
    RETURN 0
  ENDIF
  
  IF ((pdir:=Lock(path,ACCESS_READ)))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    free_pdir()
    RETURN 0
  ENDIF
  
  IF(Examine(pdir, dir_info))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    free_pdir()
    RETURN 0
  ENDIF
  
  IF(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0)
      returnval:=1
      AstrCopy(buf,dir_info.filename)
    ENDIF
  ENDIF
  
  free_pdir()
  FreeDosObject(DOS_FIB,dir_info)
ENDPROC returnval

PROC findFirst(path: PTR TO CHAR,buf: PTR TO CHAR)
  DEF returnval=0

  IF ((dir_info:=(AllocDosObject(DOS_FIB,NIL)))=NIL)
    Delay(300)
    RETURN 0
  ENDIF
  
  IF((pdir:=(Lock(path,ACCESS_READ)))=FALSE)
    findClose()
    UnLock(pdir)
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF

  IF(Examine(pdir,dir_info))=FALSE
    findClose()
    RETURN 0
  ENDIF

  IF(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0 )
      returnval:=1
      StrCopy(buf,dir_info.filename)
    ENDIF
  ENDIF
ENDPROC returnval

PROC findNext(buf: PTR TO CHAR)
  DEF returnval=0
  IF(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0 )
      returnval:=1
      StrCopy(buf,dir_info.filename)
    ENDIF
  ENDIF
ENDPROC returnval

PROC findClose()
  IF pdir<>NIL THEN UnLock(pdir)
  IF dir_info<>NIL THEN FreeDosObject(DOS_FIB,dir_info)
  pdir:=NIL
  dir_info:=NIL
ENDPROC

/* ***** Do BevelBorders ***** */
PROC drawborders()
  /* *** Stats *** */
  DrawBevelBoxA(eWin.rport, BLEF_0, topOffset+BTOP_0, BWID_0, theight*11,[GT_VISUALINFO, visInfo,TAG_END])
ENDPROC

PROC getNodeTextColour(node)
  DEF c
  c:=chat[node]
  IF(quietNode[node]) THEN c:=3
ENDPROC c

->//*********************************************************************
->// CallNode - This function opens a port to a nodes AEServer and tries
->// to send a msg to the node and waits on a reply
->//*********************************************************************
PROC callNode(node,code,data=1)
  DEF response[100]:STRING
   
  StringF(response,'AmiExpress_Node.\d',node)
  IF(FindPort(response))=FALSE
    IF(StrLen(startNode[node])>0)
      ->ActiveNodeCount +=1; Down[node]=FALSE;
      IF(startProcess(startNode[node],bbsStack))
        activeNodeCount++
        activeNodes[node]:=TRUE
        down[node]:=FALSE
      ENDIF
      ->Execute(StartNode[node],NULL,NULL);
      RETURN
    ENDIF
  ENDIF
  IF(register(node))
    sendMessage(code,data)
  ENDIF
ENDPROC

PROC putToPort(message)
  PutMsg(nport,message)
ENDPROC 1

PROC sendMessage(nl,data=1)
  DEF jhmsg: PTR TO jhMessage

  jhmsg:=AllocMem(SIZEOF jhMessage,MEMF_PUBLIC OR MEMF_CLEAR)
  jhmsg.msg.ln.type:=NT_FREEMSG
  jhmsg.msg.length:=SIZEOF jhMessage
  jhmsg.msg.replyport:=0
 
  jhmsg.command:=nl
  jhmsg.data:=data  ->READIT
     
  putToPort(jhmsg)
ENDPROC


PROC register(node)
  StringF(masterPort,'AEServer.\d',node)
  nport:=FindPort(masterPort)
  IF(nport=FALSE)
    shutDown()
    RETURN 0
  ENDIF
ENDPROC 1

PROC shutDown()
->//  DeletePort((struct MsgPort *)replymp);
->//  FreeMem(Jhmsg,sizeof(struct JHMessage));
ENDPROC

PROC createCustomMenus(nodes)
  DEF bt,nm
  DEF tempnodes
  DEF i,j
  tempnodes:=nodes

  ->(void)GetDate();
  FOR i:=0 TO 1 
    bt:=0; nm:=0;
    menuset:=i
    nodes:=tempnodes; nodes--
  
    maddItem( NM_TITLE, 'Project', 0 , 0, 0, 0)
    maddItem( NM_ITEM,  'About',0,0,0,0)
    StringF(version,' AmiExpress Professional \s (\s)',myVerStr,myBuildStr)
    maddItem( NM_SUB,version,0,0,0,0)
    maddItem( NM_SUB,'                  Written by Darren Coles     ',0,0,0,0)
  
    maddItem( NM_ITEM,  '/X Technical', 0,0,0,0)
    maddItem( NM_SUB,'                   AmiExpress Technical Support',0,0,0,0)
    maddItem( NM_SUB,'   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ',0,0,0,0)
    maddItem( NM_SUB,'        ByteMaster       ByteMaster''s BBS USA     - 703-639-6114      ',0,0,0,0)
    maddItem( NM_SUB,'                                                                    ',0,0,0,0)
    maddItem( NM_ITEM,  '/X Distributors', 0,0,0,0)

    maddItem( NM_SUB,'                       AmiExpress Distributors',0,0,0,0)
    maddItem( NM_SUB,'   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ',0,0,0,0)
    maddItem( NM_SUB,'        ByteMaster    ByteMaster''s BBS     USA     - 703-639-6114   ',0,0,0,0)
    maddItem( NM_SUB,'        Lector & Dux  THE NORTHERN PALACE  DENMARK - 45-31744704    ',0,0,0,0)
    maddItem( NM_SUB,'                                                                    ',0,0,0,0)
 
    maddItem( NM_ITEM,'/X Developement',0,0,0,0)
    maddItem( NM_SUB,'    /X Developement Team   ',0,0,0,0)
    maddItem( NM_SUB,'   ~~~~~~~~~~~~~~~~~~~~~~  ',0,0,0,0)
    maddItem( NM_SUB,'   Mike Thomas             ',0,0,0,0)
    maddItem( NM_SUB,'   Joseph Hodge            ',0,0,0,0)
    maddItem( NM_SUB,'   James E. Millsap        ',0,0,0,0)
    maddItem( NM_SUB,'   Gregg Green             ',0,0,0,0)
    maddItem( NM_SUB,'   Jens Langner            ',0,0,0,0)
    maddItem( NM_SUB,'   Ted Mahar               ',0,0,0,0)
    maddItem( NM_SUB,'   Phillip Julias IV       ',0,0,0,0)

    maddItem( NM_ITEM,'/X Utility Developement',0,0,0,0)
    maddItem( NM_SUB,'    /X Utility Developement Team   ',0,0,0,0)
    maddItem( NM_SUB,'   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ',0,0,0,0)
    maddItem( NM_SUB,'   James E. Millsap  ',0,0,0,0)
    maddItem( NM_SUB,'   Krzysztof Wianecki',0,0,0,0)
    maddItem( NM_SUB,'   Stephan Schiemann ',0,0,0,0)
    maddItem( NM_SUB,'   Eddie Oniel       ',0,0,0,0)

    maddItem( NM_ITEM,  'Quit',0,0,0,0)

    maddItem( NM_TITLE, 'Master Control',0,0,0,0)
    maddItem(  NM_ITEM, 'Sysop Login',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem(  NM_ITEM, 'Instant Login',0, 0, 0, 0)
    maddNodes(nodes)
    IF shellMode
      maddItem(  NM_ITEM, 'AEShell',0, 0, 0, 0)
      maddNodes(nodes)
    ENDIF
    maddItem(  NM_ITEM, 'Toggle Chat',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem(  NM_ITEM, 'Exit Node',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem(  NM_ITEM, 'Local Login',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem(  NM_ITEM, 'Reserve Node',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem(  NM_ITEM, 'Accounts',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem(  NM_ITEM, 'Init Modem',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem(  NM_ITEM, 'Node(offhook)',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem(  NM_ITEM, 'Quiet Node',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem(  NM_ITEM, 'Config Node',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem(  NM_ITEM, 'Node Chat',0, 0, 0, 0)
    maddNodes(nodes)
    maddItem( NM_ITEM,'Set NRAMS',0,0,0,0)
    maddNodes(nodes)

    maddItem( NM_TITLE, 'Custom Control',0,0,0,0)

    FOR j:=1 TO 15
      IF(StrLen(buttons[bt].text)>0)
        bm[nm++]:=bt; maddItem(  NM_ITEM, buttons[bt].text,0, 0, 0, 0)
      ENDIF
      bt++
    
      IF((StrLen(buttons[bt-1].text)>0) AND (buttons[bt-1].type))
        maddNodes(nodes);
      ENDIF
    ENDFOR

    maddItem(   NM_END, 0, 0 , 0, 0, 0)
  ENDFOR
ENDPROC

PROC initGads(scr:PTR TO screen)
  DEF gad:PTR TO gadget
  DEF i
  ->static BOOL again=FALSE;
  DEF ng: PTR TO newgadget
  
  eGList:=NIL
  IF(initGadsagain=FALSE)
    IF ((visInfo :=GetVisualInfoA(scr, [TAG_END])))=NIL THEN RETURN 0

    FOR i:=0 TO GAD_NODES+MAX_NODES-1
      ng:=ngAry[i]
      ng.visualinfo:=visInfo
      ng.textattr:=defaultfontattr
    ENDFOR
  ENDIF

  IF ((gad:=CreateContext({eGList})))=NIL THEN RETURN 0
  
  gad:=CreateGadgetA(TEXT_KIND, gad, ngAry[GAD_ACTION], [GTTX_BORDER, 2,TAG_END])
  IF (gad = NIL) THEN RETURN 0

  gad:= CreateGadgetA(TEXT_KIND, gad, ngAry[GAD_USER],  [GTTX_BORDER, 2,TAG_END])
  IF (gad = NIL) THEN RETURN 0

  gad:= CreateGadgetA(TEXT_KIND, gad, ngAry[GAD_LOCATION],  [GTTX_BORDER, 2,TAG_END])
  IF (gad = NIL) THEN RETURN 0

  gad:= CreateGadgetA(TEXT_KIND, gad, ngAry[GAD_BAUD],  [GTTX_BORDER, 2,TAG_END])
  IF (gad = NIL) THEN RETURN 0
  
  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_EXITNODE].topedge:=ngAry[GAD_EXITNODE].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_EXITNODE],  [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_NODEOFFHOOK].topedge:=ngAry[GAD_NODEOFFHOOK].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_NODEOFFHOOK], [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_INSTANTLOGIN].topedge:=ngAry[GAD_INSTANTLOGIN].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_INSTANTLOGIN],  [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_AESHELL].topedge:=ngAry[GAD_AESHELL].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_AESHELL], [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_TOGGLECHAT].topedge:=ngAry[GAD_TOGGLECHAT].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_TOGGLECHAT],  [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_SYSOPLOGIN].topedge:=ngAry[GAD_SYSOPLOGIN].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_SYSOPLOGIN],  [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_NRAMS].topedge:=ngAry[GAD_NRAMS].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_NRAMS], [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_RESERVENODE].topedge:=ngAry[GAD_RESERVENODE].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_RESERVENODE], [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_ACCOUNTS].topedge:=ngAry[GAD_ACCOUNTS].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_ACCOUNTS],  [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_INITMODEM].topedge:=ngAry[GAD_INITMODEM].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_INITMODEM], [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_LOCALLOGIN].topedge:=ngAry[GAD_LOCALLOGIN].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_LOCALLOGIN],  [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_MCP].topedge:=ngAry[GAD_MCP].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_MCP], [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_NODECONFIG].topedge:=ngAry[GAD_NODECONFIG].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_NODECONFIG],  [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_NODECHAT].topedge:=ngAry[GAD_NODECHAT].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_NODECHAT],  [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_SAVEWIN].topedge:=ngAry[GAD_SAVEWIN].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_SAVEWIN], [TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_FLIP].topedge:=ngAry[GAD_FLIP].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_FLIP],  [GTTX_BORDER,2,TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_CONTROL].topedge:=ngAry[GAD_CONTROL].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_CONTROL], [GTTX_BORDER,2,TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_TOPS].topedge:=ngAry[GAD_TOPS].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(CYCLE_KIND, gad, ngAry [GAD_TOPS],  [GTCY_LABELS,['Last Five Callers','Last Five Uploads','Last Five Downloads',NIL],GTCY_ACTIVE,topOption,TAG_END])
  IF (gad = NIL) THEN RETURN 0

  ->IF(initGadsagain=FALSE) THEN ngAry[GAD_TOPSBOX].topedge:=ngAry[GAD_TOPSBOX].topedge+(-110+(theight*11))
  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_TOPSBOX], [GTTX_BORDER,2,TAG_END])
  IF (gad = NIL) THEN RETURN 0

  gad:= CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_SHORT], [TAG_END])
  IF (gad = NIL) THEN RETURN 0
  
  FOR i:=0  TO MAX_NODES-1
    IF(nodes[i]) 
      gad:=CreateGadgetA(BUTTON_KIND, gad, ngAry[GAD_NODES+i],TAG_END)
      IF (gad = NIL) THEN RETURN 0
    ENDIF
  ENDFOR
  initGadsagain:=TRUE

ENDPROC eGList

->//********************************************************************
->// DoControl - executes the buttons
->//********************************************************************
PROC doControl(node)
  DEF cmd[200]:STRING  /*** temporary storage for misc ***/
  DEF cd /*** stores the current node action ***/
  
  IF((buttonID>=0) AND (button))
     doButton(buttonID,node)
     RETURN
  ENDIF

  SELECT control
    CASE NODECONFIG
      getIconNodeInfo(node)
    CASE RUNMCP
      StringF(cmd,'run >nil: bbs:utils/mcp.script')
      Execute(cmd,NIL,NIL)
    CASE SV_SETNRAMS
      IF(users[node].actionVal=ENV_AWAITCONNECT)
        callNode(node,SV_SETNRAMS)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_SYSOPLOG
      IF(users[node].actionVal=ENV_AWAITCONNECT)
        callNode(node,SV_SYSOPLOG)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_LOCALLOG
      IF(users[node].actionVal=ENV_AWAITCONNECT)
        callNode(node,SV_LOCALLOG)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_ACCOUNTS
      IF(users[node].actionVal=ENV_AWAITCONNECT)
        callNode(node,SV_ACCOUNTS)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_EXITNODE
      IF(users[node].actionVal=ENV_AWAITCONNECT)
        callNode(node,SV_EXITNODE)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_NODEOFFHOOK
      IF(users[node].actionVal=ENV_AWAITCONNECT)
        callNode(node,SV_NODEOFFHOOK)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_RESERVE
      IF(users[node].actionVal=ENV_AWAITCONNECT)
        callNode(node,SV_RESERVE)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_CHAT
      cd:=users[node].actionVal
      IF((cd<>ENV_SUSPEND) AND (cd<>ENV_DOWNLOADING) AND (cd<>ENV_UPLOADING) AND (cd<>ENV_ACCOUNTSEQ) AND (cd<>ENV_LOGOFF) AND (cd<>ENV_EMACS) AND (cd<>ENV_NOTACTIVE) AND (cd<>ENV_CONNECT) AND (cd<>ENV_LOGGINGON) AND (cd<>ENV_AWAITCONNECT) AND (cd<>ENV_SHUTDOWN))
        callNode(node,SV_CHAT)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_INITMODEM
      IF(users[node].actionVal=ENV_AWAITCONNECT)
        callNode(node,SV_INITMODEM)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_INSTANT
      IF(users[node].actionVal=ENV_AWAITCONNECT)
        callNode(node,SV_INSTANT)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_AESHELL
      IF shellMode
        IF(users[node].actionVal=ENV_AWAITCONNECT)
          callNode(node,SV_AESHELL)
        ELSE
          DisplayBeep(scr)
        ENDIF
      ENDIF
    CASE SV_CHATTOGGLE
      cd:=users[node].actionVal
      IF((cd<>ENV_SHUTDOWN) AND (cd<>ENV_SUSPEND))
       /* if(TChat[node]) TChat[node]=0; else TChat[node]=1;

        SetAPen(eWin.rport,getNodeTextColour(node))
        Move(EWin->RPort,64,topOffset+26+(node*11));
        Draw(EWin->RPort,64,topOffset+26+(node*11)+6);
        Move(EWin->RPort,63,topOffset+26+(node*11));
        Draw(EWin->RPort,63,topOffset+26+(node*11)+6);
        Move(EWin->RPort,62,topOffset+26+(node*11));
        Draw(EWin->RPort,62,topOffset+26+(node*11)+6);
        Move(EWin->RPort,61,topOffset+26+(node*11));
        Draw(EWin->RPort,61,topOffset+26+(node*11)+6);*/
        callNode(node,SV_CHATTOGGLE)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_QUIETNODE
      cd:=users[node].actionVal
      IF((cd<>ENV_SHUTDOWN) AND (cd<>ENV_SUSPEND))
        callNode(node,SV_QUIETNODE)
      ELSE
        DisplayBeep(scr)
      ENDIF
    CASE SV_TOPS
      SELECT topOption
        CASE LAST_CALLERS
          showNdLastUser(eWin,node)
        CASE LAST_UPLOADS
          showNdLastUploads(eWin,node)
        CASE LAST_DOWNLOADS
          showNdLastDownloads(eWin,node)
      ENDSELECT
  ENDSELECT
  control:=0
ENDPROC

->//***********************************************************************
->// HandleEditGadget - This function determines what actions should take
->// place when a gadget is selected from the ACP screen
->//***********************************************************************
PROC handleEditGadget(im:PTR TO intuimessage,ig)
   DEF id
   DEF gadget: PTR TO gadget
   
  IF(im)
    gadget:=im.iaddress
    id:=gadget.gadgetid
  ELSE
    id:=ig
  ENDIF
  SELECT id
    CASE GAD_NRAMS
      IF(button)
        IF(nutton(14)=FALSE) THEN doButton(14,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_SETNRAMS
      ENDIF
    CASE GAD_SAVEWIN
      IF(button)
        IF(nutton(13)=FALSE) THEN doButton(13,0)
      ELSE
        screenSave()
      ENDIF
    CASE GAD_NODECONFIG
      IF(button)
        IF(nutton(11)=FALSE) THEN doButton(11,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=NODECONFIG
      ENDIF
    CASE GAD_MCP
      IF(button)
        IF(nutton(10)=FALSE) THEN doButton(10,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_QUIETNODE
      ENDIF
    CASE GAD_SYSOPLOGIN
      IF(button)
        IF(nutton(0)=FALSE) THEN doButton(0,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_SYSOPLOG
      ENDIF
    CASE GAD_LOCALLOGIN
      IF(button)
        IF(nutton(5)=FALSE) THEN doButton(5,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_LOCALLOG
      ENDIF
    CASE GAD_ACCOUNTS
      IF(button)
        IF(nutton(7)=FALSE) THEN doButton(7,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_ACCOUNTS
      ENDIF
    CASE GAD_NODECHAT
      IF(button)
        IF(nutton(12)=FALSE) THEN doButton(12,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_CHAT
      ENDIF
    CASE GAD_EXITNODE
      IF(button)
        IF(nutton(4)=FALSE) THEN doButton(4,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_EXITNODE
      ENDIF
    CASE GAD_NODEOFFHOOK
      IF(button)
        IF(nutton(9)=FALSE) THEN doButton(9,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_NODEOFFHOOK
      ENDIF
    CASE GAD_INITMODEM
      IF(button)
        IF(nutton(8)=FALSE) THEN doButton(8,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_INITMODEM
      ENDIF
    CASE GAD_INSTANTLOGIN
      IF(button)
        IF(nutton(1)=FALSE) THEN doButton(1,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_INSTANT
      ENDIF
    CASE GAD_RESERVENODE
      IF(button)
        IF(nutton(6)=FALSE) THEN doButton(6,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_RESERVE
      ENDIF
    CASE GAD_SHORT
      shorten:=1
      IF(shortUp=FALSE)
        IF(short=FALSE) 
          SizeWindow(eWin,0,-63)
          MoveWindow(eWin,0,63)
          short:=1
        ELSE
          short:=0
          MoveWindow(eWin,0,-63)
          SizeWindow(eWin,0,63)
        ENDIF
      ELSE
        IF(short=FALSE)
          SizeWindow(eWin,0,-63)
          short:=1
        ELSE
          short:=0
          SizeWindow(eWin,0,63)
        ENDIF
      ENDIF
    CASE GAD_AESHELL
      IF(button)
        IF(nutton(2)=FALSE) THEN doButton(2,0)
      ELSE
        IF shellMode
          IF(control) THEN control:=0 ELSE control:=SV_AESHELL
        ELSE
          selectAndRunConfig('','','')
        ENDIF
      ENDIF
    CASE GAD_TOGGLECHAT
      IF(button)
        IF(nutton(3)=FALSE) THEN doButton(3,0)
      ELSE
        IF(control) THEN control:=0 ELSE control:=SV_CHATTOGGLE
      ENDIF
    CASE GAD_TOPS
      topOption++
      IF(topOption>2) THEN topOption:=0
      SELECT topOption
        CASE LAST_CALLERS
          showLastUser(eWin)
        CASE LAST_DOWNLOADS
          showLastDownloads(eWin)
        CASE LAST_UPLOADS
          showLastUploads(eWin)
      ENDSELECT
    CASE GAD_TOPSBOX
        IF(control)
          control:=0
          SELECT topOption
            CASE LAST_CALLERS
              showLastUser(eWin)
            CASE LAST_UPLOADS
              showLastUploads(eWin)
            CASE LAST_DOWNLOADS
              showLastDownloads(eWin)
          ENDSELECT
        ELSE
          control:=SV_TOPS
        ENDIF
    CASE GAD_CONTROL
        toggleGads()
    DEFAULT
      IF (id>=GAD_NODES) AND (id<(32+GAD_NODES))
        IF((suspend[id-GAD_NODES]) AND (buttonID<0))=FALSE
          IF((control) OR (buttonID>=0)) THEN doControl(id-GAD_NODES) ELSE callNode(id-GAD_NODES,SV_UNICONIFY)
        ENDIF
      ENDIF
  ENDSELECT
ENDPROC

->//*********************************************************************
->// DoButton - Determines if the button is a NUTTON and acts accordingly
->//*********************************************************************
PROC doButton(b,node)
  DEF string[200]:STRING

  IF(buttons[b].type)
    StringF(string,'\s \d',buttons[b].command,node)
    Execute(string,NIL,NIL)
    buttonID:=-1 ->//tells us that there is no custom buttons pending
    RETURN
  ENDIF
  Execute(buttons[b].command,NIL,NIL)
ENDPROC

->//*********************************************************************
->// Nutton - This determines what type of custom button was seleced
->// returns 1 if it is a Nutton otherwise it retunes a 0
->//*********************************************************************
PROC nutton(b)
  IF(buttons[b].type)
    buttonID:=b
    RETURN 1
  ENDIF
ENDPROC 0

->//*******************************************************************
->// UpdateNode - This function determines what a user is doing based
->// on input from the nodes. Then it updates the Node data
->//*******************************************************************
PROC updateNode(name:PTR TO CHAR,location:PTR TO CHAR,action:PTR TO CHAR,baud:PTR TO CHAR,node)
  DEF action2[50]:STRING
  DEF v,a,top
  DEF tempstr[25]:STRING
  DEF datestr[255]:STRING
  DEF tempstr2[255]:STRING

  StrCopy(action2,'')
  v:=Val(action)
  SELECT v
    CASE ENV_IDLE
      StrCopy(action2,'Idle            ')
    CASE ENV_DOWNLOADING
      StrCopy(action2,'Downloading     ')
    CASE ENV_UPLOADING
      StrCopy(action2,'Uploading       ')
    CASE ENV_DOORS
      StringF(action2,'\l\s[16]',name)
    CASE ENV_MAIL
      StrCopy(action2,'Read/Write  Mail')
    CASE ENV_STATS
      StrCopy(action2,'Reviewing Stats ')
    CASE ENV_ACCOUNT
      StrCopy(action2,'Account Editing ')
    CASE ENV_ZOOM
      StrCopy(action2,'Zooming Mail    ')
    CASE ENV_FILES
      StrCopy(action2,'View Dir files  ')
    CASE ENV_BULLETINS
      StrCopy(action2,'Reading Bulletin')
    CASE ENV_VIEWING
      StrCopy(action2,'Viewing a file  ')
    CASE ENV_ACCOUNTSEQ
      StrCopy(action2,'Account Sequence')
    CASE ENV_LOGOFF
      StrCopy(action2,'Logging off     ')
    CASE ENV_SYSOP
      StrCopy(action2,'Sysop Commands  ')
    CASE ENV_SHELL
      StrCopy(action2,'Dropped to Shell')
    CASE ENV_EMACS
      StrCopy(action2,'Using Emacs     ')
    CASE ENV_JOIN
      StrCopy(action2,'Joining a Conf. ')
    CASE ENV_CHAT
      StrCopy(action2,'Chatting        ')
      chat[node]:=1
    CASE ENV_NOTACTIVE
      StrCopy(action2,'Reseting Node   ')
    CASE ENV_REQ_CHAT
      StrCopy(action2,'Requesting Chat ')
      chat[node]:=2
    CASE ENV_CONNECT
      StrCopy(action2,'Connecting      ')
    CASE ENV_LOGGINGON
      StrCopy(action2,'Logging on      ')
    CASE ENV_AWAITCONNECT
      StrCopy(action2,'Awaiting Connect')
      chat[node]:=1
    CASE ENV_SCANNING
      StrCopy(action2,'Scanning Mail   ')
    CASE ENV_SHUTDOWN
      StrCopy(action2,'Node Inactive   ')
      IF activeNodes[node] THEN activeNodeCount--
      activeNodes[node]:=FALSE
      /*if(ActiveNodeCount==0) notDone=0;*/
    CASE ENV_MULTICHAT
      StrCopy(action2,'MultiNode Chat  ')
    CASE ENV_SUSPEND
      StrCopy(action2,'BBS Suspended   ')
    CASE ENV_RESERVE
      StrCopy(action2,'Reserve for User')
    CASE ENV_ONLINEMSG
      StrCopy(action2,'Online Message  ')
    CASE ENV_NUKE
      StrCopy(action2,'Nuke            ')
    CASE ENV_SETUP
      StrCopy(action2,'Entered Setup   ')
    CASE SV_AESHELL
      StrCopy(action2,'Entered AEShell ')
    CASE SV_NEWMSG
      StringF(action2,'\l\s[16]',name)
  ENDSELECT
  drawPen:=getNodeTextColour(node)

  a:=Val(action)
  top:=topOffset+32+(node*11)
  SetAPen(eWin.rport,0)
  IF(a<>SV_NEWMSG) AND (a<>ENV_DOORS)
    RectFill(eWin.rport,GLEF_USER+2,top-7,GLEF_USER+GWID_USER-2,top+1)
    RectFill(eWin.rport,GLEF_LOCATION,top-7,GLEF_LOCATION+GWID_LOCATION,top+1)
    RectFill(eWin.rport,GLEF_BAUD,top-7,GLEF_BAUD+GWID_BAUD-2,top+1)
  ENDIF

  RectFill(eWin.rport,GLEF_ACTION,top-7,GLEF_ACTION+GWID_ACTION,top+1)
  SetAPen(eWin.rport,drawPen)
  IF(a<>SV_NEWMSG) AND (a<>ENV_DOORS)
    Move(eWin.rport,GLEF_USER+3,top)
    Text(eWin.rport,name,IF StrLen(name)>22 THEN 22 ELSE StrLen(name))
    Move(eWin.rport,GLEF_LOCATION+2,top)
    Text(eWin.rport,location,IF StrLen(location)>22 THEN 22 ELSE StrLen(location))
    Move(eWin.rport,GLEF_BAUD+5,top)
    StringF(tempstr,'\r\s[7]',baud)
    Text(eWin.rport,tempstr,7)
  ENDIF
  Move(eWin.rport,GLEF_ACTION,top)

  IF(a=26) THEN suspend[node]:=1 ELSE suspend[node]:=0
  Text(eWin.rport,action2,IF EstrLen(action2)>16 THEN 16 ELSE EstrLen(action2))
  
  IF(a<>SV_NEWMSG) AND (a<>ENV_DOORS)
    StringF(tempstr,'\l\s[22]',name)
    AstrCopy(users[node].user,tempstr)
    StringF(tempstr,'\l\s[22]',location)
    AstrCopy(users[node].location,tempstr)
  ENDIF

  AstrCopy(users[node].action,action2)
  
  StringF(tempstr,'\r\s[7]',baud)
  AstrCopy(users[node].baud,tempstr)
  
  users[node].active:=1
  
  IF(Val(action)=ENV_RESERVE) THEN users[node].actionVal:=ENV_AWAITCONNECT ELSE users[node].actionVal:=Val(action)
  IF(users[node].actionVal=ENV_LOGGINGON)
    trimStr(users[node].user,tempstr2)
    getSystemDate(datestr)
      
    regLastUser(tempstr2,datestr,node);
    SELECT topOption
      CASE LAST_CALLERS
        showLastUser(eWin)
      CASE LAST_UPLOADS
        showLastUploads(eWin)
      CASE LAST_DOWNLOADS
        showLastDownloads(eWin)
    ENDSELECT
    saveState()
  ENDIF
ENDPROC

PROC backup(str:PTR TO CHAR,cycle)
  DEF fi,fo
  DEF ch[10]:STRING
  DEF num
  DEF im1[200]:STRING
  DEF im2[200]:STRING
  
  num:=cycle
  
  IF(tLock(str))
    WHILE(cycle)
      StringF(im1,'\s{\d}',str,cycle)
      IF(tLock(im1))
        IF(cycle=num)
          DeleteFile(im1)
        ELSE
          StringF(im2,'\s{\d}',str,cycle+1)
          Rename(im1,im2)
          restrict(im2)
        ENDIF
      ENDIF
      cycle--
    ENDWHILE

    StringF(im1,'\s{1}',str)
    Rename(str,im1)
    fi:=Open(im1,MODE_OLDFILE)
    fo:=Open(str,MODE_NEWFILE)
    WHILE(Fread(fi,ch,1,1)<>0)
      Fwrite(fo,ch,1,1)
    ENDWHILE
    Close(fo)
    Close(fi)
    restrict(im1)
    restrict(str)
  ENDIF
ENDPROC

PROC restrict(str:PTR TO CHAR)
  DEF fLock
  DEF bad=TRUE
  DEF fBlock:PTR TO fileinfoblock

  IF((fLock:=Lock(str,ACCESS_READ)))<>0
    IF((fBlock:=AllocMem(SIZEOF fileinfoblock,MEMF_CHIP OR MEMF_CLEAR)))=NIL
      bad:=TRUE
    ELSE 
      IF((Examine(fLock,fBlock)))=0
        bad:=TRUE
      ELSE 
        bad:=FALSE
      ENDIF
      FreeMem(fBlock,SIZEOF fileinfoblock);
    ENDIF
    UnLock(fLock)
    IF(bad=FALSE) THEN SetComment(str,'Restricted')
  ENDIF
ENDPROC

PROC maddNodes(nodes)
  DEF temp[100]:STRING
  DEF i
  
  FOR i:=0 TO nodes
    StringF(temp,'Node \d',i)
    maddItem(NM_SUB,temp,0,0,0,0)
  ENDFOR
ENDPROC

PROC maddItem(type,label:PTR TO CHAR,commKey:PTR TO CHAR,flags,mutual,userData)
   ->DEF i=0   was static
   DEF t:PTR TO newmenu
   DEF s:PTR TO CHAR
   IF(menuset=1)
     eWinMenu:=AllocMem((SIZEOF newmenu)*maddItemi,MEMF_PUBLIC OR MEMF_CLEAR)
     menuset:=-1
     maddItemi:=0
   ENDIF
   IF(menuset=-1)
     t:=eWinMenu+(maddItemi*(SIZEOF newmenu))
     t.type:=type
     s:=AllocMem(80,MEMF_PUBLIC OR MEMF_CLEAR)
     IF(label) THEN AstrCopy(s,label) ELSE AstrCopy(s,'')
     t.label:=s
     t.commkey:=commKey
     t.flags:=flags
     t.mutualexclude:=mutual
     t.userdata:=userData
     maxMenus++
   ENDIF
   maddItemi++
ENDPROC

PROC maddRem()
  DEF i
  DEF t:PTR TO newmenu
  
  FOR i:=0 TO maxMenus-1
    t:=eWinMenu+(i*(SIZEOF newmenu))
    FreeMem(t.label,80)
  ENDFOR
  FreeMem(eWinMenu,(SIZEOF newmenu)*maxMenus)
ENDPROC

PROC regLastDownloads(name:PTR TO CHAR,dateStr:PTR TO CHAR,node)
  ->DEF num=0   was static
  
  regNodeDownloads(name,dateStr,node)
  lastDownloads.add(name,dateStr)
ENDPROC

PROC regNodeDownloads(name:PTR TO CHAR, dateStr:PTR TO CHAR,node)
  DEF list: PTR TO itemsList
  list:=ndDownloads[node]
  list.add(name,dateStr)
ENDPROC

PROC regLastUploads(name:PTR TO CHAR,dateStr:PTR TO CHAR,node)
  ->DEF num=0   was static
  
  regNodeUploads(name,dateStr,node)
  lastUploads.add(name,dateStr)
ENDPROC

PROC regNodeUploads(name:PTR TO CHAR,dateStr:PTR TO CHAR, node)
  DEF list: PTR TO itemsList
  list:=ndUploads[node]
  list.add(name,dateStr)
ENDPROC

PROC showQuiet(i)
  DEF rowTop
  rowTop:=topOffset+32+(i*11)

  SetAPen(eWin.rport,0)
  RectFill(eWin.rport,BLEF_0+2,rowTop-7,BLEF_0+BWID_0-3,rowTop+1)

  SetAPen(eWin.rport,getNodeTextColour(i))
  Move(eWin.rport,GLEF_USER+3,rowTop)
  Text(eWin.rport,users[i].user,IF StrLen(users[i].user)>22 THEN 22 ELSE StrLen(users[i].user))

  Move(eWin.rport,GLEF_LOCATION+2,rowTop)
  Text(eWin.rport,users[i].location,IF StrLen(users[i].location)>22 THEN 22 ELSE StrLen(users[i].location))

  Move(eWin.rport,GLEF_ACTION,rowTop)
  Text(eWin.rport,users[i].action,IF StrLen(users[i].action)>16 THEN 16 ELSE StrLen(users[i].action))

  Move(eWin.rport,GLEF_BAUD+5,rowTop)
  Text(eWin.rport,users[i].baud,7)
  drawChatBlock(i)
ENDPROC

PROC regLastUser(name:PTR TO CHAR,dateStr:PTR TO CHAR,node)
  DEF tempStr[44]:STRING
  ->DEF num=0;  was static
  
  StringF(tempStr,'\d: \s',node,name)
  regNodeUser(name,dateStr,node)
  lastUsers.add(tempStr,dateStr)
ENDPROC

PROC regNodeUser(name:PTR TO CHAR,dateStr:PTR TO CHAR, node)
  DEF list: PTR TO itemsList
  list:=ndUser[node]
  list.add(name,dateStr)
ENDPROC

PROC showLastUser(win:PTR TO window)
  DEF i=0
  DEF rowTop
  DEF tempStr[255]:STRING

  rowTop:=topOffset+(theight*11)+BTOP_TOPSBOX
  SetAPen(win.rport,0)
  RectFill(win.rport,BLEF_TOPSBOX+5,rowTop+1,BLEF_TOPSBOX+BWID_TOPSBOX-10,rowTop+BHEI_TOPSBOX-2)
  SetAPen(win.rport,1)
  WHILE(i<5)
    rowTop:=topOffset+155+(i*10)-110+(theight*11)
    lastUsers.getDisplayText(i,tempStr)
    printMyText(win.rport,tempStr,GLEF_TOPS+5,rowTop)
    i++
  ENDWHILE
ENDPROC

PROC showNdLastUser(win:PTR TO window,node)
  DEF i=0
  DEF rowTop
  DEF list: PTR TO itemsList
  DEF tempStr[255]:STRING

  rowTop:=topOffset+(theight*11)+BTOP_TOPSBOX
  SetAPen(win.rport,0)
  RectFill(win.rport,BLEF_TOPSBOX+5,rowTop+1,BLEF_TOPSBOX+BWID_TOPSBOX-10,rowTop+BHEI_TOPSBOX-2)
  SetAPen(win.rport,1)
  WHILE(i<5)
    rowTop:=topOffset+155+(i*10)-110+(theight*11)
    list:=ndUser[node]
    list.getDisplayText(i,tempStr)
    printMyText(win.rport,tempStr,GLEF_TOPS+5,rowTop)
    i++
  ENDWHILE
ENDPROC

PROC showLastUploads(win:PTR TO window)
  DEF i=0
  DEF rowTop
  DEF tempStr[255]:STRING

  rowTop:=topOffset+(theight*11)+BTOP_TOPSBOX
  SetAPen(win.rport,0)
  RectFill(win.rport,BLEF_TOPSBOX+5,rowTop+1,BLEF_TOPSBOX+BWID_TOPSBOX-10,rowTop+BHEI_TOPSBOX-2)
  SetAPen(win.rport,1)
  WHILE(i<5)
    rowTop:=topOffset+155+(i*10)-110+(theight*11)
    lastUploads.getDisplayText(i,tempStr)
    printMyText(win.rport,tempStr,GLEF_TOPS+5,rowTop)
    i++
  ENDWHILE
ENDPROC

PROC showNdLastUploads(win:PTR TO window,node)
  DEF i=0
  DEF rowTop
  DEF list: PTR TO itemsList
  DEF tempStr[255]:STRING

  rowTop:=topOffset+(theight*11)+BTOP_TOPSBOX
  SetAPen(win.rport,0)
  RectFill(win.rport,BLEF_TOPSBOX+5,rowTop+1,BLEF_TOPSBOX+BWID_TOPSBOX-10,rowTop+BHEI_TOPSBOX-2)
  SetAPen(win.rport,1)
  WHILE(i<5)
    rowTop:=topOffset+155+(i*10)-110+(theight*11)
    list:=ndUploads[node]
    list.getDisplayText(i,tempStr)
    printMyText(win.rport,tempStr,GLEF_TOPS+5,rowTop)
    i++
  ENDWHILE
ENDPROC

PROC showLastDownloads(win:PTR TO window)
  DEF i=0
  DEF rowTop
  DEF tempStr[255]:STRING

  rowTop:=topOffset+(theight*11)+BTOP_TOPSBOX
  SetAPen(win.rport,0)
  RectFill(win.rport,BLEF_TOPSBOX+5,rowTop+1,BLEF_TOPSBOX+BWID_TOPSBOX-10,rowTop+BHEI_TOPSBOX-2)
  SetAPen(win.rport,1)
  WHILE(i<5)
    rowTop:=topOffset+155+(i*10)-110+(theight*11)
    lastDownloads.getDisplayText(i,tempStr)
    printMyText(win.rport,tempStr,GLEF_TOPS+5,rowTop)
    i++
  ENDWHILE
ENDPROC

PROC showNdLastDownloads(win:PTR TO window,node)
  DEF i=0
  DEF rowTop
  DEF list: PTR TO itemsList
  DEF tempStr[255]:STRING

  rowTop:=topOffset+(theight*11)+BTOP_TOPSBOX
  SetAPen(win.rport,0)
  RectFill(win.rport,BLEF_TOPSBOX+5,rowTop+1,BLEF_TOPSBOX+BWID_TOPSBOX-10,rowTop+BHEI_TOPSBOX-2)
  SetAPen(win.rport,1)
  WHILE(i<5)
    rowTop:=topOffset+155+(i*10)-110+(theight*11)
    list:=ndDownloads[node]
    list.getDisplayText(i,tempStr)
    printMyText(win.rport,tempStr,GLEF_TOPS+5,rowTop)
    i++
  ENDWHILE
ENDPROC

PROC showNodes()
  DEF i,rowTop
  SetAPen(eWin.rport,0)
  RectFill(eWin.rport,BLEF_0+2,topOffset+BTOP_0+1,BLEF_0+BWID_0-3,topOffset+BTOP_0+(theight*11)-2)
  FOR i:=0 TO theight-1
    rowTop:=topOffset+32+(i*11)
    SetAPen(eWin.rport,getNodeTextColour(i))
     
    IF(users[i].active)
      Move(eWin.rport,GLEF_USER+3,rowTop)
      Text(eWin.rport,users[i].user,IF StrLen(users[i].user)>22 THEN 22 ELSE StrLen(users[i].user))
      Move(eWin.rport,GLEF_LOCATION+2,rowTop)
      Text(eWin.rport,users[i].location,IF StrLen(users[i].location)>22 THEN 22 ELSE StrLen(users[i].location))
      Move(eWin.rport,GLEF_ACTION,rowTop);
      Text(eWin.rport,users[i].action,IF StrLen(users[i].action)>16 THEN 16 ELSE StrLen(users[i].action))
      Move(eWin.rport,GLEF_BAUD+5,rowTop)
      Text(eWin.rport,users[i].baud,7)
    ENDIF
  ENDFOR
ENDPROC

PROC showCPS(node,incps:PTR TO CHAR)
  DEF cps[10]:STRING
  IF StrLen(incps)>7
    StrCopy(cps,'9999999')
  ELSE
    StringF(cps,'\s[7]',incps)
  ENDIF

  drawPen:=chat[node]
  IF(quietNode[node]) THEN drawPen:=3

  Move(eWin.rport,GLEF_BAUD+5,topOffset+32+(node*11))
  Text(eWin.rport,cps,7)
ENDPROC

PROC checkStartingScript()
  DEF i,allStarted=TRUE
  IF starting
    FOR i:=0 TO MAX_NODES-1
      IF (StrLen(startNode[i])>0) AND (nodeIdle[i]=FALSE)
        IF (users[i].active=FALSE) OR (users[i].actionVal=ENV_NOTACTIVE) THEN allStarted:=FALSE
      ENDIF
    ENDFOR
    IF allStarted
      IF StrLen(startupCompleteScript)>0 THEN Execute(startupCompleteScript,NIL,NIL)
      starting:=FALSE
    ENDIF
  ENDIF
ENDPROC

PROC checkMasterSig(signals)
  DEF temp[100]:STRING
  DEF temp1[10]:STRING
  DEF datestr[20]:STRING
  DEF tempstr2[255]:STRING
  DEF i,c
  DEF b:PTR TO button

  IF(signals AND masterSig)
    WHILE((cpymsg:=GetMsg(mp)))             
      IF(cpymsg.command=SV_START)
        AstrCopy(cpymsg.user,mybbslocation)
        cpymsg.myCmds:=cmds[cpymsg.node]
        cpymsg.sopt:=sopts[cpymsg.node]
        IF activeNodes[cpymsg.node]=FALSE
          activeNodeCount++
          activeNodes[cpymsg.node]:=TRUE
        ENDIF
      ENDIF

      IF(cpymsg.command=SV_INFO)
        cpymsg.data:=acpData;
        ReplyMsg(cpymsg)
      ENDIF

      IF(cpymsg.command=SV_NODE_LOCK)
        IF lockedNodes=-1
          lockedNodes:=cpymsg.node
        ELSEIF lockedNodes:=cpymsg.node
          lockedNodes:=-1
        ENDIF
        cpymsg.data:=lockedNodes
        ReplyMsg(cpymsg)
      ELSEIF(cpymsg.command=SV_ACPALERT)
        myrequest(cpymsg.user)
        ReplyMsg(cpymsg)
      ELSEIF(cpymsg.command=SV_STARTNODE)
        StringF(temp,'AmiExpress_Node.\d',cpymsg.node)
        IF(FindPort(temp))=FALSE
          IF(startProcess(startNode[cpymsg.node],bbsStack))
            IF activeNodes[cpymsg.node]=FALSE
              activeNodeCount++
              activeNodes[cpymsg.node]:=TRUE
            ENDIF
          ENDIF
        ENDIF
        ReplyMsg(cpymsg)
      ELSE
        CopyMem(cpymsg,msg,SIZEOF acpMessage)
        ReplyMsg(cpymsg)
        c:=msg.command
        SELECT c
          CASE JH_UPDATE
              updateNode(msg.user,msg.location,msg.action,msg.baud,msg.node)
              checkStartingScript()
              IF(showAbout)
                showNodes()
                showAbout:=0
              ENDIF
          CASE JH_DOWNLOAD
              trimStr(msg.user,tempstr2)

              getSystemDate(datestr)
               
              regLastDownloads(tempstr2,datestr,msg.node)
              saveState()
              IF topOption = LAST_DOWNLOADS THEN showLastDownloads(eWin)
              StringF(temp,'DL: \s',msg.user)
              StringF(temp1,'\d',SV_NEWMSG)
              updateNode(temp,msg.location,temp1,msg.baud,msg.node)
              IF(showAbout)
                showNodes()
                showAbout:=0
              ENDIF
          CASE JH_UPLOAD
              trimStr(msg.user,tempstr2)

              getSystemDate(datestr)
                
              regLastUploads(tempstr2,datestr,msg.node)
              saveState()
              IF topOption = LAST_UPLOADS THEN showLastUploads(eWin)
              StringF(temp,'UL: \s',msg.user)
              StringF(temp1,'\d',SV_NEWMSG)
              updateNode(temp,msg.location,temp1,msg.baud,msg.node)
              IF(showAbout)
                showNodes()
                showAbout:=0
              ENDIF
          CASE JH_CHATON
              tChat[msg.node]:=1
              drawChatBlock(msg.node)
          CASE JH_CHATOFF
              tChat[msg.node]:=0
              drawChatBlock(msg.node)
          CASE JH_QUIETON
              quietNode[msg.node]:=1 
              showQuiet(msg.node)
          CASE JH_QUIETOFF
              quietNode[msg.node]:=0
              showQuiet(msg.node)
          CASE JH_AUTOCOMMAND
              i:=button
              IF(msg.data<20)
                button:=0
                control:=0
                IF(msg.data>=0) THEN handleEditGadget(NIL,GAD_SYSOPLOGIN+msg.data)
                handleEditGadget(NIL,GAD_NODES+msg.node);
              ELSE
                button:=1
                msg.data:=msg.data-20
                control:=0
                handleEditGadget(NIL,GAD_SYSOPLOGIN+bm[msg.data])
                b:=buttons[bm[msg.data]]
                IF(b.type) THEN handleEditGadget(NIL,GAD_NODES+msg.node) 
              ENDIF
              button:=i
          CASE JH_TRANSFERCPS
              showCPS(msg.node,msg.user)
        ENDSELECT
      ENDIF
    ENDWHILE
  ENDIF
ENDPROC

PROC drawChatBlock(node)
  DEF colour
  colour:=IF tChat[node] THEN getNodeTextColour(node) ELSE 0
  SetAPen(eWin.rport,colour)
  Move(eWin.rport,64,topOffset+26+(node*11))
  Draw(eWin.rport,64,topOffset+26+(node*11)+6)
  Move(eWin.rport,63,topOffset+26+(node*11))
  Draw(eWin.rport,63,topOffset+26+(node*11)+6)
  Move(eWin.rport,62,topOffset+26+(node*11))
  Draw(eWin.rport,62,topOffset+26+(node*11)+6)
  Move(eWin.rport,61,topOffset+26+(node*11))
  Draw(eWin.rport,61,topOffset+26+(node*11)+6) 
ENDPROC

PROC cmdOpt(cmd:PTR TO commands,maxNodes,x,y)
  DEF j
  FOR j:=0 TO maxNodes-1
    cmd.acLvl[x]:=y
  ENDFOR
ENDPROC

PROC stripInfo(y:PTR TO CHAR)
  DEF x,brk=FALSE
  
  x:=StrLen(y)-1
  WHILE(x>-1)
    IF(y[x]=".")
      y[x]:=0
      brk:=TRUE
    ENDIF
    EXIT brk
    x--
  ENDWHILE
ENDPROC x

PROC createSemaphores()
  Forbid()
  IF((semiNodes:=FindSemaphore(multiName)))=FALSE
    semiNodes:=AllocMem(SIZEOF multiPort,MEMF_PUBLIC OR MEMF_CLEAR)
    AstrCopy(semiNodes.semiName,multiName)
    semiNodes.semi.ln.pri:=0
    semiNodes.semi.ln.name:=semiNodes.semiName
    newList(semiNodes.list)
    initSemaSemiNodes(semiNodes)
    InitSemaphore(semiNodes)
    ->AddSemaphore((semiNodes)
  ELSE
    ObtainSemaphore(semiNodes)
    initSemaSemiNodes(semiNodes)
    ReleaseSemaphore(semiNodes)
  ENDIF
  Permit()
ENDPROC

PROC initSemaSemiNodes(s:PTR TO multiPort)
  DEF i=0
  DEF j
  WHILE(i<MAX_NODES)
    AstrCopy(s.myNode[i].handle,'')
    FOR j:=0 TO MAX_NODES-1
      s.myNode[i].stats[j].info:=0
      s.myNode[i].stats[j].status:=CHAT_NONE
    ENDFOR
    
    s.myNode[i].t:=NIL
    s.myNode[i].taskSignal:=NIL
    s.myNode[i].netSocket:=-1
    s.myNode[i].private:=FALSE
    s.myNode[i].offHook:=TRUE
    s.myNode[i].chatColor:=i+1
    StringF(singleName,'AEStat\d',i)
    singleNode:=FindSemaphore(singleName)
    IF(singleNode=FALSE)
      singleNode:=AllocMem(SIZEOF singlePort,MEMF_PUBLIC OR MEMF_CLEAR)
      AstrCopy(singleNode.semiName,singleName)
      singleNode.semi.ln.pri:=0
      singleNode.semi.ln.name:=singleNode.semiName
      singleNode.multiCom:=s
      AstrCopy(singleNode.handle,'')
      AstrCopy(singleNode.location,'')
      AstrCopy(singleNode.misc1,'')
      AstrCopy(singleNode.misc2,'')
      singleNode.status:=-1
      newList(singleNode.list)
      InitSemaphore(singleNode)
      ->AddSemaphore(singleNode)
    
    ELSE
      ObtainSemaphore(singleNode)
      singleNode.multiCom:=s
      AstrCopy(singleNode.handle,'')
      AstrCopy(singleNode.location,'')
      AstrCopy(singleNode.misc1,'')
      AstrCopy(singleNode.misc2,'')
      singleNode.status:=-1
      ReleaseSemaphore(singleNode)
    ENDIF
    s.myNode[i].s:=singleNode
    IF(s.myNode[i].chatColor>7)
      s.myNode[i].chatColor:=s.myNode[i].chatColor-6
    ENDIF
    i++
     
  ENDWHILE
ENDPROC

PROC shutDownSemis()
  DEF i
  DEF p:PTR TO singlePort
  Forbid()
  ->RemSemaphore((struct SignalSemaphore *)SemiNodes);
  ObtainSemaphore(semiNodes)
  FOR i:=0 TO MAX_NODES-1
     p:=semiNodes.myNode[i].s
     ->RemSemaphore((struct SignalSemaphore *)p);
     ObtainSemaphore(p)
     ReleaseSemaphore(p)
     FreeMem(p,SIZEOF singlePort)
  ENDFOR
  ReleaseSemaphore(semiNodes)
  FreeMem(semiNodes,SIZEOF multiPort)
  Permit()
ENDPROC

PROC loadTranslators(baseDir:PTR TO CHAR)
  DEF baseLang[255]:STRING
  DEF fileName[255]:STRING
  DEF fullFileName[512]:STRING
  DEF ext[4]:STRING
  DEF translatorName[80]:STRING
  DEF trans1: PTR TO translator
  DEF trans2: PTR TO translator
  DEF tempstr1[255]:STRING
  DEF tempstr2[255]:STRING
  DEF tempstr3[512]:STRING
  DEF fh,fsize
  DEF intxt:PTR TO CHAR
  DEF outtxt:PTR TO CHAR
  DEF workMem
  DEF counts[27]:ARRAY OF LONG
  DEF indexes[27]:ARRAY OF LONG
  DEF i,j,n,cnt
  DEF wordList:PTR TO LONG,transCount=0

  FOR i:=0 TO 26
    counts[i]:=0
  ENDFOR

  trans1:=NIL
  trans2:=NIL
  StrCopy(baseLang,baseDir)
  checkPathSlash(baseLang)
  
  IF findFirst(baseLang,fileName)
    REPEAT
      RightStr(ext,fileName,4)
      UpperStr(ext)
      IF StrCmp(ext,'.TRN')
        StrCopy(translatorName,fileName)
        SetStr(translatorName,EstrLen(translatorName)-4)
        StringF(fullFileName,'\s\s',baseLang,fileName)
  
        trans2:=NEW trans2
        AstrCopy(trans2.translatorName,translatorName,80)
        fsize:=FileLength(fullFileName)

        workMem:=New(fsize+2)     ->allocate some memory (two extra bytes in case there is no newline at the end of the file)
        trans2.translationText:=New(fsize+4)     ->allocate some memory, two extra bytes for ending colon and space and some in case there is no newline
        
        fh:=Open(fullFileName,MODE_OLDFILE)
        IF fh<>0
          ->read file into workMem
          outtxt:=workMem
          
          ReadStr(fh,tempstr1) 
          ReadStr(fh,tempstr2) 
          LowerStr(tempstr1)
          LowerStr(tempstr2)
          cnt:=0
          WHILE((StrLen(tempstr1)>0) OR (StrLen(tempstr2)>0))
            cnt++
            AstrCopy(outtxt,tempstr1,256)
            IF (outtxt[0]>="a") AND (outtxt[0]<="z")
              n:=outtxt[0]-"a"
              counts[n]:=counts[n]+1
            ELSE
              counts[26]:=counts[26]+1
            ENDIF
            outtxt:=outtxt+StrLen(outtxt)+1
            AstrCopy(outtxt,tempstr2,256)
            outtxt:=outtxt+StrLen(outtxt)+1
            ReadStr(fh,tempstr1) 
            ReadStr(fh,tempstr2) 
            LowerStr(tempstr1)
            LowerStr(tempstr2)
          ENDWHILE
          Close(fh)

          FOR i:=0 TO 26
            indexes[i]:=List(counts[i])
          ENDFOR
         
          outtxt:=workMem
          FOR i:=0 TO cnt-1
            IF (outtxt[0]>="a") AND (outtxt[0]<="z")
              n:=outtxt[0]-"a"
              wordList:=indexes[n]
            ELSE
              wordList:=indexes[26]
            ENDIF
            ListAdd(wordList,[outtxt])
            outtxt:=outtxt+StrLen(outtxt)+1
            outtxt:=outtxt+StrLen(outtxt)+1
          ENDFOR

          outtxt:=trans2.translationText
          FOR i:=0 TO 26
            trans2.translationIndexes[i]:=outtxt
            wordList:=indexes[i]
            FOR j:=0 TO ListLen(wordList)-1
              intxt:=wordList[j]
              StrCopy(tempstr1,intxt)
              intxt:=intxt+StrLen(intxt)+1
              StrCopy(tempstr2,intxt)
              intxt:=intxt+StrLen(intxt)+1

              StringF(tempstr3,':\s \s',tempstr1,tempstr2)
              AstrCopy(outtxt,tempstr3,513)
              outtxt:=outtxt+StrLen(outtxt)
            ENDFOR
          ENDFOR
          trans2.translationIndexes[27]:=outtxt
          AstrCopy(outtxt,': ',3)

          FOR i:=0 TO 26
            DisposeLink(indexes[i])
          ENDFOR
          transCount++
        ELSE
          StringF(tempstr1,'Fatal Error Reading Translation file \s',fileName)
          myrequest(tempstr1)
          Dispose(trans2.translationText)
          trans2.translationText:=NIL
        ENDIF
        Dispose(workMem)
        IF trans1<>NIL
           trans2.trans.pred:=trans1    ->ptr to previous translator
           trans2.trans.succ:=NIL       ->ptr to next will initially be nil

           trans1.trans.succ:=trans2    ->ptr to next translator
        ELSE
           translators:=trans2
        ENDIF
        trans1:=trans2
      ENDIF
    UNTIL findNext(fileName)=0
    findClose()
    IF trans1<>NIL
      trans2:=NEW trans2
      trans2.trans.pred:=trans1    ->ptr to previous translator
      trans2.trans.succ:=NIL       ->ptr to next will initially be nil
      AstrCopy(trans2.translatorName,'',80)

      trans1.trans.succ:=trans2    ->ptr to next translator
    ENDIF
  ENDIF
  ->WriteF('translators: \d\n',transCount)
ENDPROC transCount<>0

PROC unloadTranslators()
  DEF transptr:PTR TO mln
  DEF transptr2:PTR TO translator

  IF (translators<>NIL)
    transptr:=translators
    REPEAT
      transptr2:=transptr
      transptr:=transptr2.trans.succ    ->get ptr to next translation object
      /*IF StrLen(transptr2.translatorName)>0
        WriteF('unloading \s\n',transptr2.translatorName)
      ENDIF*/
      IF transptr2.translationText<>NIL
        Dispose(transptr2.translationText) ->free the text for this object
      ENDIF
      END transptr2 ->free this object
    UNTIL transptr=NIL
    translators:=NIL
  ENDIF
ENDPROC

PROC getIconNodeInfo(i)
  DEF dobj: PTR TO diskobject
  DEF oldtooltypes,cfg
  DEF s:PTR TO CHAR
  DEF basis[200]:STRING
  DEF fileName[200]:STRING
  DEF temp[255]:STRING
  DEF cmd:PTR TO commands
  DEF sopt:PTR TO startOption
  DEF n
  
  cmd:=cmds[i]
  sopt:=sopts[i]
  
  StringF(basis,'\sNode\d/Modem',cmd.bbsLoc,i)
  
  IF(getFileName(basis,fileName))
    stripInfo(fileName)
    StringF(basis,'\sNode\d/Modem/\s',cmd.bbsLoc,i,fileName)
    dobj,cfg:=getToolTypes(basis)
    IF(dobj)
      oldtooltypes:=dobj.tooltypes
      IF(s:=FindToolType(oldtooltypes,'MODEM.INIT')) THEN AstrCopy(cmd.mInit,s)
      IF(s:=FindToolType(oldtooltypes,'MODEM.RESET')) THEN AstrCopy(cmd.mReset,s)
      IF(s:=FindToolType(oldtooltypes,'MODEM.RING')) THEN AstrCopy(cmd.mRing,s)
      IF(s:=FindToolType(oldtooltypes,'MODEM.ANSWER')) THEN AstrCopy(cmd.mAnswer,s)
      IF(s:=FindToolType(oldtooltypes,'MODEM.OFFHOOK')) THEN AstrCopy(sopt.offHook,s)
      IF(s:=FindToolType(oldtooltypes,'MODEM.CALLERID-1')) THEN sopt.toggles[TOGGLES_CALLERID]:=1
      IF(s:=FindToolType(oldtooltypes,'MODEM.CALLERID-2')) THEN sopt.toggles[TOGGLES_CALLERIDNAME]:=1
      freeToolTypes(dobj,cfg)
    ENDIF
  ENDIF
 
  StringF(basis,'\sNode\d/Serial',cmd.bbsLoc,i)
  IF(getFileName(basis,fileName))
    stripInfo(fileName)
    StringF(basis,'\sNode\d/Serial/\s',cmd.bbsLoc,i,fileName)
    dobj,cfg:=getToolTypes(basis)
    IF(dobj)
      oldtooltypes:=dobj.tooltypes
      IF(s:=FindToolType(oldtooltypes,'SERIAL.UNIT')) THEN cmd.serDevUnit:=Val(s)
      IF(s:=FindToolType(oldtooltypes,'SERIAL.BAUD')) THEN cmd.openingBaud:=Val(s)
      IF(s:=FindToolType(oldtooltypes,'SERIAL.DRIVER')) THEN AstrCopy(cmd.serDev,s)
      IF(s:=FindToolType(oldtooltypes,'SERIAL.A2232_PATCH')) THEN sopt.a2232:=TRUE
      IF(s:=FindToolType(oldtooltypes,'SERIAL.NO_PURGELINE')) THEN sopt.toggles[TOGGLES_NOPURGE]:=1
      IF(s:=FindToolType(oldtooltypes,'SERIAL.REPURGE')) THEN sopt.toggles[TOGGLES_REPURGE]:=1
      IF(s:=FindToolType(oldtooltypes,'SERIAL.LOGOFF_RESET')) THEN sopt.toggles[TOGGLES_SERIALRESET]:=1
      IF(s:=FindToolType(oldtooltypes,'SERIAL.TRUE_RESET')) THEN sopt.toggles[TOGGLES_TRUERESET]:=1
      freeToolTypes(dobj,cfg)
    ENDIF
  ENDIF
  
  StringF(fileName,'\sNode\d/WINDOW.DEF',cmd.bbsLoc,i)
  dobj,cfg:=getToolTypes(fileName)
  IF(dobj)
    oldtooltypes:=dobj.tooltypes
    IF(s:=FindToolType(oldtooltypes,'WINDOW.LEFTEDGE')) THEN sopt.leftEdge:=Val(s)
    IF(s:=FindToolType(oldtooltypes,'WINDOW.TOPEDGE')) THEN sopt.topEdge:=Val(s)
    IF(s:=FindToolType(oldtooltypes,'WINDOW.HEIGHT')) THEN sopt.height:=Val(s)
    IF(s:=FindToolType(oldtooltypes,'WINDOW.WIDTH')) THEN sopt.width:=Val(s)
    IF(s:=FindToolType(oldtooltypes,'WINDOW.STATBAR')) THEN sopt.statBar:=TRUE
    IF(s:=FindToolType(oldtooltypes,'WINDOW.ICONIFIED')) THEN sopt.iconify:=TRUE
    IF(s:=FindToolType(oldtooltypes,'WINDOW.INTERLACE')) THEN sopt.interlace:=TRUE
    IF(s:=FindToolType(oldtooltypes,'WINDOW.TO_FRONT')) THEN cmd.acLvl[LVL_SCREEN_TO_FRONT]:=1
    IF(s:=FindToolType(oldtooltypes,'WINDOW.NUM_COLORS'))
       n:=Val(s)
       SELECT 17 OF n
         CASE 0
           sopt.bitPlanes:=0
         CASE 1,2
           sopt.bitPlanes:=1
         CASE 3,4
           sopt.bitPlanes:=2
         CASE 5,6,7,8
           sopt.bitPlanes:=3
         CASE 9,10,11,12,13,14,15,16
           sopt.bitPlanes:=4
         DEFAULT 
           sopt.bitPlanes:=3
       ENDSELECT
    ENDIF
    freeToolTypes(dobj,cfg)
  ENDIF
  StringF(fileName,'\sNode\d',cmd.bbsLoc,i)
  dobj,cfg:=getToolTypes(fileName)
  IF(dobj)
    oldtooltypes:=dobj.tooltypes
    IF(s:=FindToolType(oldtooltypes,'SYSTEM_PASSWORD')) THEN AstrCopy(cmd.sysPass,s)
    IF(s:=FindToolType(oldtooltypes,'REMOTE_PASSWORD')) THEN AstrCopy(cmd.remotePass,s)
    IF(s:=FindToolType(oldtooltypes,'NEWUSER_PASSWORD')) THEN AstrCopy(cmd.newUserPw,s)
    IF(s:=FindToolType(oldtooltypes,'PRIORITY')) THEN cmd.taskPri:=Val(s)
    IF(s:=FindToolType(oldtooltypes,'QUIETNODE')) THEN sopt.toggles[TOGGLES_QUIETSTART]:=TRUE
    IF(s:=FindToolType(oldtooltypes,'NODESTART')) 
      StrCopy(basis,s)
      StringF(fileName,'\s \d',basis,i)
      StrCopy(startNode[i],fileName)
      startUp:=TRUE
    ENDIF
      
    IF(s:=FindToolType(oldtooltypes,'IDLENODE')) THEN nodeIdle[i]:=1
    IF(s:=FindToolType(oldtooltypes,'TRAPDOOR')) THEN sopt.trapDoor:=TRUE
    IF(s:=FindToolType(oldtooltypes,'PLAYPEN')) 
      StrCopy(temp,s)
      checkPathSlash(temp)
      AstrCopy(sopt.ramPen,temp)
    ENDIF
    IF(s:=FindToolType(oldtooltypes,'SENTBY_FILES')) THEN cmd.acLvl[LVL_SENTBY_FILES]:=1
    IF(s:=FindToolType(oldtooltypes,'CHAT_ON')) THEN cmd.acLvl[LVL_DEFAULT_CHAT_ON]:=1
    IF(s:=FindToolType(oldtooltypes,'CAPITOL_FILES')) THEN cmd.acLvl[LVL_CAPITOLS_in_FILE]:=1
    IF(s:=FindToolType(oldtooltypes,'SYSOP_CHAT_COLOR')) THEN cmd.acLvl[LVL_CHAT_COLOR_SYSOP]:=Val(s)
    IF(s:=FindToolType(oldtooltypes,'USER_CHAT_COLOR')) THEN cmd.acLvl[LVL_CHAT_COLOR_USER]:=Val(s)
    IF(s:=FindToolType(oldtooltypes,'KEEP_UPLOAD_CREDIT')) THEN cmd.acLvl[LVL_KEEP_UPLOAD_CREDIT]:=Val(s)
    IF(s:=FindToolType(oldtooltypes,'FREE_RESUMING')) THEN cmd.acLvl[LVL_ALLOW_FREE_RESUMING]:=1
    IF(s:=FindToolType(oldtooltypes,'CALLERS_LOG')) THEN cmd.acLvl[LVL_DO_CALLERSLOG]:=1
    IF(s:=FindToolType(oldtooltypes,'UD_LOG')) THEN cmd.acLvl[LVL_DO_UD_LOG]:=1
    IF(s:=FindToolType(oldtooltypes,'DOOR_LOG')) THEN sopt.toggles[TOGGLES_DOORLOG]:=1
    IF(s:=FindToolType(oldtooltypes,'START_LOG')) THEN sopt.toggles[TOGGLES_STARTLOG]:=1
    IF(s:=FindToolType(oldtooltypes,'NO_TIMEOUT')) THEN sopt.toggles[TOGGLES_NOTIMEOUT]:=1
    IF(s:=FindToolType(oldtooltypes,'NO_MCI_MSG')) THEN sopt.toggles[TOGGLES_NOMCIMSGS]:=1 
    ->IF(s:=FindToolType(oldtooltypes,'BREAK_CHAT')) THEN sopt.toggles[TOGGLES_BREAK_CHAT]:=1   NOT USED ANYMORE!!
    IF(s:=FindToolType(oldtooltypes,'NO_WILDCARD_EXPANSION')) THEN sopt.toggles[TOGGLES_USEWILDCARDS]:=0 ELSE sopt.toggles[TOGGLES_USEWILDCARDS]:=1
    IF(s:=FindToolType(oldtooltypes,'DISABLE_QUICK_LOGONS')) THEN sopt.qLogon:=1
    IF(s:=FindToolType(oldtooltypes,'FILESNOTALLOWED')) THEN AstrCopy(sopt.filesNot,s)
    IF(s:=FindToolType(oldtooltypes,'SCREENS')) 
      StrCopy(temp,s)
      checkPathSlash(temp)
      AstrCopy(sopt.nodeScreens,temp)
    ELSE
       StringF(temp,'\sNode\d/',cmd.bbsLoc,i)
       AstrCopy(sopt.nodeScreens,temp)
    ENDIF
    
    IF(s:=FindToolType(oldtooltypes,'TELNET')) THEN telnetNode[i]:=1
    IF(s:=FindToolType(oldtooltypes,'FTP')) THEN ftpNode[i]:=1
    freeToolTypes(dobj,cfg)
  ENDIF
ENDPROC

PROC getIconBBSInfo(maxNodes)
  DEF dobj:PTR TO diskobject
  DEF cfg
  DEF oldtooltypes

  DEF s:PTR TO CHAR
  DEF sopt:PTR TO startOption 
  DEF cmd:PTR TO commands

  DEF i
  DEF def
  DEF temp[100]:STRING
  cmd:=cmds[0]
  StringF(temp,'\sCONFCONFIG',cmd.bbsLoc)
  dobj,cfg:=getToolTypes(temp)
  IF(dobj)
    oldtooltypes:=dobj.tooltypes
    IF(s:=FindToolType(oldtooltypes,'RELATIVE_CONFERENCES'))
      FOR i:=0 TO maxNodes-1
        sopt:=sopts[i]
        sopt.toggles[TOGGLES_CONFRELATIVE]:=1
      ENDFOR
    ENDIF
    freeToolTypes(dobj,cfg)
  ENDIF
  StringF(temp,'\sACCESS',cmd.bbsLoc)
  dobj,cfg:=getToolTypes(temp)
  IF(dobj=NIL) THEN RETURN
  oldtooltypes:=dobj.tooltypes
  
  def:=0
  IF(s:=FindToolType(oldtooltypes,'ACS.ACCOUNT_EDITING'))    THEN cmdOpt(cmd,maxNodes,ACS_ACCOUNT_EDITING,1)  ELSE cmdOpt(cmd,maxNodes,ACS_ACCOUNT_EDITING,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.COMMENT_TO_SYSOP'))   THEN cmdOpt(cmd,maxNodes,ACS_COMMENT_TO_SYSOP,1) ELSE cmdOpt(cmd,maxNodes,ACS_COMMENT_TO_SYSOP,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.DOWNLOAD'))           THEN cmdOpt(cmd,maxNodes,ACS_DOWNLOAD,1) ELSE cmdOpt(cmd,maxNodes,ACS_DOWNLOAD,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.ENTER_MESSAGE'))      THEN cmdOpt(cmd,maxNodes,ACS_ENTER_MESSAGE,1) ELSE cmdOpt(cmd,maxNodes,ACS_ENTER_MESSAGE,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.FILE_LISTINGS'))      THEN cmdOpt(cmd,maxNodes,ACS_FILE_LISTINGS,1) ELSE cmdOpt(cmd,maxNodes,ACS_FILE_LISTINGS,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.JOIN_CONFERENCE'))    THEN cmdOpt(cmd,maxNodes,ACS_JOIN_CONFERENCE,1) ELSE cmdOpt(cmd,maxNodes,ACS_JOIN_CONFERENCE,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.NEW_FILES_SINCE'))    THEN cmdOpt(cmd,maxNodes,ACS_NEW_FILES_SINCE,1) ELSE cmdOpt(cmd,maxNodes,ACS_NEW_FILES_SINCE,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.PAGE_SYSOP'))         THEN cmdOpt(cmd,maxNodes,ACS_PAGE_SYSOP,1) ELSE cmdOpt(cmd,maxNodes,ACS_PAGE_SYSOP,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.READ_MESSAGE'))       THEN cmdOpt(cmd,maxNodes,ACS_READ_MESSAGE,1) ELSE cmdOpt(cmd,maxNodes,ACS_READ_MESSAGE,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.DISPLAY_USER_STATS')) THEN cmdOpt(cmd,maxNodes,ACS_DISPLAY_USER_STATS,1) ELSE cmdOpt(cmd,maxNodes,ACS_DISPLAY_USER_STATS,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.UPLOAD'))             THEN cmdOpt(cmd,maxNodes,ACS_UPLOAD,1) ELSE cmdOpt(cmd,maxNodes,ACS_UPLOAD,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.VIEW_A_FILE'))        THEN cmdOpt(cmd,maxNodes,ACS_VIEW_A_FILE,1) ELSE cmdOpt(cmd,maxNodes,ACS_VIEW_A_FILE,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.EDIT_USER_INFO'))     THEN cmdOpt(cmd,maxNodes,ACS_EDIT_USER_INFO,1) ELSE cmdOpt(cmd,maxNodes,ACS_EDIT_USER_INFO,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.REMOTE_SHELL'))       THEN cmdOpt(cmd,maxNodes,ACS_REMOTE_SHELL,1) ELSE cmdOpt(cmd,maxNodes,ACS_REMOTE_SHELL,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.ZIPPY_TEXT_SEARCH'))  THEN cmdOpt(cmd,maxNodes,ACS_ZIPPY_TEXT_SEARCH,1) ELSE cmdOpt(cmd,maxNodes,ACS_ZIPPY_TEXT_SEARCH,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.OVERIDE_CHAT'))       THEN cmdOpt(cmd,maxNodes,ACS_OVERRIDE_CHAT,1) ELSE cmdOpt(cmd,maxNodes,ACS_OVERRIDE_CHAT,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.EDIT_USER_NAME'))     THEN cmdOpt(cmd,maxNodes,ACS_EDIT_USER_NAME,1) ELSE cmdOpt(cmd,maxNodes,ACS_EDIT_USER_NAME,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.EDIT_USER_LOCATION')) THEN cmdOpt(cmd,maxNodes,ACS_EDIT_USER_LOCATION,1) ELSE cmdOpt(cmd,maxNodes,ACS_EDIT_USER_LOCATION,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.EDIT_PHONE_NUMBER'))  THEN cmdOpt(cmd,maxNodes,ACS_EDIT_PHONE_NUMBER,1) ELSE cmdOpt(cmd,maxNodes,ACS_EDIT_PHONE_NUMBER,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.EDIT_PASSWORD'))      THEN cmdOpt(cmd,maxNodes,ACS_EDIT_PASSWORD,1) ELSE cmdOpt(cmd,maxNodes,ACS_EDIT_PASSWORD,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.OVERIDE_TIMES'))      THEN cmdOpt(cmd,maxNodes,ACS_OVERRIDE_TIMES,1) ELSE cmdOpt(cmd,maxNodes,ACS_OVERRIDE_TIMES,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.SYSOP_READ'))         THEN cmdOpt(cmd,maxNodes,ACS_SYSOP_READ,1) ELSE cmdOpt(cmd,maxNodes,ACS_SYSOP_READ,def)
  IF(s:=FindToolType(oldtooltypes,'ACS.READ_BULLETINS'))     THEN cmdOpt(cmd,maxNodes,ACS_READ_BULLETINS,1) ELSE cmdOpt(cmd,maxNodes,ACS_READ_BULLETINS,def)
  
  IF(s:=FindToolType(oldtooltypes,'ACS.EALL_MESSAGES'))
    FOR i:=0 TO maxNodes-1
      sopt:=sopts[i]
      sopt.eall_level:=1
    ENDFOR
  ELSE
    FOR i:=0 TO maxNodes-1
      sopt:=sopts[i]
      sopt.eall_level:=def
    ENDFOR
  ENDIF
  freeToolTypes(dobj,cfg)
ENDPROC

PROC setTheGads()
  DEF i 
  ->DEF j=0 ->static int j=0;
  ->DEF set=FALSE ->static BOOL Set=FALSE;
  DEF ng:PTR TO newgadget
  
  IF(setTheGadsj=FALSE)
    StrCopy(setOriText[0],'Sysop Login')
    StrCopy(setOriText[1],'Instant Login')
    StrCopy(setOriText[2],'AEShell')
    StrCopy(setOriText[3],'Toggle Chat')
    StrCopy(setOriText[4],'Exit Node')
    StrCopy(setOriText[5],'Local Login')
    StrCopy(setOriText[6],'Reserve Node')
    StrCopy(setOriText[7],'Accounts')
    StrCopy(setOriText[8],'Init Modem')
    StrCopy(setOriText[9],'Node(offhook)')
    StrCopy(setOriText[10],'Quiet Node')
    StrCopy(setOriText[11],'Config Node')
    StrCopy(setOriText[12],'Node Chat')
    StrCopy(setOriText[13],'Save Win')
    StrCopy(setOriText[14],'Set NRAMS')
    setTheGadsj:=1
    RETURN
  ENDIF
  
  FOR i:=0 TO 14
    ng:=ngAry[i]
    IF(setTheGadsSet=FALSE)    
      ng.gadgettext:=buttons[i].text
      button:=1
    ELSE
      button:=0
      buttonID:=-1
      ng.gadgettext:=setOriText[i]
    ENDIF
  ENDFOR
  IF(setTheGadsSet) THEN setTheGadsSet:=FALSE ELSE setTheGadsSet:=TRUE
ENDPROC

PROC toggleGads()
  RemoveGList(eWin,gadgets,-1);                    
  FreeGadgets(gadgets)
  setTheGads()
  
  gadgets:=initGads(scr)
  AddGList(eWin, gadgets, -1, -1, NIL)
  
  RefreshGList(eWin.firstgadget, eWin, NIL, -1)
  Gt_RefreshWindow(eWin,NIL)
 /*switch(TopOption)
    {
      case LAST_CALLERS:ShowLastUser(EWin);break;
      case LAST_UPLOADS:ShowLastUploads(EWin);break;
      case LAST_DOWNLOADS:ShowLastDownloads(EWin);break;
    }
 */
ENDPROC

PROC getCmds(i)
  DEF j
  DEF sopt:PTR TO startOption
  
  cmds[i]:=AllocMem(SIZEOF commands,MEMF_PUBLIC OR MEMF_CLEAR)
  sopts[i]:=AllocMem(SIZEOF startOption,MEMF_PUBLIC OR MEMF_CLEAR)
  sopt:=sopts[i]
  sopt.leftEdge:=0
  sopt.topEdge:=0
  sopt.width:=640
  sopt.height:=200
  sopt.bitPlanes:=3
  sopt.statBar:=FALSE
  sopt.interlace:=FALSE
  sopt.dupeCheck:=FALSE
  sopt.qLogon:=FALSE
  sopt.takeCredits:=FALSE
  sopt.seenIt:=FALSE
  sopt.trapDoor:=FALSE
  sopt.iconify:=FALSE
  sopt.eall_level:=255
  sopt.a2232:=FALSE
  sopt.translation:=NIL
  
  FOR j:=0 TO 19
    sopt.toggles[j]:=FALSE
  ENDFOR
  sopt.toggles[TOGGLES_REUSEINACTIVE]:=1
  IF(doMultiCom)
    ObtainSemaphore(semiNodes)
    sopt.masterSemi:=semiNodes
    sopt.singleSemi:=semiNodes.myNode[i].s
    ReleaseSemaphore(semiNodes)
    sopt.toggles[TOGGLES_MULTICOM]:=TRUE
  ELSE
    sopt.masterSemi:=NIL
    sopt.singleSemi:=NIL
  ENDIF

  AstrCopy(sopt.cycleLock,'')
  AstrCopy(sopt.logoff,'')
  AstrCopy(sopt.shutDown,'')
  AstrCopy(sopt.ramPen,'')
  AstrCopy(sopt.namePrompt,'')
  AstrCopy(sopt.filesNot,'')
  AstrCopy(sopt.userData,'')
  AstrCopy(sopt.userKey,'')
  AstrCopy(sopt.offHook,'')
  AstrCopy(sopt.nodeScreens,'')
ENDPROC

PROC readStartUp(s:PTR TO CHAR)
  DEF image[200]:STRING
  DEF tempstr[255]:STRING
  DEF dobj:PTR TO diskobject
  DEF cmd:PTR TO commands
  DEF sopt:PTR TO startOption
  DEF oldtooltypes,cfg
  DEF t:  PTR TO CHAR
  DEF i,n
  DEF nodeCount
  DEF buttonnum=0
  DEF buttontitle=0
  DEF j
  
  FOR i:=0 TO MAX_NODES-1
    nodeIdle[i]:=0
  ENDFOR

  FOR i:=0 TO 16
    AstrCopy(buttons[i].text,'')
    AstrCopy(buttons[i].command,'')
  ENDFOR
  
  dobj,cfg:=getToolTypes(s)
  IF (dobj=NIL) 
    selectAndRunConfig('','s:','aeicon.json')
    
    dobj,cfg:=getToolTypes(s)
    IF (dobj=NIL) 
      myrequest('Error, can''t locate acp.info')
      acpError:=1
      RETURN
    ENDIF
  ENDIF
  oldtooltypes:=dobj.tooltypes
  
  IF(t:=FindToolType(oldtooltypes,'ACPFONT'))
    StrCopy(fontName,t)
  ENDIF

  IF(FindToolType(oldtooltypes,'MULTICOM_PORT'))
    doMultiCom:=1
    createSemaphores()
  ENDIF
  
  IF(t:=FindToolType(oldtooltypes,'PUBLICSCREEN'))
    StrCopy(publicName,t)
  ENDIF
  
  IF(t:=FindToolType(oldtooltypes,'NODES')) 
    j:=0
    nodeCount:=Val(t)
    WHILE(j<nodeCount)
      getCmds(j)
      IF(theight<j) THEN theight:=j
      nodes[j]:=1
      cmd:=cmds[j]
      cmd.acLvl[LVL_NODE_NUMBER]:=j
      j++
    ENDWHILE
  ELSE
    freeToolTypes(dobj,cfg)
    myrequest('ERROR, missing NODES tooltype\nPlease refer to /X documentation')
    acpError:=1
    RETURN
  ENDIF
  
  shellMode:=(FindToolType(oldtooltypes,'AESHELL')<>NIL)
  commodityEnabled:=(FindToolType(oldtooltypes,'NO_CX')=NIL)
  
  IF(t:=FindToolType(oldtooltypes,'ICONIFIED')) THEN zipOn:=TRUE
  IF(t:=FindToolType(oldtooltypes,'ICONIFY.LEFTEDGE')) THEN zim[0]:=Val(t)
  IF(t:=FindToolType(oldtooltypes,'ICONIFY.TOPEDGE')) THEN zim[1]:=Val(t)
  IF(t:=FindToolType(oldtooltypes,'SHORT_DONOTMOVE')) THEN shortUp:=1
  IF(t:=FindToolType(oldtooltypes,'PRIORITY')) THEN SetTaskPri(FindTask(0),Val(t))
  IF(t:=FindToolType(oldtooltypes,'TELNETPORT')) THEN telnetPort:=Val(t)
  IF(t:=FindToolType(oldtooltypes,'FTPPORT')) THEN ftpPort:=Val(t)
  IF(t:=FindToolType(oldtooltypes,'DOSCHECKTIME')) THEN dosCheckTime:=Val(t)
  IF(t:=FindToolType(oldtooltypes,'DOSCHECKTRIGGER')) THEN dosCheckTrigger:=Val(t)
  IF(t:=FindToolType(oldtooltypes,'DOSBANTIME')) THEN dosBanTime:=Val(t)
    
  j:=1
  StringF(image,'BACKUP.\d',j++)
  WHILE(t:=FindToolType(oldtooltypes,image))
     backup(t,5)
     StringF(image,'BACKUP.\d',j++)
  ENDWHILE
  j:=1
  StringF(image,'RESTRICT.\d',j++)
  WHILE(t:=FindToolType(oldtooltypes,image))
     restrict(t)
     StringF(image,'RESTRICT.\d',j++)
  ENDWHILE
  j:=1
  StringF(image,'BUTTON_NAME.\d',j++)
  WHILE(t:=FindToolType(oldtooltypes,image))
    AstrCopy(buttons[buttonnum++].text,t)
    StringF(image,'BUTTON_NAME.\d',j++)
  ENDWHILE
  j:=1
  StringF(image,'BUTTON_COMMAND.\d',j++)
  WHILE(t:=FindToolType(oldtooltypes,image))
    AstrCopy(buttons[buttontitle++].command,t)
    StringF(image,'BUTTON_COMMAND.\d',j++)
  ENDWHILE
  j:=1
  StringF(image,'NUTTON_NAME.\d',j++)
  WHILE(t:=FindToolType(oldtooltypes,image))
    AstrCopy(buttons[buttonnum++].text,t)
    StringF(image,'NUTTON_NAME.\d',j++)
  ENDWHILE
  j:=1
  StringF(image,'NUTTON_COMMAND.\d',j++)

  WHILE(t:=FindToolType(oldtooltypes,image))
    AstrCopy(buttons[buttontitle].command,t)
    buttons[buttontitle++].type:=TRUE
    StringF(image,'NUTTON_COMMAND.\d',j++)
  ENDWHILE

  bbsStack:=60000
  
  IF(t:=FindToolType(oldtooltypes,'BBS_STACK')) THEN bbsStack:=Val(t)
  IF(t:=FindToolType(oldtooltypes,'BBS_NAME'))
    FOR i:=0 TO nodeCount-1
      cmd:=cmds[i]
      AstrCopy(cmd.bbsName,t)      
    ENDFOR
  ENDIF
  
  IF(t:=FindToolType(oldtooltypes,'BBS_GEOGRAPHIC')) THEN StrCopy(mybbslocation,t)
  IF(t:=FindToolType(oldtooltypes,'BBS_LOCATION'))
    StrCopy(bbsPath,t)
    checkPathSlash(bbsPath)
    FOR i:=0 TO nodeCount-1
      cmd:=cmds[i]
      AstrCopy(cmd.bbsLoc,bbsPath)
    ENDFOR
  ENDIF

  IF(t:=FindToolType(oldtooltypes,'EXECUTE_ON_STARTUP_COMPLETE'))
    StrCopy(startupCompleteScript,t)
  ENDIF

  IF(t:=FindToolType(oldtooltypes,'SYSOP_NAME'))
    FOR i:=0 TO nodeCount-1
      cmd:=cmds[i]
      AstrCopy(cmd.sysopName,t)
    ENDFOR
  ENDIF

  IF(t:=FindToolType(oldtooltypes,'LONG_WHO'))
    FOR i:=0 TO nodeCount-1
      cmd:=cmds[i]
      cmd.acLvl[LVL_LONGWHO]:=1
    ENDFOR
  ENDIF

  IF(t:=FindToolType(oldtooltypes,'CREDIT_BY_KBYTES'))
    FOR i:=0 TO nodeCount-1
      sopt:=sopts[i]
      sopt.toggles[TOGGLES_CREDITBYKB]:=1
    ENDFOR
  ENDIF

  IF(t:=FindToolType(oldtooltypes,'NAMEBASE'))
    FOR i:=0 TO nodeCount-1
      sopt:=sopts[i]
      sopt.toggles[TOGGLES_NAMEBASE]:=1
    ENDFOR
  ENDIF

  IF(t:=FindToolType(oldtooltypes,'AREABASE'))
    FOR i:=0 TO nodeCount-1
      sopt:=sopts[i]
      sopt.toggles[TOGGLES_AREABASE]:=1
    ENDFOR
  ENDIF

  FOR i:=0 TO nodeCount-1
    cmd:=cmds[i]
    StringF(image,'NODE\d_SYSOP',i)
    IF(t:=FindToolType(oldtooltypes,image))
      AstrCopy(cmd.sysopName,t)
    ENDIF

    StringF(image,'NODE\d_NAME',i)
    IF(t:=FindToolType(oldtooltypes,image))
      AstrCopy(cmd.bbsName,t)
    ENDIF

    StringF(image,'NODE\d_LOCATION',i)
    IF(t:=FindToolType(oldtooltypes,image))
      AstrCopy(cmd.bbsLoc,t)
    ENDIF
  ENDFOR
  ->else { myrequest('ERROR, missing BBS_LOCATION tooltype\nWait for all Disk Activity to Complete\nand reset') }
  
  IF(t:=FindToolType(oldtooltypes,'NEW_ACCOUNTS'))
    IF(MatchToolValue(t,'APPEND'))
      FOR i:=0 TO nodeCount-1
        sopt:=sopts[i]
        sopt.toggles[TOGGLES_REUSEINACTIVE]:=0
      ENDFOR
    ENDIF
  ENDIF

  IF(t:=FindToolType(oldtooltypes,'LANGUAGE_BASE'))
    IF loadTranslators(t)
      minNode:=NEW minNode
      minNode.succ:=translators

      FOR i:=0 TO nodeCount-1
        sopt:=sopts[i]
        sopt.translation:=minNode
      ENDFOR 
    ENDIF
  ENDIF

  persistState:=TRUE
  IF(t:=FindToolType(oldtooltypes,'NO_SAVESTATE'))
    persistState:=FALSE
  ENDIF

  freeToolTypes(dobj,cfg)

  StringF(tempstr,'\sCONFCONFIG',cmd.bbsLoc)
  dobj,cfg:=getToolTypes(tempstr)
  IF(dobj)
    oldtooltypes:=dobj.tooltypes
    IF(t:=FindToolType(oldtooltypes,'NCONFS'))
      n:=Val(t)
      FOR i:=0 TO n-1
        StringF(tempstr,'LOCATION.\d',i+1)
        IF(t:=FindToolType(oldtooltypes,tempstr))
          StringF(tempstr,'\sDirCaches/enabled',t)
          IF FileLength(tempstr)>=0
            StringF(tempstr,'COPY "\sDirCaches/Conf#?Dir#?" ALL RAM:DirCaches >NIL:',t)
            Execute(tempstr,0,0)
          ENDIF
        ENDIF
      ENDFOR
    ENDIF
  ENDIF
  freeToolTypes(dobj,cfg)

  IF(doMultiCom)
    FOR i:=0 TO nodeCount-1
      sopt:=sopts[i]
      sopt.toggles[TOGGLES_MULTICOM]:=1
    ENDFOR
  ENDIF

  createCustomMenus(nodeCount)
  FOR i:=0 TO nodeCount-1
    getIconNodeInfo(i)
  ENDFOR
  getIconBBSInfo(nodeCount)
ENDPROC

PROC validate()
  DEF i
  DEF cmd:PTR TO commands
  FOR i:=0 TO MAX_NODES-1
    IF(cmds[i]<>NIL)
      cmd:=cmds[i]
      IF(cmd.acLvl[LVL_DEFAULT_CHAT_ON]) THEN tChat[i]:=1
    ENDIF
  ENDFOR
    
ENDPROC 1

PROC loadScreen()
  DEF fi
  DEF i
  DEF nodeCount=0

  fi:=Open('S:ACP.config',MODE_OLDFILE)
  IF(fi=NIL) THEN RETURN
  
  Read(fi,pref,SIZEOF screenPref)
  Close(fi)
  
  FOR i:=0 TO MAX_NODES-1
    IF(nodes[i]) THEN nodeCount++
  ENDFOR
  
  IF(pref.nodes<>nodeCount) THEN RETURN
  
  edgeX:=pref.left
  edgeY:=pref.top
  ->width:=pref.width
  ->height:=pref.height
 
  ->DIM[0]=Pref.Zoom[0];
  ->DIM[1]=Pref.Zoom[1];
  ->DIM[2]=Pref.Zoom[2];
  ->DIM[3]=Pref.Zoom[3];
ENDPROC

PROC screenSave()
  DEF fi
  DEF i
  DEF nodeCount=0

  pref.top:=eWin.topedge
  pref.left:=eWin.leftedge
  pref.height:=eWin.height
  pref.width:=eWin.width
  
  FOR i:=0 TO MAX_NODES-1
    IF(nodes[i]) THEN nodeCount++
  ENDFOR
  pref.nodes:=nodeCount
  ->Pref.Zoom[0]=DIM[0];
  ->Pref.Zoom[1]=DIM[1];
  ->Pref.Zoom[2]=DIM[2];
  ->Pref.Zoom[3]=DIM[3];
  fi:=Open('S:ACP.config',MODE_NEWFILE);
  Write(fi,pref,SIZEOF screenPref)
  Close(fi) 
ENDPROC

PROC do_appicon(myport: PTR TO mp)
  DEF temp[100]:STRING
  DEF cmd:PTR TO commands
  ->DEF i=0  ->static int i=0;
  ->DEF j=0  ->static int j=0;
  
  cmd:=cmds[0]
  StringF(temp,'\sStorage/Icons/Iconified',cmd.bbsLoc)
    
  IF(do_appiconi=FALSE)
    StringF(temp,'\sStorage/Icons/Iconified',cmd.bbsLoc)
    workbenchbase:=OpenLibrary('workbench.library', 37)
    IF((dobj:=GetDiskObject(temp)))=FALSE
      dobj:=GetDefDiskObject(WBDISK)
      do_appiconj:=1
    ENDIF
    dobj.type:=NIL
    dobj.currentx:=zim[0]
    dobj.currenty:=zim[1]
    
    dobj.gadget.flags:=GFLG_GADGIMAGE
    
    appicon:=AddAppIconA(0,0, '', myport, NIL, dobj, NIL)
     
    do_appiconi:=1
  ELSE
    do_appiconi:=0
    RemoveAppIcon(appicon)
    appicon:=NIL
    FreeDiskObject(dobj)
    CloseLibrary(workbenchbase)
  ENDIF
ENDPROC

PROC startProcess(s:PTR TO CHAR,stack)
  DEF err
  
  tags[7]:=stack
  
  err:=SystemTagList(s,tags)
  IF(err=-1)
    RETURN 0
  ELSE
    RETURN 1
  ENDIF
ENDPROC

PROC selectAndRunConfig(outpath:PTR TO CHAR,initialFolder:PTR TO CHAR,initialFile:PTR TO CHAR)
  DEF configFile[255]:STRING
  DEF fr:PTR TO filerequester

  aslbase:=OpenLibrary('asl.library',37)
  iconbase:=OpenLibrary('icon.library',33)

  fr:=AllocAslRequest(ASL_FILEREQUEST,
                       [ASL_HAIL,       'Select /X config file',
                        ->ASL_WINDOW,window,
                        ASL_PATTERN,'#?.json',
                        ASL_FUNCFLAGS, FILF_PATGAD,
                        ASLFR_INITIALDRAWER, initialFolder,
                        ASLFR_INITIALFILE, initialFile,
                        NIL])

  IF AslRequest(fr, NIL)=FALSE
    FreeAslRequest(fr)
    myrequest('No file was selected.')
    RETURN
  ENDIF
  AstrCopy(configFile,fr.drawer,255)
  AddPart(configFile,fr.file,255)
  FreeAslRequest(fr)
  runConfig(configFile,outpath)
ENDPROC

PROC runConfig(infile:PTR TO CHAR,outpath:PTR TO CHAR) HANDLE
  DEF r
  DEF p:jsmn_parser
  DEF tok:PTR TO jsmntok_t
  DEF tokcount
  DEF fh
  DEF fib:PTR TO fileinfoblock
  DEF filesize,buf

  iconbase:=OpenLibrary('icon.library',33)

  /* Prepare parser */
  jsmn_init(p)
  
  fh:=Open(infile,MODE_OLDFILE)
  IF fh=0
    myrequest('Could not open json file.')
    RETURN
  ENDIF

  IF ((fib:=(AllocDosObject(DOS_FIB,NIL)))=NIL)
    myrequest('Could not allocate dos object.')
    RETURN 4
  ENDIF
  
  IF ExamineFH(fh,fib)=NIL
    myrequest('Could not examine json file.')
    FreeDosObject(DOS_FIB,fib)
    RETURN 5
  ENDIF

  filesize:=fib.size
  FreeDosObject(DOS_FIB,fib)

  buf:=New(filesize)
  IF (buf = NIL)
    myrequest('Could not allocate enough memory to read json file.')
    RETURN 6
  ENDIF
  
  /* Read json into memory */
  r:=Read(fh,buf, filesize)
  Close(fh)
  IF (r <> filesize)
    myrequest('Error reading json config file.')
    RETURN 1
  ENDIF

  tokcount:=jsmn_parse(p, buf, filesize, 0, 0)

  tok:=New(SIZEOF jsmntok_t * tokcount)
  IF (tok = NIL)
    myrequest('Could not allocate enough memory to parse json file.')
    RETURN 7
  ENDIF
  
  jsmn_init(p)
  r:=jsmn_parse(p, buf, filesize, tok, tokcount)
  IF (r>=0)
    createdata(outpath, buf, tok, p.toknext,TRUE)
  ELSE
    SELECT r
      CASE JSMN_ERROR_NOMEM
        myrequest('Error Parsing json file - not enough memory to proceed.')
      CASE JSMN_ERROR_INVAL
        myrequest('Error Parsing json file - invalid data found.')
      CASE JSMN_ERROR_PART
        myrequest('Error Parsing json file - incomplete data found.')
    ENDSELECT
  ENDIF
EXCEPT DO
  IF iconbase THEN CloseLibrary(iconbase)
ENDPROC

PROC processCommodityMessages()
  DEF msg, msgid, msgtype

  WHILE msg:=GetMsg(broker_mp)
    -> Extract any necessary information from the CxMessage and return it
    msgid:=CxMsgID(msg)
    msgtype:=CxMsgType(msg)
    ReplyMsg(msg)

    SELECT msgtype
    CASE CXM_IEVENT
      -> Shouldn't get any of these in this example
    CASE CXM_COMMAND
      -> Commodities has sent a command
      SELECT msgid
      CASE CXCMD_APPEAR
        IF do_appiconi  THEN ZipWindow(eWin)
      CASE CXCMD_DISAPPEAR
        IF do_appiconi=0 THEN ZipWindow(eWin)
      CASE CXCMD_DISABLE
        -> The user clicked CX Exchange disable gadget, better disable
        ActivateCxObj(broker, FALSE)
      CASE CXCMD_ENABLE
        -> User clicked enable gadget
        ActivateCxObj(broker, TRUE)
      CASE CXCMD_KILL
        -> User clicked kill gadget, better quit
        attemptShutdown()
        
      ENDSELECT
    ENDSELECT
  ENDWHILE
ENDPROC

PROC attemptShutdown()
  DEF i
 
  IF(activeNodeCount=0)
    notDone:=0
  ELSE
    FOR i:=0 TO MAX_NODES-1
      IF(StrLen(startNode[i])>0)
        IF((users[i].actionVal=ENV_AWAITCONNECT) AND (down[i])=FALSE)
          control:=SV_NODEOFFHOOK
          down[i]:=TRUE
          doControl(i)
        ENDIF                     
      ELSE
        IF(users[i].actionVal<>ENV_SHUTDOWN) THEN notDone:=1 
      ENDIF
    ENDFOR
  ENDIF
ENDPROC

PROC loadState()
  DEF stateFile[255]:STRING
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF fh,i,j
  
  IF persistState=FALSE THEN RETURN

  StringF(stateFile,'\sacp.dat',bbsPath)
  fh:=Open(stateFile,MODE_OLDFILE)
  IF fh<>0
    FOR i:=0 TO MAX_NODES-1
      FOR j:=0 TO 4
        ReadStr(fh,tempStr)
        ReadStr(fh,tempStr2)
        IF StrLen(tempStr)>0 THEN regLastUser(tempStr,tempStr2,i)
        ReadStr(fh,tempStr)
        ReadStr(fh,tempStr2)
        IF StrLen(tempStr)>0 THEN regLastUploads(tempStr,tempStr2,i)
        ReadStr(fh,tempStr)
        ReadStr(fh,tempStr2)
        IF StrLen(tempStr)>0 THEN regLastDownloads(tempStr,tempStr2,i)
      ENDFOR
    ENDFOR
    ReadStr(fh,tempStr)
    IF StrCmp(tempStr,'##')
      END lastUsers
      END lastUploads
      END lastDownloads
      lastUsers:=NEW lastUsers.init()
      lastUploads:=NEW lastUploads.init()
      lastDownloads:=NEW lastDownloads.init()
      
      FOR j:=0 TO 4
        ReadStr(fh,tempStr)
        ReadStr(fh,tempStr2)
        IF StrLen(tempStr)>0 THEN lastUsers.add(tempStr,tempStr2)

        ReadStr(fh,tempStr)
        ReadStr(fh,tempStr2)
        IF StrLen(tempStr)>0 THEN lastUploads.add(tempStr,tempStr2)

        ReadStr(fh,tempStr)
        ReadStr(fh,tempStr2)
        IF StrLen(tempStr)>0 THEN lastDownloads.add(tempStr,tempStr2)
      ENDFOR
    ENDIF

    Close(fh)
  ENDIF
  showLastUser(eWin)
ENDPROC

PROC saveState()
  DEF stateFile[255]:STRING
  DEF tempStr[255]:STRING
  DEF fh,i,j
  DEF list:PTR TO itemsList
  
  IF persistState=FALSE THEN RETURN
  
  StringF(stateFile,'\sacp.dat',bbsPath)
  fh:=Open(stateFile,MODE_NEWFILE)
  IF fh<>0
    FOR i:=0 TO MAX_NODES-1
      FOR j:=0 TO 4
        list:=ndUser[i]
        StringF(tempStr,'\s\n',list.getItem(j))
        Write(fh,tempStr,StrLen(tempStr))
        StringF(tempStr,'\s\n',list.getItemDate(j))
        Write(fh,tempStr,StrLen(tempStr))
        list:=ndUploads[i]
        StringF(tempStr,'\s\n',list.getItem(j))
        Write(fh,tempStr,StrLen(tempStr))
        StringF(tempStr,'\s\n',list.getItemDate(j))
        Write(fh,tempStr,StrLen(tempStr))
        list:=ndDownloads[i]
        StringF(tempStr,'\s\n',list.getItem(j))
        Write(fh,tempStr,StrLen(tempStr))
        StringF(tempStr,'\s\n',list.getItemDate(j))
        Write(fh,tempStr,StrLen(tempStr))
      ENDFOR
    ENDFOR

    StringF(tempStr,'##\n')
    Write(fh,tempStr,StrLen(tempStr))
    
    FOR j:=0 TO 4
      StringF(tempStr,'\s\n',lastUsers.getItem(j))
      Write(fh,tempStr,StrLen(tempStr))
      StringF(tempStr,'\s\n',lastUsers.getItemDate(j))
      Write(fh,tempStr,StrLen(tempStr))
      
      StringF(tempStr,'\s\n',lastUploads.getItem(j))
      Write(fh,tempStr,StrLen(tempStr))
      StringF(tempStr,'\s\n',lastUploads.getItemDate(j))
      Write(fh,tempStr,StrLen(tempStr))

      StringF(tempStr,'\s\n',lastDownloads.getItem(j))
      Write(fh,tempStr,StrLen(tempStr))
      StringF(tempStr,'\s\n',lastDownloads.getItemDate(j))
      Write(fh,tempStr,StrLen(tempStr))
    ENDFOR
    Close(fh)
  ENDIF
ENDPROC

PROC loadConnectionList(connList:PTR TO stdlist)
  DEF connFile[255]:STRING
  DEF tempStr[255]:STRING
  DEF connItem:PTR TO connectionItem
  DEF fh
  StringF(connFile,'\sacpConnections.dat',bbsPath)
  fh:=Open(connFile,MODE_OLDFILE)
  IF fh<>0
    WHILE (ReadStr(fh,tempStr)<>-1) OR (EstrLen(tempStr)>0)
      connItem:=NEW connItem
      connItem.ipAddr:=Val(tempStr)
      ReadStr(fh,tempStr)
      connItem.connectionTime:=Val(tempStr)
      ReadStr(fh,tempStr)
      connItem.blocked:=Val(tempStr)
      ReadStr(fh,tempStr)
      connItem.blockExpiry:=Val(tempStr)
      connList.add(connItem)
    ENDWHILE

    Close(fh)
  ENDIF
ENDPROC

PROC saveConnectionList(connList:PTR TO stdlist)
  DEF connFile[255]:STRING
  DEF tempStr[255]:STRING
  DEF connItem:PTR TO connectionItem
  DEF i,fh
  StringF(connFile,'\sacpConnections.dat',bbsPath)
  fh:=Open(connFile,MODE_NEWFILE)
  IF fh<>0
    FOR i:=0 TO connList.count()-1
      connItem:=connList.item(i)
     
      StringF(tempStr,'$\h\n',connItem.ipAddr)
      Write(fh,tempStr,StrLen(tempStr))
      StringF(tempStr,'\d\n',connItem.connectionTime)
      Write(fh,tempStr,StrLen(tempStr))
      StringF(tempStr,'\d\n',connItem.blocked)
      Write(fh,tempStr,StrLen(tempStr))
      StringF(tempStr,'\d\n',connItem.blockExpiry)
      Write(fh,tempStr,StrLen(tempStr))
    ENDFOR
    Close(fh)
  ENDIF
ENDPROC


PROC telnetSend(socket,msg,len=-1)
  DEF r
  IF len=-1 THEN len:=StrLen(msg)
  r:=Send(socket,msg,len,0)
  IF r<>len THEN RETURN FALSE
ENDPROC TRUE

PROC clearFDS()
  DEF i
  FOR i:=0 TO 31 DO fds[i]:=0
ENDPROC

PROC setFDS(socketVal)
  DEF n
  
  n:=socketVal/32
  IF (n<0) OR (n>=32) THEN Raise(ERR_FDS_RANGE)

  fds[n]:=fds[n] OR (Shl(1,socketVal AND 31))
ENDPROC

PROC updateVersion(expVer:PTR TO CHAR,expDate:PTR TO CHAR)
  DEF v,p
  DEF y,m,d
  DEF tmp[4]:STRING
  
  v:=getBuild()
  p:=InStr(v,' ')
  IF p>=0
    StrCopy(expVer,v,p)
    v:=v+p+1
    StrCopy(tmp,v,4)
    y:=Val(tmp)
    StrCopy(tmp,v+4,2)
    m:=Val(tmp)
    StrCopy(tmp,v+6,2)
    d:=Val(tmp)
    StringF(expDate,'\d[2]-\s[3]-\d[4]',d,'JanFebMarAprMayJunJulAugSepOctNovDec'+((m-1)*3),y)
  ELSE
    StrCopy(expVer,v)
    StrCopy(expDate,'')
  ENDIF
ENDPROC

PROC updateDosConnectionList(connectionList:PTR TO stdlist,t)
  DEF i
  DEF connItem:PTR TO connectionItem
  DEF res=FALSE
  
  FOR i:=connectionList.count()-1 TO 0 STEP -1
    connItem:=connectionList.item(i)
    IF (connItem.blocked=FALSE)
      IF ((connItem.connectionTime>t) OR (connItem.connectionTime<(t-dosCheckTime)))
        END connItem
        connectionList.remove(i)
        res:=TRUE
      ENDIF
    ELSE
      IF (connItem.blockExpiry<>0) AND (connItem.blockExpiry<t)
        END connItem
        connectionList.remove(i)
        res:=TRUE
      ENDIF
    ENDIF
  ENDFOR
ENDPROC res

PROC applyDosBan(connectionList:PTR TO stdlist,ipAddr:PTR TO sockaddr_in,t)
  DEF i
  DEF connItem:PTR TO connectionItem
  
  FOR i:=connectionList.count()-1 TO 0 STEP -1
    connItem:=connectionList.item(i)
    END connItem
    connectionList.remove(i)
  ENDFOR
  connItem:=NEW connItem
  connItem.ipAddr:=ipAddr.sin_addr
  connItem.connectionTime:=t
  connItem.blocked:=TRUE
  IF dosBanTime<0
    connItem.blockExpiry:=0     ->permanent ban
  ELSE
    connItem.blockExpiry:=t+Mul(dosBanTime,60)  -> apply denial of service ban period
  ENDIF
  connectionList.add(connItem)
ENDPROC

PROC addDosConnect(connectionList:PTR TO stdlist,ipAddr:PTR TO sockaddr_in,t)
  DEF connItem:PTR TO connectionItem
  connItem:=NEW connItem
  connItem.ipAddr:=ipAddr.sin_addr
  connItem.connectionTime:=t
  connItem.blocked:=FALSE
  connItem.blockExpiry:=0
  connectionList.add(connItem)
ENDPROC

PROC acceptFTP(ftpServerSocket,connectionList:PTR TO stdlist)
  DEF tempstr[255]:STRING
  DEF ftpSocket=-1
  DEF ftpSocket2=-1
  DEF i,f
  DEF peeraddr: sockaddr_in
  DEF n,t
  DEF connItem: PTR TO connectionItem
  DEF saveConn=FALSE
  DEF num

  ftpSocket:=Accept(ftpServerSocket,NIL,NIL)
  IF ftpSocket>=0

    saveConn:=FALSE
    n:=SIZEOF sockaddr_in
    GetPeerName(ftpSocket,peeraddr,{n})

    IF (dosCheckTime>0) AND (dosCheckTrigger>0)
      t:=getSystemTime()
      IF updateDosConnectionList(connectionList,t) THEN saveConn:=TRUE
        
      n:=0
      FOR i:=0 TO connectionList.count()-1
        connItem:=connectionList.item(i)
        IF (connItem.ipAddr=peeraddr.sin_addr)
          IF connItem.blocked
            IF (connItem.blockExpiry=0)
              telnetSend(ftpSocket,'530 Your ip address is permanently blocked\b\n')
            ELSE
              num:=Div(connItem.blockExpiry-t,60)
              StringF(tempstr,'530 Your ip address has been blocked for another \d minutes\b\n',num)
              telnetSend(ftpSocket,tempstr)
            ENDIF
            CloseSocket(ftpSocket)
            ftpSocket:=-1
          ELSE
            n++
          ENDIF
        ENDIF
      ENDFOR
      
      IF (ftpSocket<>-1) AND (n>=dosCheckTrigger)
        applyDosBan(connectionList,peeraddr,t)
        saveConn:=TRUE
        IF dosBanTime<0
          telnetSend(ftpSocket,'530 Your ip address has been blocked permanently\b\n')
        ELSE
          StringF(tempstr,'530 Your ip address has been blocked for \d minutes\b\n',dosBanTime)
          telnetSend(ftpSocket,tempstr)
        ENDIF
        CloseSocket(ftpSocket)
        ftpSocket:=-1
      ENDIF

      IF (ftpSocket<>-1)
        addDosConnect(connectionList,peeraddr,t)
        saveConn:=TRUE
      ENDIF
    ENDIF

    IF (ftpSocket<>-1)
      f:=FALSE
   
      ->IF telnetSend(telnetSocket,'\b\n/X Native Telnet:  Searching for free node...\b\n')=FALSE THEN f:=TRUE

      IF f=FALSE
        i:=0
        REPEAT
          IF(users[i].actionVal=ENV_AWAITCONNECT) AND (ftpNode[i]=1)
            IF(doMultiCom)
              ObtainSemaphore(semiNodes)
              IF semiNodes.myNode[i].offHook=FALSE
                ftpSocket2:=semiNodes.myNode[i].netSocket
                
                ->set to -2 to prevent the node from being used between here and when the incoming_telnet message arrives
                IF ftpSocket2=-1 THEN semiNodes.myNode[i].netSocket:=-2
              ENDIF
              ReleaseSemaphore(semiNodes)
            ELSE
              ftpSocket2:=-1
            ENDIF

            IF ftpSocket2=-1
              StringF(tempstr,'220 Successful connection to node \d\b\n',i)
              telnetSend(ftpSocket,tempstr)

              IoctlSocket(ftpSocket,FIONBIO,[1])
              ftpSocket2:=ReleaseSocket(ftpSocket,UNIQUE_ID)
              callNode(i,INCOMING_FTP,ftpSocket2)
              ftpSocket:=-1
              i:=-1
            ELSE
              i++
            ENDIF
          ELSE
            i++
          ENDIF
        UNTIL (i=MAX_NODES) OR (i=-1)
        IF i<>-1
          telnetSend(ftpSocket,'530 No nodes available to handle your connection \b\n\b\n')                   
        ENDIF
      ENDIF
        
      IF ftpSocket<>-1
        CloseSocket(ftpSocket)
        ftpSocket:=-1
      ENDIF
    ENDIF
    IF saveConn THEN saveConnectionList(connectionList)
  ENDIF
ENDPROC

PROC acceptTelnet(telnetServerSocket,connectionList:PTR TO stdlist)
  DEF tempstr[255]:STRING
  DEF telnetSocket=-1
  DEF telnetSocket2=-1
  DEF i,f
  DEF peeraddr: sockaddr_in
  DEF n,t
  DEF connItem: PTR TO connectionItem
  DEF saveConn=FALSE
  DEF num

  telnetSocket:=Accept(telnetServerSocket,NIL,NIL)
  IF telnetSocket>=0

    saveConn:=FALSE
    n:=SIZEOF sockaddr_in
    GetPeerName(telnetSocket,peeraddr,{n})

    IF (dosCheckTime>0) AND (dosCheckTrigger>0)
      t:=getSystemTime()
      IF updateDosConnectionList(connectionList,t) THEN saveConn:=TRUE
              
      n:=0
      FOR i:=0 TO connectionList.count()-1
        connItem:=connectionList.item(i)
        IF (connItem.ipAddr=peeraddr.sin_addr)
          IF connItem.blocked
            IF (connItem.blockExpiry=0)
              telnetSend(telnetSocket,'\b\n/X Native Telnet:  Your ip address is permanently blocked\b\n')
            ELSE
              num:=Div(connItem.blockExpiry-t,60)
              StringF(tempstr,'\b\n/X Native Telnet:  Your ip address has been blocked for another \d minutes\b\n',num)
              telnetSend(telnetSocket,tempstr)
            ENDIF
            CloseSocket(telnetSocket)
            telnetSocket:=-1
          ELSE
            n++
          ENDIF
        ENDIF
      ENDFOR
      
      IF (telnetSocket<>-1) AND (n>=dosCheckTrigger)

        applyDosBan(connectionList,peeraddr,t)
        saveConn:=TRUE
        
        IF dosBanTime<0
          telnetSend(telnetSocket,'\b\n/X Native Telnet:  Your ip address has been blocked permanently\b\n')
        ELSE
          StringF(tempstr,'\b\n/X Native Telnet:  Your ip address has been blocked for \d minutes\b\n',dosBanTime)
          telnetSend(telnetSocket,tempstr)
        ENDIF
        CloseSocket(telnetSocket)
        telnetSocket:=-1
      ENDIF

      IF (telnetSocket<>-1)
        addDosConnect(connectionList,peeraddr,t)
        saveConn:=TRUE
      ENDIF
    ENDIF

    IF (telnetSocket<>-1)
      f:=FALSE

      ->WILL=251, WONT=252, DO=253, DONT=254
    
      IF telnetSend(telnetSocket,'\b\n/X Native Telnet:  Searching for free node...\b\n')=FALSE THEN f:=TRUE

      IF f=FALSE
        i:=0
        REPEAT
          IF(users[i].actionVal=ENV_AWAITCONNECT) AND (telnetNode[i]=1)
            IF(doMultiCom)
              ObtainSemaphore(semiNodes)
              IF semiNodes.myNode[i].offHook=FALSE
                telnetSocket2:=semiNodes.myNode[i].netSocket
                
                ->set to -2 to prevent the node from being used between here and when the incoming_telnet message arrives
                IF telnetSocket2=-1 THEN semiNodes.myNode[i].netSocket:=-2
              ENDIF
              ReleaseSemaphore(semiNodes)
            ELSE
              telnetSocket2:=-1
            ENDIF

            IF telnetSocket2=-1
              StringF(tempstr,'/X Native Telnet:  Successful connection to node \d\b\n\b\n',i)
              telnetSend(telnetSocket,tempstr)

              StringF(tempstr,'\c\c\c',255,253,0)    ->DO BINARY
              telnetSend(telnetSocket,tempstr,3)
              StringF(tempstr,'\c\c\c',255,254,31)    ->DONT NAWS
              telnetSend(telnetSocket,tempstr,3)
              StringF(tempstr,'\c\c\c',255,252,5)     ->WONT STATUS
              telnetSend(telnetSocket,tempstr,3)
              StringF(tempstr,'\c\c\c',255,254,32)    ->DONT TERMSPEED
              telnetSend(telnetSocket,tempstr,3)
              StringF(tempstr,'\c\c\c',255,254,34)    ->DONT LINEMODE
              telnetSend(telnetSocket,tempstr,3)
              StringF(tempstr,'\c\c\c',255,251,3)    ->WILL SGA
              telnetSend(telnetSocket,tempstr,3)
              StringF(tempstr,'\c\c\c',255,251,1)    ->WILL ECHO
              telnetSend(telnetSocket,tempstr,3)


              IoctlSocket(telnetSocket,FIONBIO,[1])
              telnetSocket2:=ReleaseSocket(telnetSocket,UNIQUE_ID)
              callNode(i,INCOMING_TELNET,telnetSocket2)
              telnetSocket:=-1
              i:=-1
            ELSE
              i++
            ENDIF
          ELSE
            i++
          ENDIF
        UNTIL (i=MAX_NODES) OR (i=-1)
        IF i<>-1
          telnetSend(telnetSocket,'/X Native Telnet:  No nodes available to handle your connection \b\n\b\n')                   
        ENDIF
      ENDIF
        
      IF telnetSocket<>-1
        CloseSocket(telnetSocket)
        telnetSocket:=-1
      ENDIF
    ENDIF
    IF saveConn THEN saveConnectionList(connectionList)
  ENDIF
ENDPROC

PROC main() HANDLE

  DEF iconStartName[200]:STRING
  DEF alzMenu:PTR TO menuitem
  DEF alzMenu2:PTR TO menuitem

  DEF oldDirLock=NIL
  DEF tempstr[255]:STRING
  DEF argmsg: PTR TO wbstartup
  DEF wb_arg:PTR TO wbarg
  DEF appmsg:PTR TO iostd
  DEF num
  DEF ktr
  DEF newscreen=0
  DEF tempscreen:PTR TO screen
  DEF screenModeID
  DEF im: PTR TO intuimessage
  DEF version[200]:STRING
  DEF windowSig,myappsig
  DEF i,class
  DEF newlock=NIL
  DEF telnetServerSocket=-1
  DEF ftpServerSocket=-1
  DEF b:PTR TO button
  DEF connectionList: PTR TO stdlist
  DEF connItem: PTR TO connectionItem

  DEF sopt:PTR TO startOption

  fds:=NEW [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]:LONG
 
  KickVersion(37)  -> E-Note: requires V37

  updateVersion(myVerStr,myBuildStr)

  FOR i:=0 TO MAX_NODES-1
    ndUser[i]:=NIL
    ndUploads[i]:=NIL
    ndDownloads[i]:=NIL
  ENDFOR

  connectionList:=NEW connectionList.stdlist(100)

  dim:=[1,1,1,1]:INT  /*** Dimensions of ZIP window default ***/
  zim:=[10,100]:INT

  tags:=[SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,TRUE,NP_STACKSIZE,0,NP_PRIORITY,0,TAG_END,0]

  StrCopy(portName,'AE.Master')
  StrCopy(multiName,'AEMulti')
  
  colourSpecs:= [
    0,0,0,0,
    1,$f,0,0,
    2,0,$f,0,
    3,$f,$f,0,
    4,0,0,$f,
    5,$f,0,$f,
    6,0,$f,$f,
    7,$f,$f,$f,
    -1,0,0,0]:INT

  amigaSpecs:= [
    0,0,0,0,
    1,$f,$f,$f,
    2,0,$f,0,
    3,$f,$f,0,
    4,0,0,$f,
    5,$f,0,$f,
    6,0,$f,$f,
    7,$f,0,0,
    -1,0,0,0]:INT

  StrCopy(mybbslocation,'')
  StrCopy(publicName,'')
  colours:=amigaSpecs
  pens[DETAILPEN]:=3
  pens[BLOCKPEN]:=4
  pens[TEXTPEN]:=6 
  pens[SHINEPEN]:=1
  pens[SHADOWPEN]:=0
  pens[FILLPEN]:=4
  pens[FILLTEXTPEN]:=3
  pens[BACKGROUNDPEN]:=4
  pens[HIGHLIGHTTEXTPEN]:=7

  gadtoolsbase:=OpenLibrary('gadtools.library',0)
  iconbase:=OpenLibrary('icon.library',33)
 
  argmsg:=wbmessage
  IF(argmsg)
    wb_arg:=argmsg.arglist

    FOR ktr:=0 TO argmsg.numargs      
      IF(wb_arg.lock)
        oldDirLock:=CurrentDir(wb_arg.lock)
        StrCopy(iconStartName,wb_arg.name)
      ENDIF
      wb_arg++
    ENDFOR
  ELSE
    IF StrLen(arg)>0
      StrCopy(iconStartName,arg)
      RightStr(tempstr,iconStartName,3)
      UpperStr(tempstr)
      IF StrCmp(tempstr,'acp')=FALSE THEN StrAdd(iconStartName,'acp')
      
      StrCopy(tempstr,iconStartName,PathPart(iconStartName)-iconStartName)
      newlock:=Lock(tempstr,ACCESS_READ)
      IF newlock<>NIL THEN oldDirLock:=CurrentDir(newlock)
    ELSE
      StrCopy(iconStartName,'PROGDIR:acp')
      newlock:=Lock('PROGDIR:',ACCESS_READ)
      IF newlock<>NIL THEN oldDirLock:=CurrentDir(newlock)
    ENDIF
  ENDIF
 
  FOR i:=0 TO 14
    setOriText[i]:=String(100)
  ENDFOR

  FOR i:=0 TO MAX_NODES-1
    startNode[i]:=String(255)
    chat[i]:=1
    down[i]:=FALSE
    activeNodes[i]:=FALSE
    tChat[i]:=0
    cmds[i]:=NIL
    sopts[i]:=NIL
    nodes[i]:=0
    quietNode[i]:=0
    telnetNode[i]:=0
    ftpNode[i]:=0
  ENDFOR
 
  IF (diskfontbase:=OpenLibrary('diskfont.library', 37))=NIL THEN Raise(ERR_NO_DISKFONT)

  acpData:=NEW acpData

  IF(FindPort('AE.Master'))
    myrequest('ACP is already running.')
    Raise(ERR_ALREADY_RUNNING)
  ENDIF

  acpData.masterSemi:=0;
  FOR i:=0 TO 4
    acpData.lastUsers[i]:=0
    acpData.lastUsersDate[i]:=0
    acpData.lastUploads[i]:=0
    acpData.lastUploadsDate[i]:=0
    acpData.lastDownloads[i]:=0
    acpData.lastDownloadsDate[i]:=0
  ENDFOR

  
  openMaster()
  clearUsers()
  initCycles()

  ->doMultiCom:=0

  StrCopy(fontName,'topaz.font')

  readStartUp(iconStartName)
  IF acpError THEN Raise(ERR_STARTUP)

  loadConnectionList(connectionList)

  IF commodityEnabled  
    cxbase:=OpenLibrary('commodities.library', 37)
    broker_mp:=CreateMsgPort()
    IF broker_mp
      broker:=CxBroker(
               [NB_VERSION,   -> Version of the NewBroker object
                0,  -> E-Note: pad byte
               'ACP',  -> Name: commodities uses for this commodity
               'ACP',      -> Title of commodity that appears in CXExchange
               'ACP Broker for Ami-Express',  -> Description
                0,  -> Unique: tells CX not to launch a commodity with the same name
                COF_SHOW_HIDE,  -> Flags: tells CX if this commodity has a window
                0,  -> Pri: this commodity's priority
                0,  -> E-Note: pad byte
                broker_mp, -> Port: mp CX talks to
                0   -> ReservedChannel: reserved for later use
               ]:newbroker, NIL)
        cxsigflag:=Shl(1, broker_mp.sigbit)
      
        -> After it's set up correctly, the broker has to be activated
      ActivateCxObj(broker, TRUE)

    ENDIF
  ENDIF


  defaultfontattr.name:=fontName
  defaultfontattr.ysize:=8

  fontHandle:=OpenFont(defaultfontattr)
  IF fontHandle=NIL THEN fontHandle:=OpenDiskFont(defaultfontattr)

  IF(validate()=FALSE) THEN Raise(ERR_VALIDATE)

  IF (telnetPort<>-1) OR (ftpPort<>-1)
    waitSocketLib()
    IF socketbase=NIL
      myrequest('Timeout error waiting for internet connection')
    ELSE
      IF (telnetPort<>-1) THEN telnetServerSocket:=openListenSocket(telnetPort)
      IF (ftpPort<>-1) THEN ftpServerSocket:=openListenSocket(ftpPort)
    ENDIF
  ENDIF

  theight++
  edgeX:=WLEF
  edgeY:=WTOP
  width:=WWID
  height:=WHEI+(theight*11)
  loadScreen()

  msg:=AllocMem(SIZEOF acpMessage,MEMF_PUBLIC OR MEMF_CLEAR)
  IF(EstrLen(publicName)=0)
    scr:=LockPubScreen(NIL)
  ELSE
    scr:=LockPubScreen(publicName)
    IF(scr=NIL) 
      tempscreen:=LockPubScreen(NIL)
      screenModeID:=GetVPModeID(tempscreen.viewport)
      newscreen:=1 
      IF(colours<>amigaSpecs)
        pens[SHINEPEN]:=7
      ENDIF
      scr:=OpenScreenTagList(NIL,[SA_LEFT,0,SA_TOP,0,SA_WIDTH,tempscreen.width,SA_HEIGHT,tempscreen.height,SA_DEPTH,3,
                    SA_TITLE,publicName,SA_COLORS,colours,
                    SA_PENS,pens,SA_TYPE,PUBLICSCREEN,SA_PUBNAME,publicName,
                    SA_DISPLAYID,screenModeID,SA_OVERSCAN,OSCAN_TEXT,0])
      UnlockPubScreen(NIL,tempscreen)

    ENDIF
  ENDIF
  

  IF scr
    topOffset:=scr.wbortop+scr.font.ysize+1-11
    height:=height+topOffset+scr.wborbottom
    initNgAry()

    IF(zipOn)
      i:=dim[2]; dim[2]:=width; width:=i
      i:=dim[3]; dim[3]:=height; height:=i
      i:=dim[0]; dim[0]:=edgeX; edgeX:=i
      i:=dim[1]; dim[1]:=edgeY; edgeY:=i
      do_appicon(myappport)
    ENDIF
  
    IF(gadgets:=initGads(scr))

      eWinM:=CreateMenusA(eWinMenu,[GTMN_FRONTPEN,1,TAG_END])

      i:=0
      alzMenu2:=eWinM.firstitem  
      WHILE (i++<>4)
        alzMenu:=alzMenu2.subitem
        WHILE (alzMenu)
          alzMenu.flags:=alzMenu.flags OR HIGHNONE
          alzMenu:=alzMenu.nextitem                        
        ENDWHILE
        alzMenu2:=alzMenu2.nextitem
      ENDWHILE

      StringF(version,'AmiExpress Server \s, by ''Darren Coles''',myVerStr)
      LayoutMenusA(eWinM,visInfo,[TAG_END])
      
      eWin:=OpenWindowTagList(NIL,[
             WA_FLAGS,     WFLG_DRAGBAR OR 
                           WFLG_DEPTHGADGET OR
                           WFLG_CLOSEGADGET OR 
                           WFLG_NOCAREREFRESH OR 
                           WFLG_SMART_REFRESH OR 
                           WFLG_REPORTMOUSE,

             WA_IDCMP,     LISTVIEWIDCMP OR
                           IDCMP_NEWSIZE OR
                           IDCMP_MENUPICK OR 
                           IDCMP_VANILLAKEY OR
                           IDCMP_RAWKEY OR
                           IDCMP_GADGETUP OR
                           IDCMP_CLOSEWINDOW ,
             WA_LEFT,      edgeX,
             WA_TOP,       edgeY,
             WA_DETAILPEN, IF newscreen=FALSE THEN 1 ELSE 4,
             WA_BLOCKPEN,  IF newscreen=FALSE THEN 2 ELSE pens[HIGHLIGHTTEXTPEN],
             WA_WIDTH,     width,
             WA_HEIGHT,    height,
             WA_TITLE,     version,
             WA_MINWIDTH,  1,
             WA_MINHEIGHT, 1,
             WA_MAXWIDTH,  -1,
             WA_MAXHEIGHT, -1,
             WA_ZOOM, dim,
             WA_AUTOADJUST, 1,
             WA_PUBSCREEN, IF EstrLen(publicName)=0 THEN NIL ELSE scr,
             WA_PUBSCREENFALLBACK, 1,
             WA_GADGETS,   gadgets,
             TAG_END] )
      
      IF fontHandle<>NIL THEN SetFont(eWin.rport,fontHandle)

      SetMenuStrip(eWin,eWinM)
      setTheGads()
      IF(EstrLen(publicName)=0)
         UnlockPubScreen(NIL,scr)        
      ELSE
        PubScreenStatus(scr,0)
      ENDIF

      IF (eWin)
        drawborders()
        notDone:=1
    
        IF eWin THEN Gt_RefreshWindow(eWin, NIL)
        IF eWin
          windowSig:=(Shl(1,eWin.userport.sigbit))
        ELSE
          windowSig:=0
        ENDIF
        masterSig:=(Shl(1,mp.sigbit))
        myappsig:=(Shl(1,myappport.sigbit))
        IF(eWin AND startUp)
          FOR i:=0 TO MAX_NODES-1
            IF(StrLen(startNode[i])>0)
              drawChatBlock(i)
              sopt:=sopts[i]
              IF sopt THEN sopt.acpWindow:=eWin
              IF(nodeIdle[i])=FALSE
                IF(startProcess(startNode[i],bbsStack))
                  activeNodeCount++
                  activeNodes[i]:=TRUE
                ENDIF
              ENDIF
            ENDIF
          ENDFOR
        ENDIF

        loadState()
        checkStartingScript()

        acpData.masterSemi:=semiNodes;
        FOR i:=0 TO 4
          acpData.lastUsers[i]:=lastUsers.getItem(i)
          acpData.lastUsersDate[i]:=lastUsers.getItemDate(i)
          acpData.lastUploads[i]:=lastUploads.getItem(i)
          acpData.lastUploadsDate[i]:=lastUploads.getItemDate(i)
          acpData.lastDownloads[i]:=lastDownloads.getItem(i)
          acpData.lastDownloadsDate[i]:=lastDownloads.getItemDate(i)
        ENDFOR

        WHILE (notDone)
          IF (telnetServerSocket=-1) AND (ftpServerSocket=-1)
            signals:=Wait(masterSig OR windowSig OR myappsig OR cxsigflag)
          ELSE
            REPEAT
              clearFDS()
              IF telnetServerSocket<>-1 THEN setFDS(telnetServerSocket)
              IF ftpServerSocket<>-1 THEN setFDS(ftpServerSocket)
              
              
              signals:=masterSig OR windowSig OR myappsig OR cxsigflag
              WaitSelect(Max(telnetServerSocket,ftpServerSocket)+1,fds,NIL,NIL,NIL,{signals})
              IF telnetServerSocket>=0 THEN acceptTelnet(telnetServerSocket,connectionList)
              IF ftpServerSocket>=0 THEN acceptFTP(ftpServerSocket,connectionList)
            UNTIL signals
          ENDIF
          
          IF(signals AND cxsigflag) THEN processCommodityMessages()
          
          IF(signals AND windowSig)
            WHILE (im:=Gt_GetIMsg(eWin.userport))
              class:=im.class
              SELECT class
                CASE IDCMP_CLOSEWINDOW
                  attemptShutdown()
                CASE IDCMP_NEWSIZE
                  IF(shorten=FALSE) THEN do_appicon(myappport)
                  shorten:=0
                  Gt_BeginRefresh(eWin)
                  Gt_EndRefresh(eWin, TRUE)
                  drawborders()
                  SELECT topOption
                    CASE LAST_CALLERS
                      showLastUser(eWin)
                    CASE LAST_UPLOADS
                      showLastUploads(eWin)
                    CASE LAST_DOWNLOADS
                      showLastDownloads(eWin)
                  ENDSELECT
                  FOR i:=0 TO MAX_NODES-1
                    IF(StrLen(startNode[i])>0)
                      drawChatBlock(i)
                    ENDIF
                  ENDFOR
                  showNodes()
                CASE GADGETDOWN
                  handleEditGadget(im,0)
                CASE GADGETUP
                  handleEditGadget(im,0)
                CASE MENUPICK
                  ->quit menu item
                  IF(menunum(im.code)=0) AND (itemnum(im.code)=5) THEN attemptShutdown()
                  
                  IF(menunum(im.code)=1)
                    i:=button
                    button:=0
                    handleEditGadget(NIL,GAD_SYSOPLOGIN+itemnum(im.code))
                    handleEditGadget(NIL,GAD_NODES+subnum(im.code))
                    button:=i
                  ENDIF
                  IF(menunum(im.code)=2)
                    num:=itemnum(im.code)
                    i:=button
                    button:=1
                    handleEditGadget(NIL,GAD_SYSOPLOGIN+bm[num])
                    b:=buttons[bm[num]]
                    IF(b.type) THEN handleEditGadget(NIL,GAD_NODES+subnum(im.code))
                    button:=i
                  ENDIF     
              ENDSELECT
              Gt_ReplyIMsg(im)
            ENDWHILE
          ENDIF
          checkMasterSig(signals)
          IF(signals AND myappsig)
            WHILE(appmsg:=GetMsg(myappport))
              ReplyMsg(appmsg)          
            ENDWHILE
            ZipWindow(eWin)  ->//ChangeWindowBox(EWin,EdgeX,EdgeY,Width,Height)
          ENDIF
        ENDWHILE
        shutDownMaster()
        IF(eWin.menustrip)
          ClearMenuStrip(eWin)
          maddRem()
        ENDIF
 
        CloseWindow(eWin)
      ENDIF
    ENDIF     
  ENDIF
 
EXCEPT DO
  freeGads()  
  IF(EstrLen(publicName)>0)
    IF(scr:=LockPubScreen(publicName))
      Forbid()
      UnlockPubScreen(NIL,scr)
      CloseScreen(scr)
      Permit()
    ENDIF
  ENDIF

  IF msg THEN FreeMem(msg,SIZEOF acpMessage)
  
  IF(doMultiCom) THEN shutDownSemis()
  FOR i:=0 TO MAX_NODES-1
    IF(cmds[i]) THEN FreeMem(cmds[i],SIZEOF commands)
    IF(sopts[i]) THEN FreeMem(sopts[i],SIZEOF startOption)
  ENDFOR
  
  IF acpData THEN END acpData

  IF fds<>NIL THEN END fds[32]
  IF appicon THEN do_appicon(myappport)
  
  shutDownMaster()
  saveState()
  saveConnectionList(connectionList)
  IF oldDirLock THEN CurrentDir(oldDirLock)
  IF newlock<>NIL THEN UnLock(newlock)

  IF fontHandle
    CloseFont(fontHandle)
    fontHandle:=NIL
  ENDIF

  IF translators THEN unloadTranslators()
  IF minNode THEN END minNode

  FOR i:=0 TO 14
    DisposeLink(setOriText[i])
  ENDFOR

  END lastUsers
  END lastUploads
  END lastDownloads

  FOR i:=0 TO MAX_NODES-1
    DisposeLink(startNode[i])
    END ndUser[i]
    END ndDownloads[i]
    END ndUploads[i]
  ENDFOR

  FOR i:=0 TO connectionList.count()-1
    connItem:=connectionList.item(i)
    END connItem
  ENDFOR
  END connectionList

  IF (telnetServerSocket>=0) THEN CloseSocket(telnetServerSocket)
  IF (ftpServerSocket>=0) THEN CloseSocket(ftpServerSocket)
  
  IF broker THEN DeleteCxObj(broker)
  IF broker_mp
    -> Empty the port of CxMsgs
    WHILE msg:=GetMsg(broker_mp) DO ReplyMsg(msg)
    DeleteMsgPort(broker_mp) -> E-Note: C version incorrectly uses DeletePort()
  ENDIF

  IF socketbase THEN CloseLibrary(socketbase)
  IF cxbase THEN CloseLibrary(cxbase)
  IF iconbase THEN CloseLibrary(iconbase)
  IF gadtoolsbase THEN CloseLibrary(gadtoolsbase)
  IF diskfontbase THEN CloseLibrary(diskfontbase)
ENDPROC