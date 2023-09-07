-> Ami Express 5 
OPT LARGE,OSVERSION=37,PURE

#ifndef EVO_3_4_0
  FATAL 'Ami-Express should only be compiled with E-VO Amiga E Compiler'
#endif

/*

missing Door port commands
  FULLEDIT (not implemented in /X3 or 4)

node tooltypes
  FREE_RESUMING  - see /X4 docs (LVL_ALLOW_FREE_RESUMING & ACS_ALLOW_FREE_RESUMING) - not implemented in /X3 or 4
  RIPSCRIPT  - unknown (cant see any code that uses this value)
  NODBLBUFFER  - don't allow double buffer size during serial xfer
  HDTRANSBUFFER - see /X4 docs

*/

MODULE 'intuition/screens','intuition/intuition','intuition/gadgetclass','exec/ports','exec/nodes','exec/memory','exec/alerts','exec/semaphores',
       'devices/console','devices/serial','graphics/view','gadtools','libraries/gadtools','dos/dos','dos/var','dos/dosextens','dos/datetime',
       'dos/dostags','graphics/text','libraries/diskfont','diskfont','devices/timer','exec/io','exec/tasks','amigalib/io','amigalib/ports',
       'icon','workbench/workbench','commodities','exec/libraries','exec/lists','libraries/commodities','asl','workbench/startup','rexx/storage',
       'rexxsyslib','libraries/asl','devices/serial','xproto','xpr_lib','socket','net/socket','net/netdb','net/in','fifo','owndevunit','asyncio',
       'libraries/asyncio'

  MODULE '*axcommon','*axconsts','*axenums','*axobjects','*miscfuncs','*stringlist','*ftpd','*httpd','*errors','*mailssl','*zmodem',
         '*xymodem','*hydra','*bcd','*pwdhash','*sha256','*tooltypes','*expversion'

DEF masterMsg:acpMessage
DEF resmp: PTR TO mp
DEF rexxmp: PTR TO mp
DEF serverRP=0:PTR TO mp
DEF currentStat=0
DEF rexxPortName[20]:STRING
DEF resPortName[12]:STRING
DEF servercmd=-1
DEF serverin

DEF singleNode=0: PTR TO singlePort
DEF masterNode=0: PTR TO multiPort

DEF consoleDebugLevel=LOG_NONE
DEF debugLogLevel=LOG_ERROR
DEF inputLogging=FALSE

DEF inac=FALSE

DEF state=-1, stateData, reqState,instantLogon=FALSE
DEF windowClose=NIL:PTR TO window
DEF windowStat=NIL:PTR TO window
DEF windowZmodem=NIL:PTR TO window
DEF expMenu:PTR TO menu
DEF consoleReadMP=NIL: PTR TO mp
DEF titlebar[255]:STRING
DEF ititlebar[255]:STRING
DEF consoleIO=NIL: PTR TO iostd
DEF statWriteMP=NIL: PTR TO mp
DEF statWriteIO=NIL: PTR TO iostd
DEF zModemStatWriteMP=NIL: PTR TO mp
DEF zModemStatWriteIO=NIL: PTR TO iostd

DEF hydraWindow1=NIL:PTR TO window
DEF hydraWindow2=NIL:PTR TO window
DEF hydraWindow3=NIL:PTR TO window
DEF hydraStatWriteMP1=NIL: PTR TO mp
DEF hydraStatWriteIO1=NIL: PTR TO iostd
DEF hydraStatWriteMP2=NIL: PTR TO mp
DEF hydraStatWriteIO2=NIL: PTR TO iostd
DEF hydraStatWriteMP3=NIL: PTR TO mp
DEF hydraStatWriteIO3=NIL: PTR TO iostd
DEF hydraConsoleReadMP=NIL: PTR TO mp
DEF hydraConsoleReadIO=NIL: PTR TO iostd

DEF serialReadIO=NIL: PTR TO ioextser
DEF serialReadMP=NIL: PTR TO mp
DEF serialWriteMP=NIL: PTR TO mp
DEF serialWriteIO=NIL: PTR TO ioextser
DEF timerport=NIL: PTR TO mp
DEF timermsg=NIL: PTR TO timerequest
DEF readQueued=FALSE
DEF timerQueued=FALSE
DEF ibuf, serbuff, inControl
DEF conbuf[1]:ARRAY OF CHAR
DEF commandText[255]:STRING
DEF loggedOnUser=NIL: PTR TO user       ->shared with tooltypes.e
DEF loggedOnUserKeys=NIL: PTR TO userKeys
DEF loggedOnUserMisc=NIL: PTR TO userMisc
DEF tempAccess: tempAccess
DEF tempAccessGranted=FALSE
DEF sopt=NIL: PTR TO startOption
DEF mailOptions=NIL: PTR TO mailConfig  ->shared with mailssl.e
DEF node      ->shared with tooltypes.e
DEF ringCount
DEF nodeScreenDir[255]:STRING
DEF confScreenDir[255]:STRING
DEF nodeWorkDir[255]:STRING
DEF reservedName[255]:STRING
DEF consoleOutputDeviceName[255]:STRING
DEF consoleInputDeviceName[255]:STRING
DEF bgCheckPortName[20]:STRING

DEF currentConf=0 ->shared with tooltypes.e
DEF currentMsgBase=0
DEF relConfNum=0
DEF callerNum=0
DEF currentConfName[255]:STRING
DEF currentConfDir[255]:STRING    ->shared with tooltypes.e
DEF msgBaseLocation[255]:STRING
DEF userDataFile[255]:STRING
DEF userKeysFile[255]:STRING
DEF userMiscFile[255]:STRING
DEF maxDirs
DEF ansi: ansi
DEF quickFlag=FALSE
DEF ripMode=FALSE
DEF ansiColour=TRUE
DEF lineCount=0
DEF nonStopDisplayFlag=FALSE
DEF logonType=LOGON_TYPE_LOGGED_OFF
DEF timeoutOverride=-1
DEF sysopAvail=TRUE
DEF pagedFlag=FALSE
DEF doorTimeout=INPUT_TIMEOUT
DEF doorExtSig=NIL
DEF expressVer[15]:STRING
DEF expressDate[15]:STRING
DEF regKey[100]:STRING
DEF mailStat=NIL: PTR TO mailStat
DEF mailHeader=NIL: PTR TO mailHeader
DEF cmds=NIL: PTR TO commands   ->shared with tooltyles.e
DEF mybbsLoc[255]:STRING
DEF parsedParams: PTR TO stringlist
DEF confBases: PTR TO stdlist
DEF newSinceFlag
DEF computerEntries
DEF computerTypes: PTR TO stringlist
DEF onlineEdit=0
DEF quietFlag=FALSE
DEF chatFlag=FALSE
DEF blockOLM=TRUE

DEF chatF=0
DEF pagesAllowed=-1
DEF ownPartFiles=FALSE
DEF localUpload=FALSE
DEF bytesADL=0
DEF tTEFF=0
DEF tTCPS=0
->DEF tTTM=0
DEF ulTTTM=0
DEF dlTTTM=0
DEF dTBT[8]:ARRAY OF CHAR
DEF uTBT[8]:ARRAY OF CHAR
DEF beenUDd=FALSE
DEF lcFileXfr=0
DEF recFileNames:PTR TO stringlist
DEF skipdFiles:PTR TO stringlist
DEF checksym=0
DEF purgeScanNM[31]:STRING
DEF validUser=0
DEF uucp=0
DEF freeDownloads=FALSE
DEF acsLevel=-1
DEF overrideDefaultAccess=FALSE
DEF userSpecificAccess=FALSE
DEF connectString[20]:STRING
DEF ioFlags[7]:ARRAY OF CHAR
DEF trapConnect[100]:STRING
DEF confDBName[255]:STRING
DEF captureFP = NIL
DEF nofkeys=0
DEF relogon=FALSE
DEF lostCarrier=FALSE
DEF timeoutLC=FALSE

DEF messageMenuChar=0
DEF disallowFileAttach=FALSE

DEF floatMsgRecNum

DEF doormsgcode=0
DEF nonStopMail=FALSE
DEF kMsgFlag=FALSE
DEF noDirF
DEF tempFlag
DEF replyFlag, numOfZMsgs
DEF fwdFlag
DEF fwdDir
DEF msgNum
DEF fwdToMsg
DEF currentSeekPos
DEF fileattach=TRUE, newmailsearch = FALSE
DEF attachedFiles: PTR TO stringlist
DEF privateFlag=0
DEF alreadyRecvd
DEF delMsgNum
DEF lastMsgReadConf=0
DEF lastNewReadConf=0
DEF msgBuf: PTR TO stringlist
DEF maxMsgLines = 800
DEF confNames: PTR TO stringlist
DEF confDirs: PTR TO stringlist   ->shared with tooltyles.e
DEF historyFolder[255]:STRING
DEF userNotesFolder[255]:STRING
DEF historyBuf : PTR TO stringlist
DEF historyNum
DEF historyCycle
DEF comment=0
DEF menuPrompt[255]:STRING

DEF mciViewSafe=TRUE
DEF mcioff=FALSE

DEF newFilesPauseFlag =FALSE
DEF confNameType=NAME_TYPE_USERNAME

DEF editor: editor
DEF editorFileName[80]:STRING
DEF editorFileInclude[80]:STRING

DEF xprLib: PTR TO stringlist   ->shared with tooltypes.e
DEF xprTitle: PTR TO stringlist
DEF screenTypeTitle: PTR TO stringlist
DEF screenTypeExt: PTR TO stringlist
DEF scomment:PTR TO stringlist

DEF fCheckDir[255]:STRING   ->shared with tooltypes.e

DEF hostLanguage[255]:STRING
DEF userLanguage[255]:STRING

DEF translatorMode=TRANS_NONE
DEF translatorLanguage[255]:STRING

DEF confMailName[31]:STRING

DEF lines=0
DEF rzmsg=0
DEF tempUser: PTR TO user
DEF tempUserKeys: PTR TO userKeys
DEF tempUserMisc: PTR TO userMisc
DEF flagFilesList:PTR TO stdlist
DEF onlineBaud,onlineBaudR
DEF idRate[15]:STRING
DEF idDate[15]:STRING
DEF idTime[15]:STRING
DEF idNmbr[41]:STRING
DEF idName[41]:STRING
DEF hostName[200]:STRING
DEF hostIP[20]:STRING
DEF dlFileCount=0
DEF ulFileCount=0
DEF timeLimit
DEF logonTime
DEF lastTimeUpdate
DEF bitPlanes=3
DEF ximPort=0

DEF slowmo=0
DEF slowmoCount=0

DEF resetSerOut=FALSE

DEF mimicVersion[255]:STRING

DEF namePrompt[255]:STRING
DEF passwordPrompt[255]:STRING

DEF mciterminator[1]:STRING

DEF customMsgParam1=0
DEF customMsgParam2=0
DEF customMsgCmd[255]:STRING

DEF transfering=FALSE
DEF binaryRaw=FALSE
DEF doorSilent=FALSE

DEF cancelTransferOffHook=FALSE
DEF aeGoodFile=0
DEF sysopdl,numFiles,fsize
DEF dtfsize[8]:ARRAY OF CHAR
DEF zModemInfo: zModem
DEF chatSerFlag=0,chatConFlag=0

DEF serShared=FALSE

DEF zresume=0

DEF scropen=FALSE
DEF wantzwin=FALSE
DEF statWinType=0
DEF screen=NIL:PTR TO screen
DEF window=NIL:PTR TO window
DEF defaultfontattr: textattr
DEF fontName[255]:STRING
DEF fontHandle=NIL
DEF dStatBar=NIL
DEF consoleMP=NIL: PTR TO mp
DEF consoleReadIO=NIL: PTR TO iostd
DEF rawArrow=FALSE
DEF broker=NIL, broker_mp=NIL:PTR TO mp, cxsigflag=0

DEF securityNames
DEF securityFlags[255]:STRING
DEF secOverride[255]:STRING
DEF shutDownMsg[255]:STRING
DEF shutDownFlag=0

DEF olmBuf: PTR TO stringlist
DEF olmQueue: PTR TO stringlist
DEF lastOlmNode=-1

DEF translators: PTR TO translator
DEF managedTranslators=FALSE

DEF doorExpertMode = FALSE

DEF amixnetOutboundDir[255]:STRING
DEF netMailTransfer=FALSE
DEF sysopUploading=FALSE

DEF autoDeactivateDays=-1

DEF sdReplyRexx=NIL: PTR TO rexxmsg

DEF bgData:bgCheckData
DEF bgFileCheck=FALSE

DEF diskObjectCache:PTR TO stdlist    ->shared with tooltypes.e
DEF cacheResetOn=CACHE_RESET_NEVER
DEF cacheTests=0          ->shared with tooltypes.e
DEF cacheHits=0           ->shared with tooltypes.e

DEF serialLocked=FALSE
DEF ownDevSignal=0

DEF netTrans=0

DEF arg1[255]:STRING
DEF arg2[255]:STRING
DEF arg3[255]:STRING

DEF holdAccessLevel=201

DEF max_desclines=15

DEF serialCacheSize=0
DEF serialCacheCurrentSize=0
DEF serialCacheLastFlush1=0
DEF serialCacheLastFlush2=0
DEF serialCache=0
DEF serialCacheEnabled=FALSE

DEF includeDeact=FALSE

DEF bgChecking=FALSE

DEF ftptime1=0
DEF ftptime2=0

DEF nativeTelnet=FALSE
DEF nativeFtp=FALSE
DEF ftpConn=FALSE
DEF telnetSocket=-1
DEF offHookFlag=TRUE

DEF lastIAC=FALSE
DEF lastIAC2=FALSE
DEF iaccmd=0
DEF nawsMode=0
DEF willsent=FALSE
DEF dosent=FALSE

DEF nodeStart=0

DEF cntr=0

DEF userLineLen=0

DEF iemsiUsername[255]:STRING
DEF iemsiPassword[255]:STRING

DEF fds=NIL:PTR TO LONG

DEF zmodemRxBuffer=0
DEF zModemRxBufferSize=65536
DEF bufferedBytes=0
DEF bufferReadOffset=0
DEF lastCarrierCheck=0

DEF cmdShortcuts=FALSE
DEF shortcuts:PTR TO stringlist
DEF currentMenuName[255]:STRING
DEF defaultMenuName[255]:STRING
DEF menuPause=TRUE

DEF telnetUsername[100]:STRING
DEF telnetPassword[100]:STRING
DEF telnetUsernamePrompt[100]:STRING
DEF telnetPasswordPrompt[100]:STRING

DEF quietDownload=FALSE
DEF unknownValue=0
DEF memConf=0:PTR TO LONG ->shared with tooltypes.e

RAISE ERR_BRKR IF CxBroker()=NIL,
      ERR_PORT IF CreateMsgPort()=NIL,
      ERR_ASL  IF AllocAslRequest()=NIL

PROC calcEfficiency(cps,baud)
  DEF res
  IF cps>21474836
    res:=Mul(Div(cps,Div(baud,10)),100)
  ELSE
    res:=Div(Mul(cps,100),Div(baud,10))
  ENDIF
ENDPROC res

PROC configFileExists(fname:PTR TO CHAR)
  DEF lh
  DEF fn[255]:STRING
  
  StringF(fn,'\s.info',fname)
  IF lh:=Lock(fn,ACCESS_READ)
    UnLock(lh)
    RETURN TRUE
  ENDIF
  StringF(fn,'\s.cfg',fname)
  IF lh:=Lock(fn,ACCESS_READ)
    UnLock(lh)
    RETURN TRUE
  ENDIF

  StringF(fn,'\s.txt',fname)
  IF lh:=Lock(fn,ACCESS_READ)
    UnLock(lh)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

PROC convertAccess()
  DEF tempStr[255]:STRING

  acsLevel:=findAcsLevel()

  getUserAccessFilename(tempStr)
  userSpecificAccess:=configFileExists(tempStr);

  StringF(tempStr,'\sAccess',cmds.bbsLoc)
  IF configFileExists(tempStr)=FALSE THEN overrideDefaultAccess:=TRUE ELSE overrideDefaultAccess:=checkSecurity(ACS_OVERRIDE_DEFAULTS)

  StrCopy(securityFlags,'')
ENDPROC

PROC isConfAccessAreaName(user:PTR TO user)
  DEF i,c=0,ca
  
  FOR i:=0 TO StrLen(user.conferenceAccess)-1
    ca:=user.conferenceAccess[i]
    IF (ca<>"X") AND (ca<>"_") THEN c++
  ENDFOR
ENDPROC c<>0

PROC checkOnlineStatus()
  DEF stat

  IF(state=STATE_AWAIT) THEN RETURN RESULT_SUCCESS

  IF(reqState=REQ_STATE_LOGOFF) THEN RETURN RESULT_NO_CARRIER
  IF(logonType>=LOGON_TYPE_REMOTE)
    stat:=checkCarrier()
    IF(stat=FALSE) THEN RETURN RESULT_NO_CARRIER
  ENDIF
ENDPROC RESULT_SUCCESS

PROC modemOffHook()
  DEF ni:PTR TO nodeInfo
  offHookFlag:=TRUE
  IF (telnetSocket>=0)
    CloseSocket(telnetSocket)
    CloseLibrary(socketbase)
    socketbase:=NIL
    waitSocketLib(TRUE)
    telnetSocket:=-1
    IF sopt.toggles[TOGGLES_MULTICOM]
      ObtainSemaphore(masterNode)
      ni:=(masterNode.myNode[node])
      ni.netSocket:=-1
      ni.offHook:=TRUE
      ReleaseSemaphore(masterNode)
    ENDIF   
    ioFlags[IOFLAG_SER_IN]:=0
    ioFlags[IOFLAG_SER_OUT]:=0
    ioFlags[IOFLAG_SCR_OUT]:=-1
    ioFlags[IOFLAG_KBD_IN]:=-1
  ENDIF
  
  IF(StrLen(cmds.serDev)>0)
    IF serShared=FALSE
      serShared:=TRUE
      IF(sopt.toggles[TOGGLES_SERIALRESET])
        resetSystem()
        intDoReset(sopt.offHook)
        ioFlags[IOFLAG_SER_IN]:=0
        ioFlags[IOFLAG_SER_OUT]:=0
        ioFlags[IOFLAG_SCR_OUT]:=-1
        ioFlags[IOFLAG_KBD_IN]:=-1
      ELSE
        dropDTR();Delay(25)->//Reset_System(0)
        intDoReset(sopt.offHook)
        Delay(5)
        ->droppedHook:=1
        ioFlags[IOFLAG_SER_IN]:=0
        ioFlags[IOFLAG_SER_OUT]:=0
        ioFlags[IOFLAG_SCR_OUT]:=-1
        ioFlags[IOFLAG_KBD_IN]:=-1
      ENDIF
    ENDIF
  ENDIF
ENDPROC

PROC updateTimeUsed()
  DEF currDay,logonDay,currTime
  DEF string[255]:STRING
  currTime:=getSystemTime()
  currDay:=Div(currTime-21600,86400)
  logonDay:=Div(logonTime-21600,86400)
  IF (currDay<>logonDay)
    StringF(string,'timeused debug: \s new day reset,  currday \d, lastday \d',loggedOnUser.name, currDay,logonDay)
    debugLog(LOG_DEBUG,string)
    loggedOnUser.timeTotal:=loggedOnUser.timeLimit
    loggedOnUser.dailyBytesDld:=0
    loggedOnUser.timeUsed:=0
    loggedOnUser.chatRemain:=loggedOnUser.chatLimit
    timeLimit:=loggedOnUser.timeTotal-loggedOnUser.timeUsed

    logonTime:=Mul(currDay,86400)+21600
    lastTimeUpdate:=logonTime
  ENDIF
  IF (currTime-lastTimeUpdate)>0
    IF(chatFlag=0)
      loggedOnUser.timeUsed:=loggedOnUser.timeUsed+(currTime-lastTimeUpdate)
      timeLimit:=timeLimit-(currTime-lastTimeUpdate)
    ELSE
      IF loggedOnUser.chatLimit>0
        loggedOnUser.chatRemain:=loggedOnUser.chatRemain-(currTime-lastTimeUpdate)
      ENDIF
    ENDIF
    lastTimeUpdate:=currTime
  ENDIF
ENDPROC

PROC checkTimeUsed()
  IF (timeLimit<0) AND (state<>STATE_LOGGING_OFF) AND (checkSecurity(ACS_OVERRIDE_TIMELIMIT)=FALSE)
    IF displayScreen(SCREEN_LOGON24)=FALSE
      aePuts('You have exceeded your time limit\b\n')
      aePuts('Goodbye\b\n\b\n')
      aePuts('Disconnecting..\b\n')
    ENDIF
    modemOffHook()
    quickFlag:=TRUE
    saveFlagged()
    IF StrLen(historyFolder)>0 THEN saveHistory()
    reqState:=REQ_STATE_LOGOFF
    setEnvStat(ENV_LOGOFF)
  ENDIF
ENDPROC

PROC checkMailConfScan(conf,msgBase)
  DEF cb: PTR TO confBase
  DEF res=TRUE

  IF((checkToolTypeExists(TOOLTYPE_CONF,conf,'FORCE_NEWSCAN')))
    RETURN TRUE
  ELSEIF (checkToolTypeExists(TOOLTYPE_CONF,conf,'NO_NEWSCAN'))
    RETURN FALSE
  ENDIF

  cb:=confBases.item(getConfIndex(conf,msgBase))

  IF cb<>NIL
    IF (cb.handle[0] AND MAIL_SCAN_MASK)<>0 THEN res:=TRUE ELSE res:=FALSE
  ELSE
    res:=TRUE
  ENDIF
ENDPROC res

PROC checkFileConfScan(conf)
  DEF cb: PTR TO confBase
  DEF res

  IF((checkToolTypeExists(TOOLTYPE_CONF,conf,'SHOW_NEW_FILES')))
    RETURN TRUE
  ELSEIF (checkToolTypeExists(TOOLTYPE_CONF,conf,'NO_NEW_FILES'))
    RETURN FALSE
  ENDIF

  cb:=confBases.item(getConfIndex(conf,1))

  IF cb<>NIL
    IF (cb.handle[0] AND FILE_SCAN_MASK)<>0 THEN res:=TRUE ELSE res:=FALSE
  ELSE
    res:=TRUE
  ENDIF
ENDPROC res

PROC closeSerial()
  
  IF serialReadIO<>NIL
    IF CheckIO(serialReadIO)=FALSE THEN AbortIO(serialReadIO)
    CloseDevice(serialReadIO)
    deleteExtIO(serialReadIO)
    serialReadIO:=NIL
  ENDIF
  IF serialReadMP<>NIL
    deletePort(serialReadMP)
    serialReadMP:=NIL
  ENDIF
  IF serialWriteIO<>NIL
    CloseDevice(serialWriteIO)
    deleteExtIO(serialWriteIO)
    serialWriteIO:=NIL
  ENDIF
  IF serialWriteMP<>NIL
    deletePort(serialWriteMP)
    serialWriteMP:=NIL
  ENDIF

  IF serialCache<>NIL
    Dispose(serialCache)
  ENDIF
ENDPROC

PROC setNRAMS()
  DEF nramName[255]:STRING
  DEF nramData[255]:STRING
  DEF n=1

  StringF(nramName,'NRAM.\d',1)
  IF readToolType(TOOLTYPE_NRAMS,node,nramName,nramData) AND (serialWriteIO<>NIL)
    ioFlags[IOFLAG_SER_IN]:=-1
    ioFlags[IOFLAG_SER_OUT]:=0
    ioFlags[IOFLAG_SCR_OUT]:=0
    ioFlags[IOFLAG_KBD_IN]:=-1
    dropDTR()
    intDoReset(sopt.offHook)
    setEnvMsg('Setting NRAMS')
    REPEAT
      StringF(nramName,'Setting NRAM.\d',n)
      setEnvMsg(nramName)
      intDoReset(nramData)
      Delay(60)
      n++
      StringF(nramName,'NRAM.\d',n)
    UNTIL readToolType(TOOLTYPE_NRAMS,node,nramName,nramData)=FALSE
    resetSystem()
    setEnvStat(ENV_AWAITCONNECT)
  ELSE
    setEnvMsg('NO NRAM.DEF')
    Delay(30)
    setEnvStat(ENV_AWAITCONNECT)
  ENDIF
ENDPROC

PROC reInitModem()
  dropDTR()
  Delay(20)
  intDoReset(sopt.offHook)
  Delay(60)
  serPuts(cmds.mInit)
  serPutChar("\b")
  Delay(60)
  purgeLine()
ENDPROC

PROC openSerial(baud, dataLen, stopBits)
  DEF flags,rcount=0,error
  DEF errorstr[255]:STRING

  IF serialReadIO<>NIL THEN RETURN FALSE

  IF(StrLen(cmds.serDev)>0)
    IF (serialCacheSize>0) THEN serialCache:=New(serialCacheSize+1)
    serialCacheLastFlush1,serialCacheLastFlush2:=getSystemTime()

    IF (serialCacheSize<=0) OR (serialCache<>NIL)
      IF(serialReadMP:=createPort(0,0))
        IF(serialReadIO:=createExtIO(serialReadMP,SIZEOF ioextser))
          IF(serialWriteMP:=createPort(0,0))
            IF(serialWriteIO:=createExtIO(serialWriteMP,SIZEOF ioextser))
              flags:=SERF_SHARED
              IF checkToolTypeExists(TOOLTYPE_NODE,node,'NORADBOOGIE')=FALSE THEN flags:=flags OR SERF_XDISABLED OR SERF_RAD_BOOGIE
              IF (cmds.acLvl[LVL_VARYING_LINK_RATE]=0) THEN flags:=flags OR SERF_7WIRE
              serialWriteIO.serflags:=flags
              serialReadIO.serflags:=flags

retry:
              IF((OpenDevice(cmds.serDev,cmds.serDevUnit,serialReadIO,0)))=FALSE
                IF((OpenDevice(cmds.serDev,cmds.serDevUnit,serialWriteIO,0)))=FALSE
                  Delay(10)

                  serialWriteIO.baud:=baud
                  serialWriteIO.readlen:=dataLen
                  serialWriteIO.writelen:=dataLen
                  serialWriteIO.serflags:=flags
                  serialWriteIO.stopbits:=stopBits
                  serialWriteIO.ctlchar:=286457856   ->0x11130000
                  serialWriteIO.rbuflen:=16384
                  serialWriteIO.iostd.command:=SDCMD_SETPARAMS
                  error:=DoIO(serialWriteIO)
                  IF error
                    StringF(errorstr,'error write setparams: \d',error)
                    debugLog(LOG_ERROR,errorstr)
                  ENDIF

                  serialReadIO.baud:=baud
                  serialReadIO.readlen:=dataLen
                  serialReadIO.writelen:=dataLen
                  serialReadIO.serflags:=flags
                  serialReadIO.stopbits:=stopBits
                  serialReadIO.ctlchar:=286457856   ->0x11130000
                  serialReadIO.rbuflen:=16384
                  serialReadIO.iostd.command:=SDCMD_SETPARAMS
                  error:=DoIO(serialReadIO)
                  IF error
                    StringF(errorstr,'error read setparams: \d',error)
                    debugLog(LOG_ERROR,errorstr)
                  ENDIF

                  queueSerialRead({serbuff})
                  RETURN FALSE
                ENDIF
              ELSE
               Delay(30)
               rcount++
               IF rcount<120 THEN JUMP retry
              ENDIF

              deleteExtIO(serialWriteIO)
              serialWriteIO:=NIL
            ENDIF
            deletePort(serialWriteMP)
            serialWriteMP:=NIL
          ENDIF
          deleteExtIO(serialReadIO)
          serialReadIO:=NIL
        ENDIF
        deletePort(serialReadMP)
        serialReadMP:=NIL
      ENDIF
      Dispose(serialCache)
      serialCache:=NIL
    ENDIF
    RETURN TRUE
  ENDIF

ENDPROC FALSE

PROC setBaud(rate)
  IF serialReadIO<>NIL
    purgeLine()                 /* Flush recieve buffer */
    AbortIO(serialReadIO)         /* Abort PurgeLine's read req */
    WaitIO(serialReadIO)
    serialReadIO.baud:=rate  /* set baud rate */
    serialReadIO.iostd.command:=SDCMD_SETPARAMS
    DoIO(serialReadIO)

    serialReadIO.iostd.command:=CMD_READ /* Restart read req */
    SendIO(serialReadIO)
  ENDIF
ENDPROC


PROC intDoReset(s: PTR TO CHAR)
  DEF loop,i
  i:=StrLen(s)
  FOR loop:=0 TO i-1
    IF(s[loop]="~")
      Delay(110)
    ELSE
      IF(s[loop]="|")
        serPutChar("\b")
        Delay(60)
      ELSE
        serPutChar(s[loop])
      ENDIF
    ENDIF
  ENDFOR
  serPutChar("\b")
ENDPROC

PROC dropDTR()
  DEF ni:PTR TO nodeInfo
  IF telnetSocket>=0
    CloseSocket(telnetSocket)
    CloseLibrary(socketbase)
    socketbase:=NIL
    waitSocketLib(TRUE)
    telnetSocket:=-1
    IF sopt.toggles[TOGGLES_MULTICOM]
      ObtainSemaphore(masterNode)
      ni:=(masterNode.myNode[node])
      ni.netSocket:=-1
      ReleaseSemaphore(masterNode)
    ENDIF
  ENDIF
  
  IF(serialReadIO<>NIL)
    IF(CheckIO(serialReadIO))=FALSE
      AbortIO(serialReadIO)
    ENDIF
    WaitIO(serialReadIO)

    closeSerial()    ->// this was not resetting SEROUT Mon Jun  8 04:02:50 1992
    Delay(60)
    IF(openSerial(cmds.openingBaud,8,1)<>0)
      debugLog(LOG_ERROR,'Can''t re-open Serial Device!')
    ENDIF

    Delay(60)
  ENDIF
  offHookFlag:=FALSE
  IF sopt.toggles[TOGGLES_MULTICOM]
    ObtainSemaphore(masterNode)
    ni:=(masterNode.myNode[node])
    ni.offHook:=FALSE
    ReleaseSemaphore(masterNode)
  ENDIF
ENDPROC


PROC rePurge()
  WHILE(checkSer())
    WaitIO(serialReadIO)
    serialReadIO.iostd.command:=CMD_READ
    SendIO(serialReadIO)
  ENDWHILE
ENDPROC

PROC resetSystem()
  DEF tempStr[255]:STRING
  DEF ni:PTR TO nodeInfo

  ioFlags[IOFLAG_KBD_IN]:=-1
  ioFlags[IOFLAG_SER_IN]:=0
  IF(ioFlags[IOFLAG_FIL_IN]) THEN ioFlags[IOFLAG_FIL_IN]:=0

  ioFlags[IOFLAG_SCR_OUT]:=0
  ioFlags[IOFLAG_SER_OUT]:=-1
  
  IF (telnetSocket>=0)
    CloseSocket(telnetSocket)
    CloseLibrary(socketbase)
    socketbase:=NIL
    waitSocketLib(TRUE)
    telnetSocket:=-1
    IF sopt.toggles[TOGGLES_MULTICOM]
      ObtainSemaphore(masterNode)
      ni:=(masterNode.myNode[node])
      ni.netSocket:=-1
      ReleaseSemaphore(masterNode)
    ENDIF

  ENDIF
  
  IF(StrLen(cmds.serDev)<>0)
    purgeLine()
    dropDTR()
    Delay(25)
    IF(cmds.acLvl[LVL_VARYING_LINK_RATE]=1)
      setBaud(cmds.openingBaud)
      Delay(25)
    ENDIF
    intDoReset(cmds.mReset)
    IF(sopt.toggles[TOGGLES_TRUERESET])
      Delay(30)
      serPuts('ATZ\b')
      lineInput('','',50,5,tempStr)
      IF(StriCmp(tempStr,'ATZ',3))
        Delay(50)
      ENDIF
      reInitModem()
      intDoReset(cmds.mReset)
    ENDIF
    Delay(30)
    IF(sopt.toggles[TOGGLES_NOPURGE]) THEN RETURN
    IF(sopt.toggles[TOGGLES_REPURGE])
      rePurge()
      RETURN
    ENDIF
    purgeLine()

    ioFlags[IOFLAG_SER_OUT]:=0

  ENDIF
  offHookFlag:=FALSE
  IF sopt.toggles[TOGGLES_MULTICOM]
    ObtainSemaphore(masterNode)
    ni:=(masterNode.myNode[node])
    ni.offHook:=FALSE
    ReleaseSemaphore(masterNode)
  ENDIF
ENDPROC

PROC checkPasswordStrength(newPass:PTR TO CHAR)
  DEF min,act,lower=0,upper=0,num=0,sym=0,i
  min:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'MIN_PASSWORD_LENGTH') 
  IF min>0
    IF StrLen(newPass)<min THEN RETURN 1
  ENDIF

  min:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'MIN_PASSWORD_STRENGTH') 
  IF min>0
    act:=0
    IF min>4 THEN min:=4
    FOR i:=0 TO StrLen(newPass)-1 
      IF (newPass[i]>=48) AND (newPass[i]<=57) 
        num:=1
      ELSEIF (newPass[i]>=65) AND (newPass[i]<=90)
        upper:=1
      ELSEIF (newPass[i]>=97) AND (newPass[i]<=122) 
        lower:=1
      ELSE
        sym:=1
      ENDIF
    ENDFOR
    act:=lower+upper+num+sym
    IF act<min THEN RETURN 2
  ENDIF
ENDPROC TRUE

PROC setNewPassword(user:PTR TO user, userMisc:PTR TO userMisc, newpass:PTR TO CHAR)
  DEF passType
  
  IF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','LEGACY')
    passType:=PWD_LEGACY
  ELSEIF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','PBKDF2_5')
    passType:=PWD_PBKDF2_5
  ELSEIF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','PBKDF2_50')
    passType:=PWD_PBKDF2_50
  ELSEIF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','PBKDF2_100')
    passType:=PWD_PBKDF2_100
  ELSEIF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','PBKDF2_1000')
    passType:=PWD_PBKDF2_1000
  ELSEIF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','PBKDF2_10000')
    passType:=PWD_PBKDF2_10000
  ELSE
    passType:=PWD_LEGACY
  ENDIF
  
  userMisc.pwdType:=passType
  SELECT passType
    CASE PWD_LEGACY
      UpperStr(newpass)
      user.pwdHash:=calcPasswordHash(newpass)
      MemFill(userMisc.pwdHash,32,0)
    CASE PWD_PBKDF2_5
      calcPasswordSalt(userMisc.salt)
      pkcs5_pbkdf2(newpass,StrLen(newpass), userMisc.salt,8, userMisc.pwdHash, 32, 5)
      user.pwdHash:=-1
    CASE PWD_PBKDF2_50
      calcPasswordSalt(userMisc.salt)
      pkcs5_pbkdf2(newpass,StrLen(newpass), userMisc.salt,8, userMisc.pwdHash, 32, 50)
      user.pwdHash:=-1
    CASE PWD_PBKDF2_100
      calcPasswordSalt(userMisc.salt)
      pkcs5_pbkdf2(newpass,StrLen(newpass), userMisc.salt,8, userMisc.pwdHash, 32, 100)
      user.pwdHash:=-1
    CASE PWD_PBKDF2_1000
      calcPasswordSalt(userMisc.salt)
      pkcs5_pbkdf2(newpass,StrLen(newpass), userMisc.salt,8, userMisc.pwdHash, 32, 1000)
      user.pwdHash:=-1
    CASE PWD_PBKDF2_10000
      calcPasswordSalt(userMisc.salt)
      pkcs5_pbkdf2(newpass,StrLen(newpass), userMisc.salt,8, userMisc.pwdHash, 32, 10000)
      user.pwdHash:=-1
  ENDSELECT
ENDPROC

PROC checkUserPassword(user:PTR TO user, userMisc:PTR TO userMisc, testpass:PTR TO CHAR) 
  DEF tmpHash[32]:ARRAY OF CHAR
  DEF tempPass[100]:STRING
  DEF res,maxAttempts
  SELECT userMisc.pwdType
    CASE PWD_LEGACY
      StrCopy(tempPass,testpass)
      UpperStr(tempPass)
      res:=(user.pwdHash=calcPasswordHash(tempPass))
    CASE PWD_PBKDF2_5
      pkcs5_pbkdf2(testpass,StrLen(testpass), userMisc.salt,8, tmpHash, 32, 5)
      res:=(StrCmp(tmpHash,userMisc.pwdHash,32))
    CASE PWD_PBKDF2_50
      pkcs5_pbkdf2(testpass,StrLen(testpass), userMisc.salt,8, tmpHash, 32, 50)
      res:=(StrCmp(tmpHash,userMisc.pwdHash,32))
    CASE PWD_PBKDF2_100
      pkcs5_pbkdf2(testpass,StrLen(testpass), userMisc.salt,8, tmpHash, 32, 100)
      res:=(StrCmp(tmpHash,userMisc.pwdHash,32))
    CASE PWD_PBKDF2_1000
      pkcs5_pbkdf2(testpass,StrLen(testpass), userMisc.salt,8, tmpHash, 32, 1000)
      res:=(StrCmp(tmpHash,userMisc.pwdHash,32))
    CASE PWD_PBKDF2_10000
      pkcs5_pbkdf2(testpass,StrLen(testpass), userMisc.salt,8, tmpHash, 32, 10000)
      res:=(StrCmp(tmpHash,userMisc.pwdHash,32))
  ENDSELECT
  IF res=FALSE
    userMisc.invalidAttempts:=userMisc.invalidAttempts+1
    maxAttempts:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'MAX_PASSWORD_FAILS') 
    IF maxAttempts>=0
      IF userMisc.invalidAttempts>=maxAttempts
        userMisc.accountLocked:=TRUE
        userMisc.invalidAttempts:=0
      ENDIF
    ENDIF
  ELSE
    userMisc.invalidAttempts:=0
  ENDIF
  
ENDPROC res


PROC acceptIncomingConnection(sock,ftp)
  DEF ni:PTR TO nodeInfo
  DEF socket
  ftpConn:=ftp
  IF (telnetSocket=-1) AND (offHookFlag=FALSE)
    telnetSocket:=ObtainSocket(sock,PF_INET,SOCK_STREAM,IPPROTO_TCP)

    IF checkCarrier()=FALSE 
      CloseSocket(telnetSocket)
      CloseLibrary(socketbase)
      socketbase:=NIL
      waitSocketLib(TRUE)
      telnetSocket:=-1
    ENDIF

    IF sopt.toggles[TOGGLES_MULTICOM]
      ObtainSemaphore(masterNode)
      ni:=(masterNode.myNode[node])
      ni.netSocket:=telnetSocket
      ReleaseSemaphore(masterNode)
    ENDIF
  ELSE
    socket:=ObtainSocket(sock,PF_INET,SOCK_STREAM,IPPROTO_TCP)
    CloseSocket(socket)
  ENDIF
  IF sopt.toggles[TOGGLES_MULTICOM]
    ObtainSemaphore(masterNode)
    ni:=(masterNode.myNode[node])
    IF ni.netSocket=-2 THEN ni.netSocket:=telnetSocket
    ReleaseSemaphore(masterNode)
  ENDIF
ENDPROC

PROC checkDoorMsg(mode)
  DEF returnval=FALSE
  DEF ch,cmd
  DEF type,temp,exit
  DEF servermsg: PTR TO jhMessage
  DEF i
  DEF subState: loggedOnState
  DEF debugstr[255]:STRING
  DEF tempstring[255]:STRING

  IF(inac) THEN RETURN

  IF (resmp=FALSE) THEN RETURN
  exit:=FALSE

  WHILE(servermsg:=GetMsg(resmp)) AND (exit=FALSE)
    StringF(debugstr,'server message cmd:\d',servermsg.command)
    debugLog(LOG_DEBUG,debugstr)
    StringF(debugstr,'server message data:\d',servermsg.data)
    debugLog(LOG_DEBUG,debugstr)
    StringF(debugstr,  'server message string:\s',servermsg.string)
    debugLog(LOG_DEBUG,debugstr)
    cmd:=servermsg.command

    IF cmd=EXT_LOAD_ACCOUNT THEN cmd:=LOAD_ACCOUNT
    IF cmd=EXT_SAVE_ACCOUNT THEN cmd:=SAVE_ACCOUNT

    SELECT cmd
      CASE JH_WRITE
        inac:=TRUE
        IF(currentStat=0)
          IF blockOLM=FALSE THEN aePuts(servermsg.string)
        ELSE
          sendOlmPacket(node,servermsg.string,0)
        ENDIF
        servermsg.command:=currentStat
        inac:=FALSE
      CASE JH_MCI
        inac:=TRUE
        ReplyMsg(servermsg)
        StrCopy(tempstring,servermsg.string)
        processMci(tempstring)
        IF servermsg.data
          aePuts('\b\n')
          checkForPause()
        ENDIF
        inac:=FALSE
        exit:=TRUE
      CASE JH_CO
        inac:=TRUE
        conPuts(servermsg.string)
        IF(servermsg.data) THEN conPuts('\b\n')
        inac:=FALSE
      CASE JH_SM
        inac:=TRUE
        aePuts(servermsg.string)
        IF(servermsg.data) THEN aePuts('\b\n')
        inac:=FALSE
      CASE JH_PM
        inac:=TRUE
        aePuts(servermsg.string)
        IF(lineInput(servermsg.string,'',servermsg.data,doorTimeout,tempstring)<>RESULT_SUCCESS)
          servermsg.data:=-1
        ELSE
          servermsg.data:=1
        ENDIF
        inac:=FALSE
      CASE JH_HK
        inac:=TRUE
        lineCount:=0
        aePuts(servermsg.string)
        ch:=readChar(doorTimeout)
        IF(ch<0)
          servermsg.data:=-1
        ELSE
          servermsg.data:=1
        ENDIF
        servermsg.string[0]:=ch
        servermsg.string[1]:=0
        inac:=FALSE
      CASE JH_SG
        inac:=TRUE
        IF (findSecurityScreen(servermsg.string,tempstring)) THEN displayFile(tempstring)
        inac:=FALSE
      CASE JH_SF
        inac:=TRUE
        displayFile(servermsg.string)
        inac:=FALSE
      CASE JH_EF
        inac:=TRUE;
        fileattach:=FALSE
        loadMsg(servermsg.string)
        IF(edit()=RESULT_SUCCESS)
          saveMsg(servermsg.string)
          servermsg.data:=1
        ELSE
          servermsg.data:=-1
        ENDIF
        inac:=FALSE
      CASE JH_BBSNAME
        AstrCopy(servermsg.string,cmds.bbsName,80)
      CASE JH_SYSOP
        AstrCopy(servermsg.string,cmds.sysopName,80)
      CASE JH_FLAGFILE
        addFlagToList(servermsg.string)
      CASE  DT_NAME
        IF(servermsg.data)
          AstrCopy(servermsg.string,loggedOnUser.name,31)
        ELSE
          AstrCopy(loggedOnUser.name,servermsg.string,31)
        ENDIF
      CASE  DT_PASSWORD
        IF (servermsg.data)
          ->we dont allow doors to grab the password
          AstrCopy(servermsg.string,'')
        ELSE
          ->calculate the new password hash
          StrCopy(tempstring,servermsg.string)
          IF StrLen(tempstring)>0
            setNewPassword(loggedOnUser,loggedOnUserMisc,tempstring)
            loggedOnUserMisc.pwdLastUpdated:=getSystemTime()
          ENDIF
        ENDIF
      CASE DT_LOCATION
        IF (servermsg.data)
          AstrCopy(servermsg.string,loggedOnUser.location,30)
        ELSE
          AstrCopy(loggedOnUser.location,servermsg.string,30)
        ENDIF
      CASE DT_PHONENUMBER
        IF (servermsg.data)
          AstrCopy(servermsg.string,loggedOnUser.phoneNumber,13)
        ELSE
          AstrCopy(loggedOnUser.phoneNumber,servermsg.string,13)
        ENDIF
      CASE DT_SLOTNUMBER
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.slotNumber)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.slotNumber:=Val(servermsg.string)
        ENDIF
      CASE DT_SECSTATUS
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.secStatus)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.secStatus:=Val(servermsg.string)
          convertAccess()
        ENDIF
      CASE DT_SECBOARD
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.secBoard)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.secBoard:=Val(servermsg.string)
        ENDIF
      CASE DT_SECLIBRARY
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.secLibrary)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.secLibrary:=Val(servermsg.string)
        ENDIF
      CASE DT_SECBULLETIN
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.secBulletin)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.secBulletin:=Val(servermsg.string)
        ENDIF
      CASE DT_MESSAGESPOSTED
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.messagesPosted AND $FFFF)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.messagesPosted:=Val(servermsg.string)
        ENDIF
      CASE DT_UPLOADS
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.uploads AND $FFFF)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.uploads:=Val(servermsg.string)
        ENDIF
      CASE DT_DOWNLOADS
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.downloads AND $FFFF)
          AstrCopy(servermsg.string,tempstring,200)
        ELSE
          loggedOnUser.downloads:=Val(servermsg.string)
        ENDIF
      CASE DT_TIMESCALLED
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.timesCalled AND $FFFF)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.timesCalled:=Val(servermsg.string)
        ENDIF
      CASE DT_TIMELASTON
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.timeLastOn)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.timeLastOn:=Val(servermsg.string)
        ENDIF
      CASE DT_TIMEUSED
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.timeUsed)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.timeUsed:=Val(servermsg.string)
        ENDIF
      CASE DT_TIMELIMIT
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.timeLimit)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.timeLimit:=Val(servermsg.string)
        ENDIF
      CASE DT_TIMETOTAL
        IF (servermsg.data)
          StringF(tempstring,'\d',loggedOnUser.timeTotal)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.timeTotal:=Val(servermsg.string)
        ENDIF
      CASE DT_BYTESUPLOAD
        IF (servermsg.data)
          formatBCD(loggedOnUserMisc.uploadBytesBCD,tempstring)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          bcdVal(servermsg.string,loggedOnUserMisc.uploadBytesBCD)
          loggedOnUser.bytesUpload:=convertFromBCD(loggedOnUserMisc.uploadBytesBCD)
        ENDIF
      CASE DT_BYTEDOWNLOAD
        IF (servermsg.data)
          formatBCD(loggedOnUserMisc.downloadBytesBCD,tempstring)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          bcdVal(servermsg.string,loggedOnUserMisc.downloadBytesBCD)
          loggedOnUser.bytesDownload:=convertFromBCD(loggedOnUserMisc.downloadBytesBCD)
        ENDIF
      CASE DT_DAILYBYTELIMIT
        IF (servermsg.data)
          formatUnsignedLong(loggedOnUser.dailyBytesLimit,tempstring)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.dailyBytesLimit:=Val(servermsg.string)
        ENDIF
      CASE DT_DAILYBYTEDLD
        IF (servermsg.data)
          formatUnsignedLong(loggedOnUser.dailyBytesDld,tempstring)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.dailyBytesDld:=Val(servermsg.string)
        ENDIF
      CASE DT_EXPERT
        IF (servermsg.data)
          StringF(tempstring,'\c',loggedOnUser.expert)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          loggedOnUser.expert:=servermsg.string[0]
        ENDIF
      CASE DT_LINELENGTH
        IF (servermsg.data)
          StringF(tempstring,'\d',userLineLen)
          AstrCopy(servermsg.string,tempstring,200)
        ELSE
          loggedOnUser.lineLength:=Val(servermsg.string)
          userLineLen:=loggedOnUser.lineLength
        ENDIF
      CASE DT_DUMP
        dumpActiveUser(servermsg.string)
      CASE DT_TIMEOUT
        IF (servermsg.data)
          StringF(tempstring,'\d',doorTimeout)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          doorTimeout:=Val(servermsg.string)
        ENDIF
      CASE BB_CONFNAME
        IF (servermsg.data)
          StrCopy(tempstring,currentConfName)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          StrCopy(currentConfName,servermsg.string)
          setConfName(loggedOnUser.confRJoin,servermsg.string)
        ENDIF
      CASE BB_CONFLOCAL
        IF (servermsg.data)
          StrCopy(tempstring,currentConfDir)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          setConfLocation(loggedOnUser.confRJoin,servermsg.string)
        ENDIF
      CASE BB_LOCAL
        StrCopy(tempstring,cmds.bbsLoc)
        AstrCopy(servermsg.string,tempstring,80)

      CASE BB_STATUS
        IF(mode)
          AstrCopy(servermsg.string,'ONLINE')
        ELSE
          AstrCopy(servermsg.string,'OFFLINE')
        ENDIF
      CASE BB_COMMAND
        serverin:=servermsg.string[0]
        returnval:=TRUE
      CASE BB_MAINLINE
        StrCopy(tempstring,commandText)
        AstrCopy(servermsg.string,tempstring,80)
      CASE BB_TASKPRI
        StringF(tempstring,'\c',cmds.taskPri)
        AstrCopy(servermsg.string,tempstring,80)
      CASE RAWSCREEN_ADDRESS
        StringF(tempstring,'\d',screen)
        AstrCopy(servermsg.string,tempstring,80)
      CASE BB_CHATFLAG
        IF sysopAvail
          AstrCopy(servermsg.string,'ON')
        ELSE
          AstrCopy(servermsg.string,'OFF')
        ENDIF
      CASE EXPRESS_VERSION
        getExpressMajorVer(tempstring)
        AstrCopy(servermsg.string,tempstring,80)
      CASE SV_UNICONIFY
        servercmd:=SV_UNICONIFY
      CASE SV_EXITNODE
        servercmd:=SV_EXITNODE
      CASE SV_NODEOFFHOOK
        servercmd:=SV_NODEOFFHOOK
      CASE SV_SYSOPLOG
        servercmd:=SV_SYSOPLOG
      CASE SV_LOCALLOG
        servercmd:=SV_LOCALLOG
      CASE SV_INSTANT
        servercmd:=SV_INSTANT
      CASE SV_CHATTOGGLE
        servercmd:=SV_CHATTOGGLE
      CASE SV_TOGGLESTATUS
        servercmd:=SV_TOGGLESTATUS
      CASE SV_ACCOUNTS
        servercmd:=SV_ACCOUNTS
      CASE SV_QUIETNODE
        quietFlag:=Not(quietFlag)
        sendQuietFlag(quietFlag)
      CASE SV_SETNRAMS
        ReplyMsg(servermsg)
        type:=servermsg.msg.ln.type
        IF type=NT_FREEMSG THEN FreeMem(servermsg,servermsg.msg.length)
        servermsg:=NIL
        setNRAMS()
      CASE SV_CHAT
        IF logonType<>LOGON_TYPE_LOGGED_OFF THEN servercmd:=SV_CHAT
      CASE SV_INITMODEM
        servercmd:=SV_INITMODEM
      CASE SV_WHATSUP
        sendMaster()
      CASE BB_CHATSET
        IF servermsg.data
          StringF(tempstring,'\d',pagedFlag)
          AstrCopy(servermsg.string,tempstring,80)
        ELSE
          temp:=pagedFlag
          pagedFlag:=Val(servermsg.string)

          IF pagedFlag AND Not(temp)
            sysopPaged()
          ENDIF
        ENDIF
      CASE SV_RESERVE
        servercmd:=SV_RESERVE
      CASE SV_AESHELL
        servercmd:=SV_AESHELL
      CASE SV_KICKUSER
        servercmd:=SV_KICKUSER
      CASE SV_TIMEINCREASE
        servercmd:=SV_TIMEINCREASE
      CASE SV_TIMEDECREASE
        servercmd:=SV_TIMEDECREASE
      CASE SV_CAPTURE
        servercmd:=SV_CAPTURE
      CASE SV_DISPLAYFILE
        servercmd:=SV_DISPLAYFILE
      CASE SV_GRANTTEMP
        servercmd:=SV_GRANTTEMP
      CASE SV_RESERVENODE
        StrCopy(reservedName,servermsg.string)
        IF(StrLen(reservedName)>0)
          setEnvStat(ENV_AWAITCONNECT)
        ELSE
          setEnvStat(ENV_RESERVE)
        ENDIF
      CASE SV_INCOMING_MSG
        IF blockOLM=FALSE
          subState:=stateData

          lastOlmNode:=servermsg.nodeID
          olmBuf.add(servermsg.string)
          IF servermsg.lineNum<0
            ->message ready to send
            IF (state=STATE_LOGGEDON) AND (subState.subState=SUBSTATE_READ_COMMAND)
              FOR i:=0 TO olmBuf.count()-1
                aePuts(olmBuf.item(i))
              ENDFOR
              olmBuf.clear()
            ELSE
              FOR i:=0 TO olmBuf.count()-1
                olmQueue.add(olmBuf.item(i))
              ENDFOR
              olmBuf.clear()
            ENDIF
          ENDIF
        ENDIF
      CASE LOAD_ACCOUNT
        doorMsgLoadAccount(servermsg)
      CASE SAVE_ACCOUNT
        doorMsgSaveAccount(servermsg)
      CASE SAVE_CONFDB
        saveConfDB(servermsg.data,servermsg.nodeID,1,servermsg.filler1)
        IF(loggedOnUser.slotNumber=servermsg.data) THEN loadMsgPointers(currentConf,1)
      CASE LOAD_CONFDB
        loadConfDB(servermsg.data,servermsg.nodeID,1,servermsg.filler1)
      CASE CANCEL_TRANSFER_OFFHOOK
        cancelTransferOffHook:=TRUE
      CASE CLEAR_OLM_QUEUE
        processOlmMessageQueue(FALSE)
      CASE INCOMING_TELNET
        acceptIncomingConnection(servermsg.data,FALSE)
      CASE INCOMING_FTP
        acceptIncomingConnection(servermsg.data,TRUE)
      CASE SV_CONFMAINT
        servercmd:=SV_CONFMAINT
      CASE SV_VIEWLOGS
        servercmd:=SV_VIEWLOGS
    ENDSELECT
    IF servermsg<>NIL
      ReplyMsg(servermsg)
      type:=servermsg.msg.ln.type
      IF type=NT_FREEMSG THEN FreeMem(servermsg,servermsg.msg.length)
    ENDIF
  ENDWHILE
  inac:=FALSE
ENDPROC returnval

PROC getPass2(prompt: PTR TO CHAR,password:PTR TO CHAR,userPwd, max:LONG,outstr=NIL:PTR TO CHAR)

  DEF c,i,j
  DEF pass[200]:STRING
  DEF tempstr[255]:STRING
  DEF passType

  i:=1
  IF (password<>NIL)
    IF (StrLen(password)=0) THEN RETURN RESULT_FAILURE
  ENDIF

  WHILE i
    aePuts(prompt)
    j:=0
    REPEAT
      IF StrLen(iemsiPassword)>0
        IF j=StrLen(iemsiPassword)
          c:=13
        ELSE
          c:=iemsiPassword[j]
        ENDIF
      ELSE
        c:=readChar(INPUT_TIMEOUT)
      ENDIF
      IF((c=RESULT_NO_CARRIER) OR (c=RESULT_TIMEOUT)) THEN RETURN c
      IF(c=CHAR_BACKSPACE)
        IF j<>0
          StrCopy(tempstr,'')
          StrAddChar(tempstr,8)
          StrAdd(tempstr,' ')
          StrAddChar(tempstr,8)
          aePuts(tempstr)
          j--
        ENDIF
      ELSE
        IF((c<>13) AND (c<>12) AND (c<>10))
          StrAdd(pass,' ')
          pass[j]:=c
          serPuts('*')
          IF checkToolTypeExists(TOOLTYPE_NODE,node,'VIEW_PASSWORD') THEN conPutChar(c) ELSE conPuts('*')
          j++
        ENDIF
      ENDIF
    UNTIL (c=13) OR (c=12) OR (j>=30)
    
    StrCopy(iemsiPassword,'')
    
    SetStr(pass,j)
    IF (outstr<>NIL) THEN StrCopy(outstr,pass)

    IF(j>max) THEN SetStr(pass,max)

    IF j>0
      IF (password<>NIL)
        IF(StriCmp(pass,password))
          purgeLine()
          aePuts('\b\n')
          RETURN RESULT_SUCCESS
        ENDIF
      ELSEIF userPwd
        IF checkUserPassword(loggedOnUser,loggedOnUserMisc,pass)
          IF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','LEGACY')
            passType:=PWD_LEGACY
          ELSEIF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','PBKDF2_5')
            passType:=PWD_PBKDF2_5 
          ELSEIF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','PBKDF2_50')
            passType:=PWD_PBKDF2_50
          ELSEIF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','PBKDF2_100')
            passType:=PWD_PBKDF2_100 
          ELSEIF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','PBKDF2_1000')
            passType:=PWD_PBKDF2_1000
          ELSEIF checkToolType(TOOLTYPE_BBSCONFIG,0,'PASSWORD_SECURITY','PBKDF2_10000')
            passType:=PWD_PBKDF2_10000
          ELSE
            passType:=PWD_LEGACY
          ENDIF
    
          IF loggedOnUserMisc.pwdType<>passType
            setNewPassword(loggedOnUser,loggedOnUserMisc,pass)
          ENDIF
          
          IF checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'STRICT_PASSWORD_POLICY')
            IF checkPasswordStrength(pass)<>TRUE THEN loggedOnUserMisc.forcePwdReset:=TRUE
          ENDIF
          purgeLine()
          aePuts('\b\n')
          RETURN RESULT_SUCCESS
        ENDIF
      ELSE
        purgeLine()
        aePuts('\b\n')
        RETURN RESULT_SUCCESS
      ENDIF
    ENDIF
    aePuts('\b\n')
    i--
  ENDWHILE
  purgeLine()
  aePuts('\b\n')
ENDPROC RESULT_NOT_ALLOWED

PROC aePuts(string,force=FALSE)
  aePuts2(string,-1,force)
ENDPROC

PROC asl(s: PTR TO CHAR,slines=NIL:PTR TO stringlist) HANDLE
  DEF fr:PTR TO filerequester
  DEF src[100]:STRING,tags=NIL:PTR TO LONG
  DEF flags,x
  DEF frargs: PTR TO wbarg

  IF KickVersion(37)=FALSE THEN Raise(ERR_KICKVER)  -> E-Note: requires V37
  aslbase:=OpenLibrary('asl.library',37)
  IF aslbase=NIL THEN Raise(ERR_LIB)

  flags:=FILF_PATGAD
  IF slines<>NIL THEN flags:=flags OR FILF_MULTISELECT
  tags:=NEW [ASL_HAIL,'/X FileRequest',
                      ASLFR_SCREEN,screen,
                      ASL_PATTERN,'#?',
                      ASL_FUNCFLAGS, flags,
                      ASL_DIR,cmds.bbsLoc,
                      TAG_DONE]

  fr:=AllocAslRequest(ASL_FILEREQUEST,tags)

  IF(AslRequest(fr,0))

    IF(fr.numargs)
      frargs:=fr.arglist

      FOR x:=0 TO fr.numargs-1
        StrCopy(src,fr.drawer)
        AddPart(src,frargs[x].name,100)
        IF s<>NIL THEN StrCopy(s,src)
        IF slines<>NIL THEN slines.add(src)
      ENDFOR
    ELSE
      StrCopy(src,fr.drawer)
      AddPart(src,frargs[x].name,100)
      IF s<>NIL THEN StrCopy(s,src)
      IF slines<>NIL THEN slines.add(src)
    ENDIF
  ENDIF
EXCEPT DO
  IF fr THEN FreeAslRequest(fr)
  IF tags THEN FastDisposeList(tags)
  IF aslbase THEN CloseLibrary(aslbase)
  SELECT exception
    CASE ERR_ASL
      debugLog(LOG_ERROR,'Error: Could not allocate ASL request')
    CASE ERR_KICK
      debugLog(LOG_ERROR,'Error: Requires V37')
    CASE ERR_LIB
      debugLog(LOG_ERROR,'Error: Could not open ASL library')
  ENDSELECT
ENDPROC

PROC aePuts2(string,length,force=FALSE)
  DEF str[1023]:STRING
  DEF str2[1023]:STRING
  DEF cls[1]:STRING
  DEF p
  
  StrCopy(cls,'#')
  cls[0]:=12
  IF length=-1
    IF InStr(string,cls)>=0 THEN lineCount:=0
  ELSE
    IF ((p:=InStr(string,cls))>=0) AND (p<length) THEN lineCount:=0
  ENDIF

  IF ((captureFP<>0) OR (ansiColour=FALSE) OR (bitPlanes<3))
    IF length<>-1 THEN StrCopy(str,string,length) ELSE StrCopy(str,string)
    stripAnsi(str,str2,0,0,ansi)
  ENDIF

  IF (ansiColour=FALSE)
    IF (ioFlags[IOFLAG_SCR_OUT]) THEN conPuts(str2,length,force)
    IF (ioFlags[IOFLAG_SER_OUT]) THEN serPuts(str2,length,FALSE,force)
  ELSE
    IF (ioFlags[IOFLAG_SCR_OUT])
      IF bitPlanes<3 THEN conPuts(str2) ELSE conPuts(string,length,force)
    ENDIF
    IF (ioFlags[IOFLAG_SER_OUT]) THEN serPuts(string,length,FALSE,force)
  ENDIF

  IF captureFP THEN fileWrite(captureFP,str2)
ENDPROC

PROC serPutChar(c)
  DEF str[1]:STRING
  StrCopy(str,' ')
  str[0]:=c
  serPuts(str)
ENDPROC

PROC cacheSerialData(serialData,dataLen)
  IF (serialCache<>NIL)
    AstrCopy(serialCache+serialCacheCurrentSize,serialData,dataLen+1)
    serialCacheCurrentSize:=serialCacheCurrentSize+dataLen
  ENDIF
ENDPROC

PROC flushSerialCache()
  IF (serialWriteIO<>NIL) OR (telnetSocket>=0)
    IF (serialCache<>NIL) AND (serialCacheCurrentSize>0)
      IF telnetSocket>=0
        telnetSend(serialCache,serialCacheCurrentSize)
      ELSE
        serialWriteIO.iostd.command:=CMD_WRITE
        serialWriteIO.iostd.data:=serialCache
        serialWriteIO.iostd.length:=serialCacheCurrentSize
        DoIO(serialWriteIO)
      ENDIF
      serialCacheCurrentSize:=0
      serialCacheLastFlush1,serialCacheLastFlush2:=getSystemTime()
    ENDIF
  ENDIF
ENDPROC

PROC telnetSend(string:PTR TO CHAR, putlen)
  DEF i,c,e
  DEF buf2

  IF binaryRaw
    buf2:=string
    c:=putlen   
  ELSE
    c:=0
    FOR i:=0 TO putlen-1
      IF string[i]=255 THEN c++
    ENDFOR
    buf2:=New(putlen+c)
    c:=0
    FOR i:=0 TO putlen-1
      IF string[i]=255
        buf2[c]:=255
        c++
        buf2[c]:=255
      ELSE
        buf2[c]:=string[i]
      ENDIF
      c++
    ENDFOR
  ENDIF

  IoctlSocket(telnetSocket,FIONBIO,[1])
  i:=Send(telnetSocket,buf2,c,0)
  IF (i<>c)
    e:=Errno()
    IF (((e=EWOULDBLOCK) OR (e=ENOBUFS))=FALSE)
      RETURN
    ELSE
      IF i=-1 THEN i:=0
      c:=c-i
      IoctlSocket(telnetSocket,FIONBIO,[0])
      i:=Send(telnetSocket,buf2+i,c,0)
      IoctlSocket(telnetSocket,FIONBIO,[1])
      IF (i<>c)
        e:=Errno()
      ENDIF
    ENDIF
  ENDIF
  IF binaryRaw=FALSE THEN Dispose(buf2)
ENDPROC

PROC serPuts(string: PTR TO CHAR, putlen=-1,binary=FALSE, force=FALSE)
  DEF actlen,serFlushTime
  DEF tempTime1,tempTime2

  IF (serialWriteIO<>NIL) OR (telnetSocket>=0)
    IF ((transfering=FALSE) AND (doorSilent=FALSE)) OR (force)

      serFlushTime:=0
      IF serialCacheEnabled
        tempTime1,tempTime2:=getSystemTime()

        ->calculate ticks (50ths of a second) since last cache flush
        serFlushTime:=Mul(tempTime1-serialCacheLastFlush1,50)+tempTime2-serialCacheLastFlush2
      ENDIF

      IF binary OR (serialCacheEnabled=FALSE) OR (serFlushTime>10) OR (serialCache=NIL) OR (slowmo)
        flushSerialCache()       
        IF binary AND (putlen=-1)
          debugLog(LOG_ERROR,'unsized binary write')
        ENDIF
        
        IF slowmo THEN slowmoSerPuts2(string,putlen) ELSE serPuts2(string,putlen)       
        ->IF error THEN debugLog(LOG_ERROR,'serial write error: \d',error)
      ELSE
        actlen:=StrLen(string)
        IF (putlen=-1) OR (actlen<putlen) THEN putlen:=actlen
        IF ((serialCacheCurrentSize+putlen)>serialCacheSize) THEN flushSerialCache()
        IF (putlen>=serialCacheSize)
          serPuts2(string,putlen)
        ELSE
          cacheSerialData(string,putlen)
        ENDIF
      ENDIF
    ENDIF
  ENDIF
ENDPROC

PROC slowmoSerPuts2(string: PTR TO CHAR, putlen)
  DEF l,p,signals,timersig
  
  IF putlen=-1 THEN putlen:=StrLen(string)
  p:=0
  l:=60*(slowmo)
  openTimer()
  WHILE p<putlen
    IF p+l>putlen THEN l:=putlen-p
      
    serPuts2(string+p,l)
    slowmoCount:=slowmoCount-l
    IF slowmoCount<=0
      setTimer(0,10000)
      IF timerport<>NIL THEN timersig:=Shl(1, timerport.sigbit)
      signals:=Wait(SIGBREAKF_CTRL_C OR timersig)
      IF (signals AND timersig)=0
        stopTime()
      ELSE
        waitTime()
      ENDIF
      slowmoCount:=slowmoCount+(60*slowmo)
    ENDIF
    p:=p+l
  ENDWHILE
  closeTimer()
ENDPROC

PROC serPuts2(string: PTR TO CHAR, putlen)
  IF telnetSocket>=0
    IF putlen=-1 THEN putlen:=StrLen(string)
  
    telnetSend(string,putlen)
  ELSE
    serialWriteIO.iostd.command:=CMD_WRITE
    serialWriteIO.iostd.data:=string
    serialWriteIO.iostd.length:=putlen  -> use -1 for print until terminating NIL
    DoIO(serialWriteIO)
  ENDIF
ENDPROC

PROC conPutChar(c)
  DEF str[1]:STRING
  StrCopy(str,' ')
  str[0]:=c
  conPuts(str)
ENDPROC

PROC conCursorOn() IS conPuts('[ p')
PROC conCursorOff() IS conPuts('[0 p')

-> Output a NIL-terminated string of characters to a console.
PROC conPuts(string, putlen=-1, force=FALSE)
  DEF actlen
  IF (consoleIO<>NIL) AND (((transfering=FALSE) AND (doorSilent=FALSE)) OR (force))
    IF (actlen:=StrLen(string))<putlen THEN putlen:=actlen
    consoleIO.command:=CMD_WRITE
    consoleIO.data:=string
    consoleIO.length:=putlen  -> use -1 for print until terminating NIL
    DoIO(consoleIO)
  ENDIF
ENDPROC

PROC checkCon()
  IF (consoleReadIO=NIL) OR (transfering) OR (doorSilent) THEN RETURN FALSE
ENDPROC CheckIO(consoleReadIO)

PROC checkSer()
  IF (serialReadIO=NIL) OR (transfering) OR (doorSilent) THEN RETURN FALSE
ENDPROC CheckIO(serialReadIO)

PROC lineReset()
  IF serialReadIO<>NIL
    serialReadIO.iostd.command:=CMD_RESET
    DoIO(serialReadIO)
    serialReadIO.iostd.command:=CMD_READ
    SendIO(serialReadIO)
  ENDIF
ENDPROC

PROC purgeLineEnd()
  DEF result

  IF (transfering=FALSE) AND (doorSilent=FALSE)
    IF (serialReadIO<>NIL)
      result:=CheckIO(serialReadIO)
      IF(result=FALSE)
        AbortIO(serialReadIO)
      ENDIF
      WaitIO(serialReadIO)
      serialReadIO.iostd.command:=CMD_CLEAR
      DoIO(serialReadIO)
    ENDIF
    IF telnetSocket>=0 THEN purgeTelnet()
  ENDIF
ENDPROC

PROC purgeLineStart()
  IF (serialReadIO<>NIL) AND (transfering=FALSE) AND (doorSilent=FALSE)
    serialReadIO.iostd.command:=CMD_CLEAR
    DoIO(serialReadIO);
    queueSerialRead({serbuff})
  ENDIF
ENDPROC

PROC purgeLine()
  IF (transfering=FALSE) AND (doorSilent=FALSE)
    IF (serialReadIO<>NIL)
      AbortIO(serialReadIO)
      WaitIO(serialReadIO)
      serialReadIO.iostd.command:=CMD_CLEAR
      DoIO(serialReadIO)
      queueSerialRead({serbuff})
    ENDIF
    IF telnetSocket>=0 THEN purgeTelnet()
  ENDIF
ENDPROC

PROC purgeTelnet()
  DEF data,tot,n
  DEF buff[4096]:ARRAY OF CHAR

  data,tot:=checkTelnetData()
  n:=4096
  WHILE (tot>0)
    IF tot<4096 THEN n:=tot
    IoctlSocket(telnetSocket,FIONBIO,[1])
    n:=Recv(telnetSocket,buff,n,0)
    IF n>0 THEN tot:=tot-n ELSE tot:=0
  ENDWHILE
ENDPROC
PROC checkCarrier()
  DEF stat,stat2=0
  DEF temp[255]:STRING
  stat:=1

  IF serShared THEN RETURN 0

  IF telnetSocket>=0
    stat2:=Recv(telnetSocket,temp,1,MSG_PEEK)
    IF stat2<>1
      stat:=0
      stat2:=Errno()
      IF (stat2 <> EINTR) AND (stat2<>EWOULDBLOCK) THEN stat:=1
    ELSE
      stat:=0
    ENDIF
  ELSEIF(serialWriteIO<>NIL)
    serialWriteIO.iostd.command:=SDCMD_QUERY
    stat2:=DoIO(serialWriteIO)
    stat:=serialWriteIO.status AND CIAF_COMCD
    serialWriteIO.iostd.command:=CMD_WRITE
    IF(sopt.a2232<>0)
      IF((serialWriteIO.status<>0) AND (stat=FALSE))
        IF checkToolTypeExists(TOOLTYPE_NODE,node,'TRAP_SERIAL')
          StringF(temp,'Serial Error \d',serialWriteIO.status)
          errorLog(temp)
        ENDIF
        lineReset()
      ENDIF
    ENDIF
  ELSE
    RETURN 1
  ENDIF

  IF stat
    lostCarrier:=TRUE
    RETURN FALSE
  ELSE
    RETURN TRUE
  ENDIF
ENDPROC

PROC getSigs()
  DEF sigs=0
  IF windowClose<>NIL
    sigs:=sigs OR Shl(1, windowClose.userport.sigbit)
  ELSEIF window<>NIL
    sigs:=sigs OR Shl(1, window.userport.sigbit)
  ENDIF

  sigs:=sigs OR cxsigflag

  IF resmp<>NIL THEN sigs:=sigs OR Shl(1,resmp.sigbit)
ENDPROC sigs

PROC processMessages()
  checkDoorMsg(0)
  IF servercmd=SV_UNICONIFY
    servercmd:=-1
    IF scropen THEN expressToFront() ELSE openExpressScreen()
  ENDIF
  
  processWindowMessage(-1)
  processCommodityMessage(-1)
ENDPROC

PROC checkInput()
  processMessages()
  IF(logonType>=LOGON_TYPE_REMOTE)
    IF(checkCarrier()=FALSE) THEN RETURN TRUE
  ENDIF 
ENDPROC ((checkCon() OR checkSer() OR checkTelnetData()))

PROC checkScreenClear()
  IF((loggedOnUserKeys.userFlags AND USER_SCRNCLR))
    sendCLS()
    RETURN TRUE
  ENDIF
ENDPROC FALSE

PROC sCheckInput()
  DEF result1=0,result2=0,result3=0

  IF(consoleReadIO) AND (ioFlags[IOFLAG_KBD_IN]) THEN result1:=CheckIO(consoleReadIO)
  IF(serialReadIO) AND (ioFlags[IOFLAG_SER_IN]) THEN result2:=CheckIO(serialReadIO)
  IF(telnetSocket>=0) AND (ioFlags[IOFLAG_SER_IN]) THEN result3:=checkTelnetData()
ENDPROC result1 OR result2 OR result3

PROC countMsgBases()
  DEF count=0
  DEF num,i
  
  FOR i:=1 TO cmds.numConf
    num:=getConfMsgBaseCount(i)
    count:=count+num
  ENDFOR
ENDPROC count

PROC getConfIndex(confNum,msgBaseNum)
  DEF index=0
  DEF num=1,i
  FOR i:=1 TO confNum-1
    num:=getConfMsgBaseCount(i)
    index:=index+num
  ENDFOR
  index:=index+msgBaseNum-1
ENDPROC index

PROC getConfMsgBaseCount(confNum)
  DEF num
  num:=readToolTypeInt(TOOLTYPE_MSGBASE,confNum,'NMSGBASES') 
  IF num=-1 THEN num:=1 
ENDPROC num

PROC getMsgBaseName(confNum,msgBaseNum,outMsgBaseNameString)
  DEF tempStr[255]:STRING
  StringF(tempStr,'NAME.\d',msgBaseNum)
  StrCopy(outMsgBaseNameString,'')
  readToolType(TOOLTYPE_MSGBASE,confNum,tempStr,outMsgBaseNameString)
ENDPROC

PROC getMsgBaseLocation(confNum,msgBaseNum,outMsgBaseLocationString)
  DEF toolTypeName[100]:STRING
  DEF location[255]:STRING
  DEF num
  
  num:=readToolTypeInt(TOOLTYPE_MSGBASE,confNum,'NMSGBASES') 
  IF (msgBaseNum>num) OR (msgBaseNum<1) OR (num=-1)
    StringF(outMsgBaseLocationString,'\sMsgBase/',getConfLocation(confNum))
    checkPathSlash(outMsgBaseLocationString)
    RETURN
  ENDIF
  StringF(toolTypeName,'LOCATION.\d',msgBaseNum)
  readToolType(TOOLTYPE_MSGBASE,confNum,toolTypeName,location)

  ->if the location has a colon then we presume its a full path, otherwise we assume its relative to the conf location
  IF (InStr(location,':')>=0)
    StrCopy(outMsgBaseLocationString,location)
  ELSE
    StringF(outMsgBaseLocationString,'\s\s',getConfLocation(confNum),location)
  ENDIF
  checkPathSlash(outMsgBaseLocationString)
ENDPROC

PROC getConfLocation(confNum,outConfLocationString=NIL)
  IF outConfLocationString<>NIL THEN StrCopy(outConfLocationString,confDirs.item(confNum-1))
ENDPROC confDirs.item(confNum-1)

PROC setConfLocation(confNum,newconfLocation)
  DEF p : PTR TO CHAR
  DEF tempstr[255]:STRING

  StrCopy(tempstr,newconfLocation)
  checkPathSlash(tempstr)
  
  confDirs.setItem(confNum-1,tempstr)
  IF confNum<11
    p:=cmds.conf1Loc
    AstrCopy(p+((confNum-1)*60),tempstr)
  ENDIF
ENDPROC

PROC getConfDbFileName(confNum,msgBaseNum,outConfDbFile)
  DEF cn
  cn:=readToolTypeInt(TOOLTYPE_CONF,confNum,'CONFDB_SHARED')
  IF cn<>-1 THEN confNum:=cn
  IF getConfMsgBaseCount(confNum)>1
    getMsgBaseLocation(confNum,msgBaseNum,outConfDbFile)
  ELSE
    getConfLocation(confNum,outConfDbFile)
  ENDIF
  StrAdd(outConfDbFile,confDBName)
ENDPROC

PROC getConfName(confNum,outConfNameString=NIL)
  IF outConfNameString<>NIL THEN StrCopy(outConfNameString,confNames.item(confNum-1))
ENDPROC confNames.item(confNum-1)

PROC setConfName(confNum,newConfName)
  DEF p : PTR TO CHAR

  confNames.setItem(confNum-1,newConfName)
  IF confNum<11
    p:=cmds.conf1Name

    AstrCopy(p+((confNum-1)*60),newConfName)
  ENDIF
ENDPROC

PROC yesNo(flag)
  DEF ch

  IF(flag)
    IF(flag=2)
      aePuts('[32m([33my[32m/[33mN[32m)[32m?[0m ')
    ELSE
      aePuts('[32m([33mY[32m/[33mn[32m)[32m?[0m ')
    ENDIF
  ENDIF

  LOOP
    ch:=readChar(INPUT_TIMEOUT)
    IF(ch<0) THEN RETURN ch
    IF(ch=13)     ->  removed ((ch=13) OR (ch=10))
      IF(flag=1) THEN ch:="y"
      IF(flag=2) THEN ch:="n"
    ENDIF
    IF((ch="y") OR (ch="Y"))
      aePuts('Yes\b\n')
      RETURN 1
    ENDIF
    IF((ch="n") OR  (ch="N"))
      aePuts('No\b\n')
      RETURN 0
    ENDIF
  ENDLOOP
ENDPROC

PROC addToHistory(text)
  IF historyBuf.count()<20
    historyNum:=historyBuf.add(text)
    historyCycle:=historyNum
  ELSE
    historyBuf.setItem(historyNum,text)
    historyCycle:=historyNum
    historyNum++
    IF historyNum>=historyBuf.count() THEN historyNum:=0
  ENDIF
ENDPROC

PROC lineInput(promptText,defaultOutput,maxLen,timeout,outputString,allowHistory=TRUE)
  DEF result
  DEF wasControl,ch
  DEF cmdCharString[1]:STRING
  DEF timedout, i,originalTimeout,curpos
  DEF tempstr[255]:STRING
  DEF warning=FALSE

  IF StrLen(promptText)>0
    aePuts(promptText)
  ENDIF

  lineCount:=0

  ->no timeout tooltype overrides normal input timeouts
  IF (sopt.toggles[TOGGLES_NOTIMEOUT]) OR checkSecurity(ACS_NO_TIMEOUT)
    timeout:=0
  ELSEIF timeoutOverride<>-1
    timeout:=timeoutOverride
  ENDIF

  IF ftpConn AND (timeout=0) THEN timeout:=300

  IF (timeout<120) OR ftpConn
    warning:=TRUE
  ELSE
    timeout:=timeout-60
  ENDIF
  originalTimeout:=timeout

  result:=RESULT_TIMEOUT

  StrCopy(outputString,defaultOutput)
  aePuts(outputString)
  curpos:=StrLen(outputString)

  conCursorOn()
    
    REPEAT
redoinput:
      wasControl,ch:=processInputMessage(timeout)
      IF (ch=RESULT_ABORT) OR (ch=RESULT_NO_CARRIER)
      StrCopy(outputString,'')
        result:=ch
        ch:=RESULT_ABORT
      ENDIF

      timedout:=(ch=RESULT_TIMEOUT)
      IF ftpConn
        IF (ch>31) AND (EstrLen(outputString)<maxLen)
          StrCopy(tempstr,'')
          StrAddChar(outputString,ch)
        ENDIF
      ELSE
        IF timedout AND (warning=FALSE)
          sendBELL()
          timeout:=60
          timedout:=FALSE
          warning:=TRUE
          JUMP redoinput
        ENDIF

        IF timedout=FALSE
          warning:=FALSE
          timeout:=originalTimeout
          IF (allowHistory) AND (ch=2) AND (wasControl=0)  -> CTRL B
            historyBuf.clear()
            historyNum:=0
            historyCycle:=0
            wasControl:=TRUE
          ENDIF

          IF (ch=24) AND (wasControl=0)   -> CTRL X
            StrCopy(tempstr,'')
            FOR i:=curpos TO StrLen(outputString)-1
              StrAdd(tempstr,'[1C')
            ENDFOR
            FOR i:=1 TO StrLen(outputString)
              StrAddChar(tempstr,8)
              StrAdd(tempstr,' ')
              StrAddChar(tempstr,8)
            ENDFOR
            aePuts(tempstr)
            StrCopy(outputString,'')
            curpos:=0
          ENDIF

          IF (rawArrow=FALSE)
            IF (allowHistory) AND (ch=UPARROW) AND (historyBuf.count()>0)
              StrCopy(tempstr,'')
              FOR i:=curpos TO StrLen(outputString)-1
                StrAdd(tempstr,'[1C')
              ENDFOR
              FOR i:=1 TO StrLen(outputString)
                StrAddChar(tempstr,8)
                StrAdd(tempstr,' ')
                StrAddChar(tempstr,8)
              ENDFOR
              StrCopy(outputString,historyBuf.item(historyCycle),maxLen)
              historyCycle--
              IF historyCycle<0 THEN historyCycle:=historyBuf.count()-1
              aePuts(tempstr)
              aePuts(outputString)
              curpos:=StrLen(outputString)
            ENDIF
            IF (allowHistory) AND (ch=DOWNARROW) AND (historyBuf.count()>0)
              StrCopy(tempstr,'')
              FOR i:=curpos TO StrLen(outputString)-1
                StrAdd(tempstr,'[1C')
              ENDFOR
              FOR i:=1 TO StrLen(outputString)
                StrAddChar(tempstr,8)
                StrAdd(tempstr,' ')
                StrAddChar(tempstr,8)
              ENDFOR
              StrCopy(outputString,historyBuf.item(historyCycle),maxLen)
              historyCycle++
              IF historyCycle>=historyBuf.count() THEN historyCycle:=0
              aePuts(tempstr)
              aePuts(outputString)
              curpos:=StrLen(outputString)
              ENDIF
              IF ((ch=LEFTARROW) AND (curpos>0))
                curpos--
                aePuts('[1D')
              ENDIF
              IF ((ch=RIGHTARROW) AND (curpos<(StrLen(outputString))))
                curpos++
                aePuts('[1C')
              ENDIF
            ENDIF

          IF (wasControl=FALSE)
            cmdCharString[0]:=ch
            IF (ch=CHAR_BACKSPACE)
            StrCopy(tempstr,'')
              IF curpos>0
                StrAddChar(tempstr,ch)
                curpos--
                FOR i:=curpos TO StrLen(outputString)-2
                  outputString[i]:=outputString[i+1]
                  StrAddChar(tempstr,outputString[i+1])
                ENDFOR
                StrAdd(tempstr,' ')
                FOR i:=curpos TO StrLen(outputString)-1
                  StrAdd(tempstr,'[1D')
                ENDFOR

                SetStr(outputString,EstrLen(outputString)-1)
                aePuts(tempstr)
              ENDIF
            ELSEIF (ch=CHAR_DELETE)
            StrCopy(tempstr,'')
            IF curpos<(StrLen(outputString))
              FOR i:=curpos TO StrLen(outputString)-2
                outputString[i]:=outputString[i+1]
                StrAddChar(tempstr,outputString[i+1])
              ENDFOR
              StrAdd(tempstr,' ')
              FOR i:=curpos TO StrLen(outputString)-1
                StrAdd(tempstr,'[1D')
              ENDFOR
              SetStr(outputString,EstrLen(outputString)-1)
              aePuts(tempstr)
            ENDIF
          ELSEIF (ch>31) AND (EstrLen(outputString)<maxLen)
            StrCopy(tempstr,'')
            StrAdd(outputString,'#')
            FOR i:=StrLen(outputString)-1 TO curpos+1 STEP -1
              outputString[i]:=outputString[i-1]
            ENDFOR
            outputString[curpos]:=ch
            aePuts(cmdCharString)
            curpos++
            FOR i:=curpos TO StrLen(outputString)-1
              StrAddChar(tempstr,outputString[i])
            ENDFOR
            FOR i:=curpos TO StrLen(outputString)-1
              StrAdd(tempstr,'[1D')
            ENDFOR
            aePuts(tempstr)
            ENDIF
          ENDIF
        ENDIF
      ENDIF
    UNTIL (ch=13) OR (ch=RESULT_ABORT) OR (timedout) OR (reqState<>REQ_STATE_NONE)

  conCursorOff()

  IF ch=13 THEN result:=RESULT_SUCCESS
  IF (result=RESULT_SUCCESS) AND (StrLen(outputString)>0) AND (allowHistory)
    addToHistory(outputString)
    IF inputLogging
      StringF(tempstr,'\tUser Input: \s',outputString)
      callersLog(tempstr)
    ENDIF
  ENDIF

  IF (captureFP)
    fileWriteLn(captureFP,outputString)
  ENDIF

  IF result=RESULT_TIMEOUT
    callersLog('\t**Input timed out **')
    StringF(tempstr,'input timeout - state=\d',state)
    debugLog(LOG_DEBUG,tempstr)
  ENDIF

  IF ftpConn=FALSE THEN aePuts('\b\n')
  flushSerialCache()
ENDPROC result

PROC readMayGetChar(msgport, checkTelnet, whereto)
  DEF temp, readreq:PTR TO iostd
  temp:=0
  
  IF checkTelnet AND (telnetSocket>=0)
    IF Recv(telnetSocket,whereto,1,0)=1   
      temp:=whereto[]
      IF (lastIAC=0) AND (temp=255)
        lastIAC:=1
        temp:=0
      ELSEIF lastIAC=5
        ->poosible end of SB stream
        IF temp=240
          ->return to normal
          lastIAC:=0
        ELSE
          ->continue SB stream
          lastIAC:=4
        ENDIF
        temp:=0
      ELSEIF lastIAC=4
        ->SB stream ends with 255,240
        IF nawsMode
          IF nawsMode=2 THEN userLineLen:=(userLineLen AND $ff) OR (Shl(temp,8))
          IF nawsMode=1
            userLineLen:=((userLineLen AND $ff00) OR temp)-1
            IF userLineLen<10 THEN userLineLen:=10
          ENDIF
          nawsMode--
        ELSEIF (temp=255)
          lastIAC:=5
        ENDIF
        temp:=0
      ELSEIF lastIAC=3
        ->SB mode processing
        IF temp=31
          ->SB NAWS
          nawsMode:=4
        ENDIF
        lastIAC:=4
        temp:=0
      ELSEIF lastIAC=1
        ->IAC(255) should be followed by command code 250-255
        IF temp=255
          ->IAC 255 sends code 255
          lastIAC:=0
        ELSEIF (temp=250)
          ->IAC SB
          lastIAC:=3
          temp:=0
        ELSEIF (temp>250) AND (temp<255)
          ->IAC DO/DONT/WILL/WONT
          lastIAC:=2
          temp:=0
        ELSE 
          ->return to normal mode
          lastIAC:=0
          temp:=0
        ENDIF
      ELSEIF lastIAC=2
        ->ignore DO/DONT/WILL/WONT parameter code and then return to normal mode
        lastIAC:=0
        temp:=0
      ELSE
        lastIAC:=0
      ENDIF
        
    ENDIF
  ELSE  
    IF NIL=(readreq:=GetMsg(msgport)) THEN RETURN -1
    temp:=whereto[]  -> Get the character...
    IF checkTelnet THEN queueSerialRead(whereto) ELSE queueConsoleRead(whereto) -> ...then re-use the request block
  ENDIF
ENDPROC temp

PROC queueHydraConsoleRead(whereto,bsize=1)
  IF hydraConsoleReadIO=NIL THEN RETURN FALSE
  hydraConsoleReadIO.command:=CMD_READ
  hydraConsoleReadIO.data:=whereto
  hydraConsoleReadIO.length:=bsize
  SendIO(hydraConsoleReadIO)
ENDPROC TRUE

-> Queue up a read request to console, passing it pointer to a buffer into
-> which it can read the character
PROC queueConsoleRead(whereto,bsize=1)
  IF consoleReadIO=NIL THEN RETURN FALSE
  consoleReadIO.command:=CMD_READ
  consoleReadIO.data:=whereto
  consoleReadIO.length:=bsize
  SendIO(consoleReadIO)
ENDPROC TRUE

PROC queueSerialRead(whereto,bsize=1)
  IF readQueued THEN stopSerialRead()
  IF serialReadIO=NIL THEN RETURN FALSE
  serialReadIO.iostd.command:=CMD_READ
  serialReadIO.iostd.data:=whereto
  serialReadIO.iostd.length:=bsize
  SetSignal(0,Shl(1, serialReadMP.sigbit))
  SendIO(serialReadIO)
  readQueued:=TRUE
ENDPROC TRUE

PROC loadTranslator(translator:PTR TO translator,fileName)
  DEF fh
  DEF intxt:PTR TO CHAR
  DEF outtxt:PTR TO CHAR

  DEF workMem
  DEF counts[27]:ARRAY OF LONG
  DEF indexes[27]:ARRAY OF LONG
  DEF i,j,n,cnt,fsize
  DEF wordList:PTR TO LONG

  DEF tempstr1[255]:STRING
  DEF tempstr2[255]:STRING
  DEF tempstr3[255]:STRING

  fsize:=FileLength(fileName)
  translator.translationText:=New(fsize+4)     ->allocate some memory, two extra bytes for ending colon and space and some in case there is no newline
  workMem:=New(fsize+2)     ->allocate some memory (two extra bytes in case there is no newline at the end of the file)
  fh:=Open(fileName,MODE_OLDFILE)
  IF fh<>0

    FOR i:=0 TO 26
      counts[i]:=0
    ENDFOR

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
      ListAddItem(wordList,outtxt)
      outtxt:=outtxt+StrLen(outtxt)+1
      outtxt:=outtxt+StrLen(outtxt)+1
    ENDFOR

    outtxt:=translator.translationText
    FOR i:=0 TO 26
      translator.translationIndexes[i]:=outtxt
      wordList:=indexes[i]
      FOR j:=0 TO ListLen(wordList)-1
        intxt:=ListItem(wordList,j)
        StrCopy(tempstr1,intxt)
        intxt:=intxt+StrLen(intxt)+1
        StrCopy(tempstr2,intxt)
        intxt:=intxt+StrLen(intxt)+1

        StringF(tempstr3,':\s \s',tempstr1,tempstr2)
        AstrCopy(outtxt,tempstr3,513)
        outtxt:=outtxt+StrLen(outtxt)
      ENDFOR
    ENDFOR
    translator.translationIndexes[27]:=outtxt
    AstrCopy(outtxt,': ',3)

    FOR i:=0 TO 26
      DisposeLink(indexes[i])
    ENDFOR
  ELSE
     callersLog('\tError Reading Translation file \s',fileName)

     Dispose(translator.translationText)
     translator.translationText:=NIL
  ENDIF
  Dispose(workMem)
ENDPROC

PROC loadTranslators()
  DEF baseLang[255]:STRING
  DEF fileName[255]:STRING
  DEF translatorName[80]:STRING
  DEF languageName[40]:STRING
  DEF trans1: PTR TO translator
  DEF trans2: PTR TO translator
  DEF temp

  unloadTranslators()

  IF readToolType(TOOLTYPE_BBSCONFIG,'','LANGUAGE_BASE',baseLang)
    managedTranslators:=TRUE
    trans1:=NIL
    trans2:=NIL
    checkPathSlash(baseLang)

    temp:=1
    StringF(languageName,'LANGUAGE.\d',temp)
    WHILE readToolType(TOOLTYPE_LANGUAGES,'',languageName,languageName)

      IF StrCmp(languageName,hostLanguage)=FALSE
        StringF(translatorName,'\s\s',hostLanguage,languageName)
        StringF(fileName,'\s\s.TRN',baseLang,translatorName)
        IF fileExists(fileName)
          trans1:=NEW trans1
          trans1.translationText:=NIL
          AstrCopy(trans1.translatorName,translatorName,80)
          loadTranslator(trans1,fileName)
          IF trans2=NIL
            translators:=trans1
          ELSE
            trans1.trans.pred:=trans2
            trans1.trans.succ:=NIL
            trans2.trans.succ:=trans1
          ENDIF
          trans2:=trans1
        ENDIF

        StringF(translatorName,'\s\s',languageName,hostLanguage)
        StringF(fileName,'\s\s.TRN',baseLang,translatorName)
        IF fileExists(fileName)
          trans1:=NEW trans1
          AstrCopy(trans1.translatorName,translatorName,80)
          loadTranslator(trans1,fileName)

          IF trans2=NIL
            translators:=trans1
          ELSE
            trans1.trans.pred:=trans2
            trans1.trans.succ:=NIL
            trans2.trans.succ:=trans1
          ENDIF
          trans2:=trans1

        ENDIF
      ENDIF
      temp++
      StringF(languageName,'LANGUAGE.\d',temp)
    ENDWHILE

  ENDIF
ENDPROC

PROC unloadTranslators()
  DEF transptr:PTR TO mln
  DEF transptr2:PTR TO translator

  IF managedTranslators AND (translators<>NIL)
    transptr:=translators
    REPEAT
      transptr2:=transptr
      transptr:=transptr2.trans.succ    ->get ptr to next translation object
      IF transptr2.translationText<>NIL
        Dispose(transptr2.translationText) ->free the text for this object
      ENDIF
      END transptr2 ->free this object
    UNTIL transptr=NIL
    translators:=NIL
  ENDIF
  managedTranslators:=FALSE
ENDPROC

PROC loadHistory()
  DEF fh
  DEF fname[255]:STRING
  DEF tempstr[255]:STRING

  StringF(fname,'\shistory\d',historyFolder,loggedOnUser.slotNumber)
  IF(fh:=Open(fname,MODE_OLDFILE))<>0
    ReadStr(fh,tempstr)
    historyNum:=Val(tempstr)
    ReadStr(fh,tempstr)
    historyCycle:=Val(tempstr)

    historyBuf.clear()

    WHILE(ReadStr(fh,tempstr)<>-1) OR (StrLen(tempstr)>0)
      historyBuf.add(tempstr)
    ENDWHILE
    Close(fh)
  ENDIF
ENDPROC

PROC saveHistory()
  DEF fh,i,lock
  DEF fname[255]:STRING
  DEF tempstr[255]:STRING

  IF(lock:=CreateDir(historyFolder))
    UnLock(lock)
  ENDIF

  StringF(fname,'\shistory\d',historyFolder,loggedOnUser.slotNumber)
  IF(fh:=Open(fname,MODE_NEWFILE))<>0
    StringF(tempstr,'\d',historyNum)
    fileWriteLn(fh,tempstr)
    StringF(tempstr,'\d',historyCycle)
    fileWriteLn(fh,tempstr)
    FOR i:=0 TO historyBuf.count()-1
      fileWriteLn(fh,historyBuf.item(i))
    ENDFOR
    Close(fh)
  ENDIF
ENDPROC

/* adds a new flagFileItem populated with the filename & conf passed in to the specified list */
PROC addFlagItem(list:PTR TO stdlist,confNum,fileName)
  DEF item:PTR TO flagFileItem

  item:=NEW item
  item.fileName:=String(StrLen(fileName))
  fullTrim(fileName,item.fileName)
  item.confNum:=confNum
  list.add(item)
ENDPROC

/* adds new flagFileItems populated with the filename & conf passed in to the specified list from the space delimited list of filenames */
PROC addFlagItems(list:PTR TO stdlist,confNum,fileNames)
  DEF fname[255]:STRING
  DEF i

  StrCopy(fname,'')
  FOR i:=0 TO EstrLen(fileNames)-1
    IF (fileNames[i]=" ")
      IF EstrLen(fname)>0
        addFlagItem(list,confNum,fname)
        StrCopy(fname,'')
      ENDIF
    ELSE
      StrAdd(fname,fileNames+i,1)
    ENDIF
  ENDFOR
  IF (EstrLen(fname)>0)
    addFlagItem(list,confNum,fname)
  ENDIF
ENDPROC

/*clears out the specified list of flagFileItems */
PROC clearFlagItems(list:PTR TO stdlist)
  DEF item:PTR TO flagFileItem
  DEF i

  FOR i:=0 TO list.count()-1
    item:=list.item(i)
    DisposeLink(item.fileName)
    END item
  ENDFOR
  list.clear()
ENDPROC

PROC loadFlagged()
  DEF fh
  DEF data[2048]:STRING
  DEF conf,len
  DEF fname[255]:STRING

  IF ownPartFiles
    StringF(fname,'\sPartdownload/dump\d-\d',cmds.bbsLoc,node,loggedOnUser.slotNumber)
  ELSE
    StringF(fname,'\sPartdownload/dump\d',cmds.bbsLoc,loggedOnUser.slotNumber)
  ENDIF

  IF (fh:=Open(fname,MODE_OLDFILE))<>0
    ReadStr(fh,data)

    addFlagItems(flagFilesList,-1,data)

    Close(fh)
  ENDIF

  IF ownPartFiles
    StringF(fname,'\sPartdownload/flagged\d-\d',cmds.bbsLoc,node,loggedOnUser.slotNumber)
  ELSE
    StringF(fname,'\sPartdownload/flagged\d',cmds.bbsLoc,loggedOnUser.slotNumber)
  ENDIF

  IF (fh:=Open(fname,MODE_OLDFILE))<>0
    WHILE(ReadStr(fh,data)<>-1) OR (StrLen(data)>0)
      conf:=Val(data,{len})
      addFlagItem(flagFilesList,conf,data+len+1)
    ENDWHILE
    Close(fh)
  ENDIF

  IF flagFilesList.count()>0
    aePuts('\b\n** Flagged File(s) Exist **\b\n')
    sendBELL()
  ENDIF

ENDPROC

PROC saveFlagged()
  DEF fh,i
  DEF fname[255]:STRING
  DEF item:PTR TO flagFileItem

  aePuts('\b\n** AutoSaving File Flags **\b\n')
  sendBELL()

  IF ownPartFiles
    StringF(fname,'\sPartdownload/dump\d-\d',cmds.bbsLoc,node,loggedOnUser.slotNumber)
    DeleteFile(fname)
    StringF(fname,'\sPartdownload/flagged\d-\d',cmds.bbsLoc,node,loggedOnUser.slotNumber)
    DeleteFile(fname)
  ELSE
    StringF(fname,'\sPartdownload/dump\d',cmds.bbsLoc,loggedOnUser.slotNumber)
    DeleteFile(fname)
    StringF(fname,'\sPartdownload/flagged\d',cmds.bbsLoc,loggedOnUser.slotNumber)
    DeleteFile(fname)
  ENDIF

  IF(flagFilesList.count())
    IF(fh:=Open(fname,MODE_NEWFILE))<>0
      FOR i:=0 TO flagFilesList.count()-1
        item:=flagFilesList.item(i)
        StringF(fname,'\d \s\n',item.confNum,item.fileName)
        Write(fh,fname,StrLen(fname))
      ENDFOR
      Close(fh)
    ENDIF
  ENDIF
ENDPROC

PROC showFlaggedFiles(maxLen)
  DEF i
  DEF item:PTR TO flagFileItem

  FOR i:=0 TO flagFilesList.count()-1
    IF (maxLen=-1) OR (maxLen>0)
      IF i<>0
        IF (maxLen>0) OR (maxLen=-1)
          aePuts(' ')
          IF maxLen>0 THEN maxLen:=maxLen-1
        ENDIF
      ENDIF
      item:=flagFilesList.item(i)
      IF (maxLen=-1) OR (maxLen>StrLen(item.fileName))
        aePuts(item.fileName)
        IF maxLen<>-1 THEN maxLen:=maxLen-StrLen(item.fileName)
      ELSE
        aePuts2(item.fileName,maxLen)
        maxLen:=0
      ENDIF
    ENDIF
  ENDFOR

ENDPROC

PROC getCallerCount()
  DEF tempStr[255]:STRING
  StringF(tempStr,'\sSystemStats',cmds.bbsLoc)
ENDPROC readIntFromFile(tempStr)

PROC updateCallerNum()
  DEF tempStr[255]:STRING
  StringF(tempStr,'\sSystemStats',cmds.bbsLoc)
  callerNum:=readIntFromFile(tempStr)
  callerNum++
  writeIntToFile(tempStr,callerNum)
ENDPROC

PROC tidyPlayPen()
  DEF tempStr[255]:STRING
  DEF fib:PTR TO fileinfoblock
  DEF fLock,playpenFiles,fh
  DEF olduser=NIL

  IF(StrLen(sopt.ramPen)>0) THEN StrCopy(tempStr,sopt.ramPen) ELSE StringF(tempStr,'\sNode\d/Playpen/',cmds.bbsLoc,node)

  IF((fib:=AllocDosObject(DOS_FIB,NIL)))=NIL THEN RETURN

  /* lock the directory (Playpen or RamPen) */
  IF((fLock:=Lock(tempStr,ACCESS_READ)))=0
    FreeDosObject(DOS_FIB,fib)
    RETURN
  ENDIF

  IF((Examine(fLock,fib)))=0
    UnLock(fLock)
    FreeDosObject(DOS_FIB,fib)
    RETURN
  ENDIF

  playpenFiles:=ExNext(fLock,fib)
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fib)
  
  IF playpenFiles
    olduser:=loggedOnUser
    IF olduser=NIL
      StringF(tempStr,'\snode\d.user',cmds.bbsLoc,node)
      IF(fh:=Open(tempStr,MODE_OLDFILE))<>0
        loggedOnUser:=NEW loggedOnUser
        Read(fh,loggedOnUser,SIZEOF user)     
        getConfLocation(loggedOnUser.confRJoin,currentConfDir)
        checkPathSlash(currentConfDir)
        Close(fh)
      ENDIF
    ENDIF
    
    cleanPlayPen()
    IF (loggedOnUser<>NIL) AND (olduser=NIL)
      END loggedOnUser
      loggedOnUser:=NIL
      StrCopy(currentConfDir,'')
    ENDIF
  ENDIF

ENDPROC

PROC clearUser()
  DEF tempStr[255]:STRING
  StringF(tempStr,'\snode\d.user',cmds.bbsLoc,node)
  SetProtection(tempStr,FIBF_OTR_DELETE)
  DeleteFile(tempStr)

  StringF(tempStr,'\snode\d.userkeys',cmds.bbsLoc,node)
  SetProtection(tempStr,FIBF_OTR_DELETE)
  DeleteFile(tempStr)
ENDPROC

PROC dumpActiveUser(filename: PTR TO CHAR)
  DEF fi
  fi:=Open(filename,MODE_NEWFILE)
  Write(fi,loggedOnUser,SIZEOF user)
  Close(fi)
ENDPROC

PROC createNodeUserFiles()
  DEF tempStr[255]:STRING
  DEF res,fh
  
  StringF(tempStr,'\snode\d.user',cmds.bbsLoc,node)
  IF(fh:=Open(tempStr,MODE_NEWFILE))<>0
    IF(Write(fh,loggedOnUser,SIZEOF user)) THEN res:=1
  ENDIF
  Close(fh)
  /* Write current userkeys information */
  StringF(tempStr,'\snode\d.userkeys',cmds.bbsLoc,node) /* file name */
  IF(fh:=Open(tempStr,MODE_NEWFILE))<>0
    IF(Write(fh,loggedOnUserKeys,SIZEOF userKeys)) THEN res:=1
  ENDIF
  Close(fh)
ENDPROC res

PROC checkUserOnLine(check)
  DEF fh,lock
  DEF error=0,loop
  DEF tempStr[255]:STRING
  DEF tuser:user
  DEF sp:PTR TO singlePort
  DEF status

  IF(check)
    loop:=0
    error:=1
    REPEAT
    IF(loop=node)   THEN loop++

    IF sopt.toggles[TOGGLES_MULTICOM]
      status:=-1
      ObtainSemaphore(masterNode)
      sp:=(masterNode.myNode[loop].s)
      ReleaseSemaphore(masterNode)

      IF sp
        ObtainSemaphore(sp)
        status:=sp.status
        ReleaseSemaphore(sp)
      ENDIF
    ELSE
      status:=0
    ENDIF

    IF (status>=0) AND (status<>ENV_NOTACTIVE) AND (status<>ENV_SHUTDOWN)
      StringF(tempStr,'\snode\d',cmds.bbsLoc,loop)
      IF(lock:=Lock(tempStr,ACCESS_READ))
        UnLock(lock)
        StringF(tempStr,'\snode\d.user',cmds.bbsLoc,loop)
        IF(fh:=Open(tempStr,MODE_OLDFILE))<>0
          IF(Read(fh,tuser,SIZEOF user))
            IF(stringCompare(tuser.name,loggedOnUser.name)=RESULT_SUCCESS)
              error:=0
              lock:=NIL
            ENDIF
          ENDIF
        ENDIF
        Close(fh)
      ENDIF
    ENDIF
    loop++
    UNTIL (lock=NIL) OR (loop=MAX_NODES)
  ELSE
    error:=1
  ENDIF

  IF(error)
    /* Write the current user info to Node%d.user */
    error:=createNodeUserFiles()
  ENDIF

ENDPROC error

PROC findAcsLevel()
  DEF ttfile[255]:STRING,found,level
  level:=loggedOnUser.secStatus/5*5
  REPEAT
    getNodeFile(TOOLTYPE_ACCESS,level,ttfile)
    found:=configFileExists(ttfile)
    IF (found=FALSE) AND (level>0) THEN level:=level-5
  UNTIL (level<=0) OR (found)

  IF (found=FALSE) THEN level:=0
ENDPROC level

PROC higherAccess()
  aePuts('\b\nCommand requires higher access.\b\n')
ENDPROC

PROC iac(s,cmd1,cmd2)
  DEF willwont[3]:ARRAY OF CHAR
  willwont[0]:=255
  willwont[1]:=cmd1
  willwont[2]:=cmd2
  IoctlSocket(s,FIONBIO,[0])
  Send(s,willwont,3,0)
  IoctlSocket(s,FIONBIO,[1])
ENDPROC

PROC telnetConnect(host:PTR TO CHAR,port)
  DEF sa=0:PTR TO sockaddr_in
  DEF addr: LONG
  DEF hostEnt: PTR TO hostent
  DEF tempstr[255]:STRING
  DEF socketLibWasOpen=FALSE
  DEF tv:timeval
  DEF e,n,s,readBuffer:PTR TO CHAR,b
  DEF ibuf:PTR TO CHAR
  DEF done=FALSE
  DEF timeout=10
  DEF tlastIAC=FALSE
  DEF tlastIAC2=FALSE
  DEF tlastIAC3=FALSE
  DEF last
  DEF c,c2,ch
  DEF cmd1,cmd2
  DEF sigs

  IF (socketbase=NIL)
    socketbase:=OpenLibrary('bsdsocket.library', 2)
    IF socketbase=NIL
      aePuts('\b\nUnable to open bsdsocket library.\b\n')
      RETURN
    ENDIF
  ELSE
    socketLibWasOpen:=TRUE
  ENDIF

  IF port=0 THEN port:=23

  hostEnt:=GetHostByName(host)
  IF hostEnt=NIL
    StringF(tempstr,'\b\nUnable to determine IP address for \s.\b\n',host)
    aePuts(tempstr)
    IF socketLibWasOpen=FALSE THEN CloseLibrary(socketbase)
    RETURN
  ENDIF
  
  
  addr:=Long(hostEnt.h_addr_list)
  addr:=Long(addr)

  NEW sa

  sa.sin_len:=SIZEOF sockaddr_in
  sa.sin_family:=2
  sa.sin_port:=port
  sa.sin_addr:=addr

  s:=Socket(AF_INET,SOCK_STREAM,0)
  IF s<0
    END sa
    StringF(tempstr,'\b\nUnable to create socket, error \d .\b\n',Errno())
    aePuts(tempstr)
    IF socketLibWasOpen=FALSE 
      CloseLibrary(socketbase)
      socketbase:=NIL
    ENDIF
    RETURN
  ENDIF
  
  StringF(tempstr,'\b\nTrying \s(\d)...\b\n\b\n',host,port)
  aePuts(tempstr)

  IoctlSocket(s,FIONBIO,[1])
  setSingleFDS(fds,s)

  Connect(s,sa,SIZEOF sockaddr_in)
    
  tv.secs:=timeout
  tv.micro:=0
  
  n:=WaitSelect(s+1,NIL,fds,NIL,tv,NIL)
 
  IF (n<=0)
    END sa
    CloseSocket(s)
    StringF(tempstr,'Unable to connect to \s, timed outa fter \d seconds.\b\n',host,timeout)
    aePuts(tempstr)
    IF socketLibWasOpen=FALSE 
      CloseLibrary(socketbase)
      socketbase:=NIL
    ENDIF
    RETURN
  ENDIF
  
  END sa
  
  StringF(tempstr,'Connected to \s.\b\n',host)
  aePuts(tempstr)
  aePuts('Escape character is ''^]''.\b\n\b\n')

  readBuffer:=New(8193)
  conCursorOn()

  ibuf:=New(255)

  rawArrow:=TRUE
  REPEAT
    sigs:=0
    IF windowClose<>NIL 
      sigs:=sigs OR Shl(1,windowClose.userport.sigbit)
    ELSEIF window<>NIL
      sigs:=sigs OR Shl(1,window.userport.sigbit)
    ENDIF
    IF broker_mp<>NIL THEN sigs:=sigs OR Shl(1,broker_mp.sigbit)
    IF consoleReadMP<>NIL THEN sigs:=sigs OR Shl(1,consoleReadMP.sigbit)
    IF serialReadMP<>NIL THEN sigs:=sigs OR Shl(1,serialReadMP.sigbit)
    IF resmp<>NIL THEN sigs:=sigs OR Shl(1,resmp.sigbit)
    n:=setSingleFDS(fds,s)
    IF telnetSocket>=0 THEN setFDS(fds,telnetSocket)
    tv.secs:=1
    tv.micro:=0
    n:=WaitSelect(Max(s,telnetSocket)+1,fds,NIL,NIL,tv,{sigs})
   
    IF checkInput()
      c:=0
      WHILE (checkInput()) AND (c<100)
        ch:=readChar(1,0,TRUE)
        IF ch>=0
          ibuf[c]:=ch
          IF (ibuf[c]=UPARROW) AND (c<97)
            ibuf[c]:=27
            ibuf[c+1]:="["
            ibuf[c+2]:="A"
            c:=c+2
          ELSEIF (ibuf[c]=DOWNARROW) AND (c<97)
            ibuf[c]:=27
            ibuf[c+1]:="["
            ibuf[c+2]:="B"
            c:=c+2
          ELSEIF (ibuf[c]=RIGHTARROW) AND (c<97)
            ibuf[c]:=27
            ibuf[c+1]:="["
            ibuf[c+2]:="C"
            c:=c+2
          ELSEIF (ibuf[c]=LEFTARROW) AND (c<97)
            ibuf[c]:=27
            ibuf[c+1]:="["
            ibuf[c+2]:="D"
            c:=c+2
          ENDIF
          c++
        ENDIF
      ENDWHILE
      conCursorOn()

      IF (c=1) AND (ibuf[0]=27) OR (ibuf[0]=255)
        done:=TRUE
      ELSE
        Send(s,ibuf,c,0)
      ENDIF
    ENDIF

    b:=Recv(s,readBuffer,8192,0)
    IF b=0
      done:=TRUE
    ELSEIF b=-1
      e:=Errno()
      IF e<>35 THEN done:=TRUE
    ELSEIF b>0
      readBuffer[b]:=0
      ->hexdump(readBuffer,b)
      
      c:=0
      c2:=0
      REPEAT
      
        IF tlastIAC3
          IF (last=$FF) AND (readBuffer[c]=$F0) THEN tlastIAC3:=FALSE
          last:=readBuffer[c]
        ELSEIF tlastIAC2
          cmd2:=readBuffer[c]
          StringF(tempstr,'code: \d',cmd2)
          debugLog(LOG_DEBUG,tempstr)
          ->expecting an IAC parameter byte - just skip it
          tlastIAC2:=FALSE
        ELSEIF (readBuffer[c]=255) OR (tlastIAC)
          IF (tlastIAC=FALSE) THEN c++
          tlastIAC:=FALSE
          IF c>=b
            tlastIAC:=TRUE
          ELSE
            IF readBuffer[c]=255
              readBuffer[c2]:=255
              c2++
            ELSEIF (readBuffer[c]>=250) AND (readBuffer[c]<255)
              cmd1:=readBuffer[c]
              StringF(tempstr,'known iac code: \d',cmd1)
              debugLog(LOG_DEBUG,tempstr)
              c++
              IF (c>=b)
                tlastIAC2:=TRUE
              ELSE
                cmd2:=readBuffer[c]
                StringF(tempstr,'code: \d',cmd2)
                debugLog(LOG_DEBUG,tempstr)
                IF cmd1=$fa 
                  tlastIAC3:=TRUE
                  last:=-1
                ENDIF
                
                IF (cmd1=$fb) AND (cmd2=1) THEN iac(s,$fd,1) ->if will echo then do echo
                IF (cmd1=$fb) AND (cmd2=3) THEN iac(s,$fd,3) ->if will sga then do sga
                IF (cmd1=$fd) OR (cmd1=$fe) THEN iac(s,$fc,cmd2) -> if do or dont then wont
              ENDIF
            ELSE
              StringF(tempstr,'unknown iac code: \d',readBuffer[c])
              debugLog(LOG_DEBUG,tempstr)
            ENDIF
          ENDIF
        ELSE
          readBuffer[c2]:=readBuffer[c]
          c2++
        ENDIF
        c++
        
      UNTIL c>=b
      IF c2>0 THEN aePuts2(readBuffer,c2)
      IF (StrLen(telnetUsername)>0) AND (StrLen(telnetUsernamePrompt)>0)
        IF InStr(readBuffer,telnetUsernamePrompt)>=0
          StringF(tempstr,'\s\b\n',telnetUsername)
          Send(s,tempstr,EstrLen(tempstr),0)
          StrCopy(telnetUsername,'')
        ENDIF
      ENDIF     
      IF (StrLen(telnetPassword)>0) AND (StrLen(telnetPasswordPrompt)>0)
        IF InStr(readBuffer,telnetPasswordPrompt)>=0
          StringF(tempstr,'\s\b\n',telnetPassword)
          Send(s,tempstr,EstrLen(tempstr),0)
          StrCopy(telnetPassword,'')
        ENDIF
      ENDIF
      
    ENDIF
    
    IF((logonType>=LOGON_TYPE_REMOTE) AND (checkCarrier()=FALSE)) THEN done:=TRUE
  UNTIL done
  rawArrow:=FALSE
  
  aePuts('\b\nDisconnected.\b\n')
  Dispose(readBuffer)
  Dispose(ibuf)
  
  CloseSocket(s)
  IF socketLibWasOpen=FALSE 
    CloseLibrary(socketbase)
    socketbase:=NIL
  ENDIF
  
ENDPROC

PROC startProcess(exestring, stacksize, priority, async, doorTrap)
  DEF filetags:PTR TO LONG
  DEF task,temp
  DEF doorTrapFH=0
  DEF processOutFile[255]:STRING

  IF (byteSignExtend(cmds.taskPri)<=priority)
    task:=FindTask(0)
    SetTaskPri(task,priority+1)
  ENDIF


  IF doorTrap
    StringF(processOutFile,'\sNode\d/StartProcess',cmds.bbsLoc,node)

    doorTrapFH:=Open(processOutFile,MODE_NEWFILE)
  ENDIF
  
  filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,doorTrapFH,SYS_ASYNCH,async,NP_STACKSIZE,stacksize,NP_PRIORITY,priority,TAG_DONE]
  temp:=SystemTagList(exestring,filetags)
  FastDisposeList(filetags)
 
  IF (byteSignExtend(cmds.taskPri)<=priority)
    SetTaskPri(task,cmds.taskPri)
  ENDIF

  IF doorTrap
    Close(doorTrapFH)
  ENDIF

ENDPROC

PROC calcSizeText(bcdValue:PTR TO CHAR,outString:PTR TO CHAR)
  DEF i
  DEF tempBCD[8]:ARRAY OF CHAR
  DEF tempBCD2[8]:ARRAY OF CHAR
  i:=0           
  CopyMem(bcdValue,tempBCD,8)
  CopyMem(tempBCD,tempBCD2,8)
  REPEAT
    subBCD(tempBCD,1024)
    IF tempBCD[0]<$50
      addBCD(tempBCD2,512)
      divBCD1024(tempBCD2)
      CopyMem(tempBCD2,tempBCD,8)
      i++
    ENDIF
  UNTIL tempBCD[0]>=$50
  
  formatBCD(tempBCD2,outString)
  SELECT i
    CASE 0
      StrAdd(outString,'b')
    CASE 1
      StrAdd(outString,'kb')
    CASE 2
      StrAdd(outString,'mb')
    CASE 3
      StrAdd(outString,'gb')
    CASE 4
      StrAdd(outString,'tb')
    CASE 5
      StrAdd(outString,'pb')
    DEFAULT
      formatBCD(bcdValue,outString)
  ENDSELECT           
ENDPROC

PROC processXimMsg(msgcmd,msg:PTR TO jhMessage,tooltype,command,privcmd,params,nodesPtr:PTR TO LONG, exitPtr:PTR TO LONG, runOnExit:PTR TO CHAR, runOnExit2:PTR TO CHAR)
  DEF tempstring[255]:STRING
  DEF tempstring2[255]:STRING
  DEF tuserdata:PTR TO user,tuserkeys:PTR TO userKeys, tusermisc: PTR TO userMisc
  DEF i,ch,temp
  
  SELECT MAX_CMD OF msgcmd
    CASE JH_REGISTER
        msg.command:=IF loggedOnUser<>NIL THEN userLineLen ELSE 29
        nodesPtr[]:=nodesPtr[]+1
    CASE JH_WRITE
      IF (transfering=FALSE) AND (doorSilent=FALSE)
        aePuts(msg.string)
      ENDIF
    CASE CHAIN
        nodesPtr[]:=nodesPtr[]-1
    CASE JH_SHUTDOWN
        nodesPtr[]:=nodesPtr[]-1
         IF(nodesPtr[]=0)
            quietDownload:=FALSE
            rawArrow:=FALSE
            exitPtr[]:=TRUE
         ENDIF
    CASE JH_CO
      conPuts(msg.string,-1)
      IF msg.data
        conPuts('\b\n',-1)
        checkForPause()
      ENDIF
    CASE JH_SO
      serPuts(msg.string,-1)
      IF msg.data
        serPuts('\b\n',-1)
      ENDIF
    CASE JH_SM
      aePuts(msg.string)
      IF msg.data
        aePuts('\b\n')
        checkForPause()
      ENDIF
    CASE JH_SMPTR
      aePuts(msg.strptr)
      IF msg.data
        aePuts('\b\n')
        checkForPause()
      ENDIF
    CASE JH_PM
      IF(lineInput(msg.string,'',msg.data,doorTimeout,tempstring)<>RESULT_SUCCESS)
        msg.data:=-1
      ELSE
        msg.data:=1
        AstrCopy(msg.string,tempstring,200)
      ENDIF
    CASE JH_LI
      IF(lineInput('',msg.string,msg.data,doorTimeout,tempstring)<>RESULT_SUCCESS)
        msg.data:=-1
      ELSE
        msg.data:=1
        AstrCopy(msg.string,tempstring,200)
      ENDIF
    CASE JH_ExtHK
        lineCount:=0
        msg.command:=readChar(doorTimeout,Shl(1,msg.signal))
        IF (msg.command<0) THEN msg.data:=-1 ELSE msg.data:=1
    CASE JH_HK
      lineCount:=0
      aePuts(msg.string)
      ch:=readChar(doorTimeout)
      IF (ch<0)
        msg.data:=-1
      ELSE
        msg.data:=1
      ENDIF
      msg.string[0]:=ch
      msg.string[1]:=0
      msg.command:=ximPort /*XIMPort=1 for console,2for serial  */
    CASE JH_20
       ch:=readChar(doorTimeout)
       msg.data:=ch
       msg.command:=ximPort
    CASE QUICK_KEY
       ch:=readChar(doorTimeout)
       msg.data:=ch
       msg.command:=ximPort
    CASE JH_MCI
      StrCopy(tempstring,msg.string)
      processMci(tempstring)
      IF msg.data
        aePuts('\b\n')
        checkForPause()
      ENDIF
    CASE JH_SIGBIT
      msg.data:=doorExtSig
    CASE JH_FetchKey
      IF checkInput()
        msg.command:=readChar(doorTimeout)
        IF (msg.command<0)  THEN msg.data:=-1 ELSE msg.data:=1
      ELSE
        msg.command:=0
        msg.data:=1
      ENDIF
    CASE JH_SG
      IF (findSecurityScreen(msg.string,tempstring)) THEN displayFile(tempstring)
    CASE JH_SF
      displayFile(msg.string)
    CASE JH_EF
      fileattach:=FALSE
      loadMsg(msg.string)
      IF(edit()=RESULT_SUCCESS)
        saveMsg(msg.string)
        msg.data:=1
      ELSE
        msg.data:=-1
      ENDIF
    CASE JH_BBSNAME
      AstrCopy(msg.string,cmds.bbsName,41)
    CASE JH_SYSOP
      AstrCopy(msg.string,cmds.sysopName,41)
    CASE JH_FLAGFILE
       addFlagToList(msg.string)
    CASE RETURNCOMMAND
      StrCopy(runOnExit,msg.string,200)
    CASE DT_NAME
      IF (msg.data)
        AstrCopy(msg.string,loggedOnUser.name,31)
      ELSE
        AstrCopy(loggedOnUser.name,msg.string,31)
      ENDIF
    CASE DT_PASSWORD
      IF (msg.data)
        ->we dont allow doors to grab the password
        AstrCopy(msg.string,'')
      ELSE
        ->calculate the new password hash
        StrCopy(tempstring,msg.string)
        IF StrLen(tempstring)>0 
          setNewPassword(loggedOnUser,loggedOnUserMisc,tempstring)
          loggedOnUserMisc.pwdLastUpdated:=getSystemTime()
        ENDIF
      ENDIF
    CASE DT_LOCATION
      IF (msg.data)
        AstrCopy(msg.string,loggedOnUser.location,30)
      ELSE
        AstrCopy(loggedOnUser.location,msg.string,30)
      ENDIF
    CASE DT_PHONENUMBER
      IF (msg.data)
        AstrCopy(msg.string,loggedOnUser.phoneNumber,13)
      ELSE
        AstrCopy(loggedOnUser.phoneNumber,msg.string,13)
      ENDIF
    CASE DT_SLOTNUMBER
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.slotNumber)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.slotNumber:=Val(msg.string)
      ENDIF
    CASE DT_SECSTATUS
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.secStatus)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.secStatus:=Val(msg.string)
        convertAccess()
      ENDIF
    CASE DT_SECBOARD
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.secBoard)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.secBoard:=Val(msg.string)
      ENDIF
    CASE DT_SECLIBRARY
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.secLibrary)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.secLibrary:=Val(msg.string)
      ENDIF
    CASE DT_SECBULLETIN
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.secBulletin)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.secBulletin:=Val(msg.string)
      ENDIF
    CASE DT_MESSAGESPOSTED
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.messagesPosted AND $FFFF)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.messagesPosted:=Val(msg.string)
      ENDIF
    CASE DT_UPLOADS
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.uploads AND $FFFF)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.uploads:=Val(msg.string)
      ENDIF
    CASE DT_DOWNLOADS
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.downloads AND $FFFF)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.downloads:=Val(msg.string)
      ENDIF
    CASE DT_TIMESCALLED
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.timesCalled AND $FFFF)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.timesCalled:=Val(msg.string)
      ENDIF
    CASE DT_TIMELASTON
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.timeLastOn)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.timeLastOn:=Val(msg.string)
      ENDIF
    CASE DT_TIMEUSED
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.timeUsed)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.timeUsed:=Val(msg.string)
      ENDIF
    CASE DT_TIMELIMIT
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.timeLimit)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.timeLimit:=Val(msg.string)
      ENDIF
    CASE DT_TIMETOTAL
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.timeTotal)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.timeTotal:=Val(msg.string)
      ENDIF
    CASE DT_BYTESUPLOAD
      IF (msg.data)
        formatBCD(loggedOnUserMisc.uploadBytesBCD,tempstring)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        bcdVal(msg.string,loggedOnUserMisc.uploadBytesBCD)
        loggedOnUser.bytesUpload:=convertFromBCD(loggedOnUserMisc.uploadBytesBCD)
      ENDIF
    CASE DT_BYTEDOWNLOAD
      IF (msg.data)
        formatBCD(loggedOnUserMisc.downloadBytesBCD,tempstring)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        bcdVal(msg.string,loggedOnUserMisc.downloadBytesBCD)
        loggedOnUser.bytesDownload:=convertFromBCD(loggedOnUserMisc.downloadBytesBCD)
      ENDIF
    CASE DT_DAILYBYTELIMIT
      IF (msg.data)
        formatUnsignedLong(loggedOnUser.dailyBytesLimit,tempstring)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.dailyBytesLimit:=Val(msg.string)
      ENDIF
    CASE DT_DAILYBYTEDLD
      IF (msg.data)
        formatUnsignedLong(loggedOnUser.dailyBytesDld,tempstring)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.dailyBytesDld:=Val(msg.string)
      ENDIF
    CASE DT_EXPERT
      IF (msg.data)
        StringF(tempstring,'\c',loggedOnUser.expert)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.expert:=msg.string[0]
      ENDIF
    CASE DT_LINELENGTH
      IF (msg.data)
        StringF(tempstring,'\d',userLineLen)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.lineLength:=Val(msg.string)
        userLineLen:=loggedOnUser.lineLength
      ENDIF
    CASE ACTIVE_NODES
        AstrCopy(msg.string,'                                ')
        FOR i:=0 TO MAXNODES-1
          StringF(tempstring,'AmiExpress_Node.\d',i)
          IF FindPort(tempstring) THEN msg.string[i]:="X"
        ENDFOR
    CASE DT_DUMP
      dumpActiveUser(msg.string)
    CASE DT_MSGCODE
      IF(msg.data=1 )
        doormsgcode:=1
      ELSEIF (msg.data=2)
        doormsgcode:=0
      ELSE
        msg.data:=doormsgcode
      ENDIF
    CASE ENVSTAT
        IF(msg.data)
          StringF(tempstring,'\d',currentStat)
          AstrCopy(msg.string,tempstring,10)
        ELSE
          setEnvStat(Val(msg.string))
        ENDIF
    CASE SV_NEWMSG
      setEnvMsg(msg.string)
    CASE DT_TIMEOUT
      IF (msg.data)
        StringF(tempstring,'\d',doorTimeout)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        doorTimeout:=Val(msg.string)
      ENDIF
    CASE BB_CONFNAME
      IF (msg.data)
        StrCopy(tempstring,currentConfName)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        StrCopy(currentConfName,msg.string)
        setConfName(loggedOnUser.confRJoin,msg.string)
      ENDIF
    CASE BB_CONFLOCAL
      IF (msg.data)
        StrCopy(tempstring,currentConfDir)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        setConfLocation(loggedOnUser.confRJoin,msg.string)
      ENDIF
    CASE BB_LOCAL
      AstrCopy(msg.string,cmds.bbsLoc,200)
    CASE ZMODEMSEND
        convertToBCD(0,dTBT)
        convertToBCD(0,uTBT)
        ulTTTM:=NIL
        dlTTTM:=NIL
        tTEFF:=NIL
        tTCPS:=NIL
        StrCopy(tempstring,msg.string)
        ch:=downloadFile(tempstring)
        IF((logonType>=LOGON_TYPE_REMOTE) AND (checkCarrier()=FALSE)) THEN msg.data:=-2 ELSE msg.data:=ch
    CASE BATCHZMODEMSEND
        convertToBCD(0,dTBT)
        convertToBCD(0,uTBT)
        ulTTTM:=NIL
        dlTTTM:=NIL
        tTEFF:=NIL
        tTCPS:=NIL
        ch:=downloadFile(msg.filler1)
        IF((logonType>=LOGON_TYPE_REMOTE) AND (checkCarrier()=FALSE)) THEN msg.data:=-2 ELSE msg.data:=ch
    CASE ZMODEMRECEIVE
        convertToBCD(0,dTBT)
        convertToBCD(0,uTBT)
        ulTTTM:=NIL
        dlTTTM:=NIL
        tTEFF:=NIL
        tTCPS:=NIL
        bgFileCheck:=FALSE
        StrCopy(tempstring,msg.string);
        ch:=fileReceive(tempstring,1);
        IF((logonType>=LOGON_TYPE_REMOTE) AND (checkCarrier()=FALSE)) THEN msg.data:=-2 ELSE msg.data:=ch
    CASE SCREEN_ADDRESS
        StringF(tempstring,'\z\h[8]',screen)
        LowerStr(tempstring)
        AstrCopy(msg.string,tempstring,200)
    CASE BB_TASKPRI
      StringF(tempstring,'\c',cmds.taskPri)
      AstrCopy(msg.string,tempstring,200)
    CASE RAWSCREEN_ADDRESS
      StringF(tempstring,'\d',screen)
      AstrCopy(msg.string,tempstring,200)
    CASE BB_CHATFLAG
      IF sysopAvail
        AstrCopy(msg.string,'ON')
      ELSE
        AstrCopy(msg.string,'OFF')
      ENDIF
    CASE BB_CHATSET
      IF msg.data
        StringF(tempstring,'\d',pagedFlag)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        temp:=pagedFlag
        pagedFlag:=Val(msg.string)

        IF pagedFlag AND Not(temp)
          sysopPaged()
        ENDIF
      ENDIF
    CASE DT_STAMP_LASTON
      formatCDateTime(loggedOnUser.timeLastOn,tempstring)
      AstrCopy(msg.string,tempstring,200)
    CASE DT_CURR_TIME
        StringF(tempstring,'\d',getSystemTime())
        AstrCopy(msg.string,tempstring,200)
    CASE DT_STAMP_CTIME
      formatCDateTime(getSystemTime(),tempstring)
      AstrCopy(msg.string,tempstring,200)
    CASE DT_CONFACCESS
        IF(msg.data) THEN AstrCopy(msg.string,loggedOnUser.conferenceAccess,10) ELSE AstrCopy(loggedOnUser.conferenceAccess,msg.string,10)
    CASE BB_PCONFNAME
        temp:=Val(msg.string)
        IF((temp<1) OR (temp>9))
          AstrCopy(msg.string,'ERROR',10)
        ELSE
          AstrCopy(msg.string,getConfName(temp),200)
        ENDIF
    CASE BB_PCONFLOCAL
        temp:=Val(msg.string)
        IF((temp<1) OR (temp>9))
          AstrCopy(msg.string,'ERROR',10)
        ELSE
          getConfLocation(temp,tempstring)
          AstrCopy(msg.string,tempstring,200)
        ENDIF
    CASE BB_MAINLINE
      IF StrLen(params)>0
        StringF(tempstring,'\s \s',command,params)
      ELSE
        StrCopy(tempstring,command)
      ENDIF
      AstrCopy(msg.string,tempstring,200)
    CASE BB_NODEID
      StringF(tempstring,'\d',node)
      AstrCopy(msg.string,tempstring,200)
    CASE BB_CALLERSLOG
      callersLog(msg.string,FALSE)
    CASE BB_UDLOG
      udLog(msg.string)
    CASE EXPRESS_VERSION
        getExpressMajorVer(tempstring)
        AstrCopy(msg.string,tempstring,200)
    CASE GETKEY
      IF checkInput() THEN msg.string[0]:="1" ELSE msg.string[0]:="0"
      msg.string[1]:=0
    CASE RAWARROW
      IF(rawArrow) THEN rawArrow:=FALSE ELSE rawArrow:=TRUE
    CASE PRV_COMMAND
      StrCopy(tempstring,msg.string)
      processCommand(tempstring,TRUE)
    CASE PRV_GROUP
      StrCopy(tempstring,msg.string)
        temp:=Val(tempstring)
          AstrCopy(cmds.conf1Loc+(temp*54),tempstring+40,54)
        IF(temp=(currentConf-1)) 
          StrCopy(currentConfDir,tempstring+40)
          checkPathSlash(currentConfDir)
        ENDIF
        tempstring[39]:=0
        stripReturn(tempstring)
        AstrCopy(cmds.conf1Name+(temp*54),tempstring+2,54)
        IF(temp=(currentConf-1)) THEN StrCopy(currentConfName,tempstring+2)
    CASE BB_CONFNUM
      StringF(tempstring,'\d',currentConf-1)
      AstrCopy(msg.string,tempstring,200)
    CASE BB_DROPDTR
      processOlmMessageQueue(TRUE)
      Delay(30)
      modemOffHook()
      resetSerOut:=TRUE
      ->reqState:=REQ_STATE_LOGOFF
    CASE BB_GETTASK
      msg.task:=FindTask(0)
    CASE NODE_BAUD
      StringF(tempstring,'\d',onlineBaud)
      AstrCopy(msg.string,tempstring,10)
    CASE NODE_BAUDRATE
      StringF(tempstring,'\d',onlineBaudR)
      AstrCopy(msg.string,tempstring,10)
    CASE NODE_DEVICE
      AstrCopy(msg.string,cmds.serDev)
    CASE NODE_UNIT
      StringF(tempstring,'\d',cmds.serDevUnit)
      AstrCopy(msg.string,tempstring,10)
    CASE DT_ADDBIT
        setTempSecurityFlags(msg.data)
    CASE DT_REMBIT
        clearTempSecurityFlags(msg.data)
    CASE DT_QUERYBIT
        msg.command:=checkSecurity(msg.data)
    CASE BB_LOGONTYPE
        msg.data:=logonType
    CASE BB_SCRLEFT
        msg.data:=screen.leftedge
    CASE BB_SCRTOP
        msg.data:=screen.topedge
    CASE BB_SCRWIDTH
        msg.data:=screen.width
    CASE BB_SCRHEIGHT
        msg.data:=screen.height
    CASE BB_PURGELINE
        purgeLine()
    CASE BB_PURGELINESTART
        purgeLineStart()
    CASE BB_PURGELINEEND
        purgeLineEnd()
    CASE BB_NONSTOPTEXT
      IF (msg.data=0) THEN nonStopDisplayFlag:=FALSE ELSE nonStopDisplayFlag:=TRUE
    CASE BB_LINECOUNT
      IF(msg.data)
        StringF(tempstring,'\d',lineCount)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        lineCount:=Val(msg.string)
      ENDIF
    CASE DT_LANGUAGE
      IF msg.data
        AstrCopy(msg.string,'txt')
        IF loggedOnUser<>NIL
          IF (loggedOnUser.screenType<screenTypeExt.count())
            AstrCopy(msg.string,screenTypeExt.item(loggedOnUser.screenType),200)
          ENDIF
        ENDIF
      ELSE
        IF loggedOnUser<>NIL
          FOR i:=0 TO screenTypeExt.count()-1
            IF StriCmp(msg.string,screenTypeExt.item(i)) THEN loggedOnUser.screenType:=i;
          ENDFOR
        ENDIF
      ENDIF

    CASE DT_QUICKFLAG
      quickFlag:=msg.data
    CASE DT_GOODFILE
      aeGoodFile:=msg.data
    CASE DT_ANSICOLOR
        IF msg.data THEN ansiColour:=TRUE ELSE ansiColour:=FALSE
        IF msg.data=2 THEN ripMode:=TRUE
    CASE DT_ISANSI
        IF ansiColour THEN msg.data:=1 ELSE msg.data:=0
    CASE MULTICOM
        msg.semi:=masterNode
    CASE EXT_LOAD_ACCOUNT,LOAD_ACCOUNT
        doorMsgLoadAccount(msg)
    CASE SEARCH_ACCOUNT
        IF(findUserFromNumber(msg.data,msg.filler1)) THEN msg.data:=1 ELSE msg.data:=0
    CASE APPEND_ACCOUNT

        tuserdata:=msg.filler1
        tuserkeys:=msg.filler2
        IF (msg.msg.length>=SIZEOF jhMessage)
          tusermisc:=msg.filler3
        ELSE
          tusermisc:=NIL
        ENDIF
        findOpenAccount(tuserdata,tuserkeys,tusermisc)
    CASE LAST_ACCOUNTNUM
        msg.data:=findLastAccount()
    CASE SAVE_ACCOUNT
       doorMsgSaveAccount(msg)
    CASE EDITOR_STRUCT
        IF(msg.data)
          CopyMem(msg.filler1,editor,SIZEOF editor)
        ELSE
          CopyMem(editor,msg.filler1,SIZEOF editor)
        ENDIF
    CASE LOAD_CONFDB
      loadConfDB(msg.data,msg.nodeID,1,msg.filler1)
    CASE SAVE_CONFDB
      saveConfDB(msg.data,msg.nodeID,1,msg.filler1)
      IF(loggedOnUser.slotNumber=msg.data) THEN loadMsgPointers(currentConf,1)
    CASE GET_CONFNUM
      AstrCopy(msg.filler1,getConfName(msg.data),54)
      AstrCopy(msg.filler2,getConfLocation(msg.data),54)
    CASE MOD_TYPE
      msg.data:=IF privcmd THEN 1 ELSE 0
    CASE DT_FILECODE
      checksym:=msg.data
    CASE ACP_COMMAND
        sendACPCommand(msg.string,msg.data,msg.lineNum)
    CASE BYPASS_CSI_CHECK
        debugLog(LOG_WARN,'BYPASS_CSI_CHECK not yet implemented')
    CASE SENTBY
       msg.data:=cmds.acLvl[LVL_SENTBY_FILES]
    CASE SETOVERIDE
      setOverride(msg.data)
    CASE FULLEDIT
        debugLog(LOG_WARN,'FULLEDIT not yet implemented')
    CASE SETMCIOFF
      mcioff:=msg.data<>0
    CASE GET_CUSTOM_MSGBASE_PARAM1
      msg.data:=customMsgParam1
    CASE GET_CUSTOM_MSGBASE_PARAM2
      msg.data:=customMsgParam2
    CASE LAST_READ
      msg.data:=lastMsgReadConf
    CASE LAST_SCANNED
      msg.data:=lastNewReadConf
    CASE MSGBASE_LOC
      IF (msg.data)
        AstrCopy(msg.string,msgBaseLocation,26)
      ELSE
        StrCopy(msgBaseLocation,msg.string,26)
        checkPathSlash(msgBaseLocation)
      ENDIF
    CASE GET_CUSTOM_MSGBASE_MENUCMD
      AstrCopy(msg.string,customMsgCmd,200)
    CASE DT_REALNAME
      IF (msg.data)
        AstrCopy(msg.string,loggedOnUserMisc.realName,26)
      ELSE
        AstrCopy(loggedOnUserMisc.realName,msg.string,26)
      ENDIF
    CASE SER_INOUT
      ioFlags[IOFLAG_SER_IN]:=msg.data
      ioFlags[IOFLAG_SER_OUT]:=msg.data
      
    CASE AXNET_SEND
      convertToBCD(0,dTBT)
      convertToBCD(0,uTBT)
      ulTTTM:=0
      dlTTTM:=0
      tTEFF:=0
      tTCPS:=0
      
      msg.data:=doAxNetSend(msg.filler1)
      IF logonType=LOGON_TYPE_REMOTE
        IF checkCarrier()=FALSE
          msg.data:=RESULT_ABORT
        ENDIF
      ENDIF           
    CASE AXNET_RECEIVE
      convertToBCD(0,dTBT)
      convertToBCD(0,uTBT)
      ulTTTM:=0
      dlTTTM:=0
      tTEFF:=0
      tTCPS:=0
      StrCopy(tempstring,msg.string)

      msg.data:=doAxNetReceive(tempstring)
      IF logonType=LOGON_TYPE_REMOTE
        IF checkCarrier()=FALSE
          msg.data:=RESULT_ABORT
        ENDIF
      ENDIF
    CASE MEMCONF
      ->ensure all conf info files are loaded
      FOR i:=1 TO cmds.numConf
        readToolTypeInt(TOOLTYPE_CONF,i,'NDIRS')
      ENDFOR
      msg.filler1:=memConf
    CASE SET_SERSHARED
      serShared:=msg.data
    CASE CONF_ACCESS
      IF (msg.data<0) OR (msg.data>=cmds.numConf)
        msg.data:=2
      ELSE
        IF checkConfAccess(msg.data+1) THEN msg.data:=1 ELSE msg.data:=0
      ENDIF
    CASE PASSWORD_HASH
      IF loggedOnUserMisc.pwdType=PWD_LEGACY
        formatUnsignedLong(calcPasswordHash(msg.string),tempstring)
      ELSE
        StrCopy(tempstring,loggedOnUserMisc.pwdHash,32)
      ENDIF
      AstrCopy(msg.string,tempstring,40)
    CASE GET_GNSFLAG
      msg.data:=IF(nonStopDisplayFlag) THEN 1  ELSE 0
    CASE DISPLAY_FILE
      displayFile(msg.string,TRUE,FALSE)
    CASE CHECK_TO_DISPLAY
      IF (findSecurityScreen(msg.string,tempstring)) THEN displayFile(tempstring,TRUE,FALSE)
    CASE SET_FILEATTACH
      fileattach:=(msg.data<>0)
    CASE INTERPRET_MCI
      processMci(msg.string,tempstring)
      AstrCopy(msg.string,tempstring,200)
    CASE GET_XIMPORT
      msg.data:=ximPort
    CASE GET_MENU_COMMAND_CHAR
      msg.data:=messageMenuChar
    CASE FILE_REQUEST
      asl(msg.string)
    CASE DISABLE_FILE_ATTACH
      disallowFileAttach:=(msg.data<>0)
    CASE QWKZOOM_REC
      IF msg.data
        RealF(tempstring,floatMsgRecNum,2)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        floatMsgRecNum:=RealVal(msg.string)
      ENDIF
    CASE REL_CONF
      msg.data:=relConf(msg.data)
    CASE RETURNCOMMAND2
      StrCopy(runOnExit2,msg.string,200)
    CASE CHECK_PLAYPEN_EXISTS
      msg.data:=checkForFile(msg.string)
      IF msg.data=0 THEN msg.data:=checkInPlaypens(msg.string)
    CASE EXT_CHOOSE_NAME,CHOOSE_NAME
        tuserdata:=msg.filler1
        tuserkeys:=msg.filler2
        IF (msg.msg.length>=SIZEOF jhMessage)
          tusermisc:=msg.filler3
        ELSE
          tusermisc:=NIL
        ENDIF
        msg.data:=chooseAName(msg.string,tuserdata,tuserkeys,tusermisc,msg.data)
    CASE CHECK_REALNAME
      StringF(tempstring,'USERNAME.\d',currentMsgBase)
      StringF(tempstring2,'REALNAME.\d',currentMsgBase)
      IF checkToolTypeExists(TOOLTYPE_CONF,currentConf,'USERNAME') OR checkToolTypeExists(TOOLTYPE_MSGBASE,currentConf,tempstring)
        msg.data:=2
      ELSEIF checkToolTypeExists(TOOLTYPE_CONF,currentConf,'REALNAME') OR checkToolTypeExists(TOOLTYPE_MSGBASE,currentConf,tempstring2)
        msg.data:=1
      ELSE
        msg.data:=0
      ENDIF
    CASE DT_INTERNETNAME
      IF (msg.data)
        AstrCopy(msg.string,loggedOnUserMisc.internetName,10)
      ELSE
        AstrCopy(loggedOnUserMisc.internetName,msg.string,10)
      ENDIF
    CASE DT_TRANSLATOR
      IF (msg.data)
        AstrCopy(msg.string,userLanguage,200)
      ELSE
        StrCopy(userLanguage,msg.string,200)
        IF sopt.translation=NIL THEN loadTranslators()
      ENDIF
    CASE DT_HOST_LANGUAGE
      IF (msg.data)
        AstrCopy(msg.string,hostLanguage,200)
      ELSE
        StrCopy(hostLanguage,msg.string,200)
      ENDIF
    CASE XNET_OUTBOUND
      StrCopy(amixnetOutboundDir,msg.string,200)
    CASE DT_HOSTNAME
      AstrCopy(msg.string,hostName,200)
    CASE DT_HOSTIP
      AstrCopy(msg.string,hostIP,20)
    CASE DT_GEOGRAPHIC
      AstrCopy(msg.string,mybbsLoc,200)
    CASE DT_SIZEUPLOAD
      calcSizeText(loggedOnUserMisc.uploadBytesBCD,tempstring)
      AstrCopy(msg.string,tempstring,200)
    CASE DT_SIZEDOWNLOAD
      calcSizeText(loggedOnUserMisc.downloadBytesBCD,tempstring)
      AstrCopy(msg.string,tempstring,200)          
    CASE CON_CURSOR
      IF (msg.data)
        conCursorOn()
      ELSE
        conCursorOff()
      ENDIF
    CASE TELNET_CONNECT
      telnetConnect(msg.string,msg.data)
    CASE TELNET_USERNAME_PROMPT
      StrCopy(telnetUsernamePrompt,msg.string)
    CASE TELNET_USERNAME
      StrCopy(telnetUsername,msg.string)
    CASE TELNET_PASSWORD_PROMPT
      StrCopy(telnetPasswordPrompt,msg.string)
    CASE TELNET_PASSWORD
      StrCopy(telnetPassword,msg.string)
    CASE GET_CMD_TOOLTYPE
      StrCopy(tempstring,'')
      msg.data:=readToolType(tooltype,command,msg.string,tempstring)
      AstrCopy(msg.string,tempstring,200)
    CASE DT_CONFACCESS2
      StrCopy(tempstring,'')
      IF msg.data
        FOR i:=1 TO Min(25,cmds.numConf)
          IF checkConfAccess(i) THEN StrAdd(tempstring,'X') ELSE StrAdd(tempstring,'_')
        ENDFOR
        AstrCopy(msg.string,tempstring,200)
      ELSE
        AstrCopy(loggedOnUser.conferenceAccess,msg.string,10)
      ENDIF
    CASE DT_CBYTESUPLOAD
    /*DUPE of DT_BYTESUPLOAD - logged on user will always be current conf stats when using confacc. */
      IF (msg.data)
        formatBCD(loggedOnUserMisc.uploadBytesBCD,tempstring)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        bcdVal(msg.string,loggedOnUserMisc.uploadBytesBCD)
        loggedOnUser.bytesUpload:=convertFromBCD(loggedOnUserMisc.uploadBytesBCD)
      ENDIF            
    CASE DT_CBYTESDOWNLOAD
    /*DUPE of DT_BYTESUPLOAD - logged on user will always be current conf stats when using confacc. */
      IF (msg.data)
        formatBCD(loggedOnUserMisc.downloadBytesBCD,tempstring)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        bcdVal(msg.string,loggedOnUserMisc.downloadBytesBCD)
        loggedOnUser.bytesDownload:=convertFromBCD(loggedOnUserMisc.downloadBytesBCD)
      ENDIF
    CASE DT_CFILESUPLOAD
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.uploads)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.uploads:=Val(msg.string)
      ENDIF         
    CASE DT_CFILESDOWNLOAD
      IF (msg.data)
        StringF(tempstring,'\d',loggedOnUser.downloads)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUser.downloads:=Val(msg.string)
      ENDIF         
    CASE BB_CONFACCOUNT
      IF (msg.data)
        AstrCopy(msg.string,IF checkSecurity(ACS_CONFERENCE_ACCOUNTING) THEN 'YES' ELSE 'NO',200)
      ELSE
        debugLog(LOG_WARN,'BB_CONFACCOUNT cannot currently set conf accounting')             
      ENDIF
    CASE DT_CALLEDTODAY
      IF (msg.data)
        StringF(tempstring,'\d',getTodaysCalls(loggedOnUser,loggedOnUserKeys))
        AstrCopy(msg.string,tempstring,200)
      ELSE
        loggedOnUserKeys.timesOnToday:=Val(msg.string)
      ENDIF         
    CASE SIG_PLAYPEN
      IF(StrLen(sopt.ramPen)>0) THEN StrCopy(tempstring,sopt.ramPen) ELSE StringF(tempstring,'\sNode\d/Playpen/',cmds.bbsLoc,node)
      AstrCopy(msg.string,tempstring,200)
    CASE ICONIFYQUERY
      AstrCopy(msg.string,IF scropen THEN 'NO' ELSE 'YES',200)
    CASE LOGON_UNAME
      debugLog(LOG_WARN,'LOGON_UNAME not currently supported')
    CASE LOGON_UPASS
      debugLog(LOG_WARN,'LOGON_UPASS not currently supported')
    CASE SIG_LI
      getPass2(msg.string,NIL,0,msg.data,tempstring)
      AstrCopy(msg.string,tempstring,200)
    CASE UNKNOWN4
      IF (msg.data)
        StringF(tempstring,'\d',unknownValue)
        AstrCopy(msg.string,tempstring,200)
      ELSE
        unknownValue:=Val(msg.string)
      ENDIF 
    CASE QUIET_DOWNLOAD
      IF (msg.string[0])
        quietDownload:=msg.data
      ELSE
        msg.data:=quietDownload
      ENDIF 
    DEFAULT
      StringF(tempstring,'currently not implemented msg request: \d',msgcmd)
      debugLog(LOG_WARN,tempstring)
      StringF(tempstring,'data: \d',msg.data)
      debugLog(LOG_WARN,tempstring)
      StringF(tempstring,'string: \s',msg.string)
      debugLog(LOG_WARN,tempstring)
    ENDSELECT
ENDPROC

PROC runDoor(cmd,type,command,tooltype,params,resident,doorTrap,privcmd,pri=0,stacksize=20000)
  DEF doorPort[12]:STRING
  DEF mp: PTR TO mp
  DEF exestring[100]:STRING
  DEF ximSig,signals
  DEF msg: PTR TO jhMessage
  DEF doormsg: PTR TO doorMsg
  DEF temp
  DEF async,ch
  DEF nodes = 0,msgcmd
  DEF tempstring[255]:STRING
  DEF runOnExit[255]:STRING
  DEF runOnExit2[255]:STRING
  DEF exit=0
  DEF alreadyActive=FALSE
  DEF oldViewSafe

  StringF(tempstring,'run door: \s',cmd)
  debugLog(LOG_DEBUG,tempstring)
  aePuts('[0m')

  IF serShared=FALSE THEN purgeLine()

  StrCopy(runOnExit,'')
  StrCopy(runOnExit2,'')

  IF (resident=FALSE) AND ((type<>DOORTYPE_MCI) AND (StrLen(cmd)>0))
    IF (fileExists(cmd)=FALSE)
      IF privcmd=FALSE
        aePuts('\b\nError, can''t locate Custom Command\b\n')
        aePuts('or Command is in use\b\n')
      ENDIF
      RETURN
    ENDIF
  ENDIF

  oldViewSafe:=mciViewSafe

  async:=TRUE

  SELECT type
    CASE DOORTYPE_AIM
      IF resident
        StringF(exestring,'REXXDOOR \d \s',node,cmd)
      ELSE
        StringF(exestring,'\sUtils/REXXDOOR \d \s',cmds.bbsLoc,node,cmd)
      ENDIF
    CASE DOORTYPE_XIM
      StringF(exestring,'\s \d',cmd,node)
    CASE DOORTYPE_SIM
      StringF(exestring,'\s \d',cmd,node)
      async:=FALSE
    CASE DOORTYPE_TIM
      IF resident
        StringF(exestring,'PARADOOR \s \d',cmd,node)
      ELSE
        StringF(exestring,'\sUtils/PARADOOR \s \d',cmds.bbsLoc,cmd,node)
      ENDIF
    CASE DOORTYPE_IIM
      purgeLineEnd()
      StringF(exestring,'\s \d',cmd,node)
      purgeLineStart()
    CASE DOORTYPE_MCI
      StringF(cmd,'~SS_\s',cmd)
      readToolType(tooltype,command,'MCI_TEXT',cmd)
      StringF(exestring,'~|\s|',cmd)
      processMci(exestring)
    CASE DOORTYPE_AEM
      IF resident
        StringF(exestring,'REXXEXEC \d \s',node,cmd)
      ELSE
        StringF(exestring,'\sUtils/REXXEXEC \d \s',cmds.bbsLoc,node,cmd)
      ENDIF
    CASE DOORTYPE_SUP
      StringF(exestring,'\s \d',cmd,node)
      async:=FALSE
    DEFAULT
      StringF(exestring,'\s \d',cmd,node)
      async:=FALSE
  ENDSELECT

  IF type=DOORTYPE_AIM THEN type:=DOORTYPE_XIM



  IF type=DOORTYPE_XIM
    StringF(doorPort,'\s\d','AEDoorPort',node)
  ELSE
    StringF(doorPort,'\s\d','DoorControl',node)
  ENDIF

  IF (type=DOORTYPE_MCI) THEN RETURN

  IF (mp:=FindPort(doorPort))
    alreadyActive:=TRUE
  ELSE
    mp:=createPort(doorPort,0)
  ENDIF

  ximSig:=Shl(1,mp.sigbit)

  doorLog(type,cmd)

  IF type=DOORTYPE_SUP THEN purgeLineEnd()

  temp:=startProcess(exestring,stacksize,pri,async,doorTrap)

  IF type=DOORTYPE_SUP THEN purgeLineStart()

  IF ((temp=-1) OR (async=FALSE))
    IF alreadyActive=FALSE THEN deletePort(mp)
    doorLog(type,'')
    RETURN
  ENDIF

  IF((type=DOORTYPE_IIM) OR (type=DOORTYPE_SIM) OR (type=DOORTYPE_SUP))
    IF alreadyActive=FALSE THEN deletePort(mp)
    doorLog(type,'')
    RETURN
  ENDIF

  IF type=DOORTYPE_XIM
    WHILE(exit=FALSE)
      signals:=Wait(ximSig)
      WHILE(msg:=GetMsg(mp))
        msgcmd:=msg.command


        StringF(tempstring,'msg request: \d',msgcmd)
        debugLog(LOG_DEBUG,tempstring)
        StringF(tempstring,'data: \d',msg.data)
        debugLog(LOG_DEBUG,tempstring)
        StringF(tempstring,'string: \s',msg.string)
        debugLog(LOG_DEBUG,tempstring)
        IF(msgcmd<>ACP_COMMAND) THEN msg.lineNum:=0
        
        processXimMsg(msgcmd,msg,tooltype,command,privcmd,params,{nodes},{exit},runOnExit,runOnExit2)
        ReplyMsg(msg)
      ENDWHILE
    ENDWHILE
  ELSE
    WHILE(exit=FALSE)
      doormsg:=WaitPort(mp)
      WHILE(doormsg:=GetMsg(mp))
        doormsg.carrier:=FALSE
        msgcmd:=doormsg.command
        SELECT msgcmd
          CASE PG_SHUTDOWN
            ReplyMsg(doormsg)
            aePuts('\b\n')
            rawArrow:=FALSE
            exit:=TRUE

          CASE PG_SO
            serPutChar(doormsg.data)
          CASE PG_CC
            conPutChar(doormsg.data)
          CASE PG_CH
            serPutChar(doormsg.data)
            conPutChar(doormsg.data)
          CASE PG_CO
            conPuts(doormsg.string)
            IF(doormsg.data) THEN conPuts('\b\n')
            checkForPause()

          CASE PG_SM
            aePuts(doormsg.string)
            IF (doormsg.data) THEN aePuts('\b\n')
            checkForPause()

          CASE PG_PM
            aePuts(doormsg.string)
            IF(lineInput('','',doormsg.data,doorTimeout,tempstring)<0)
               doormsg.carrier:=TRUE
            ELSE
               doormsg.carrier:=FALSE
            ENDIF
            AstrCopy(doormsg.string,tempstring,80)
          CASE PG_SC
            aePuts(doormsg.string);
            IF(lineInput('','',doormsg.data,doorTimeout,tempstring)<0)
              doormsg.carrier:=TRUE
            ELSE
              doormsg.carrier:=FALSE
            ENDIF
            AstrCopy(doormsg.string,tempstring,80)
          CASE PG_HK
            lineCount:=0
            aePuts(msg.string)
            ch:=readChar(doorTimeout)
            IF (ch<0)
              doormsg.carrier:=TRUE
            ELSE
              doormsg.carrier:=FALSE
            ENDIF
            doormsg.string[0]:=ch
            doormsg.string[1]:=0
          CASE PG_SG
            nonStopDisplayFlag:=FALSE;
            mciViewSafe:=FALSE
            IF (findSecurityScreen(doormsg.string,tempstring)) THEN displayFile(tempstring)
            mciViewSafe:=TRUE
          CASE PG_SF
            nonStopDisplayFlag:=FALSE;
            mciViewSafe:=FALSE
            displayFile(doormsg.string)
            mciViewSafe:=TRUE
          CASE PG_EF
            fileattach:=FALSE
            loadMsg(doormsg.string)
            IF(edit()=RESULT_SUCCESS)
              saveMsg(doormsg.string)
            ENDIF
          CASE PG_UD
            IF(doormsg.data=1)
              doormsg.data:=Div(loggedOnUser.secStatus,10)
            ELSEIF(doormsg.data=2)
              doormsg.data:=loggedOnUser.expert
            ELSEIF(doormsg.data=3)
              doormsg.data:=0
            ELSEIF(doormsg.data=4)
              doormsg.data:=loggedOnUser.timesCalled
            ELSEIF(doormsg.data=5)
              doormsg.data:=loggedOnUser.timesCalled
            ELSEIF(doormsg.data=6)
              doormsg.data:=1
            ELSEIF(doormsg.data=7)
              doormsg.data:=Div(timeLimit,60)
            ELSEIF(doormsg.data=8)
              doormsg.data:=80
            ELSEIF(doormsg.data=9)
              doormsg.data:=userLineLen
            ENDIF
          CASE PG_US
            IF(doormsg.data=1)
              AstrCopy(doormsg.string,loggedOnUser.name,80)
              doormsg.string[21]:=0
            ELSEIF(doormsg.data=2)
              AstrCopy(doormsg.string,'',80)
            ELSEIF(doormsg.data=3)
              AstrCopy(doormsg.string,loggedOnUser.location,80)
              doormsg.string[39]:=0
            ELSEIF(doormsg.data=4)
              AstrCopy(doormsg.string,loggedOnUser.location,80)
              doormsg.string[29]:=0
            ELSEIF(doormsg.data=5)
              AstrCopy(doormsg.string,loggedOnUser.location,80)
              doormsg.string[2]:=0
            ELSEIF(doormsg.data=6)
              AstrCopy(doormsg.string,loggedOnUser.location,80)
              doormsg.string[7]:=0
            ELSEIF(doormsg.data=7)
              AstrCopy(doormsg.string,'PGDOORS:',80)
            ELSEIF(doormsg.data=8)
              AstrCopy(doormsg.string,cmds.bbsLoc,80)
            ELSEIF(doormsg.data=9)
              formatLongDate(getSystemTime(),tempstring)
              AstrCopy(doormsg.string,tempstring,80)
            ELSEIF(doormsg.data=10)
              formatLongTime(getSystemTime(),tempstring)
              AstrCopy(doormsg.string,tempstring,80)
            ELSE
              AstrCopy(doormsg.string,'',80)
            ENDIF
          ->CASE PG_PS
            ->break;
          ->CASE PG_CS
            ->break;
          CASE PG_RD
            IF(doormsg.data<>0)
              doormsg.data:=Rnd(doormsg.data)
            ENDIF
          ->CASE PG_CL
            ->break;
          CASE PG_TM
            loggedOnUser.timeUsed:=loggedOnUser.timeUsed-Mul(doormsg.data,60)
            IF(loggedOnUser.timeUsed<0) THEN loggedOnUser.timeUsed:=0
            timeLimit:=timeLimit+Mul(doormsg.data,60);
            IF(timeLimit<0) THEN timeLimit:=0
          CASE PG_FF
            IF(fileExists(doormsg.string))
              doormsg.data:=1
            ELSE
              doormsg.data:=-1
            ENDIF
          CASE BB_TASKPRI
            StringF(tempstring,'\c',cmds.taskPri)
            AstrCopy(doormsg.string,tempstring,80)
        ENDSELECT
        ReplyMsg(doormsg)

      ENDWHILE

    ENDWHILE
  ENDIF

  IF alreadyActive=FALSE THEN deletePort(mp)

  doorLog(type,'')
  aePuts('[0m')

  IF resetSerOut
    ioFlags[IOFLAG_SER_IN]:=0
    ioFlags[IOFLAG_SER_OUT]:=0
    resetSerOut:=FALSE
  ENDIF

  IF (StrLen(runOnExit)>0)
    processCommand(runOnExit,FALSE,SUBTYPE_INTCMD)
  ENDIF
  IF (StrLen(runOnExit2)>0)
    processCommand(runOnExit2)
  ENDIF
ENDPROC

PROC doorMsgLoadAccount(doorMsg: PTR TO jhMessage)
  DEF tuserdata:PTR TO user,tuserkeys:PTR TO userKeys, tusermisc: PTR TO userMisc

  doorMsg.nodeID:=0
  tuserdata:=doorMsg.filler1
  tuserkeys:=doorMsg.filler2
  IF (doorMsg.msg.length>=SIZEOF jhMessage)
    tusermisc:=doorMsg.filler3
  ELSE
    tusermisc:=NIL
  ENDIF
  IF(loggedOnUser.slotNumber=doorMsg.data)
    saveMsgPointers(currentConf,currentMsgBase) ->AddMsgPointers();
    IF tuserdata<>NIL THEN CopyMem(loggedOnUser,tuserdata,SIZEOF user);
    IF tuserkeys<>NIL THEN CopyMem(loggedOnUserKeys,tuserkeys,SIZEOF userKeys)
    IF tusermisc<>NIL THEN CopyMem(loggedOnUserKeys,tusermisc,SIZEOF userMisc)
    loadMsgPointers(currentConf,currentMsgBase)
    doorMsg.nodeID:=1;
  ELSE
    IF(loadAccount(doorMsg.data,tuserdata,tuserkeys,tusermisc)<>RESULT_FAILURE) THEN doorMsg.nodeID:=1;
  ENDIF
  doorMsg.data:=doorMsg.nodeID
ENDPROC

PROC doorMsgSaveAccount(doorMsg: PTR TO jhMessage)
  DEF tuserdata:PTR TO user,tuserkeys:PTR TO userKeys, tusermisc: PTR TO userMisc
  DEF i
  tuserdata:=doorMsg.filler1
  tuserkeys:=doorMsg.filler2
  IF (doorMsg.msg.length>=SIZEOF jhMessage)
    tusermisc:=doorMsg.filler3
  ELSE
    tusermisc:=NIL
  ENDIF
  IF(tuserdata.slotNumber=0)
    tuserkeys.number:=0;
    saveAccount(tuserdata,tuserkeys,tusermisc,doorMsg.data,1)
  ELSE
    saveAccount(tuserdata,tuserkeys,tusermisc,0,0)
  ENDIF

  IF(loggedOnUser.slotNumber=doorMsg.data)
    i:=0;
    IF((loggedOnUser.secStatus<>tuserdata.secStatus) OR (StriCmp(loggedOnUser.conferenceAccess,tuserdata.conferenceAccess))) THEN i:=1
    IF tuserdata<>NIL THEN CopyMem(tuserdata,loggedOnUser,SIZEOF user)
    IF tuserkeys<>NIL THEN CopyMem(tuserkeys,loggedOnUserKeys,SIZEOF userKeys)
    IF tusermisc<>NIL THEN CopyMem(tusermisc,loggedOnUserMisc,SIZEOF userMisc)
    timeLimit:=loggedOnUser.timeTotal-loggedOnUser.timeUsed
    loadMsgPointers(currentConf,currentMsgBase)
    IF(i) THEN convertAccess()
  ENDIF
ENDPROC

PROC getExpressMajorVer(outExpressVer)
  DEF i,temp
  IF StrLen(mimicVersion)>0
    StrCopy(outExpressVer,mimicVersion)
    RETURN
  ENDIF
  
  IF (expressVer[0]="v") OR (expressVer[0]="V") THEN i:=1 ELSE i:=0
  IF ((temp:=InStr(expressVer,'.'))>=0)
    StringF(outExpressVer,'v\d.\d',Val(expressVer+i),Val(expressVer+temp+1))
  ELSE
    StringF(outExpressVer,'v\d',Val(expressVer+i))
  ENDIF
ENDPROC

PROC runCommand(cmdtype,cmd,params,privcmd,subtype=-1)
  DEF commandfile[255]:STRING
  DEF passwordstr[255]:STRING
  DEF bannerScreen[255]:STRING
  DEF doorname[255]:STRING
  DEF commandTypeCode
  DEF tooltype,pri,stacksize
  DEF acsLevel
  DEF passparams=-1
  DEF access=0
  DEF stat
  DEF resident,doorTrap
  DEF lk
  DEF fi:PTR TO fileinfoblock
  DEF flags

  IF cmdtype=CMDTYPE_BBSCMD
    getNodeFile(TOOLTYPE_CONFCMD,cmd,commandfile)
    IF (subtype<=SUBTYPE_CONFCMD) AND configFileExists(commandfile)
      tooltype:=TOOLTYPE_CONFCMD
      subtype:=SUBTYPE_CONFCMD
    ELSE
      getNodeFile(TOOLTYPE_NODECMD,cmd,commandfile)
      IF (subtype<=SUBTYPE_NODECMD) AND configFileExists(commandfile)
        tooltype:=TOOLTYPE_NODECMD
        subtype:=SUBTYPE_NODECMD
      ELSE
        getNodeFile(TOOLTYPE_BBSCMD,cmd,commandfile)
        IF (subtype<=SUBTYPE_CMD) AND configFileExists(commandfile)
          tooltype:=TOOLTYPE_BBSCMD
          subtype:=SUBTYPE_CMD
        ELSE
          RETURN RESULT_FAILURE
        ENDIF
      ENDIF
    ENDIF

  ELSEIF cmdtype=CMDTYPE_SYSCMD
    getNodeFile(TOOLTYPE_CONFSYSCMD,cmd,commandfile)
    IF (subtype<=SUBTYPE_CONFCMD) AND configFileExists(commandfile)
      tooltype:=TOOLTYPE_CONFSYSCMD
      subtype:=SUBTYPE_CONFCMD
    ELSE
      getNodeFile(TOOLTYPE_NODESYSCMD,cmd,commandfile)
      IF (subtype<=SUBTYPE_NODECMD) AND configFileExists(commandfile)
        tooltype:=TOOLTYPE_NODESYSCMD
        subtype:=SUBTYPE_NODECMD
      ELSE
        getNodeFile(TOOLTYPE_SYSCMD,cmd,commandfile)
        IF (subtype<=SUBTYPE_CMD) AND configFileExists(commandfile)
          tooltype:=TOOLTYPE_SYSCMD
          subtype:=SUBTYPE_CMD
        ELSE
          RETURN RESULT_FAILURE
        ENDIF
      ENDIF
    ENDIF
  ELSEIF cmdtype=CMDTYPE_CUSTOM
    getNodeFile(TOOLTYPE_CONFCMD2,cmd,commandfile)
    IF configFileExists(commandfile)
      tooltype:=TOOLTYPE_CONFCMD2
      subtype:=SUBTYPE_CONFCMD
    ELSE
      RETURN RESULT_FAILURE
    ENDIF
  ENDIF

  commandTypeCode:=DOORTYPE_SIM
  IF checkToolType(tooltype,cmd,'TYPE','XIM')
    commandTypeCode:=DOORTYPE_XIM
  ELSEIF checkToolType(tooltype,cmd,'TYPE','AIM')
    commandTypeCode:=DOORTYPE_AIM
  ELSEIF checkToolType(tooltype,cmd,'TYPE','SIM')
    commandTypeCode:=DOORTYPE_SIM
  ELSEIF checkToolType(tooltype,cmd,'TYPE','TIM')
    commandTypeCode:=DOORTYPE_TIM
  ELSEIF checkToolType(tooltype,cmd,'TYPE','IIM')
    commandTypeCode:=DOORTYPE_IIM
  ELSEIF checkToolType(tooltype,cmd,'TYPE','MCI')
    commandTypeCode:=DOORTYPE_MCI
  ELSEIF checkToolType(tooltype,cmd,'TYPE','AEM')
    commandTypeCode:=DOORTYPE_AEM
  ELSEIF checkToolType(tooltype,cmd,'TYPE','SUP')
    commandTypeCode:=DOORTYPE_SUP
  ENDIF

  acsLevel:=255
  IF loggedOnUser<>NIL THEN acsLevel:=loggedOnUser.secStatus
  access:=readToolTypeInt(tooltype,cmd,'ACCESS');
  IF access=0 THEN RETURN TRUE
  IF (access>acsLevel)
    IF privcmd=FALSE THEN higherAccess()
    RETURN RESULT_NOT_ALLOWED
  ENDIF

  setEnvStat(ENV_DOORS)
  IF readToolType(tooltype,cmd,'NAME',doorname)
    setEnvMsg(doorname)
  ELSE
    setEnvMsg(cmd)
  ENDIF

  IF readToolType(tooltype,cmd,'PASSWORD',passwordstr)
    aePuts('\b\n')
    aePuts('Enter Password >: ')
    StrCopy(commandfile,'')
    stat:=lineInput('','',15,INPUT_TIMEOUT,commandfile)
    IF(stat<0)
      ->UnLockDoor(&LockDoor)
      RETURN RESULT_FAILURE
    ENDIF
    IF(StriCmp(passwordstr,commandfile)=FALSE)
      aePuts('\b\nInValid Password!\b\n')
      ->UnLockDoor(&LockDoor)
      RETURN RESULT_NOT_ALLOWED
    ENDIF
  ENDIF

  IF checkToolTypeExists(tooltype,cmd,'INTERNAL')
    passparams:=readToolTypeInt(tooltype,cmd,'PASS_PARAMETERS')
    IF passparams=1 THEN RETURN RESULT_SUCCESS

    readToolType(tooltype,cmd,'INTERNAL',commandfile)
    IF passparams>0
      ->pass in the original params
      StrAdd(commandfile,' ')
      StrAdd(commandfile,params)
    ENDIF

    IF (passparams=-1) OR (passparams=2) THEN subtype++
    IF (passparams=4) THEN subtype:=SUBTYPE_INTCMD
    IF (passparams=5) THEN subtype:=SUBTYPE_ANYCMD
    
    RETURN processCommand(commandfile,(passparams=5) AND (cmdtype=CMDTYPE_SYSCMD),subtype)
  ENDIF

  getNodeFile(tooltype,cmd,commandfile)
  readToolType(tooltype,cmd,'LOCATION',commandfile)

  IF commandTypeCode=-1 THEN RETURN RESULT_FAILURE

  IF (checkToolTypeExists(tooltype,cmd,'QUICKMODE')) AND (quickFlag) THEN RETURN TRUE

  pri:=0
  stacksize:=20000
  IF readToolType(tooltype,cmd,'PRIORITY',passwordstr)
    IF StriCmp(passwordstr,'same')
      pri:=byteSignExtend(cmds.taskPri)
    ELSE
      pri:=Val(passwordstr)
    ENDIF
  ENDIF

  IF readToolType(tooltype,cmd,'STACK',passwordstr) THEN stacksize:=Val(passwordstr)

  resident:=checkToolTypeExists(tooltype,cmd,'RESIDENT')
  IF checkToolTypeExists(tooltype,cmd,'EXPERT_MODE') THEN doorExpertMode:=TRUE

  doorTrap:=checkToolTypeExists(tooltype,cmd,'TRAPON')

  doorSilent:=checkToolTypeExists(tooltype,cmd,'SILENT')

  IF readToolType(tooltype,cmd,'BANNER',bannerScreen) THEN showCustomScreen(bannerScreen)

  readToolType(tooltype,cmd,'MIMICVER',mimicVersion)
  
  inputLogging:=checkToolTypeExists(TOOLTYPE_NODE,node,'LOG_INPUTS') OR checkToolTypeExists(tooltype,cmd,'LOG_INPUTS')

  IF (commandTypeCode=DOORTYPE_SIM) OR (commandTypeCode=DOORTYPE_TIM) OR (commandTypeCode=DOORTYPE_IIM) OR (commandTypeCode=DOORTYPE_SUP) 
    ->option automatically set script flag when calling SIM doors
    IF checkToolTypeExists(tooltype,cmd,'SCRIPTCHECK')
      lk:=Lock(commandfile,ACCESS_READ)
      IF lk<>0
        fi:=AllocDosObject(DOS_FIB,NIL)
        IF fi<>0
          Examine(lk,fi)
          flags:=fi.protection
          FreeDosObject(DOS_FIB,fi)
          IF (flags AND FIBF_SCRIPT)=0 THEN SetProtection(cmd,flags OR FIBF_SCRIPT)
        ENDIF
        UnLock(lk)
      ENDIF
    ENDIF
  ENDIF

  
  runDoor(commandfile,commandTypeCode,cmd,tooltype,params,resident,doorTrap,privcmd,pri,stacksize)
  
  inputLogging:=FALSE
  doorSilent:=FALSE
  StrCopy(mimicVersion,'')
ENDPROC RESULT_SUCCESS

PROC runBbsCommand(cmd,params,privcmd=FALSE,subtype=-1)
  DEF debugstr[255]:STRING
  StringF(debugstr,'execute bbscmd: \s \s',cmd,params)
  debugLog(LOG_DEBUG,debugstr)
ENDPROC runCommand(CMDTYPE_BBSCMD,cmd,params,privcmd,subtype)

PROC runSysCommand(cmd,params,privcmd=TRUE,subtype=-1)
  DEF debugstr[255]:STRING
  StringF(debugstr,'execute syscmd: \s \s',cmd,params)
  debugLog(LOG_DEBUG,debugstr)
ENDPROC runCommand(CMDTYPE_SYSCMD,cmd,params,privcmd,subtype)

PROC loadConfDB(account,confNum,msgBase,addr,force=FALSE)
  DEF bi, confLoc[255]:STRING
  DEF tmpMem
  IF (account = loggedOnUser.slotNumber) AND (force=FALSE)
    CopyMem(confBases.item(getConfIndex(confNum,msgBase)),addr,SIZEOF confBase)
    RETURN
  ENDIF

  getConfDbFileName(confNum,msgBase,confLoc)

  bi:=Open(confLoc,MODE_OLDFILE)
  IF(bi=0)
    callersLog('\tError can''t open >:')
    RETURN
  ENDIF

  IF(Seek(bi,(account-1)*SIZEOF confBase,OFFSET_BEGINNING)=-1)
    callersLog('\tError Reading confbase data')
    callersLog(confLoc)
    Close(bi)
    RETURN
  ENDIF

  IF (Read(bi,addr,SIZEOF confBase)<>SIZEOF confBase)
    ->if we can't read the conf db then clear out any existing data
    tmpMem:=New(SIZEOF confBase)
    CopyMem(tmpMem,addr,SIZEOF confBase)
    Dispose(tmpMem)
    callersLog('\tError Reading confbase data')
  ENDIF

  convertConfUDBytesTOBCD(addr)

  Close(bi)
ENDPROC

PROC saveConfDB(account,confNum,msgBase,addr,force=FALSE)
  DEF bi, confLoc[255]:STRING

  IF (account = loggedOnUser.slotNumber) AND (force=FALSE)
    CopyMem(addr,confBases.item(getConfIndex(confNum,msgBase)),SIZEOF confBase)
    RETURN
  ENDIF

  getConfDbFileName(confNum,msgBase,confLoc)

  bi:=Open(confLoc,MODE_READWRITE)
  IF(bi=0)
    callersLog('\tError can''t open >:')
    callersLog(confLoc)
    RETURN
  ENDIF

  IF(Seek(bi,(account-1)*SIZEOF confBase,OFFSET_BEGINNING)=-1)
    callersLog('\tError Reading MsgBase Pointer')
    Close(bi)
    RETURN
  ENDIF

  Write(bi,addr,SIZEOF confBase)
  Close(bi)
ENDPROC

PROC loadMsgPointers(conf,msgBase)
  DEF cb: PTR TO confBase
  DEF i

  IF(loggedOnUser.slotNumber<=0) OR (conf<1) OR (msgBase<1)
    lastMsgReadConf:=0
    lastNewReadConf:=0
    RETURN
  ENDIF

  cb:=confBases.item(getConfIndex(conf,msgBase))

  IF (checkSecurity(ACS_CONFERENCE_ACCOUNTING))
    IF (readToolTypeInt(TOOLTYPE_CONF,conf,'CONFDB_SHARED')<=0)
      FOR i:=0 TO 7
        loggedOnUserMisc.downloadBytesBCD[i]:=cb.downloadBytesBCD[i]
        loggedOnUserMisc.uploadBytesBCD[i]:=cb.uploadBytesBCD[i]
      ENDFOR
      loggedOnUser.bytesDownload:=convertFromBCD(loggedOnUserMisc.downloadBytesBCD)
      loggedOnUser.bytesUpload:=convertFromBCD(loggedOnUserMisc.uploadBytesBCD)
      loggedOnUser.uploads:=cb.upload
      loggedOnUser.downloads:=cb.downloads
      loggedOnUser.secBoard:=cb.ratioType
      loggedOnUser.secLibrary:=cb.ratio
      loggedOnUser.newSinceDate:=cb.newSinceDate
    ENDIF
  ENDIF
  loggedOnUser.messagesPosted:=cb.messagesPosted

  IF(newSinceFlag) THEN cb.newSinceDate:=getSystemTime()
  lastMsgReadConf:=cb.confYM
  lastNewReadConf:=cb.confRead
ENDPROC

PROC saveMsgPointers(conf,msgBase)
  DEF cb: PTR TO confBase
  DEF debug[255]:STRING
  DEF i

  IF(loggedOnUser.slotNumber<=0) OR (conf<1) OR (msgBase<1)
    lastMsgReadConf:=0
    lastNewReadConf:=0
    RETURN
  ENDIF

  cb:=confBases.item(getConfIndex(conf,msgBase))

  IF (checkSecurity(ACS_CONFERENCE_ACCOUNTING))
    IF (readToolTypeInt(TOOLTYPE_CONF,conf,'CONFDB_SHARED')<=0)
      cb.bytesDownload:=loggedOnUser.bytesDownload
      cb.bytesUpload:=loggedOnUser.bytesUpload
      FOR i:=0 TO 7
        cb.downloadBytesBCD[i]:=loggedOnUserMisc.downloadBytesBCD[i]
        cb.uploadBytesBCD[i]:=loggedOnUserMisc.uploadBytesBCD[i]
      ENDFOR
      cb.upload:=loggedOnUser.uploads
      cb.downloads:=loggedOnUser.downloads
      cb.ratioType:=loggedOnUser.secBoard
      cb.ratio:=loggedOnUser.secLibrary
    ENDIF
  ENDIF
  cb.messagesPosted:=loggedOnUser.messagesPosted

  IF(newSinceFlag) THEN cb.newSinceDate:=getSystemTime()

  IF (lastMsgReadConf=0)
    StringF(debug,'error putting last message read conf \d: value \d',conf,lastMsgReadConf)
    errorLog(debug)
    IF loggedOnUser<>NIL
      StringF(debug,'user = \s',loggedOnUser.name)
      errorLog(debug)
    ELSE
      StrCopy(debug,'user = nil')
      errorLog(debug)
    ENDIF
  ENDIF

  IF (lastNewReadConf=0)
    StringF(debug,'error putting last message new conf \d: value \d',conf,lastNewReadConf)
    errorLog(debug)
    IF loggedOnUser<>NIL
      StringF(debug,'user = \s',loggedOnUser.name)
      errorLog(debug)
    ELSE
      StrCopy(debug,'user = nil')
      errorLog(debug)
    ENDIF
  ENDIF

  cb.confYM:=lastMsgReadConf
  cb.confRead:=lastNewReadConf
ENDPROC

PROC joinConf(conf, msgBaseNum,confScan, auto, forceMailScan=FORCE_MAILSCAN_NOFORCE)
  DEF string[255]:STRING,tempstr[255]:STRING
  DEF namestr1[255]:STRING
  DEF namestr2[255]:STRING
  DEF quietJoin
  DEF mystat, temp

  IF (checkConfAccess(conf)=FALSE) THEN conf:=1
  IF((conf<1) OR (conf>cmds.numConf)) THEN conf:=1
  WHILE (conf<=cmds.numConf) ANDALSO (checkConfAccess(conf)=FALSE)
    conf++
  ENDWHILE

  IF (conf>cmds.numConf)
    aePuts('\b\nYou do not have access to any conferences on this BBS\b\n')
    aePuts('Disconnecting..\b\n')
    reqState:=REQ_STATE_LOGOFF
    RETURN
  ENDIF

  IF (msgBaseNum<1 ) OR (msgBaseNum>getConfMsgBaseCount(conf)) THEN msgBaseNum:=1

  IF confScan=FALSE
    currentConf:=conf
    currentMsgBase:=msgBaseNum
  ENDIF
  
  getConfName(conf,currentConfName)
  getConfLocation(conf,currentConfDir)
  checkPathSlash(currentConfDir)

  maxDirs:=readToolTypeInt(TOOLTYPE_CONF,conf,'NDIRS')

  quietJoin:=checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'QUIET_JOIN')

  IF checkToolTypeExists(TOOLTYPE_CONF,conf,'FREEDOWNLOADS') THEN freeDownloads:=TRUE ELSE freeDownloads:=FALSE

  StrCopy(menuPrompt,'')
  readToolType(TOOLTYPE_CONF,conf,'MENU_PROMPT',menuPrompt)

  getMsgBaseLocation(conf,msgBaseNum,msgBaseLocation)

  confNameType:=NAME_TYPE_USERNAME
  StringF(namestr1,'REALNAME.\d',msgBaseNum)
  StringF(namestr2,'INTERNETNAME.\d',msgBaseNum)
  IF checkToolTypeExists(TOOLTYPE_CONF,conf,'REALNAME') OR checkToolTypeExists(TOOLTYPE_MSGBASE,conf,namestr1)
    confNameType:=NAME_TYPE_REALNAME
  ELSEIF checkToolTypeExists(TOOLTYPE_CONF,conf,'INTERNETNAME') OR checkToolTypeExists(TOOLTYPE_MSGBASE,conf,namestr2)
    confNameType:=NAME_TYPE_INTERNETNAME
  ENDIF

  loadMsgPointers(conf,msgBaseNum)

  IF checkToolTypeExists(TOOLTYPE_CONF,conf,'CUSTOM')=FALSE
    mystat:=getMailStatFile(conf,msgBaseNum)
    IF(mystat=RESULT_FAILURE)
      lastMsgReadConf:=0
      lastNewReadConf:=0
      mailStat.lowestKey:=0
      mailStat.lowestNotDel:=0
      mailStat.highMsgNum:=0
    ENDIF
    IF(lastMsgReadConf<mailStat.lowestNotDel) THEN lastMsgReadConf:=mailStat.lowestNotDel
    IF(lastNewReadConf<mailStat.lowestNotDel) THEN lastNewReadConf:=mailStat.lowestNotDel

    IF(lastMsgReadConf>mailStat.highMsgNum)
      StringF(string,'error setting last message read: value \d, high msg num \d',lastMsgReadConf,mailStat.highMsgNum)
      errorLog(string)
      lastMsgReadConf:=0
    ENDIF
    IF(lastNewReadConf>mailStat.highMsgNum)
      StringF(string,'error setting last new read read: value \d, high msg num \d',lastNewReadConf,mailStat.highMsgNum)
      errorLog(string)
      lastNewReadConf:=0
    ENDIF
  ENDIF

  StrCopy(confScreenDir,currentConfDir)
  readToolType(TOOLTYPE_CONF,conf,'SCREENS',confScreenDir)
  checkPathSlash(confScreenDir)

  IF(confScan=FALSE)
    StrCopy(currentMenuName,'')
    IF displayScreen(SCREEN_CONF_BULL)
      temp:=doPause()
      IF(temp<0) THEN RETURN temp
    ENDIF

    relConfNum:=relConf(conf)

    IF quietJoin=FALSE THEN aePuts('\b\n')
    IF (auto)
      scanHoldDesc()
      processSysCommand('S')
      IF getConfMsgBaseCount(conf)>1
        getMsgBaseName(conf,msgBaseNum,tempstr)
        StringF(string,'Conference \d: \s [\s] Auto-ReJoined',relConfNum,currentConfName,tempstr)
      ELSE
        StringF(string,'Conference \d: \s Auto-ReJoined',relConfNum,currentConfName)
      ENDIF
      IF quietJoin=FALSE THEN aePuts(string)
    ELSE
      IF getConfMsgBaseCount(conf)>1
        getMsgBaseName(conf,msgBaseNum,tempstr)
        StringF(string,'[32mJoining Conference[33m:[0m \s [\s]',currentConfName,tempstr)
        IF quietJoin=FALSE THEN aePuts(string)
        StringF(string,'\s [\s] (\d) Conference Joined',currentConfName,tempstr,conf)
      ELSE
        StringF(string,'[32mJoining Conference[33m:[0m \s',currentConfName)
        IF quietJoin=FALSE THEN aePuts(string)
        StringF(string,'\s (\d) Conference Joined',currentConfName,conf)
      ENDIF
    ENDIF
    IF quietJoin=FALSE THEN aePuts('\b\n')
    StringF(tempstr,'\t\s',string)
    callersLog(tempstr)

    IF (quietJoin=FALSE)
      IF checkToolTypeExists(TOOLTYPE_CONF,conf,'CUSTOM')=FALSE
        IF(mailStat.lowestKey>1)

          StringF(string,'[32mMessages range from [33m( [0m\d [32m- [0m\d [33m)[0m\b\n',
                     mailStat.lowestKey,mailStat.highMsgNum-1)
        ELSE
          StringF(string,'\b\n[32mTotal messages           [33m:[0m \d\b\n',mailStat.highMsgNum-1)
        ENDIF
        aePuts(string)

        temp:=lastNewReadConf-1
        IF(temp<0) THEN temp:=1
        StringF(string,'\b\n[32mLast message auto scanned[33m:[0m \d\b\n',temp)
        aePuts(string)

        StringF(string,'[32mLast message read        [33m:[0m \d\b\n',lastMsgReadConf)
        aePuts(string)
      ELSE
        customMsgbaseCmd(MAIL_STATS,conf,0)
      ENDIF
    ENDIF

    IF (auto) THEN displaySysopULStats()

  ENDIF

  IF (auto=FALSE) AND (forceMailScan<>FORCE_MAILSCAN_SKIP)
    IF (forceMailScan=FORCE_MAILSCAN_ALL) OR (checkMailConfScan(conf, msgBaseNum))
      IF checkToolTypeExists(TOOLTYPE_CONF,conf,'CUSTOM')=FALSE
        mystat:=callMsgFuncs(MAIL_SCAN,conf, msgBaseNum)
      ELSE
        customMsgbaseCmd(MAIL_SCAN,conf,0)
      ENDIF
      saveMsgPointers(conf,msgBaseNum)
    ENDIF
  ENDIF

  IF (auto=FALSE) AND (confScan=FALSE)
    IF (reqState<>REQ_STATE_NONE) THEN RETURN mystat
    IF(logonType>=LOGON_TYPE_REMOTE)
      IF(checkCarrier()=FALSE) THEN RETURN mystat
    ENDIF
    loggedOnUser.confRJoin:=conf
    loggedOnUser.msgBaseRJoin:=msgBaseNum
    createNodeUserFiles()
  ENDIF
ENDPROC mystat

PROC doPause()
  DEF ch
  IF reqState<>REQ_STATE_NONE THEN RETURN
  aePuts('\b\n[32m([33mPause[32m)[34m...[32mSpace To Resume[33m: [0m')
  REPEAT
    ch:=readChar(INPUT_TIMEOUT)
  UNTIL (ch=13) OR (ch=32) OR (ch<0) OR (reqState<>REQ_STATE_NONE)
  lineCount:=0
  aePuts('\b\n')
  IF reqState<>REQ_STATE_NONE THEN ch:=RESULT_NO_CARRIER
  IF ch<0 THEN RETURN ch
ENDPROC 0

PROC readChar(timeout, extsig = 0, raw=FALSE)
  DEF wasControl,ch
  DEF timedout,signalled
  DEF tempstr[100]:STRING

  conCursorOn()
  REPEAT
    wasControl,ch:=processInputMessage(timeout, extsig,raw)
    timedout:=(ch=RESULT_TIMEOUT)
    signalled:=(ch=RESULT_SIGNALLED)
  UNTIL (((wasControl=FALSE) OR (raw)) AND (ch<>0)) OR (reqState<>REQ_STATE_NONE) OR (timedout) OR (signalled)
  conCursorOff()

  IF signalled THEN ch:=0
  IF timedout THEN ch:=RESULT_TIMEOUT
  IF reqState<>REQ_STATE_NONE THEN ch:=RESULT_NO_CARRIER
  
  IF inputLogging
    IF ch<32
      StringF(tempstr,'\tUser Input: \d',ch)
    ELSE
      StringF(tempstr,'\tUser Input: \c',ch)
    ENDIF
    callersLog(tempstr)
  ENDIF
ENDPROC ch

PROC checkForPause()
  DEF linelen
  DEF input[3]:STRING

  IF loggedOnUser=NIL THEN RETURN RESULT_SUCCESS
  
  linelen:=userLineLen
  IF linelen=0 THEN linelen:=22

  IF(nonStopDisplayFlag=FALSE) THEN lineCount++
  IF((nonStopDisplayFlag=FALSE) AND (lineCount>=linelen))
    lineCount:=0
    aePuts('(Pause)...More(y/n/ns)? ')
    lineInput('','',3,INPUT_TIMEOUT,input)

    IF((input[0]="N") OR (input[0]="n"))
      IF((input[1]="S") OR (input[1]="s")) THEN nonStopDisplayFlag:=TRUE ELSE RETURN RESULT_FAILURE
    ENDIF
    aePuts('[1A[K')
  ENDIF
ENDPROC RESULT_SUCCESS

PROC sendChar(n)
  DEF c[1]:STRING
  StrCopy(c,' ')
  c[0]:=n
  aePuts(c)
ENDPROC

PROC send017()
  DEF chr[1]:STRING
  StrCopy(chr,' ')
  chr[0]:=15
  aePuts(chr)
ENDPROC

PROC conCLS()
  DEF cls[1]:STRING
  StrCopy(cls,' ')
  cls[0]:=12
  conPuts(cls)
ENDPROC

PROC sendCLS()
  DEF cls[1]:STRING
  StrCopy(cls,' ')
  cls[0]:=12
  aePuts(cls)
ENDPROC

PROC sendBELL()
  DEF bell[1]:STRING
  StrCopy(bell,' ')
  bell[0]:=7
  aePuts(bell)
ENDPROC

PROC sendBackspace()
  DEF c[1]:STRING
  StrCopy(c,' ')
  c[0]:=8
  aePuts(c)
ENDPROC

PROC blankLines(n)
  DEF stats

  WHILE n
    aePuts('\b\n')
    IF(stats:=checkForPause())
      aePuts('\b\n')
      RETURN stats
    ENDIF
    n--
  ENDWHILE
ENDPROC

PROC processMciCmd(mcidata,len,pos,outdata = NIL)
  DEF cmd[100]:STRING
  DEF num[4]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF filename[100]:STRING
  DEF screenfilename[100]:STRING
  DEF maxLen,nval,res
  DEF t=0,i
  DEF item:PTR TO flagFileItem

  IF (mcidata[pos]="~")
    pos:=pos+1

    WHILE (EstrLen(num)<3) AND (pos<len) AND (mcidata[pos]>="0") AND (mcidata[pos]<="9")
      StrAdd(num,' ')
      num[EstrLen(num)-1]:=mcidata[pos]
      pos:=pos+1
    ENDWHILE

    nval:=InStr(mcidata,' ',pos)
    IF nval<0 THEN nval:=len
    maxLen:=InStr(mcidata,mciterminator,pos)
    IF maxLen<0 THEN maxLen:=len ELSE t:=1
    IF nval<maxLen
      maxLen:=nval
      t:=0
    ENDIF

    midStr2(cmd,mcidata,pos,maxLen-pos)
    IF EstrLen(num)>0 THEN maxLen:=Val(num) ELSE maxLen:=-1

    IF (StrCmp(cmd,''))
      pos:=pos+t
    ELSEIF (StrCmp(cmd,'N'))
      pos:=pos+1+t
      StrCopy(tempstr,loggedOnUser.name)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'UL'))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUser.location)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'P'))
      ->do nothing with password
      pos:=pos+1+t
    ELSEIF (StrCmp(cmd,'#'))
      pos:=pos+1+t
      StrCopy(tempstr,loggedOnUser.phoneNumber)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'TC'))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.timesCalled AND $FFFF)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'TT'))
      pos:=pos+2+t
      StringF(tempstr,'\d',getTodaysCalls(loggedOnUser,loggedOnUserKeys))
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'LC'))
      pos:=pos+2+t
      formatLongDateTime(loggedOnUser.timeLastOn,tempstr)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'M'))
      pos:=pos+1+t
      StringF(tempstr,'\d',loggedOnUser.messagesPosted AND $FFFF)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'A'))
      pos:=pos+1+t
      StringF(tempstr,'\d',loggedOnUser.secStatus)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'S'))
      pos:=pos+1+t
      StringF(tempstr,'\d',loggedOnUser.slotNumber)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'CA'))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUser.conferenceAccess)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'BR'))
      pos:=pos+2+t
      StringF(tempstr,'\d',onlineBaud)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'HW'))
      pos:=pos+2+t
      StrCopy(tempstr,computerTypes.item(loggedOnUser.secBulletin))
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'TL'))
      pos:=pos+2+t
      StringF(tempstr,'\d',Div(loggedOnUser.timeLimit,60))
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'TR'))
      pos:=pos+2+t
      StringF(tempstr,'\d',Div(timeLimit,60))
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'UB'))
      pos:=pos+2+t
      formatBCD(loggedOnUserMisc.uploadBytesBCD,tempstr)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'DB'))
      pos:=pos+2+t
      formatBCD(loggedOnUserMisc.downloadBytesBCD,tempstr)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'SU'))
      pos:=pos+2+t
      calcSizeText(loggedOnUserMisc.uploadBytesBCD,tempstr)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'SD'))
      pos:=pos+2+t
      calcSizeText(loggedOnUserMisc.downloadBytesBCD,tempstr)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'FU'))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.uploads AND $FFFF)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'FD'))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.downloads AND $FFFF)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'BD'))
      pos:=pos+2+t
      StringF(tempstr,'\d',loggedOnUser.todaysBytesLimit)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'LG')) OR (StrCmp(cmd,'ON'))
      pos:=pos+2+t
      StringF(tempstr,'\d',node)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'IN'))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUserMisc.internetName)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'RN'))
      pos:=pos+2+t
      StrCopy(tempstr,loggedOnUserMisc.realName)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'OD'))
      pos:=pos+2+t
      formatLongDate(logonTime,tempstr)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'OT'))
      pos:=pos+2+t
      formatLongTime(logonTime,tempstr)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'SC'))
      pos:=pos+2+t
      StringF(tempstr,'\d',getCallerCount())
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'VE'))
      IF outdata=NIL THEN aePuts2(expressVer,maxLen) ELSE StrAdd(outdata,expressVer,maxLen)
      pos:=pos+2+t
    ELSEIF (StrCmp(cmd,'VD'))
      IF outdata=NIL THEN aePuts2(expressDate,maxLen) ELSE StrAdd(outdata,expressDate,maxLen)
      pos:=pos+2+t
    ELSEIF (StrCmp(cmd,'ND'))
      StringF(tempstr,'\d',node)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)    
      pos:=pos+2+t     
    ELSEIF (StrCmp(cmd,'CF'))
      StringF(tempstr,'\d',relConfNum)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)    
      pos:=pos+2+t     
    ELSEIF (StrCmp(cmd,'CN'))
      IF outdata=NIL THEN aePuts2(currentConfName,maxLen) ELSE StrAdd(outdata,currentConfName,maxLen)    
      pos:=pos+2+t     
    ELSEIF (StrCmp(cmd,'MB'))
      StringF(tempstr,'\d',currentMsgBase)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)    
      pos:=pos+2+t     
    ELSEIF (StrCmp(cmd,'MN'))
      getMsgBaseName(currentConf,currentMsgBase,tempstr)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)    
      pos:=pos+2+t     
    ELSEIF (StrCmp(cmd,'AK'))
      pos:=pos+2+t
      IF outdata=NIL THEN displayKeys()
    ELSEIF (StrCmp(cmd,'CT'))
      pos:=pos+2+t
      formatLongTime(logonTime,tempstr)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'DT'))
      pos:=pos+2+t
      formatLongDate(getSystemTime(),tempstr)
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'FF'))
      pos:=pos+2+t
      IF outdata=NIL THEN showFlaggedFiles(maxLen)
    ELSEIF (StrCmp(cmd,'FC'))
      pos:=pos+2+t
      StringF(tempstr,'\d',flagFilesList.count())
      IF outdata=NIL THEN aePuts2(tempstr,maxLen) ELSE StrAdd(outdata,tempstr,maxLen)
    ELSEIF (StrCmp(cmd,'FL'))
      pos:=pos+2+t
      IF outdata=NIL
        FOR i:=0 TO flagFilesList.count()-1
          item:=flagFilesList.item(i)
          StringF(tempstr,'                     \s\b\n',item.fileName)
          aePuts(tempstr)
        ENDFOR
      ENDIF
    ELSEIF (maxLen=-1) AND (StrCmp(cmd,'SP'))
      ->PAUSE
      pos:=pos+2+t
      IF outdata=NIL 
        res:=doPause()
        IF res<>RESULT_SUCCESS THEN RETURN res
      ENDIF
    ELSEIF (maxLen=-1) AND (StrCmp(cmd,'CR'))
      ->PAUSE
      pos:=pos+2+t
      IF outdata=NIL 
        res:=readChar(INPUT_TIMEOUT)
        IF res<>RESULT_SUCCESS THEN RETURN res
      ENDIF
    ELSEIF StrCmp(cmd,'f')
      IF outdata=NIL THEN sendCLS()
      pos:=pos+1+t
    ELSEIF StrCmp(cmd,'w')
      IF outdata=NIL
        IF maxLen<0 THEN maxLen:=1
        Delay(maxLen)
      ENDIF
      pos:=pos+1+t
    ELSEIF StrCmp(cmd,'x',1)
      IF outdata=NIL
        maxLen:=Val(mcidata+pos+1)
        IF maxLen>=0
          StringF(tempstr,'[;\dH',maxLen)
          aePuts(tempstr)
        ENDIF
      ENDIF
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'y',1)
      IF outdata=NIL
        maxLen:=Val(mcidata+pos+1)
        IF maxLen>=0
          StringF(tempstr,'[\d;H',maxLen)
          aePuts(tempstr)
        ENDIF
      ENDIF
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'SS_',3)
      ->display another file
      pos:=pos+3
      IF outdata=NIL
        nval:=EstrLen(cmd)-3
        midStr2(cmd,mcidata,pos,nval)
        displayFile(cmd)
      ENDIF
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'SX_',3)
      ->sequential file display
      pos:=pos+3
      IF outdata=NIL
        nval:=EstrLen(cmd)-3
        midStr2(cmd,mcidata,pos,nval)
        nval:=readIntFromFile(cmd)
        IF nval<>-1
          nval++
          StrCopy(tempstr,cmd,FilePart(cmd)-cmd)
          StringF(filename,'\s\z\r\d[3].\s',tempstr,nval,FilePart(cmd))
          IF findSecurityScreen(filename,screenfilename)
            displayFile(screenfilename)
          ELSE
            nval:=-1
          ENDIF
        ENDIF

        IF nval=-1
          nval:=1
          StringF(filename,'\s\z\r\d[3].\s',tempstr,nval,FilePart(cmd))
          IF findSecurityScreen(filename,screenfilename)
            displayFile(screenfilename)
          ENDIF
        ENDIF
        writeIntToFile(cmd,nval)
      ENDIF
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'SR_',3)
      ->display random file
      pos:=pos+3
      IF outdata=NIL
        nval:=Val(num)
        StringF(tempstr,'random \d',nval)
        debugLog(LOG_DEBUG,tempstr)
        nval:=Rnd(nval)
        StringF(tempstr,'random result \d',nval)
        debugLog(LOG_DEBUG,tempstr)
        maxLen:=EstrLen(cmd)-3
        -> get full filename
        midStr2(cmd,mcidata,pos,maxLen)
        StrCopy(tempstr,cmd,FilePart(cmd)-cmd)
        StringF(filename,'\z\r\d[3].\s',nval+1,FilePart(cmd),screenfilename)
        StrAdd(tempstr, filename)

        findSecurityScreen(tempstr,screenfilename)

        displayFile(screenfilename)
      ENDIF
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'CC_',3)
      ->run a command
      pos:=pos+3
      IF outdata=NIL
        nval:=EstrLen(cmd)-3
        midStr2(cmd,mcidata,pos,nval)
        processSysCommand(cmd,TRUE)
      ENDIF
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrCmp(cmd,'CR_',3)
      ->promted keypress
      pos:=pos+3
      IF outdata=NIL
        nval:=EstrLen(cmd)-3
        midStr2(cmd,mcidata,pos,nval)
        aePuts(cmd)
        res:=readChar(INPUT_TIMEOUT)
        IF res<>RESULT_SUCCESS THEN RETURN res
      ENDIF
      pos:=pos+nval+t
    ELSEIF StrCmp(cmd,'SM_',3)
      pos:=pos+3
      IF outdata=NIL
        nval:=EstrLen(cmd)-3
        midStr2(currentMenuName,mcidata,pos,nval)
      ENDIF
      pos:=pos+EstrLen(currentMenuName)+t
    ELSEIF StrCmp(cmd,'q')
      pos:=pos+1+t
      IF outdata=NIL THEN aePuts('[0m')
    ELSEIF StrCmp(cmd,'h')
      pos:=pos+1+t
      IF outdata=NIL THEN sendBackspace()
    ELSEIF StrCmp(cmd,'CL')
      pos:=pos+2+t
      IF outdata=NIL
        num:=0
        FOR nval:=1 TO cmds.numConf
          IF((checkConfAccess(nval)=TRUE) OR (sopt.toggles[TOGGLES_CONFRELATIVE]=FALSE))
            num++
            StringF(tempstr,'                     [32m\d[3][33m) [35m',num)
            aePuts(tempstr)
            getConfName(nval,tempstr)
            res:=StrLen(tempstr)
            WHILE(res<30)
              aePuts(' ')
              res++
            ENDWHILE
            StringF(tempstr2,'[36m\s[0m\b\n',tempstr)
            aePuts(tempstr2)
          ENDIF
        ENDFOR
      ENDIF
    ELSEIF StrCmp(cmd,'CD')
      pos:=pos+2+t
      IF outdata=NIL
        num:=0
        FOR nval:=1 TO cmds.numConf
          IF((checkConfAccess(nval)=TRUE) OR (sopt.toggles[TOGGLES_CONFRELATIVE]=FALSE))
            num++
            StringF(tempstr,'   [34m[[0m\r\z\d[3][34m] [0m\l\s[30]',num,getConfName(nval))
            aePuts(tempstr)
            IF (num AND 1)=0 THEN aePuts('\b\n')
          ENDIF
        ENDFOR
      ENDIF
    ELSEIF StrCmp(cmd,'ML')
      pos:=pos+2+t
      IF outdata=NIL
        num:=getConfMsgBaseCount(currentConf)
        FOR nval:=1 TO num
          StringF(tempstr,'                     [32m\d[3][33m) [35m',nval)
          aePuts(tempstr)
          getMsgBaseName(currentConf,nval,tempstr)
          IF (num=1) AND (StrLen(tempstr)=0) THEN StrCopy(tempstr,'Default')
          res:=StrLen(tempstr)
          WHILE(res<30)
            aePuts(' ')
            res++
          ENDWHILE
          StringF(tempstr2,'[36m\s[0m\b\n',tempstr)
          aePuts(tempstr2)
        ENDFOR
      ENDIF
    ELSEIF StrCmp(cmd,'MD')
      pos:=pos+2+t
      IF outdata=NIL
        num:=getConfMsgBaseCount(currentConf)
        FOR nval:=1 TO num
          getMsgBaseName(currentConf,nval,tempstr2)
          IF (num=1) AND (StrLen(tempstr2)=0) THEN StrCopy(tempstr2,'Default')
          StringF(tempstr,'   [34m[[0m\r\z\d[3][34m] [0m\l\s[30]',nval,tempstr2)
          aePuts(tempstr)
          IF (nval AND 1)=0 THEN aePuts('\b\n')
        ENDFOR
      ENDIF
    ELSEIF StrCmp(cmd,'c0')
      IF outdata=NIL THEN aePuts('[30m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c1')
      IF outdata=NIL THEN aePuts('[31m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c2')
      IF outdata=NIL THEN aePuts('[32m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c3')
      IF outdata=NIL THEN aePuts('[33m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c4')
      IF outdata=NIL THEN aePuts('[34m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c5')
      IF outdata=NIL THEN aePuts('[35m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c6')
      IF outdata=NIL THEN aePuts('[36m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'c7')
      IF outdata=NIL THEN aePuts('[37m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b0') OR StrCmp(cmd,'z0')
      IF outdata=NIL THEN aePuts('[40m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b1') OR StrCmp(cmd,'z1')
      IF outdata=NIL THEN aePuts('[41m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b2') OR StrCmp(cmd,'z2')
      IF outdata=NIL THEN aePuts('[42m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b3') OR StrCmp(cmd,'z3')
      IF outdata=NIL THEN aePuts('[43m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b4') OR StrCmp(cmd,'z4')
      IF outdata=NIL THEN aePuts('[44m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b5') OR StrCmp(cmd,'z5')
      IF outdata=NIL THEN aePuts('[45m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b6') OR StrCmp(cmd,'z6')
      IF outdata=NIL THEN aePuts('[46m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'b7') OR StrCmp(cmd,'z7')
      IF outdata=NIL THEN aePuts('[47m')
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n1')
      IF outdata=NIL THEN blankLines(1)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n2')
      IF outdata=NIL THEN blankLines(2)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n3')
      IF outdata=NIL THEN blankLines(3)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n4')
      IF outdata=NIL THEN blankLines(4)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n5')
      IF outdata=NIL THEN blankLines(5)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n6')
      IF outdata=NIL THEN blankLines(6)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n7')
      IF outdata=NIL THEN blankLines(7)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n8')
      IF outdata=NIL THEN blankLines(8)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'n9')
      IF outdata=NIL THEN blankLines(9)
      pos:=pos+2+t
    ELSEIF StrCmp(cmd,'SMO',3)
      pos:=pos+3
      IF outdata=NIL
        slowmo:=1
        slowmoCount:=slowmoCount+(60*slowmo)      
        nval:=EstrLen(cmd)-3
        midStr2(cmd,mcidata,pos,nval)
        slowmo:=Val(cmd)
        IF (slowmo<1) OR (slowmo>5) THEN slowmo:=1
      ENDIF
      pos:=pos+nval+t
    ELSEIF StrCmp(cmd,'SMC')
      IF outdata=NIL THEN slowmo:=0
      pos:=pos+3+t
    ELSEIF StrCmp(cmd,'NS')
      IF outdata=NIL THEN nonStopDisplayFlag:=TRUE
      pos:=pos+2+t
    ELSEIF (StrCmp(cmd,'D',1))
      ->this needs to be near the end otherwise it might pick up other commands starting with D
      pos:=pos+1+t
      MidStr(cmd,mcidata,pos)
      StrCopy(mciterminator,cmd)
      pos:=pos+StrLen(cmd)
    ELSEIF StrCmp(cmd,'~',1)
      IF outdata=NIL THEN aePuts(cmd) ELSE StrAdd(outdata,cmd)
      pos:=pos+EstrLen(cmd)+t
    ELSEIF StrLen(cmd)=0
      pos:=pos+t
    ELSE
      ->unknown mci
      IF outdata=NIL
        aePuts('~')
        aePuts(num)
      ELSE
        StrAdd(outdata,'~')
        StrAdd(outdata,num)
      ENDIF
    ENDIF
  ENDIF

ENDPROC pos

->process mci string and either output to outdata or send to screen/serial if outdata=NIL
PROC processMci(mcidata,outdata=NIL)
  DEF pos=0,cmdpos,len

  IF outdata=NIL
    IF (mciViewSafe=FALSE) AND ((checkSecurity(ACS_MCI_MSG)=FALSE) OR (sopt.toggles[TOGGLES_NOMCIMSGS]=TRUE)) THEN RETURN
  ELSE
    StrCopy(outdata,'')
  ENDIF

  len:=EstrLen(mcidata)
  IF len=0
    RETURN
  ENDIF

  WHILE (pos>=0) AND (pos<len)
    IF (outdata=NIL) AND (reqState<>REQ_STATE_NONE) THEN RETURN
    IF (cmdpos:=InStr(mcidata,'~',pos))<0
      IF outdata=NIL
        aePuts(mcidata+pos)
      ELSE
        StrAdd(outdata,mcidata+pos)
      ENDIF
      pos:=EstrLen(mcidata)
    ELSE
      IF outdata=NIL
        aePuts2(mcidata+pos,cmdpos-pos)
      ELSE
        StrAdd(outdata,mcidata+pos,cmdpos-pos)
      ENDIF
      pos:=pos+(cmdpos-pos)
      pos:=processMciCmd(mcidata,len,pos,outdata)
    ENDIF
  ENDWHILE
ENDPROC

PROC startASend()
  DEF str[100]:STRING

  IF(logonType>=LOGON_TYPE_REMOTE)
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SER_OUT]:=0
  ENDIF
  
  asl(str)
  IF(logonType>=LOGON_TYPE_REMOTE)
      ioFlags[IOFLAG_SER_IN]:=-1
      ioFlags[IOFLAG_SER_OUT]:=-1
  ENDIF
  IF StrLen(str)>0 THEN displayFile(str)
ENDPROC

PROC startCapture()
  DEF stat
  DEF str[100]:STRING
  DEF oldflag1,oldflag2

  IF(captureFP)
        Close(captureFP)
        captureFP:=NIL
        conPuts('\b\nCapture closed!\b\n')
  ELSE
redo:
    conPuts('\b\nOpen capture, path/filename: ')

    oldflag1:=ioFlags[IOFLAG_SER_OUT]
    oldflag2:=ioFlags[IOFLAG_SER_IN]
    ioFlags[IOFLAG_SER_OUT]:=FALSE
    ioFlags[IOFLAG_SER_IN]:=FALSE
      stat:=lineInput('','',99,INPUT_TIMEOUT,str)
    ioFlags[IOFLAG_SER_OUT]:=oldflag1
    ioFlags[IOFLAG_SER_IN]:=oldflag2

    IF((stat<0) OR (StrLen(str)=0))   THEN RETURN
    captureFP:=Open(str,MODE_NEWFILE)
    IF(captureFP=0)
      conPuts('ERROR: can''t open ')
      conPuts(str)
      conPuts(' for writing!  Try another!\b\n')
      JUMP redo
    ELSE
      conPuts('[A[KCapture opened!\b\n')
    ENDIF
  ENDIF
ENDPROC

PROC tranChat()
  DEF whichCon,whichSer

  DEF tempstr1[255]:STRING
  DEF tempstr2[255]:STRING
  DEF trans1: PTR TO translator
  DEF trans2: PTR TO translator
  DEF str[255]:STRING
  DEF str2[255]:STRING

  DEF canTransUserToHost=FALSE
  DEF canTransHostToUser=FALSE
  DEF chatfile[255]:STRING
  DEF c,serLineLen=0,conLineLen=0,cnt

  pagedFlag:=0

  StringF(tempstr1,'\s\s',hostLanguage,userLanguage)

  trans1:=getTranslator(tempstr1)
  IF trans1<>NIL
    canTransHostToUser:=TRUE
  ENDIF

  StringF(tempstr1,'\s\s',userLanguage,hostLanguage)

  trans2:=getTranslator(tempstr1)
  IF trans2<>NIL
    canTransUserToHost:=TRUE
  ENDIF

  aePuts('\b\n')

  runSysCommand('CHATIN','')

  StrCopy(chatfile,'')
  IF (loggedOnUser.screenType<screenTypeExt.count())
    StringF(chatfile,'\sNode\d/StartChat.\s',cmds.bbsLoc,node,screenTypeExt.item(loggedOnUser.screenType))
    IF fileExists(chatfile)=FALSE THEN StrCopy(chatfile,'')
  ENDIF
  IF StrLen(chatfile)=0
    StringF(chatfile,'\sNode\d/StartChat.txt',cmds.bbsLoc,node)
  ENDIF

  IF((displayFile(chatfile,TRUE,TRUE)))=FALSE
    aePuts('\b\n\b\nThis is ')
    aePuts(cmds.sysopName)
    aePuts(', How can I help you??\b\n\b\n')
  ENDIF

  StrCopy(translatorLanguage,userLanguage)

  StringF(str,'[32mTranslation \s to \s: \s[0m\b\n',hostLanguage,userLanguage,IF(canTransHostToUser) THEN '[33mACTIVE' ELSE '[31mNOT AVAILABLE')
  aePuts(str)
  StringF(str,'[32mTranslation \s to \s: \s[0m\b\n',userLanguage,hostLanguage,IF(canTransUserToHost) THEN '[33mACTIVE' ELSE '[31mNOT AVAILABLE')
  aePuts(str)
  aePuts('\b\n')

  IF(ansiColour)
    StringF(str,'[\dm',cmds.acLvl[LVL_CHAT_COLOR_SYSOP])
    aePuts(str)
  ENDIF

  chatConFlag:=1
  chatSerFlag:=0

  StrCopy(tempstr1,'')
  StrCopy(tempstr2,'')
  WHILE chatFlag
  tcloop:
    whichCon:=chatConFlag
    whichSer:=chatSerFlag
    c:=readChar(INPUT_TIMEOUT)
    IF(c<0)
      chatFlag:=0
      RETURN c
    ENDIF
    updateTimeUsed()
    checkTimeUsed()
    IF (loggedOnUser.chatLimit<>0) AND (loggedOnUser.chatRemain<=0)  AND (checkSecurity(ACS_OVERRIDE_CHATLIMIT)=FALSE)
      chatFlag:=0
    ENDIF
    EXIT chatFlag=0

    IF((chatConFlag=1) AND (whichSer=1))
      StringF(str,'[\dm',cmds.acLvl[LVL_CHAT_COLOR_SYSOP])
      aePuts(str)
    ENDIF
    IF((chatSerFlag=1) AND (whichCon=1))
      StringF(str,'[\dm',cmds.acLvl[LVL_CHAT_COLOR_USER])
      aePuts(str)
    ENDIF

    IF((c=CHAR_BACKSPACE))
      StringF(str,'\c \c',CHAR_BACKSPACE,CHAR_BACKSPACE)
      IF(chatConFlag)
        IF conLineLen>0
          conPuts(str)
          conLineLen--
          SetStr(tempstr1,StrLen(tempstr1)-1)
        ENDIF
      ENDIF
      IF(chatSerFlag)
        IF serLineLen>0
          serPuts(str)
          serLineLen--
          SetStr(tempstr2,StrLen(tempstr2)-1)
        ENDIF
      ENDIF
      JUMP tcloop
    ELSEIF((c=3) AND (checkSecurity(ACS_BREAK_CHAT)))
      chatFlag:=0
    ELSEIF (c=13) OR (c=32)      ->removed OR (c=10)
      IF chatConFlag
        IF serLineLen>0
          cnt:=serLineLen
          StrCopy(str,'')
          StrCopy(str2,'')
          WHILE cnt>0
            StrAddChar(str,CHAR_BACKSPACE)
            StrAdd(str2,' ')
            cnt--
          ENDWHILE
          serPuts(str)
          serPuts(str2)
          serPuts(str)
        ENDIF
        IF StrLen(tempstr1)>0
          translatorMode:=TRANS_HOST_TO_DEFINED
          translateText(tempstr1)
          serPuts(tempstr1)
          conLineLen:=0
          StrCopy(tempstr1,'')
        ENDIF
        IF c<>32 THEN aePuts('\b\n') ELSE aePuts(' ')
        StringF(str,'[\dm\s[\dm',cmds.acLvl[LVL_CHAT_COLOR_USER],tempstr2,cmds.acLvl[LVL_CHAT_COLOR_SYSOP])
        serPuts(str)
      ELSEIF chatSerFlag
        IF conLineLen>0
          cnt:=conLineLen
          StrCopy(str,'')
          StrCopy(str2,'')
          WHILE cnt>0
            StrAddChar(str,CHAR_BACKSPACE)
            StrAdd(str2,' ')
            cnt--
          ENDWHILE
          conPuts(str)
          conPuts(str2)
          conPuts(str)
        ENDIF
        IF StrLen(tempstr2)>0
          translatorMode:=TRANS_DEFINED_TO_HOST
          translateText(tempstr2)
          conPuts(tempstr2)
          serLineLen:=0
          StrCopy(tempstr2,'')
        ENDIF
        IF c<>32 THEN aePuts('\b\n') ELSE aePuts(' ')
        StringF(str,'[\dm\s[\dm',cmds.acLvl[LVL_CHAT_COLOR_SYSOP],tempstr1,cmds.acLvl[LVL_CHAT_COLOR_USER])
        conPuts(str)
      ENDIF
      JUMP tcloop
    ENDIF

    IF chatConFlag
      StrAddChar(tempstr1,c)
      conPutChar(c)
      conLineLen++
    ENDIF
    IF chatSerFlag
      StrAddChar(tempstr2,c)
      serPutChar(c)
      serLineLen++
    ENDIF
  ENDWHILE

  IF StrLen(tempstr1)>0
    translatorMode:=TRANS_HOST_TO_DEFINED
    translateText(tempstr1)
    serPuts('\b\n\b\n')
    serPuts(tempstr1)
    serPuts('\b\n\b\n')
  ENDIF

  IF StrLen(tempstr2)>0
    translatorMode:=TRANS_DEFINED_TO_HOST
    translateText(tempstr2)
    conPuts('\b\n\b\n')
    conPuts(tempstr2)
    conPuts('\b\n\b\n')
  ENDIF
  translatorMode:=TRANS_NONE

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  IF(ansiColour)    THEN aePuts('[0m')

  StrCopy(chatfile,'')
  IF (loggedOnUser.screenType<screenTypeExt.count())
    StringF(chatfile,'\sNode\d/EndChat.\s',cmds.bbsLoc,node,screenTypeExt.item(loggedOnUser.screenType))
    IF fileExists(chatfile)=FALSE THEN StrCopy(chatfile,'')
  ENDIF
  IF StrLen(chatfile)=0
    StringF(chatfile,'\sNode\d/EndChat.txt',cmds.bbsLoc,node)
  ENDIF

  IF((displayFile(chatfile,TRUE,TRUE)))=FALSE
    aePuts('\b\n\b\nEnding Chat.')
  ENDIF
  runSysCommand('CHATOUT','')

ENDPROC

PROC chat()
  DEF c,x,i,back,whichCon,whichSer
  DEF str[100]:STRING,str2[10]:STRING,space[90]:STRING
  DEF chatfile[255]:STRING

  checkOnlineStatus()

  runSysCommand('CHATIN','')
  StrCopy(chatfile,'')
  IF (loggedOnUser.screenType<screenTypeExt.count())
    StringF(chatfile,'\sNode\d/StartChat.\s',cmds.bbsLoc,node,screenTypeExt.item(loggedOnUser.screenType))
    IF fileExists(chatfile)=FALSE THEN StrCopy(chatfile,'')
  ENDIF
  IF StrLen(chatfile)=0
    StringF(chatfile,'\sNode\d/StartChat.txt',cmds.bbsLoc,node)
  ENDIF

  IF((i:=displayFile(chatfile,TRUE,TRUE)))=FALSE
    aePuts('\b\n\b\nThis is ')
    aePuts(cmds.sysopName)
    aePuts(', How can I help you??\b\n\b\n')
  ENDIF

  pagedFlag:=0
  chatConFlag:=1
  IF(ansiColour)
    StringF(str,'[\dm',cmds.acLvl[LVL_CHAT_COLOR_SYSOP])
    aePuts(str)
  ENDIF

  chatSerFlag:=0
  StrCopy(space,'')
  StrCopy(str,'')
  x:=0
  WHILE(chatFlag)
next:

    whichCon:=chatConFlag
    whichSer:=chatSerFlag
    cnext2:

    c:=readChar(INPUT_TIMEOUT)
    IF(c=HISTORY)   THEN JUMP cnext2

    EXIT chatFlag=0

    IF(c=RESULT_NO_CARRIER)
      chatFlag:=0
      RETURN RESULT_NO_CARRIER
    ENDIF

    IF((c=3) AND (checkSecurity(ACS_BREAK_CHAT)))
      chatFlag:=0
      JUMP chatbrk
    ENDIF

    updateTimeUsed()
    checkTimeUsed()
    IF (loggedOnUser.chatLimit<>0) AND (loggedOnUser.chatRemain<=0)  AND (checkSecurity(ACS_OVERRIDE_CHATLIMIT)=FALSE)
      chatFlag:=0
      JUMP chatbrk
    ENDIF

    IF(c=13)
        IF(captureFP) THEN fileWriteLn(captureFP,space)

      /***** SIMILATES THE F1 'exit chat' routine *****/
      UpperStr(space)

      StrCopy(space,'')
      x:=0
      aePuts('\b\n')
      checkOnlineStatus()
      JUMP cnext2
    ENDIF

    IF(c=CHAR_BACKSPACE)
      IF(x>0)
        x--
        SetStr(space,x)
        sendChar(CHAR_BACKSPACE)
        aePuts(' ')
        sendChar(CHAR_BACKSPACE)

        JUMP cnext2
      ENDIF
      JUMP cnext2
    ENDIF
    IF((c='')OR (c=7))
      sendChar(c)
      JUMP cnext2
    ENDIF

    IF(c<" ")   THEN JUMP cnext2

    x++
    IF(ansiColour)
      IF((chatConFlag=1) AND (whichSer=1))
        StringF(str,'[\dm',cmds.acLvl[LVL_CHAT_COLOR_SYSOP])
        IF(bitPlanes<3) THEN serPuts(str) ELSE aePuts(str)
      ENDIF
      IF((chatSerFlag=1) AND (whichCon=1))
        StringF(str,'[\dm',cmds.acLvl[LVL_CHAT_COLOR_USER])
        IF(bitPlanes<3) THEN serPuts(str) ELSE aePuts(str)
      ENDIF
      sendChar(c)
    ELSE
      sendChar(c)
    ENDIF

    StrCopy(str2,' ')
    str2[0]:=c
    StrAdd(space,str2)

    IF(x>78)
      back:=0
      i:=x
      WHILE i>=0
        IF(space[i-1]=" ")
            back:=x-i
        i:=0
        ENDIF
        i--
      ENDWHILE
      IF(back=0)
        IF(captureFP) THEN fileWriteLn(captureFP,space)

        aePuts('\b\n')
        StrCopy(space,'')
        x:=0
        JUMP next
      ENDIF
      StrCopy(str,'')
      FOR i:=(x-back) TO x-1
        StrCopy(str2,' ')
        str2[0]:=space[i]
        StrAdd(str,str2)
      ENDFOR

      IF(captureFP)
        IF(x-back-1>=0)
          SetStr(space,x-back-1)
        ENDIF
        fileWriteLn(captureFP,space)
      ENDIF

      x:=StrLen(str)
      StrCopy(space,str)
      FOR i:=0 TO x-1
        sendChar(CHAR_BACKSPACE)
        aePuts(' ')
        sendChar(CHAR_BACKSPACE)
      ENDFOR

      aePuts('\b\n')
      aePuts(str)
    ENDIF

chatbrk:
  ENDWHILE

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  IF(ansiColour)    THEN aePuts('[0m')

  StrCopy(chatfile,'')
  IF (loggedOnUser.screenType<screenTypeExt.count())
    StringF(chatfile,'\sNode\d/EndChat.\s',cmds.bbsLoc,node,screenTypeExt.item(loggedOnUser.screenType))
    IF fileExists(chatfile)=FALSE THEN StrCopy(chatfile,'')
  ENDIF
  IF StrLen(chatfile)=0
    StringF(chatfile,'\sNode\d/EndChat.txt',cmds.bbsLoc,node)
  ENDIF

  IF((i:=displayFile(chatfile,TRUE,TRUE)))=FALSE
    aePuts('\b\n\b\nEnding Chat.')
  ENDIF
  runSysCommand('CHATOUT','')
ENDPROC RESULT_SUCCESS

PROC findSecurityScreen(screenDirAndName,screenfileName)
  DEF secLevel
  DEF minLevel=5
  DEF defscr=FALSE

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'DEF_SCREENS')
    minLevel:=5
    defscr:=TRUE
  ENDIF

  ->DEF_SCREENS means find non-security screens first
  IF (defscr)
    IF ripMode
      StringF(screenfileName,'\s\s',screenDirAndName,'.RIP')
      IF fileExists(screenfileName) THEN RETURN TRUE
    ENDIF

    IF loggedOnUser<>NIL
      IF (loggedOnUser.screenType<screenTypeExt.count())
        StringF(screenfileName,'\s\s',screenDirAndName,screenTypeExt.item(loggedOnUser.screenType))
        IF fileExists(screenfileName) THEN RETURN TRUE
      ENDIF
    ENDIF
    StringF(screenfileName,'\s\s',screenDirAndName,'.TXT')
    IF fileExists(screenfileName) THEN RETURN TRUE
  ENDIF

  ->check security screens
  IF (loggedOnUser<>NIL)
    secLevel:=loggedOnUser.secStatus/5*5
    WHILE (secLevel>=minLevel)
      IF ripMode
        StringF(screenfileName,'\s\d\s',screenDirAndName,secLevel,'.RIP')
        IF fileExists(screenfileName) THEN RETURN TRUE
      ENDIF

      IF (loggedOnUser.screenType<screenTypeExt.count())
        StringF(screenfileName,'\s\d\s',screenDirAndName,secLevel,screenTypeExt.item(loggedOnUser.screenType))
        IF fileExists(screenfileName) THEN RETURN TRUE
      ENDIF
      StringF(screenfileName,'\s\d\s',screenDirAndName,secLevel,'.TXT')
      IF fileExists(screenfileName) THEN RETURN TRUE
      secLevel:=secLevel-5
    ENDWHILE
  ENDIF

  ->check non security screens at end if not DEF_SCREENS
  IF (defscr=FALSE)
    IF ripMode
      StringF(screenfileName,'\s\s',screenDirAndName,'.RIP')
      IF fileExists(screenfileName) THEN RETURN TRUE
    ENDIF
    IF loggedOnUser<>NIL
      IF (loggedOnUser.screenType<screenTypeExt.count())
        StringF(screenfileName,'\s\s',screenDirAndName,screenTypeExt.item(loggedOnUser.screenType))
        IF fileExists(screenfileName) THEN RETURN TRUE
      ENDIF
    ENDIF
    StringF(screenfileName,'\s\s',screenDirAndName,'.TXT')
    IF fileExists(screenfileName) THEN RETURN TRUE
  ENDIF

ENDPROC FALSE

PROC suspendBBS(ownDevRequest=FALSE)
  DEF wasopen
  DEF oldstate,oldenvstat
  DEF rexxsig
  DEF tempstr[255]:STRING,tempstr2[255]:STRING


  wasopen:=scropen
  oldstate:=state

  IF rexxmp<>NIL THEN rexxsig:=Shl(1, rexxmp.sigbit)

  oldenvstat:=currentStat
  state:=STATE_SUSPEND
  setEnvStat(ENV_SUSPEND)
  IF scropen THEN closeExpressScreen()

  closeSerial()

  IF ownDevRequest AND serialLocked
    FreeDevUnit(cmds.serDev,cmds.serDevUnit)
  ENDIF

  formatLongDateTime(getSystemTime(),tempstr)
  StringF(tempstr2,'BBS has been suspended at \s',tempstr)
  startLog(tempstr2)

  StringF(tempstr,'Express Node \d',node)
  WHILE(reqState<>REQ_STATE_RESUME)
    IF ownDevRequest AND serialLocked
      IF AttemptDevUnit(cmds.serDev, cmds.serDevUnit, tempstr, ownDevSignal )=FALSE
        reqState:=REQ_STATE_RESUME
      ENDIF
    ELSE
      Wait(rexxsig)
      processRexxMessage()
    ENDIF
  ENDWHILE
  state:=oldstate
  reqState:=REQ_STATE_NONE

  formatLongDateTime(getSystemTime(),tempstr)
  StringF(tempstr2,'BBS has received resume @ \s',tempstr)
  startLog(tempstr2)


  IF(openSerial(cmds.openingBaud,8,1)<>0)
    StringF(shutDownMsg,'Can''t open \s!',cmds.serDev)
    reqState:=REQ_STATE_SHUTDOWN
    RETURN
  ENDIF
  setEnvStat(oldenvstat)

 IF(wasopen)   /* got msg to LICON this (Uniconify this */
   openExpressScreen()
 ENDIF
ENDPROC


PROC displayInitialisingLogo()
  conCLS()
  conCursorOn()
  conPuts('[1;33m\n\n\n\n\n                               Express BBS[0m\n\n')
  conPuts('                             Initializing...')
ENDPROC

PROC checkShutDown()
  IF(shutDownFlag=1)
    ReplyMsg(sdReplyRexx)
    IF netTrans=0
      reqState:=REQ_STATE_SHUTDOWN
      StrCopy(shutDownMsg,'!')
    ENDIF
    netTrans:=0
  ENDIF
  IF(shutDownFlag=2)
    ReplyMsg(sdReplyRexx)
    suspendBBS()
    IF reqState=REQ_STATE_SHUTDOWN THEN RETURN
    displayInitialisingLogo()
    reInitModem()
  ENDIF
  shutDownFlag:=0
ENDPROC

PROC translateWord(translator:PTR TO translator,word)
  DEF words:PTR TO CHAR
  DEF searchWord[255]:STRING
  DEF pos,n
  DEF chr[1]:STRING
  DEF len
  DEF propercaps=FALSE
  DEF allcaps=FALSE
  DEF i

  StringF(searchWord,':\s ',word)
  LowerStr(searchWord)

  MidStr(chr,word,0,1)
  IF (word[0]>="A") AND (word[0]<="Z")
    allcaps:=TRUE
    propercaps:=TRUE
    FOR i:=1 TO EstrLen(word)
      IF (word[i]>="a") AND (word[i]<="z") THEN allcaps:=FALSE
      IF (word[i]>="A") AND (word[i]<="Z") THEN propercaps:=FALSE
    ENDFOR
  ENDIF

  LowerStr(chr)
  IF (chr[0]>="a") AND (chr[0]<="z")
    n:=chr[0]-"a"
    words:=translator.translationIndexes[n]
    len:=translator.translationIndexes[n+1]-words

  ELSE
    words:=translator.translationIndexes[26]
    len:=translator.translationIndexes[27]-words
  ENDIF

  n:=StrLen(searchWord)
  IF (words<>NIL)
    pos:=0
    WHILE pos<len
      IF (StrCmp(words+pos,searchWord,n))
        WHILE words[pos]<>" "
          pos++
        ENDWHILE
        pos++
        StrCopy(word,'')
        WHILE words[pos]<>":"
          MidStr(chr,words,pos,1)
          StrAdd(word,chr)
          pos++
        ENDWHILE
        IF allcaps THEN UpperStr(word)
        IF propercaps AND (word[0]>="a") AND (word[0]<="z") THEN word[0]:=word[0]-32
        RETURN TRUE
      ELSE
        WHILE words[pos]<>" "
          pos++
        ENDWHILE
        pos++
        WHILE words[pos]<>":"
          pos++
        ENDWHILE
      ENDIF
    ENDWHILE
  ENDIF
ENDPROC FALSE

PROC getTranslator(translatorName)
  DEF trans:PTR TO translator
  trans:=translators

  WHILE (trans<>NIL)
    EXIT StriCmp(trans.translatorName,translatorName)
    trans:=trans.trans.succ
  ENDWHILE
ENDPROC trans

PROC translateText(textstring)
  DEF sourceText
  DEF translatorName[255]:STRING
  DEF trans:PTR TO translator
  DEF chr[1]:STRING
  DEF word[255]:STRING
  DEF i
  DEF cnt=0, translated

  sourceText:=String(StrLen(textstring))
  StrCopy(sourceText,textstring)

  trans:=translators
  IF translatorMode=TRANS_HOST_TO_DEFINED
    StringF(translatorName,'\s\s',hostLanguage,translatorLanguage)
  ELSEIF translatorMode=TRANS_DEFINED_TO_HOST
    StringF(translatorName,'\s\s',translatorLanguage,hostLanguage)
  ELSE
    RETURN
  ENDIF

  trans:=getTranslator(translatorName)

  IF trans<>NIL
    ->translate sourcetext and store in textstring
    StrCopy(textstring,'')
    StrCopy(word,'')
    FOR i:=0 TO StrLen(sourceText)-1
      MidStr(chr,sourceText,i,1)
      UpperStr(chr)
      IF ((chr[0]<"A") OR (chr[0]>"Z")) AND (chr[0]<128) AND (chr[0]<>39) AND (chr[0]<>"-")
        MidStr(chr,sourceText,i,1)
        IF StrLen(word)>0
          translated:=translateWord(trans,word)
          IF cnt+StrLen(word)>75
            StrAdd(textstring,'\b\n')
            cnt:=0
          ENDIF
          cnt:=cnt+StrLen(word)
          IF (translated=FALSE) AND (loggedOnUser.translatorID AND 128)
            StrAdd(textstring,'[33m')
            StrAdd(textstring,word)
            StrAdd(textstring,'[0m')
          ELSE
            StrAdd(textstring,word)
          ENDIF
          StrCopy(word,'')
        ENDIF
        StrAdd(textstring,chr)
        cnt++
      ELSE
        MidStr(chr,sourceText,i,1)
        StrAdd(word,chr)
      ENDIF
    ENDFOR
    IF StrLen(word)>0
      translated:=translateWord(trans,word)
      IF cnt+StrLen(word)>75 THEN StrAdd(textstring,'\b\n')
      IF (translated=FALSE) AND (loggedOnUser.translatorID AND 128)
        StrAdd(textstring,'[33m')
        StrAdd(textstring,word)
        StrAdd(textstring,'[0m')
      ELSE
        StrAdd(textstring,word)
      ENDIF
    ENDIF
  ENDIF
ENDPROC

PROC displayScreen(screenType)
  DEF screenfile[255]:STRING
  DEF screencheck[255]:STRING
  DEF res
  res:=FALSE
  SELECT screenType
    CASE SCREEN_AWAIT
      StringF(screenfile,'\sAWAITSCREEN.TXT',nodeScreenDir)
      IF fileExists(screenfile) THEN res:=displayFile(screenfile)
    CASE SCREEN_BULL
      StringF(screencheck,'\s\s',cmds.bbsLoc,'BULL')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NODE_BULL
      StringF(screencheck,'\s\s',nodeScreenDir,'BULL')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_LOGOFF
      StringF(screencheck,'\s\s',nodeScreenDir,'LOGOFF')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_CONF_BULL
      StringF(screencheck,'\s\s',confScreenDir,'BULL')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_MENU
      IF StrLen(currentMenuName)=0
        StringF(screencheck,'\s\s',confScreenDir,defaultMenuName)
      ELSE
        StringF(screencheck,'\s\s',confScreenDir,currentMenuName)
      ENDIF
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
      cmdShortcuts:=FALSE
      shortcuts.clear()
      IF res
        StrAdd(screenfile,'.keys')
        IF fileExists(screenfile)
          loadShortcuts(screenfile)
          cmdShortcuts:=TRUE        
        ENDIF      
      ENDIF
    CASE SCREEN_LOGON
      StringF(screencheck,'\s\s',nodeScreenDir,'LOGON')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_BBSTITLE
      StringF(screencheck,'\s\s',nodeScreenDir,'BBSTITLE')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_JOIN
      StringF(screencheck,'\s\s',nodeScreenDir,'JOIN')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_JOINED
      StringF(screencheck,'\s\s',nodeScreenDir,'JOINED')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_JOINCONF
      StringF(screencheck,'\s\s',nodeScreenDir,'JoinConf')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_CONF_JOINMSGBASE
      StringF(screencheck,'\s\s',confScreenDir,'JoinMsgBase')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_JOINMSGBASE
      StringF(screencheck,'\s\s',nodeScreenDir,'JoinMsgBase')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_DOWNLOAD
      StringF(screencheck,'\s\s',confScreenDir,'DownloadMsg')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_FILEHELP
      StringF(screencheck,'\s\s',confScreenDir,'FileHelp')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_UPLOAD
      StringF(screencheck,'\s\s',confScreenDir,'UploadMsg')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NOUPLOADS
      StringF(screencheck,'\s\s',confScreenDir,'NoUploads')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NEWUSERPW
      StringF(screencheck,'\s\s',nodeScreenDir,'NEWUSERPW')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NONEWUSERS
      StringF(screencheck,'\s\s',nodeScreenDir,'NONEWUSERS')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NONEWATBAUD
      StringF(screencheck,'\s\s\d',nodeScreenDir,'NONEWAT',onlineBaud)
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NOT_TIME
      StringF(screencheck,'\s\s\d',nodeScreenDir,'NOTTIME',onlineBaud)
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_NOCALLERSATBAUD
      StringF(screencheck,'\s\s\d',nodeScreenDir,'NOCALLERSAT',onlineBaud)
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_GUESTLOGON
      StringF(screencheck,'\s\s',nodeScreenDir,'GUESTLOGON')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_LOCKOUT0
      StringF(screencheck,'\s\s',nodeScreenDir,'LOCKOUT0')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_LOCKOUT1
      StringF(screencheck,'\s\s',nodeScreenDir,'LOCKOUT1')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_PRIVATE
      StringF(screencheck,'\s\s',nodeScreenDir,'PRIVATE')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_ONENODE
      StringF(screencheck,'\s',cmds.bbsLoc,'OnlyOnOneNode')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_LOGON24
      StringF(screencheck,'\s',cmds.bbsLoc,'Logon24hrs')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_LANGUAGES
      StringF(screencheck,'\s',cmds.bbsLoc,'Languages')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_INTERNETNAMES
      StringF(screencheck,'\s',cmds.bbsLoc,'InternetNames')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_REALNAMES
      StringF(screencheck,'\s',cmds.bbsLoc,'RealNames')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
    CASE SCREEN_MAILSCAN      
      StringF(screencheck,'\s',cmds.bbsLoc,'MailScan')
      IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
  ENDSELECT
ENDPROC res

PROC showCustomScreen(screenName:PTR TO CHAR)
  DEF screenfile[255]:STRING
  DEF screencheck[255]:STRING
  DEF res
  res:=FALSE
  StringF(screencheck,'\s\s',cmds.bbsLoc,screenName)
  IF (findSecurityScreen(screencheck,screenfile)) THEN res:=displayFile(screenfile)
ENDPROC res

PROC runExecuteOn(execOn:PTR TO CHAR)
  DEF toolTypeText[255]:STRING
  DEF tempstr1[255]:STRING
  DEF tempstr2[255]:STRING
  DEF filetags:PTR TO LONG
  
  StringF(toolTypeText,'EXECUTE_ON_\s',execOn)
  IF (readToolType(TOOLTYPE_BBSCONFIG,0,toolTypeText,tempstr1))
    filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,FALSE,TAG_DONE]
    processMci(tempstr1,tempstr2)
    SystemTagList(tempstr2,filetags)
    FastDisposeList(filetags)
  ENDIF

  StringF(toolTypeText,'EXECUTE_ASYNC_ON_\s',execOn)
  IF (readToolType(TOOLTYPE_BBSCONFIG,0,toolTypeText,tempstr1))
    filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,TRUE,TAG_DONE]
    processMci(tempstr1,tempstr2)
    SystemTagList(tempstr2,filetags)
    FastDisposeList(filetags)
  ENDIF
ENDPROC

PROC doUploadNotify()
  DEF str[255]:STRING
  DEF string[255]:STRING
  runExecuteOn('UPLOAD')
  
  IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_UPLOAD')) AND (StrLen(mailOptions.sysopEmail)>0)
    StringF(str,'\s: Ami-Express upload notification',cmds.bbsName)
    StringF(string,'This is a notification that \s from \s has uploaded\n\n',loggedOnUser.name,loggedOnUser.location)
    sendMail(str,string,FALSE, NIL,0,mailOptions.sysopEmail)
  ENDIF
ENDPROC

PROC doCommentNotify(fromName:PTR TO CHAR, subject:PTR TO CHAR)
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  runExecuteOn('SYSOP_COMMENT')
  IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_SYSOP_COMMENT')) AND (StrLen(mailOptions.sysopEmail)>0)
    StringF(tempStr,'\s: Ami-Express sysop message notification',cmds.bbsName)
    StringF(tempStr2,'This is a notification that \s has sent you a message.\n\nSubject: \s\n\n',fromName,subject)
    sendMail(tempStr,tempStr2,TRUE, msgBuf,lines,mailOptions.sysopEmail)
  ENDIF
ENDPROC

PROC doLogonNotify()
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  runExecuteOn('LOGON')
  IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_LOGON')) AND (StrLen(mailOptions.sysopEmail)>0)
    StringF(tempStr,'\s: Ami-Express logon notification',cmds.bbsName)
    StringF(tempStr2,'This is a notification that \s from \s has logged on\n\n',loggedOnUser.name,loggedOnUser.location)
    sendMail(tempStr,tempStr2,FALSE, NIL,0,mailOptions.sysopEmail)
  ENDIF
ENDPROC

PROC doNewUserNotify()
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  runExecuteOn('NEW_USER')
 
  IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_NEW_USER')) AND (StrLen(mailOptions.sysopEmail)>0)
    StringF(tempStr,'\s: Ami-Express new user notification',cmds.bbsName)
    StringF(tempStr2,'This is a notification that a new user called \s from \s has registered.',loggedOnUser.name,loggedOnUser.location)
    sendMail(tempStr,tempStr2,FALSE,msgBuf,lines,mailOptions.sysopEmail)
  ENDIF
ENDPROC

PROC doLogoffNotify()
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  runExecuteOn('LOGOFF')
  IF (checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_LOGOFF')) AND (StrLen(mailOptions.sysopEmail)>0)
    StringF(tempstr,'\s: Ami-Express logoff notification',cmds.bbsName)
    StringF(tempstr2,'This is a notification that \s from \s has logged off\n\n',loggedOnUser.name,loggedOnUser.location)
    sendMail(tempstr,tempstr2,FALSE, NIL,0,mailOptions.sysopEmail)
  ENDIF
ENDPROC

PROC displayFile(filename, allowMCI=TRUE, resetNonStop=TRUE, resetLineCount=TRUE)
  DEF fh
  DEF firstline=TRUE
  DEF linedata[999]:STRING
  DEF len,res,stat,read,lf
  DEF ripFile=FALSE
  DEF extension[4]:STRING
  DEF fname[255]:STRING

  slowmo:=0
  IF resetLineCount THEN lineCount:=0

  IF (mciViewSafe=FALSE) AND ((checkSecurity(ACS_MCI_MSG)=FALSE) OR (sopt.toggles[TOGGLES_NOMCIMSGS]=TRUE)) THEN allowMCI:=FALSE
  IF mcioff=TRUE THEN allowMCI:=FALSE

  StrCopy(mciterminator,'|')
  StrCopy(fname,filename)
  RightStr(extension,fname,4)

  IF StriCmp(extension,'.rip')
    conPuts('\b\n\b\n[0mDisplaying Rip Script\b\n\b\n')
    ripFile:=TRUE
  ENDIF

  IF (resetNonStop) AND (state<>STATE_LOGGING_OFF) THEN nonStopDisplayFlag:=FALSE
  res:=FALSE

  IF (fh:=Open(filename,OLDFILE))<>0
    res:=TRUE
    WHILE ((read:=Fgets(fh,linedata,999))<>NIL)
      IF ripFile
        IF ioFlags[IOFLAG_SER_OUT]
          serPuts(linedata)
        ENDIF
        JUMP ripCont
      ENDIF
      len:=StrLen(linedata)-1
      lf:=FALSE
      IF (len>1)
        IF (linedata[len-1]="\b") AND (linedata[len]="\n")
          SetStr(linedata,len-1)
          lf:=TRUE
        ENDIF
      ENDIF
      IF (lf=FALSE)
        IF linedata[len]="\n"
          SetStr(linedata,len)
          lf:=TRUE
        ELSE
          len++
          SetStr(linedata,len)
          lf:=FALSE
        ENDIF
      ENDIF
      IF (firstline)
        IF len>0
          IF linedata[0]<>"~" THEN allowMCI:=FALSE
        ELSE
          allowMCI:=FALSE
        ENDIF
      ENDIF
      IF translatorMode<>TRANS_NONE
        translateText(linedata)
      ENDIF
      stat:=RESULT_SUCCESS
      IF allowMCI
        processMci(linedata)
      ELSE
        IF (InStr(linedata,'')>=0) OR (StrLen(linedata)<80)
          aePuts(linedata)
        ELSE
          WHILE StrLen(linedata)>0
            IF StrLen(linedata)>79
              aePuts2(linedata,79)
              StrCopy(linedata,linedata+79)
            ELSE
              aePuts(linedata)
              StrCopy(linedata,'')
            ENDIF
            IF StrLen(linedata)>0
              aePuts('\b\n')
              stat:=checkForPause()
            ENDIF
          ENDWHILE
        ENDIF
      ENDIF
      IF (ripMode=FALSE) OR (ripFile=FALSE)
        IF lf
          aePuts('\b\n')
          stat:=checkForPause()
        ENDIF
      ENDIF
      IF(logonType>=LOGON_TYPE_REMOTE)
        IF(checkCarrier()=FALSE) THEN stat:=RESULT_NO_CARRIER
      ENDIF
      EXIT (stat<>RESULT_SUCCESS) OR (reqState<>REQ_STATE_NONE)
      firstline:=FALSE
ripCont:
    ENDWHILE
    Close(fh)
  ENDIF
  aePuts('[0m')
  slowmo:=0
ENDPROC res

PROC processRexxMessage()
  DEF rexxmsg: PTR TO rexxmsg
  DEF debugstr[255]:STRING
  DEF rexxstring:PTR TO CHAR
  DEF cmd

  debugLog(LOG_DEBUG,'rexx')

  rexxmsg,rexxstring:=rxGetMsg(rexxmp)
  WHILE(rexxmsg<>NIL)

    StringF(debugstr,'rexx message: \s',rexxstring)
    debugLog(LOG_DEBUG,debugstr)

    IF( StriCmp(rexxstring,'syscmd ',7) )
      IF shutDownFlag<>1
        sdReplyRexx:=rexxmsg
        StrCopy(arg3,rexxstring+7)
        shutDownFlag:=1
        netTrans:=1
      ELSE
        ReplyMsg(rexxmsg)
        RETURN
      ENDIF
    ELSEIF( StriCmp(rexxstring,'shutdown',8) )
      IF(shutDownFlag<>1)
        sdReplyRexx:=rexxmsg
        shutDownFlag:=1
        setEnvStat(ENV_SHUTDOWN)
      ELSE
        ReplyMsg(rexxmsg)
      ENDIF
      IF(state<>STATE_AWAIT)
        aePuts('\b\n\b\n  The BBS has recieved an emergency shutdown, you have 2 mins to logoff!!\b\n\b\n')
        timeLimit:=130
      ENDIF
      RETURN
    ELSEIF(StriCmp(rexxstring,'chat',4))
      sdReplyRexx:=rexxmsg
      ->rexxChatFlag:=1
      ->StrCopy(rexxChatMsg,rexxstring+4)
      IF(state<>STATE_AWAIT)
        aePuts(rexxstring+4)
        aePuts('\b\n')
        ->rexxChatFlag=0
      ENDIF
      ReplyMsg(rexxmsg)
    ELSEIF(StriCmp(rexxstring,'suspend',7))
      IF(shutDownFlag<>2) /* First suspend Notice */
        sdReplyRexx:=rexxmsg
        shutDownFlag:=2
        setEnvStat(ENV_SUSPEND)
      ELSE /* Already have a suspend pending! */
        /*if(rexxmsg->rm_Action&RXFF_RESULT)
                    {
                    rexxmsg->rm_Result1=1
                    rexxmsg->rm_Result2=0
                    }*/
        ReplyMsg(rexxmsg)
      ENDIF
    ELSEIF( StriCmp(rexxstring,'resume',6) )
      IF(state=STATE_SUSPEND) /* resume as soon as possible */
        ReplyMsg(rexxmsg)
        reqState:=REQ_STATE_RESUME
        shutDownFlag:=0
      ELSE /* fail these requests */
        ReplyMsg(rexxmsg)
      ENDIF

    ELSEIF( StriCmp(rexxstring,'getdata',7) )
      cmd:=Val(rexxstring+8)
      SELECT cmd
        CASE BB_CHATFLAG
          IF sysopAvail THEN rxReplyMsg(rexxmsg,0,'ON') ELSE rxReplyMsg(rexxmsg,0,'OFF')
        DEFAULT
         rxReplyMsg(rexxmsg,0,'')
      ENDSELECT
    ELSEIF( StriCmp(rexxstring,'aesayln',7) )
      aePuts(rexxstring+8)
      aePuts('\b\n')
      rxReplyMsg(rexxmsg,0,'')
    ELSEIF( StriCmp(rexxstring,'aesay',5) )
      aePuts(rexxstring+6)
      rxReplyMsg(rexxmsg,0,'')
    ELSE
      rxReplyMsg(rexxmsg,0,'')
    ENDIF

    rexxmsg,rexxstring:=rxGetMsg(rexxmp)
  ENDWHILE
ENDPROC

PROC processCommodityMessage(signals)
  DEF msg, msgid, msgtype

  IF signals AND cxsigflag
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
            debugLog(LOG_DEBUG,'CXCMD_APPEAR')
            openExpressScreen()
          CASE CXCMD_DISAPPEAR
            debugLog(LOG_DEBUG,'CXCMD_DISAPPEAR')
            closeExpressScreen()
          CASE CXCMD_DISABLE
            debugLog(LOG_DEBUG,'CXCMD_DISABLE')
            -> The user clicked CX Exchange disable gadget, better disable
            ActivateCxObj(broker, FALSE)
          CASE CXCMD_ENABLE
            -> User clicked enable gadget
            debugLog(LOG_DEBUG,'CXCMD_ENABLE')
            ActivateCxObj(broker, TRUE)
          CASE CXCMD_KILL
            -> User clicked kill gadget, better quit
            debugLog(LOG_DEBUG,'CXCMD_KILL')
            reqState:=REQ_STATE_SHUTDOWN
        ENDSELECT
      DEFAULT
        debugLog(LOG_WARN,'Unknown msgtype')
      ENDSELECT
    ENDWHILE
  ENDIF
ENDPROC

PROC processWinMessage2(win:PTR TO window)
  DEF winmsg:PTR TO intuimessage
  DEF msgclass
  WHILE winmsg:=GetMsg(win.userport)
    msgclass:=winmsg.class
    ReplyMsg(winmsg)
    SELECT msgclass
      CASE IDCMP_CLOSEWINDOW
        closeExpressScreen()
      CASE IDCMP_MENUPICK
        handleMenuPick(winmsg.code)
    ENDSELECT
    EXIT window=NIL
  ENDWHILE
ENDPROC

PROC processWindowMessage(signals)
  -> If IDCMP messages received, handle them
  DEF windowsig

  IF screen AND (scropen=FALSE)
    IF CloseScreen(screen) THEN screen:=NIL
  ENDIF

  IF windowClose<>NIL
    windowsig:=Shl(1, windowClose.userport.sigbit)
    IF signals AND windowsig THEN processWinMessage2(windowClose)
  ENDIF

  IF window<>NIL
    windowsig:=Shl(1, window.userport.sigbit)
    IF signals AND windowsig THEN processWinMessage2(window)
  ENDIF

  IF windowStat<>NIL
    windowsig:=Shl(1, windowStat.userport.sigbit)
    IF signals AND windowsig THEN processWinMessage2(windowStat)
  ENDIF
ENDPROC

PROC initStatCon()
  IF statWriteMP=NIL THEN statWriteMP:=createPort(0,0)
  IF statWriteIO=NIL THEN statWriteIO:=createStdIO(statWriteMP)
  statWriteIO.data:=windowStat
  OpenDevice('console.device', 0, statWriteIO, 0)
  IF (KickVersion(40) AND (bitPlanes>2))
    statWriteIO.command:=CMD_WRITE
    statWriteIO.data:='[37m[ s'
    statWriteIO.length:=-1
    DoIO(statWriteIO)
  ENDIF
ENDPROC

PROC clearStatusPane()
  DEF tempStr[255]:STRING,tempstr2[25]:STRING
  ->statMessage(1,1,'[37m[ s[0 p')

  statCursorTo(1,1)

  statPrint('[0mLOGIN NAME     [34m|[0mREAL NAME      [34m|[0m  1[34m|[0m255[34m|[0mXXXXXXXXX[34m|[0m800-555-1212[34m|     |')
  statCursorTo(1,2)
  statPrint('[0mLOCATION                       [34m|[0m 0[34m|[0m 0[34m|[0m    0[34m|[0m    0[34m|[0m           0[34m|[0m           0[34m|   ')
  statCursorTo(1,3)
  formatLongDateTime(getSystemTime(),tempstr2)
  StringF(tempStr,'[0mTIME \s[25] [34m   |[0m       0[34m|[0m    0[34m|[0mLAST CALLED               [34m',tempstr2)
  statPrint(tempStr)
  statPrint('[0m')     /* and set text to normal */
  statParkCursor()

  StringF(tempStr,'\r\d[7]',cmds.openingBaud)
  statMessage(73,1,tempStr)
ENDPROC

PROC closeAEStats()
  IF statWriteIO<>NIL
    CloseDevice(statWriteIO)
    deleteStdIO(statWriteIO)
    statWriteIO:=NIL
  ENDIF
  IF statWriteMP<>NIL
    deletePort(statWriteMP)
    statWriteMP:=NIL
  ENDIF

  IF(windowStat<>NIL) 
    ClearMenuStrip(windowStat)
    CloseWindow(windowStat)
  ENDIF
  windowStat:=NIL
ENDPROC

PROC toggleStatusDisplay()
  DEF dp,bp,sz,tags:PTR TO LONG
  DEF pub=FALSE
  DEF pubScreen[255]:STRING
  DEF pubLock=0:PTR TO screen


  IF bitPlanes=0
    pub:=TRUE
  ENDIF

  IF readToolType(TOOLTYPE_WINDOW,node,'WINDOW.PUBSCREEN',pubScreen)
    pub:=TRUE
  ENDIF

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'SHOW_CACHE_STATS')
    sz:=37
  ELSE
    sz:=27
  ENDIF

  IF pub
    IF StrLen(pubScreen)>0
      pubLock:=LockPubScreen(pubScreen)
    ELSE
      pubLock:=LockPubScreen(NIL)
    ENDIF
    IF pubLock=FALSE
      pub:=FALSE
    ELSE
      sz:=sz+pubLock.wbortop+pubLock.font.ysize+pubLock.wborbottom
    ENDIF
  ENDIF

  IF (screen=NIL) AND (pub=FALSE) THEN RETURN

  IF(dStatBar)
    dStatBar:=0
    closeAEStats()
    MoveWindow(window,0,-sz)
    SizeWindow(window,0,sz)
    IF (loggedOnUser<>NIL)
      IF (StrLen(loggedOnUser.name)>0) THEN statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
    ENDIF
  ELSE

    IF(bitPlanes<2)
      dp:=1
      bp:=1
    ELSE
      dp:=3
      bp:=4
    ENDIF

    IF pub
      tags:=NEW [WA_PUBSCREEN,pubLock,
         WA_DEPTHGADGET,1,
         WA_DRAGBAR,1,
         WA_LEFT,window.leftedge,
         WA_TOP,window.topedge,
         WA_WIDTH,sopt.width,
         WA_HEIGHT,sz,
         WA_DETAILPEN,dp,
         WA_BLOCKPEN,bp,
         WA_IDCMP,IDCMP_MENUPICK,
         WA_NEWLOOKMENUS,1,
         WA_FLAGS,WFLG_SIMPLE_REFRESH,
         TAG_DONE]
    ELSE
      tags:=NEW [WA_CUSTOMSCREEN,screen,
         WA_LEFT,0,
         WA_TOP,screen.wbortop+screen.font.ysize-1,
         WA_WIDTH,640,
         WA_HEIGHT,sz,
         WA_DETAILPEN,dp,
         WA_BLOCKPEN,bp,
         WA_IDCMP,IDCMP_MENUPICK,
         WA_NEWLOOKMENUS,1,
         WA_FLAGS,WFLG_SIMPLE_REFRESH,
         TAG_DONE]
    ENDIF

    IF(( windowStat:=OpenWindowTagList(NIL,tags))<>NIL)

      dStatBar:=1
      SizeWindow(window,0,-sz)
      MoveWindow(window,0,sz)
      
      initStatCon()
      clearStatusPane()
      SetWindowTitles(window,titlebar,titlebar)
      SetMenuStrip(windowStat,expMenu)

      IF pub THEN SetWindowTitles(windowStat,titlebar,titlebar)
      IF (loggedOnUser<>NIL)
        IF (StrLen(loggedOnUser.name)>0) THEN statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
      ENDIF
      statChatFlag()
    ENDIF
    FastDisposeList(tags)
    IF pubLock THEN UnlockPubScreen(NIL,pubLock)
  ENDIF
  updateMenus()
ENDPROC

PROC doFax()
  DEF oldshared
  oldshared:=serShared
  serShared:=TRUE

  purgeLineEnd()

  runSysCommand('FAX','')

  serShared:=oldshared

  reInitModem()
  resetSystem()
  setEnvStat(ENV_AWAITCONNECT)
ENDPROC

PROC checkForCallerId(string:PTR TO CHAR)
  DEF tempstr[255]:STRING
  DEF n,r
  
  r:=FALSE
  IF InStr(string,'CID')>=0
    IF (n:=InStr(string,'='))<>-1
      StrCopy(tempstr,TrimStr(string+n+1))
      
      ->does this string include a host name
      IF (n:=InStr(tempstr,' ('))<>-1
      
        ->grab ip part
        StrCopy(hostIP,tempstr,n)
        
        ->grab hostname part
        StrCopy(hostName,TrimStr(tempstr+n+2))
        
        ->remove last character (closing bracket)
        SetStr(hostName,StrLen(hostName)-1)
      ELSE
        r:=TRUE
        FOR n:=0 TO StrLen(tempstr)-1
          IF ((tempstr[n]<"0") OR (tempstr[n]>"9")) AND (tempstr[n]<>".") THEN r:=FALSE
        ENDFOR
        IF r THEN StrCopy(hostIP,tempstr) ELSE StrCopy(hostName,tempstr)
      ENDIF
      
    ENDIF
    r:=TRUE
  ENDIF
  IF InStr(string,'HOST NAME')>=0
    IF (n:=InStr(string,'='))<>-1
      StrCopy(hostName,TrimStr(string+n+1))
    ENDIF
    r:=TRUE
  ENDIF
  IF InStr(string,'HOST IP ADDR')>=0
    IF (n:=InStr(string,'='))<>-1
      StrCopy(hostIP,TrimStr(string+n+1))
    ENDIF
    r:=TRUE
  ENDIF 
ENDPROC r

PROC checkIncomingCall()
  DEF rCount,input
  DEF string[255]:STRING
  DEF tempstr[255]:STRING
  DEF stat,n,isConnected=FALSE
  DEF r
  DEF peeraddr: sockaddr_in
  DEF hostent: PTR TO hostent
  DEF s

  ioFlags[IOFLAG_SER_IN]:=-1
  ioFlags[IOFLAG_SER_OUT]:=0

  StrCopy(hostName,'')
  StrCopy(hostIP,'')

  IF telnetSocket>=0
    StrCopy(connectString,'CONNECT 19200')
    n:=SIZEOF sockaddr_in
    r:=GetPeerName(telnetSocket,peeraddr,{n})
    IF r=0
      StringF(hostIP,'\d.\d.\d.\d',Shr(peeraddr.sin_addr AND $ff000000,24) AND $FF,Shr(peeraddr.sin_addr AND $ff0000,16),Shr(peeraddr.sin_addr AND $ff00,8),peeraddr.sin_addr AND $ff)
      s:=peeraddr.sin_addr
      hostent:=GetHostByAddr({s},4,AF_INET)
      IF hostent<>NIL THEN StrCopy(hostName,hostent.h_name,255)
    ENDIF
    JUMP go3
  ENDIF

  IF(sopt.trapDoor OR instantLogon)
    instantLogon:=FALSE
    JUMP go
  ENDIF

  rCount:=ringCount

  IF (rCount=-1) THEN rCount:=2
  StringF(string,'ringcount: \d',rCount)
  debugLog(LOG_DEBUG,string)


  WHILE(rCount)
    stat:=lineInput('','',80,5,string)
    IF stat<>RESULT_SUCCESS THEN RETURN
    checkForCallerId(string)
    IF StrLen(string)>0
      IF(stringCompare(string,cmds.mRing))=RESULT_SUCCESS THEN rCount--
      IF(StrCmp(string,'CONNECT',7)) THEN JUMP go2
    ENDIF
  ENDWHILE
  IF(rCount) THEN RETURN

  IF(sopt.toggles[TOGGLES_CALLERID] OR sopt.toggles[TOGGLES_CALLERIDNAME])
    lineInput('','',14,5,idRate)
    lineInput('','',14,5,idTime)
    lineInput('','',14,5,idDate)
    lineInput('','',40,5,idNmbr)
    IF(sopt.toggles[TOGGLES_CALLERIDNAME]) THEN lineInput('','',40,5,idName)
    callerIDLog(1)
  ENDIF
  /* OTHERWISE EQUAL, ANSWER AND SET BAUDS */
go:
  statClearTime()
  IF(sopt.trapDoor=FALSE)
    StringF(string,'\s\b',cmds.mAnswer)
    serPuts(string)
    
    StrCopy(string,'')
go2:
    n:=0
    REPEAT
      IF(input=RESULT_TIMEOUT) THEN JUMP timedout
      IF checkForCallerId(string)=FALSE
        IF StriCmp(string,'+FCO')
          doFax()
          RESULT_SUCCESS
        ELSEIF (StrCmp(string,'CONNECT',7))
          isConnected:=TRUE
        ELSEIF (StrLen(string)>0) AND (StrCmp(string,cmds.mRing)=FALSE) AND (StrCmp(string,cmds.mAnswer)=FALSE)
          n++
          StringF(tempstr,'\tINVALID CONNECT    = \s',string)
          callersLog(tempstr)
        ENDIF
      ENDIF
      IF isConnected=FALSE THEN input:=lineInput('','',80,40,string)
    UNTIL((isConnected) OR (n=5))
    IF isConnected=FALSE THEN JUMP timedout
  ELSE
    StrCopy(string,trapConnect)
  ENDIF
  StrCopy(connectString,string)

  IF(sopt.trapDoor)
    ->//CutConnect(string)
    IF(input=RESULT_TIMEOUT) THEN JUMP timedout
  ENDIF
go3:

  stripReturn(string)
  readToolType(TOOLTYPE_CONNECT,node,string,connectString)

  IF(StrCmp(connectString,'CONNECT',7))
    onlineBaud:=Val(connectString+7)
    onlineBaudR:=cmds.openingBaud
    IF onlineBaud=0 THEN onlineBaud:=cmds.openingBaud
    IF StrLen(connectString)=7 THEN StringF(connectString,'CONNECT \d',onlineBaud)

    ioFlags[IOFLAG_SER_OUT]:=-1
    ioFlags[IOFLAG_SCR_OUT]:=-1
    IF(cmds.acLvl[LVL_VARYING_LINK_RATE]=1) THEN setBaud(onlineBaud)

    runExecuteOn('CONNECT')

    conCLS()
    RETURN RESULT_CONNECT
  ENDIF

  onlineBaud:=cmds.openingBaud
  setEnvStat(ENV_AWAITCONNECT)

timedout:

  dropDTR()
  Delay(25)
  IF(cmds.acLvl[LVL_VARYING_LINK_RATE]=1)
    setBaud(cmds.openingBaud)
    Delay(25)
  ENDIF
  intDoReset(cmds.mReset)
  serPutChar("\b")
  Delay(25)
  purgeLine()
  ioFlags[IOFLAG_SER_IN]:=0
  ioFlags[IOFLAG_SER_OUT]:=0

ENDPROC RESULT_SUCCESS

PROC reserveForUser()
  DEF stat
  DEF str[34]:STRING

reserveRedo:
  confNameType:=NAME_TYPE_USERNAME
  aePuts('\b\n[0mEnter username to reserve for: ')
  stat:=lineInput('','',30,INPUT_TIMEOUT,str)
  IF((stat<0) OR (StrLen(str)=0)) THEN RETURN

  stat:=chooseAName(str,tempUser,tempUserKeys,tempUserMisc,0)
  IF(stat<RESULT_FAILURE) THEN   RETURN
  IF(stat=RESULT_FAILURE) THEN JUMP reserveRedo
  StrCopy(reservedName,tempUserKeys.userName)
ENDPROC

PROC processInputMessage(timeout, extsig = 0,rawMode=FALSE, allowSer=TRUE)
  DEF consolesig=0,windowsig=0,telnetsig=0,telnetSigBit, obuf[255]:STRING
  DEF ch=0,lch,wasControl=0,signals
  DEF doorsig=0,rexxsig=0,serialsig=0,timersig=0,timedout=0
  DEF temp[255]:STRING
  DEF statePtr: PTR TO awaitState

  IF (transfering) OR (doorSilent)
    RETURN TRUE,RESULT_TIMEOUT
  ENDIF

  flushSerialCache()

  telnetSigBit:=AllocSignal(-1)
  telnetsig:=Shl(1,telnetSigBit)

  chatSerFlag:=0
  chatConFlag:=0

  IF loggedOnUser<>NIL THEN statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)

  IF consoleReadMP<>NIL THEN consolesig:=Shl(1, consoleReadMP.sigbit)
  IF serialReadMP<>NIL THEN serialsig:=Shl(1, serialReadMP.sigbit)

  IF windowClose<>NIL
    windowsig:=Shl(1, windowClose.userport.sigbit)
  ENDIF
  
  IF window<>NIL
    windowsig:=windowsig OR Shl(1, window.userport.sigbit)
  ENDIF

  IF windowStat<>NIL
    windowsig:=windowsig OR Shl(1, windowStat.userport.sigbit)
  ENDIF

  IF resmp<>NIL THEN doorsig:=Shl(1, resmp.sigbit)
  IF rexxmp<>NIL THEN rexxsig:=Shl(1, rexxmp.sigbit)

  -> A character, or an IDCMP msg, or both could wake us up
  signals:=0
  IF checkSer() THEN signals:=signals OR serialsig
  IF checkCon() THEN signals:=signals OR consolesig
  IF checkTelnetData() THEN signals:=signals OR telnetsig

  IF signals=0
    IF timeout<>0
      openTimer()
      setTimer(timeout,0)
      IF timerport<>NIL THEN timersig:=Shl(1, timerport.sigbit)
    ENDIF
  
    IF telnetSocket>=0
      REPEAT
        setSingleFDS(fds,telnetSocket)
        signals:=SIGBREAKF_CTRL_C OR consolesig OR windowsig OR cxsigflag OR doorsig OR rexxsig OR serialsig OR timersig OR extsig
        WaitSelect(telnetSocket+1,fds,NIL,NIL,NIL,{signals})
        IF checkTelnetData()
          signals:=signals OR telnetsig
        ENDIF
      UNTIL signals OR (checkCarrier()=FALSE)
    ELSE
      signals:=Wait(SIGBREAKF_CTRL_C OR consolesig OR windowsig OR cxsigflag OR doorsig OR rexxsig OR serialsig OR timersig OR extsig)
    ENDIF
    timedout:=(timersig<>0) AND ((signals AND timersig)<>0)
    IF timedout THEN waitTime()
    closeTimer()
  ENDIF

  FreeSignal(telnetSigBit)

  wasControl:=0
  ch:=0

  IF signals AND SIGBREAKF_CTRL_C
    debugLog(LOG_DEBUG,'CTRL-C detected')
    reqState:=REQ_STATE_SHUTDOWN
  ENDIF

  processWindowMessage(signals)
  processCommodityMessage(signals)
  IF (signals AND rexxsig) THEN processRexxMessage()
  IF (signals AND doorsig)
    IF checkDoorMsg(1)
      ch:=serverin
    ENDIF
  ENDIF

  IF (extsig<>0) AND ((signals AND extsig)<>0) THEN RETURN TRUE,RESULT_SIGNALLED

  IF (timedout)
    RETURN TRUE,RESULT_TIMEOUT
  ENDIF

  IF state=STATE_LOGGING_OFF
    RETURN FALSE,0
  ENDIF

  IF (ch=0) AND allowSer AND (signals AND (serialsig OR telnetsig))
    IF rawMode
      IF (ioFlags[IOFLAG_SER_IN])
        lch:=readMayGetChar(serialReadMP,TRUE,{serbuff})
        IF lch<>-1 THEN ch:=lch
      ENDIF
    ELSEIF -1<>(lch:=readMayGetChar(serialReadMP,TRUE,{serbuff}))
      IF (ioFlags[IOFLAG_SER_IN])
        ch:=lch
        wasControl:=FALSE
        StringF(obuf, 'Serial Received: hex $\z\h[2] = \c', ch, ch)
        debugLog(LOG_DEBUG,obuf)
        chatSerFlag:=1
        ximPort:=SERIAL_PORT
        IF ch=$1b
          ch:=readMayGetChar(serialReadMP,TRUE,{serbuff})
          StringF(obuf, 'Escape Serial Received: hex $\z\h[2] = \c', ch, ch)
          debugLog(LOG_DEBUG,obuf)
          IF ch="["
            ch:=readMayGetChar(serialReadMP,TRUE,{serbuff})

            IF (ch>="A") AND (ch<="D")
             wasControl:=1
               SELECT ch
                 CASE "A"
                   IF rawArrow THEN wasControl:=0
                   ch:=UPARROW
                 CASE "B"
                   IF rawArrow THEN wasControl:=0
                   ch:=DOWNARROW
                 CASE "C"
                   IF rawArrow THEN wasControl:=0
                   ch:=RIGHTARROW
                 CASE "D"
                   IF rawArrow THEN wasControl:=0
                   ch:=LEFTARROW
               ENDSELECT
            ENDIF
          ENDIF
        ENDIF
      ENDIF
    ENDIF
  ENDIF
  IF (ch=0) AND signals AND consolesig
    -> If a console signal was received, get the character

    IF rawMode
      IF (ioFlags[IOFLAG_KBD_IN])
        lch:=readMayGetChar(consoleReadMP, FALSE,{ibuf})
        IF lch<>-1 THEN ch:=lch
      ENDIF
    ELSEIF -1<>(lch:=readMayGetChar(consoleReadMP, FALSE, {ibuf}))
      IF (ioFlags[IOFLAG_KBD_IN])
        ch:=lch
        chatConFlag:=1
        ximPort:=CONSOLE_PORT

        IF ((ch>=$1F) AND (ch<=$7E)) OR (ch>=$A0)
          StringF(obuf, 'Received: hex $\z\h[2] = \c inControl=\d\b\n', ch, ch,inControl)
        ELSE
          StringF(obuf, 'Received: hex $\z\h[2] \d', ch,inControl)
        ENDIF
        debugLog(LOG_DEBUG,obuf)

        IF ch=$9B
          ch:=readMayGetChar(consoleReadMP, FALSE, {ibuf})
            StringF(obuf, 'Received control: hex $\z\h[2] \d', ch,ch)
            debugLog(LOG_DEBUG,obuf)
            lch:=readMayGetChar(consoleReadMP, FALSE, {ibuf})
            StringF(obuf, 'Received control: hex $\z\h[2] \d', lch,lch)
            debugLog(LOG_DEBUG,obuf)
          IF (ch="1") AND (lch<>$7E)
            ch:=lch
            lch:=readMayGetChar(consoleReadMP, FALSE, {ibuf})
            StringF(obuf, 'Received control: hex $\z\h[2] \d', lch,lch)
            debugLog(LOG_DEBUG,obuf)
            IF lch=$7e
              wasControl:=2
            ENDIF
          ELSEIF lch=$7e
            wasControl:=1
          ELSEIF (ch>="A") AND (ch<="D") AND (lch=-1)
            wasControl:=1
            SELECT ch
              CASE "A"
                IF rawArrow THEN wasControl:=0
                ch:=UPARROW
              CASE "B"
                IF rawArrow THEN wasControl:=0
                ch:=DOWNARROW
              CASE "C"
                IF rawArrow THEN wasControl:=0
                ch:=RIGHTARROW
              CASE "D"
                IF rawArrow THEN wasControl:=0
                ch:=LEFTARROW
            ENDSELECT
          ENDIF
        ENDIF
      ENDIF
    ENDIF
  ENDIF

  IF (state=STATE_AWAIT)
    statePtr:=stateData
    IF servercmd=SV_UNICONIFY
      IF scropen THEN expressToFront() ELSE openExpressScreen()
      statePtr.redrawScreen:=TRUE
      servercmd:=-1
    ENDIF

    ->F1
    IF (servercmd=SV_SYSOPLOG) OR ((wasControl=1) AND (ch="0"))
      servercmd:=-1
      debugLog(LOG_DEBUG,'SYSOP LOGON')
      statClearTime()
      disableNodeMenus(TRUE)
      disableOnlineMenus(FALSE)
      StrCopy(connectString,'SYSOP_LOCAL')
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SER_OUT]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      ioFlags[IOFLAG_KBD_IN]:=-1
      onlineBaud:=cmds.openingBaud
      onlineBaudR:=cmds.openingBaud
      intDoReset(sopt.offHook)
      reqState:=REQ_STATE_SYSOPLOGON
    ENDIF

    ->F2
    IF (servercmd=SV_LOCALLOG) OR ((wasControl=1) AND (ch="1"))
      servercmd:=-1
      debugLog(LOG_DEBUG,'LOCAL LOGON')
      statClearTime()
      disableNodeMenus(TRUE)
      disableOnlineMenus(FALSE)
      StrCopy(connectString,'F2_LOCAL')
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SER_OUT]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      ioFlags[IOFLAG_KBD_IN]:=-1
      onlineBaud:=cmds.openingBaud
      onlineBaudR:=cmds.openingBaud
      logonType:=LOGON_TYPE_LOCAL
      intDoReset(sopt.offHook)
      reqState:=REQ_STATE_LOGON
    ENDIF

    ->F3
    IF (servercmd=SV_INSTANT) OR ((wasControl=1) AND (ch="2"))
      servercmd:=-1
      instantLogon:=TRUE
    ENDIF

    -> F4
    IF (servercmd=SV_RESERVE) OR ((wasControl=1) AND (ch="3"))
      servercmd:=-1
      IF(StrLen(reservedName)>0)
        StrCopy(reservedName,'')
      ELSE
        disableNodeMenus(TRUE)
        ioFlags[IOFLAG_SER_IN]:=0
        ioFlags[IOFLAG_SER_OUT]:=0
        ioFlags[IOFLAG_SCR_OUT]:=-1
        ioFlags[IOFLAG_KBD_IN]:=-1
        timeLimit:=3600
        intDoReset(sopt.offHook)
        conCursorOn()
        conCLS()
        reserveForUser()
        resetSystem()
        disableNodeMenus(FALSE)
        ioFlags[IOFLAG_SER_IN]:=-1
        ioFlags[IOFLAG_SCR_OUT]:=0
        setEnvStat(ENV_RESERVE)
      ENDIF
      IF reqState=REQ_STATE_NONE THEN statePtr.redrawScreen:=TRUE
    ENDIF

    ->F5
    IF (servercmd=SV_CONFMAINT) OR ((wasControl=1) AND (ch="4"))
      servercmd:=-1
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      conCursorOn()
      sendCLS()
      onlineBaud:=cmds.openingBaud
      onlineBaudR:=cmds.openingBaud
      timeLimit:=3600
      disableNodeMenus(TRUE)
      logonType:=LOGON_TYPE_LOCAL
      logonTime:=getSystemTime()
      lastTimeUpdate:=logonTime
      loggedOnUser:=NEW loggedOnUser
      loggedOnUserKeys:=NEW loggedOnUserKeys
      loggedOnUserMisc:=NEW loggedOnUserMisc
      loadAccount(1,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
      masterLoadPointers(loggedOnUser)
      setEnvStat(ENV_SYSOP)
      conferenceMaintenance()
      END loggedOnUser
      END loggedOnUserKeys
      END loggedOnUserMisc
      loggedOnUser:=NIL
      loggedOnUserMisc:=NIL
      loggedOnUserKeys:=NIL
      ioFlags[IOFLAG_SER_IN]:=-1
      ioFlags[IOFLAG_SCR_OUT]:=0
      IF(ioFlags[IOFLAG_FIL_IN]) THEN ioFlags[IOFLAG_FIL_IN]:=0
      disableNodeMenus(FALSE)
      IF reqState=REQ_STATE_NONE THEN statePtr.redrawScreen:=TRUE
    ENDIF

    ->Shift F5
    IF (servercmd=SV_AESHELL) OR ((wasControl=2) AND (ch="4"))
      servercmd:=-1
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      intDoReset(sopt.offHook)
      disableNodeMenus(TRUE)
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      setEnvStat(ENV_SHELL)
      sendCLS()
      remoteShell()
      resetSystem()
      disableNodeMenus(FALSE)
      ioFlags[IOFLAG_SER_IN]:=-1
      ioFlags[IOFLAG_SCR_OUT]:=0
      IF(ioFlags[IOFLAG_FIL_IN]) THEN ioFlags[IOFLAG_FIL_IN]:=0
      IF reqState=REQ_STATE_NONE THEN statePtr.redrawScreen:=TRUE
    ENDIF

    ->F6
    IF (servercmd=SV_ACCOUNTS) OR ((wasControl=1) AND (ch="5"))
      servercmd:=-1
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      intDoReset(sopt.offHook)
      disableNodeMenus(TRUE)
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      conCursorOn()
      sendCLS()
      onlineBaud:=cmds.openingBaud
      onlineBaudR:=cmds.openingBaud
      timeLimit:=3600
      logonType:=LOGON_TYPE_LOCAL
      logonTime:=getSystemTime()
      lastTimeUpdate:=logonTime
      loggedOnUser:=NEW loggedOnUser
      loggedOnUserKeys:=NEW loggedOnUserKeys
      loggedOnUserMisc:=NEW loggedOnUserMisc
      acsLevel:=255
      loadAccount(1,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
      masterLoadPointers(loggedOnUser)
      editAccounts(FALSE)
      acsLevel:=-1
      END loggedOnUser
      END loggedOnUserKeys
      END loggedOnUserMisc
      loggedOnUser:=NIL
      loggedOnUserMisc:=NIL
      loggedOnUserKeys:=NIL
      resetSystem()
      disableNodeMenus(FALSE)
      ioFlags[IOFLAG_SER_IN]:=-1
      ioFlags[IOFLAG_SCR_OUT]:=0
      IF(ioFlags[IOFLAG_FIL_IN]) THEN ioFlags[IOFLAG_FIL_IN]:=0
      IF reqState=REQ_STATE_NONE THEN statePtr.redrawScreen:=TRUE
    ENDIF

    ->Shift F6
    IF (servercmd=SV_VIEWLOGS) OR ((wasControl=2) AND (ch="5"))
      servercmd:=-1
      ioFlags[IOFLAG_SER_IN]:=0
      ioFlags[IOFLAG_SCR_OUT]:=-1
      intDoReset(sopt.offHook)
      disableNodeMenus(TRUE)
      IF (scropen) THEN expressToFront() ELSE openExpressScreen()
      sendCLS()
      StringF(temp,'\sNode\d/Callerslog',cmds.bbsLoc,node)
      logonType:=LOGON_TYPE_LOCAL
      logonTime:=getSystemTime()
      lastTimeUpdate:=logonTime
      loggedOnUser:=NEW loggedOnUser
      loggedOnUserKeys:=NEW loggedOnUserKeys
      loggedOnUserMisc:=NEW loggedOnUserMisc
      setEnvStat(ENV_SYSOP)
      loadAccount(1,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
      masterLoadPointers(loggedOnUser)
      displayCallersLog(temp,FALSE)
      END loggedOnUser
      END loggedOnUserKeys
      END loggedOnUserMisc
      loggedOnUser:=NIL
      loggedOnUserMisc:=NIL
      loggedOnUserKeys:=NIL
      resetSystem()
      disableNodeMenus(FALSE)
      ioFlags[IOFLAG_SER_IN]:=-1
      ioFlags[IOFLAG_SCR_OUT]:=0
      IF(ioFlags[IOFLAG_FIL_IN]) THEN ioFlags[IOFLAG_FIL_IN]:=0
      IF reqState=REQ_STATE_NONE THEN statePtr.redrawScreen:=TRUE
    ENDIF

    ->F7
    IF (servercmd=SV_CHATTOGGLE) OR ((wasControl=1) AND (ch="6"))
      servercmd:=-1
      sysopAvail:=Not(sysopAvail)
      updateMenus()
      updateTitle(NIL)
      statChatFlag()
    ENDIF

    ->F8
    IF (servercmd=SV_INITMODEM) OR ((wasControl=1) AND (ch="7"))
      servercmd:=-1
      reInitModem()
      resetSystem()
    ENDIF

    ->F9
    IF (servercmd=SV_EXITNODE) OR ((wasControl=1) AND (ch="8"))
      servercmd:=-1
      StrCopy(shutDownMsg,'!')
      reqState:=REQ_STATE_SHUTDOWN
    ENDIF
    ->F10
    IF (servercmd=SV_NODEOFFHOOK) OR ((wasControl=1) AND (ch="9"))
      servercmd:=-1
      StrCopy(shutDownMsg,'!')
      reqState:=REQ_STATE_SHUTDOWN_OFFHOOK
    ENDIF

    ->Shift 10 - clear tooltype cache
    IF ((wasControl=2) AND (ch="9"))
      clearDiskObjectCache()
    ENDIF

    IF (servercmd=SV_TOGGLESTATUS) OR ((wasControl=1) AND (ch="?"))
      toggleStatusDisplay()
    ENDIF
  ENDIF

  IF ((state=STATE_LOGGEDON) OR (state=STATE_CONNECTING) OR (state=STATE_SYSOPLOGON)) AND (nofkeys=FALSE)
    IF servercmd=SV_UNICONIFY
      servercmd:=-1
      IF scropen THEN expressToFront() ELSE openExpressScreen()
    ENDIF

    ->F1
    IF (servercmd=SV_CHAT) OR ((wasControl=1) AND (ch="0"))
      servercmd:=-1
      IF scropen THEN expressToFront() ELSE openExpressScreen()
      ch:=13
      wasControl:=FALSE
      chatF:=1
      chatFlag:=Not(chatFlag)
      IF (chatFlag<>0)
        IF checkSecurity(ACS_TRANSLATION) AND (StrCmp(userLanguage,hostLanguage)=FALSE)
          setEnvMsg('TranChat')
          IF(tranChat()=RESULT_NO_CARRIER)  THEN reqState:=REQ_STATE_LOGOFF
        ELSE
          setEnvStat(ENV_CHAT)
          IF(chat()=RESULT_NO_CARRIER)  THEN reqState:=REQ_STATE_LOGOFF
        ENDIF
      ENDIF
    ENDIF

    ->F2 - increase time limit
    IF (servercmd=SV_TIMEINCREASE) OR ((wasControl=1) AND (ch="1") AND (loggedOnUser<>NIL))
      servercmd:=-1
      timeLimit:=timeLimit+600
      loggedOnUser.timeTotal:=loggedOnUser.timeTotal+600
    ENDIF

    ->F3 - decrease time limit
    IF (servercmd=SV_TIMEDECREASE) OR ((wasControl=1) AND (ch="2") AND (loggedOnUser<>NIL))
      servercmd:=-1
      timeLimit:=timeLimit-600
      loggedOnUser.timeTotal:=loggedOnUser.timeTotal-600
    ENDIF

    ->F4 - capture
    IF (servercmd=SV_CAPTURE) OR ((wasControl=1) AND (ch="3"))
      servercmd:=-1
      startCapture()
    ENDIF

    ->Shift F4 - display file to user
    IF (servercmd=SV_DISPLAYFILE) OR ((wasControl=2) AND (ch="3"))
      servercmd:=-1
      startASend()
      RETURN TRUE,RESULT_SUCCESS
    ENDIF

    ->F6 - account edit
    IF (servercmd=SV_ACCOUNTS) OR ((wasControl=1) AND (ch="5")) AND (loggedOnUser<>NIL)
      servercmd:=-1
      doOnLineEdit(TRUE)
      checkUserOnLine(0)
      convertAccess()
    ENDIF

    ->Shift F6 - grant/remove temporary access
    IF (servercmd=SV_GRANTTEMP) OR ((wasControl=2) AND (ch="5") AND (loggedOnUser<>NIL))
      servercmd:=-1
      IF(tempAccessGranted)
        loggedOnUser.secStatus:=tempAccess.accessLevel;
        loggedOnUser.secBoard:=tempAccess.ratioType;
        loggedOnUser.secLibrary:=tempAccess.ratio;
        loggedOnUser.timeTotal:=tempAccess.timeTotal;
        AstrCopy(loggedOnUser.conferenceAccess,tempAccess.confAc,10)
        statPrintUser(loggedOnUser,loggedOnUserMisc,loggedOnUserKeys)
      ELSE
        tempAccess.accessLevel:=loggedOnUser.secStatus
        tempAccess.ratioType:=loggedOnUser.secBoard
        tempAccess.ratio:=loggedOnUser.secLibrary
        tempAccess.timeTotal:=loggedOnUser.timeTotal
        AstrCopy(tempAccess.confAc,loggedOnUser.conferenceAccess,10)
        doOnLineEdit(TRUE)
        convertAccess()
      ENDIF
      tempAccessGranted:=Not(tempAccessGranted)
      conPuts('\b\nTemporary Access ')
      conPuts((IF tempAccessGranted THEN 'Granted\b\n' ELSE 'Removed\b\n'))
    ENDIF

    ->F7
    IF (servercmd=SV_CHATTOGGLE) OR ((wasControl=1) AND (ch="6"))
      servercmd:=-1
      sysopAvail:=Not(sysopAvail)
      updateMenus()
      updateTitle(NIL)
      statChatFlag()
    ENDIF

    ->F8 - toggle SER-OUT
    IF ((wasControl=1) AND (ch="7"))
      servercmd:=-1
      IF logonType>=LOGON_TYPE_REMOTE THEN ioFlags[IOFLAG_SER_OUT]:=Not(ioFlags[IOFLAG_SER_OUT])
    ENDIF

    ->F9 - toggle SER-INT
    IF ((wasControl=1) AND (ch="8"))
      servercmd:=-1
      IF logonType>=LOGON_TYPE_REMOTE THEN ioFlags[IOFLAG_SER_IN]:=Not(ioFlags[IOFLAG_SER_IN])
    ENDIF

    ->F10
    IF (servercmd=SV_KICKUSER) OR ((wasControl=1) AND (ch="9"))
      servercmd:=-1
      dropDTR()
      ioFlags[IOFLAG_SER_OUT]:=0
      IF loggedOnUser<>NIL
        saveFlagged()
        IF StrLen(historyFolder)>0 THEN saveHistory()
      ENDIF
      reqState:=REQ_STATE_LOGOFF
      setEnvStat(ENV_LOGOFF)
    ENDIF

    ->Shift 10 - clear tooltype cache
    IF ((wasControl=2) AND (ch="9"))
      clearDiskObjectCache()
    ENDIF

    ->HELP
    IF (servercmd=SV_TOGGLESTATUS) OR ((wasControl=1) AND (ch="?"))
      servercmd:=-1
      toggleStatusDisplay()
    ENDIF
  ENDIF
  servercmd:=-1

  IF netTrans=0 THEN checkShutDown()

  IF(logonType>=LOGON_TYPE_REMOTE)
    IF(checkCarrier()=FALSE) THEN ch:=RESULT_NO_CARRIER
  ENDIF
ENDPROC wasControl, ch

PROC loadAccount(slot,userPtr:PTR TO user, userKeysPtr:PTR TO userKeys, userMiscPtr:PTR TO userMisc)
  DEF l,fh
  DEF result

  result:=RESULT_SUCCESS
  l:=SIZEOF user
  IF (fh:=Open(userDataFile,OLDFILE))<>0
    Seek(fh,(slot-1)*l,OFFSET_BEGINNING)
    IF Read(fh,userPtr,l)<>l THEN result:=RESULT_FAILURE
    Close(fh)
  ELSE
    result:=RESULT_FAILURE
  ENDIF

  IF (userKeysPtr<>NIL)
    l:=SIZEOF userKeys
    IF (fh:=Open(userKeysFile,OLDFILE))<>0
      Seek(fh,(slot-1)*l,OFFSET_BEGINNING)
      IF Read(fh,userKeysPtr,l)<>l THEN result:=RESULT_FAILURE
      Close(fh)
    ELSE
      result:=RESULT_FAILURE
    ENDIF
  ENDIF

  IF (userMiscPtr<>NIL)
    l:=SIZEOF userMisc
    IF (fh:=Open(userMiscFile,OLDFILE))<>0
      Seek(fh,(slot-1)*l,OFFSET_BEGINNING)
      IF Read(fh,userMiscPtr,l)<>l THEN result:=RESULT_FAILURE
      Close(fh)
    ELSE
      result:=RESULT_FAILURE
    ENDIF
  ENDIF

  IF (result=RESULT_SUCCESS) AND userPtr AND userKeysPtr AND userMiscPtr

    ->populate bcd download and upload bytes if not already done
    convertUserUDBytesTOBCD(userPtr,userMiscPtr)
    
    ->populate long download and upload cps if not already done
    IF (userKeysPtr.oldUpCPS<>-1) AND ((userKeysPtr.upCPS2)<>(userKeysPtr.oldUpCPS AND $ffff)) THEN userKeysPtr.upCPS2:=userKeysPtr.oldUpCPS AND $ffff
    IF (userKeysPtr.oldDnCPS<>-1) AND ((userKeysPtr.dnCPS2)<>(userKeysPtr.oldDnCPS AND $ffff)) THEN userKeysPtr.dnCPS2:=userKeysPtr.oldDnCPS AND $ffff
  ENDIF
ENDPROC result

/* if flg > 0 then force save account */
PROC saveAccount(hoozer: PTR TO user, hoozer2: PTR TO userKeys, hoozer3: PTR TO userMisc,uslot,flg) HANDLE
  DEF slot,stat
  DEF fh=NIL,l
  DEF tempStr[255]:STRING

  IF((onlineEdit) AND (logonType>=LOGON_TYPE_REMOTE))
    StringF(tempStr,'\tSaved account \d[4] \s',hoozer.slotNumber,hoozer.name)
    callersLog(tempStr)
  ENDIF

  IF(flg)                /* Force Save User Account */
    uslot--
    slot:=uslot
  ELSE
    IF(hoozer.slotNumber=0) THEN RETURN RESULT_FAILURE
    slot:=hoozer.slotNumber-1
  ENDIF

  l:=SIZEOF user

  fh:=Open(userDataFile,MODE_READWRITE)
  IF(fh=0) THEN RETURN RESULT_FAILURE

  Seek(fh,slot*l,OFFSET_BEGINNING)

  stat:=Write(fh,hoozer,l)
  IF(stat<>l)
    Raise(ERR_EXCEPT)
  ENDIF

  Close(fh)

  l:=SIZEOF userKeys
  fh:=Open(userKeysFile,MODE_READWRITE)
  IF(fh=0) THEN RETURN RESULT_FAILURE

  Seek(fh,slot*l,OFFSET_BEGINNING)

  IF(hoozer.newUser)  THEN hoozer2.newUser:=1 ELSE hoozer2.newUser:=0

  stat:=Write(fh,hoozer2,l)
  IF(stat<>l)
    Raise(ERR_EXCEPT)
  ENDIF

  Close(fh)

  IF (hoozer3<>NIL)
    l:=SIZEOF userMisc
    fh:=Open(userMiscFile,MODE_READWRITE)
    IF(fh=0) THEN RETURN RESULT_FAILURE

    Seek(fh,slot*l,OFFSET_BEGINNING)

    stat:=Write(fh,hoozer3,l)
    IF(stat<>l)
      Raise(ERR_EXCEPT)
    ENDIF

    Close(fh)
  ENDIF
EXCEPT
  Close(fh)
  RETURN RESULT_FAILURE
ENDPROC RESULT_SUCCESS

PROC writeLogoffLog(stringout:PTR TO CHAR,newFile)
  DEF gfp1, xgstr1[20]:STRING, xgstr2[255]:STRING
  DEF calltime
  DEF datestr[20]:STRING
  DEF timestr[20]:STRING
  DEF fname[100]:STRING

  calltime:=getSystemTime()
  formatLongDate(calltime,datestr)
  formatLongTime(calltime,timestr)

  StringF(xgstr1,'\s \s',datestr,timestr)

  StringF(fname,'ram:logoff\d.log',node)

  IF newFile THEN DeleteFile(fname)
  gfp1:=Open(fname,MODE_READWRITE)

  IF(gfp1<>0)
    Seek(gfp1,0,OFFSET_END)
    StringF(xgstr2,'\s ',xgstr1)
    Write(gfp1,xgstr2,StrLen(xgstr2))
    fileWriteLn(gfp1,stringout)
    Close(gfp1)
  ENDIF
ENDPROC

PROC processLoggingOff()
  DEF tempstr[255]:STRING

  writeLogoffLog('logging off 1 (start)',TRUE)

  binaryRaw:=FALSE
  cmdShortcuts:=FALSE
  shortcuts.clear()
  pagedFlag:=FALSE
  chatFlag:=FALSE
  blockOLM:=FALSE
  beenUDd:=FALSE
  IF(sopt.toggles[TOGGLES_QUIETSTART])
    quietFlag:=TRUE
  ELSE
    quietFlag:=FALSE
  ENDIF
  nonStopDisplayFlag:=TRUE

  writeLogoffLog('logging off 2',FALSE)
  processOlmMessageQueue(FALSE)

  setEnvStat(ENV_LOGOFF)
  IF(captureFP)
    Close(captureFP)
    captureFP:=NIL
  ENDIF

  writeLogoffLog('logging off 3',FALSE)
  IF ftpConn=FALSE THEN checkOnlineStatus()
  clearFlagItems(flagFilesList)

  olmBuf.clear()
  olmQueue.clear()

  historyBuf.clear()
  historyNum:=0
  historyCycle:=0

  writeLogoffLog('logging off 4',FALSE)
  IF loggedOnUser<>NIL

    writeLogoffLog('logging off 5',FALSE)
    IF(validUser=3)
      logoffLog('UUCP feed completed')
    ELSEIF lostCarrier
      logoffLog('Loss Carrier')
    ELSE
      logoffLog('N')
    ENDIF

    writeLogoffLog('logging off 6',FALSE)
    IF tempAccessGranted
      loggedOnUser.secStatus:=tempAccess.accessLevel
      loggedOnUser.secBoard:=tempAccess.ratioType
      loggedOnUser.secLibrary:=tempAccess.ratio;
      loggedOnUser.timeTotal:=tempAccess.timeTotal
      AstrCopy(loggedOnUser.conferenceAccess,tempAccess.confAc,10)
      tempAccessGranted:=FALSE
    ENDIF

    writeLogoffLog('logging off 7',FALSE)
    updateTimeUsed()
    checkTimeUsed()
    clearUser()

    writeLogoffLog('logging off 8',FALSE)
    IF(quickFlag=FALSE)
      checkScreenClear()
      IF(logonType<>LOGON_TYPE_SYSOP) AND (ftpConn=FALSE) THEN displayScreen(SCREEN_LOGOFF)
    ENDIF

    writeLogoffLog('logging off 9',FALSE)
    IF(logonType<>LOGON_TYPE_SYSOP) AND (ftpConn=FALSE) THEN aePuts('\b\nClick...')

    AstrCopy(loggedOnUserKeys.userName,loggedOnUser.name,31)
    UpperStr(loggedOnUserKeys.userName)
    loggedOnUserKeys.number:=loggedOnUser.slotNumber

    IF(newSinceFlag) THEN loggedOnUser.newSinceDate:=getSystemTime()

    writeLogoffLog('logging off 10',FALSE)
    saveMsgPointers(currentConf,currentMsgBase)

    loggedOnUser.timeLastOn:=getSystemTime()
    writeLogoffLog('logging off 11',FALSE)
    addMsgPointers()
    masterSavePointers(loggedOnUser)
    writeLogoffLog('logging off 12',FALSE)
    saveAccount(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,0,0) /* Reseave users account after logoff */

    writeLogoffLog('logging off 13',FALSE)

    doLogoffNotify()

    StrCopy(reservedName,'')

    writeLogoffLog('logging off 15',FALSE)
    WHILE(acpLockNodes()<>node)
      StringF(tempstr,'Standby node \d',node)
      setEnvMsg(tempstr)
      Delay(30)
    ENDWHILE
    writeLogoffLog('logging off 16',FALSE)
    processSysCommand('LOGOFF')

    writeLogoffLog('logging off 17',FALSE)
    IF autoDeactivateDays<>-1
      deactivateOldUsers(autoDeactivateDays)
    ENDIF

    writeLogoffLog('logging off 18',FALSE)
    StringF(tempstr,'LOGOFF\d',node)
    processSysCommand(tempstr)

    writeLogoffLog('logging off 19',FALSE)
    IF (relogon)
      processSysCommand('RELOGON')
      StringF(tempstr,'RELOGON\d',node)
      processSysCommand(tempstr)
      IF consoleDebugLevel>=LOG_DEBUG
        errorLog('RL')
      ENDIF
    ENDIF
    writeLogoffLog('logging off 20',FALSE)
    acpLockNodes()

    END loggedOnUser
    END loggedOnUserKeys
    END loggedOnUserMisc
  ENDIF
  writeLogoffLog('logging off 21',FALSE)

  serialCacheEnabled:=FALSE
  flushSerialCache()

  confNameType:=NAME_TYPE_USERNAME
  loggedOnUser:=NIL
  loggedOnUserKeys:=NIL
  loggedOnUserMisc:=NIL
  currentConf:=0
  currentMsgBase:=0
  sendQuietFlag(quietFlag)
  Delay(50)
  stateData:=0
  writeLogoffLog('logging off 22',FALSE)
  disableNodeMenus(FALSE)
  disableOnlineMenus(TRUE)

  StrCopy(telnetUsername,'')
  StrCopy(telnetPassword,'')
  StrCopy(telnetUsernamePrompt,'')
  StrCopy(telnetPasswordPrompt,'')

  quickFlag:=FALSE
  ansiColour:=TRUE
  ripMode:=FALSE
  mcioff:=FALSE
  mciViewSafe:=TRUE
  ftpConn:=FALSE

  writeLogoffLog('logging off 23',FALSE)
  END recFileNames
  recFileNames:=NEW recFileNames.stringlist()

  writeLogoffLog('logging off 24',FALSE)
  IF (relogon=FALSE)
    state:=STATE_AWAIT

    writeLogoffLog('logging off 25',FALSE)
    IF(cmds.acLvl[LVL_SCREEN_TO_FRONT] AND scropen) THEN expressToBack()
    modemOffHook()
  ELSE
    state:=STATE_LOGON
    relogon:=FALSE
  ENDIF
  writeLogoffLog('logging off 26',FALSE)

  IF sopt.trapDoor OR (netTrans=2)
    StrCopy(shutDownMsg,'!')
    reqState:=REQ_STATE_SHUTDOWN
  ENDIF
  writeLogoffLog('logging off 27 (end)',FALSE)
ENDPROC

PROC myDirProtect(bits,ps: PTR TO CHAR)
  DEF c,x,y
  DEF pbits
  pbits:=["d","e","w","r","a","p","s","h" ]:CHAR

  y:=1
  c:=Eor(bits,15)

  FOR x:=0 TO 7
    IF((c AND y)=y) THEN ps[7-x]:=pbits[x]
    y:=Shl(y,1)
  ENDFOR
ENDPROC


PROC myDirDisplay(f_info: PTR TO fileinfoblock)
  DEF t,h,m,s
  DEF ans[10]:STRING
  DEF date[20]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

  t:=dateStampToDateTime(f_info.datestamp)

  formatLongDateTime(t,date)

  t:=t+21601
  StrCopy(ans,'--------')
  myDirProtect(f_info.protection,ans)

  IF(f_info.direntrytype<=0)
    StringF(tempstr,'\d[8]',f_info.size)
  ELSE
    StrCopy(tempstr,'     Dir')
  ENDIF

  StringF(tempstr2,' \l\s[25] \s \s \s \r\z\d[2]:\r\z\d[2]:\r\z\d[2]\b\n',f_info.filename,tempstr,ans,date,h,m,s)
  aePuts(tempstr2)
ENDPROC

PROC myDirRecurse(path: PTR TO CHAR,cflag)
  DEF stat=0
  DEF lock
  DEF f_info: PTR TO fileinfoblock
  DEF tempstr[255]:STRING

  f_info:=AllocDosObject(DOS_FIB,NIL)
  IF(f_info)=NIL THEN RETURN

  lock:=Lock(path,ACCESS_READ)
  IF(lock)=0
    FreeDosObject(DOS_FIB,f_info)
    RETURN
  ENDIF

  IF(Examine(lock,f_info))=0
    StringF(tempstr,'\s does not exist\b\n',path)
    aePuts(tempstr)
    UnLock(lock)
    FreeDosObject(DOS_FIB,f_info)
    RETURN
  ENDIF

  lineCount:=0
  IF(f_info.direntrytype>0)
    StringF(tempstr,'Directory of \s\b\n',path)
    aePuts(tempstr)

    WHILE(((ExNext(lock,f_info))<>0) AND(stat=FALSE))
      myDirDisplay(f_info)
      stat:=checkForPause()
      IF(cflag AND (stat=FALSE) AND (StrLen(f_info.comment)>0))
        aePuts(' : ')
        aePuts(f_info.comment)
        aePuts('\b\n')
        stat:=checkForPause()
      ENDIF
    ENDWHILE
  ELSE
    myDirDisplay(f_info)
  ENDIF

  UnLock(lock)
  FreeDosObject(DOS_FIB,f_info)
ENDPROC


PROC myDirAnyWhere(params)
  DEF stat,comments=0
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

  nonStopDisplayFlag:=FALSE

  aePuts('\b\n')
  parseParams(params)

  IF(parsedParams.count()>0)
    StrCopy(tempstr,parsedParams.item(0))
    IF parsedParams.count()>1
      IF StriCmp(parsedParams.item(1),'c',1) THEN comments:=1
    ENDIF
  ELSE
    comments:=1
    aePuts('FullPath for directory? ')
    stat:=lineInput('','',250,INPUT_TIMEOUT,tempstr)
    IF((stat<0) OR (StrLen(tempstr)=0))
      aePuts('\b\n')
      RETURN
    ENDIF

    IF(findAssign(tempstr))
      aePuts('\b\nDevice not Mounted.\b\n')
      aePuts('\b\n')
      RETURN
    ENDIF

    aePuts('Include comments (Y/n)? ')
    stat:=lineInput('','',3,INPUT_TIMEOUT,tempstr2)
    IF(stat<0) THEN RETURN

    IF((tempstr2[0]="n") OR (tempstr2[0]="N")) THEN comments:=0
  ENDIF
  myDirRecurse(tempstr,comments)
  aePuts('\b\n')
ENDPROC

PROC setTempSecurityFlags(securityFlag)
  WHILE StrLen(securityFlags)<=securityFlag
    StrAdd(securityFlags,'?')
  ENDWHILE
  securityFlags[securityFlag]:="T"
ENDPROC

PROC clearTempSecurityFlags(securityFlag)
  WHILE StrLen(securityFlags)<=securityFlag
    StrAdd(securityFlags,'?')
  ENDWHILE
  securityFlags[securityFlag]:="F"
ENDPROC

PROC clearOverride()
  StrCopy(secOverride,'')
ENDPROC

PROC setOverride(securityFlag)
 WHILE StrLen(secOverride)<=securityFlag
    StrAdd(secOverride,'F')
  ENDWHILE
  secOverride[securityFlag]:="T"
ENDPROC

PROC checkSecurity(securityFlag)
  IF (loggedOnUser=NIL) THEN RETURN FALSE

  IF (StrLen(secOverride)>securityFlag)
    IF secOverride[securityFlag]="T" THEN RETURN FALSE
  ENDIF
  
  IF (StrLen(securityFlags)>securityFlag)
    IF securityFlags[securityFlag]<>"?" THEN RETURN (securityFlags[securityFlag]="T")
  ENDIF

  IF securityFlag=ACS_SENTBY_FILES
    RETURN cmds.acLvl[LVL_SENTBY_FILES]
  ELSEIF securityFlag=ACS_DEFAULT_CHAT_ON
    RETURN cmds.acLvl[LVL_DEFAULT_CHAT_ON]
  ELSEIF securityFlag=ACS_CLEAR_SCREEN_MSG
    IF loggedOnUserKeys=NIL THEN RETURN FALSE
    RETURN loggedOnUserKeys.userFlags AND USER_SCRNCLR
  ELSEIF securityFlag=ACS_KEEP_UPLOAD_CREDIT
    RETURN cmds.acLvl[LVL_KEEP_UPLOAD_CREDIT]
  ELSEIF securityFlag=ACS_DO_CALLERSLOG
    RETURN cmds.acLvl[LVL_DO_CALLERSLOG]
  ELSEIF securityFlag=ACS_DO_UD_LOG
    RETURN cmds.acLvl[LVL_DO_UD_LOG]
  ELSEIF securityFlag=ACS_SCREEN_TO_FRONT
    RETURN cmds.acLvl[LVL_SCREEN_TO_FRONT]
  ELSEIF securityFlag=ACS_WILDCARDS
    RETURN sopt.toggles[TOGGLES_USEWILDCARDS]
  ELSEIF (securityFlag=ACS_MSG_LEVEL) OR (securityFlag=ACS_MSG_EXPERATION) OR (securityFlag=ACS_CUSTOMCOMMANDS) OR (securityFlag=ACS_JOIN_SUB_CONFERENCE)
    RETURN TRUE
  ENDIF

  IF (overrideDefaultAccess=FALSE) AND (securityFlag<>ACS_OVERRIDE_DEFAULTS)
    IF checkToolTypeExists(TOOLTYPE_DEFAULT_ACCESS,0,ListItem(securityNames,securityFlag)) THEN RETURN TRUE
  ENDIF

  IF (acsLevel=-1) THEN RETURN FALSE

  IF userSpecificAccess
    IF checkToolTypeExists(TOOLTYPE_USER_ACCESS,0,ListItem(securityNames,securityFlag)) THEN RETURN TRUE
  ENDIF

ENDPROC checkToolTypeExists(TOOLTYPE_ACCESS,acsLevel,ListItem(securityNames,securityFlag))

PROC checkConfAccess(confNum,user=NIL:PTR TO user)
  DEF ttname[20]:STRING
  IF user=NIL THEN user:=loggedOnUser
  IF (user=NIL) THEN RETURN FALSE

  IF isConfAccessAreaName(user)=FALSE
    IF (confNum<=StrLen(user.conferenceAccess))
      IF user.conferenceAccess[confNum-1]="X" THEN RETURN TRUE
    ENDIF
    RETURN FALSE
  ENDIF

  StringF(ttname,'Conf.\d',confNum)
ENDPROC checkToolTypeExists(TOOLTYPE_AREA,user.conferenceAccess,ttname)

PROC myError(errorCode)
  DEF errorString[100]:STRING

  SELECT errorCode
    CASE ERR_MEMORY
      StringF(errorString,'Could not allocate enough memory for workspace')
    CASE ERR_MEMORY2
      StringF(errorString,'Tell \s there is a memory problem.',cmds.sysopName)
    CASE ERR_MSGBASE
      StringF(errorString,'Msg Base ERROR!!  Please notify \s',cmds.sysopName)
    CASE ERR_MEMORY3
      StringF(errorString,'No Mem Error: Not enough memory to finish operation')
    CASE ERR_FILELIST
      StringF(errorString,'There is a problem with File listings, please tell \s',cmds.sysopName)
    CASE ERR_NOFILES
      aePuts('No files available in this conference.\b\n\b\n')
      RETURN
    CASE ERR_FILEEXAMINE
      StringF(errorString,'Tell \s there is a File Examine Error',cmds.sysopName)
    CASE ERR_WORKDIROPEN
      StringF(errorString,'Tell \s the system can''t open a file in the work dirs',cmds.sysopName)
    CASE ERR_LOCK
      StringF(errorString,'Tell \s the system has a Lock Error',cmds.sysopName)
    CASE ERR_FREESPACE
      StringF(errorString,'Not enough free space on Device for uploading.')
    CASE ERR_SYMBOLS
      StringF(errorString,'\b\nYou may not include any special symbols\b\n')
      RETURN
    CASE ERR_FIB_MEMORY
      StringF(errorString,'Out of chipmem for FileInfoBlock')
    CASE ERR_NO_BULLS
      aePuts('\b\nNo bulletins are available in this conference!\b\n\b\n')
      RETURN
    CASE ERR_NO_CONFFLAGS
      aePuts('\b\nNo ConfFlags are available in this conference!\b\n')
      RETURN
  ENDSELECT

  aePuts('\b\n')
  aePuts(errorString)
  aePuts('\b\n\b\n')
  errorLog(errorString)
ENDPROC

PROC relConf(cn)
  DEF i=0
  DEF count=0

  WHILE(i<cn)
    IF((checkConfAccess(i+1)=TRUE) OR (sopt.toggles[TOGGLES_CONFRELATIVE]=FALSE)) THEN count++
    i++
  ENDWHILE
ENDPROC count

PROC getInverse(cn,force=FALSE)
  DEF i=0
  DEF j=0
  IF(cn<1) THEN RETURN 0
  IF (force=FALSE) AND (sopt.toggles[TOGGLES_CONFRELATIVE]=FALSE) THEN RETURN cn
    WHILE(i<cn)
      IF(j<cmds.numConf)
       IF(checkConfAccess(j+1)) THEN i++
      ELSE
        RETURN 0
      ENDIF
      j++
    ENDWHILE
ENDPROC j

PROC masterLoadPointers(hoozer: PTR TO user)
  DEF i,m,cb: PTR TO confBase

  FOR i:=1 TO cmds.numConf
    FOR m:=1 TO getConfMsgBaseCount(i)
      cb:=confBases.item(getConfIndex(i,m))
      loadConfDB(hoozer.slotNumber,i,m,cb,TRUE)
    ENDFOR
  ENDFOR
ENDPROC

PROC clearMsgPointers()
  DEF cb: PTR TO confBase
  DEF i,j,m,defaultmask

  FOR i:=1 TO cmds.numConf
    FOR m:=1 TO getConfMsgBaseCount(i)
      cb:=confBases.item(getConfIndex(i,m))
      cb.bytesDownload:=0
      cb.bytesUpload:=0
      FOR j:=0 TO 7
        cb.downloadBytesBCD[j]:=0
        cb.uploadBytesBCD[j]:=0
      ENDFOR
      cb.upload:=0
      cb.downloads:=0
      cb.ratioType:=0
      cb.ratio:=0
      cb.messagesPosted:=0
      cb.uploadTracking:=0
      cb.unused:=0
      cb.confYM:=0
      cb.confRead:=0
      defaultmask:=0

      IF checkToolTypeExists(TOOLTYPE_CONF,i,'DEFAULT_NEWSCAN') THEN defaultmask:=defaultmask OR MAIL_SCAN_MASK
      IF checkToolTypeExists(TOOLTYPE_CONF,i,'DEFAULT_NEW_FILES') THEN defaultmask:=defaultmask OR FILE_SCAN_MASK
      IF checkToolTypeExists(TOOLTYPE_CONF,i,'DEFAULT_ZOOM') THEN defaultmask:=defaultmask OR ZOOM_SCAN_MASK
      cb.handle[0]:=defaultmask
    ENDFOR
  ENDFOR
ENDPROC

PROC addMsgPointers()
  DEF i,m
  DEF cb: PTR TO confBase

  IF loggedOnUser.slotNumber<=0 THEN RETURN

  IF (checkSecurity(ACS_CONFERENCE_ACCOUNTING))
    loggedOnUser.bytesDownload:=0
    loggedOnUser.bytesUpload:=0
    FOR i:=0 TO 7
      loggedOnUserMisc.downloadBytesBCD[i]:=0
      loggedOnUserMisc.uploadBytesBCD[i]:=0
    ENDFOR
    loggedOnUser.uploads:=0
    loggedOnUser.downloads:=0
  ENDIF
  loggedOnUser.messagesPosted:=0

  FOR i:=1 TO cmds.numConf
    FOR m:=1 TO getConfMsgBaseCount(i)
      cb:=confBases.item(getConfIndex(i,m))
      IF (checkSecurity(ACS_CONFERENCE_ACCOUNTING)) AND (readToolTypeInt(TOOLTYPE_CONF,i,'CONFDB_SHARED')<=0) AND (checkConfAccess(i))
        addBCD2(loggedOnUserMisc.downloadBytesBCD,cb.downloadBytesBCD)
        addBCD2(loggedOnUserMisc.uploadBytesBCD,cb.uploadBytesBCD)
        loggedOnUser.bytesDownload:=convertFromBCD(loggedOnUserMisc.downloadBytesBCD)
        loggedOnUser.bytesUpload:=convertFromBCD(loggedOnUserMisc.uploadBytesBCD)
        loggedOnUser.uploads:=loggedOnUser.uploads+cb.upload
        loggedOnUser.downloads:=loggedOnUser.downloads+cb.downloads
      ENDIF
      loggedOnUser.messagesPosted:=loggedOnUser.messagesPosted+cb.messagesPosted
    ENDFOR
  ENDFOR

ENDPROC

PROC masterSavePointers(hoozer: PTR TO user)
  DEF i,m,cb: PTR TO confBase

  FOR i:=1 TO cmds.numConf
    FOR m:=1 TO getConfMsgBaseCount(i)
      cb:=confBases.item(getConfIndex(i,m))
      saveConfDB(hoozer.slotNumber,i,m,cb,TRUE)
    ENDFOR
  ENDFOR
ENDPROC

PROC getMailStatFile(confNum,msgBaseNum)
  DEF fd, stat
  DEF string[100]:STRING

  getMsgBaseLocation(confNum,msgBaseNum,string)
  StrAdd(string,'MailStats')

  fd:=Open(string,OLDFILE)
  IF(fd=0)
    fd:=Open(string,MODE_READWRITE)
    IF(fd=0)
      myError(ERR_MSGBASE)
      mailStat.lowestKey:=0
      mailStat.lowestNotDel:=0
      mailStat.highMsgNum:=0

      RETURN RESULT_FAILURE
    ENDIF

    mailStat.lowestNotDel:=0
    mailStat.lowestKey:=1
    mailStat.highMsgNum:=1
    stat:=Write(fd,mailStat,SIZEOF mailStat)
  ELSE
    stat:=Read(fd,mailStat,SIZEOF mailStat)
  ENDIF

  IF (stat<>SIZEOF mailStat)
    Close(fd)
    myError(ERR_MSGBASE)
    RETURN RESULT_FAILURE
  ENDIF

  Close(fd)

ENDPROC RESULT_SUCCESS

PROC parseList(liststring,list:PTR TO stringlist)
  DEF spacepos,startpos,newitem
  DEF tempstr[255]:STRING

  list.clear()

  IF StrLen(liststring)=0 THEN RETURN

  startpos:=0
  spacepos:=InStr(liststring,' ')
  IF spacepos>=0
    WHILE(spacepos>=0)
      midStr2(tempstr,liststring,startpos,spacepos-startpos)
      UpperStr(tempstr)
      newitem:=TrimStr(tempstr)
      IF StrLen(newitem)>0 THEN list.add(newitem)
      startpos:=spacepos+1
      WHILE ((startpos<StrLen(liststring)) AND (liststring[startpos]=" ")) DO startpos:=startpos+1
      spacepos:=InStr(liststring,' ',startpos)
    ENDWHILE
    IF startpos<StrLen(liststring)
      midStr2(tempstr,liststring,startpos,StrLen(liststring)-startpos)
      UpperStr(tempstr)
      newitem:=TrimStr(tempstr)
      IF StrLen(newitem)>0 THEN list.add(newitem)
    ENDIF
  ELSE
    StrCopy(tempstr,liststring)
    UpperStr(tempstr)
    IF StrLen(tempstr)>0 THEN list.add(tempstr)
  ENDIF
ENDPROC

PROC parseParams(paramstring)
  parsedParams.clear()
  parseList(paramstring,parsedParams)
ENDPROC

PROC paramsContains(paramcheck)
  DEF i

  FOR i:=0 TO parsedParams.count()-1
    IF StrCmp(parsedParams.item(i),paramcheck) THEN RETURN TRUE
  ENDFOR

ENDPROC FALSE


PROC commentToSYSOP()
  DEF stat
  DEF str[255]:STRING
  DEF oldConf,oldMsgBase

  stat:=captureRealAndInternetNames(currentConf,currentMsgBase)
  IF stat<0 THEN RETURN stat
  
  stat:=loadAccount(1,tempUser,tempUserKeys,tempUserMisc)
  IF(stat<0)
    RETURN stat
  ENDIF

  SELECT confNameType
    CASE NAME_TYPE_USERNAME
      AstrCopy(mailHeader.toName,tempUserKeys.userName,31)
    CASE NAME_TYPE_REALNAME
      AstrCopy(mailHeader.toName,tempUserMisc.realName,26)
    CASE NAME_TYPE_INTERNETNAME
      AstrCopy(mailHeader.toName,tempUserMisc.internetName,10)
  ENDSELECT

  aePuts('\b\n                       [32m([33m------------------------------[32m)[0m\b\n')
  StringF(str,'     [36mTo[33m: [32m([33mEnter[32m)[0m=[32m''[33mALL[32m''[32m?[0m \s\b\n',mailHeader.toName)
  aePuts(str)
  checkToForward(str,mailHeader.toName,0)
  aePuts('[36mSubject[33m: [32m([33mBlank[32m)[0m=[33mabort[32m?[0m ')
  stat:=lineInput('','',30,INPUT_TIMEOUT,str)
  IF(stat<0) THEN RETURN stat

  IF (StrLen(str)=0)
    aePuts('\b\n')
    RETURN RESULT_SUCCESS
  ENDIF
  AstrCopy(mailHeader.subject,str,30)
  mailHeader.status:="R"
  comment:=1
  oldConf:=currentConf
  oldMsgBase:=currentMsgBase
  IF currentConf=0 THEN currentConf:=1
  IF currentMsgBase=0 THEN currentMsgBase:=1
  stat:=callMsgFuncs(MAIL_CREATE,currentConf,currentMsgBase)
  currentConf:=oldConf
  currentMsgBase:=oldMsgBase
  comment:=0
  IF(stat<0) THEN RETURN stat
ENDPROC RESULT_SUCCESS

-> checks to see if a string contains a numeric value
PROC isDigit(teststring)
  DEF d,n

  d,n:=Val(teststring)
  IF (n>0) THEN RETURN TRUE
ENDPROC FALSE

PROC firstChar(teststring)
ENDPROC TrimStr(teststring)-teststring

PROC firstCharValue(teststring)
  IF StrLen(teststring)=0 THEN RETURN 0
ENDPROC teststring[0]

PROC listMSGs(gfh)
  DEF tempStr[255]:STRING
  DEF r
  DEF oldMsgNum
  DEF mailFlag=0
  DEF mailStatus[10]:STRING
  DEF cb:PTR TO confBase
  
  nonStopDisplayFlag:=FALSE
  oldMsgNum:=msgNum

  StringF(tempStr,'[32mStarting message [33m[[0m\d[33m][0m: ',mailStat.lowestNotDel)
  aePuts(tempStr)
  lineInput('','',10,INPUT_TIMEOUT,tempStr)
  IF StrLen(tempStr)=0
    msgNum:=mailStat.lowestNotDel
    r:=1
  ELSE
    msgNum,r:=Val(tempStr)
  ENDIF
  IF r=0
    msgNum:=oldMsgNum
    RETURN RESULT_FAILURE
  ENDIF

  REPEAT
    IF(msgNum>=mailStat.highMsgNum)
      JUMP listOUT
    ENDIF
    loadMessageHeader(gfh)
    IF(mailHeader.status="D") THEN JUMP listNextMSG

    cb:=confBases.item(getConfIndex(currentConf,currentMsgBase))

    IF(((stringCompare(mailHeader.toName,confMailName)=RESULT_SUCCESS) OR (stringCompare(mailHeader.toName,'eall')=RESULT_SUCCESS) OR ((stringCompare(mailHeader.toName,'all')=RESULT_SUCCESS) AND (cb.handle[0] AND MAILSCAN_ALL))))
      IF(mailFlag=0)
        aePuts('\b\n\b\n')
        aePuts('[32mMsg    Type     From                           Subject              \b\n')
        aePuts('[33m------ -------  -----------------------------  ---------------------\b\n')
        aePuts('[0m')
        IF(nonStopDisplayFlag=FALSE) THEN lineCount:=lineCount+4
        mailFlag:=1
      ENDIF
      IF (mailHeader.status="P") OR (mailHeader.status="p") THEN StrCopy(mailStatus,'Public ') ELSE StrCopy(mailStatus,'Private')
      StringF(tempStr,'\z\r\d[6] \s  \l\s[29]  \l\s[21]  [0m\b\n',mailHeader.msgNumb,mailStatus,mailHeader.fromName,mailHeader.subject)
      aePuts(tempStr)

      IF checkForPause()=RESULT_FAILURE
        msgNum:=oldMsgNum
        RETURN RESULT_SUCCESS
      ENDIF

    ENDIF
listNextMSG:
    msgNum++
  UNTIL msgNum>mailStat.highMsgNum
listOUT:
  msgNum:=oldMsgNum
ENDPROC

PROC displayMessage(gfh)
  DEF timeVar
  DEF str[255]:STRING
  DEF string[255]:STRING
  DEF date[100]:STRING
  DEF tempStr[255]:STRING
  DEF stat

  IF(mailHeader.status="D")
    checkScreenClear()
    aePuts('\b\nThat message has been deleted.\b\n\b\n')
    RETURN 0
  ENDIF

  timeVar:=mailHeader.msgDate
  formatLongDateTime(timeVar,date)

  IF translatorMode=TRANS_NONE
    checkScreenClear()

    StringF(str,'[32mDate   [33m: [0m\l\s[30]   [32mNumber[33m: [0m\d\b\n',date,mailHeader.msgNumb)
    aePuts(str)
    StrCopy(date,mailHeader.toName,31)
    LowerStr(date)
    timeVar:=(StrCmp(date,'eall',4))
    IF(timeVar)
      StrCopy(date,confMailName,31)
      StrAdd(date,' (ALL)')
    ELSE
      StrCopy(date,mailHeader.toName,31)
    ENDIF

    StringF(str,'[32mTo     [33m: [0m\l\s[30]  ',date)

    aePuts(str)
    IF(mailHeader.recv<>0)
      timeVar:=mailHeader.recv
      formatLongDateTime(timeVar,date)
      StringF(str,' [32mRecv''d[33m: [0m\s\b\n',date)
      aePuts(str)
    ELSE
      aePuts(' [32mRecv''d[33m: [0m')
      IF(stringCompare(mailHeader.toName,'ALL')=RESULT_SUCCESS)
        aePuts('N/A\b\n')
      ELSE
        aePuts('No\b\n')
      ENDIF
    ENDIF

    IF(mailHeader.status="P") OR (mailHeader.status="p")
      StrCopy(string,'Public Message')
    ELSE
      StrCopy(string,'Private Message')
    ENDIF

    StringF(str,'[32mFrom   [33m: [0m\l\s[30]   [32mStatus[33m: [0m\s\b\n',mailHeader.fromName,string)
    aePuts(str)
    StringF(str,'[32mSubject[33m: [0m\s\b\n\b\n',mailHeader.subject)
    aePuts(str)
    lineCount:=lineCount+5

    alreadyRecvd:=mailHeader.recv

    IF(stringCompare(mailHeader.toName,confMailName)=RESULT_SUCCESS)
      IF(mailHeader.recv=0)
       mailHeader.recv:=getSystemTime()
          delMsgNum:=mailHeader.msgNumb
          saveOverHeader(gfh)
      ENDIF
    ENDIF

  ENDIF

  StringF(tempStr,'\s\d',msgBaseLocation,mailHeader.msgNumb)
  IF(nonStopMail)
    nonStopDisplayFlag:=TRUE
    mcioff:=TRUE
    displayFile(tempStr,TRUE,FALSE,FALSE)
    IF(stat=RESULT_FAILURE) THEN nonStopMail:=FALSE
  ELSE
    mcioff:=TRUE
    displayFile(tempStr,TRUE,TRUE,FALSE)
  ENDIF
  mcioff:=FALSE
  stat:=checkAttachedFile(mailHeader.msgNumb,1)
ENDPROC stat


PROC errorLog(stringout: PTR TO CHAR)
  DEF gfp1, xgstr1[20]:STRING, xgstr2[255]:STRING
  DEF calltime
  DEF datestr[20]:STRING
  DEF timestr[20]:STRING
  DEF fname[100]:STRING

  calltime:=getSystemTime()
  formatLongDate(calltime,datestr)
  formatLongTime(calltime,timestr)

  StringF(xgstr1,'\s \s',datestr,timestr)

  StringF(fname,'\sNode\d/ErrorLog',cmds.bbsLoc,node)

  gfp1:=Open(fname,MODE_READWRITE)

  IF(gfp1<>0)
    Seek(gfp1,0,OFFSET_END)
    StringF(xgstr2,'\s ',xgstr1)
    Write(gfp1,xgstr2,StrLen(xgstr2))
    fileWriteLn(gfp1,stringout)
    Close(gfp1)
  ENDIF
ENDPROC

PROC fileListReverse(filename: PTR TO CHAR) HANDLE
  DEF currentPos,readsize,loop,stat
  DEF buf=NIL:PTR TO CHAR
  DEF bufptr1:PTR TO CHAR, bufptr2:PTR TO CHAR
  DEF fh=NIL
  DEF memsize=4096
  DEF bufend,temp
  readsize:=memsize

  IF (buf:=New((memsize*2)+2))<>0
    bufptr1:=buf
    bufptr2:=buf+memsize+1
    bufend:=FALSE

    IF(fh:=Open(filename,MODE_OLDFILE))<>0

      Seek(fh,0,OFFSET_END)
      currentPos:=Seek(fh,0,OFFSET_CURRENT)
      readsize:=memsize
      stat:=0
      REPEAT
        IF currentPos<memsize
          readsize:=currentPos
          currentPos:=0
        ELSE
          currentPos:=currentPos-memsize
        ENDIF

        Seek(fh,currentPos,OFFSET_BEGINNING)
        Read(fh,bufptr2,readsize)
        bufptr2[readsize]:=0
        FOR loop:=readsize-1 TO 0 STEP -1
          IF (bufptr2[loop]="\n") AND (((bufend) AND (loop=(readsize-1)) AND (bufptr1[0]>" ")) OR (bufptr2[loop+1]>" "))
            stat:=displayIt3(bufptr2+loop+1)
            bufptr2[loop+1]:=0
            IF stat<0
              Raise(ERR_EXCEPT)
            ENDIF
            IF bufend
              stat:=displayIt3(bufptr1)
              IF stat<0
                Raise(ERR_EXCEPT)
              ENDIF
            ENDIF
            bufend:=FALSE
          ENDIF
        ENDFOR
        IF (currentPos>0) THEN bufend:=TRUE
        temp:=bufptr1
        bufptr1:=bufptr2
        bufptr2:=temp
      UNTIL (currentPos<=0) OR (stat<0)
      Close(fh)
      fh:=NIL
      stat:=displayIt3(bufptr1)
      IF stat<0
        Raise(ERR_EXCEPT)
      ENDIF
      IF bufend
        stat:=displayIt3(bufptr2)
        IF stat<0
          Raise(ERR_EXCEPT)
        ENDIF
      ENDIF
    ENDIF
    Dispose(buf)
  ENDIF
EXCEPT
  IF fh THEN Close(fh)
  IF buf THEN Dispose(buf)
  RETURN stat
ENDPROC RESULT_SUCCESS

PROC displayCallersLog(filename: PTR TO CHAR,tf)

  DEF stat,stat2,loop,lnlp=0,readSize,currentPos
  DEF buf:PTR TO CHAR
  DEF fh
  DEF memsize=4096
  DEF tempstr[255]:STRING
  DEF count

  readSize:=memsize
  lineCount:=0
  nonStopDisplayFlag:=FALSE
  IF(tf) THEN nonStopDisplayFlag:=TRUE

  IF(buf:=AllocMem(memsize+4,MEMF_ANY))<>0
    IF(fh:=Open(filename,MODE_OLDFILE))<>0
      Seek(fh,0,OFFSET_END)
      currentPos:=Seek(fh,0,OFFSET_CURRENT)
      REPEAT
        IF(currentPos<memsize)
          readSize:=currentPos+lnlp
          currentPos:=0
        ELSE
          currentPos:=(currentPos-4096)+lnlp
        ENDIF

        stat:=Seek(fh,currentPos,OFFSET_BEGINNING)
        IF(stat>=0)
          Seek(fh,0,OFFSET_CURRENT)
          IF((stat:=Read(fh,buf,readSize)))>0
            buf[readSize-1]:=0
            lnlp:=0
            FOR loop:=readSize TO 1 STEP -1
              IF(buf[loop]="\n")
                StringF(tempstr,'\s\b\n',buf+loop+1)
                
                ->bit of a hack to the lineCount to try and take account of long log lines that wrap around
                ->usually log lines start with a tab so anything over 72 characters would probably wrap around
                count:=StrLen(buf+loop+1)
                IF count>72
                  lineCount:=lineCount+(Div(count-72,80))+1
                ENDIF
                aePuts(tempstr)
                buf[loop]:=0
                lnlp:=loop+1
                IF(stat2:=checkForPause())<>0
                  aePuts('\b\n')
                  loop:=0;
                  stat:=(-1)
                ENDIF
                IF(sCheckInput())
                  stat2:=readChar(1)
                  IF(stat2<0)
                      loop:=0;
                      stat:=(-1);
                  ELSE
                    SELECT stat2
                      CASE 19 /* Pause */
                        stat:=readChar(INPUT_TIMEOUT)
                        IF(stat2<0)
                          loop:=0
                          stat:=(-1)
                        ENDIF
                      CASE 3 /* ^C */
                        aePuts('**Break\b\n\b\n')
                        IF(ansiColour) THEN aePuts('[0m')
                        loop:=0
                        stat:=(-1);
                    ENDSELECT
                  ENDIF
                ENDIF
              ENDIF
            ENDFOR
          ENDIF
          IF(stat<0)
            stat:=IoErr()
            IF(stat>0)
                ->sprintf(GSTR2,"IOErr #%d\b\n",stat);
                ->AEPutStr(GSTR2);
            ENDIF
            stat:=(-1)
          ENDIF
        ENDIF
      UNTIL (currentPos<=0) OR (stat<0)
      Close(fh)
    ELSE
      aePuts('\b\nNot a valid node!\b\n\b\n')
    ENDIF

    FreeMem(buf,memsize+4)
  ENDIF
ENDPROC

PROC debugLog(logType,logline:PTR TO CHAR)
  DEF buff[255]:STRING
  DEF currTime,currTick

  IF consoleDebugLevel>=logType
    currTime,currTick:=getSystemTime()

    WriteF('\d.\z\l\d[2] \s\n',currTime,currTick,logline)
  ENDIF

  IF debugLogLevel>=logType
    StringF(buff,'\tD-(Node \d)\s',node,logline)
    errorLog(buff)
  ENDIF
ENDPROC

PROC runFifoHandler()
  DEF m,p:PTR TO process,i
  DEF c:PTR TO commandlineinterface
  DEF s:PTR TO CHAR
  DEF tempstr[255]:STRING
  DEF found=FALSE
  
  ->check to see if fifo handler is running and run it if not
  
  Forbid()
  m:=MaxCli()
   
  FOR i:=1 TO m
    p:=FindCliProc(i)
    IF p
      c:=p.cli
      IF c
        c:=Shl(c,2)
        s:=c.commandname
        IF s
          s:=Shl(s,2)
          StrCopy(tempstr,s+1,s[0])
          LowerStr(tempstr)
          IF StrCmp(tempstr,'l:fifo-handler') THEN found:=TRUE
        ENDIF
      ENDIF
    ENDIF
    
  ENDFOR
  Permit()
  IF found=FALSE THEN Execute('Run >NIL: <NIL: l:fifo-handler',0,0)
ENDPROC

PROC remoteShell() HANDLE
  DEF rMsg:mn
  DEF wMsg:mn
  DEF fifoName[255]:STRING
  DEF fifoMast[255]:STRING
  DEF fifoSlav[255]:STRING
  DEF ioSink=NIL:PTR TO mp
  DEF fifoR=NIL
  DEF fifoW=NIL

  DEF fifrIP=0
  DEF fifwIP=0
  DEF done=0
  DEF pmask
  DEF msg:PTR TO mn
  DEF n,ch
  DEF bufptr:PTR TO CHAR
  DEF temp[255]:STRING
  DEF tags:PTR TO LONG

  runFifoHandler()

  StringF(fifoName,'bbsshell\d',node)

  StringF(fifoMast, '\s_m', fifoName)
  StringF(fifoSlav, '\s_s', fifoName)

  ioSink:=createPort(NIL, 0)

  fifobase:=OpenLibrary('fifo.library', 0)
  IF (fifobase=NIL)
    aePuts('unable to open fifo.library\n')
    callersLog('\tunable to open fifo.library\n')
    deletePort(ioSink)
    RETURN RESULT_FAILURE
  ENDIF

  fifoW:=OpenFifo(fifoMast, 2048, FIFOF_WRITE OR FIFOF_NORMAL OR FIFOF_NBIO)
  IF (fifoW = NIL)
    aePuts('unable to open fifo master\n')
    callersLog('\tunable to open fifo master\n')
    Raise(ERR_EXCEPT)
  ENDIF

  fifoR:=OpenFifo(fifoSlav, 2048, FIFOF_READ  OR FIFOF_NORMAL OR FIFOF_NBIO)
  IF (fifoR = NIL)
    aePuts('unable to open fifo slave\n')
    callersLog('\tunable to open fifo slave\n')
    Raise(ERR_EXCEPT)
  ENDIF


  rMsg.replyport:=ioSink
  wMsg.replyport:=ioSink

  IF(findAssign('fifo:')<>0)
    aePuts('unable to find fifo: device\n')
    callersLog('\tunable to find fifo: device\n')
    Raise(ERR_EXCEPT)
  ENDIF


  StringF(temp,'newshell fifo:\s/rwkecs',fifoName)
  tags:=NEW [SYS_INPUT,0,SYS_OUTPUT,0,SYS_ASYNCH,1,TAG_DONE]
  SystemTagList(temp,tags)
  FastDisposeList(tags)

  pmask:=Shl(1,ioSink.sigbit)

  RequestFifo(fifoR, rMsg, FREQ_RPEND)
  fifrIP:=1

  conCursorOn()
  aePuts('\b\n')

  Wait(pmask)   ->shell should send start string when it's started

  WHILE (done=FALSE)

    WHILE ((msg:=GetMsg(ioSink)))
      IF (msg = rMsg)
        ->incoming message from fifo read
        fifrIP:=0

        IF ((n:=ReadFifo(fifoR, {bufptr}, 0)) > 0)
          aePuts2(bufptr, n)
                    /*  clear N bytes   */
          n:=ReadFifo(fifoR, {bufptr}, n)
        ENDIF

        IF (n < 0)            /*  EOF */
          aePuts('\nREMOTE EOF!\n')
          done:=TRUE
        ELSE
          RequestFifo(fifoR, rMsg, FREQ_RPEND)
          fifrIP:=1
        ENDIF
      ENDIF
    ENDWHILE

    IF done=0
      ch:=readChar(INPUT_TIMEOUT,pmask,TRUE)

      IF (ch<0) OR (reqState<>REQ_STATE_NONE)
        ->timeout or kill signal
        done:=TRUE
      ENDIF

      IF (done=0) AND (ch<>0)
        ->incoming message from console read
        SELECT ch
          CASE 3
            sendBreak("C")
          CASE 4
            sendBreak("D")
          CASE 5
            sendBreak("E")
          CASE 6
            sendBreak("F")
          DEFAULT
            StrCopy(temp,'#')
            temp[0]:=ch
            n:=WriteFifo(fifoW, temp, 1)
            IF (n <> 1)
              IF (fifwIP = 0)
                RequestFifo(fifoW, wMsg, FREQ_WAVAIL)
                fifwIP:=1
              ENDIF
            ENDIF
        ENDSELECT
      ENDIF
    ENDIF
  ENDWHILE

  conCursorOff()

  IF (fifwIP)
    RequestFifo(fifoW, wMsg, FREQ_ABORT)
    waitMsg(wMsg)
  ENDIF

  IF (fifrIP)
    RequestFifo(fifoR, rMsg, FREQ_ABORT)
    waitMsg(rMsg)
  ENDIF

  IF (fifoR) THEN CloseFifo(fifoR, FIFOF_EOF)

  /*  no FIFOF_EOF on IDCMP_CLOSEWINDOW to conform to documentation */
  IF (fifoW) THEN   CloseFifo(fifoW, FIFOF_EOF)

  IF (fifobase) THEN CloseLibrary(fifobase)

  IF (ioSink) THEN deletePort(ioSink)
EXCEPT
  IF (fifoR) THEN CloseFifo(fifoR, FIFOF_EOF)

  /*  no FIFOF_EOF on IDCMP_CLOSEWINDOW to conform to documentation */
  IF (fifoW) THEN   CloseFifo(fifoW, FIFOF_EOF)

  IF (fifobase) THEN CloseLibrary(fifobase)

  IF (ioSink) THEN deletePort(ioSink)
  RETURN RESULT_FAILURE
ENDPROC RESULT_SUCCESS

PROC waitMsg(msg:PTR TO mn)
  WHILE(msg.ln.type = NT_MESSAGE)
    Wait(Shl(1,msg.replyport.sigbit))
  ENDWHILE
  Forbid()
  Remove(msg)
  Permit()
ENDPROC

PROC sendBreak(c)
  DEF buf[256]:STRING
  DEF fh

  StringF(buf, 'FIFO:bbsshell\d/\c', node, c)
  IF ((fh:=Open(buf, 1005))) THEN Close(fh)
ENDPROC

PROC doorLog(type, str:PTR TO CHAR)
  DEF gfp1
  DEF logname[255]:STRING
  DEF str1[255]:STRING
  DEF string[255]:STRING
  DEF name[255]:STRING

  IF(sopt.toggles[TOGGLES_DOORLOG])=FALSE THEN RETURN

  StringF(logname,'\sNode\d/DoorLog',cmds.bbsLoc,node)

  gfp1:=Open(logname,MODE_READWRITE)
  IF gfp1<>0
    Seek(gfp1,0,OFFSET_END)

    IF loggedOnUser<>NIL THEN StrCopy(name,loggedOnUser.name) ELSE StrCopy(name,'')

    formatLongDateTime(getSystemTime(),str1)
    IF StrLen(str)>0
      StringF(string,'[\s[25]] \s - \d - \s',str1,name,type,str)
    ELSE
      StringF(string,'[\s[25]] \s - \d - Exiting',str1,name,type)
    ENDIF

    fileWriteLn(gfp1,string)
    Close(gfp1)
  ENDIF
ENDPROC

PROC startLog(stringout:PTR TO CHAR)
  DEF gfp1
  DEF logname[255]:STRING

  IF(sopt.toggles[TOGGLES_STARTLOG])=FALSE THEN RETURN

  StringF(logname,'\sNode\d/StartUpLog',cmds.bbsLoc,node)

  gfp1:=Open(logname,MODE_READWRITE)
  IF gfp1<>0
    Seek(gfp1,0,OFFSET_END)
    fileWriteLn(gfp1,stringout)
    Close(gfp1)
  ENDIF
ENDPROC

PROC creditLog(logline: PTR TO CHAR)
  DEF fn[255]:STRING
  DEF fh

  StringF(fn,'\sCreditLog',cmds.bbsLoc)
  fh:=Open(fn,MODE_OLDFILE)
  IF(fh=0)
    fh:=Open(fn,MODE_NEWFILE)
  ELSE
    Close(fh)
    fh:=Open(fn,MODE_READWRITE)
    Seek(fh,0,OFFSET_END)
  ENDIF

  IF(fh)
    fileWriteLn(fh,logline)
    Close(fh)
  ENDIF
ENDPROC

PROC logoffLog(stat: PTR TO CHAR)
  DEF tempstr[255]:STRING
  DEF datestr[10]:STRING
  DEF timestr[10]:STRING
  DEF calltime

  calltime:=getSystemTime()
  formatLongDate(calltime,datestr)
  formatLongTime(calltime,timestr)

  IF stat[0]="N"
    StringF(tempstr,'\s (\s) \s Off Normally',datestr,timestr,loggedOnUser.name)
  ELSE
    StringF(tempstr,'\s (\s) \s Off \s',datestr,timestr,loggedOnUser.name,stat)
  ENDIF
  callersLog(tempstr)
ENDPROC

PROC logUDFile(dl)
  DEF tempStr[255]:STRING
  IF dl
    StringF(tempStr,'\t\sDownloading \s \d bytes',IF zModemInfo.freeDFlag THEN 'Free ' ELSE '',zModemInfo.fileName,zModemInfo.filesize)
  ELSE
    IF zModemInfo.resumePos<>0
      StringF(tempStr,'\tResuming \s[12] \d bytes from \d',FilePart(zModemInfo.fileName),zModemInfo.filesize,zModemInfo.resumePos)
    ELSE
      IF zModemInfo.filesize<>$7fffffff
        StringF(tempStr,'\tUploading \s[12] \d bytes',FilePart(zModemInfo.fileName),zModemInfo.filesize)
      ENDIF
    ENDIF
  ENDIF
  callersLog(tempStr)
  udLog(tempStr)

ENDPROC

PROC callersLog(stringout: PTR TO CHAR,linefeed=TRUE)
  DEF buff[100]:STRING
  DEF gfp1

  IF cmds.acLvl[LVL_DO_CALLERSLOG]=FALSE THEN RETURN

  StringF(buff,'\sNode\d/CallersLog',cmds.bbsLoc,node)

  gfp1:=Open(buff,MODE_OLDFILE)
  IF(gfp1=0)
    gfp1:=Open(buff,MODE_NEWFILE)
  ELSE
    Close(gfp1)
    gfp1:=Open(buff,MODE_READWRITE)
    Seek(gfp1,0,OFFSET_END)
  ENDIF

  IF(gfp1)
    IF linefeed
      fileWriteLn(gfp1,stringout)
    ELSE
      fileWrite(gfp1,stringout)
    ENDIF
    Close(gfp1)
  ENDIF
ENDPROC

PROC udLog(stringout: PTR TO CHAR)
  DEF gfp1
  DEF lstr[300]:STRING

  IF(cmds.acLvl[LVL_DO_UD_LOG]=FALSE) THEN RETURN

  StringF(lstr,'\sNode\d/UDLog',cmds.bbsLoc,node)
  gfp1:=Open(lstr,MODE_OLDFILE)
  IF(gfp1=0)
    gfp1:=Open(lstr,MODE_NEWFILE)
  ELSE
    Close(gfp1)
    gfp1:=Open(lstr,MODE_READWRITE)
    Seek(gfp1,0,OFFSET_END)
  ENDIF

  IF(gfp1)
    fileWriteLn(gfp1,stringout)
    Close(gfp1)
  ENDIF
ENDPROC

PROC udLogDivider()
  udLog('**************************************************************')
ENDPROC

PROC callerIDLog(opt)
  DEF fi
  DEF tempstr[255]:STRING

  IF(((sopt.toggles[TOGGLES_CALLERID]) OR (sopt.toggles[TOGGLES_CALLERIDNAME])) AND opt)
    StringF(tempstr,'\sNode\d/CallerIDlog',cmds.bbsLoc,node)
    fi:=Open(tempstr,MODE_READWRITE)
    Seek(fi,0,OFFSET_END)
    fileWrite(fi,'**************************************************************\n');

    IF(sopt.toggles[TOGGLES_CALLERIDNAME])
       StringF(tempstr,'\t(\s - \s [\s[16] / \s]) \n',idDate,idTime,idNmbr,idName)
    ELSE
       StringF(tempstr,'\t(\s - \s [\s[16]])\n',idDate,idTime,idNmbr)
    ENDIF
    fileWrite(fi,tempstr)
    Close(fi)
    RETURN
  ENDIF
  IF(sopt.toggles[TOGGLES_CALLERID] OR sopt.toggles[TOGGLES_CALLERIDNAME])
    StringF(tempstr,'\sNode\d/CallerIDlog',cmds.bbsLoc,node)
    fi:=Open(tempstr,MODE_READWRITE)
    Seek(fi,0,OFFSET_END)
    StringF(tempstr,'\t\s\n',loggedOnUser.name)
    fileWrite(fi,tempstr)
    Close(fi)
  ENDIF
ENDPROC

PROC callersLogDivider()
  callersLog('**************************************************************')
ENDPROC

PROC restricted(str: PTR TO CHAR)
  DEF fLock
  DEF image[200]:STRING
  DEF bad=TRUE
  DEF fBlock: fileinfoblock

  IF(fLock:=Lock(str,ACCESS_READ))<>0
    IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))= NIL
      aePuts('\b\nCan''t allocate memory to lock file!!\b\n')
      bad:=TRUE
    ELSE
      IF((Examine(fLock,fBlock))=0)
        aePuts('\b\nCan''t get informations from file.\b\n')
        bad:=TRUE
      ELSE
        IF(StriCmp(fBlock.comment,'Restricted',10))
          aePuts('\b\n ')
          aePuts(str)
          aePuts('\b\n >>Restricted File<< Updating CallersLog\b\n')
          StringF(image,'\tAttempt to examine RESTRICTED file \s[100]',str)
          callersLog(image)
          bad:=TRUE
        ELSE
          bad:=FALSE->//!AllowedView(FBlock->fib_Comment)
        ENDIF
      ENDIF
      FreeDosObject(DOS_FIB,fBlock)
    ENDIF
    UnLock(fLock)
  ENDIF
ENDPROC bad

PROC deleteMsgFiles(num:LONG,attachType)
  DEF image[100]:STRING
  DEF fBlock:PTR TO fileinfoblock
  DEF fLock
  DEF str[100]:STRING
  DEF f

  StringF(str,'\sF\d',msgBaseLocation,num)
  IF attachType=2
    IF(fBlock:=AllocDosObject(DOS_FIB,NIL))
      IF(fLock:=Lock(str,ACCESS_READ))

        IF(Examine(fLock,fBlock))
          WHILE(ExNext(fLock,fBlock))
            StringF(image,'\sF\d/\s',msgBaseLocation,num,fBlock.filename)
            SetProtection(image,FIBF_OTR_DELETE)
            DeleteFile(image)
          ENDWHILE
          aePuts('\b\n')
        ENDIF
        UnLock(fLock)
      ENDIF
      FreeDosObject(DOS_FIB,fBlock)
      SetProtection(str,FIBF_OTR_DELETE)
      DeleteFile(str)
    ENDIF
  ENDIF
  
  IF attachType=3
    StringF(image,'\sA\d',msgBaseLocation,num)
    f:=Open(image,MODE_OLDFILE)
    IF f<>0
      ReadStr(f,str)
      IF StrCmp(str,'Y')
        aePuts('\b\nDeleted attached file(s):\b\n')
        WHILE(ReadStr(f,str)<>-1) OR (StrLen(str)>0)
          SetProtection(str,FIBF_OTR_DELETE)
          DeleteFile(str)
          aePuts(str)
          aePuts('\b\n')
        ENDWHILE
      ENDIF
      Close(f)
      SetProtection(image,FIBF_OTR_DELETE)
      DeleteFile(image)
    ENDIF
  ENDIF
ENDPROC

PROC attachMsgFiles(num: LONG,s:PTR TO CHAR,attachType: LONG)
  DEF image[100]:STRING
  DEF str[100]:STRING
  DEF fBlock: PTR TO fileinfoblock
  DEF fLock
  DEF cnt=0
  DEF f

  StrCopy(s,'')
  StringF(str,'\sF\d',msgBaseLocation,num)
  IF attachType=2
    IF(fBlock:=AllocDosObject(DOS_FIB,NIL))
      IF(fLock:=Lock(str,ACCESS_READ))
        IF(Examine(fLock,fBlock))
          WHILE(ExNext(fLock,fBlock))
            StringF(image,'\sF\d/\s ',msgBaseLocation,num,fBlock.filename)
            IF((StrLen(image)+StrLen(s))<1024)
              aePuts('\b\nFlagging >:')
              aePuts(fBlock.filename)
              cnt++
              StrAdd(s,image)
            ENDIF
          ENDWHILE
          aePuts('\b\n')
        ENDIF
        UnLock(fLock)
      ENDIF
      FreeDosObject(DOS_FIB,fBlock)
    ENDIF
  ENDIF
  
  IF attachType=3
    StringF(image,'\sA\d',msgBaseLocation,num)
    f:=Open(image,MODE_OLDFILE)
    IF f<>0
      ReadStr(f,str)    ->skip delete flag
      WHILE(ReadStr(f,str)<>-1) OR (StrLen(str)>0)
        IF((StrLen(str)+StrLen(s)+1)<1024)
          cnt++
          StrAdd(s,image)
        ENDIF
      ENDWHILE
      Close(f)
    ENDIF
  ENDIF
  
  IF cnt=0
    aePuts('File attachment not found\b\n')
  ENDIF
ENDPROC


PROC checkAttachedFile(msgnumb,flag)
  DEF stat
  DEF str[250]:STRING
  DEF fBlock:PTR TO fileinfoblock
  DEF fLock
  DEF filetype=0
  DEF tempStr[1024]:STRING

  StrCopy(tempStr,'')

  convertToBCD(0,dTBT)
  convertToBCD(0,uTBT)
  ulTTTM:=NIL
  ulTTTM:=0
  tTEFF:=NIL
  tTCPS:=NIL

  StringF(str,'\s\d',msgBaseLocation,msgnumb)

  IF(fBlock:=AllocDosObject(DOS_FIB,NIL))
    IF(fLock:=Lock(str,ACCESS_READ))
      IF(Examine(fLock,fBlock))
        IF(StrLen(fBlock.comment)>0)
          StrCopy(tempStr,fBlock.comment)
          filetype:=1     ->single attached file referenced in file comment
        ENDIF

      ENDIF
      UnLock(fLock)
      IF(filetype=0)
        StringF(str,'\sF\d',msgBaseLocation,msgnumb)
        IF(fLock:=Lock(str,ACCESS_READ))
          IF(Examine(fLock,fBlock))
            IF(ExNext(fLock,fBlock))
              filetype:=2 ->sub folder containing attached files
            ENDIF
          ENDIF
          UnLock(fLock)
        ENDIF
      ENDIF
    ENDIF
    FreeDosObject(DOS_FIB,fBlock)
  ENDIF
  StringF(str,'\sA\d',msgBaseLocation,msgnumb)
  IF fileExists(str) THEN filetype:=3   ->corresponding A<msgnum> file containing attachment file details

  IF(filetype)
    IF(flag)
      aePuts('...This message has an attached file(s), Download? (y/N/goodbye)? ')
      stat:=readChar(INPUT_TIMEOUT)
      IF(stat<0) THEN RETURN stat

      IF((stat="n") OR (stat="N")) THEN aePuts('No\b\n')
      IF((stat="y") OR (stat="Y"))
        aePuts('Yes\b\n\b\n')
        IF(filetype<>1) THEN attachMsgFiles(msgnumb,tempStr,filetype)
        downloadFile(tempStr)
      ENDIF
      IF((stat="g") OR (stat="G"))
        aePuts('Goodbye\b\n\b\n')
        IF(filetype<>1) THEN attachMsgFiles(msgnumb,tempStr,filetype)
        downloadFile(tempStr)
        aePuts('\b\n')
        stat:=pGoodbye()
        IF(stat=RESULT_GOODBYE) THEN modemOffHook()
        RETURN stat
      ENDIF
      stat:=0
      aePuts('\b\n')
    ELSE
      IF(filetype=1)
        stat:=isupper(tempStr[0])
        IF(stat)
          SetProtection(tempStr,FIBF_OTR_DELETE)
          DeleteFile(tempStr)
          aePuts('\b\nDeleted attached file(s) ')
          aePuts(tempStr)
        ENDIF
      ELSE
        deleteMsgFiles(msgnumb,filetype)
      ENDIF
    ENDIF
  ENDIF
ENDPROC RESULT_SUCCESS

PROC forwardMSG(gfh)
  DEF stat,aFlag
  DEF frm[255]:STRING
  DEF tempStr[255]:STRING
  DEF mh: mailHeader

  delMsgNum:=mailHeader.msgNumb
  StrCopy(frm,mailHeader.toName)

  msgToHeader()
  stat:=lineInput('','',30,INPUT_TIMEOUT,tempStr)
  IF (stat<0) THEN RETURN stat
  aFlag:=getAValidName(tempStr,'ALL',mh.toName)

  IF(StrLen(mh.toName)=0) THEN RETURN 2

  checkToForward(tempStr,mh.toName,1)

  aePuts('[36mSubject[33m: [32m([33mBlank[32m)[0m=[33mabort[32m?[0m ')
  stat:=lineInput('',mailHeader.subject,30,INPUT_TIMEOUT,tempStr)
  AstrCopy(mh.subject,tempStr,31)
  IF(stat<0)
    RETURN stat
  ENDIF

  IF(StrLen(mh.subject)=0)
    aePuts('\b\n')
    RETURN RESULT_SUCCESS
  ENDIF

  aePuts('         [36mPrivate ')
  stat:=yesNo(2)
  IF(stat<0)
    RETURN stat
  ENDIF

  IF (stat)
    mh.status:="R"
  ELSE
    IF checkSecurity(ACS_CENSORED) OR (mailHeader.status="p")
      mh.status:="p"
    ELSE
      mh.status:="P"
    ENDIF
  ENDIF

  IF checkSecurity(ACS_DELETE_MESSAGE)
    IF(stringCompare(frm,confMailName)=RESULT_SUCCESS)
      aePuts('Delete original message ')
      stat:=yesNo(2)
      IF(stat<0) THEN RETURN stat
      IF(stat) THEN deleteMSG(gfh)
    ENDIF
  ENDIF

  aePuts('\b\nSaving...')

  StringF(tempStr,'\s\d',msgBaseLocation,mailHeader.msgNumb)
  IF loadMsg(tempStr)
    stat:=saveNewMSG(gfh,mh)
    IF(stat<0)
      RETURN stat
    ENDIF
  ENDIF
ENDPROC RESULT_SUCCESS


PROC replyToMSG(gfh)
  DEF str[255]:STRING
  DEF frm[255]:STRING
  DEF stat

  delMsgNum:=mailHeader.msgNumb
  StrCopy(frm,mailHeader.toName)
  aePuts('                       [32m([33m------------------------------[32m)[0m\b\n')
  AstrCopy(mailHeader.toName,mailHeader.fromName,31)
  StringF(str,'     [36mTo[33m: [32m([33mEnter[32m)[0m=[32m''[33mALL[32m''[32m?[0m \s\b\n',mailHeader.toName)
  aePuts(str)
  checkToForward(str,mailHeader.toName,1)
  aePuts('[36mSubject[33m: [32m([33mBlank[32m)[0m=[33mabort[32m?[0m ')
  stat:=lineInput('',mailHeader.subject,30,INPUT_TIMEOUT,str)
  IF(stat<0) THEN RETURN stat
  AstrCopy(mailHeader.subject,str,31)
  IF(StrLen(mailHeader.subject)=0) THEN RETURN RESULT_SUCCESS

  mailHeader.recv:=0

  replyFlag:=1
  stat:=enterMSG(gfh)
  IF(stat<0) THEN RETURN stat

  IF checkSecurity(ACS_DELETE_MESSAGE)
    IF(stringCompare(frm,confMailName)=RESULT_SUCCESS)
      aePuts('Delete original message ')
      stat:=yesNo(2)
      IF(stat<0) THEN RETURN stat
      IF(stat) THEN deleteMSG(gfh)
    ENDIF
  ENDIF

ENDPROC RESULT_SUCCESS

PROC checkToForward(str,name,check)
  DEF error
  DEF tempStr[255]:STRING

  error:=0

  IF readToolType(TOOLTYPE_CONF,currentConf,'FORWARDMAIL',str)
    IF(str[StrLen(str)-1]="\n") THEN SetStr(str,StrLen(str)-1)
    IF(check)
      loadAccount(1,tempUser,tempUserKeys,tempUserMisc)
      IF(stringCompare(name,tempUser.name)=RESULT_SUCCESS)
        IF(findUserFromName(1,confNameType,str,tempUser,tempUserKeys,tempUserMisc))
          SELECT confNameType
             CASE NAME_TYPE_USERNAME
              StringF(tempStr,'    [36mForwarding mail To[33m:[0m \s\b\n',tempUserKeys.userName)
            CASE NAME_TYPE_REALNAME
              StringF(tempStr,'    [36mForwarding mail To[33m:[0m \s\b\n',tempUserMisc.realName)
            CASE NAME_TYPE_INTERNETNAME
              StringF(tempStr,'    [36mForwarding mail To[33m:[0m \s\b\n',tempUserMisc.internetName)
          ENDSELECT
          aePuts(tempStr)
          AstrCopy(name,tempUserKeys.userName,31)
          error:=1
        ENDIF
      ENDIF
    ELSE
      IF(findUserFromName(1,confNameType,str,tempUser,tempUserKeys,tempUserMisc))
        SELECT confNameType
          CASE NAME_TYPE_USERNAME
            StringF(tempStr,'    [36mForwarding mail To[33m:[0m \s\b\n',tempUserKeys.userName)
          CASE NAME_TYPE_REALNAME
            StringF(tempStr,'    [36mForwarding mail To[33m:[0m \s\b\n',tempUserMisc.realName)
          CASE NAME_TYPE_INTERNETNAME
            StringF(tempStr,'    [36mForwarding mail To[33m:[0m \s\b\n',tempUserMisc.internetName)
        ENDSELECT
        aePuts(tempStr)
        AstrCopy(name,tempUserKeys.userName,31)
        error:=1
      ENDIF
    ENDIF
  ENDIF
ENDPROC error

PROC saveMsg(s)
  DEF f,i=0

  IF(lines)
    IF (f:=Open(s,MODE_NEWFILE))<>0
      WHILE lines
        fileWriteLn(f,msgBuf.item(i))
        lines--
        i++
      ENDWHILE
      Close(f)
      msgBuf.clear()
      RETURN 1
    ENDIF
  ENDIF
ENDPROC RESULT_SUCCESS

PROC loadMsg(s)
  DEF f, temp
  DEF loadStr[255]:STRING

  lines:=0
  msgBuf.clear()
  StrCopy(loadStr,s)
  IF(f:=Open(loadStr,MODE_OLDFILE))<>0

    WHILE(ReadStr(f,loadStr)<>-1)
      removeCR(loadStr)
      msgBuf.add(loadStr)
      lines++
    ENDWHILE

    Close(f)

    temp:=lines-1
    WHILE(temp>0)
      EXIT (StrLen(msgBuf.item(temp))<>0)
      msgBuf.remove(temp)
      temp--
    ENDWHILE
    lines:=temp+1
    RETURN 1
  ENDIF

ENDPROC FALSE

PROC msgToHeader()
  aePuts('\b\n                       [32m([33m------------------------------[32m)[0m\b\n')
  aePuts('     [36mTo[33m: [32m([33mEnter[32m)[0m=[32m''[33mALL[32m''[32m?[0m ')
ENDPROC

PROC editEmacs(filename: PTR TO CHAR)
  DEF tempStr[255]:STRING
  StringF(tempStr,'\tEditor \s',filename)
  callersLog(tempStr)

  runSysCommand('EDITOR',filename)
ENDPROC

PROC editEMessage(number)
  DEF tempStr[255]:STRING

  StringF(tempStr,'\s\d',msgBaseLocation,number)
  editEmacs(tempStr)
ENDPROC

PROC editDirFile(params)
  DEF stat,which
  DEF tempStr[255]:STRING

  IF(maxDirs=0)
    aePuts('\b\n')
    myError(5)
    RETURN
  ENDIF

  parseParams(params)
  REPEAT
    IF StrLen(tempStr)=0
      StringF(tempStr,'\b\nDirectory to Edit[1-\d]? ',maxDirs)
      aePuts(tempStr)
      stat:=lineInput('','',5,INPUT_TIMEOUT,tempStr)
      IF((stat<0) OR (StrLen(tempStr)=0))
        aePuts('\b\n')
        RETURN
      ENDIF
    ENDIF
    which:=Val(tempStr)
    StrCopy(tempStr,'')
    IF((which<1) OR (which>maxDirs)) THEN aePuts('\b\nNo such directory!\b\n')
  UNTIL (which>=1) AND (which<=maxDirs)

  StringF(tempStr,'\sDir\d',currentConfDir,which)
  editEmacs(tempStr)
  aePuts('\b\n')

ENDPROC

PROC editAnyFile(params)
  DEF stat
  DEF tempStr[255]:STRING

  setEnvStat(ENV_SYSOP)

  parseParams(params)
  IF(parsedParams.count()>0)
    StrCopy(tempStr,parsedParams.item(0))
  ELSE
    aePuts('\b\nFullPath/Filename to Editor? ')
    stat:=lineInput('','',250,INPUT_TIMEOUT,tempStr)
    IF((stat<0) OR (StrLen(tempStr)=0))
      aePuts('\b\n')
      RETURN
    ENDIF
  ENDIF
  IF(findAssign(tempStr))
    aePuts('\b\nDevice not Mounted.\b\n')
    aePuts('\b\n')
    RETURN
  ENDIF
 editEmacs(tempStr)
 aePuts('\b\n')
ENDPROC


PROC edit(allowFullscreen=TRUE,maxLineLen=75,updatePosted=FALSE)
  DEF c
  DEF cn,i,j,x,back,bkFlag,helplist=0
  DEF str[200]:STRING
  DEF space[90]:STRING
  DEF str2[10]:STRING
  DEF temp[170]:STRING
  DEF stat,brkflag
  DEF tempstr[255]:STRING
  DEF attachedFile[255]:STRING

  /* Clear msg buffer */
  rzmsg:=NIL
  StrCopy(str,'')
  x:=0
  bkFlag:=0

  StringF(str,'\sCommands/SysCmd/FULLEDIT',cmds.bbsLoc)
  IF(configFileExists(str) AND checkSecurity(ACS_FULL_EDIT) AND (loggedOnUser.editorType<>1))
    stat:=0
    IF allowFullscreen
      IF(loggedOnUser.editorType<>2)
        aePuts('[36mFullScreen Editor[0m')
        stat:=yesNo(2)
      ELSE
        stat:=1
      ENDIF
    ENDIF

    IF(stat>0)
      editor.editorIncludeFile:=0
      StringF(editorFileInclude,'\sNode\d/Work/msg.i',cmds.bbsLoc,node)
      IF(saveMsg(editorFileInclude)) THEN editor.editorIncludeFile:=editorFileInclude
      StringF(str,'\sCommands/SysCmd/',cmds.bbsLoc)
      StringF(editorFileName,'\sNode\d/Work/msg',cmds.bbsLoc,node)
      editor.editorFile:=editorFileName
      editor.editorPrependFile:=0
      editor.editorPostPendFile:=0
      editor.editorFlags:=0
      editor.editorFlags:=editor.editorFlags OR ED_ABORT_ALLOWED
      editor.editorMaxWidth:=76
      editor.editorFlags:=editor.editorFlags OR ED_ANSI_ALLOWED
      editor.editorTop:=1
      editor.maxScrLength:=userLineLen
      editor.maxFileLength:=100
      IF((checkSecurity(ACS_PRI_MSGFILES) OR checkSecurity(ACS_PUB_MSGFILES)) AND fileattach) THEN editor.editorFlags:=editor.editorFlags OR ED_BATCH_UPLOAD
      IF(checkSecurity(ACS_ATTACH_FILES) AND fileattach) THEN editor.editorFlags:=editor.editorFlags OR ED_ATTACH_FILE

      IF(runSysCommand('FULLEDIT','',1)=RESULT_SUCCESS)
        IF(loadMsg(editorFileName))
          IF updatePosted THEN loggedOnUser.messagesPosted:=loggedOnUser.messagesPosted+1

          SetProtection(editorFileName,FIBF_OTR_DELETE)
          DeleteFile(editorFileName)
          SetProtection(editorFileInclude,FIBF_OTR_DELETE)
          DeleteFile(editorFileInclude)
          IF(editor.editorFlags AND ED_BATCH_REQUESTED) THEN rzmsg:=1
          editor.editorFlags:=editor.editorFlags AND Not(ED_BATCH_UPLOAD OR ED_ATTACH_FILE OR ED_BATCH_REQUESTED OR ED_ATTACH_REQUESTED)
          RETURN RESULT_SUCCESS
        ENDIF
        editor.editorFlags:=editor.editorFlags AND Not(ED_BATCH_UPLOAD OR ED_ATTACH_FILE OR ED_BATCH_REQUESTED OR ED_ATTACH_REQUESTED)

        SetProtection(editorFileInclude,FIBF_OTR_DELETE)
        DeleteFile(editorFileInclude)
        RETURN -1
      ENDIF
      editor.editorFlags:=editor.editorFlags AND Not(ED_BATCH_UPLOAD OR ED_ATTACH_FILE OR ED_BATCH_REQUESTED OR ED_ATTACH_REQUESTED)
    ENDIF
  ENDIF

  aePuts('\b\n')
  StringF(tempstr,'   Enter your text. (Enter) alone to end. (\d chars/line)\b\n',maxLineLen)
  aePuts(tempstr)
  StrCopy(str,'|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|')
  SetStr(str,maxLineLen)
  StringF(tempstr,'   (\s)\b\n',str)
  aePuts(tempstr)
  IF(lines<>0)
    FOR j:=0 TO lines-1
      IF j<=98
        StringF(space,'\d[2]> \s\b\n',j+1,msgBuf.item(j))
      ELSE
        StringF(space,'\d[3]> \s\b\n',j+1,msgBuf.item(j))
      ENDIF
      aePuts(space)
    ENDFOR
  ENDIF
  StrCopy(space,'')

  rawArrow:=TRUE

  REPEAT
bEG_IN:
    msgBuf.setItem(lines,space)
    IF lines<=98
      StringF(str,'\d[2]> \s',lines+1,msgBuf.item(lines))
    ELSE
      StringF(str,'\d[3]> \s',lines+1,msgBuf.item(lines))
    ENDIF
    aePuts(str)

    LOOP
next2:

      c:=readChar(INPUT_TIMEOUT)
      IF(c<0) THEN RETURN c
      IF(c=13)
        IF(StrLen(space)=0)
          msgBuf.setItem(lines,'')
          bkFlag:=1
          JUMP brk
        ENDIF
        msgBuf.setItem(lines,space)
        StrCopy(space,'')
        aePuts('\b\n')
        x:=0
        JUMP brk
      ENDIF
      IF(c=30)
        StrCopy(tempstr,'')
        WHILE(x)
          StrAddChar(tempstr,8)
          StrAdd(tempstr,' ')
          StrAddChar(tempstr,8)
          x--
        ENDWHILE
        aePuts(tempstr)
        StrCopy(space,'')
        JUMP next2
      ENDIF
      IF(c=CHAR_BACKSPACE)
        StrCopy(tempstr,'')
        IF x>0
          StrAddChar(tempstr,c)
          x--
          FOR i:=x TO StrLen(space)-2
            space[i]:=space[i+1]
            StrAddChar(tempstr,space[i+1])
          ENDFOR
          StrAdd(tempstr,' ')
          FOR i:=x TO StrLen(space)-1
            StrAdd(tempstr,'[1D')
          ENDFOR

          SetStr(space,EstrLen(space)-1)
          aePuts(tempstr)
        ENDIF
        JUMP next2
      ENDIF
      IF (c=CHAR_DELETE)
        StrCopy(tempstr,'')
        IF x<(StrLen(space))
          FOR i:=x TO StrLen(space)-2
            space[i]:=space[i+1]
            StrAddChar(tempstr,space[i+1])
          ENDFOR
          StrAdd(tempstr,' ')
          FOR i:=x TO StrLen(space)-1
            StrAdd(tempstr,'[1D')
          ENDFOR
          SetStr(space,EstrLen(space)-1)
          aePuts(tempstr)
        ENDIF
        JUMP next2
      ENDIF
      IF(c=CHAR_TAB)
        c:=Mod(x,8)
        IF x=(StrLen(space))
          IF(x+(8-c)>maxLineLen-3)
            c:=CHAR_TAB
          ELSE
            WHILE c<8
              StrCopy(str2,' ')
              aePuts(' ')
              StrAdd(space,str2)
              x++
              c++
            ENDWHILE
          ENDIF
        ELSE
          IF(StrLen(space)+(7-c)<maxLineLen)
            FOR i:=c TO 7
              StrCopy(tempstr,'')
              StrAdd(space,'#')
            ENDFOR
            FOR i:=StrLen(space)-1 TO x+(7-c) STEP -1
              space[i]:=space[i-(8-c)]
            ENDFOR

            FOR i:=c TO 7
              space[x]:=" "
              sendChar(" ")
              x++
            ENDFOR

            FOR i:=x TO StrLen(space)-1
              StrAddChar(tempstr,space[i])
            ENDFOR
            FOR i:=x TO StrLen(space)-1
              StrAdd(tempstr,'[1D')
            ENDFOR
            aePuts(tempstr)
          ELSE
            c:=CHAR_TAB
          ENDIF
        ENDIF
      ENDIF
      IF ((c=LEFTARROW) AND (x>0))
        x--
        aePuts('[1D')
      ENDIF
      IF ((c=RIGHTARROW) AND (x<(StrLen(space))))
        x++
        aePuts('[1C')
      ENDIF

      IF(c<" ") THEN JUMP next2

      IF (x<StrLen(space))
        IF StrLen(space)<maxLineLen
          StrCopy(tempstr,'')
          StrAdd(space,'#')
          FOR i:=StrLen(space)-1 TO x+1 STEP -1
            space[i]:=space[i-1]
          ENDFOR
          space[x]:=c
          sendChar(c)
          x++
          FOR i:=x TO StrLen(space)-1
            StrAddChar(tempstr,space[i])
          ENDFOR
          FOR i:=x TO StrLen(space)-1
            StrAdd(tempstr,'[1D')
          ENDFOR
          aePuts(tempstr)
        ENDIF
      ELSE
        x++
        sendChar(c)
        StrCopy(str2,' ')
        str2[0]:=c
        StrAdd(space,str2)
      ENDIF

      IF(x>maxLineLen)
        back:=0
        brkflag:=FALSE
        FOR cn:=x TO 1 STEP -1
          IF(space[cn-1]=" ")
            back:=x-cn
            SetStr(space,cn-1)
            brkflag:=TRUE
          ENDIF
          EXIT brkflag
        ENDFOR
        IF(back=0)
          msgBuf.setItem(lines,space)
          aePuts('\b\n')
          StrCopy(space,'')
          x:=0
          JUMP brk
        ENDIF
        StrCopy(str,'')
        FOR cn:=x-back TO x-1
          StrCopy(str2,' ')
          str2[0]:=space[cn]
          StrAdd(str,str2)
        ENDFOR
        x:=StrLen(str)
        msgBuf.setItem(lines,space)
        StrCopy(space,str)
        StrCopy(tempstr,'')
        FOR cn:=0 TO x
          StrAddChar(tempstr,8)
          StrAdd(tempstr,' ')
          StrAddChar(tempstr,8)
        ENDFOR
        aePuts(tempstr)
        aePuts('\b\n')
        JUMP brk
      ENDIF
    ENDLOOP
brk:
    lines++
    ->IF((lines=(msgBuf.maxSize()-2)) AND (bkFlag=0)) THEN aePuts('\b\nWarning two lines remaining.\b\n\b\n')   ->no limit on list size now

  UNTIL (bkFlag<>0) ->OR (lines>=ListMax(msgBuf))  max limit removed

  lines--
  msgBuf.setSize(lines)

  rawArrow:=FALSE

  aePuts('\b\n')

  REPEAT
cont2:
    IF(helplist=0)
      aePuts('\b\n[32mMsg. Options: [33mA[36m,[33mC[36m,[33mD[36m,[33mE')
      IF(checkSecurity(ACS_ATTACH_FILES) AND fileattach) THEN aePuts('[36m,[33mF')
      aePuts('[36m,[33mL[36m,[33mS')
      IF(fileattach AND (((mailHeader.status="P") AND checkSecurity(ACS_PUB_MSGFILES)) OR (checkSecurity(ACS_PRI_MSGFILES) AND (mailHeader.status<>"P")))) THEN aePuts('[36m,[33mX')
      aePuts('[36m,[33m? [0m>:')
    ELSE
      aePuts('\b\n[33mA[32m>[36mbort[0m')
      aePuts('\b\n[33mC[32m>[36montinue[0m')
      aePuts('\b\n[33mD[32m>[36melete Lines[0m')
      aePuts('\b\n[33mE[32m>[36mdit[0m')
      IF (fileattach AND checkSecurity(ACS_ATTACH_FILES)) THEN aePuts('\b\n[33mF[32m>[36mile Attachment[0m')
      aePuts('\b\n[33mL[32m>[36mist[0m')
      aePuts('\b\n[33mS[32m>[36mave[0m')
      IF(fileattach AND (((mailHeader.status="P") AND checkSecurity(ACS_PUB_MSGFILES)) OR (checkSecurity(ACS_PRI_MSGFILES) AND (mailHeader.status<>"P")))) THEN aePuts('\b\n[33mX[32m>[36mfer Files[0m')
      aePuts('\b\n[0m >: ')
      helplist:=0
    ENDIF
    stat:=lineInput('','',10,INPUT_TIMEOUT,str)

    messageMenuChar:=str[0]
    IF stat<0 THEN RETURN stat


    IF(str[0]="?")
      helplist:=1
      JUMP cont2
    ENDIF
    IF((str[0]="D") OR (str[0]="d"))
      REPEAT
        IF(lines=0)
          aePuts('\b\nNo lines to delete.\b\n')
          stat:=0
          JUMP brk3
        ENDIF
        StringF(str,'\b\n[36mLine number to delete [32m[[33m1[32m..[33m\d[32m][0m? ',lines)
        aePuts(str)
        stat:=lineInput('','',5,INPUT_TIMEOUT,str)
        IF (stat<0) THEN JUMP brk3

        IF(StrLen(str)=0)
          stat:=0
          JUMP brk3
        ENDIF
        stat:=Val(str)

        IF((stat<1) OR (stat>lines))
          StringF(str,'\b\nLine \d does not exist.\b\n',stat)
          aePuts(str)
        ENDIF
      UNTIL (stat>0) AND (stat<=lines)
brk3:

      IF stat<0 THEN RETURN stat

      IF (stat=0) THEN JUMP cont2

      IF stat<=99
        StringF(str,'\b\n\d[2]> \s\b\n',stat,msgBuf.item(stat-1))
      ELSE
        StringF(str,'\b\n\d[3]> \s\b\n',stat,msgBuf.item(stat-1))
      ENDIF

      aePuts(str)
      aePuts('\b\n[36mIs this the correct line [32m([33mY[32m/[33mN[32m)[0m? ')
      cn:=yesNo(0)
      IF cn<0 THEN RETURN stat

      IF(cn)
        msgBuf.remove(stat-1)

        StringF(str,'\b\nDeleted line \d.\b\n',stat)
        lines--
        aePuts(str)
      ENDIF
      JUMP cont2
    ENDIF

    IF((str[0]="C") OR (str[0]="c"))
      aePuts('\b\n')
      lines--
      IF(lines<0) THEN lines:=0
      IF lines<msgBuf.count()
        StrCopy(space,msgBuf.item(lines))
      ELSE
        StrCopy(space,'')
      ENDIF
      msgBuf.setSize(lines)

      bkFlag:=0
      x:=StrLen(space)
      JUMP bEG_IN
    ENDIF
    IF((str[0]="E") OR (str[0]="e"))
      IF(lines<1)
        aePuts('\b\nNo Lines to edit!\b\n')
        JUMP cont2
      ENDIF
loopHere:
      StringF(str,'\b\n[36mLine number to edit [32m[[33m1[32m..[33m\d[32m][0m? ',lines)
      aePuts(str)

      stat:=lineInput('','',5,INPUT_TIMEOUT,str)
      IF (stat<0) THEN RETURN RESULT_TIMEOUT
      IF(StrLen(str)=0) THEN JUMP cont2

      x:=Val(str)
      IF((x<1) OR (x>lines))
        StringF(str,'\b\nLine \d does not exist.\b\n',x)
        aePuts(str)
        JUMP loopHere
      ENDIF
      StrCopy(temp,msgBuf.item(x-1))
      aePuts('\b\n    Edit Line')
      aePuts('\b\n   (---------------------------------------------------------------------------)')
      stat:=lineInput('\b\n    ',temp,maxLineLen,INPUT_TIMEOUT,temp,FALSE)
      IF (stat<0) THEN RETURN stat
      msgBuf.setItem(x-1,temp)
      JUMP cont2
    ENDIF

    IF((str[0]="L") OR (str[0]="l"))
      aePuts('\b\n')
      FOR j:=0 TO lines-1
        IF j<=98
          StringF(space,'\d[2]> \s\b\n',j+1,msgBuf.item(j))
        ELSE
          StringF(space,'\d[3]> \s\b\n',j+1,msgBuf.item(j))
        ENDIF
        aePuts(space)
      ENDFOR
      JUMP cont2
    ENDIF

    IF((str[0]="F") OR (str[0]="f") AND (disallowFileAttach=FALSE))
      messageMenuChar:="F"

      IF(checkSecurity(ACS_ATTACH_FILES) AND fileattach)
        IF(ximPort=CONSOLE_PORT)
          asl(NIL,attachedFiles)
        ELSE
          aePuts('\b\nEnter path/filename to attach (''5 <DIR>''=DIR): ')
          stat:=lineInput('','',250,INPUT_TIMEOUT,attachedFile)
          IF(stat<0) THEN RETURN stat
          IF((attachedFile[0]="5") AND (attachedFile[1]=" "))
            myDirAnyWhere(attachedFile)
            StrCopy(attachedFile,'')
            JUMP cont2
          ENDIF
          attachedFiles.clear()
          attachedFiles.add(attachedFile)
        ENDIF
        FOR i:=attachedFiles.count()-1 TO 0 STEP -1
          StrCopy(attachedFile,attachedFiles.item(i))
          IF(StrLen(attachedFile)>0)
            IF(findAssign(attachedFile))
              aePuts('\b\nDevice not Mounted.\b\n')
              aePuts('\b\n')
              attachedFiles.remove(i)
            ENDIF
            IF(restricted(attachedFile)) THEN attachedFiles.remove(i)
          ENDIF
        ENDFOR
        IF attachedFiles.count()>0
          aePuts('Delete file(s) when message is deleted ')
          stat:=yesNo(2)
          IF(stat<0)
            attachedFiles.clear()
            RETURN stat
          ENDIF
          
          IF(stat)
            attachedFiles.insert(0,'Y')
          ELSE
            attachedFiles.insert(0,'N')
          ENDIF
          JUMP cont2
        ENDIF
      ELSE
        higherAccess()
      ENDIF

    ENDIF
    IF((str[0]="S") OR (str[0]="s"))
      IF updatePosted THEN loggedOnUser.messagesPosted:=loggedOnUser.messagesPosted+1
      RETURN RESULT_SUCCESS
    ENDIF

    IF(fileattach AND ((str[0]="X") OR (str[0]="x")) AND ((checkSecurity(ACS_PRI_MSGFILES) AND (mailHeader.status="R")) OR (checkSecurity(ACS_PUB_MSGFILES) AND (mailHeader.status="P"))))
      rzmsg:=1
      IF updatePosted THEN loggedOnUser.messagesPosted:=loggedOnUser.messagesPosted+1
      RETURN RESULT_SUCCESS
    ENDIF
    IF((str[0]="A") OR(str[0]="a"))
      aePuts('\b\nAbort message entry (y/n)? ')
      stat:=yesNo(0)
      IF(stat<0) THEN RETURN stat
      IF(stat>0) THEN RETURN -1
    ENDIF
  UNTIL stat<0
ENDPROC stat

PROC getMsgId()
  DEF lock, loop, error
  DEF fh,v,r,c
  DEF fname[255]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING

  loop:=0
  StringF(fname,'\smsgidnr.lck',cmds.bbsLoc)
  REPEAT
    lock:=Lock(fname,ACCESS_WRITE)
    IF(lock=0)
      error:=IoErr()
      IF(error=205) THEN createFile(fname)
      Delay(120)
      aePuts('.')
    ENDIF
  UNTIL((lock<>0) OR (loop++>=30))

  IF(lock=0)
    StringF(tempstr,'\tError \d trying to Lock message serial file',IoErr())
    callersLog(tempstr)
    RETURN FALSE,0
  ENDIF
  
  StringF(fname,'\smsgidnr.nxt',cmds.bbsLoc)

  fh:=Open(fname,MODE_OLDFILE)
  IF fh<>0
    ReadStr(fh,tempstr)
    Close(fh)
  ENDIF
  StringF(tempstr2,'$\s',tempstr)
  v,r:=Val(tempstr2)
  c:=getSystemTime()
  IF r<>9 THEN v:=c
  r:=v  
  v++
  IF c>v THEN v:=c

  fh:=Open(fname,MODE_NEWFILE)
  IF fh<>0
    StringF(tempstr,'\z\h[8]\n',v)
    Write(fh,tempstr,StrLen(tempstr))
    Close(fh)
  ENDIF
  
  UnLock(lock)
ENDPROC TRUE,r

PROC saveAttachList(fname:PTR TO CHAR)
  DEF f,i
  IF((f:=Open(fname,MODE_NEWFILE)))=0
    aePuts('Failed!\b\n\b\n')
    RETURN
  ENDIF
  FOR i:=0 TO attachedFiles.count()-1
    fileWriteLn(f,attachedFiles.item(i))
  ENDFOR
  Close(f)       
ENDPROC

PROC saveNewMSG(gfh,mh:PTR TO mailHeader)
  DEF msgbaselock
  DEF f,i,stat,id
  DEF rzmsglock,lock
  DEF string[255]:STRING
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING

  mh.recv:=0
  mh.msgDate:=getSystemTime()
  AstrCopy(mh.fromName,confMailName,31)
   
  IF(msgbaselock:=lockMsgBase())

    StringF(tempStr,'EXTSEND.\d',currentMsgBase)
    IF checkToolTypeExists(TOOLTYPE_MSGBASE,currentConf,tempStr) AND (comment=0)
      getMsgBaseLocation(currentConf,currentMsgBase,tempStr)
      StrAdd(tempStr,'EXT-OUT')
      IF (lock:=CreateDir(tempStr)) THEN UnLock(lock)
      i:=0
      REPEAT
        i++
        StringF(tempStr2,'\s/\d.msg',tempStr,i)
      UNTIL fileExists(tempStr2)=FALSE
      f:=Open(tempStr2,MODE_NEWFILE)
      IF f<>0
        fileWriteLn(f,confMailName)
        fileWriteLn(f,mh.toName)
        fileWriteLn(f,mh.subject)
        formatLongDateTime2(mh.msgDate,tempStr," ")
        fileWriteLn(f,tempStr)
        stat,id:=getMsgId()
        IF stat
          StringF(tempStr,'\d',id)
        ELSE
          StrCopy(tempStr,'')
        ENDIF
        fileWriteLn(f,tempStr)
        
        FOR i:=0 TO lines-1
          StringF(tempStr2,'\s\n',msgBuf.item(i))
          Write(f,tempStr2,StrLen(tempStr2))
        ENDFOR
        Close(f)
      ENDIF
    ENDIF

    getMailStatFile(currentConf,currentMsgBase)
    mh.msgNumb:=mailStat.highMsgNum
    mh.extMsgNum:=-1
    stat:=saveMessageHeader(gfh,mh)
    IF(stat<>RESULT_FAILURE)
      StringF(string,'Message Number \d...',mh.msgNumb)
      aePuts(string)
      StringF(tempStr,'\s\d',msgBaseLocation,mh.msgNumb)
      IF((f:=Open(tempStr,MODE_NEWFILE)))=0
        aePuts('Failed!\b\n\b\n')
        rzmsg:=NIL
        RETURN RESULT_FAILURE
      ENDIF
      FOR i:=0 TO lines-1
        StringF(tempStr2,'\s\n',msgBuf.item(i))
        Write(f,tempStr2,StrLen(tempStr2))
      ENDFOR
      Close(f)
      aePuts('done!\b\n\b\n')

      IF attachedFiles.count()>0
        StringF(tempStr,'\sA\d',msgBaseLocation,mh.msgNumb)
        saveAttachList(tempStr)
        attachedFiles.clear()
      ENDIF
    ELSE
      aePuts('Failed!\b\n\b\n')
    ENDIF
    UnLock(msgbaselock)

    IF (tempUser.slotNumber=1)
      doCommentNotify(mh.fromName,mh.subject)
    ENDIF

    IF(rzmsg)
      StringF(tempStr,'\sF\d',msgBaseLocation,mh.msgNumb)
      IF(rzmsglock:=CreateDir(tempStr))
        UnLock(rzmsglock)
      ENDIF
      setEnvStat(ENV_UPLOADING)
      aePuts('\b\n')
      bgFileCheck:=FALSE
      stat:=uploadaFile(0,'',TRUE)
      rzmsg:=NIL
      StringF(tempStr,'\sF\d',msgBaseLocation,mh.msgNumb)
      SetProtection(tempStr,FIBF_OTR_DELETE)
      DeleteFile(tempStr)
      IF(stat=RESULT_GOODBYE)
        fileattach:=FALSE
        reqState:=REQ_STATE_LOGOFF
        RETURN RESULT_STANDARD_LOGOFF
      ENDIF

      IF(stat=RESULT_NO_CARRIER) THEN RETURN RESULT_NO_CARRIER
      RETURN stat
    ENDIF
  ELSE
     aePuts('ERROR! Another task has the MsgBase locked!\b\nMessage has not been saved!\b\n\b\n')
  ENDIF

ENDPROC

PROC enterMSG(gfh)
  DEF aFlag
  DEF str[255]:STRING
  DEF firstparam
  DEF tempStr[255]:STRING
  DEF exit,i,i2,i3,stat
  DEF extSend
  
  aFlag:=0

  attachedFiles.clear()
  IF(comment=1) THEN JUMP skipAll

  IF(replyFlag=1)
    JUMP skipBegin
  ELSE
    IF(parsedParams.count()>0)
      firstparam:=parsedParams.item(0)
      IF(StrLen(firstparam)<=30)
        AstrCopy(mailHeader.toName,firstparam,31)
        msgToHeader()
        aePuts(mailHeader.toName)
        aePuts('\b\n')
        JUMP skipEntry
      ENDIF
    ENDIF
  ENDIF


  msgToHeader()
  stat:=lineInput('','',30,INPUT_TIMEOUT,tempStr)
  AstrCopy(mailHeader.toName,tempStr,31)
  IF(stat<0)
    RETURN stat
  ENDIF

skipEntry:

  StringF(tempStr,'EXTSEND.\d',currentMsgBase)
  extSend:=checkToolTypeExists(TOOLTYPE_MSGBASE,currentConf,tempStr)

  IF checkSecurity(ACS_CENSORED)
    mailHeader.status:="p"
  ELSE
    mailHeader.status:="P"
  ENDIF

  IF(StrLen(mailHeader.toName)=0)
    aFlag:=1
    AstrCopy(mailHeader.toName,'ALL')
  ELSE
    StrCopy(str,mailHeader.toName,31)
    LowerStr(str)
    stat:=StrCmp(str,'eall',4)            /* looking for eall             */

    IF(stat)
      IF extSend
        aePuts('\b\nCan''t use EALL in external message bases!!\b\n\b\n')
        RETURN RESULT_FAILURE
      ENDIF
      
      IF(checkSecurity(ACS_EALL_MESSAGES))
        aFlag:=2
        AstrCopy(mailHeader.toName,'EALL')
      ELSE
        aePuts('\b\nUser does not exist!!\b\n\b\n')
        RETURN RESULT_FAILURE
      ENDIF
    ELSE
      stat:=StrCmp(str,'sysop',5)
      IF(stat)
        loadAccount(1,tempUser,tempUserKeys,tempUserMisc)
        stat:=0
      ELSE
        stat:=chooseAName(mailHeader.toName,tempUser,tempUserKeys,tempUserMisc,IF extSend THEN 0 ELSE 1)
        IF(stat<0) AND (extSend=FALSE)
          RETURN stat
        ENDIF
      ENDIF
      IF stat>=0
        SELECT confNameType
          CASE NAME_TYPE_USERNAME
            AstrCopy(mailHeader.toName,tempUserKeys.userName,31)
          CASE NAME_TYPE_REALNAME
            AstrCopy(mailHeader.toName,tempUserMisc.realName,26)
          CASE NAME_TYPE_INTERNETNAME
            AstrCopy(mailHeader.toName,tempUserMisc.internetName,10)
        ENDSELECT
        IF(checkConfAccess(currentConf,tempUser)=FALSE)
          aePuts('\b\nUser does not have access to this conference!\b\n\b\n')
          RETURN RESULT_FAILURE
        ENDIF
      ENDIF
    ENDIF
  ENDIF

  checkToForward(str,mailHeader.toName,1)

  aePuts('[36mSubject[33m: [32m([33mBlank[32m)[0m=[33mabort[32m?[0m ')
  stat:=lineInput('','',30,INPUT_TIMEOUT,tempStr)
  AstrCopy(mailHeader.subject,tempStr,31)
  IF(stat<0)
    RETURN stat
  ENDIF

  IF(StrLen(mailHeader.subject)=0)
    aePuts('\b\n')
    RETURN RESULT_FAILURE
  ENDIF

skipBegin:
  IF(aFlag=FALSE) AND (extSend=FALSE)
    aePuts('         [36mPrivate ')
    stat:=yesNo(2)
    IF(stat<0)
      RETURN stat
    ENDIF

    IF (stat)
      mailHeader.status:="R"
    ELSE
      IF checkSecurity(ACS_CENSORED) OR ((mailHeader.status="p") AND (replyFlag=1))
        mailHeader.status:="p"
      ELSE
        mailHeader.status:="P"
      ENDIF
    ENDIF
  ENDIF

  IF(replyFlag=1)
    replyFlag:=0
    aePuts('  [36mQuote in Reply ')
    stat:=yesNo(2)
    IF(stat<0)
      RETURN stat
    ENDIF

    IF(stat)
      StringF(tempStr,'\s\d',msgBaseLocation,mailHeader.msgNumb)
      IF(stat:=loadMsg(tempStr))
        aePuts('\b\n')
        nonStopDisplayFlag:=FALSE
        lineCount:=0
        FOR i:=0 TO lines-1
          IF i<=98
            StringF(str,'\z\l\d[2]> \s\b\n',i+1,msgBuf.item(i))
          ELSE
            StringF(str,'\z\l\d[3]> \s\b\n',i+1,msgBuf.item(i))
          ENDIF
          aePuts(str)
          EXIT stat:=checkForPause()
        ENDFOR
        LOOP
          aePuts('\b\n Enter Startline,Endline or (*=ALL, A=Abort): ')
          stat:=lineInput('','',6,INPUT_TIMEOUT,str)
          IF(stat<0)
            RETURN stat
          ENDIF
          exit:=FALSE
          stat:=firstCharValue(str)
          IF((stat="A") OR (stat="a"))
            i:=(-1)
            lines:=0
            exit:=TRUE
          ENDIF
          EXIT exit

          IF(stat="*")
            i:=1
            i2:=lines
          ELSE
            IF (i:=InStr(str,','))<>-1
              i2:=Val(str+i+1)
              i:=Val(str)
            ENDIF
            ->sscanf(str,"%d,%d",&i,&i2)
          ENDIF

          EXIT (((i>0) AND (i<=lines)) AND ((i2>0) AND (i2<=lines)) AND (i<=i2))

        ENDLOOP
        IF(i<>(-1))
          FOR i3:=0 TO i2-i
            msgBuf.setItem(i3,msgBuf.item(i+i3-1))
          ENDFOR

          lines:=i3
          formatLongDateTime(mailHeader.msgDate,tempStr)
          StringF(str,' -----[ \s ]--[ \s ]----------------------------------------------------------------------',mailHeader.fromName,tempStr)
          SetStr(str,70)
          msgBuf.setItem(lines,str)

          lines++
          msgBuf.setItem(lines,' ')
          lines++
          msgBuf.setItem(lines,'')
          /****new reply routines ****/

        ELSE
          msgBuf.clear()
        ENDIF
      ENDIF
    ELSE
      msgBuf.clear()
      lines:=0
    ENDIF
  ELSE

skipAll:
    msgBuf.clear()
    lines:=0
  ENDIF

  stat:=edit(TRUE,75,TRUE)
  IF((stat=RESULT_TIMEOUT) OR (stat=RESULT_NO_CARRIER))
    RETURN stat
  ENDIF

  aePuts('\b\n')
  IF(stat<0)
    RETURN RESULT_FAILURE
  ENDIF

  aePuts('Saving...')
  stat:=saveNewMSG(gfh,mailHeader)
  IF(stat<0)
    RETURN stat
  ENDIF

  rzmsg:=NIL

ENDPROC RESULT_SUCCESS

PROC replyPrompt(gfh)
  DEF unum, helplist
  DEF str[255]:STRING
  DEF string[255]:STRING
  DEF stat,i

  helplist:=0
  LOOP
contloop:
    fwdFlag:=0
    IF(helplist=0)
      IF(nonStopMail=FALSE)
        aePuts('\b\n[32mMsg. Options: [33mA[36m')
        IF checkSecurity(ACS_DELETE_MESSAGE) THEN aePuts(',[33mD')
        aePuts('[36m,[33mF[36m,[33mR[36m,[33mL[36m,[33mQ')
        StringF(string,'[36m,[33m?[36m,[33m??[36m,[32m<[33mCR[32m> [32m([0m \d[32m )[0m >: ',msgNum)
        aePuts(string)
      ENDIF
    ELSEIF helplist=1
      aePuts('[33mA[32m>[36mgain[0m')
      IF checkSecurity(ACS_DELETE_MESSAGE) THEN aePuts('\b\n[33mD[32m>[36melete Message[0m')
      aePuts('\b\n[33mF[32m>[36morward[0m')
      aePuts('\b\n[33mR[32m>[36meply[0m')
      aePuts('\b\n[33mL[32m>[36mist[0m')
      aePuts('\b\n[33mQ[32m>[36muit[0m')
      StringF(string,'\b\n[32m<[33mCR[32m>[0m=[33mNext [32m([0m \d[32m )[0m >: ',msgNum)
      aePuts(string)
      helplist:=0
    ELSE
      aePuts('[33mA[32m>[36mgain[0m')
      IF checkSecurity(ACS_DELETE_MESSAGE) THEN aePuts('\b\n[33mD[32m>[36melete Message[0m')
      aePuts('\b\n[33mF[32m>[36morward[0m')
      aePuts('\b\n[33mR[32m>[36meply[0m')
      aePuts('\b\n[33mL[32m>[36mist all messages[0m')
      aePuts('\b\n[33mNS[32m>[36m Non-stop mode[0m')
      IF checkSecurity(ACS_TRANSLATION)
        IF (StrCmp(userLanguage,hostLanguage)=FALSE) THEN aePuts('\b\n[33mT[32m>[36mranslate[0m')
        aePuts('\b\n[33mTS[32m>[36m Select Language & Translate[0m')
        aePuts('\b\n[33mT![32m>[36m Translate To Each language[0m')
        aePuts('\b\n[33mT*[32m>[36m Translate from each language[0m')
      ENDIF
      aePuts('\b\n[33mK[32m>[36meep and quit[0m')
      IF checkSecurity(ACS_MESSAGE_EDIT)
        aePuts('\b\n[33mE[32m>[36m Edit Emacs Message[0m')
        aePuts('\b\n[33mEH[32m>[36m Edit Message Header[0m')
        aePuts('\b\n[33mEM[32m>[36m Edit Message Body[0m')
      ENDIF
      IF checkSecurity(ACS_ACCOUNT_EDITING)
        aePuts('\b\n[33mU[32m>[36mser Account Edit[0m')
      ENDIF
      aePuts('\b\n[33mQ[32m>[36muit[0m')
      StringF(string,'\b\n[32m<[33mCR[32m>[0m=[33mNext [32m([0m \d[32m )[0m >: ',msgNum)
      aePuts(string)
      helplist:=0
    ENDIF

    IF(nonStopMail=FALSE)
      stat:=lineInput('','',10,INPUT_TIMEOUT,str)
      IF(stat<0) THEN RETURN stat
      aePuts('\b\n')
    ENDIF
    IF(StriCmp(str,'??'))
      helplist:=2
      JUMP contloop
    ENDIF
    IF(str[0]="?")
      helplist:=1
      JUMP contloop
    ENDIF

    IF(((str[0]="N") OR (str[0]="n")) AND ((str[1]="S") OR (str[1]="s"))) THEN nonStopMail:=TRUE

    IF((StrLen(str)=0) OR (nonStopMail)) THEN RETURN RESULT_SUCCESS

    IF(((str[0]="A") OR (str[0]="a")))
      stat:=displayMessage(gfh)
      IF(stat<0) THEN RETURN stat
      JUMP contloop
    ENDIF

    IF checkSecurity(ACS_TRANSLATION) AND ((str[0]="T") OR (str[0]="t"))
      IF StriCmp(str,'t!') OR StriCmp(str,'t*')
        i:=1
        StringF(string,'LANGUAGE.\d',i)
        WHILE readToolType(TOOLTYPE_LANGUAGES,'',string,translatorLanguage)

          IF StrCmp(translatorLanguage,hostLanguage)=FALSE
            IF StriCmp(str,'t!')
              StringF(string,'\b\nTranslating to \s\b\n\b\n',translatorLanguage)
              aePuts(string)
              translatorMode:=TRANS_HOST_TO_DEFINED
            ELSE
              StringF(string,'\b\nTranslating from \s\b\n\b\n',translatorLanguage)
              aePuts(string)
              translatorMode:=TRANS_DEFINED_TO_HOST
            ENDIF

            stat:=displayMessage(gfh)
            translatorMode:=TRANS_NONE
            IF(stat<0) THEN RETURN stat
            doPause()
          ENDIF

          i++
          StringF(string,'LANGUAGE.\d',i)
        ENDWHILE
      ELSE
        IF StriCmp(str,'ts')
          stat:=chooseTranslator()
          IF(stat<0) THEN RETURN stat
        ENDIF
        translatorMode:=TRANS_HOST_TO_DEFINED
        StrCopy(translatorLanguage,userLanguage)
        stat:=displayMessage(gfh)
        translatorMode:=TRANS_NONE
        IF(stat<0) THEN RETURN stat
      ENDIF
      JUMP contloop
    ENDIF

    IF checkSecurity(ACS_DELETE_MESSAGE)
      IF(((str[0]="D") OR (str[0]="d")))
        IF((privateFlag=0) OR ((stringCompare(mailHeader.toName,confMailName)=RESULT_SUCCESS)))
          stat:=deleteMSG(gfh)
          RETURN RESULT_SUCCESS
        ELSE
          aePuts('Not your message.\b\n')
          JUMP contloop
        ENDIF
      ENDIF
    ENDIF

    IF(((str[0]="K") OR (str[0]="k")))
      IF((privateFlag=0) OR ((stringCompare(mailHeader.toName,confMailName)=RESULT_SUCCESS)))
        mailHeader.recv:=0
        delMsgNum:=mailHeader.msgNumb;
        IF lastNewReadConf>=mailHeader.msgNumb THEN lastNewReadConf--
        IF mailStat.lowestNotDel>=mailHeader.msgNumb THEN lastNewReadConf:=mailStat.lowestNotDel
        saveOverHeader(gfh)
        kMsgFlag:=TRUE
        RETURN RESULT_SUCCESS
      ELSE
        aePuts('Not your message.\b\n')
        JUMP contloop
      ENDIF
    ENDIF

    IF(((str[0]="E") OR (str[0]="e")) AND (checkSecurity(ACS_MESSAGE_EDIT)))
      IF((str[1]="H") OR (str[1]="h"))
        IF((stat:=editHeader(gfh))<0) THEN RETURN stat
      ELSEIF((str[1]="M") OR (str[1]="m"))
        fileattach:=FALSE
        StringF(str,'\s\d',msgBaseLocation,mailHeader.msgNumb)
        loadMsg(str)
        IF(edit()=RESULT_SUCCESS) THEN saveMsg(str)
      ELSE
        editEMessage(mailHeader.msgNumb)
      ENDIF
      stat:=displayMessage(gfh)
      IF(stat<0) THEN RETURN stat
      JUMP contloop
    ENDIF
    IF(((str[0]="U") OR (str[0]="u")))
      IF(checkSecurity(ACS_ACCOUNT_EDITING))
        StrCopy(str,mailHeader.fromName,31)
        unum:=findUserFromName(1,confNameType,str,tempUser,tempUserKeys,tempUserMisc)
        IF unum
          stat:=loadAccount(unum,tempUser,tempUserKeys,tempUserMisc)
          IF(stat=RESULT_FAILURE)
            aePuts('Warning, error while loading account\b\n')
            JUMP contloop
          ENDIF

          sendCLS()
          callersLog('\tAccount editing from mail.')
          editInfo(unum,tempUser,tempUserKeys,tempUserMisc,FALSE)
          sendCLS()
          stat:=displayMessage(gfh)
          IF(stat<0) THEN RETURN stat
        ELSE
          aePuts('User no longer exists.\b\n')
        ENDIF
        JUMP contloop
      ENDIF
    ENDIF

    IF(((str[0]="f") OR (str[0]="F")))
      IF((privateFlag=0) OR ((stringCompare(mailHeader.toName,confMailName)=RESULT_SUCCESS)) OR (StrCmp(mailHeader.toName,'EALL',4)))
        stat:=captureRealAndInternetNames(currentConf,currentMsgBase)
        IF stat=RESULT_SUCCESS
          stat:=forwardMSG(gfh)
        ENDIF
        JUMP contloop
      ELSE
        aePuts('Not your message.\b\n')
        JUMP contloop
      ENDIF
    ENDIF

    IF(((str[0]="l") OR (str[0]="L")))
      stat:=listMSGs(gfh)
      JUMP contloop
    ENDIF

    IF((str[0]="Q") OR (str[0]="q"))
      aePuts('\b\n')
      RETURN RESULT_FAILURE
    ENDIF

    IF(((str[0]="r") OR (str[0]="R")))
      IF((privateFlag=0) OR ((stringCompare(mailHeader.toName,confMailName)=RESULT_SUCCESS)) OR (StrCmp(mailHeader.toName,'EALL',4)))
        stat:=captureRealAndInternetNames(currentConf,currentMsgBase)
        IF stat=RESULT_SUCCESS
          stat:=replyToMSG(gfh)
          RETURN RESULT_SUCCESS
        ENDIF
      ELSE
        aePuts('Not your message.\b\n')
        JUMP contloop
      ENDIF
    ENDIF
    aePuts('No such command!!\b\n')
  ENDLOOP

ENDPROC RESULT_SUCCESS

PROC nameCompare(s,t)
  IF(sopt.toggles[TOGGLES_USEWILDCARDS])
    RETURN stringCompare(s,t)
  ELSEIF StriCmp(s,t)
    RETURN 0
  ENDIF
ENDPROC 1

PROC checkForAst(s)
  DEF i
  FOR i:=0 TO StrLen(s)-1
    IF((s[i]="*") AND (sopt.toggles[TOGGLES_USEWILDCARDS])) THEN RETURN i+1
  ENDFOR

ENDPROC FALSE

PROC checkIfNameAllowed(name)
  DEF num,loop
  DEF disallowedName[255]:STRING
  DEF nameStr[20]:STRING

  IF StriCmp(name,'')
    aePuts('Username not allowed!!\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  IF StriCmp(name,'NEW')
    aePuts('Username not allowed!!\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  IF StriCmp(name,'ACS.',4)
    aePuts('Username not allowed!!\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  num:=1
  loop:=TRUE
  WHILE loop
    StringF(nameStr,'NAME.\d',num)
    IF readToolType(TOOLTYPE_NAMESNOTALLOWED,'',nameStr,disallowedName)=FALSE
      loop:=FALSE
    ELSE
      IF(StriCmp(name,disallowedName))
        aePuts('Username not allowed!!\b\n\b\n')
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF
    num++
  ENDWHILE
ENDPROC RESULT_SUCCESS

PROC updateLineLen()
  DEF string[10]:STRING
  IF loggedOnUser.lineLength=0
    IF logonType<>LOGON_TYPE_REMOTE
      IF window<>NIL
        userLineLen:=Shr(window.height,3)-1
      ELSE
        userLineLen:=29
      ENDIF
    ELSE
      userLineLen:=29
      IF telnetSocket<>-1
        StringF(string,'\c\c\c',255,253,31)    ->DO NAWS
        binaryRaw:=TRUE
        telnetSend(string,3)
        binaryRaw:=FALSE
      ENDIF
    ENDIF
  ELSE
    IF telnetSocket<>-1
      StringF(string,'\c\c\c',255,254,31)    ->DON'T NAWS
      binaryRaw:=TRUE
      telnetSend(string,3)
      binaryRaw:=FALSE
    ENDIF
    userLineLen:=loggedOnUser.lineLength
  ENDIF
ENDPROC

PROC numberOfLinesTest()
  DEF stat
  DEF str[20]:STRING

  FOR stat:=70 TO 2 STEP -1
    StringF(str,' \d\b\n',stat)
    aePuts(str)
  ENDFOR
  aePuts('\b\nEnter the number you see at the top of your screen (or 0 for Auto): ')
  stat:=lineInput('','',3,INPUT_TIMEOUT,str)
  IF(stat<0) THEN RETURN stat
  IF(StrLen(str)=0) THEN RETURN RESULT_SUCCESS
  stat:=Val(str)

  IF((stat < 0) OR (stat > 255)) THEN RETURN RESULT_FAILURE
  loggedOnUser.lineLength:=stat
  updateLineLen()
  
ENDPROC RESULT_SUCCESS

PROC chooseComputer()
  DEF stat
  DEF tempStr[40]:STRING

  FOR stat:=0 TO computerTypes.count()-1 STEP 2
    StringF(tempStr,'\d[2]> \l\s[34] ',stat+1,computerTypes.item(stat))
    aePuts(tempStr)
    IF((stat+1)<computerTypes.count())
      StringF(tempStr,'\d[2]> \l\s[34]\b\n',stat+2,computerTypes.item(stat+1))
      aePuts(tempStr)
    ELSE
      aePuts('\b\n')
    ENDIF

  ENDFOR
  aePuts('\b\n')

jLoop6:
  aePuts('Choose computer type: ')
  stat:=lineInput('','',3,INPUT_TIMEOUT,tempStr)
  IF(stat<0) THEN RETURN stat
  IF(StrLen(tempStr)=0) THEN RETURN RESULT_SUCCESS
  stat:=Val(tempStr)
  IF((stat <= 0) OR (stat > computerTypes.count())) THEN JUMP jLoop6

  loggedOnUser.secBulletin:=stat-1

ENDPROC RESULT_SUCCESS

PROC chooseScreenType()

  DEF stat
  DEF tempStr[40]:STRING

  FOR stat:=1 TO screenTypeTitle.count()
    StringF(tempStr,'\d> \l\s\b\n',stat,screenTypeTitle.item(stat-1))
    aePuts(tempStr)
  ENDFOR

stLoop5:
  aePuts('\b\nChoose screen type: ')
  stat:=lineInput('','',3,INPUT_TIMEOUT,tempStr)
  IF(stat<0) THEN RETURN stat
  IF(StrLen(tempStr)=0) THEN RETURN RESULT_SUCCESS
  stat:=Val(tempStr)
  IF((stat <= 0) OR (stat > screenTypeTitle.count())) THEN JUMP stLoop5

  loggedOnUser.screenType:=stat-1

ENDPROC RESULT_SUCCESS

PROC chooseProtocol()
  DEF stat,i
  DEF tempStr[40]:STRING

  FOR i:=1 TO xprTitle.count()
    StringF(tempStr,'\d> \s\b\n',i,xprTitle.item(i-1))
    aePuts(tempStr)
  ENDFOR
pLoop1:
  aePuts('\b\nChoose protocol: ')

  stat:=lineInput('','',5,INPUT_TIMEOUT,tempStr)
  IF(stat<0) THEN RETURN stat

  IF(StrLen(tempStr)=0) THEN RETURN RESULT_SUCCESS
  stat:=Val(tempStr)
  IF((stat <= 0) OR (stat > xprTitle.count())) THEN JUMP pLoop1

  loggedOnUser.xferProtocol:=stat-1
ENDPROC RESULT_SUCCESS

PROC chooseTranslator()
  DEF tempstr[15]:STRING
  DEF stat

  IF displayScreen(SCREEN_LANGUAGES)=FALSE
    aePuts('Languages list unavailable\b\n\b\n')
  ENDIF

redoTrans:
  aePuts('\b\nLanguage (num) >: ')

  stat:=lineInput('','',5,INPUT_TIMEOUT,tempstr)
  IF(stat<0) THEN RETURN stat

  IF(StrLen(tempstr)=0) THEN RETURN RESULT_SUCCESS

  IF (tempstr[0]="H") OR (tempstr[0]="h")
    loggedOnUser.translatorID:=Eor(loggedOnUser.translatorID,128)
    IF loggedOnUser.translatorID AND 128
      aePuts('WORD HIGHLIGHT ON')
    ELSE
      aePuts('WORD HIGHLIGHT OFF')
    ENDIF
    JUMP redoTrans
  ENDIF

  stat:=Val(tempstr)
  IF (stat <= 0) THEN RETURN RESULT_SUCCESS

  StringF(tempstr,'LANGUAGE.\d',stat)
  IF readToolType(TOOLTYPE_LANGUAGES,'',tempstr,userLanguage)
    loggedOnUser.translatorID:=(loggedOnUser.translatorID AND 128) OR stat
  ENDIF
ENDPROC RESULT_SUCCESS

PROC findUserFromNumber(start,hoozer:PTR TO userKeys)
  DEF fh
  fh:=Open(userKeysFile,MODE_OLDFILE)
  IF(fh=0) THEN RETURN 0
  Seek(fh,(start-1)*SIZEOF userKeys,OFFSET_BEGINNING)
  IF(Read(fh,hoozer,SIZEOF userKeys)>0)
    Close(fh)
    RETURN 1
  ENDIF
  Close(fh)
ENDPROC 0

PROC deactivateOldUsers(days)
  DEF fh,fh2
  DEF l,l2
  DEF i,deactivateLimit

  deactivateLimit:=getSystemTime()-Mul(days,86400)

  IF(fh:=Open(userDataFile,MODE_READWRITE))<>0
    l:=SIZEOF user
    l2:=SIZEOF userKeys

    IF(fh2:=Open(userKeysFile,MODE_READWRITE))<>0
      i:=0
      WHILE(Read(fh,tempUser,l)=l)
        IF tempUser.timeLastOn<deactivateLimit
          IF tempUser.slotNumber<>0
            Seek(fh,-l,OFFSET_CURRENT)
            tempUser.slotNumber:=0
            Write(fh,tempUser,l)

            Seek(fh2,Mul(i,l2),OFFSET_BEGINNING)
            IF (Read(fh2,tempUserKeys,l2)=l2)
              Seek(fh2,-l2,OFFSET_CURRENT)
              tempUserKeys.number:=0
              Write(fh2,tempUserKeys,l2)
            ENDIF
          ENDIF
        ENDIF
        i++
      ENDWHILE
      Close(fh2)
    ENDIF
    Close(fh)
  ENDIF
ENDPROC

PROC findUserFromName(start,nameType,name, hoozer: PTR TO user, hoozer2: PTR TO userKeys, hoozer3: PTR TO userMisc) HANDLE
  DEF slot, stat, fh=NIL,fh2=NIL
  DEF tempStr[255]:STRING

  start--
  StrCopy(tempStr,name,31)
  UpperStr(tempStr)

  fh:=Open(userKeysFile,MODE_OLDFILE)
  IF(fh=0) THEN RETURN 0
  Seek(fh,start*SIZEOF userKeys,OFFSET_BEGINNING)

  fh2:=Open(userMiscFile,MODE_OLDFILE)
  IF(fh2=0) THEN RETURN 0
  Seek(fh2,start*SIZEOF userMisc,OFFSET_BEGINNING)

  slot:=0
  LOOP
    stat:=Read(fh,hoozer2,SIZEOF userKeys)
    IF(stat<>SIZEOF userKeys)
      Throw(ERR_EXCEPT,0)
    ENDIF

    stat:=Read(fh2,hoozer3,SIZEOF userMisc)
    IF(stat<>SIZEOF userMisc)
      Throw(ERR_EXCEPT,0)
    ENDIF

    slot++
    SELECT nameType
      CASE NAME_TYPE_USERNAME
        IF ((nameCompare(hoozer2.userName,tempStr)=RESULT_SUCCESS) AND (includeDeact OR (hoozer2.number<>0)))
          Throw(ERR_EXCEPT,start+slot)
        ENDIF
      CASE NAME_TYPE_REALNAME
        IF ((nameCompare(hoozer3.realName,tempStr)=RESULT_SUCCESS) AND (includeDeact OR (hoozer2.number<>0)))
          Throw(ERR_EXCEPT,start+slot)
        ENDIF
      CASE NAME_TYPE_INTERNETNAME
        IF ((nameCompare(hoozer3.internetName,tempStr)=RESULT_SUCCESS) AND (includeDeact OR (hoozer2.number<>0)))
          Throw(ERR_EXCEPT,start+slot)
        ENDIF
    ENDSELECT
  ENDLOOP
  Close(fh)
  Close(fh2)
EXCEPT
  Close(fh)
  Close(fh2)
  RETURN exceptioninfo
ENDPROC 0

PROC chooseAName(s,hoozer: PTR TO user,hoozer2: PTR TO userKeys,hoozer3: PTR TO userMisc,lflag)
  DEF stat,i
  i:=1
  REPEAT
    stat:=findUserFromName(i,confNameType,s,hoozer,hoozer2,hoozer3)
    IF(stat=0)
      IF(lflag) THEN aePuts('\b\nUser does not exist!!\b\n\b\n')
      RETURN RESULT_FAILURE
    ENDIF
    IF(stat:=checkForAst(s))
      IF((stat<4) OR ((sopt.toggles[TOGGLES_USEWILDCARDS])=FALSE)) THEN RETURN RESULT_FAILURE
      aePuts(' Expand: ')
      aePuts(hoozer2.userName)
      aePuts(' Correct ')
      stat:=yesNo(1)
      IF(stat<0) THEN RETURN stat
      IF(stat=0)
        IF(ansiColour) THEN aePuts('[A[K')
        stat:=1
        i:=(hoozer2.number)+1
      ELSE
       stat:=0
      ENDIF

    ELSE
      stat:=0
    ENDIF
  UNTIL stat=0
  loadAccount(hoozer2.number,hoozer,hoozer2,hoozer3)
ENDPROC 1

PROC getAValidName(name, default, str)
  DEF stat

  IF(StrLen(name)=0)
    AstrCopy(str,default,31)
    RETURN 0
  ENDIF

  AstrCopy(str,name,31)
  LowerStr(str)
  IF(StrCmp(str,'all',3))
    UpperStr(str)
    RETURN 1
  ENDIF

  IF(StrCmp(str,'eall',4))
    UpperStr(str)
    RETURN 1
  ENDIF

  IF(StrCmp(str,'sysop',5))
    loadAccount(1,tempUser,tempUserKeys,tempUserMisc)
  ELSE
    stat:=chooseAName(name,tempUser,tempUserKeys,tempUserMisc,1)
    IF(stat<0)
      AstrCopy(str,'')
      RETURN 0
    ENDIF
  ENDIF

  SELECT confNameType
    CASE NAME_TYPE_USERNAME
      AstrCopy(str,tempUserKeys.userName,31)
    CASE NAME_TYPE_REALNAME
      AstrCopy(str,tempUserMisc.realName,26)
    CASE NAME_TYPE_INTERNETNAME
      AstrCopy(str,tempUserMisc.internetName,10)
  ENDSELECT
  IF(checkConfAccess(currentConf,tempUser)=FALSE)
    aePuts('\b\nUser does not have access to this conference, try another!\b\n\b\n')
    AstrCopy(str,'')
    RETURN 0
  ENDIF
ENDPROC 0

PROC editHeader(gfh)
  DEF aFlag
  DEF mh: mailHeader
  DEF string[200]:STRING
  DEF stat

  CopyMem(mailHeader,mh,SIZEOF mailHeader)
  mh.status:="P"
  aePuts('\b\n')
  StringF(string,'     [36mFrom[33m: [32m([33mEnter[32m)[0m=[32m''[33m\s[32m''[32m?[0m ',mailHeader.fromName)
  aePuts(string)
  stat:=lineInput('','',30,INPUT_TIMEOUT,string)
  IF (stat<0) THEN RETURN stat
  aFlag:=getAValidName(string,mailHeader.fromName,mh.fromName)

  IF(StrLen(mh.fromName)=0) THEN RETURN 2

  IF(aFlag)
    aePuts('Invalid From Name. Aborting.\b\n')
    RETURN 2
  ENDIF
  StringF(string,'     [36m  To[33m: [32m([33mEnter[32m)[0m=[32m''[33m\s[32m''[32m?[0m ',mailHeader.toName)
  aePuts(string)
  stat:=lineInput('','',30,INPUT_TIMEOUT,string)
  IF(stat<0) THEN RETURN stat
  aFlag:=getAValidName(string,mailHeader.toName,mh.toName)

  IF(StrLen(mh.toName)=0) THEN RETURN 2
  StringF(string,'  [36mSubject[33m: [32m([33mEnter[32m)[0m=[32m''[33m\s[32m''[32m?[0m ',mailHeader.subject)
  aePuts(string)
  stat:=lineInput('','',30,INPUT_TIMEOUT,string)
  IF(stat<0) THEN RETURN stat
  IF(string[0]>=" ") THEN AstrCopy(mh.subject,string,30)

  IF(aFlag=FALSE)
    aePuts('         [36mPrivate ')
    stat:=yesNo(2)
    IF(stat<0) THEN RETURN stat
    IF(stat) THEN mh.status:="R" ELSE mh.status:="P"
  ENDIF

  mh.recv:=0

  CopyMem(mh,mailHeader,SIZEOF mailHeader)
  delMsgNum:=msgNum-fwdFlag
  saveOverHeader(gfh)

ENDPROC 1

PROC searchNewMail(gfh, cn, msgBaseNum)
  DEF mailFlag,msgcnt,dcnt,displayMsg
  DEF mailStatus[7]:STRING
  DEF tempStr[255]:STRING
  DEF msgBaseName[255]:STRING
  DEF stat,oldcn
  DEF cb:PTR TO confBase
  msgcnt:=0
  dcnt:=0

  mailFlag:=0
  nonStopMail:=FALSE
  kMsgFlag:=FALSE
  displayMsg:=0

  IF(mailStat.highMsgNum<lastNewReadConf) THEN lastNewReadConf:=mailStat.lowestKey

  IF(currentConf=0)
    IF msgBaseNum=1
      StringF(tempStr,'[32mScanning Conference[33m: [0m\s - ',currentConfName)
      aePuts(tempStr)
    ENDIF
    getMsgBaseName(cn,msgBaseNum,msgBaseName)

    IF StrLen(msgBaseName)>0
      IF msgBaseNum=1 THEN aePuts('\n')
      StringF(tempStr,' [32mMessage Base[33m: [0m\s - ',msgBaseName)
      aePuts(tempStr)
    ENDIF
  ENDIF

  msgNum:=lastNewReadConf

  IF(msgNum<=0) THEN lastNewReadConf:=msgNum:=mailStat.lowestKey

  IF(msgNum<mailStat.lowestKey) THEN msgNum:=mailStat.lowestKey
  IF(msgNum>=mailStat.highMsgNum)
    IF(currentConf=0)
      aePuts('No mail today!\b\n')
    ELSE
      aePuts('\b\n')
    ENDIF
    IF(nonStopDisplayFlag=FALSE) THEN lineCount++
    RETURN RESULT_SUCCESS
  ENDIF

  REPEAT
    IF(msgNum>=mailStat.highMsgNum)
      JUMP getOUT
    ENDIF
    stat:=loadMessageHeader(gfh)
    IF(mailHeader.status="D") THEN JUMP getNextMSG

    cb:=confBases.item(getConfIndex(cn,msgBaseNum))

    IF(((stringCompare(mailHeader.toName,confMailName)=RESULT_SUCCESS) OR (stringCompare(mailHeader.toName,'eall')=RESULT_SUCCESS) OR ((stringCompare(mailHeader.toName,'all')=RESULT_SUCCESS) AND (cb.handle[0] AND MAILSCAN_ALL)))) AND (mailHeader.recv=0)

      IF(currentConf=0)

        IF(mailFlag=0)
          displayMsg:=msgNum
          aePuts('\b\n\b\n')
          aePuts('[32mType     From                           Subject                Msg    \b\n')
          aePuts('[33m-------  -----------------------------  ---------------------  -------\b\n')
          aePuts('[0m')
          IF(nonStopDisplayFlag=FALSE) THEN lineCount:=lineCount+4
          mailFlag:=1
        ENDIF
        IF (mailHeader.status="P") OR (mailHeader.status="p") THEN StrCopy(mailStatus,'Public ') ELSE StrCopy(mailStatus,'Private')
        StringF(tempStr,'\s  \l\s[29]  \l\s[21]  [0m\z\r\d[6]\b\n',mailStatus,mailHeader.fromName,mailHeader.subject,mailHeader.msgNumb)
        aePuts(tempStr)

        IF checkForPause()=RESULT_FAILURE THEN RETURN RESULT_SUCCESS

      ELSE
        IF mailFlag=0
          displayMsg:=msgNum
          mailFlag:=1
        ENDIF
      ENDIF
    ENDIF
getNextMSG:
    msgNum++
  UNTIL msgNum>mailStat.highMsgNum

getOUT:
  IF(currentConf<>0) AND (mailFlag) THEN aePuts('\b\nFound Mail!')
  IF (mailFlag)
    aePuts('\b\nWould you like to read it now ')
    stat:=yesNo(1)
    aePuts('\b\n')
    IF(stat<0) THEN RETURN stat
    IF(stat)
      oldcn:=currentConf
      msgNum:=displayMsg
      WHILE (msgNum<mailStat.highMsgNum)
        stat:=loadMessageHeader(gfh)
        IF(mailHeader.status<>"D")
          IF(((stringCompare(mailHeader.toName,confMailName)=RESULT_SUCCESS) OR (stringCompare(mailHeader.toName,'eall')=RESULT_SUCCESS) OR ((stringCompare(mailHeader.toName,'all')=RESULT_SUCCESS) AND (cb.handle[0] AND MAILSCAN_ALL))))
            oldcn:=currentConf
            currentConf:=cn
            stat:=displayMessage(gfh)
            IF(stat<0)
              currentConf:=oldcn
              RETURN stat
            ENDIF
            stat:=replyPrompt(gfh)
            currentConf:=oldcn
            IF kMsgFlag=FALSE THEN lastNewReadConf:=msgNum+1
            IF(stat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
            IF(stat<0) THEN RETURN stat
          ENDIF
        ENDIF
        msgNum++
      ENDWHILE
    ELSE
      RETURN RESULT_SUCCESS
    ENDIF
  ELSE
    lastNewReadConf:=msgNum
    IF(currentConf=0)
      aePuts('No mail today!\b\n')
    ELSE
      aePuts('\b\n')
    ENDIF
  ENDIF

ENDPROC RESULT_SUCCESS

PROC saveOverHeader(gfh)
  DEF headPoint,size,filePos,error,temp

  headPoint:=delMsgNum-mailStat.lowestKey
  size:=SIZEOF mailHeader
  filePos:=Mul(size,headPoint)
  temp:=filePos-currentSeekPos

  error:=Seek(gfh,temp,OFFSET_CURRENT)
  IF(error<0)
    myError(ERR_MSGBASE)
    RETURN RESULT_FAILURE
  ENDIF

  error:=Write(gfh,mailHeader,size)
  Seek(gfh,currentSeekPos,OFFSET_BEGINNING)

  IF(error<>size)
    myError(ERR_MSGBASE)
    RETURN RESULT_FAILURE
  ENDIF

ENDPROC RESULT_SUCCESS

PROC saveStatOnly()
  DEF error
  DEF string[255]:STRING
  DEF fd

  StringF(string,'\s\s',msgBaseLocation,'MailStats')
  fd:=Open(string,MODE_READWRITE)
  IF(fd=0)
    myError(ERR_MSGBASE)
    RETURN RESULT_FAILURE
  ENDIF

  error:=Write(fd,mailStat,SIZEOF mailStat)
  IF(error<>SIZEOF mailStat)
    aePuts('Wasn''t the same!\b\n')
    Close(fd)
    myError(ERR_MSGBASE)
    RETURN RESULT_FAILURE
  ENDIF
  Close(fd)
  RETURN RESULT_SUCCESS
ENDPROC

PROC deleteMSG(gfh)
  DEF string[255]:STRING
  DEF msgbaselock

  IF(loggedOnUser.secStatus<210)
    IF(stringCompare(mailHeader.fromName,confMailName)=RESULT_SUCCESS) THEN JUMP goAheadDel
    IF(stringCompare(mailHeader.toName,confMailName)=RESULT_SUCCESS) THEN JUMP goAheadDel
    aePuts('\b\nMessage not deleted, not your mail.\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

goAheadDel:
  IF(msgbaselock:=lockMsgBase())
    getMailStatFile(currentConf,currentMsgBase)
    delMsgNum:=msgNum-fwdFlag
    IF(mailStat.lowestNotDel=delMsgNum) THEN mailStat.lowestNotDel:=mailStat.lowestNotDel+1
    saveStatOnly()
    mailHeader.status:="D"
    checkAttachedFile(delMsgNum,0)
    StringF(string,'\s\d',msgBaseLocation,delMsgNum)
    SetProtection(string,FIBF_OTR_DELETE)
    DeleteFile(string)
    saveOverHeader(gfh)
    StringF(string,'\b\nMessage \d deleted...\b\n',delMsgNum)
    aePuts(string)
    UnLock(msgbaselock)
  ELSE
    aePuts('Can''t Lock MsgBase, Message not Deleted!\b\n')
  ENDIF
ENDPROC RESULT_SUCCESS

PROC lockMsgBase()
  DEF lock, loop, error
  DEF tempstr[255]:STRING

  loop:=0
  StringF(tempstr,'\sMailLock',msgBaseLocation)
  REPEAT
    lock:=Lock(tempstr,ACCESS_WRITE)
    IF(lock=0)
      error:=IoErr()
      IF(error=205) THEN createFile(tempstr)
      Delay(120)
      aePuts('.')
    ENDIF
  UNTIL((lock<>0) OR (loop++>=30))

  IF(lock=0)
    StringF(tempstr,'\tError \d trying to Lock MSGBASE',IoErr())
    callersLog(tempstr)
  ENDIF
ENDPROC lock

PROC createFile(filename)
  DEF fh
  fh:=Open(filename,MODE_NEWFILE)
  Close(fh)
ENDPROC

PROC readMSG(gfh)
  DEF uNum,helplist=0
  DEF str[255]:STRING
  DEF string[255]:STRING
  DEF i,stat
  DEF lowerChar

  DEF firstparam

  nonStopMail:=replyFlag:=tempFlag:=numOfZMsgs:=0
  fwdFlag:=1
  fwdDir:="+"
  msgNum:=lastMsgReadConf+1
  IF(msgNum<mailStat.lowestKey) THEN msgNum:=mailStat.lowestKey

  aePuts('\b\n')

  nonStopMail:=paramsContains('NS')

  IF paramsContains('S')
    IF(msgNum>(mailStat.highMsgNum-1))
      aePuts('No new messages.\b\n')
      aePuts('\b\n')
      RETURN RESULT_FAILURE
    ENDIF
    JUMP goNextMsg
  ENDIF

  IF parsedParams.count()>0
    firstparam:=parsedParams.item(0)
    IF (StrCmp(firstparam,'-')) OR (StrCmp(firstparam,'+')) OR (isDigit(firstparam))
      StrCopy(str,firstparam)
      JUMP passItIN
    ENDIF
  ENDIF

  LOOP
  cont:
    IF(fwdFlag=1) THEN StringF(str,'\d\c\d',msgNum,fwdDir,mailStat.highMsgNum-1) ELSE StringF(str,'\d\c\d',msgNum,fwdDir,mailStat.lowestKey)

    IF((msgNum>(mailStat.highMsgNum-1)) OR (msgNum<mailStat.lowestKey)) THEN StrCopy(str,'QUIT')

    IF(helplist=0)
      IF(nonStopMail=FALSE)
        aePuts('\b\n[32mMsg. Options: [33mA[36m')
        IF checkSecurity(ACS_DELETE_MESSAGE) THEN aePuts(',[33mD')
        aePuts('[36m,[33mF[36m,[33mR[36m,[33mL[36m,[33mQ')
        StringF(string,'[36m,[33m?[36m,[33m??[36m,[32m<[33mCR[32m> [32m([0m \s[32m )[0m>: ',str)
        aePuts(string)
      ENDIF
    ELSEIF(helplist=1)
      aePuts('[33mA[32m>[36mgain[0m')
      IF checkSecurity(ACS_DELETE_MESSAGE) THEN aePuts('\b\n[33mD[32m>[36melete Message[0m')
      aePuts('\b\n[33mF[32m>[36morward[0m')
      aePuts('\b\n[33mR[32m>[36meply[0m')
      aePuts('\b\n[33mL[32m>[36mist[0m')
      aePuts('\b\n[33mQ[32m>[36muit[0m')
      StringF(string,'\b\n[32m<[33mCR[32m>[0m=[33mNext [32m([0m \s[32m )[0m? ',str)
      aePuts(string)
      helplist:=0
    ELSE
      aePuts('[33mA[32m>[36mgain[0m')
      IF checkSecurity(ACS_DELETE_MESSAGE) THEN aePuts('\b\n[33mD[32m>[36melete Message[0m')
      aePuts('\b\n[33mF[32m>[36morward[0m')
      aePuts('\b\n[33mR[32m>[36meply[0m')
      aePuts('\b\n[33mL[32m>[36mist all messages[0m')
      aePuts('\b\n[33mNS[32m>[36m Non-stop mode[0m')
      IF checkSecurity(ACS_TRANSLATION)
        IF (StrCmp(userLanguage,hostLanguage)=FALSE) THEN aePuts('\b\n[33mT[32m>[36mranslate[0m')
        aePuts('\b\n[33mTS[32m>[36m Select Language & Translate[0m')
        aePuts('\b\n[33mT![32m>[36m Translate to each language[0m')
        aePuts('\b\n[33mT*[32m>[36m Translate from each language[0m')
      ENDIF
      aePuts('\b\n[33mK[32m>[36meep and quit[0m')
      IF checkSecurity(ACS_MESSAGE_EDIT)
       aePuts('\b\n[33mE[32m>[36m Edit Emacs Message[0m')
       aePuts('\b\n[33mEH[32m>[36m Edit Message Header[0m')
       aePuts('\b\n[33mEM[32m>[36m Edit Message Body[0m')
      ENDIF
      IF checkSecurity(ACS_ACCOUNT_EDITING)
       aePuts('\b\n[33mU[32m>[36mser Account Edit[0m')
      ENDIF

      aePuts('\b\n[33mQ[32m>[36muit[0m')
      StringF(string,'\b\n[32m<[33mCR[32m>[0m=[33mNext [32m([0m \s[32m )[0m? ',str)
      aePuts(string)
      helplist:=0
    ENDIF

    IF(nonStopMail=FALSE)
      noDirF:=1
      stat:=lineInput('','',10,INPUT_TIMEOUT,str)
      IF(stat<>RESULT_SUCCESS) THEN RETURN RESULT_FAILURE
      aePuts('\b\n')
    ENDIF

    IF(StriCmp(str,'??'))
      helplist:=2
      JUMP cont
    ENDIF
    IF(str[0]="?")
      helplist:=1
      JUMP cont
    ENDIF

    IF(((str[0]="N") OR (str[0]="n")) AND ((str[1]="S") OR (str[1]="s"))) THEN nonStopMail:=TRUE

    IF((EstrLen(str)=0) OR (nonStopMail))
      noDirF:=1
      JUMP goNextMsg
    ENDIF

    IF(tempFlag)
      IF((privateFlag=0) OR (stringCompare(mailHeader.toName,confMailName)=RESULT_SUCCESS) OR
         (stringCompare(mailHeader.fromName,confMailName)=RESULT_SUCCESS)) OR
         (checkSecurity(ACS_SYSOP_READ))

        lowerChar:=LowerChar(str[0])
        SELECT lowerChar
          CASE "k"
            mailHeader.recv:=0
            delMsgNum:=mailHeader.msgNumb;
            IF lastNewReadConf>=mailHeader.msgNumb THEN lastNewReadConf--
            IF mailStat.lowestNotDel>=mailHeader.msgNumb THEN lastNewReadConf:=mailStat.lowestNotDel
            saveOverHeader(gfh)
            kMsgFlag:=TRUE
            noDirF:=1
          CASE "a"
            stat:=displayMessage(gfh)
            IF(stat<0) THEN RETURN stat
            JUMP nextMenu
          CASE "t"
            IF checkSecurity(ACS_TRANSLATION)=FALSE THEN JUMP nextMenu

            IF StriCmp(str,'t!') OR StriCmp(str,'t*')
              i:=1
              StringF(string,'LANGUAGE.\d',i)
              WHILE readToolType(TOOLTYPE_LANGUAGES,'',string,translatorLanguage)

                IF StrCmp(translatorLanguage,hostLanguage)=FALSE
                  IF StriCmp(str,'t!')
                    StringF(string,'\b\nTranslating to \s\b\n\b\n',translatorLanguage)
                    aePuts(string)
                    translatorMode:=TRANS_HOST_TO_DEFINED
                  ELSE
                    StringF(string,'\b\nTranslating from \s\b\n\b\n',translatorLanguage)
                    aePuts(string)
                    translatorMode:=TRANS_DEFINED_TO_HOST
                  ENDIF

                  stat:=displayMessage(gfh)
                  translatorMode:=TRANS_NONE
                  IF(stat<0) THEN RETURN stat
                  doPause()
                ENDIF

                i++
                StringF(string,'LANGUAGE.\d',i)
              ENDWHILE
            ELSE
              IF StriCmp(str,'ts')
                stat:=chooseTranslator()
                IF(stat<0) THEN RETURN stat
              ENDIF
              translatorMode:=TRANS_HOST_TO_DEFINED
              StrCopy(translatorLanguage,userLanguage)
              stat:=displayMessage(gfh)
              translatorMode:=TRANS_NONE
              IF(stat<0) THEN RETURN stat
            ENDIF
            JUMP nextMenu

          CASE "d"
            IF checkSecurity(ACS_DELETE_MESSAGE)
              stat:=deleteMSG(gfh)
              noDirF:=1
              JUMP goNextMsg
            ENDIF
          CASE "f"
            stat:=captureRealAndInternetNames(currentConf,currentMsgBase)
            IF stat=RESULT_SUCCESS
              stat:=forwardMSG(gfh)
              IF(stat<0) THEN RETURN stat
            ENDIF
            noDirF:=1
            JUMP nextMenu
          CASE "r"
            stat:=captureRealAndInternetNames(currentConf,currentMsgBase)
            IF stat=RESULT_SUCCESS
              stat:=replyToMSG(gfh)
              IF(stat<0) THEN RETURN stat
            ENDIF
            noDirF:=1
            JUMP goNextMsg
        ENDSELECT
      ENDIF
      IF(((str[0]="E") OR (str[0]="e")) AND (checkSecurity(ACS_MESSAGE_EDIT)))
        IF((str[1]="H") OR (str[1]="h"))

          IF((stat=editHeader(gfh))<0) THEN RETURN stat
        ELSEIF((str[1]="M") OR (str[1]="m"))
          fileattach:=FALSE
          StringF(str,'\s\d',msgBaseLocation,mailHeader.msgNumb)
          loadMsg(str)
          IF(edit()=RESULT_SUCCESS) THEN saveMsg(str)
        ELSE
          editEMessage(mailHeader.msgNumb)
        ENDIF
        stat:=displayMessage(gfh)
        IF(stat<0) THEN RETURN stat
        JUMP nextMenu
      ENDIF

      IF(((str[0]="U") OR (str[0]="u")) AND ((checkSecurity(ACS_ACCOUNT_EDITING))))
        StrCopy(str,mailHeader.fromName,31)
        uNum:=findUserFromName(1,confNameType,str,tempUser,tempUserKeys,tempUserMisc)
        IF uNum
          stat:=loadAccount(uNum,tempUser,tempUserKeys,tempUserMisc)
          IF(stat=RESULT_FAILURE)
            aePuts('Warning, error while loading account\b\n')
            JUMP nextMenu
          ENDIF
          sendCLS()
          callersLog('\tAccount editing from mail.')
          StrCopy(str,'\d',tempUser.slotNumber)
          IF runSysCommand('ACCOUNTS',str)<>RESULT_SUCCESS THEN editInfo(uNum,tempUser,tempUserKeys,tempUserMisc,FALSE)
          sendCLS()
          
          stat:=displayMessage(gfh)
          IF(stat<0) THEN RETURN stat
        ELSE
          aePuts('User no longer exists.\b\n')
        ENDIF
        JUMP nextMenu
      ENDIF
    ENDIF

    IF((str[0]="L") OR (str[0]="l"))
      stat:=listMSGs(gfh)
      IF(stat<0) THEN RETURN stat
      JUMP nextMenu
    ENDIF
    
    IF((str[0]="Q") OR (str[0]="q"))
      RETURN RESULT_SUCCESS
    ENDIF

    passItIN:
    IF(nonStopMail=FALSE)
      noDirF:=0
    ELSE
      noDirF:=1
      fwdFlag:=1
      fwdDir:="+"
    ENDIF
    IF(str[StrLen(str)-1]="+")
      IF(fwdFlag=(-1)) THEN msgNum:=msgNum+2
      noDirF:=1

      fwdToMsg:=mailStat.highMsgNum
      fwdFlag:=1
      fwdDir:="+"
      stat:=firstChar(str)
      IF((stat>=0) AND (str[stat]="+")) THEN JUMP goNextMsg
      str[StrLen(str)-1]:=" "
    ENDIF
    IF(str[StrLen(str)-1]="-")
      IF(fwdFlag=1)
        msgNum:=msgNum-1
        msgNum:=msgNum-tempFlag
      ENDIF
      noDirF:=1
      fwdToMsg:=mailStat.lowestKey
      fwdFlag:=-1
      fwdDir:="-"
      stat:=firstChar(str)
      IF((stat>=0) AND (str[stat]="-")) THEN JUMP goNextMsg
      str[StrLen(str)-1]:=" "
    ENDIF
    StrAdd(str,' ')

    stat:=firstChar(str)
    IF(stat>=0)
      IF(isDigit(str+stat))
        msgNum:=Val(str)

 goNextMsg:
        IF(doormsgcode=2)
          doormsgcode:=0
          RETURN RESULT_SUCCESS
        ENDIF

        IF(doormsgcode=1) THEN doormsgcode:=2

        IF((stat >=0) OR (str[stat]="+") OR (str[stat] = "-"))
          checkScreenClear()
        ENDIF

        stat:=readit(gfh)
        IF(stat<RESULT_FAILURE)
          RETURN RESULT_NO_CARRIER
        ENDIF
        IF(stat=10)
          RETURN 10
        ENDIF
        IF(stat=RESULT_FAILURE)
          aePuts('\b\n')
          IF(numOfZMsgs<>0) THEN RETURN RESULT_SUCCESS ELSE RETURN RESULT_FAILURE
        ENDIF
      ENDIF
    ENDIF
nextMenu:
    aePuts('\b\n')
  ENDLOOP
ENDPROC RESULT_SUCCESS

PROC noMorePlus()
  DEF str[100]: STRING

  IF(nonStopMail=FALSE)
    IF(noDirF=0)
      StringF(str,'\b\nThe last message in this conference is \d\b\n',mailStat.highMsgNum-1)
      aePuts(str)
    ENDIF
  ENDIF
  nonStopMail:=FALSE
ENDPROC

PROC noMoreMinus()
  DEF str[100]: STRING

  IF(nonStopMail=FALSE)
    IF(noDirF=0)
      StringF(str,'\b\nThe first message in this conference is \d\b\n',mailStat.lowestNotDel)
      aePuts(str)
    ENDIF
  ENDIF
  nonStopMail:=FALSE
ENDPROC

PROC readit(gfh)
  DEF stat
  tempFlag:=1

  REPEAT
    IF(msgNum>(mailStat.highMsgNum-1))
      noMorePlus()
      RETURN RESULT_FAILURE
    ENDIF
    IF(msgNum<mailStat.lowestKey)
      noMoreMinus()
      RETURN RESULT_FAILURE
    ENDIF

    stat:=loadMessageHeader(gfh)
    IF(stat=RESULT_FAILURE)
      aePuts('\b\nMSG Base Error!!!\b\n')
      RETURN RESULT_FAILURE
    ENDIF

    privateFlag:=0
    IF(((mailHeader.status="R") OR (mailHeader.status="p")) AND (Not(checkSecurity(ACS_SYSOP_READ))))
      IF((stringCompare(mailHeader.toName,confMailName)<>RESULT_SUCCESS) AND
        ((stringCompare(mailHeader.toName,'eall')<>RESULT_SUCCESS) OR (Not(checkSecurity(ACS_READ_PRIV_EALL)))) AND
        ((stringCompare(mailHeader.toName,'all')<>RESULT_SUCCESS) OR (Not(checkSecurity(ACS_READ_PRIV_ALL)))) AND
        (stringCompare(mailHeader.fromName,confMailName)<>RESULT_SUCCESS))
        privateFlag:=1
        IF(noDirF<>0) THEN JUMP nextMSG
        aePuts('\b\nThat message is Private.\b\n\b\n')
        nonStopMail:=FALSE
        RETURN RESULT_SUCCESS
      ENDIF
    ENDIF

    IF(mailHeader.status="D")
      privateFlag:=1
      IF(noDirF<>0) THEN JUMP nextMSG
      aePuts('\b\nThat message has been deleted.\b\n\b\n')
      nonStopMail:=FALSE
      msgNum:=msgNum+fwdFlag
      RETURN RESULT_SUCCESS
    ENDIF

    numOfZMsgs++
    stat:=displayMessage(gfh)
    IF(stat<0) THEN RETURN stat

    IF(msgNum>lastMsgReadConf) THEN lastMsgReadConf:=msgNum

    msgNum:=msgNum+fwdFlag
    RETURN RESULT_SUCCESS

nextMSG:
    IF(msgNum>lastMsgReadConf) THEN lastMsgReadConf:=msgNum
    msgNum:=msgNum+fwdFlag
  UNTIL((msgNum>mailStat.highMsgNum) OR (msgNum<mailStat.lowestKey))

  IF(msgNum>=mailStat.highMsgNum)  THEN noMorePlus() ELSE noMoreMinus()
ENDPROC RESULT_FAILURE

PROC loadMessageHeader(gfh)
  DEF headPoint,size,filePos,error,temp

  headPoint:=msgNum-mailStat.lowestKey
  size:=SIZEOF mailHeader
  filePos:=Mul(size,headPoint)
  temp:=filePos-currentSeekPos
  IF(temp)
    error:=Seek(gfh,temp,OFFSET_CURRENT)
    IF(error<0)
      myError(ERR_MSGBASE)
      RETURN RESULT_FAILURE
    ENDIF
  ENDIF

  error:=Read(gfh,mailHeader,size)
  currentSeekPos:=Seek(gfh,0,OFFSET_CURRENT)

  IF(error<>size)
    myError(ERR_MSGBASE)
    RETURN RESULT_FAILURE
  ENDIF

ENDPROC RESULT_SUCCESS

PROC saveMessageHeader(gfh,mh:PTR TO mailHeader)
DEF stat, error,size
  Seek(gfh,0,OFFSET_END)
  size:=SIZEOF mailHeader

  error:=Write(gfh,mh,size)
  Seek(gfh,currentSeekPos,OFFSET_BEGINNING)

  IF(error<>size) THEN RETURN RESULT_FAILURE

  mailStat.highMsgNum:=mailStat.highMsgNum+1
  IF(mailStat.highMsgNum=2) THEN mailStat.lowestNotDel:=1

  stat:=saveStatOnly()
  IF(stat=RESULT_FAILURE) THEN RETURN stat

ENDPROC RESULT_SUCCESS

PROC customMsgbaseCmd(msgcmd,confnum,passCmdLine)
  IF passCmdLine
    StrCopy(customMsgCmd,commandText)
  ELSE
    StrCopy(customMsgCmd,'')
  ENDIF

  customMsgParam1:=msgcmd
  customMsgParam2:=confnum

  runCommand(CMDTYPE_CUSTOM,'MSGBASE.DEF','',1)
ENDPROC

PROC callMsgFuncs(msgfunc, conf, msgBaseNum)
  DEF stat, gfh
  DEF filename[255]:STRING

  fileattach:=TRUE
  StringF(filename,'\s\s',msgBaseLocation,'HeaderFile')

  gfh:=Open(filename,MODE_READWRITE)
  IF(gfh=0)
    gfh:=Open(filename,MODE_NEWFILE)
    IF(gfh=0)
      myError(ERR_MSGBASE)
      fileattach:=FALSE
      RETURN RESULT_FAILURE
    ENDIF
  ENDIF
  currentSeekPos:=0
  stat:=RESULT_FAILURE
  mciViewSafe:=FALSE
 
  SELECT confNameType
    CASE NAME_TYPE_USERNAME
      StrCopy(confMailName,loggedOnUserKeys.userName,31)
    CASE NAME_TYPE_REALNAME
      StrCopy(confMailName,loggedOnUserMisc.realName,26)
    CASE NAME_TYPE_INTERNETNAME
      StrCopy(confMailName,loggedOnUserMisc.internetName,10)
  ENDSELECT
  SELECT msgfunc
    CASE MAIL_READ
         stat:=readMSG(gfh)
    CASE MAIL_CREATE
                       stat:=captureRealAndInternetNames(conf,msgBaseNum)
         IF stat=RESULT_SUCCESS
           stat:=enterMSG(gfh)
         ENDIF
    CASE MAIL_SCAN
         newmailsearch:= TRUE
         stat:=searchNewMail(gfh,conf, msgBaseNum)
         newmailsearch:=FALSE
  ENDSELECT

  Close(gfh)
  fileattach:=FALSE
  mciViewSafe:=TRUE
ENDPROC stat

PROC showFlags()
  IF(flagFilesList.count()=0)
    aePuts('No file flags\b\n')
  ELSE
    showFlaggedFiles(-1)
    aePuts('\b\n')
  ENDIF
ENDPROC

PROC isInFlaggedList(s,confNum)
  DEF i
  DEF item:PTR TO flagFileItem
  DEF patternBuf[100]:STRING

  FOR i:=0 TO flagFilesList.count()-1
    item:=flagFilesList.item(i)
    IF ((item.confNum=confNum) OR (item.confNum=-1))
      IF (parsePatternNoCase2(item.fileName, patternBuf, 100))>=0
        IF MatchPatternNoCase(patternBuf,s) THEN RETURN TRUE
      ENDIF
    ENDIF
  ENDFOR
  
ENDPROC FALSE

PROC isInList(list:PTR TO stdlist,s,confNum)
  DEF i
  DEF item:PTR TO flagFileItem
  DEF fn

  fn:=FilePart(s)
  FOR i:=0 TO list.count()-1
    item:=list.item(i)
    IF ((item.confNum=confNum) OR (item.confNum=-1)) AND (StriCmp(fn,FilePart(item.fileName))) THEN RETURN TRUE
  ENDFOR
ENDPROC FALSE

PROC addFlagToList(s:PTR TO CHAR, confNum = -1)
  DEF stat
  DEF fileName

  fileName:=String(StrLen(s))
  fullTrim(s,fileName)

  IF confNum=-1 THEN confNum:=currentConf

  IF(StrLen(fileName)>1)
    UpperStr(fileName)
    stat:=isInFlaggedList(fileName,confNum)
    IF(stat=FALSE)
      addFlagItem(flagFilesList,confNum,fileName)
      DisposeLink(fileName)
      RETURN 2
    ENDIF
  ENDIF
  DisposeLink(fileName)
ENDPROC 0

PROC removeFlagFromList(s: PTR TO CHAR, c=-1)
  DEF templist:PTR TO stdlist
  DEF item:PTR TO flagFileItem
  DEF i

  templist:=NEW templist.stdlist(flagFilesList.maxSize())
  FOR i:=0 TO flagFilesList.count()-1
    item:=flagFilesList.item(i)
    IF (StriCmp(item.fileName,s)) AND ((c=item.confNum) OR (c=-1))
      DisposeLink(item.fileName)
      END item
    ELSE
      templist.add(item)
    ENDIF
  ENDFOR
  END flagFilesList
  flagFilesList:=templist
ENDPROC

PROC flagFrom(s: PTR TO CHAR)
  DEF stat, flag,fp,i
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  flag:=1
  StringF(tempStr,'\sdir\d',currentConfDir,maxDirs)
  IF(fp:=Open(tempStr,MODE_OLDFILE))<>0
    WHILE(((ReadStr(fp,tempStr)<>-1) OR (StrLen(tempStr)>0)) AND (stat<>1))
      IF(dirLineNewFile(tempStr))
        i:=0
        WHILE((i<StrLen(tempStr)) AND (tempStr[i]<>" "))
          tempStr2[i]:=tempStr[i]
          i++
        ENDWHILE
        IF(i=0) THEN JUMP flagcont
        SetStr(tempStr2,i)
        IF(flag=FALSE) THEN stat:=addFlagToList(tempStr2)
        IF(flag AND StriCmp(tempStr2,s))
          flag:=0
          stat:=addFlagToList(tempStr2)
        ENDIF
      ENDIF
flagcont:
    ENDWHILE
    IF(flag) THEN aePuts('Sorry filename not found!\b\n')
    Close(fp)
  ELSE
    RETURN RESULT_FAILURE
  ENDIF
ENDPROC RESULT_SUCCESS

PROC flagFiles(s: PTR TO CHAR)
  DEF stat
  DEF tempStr[190]:STRING

  IF(s=NIL) THEN showFlags()
backloop:
  IF(s=NIL)
    aePuts('[36mFilename(s) to flag: [32m([33mF[32m)[36mrom, [32m([33mC[32m)[36mlear, [32m([33mEnter[32m)[36m=none[0m? ')
    stat:=lineInput('','',190,INPUT_TIMEOUT,tempStr)
    IF(stat<0) THEN RETURN stat
  ELSE
    StrCopy(tempStr,s)
  ENDIF

  IF(StrLen(tempStr)>0)
    IF(((tempStr[0]="C") OR (tempStr[0]="c")) AND ((StrLen(tempStr)=1) OR (tempStr[1]=" ")))
      IF(tempStr[1]=" ")
        StrCopy(tempStr,tempStr+2)
      ELSE
        IF(s<>NIL) THEN showFlags()
        aePuts('[36mFilename(s) to Clear: [32m([33m*[32m)[36mAll, [32m([33mEnter[32m)[36m=none[0m? ')
        stat:=lineInput('','',190,INPUT_TIMEOUT,tempStr)
        IF(stat<0) THEN RETURN stat

        IF(StrLen(tempStr)=0) THEN RETURN RESULT_SUCCESS
        aePuts('\b\n')
      ENDIF
      UpperStr(tempStr)
      IF(tempStr[0]="*") THEN clearFlagItems(flagFilesList) ELSE removeFlagFromList(tempStr)
      RETURN 1
    ELSE
      IF(((tempStr[0]="F") OR (tempStr[0]="f")) AND ((StrLen(tempStr)=1) OR (tempStr[1]=" ")))
        IF(tempStr[1]<>" ")
          aePuts('[36mFilename to start flagging from: [0m')
              stat:=lineInput('','',190,INPUT_TIMEOUT,tempStr)
              IF (stat<0) THEN RETURN stat
          IF(StrLen(tempStr)=0) THEN RETURN RESULT_SUCCESS
        ELSE
          StrCopy(tempStr,tempStr+2)
        ENDIF

        flagFrom(tempStr)
        RETURN 1
      ELSE
        stat:=addFlagToList(tempStr)
        IF(stat=1)
          IF (s=NIL ) THEN JUMP backloop ELSE RETURN RESULT_FAILURE
        ENDIF
        IF(stat=2) THEN RETURN RESULT_FAILURE
      ENDIF
    ENDIF
  ENDIF
ENDPROC RESULT_SUCCESS

PROC alterFlags(params)
  DEF stat

  aePuts('\b\n')
  IF(StrLen(params)>0)
    stat:=flagFiles(params)
    IF(stat<0) THEN RETURN
    WHILE(stat)
      stat:=flagFiles(NIL)
    ENDWHILE
  ELSE
    REPEAT
      stat:=flagFiles(NIL)
      IF(stat<0) THEN RETURN
    UNTIL stat=0
  ENDIF
  aePuts('\b\n')
ENDPROC

PROC checkFlagged()
  DEF stat
  IF(flagFilesList.count())
    aePuts('\b\nYou have flagged files still not downloaded.\b\nDo you leave without them? ')
    stat:=yesNo(2)
    RETURN stat
  ENDIF
ENDPROC 1

PROC exceedRatio()
  aePuts('You have exceeded your ratio, you must upload first.\b\n\b\n')
ENDPROC

PROC displayULStats(u: PTR TO user, um:PTR TO userMisc)
  DEF string[200]:STRING
  DEF ktot[20]:STRING
  DEF totBCD[8]:ARRAY OF CHAR

  CopyMem(um.downloadBytesBCD,totBCD,8)
  IF sopt.toggles[TOGGLES_CREDITBYKB]=FALSE
    divBCD1024(totBCD)
  ENDIF
  formatBCD(totBCD,ktot)

  StringF(string,'Number of Downloads      : \d (\sk total)\b\n',u.downloads AND $FFFF,ktot)
  aePuts(string)

  CopyMem(um.uploadBytesBCD,totBCD,8)
  IF sopt.toggles[TOGGLES_CREDITBYKB]=FALSE
    divBCD1024(totBCD)
  ENDIF
  formatBCD(totBCD,ktot)
  StringF(string,'Number of Uploads        : \d (\sk total)\b\n',u.uploads AND $FFFF,ktot)
  aePuts(string)
  IF sopt.toggles[TOGGLES_CREDITBYKB]
    IF bytesADL=$7fffffff
      StrCopy(string,'Todays KBytes Available  : Infinite\b\n')
    ELSE
      StringF(string,'Todays KBytes Available  : \d\b\n',bytesADL)
    ENDIF
  ELSE
    IF bytesADL=$7fffffff
      StrCopy(string,'Todays Bytes Available   : Infinite\b\n')
    ELSE
      StringF(string,'Todays Bytes Available   : \d\b\n',bytesADL)
    ENDIF
  ENDIF
  aePuts(string)
ENDPROC

PROC checkFIBForFileSize(fullPath:PTR TO CHAR, checkConfNum, fBlock:PTR TO fileinfoblock,tfsizeList:PTR TO stdlist,freeDFlagList:PTR TO stdlist, cfn:PTR TO stdlist,z)
  DEF tsec,min,secs
  DEF estDlCPS
  DEF str[255]:STRING
  DEF clog[200]:STRING
  DEF flagFile:PTR TO flagFileItem
  DEF dp, p

  IF loggedOnUserMisc.lastDlCPS<>0
    estDlCPS:=loggedOnUserMisc.lastDlCPS
  ELSE
    estDlCPS:=Div(onlineBaud,10)
  ENDIF

  fsize:=fBlock.size
  tsec:=Div(fsize,estDlCPS)
  min:=tsec/60
  secs:=tsec-(min*60)
  IF ftpConn=FALSE
    StringF(str,' \r\dk, \d mins \z\r\d[2] secs \s\t',Shr(fsize,10) AND $003fffff,min,secs,fBlock.filename)
    ->IF(str[16]=" ") THEN SetStr(str,16)
    aePuts(str)
  ENDIF
  IF((fBlock.comment[0]="F") OR (freeDownloads))
    IF ftpConn=FALSE THEN aePuts('  >>Free Download!\b\n')
    IF tfsizeList<>NIL THEN tfsizeList.setItem(checkConfNum-1,tfsizeList.item(checkConfNum-1)-fsize)
  ELSE
    IF freeDFlagList<>NIL THEN freeDFlagList.setItem(checkConfNum-1,freeDFlagList.item(checkConfNum-1)+1)
    IF ftpConn=FALSE THEN aePuts('\b\n')
  ENDIF
  IF((z<>1) OR sysopdl)
    IF(StriCmp(fBlock.comment,'Restricted',10))
     IF ftpConn=FALSE THEN aePuts('    >>Restricted File<< Updating CallersLog\b\n')
     StringF(clog,'\t\tAttempt to download RESTRICTED file [\s]',fullPath)
     callersLog(clog)
     RETURN -1
    ENDIF

    IF((dp:=isInList(cfn,fullPath,checkConfNum)))=FALSE
      numFiles++
      flagFile:=NEW flagFile
      flagFile.confNum:=checkConfNum
      flagFile.fileName:=String(StrLen(fullPath))
      fullTrim(fullPath,flagFile.fileName)
      cfn.add(flagFile)
      IF sysopdl=FALSE
        IF((p:=isInFlaggedList(fBlock.filename,checkConfNum)))=FALSE
          addFlagToList(fBlock.filename,checkConfNum)
        ENDIF
      ENDIF
    ELSE
      IF ftpConn=FALSE THEN aePuts('   File is already selected!\b\n')
    ENDIF
  ENDIF

  IF(dp=NIL)
    IF tfsizeList<>NIL THEN tfsizeList.setItem(checkConfNum-1,tfsizeList.item(checkConfNum-1)+fsize)
    addBCD(dtfsize,fsize)
  ENDIF
ENDPROC dp

PROC checkForFileSize(checkFilename:PTR TO CHAR, subDirs:PTR TO CHAR, checkConfNum, tfsizeList:PTR TO stdlist, freeDFlagList:PTR TO stdlist, cfn:PTR TO stdlist, z)

  DEF stat,pstat=1,i
  DEF fflag=0,wflag=0,doflag=0
  DEF path[255]:STRING,str[255]:STRING,tempstr[100]:STRING,tempstr2[100]:STRING
  DEF fname1[255]:STRING,fname2[255]:STRING
  DEF final[255]:STRING
  DEF ft=0,dp

  DEF fBlock: PTR TO fileinfoblock
  DEF fLock=0,fLock2,res
  DEF drivenum
  DEF ramDir[255]:STRING
  DEF patternBuf,patBufLen
  DEF debugcount,xit

  IF checkConfNum=-1 THEN checkConfNum:=currentConf

  FOR i:=0 TO StrLen(checkFilename)-1
    IF((checkFilename[i]="?") OR (checkFilename[i]="*")) THEN wflag:=1
  ENDFOR
  StrCopy(tempstr2,checkFilename)
  UpperStr(tempstr2)

  fname1:=FilePart(tempstr2)
  fname2:=FilePart(userDataFile)
  IF StrLen(fname1)=StrLen(fname2)
    IF StriCmp(fname1,fname2)
      StringF(tempstr,'   File (\s) not found.\b\n',fname1)
      IF (ftpConn=FALSE) THEN aePuts(tempstr)
      RETURN RESULT_NOT_FOUND
    ENDIF
  ENDIF

  fname2:=FilePart(userKeysFile)
  IF StrLen(fname1)=StrLen(fname2)
    IF StriCmp(fname1,fname2)
      StringF(tempstr,'   File (\s) not found.\b\n',fname1)
      IF ftpConn=FALSE THEN aePuts(tempstr)
      RETURN RESULT_NOT_FOUND
    ENDIF
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)) = NIL)
    myError(1)  ->// MemError()
    RETURN RESULT_FAILURE
  ENDIF
  IF(z=1) THEN JUMP jumpIn

  patBufLen:=StrLen(tempstr2)*3+2
  patternBuf:=New(patBufLen)
  IF patternBuf=0
    myError(1)  ->// MemError()
    RETURN RESULT_FAILURE
  ENDIF
  
  IF (parsePatternNoCase2(tempstr2, patternBuf, patBufLen))=-1
    Dispose(patternBuf)
    myError(1)  ->// MemError()
    RETURN RESULT_FAILURE
  ENDIF

  IF(sysopdl)
    z:=1
    wflag:=0
    JUMP jumpIn
  ENDIF

  drivenum:=1
  StringF(tempstr,'DLPATH.\d',drivenum++)
  REPEAT
c1:
    IF(z=0)

      IF readToolType(TOOLTYPE_CONF,checkConfNum,tempstr,path)
        checkPathSlash(path)
        pstat:=1 /* shouldnt this be 251 ?*/
      ELSE
        pstat:=0
      ENDIF
    ENDIF
    StrCopy(final,path)
    IF(StrLen(path)=0) THEN JUMP c1
    IF (pstat=0) THEN JUMP outst

jumpIn:
    IF(wflag=0)
      IF(sysopdl=0)
        StrCopy(final,path)
        StrAdd(final,subDirs)
        checkPathSlash(final)
        StrAdd(final,checkFilename)
      ELSE
        StrCopy(final,checkFilename)
        IF(findAssign(final)) THEN JUMP outst
      ENDIF
      StringF(ramDir,'RAM:DirCaches/Conf\dDir\d',checkConfNum,drivenum-1)
      IF (StrLen(subDirs)=0) AND (fileExists(ramDir))
        ft:=Open(ramDir,MODE_OLDFILE)
        IF ft<>0
          fLock:=NIL
          WHILE(Fgets(ft,ramDir,255)<>NIL) AND (fLock=0)
            IF ramDir[StrLen(ramDir)-1]=10 THEN SetStr(ramDir,StrLen(ramDir)-1)
            IF MatchPatternNoCase(patternBuf,ramDir) THEN fLock:=Lock(final,ACCESS_READ)
          ENDWHILE
        Close(ft)
        ft:=0
        ELSE
          fLock:=Lock(final,ACCESS_READ)
        ENDIF
      ELSE
        fLock:=Lock(final,ACCESS_READ)
      ENDIF
      
      IF(fLock<>0)
        doflag:=1
      ELSE
        IF(sysopdl) THEN JUMP outst
      ENDIF
    ELSE
      doflag:=1
    ENDIF

    IF(doflag)
      IF fLock=NIL
        StringF(ramDir,'RAM:DirCaches/Conf\dDir\d',checkConfNum,drivenum-1)
        IF (StrLen(subDirs)=0) AND (fileExists(ramDir))
          ft:=Open(ramDir,MODE_OLDFILE)
        ENDIF
        IF((fLock:=Lock(final,ACCESS_READ))=0)
          FreeDosObject(DOS_FIB,fBlock)
          StringF(str,'Error, Path \s missing, adjust paths file..',path)
          IF ftpConn=FALSE
            aePuts(str)
            aePuts('\b\n\b\n')
          ENDIF
          callersLog(str)
          RETURN RESULT_FAILURE
        ENDIF
      ENDIF
      IF((Examine(fLock,fBlock))=NIL)
        FreeDosObject(DOS_FIB,fBlock)
        myError(1)
        UnLock(fLock)
        RETURN RESULT_FAILURE
      ENDIF

      IF(wflag=0) THEN JUMP gotit
debugcount:=0
      WHILE TRUE
        IF(ft=0)
          xit:=ExNext(fLock,fBlock)=0
        ELSE
          xit:=(Fgets(ft,tempstr,255)=0)
          IF (StrLen(tempstr)>18) AND (tempstr[8]=" ") AND (tempstr[17]=" ") THEN StrCopy(tempstr,tempstr+18)
        ENDIF
        EXIT xit

        debugcount++
        IF ft ORELSE (fBlock.direntrytype<0)
gotit:
          IF ft
            IF tempstr[StrLen(tempstr)-1]=10 THEN SetStr(tempstr,StrLen(tempstr)-1)
          ELSE
            StrCopy(tempstr,fBlock.filename)
          ENDIF
          UpperStr(tempstr)
          stat:=MatchPatternNoCase(patternBuf,tempstr)
          res:=TRUE
          IF((stat<>0) OR sysopdl)
            fflag:=1
            IF(sysopdl)
              StrCopy(final,checkFilename)
            ELSE
            
              StrCopy(final,path)
              StrAdd(final,subDirs)
              checkPathSlash(final)
            
              IF ft<>0
                StrAdd(final,tempstr)
                fLock2:=Lock(final,ACCESS_READ)
                IF fLock2
                  Examine(fLock2,fBlock)
                  UnLock(fLock2)
                ELSE
                  res:=FALSE
                ENDIF
              ELSE
                StrAdd(final,fBlock.filename)
              ENDIF
            ENDIF

            IF res
              IF (dp:=checkFIBForFileSize(final, checkConfNum, fBlock,tfsizeList,freeDFlagList,cfn, z))=-1
                FreeDosObject(DOS_FIB,fBlock)
                UnLock(fLock)
                IF ft<>0 THEN Close(ft)
                RETURN 11
              ENDIF
            ENDIF

            
            IF(wflag=0)
              FreeDosObject(DOS_FIB,fBlock)
              UnLock(fLock)
              IF ft<>0 THEN Close(ft)
              IF(dp<>NIL) THEN RETURN RESULT_FAILURE ELSE RETURN RESULT_SUCCESS
            ENDIF
          ENDIF
        ENDIF

        IF ftpConn=FALSE
          IF(sCheckInput())
            stat:=readChar(1)
            IF(stat<0)
              FreeDosObject(DOS_FIB,fBlock)
              UnLock(fLock)
              IF ft<>0 THEN Close(ft)
              RETURN RESULT_NO_CARRIER
            ENDIF
            SELECT stat
              CASE 23 /* Pause */
                stat:=readChar(INPUT_TIMEOUT)
                IF(stat<0)
                  FreeDosObject(DOS_FIB,fBlock)
                  UnLock(fLock)
                  IF ft<>0 THEN Close(ft)
                  RETURN RESULT_NO_CARRIER
                ENDIF
              CASE 3 /* ^C */
                aePuts('**Break\b\n')
                FreeDosObject(DOS_FIB,fBlock)
                UnLock(fLock)
                IF ft<>0 THEN Close(ft)
                RETURN 10
            ENDSELECT
          ENDIF
        ENDIF
      ENDWHILE
      UnLock(fLock)
      IF ft<>0 THEN Close(ft)
      ft:=0
      fLock:=0
      IF(z=1) THEN JUMP outst
    ENDIF
    StringF(tempstr,'DLPATH.\d',drivenum++)

  UNTIL pstat=0

outst:

  FreeDosObject(DOS_FIB,fBlock)

  Dispose(patternBuf)

  IF(fflag=0)
    IF ftpConn=FALSE
      StringF(str,'       File (\s) not found.\b\n',checkFilename)
      aePuts(str)
    ENDIF
    RETURN RESULT_NOT_FOUND
  ENDIF

  IF(dp<>NIL) THEN RETURN RESULT_FAILURE

ENDPROC RESULT_SUCCESS

PROC statCursorTo(x,y)
  DEF statbuf[20]:STRING
  IF (dStatBar AND(statWriteIO<>NIL))
    StringF(statbuf,'[\d;\dH',y,x)
    statWriteIO.data:=statbuf
    statWriteIO.length:=-1
    statWriteIO.command:=CMD_WRITE
    DoIO(statWriteIO)
  ENDIF
ENDPROC


PROC statPrint(s: PTR TO CHAR)
  DEF str[255]:STRING

  IF(dStatBar AND (statWriteIO<>NIL))
    IF(bitPlanes<3)
      StrCopy(str,s)
      stripAnsi2(str)
      statWriteIO.data:=str
      statWriteIO.length:=-1
      statWriteIO.command:=CMD_WRITE
      DoIO(statWriteIO)
      RETURN
    ENDIF
    statWriteIO.data:=s
    statWriteIO.length:=-1
    statWriteIO.command:=CMD_WRITE
    DoIO(statWriteIO)
  ENDIF
ENDPROC


PROC statParkCursor()
  statCursorTo(1,3)
  statPrint('[0 p')
ENDPROC

PROC statClearTime()
  statMessage(1,3,'                               ')
ENDPROC

PROC statMessage(x,y,s: PTR TO CHAR)
  statCursorTo(x,y)
  statPrint(s)
  statParkCursor()
ENDPROC

PROC createServerRP()
  serverRP:=createPort(0,0)
  masterMsg.node:=node
  masterMsg.command:=JH_UPDATE
  masterMsg.msg.ln.type:=NT_MESSAGE
  masterMsg.msg.length:=SIZEOF acpMessage
  masterMsg.msg.replyport:=serverRP
ENDPROC regServer()

PROC regServer()
  DEF port:PTR TO mp

  masterMsg.command:=SV_START
  WHILE((port:=FindPort('AE.Master'))=NIL) AND (SetSignal(0,SIGBREAKF_CTRL_C)=0)
    Delay(25)
  ENDWHILE

  IF port=NIL THEN RETURN RESULT_FAILURE

  PutMsg(port,masterMsg)
  WaitPort(serverRP)
  GetMsg(serverRP)
  StrCopy(mybbsLoc,masterMsg.user)

  cmds:=masterMsg.myCmds
  sopt:=masterMsg.sopt
  masterMsg.command:=JH_UPDATE
ENDPROC RESULT_SUCCESS

PROC deleteServerRP()
  deletePort(serverRP)
  serverRP:=NIL
ENDPROC

PROC createResControl()
  StringF(resPortName,'AEServer.\d',node)
  resmp:=createPort(resPortName,0)
ENDPROC

PROC deleteResControl()
  IF(resmp) THEN deletePort(resmp)
  resmp:=0
ENDPROC

PROC createRexxPort()
  DEF sig
  StringF(rexxPortName,'AmiExpress_Node.\d',node)

  Forbid()
  IF FindPort(rexxPortName)=FALSE
    rexxmp:= NEW rexxmp
    rexxmp.sigtask:=FindTask(0)
    rexxmp.flags:=PA_SIGNAL
    rexxmp::ln.name:=rexxPortName
    rexxmp::ln.type:=NT_MSGPORT
    IF (sig:=AllocSignal(-1))
      rexxmp.sigbit:=sig
      AddPort(rexxmp)
    ENDIF
  ENDIF
  Permit()
ENDPROC

PROC deleteRexxPort()
  IF rexxmp
    FreeSignal(rexxmp.sigbit)
    RemPort(rexxmp)
    Dispose(rexxmp)
  ENDIF
  rexxmp:=NIL
ENDPROC

PROC rxGetMsg(port)
  DEF mes:PTR TO rexxmsg
  IF mes:=GetMsg(port)
    rexxsysbase:=mes.libbase
    RETURN mes,Long(mes.args)
  ENDIF
ENDPROC NIL,NIL

PROC rxReplyMsg(mes:PTR TO rexxmsg,rc=0,resultstring=NIL)
  mes.result1:=rc
  mes.result2:=NIL
  IF (mes.action AND RXFF_RESULT) AND (rc=0) AND (resultstring<>NIL)
    mes.result2:=CreateArgstring(resultstring,StrLen(resultstring))
  ENDIF
  ReplyMsg(mes)
ENDPROC


PROC setEnvStat(statCode)
  DEF environ[200]:STRING
  DEF status[200]:STRING
  DEF baudtext[10]:STRING

  IF bgChecking THEN RETURN 1

  currentStat:=statCode
  IF sopt<>NIL
    IF (sopt.toggles[TOGGLES_MULTICOM]<>0)
      IF (singleNode<>0)
        ObtainSemaphore(singleNode)

        getBaudText(baudtext)

        IF loggedOnUser<>NIL
          AstrCopy(singleNode.handle,loggedOnUser.name)
          AstrCopy(singleNode.location,loggedOnUser.location)
        ELSE
          AstrCopy(singleNode.handle,'')
          AstrCopy(singleNode.location,'')
        ENDIF
        AstrCopy(singleNode.baud,baudtext,10)

        AstrCopy(singleNode.misc1,'')
        AstrCopy(singleNode.misc2,'')

        currentStat:=statCode
        IF(quietFlag) THEN singleNode.status:=0-(statCode+2) ELSE singleNode.status:=currentStat
        singleNode.misc2[0]:=IF blockOLM THEN 1 ELSE 0
        ReleaseSemaphore(singleNode)
      ENDIF
    ENDIF
  ENDIF

  StringF(environ,'STATS@\d',node)
  IF loggedOnUser<>NIL
    StringF(status,'\l\s[35]-\d[2]',loggedOnUser.name,statCode)
  ELSE
    StringF(status,'\l\s[35]-\d[2]','',statCode)
  ENDIF
  SetVar(environ,status,-1,LV_VAR OR GVF_GLOBAL_ONLY)

  sendMaster()

  runExecuteOn('STATUS_CHANGE')

ENDPROC 1

PROC setEnvMsg(s: PTR TO CHAR)
  DEF temp[10]:STRING
  DEF debugstr[255]:STRING
  DEF port: PTR TO mp

  IF (serverRP=NIL) OR (bgChecking) THEN RETURN
  StringF(debugstr,'setenvmsg: \s',s)
  debugLog(LOG_DEBUG,debugstr)
  AstrCopy(masterMsg.user,s)
  StringF(temp,'\d',SV_NEWMSG)

  IF(sopt.toggles[TOGGLES_MULTICOM])
    ObtainSemaphore(singleNode)
    AstrCopy(singleNode.misc1,s)
    ReleaseSemaphore(singleNode)
    runExecuteOn('STATUS_CHANGE')
  ENDIF
  AstrCopy(masterMsg.action,temp)

  getBaudText(temp)

  IF(sopt.toggles[TOGGLES_MULTICOM])
    ObtainSemaphore(singleNode)
    AstrCopy(singleNode.baud,temp,10)
    ReleaseSemaphore(singleNode)
  ENDIF
  AstrCopy(masterMsg.baud,temp)

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
    GetMsg(serverRP)
  ENDIF
ENDPROC

PROC getBaudText(baudText:PTR TO CHAR)
  IF loggedOnUser<>NIL
    IF (telnetSocket<>-1)
      IF ftpConn
        StrCopy(baudText,'FTP   ')
      ELSE
        StrCopy(baudText,'TELNET')
      ENDIF
      
    ELSE
      IF (StrLen(cmds.serDev)=0)
        StrCopy(baudText,'LOCAL')
      ELSE
        StringF(baudText,'\r\d[7]',onlineBaud)
      ENDIF
    ENDIF
  ELSE
    IF (StrLen(cmds.serDev)=0)
      IF nativeTelnet AND nativeFtp
        StrCopy(baudText,'FTP/TEL')
      ELSEIF nativeTelnet
        StrCopy(baudText,'TELNET')
      ELSEIF nativeFtp
        StrCopy(baudText,'FTP   ')
      ELSE
        StrCopy(baudText,'LOCAL')
      ENDIF
    ELSE
      StringF(baudText,'\r\d[7]',cmds.openingBaud)
    ENDIF
  ENDIF
ENDPROC

PROC acpLockNodes()
  DEF port: PTR TO mp
  masterMsg.command:=SV_NODE_LOCK
  masterMsg.data:=node
  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
    GetMsg(serverRP)
  ENDIF
  masterMsg.command:=JH_UPDATE
ENDPROC masterMsg.data


PROC sendACPCommand(string:PTR TO CHAR,command,node)
  DEF port: PTR TO mp
  AstrCopy(masterMsg.user,string)
  AstrCopy(masterMsg.location,'')
  AstrCopy(masterMsg.action,'')
  masterMsg.command:=JH_AUTOCOMMAND
  masterMsg.node:=node
  masterMsg.data:=command

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
    GetMsg(serverRP)
  ENDIF
  masterMsg.node:=node
  masterMsg.command:=JH_UPDATE
ENDPROC

PROC sendACPCommand2(string:PTR TO CHAR,command,destNode=-1)
  DEF port: PTR TO mp
  DEF acpMsg:acpMessage
  DEF acpReplyPort:PTR TO mp

  acpReplyPort:=createPort(0,0)

  acpMsg.node:=node
  acpMsg.msg.ln.type:=NT_MESSAGE
  acpMsg.msg.length:=SIZEOF acpMessage
  acpMsg.msg.replyport:=acpReplyPort

  AstrCopy(acpMsg.user,string)
  AstrCopy(acpMsg.location,'')
  AstrCopy(acpMsg.action,'')
  acpMsg.command:=command
  IF destNode=-1
    acpMsg.node:=node
  ELSE
    acpMsg.node:=destNode
  ENDIF
  acpMsg.data:=command

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,acpMsg)
    WaitPort(acpReplyPort)
    GetMsg(acpReplyPort)
  ENDIF
  deletePort(acpReplyPort)

  ->masterMsg.node:=node
  ->masterMsg.command:=JH_UPDATE
ENDPROC

PROC sendMaster()
  DEF temp[10]:STRING
  DEF port:PTR TO mp
  DEF masterMsg2:acpMessage
  DEF masterReplyPort:PTR TO mp

  masterReplyPort:=createPort(0,0)

  masterMsg2.node:=node
  masterMsg2.msg.ln.type:=NT_MESSAGE
  masterMsg2.msg.length:=SIZEOF acpMessage
  masterMsg2.msg.replyport:=masterReplyPort
  masterMsg2.command:=JH_UPDATE

  IF loggedOnUser<>NIL
    AstrCopy(masterMsg2.user,loggedOnUser.name)
    AstrCopy(masterMsg2.location,loggedOnUser.location)
    IF (telnetSocket<>-1)
      IF ftpConn
        StrCopy(temp,'FTP')
      ELSE
        StrCopy(temp,'TELNET')
      ENDIF
    ELSE
      IF (StrLen(cmds.serDev)=0)
        StrCopy(temp,'LOCAL')
      ELSE
        StringF(temp,'\r\d[7]',onlineBaud)
      ENDIF
    ENDIF
  ELSE
    AstrCopy(masterMsg2.user,'')
    AstrCopy(masterMsg2.location,'')
    IF (StrLen(cmds.serDev)=0)
      IF nativeTelnet AND nativeFtp
        StrCopy(temp,'FTP/TEL')
      ELSEIF nativeTelnet
        StrCopy(temp,'TELNET')
      ELSEIF nativeFtp
        StrCopy(temp,'FTP')
      ELSE
        StrCopy(temp,'LOCAL')
      ENDIF
    ELSE
      StringF(temp,'\r\d[7]',cmds.openingBaud)
    ENDIF
  ENDIF
  AstrCopy(masterMsg2.baud,temp)

  StringF(temp,'\d',currentStat)
  AstrCopy(masterMsg2.action,temp)
  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg2)
    WaitPort(masterReplyPort)
    GetMsg(masterReplyPort)
  ENDIF
  deletePort(masterReplyPort)
ENDPROC


PROC sendMasterUpload(filename:PTR TO CHAR)

  DEF temp[10]:STRING
  DEF temp1[43]:STRING
  DEF port:PTR TO mp
  DEF ulMsg:acpMessage
  DEF ulReplyPort:PTR TO mp

  ulReplyPort:=createPort(0,0)

  ulMsg.node:=node
  ulMsg.msg.ln.type:=NT_MESSAGE
  ulMsg.msg.length:=SIZEOF acpMessage
  ulMsg.msg.replyport:=ulReplyPort

  StringF(temp1,'\r\d[7]',onlineBaud)
  AstrCopy(ulMsg.baud,temp1)

  StringF(temp1,'\l\s[16]',FilePart(filename))
  AstrCopy(ulMsg.user,temp1)
  IF loggedOnUser<>NIL
    AstrCopy(ulMsg.location,loggedOnUser.location)
  ELSE
    AstrCopy(ulMsg.location,'')
  ENDIF

  StringF(temp,'\d',currentStat)
  AstrCopy(ulMsg.action,temp)
  ulMsg.command:=JH_UPLOAD

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,ulMsg)
    WaitPort(ulReplyPort)
    GetMsg(ulReplyPort)
  ENDIF
  deletePort(ulReplyPort)

  IF(sopt.toggles[TOGGLES_MULTICOM])
    ObtainSemaphore(singleNode)
    AstrCopy(singleNode.misc1,FilePart(filename))
    AstrCopy(singleNode.misc2,'')
    singleNode.misc2[0]:=IF blockOLM THEN 1 ELSE 0
    ReleaseSemaphore(singleNode);
    runExecuteOn('STATUS_CHANGE')
  ENDIF
ENDPROC

PROC sendMasterDownload(filename: PTR TO CHAR)
  DEF temp[10]:STRING
  DEF temp1[43]:STRING
  DEF port:PTR TO mp
  DEF dlMsg:acpMessage
  DEF dlReplyPort:PTR TO mp

  dlReplyPort:=createPort(0,0)

  dlMsg.node:=node
  dlMsg.msg.ln.type:=NT_MESSAGE
  dlMsg.msg.length:=SIZEOF acpMessage
  dlMsg.msg.replyport:=dlReplyPort

  StringF(temp1,'\r\d[7]',onlineBaud)
  AstrCopy(dlMsg.baud,temp1)

  StringF(temp1,'\l\s[16]',FilePart(filename))
  AstrCopy(dlMsg.user,temp1)
  IF loggedOnUser<>NIL
    AstrCopy(dlMsg.location,loggedOnUser.location)
  ELSE
    AstrCopy(dlMsg.location,'')
  ENDIF

  StringF(temp,'\d',currentStat)
  AstrCopy(dlMsg.action,temp)
  dlMsg.command:=JH_DOWNLOAD

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,dlMsg)
    WaitPort(dlReplyPort)
    GetMsg(dlReplyPort)
  ENDIF
  deletePort(dlReplyPort)

  IF(sopt.toggles[TOGGLES_MULTICOM])
    ObtainSemaphore(singleNode)
    AstrCopy(singleNode.misc1,FilePart(filename))
    AstrCopy(singleNode.misc2,'')
    singleNode.misc2[0]:=IF blockOLM THEN 1 ELSE 0
    ReleaseSemaphore(singleNode);
    runExecuteOn('STATUS_CHANGE')
  ENDIF
ENDPROC

PROC sendChatFlag(chatFlag)
  DEF port:PTR TO mp

  IF serverRP=NIL THEN RETURN
  AstrCopy(masterMsg.user,'')
  AstrCopy(masterMsg.location,'')
  AstrCopy(masterMsg.action,'')
  masterMsg.command:=IF chatFlag THEN JH_CHATON ELSE JH_CHATOFF

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
    GetMsg(serverRP)
  ENDIF
  masterMsg.command:=JH_UPDATE
ENDPROC

PROC sendQuietFlag(opt)
  DEF port:PTR TO mp

  IF serverRP=NIL THEN RETURN

  AstrCopy(masterMsg.user,'')
  AstrCopy(masterMsg.location,'')
  AstrCopy(masterMsg.action,'')
  masterMsg.command:=IF quietFlag THEN JH_QUIETON ELSE JH_QUIETOFF

  IF((port:=FindPort('AE.Master')))
    PutMsg(port,masterMsg)
    WaitPort(serverRP)
    GetMsg(serverRP)
  ENDIF
  masterMsg.command:=JH_UPDATE
  IF(sopt.toggles[TOGGLES_MULTICOM])
    ObtainSemaphore(singleNode)
    IF loggedOnUser<>NIL
      AstrCopy(singleNode.handle,loggedOnUser.name)
      AstrCopy(singleNode.location,loggedOnUser.location)
    ELSE
      AstrCopy(singleNode.handle,'')
      AstrCopy(singleNode.location,'')
    ENDIF
    AstrCopy(singleNode.misc1,'')
    AstrCopy(singleNode.misc2,'')
    IF(opt) THEN singleNode.status:=0-(currentStat+2) ELSE singleNode.status:=currentStat
    singleNode.misc2[0]:=IF blockOLM THEN 1 ELSE 0
    ReleaseSemaphore(singleNode)
  ENDIF
ENDPROC

PROC updateTitle(hoozer: PTR TO user)
  DEF aflag,pflag,pub=FALSE
  DEF pubScreen[20]:STRING

  IF pagedFlag THEN pflag:="*" ELSE pflag:=" "
  IF sysopAvail THEN aflag:="*" ELSE aflag:=" "

  StringF(titlebar,'    AmiExpress BBS (c)\s  \s                      Node \d \c',expressDate,expressVer,node,aflag)

  IF readToolType(TOOLTYPE_WINDOW,node,'WINDOW.PUBSCREEN',pubScreen)
    pub:=TRUE
  ENDIF

  IF hoozer=NIL
    IF window<>NIL THEN SetWindowTitles(window,titlebar,titlebar)
    IF (windowStat<>NIL) AND pub THEN SetWindowTitles(windowStat,titlebar,titlebar)
    RETURN
  ENDIF

  IF(scropen)
    StringF(ititlebar,'   \c\s, \s, (\d \l\s[10] [\d]) \d mins, \d \c',pflag,hoozer.name,hoozer.phoneNumber,hoozer.secStatus,hoozer.conferenceAccess,currentConf,Div(timeLimit,60),onlineBaud,aflag) ->//(RTS) was Online_BaudR
    IF(dStatBar=NIL)
      SetWindowTitles(window,ititlebar,ititlebar)
      IF (windowStat<>NIL) AND (pub) THEN SetWindowTitles(windowStat,ititlebar,ititlebar)
    ELSE
      SetWindowTitles(window,titlebar,titlebar)
      IF (windowStat<>NIL) AND (pub) THEN SetWindowTitles(windowStat,titlebar,titlebar)
    ENDIF
  ENDIF
ENDPROC

PROC statChatFlag()
  IF(sysopAvail)
    statMessage(79,1,'*')
    sendChatFlag(1)
  ELSE
    statMessage(79,1,' ')
    sendChatFlag(0)
  ENDIF
ENDPROC

PROC statPrintTime(s: PTR TO CHAR)
  DEF str[32]:STRING

  StringF(str,'\s[18]',s)
  statMessage(1,3,str)
ENDPROC


PROC statPrintUser(hoozer: PTR TO user,hoozer2: PTR TO userKeys,hoozer3: PTR TO userMisc)
  DEF string[82]:STRING
  DEF bcdStr[20]:STRING
  DEF pubScreen[20]:STRING
  DEF pub=FALSE

  statChatFlag()
  IF scropen=FALSE THEN RETURN

  IF readToolType(TOOLTYPE_WINDOW,node,'WINDOW.PUBSCREEN',pubScreen)
    pub:=TRUE
  ENDIF

  IF hoozer=NIL
    SetWindowTitles(window,titlebar,titlebar)
    IF (windowStat<>NIL) AND (pub) THEN SetWindowTitles(windowStat,titlebar,titlebar)
    RETURN
  ENDIF

  IF(pagedFlag) AND (bitPlanes>2)
    IF KickVersion(40)
      statMessage(1,1,'[31m')
    ELSE
      statMessage(1,1,'[37m')
    ENDIF
  ELSE
    statMessage(1,1,'[0m')
  ENDIF

  /* if user hit chat & window is no color, add * infront of user name */
  IF((bitPlanes=1) AND (pagedFlag)) THEN StringF(string,'*\l\s[14]',hoozer.name) ELSE StringF(string,'\l\s[15]',hoozer.name)
  statMessage(1,1,string)
  updateTitle(hoozer)

  StringF(string,'\l\s[15]',hoozer3.realName)
  statMessage(17,1,string)

  StringF(string,'\l\d[3]',hoozer.slotNumber)
  statMessage(33,1,string)

  StringF(string,'\l\d[3]',hoozer.secStatus)
  statMessage(37,1,string)

  StringF(string,'\l\s[9]',hoozer.conferenceAccess)
  statMessage(41,1,string)

  StringF(string,'\l\s[12]',hoozer.phoneNumber)
  statMessage(51,1,string)

  ->what goes in here? seems blank

  StringF(string,'\r\d[7]',onlineBaud)
  statMessage(73,1,string)

  StringF(string,'\l\s[31]',hoozer.location)
  statMessage(1,2,string)


  StringF(string,'\l\d[2]',hoozer.secLibrary)
  statMessage(36,2,string)

  StringF(string,'\l\d[2]',hoozer.secBoard)
  statMessage(33,2,string)

  StringF(string,'\l\d[5]',hoozer.downloads AND $FFFF)
  statMessage(39,2,string)

  StringF(string,'\l\d[5]',hoozer.uploads AND $FFFF)
  statMessage(45,2,string)

  formatBCD(hoozer3.downloadBytesBCD,bcdStr)
  IF StrLen(bcdStr)>12
    SetStr(bcdStr,StrLen(bcdStr)-3)
    StrAdd(bcdStr,'K')
  ENDIF

  StringF(string,'\l\s[12]',bcdStr)
  statMessage(51,2,string)

  formatBCD(hoozer3.uploadBytesBCD,bcdStr)
  IF StrLen(bcdStr)>12
    SetStr(bcdStr,StrLen(bcdStr)-3)
    StrAdd(bcdStr,'K')
  ENDIF

  StringF(string,'\l\s[12]',bcdStr)
  statMessage(64,2,string)

  StringF(string,'\r\z\d[3]',currentConf)
  statMessage(77,2,string)

  IF (hoozer.todaysBytesLimit<>0)
    StringF(string,'\l\d[8]',hoozer.todaysBytesLimit)
  ELSE
    StrCopy(string,'Infinite')
  ENDIF

  statMessage(36,3,string)

  StringF(string,'\l\d[5]',hoozer.timesCalled AND $FFFF)
  statMessage(45,3,string)

  statMessage(51,3,'                           ')

  IF(hoozer.newUser = FALSE)
    formatLongDateTime(hoozer.timeLastOn,string)
  ELSE
    IF(validUser=0)
      StringF(string,' * * Account Not Saved * * ')
    ELSE
      StringF(string,' * * New User Account  * * ')
    ENDIF
  ENDIF
  statMessage(51,3,string)

  StringF(string,'\d Min & \r\z\d[2] Secs', Div(timeLimit,60), timeLimit-(Mul(Div(timeLimit,60),60)))
  statPrintTime(string)

  StringF(string,' \r\s[15]',hostIP)
  statMessage(19,3,string)

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'SHOW_CACHE_STATS')
    IF (cacheTests>0)
      RealF(bcdStr,!(cacheHits!*100.0)/(cacheTests!),2)
    ELSE
      StrCopy(bcdStr,'0')
    ENDIF
    StringF(string,'Tooltype cache: Used \d/\d Hit rate: \d/\d (\s%)                     ',diskObjectCache.count(),diskObjectCache.maxSize(),cacheHits,cacheTests,bcdStr)
    statMessage(1,4,string)
  ENDIF
ENDPROC

PROC pGoodbye()
  DEF i,stat
  DEF tempStr[70]:STRING

  FOR i:=10 TO 1 STEP -1
    StringF(tempStr,'Last chance!  Auto LOGOFF in \d SECS.  Abort: (Enter)=yes? ',i)
    aePuts('\b\n')
    ->//if(AnsiColor)
    aePuts('[A')
    aePuts(tempStr)
    stat:=readChar(1)
    IF(stat>0)
      IF (stat="n") OR (stat="N")
        aePuts('No\b\n\b\n')
        RETURN RESULT_GOODBYE
      ELSEIF (stat="y") OR (stat="T") OR (stat=13) OR (stat=10)
        aePuts('Yes\b\n\b\n')
        RETURN RESULT_SUCCESS
      ENDIF
    ENDIF
  ENDFOR
  aePuts('\b\n')
ENDPROC RESULT_GOODBYE

/*PROC hexdump(buf,size)
  DEF i,j
  FOR i:=0 TO size-1
    WriteF('\r\z\h[2] ',buf[i])
    IF (Mod(i,16)=15) OR (i=(size-1))
      IF (i=size-1)
        j:=i
        WHILE (Mod(j,16)<15)
          WriteF('   ')
          j++
        ENDWHILE
      ENDIF
      j:=i & $fffffff0
      REPEAT
        IF (buf[j]<32) OR (buf[j]>127)
          WriteF('.')
        ELSE
          WriteF('\c',buf[j])
        ENDIF
        j++
      UNTIL j>i
      WriteF('\b\n')
    ENDIF
  ENDFOR
  WriteF('\b\n')
ENDPROC*/

PROC xprfopenAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfopen();
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfopen()
  DEF fn,am,i,res,filemode
  DEF tempstr[255]:STRING
  DEF dup
  ->(*xpr_fopen)(char *filename, char *accessmode)
  ->        D0                     A0              A1
  MOVE.L A0,fn
  MOVE.L A1,am

  loadA4({tasksA4})

  IF StriCmp(am,'r')
    filemode:=MODE_OLDFILE
  ELSEIF StriCmp(am,'w')
    filemode:=MODE_NEWFILE
  ELSEIF StriCmp(am,'rw')
    filemode:=MODE_READWRITE
  ELSEIF StriCmp(am,'a')
    filemode:=MODE_READWRITE
  ELSEIF StriCmp(am,'w+')
    filemode:=MODE_READWRITE
  ELSEIF StriCmp(am,'a+')
    filemode:=MODE_READWRITE
  ELSE
    filemode:=MODE_READWRITE
  ENDIF

  IF (filemode=MODE_OLDFILE) AND (zModemInfo.currentOperation=ZMODEM_UPLOAD)
    ->check for dupes when the xpr lib asks us to open file in read mode and we are uploading

    dup:=FALSE
    IF (netMailTransfer=FALSE) AND (sysopUploading=FALSE) AND (rzmsg=FALSE)
      IF checkForFile(FilePart(fn))
        dup:=TRUE
      ELSEIF checkInPlaypens(FilePart(fn))
        dup:=TRUE
      ENDIF
    ENDIF

    IF dup
      skipdFiles.add(FilePart(fn))
      res:=-1     ->return -1 which is not actually a file handle but xpr lib should see it as being a file that exists
      StringF(tempstr,'xprfopen: oldfile dupe \s - mode - \s, res - \d',fn, am, res)
      debugLog(LOG_DEBUG,tempstr)
      JUMP dupe
    ENDIF
  ENDIF

  IF (zModemInfo.currentOperation=ZMODEM_UPLOAD)
    FOR i:=skipdFiles.count()-1 TO 0 STEP -1
      ->if its a dupe file then we dont want to try and resume so return an error
      IF StriCmp(skipdFiles.item(i),FilePart(fn))
        res:=0
        StringF(tempstr,'xprfopen: readwrite dupe \s - mode - \s, res - \d',fn, am, res)
        debugLog(LOG_DEBUG,tempstr)
        JUMP dupe
      ENDIF
    ENDFOR
  ENDIF

  IF (filemode<>MODE_OLDFILE) AND (zModemInfo.currentOperation=ZMODEM_UPLOAD) THEN zModemInfo.currentUL:=zModemInfo.currentUL+1

  zModemInfo.resumePos:=0
  
  IF asynciobase<>NIL
    IF filemode=MODE_OLDFILE 
      res:=OpenAsync(fn,MODE_READ,65536)
    ELSEIF filemode=MODE_NEWFILE
      res:=OpenAsync(fn,MODE_WRITE,65536)
    ELSEIF filemode=MODE_READWRITE
      res:=OpenAsync(fn,MODE_APPEND,65536)
    ENDIF
  ELSE
    res:=Open(fn,filemode)
  ENDIF

  IF StriCmp(am,'a') OR StriCmp(am,'a+')
    IF asynciobase<>NIL
      SeekAsync(res,0,MODE_END)
      zModemInfo.resumePos:=SeekAsync(res,0,MODE_END)
    ELSE
      Seek(res,0,OFFSET_END)
      zModemInfo.resumePos:=Seek(res,0,OFFSET_END)
    ENDIF
  ENDIF
  StringF(tempstr,'xprfopen: \s - mode - \s, res - \d',fn, am, res)
  debugLog(LOG_DEBUG,tempstr)
dupe:
ENDPROC res

PROC xprfcloseAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfclose()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfclose()
  DEF fp
  DEF tempstr[255]:STRING
  ->        (*xpr_fclose)(long filepointer)
  ->                      A0
  MOVE.L A0,fp

  loadA4({tasksA4})

  StringF(tempstr,'xprfclose \d',fp)
  debugLog(LOG_DEBUG,tempstr)
  IF fp<>-1
    IF asynciobase<>NIL
      CloseAsync(fp)
    ELSE
      Close(fp)
    ENDIF
    IF (loggedOnUserKeys<>NIL) AND (zModemInfo.filesize>0) AND (zModemInfo.transPos=zModemInfo.filesize)
      doBgCheck()
    ENDIF
  ENDIF
  IF zModemInfo.needUpdateDownloadStats
    zmdownloadcompleted(zModemInfo.filesize,zModemInfo.filesize-zModemInfo.resumePos)
    zModemInfo.needUpdateDownloadStats:=FALSE
  ENDIF

ENDPROC FALSE

PROC xprchkabortAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprchkabort()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprchkabort()
  DEF winmsg:PTR TO intuimessage,res
  ->DEF tempstr[255]:STRING

  loadA4({tasksA4})

  res:=0
  IF windowZmodem<>NIL
    IF (winmsg:=GetMsg(windowZmodem.userport))<>NIL
      IF winmsg.class=IDCMP_CLOSEWINDOW THEN res:=-1
      ReplyMsg(winmsg)
    ENDIF
  ENDIF

  IF cancelTransferOffHook THEN res:=-1

  ->StringF(tempstr,'xprchkabort, res=\d',res)
  ->debugLog(LOG_DEBUG,tempstr)
ENDPROC res

PROC xprfreadAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfread()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfread()
  DEF buf,bsize,bcount,fp,res
  ->DEF tempstr[255]:STRING
  ->      long count = (*xpr_fread)(char *buffer, long size, long count,
  ->        -D0                        A0            D0         D1
  ->                                  long fileptr)
  ->                                  A1

  MOVE.L A0,buf
  MOVE.L D0,bsize
  MOVE.L D1,bcount
  MOVE.L A1,fp

  loadA4({tasksA4})

  ->StringF(tempstr,'xprfread: \d bytes',bsize*bcount)
  ->debugLog(LOG_DEBUG,tempstr)

  IF asynciobase<>NIL
    res:=ReadAsync(fp,buf,Mul(bsize,bcount))
  ELSE
    res:=Read(fp,buf,Mul(bsize,bcount))
  ENDIF

  ->calculate number of items read
  res:=Div(res,bsize)
ENDPROC res

PROC xprfwriteAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfwrite()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfwrite()
  DEF buf,bsize,bcount,fp,res
  ->DEF tempstr[255]:STRING
  ->        long count = (*xpr_fwrite)(char *buffer, long size, long count,
  ->        D0                         A0            D0         D1
  ->                                  long fileptr)
  ->                                  A1

  MOVE.L A0,buf
  MOVE.L D0,bsize
  MOVE.L D1,bcount
  MOVE.L A1,fp

  loadA4({tasksA4})

  ->StringF(tempstr,'xprfwrite: \d bytes',Mul(bsize,bcount))
  ->debugLog(LOG_DEBUG,tempstr)

  IF asynciobase<>NIL
    res:=WriteAsync(fp,buf,Mul(bsize,bcount))
  ELSE
    res:=Write(fp,buf,Mul(bsize,bcount))
  ENDIF

  ->calculate number of items written
  res:=Div(res,bsize)
ENDPROC res

PROC xprsreadAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
   xprsread()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprsread()
  DEF buf,bsize,timeout,serialsig,i,signals,res,timersig
  DEF tempstr[255]:STRING
  DEF waiting,stat,obuf,buf2,c,c2,avail
  DEF tv:timeval

  ->        long count = (*xpr_sread)(char *buffer, long size, long timeout)
  ->        D0                        A0            D0         D1

  MOVE.L A0,buf
  MOVE.L D0,bsize
  MOVE.L D1,timeout

  loadA4({tasksA4})

  StringF(tempstr,'xprsread: \d bytes \d timeout',bsize,timeout)
  debugLog(LOG_DEBUG,tempstr)

  IF telnetSocket>=0
    IF bsize=0 THEN RETURN 0
    waiting:=bsize

    tv.secs:=Div(timeout,1000000)
    tv.micro:=Mod(timeout,1000000)

    buf2:=New(bsize)
    obuf:=buf2
    c2:=0
    REPEAT
      IF timeout<>0
      setSingleFDS(fds,telnetSocket)
      res:=WaitSelect(telnetSocket+1,fds,NIL,NIL,tv,NIL)
      ENDIF
      IF (timeout=0) OR (res>0)
        REPEAT
          stat,avail:=checkTelnetData()
          
          IF avail>waiting THEN avail:=waiting
          IF avail>0
            stat:=Recv(telnetSocket,buf2,avail,0)
            IF stat>0
            
              StringF(tempstr,'xprsread recv complete: \d bytes',stat)
              debugLog(LOG_DEBUG,tempstr)
              c:=0
              REPEAT
                IF lastIAC2
                  StringF(tempstr,'code: \d',buf2[c])
                  debugLog(LOG_DEBUG,tempstr)
                  ->expecting an IAC parameter byte - just skip it
                  lastIAC2:=FALSE
                ELSEIF (buf2[c]=255) OR (lastIAC)
                  IF (lastIAC=FALSE) THEN c++
                  lastIAC:=FALSE
                  IF c>=stat
                    lastIAC:=TRUE
                  ELSE
                    IF buf2[c]=255
                      buf[c2]:=255
                      c2++
                    ELSEIF (buf2[c]>=250) AND (buf2[c]<255)
                      StringF(tempstr,'known iac code: \d',buf2[c])
                      debugLog(LOG_DEBUG,tempstr)
                      c++
                      IF (c>=stat)
                        lastIAC2:=TRUE
                      ELSE
                        StringF(tempstr,'code: \d',buf2[c])
                        debugLog(LOG_DEBUG,tempstr)
                      ENDIF
                    ELSE
                      StringF(tempstr,'unknown iac code: \d',buf2[c])
                      debugLog(LOG_DEBUG,tempstr)
                    ENDIF
                  ENDIF
                ELSE
                  buf[c2]:=buf2[c]
                  c2++
                ENDIF
                c++
              UNTIL (c>=stat)
              waiting:=bsize-c2
            ENDIF
          ENDIF
        UNTIL (avail=0) OR (waiting=0)
      ENDIF
    UNTIL (waiting=0) OR (timeout=0) OR (res=0)
    
    i:=c2
    IF(checkCarrier())=FALSE
      i:=-1
    ENDIF
    
    Dispose(buf2)
    StringF(tempstr,'xprsread complete: \d bytes',i)
    debugLog(LOG_DEBUG,tempstr)
    ->hexdump(buf,i)
    RETURN i
  ENDIF

  IF(bsize > 0)

    waiting:=getSerialInfo()
    /* Return error if carrier is lost. */

    IF(checkCarrier())=FALSE
      i:=-1
      JUMP sreaddone
    ENDIF

    /* Is there data waiting to be read? */

    IF(waiting > 0)
      /* No timeout specified? Read as many
      * bytes as available.
      */

      IF(timeout = 0)
        IF(waiting > bsize) THEN waiting:=bsize

        IF(doSerialRead(buf,waiting))
          IF(serialErrorReport(serialReadIO))
            i:=-1
            JUMP sreaddone
          ELSE
            waiting:=serialReadIO.iostd.actual
          ENDIF
        ENDIF

        i:=waiting
        JUMP sreaddone
      ENDIF

      /* Enough data pending to be read? */

      IF(waiting >= bsize)
        IF(doSerialRead(buf,bsize))
          IF(serialErrorReport(serialReadIO))
            i:=-1
            JUMP sreaddone
          ELSE
            bsize:=serialReadIO.iostd.actual
          ENDIF
        ENDIF

        i:=bsize
        JUMP sreaddone
      ENDIF
    ELSE
      /* No timeout and no data available:
      * return immediately.
      */

      IF(timeout=0)
        i:=0
        JUMP sreaddone
      ENDIF
    ENDIF

    serialsig:=0
    timersig:=0

    openTimer()
    IF serialReadMP<>NIL THEN serialsig:=Shl(1, serialReadMP.sigbit)
    IF timerport<>NIL THEN timersig:=Shl(1, timerport.sigbit)

    setTimer(Div(timeout,1000000),Mod(timeout,1000000))

    queueSerialRead(buf,bsize)

    LOOP
      signals:=Wait(serialsig OR timersig)

      /* Receive buffer filled? */

      IF(signals AND serialsig)
        /* Abort the timer request. */

        stopTime()
        closeTimer()

        /* Did the request terminate gracefully? */

        IF(waitSerialRead())
          IF(serialErrorReport(serialReadIO))
            i:=-1
            JUMP sreaddone
          ELSE
            bsize:=serialReadIO.iostd.actual
          ENDIF
        ENDIF

        i:=bsize
        JUMP sreaddone
      ENDIF

      /* Hit by timeout? */

      IF(signals AND timersig)
        /* Abort the read request. */

        stopSerialRead()

        /* Remove the timer request. */

        waitTime()
        closeTimer()

        /* Did the driver receive any
        * data?
        */

        IF(serialReadIO.iostd.actual > 0)
          i:=serialReadIO.iostd.actual
          JUMP sreaddone
        ELSE
          /* Take a second look and query the number of
          * bytes ready to be received, there may
          * still be some bytes in the buffer.
          * Note: this depends on the way the
          * driver handles read abort.
          */

          waiting:=getSerialInfo()

          /* Don't read too much. */

          IF(bsize > waiting) THEN bsize:=waiting

          /* Are there any bytes to be transferred? */

          IF(bsize > 0)
            /* Read the data. */

            IF(doSerialRead(buf,bsize))
              IF(serialErrorReport(serialReadIO))
                i:=-1
                JUMP sreaddone
              ELSE
                bsize:=serialReadIO.iostd.actual
              ENDIF
            ENDIF

          ELSE
            /* Ok, so there is no data in the buffer. */
            /* Check if the carrier signal is still */
            /* present */

            IF(checkCarrier())=FALSE
              i:=-1
              JUMP sreaddone
            ENDIF
          ENDIF

          i:=bsize
          JUMP sreaddone
        ENDIF
      ENDIF
    ENDLOOP
  ELSE
    i:=0
  ENDIF

sreaddone:
  StringF(tempstr,'xprsread complete: \d bytes',i)
  debugLog(LOG_DEBUG,tempstr)
  ->hexdump(buf,i)
ENDPROC i

PROC xprswriteAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprswrite()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprswrite()
  DEF buf,bsize
  DEF tempstr[255]:STRING
  ->        long status = (*xpr_swrite)(char *buffer, long size)
  ->        D0                          A0            D0

  MOVE.L A0,buf
  MOVE.L D0,bsize

  loadA4({tasksA4})

  StringF(tempstr,'xprswrite: \d bytes',bsize)
  debugLog(LOG_DEBUG,tempstr)
  ->hexdump(buf,bsize)

  serPuts(buf,bsize,TRUE,TRUE)

ENDPROC FALSE

PROC xprfseekAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfseek()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfseek()
  DEF fp,offset,origin
  DEF tempstr[255]:STRING
  ->       long status = (*xpr_fseek)(long fileptr, long offset, long origin)
  ->              D0                     A0            D0         D1


  MOVE.L A0,fp
  MOVE.L D0,offset
  MOVE.L D1,origin

  loadA4({tasksA4})

  StringF(tempstr,'xprfseek: \d offset',offset)
  debugLog(LOG_DEBUG,tempstr)

  IF asynciobase<>NIL
    IF origin=OFFSET_BEGINNING
      SeekAsync(fp,offset,MODE_START)
    ELSEIF origin=OFFSET_CURRENT
      SeekAsync(fp,offset,MODE_CURRENT)
    ELSEIF origin=OFFSET_END
      SeekAsync(fp,offset,MODE_END)
    ENDIF
  ELSE
    Seek(fp,offset,origin)
  ENDIF
  IF zModemInfo.resumePos=0
    IF asynciobase<>NIL
      zModemInfo.resumePos:=SeekAsync(fp,0,MODE_CURRENT)
    ELSE
      zModemInfo.resumePos:=Seek(fp,0,OFFSET_CURRENT)
    ENDIF
  ENDIF
ENDPROC FALSE

PROC xprsflushAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprsflush()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprsflush()
  loadA4({tasksA4})
  debugLog(LOG_DEBUG,'xprsflush')
ENDPROC FALSE

PROC xprupdateAsm()
  MOVEM.L D0-D7/A0-A6,-(A7)
  xprupdate()
  MOVEM.L (A7)+,D0-D7/A0-A6
ENDPROC D0

PROC xprupdate()
  DEF xpru: PTR TO xpr_update
  DEF updateTime
  DEF update=FALSE
  DEF outmsg[255]:STRING
  DEF fsize

  MOVE.L A0,xpru

  loadA4({tasksA4})

  IF(xpru.xpru_updatemask AND XPRU_ERRORMSG)<>0
    AstrCopy(zModemInfo.zStat,xpru.xpru_errormsg,60)
    update:=TRUE

    debugLog(LOG_DEBUG,xpru.xpru_errormsg)
  ENDIF
  IF(xpru.xpru_updatemask AND XPRU_FILENAME)<>0
    update:=TRUE
    IF xpru.xpru_filename<>NIL
      IF StrCmp(zModemInfo.fileName,xpru.xpru_filename)=FALSE
        AstrCopy(zModemInfo.fileName,xpru.xpru_filename)
        IF zModemInfo.currentOperation=ZMODEM_UPLOAD
          sendMasterUpload(FilePart(zModemInfo.fileName))
        ENDIF
      ENDIF
    ENDIF
  ENDIF

  IF(xpru.xpru_updatemask AND XPRU_EXPECTTIME)<>0
    IF xpru.xpru_expecttime<>0 THEN AstrCopy(zModemInfo.apxTime,xpru.xpru_expecttime,40)
  ENDIF

  IF(xpru.xpru_updatemask AND XPRU_ELAPSEDTIME)<>0
    IF xpru.xpru_expecttime<>0 THEN AstrCopy(zModemInfo.elapsedTime,xpru.xpru_elapsedtime,40)
  ENDIF

  IF(xpru.xpru_updatemask AND XPRU_FILESIZE)<>0
    update:=TRUE
    IF xpru.xpru_filesize<>-1
      zModemInfo.filesize:=xpru.xpru_filesize
      logUDFile(zModemInfo.currentOperation=ZMODEM_DOWNLOAD)
    ENDIF
  ENDIF

  IF(xpru.xpru_updatemask AND XPRU_ERRORS)<>0
    IF xpru.xpru_bytes<>-1 THEN zModemInfo.errorPos:=xpru.xpru_bytes
    zModemInfo.errorCount:=xpru.xpru_errors
  ENDIF

  IF(xpru.xpru_updatemask AND XPRU_BYTES)<>0
    IF xpru.xpru_bytes<>-1
      IF zModemInfo.currentOperation=ZMODEM_DOWNLOAD
        zModemInfo.transPos:=xpru.xpru_bytes
      ELSE
      ENDIF
      zModemInfo.transPos:=xpru.xpru_bytes
      fsize:=zModemInfo.filesize
  
      IF zModemInfo.transPos=fsize THEN AstrCopy(zModemInfo.lastTime,xpru.xpru_elapsedtime,40)
    ENDIF
  ENDIF
  IF(xpru.xpru_updatemask AND XPRU_MSG)<>0
    IF xpru.xpru_msg<>NIL
      IF (StrCmp(xpru.xpru_msg,'Sending EOF')) AND (zModemInfo.shouldUpdateDownloadStats) THEN zModemInfo.needUpdateDownloadStats:=TRUE
      AstrCopy(zModemInfo.zStat,xpru.xpru_msg,60)
      debugLog(LOG_DEBUG,xpru.xpru_msg)
    ENDIF
  ENDIF
  IF(xpru.xpru_updatemask AND XPRU_DATARATE)<>0
    IF xpru.xpru_datarate<>-1
      tTCPS:=xpru.xpru_datarate
      tTEFF:=calcEfficiency(tTCPS,onlineBaud)
    ENDIF
  ENDIF

  IF(xpru.xpru_updatemask AND XPRU_BLOCKS)<>0
    update:=TRUE
  ENDIF
  
  IF update
    updateTime:=getSystemTime()
    IF zModemInfo.lastUpdate<>updateTime
      updateZDisplay()
      debugLog(LOG_DEBUG,'xpru display update')
      StringF(outmsg,'current block size: \d',xpru.xpru_blocksize)
      debugLog(LOG_DEBUG,outmsg)
      zModemInfo.lastUpdate:=updateTime

      processMessages()

    ENDIF
  ENDIF
ENDPROC

PROC xprsetserialAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprsetserial()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprsetserial()
  DEF res,newstatus,oldstatus
  DEF tempstr[255]:STRING

  MOVE.L D0,newstatus

  loadA4({tasksA4})

  StringF(tempstr,'xprsetserial \d',newstatus)
  debugLog(LOG_DEBUG,tempstr)
  res:=oldstatus
  oldstatus:=newstatus

ENDPROC res

PROC xprfinfoAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfinfo()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfinfo()
  DEF i,res,fn,fitype,fp
  DEF tempstr[255]:STRING
  ->long info = (*xpr_finfo)(char *filename, long typeofinfo)
  ->        D0                       A0              D0

  MOVE.L A0,fn
  MOVE.L D0,fitype

  loadA4({tasksA4})

  StringF(tempstr,'xprsfinfo - fitype \d \s',fitype,fn)
  debugLog(LOG_DEBUG,tempstr)

  IF fitype=1
    ->file size

    IF (zModemInfo.currentOperation=ZMODEM_UPLOAD)
      FOR i:=skipdFiles.count()-1 TO 0 STEP -1
        ->if its a dupe file then we dont want to try and resume so return 2gb filesize

        StringF(tempstr,'xprsfinfo - dupecheck \s \s - res \d',skipdFiles.item(i),FilePart(fn),StriCmp(skipdFiles.item(i),FilePart(fn)))
        debugLog(LOG_DEBUG,tempstr)

        IF StriCmp(skipdFiles.item(i),FilePart(fn))
          StringF(tempstr,'xprsfinfo - dupe - \s',fn)
          debugLog(LOG_DEBUG,tempstr)
          res:=$7fffffff
          RETURN res
        ENDIF
      ENDFOR
    ENDIF

    fp:=Open(fn,MODE_OLDFILE)
    Seek(fp,0,OFFSET_END)
    res:=Seek(fp,0,OFFSET_CURRENT)
    Close(fp)
  ELSE
    ->file type
    res:=1 ->always binary
  ENDIF

  ->debugLog(LOG_DEBUG,'xprsfinfo')
ENDPROC res

PROC xprunlinkAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprunlink()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprunlink()
  DEF fn
  MOVE.L A0,fn
  loadA4({tasksA4})
ENDPROC xprunlink2(fn)

PROC xprunlink2(fn)
  DEF tempstr[255]:STRING
  DEF res

  StringF(tempstr,'xprunlink \s',fn)
  debugLog(LOG_DEBUG,tempstr)

  res:=0
  ->partial upload, move it as a partial upload rather than deleting it
  IF loggedOnUser<>NIL
    IF ownPartFiles
      StringF(tempstr,'\sPartUpload/\s@\d-\d',currentConfDir,FilePart(fn),node,loggedOnUser.slotNumber)
    ELSE
      StringF(tempstr,'\sPartUpload/\s@\d',currentConfDir,FilePart(fn),loggedOnUser.slotNumber)
    ENDIF
  ENDIF
  IF(Rename(fn,tempstr))=FALSE
    fileCopy(fn,tempstr)
    SetProtection(fn,FIBF_OTR_DELETE)
    IF DeleteFile(fn)=0 THEN res:=-1
  ENDIF
ENDPROC res

PROC xprffirstAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprffirst()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprffirst()
  DEF buffer:PTR TO CHAR

  MOVE.L A0,buffer
  loadA4({tasksA4})
ENDPROC xprffirst2(buffer)

PROC xprffirst2(buffer)
  DEF fileItem:PTR TO flagFileItem
  zModemInfo.resumePos:=0
  zModemInfo.currentDL:=0
  fileItem:=zModemInfo.fileList.item(zModemInfo.currentDL)
  zModemInfo.freeDFlag:=checkFree(fileItem.fileName)
  AstrCopy(buffer,fileItem.fileName,255)
  sendMasterDownload(fileItem.fileName)
ENDPROC TRUE

PROC xprfnextAsm()
  MOVEM.L D1-D7/A0-A6,-(A7)
  xprfnext()
  MOVEM.L (A7)+,D1-D7/A0-A6
ENDPROC D0

PROC xprfnext()
  DEF buffer:PTR TO CHAR

  MOVE.L A0,buffer

  loadA4({tasksA4})

ENDPROC xprfnext2(buffer)

PROC xprfnext2(buffer:PTR TO CHAR)
  DEF fileItem:PTR TO flagFileItem

  zModemInfo.currentDL:=zModemInfo.currentDL+1

  IF buffer=NIL THEN RETURN FALSE

  IF zModemInfo.currentDL=zModemInfo.fileList.count()
    AstrCopy(buffer,'')
    RETURN FALSE
  ENDIF

  fileItem:=zModemInfo.fileList.item(zModemInfo.currentDL)
  AstrCopy(buffer,fileItem.fileName,255)
  sendMasterDownload(fileItem.fileName)
  zModemInfo.freeDFlag:=checkFree(fileItem.fileName)
  zModemInfo.resumePos:=0
ENDPROC TRUE


PROC waitSerialRead()
  DEF res
  IF readQueued
    readQueued:=FALSE
    WaitIO(serialReadIO)
  ELSE
    res:=0
  ENDIF
ENDPROC res

PROC waitTime()
  DEF res
  IF timerQueued
    timerQueued:=FALSE
    res:=WaitIO(timermsg)
  ELSE
    res:=0
  ENDIF
ENDPROC res

PROC doSerialRead(data,length)
  IF(readQueued) THEN stopSerialRead()

  serialReadIO.iostd.command:=CMD_READ
  serialReadIO.iostd.length:=length
  serialReadIO.iostd.data:=data
ENDPROC DoIO(serialReadIO)

PROC stopSerialRead()
  IF readQueued AND (serialReadIO<>NIL)
    IF(CheckIO(serialReadIO))=FALSE THEN AbortIO(serialReadIO)
    WaitIO(serialReadIO)
    readQueued:=FALSE
  ENDIF
ENDPROC

PROC serialErrorReport(request: PTR TO ioextser)
  DEF isFatal=FALSE,error

  error:=request.iostd.error
  SELECT error
    CASE SERERR_LINEERR
      debugLog(LOG_ERROR,'serial error: hardware data overrun')
      ->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_HARDWARE_DATA_OVERRUN_TXT)
      isFatal:=FALSE
    CASE SERERR_PARITYERR
      debugLog(LOG_ERROR,'serial error: parity error')
      ->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_PARITY_ERROR_TXT)
      isFatal:=TRUE
    CASE SERERR_TIMERERR
      debugLog(LOG_ERROR,'serial error: timer error')
      ->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_TIMER_ERROR_TXT)
      isFatal:=FALSE
    CASE SERERR_BUFOVERFLOW
      debugLog(LOG_ERROR,'serial error: read buffer overflow')
      ->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_READ_BUFFER_OVERFLOWED_TXT)
      isFatal:=FALSE
    CASE SERERR_NODSR
      debugLog(LOG_ERROR,'serial error: no dsr')
      ->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_NO_DSR_TXT)
      isFatal:=TRUE
    CASE SERERR_DETECTEDBREAK
      debugLog(LOG_ERROR,'serial error: break detected')
      ->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_BREAK_DETECTED_TXT)
      isFatal:=TRUE
    DEFAULT
      ->debugLog(LOG_ERROR,'serial error: unknown error')
      ->ErrorMessage = LocaleString(MSG_TERMXPR_ERROR_UNKNOWN_CAUSE_TXT)
      isFatal:=FALSE
  ENDSELECT
ENDPROC isFatal

PROC getSerialInfo()
  DEF waiting
  
  IF(serialWriteIO)
    serialWriteIO.iostd.command:=SDCMD_QUERY
    DoIO(serialWriteIO)

    waiting:=serialWriteIO.iostd.actual
    ->status:=serialWriteIO.status
  ELSE
    waiting:=0
    ->status:=(CIAF_COMCD OR CIAF_COMDSR)
  ENDIF
ENDPROC waiting

PROC setTimer(timevalSecs,timevalMicro)
  timermsg.io.command:=TR_ADDREQUEST /* add a new timer request */
  timermsg.time.secs:=timevalSecs          /* seconds */
  timermsg.time.micro:=timevalMicro        /* microseconds */
  timermsg.io.mn.replyport:=timerport
  timerQueued:=TRUE
  SendIO(timermsg)     /* post the request to the timer device */
ENDPROC

PROC stopTime()
  IF timerQueued
    IF(CheckIO(timermsg))=FALSE THEN AbortIO(timermsg)
    WaitIO(timermsg)
    timerQueued:=FALSE
  ENDIF
ENDPROC

PROC openTimer()
  DEF error

  IF(timerport:=createPort(0,0))=NIL THEN RETURN TRUE

  IF(timermsg:=(createExtIO(timerport,SIZEOF timerequest)))=FALSE THEN RETURN TRUE

  timermsg.io.mn.replyport:=timerport
  IF(error:=OpenDevice('timer.device',UNIT_VBLANK,timermsg,0)) THEN RETURN error
ENDPROC FALSE

PROC closeTimer()
  IF(timermsg)
    stopTime()
    CloseDevice(timermsg)
    deleteExtIO(timermsg)
    timermsg:=NIL
    IF(timerport) THEN deletePort(timerport)
    timerport:=NIL
  ENDIF
ENDPROC

PROC hydchatwrite(s:PTR TO CHAR) IS hydraStatPrint(2,s)

PROC hydraStatPrint(winNum,s:PTR TO CHAR)
  IF winNum=0
    IF(hydraWindow1<>NIL)
      hydraStatWriteIO1.data:=s
      hydraStatWriteIO1.length:=-1
      hydraStatWriteIO1.command:=CMD_WRITE
      DoIO(hydraStatWriteIO1)
    ENDIF
  ELSEIF winNum=1
    IF(hydraWindow2<>NIL)
      hydraStatWriteIO2.data:=s
      hydraStatWriteIO2.length:=-1
      hydraStatWriteIO2.command:=CMD_WRITE
      DoIO(hydraStatWriteIO2)
    ENDIF
  ELSEIF winNum=2
    IF(hydraWindow3<>NIL)
      hydraStatWriteIO3.data:=s
      hydraStatWriteIO3.length:=-1
      hydraStatWriteIO3.command:=CMD_WRITE
      DoIO(hydraStatWriteIO3)
    ENDIF
  ENDIF
ENDPROC

PROC zmodemStatPrint(s:PTR TO CHAR)
  IF(windowZmodem<>NIL)
    zModemStatWriteIO.data:=s
    zModemStatWriteIO.length:=-1
    zModemStatWriteIO.command:=CMD_WRITE
    DoIO(zModemStatWriteIO)
  ENDIF
ENDPROC

PROC makeCpsText(cps,outstr:PTR TO CHAR)
  DEF d1,d2
  IF cps>900000000
    d1:=Shr(cps,30) AND $FF
    d2:=Shr(cps,25) AND $1f
    d2:=Shr(Mul(d2,10),5)
    StringF(outstr,'\r\d[2].\d[1]g/s',d1,d2)
  ELSEIF cps>900000
    d1:=Shr(cps,20) AND $3FF
    d2:=Shr(cps,15) AND $1f
    d2:=Shr(Mul(d2,10),5)
    IF d1>100 THEN StringF(outstr,'\r\d[3]m/s',d1) ELSE StringF(outstr,'\r\d[2].\d[1]m/s',d1,d2)
  ELSEIF cps>900
    d1:=Shr(cps,10) AND $3FF
    d2:=Shr(cps,5) AND $1f
    d2:=Shr(Mul(d2,10),5)
    IF d1>100 THEN StringF(outstr,'\r\d[3]k/s',d1) ELSE StringF(outstr,'\r\d[2].\d[1]k/s',d1,d2)
  ELSE
    StringF(outstr,'\r\d[4]cps',cps)
  ENDIF
ENDPROC

PROC updateZDisplay()
  DEF tempstr[255]:STRING
  DEF xpos,tags2:PTR TO LONG,vi
  DEF v1,v2
  DEF fsize
  IF netMailTransfer
    IF zModemInfo.currentOperation=ZMODEM_DOWNLOAD
      StringF(tempstr,'[Node \d] NetMail Send Window',node)
      AstrCopy(zModemInfo.titleBar,tempstr)
    ELSE
      StringF(tempstr,'[Node \d] NetMail Receive Window',node)
      AstrCopy(zModemInfo.titleBar,tempstr)
    ENDIF 
  ELSE
    IF zModemInfo.currentOperation=ZMODEM_DOWNLOAD
      StringF(tempstr,'[Node \d] Send Window (\d/\d)',node,zModemInfo.currentDL,zModemInfo.totalDL)
      AstrCopy(zModemInfo.titleBar,tempstr)
    ELSE
      StringF(tempstr,'[Node \d] Receive Window (\d/??)',node,zModemInfo.currentUL)
      AstrCopy(zModemInfo.titleBar,tempstr)
    ENDIF
  ENDIF

  IF(windowZmodem<>NIL)
    fsize:=zModemInfo.filesize

  
    SetWindowTitles(windowZmodem,zModemInfo.titleBar,zModemInfo.titleBar)
    zmodemStatPrint('[H[J[0 p')
    IF (KickVersion(40) AND (bitPlanes>2))
      zmodemStatPrint('[37m[ s')
    ENDIF
    StringF(tempstr,'[H\n FileName: \s\n',FilePart(zModemInfo.fileName))
    zmodemStatPrint(tempstr)
    StringF(tempstr,' FileSize: \d\n',fsize)
    zmodemStatPrint(tempstr)
    StringF(tempstr,' ETA Time: \s\n',zModemInfo.apxTime)
    zmodemStatPrint(tempstr)
    StringF(tempstr,' Cur Time: \s\n',zModemInfo.elapsedTime)
    zmodemStatPrint(tempstr)
    StringF(tempstr,' Position: \d\n',zModemInfo.transPos)
    zmodemStatPrint(tempstr)
    StringF(tempstr,' Resume P: \d\n',zModemInfo.resumePos);
    zmodemStatPrint(tempstr);

    IF (gadtoolsbase:=OpenLibrary('gadtools.library',0))<>NIL
      vi:=GetVisualInfoA(screen, [NIL])
      tags2:=NEW [GT_VISUALINFO,vi,TAG_DONE]

      DrawBevelBoxA(windowZmodem.rport,9,129,316,10,tags2)
      FreeVisualInfo(vi)
      FastDisposeList(tags2)
      CloseLibrary(gadtoolsbase)
    ENDIF

    IF(fsize=0)
      zmodemStatPrint(' Complete: N/A\n')
      SetAPen(windowZmodem.rport,0)
      RectFill(windowZmodem.rport,11,130,322,137)
    ELSE
      IF fsize<100
        StringF(tempstr,' Complete: \d%\n',Div(Mul(zModemInfo.transPos,100),fsize))
      ELSE
        StringF(tempstr,' Complete: \d%\n',Div(zModemInfo.transPos,Div(fsize,100)))
      ENDIF
      zmodemStatPrint(tempstr)

      v1:=zModemInfo.transPos
      v2:=fsize
      IF (v2=0)
        xpos:=11
      ELSE
        IF v2>=1048576
          v1:=Shr(v1,10) AND $003fffff
          v2:=Shr(v2,10) AND $003fffff
        ENDIF
        xpos:=11+Div(Mul(v1,311),v2)
      ENDIF

      IF xpos>11
        SetAPen(windowZmodem.rport,1)
        RectFill(windowZmodem.rport,11,130,xpos,137)
      ENDIF

      IF xpos<322
        SetAPen(windowZmodem.rport,0)
        RectFill(windowZmodem.rport,xpos+1,130,322,137)
      ENDIF
    ENDIF
    StringF(tempstr,' LastTime: \s\n',zModemInfo.lastTime)
    zmodemStatPrint(tempstr)
    StringF(tempstr,'      CPS: \d Efficiency \d%\n\n',tTCPS,tTEFF)
    zmodemStatPrint(tempstr)
    StringF(tempstr,' Z Status: \s\n',zModemInfo.zStat)
    zmodemStatPrint(tempstr)
    StringF(tempstr,' Errors: \d\n',zModemInfo.errorCount)
    zmodemStatPrint(tempstr)
    StringF(tempstr,' ErrorPos: \d ',zModemInfo.errorPos)
    zmodemStatPrint(tempstr)
  ENDIF
  
  makeCpsText(tTCPS,tempstr)
  
  sendACPCommand2(tempstr,JH_TRANSFERCPS)
ENDPROC

PROC checkFree(fname)
  DEF fileComment[255]:STRING

  getFileComment(fname,fileComment)
  IF fileComment[0]="F" THEN RETURN TRUE
ENDPROC freeDownloads

PROC doAxNetSend(filename:PTR TO CHAR)
  DEF res
  netMailTransfer:=TRUE
  res:=downloadFile(filename,TRUE)
  netMailTransfer:=FALSE
ENDPROC res

PROC doAxNetReceive(filename:PTR TO CHAR)
  DEF res
  ulFileCount:=0
  netMailTransfer:=TRUE 
  res:=fileUpload(filename,TRUE)
  netMailTransfer:=FALSE
ENDPROC res

->this returns 0 = fail, 1 = success unlike most of the routines
PROC downloadFile(str: PTR TO CHAR,forceZmodem=FALSE)
  DEF templist:PTR TO stdlist
  DEF res,i
  DEF flagItem: PTR TO flagFileItem
  DEF tempstringlist:PTR TO stringlist

  templist:=NEW templist.stdlist(100)
  tempstringlist:=NEW tempstringlist.stringlist(100)
  IF netMailTransfer=FALSE
    parseList(str,tempstringlist)
    FOR i:=0 TO tempstringlist.count()-1
      flagItem:=NEW flagItem
      flagItem.fileName:=String(255)
      StrCopy(flagItem.fileName,tempstringlist.item(i))
      flagItem.confNum:=currentConf
      templist.setItem(i,flagItem)
    ENDFOR
  ELSE
    parseList(str,tempstringlist)
    FOR i:=0 TO tempstringlist.count()-1
      flagItem:=NEW flagItem
      flagItem.fileName:=String(255)
      StringF(flagItem.fileName,'\s\s',amixnetOutboundDir,tempstringlist.item(i))
      flagItem.confNum:=-1
      templist.add(flagItem)
    ENDFOR
  ENDIF

  res:=downloadFiles(templist,NIL,FALSE,forceZmodem)

  clearFlagItems(templist)
  END templist
  END tempstringlist
ENDPROC res

PROC httpUpload(uploadFolder: PTR TO CHAR,httpPorts)
  DEF tempstr[100]:STRING
  DEF oldSerCache

  zModemInfo.currentUL:=0
  zModemInfo.fileList:=NIL

  oldSerCache:=serialCacheEnabled
  flushSerialCache()
  serialCacheEnabled:=FALSE
  IF readToolType(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'HTTPHOST',tempstr)=FALSE
    StrCopy(tempstr,'localhost')
  ENDIF
  
  doHttpd(node,tempstr,httpPorts,uploadFolder,{aePuts},{readChar},{sCheckInput},{ftpUploadFileStart},{ftpUploadFileEnd}, {ftpTransferFileProgress},{ftpDupeCheck},{checkCarrier},TRUE,NIL)
  serialCacheEnabled:=oldSerCache
ENDPROC

PROC httpDownload(fileList: PTR TO stdlist, pupdateDownloadStats,httpPorts)
  DEF i
  DEF dirLock
  DEF tempstr[255]:STRING
  DEF tempDir[255]:STRING
  DEF linkStr[255]:STRING
  DEF item:PTR TO flagFileItem
  DEF oldSerCache

  IF readToolType(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'HTTPHOST',tempstr)=FALSE
    StrCopy(tempstr,'localhost')
  ENDIF

  IF readToolType(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'HTTPTEMP',tempstr)=FALSE
    StringF(tempDir,'RAM:http\d',node)
  ELSE
    StringF(tempDir,'\shttp\d',tempstr,node)
  ENDIF
  
  aePuts('\b\nCreating HTTP file area\b\n')
  dirLock:=CreateDir(tempDir)
  StrAdd(tempDir,'/')
  IF dirLock<>NIL THEN UnLock(dirLock)
  ->create links in ram
  IF fileList<>NIL
    FOR i:=0 TO fileList.count()-1
      item:=fileList.item(i)
      StringF(linkStr,'\s\s',tempDir,FilePart(item.fileName))
      IF MakeLink(linkStr,item.fileName,1)=0
        StringF(tempstr,'Makelink failed \s \s error: \d\b\n',linkStr,item.fileName,IoErr())
        aePuts(tempstr)
      ENDIF
    ENDFOR
  ENDIF
  
  zModemInfo.currentDL:=0
  zModemInfo.fileList:=fileList
  
  zModemInfo.shouldUpdateDownloadStats:=pupdateDownloadStats
  zModemInfo.needUpdateDownloadStats:=FALSE
 
  oldSerCache:=serialCacheEnabled
  flushSerialCache()
  serialCacheEnabled:=FALSE
  doHttpd(node,tempstr,httpPorts,tempDir,{aePuts},{readChar},{sCheckInput},{ftpDownloadFileStart},{ftpDownloadFileEnd}, {ftpTransferFileProgress},{ftpDupeCheck},{checkCarrier},FALSE,fileList)
  serialCacheEnabled:=oldSerCache
 
  ->clean up ram links
  StringF(linkStr,'DELETE \s ALL',tempDir)
  Execute(linkStr,NIL,NIL)
ENDPROC

PROC ftpUploadFileStart(fileName:PTR TO CHAR,resumefrom)
  sendMasterUpload(FilePart(fileName))
  zModemInfo.filesize:=0
  zModemInfo.resumePos:=resumefrom
  zModemInfo.transPos:=0
  ftptime1,ftptime2:=getSystemTime()
  updateZDisplay()
ENDPROC

PROC ftpUploadFileEnd(fileName:PTR TO CHAR,success)
  DEF i
  DEF str[255]:STRING
  DEF t1,t2

  IF ftpConn THEN ulTTTM:=0

  t1,t2:=getSystemTime()

  ulTTTM:=ulTTTM+Mul(t1-ftptime1,50)+t2-ftptime2
  setEnvStat(ENV_UPLOADING)
  
  IF ftpConn   
    IF success
      StringF(str,'\tUploading \s \d bytes',fileName,zModemInfo.transPos)
      callersLog(str)
      
      ulTTTM:=Div(ulTTTM,50)
      StringF(str,'\t 1 file(s), \dk bytes, \d minute(s). \d second(s), \d cps, N/A % efficiency.',Shr(zModemInfo.transPos-zModemInfo.resumePos,10),Div(ulTTTM,60),Mod(ulTTTM,60),tTCPS)
      callersLog(str)
    ELSE
      callersLog('\tUpload Failed..')
    ENDIF  

    IF (tTCPS > loggedOnUserKeys.upCPS2)
      loggedOnUserKeys.upCPS2:=tTCPS
      IF tTCPS>65535 THEN tTCPS:=65535
      loggedOnUserKeys.oldUpCPS:=tTCPS
    ENDIF

    FOR i:=0 TO skipdFiles.count()-1
      StringF(str,'\tSkipped \s',skipdFiles.item(i))
      callersLog(str)
      udLog(str)
    ENDFOR
  ENDIF
ENDPROC

PROC ftpDownloadFileStart(fileName:PTR TO CHAR,filelen,resume)
  DEF fileItem:PTR TO flagFileItem
  DEF item:PTR TO flagFileItem
  DEF fn:PTR TO CHAR
  DEF i
  
  ftptime1,ftptime2:=getSystemTime()
  fileItem:=NIL
  fn:=FilePart(fileName)

  FOR i:=0 TO zModemInfo.fileList.count()-1
    item:=zModemInfo.fileList.item(i)
    IF StriCmp(item.fileName,fileName) THEN fileItem:=item
  ENDFOR

  IF fileItem<>NIL 
    sendMasterDownload(fileItem.fileName)
    zModemInfo.freeDFlag:=checkFree(fileItem.fileName)
    AstrCopy(zModemInfo.fileName,fileItem.fileName,255)
  ELSE
    sendMasterDownload(fn)
    zModemInfo.freeDFlag:=FALSE
    AstrCopy(zModemInfo.fileName,fn,255)
  ENDIF
  
  zModemInfo.filesize:=filelen
  zModemInfo.resumePos:=resume
  zModemInfo.transPos:=0
  tTEFF:=0
  tTCPS:=0
  updateZDisplay()

  logUDFile(TRUE)
ENDPROC

PROC ftpDownloadFileEnd(fileName:PTR TO CHAR, result)
  DEF fileList:PTR TO stdlist
  DEF fileItem:PTR TO flagFileItem
  DEF item:PTR TO flagFileItem
  DEF fn:PTR TO CHAR
  DEF tempStr[255]:STRING
  DEF i
  DEF t1,t2
  
  IF ftpConn THEN dlTTTM:=0

  t1,t2:=getSystemTime()

  dlTTTM:=dlTTTM+Mul(t1-ftptime1,50)+t2-ftptime2

  fileItem:=NIL
  fn:=FilePart(fileName)
  IF zModemInfo.fileList<>NIL
    FOR i:=0 TO zModemInfo.fileList.count()-1
      item:=zModemInfo.fileList.item(i)
      IF StriCmp(FilePart(item.fileName),fn) THEN fileItem:=item
    ENDFOR
  ENDIF

  IF fileItem=NIL THEN RETURN

  IF (result) THEN updateDownloadStats(fileItem,zModemInfo.filesize,zModemInfo.filesize-zModemInfo.resumePos)

  IF ftpConn
    dlTTTM:=Div(dlTTTM,50)
    IF result     
      StringF(tempStr,'\t 1 files, \dk bytes, \d minutes \d seconds \d cps, N/A % efficiency.',Shr(zModemInfo.filesize-zModemInfo.resumePos,10) AND $003fffff,Div(dlTTTM,60),Mod(dlTTTM,60),tTCPS)
      callersLog(tempStr)
      udLog(tempStr)
    ELSE
      callersLog('\tDownload Failed..')
      udLog('\tDownload Failed..')
    ENDIF
  ENDIF

  /* is this baud higher then max cps down ? */
  IF(tTCPS > loggedOnUserKeys.dnCPS2)
    loggedOnUserKeys.dnCPS2:=tTCPS
    IF tTCPS>65535 THEN tTCPS:=65535
    loggedOnUserKeys.oldDnCPS:=tTCPS
  ENDIF

  IF (result)
    removeFlagFromList(FilePart(fileItem.fileName),fileItem.confNum)
  ENDIF
  
  IF ftpConn
    fileList:=zModemInfo.fileList
    END fileList
    zModemInfo.fileList:=NIL
    setEnvStat(ENV_IDLE)
  ELSE
    setEnvStat(ENV_DOWNLOADING)
  ENDIF
ENDPROC

PROC ftpStartFileCheck(filename:PTR TO CHAR,success)
  DEF bgCheckPort:PTR TO mp
  DEF msg:PTR TO jhMessage
 
  IF success   
    bgCheckPort:=createBackgroundFileCheckThread()
    IF bgCheckPort
      msg:=AllocMem(SIZEOF jhMessage,MEMF_ANY OR MEMF_CLEAR)
      IF msg
        msg.command:=BG_CHECKFILE_THEN_QUIT
        AstrCopy(msg.string,FilePart(filename),200)
        msg.msg.length:=SIZEOF jhMessage
        ->signal background checking to check the file
        PutMsg(bgCheckPort,msg)
      ENDIF
    ENDIF
  ENDIF
ENDPROC

PROC ftpWaitFileCheck(timeout)
  DEF done
   
  IF bgChecking=FALSE
    done:=TRUE
  ELSE
    timeout:=timeout*5
    done:=FALSE
    REPEAT
      IF FindPort(bgCheckPortName)=FALSE THEN done:=TRUE
      IF done=FALSE
        Delay(10)
        timeout--
      ENDIF
    UNTIL done OR (timeout=0)
  ENDIF
   
  IF done
    transfering:=FALSE
    bgChecking:=FALSE
    tidyPlayPen()
    setEnvStat(ENV_IDLE)
  ENDIF
ENDPROC done

PROC ftpGetPath(conf,subDir:PTR TO CHAR,path:PTR TO CHAR)
  DEF temp[255]:STRING
  DEF msgBaseNum=1
  DEF mystat,dirNum
  DEF string[255]:STRING
  DEF tempstr[255]:STRING

  IF (msgBaseNum<1 ) OR (msgBaseNum>getConfMsgBaseCount(conf)) THEN msgBaseNum:=1
  currentConf:=conf
  currentMsgBase:=msgBaseNum
  
  getConfName(conf,currentConfName)
  getConfLocation(conf,currentConfDir)
  checkPathSlash(currentConfDir)

  maxDirs:=readToolTypeInt(TOOLTYPE_CONF,conf,'NDIRS')

  IF checkToolTypeExists(TOOLTYPE_CONF,conf,'FREEDOWNLOADS') THEN freeDownloads:=TRUE ELSE freeDownloads:=FALSE

  StrCopy(menuPrompt,'')
  readToolType(TOOLTYPE_CONF,conf,'MENU_PROMPT',menuPrompt)

  getMsgBaseLocation(conf,msgBaseNum,msgBaseLocation)

  confNameType:=NAME_TYPE_USERNAME
  loadMsgPointers(conf,msgBaseNum)

  IF checkToolTypeExists(TOOLTYPE_CONF,conf,'CUSTOM')=FALSE
    mystat:=getMailStatFile(conf,msgBaseNum)
    IF(mystat=RESULT_FAILURE)
      lastMsgReadConf:=0
      lastNewReadConf:=0
      mailStat.lowestKey:=0
      mailStat.lowestNotDel:=0
      mailStat.highMsgNum:=0
    ENDIF
    IF(lastMsgReadConf<mailStat.lowestNotDel) THEN lastMsgReadConf:=mailStat.lowestNotDel
    IF(lastNewReadConf<mailStat.lowestNotDel) THEN lastNewReadConf:=mailStat.lowestNotDel

    IF(lastMsgReadConf>mailStat.highMsgNum)
      StringF(string,'error setting last message read: value \d, high msg num \d',lastMsgReadConf,mailStat.highMsgNum)
      errorLog(string)
      lastMsgReadConf:=0
    ENDIF
    IF(lastNewReadConf>mailStat.highMsgNum)
      StringF(string,'error setting last new read read: value \d, high msg num \d',lastNewReadConf,mailStat.highMsgNum)
      errorLog(string)
      lastNewReadConf:=0
    ENDIF
  ENDIF

  StrCopy(confScreenDir,currentConfDir)
  readToolType(TOOLTYPE_CONF,conf,'SCREENS',confScreenDir)
  checkPathSlash(confScreenDir)

  relConfNum:=relConf(conf)

  IF getConfMsgBaseCount(conf)>1
    StringF(string,'\s [\s] (\d) Conference Joined',currentConfName,tempstr,conf)
  ELSE
    StringF(string,'\s (\d) Conference Joined',currentConfName,conf)
  ENDIF
  StringF(tempstr,'\t\s',string)
  callersLog(tempstr)

  loggedOnUser.confRJoin:=conf
  loggedOnUser.msgBaseRJoin:=msgBaseNum
  createNodeUserFiles()
  
  IF StrLen(subDir)>0
    dirNum:=1
    StringF(path,'DLPATH.\d',dirNum++)
    WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,path))
      checkPathSlash(path)
      
      StringF(temp,'\s\s',path,subDir)
      IF dirExists(temp) 
        StrCopy(path,temp)
        RETURN path
      ENDIF

      StringF(path,'DLPATH.\d',dirNum++)
    ENDWHILE
    StrCopy(path,'')
  ELSE
    StringF(temp,'ULPATH.\d',1)
    IF(readToolType(TOOLTYPE_CONF,currentConf,temp,path))
      checkPathSlash(path)
    ELSE
      StrCopy(path,'')
    ENDIF
  ENDIF
ENDPROC path

PROC ftpTransferFileProgress(fileName:PTR TO CHAR,pos,cps)
  zModemInfo.transPos:=pos
  tTCPS:=cps
  tTEFF:=calcEfficiency(tTCPS,onlineBaud)
  updateZDisplay()
ENDPROC

PROC ftpDupeCheck(fileName:PTR TO CHAR)
  DEF dup=FALSE
 
  IF checkForFile(FilePart(fileName))
    dup:=TRUE
  ELSEIF checkInPlaypens(FilePart(fileName))
    dup:=TRUE
  ENDIF
    
  IF ftpConn THEN skipdFiles.clear()
    
  IF dup THEN skipdFiles.add(FilePart(fileName))
ENDPROC dup

PROC ftpCheckRatio(fileName:PTR TO CHAR,flen,errormsg:PTR TO CHAR)
  DEF res,min,size,cnt,i
  DEF tfsizes:PTR TO stdlist
  DEF freeDFlags:PTR TO stdlist
  DEF fileList:PTR TO stdlist
  DEF fileItem:PTR TO flagFileItem
  DEF estDlCPS  
 
  IF loggedOnUserMisc.lastDlCPS<>0
    estDlCPS:=loggedOnUserMisc.lastDlCPS
  ELSE
    estDlCPS:=Div(onlineBaud,10)
  ENDIF
  
  tfsizes:=NEW tfsizes.stdlist(cmds.numConf)
  freeDFlags:=NEW freeDFlags.stdlist(cmds.numConf)

  FOR i:=0 TO cmds.numConf-1
    IF i=(currentConf-1)
      tfsizes.add(flen)
      freeDFlags.add(checkFree(fileName))
    ELSE
      tfsizes.add(0)
      freeDFlags.add(0)
    ENDIF
  ENDFOR

  fileList:=NEW fileList.stdlist(1)
  zModemInfo.fileList:=fileList
  fileItem:=NEW fileItem
  fileItem.confNum:=currentConf
  fileItem.fileName:=String(StrLen(fileName))
  StrCopy(fileItem.fileName,fileName)
  fileList.add(fileItem)

  res:=checkRatiosAndTime({min},{size},{cnt},errormsg,estDlCPS,tfsizes,freeDFlags)
  
  IF res=FALSE
    END fileItem
    END fileList
    zModemInfo.fileList:=NIL
  ENDIF
  
  END tfsizes
  END freeDFlags
ENDPROC res<>0

PROC ftpAuth(userName:PTR TO CHAR,password:PTR TO CHAR)
  IF StriCmp(userName,loggedOnUser.name,31)=FALSE THEN RETURN FALSE
ENDPROC checkUserPassword(loggedOnUser,loggedOnUserMisc,password)

PROC ftpFindFile(filename:PTR TO CHAR,subdirs:PTR TO CHAR, outFullFilename:PTR TO CHAR)
  DEF fileList:PTR TO stdlist
  DEF fileItem:PTR TO flagFileItem
  
  fileList:=NEW fileList.stdlist(1)
  checkForFileSize(filename,subdirs,-1,NIL,NIL,fileList,0)
  IF fileList.count()>0
    fileItem:=fileList.item(0)   
    StrCopy(outFullFilename,fileItem.fileName)
  ENDIF
  clearFlagItems(fileList)
  END fileList
ENDPROC

PROC updateDownloadStats(fileItem:PTR TO flagFileItem,fsize,sentsize)
  DEF cb:PTR TO confBase

  dlFileCount++
  addBCD(dTBT,sentsize)

  IF sopt.toggles[TOGGLES_CREDITBYKB]
    fsize:=Shr(fsize,10) AND $003fffff
  ENDIF

  IF sentsize
    IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING))
      saveMsgPointers(currentConf,currentMsgBase)

      IF(freeDownloads=FALSE)
        IF creditAccountTrackDownloads(loggedOnUser)
          cb:=confBases.item(getConfIndex(fileItem.confNum,1))

          addBCD(cb.downloadBytesBCD,fsize)
          cb.bytesDownload:=convertFromBCD(cb.downloadBytesBCD)
          cb.downloads:=cb.downloads+1
        ENDIF
      ENDIF
      loadMsgPointers(currentConf,currentMsgBase)
    ELSE
      IF(freeDownloads=FALSE)
        IF creditAccountTrackDownloads(loggedOnUser)

          addBCD(loggedOnUserMisc.downloadBytesBCD,fsize)
          loggedOnUser.bytesDownload:=convertFromBCD(loggedOnUserMisc.downloadBytesBCD)
          loggedOnUser.downloads:=loggedOnUser.downloads+1
        ENDIF
      ENDIF
    ENDIF
    loggedOnUser.dailyBytesDld:=loggedOnUser.dailyBytesDld+fsize
    IF bytesADL<>$7fffffff THEN bytesADL:=bytesADL-fsize
  ENDIF
ENDPROC

PROC ftpUpload(uploadFolder:PTR TO CHAR,ftpPorts,ftpDataPorts)
  DEF tempstr[100]:STRING
  DEF oldSerCache
  DEF authPtr=NIL
  DEF ftpData:PTR TO ftpData

  IF checkToolTypeExists(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'FTPAUTH') THEN authPtr:={ftpAuth}

  zModemInfo.currentUL:=0
  zModemInfo.fileList:=NIL
  
  zModemInfo.shouldUpdateDownloadStats:=FALSE
  zModemInfo.needUpdateDownloadStats:=FALSE

  oldSerCache:=serialCacheEnabled
  flushSerialCache()
  serialCacheEnabled:=FALSE
  IF readToolType(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'FTPHOST',tempstr)=FALSE
    IF readToolType(TOOLTYPE_BBSCONFIG,'','FTPHOST',tempstr)=FALSE
      StrCopy(tempstr,'127.0.0.1')
    ENDIF
  ENDIF

  ftpData:=NEW ftpData

  ftpData.conPuts:=NIL
  ftpData.aePuts:={aePuts}
  ftpData.readChar:={readChar}
  ftpData.sCheckInput:={sCheckInput}
  ftpData.uploadFileStart:={ftpUploadFileStart}
  ftpData.uploadFileEnd:={ftpUploadFileEnd}
  ftpData.uploadFileProgress:={ftpTransferFileProgress}
  ftpData.downloadFileStart:=NIL
  ftpData.downloadFileEnd:=NIL
  ftpData.downloadFileProgress:=NIL
  ftpData.checkDownloadRatio:=NIL
  ftpData.fileDupeCheck:={ftpDupeCheck}
  ftpData.ftpCheckConnection:={checkCarrier}
  ftpData.ftpAuth:=authPtr
  ftpData.callersLog:=NIL
  ftpData.processMessages:={processMessages}
  ftpData.getSigs:={getSigs}

  doftp(ftpData,node,tempstr,ftpPorts,ftpDataPorts,NIL,uploadFolder,cmds.acLvl[LVL_CAPITOLS_in_FILE]<>0,TRUE)

  END ftpData

  serialCacheEnabled:=oldSerCache
ENDPROC

PROC ftpDownload(fileList: PTR TO stdlist, updateDownloadStats,ftpPorts,ftpDataPorts)
  DEF ftpData:PTR TO ftpData
  DEF tempstr[255]:STRING
  DEF oldSerCache
  DEF authPtr=NIL

  IF checkToolTypeExists(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'FTPAUTH') THEN authPtr:={ftpAuth}

  zModemInfo.currentDL:=0
  zModemInfo.fileList:=fileList
  
  zModemInfo.shouldUpdateDownloadStats:=updateDownloadStats
  zModemInfo.needUpdateDownloadStats:=FALSE
 
  oldSerCache:=serialCacheEnabled
  flushSerialCache()
  serialCacheEnabled:=FALSE
  
  IF readToolType(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'FTPHOST',tempstr)=FALSE
    IF readToolType(TOOLTYPE_BBSCONFIG,'','FTPHOST',tempstr)=FALSE
      StrCopy(tempstr,'127.0.0.1')
    ENDIF
  ENDIF

  ftpData:=NEW ftpData

  ftpData.conPuts:=NIL
  ftpData.aePuts:={aePuts}
  ftpData.readChar:={readChar}
  ftpData.sCheckInput:={sCheckInput}
  ftpData.uploadFileStart:=NIL
  ftpData.uploadFileEnd:=NIL
  ftpData.uploadFileProgress:=NIL
  ftpData.downloadFileStart:={ftpDownloadFileStart}
  ftpData.downloadFileEnd:={ftpDownloadFileEnd}
  ftpData.downloadFileProgress:={ftpTransferFileProgress}
  ftpData.checkDownloadRatio:=NIL
  ftpData.fileDupeCheck:={ftpDupeCheck}
  ftpData.ftpCheckConnection:={checkCarrier}
  ftpData.ftpAuth:=authPtr
  ftpData.callersLog:=NIL
  ftpData.processMessages:={processMessages}
  ftpData.getSigs:={getSigs}

  doftp(ftpData,node,tempstr,ftpPorts,ftpDataPorts,fileList,'',cmds.acLvl[LVL_CAPITOLS_in_FILE]<>0,FALSE)

  END ftpData

  serialCacheEnabled:=oldSerCache

ENDPROC

->this returns 0 = fail, 1 = success unlike most of the routines
PROC downloadFiles(fileList: PTR TO stdlist, estimatedSize:PTR TO CHAR, updateDownloadStats, forceZmodem=FALSE)
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF debugstr[255]:STRING
  DEF xprio: PTR TO xprIO
  DEF result
  DEF time1,time2,ticks1,ticks2
  DEF oldshared
  DEF ftpPorts:PTR TO LONG,ftpDataPorts:PTR TO LONG,httpPorts:PTR TO LONG
  DEF zm=NIL: PTR TO zmodem_t
  DEF xym=NIL: PTR TO xymodem_t
  DEF hyd=NIL: PTR TO hydra_t
  DEF ext=TRUE
  DEF xmodemFlag=FALSE
  DEF ymodemFlag=FALSE
  DEF hydraFlag=FALSE
  DEF dlTimeTaken=0
  DEF ulTimeTaken=0
  DEF maxBlkSize=1024
  DEF internalName[10]:STRING
  DEF path[255]:STRING
  DEF txwindow,rxwindow
  DEF tmpBCD[8]:ARRAY OF CHAR
  
  DEF protocol[255]:STRING
  
  IF fileList.count()=0
    RETURN 0
  ENDIF
  
  IF netMailTransfer=FALSE
    IF (logonType<>LOGON_TYPE_REMOTE) AND (checkSecurity(ACS_LOCAL_DOWNLOADS)=FALSE)
      aePuts('\b\nNot supported locally...')
      RETURN 0
    ENDIF
  ENDIF

  IF xprLib.count()=0
    aePuts('\b\nNo transfer protocols are currently configured')
    RETURN 0
  ENDIF

  statWinType:=0

  IF forceZmodem OR (loggedOnUser=NIL)
    StrCopy(protocol,'INTERNAL')
  ELSE
    StrCopy(protocol,xprLib.item(loggedOnUser.xferProtocol))
  ENDIF

  IF(StriCmp(protocol,'INTERNAL'))
    StrCopy(internalName,'ZModem')
    ext:=FALSE
  ENDIF

  IF (StriCmp(protocol,'HYDRA'))
    StrCopy(protocol,'INTERNAL')
    StrCopy(internalName,'Hydra')
    hydraFlag:=TRUE
    statWinType:=1
    ext:=FALSE
  ENDIF

  IF(StriCmp(protocol,'INTERNALYM'))
    StrCopy(protocol,'INTERNAL')
    StrCopy(internalName,'YModem')
    ymodemFlag:=TRUE
    ext:=FALSE
  ENDIF

  IF(StriCmp(protocol,'INTERNALXM'))
    StrCopy(protocol,'INTERNAL')
    StrCopy(internalName,'XModem')
    xmodemFlag:=TRUE
    ext:=FALSE
  ENDIF

  IF(StriCmp(protocol,'INTERNAL8K'))
    StrCopy(protocol,'INTERNAL')
    StrCopy(internalName,'ZModem')
    maxBlkSize:=8192
    ext:=FALSE
  ENDIF

  IF (StriCmp(protocol,'XPRZM'))
    StrCopy(protocol,'INTERNAL')
    StrCopy(internalName,'ZModem')
    ext:=TRUE
  ENDIF

  zModemInfo.currentOperation:=ZMODEM_DOWNLOAD
  zModemInfo.shouldUpdateDownloadStats:=updateDownloadStats
  zModemInfo.needUpdateDownloadStats:=FALSE

  zModemInfo.currentDL:=0;zModemInfo.totalDL:=fileList.count();zModemInfo.transPos:=0;zModemInfo.filesize:=0;zModemInfo.errorCount:=0;zModemInfo.errorPos:=0; zModemInfo.resumePos:=0
  AstrCopy(zModemInfo.zStat,'')
  AstrCopy(zModemInfo.fileName,'')
  AstrCopy(zModemInfo.lastTime,'')

  IF (StriCmp(protocol,'FTP'))
    StrCopy(tempstr,'')
    StrCopy(tempstr2,'')
    readToolType(TOOLTYPE_BBSCONFIG,'','FTPPORT',tempstr)
    readToolType(TOOLTYPE_NODE,node,'FTPPORT',tempstr2)
    IF (StrLen(tempstr)>0) AND (StrLen(tempstr2)>0) THEN StrAdd(tempstr,',')
    StrAdd(tempstr,tempstr2)  
    
    ftpPorts:=makeIntList(tempstr)

    StrCopy(tempstr,'')
    StrCopy(tempstr2,'')
    readToolType(TOOLTYPE_BBSCONFIG,'','FTPDATAPORT',tempstr)
    readToolType(TOOLTYPE_NODE,node,'FTPDATAPORT',tempstr2)
    IF (StrLen(tempstr)>0) AND (StrLen(tempstr2)>0) THEN StrAdd(tempstr,',')
    StrAdd(tempstr,tempstr2)
    ftpDataPorts:=makeIntList(tempstr)

    IF ListLen(ftpPorts)=0 THEN ListAddItem(ftpPorts,10000+(node*2))
    IF ListLen(ftpDataPorts)=0 THEN ListAddItem(ftpDataPorts,10001+(node*2))
    wantzwin:=TRUE
    IF scropen
      openTransferStatWin()
    ENDIF
    result:=ftpDownload(fileList,updateDownloadStats,ftpPorts,ftpDataPorts)
    zModemInfo.currentOperation:=ZMODEM_NONE
    closeTransferStatWin()
    wantzwin:=FALSE

    DisposeLink(ftpPorts)
    DisposeLink(ftpDataPorts)
    RETURN result
  ENDIF

  IF (StriCmp(protocol,'HTTP'))
    StrCopy(tempstr,'')
    StrCopy(tempstr2,'')
    readToolType(TOOLTYPE_BBSCONFIG,'','HTTPPORT',tempstr)
    readToolType(TOOLTYPE_NODE,node,'HTTPPORT',tempstr2)
    IF (StrLen(tempstr)>0) AND (StrLen(tempstr2)>0) THEN StrAdd(tempstr,',')
    StrAdd(tempstr,tempstr2)
    httpPorts:=makeIntList(tempstr)

    IF ListLen(httpPorts)=0 THEN ListAddItem(httpPorts,20000+node)
    wantzwin:=TRUE
    IF scropen
      openTransferStatWin()
    ENDIF
    result:=httpDownload(fileList,updateDownloadStats,httpPorts)
    closeTransferStatWin()
    wantzwin:=FALSE
    zModemInfo.currentOperation:=ZMODEM_NONE
    DisposeLink(httpPorts)
    RETURN result
  ENDIF

  IF (logonType<>LOGON_TYPE_REMOTE)
    aePuts('\b\nNot supported locally...')
    RETURN 0
  ENDIF

  IF(StriCmp(protocol,'INTERNAL'))
    StringF(tempstr,'\s: Ready to Send\b\n',internalName)
  ELSEIF(checkSecurity(ACS_XPR_SEND)=FALSE)
    aePuts('\b\nYou are not allowed to download using external xpr protocols')
    RETURN 0
  ELSE
    StringF(tempstr,'\s: Ready to Send\b\n',xprTitle.item(loggedOnUser.xferProtocol))
  ENDIF

  aePuts(tempstr)
  ->aePuts('Control-X to Cancel\b\n')

  IF ext
    IF(StriCmp(protocol,'INTERNAL'))
      StrCopy(tempstr,'xprzmodem.library')
    ELSE
      StringF(tempstr,'\s.library',protocol)
    ENDIF
    IF (xprotocolbase:=OpenLibrary(tempstr,0))=NIL
      aePuts('\b\nUnable to open the xpr library\b\n')
      RETURN 0
    ENDIF
  ENDIF

  wantzwin:=TRUE
  IF scropen
    openTransferStatWin()
  ENDIF

  oldshared:=serShared
  serShared:=FALSE

  zModemRxBufferSize:=8192
  zmodemRxBuffer:=New(zModemRxBufferSize)

  IF ext
    xprio:=NEW xprio

    xprio.xpr_extension:=4
    xprio.xpr_fopen:={xprfopenAsm}
    xprio.xpr_fclose:={xprfcloseAsm}
    xprio.xpr_fread:={xprfreadAsm}
    xprio.xpr_fwrite:={xprfwriteAsm}
    xprio.xpr_sread:={xprsreadAsm}
    xprio.xpr_swrite:={xprswriteAsm}
    xprio.xpr_sflush:={xprsflushAsm}
    xprio.xpr_update:={xprupdateAsm}
    xprio.xpr_ffirst:={xprffirstAsm}
    xprio.xpr_fnext:={xprfnextAsm}
    xprio.xpr_chkabort:={xprchkabortAsm}
    xprio.xpr_chkmisc:=0
    xprio.xpr_gets:=0
    xprio.xpr_setserial:={xprsetserialAsm}
    xprio.xpr_finfo:={xprfinfoAsm}
    xprio.xpr_fseek:={xprfseekAsm}
    xprio.xpr_data:=0
    xprio.xpr_options:=0
    xprio.xpr_unlink:={xprunlink}
    xprio.xpr_squery:=0
    xprio.xpr_getptr:=0

    StrCopy(tempstr,'')
    IF(StriCmp(protocol,'INTERNAL'))
      StrCopy(tempstr,'TN,AY,OR,E9,KN,SN,RN,DN,B64')
    ELSE
      readToolType(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'OPTIONS',tempstr)
    ENDIF
  ELSE

    bufferedBytes:=0
    bufferReadOffset:=0
 
    IF hydraFlag
      txwindow:=readToolTypeInt(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'TXWINDOW')
      IF txwindow=-1 THEN txwindow:=0
      rxwindow:=readToolTypeInt(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'RXWINDOW')
      IF rxwindow=-1 THEN rxwindow:=0

      hyd:=NEW hyd
      hydra_init(hyd,0,0,0,txwindow,rxwindow)
      
      hyd.hyd_firstfile:={zmfirstfile}
      hyd.hyd_nextfile:={zmnextfile}
      hyd.hyd_open:={zmfopen}
      hyd.hyd_close:={zmfclose}
      hyd.hyd_seek:={zmfseek}
      hyd.hyd_read:={zmfread}
      hyd.hyd_write:={zmfwrite}
      hyd.hyd_dupecheck:={zmdupecheck}
      hyd.hyd_uploadcompleted:={zmuploadcompleted}
      hyd.hyd_downloadcompleted:={zmdownloadcompleted}
      hyd.hyd_uploadfailed:=NIL
      hyd.hyd_recvbyte:=IF telnetSocket>=0 THEN {zmrecvbyteTelnet} ELSE {zmrecvbyteSerial}
      hyd.hyd_flush:={zmflush}
      hyd.hyd_isconnected:={zmisconnected}
      hyd.hyd_iscancelled:=NIL
      hyd.hyd_logmessage:={debugLog}
      hyd.hyd_getkey:={hydgetkey}
      hyd.hyd_sysidle:={hydsysidle}
      hyd.hyd_chatwrite:={hydchatwrite}
      hyd.hyd_status:={hydstatus}
     
    ELSEIF xmodemFlag OR ymodemFlag
      xym:=NEW xym
        
      binaryRaw:=(telnetSocket>=0)
      xymodem_init(xym, 0,
            {debugLog},
            {zmprogress},
            IF telnetSocket>=0 THEN {zmrecvbyteTelnet} ELSE {zmrecvbyteSerial},
            {zmisconnected},
            {zmiscancelled},
            {zmdatawaiting},
            {zmuploadcompleted},
            {zmuploadfailed},
            {zmdownloadcompleted},
            {zmdupecheck},
            {zmflush},
            NIL,
            {zmfopen},
            {zmfclose},
            {zmfseek},
            {zmfread},
            {zmfwrite},
            {zmfirstfile},
            {zmnextfile},
            2048,0,binaryRaw,65536)
      xym.total_files:=fileList.count()
      IF estimatedSize THEN CopyMem(estimatedSize,xym.total_bytes,8) ELSE convertToBCD(0,xym.total_bytes)
    ELSE    
      zm:=NEW zm
      binaryRaw:=(telnetSocket>=0)
      zmodem_init(zm, 0,
            {debugLog},
            {zmprogress},
            IF telnetSocket>=0 THEN {zmrecvbyteTelnet} ELSE {zmrecvbyteSerial},
            {zmisconnected},
            {zmiscancelled},
            {zmdatawaiting},
            {zmuploadcompleted},
            {zmuploadfailed},
            {zmdownloadcompleted},
            {zmdupecheck},
            {zmflush},
            NIL,
            {zmfopen},
            {zmfclose},
            {zmfseek},
            {zmfread},
            {zmfwrite},
            {zmfirstfile},
            {zmnextfile},
            maxBlkSize,0,binaryRaw,65536)
      zm.total_files:=fileList.count()
      IF estimatedSize THEN CopyMem(estimatedSize,zm.total_bytes,8) ELSE convertToBCD(0,zm.total_bytes)
    ENDIF
  ENDIF
  
  asynciobase:=OpenLibrary('asyncio.library',0)

  IF telnetSocket>=0
    willsent:=0
    dosent:=0
    iac(telnetSocket,253,0) ->do binary
    iac(telnetSocket,251,0) ->will binary   
  ENDIF

  IF ext
    StringF(debugstr,'xpr setup options = \s',tempstr)
    debugLog(LOG_DEBUG,debugstr)
    xprio.xpr_filename:=tempstr
    IF XprotocolSetup(xprio)=0
      CloseLibrary(xprotocolbase)
      END xprio
      zModemInfo.currentOperation:=ZMODEM_NONE
      closeTransferStatWin()
      wantzwin:=FALSE
      Dispose(zmodemRxBuffer)
      RETURN 0
    ENDIF
  ENDIF

  ->cancel current queued serial read request
  stopSerialRead()

  result:=TRUE
  transfering:=TRUE
  cancelTransferOffHook:=FALSE
  lastIAC:=FALSE

  zModemInfo.currentDL:=0
  zModemInfo.fileList:=fileList

  IF ext
    xprio.xpr_filename:=NIL
    time1,ticks1:=getSystemTime()
    result:=XprotocolSend(xprio)
    time2,ticks2:=getSystemTime()
    dlTTTM:=Mul(time2-time1,50)+ticks2-ticks1;
    IF zModemInfo.transPos<>zModemInfo.filesize THEN result:=FALSE
  ELSE
    IF hydraFlag 
      ->hydra needs an upload path
      IF(StrLen(sopt.ramPen)>0) THEN StrCopy(path,sopt.ramPen) ELSE StringF(path,'\sNode\d/Playpen/',cmds.bbsLoc,node)
      result:=hydra_do_transfer(hyd,path,NIL,NIL,{dlTimeTaken},{ulTimeTaken})
      ulTTTM:=ulTimeTaken
    ELSEIF xmodemFlag OR ymodemFlag
      xym.user_data:=NIL
      result:=xymodem_send_files(ymodemFlag,xym, NIL,{dlTimeTaken})
    ELSE
      zm.user_data:=NIL
      result:=zmodem_send_files(zm, NIL,{dlTimeTaken})
    ENDIF
    dlTTTM:=dlTimeTaken
  ENDIF

  IF dlTTTM
    CopyMem(dTBT,tmpBCD,8)
    mulBCD(tmpBCD,50)
    tTCPS:=divBCD(tmpBCD,dlTTTM)
  ELSE
    tTCPS:=convertFromBCD(dTBT)
  ENDIF
  tTEFF:=calcEfficiency(tTCPS,onlineBaud)    

  IF telnetSocket>=0
    iac(telnetSocket,254,0) ->dont binary
    iac(telnetSocket,252,0) ->wont binary
  ENDIF

  IF ext
    XprotocolCleanup(xprio)
  ELSE
    IF hydraFlag 
      hydra_cleanup(hyd)
    ELSEIF xmodemFlag OR ymodemFlag
      xymodem_cleanup(xym)
    ELSE
      zmodem_cleanup(zm)
    ENDIF
  ENDIF
  transfering:=FALSE
  binaryRaw:=FALSE
  checkOffhookFlag()

  IF ext
    END xprio
  ELSE
    IF hyd<>NIL THEN END hyd
    IF xym<>NIL THEN END xym
    IF zm<>NIL THEN END zm
  ENDIF

  IF ext THEN CloseLibrary(xprotocolbase)

  IF asynciobase<>NIL THEN CloseLibrary(asynciobase)
  asynciobase:=NIL

  zModemInfo.currentOperation:=ZMODEM_NONE
  zModemInfo.fileList:=NIL
  closeTransferStatWin()
  wantzwin:=FALSE
  serShared:=oldshared

  ->restart normal serial
  queueSerialRead({serbuff})

  Dispose(zmodemRxBuffer)

  IF(StriCmp(protocol,'INTERNAL'))
    aePuts(internalName)
  ELSE
    aePuts(xprTitle.item(loggedOnUser.xferProtocol))
  ENDIF
  IF result THEN aePuts(' download successful\b\n') ELSE aePuts(' download unsuccessful\b\n')
  
ENDPROC result

PROC checklist(lfnames: PTR TO stdlist, sizeList:PTR TO stdlist, freeDFlagList:PTR TO stdlist, clrfinal: PTR TO stdlist)

  DEF i,status
  DEF item:PTR TO flagFileItem

  FOR i:=0 TO lfnames.count()-1
    item:=lfnames.item(i)
    IF(StrLen(item.fileName)>0)
      status:=checkForFileSize(item.fileName,'',item.confNum,sizeList,freeDFlagList,clrfinal,0)
      IF((status=RESULT_SIGNALLED) OR (status=RESULT_PRIVATE)) THEN RETURN RESULT_SUCCESS
    ENDIF
  ENDFOR
ENDPROC RESULT_SUCCESS

PROC displayUserToCallersLog(udonly)
  DEF tempStr[255]:STRING
  DEF tempStr2[10]:STRING
  DEF calltime

  IF(udonly=FALSE)
    callersLogDivider()
    callerIDLog(0)
  ELSE
   udLogDivider()
  ENDIF

  calltime:=getSystemTime()
  formatLongDate(calltime,tempStr)
  formatLongTime(calltime,tempStr2)
  IF(loggedOnUser.timesCalled=0)
    StringF(tempStr,'\s (\s) NEW [\d] \s (\s) \s',tempStr,tempStr2,loggedOnUser.slotNumber,loggedOnUser.name,connectString,loggedOnUser.location)
  ELSE
    StringF(tempStr,'\s (\s) [\d] \s (\s) \s',tempStr,tempStr2,loggedOnUser.slotNumber,loggedOnUser.name,connectString,loggedOnUser.location)
  ENDIF

  IF(udonly=FALSE)
    loggedOnUser.timesCalled:=loggedOnUser.timesCalled+1
    callersLog(tempStr)
    saveIPAddr()
    IF(logonType>=LOGON_TYPE_REMOTE) AND (checkToolTypeExists(TOOLTYPE_NODE,node,'LOG_HOST'))
      StringF(tempStr,'\tTelnet login address: \s (\s)',hostName,hostIP)
      callersLog(tempStr)
    ENDIF
  ELSE
    udLog(tempStr)
  ENDIF

ENDPROC

PROC saveIPAddr()
  DEF v[5]:STRING
  DEF i,v2, ip,p, p2
  p:=0
  ip:=0
  FOR i:=0 TO 3
    IF p>=0
      p2:=InStr(hostIP,'.',p)
      v2:=0
      IF p2>=0
        StrCopy(v,hostIP+p,p2-p)
        p:=p2+1
      ELSE
        StrCopy(v,hostIP+p)
        p:=StrLen(hostIP)
      ENDIF
      v2:=Val(v)
      ip:=Shl(ip,8) OR v2
    ENDIF    
  ENDFOR
  loggedOnUserMisc.lastIP:=ip
ENDPROC

PROC isascii(n) IS n<=127

->gets the actual name of a file (eg. you pass it a filename and it finds the correct case for it, so you can preserve the case)
PROC getFileName(s: PTR TO CHAR)
  DEF fBlock: fileinfoblock
  DEF fLock

  IF((fLock:=Lock(s,ACCESS_READ)))=NIL
    RETURN
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN
  ENDIF
  IF(Examine(fLock,fBlock)) THEN StrCopy(s,fBlock.filename)
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC

PROC getFileComment(s: PTR TO CHAR,outString)
  DEF fBlock: fileinfoblock
  DEF fLock

  StrCopy(outString,'')
  IF((fLock:=Lock(s,ACCESS_READ)))=NIL
    RETURN
  ENDIF

  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)
    RETURN
  ENDIF
  IF(Examine(fLock,fBlock)) THEN StrCopy(outString,fBlock.comment)
  UnLock(fLock)
  FreeDosObject(DOS_FIB,fBlock)
ENDPROC

PROC dynAllocate(maxbufsize)
  DEF pbuf
  DEF maxBuf
  DEF avail

  maxBuf:=readToolTypeInt(TOOLTYPE_NODE,node,'COPYBUFFER')
  IF (maxBuf>0) AND (maxbufsize>maxBuf) THEN maxbufsize:=maxBuf

  avail:=AvailMem(MEMF_LARGEST)
  IF maxbufsize>avail THEN maxbufsize:=avail-65536

  /* first try Fast mem allocate */
  WHILE((pbuf:=AllocMem(maxbufsize,MEMF_PUBLIC OR MEMF_CLEAR)))=FALSE
    maxbufsize:=maxbufsize-65536;
    EXIT (maxbufsize<65536)
    Delay(5)
  ENDWHILE
  IF(maxbufsize<8192)  THEN RETURN 0,0
ENDPROC pbuf,maxbufsize


PROC fileCopy(from,to)
  DEF buf:PTR TO CHAR
  DEF bufsize,stat1,stat2
  DEF fhs,fhd
  DEF tempstr[255]:STRING
  ->if(Rename(from,to)) return(2);

  buf,bufsize:=dynAllocate(FileLength(from)+8192)
  IF(buf<>NIL)
    /* got a buffer full of mem */
    IF(fhs:=Open(to,MODE_OLDFILE))
          Close(fhs);                 /* file exists so return */
      FreeMem(buf,bufsize);
        RETURN RESULT_SUCCESS
      ENDIF

    IF(fhs:=Open(from,MODE_OLDFILE))
      IF(fhd:=Open(to,MODE_NEWFILE))
        REPEAT
          stat1:=Read(fhs,buf,bufsize)   /* Read from file */
          IF(stat1>0)   THEN stat2:=Write(fhd,buf,stat1) /* write to file*/
        UNTIL (stat1<=0) OR (stat2<=0)

        IF(stat1<0)
          StringF(tempstr,'\b\nERROR while reading from \s!\b\n',from)
          aePuts(tempstr)
        ENDIF
        IF(stat2<0)
          StringF(tempstr,'\b\nERROR while writing to \s!\b\n',to)
          aePuts(tempstr);
        ENDIF
        Close(fhd)
      ELSE
        StringF(tempstr,'\b\nERROR while opening \s for writing!\b\n',to)
        aePuts(tempstr);
      ENDIF
      Close(fhs)
    ELSE
      StringF(tempstr,'\b\nERROR while opening \s for reading!\b\n',from)
      aePuts(tempstr)
    ENDIF
    FreeMem(buf,bufsize)
  ENDIF

  IF(((stat1>=0) AND (stat2>=0)))
    RETURN 1
  ENDIF

  ->if we get an error then remove the destination file
  DeleteFile(to)
ENDPROC 0

PROC moveFile(filename,filesize)
  DEF stat
  DEF spacehi,spacelo
  DEF pathnum
  DEF goodtogo=0
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF tempstr3[255]:STRING

  IF(filesize=0)
    errorLog('(mf 518)')
    RETURN 0
  ENDIF

  filesize:=(Shr(filesize,20) AND $00000fff)+1       ->changed to take account of disk space now in mb

  pathnum:=1
  StringF(tempstr3,'ULPATH.\d',pathnum)
  pathnum++

  WHILE(readToolType(TOOLTYPE_CONF,currentConf,tempstr3,tempstr3))
    checkPathSlash(tempstr3)
    spacehi,spacelo:=rFreeSpace(tempstr3)
    IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'\s\s',sopt.ramPen,filename) ELSE StringF(tempstr,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,filename)
    StringF(tempstr2,'\s\s',tempstr3,filename)
    IF(Rename(tempstr,tempstr2))
      SetProtection(tempstr,FIBF_OTR_DELETE)
      DeleteFile(tempstr)
      StringF(tempstr,'\tUpload moved to \s',tempstr2)
      callersLog(tempstr)
      aePuts(' File Posted\b\n\b\n')
      RETURN 1
    ELSE
      StringF(tempstr3,'WARNING could not rename file \s to \s, \s, code: \d',tempstr,tempstr2,IoErr())
      ->debugLog(LOG_WARN,tempstr3)
      errorLog(tempstr3)
    ENDIF
    IF(spacehi>=filesize)
      goodtogo:=1
      IF(stat:=fileCopy(tempstr,tempstr2))
        SetProtection(tempstr,FIBF_OTR_DELETE)
        DeleteFile(tempstr)
        StringF(tempstr,'\tUpload moved to \s',tempstr2)
        callersLog(tempstr)
        aePuts(' File Posted\b\n\b\n')
        RETURN 1
      ENDIF
    ELSE
      StringF(tempstr3,'stat: \d, filesize: \d',stat,filesize)
      ->debugLog(LOG_WARN,tempstr3)
      errorLog(tempstr3)
    ENDIF
    StringF(tempstr3,'ULPATH.\d',pathnum)
    pathnum++
  ENDWHILE
  IF(goodtogo=FALSE)
    aePuts('WARNING!\b\nNO FREE SPACE on any path!  While moving to upload dir...')
    errorLog('WARNING!NO FREE SPACE on any path!  While moving to upload dir...')
  ENDIF

  aePuts('FAILURE!!!  unable to move file!\b\n\b\n')
  StringF(tempstr,'\tFAILURE!, unable to move file \s from PlayPen',filename)
  callersLog(tempstr);
  IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'\s\s',sopt.ramPen,filename) ELSE StringF(tempstr,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,filename)
  SetProtection(tempstr,FIBF_OTR_DELETE)
  DeleteFile(tempstr)
ENDPROC 0

PROC hydgetkey()
  DEF temp=0, readreq:PTR TO iostd
  
  IF hydraConsoleReadMP=NIL THEN RETURN -1
  IF NIL=(readreq:=GetMsg(hydraConsoleReadMP)) THEN RETURN -1
  temp:=conbuf[]  -> Get the character...
  queueHydraConsoleRead(conbuf) -> ...then re-use the request block
ENDPROC temp

PROC hydsysidle()
  DEF tv:timeval
  DEF consig,serialsig1,serialsig2,timersig,signals

  IF hydraConsoleReadMP<>NIL THEN consig:=Shl(1, hydraConsoleReadMP.sigbit)
  IF telnetSocket>=0
    tv.secs:=1
    tv.micro:=0
    setSingleFDS(fds,telnetSocket)
    WaitSelect(telnetSocket+1,fds,fds,0,tv,{consig})
  ELSE
    /*openTimer()
    setTimer(1,0)
    IF serialReadMP<>NIL THEN serialsig1:=Shl(1, serialReadMP.sigbit)
    IF serialWriteMP<>NIL THEN serialsig2:=Shl(1, serialWriteMP.sigbit)
    IF timerport<>NIL THEN timersig:=Shl(1, timerport.sigbit)
    signals:=Wait(consig OR serialsig1 OR serialsig2 OR timersig)
    IF (signals AND timersig)=0
      stopTime()
    ELSE
      waitTime()
    ENDIF
    closeTimer()*/
  ENDIF
  processMessages()
ENDPROC

PROC hydstatus(hyd:PTR TO hydra_t,xmit)
  DEF pos,fsize,start1,start2,elapsed,cps,est,t1,t2
  DEF s[255]:STRING
  DEF fname,status,resumepos,errcount,errpos
  DEF wnum
  DEF tags2
  DEF rport
  DEF vi,v1,v2,xpos
  DEF tempstr[255]:STRING
  DEF elapsedStr[30]:STRING
  DEF etaStr[30]:STRING
  DEF hrs,mins,secs
  DEF updateTime
  DEF newfile

  
  IF xmit
    pos:=hyd.txpos
    fsize:=hyd.txfsize
    start1:=hyd.txstart1
    start2:=hyd.txstart2
    fname:=hyd.txfname
    status:=hyd.txstatus
    resumepos:=hyd.rxresumepos
    errcount:=0
    errpos:=hyd.txerrorpos
    newfile:=hyd.txnewfile
  ELSE 
    pos:=hyd.rxpos
    fsize:=hyd.rxfsize
    start1:=hyd.rxstart1
    start2:=hyd.rxstart2
    fname:=hyd.rxfname
    status:=hyd.rxstatus
    resumepos:=0
    errcount:=0
    errpos:=0
    newfile:=hyd.rxnewfile
  ENDIF

  IF newfile 
    IF ((zModemInfo.currentOperation=ZMODEM_DOWNLOAD) AND (xmit)) OR ((zModemInfo.currentOperation=ZMODEM_UPLOAD) AND (xmit=FALSE))
      AstrCopy(zModemInfo.fileName,fname,255)
      zModemInfo.filesize:=fsize
      zModemInfo.resumePos:=resumepos
      logUDFile(xmit)
    ENDIF
  ENDIF


  updateTime:=getSystemTime()
  IF zModemInfo.lastUpdate=updateTime THEN RETURN
  zModemInfo.lastUpdate:=updateTime

  t1,t2:=getSystemTime()
  IF start1>0
    elapsed:=Div(Mul((t1-start1),50)+t2-start2,50)
  ELSE
    elapsed:=0
  ENDIF

  IF(elapsed AND (pos >= 1024))
     cps:=Div(pos,elapsed)
  ELSE
    cps:=pos
  ENDIF
  IF cps*10 >hyd.cur_speed THEN hyd.cur_speed:=cps*10

  IF ((zModemInfo.currentOperation=ZMODEM_DOWNLOAD) AND (xmit)) OR ((zModemInfo.currentOperation=ZMODEM_UPLOAD) AND (xmit=FALSE))
    makeCpsText(cps,s)
    sendACPCommand2(s,JH_TRANSFERCPS)
  ENDIF
  
  IF (hydraWindow1=NIL) OR (hydraWindow2=NIL) THEN RETURN

  IF xmit THEN wnum:=1 ELSE wnum:=0

  IF elapsed=0
    StrCopy(elapsedStr,'N/A')
  ELSE
    hrs:=Div(elapsed,3600)
    mins:=Mod(elapsed,3600)
    secs:=Mod(mins,60)
    mins:=Div(mins,60)
    
    StringF(elapsedStr,'\z\r\d[2]:\z\r\d[2]:\z\r\d[2]',hrs,mins,secs)
  ENDIF

  IF cps=0 
    StrCopy(etaStr,'N/A')
  ELSE
    est:=Div(fsize,cps)
    hrs:=Div(est,3600)
    mins:=Mod(est,3600)
    secs:=Mod(mins,60)
    mins:=Div(mins,60)
    StringF(etaStr,'\z\r\d[2]:\z\r\d[2]:\z\r\d[2]',hrs,mins,secs)
  ENDIF

  hydraStatPrint(wnum,'[H[J[0 p')
  StringF(s,'[H FileName: \s\n',fname)
  hydraStatPrint(wnum,s)
  StringF(s,' FileSize: \d\n',fsize)
  hydraStatPrint(wnum,s)
  StringF(s,' ETA Time: \s\n',etaStr)
  hydraStatPrint(wnum,s)
  StringF(s,' Cur Time: \s\n',elapsedStr)
  hydraStatPrint(wnum,s)
  StringF(s,' Position: \d\n',pos)
  hydraStatPrint(wnum,s)
  StringF(s,' Resume P: \d\n',resumepos)
  hydraStatPrint(wnum,s)

  IF xmit THEN rport:=hydraWindow2.rport ELSE rport:=hydraWindow1.rport
  
  IF(fsize=0)
      hydraStatPrint(wnum,' Complete: N/A\n')
      SetAPen(rport,0)
      RectFill(rport,11,130,282,137)
  ELSE
      IF fsize<100
        StringF(tempstr,' Complete: \d%\n',Div(Mul(pos,100),fsize))
      ELSE
        StringF(tempstr,' Complete: \d%\n',Div(pos,Div(fsize,100)))
      ENDIF
      hydraStatPrint(wnum,tempstr)

      v1:=pos
      v2:=fsize
      IF (v2<=0) OR (v1<=0)
        xpos:=11
      ELSE
        IF v2>=1048576
          v1:=Shr(v1,10) AND $003fffff
          v2:=Shr(v2,10) AND $003fffff
        ENDIF
        xpos:=11+Div(Mul(v1,271),v2)
      ENDIF

      IF xpos>11
        SetAPen(rport,1)
        RectFill(rport,11,130,xpos,137)
      ENDIF

      IF xpos<282
        SetAPen(rport,0)
        RectFill(rport,xpos+1,130,282,137)
      ENDIF
  ENDIF 
  StringF(s,' LastTime:\n')
  hydraStatPrint(wnum,s)
  StringF(s,'     CPS: \d\n\n',cps)
  hydraStatPrint(wnum,s)
  StringF(s,' Status  : \s\n',status)
  hydraStatPrint(wnum,s)
  StringF(s,' Errors  : \s\n',errcount)
  hydraStatPrint(wnum,s)
  StringF(s,' ErrorPos: \s\n',errpos)
  hydraStatPrint(wnum,s)

  IF (gadtoolsbase:=OpenLibrary('gadtools.library',0))<>NIL
    vi:=GetVisualInfoA(screen, [NIL])
    tags2:=NEW [GT_VISUALINFO,vi,TAG_DONE]

    DrawBevelBoxA(rport,9,129,276,10,tags2)
    FreeVisualInfo(vi)
    FastDisposeList(tags2)
    CloseLibrary(gadtoolsbase)
  ENDIF
ENDPROC/*hydra_status()*/

PROC zmprogress(pos,cnt,filesize,s1,s2,errors,startpos,filename:PTR TO CHAR,newfile,blocksize)
  DEF t1,t2,t,td,n
  DEF h,m,s
  DEF tempStr[255]:STRING
  DEF updateTime

  t1,t2:=getZmSystemTime()
  td:=Mul((t1-s1),50)+t2-s2
  
  IF (td>50)
    IF (cnt>40000000)
      n:=Div(cnt,Div(td,50)) 
    ELSE
      n:=Div(Mul(cnt,50),td) 
    ENDIF
  ELSE
    n:=cnt
  ENDIF
  t:=Div(td,50)
  
  h:=Div(t,3600)
  m:=Mod(t,3600)
  s:=Mod(m,60)
  m:=Div(m,60)
  
  StringF(tempStr,'\z\r\d[2]:\z\r\d[2]:\z\r\d[2]',h,m,s)
  AstrCopy(zModemInfo.elapsedTime,tempStr,40)

  IF n>0
    t:=Div(filesize,n)
    h:=Div(t,3600)
    m:=Mod(t,3600)
    s:=Mod(m,60)
    m:=Div(m,60)
    StringF(tempStr,'\z\r\d[2]:\z\r\d[2]:\z\r\d[2]',h,m,s)
  ELSE
    StrCopy(tempStr,'??:??:??')
  ENDIF
  AstrCopy(zModemInfo.apxTime,tempStr,40)
 
  zModemInfo.filesize:=filesize
  zModemInfo.errorCount:=errors

  zModemInfo.resumePos:=startpos
  AstrCopy(zModemInfo.fileName,filename,255)

  tTCPS:=n
  tTEFF:=calcEfficiency(tTCPS,onlineBaud)

  IF pos>=0
    zModemInfo.transPos:=pos
    IF pos=filesize THEN AstrCopy(zModemInfo.lastTime,zModemInfo.elapsedTime,40)
  ENDIF

  IF newfile THEN logUDFile(zModemInfo.currentOperation=ZMODEM_DOWNLOAD)

  updateTime:=getSystemTime()
  IF zModemInfo.lastUpdate<>updateTime
    updateZDisplay()   
    debugLog(LOG_DEBUG,'zmprogress update')
    StringF(tempStr,'current block size: \d',blocksize)
    debugLog(LOG_DEBUG,tempStr)
    zModemInfo.lastUpdate:=updateTime

    processMessages()
    checkCarrier()
  ENDIF
ENDPROC

PROC zmrecvbyteTelnet(timeout)
  DEF res
  DEF r
  DEF tv:timeval
  ->DEF sysTime
 
  MOVE.L bufferReadOffset,A0
  MOVE.L bufferedBytes,A1
  MOVE.L zmodemRxBuffer,A2
repbuff:
  CMPA.L A1,A0
  BGE buffempty
  ADD.L A2,A0
  CLR.L D0
  MOVE.B (A0)+,D0
  SUB.L       A2,A0
  
  MOVE.L lastIAC,D2
  BNE.S testiac
  CMP.B #255,D0
  BEQ.S testiac
  MOVE.L A0,bufferReadOffset
  BRA recret
  
testiac:
  CMP.B #1,D2
  BNE.S testiac2

  CMP.B #255,D0
  BNE.S test1

  CLR.L D2
  MOVE.L D2,lastIAC
  MOVE.L A0,bufferReadOffset
  BRA recret

test1:
  MOVEQ.L #2,D2
  MOVE.L D2,lastIAC
  MOVE.L D0,iaccmd
  BRA repbuff
  
testiac2:
  CMP.B #2,D2
  BNE testiac3

  TST.B D0
  BNE notbin
  
  CMP.L #251,iaccmd
  BNE.S notwill
  
  TST.L dosent
  BNE.S notwill
  MOVEM.L D0-D7/A0-A6,-(A7)
  iac(telnetSocket,253,0) ->if will binary then do binary
  dosent:=1
  MOVEM.L (A7)+,D0-D7/A0-A6
  
notwill:
  CMP.L #253,iaccmd
  BNE.S notdo

  TST.L willsent
  BNE.S notdo
  MOVEM.L D0-D7/A0-A6,-(A7)
  iac(telnetSocket,251,0) ->if do binary then will binary
  willsent:=1
  MOVEM.L (A7)+,D0-D7/A0-A6

notdo:
notbin:  
  CLR.L D2
  MOVE.L D2,lastIAC
  BRA repbuff
  
testiac3:
  CMP.B #255,D0
  BNE repbuff
  MOVEQ.L #1,D2
  MOVE.L D2,lastIAC
  BRA repbuff
  
buffempty:

  res:=1
    bufferReadOffset:=0
    bufferedBytes:=0
  IF timeout

    tv.secs:=timeout
    tv.micro:=0
    setSingleFDS(fds,telnetSocket)
    res:=WaitSelect(telnetSocket+1,fds,NIL,NIL,tv,NIL)

    r:=-1
  ENDIF
  IF res>0
    IoctlSocket(telnetSocket,FIONBIO,[1])
    IF (r:=Recv(telnetSocket,zmodemRxBuffer,zModemRxBufferSize,0))<>-1
      bufferedBytes:=bufferedBytes+r
    ENDIF
    ENDIF

  IF r<=0
    IF (checkCarrier()=FALSE) THEN RETURN -1
  ENDIF
  
  IF bufferedBytes
    SUB.L A0,A0
    MOVE.L bufferedBytes,A1
    MOVE.L zmodemRxBuffer,A2
    JUMP repbuff
  ENDIF
  
  /*REPEAT
redo1:
    IF (bufferReadOffset<bufferedBytes)
      REPEAT
        res:=zmodemRxBuffer[bufferReadOffset]
        bufferReadOffset++
        IF (lastIAC=0) AND (res<>255) THEN RETURN res
        
        IF lastIAC=1
          IF res=255
            lastIAC:=0
            RETURN res
          ELSEIF (res>=250) AND (res<255)
            lastIAC:=2        
            iac1:=res
          ELSE
            WriteF('unknown IAC \d\b\n',res)
            lastIAC:=2        
          ENDIF
        ELSEIF lastIAC=2
          IF res=0
            IF iac1=251 
              //will
              iacr[0]:=255
              iacr[1]:=253
              iacr[2]:=0
              serPuts(iacr,3,TRUE,TRUE)
            ELSEIF iac1=253
              //do
              iacr[0]:=255
              iacr[1]:=251
              iacr[2]:=0
              serPuts(iacr,3,TRUE,TRUE)
            ENDIF
          ENDIF
          lastIAC:=0
        ELSEIF res=255
          lastIAC:=1
        ENDIF
     
      UNTIL (bufferReadOffset>=bufferedBytes)
      JUMP redo1
    ELSE
      tv.secs:=timeout
      tv.micro:=0
      setSingleFDS(fds,telnetSocket)
      res:=WaitSelect(telnetSocket+1,fds,NIL,NIL,tv,NIL)

      bufferReadOffset:=0
      bufferedBytes:=0
      n:=zModemRxBufferSize     
      REPEAT
        IF (r:=Recv(telnetSocket,zmodemRxBuffer+bufferedBytes,n,0))<>-1
          bufferedBytes:=bufferedBytes+r
        ENDIF
        n:=(zModemRxBufferSize-bufferedBytes)     
      UNTIL (r=-1) OR (n=0)
        
      sysTime:=getSystemTime()
      
      IF ((lastCarrierCheck+5)<sysTime)
        IF checkCarrier()=FALSE THEN RETURN -1
        lastCarrierCheck:=sysTime
      ENDIF
    ENDIF
  UNTIL (timeout=0)*/
  MOVE.L #-1,D0
recret:
ENDPROC D0

PROC zmrecvbyteSerial(timeout)
  DEF serialsig,signals,timersig=0,res
  DEF waiting,abort
  
  IF (bufferReadOffset<bufferedBytes)
    res:=zmodemRxBuffer[bufferReadOffset]
    bufferReadOffset++
    RETURN res
  ENDIF
  
  bufferReadOffset:=0
  bufferedBytes:=0
  
  waiting:=getSerialInfo()
  IF waiting>zModemRxBufferSize THEN waiting:=zModemRxBufferSize
  IF(waiting > 0)
    doSerialRead(zmodemRxBuffer,waiting)
    bufferedBytes:=serialReadIO.iostd.actual
    serialReadIO.iostd.actual:=0
  ENDIF  

  IF (bufferedBytes>0)
    res:=zmodemRxBuffer[bufferReadOffset]
    bufferReadOffset++
    RETURN res
  ENDIF

  IF timeout=0 THEN RETURN -1

  openTimer()
  setTimer(timeout,0)
  IF timerport<>NIL THEN timersig:=Shl(1, timerport.sigbit)

  queueSerialRead(zmodemRxBuffer,zModemRxBufferSize)
  serialsig:=Shl(1, serialReadMP.sigbit)

  signals:=Wait(SIGBREAKF_CTRL_C OR serialsig OR timersig)
  abort:=signals AND SIGBREAKF_CTRL_C

  IF signals AND timersig THEN waitTime() ELSE stopTime()
  closeTimer()

  IF (signals AND serialsig)=FALSE THEN stopSerialRead() ELSE waitSerialRead()

  IF(serialReadIO.iostd.actual > 0)
    bufferedBytes:=serialReadIO.iostd.actual
  ENDIF

  IF bufferedBytes=0 
    res:=-1
  ELSE
    res:=zmodemRxBuffer[bufferReadOffset]
    bufferReadOffset++
  ENDIF
  checkCarrier()

  IF abort THEN res:=-1
ENDPROC res

PROC zmisconnected() IS lostCarrier=FALSE
 
PROC zmiscancelled() IS xprchkabort()

PROC zmdatawaiting(timeout)
  DEF signals,timersig,serialsig,recvd=0,waiting
  DEF tv:timeval

  IF bufferedBytes>bufferReadOffset 
    RETURN TRUE
  ENDIF

  waiting:=getSerialInfo()
  IF (waiting>0) OR checkTelnetData() THEN RETURN TRUE

  IF timeout=0 THEN RETURN FALSE

  IF telnetSocket>=0  
    setSingleFDS(fds,telnetSocket)
    tv.secs:=timeout
    tv.micro:=0
    WaitSelect(telnetSocket+1,fds,NIL,NIL,tv,NIL)
    IF checkTelnetData() THEN  recvd:=TRUE
  ELSE
    openTimer()
    setTimer(timeout,0)
    serialsig:=Shl(1, serialReadMP.sigbit)
    IF timerport<>NIL THEN timersig:=Shl(1, timerport.sigbit)
    signals:=Wait(SIGBREAKF_CTRL_C OR serialsig OR timersig)
    recvd:=(signals AND serialsig)<>0
    IF (signals AND timersig)=0
      stopTime()
    ELSE
      waitTime()
    ENDIF
    closeTimer()
  ENDIF

ENDPROC recvd
 
PROC zmuploadcompleted(fname:PTR TO CHAR,filesize) 
  IF loggedOnUserKeys<>NIL
    addBCD(uTBT,filesize)
    recFileNames.add(FilePart(fname))
    ulFileCount++
    doBgCheck()
  ENDIF
ENDPROC

PROC zmuploadfailed(fname:PTR TO CHAR) IS xprunlink2(fname)

PROC zmdupecheck(fname:PTR TO CHAR)
  DEF dup=FALSE
  IF (netMailTransfer=FALSE) AND (sysopUploading=FALSE) AND (rzmsg=FALSE)
    IF checkForFile(FilePart(fname))
      dup:=TRUE
    ELSEIF checkInPlaypens(FilePart(fname))
      dup:=TRUE
    ENDIF
  ENDIF

  IF dup
    skipdFiles.add(FilePart(fname))
  ELSE
    IF zModemInfo.currentOperation=ZMODEM_UPLOAD
      ->dont do this if we are not in upload mode (eg hydra uploading during download)
      sendMasterUpload(FilePart(fname))
    ENDIF
  ENDIF
ENDPROC dup

PROC zmflush(buffer,size) IS serPuts(buffer,size,TRUE,TRUE)

PROC zmfopen(fn:PTR TO CHAR,filemode)
  DEF res
  IF (filemode<>MODE_OLDFILE) AND (zModemInfo.currentOperation=ZMODEM_UPLOAD) THEN zModemInfo.currentUL:=zModemInfo.currentUL+1

  IF asynciobase<>NIL
    IF filemode=MODE_OLDFILE 
      res:=OpenAsync(fn,MODE_READ,65536)
    ELSEIF filemode=MODE_NEWFILE
      res:=OpenAsync(fn,MODE_WRITE,65536)
    ELSEIF filemode=MODE_READWRITE
      res:=OpenAsync(fn,MODE_APPEND,65536)
    ENDIF
  ELSE
    res:=Open(fn,filemode)
  ENDIF
ENDPROC res

PROC zmfclose(fh)
  IF asynciobase<>NIL
    CloseAsync(fh)
  ELSE
    Close(fh)
  ENDIF
ENDPROC

PROC zmdownloadcompleted(fsize,sentsize)
  DEF fileItem:PTR TO flagFileItem
  fileItem:=zModemInfo.fileList.item(zModemInfo.currentDL)
  removeFlagFromList(FilePart(fileItem.fileName),fileItem.confNum)
  updateDownloadStats(fileItem,fsize,sentsize) 
ENDPROC

PROC zmfseek(fh,offset,origin)
  DEF res
  IF asynciobase<>NIL
    IF origin=OFFSET_BEGINNING
      res:=SeekAsync(fh,offset,MODE_START)
    ELSEIF origin=OFFSET_CURRENT
      res:=SeekAsync(fh,offset,MODE_CURRENT)
    ELSEIF origin=OFFSET_END
      res:=SeekAsync(fh,offset,MODE_END)
    ENDIF
  ELSE
    res:=Seek(fh,offset,origin)
  ENDIF
ENDPROC res

PROC zmfread(fh,buf,size)
  DEF res
  IF asynciobase<>NIL
    res:=ReadAsync(fh,buf,size)
  ELSE
    res:=Fread(fh,buf,1,size)
  ENDIF 
ENDPROC res

PROC zmfwrite(fh,buf,size)
  DEF res
  IF asynciobase<>NIL
    res:=WriteAsync(fh,buf,size)
  ELSE
    res:=Fwrite(fh,buf,1,size)
  ENDIF
ENDPROC res

PROC zmfirstfile(fname:PTR TO CHAR) IS xprffirst2(fname)
PROC zmnextfile(fname:PTR TO CHAR) IS xprfnext2(fname)

PROC createBackgroundFileCheckThread()
  DEF bgCheckPort=0,bgStack
  DEF tags=NIL:PTR TO LONG
  DEF proc:PTR TO process

  transfering:=TRUE
  bgChecking:=TRUE
  bgStack:=readToolTypeInt(TOOLTYPE_NODE,node,'BGFILECHECKSTACK')
  IF bgStack<=0 THEN bgStack:=20000

  tags:=NEW [NP_ENTRY,{backgroundFileCheckThread},NP_STACKSIZE,bgStack,TAG_DONE]
  Forbid()
  proc:=CreateNewProc(tags)
  FastDisposeList(tags)
  IF proc<>NIL
    saveA4(proc.task,{threadtasksA4})
  ELSE
    transfering:=FALSE
    bgChecking:=FALSE
  ENDIF
  Permit()     
  bgCheckPort:=FindPort(bgCheckPortName)
  IF proc<>0
    IF bgCheckPort=0
      REPEAT
        Delay(10)
        bgCheckPort:=FindPort(bgCheckPortName)
      UNTIL bgCheckPort<>0
    ENDIF
  ENDIF
    
ENDPROC bgCheckPort

PROC fileUpload(file,forceZmodem=FALSE) HANDLE
  DEF tempstr[255]:STRING,tempstr2[255]:STRING,debugstr[255]:STRING
  DEF result
  DEF xprio=NIL: PTR TO xprIO
  DEF time1,time2,ticks1,ticks2
  DEF oldshared,bgport
  DEF internalName[10]:STRING
  DEF msg:PTR TO jhMessage,tags=NIL:PTR TO LONG
  DEF ftpPorts:PTR TO LONG,ftpDataPorts:PTR TO LONG,httpPorts:PTR TO LONG
  DEF protocol[255]:STRING
  
  DEF zm=NIL: PTR TO zmodem_t
  DEF xym=NIL: PTR TO xymodem_t
  DEF hyd=NIL: PTR TO hydra_t
  DEF ymodemFlag=FALSE
  DEF xmodemFlag=FALSE
  DEF hydraFlag=FALSE
  DEF maxBlkSize=1024
  DEF ulTimeTaken
  DEF ext=TRUE
  DEF txwindow,rxwindow
  DEF tmpBCD[8]:ARRAY OF CHAR

  statWinType:=0

  ObtainSemaphore(bgData)
  bgData.checkedCount:=0
  convertToBCD(0,bgData.checkedBytes)
  
  ReleaseSemaphore(bgData)

  IF (forceZmodem) OR (loggedOnUser=NIL)
    StrCopy(protocol,'INTERNAL')
  ELSE
    StrCopy(protocol,(xprLib.item(loggedOnUser.xferProtocol)))
  ENDIF

  IF(StriCmp(protocol,'INTERNAL'))
    StrCopy(internalName,'ZModem')
    ext:=FALSE
  ENDIF

  IF(StriCmp(protocol,'HYDRA'))
    StrCopy(protocol,'INTERNAL')
    hydraFlag:=TRUE
    statWinType:=1
    StrCopy(internalName,'Hydra')
    ext:=FALSE
  ENDIF

  IF(StriCmp(protocol,'INTERNALXM'))
    StrCopy(protocol,'INTERNAL')
    xmodemFlag:=TRUE
    StrCopy(internalName,'XModem')
    ext:=FALSE
  ENDIF

  IF(StriCmp(protocol,'INTERNALYM'))
    StrCopy(protocol,'INTERNAL')
    ymodemFlag:=TRUE
    StrCopy(internalName,'YModem')
    ext:=FALSE
  ENDIF

  IF(StriCmp(protocol,'INTERNAL8K'))
    StrCopy(protocol,'INTERNAL')
    maxBlkSize:=8192
    StrCopy(internalName,'ZModem')
    ext:=FALSE
  ENDIF

  IF (StriCmp(protocol,'XPRZM'))
    StrCopy(internalName,'ZModem')
    StrCopy(protocol,'INTERNAL')
    ext:=TRUE
  ENDIF

  zModemInfo.currentUL:=0; zModemInfo.transPos:=0; zModemInfo.filesize:=0; zModemInfo.errorCount:=0; zModemInfo.errorPos:=0; zModemInfo.resumePos:=0
  AstrCopy(zModemInfo.zStat,'')
  AstrCopy(zModemInfo.fileName,'')
  AstrCopy(zModemInfo.apxTime,'')
  AstrCopy(zModemInfo.lastTime,'')

  IF(StriCmp(protocol,'INTERNAL'))
    StrCopy(tempstr,'xprzmodem.library')
  ELSEIF (StriCmp(protocol,'FTP'))

    StrCopy(tempstr,'')
    StrCopy(tempstr2,'')
    readToolType(TOOLTYPE_BBSCONFIG,'','FTPPORT',tempstr)
    readToolType(TOOLTYPE_NODE,node,'FTPPORT',tempstr2)
    IF (StrLen(tempstr)>0) AND (StrLen(tempstr2)>0) THEN StrAdd(tempstr,',')
    StrAdd(tempstr,tempstr2)
    ftpPorts:=makeIntList(tempstr)

    StrCopy(tempstr,'')
    StrCopy(tempstr2,'')
    readToolType(TOOLTYPE_BBSCONFIG,'','FTPDATAPORT',tempstr)
    readToolType(TOOLTYPE_NODE,node,'FTPDATAPORT',tempstr2)
    IF (StrLen(tempstr)>0) AND (StrLen(tempstr2)>0) THEN StrAdd(tempstr,',')
    StrAdd(tempstr,tempstr2)
    ftpDataPorts:=makeIntList(tempstr)

    IF ListLen(ftpPorts)=0 THEN ListAddItem(ftpPorts,10000+(node*2))
    IF ListLen(ftpDataPorts)=0 THEN ListAddItem(ftpDataPorts,10001+(node*2))
    
    zModemInfo.currentOperation:=ZMODEM_UPLOAD
    wantzwin:=TRUE
    IF scropen
      openTransferStatWin()
    ENDIF
    ftpUpload(file,ftpPorts,ftpDataPorts)
    DisposeLink(ftpPorts)
    DisposeLink(ftpDataPorts)
    closeTransferStatWin()
    wantzwin:=FALSE
    checkOffhookFlag()
    receivePlayPen(TRUE)
    IF (ulTTTM>0)
      tTEFF:=calcEfficiency(divBCD(uTBT,ulTTTM),onlineBaud)
    ELSE
      tTEFF:=0
    ENDIF
    RETURN 1
  ELSEIF (StriCmp(protocol,'HTTP'))

    StrCopy(tempstr,'')
    StrCopy(tempstr2,'')
    readToolType(TOOLTYPE_BBSCONFIG,'','HTTPPORT',tempstr)
    readToolType(TOOLTYPE_NODE,node,'HTTPPORT',tempstr2)
    IF (StrLen(tempstr)>0) AND (StrLen(tempstr2)>0) THEN StrAdd(tempstr,',')
    StrAdd(tempstr,tempstr2)
    httpPorts:=makeIntList(tempstr)

    IF ListLen(httpPorts)=0 THEN ListAddItem(httpPorts,20000+node)
    
    zModemInfo.currentOperation:=ZMODEM_UPLOAD
    wantzwin:=TRUE
    IF scropen
      openTransferStatWin()
    ENDIF
    httpUpload(file,httpPorts)
    DisposeLink(httpPorts)
    closeTransferStatWin()
    wantzwin:=FALSE
    checkOffhookFlag()
    receivePlayPen(TRUE)
    IF (ulTTTM>0)
      tTEFF:=calcEfficiency(divBCD(uTBT,ulTTTM),onlineBaud)
    ELSE
      tTEFF:=0
    ENDIF
    RETURN 1
  ELSE
    StringF(tempstr,'\s.library',protocol)
  ENDIF

  zModemRxBufferSize:=65546
  zmodemRxBuffer:=New(zModemRxBufferSize)

  IF ext
    IF (xprotocolbase:=OpenLibrary(tempstr,0))=NIL
      aePuts('\b\nUnable to open the xpr library\b\n')
      RETURN RESULT_FAILURE
    ENDIF
    xprio:=NEW xprio
  ENDIF

  oldshared:=serShared
  serShared:=FALSE

  zModemInfo.currentOperation:=ZMODEM_UPLOAD
  wantzwin:=TRUE
  IF scropen
    openTransferStatWin()
  ENDIF

  IF ext
    xprio.xpr_extension:=4
    xprio.xpr_fopen:={xprfopenAsm}
    xprio.xpr_fclose:={xprfcloseAsm}
    xprio.xpr_fread:={xprfreadAsm}
    xprio.xpr_fwrite:={xprfwriteAsm}
    xprio.xpr_sread:={xprsreadAsm}
    xprio.xpr_swrite:={xprswriteAsm}
    xprio.xpr_sflush:={xprsflushAsm}
    xprio.xpr_update:={xprupdateAsm}
    xprio.xpr_chkabort:={xprchkabortAsm}
    xprio.xpr_chkmisc:=0
    xprio.xpr_gets:=0
    xprio.xpr_setserial:={xprsetserialAsm}
    xprio.xpr_ffirst:=0
    xprio.xpr_fnext:=0
    xprio.xpr_finfo:={xprfinfoAsm}
    xprio.xpr_fseek:={xprfseekAsm}
    xprio.xpr_data:=0
    xprio.xpr_options:=0
    xprio.xpr_unlink:={xprunlinkAsm}
    xprio.xpr_squery:=0
    xprio.xpr_getptr:=0
  ELSE
    
    bufferedBytes:=0
    bufferReadOffset:=0  
    
    IF hydraFlag
      hyd:=NEW hyd
      txwindow:=readToolTypeInt(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'TXWINDOW')
      IF txwindow=-1 THEN txwindow:=0
      rxwindow:=readToolTypeInt(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'RXWINDOW')
      IF rxwindow=-1 THEN rxwindow:=0

      hydra_init(hyd,0,0,0,txwindow,rxwindow)

      hyd.hyd_firstfile:=0
      hyd.hyd_nextfile:=0
      hyd.hyd_open:={zmfopen}
      hyd.hyd_close:={zmfclose}
      hyd.hyd_seek:={zmfseek}
      hyd.hyd_read:={zmfread}
      hyd.hyd_write:={zmfwrite}
      hyd.hyd_dupecheck:={zmdupecheck}
      hyd.hyd_uploadcompleted:={zmuploadcompleted}
      hyd.hyd_uploadfailed:=NIL
      hyd.hyd_recvbyte:=IF telnetSocket>=0 THEN {zmrecvbyteTelnet} ELSE {zmrecvbyteSerial}
      hyd.hyd_flush:={zmflush}
      hyd.hyd_isconnected:={zmisconnected}
      hyd.hyd_iscancelled:=NIL
      hyd.hyd_logmessage:={debugLog}
      hyd.hyd_getkey:={hydgetkey}
      hyd.hyd_sysidle:={hydsysidle}
      hyd.hyd_chatwrite:={hydchatwrite}
      hyd.hyd_status:={hydstatus}

    ELSEIF xmodemFlag OR ymodemFlag
      xym:=NEW xym
      binaryRaw:=(telnetSocket>=0)
      xymodem_init(xym, 0,
            {debugLog},
            {zmprogress},
            IF telnetSocket>=0 THEN {zmrecvbyteTelnet} ELSE {zmrecvbyteSerial},
            {zmisconnected},
            {zmiscancelled},
            {zmdatawaiting},
            {zmuploadcompleted},
            {zmuploadfailed},
            NIL,
            {zmdupecheck},
            {zmflush},
            NIL,
            {zmfopen},
            {zmfclose},
            {zmfseek},
            {zmfread},
            {zmfwrite},
            {zmfirstfile},
            {zmnextfile},
            2048,0,binaryRaw,0)
    ELSE
      zm:=NEW zm
      binaryRaw:=(telnetSocket>=0)
      zmodem_init(zm, 0,
            {debugLog},
            {zmprogress},
            IF telnetSocket>=0 THEN {zmrecvbyteTelnet} ELSE {zmrecvbyteSerial},
            {zmisconnected},
            {zmiscancelled},
            {zmdatawaiting},
            {zmuploadcompleted},
            {zmuploadfailed},
            NIL,
            {zmdupecheck},
            {zmflush},
            NIL,
            {zmfopen},
            {zmfclose},
            {zmfseek},
            {zmfread},
            {zmfwrite},
            {zmfirstfile},
            {zmnextfile},
            maxBlkSize,0,binaryRaw,0)
    ENDIF
  ENDIF

  asynciobase:=OpenLibrary('asyncio.library',0)

  IF telnetSocket>=0
    willsent:=0
    dosent:=0
    iac(telnetSocket,253,0) ->do binary
    iac(telnetSocket,251,0) ->will binary
  ENDIF

  IF ext
    StrCopy(tempstr,'')
    IF(StriCmp(protocol,'INTERNAL'))
      StrCopy(tempstr,'TN,AY,OR,E9,KN,SN,RN,DN,B64')
    ELSE
      readToolType(TOOLTYPE_XFERLIB,loggedOnUser.xferProtocol,'OPTIONS',tempstr)
    ENDIF

    StringF(debugstr,'xpr setup options = \s',tempstr)
    debugLog(LOG_DEBUG,debugstr)
    xprio.xpr_filename:=tempstr
    IF XprotocolSetup(xprio)=0
      Raise(ERR_EXCEPT)
    ENDIF

    ->override options with thsee (P = upload folder, KN dont keep partial uploads - actually our xprlink routine moves them into partial uploads
    StringF(tempstr,'KN,P\s',file)
    xprio.xpr_filename:=tempstr
    IF XprotocolSetup(xprio)=0
      Raise(ERR_EXCEPT)
    ENDIF
  ENDIF

  ->cancel current queued serial read request
  stopSerialRead()

  transfering:=TRUE
  lastIAC:=FALSE

  cancelTransferOffHook:=FALSE

  IF loggedOnUserKeys<>NIL
    IF bgFileCheck AND ((loggedOnUserKeys.userFlags AND USER_BGFILECHECK) OR (checkToolTypeExists(TOOLTYPE_NODE,node,'FORCE_BGFILECHECK')))
      createBackgroundFileCheckThread()
    ENDIF
  ENDIF

  IF ext
    time1,ticks1:=getSystemTime()
    result:=XprotocolReceive(xprio)
    time2,ticks2:=getSystemTime()
    ulTTTM:=Mul(time2-time1,50)+ticks2-ticks1;
  ELSE
    IF hydraFlag 
      result:=hydra_do_transfer(hyd,file,NIL,NIL,NIL,{ulTimeTaken}) 
    ELSEIF xmodemFlag OR ymodemFlag
      result:=xymodem_recv_files(ymodemFlag,xym, file,NIL,{ulTimeTaken}) 
    ELSE
      result:=zmodem_recv_files(zm, file,NIL,{ulTimeTaken}) 
    ENDIF
    ulTTTM:=ulTimeTaken
  ENDIF
  IF ulTTTM
    CopyMem(uTBT,tmpBCD,8)
    mulBCD(tmpBCD,50)
    tTCPS:=divBCD(tmpBCD,ulTTTM)
  ELSE
    tTCPS:=convertFromBCD(uTBT)
  ENDIF
  tTEFF:=calcEfficiency(tTCPS,onlineBaud)    
  
  IF telnetSocket>=0
    iac(telnetSocket,254,0) ->dont binary
    iac(telnetSocket,252,0) ->wont binary
  ENDIF

  IF ext
    XprotocolCleanup(xprio)
  ELSE
    IF hydraFlag
      hydra_cleanup(hyd)
    ELSEIF xmodemFlag OR ymodemFlag
      xymodem_cleanup(xym)
    ELSE
      zmodem_cleanup(zm)
    ENDIF
  ENDIF

  IF (loggedOnUserKeys<>NIL) AND (netMailTransfer=FALSE)
      IF bgFileCheck AND ((loggedOnUserKeys.userFlags AND USER_BGFILECHECK) OR (checkToolTypeExists(TOOLTYPE_NODE,node,'FORCE_BGFILECHECK')))
      IF (bgport:=FindPort(bgCheckPortName))
        msg:=AllocMem(SIZEOF jhMessage,MEMF_ANY OR MEMF_CLEAR)
        IF msg
          msg.command:=BG_EXIT
          msg.msg.length:=SIZEOF jhMessage
          msg.msg.ln.type:=NT_FREEMSG
          ->signal background checking to finish
          PutMsg(bgport,msg)
          
          IF FindPort(bgCheckPortName)<>0
            aePuts('Waiting for background filecheck to complete...\b\n\b\n',TRUE)
            REPEAT
              Delay(10)
            UNTIL FindPort(bgCheckPortName)=0
          ENDIF
        ENDIF
      ENDIF
    ENDIF
  ENDIF
  bgChecking:=FALSE
  transfering:=FALSE
  binaryRaw:=FALSE

  checkOffhookFlag()

  IF ext OR xmodemFlag THEN receivePlayPen(xmodemFlag)

  Delay(50)

  IF(StriCmp(protocol,'INTERNAL'))
    aePuts(internalName)
  ELSE
    aePuts(xprTitle.item(loggedOnUser.xferProtocol))
  ENDIF
  IF(result) THEN aePuts(' upload successful\b\n') ELSE aePuts(' upload unsuccessful\b\n')

  IF tags<>NIL THEN END tags
  
  IF ext
    END xprio
  ELSE
    IF hyd<>NIL THEN END hyd
    IF xym<>NIL THEN END xym
    IF zm<>NIL THEN END zm
  ENDIF

  IF asynciobase<>NIL THEN CloseLibrary(asynciobase)
  asynciobase:=NIL

  IF ext THEN CloseLibrary(xprotocolbase)
  zModemInfo.currentOperation:=ZMODEM_NONE
  closeTransferStatWin()
  wantzwin:=FALSE

  serShared:=oldshared

  ->restart normal serial IO
  queueSerialRead({serbuff})
  
  Dispose(zmodemRxBuffer)
  RETURN 1
EXCEPT
  IF ext THEN CloseLibrary(xprotocolbase)
  zModemInfo.currentOperation:=ZMODEM_NONE
  closeTransferStatWin()
  wantzwin:=FALSE

  IF xprio THEN END xprio
  Dispose(zmodemRxBuffer)
  RETURN RESULT_FAILURE
ENDPROC

PROC freeDiskSpace()
  ->now returns free space in mb not bytes
  DEF string[200]:STRING,path[100]:STRING
  DEF tempstr[255]:STRING

  DEF tfshi,tfslo,fsuhi,fsulo
  DEF drivenum=1

  tfshi:=0
  tfslo:=0
  StringF(path,'DRIVE.\d',drivenum)
  drivenum++
  IF readToolType(TOOLTYPE_DRIVES,'',path,string)
    WHILE(readToolType(TOOLTYPE_DRIVES,'',path,string))
      fsuhi,fsulo:=rFreeSpace(string)
      tfshi:=tfshi+fsuhi
      tfslo:=tfslo+fsulo
      StringF(path,'DRIVE.\d',drivenum)
      drivenum++
    ENDWHILE
  ELSE
    StringF(tempstr,'\b\nThe file \sDRIVES.info is missing!!!\b\n\b\n',cmds.bbsLoc)
    aePuts(tempstr)
    RETURN RESULT_FAILURE
  ENDIF

  WHILE tfslo>=1048576
    tfslo:=tfslo-1048576
    tfshi++
  ENDWHILE

ENDPROC tfshi,tfslo

PROC rFreeSpace(path: PTR TO CHAR)
  ->now returns two values, space in mb and then extra bytes as second result
  DEF fLock
  DEF i_data: PTR TO infodata
  DEF tempstr[255]:STRING
  DEF stat=0
  DEF spacehi=0,spacelo=0
  DEF temp1,temp2

  IF(i_data:=AllocMem(SIZEOF infodata,MEMF_CHIP))
    IF(fLock:=Lock(path,ACCESS_READ))
      IF(stat:=Info(fLock,i_data))
      
        ->spacelo:=Mul((i_data.numblocks-i_data.numblocksused),i_data.bytesperblock)
        ->spacehi:=Mul(Shr((i_data.numblocks-i_data.numblocksused),10),i_data.bytesperblock)     ->changed to get kbytes free instead of bytes

        temp1,temp2:=mulu64(i_data.numblocks-i_data.numblocksused,i_data.bytesperblock)
        spacelo:=temp2 AND $FFFFF
        spacehi:=(Shr(temp2,20) AND $FFF) OR Shl(temp1,12)
      ELSE
        StringF(tempstr,'\b\nCan not get info from \s for free space\b\n',path)
        aePuts(tempstr)
      ENDIF
      UnLock(fLock)
    ELSE
      StringF(tempstr,'\b\nCan not find free space for \s\b\n',path)
      aePuts(tempstr)
    ENDIF
    FreeMem(i_data,SIZEOF infodata)
  ELSE
    myError(0)
  ENDIF
ENDPROC spacehi,spacelo

PROC stripReturn(str: PTR TO CHAR)
  DEF i,t
  i:=StrLen(str)-1
  WHILE(i>=0)
    t:=str[i]
    IF(t<=32) THEN str[i]:=0 ELSE RETURN
    i--
  ENDWHILE
ENDPROC

PROC scanHoldDesc()
  DEF fi
  DEF string[200]:STRING, text[200]:STRING
  DEF tempstr[255]:STRING
  DEF stat,p

  lcFileXfr:=FALSE

  StringF(purgeScanNM,'\d',loggedOnUser.slotNumber)
  StringF(string,'\sLCFILES/\s.lc',currentConfDir,purgeScanNM)
  IF(fi:=Open(string,MODE_OLDFILE))<>0
    lcFileXfr:=TRUE
    aePuts('Preparing Lost Carrier File(s) for File Description(s)\b\n\b\n')
    WHILE((ReadStr(fi,string)<>-1) OR (StrLen(string)>0))
      IF(dirLineNewFile(string))
        IF ((p:=InStr(string,' '))>=0) THEN SetStr(string,p)
        
        StringF(text,'\sLCFILES/\s',currentConfDir,string)
        IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'\s\s',sopt.ramPen,string) ELSE StringF(tempstr,'\sNode\d/PlayPen/\s',cmds.bbsLoc,node,string)

        IF(checkForFile(FilePart(text))<>RESULT_FAILURE)
          IF(StrLen(sopt.ramPen)>0) THEN StringF(tempstr,'\s\s',sopt.ramPen,string) ELSE StringF(tempstr,'\sNode\d/PlayPen/\s',cmds.bbsLoc,node,string)

          IF(Rename(text,tempstr))=FALSE THEN fileCopy(text,tempstr)
          aePuts('\tPrepared!')
        ELSE
          aePuts('\tFile already exists, deleting file.')
        ENDIF
        SetProtection(text,FIBF_OTR_DELETE)
        DeleteFile(text)
      ENDIF
    ENDWHILE
    Close(fi)
    StringF(string,'\sLCFILES/\s.lc',currentConfDir,purgeScanNM)
    SetProtection(string,FIBF_OTR_DELETE)
    DeleteFile(string);
    IF logonType>=LOGON_TYPE_REMOTE
      bgFileCheck:=checkToolTypeExists(TOOLTYPE_NODE,node,'BGFILECHECK')
    ELSE
      bgFileCheck:=FALSE
    ENDIF
    stat:=uploadaFile(1,'',FALSE)
    IF stat=RESULT_GOODBYE THEN modemOffHook()
  ENDIF   /* end if fi != NL */
  lcFileXfr:=FALSE
  aePuts('\b\n')
ENDPROC

PROC partUploadOK(option)

  DEF fib=NIL:PTR TO fileinfoblock
  DEF fLock
  DEF status,ch
  DEF rts_stat = RESULT_SUCCESS 
  DEF path[100]:STRING,str[100]:STRING,ray2[100]:STRING
  DEF cnt = 0
  DEF s:PTR TO CHAR

  StrCopy(path,currentConfDir);
  StrAdd(path,'PartUpload/')
  IF(maxDirs=0) THEN RETURN RESULT_SUCCESS

  IF(logonType=LOGON_TYPE_LOCAL) THEN RETURN RESULT_SUCCESS

  IF((fLock:=Lock(path,ACCESS_READ)))=FALSE
    StringF(str,'\b\nTell \s the bbs can''t access the \s dir\b\n',cmds.sysopName,path)
    aePuts(str)
    RETURN RESULT_SUCCESS ->// success = 0
  ENDIF
                              ->//(RTS) was chip
  IF((fib:=AllocDosObject(DOS_FIB,NIL)))=NIL
    UnLock(fLock)             ->//(RTS)
    myError(0)
    RETURN RESULT_SUCCESS
  ENDIF

  IF((Examine(fLock,fib)))=FALSE
    UnLock(fLock)
    FreeDosObject(DOS_FIB,fib)
    RETURN RESULT_SUCCESS
  ENDIF

  IF(fib.direntrytype > 0)   /* make sure we locked a directory */
    WHILE(ExNext(fLock,fib))     /* my change.. prior to this we had a blank file name */
      IF(StrLen(fib.filename) = 0)   /* check for filename > 0 length */
        JUMP inoh
      ENDIF

      cnt:=0
      s:=fib.filename
      WHILE((s[0]) AND (cnt < 30))      /* check for valid file name */
        IF(s[0] = " ")     /* check for spaces at beginning of filename */
          JUMP inoh
        ENDIF
        IF(s[0] = "/")
          JUMP inoh
        ENDIF
        IF((isascii(s[0])))=FALSE
          JUMP inoh
        ENDIF
        cnt++
        s++
      ENDWHILE

      /** END ERROR CKING */
      StrCopy(str,fib.filename)
      StrCopy(ray2,str)
      status:=getUN(str)       /* remove the @(num at end of file. Return user number */
      IF(status=loggedOnUser.slotNumber)
        aePuts('There are some incompleted uploads of yours\b\n')
        IF(option=FALSE) THEN aePuts('Would you like to leave anyway (Y/N)? ')

        LOOP
          ch:=checkOnlineStatus()
          IF(ch<0)
            rts_stat:=ch
            JUMP outoh
          ENDIF
          IF(option=FALSE)
            ch:=readChar(INPUT_TIMEOUT)
            IF(ch=RESULT_TIMEOUT)
              rts_stat:=RESULT_NO_CARRIER
              JUMP outoh
            ENDIF
            IF(logonType>=LOGON_TYPE_REMOTE)
              status:=checkCarrier()
              IF(status=FALSE)
                rts_stat:=RESULT_NO_CARRIER
                JUMP outoh
              ENDIF
            ENDIF
          ELSE
            ch:="N"
          ENDIF

          IF((ch="N") OR (ch="n"))
            IF(option=FALSE) THEN aePuts('No!   View them (Y/N)? ') ELSE aePuts('View them (Y/N)? ')
            purgeLine()
            LOOP
              ch:=checkOnlineStatus()
              IF(ch<0)
                rts_stat:=ch
                JUMP outoh
              ENDIF
              ch:=readChar(INPUT_TIMEOUT);
              IF(ch=RESULT_TIMEOUT)
                rts_stat:=RESULT_NO_CARRIER
                JUMP outoh
              ENDIF
              IF((ch="N") OR (ch="n"))
                aePuts('No!\b\n')
                rts_stat:=RESULT_ABORT
                JUMP outoh
              ENDIF
              EXIT ((ch="Y") OR (ch="y"))
            ENDLOOP
            ->// AEPutStr("Yes..\b\n");
            rts_stat:=RESULT_FAILURE
            JUMP outoh
          ENDIF   /* end if ch == 'n' */
          EXIT ((ch="Y") OR (ch="y"))
        ENDLOOP          /* end forever */
        JUMP outoh
      ENDIF
      ->//AEPutStr("Yes..\b\n");
inoh:
    ENDWHILE  /* end while (ExNext(FLock,Fib)) */
  ENDIF     /* end if(Fib->fib_DirEntryType > 0) */
outoh:
  IF(fLock) THEN UnLock(fLock)
  IF(fib) THEN FreeDosObject(DOS_FIB,fib)
ENDPROC rts_stat

PROC uploadDesc()
  DEF status,x,count
  DEF str[255]:STRING,str2[255]:STRING,odate[50]:STRING,str3[200]:STRING,str4[200]:STRING,buff[255]:STRING
  DEF udf
  DEF brk=0

  cleanItUp()
  aePuts('Batch UpLoading.....\b\n')
  aePuts('\b\nUnlimited files.  Blank Line to start transfer.\b\n')

  count:=0
  LOOP
updesccont:
    count++
    StringF(str,'\b\nFileName \d: ',count)
    aePuts(str)
    status:=lineInput('','',100,INPUT_TIMEOUT,str)
    IF(status<0) THEN RETURN status
    IF(((str[0]="A") OR (str[0]="a")) AND (StrLen(str)=1))
      aePuts('\b\n')
      RETURN RESULT_FAILURE
    ENDIF

    brk:=(StrLen(str)=0)
    IF(brk) THEN aePuts('\b\n')
    EXIT brk

    StrCopy(str2,str)
    UpperStr(str2)
    IF Not((StriCmp(str2,'HTTP://',7)) OR (StriCmp(str2,'HTTPS://',8)) OR (StriCmp(str2,'FTP://',6)))
      IF StrLen(str)>12
        aePuts('Files longer than 12 characters are not allowed.\b\n')
        count--
        JUMP updesccont
      ENDIF
      status:=checkForFile(str)   /* is file online ?? */
      IF(status=RESULT_FAILURE)
        aePuts('File Exists, or has a symbol (#?*).\b\n')
        count--
        JUMP updesccont
      ENDIF
    ENDIF

    IF (StriCmp(str2,'HTTP://',7)) OR (StriCmp(str2,'HTTPS://',8)) OR (StriCmp(str2,'FTP://',6))
      StrCopy(str2,str)
      StrCopy(str,FilePart(str2))

      IF(StrLen(sopt.ramPen)>0) THEN StringF(str4,'\s\s',sopt.ramPen,str) ELSE StringF(str4,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,str)
      StringF(str3,'curl -# -f -k \s -o \s',str2,str4)
      Execute(str3,NIL,NIL)
      IF fileExists(str4)
        lcFileXfr:=TRUE
      ELSE
        aePuts('File download was not successful.\b\n')
        count--
        JUMP updesccont
      ENDIF
    ENDIF

    StringF(str4,'\s\s',nodeWorkDir,str)

    udf:=Open(str4,MODE_OLDFILE)
    IF(udf<>0)
      aePuts('You can''t Upload a duplicate.\b\n')
      count--
      Close(udf)
      JUMP updesccont
    ENDIF
    formatLongDate(getSystemTime(),odate)

    StringF(buff,'\b\nPlease enter a description, you only have \d lines.',max_desclines)
    aePuts(buff)
    aePuts('\b\nPress return alone to end.  Begin  with (/) to make upload ''Private'' to Sysop.\b\n')

    IF readToolType(TOOLTYPE_CONF,currentConf,'ULPROMPT',str2)
      aePuts(str2)
      aePuts('\b\n')
    ENDIF
    aePuts('                                [--------------------------------------------]\b\n')
    StringF(str2,'\l\s[13]                   :',str)
    aePuts(str2)

    status:=lineInput('','',44,INPUT_TIMEOUT,str2)
    IF(status<0) THEN RETURN status
    IF(StrLen(str2)=0)
      count--
      JUMP updesccont
    ENDIF
    udf:=Open(str4,MODE_NEWFILE)
    IF(udf=0)
      myError(7)
      ->//aePuts('Tell sysop the system can''t open a file in the work dirs\b\n\b\n')
      RETURN RESULT_FAILURE
    ENDIF
    fileWriteLn(udf,str2)
    x:=0
    REPEAT
      aePuts('                                :')
      status:=lineInput('','',44,INPUT_TIMEOUT,str2)
      IF(status<0)
        Close(udf)
        SetProtection(str4,FIBF_OTR_DELETE)
        DeleteFile(str4)
        RETURN status
      ENDIF
      IF(StrLen(str2)<>0) THEN fileWriteLn(udf,str2)
      x++
    UNTIL ((StrLen(str2)=0) OR (x>=(max_desclines-1)))
    Close(udf)

  ENDLOOP

  aePuts('\b\n')
  REPEAT
    IF bgFileCheck AND (checkToolTypeExists(TOOLTYPE_NODE,node,'FORCE_BGFILECHECK')=FALSE)
      StringF(str,'[1A\bOkay:   (B)ackground filecheck: \s \b\n',IF loggedOnUserKeys.userFlags AND USER_BGFILECHECK THEN '[32mYES[0m' ELSE '[37mNO[0m')
      aePuts(str)
      aePuts('(Enter) to Start, (G)oodbye after transfer, (A)bort? ')
    ELSE
      aePuts('\bOkay:   (Enter) to Start, (G)oodbye after transfer, (A)bort? ')
    ENDIF

    status:=checkOnlineStatus()
    IF(status<0) THEN RETURN status
    status:=readChar(INPUT_TIMEOUT)
    IF(status<(-1)) THEN RETURN status

    IF bgFileCheck AND (checkToolTypeExists(TOOLTYPE_NODE,node,'FORCE_BGFILECHECK')=FALSE)
      IF (status="B") OR (status="b") THEN loggedOnUserKeys.userFlags:=Eor(loggedOnUserKeys.userFlags,USER_BGFILECHECK)
    ENDIF

    IF((status=65) OR (status=97))
      aePuts('Abort!\b\n\b\n')
      RETURN RESULT_FAILURE
    ENDIF
    IF(((status="L") OR (status="l")) AND (ximPort=CONSOLE_PORT) AND checkSecurity(ACS_VIEW_A_FILE))
      status:=13
      localUpload:=1
    ENDIF
  UNTIL (status=13) OR (status=71) OR (status=103)

  IF(status<>13)
    aePuts('Goodbye!\b\n\b\n')
    RETURN 2
  ELSE
    aePuts('\b\n\b\n')
  ENDIF
ENDPROC 1

PROC cleanItUp()
  DEF fLock
  DEF fib: PTR TO fileinfoblock
  DEF i
  DEF s: PTR TO CHAR
  DEF cnt = 0
  DEF tempstr[255]:STRING

  StrCopy(tempstr,nodeWorkDir)
  i:=StrLen(tempstr)-1
  WHILE(i)
    IF((tempstr[i]<=" ") OR (tempstr[i]="/"))
      tempstr[i]:=0
    ELSE
      i:=1    ->break
    ENDIF
    i--
  ENDWHILE

  IF((fib:=AllocDosObject(DOS_FIB,NIL)))=NIL
    myError(0)
    RETURN
  ENDIF

  /* lock the work directory */
  IF((fLock:=Lock(tempstr,ACCESS_READ)))=0
    myError(8)
    JUMP ef
  ENDIF

  IF((Examine(fLock,fib)))=0
    myError(6)
    JUMP ef
  ENDIF

  IF(fib.direntrytype > 0)   /* make sure we locked a directory */
    WHILE(ExNext(fLock,fib))
      IF(fib.direntrytype < 0)   /* found a file */
        /* * * ERROR CHECKING * * */
        /* or we can change to &Fib->fib_FileName[0] */
        IF(StrLen(fib.filename) = 0)    /* check for filename > 0 length */
          JUMP ef
        ENDIF

        cnt:=0
        s:=fib.filename
        WHILE((s[0]) AND (cnt < 30))     /* check for valid file name */
          IF(s[0] = " ")      /* check for spaces at beginning of filename */
            JUMP ef
          ENDIF
          IF(s[0] = "/")
            JUMP ef
          ENDIF
          IF(isascii(s[0]))=FALSE
            JUMP ef
          ENDIF
          cnt++
          s++
        ENDWHILE

        /* * * END ERROR CHECKING * * */


        StringF(tempstr,'\s\s',nodeWorkDir,fib.filename)
        SetProtection(tempstr,FIBF_OTR_DELETE)
        DeleteFile(tempstr)


      ENDIF /* end if(Fib->fib_DirEntryType < 0) */

    ENDWHILE   /* end while(ExNext(FLock,Fib)) */

  ENDIF     /* end  if(Fib->fib_DirEntryType > 0) */

ef:
  IF(fLock) THEN UnLock(fLock)
  IF(fib) THEN FreeDosObject(DOS_FIB,fib)
ENDPROC

PROC batchasl(where: PTR TO CHAR) HANDLE
  DEF fr:filerequester
  DEF frargs: PTR TO wbarg
  DEF src[102]:STRING
  DEF dest[102]:STRING
  DEF debugstr[255]:STRING
  DEF aslDir[255]:STRING
  DEF x,tags=NIL:PTR TO LONG
  DEF returnval

  StrCopy(aslDir,cmds.bbsLoc)
  IF readToolType(TOOLTYPE_CONF,currentConf,'LOCAL_UPLOAD_PATH',aslDir)=FALSE
    IF readToolType(TOOLTYPE_NODE,node,'LOCAL_UPLOAD_PATH',aslDir)=FALSE
      readToolType(TOOLTYPE_BBSCONFIG,'','LOCAL_UPLOAD_PATH',aslDir)
    ENDIF
  ENDIF

  IF KickVersion(37) = FALSE THEN Raise(ERR_KICKVER)  -> E-Note: requires V37
  aslbase:=OpenLibrary('asl.library',37)
  IF aslbase=NIL THEN Raise(ERR_LIB)
  tags:=NEW [ASL_HAIL,'/X Local Upload FileRequest',
     ASL_WINDOW, window,      
     ASL_PATTERN,'#?',
     ASL_FUNCFLAGS, FILF_MULTISELECT OR FILF_PATGAD,
     ASL_DIR,aslDir,
     TAG_DONE]
  fr:=AllocAslRequest(ASL_FILEREQUEST,tags)

  returnval:=0
  aePuts('\b\nBatch Local upload in progress, Please Stand by!\b\n')
  IF(AslRequest(fr,0))
    returnval:=(fr.numargs)+1
    aePuts('\b\n')
    IF(fr.numargs)
      frargs:=fr.arglist

      FOR x:=0 TO fr.numargs-1
        StrCopy(src,fr.drawer)
        AddPart(src,frargs[x].name,100)
        StrCopy(dest,where)
        AddPart(dest,frargs[x].name,100)
        IF((rzmsg=FALSE) AND (checkForFile(frargs[x].name)))
          aePuts('[0mFile ')
          aePuts(frargs[x].name)
          aePuts(' already exists\b\n')
        ELSE
          aePuts('[0mCopying ')
          aePuts(frargs[x].name)
          aePuts('[0m\b\n')
          fileCopy(src,dest)
        ENDIF
      ENDFOR
    ELSE
      StrCopy(src,fr.drawer)
      AddPart(src,fr.file,100)
      StrCopy(dest,where)
      AddPart(dest,fr.file,100)
      IF((rzmsg=FALSE) AND (checkForFile(fr.file)))
        aePuts('[0mFile ')
        aePuts(fr.file)
        aePuts(' already exists\b\n')
      ELSE
        aePuts('[0mCopying ')
        aePuts('[0m\b\n')
        aePuts(fr.file)
        fileCopy(src,dest)
      ENDIF
    ENDIF
  ELSE
    StringF(debugstr,'error: \d',IoErr())
    debugLog(LOG_ERROR,debugstr)
  ENDIF
EXCEPT DO
  IF fr THEN FreeAslRequest(fr)
  IF tags THEN FastDisposeList(tags)
  IF aslbase THEN CloseLibrary(aslbase)
  SELECT exception
    CASE ERR_ASL
      debugLog(LOG_ERROR,'Error: Could not allocate ASL request')
    CASE ERR_KICK
      debugLog(LOG_ERROR,'Error: Requires V37')
    CASE ERR_LIB
      debugLog(LOG_ERROR,'Error: Could not open ASL library')
  ENDSELECT
ENDPROC returnval

PROC fileReceive(flname:PTR TO CHAR,uLFType)
  DEF temp[100]:STRING
  DEF protocol[255]:STRING
  
  IF((logonType>=LOGON_TYPE_REMOTE) AND (localUpload=FALSE) AND (lcFileXfr=FALSE))

    IF xprLib.count()=0
      aePuts('\b\nNo transfer protocols are currently configured')
      RETURN RESULT_FAILURE
    ENDIF

    StrCopy(protocol,xprLib.item(loggedOnUser.xferProtocol))

    IF(uLFType=FALSE)
      IF(StriCmp(protocol,'INTERNAL')) OR (StriCmp(protocol,'INTERNAL8K'))
        StringF(temp,'\b\nZmodem: Ready to Receive\b\n')
      ELSEIF(StriCmp(protocol,'INTERNALYM'))
        StringF(temp,'\b\nYmodem: Ready to Receive\b\n')
      ELSEIF(StriCmp(protocol,'INTERNALXM'))
        StringF(temp,'\b\nXmodem: Ready to Receive\b\n')
      ELSEIF(StriCmp(protocol,'HYDRA'))
        StringF(temp,'\b\nHydra: Ready to Receive\b\n')
      ELSEIF(StriCmp(protocol,'FTP'))
        StringF(temp,'\b\nFTP: Ready to Receive\b\n')
      ELSEIF(StriCmp(protocol,'HTTP'))
        StringF(temp,'\b\nHTTP: Ready to Receive\b\n')
      ELSEIF(checkSecurity(ACS_XPR_RECEIVE)=FALSE)
        aePuts('\b\nYou are not allowed to upload using external xpr protocols')
        RETURN RESULT_FAILURE
      ELSE
        StringF(temp,'\b\n\s: Ready to Receive\b\n',xprTitle.item(loggedOnUser.xferProtocol))
      ENDIF
      aePuts(temp);
      ->aePuts('Control-X to Cancel\b\n')
    ENDIF

    RETURN fileUpload(flname)
  ELSE
    IF(lcFileXfr=FALSE)
      IF(batchasl(flname)) THEN receivePlayPen(TRUE)
    ELSE
      receivePlayPen(TRUE)
    ENDIF
    lcFileXfr:=0
    ->AEPutStr("\b\nNot supported locally...");
  ENDIF
  localUpload:=0
ENDPROC 0

PROC checkOffhookFlag()
  IF cancelTransferOffHook
    processOlmMessageQueue(TRUE)
    Delay(30)
    modemOffHook()
    cancelTransferOffHook:=FALSE
  ENDIF
ENDPROC

PROC receivePlayPen(log)
  DEF fLock
  DEF fib: PTR TO fileinfoblock
  DEF s:PTR TO CHAR
  DEF cnt = 0
  DEF tempstr[255]:STRING

  ObtainSemaphore(bgData)
  ulFileCount:=bgData.checkedCount
  CopyMem(bgData.checkedBytes,uTBT,8)
  ReleaseSemaphore(bgData)

  recFileNames.clear()

  IF(StrLen(sopt.ramPen)>0) THEN StrCopy(tempstr,sopt.ramPen) ELSE StringF(tempstr,'\sNode\d/Playpen/',cmds.bbsLoc,node)

  IF((fib:=AllocDosObject(DOS_FIB,NIL)))=NIL
    myError(0)
    RETURN
  ENDIF

  /* lock the directory (Playpen or RamPen) */
  IF((fLock:=Lock(tempstr,ACCESS_READ)))=0
    myError(8)
    JUMP fx
  ENDIF

  IF((Examine(fLock,fib)))=0
    myError(6)
    JUMP fx;
  ENDIF

  IF(fib.direntrytype > 0)   /* make sure we locked a directory */
    WHILE(ExNext(fLock,fib))
      IF(fib.direntrytype < 0)   /* found a file */
        /* or we can change to &Fib->fib_FileName[0] */
        IF(StrLen(fib.filename) = 0)   /* check for filename > 0 length */
          errorLog('(cpp - 631) Strlen')
          JUMP fx;
        ENDIF

        cnt:=0
        s:=fib.filename
        WHILE((s[0]) AND (cnt < 30))     /* check for valid file name */
          IF(s[0] = " ")     /* check for spaces at beginning of filename */
            JUMP fx
          ENDIF
          IF(s[0]="/")
            JUMP fx
          ENDIF
          IF((isascii(s[0]))=FALSE)
            JUMP fx
          ENDIF
          cnt++
          s++
        ENDWHILE
        ulFileCount++
        addBCD(uTBT,fib.size)
        IF log 
          StringF(tempstr,'\tUploading \s[12] \d bytes',fib.filename, fib.size)
          udLog(tempstr)
          callersLog(tempstr)
        ENDIF

        recFileNames.add(fib.filename)
      ENDIF                    /* end if(Fib->fib_DirEntryType < 0)  */
    ENDWHILE                      /* end while(ExNext(FLock,Fib))       */
  ENDIF                               /* end if(Fib->fib_DirEntryType > 0)  */

fx:
  IF(fLock) THEN UnLock(fLock)
  IF(fib) THEN FreeDosObject(DOS_FIB,fib)

ENDPROC

PROC getUN(sa: PTR TO CHAR)
  DEF x=0,x2=0,n=0
  WHILE((sa[x])<>0) AND (n=0)
    IF((sa[x])="@")
      n:=1
      sa[x]:=0
    ENDIF
    x++
  ENDWHILE
  IF(n)
    IF ownPartFiles
      IF(x2:=InStr(sa,'-',x))<>-1
        IF Val(sa+x)=node
          RETURN Val(sa+x2+1)
        ENDIF
      ENDIF
    ELSE
      RETURN Val(sa+x)
    ENDIF
  ENDIF
ENDPROC 0

PROC resumeStuff()
  DEF status,ch
  DEF string[256]:STRING,path[256]:STRING,ray2[256]:STRING,ray[256]:STRING,str[256]:STRING
  DEF fBlock:PTR TO fileinfoblock
  DEF fLock
  DEF stat,removeAll=FALSE

  StrCopy(path,currentConfDir)
  StrAdd(path,'PartUpload/')

  IF((fLock:=Lock(path,ACCESS_READ)))=0    ->//(RTS) replaced no err cking version below
    myError(8)
    RETURN -1
  ENDIF
                                                     ->// was MEMF_CHIP
  IF((fBlock:=AllocDosObject(DOS_FIB,NIL)))=NIL
    myError(0) ->(RTS)
    UnLock(fLock)
    RETURN -1
  ENDIF

  IF((Examine(fLock,fBlock)))=0
    FreeDosObject(DOS_FIB,fBlock)
    UnLock(fLock)
    myError(6)
    RETURN -1
  ENDIF

  ->ADD THIS !!

  WHILE ((ExNext(fLock,fBlock))<>0)   ->(RTS)
    StrCopy(str,fBlock.filename)
    StrCopy(ray2,str)
    status:=getUN(str)  /* returns user number from end of file name */
    IF(status=loggedOnUser.slotNumber)
      IF removeAll
        StringF(string,'Delete \s[12] [\d] ',str,fBlock.size)
      ELSE
        StringF(string,'Resume \s[12] [\d] (Y/N)? ',str,fBlock.size)
      ENDIF
      aePuts(string)
      LOOP
        ch:=checkOnlineStatus()
        IF(ch<0)
          FreeDosObject(DOS_FIB,fBlock)
          IF(fLock) THEN UnLock(fLock) ->//(RTS) Lock held
          RETURN ch
        ENDIF
        IF removeAll
          ch:="N"
        ELSE
          ch:=readChar(INPUT_TIMEOUT)
        ENDIF
        IF(ch=RESULT_TIMEOUT)
          FreeDosObject(DOS_FIB,fBlock)
          IF(fLock) THEN UnLock(fLock)  ->//(RTS) Lock held
          RETURN RESULT_NO_CARRIER
        ENDIF
        IF((ch="N") OR (ch="n"))
          IF removeAll=FALSE THEN aePuts('No!   Delete (Y/N/All)? ')
          purgeLine()
          LOOP
            IF removeAll
              ch:="Y"
            ELSE
              ch:=readChar(INPUT_TIMEOUT);
            ENDIF
            IF(ch=RESULT_TIMEOUT)
              FreeDosObject(DOS_FIB,fBlock)
              IF(fLock) THEN UnLock(fLock)  ->//(RTS) Lock held
              RETURN RESULT_NO_CARRIER
            ENDIF
            IF(logonType>=LOGON_TYPE_REMOTE)
              status:=checkCarrier()
              IF(status=FALSE)
                FreeDosObject(DOS_FIB,fBlock)
                IF(fLock) THEN UnLock(fLock)  ->(RTS) Lock held
                RETURN RESULT_NO_CARRIER
              ENDIF
            ENDIF
            IF((ch="N") OR (ch="n"))
              aePuts('No!\b\n')
              JUMP dirCont
            ENDIF
            IF ((ch="A") OR (ch="a"))
              removeAll:=TRUE
              ch:="Y"
            ENDIF
            EXIT ((ch="Y") OR (ch="y"))
          ENDLOOP        /* end first forever */
          IF removeAll
            aePuts('All.. Deleted!\b\n')
          ELSE
            aePuts('Yes.. Deleted!\b\n')
          ENDIF
          StrCopy(string,path)
          StrAdd(string,ray2)
          SetProtection(string,FIBF_OTR_DELETE)
          DeleteFile(string)
          JUMP dirCont
        ENDIF  /* end if ch == 'n */

        EXIT (ch="Y") OR (ch="y")
      ENDLOOP   /* end 2nd forever */
      aePuts('Yes..\b\n')
      StringF(string,'\b\nResuming upload: \s\b\n\b\n',str)
      aePuts(string)      /* filename */
      StrAdd(path,ray2)     /* conf_loc:filename/ */

      IF(StrLen(sopt.ramPen)>0)
        StrCopy(ray,sopt.ramPen)  /* should be filename without @name */
        StrAdd(ray,str)    /* should be old partial file with @num on end */
        stat:=1
        IF (Rename(path,ray)=FALSE)
          stat:=fileCopy(path,ray)  /* path = filename +@num */
        ENDIF
      ELSE
        StringF(ray,'\sNode\d/Playpen/',cmds.bbsLoc,node)
        StrAdd(ray,str)       /* filename */

        stat:=1
        IF (Rename(path,ray)=FALSE)
          stat:=fileCopy(path,ray)      /* rename file */
        ENDIF
      ENDIF
      IF(stat=1)
        SetProtection(path,FIBF_OTR_DELETE)
        DeleteFile(path)
      ENDIF

      IF(fBlock) THEN FreeDosObject(DOS_FIB,fBlock)
      IF(fLock) THEN UnLock(fLock)
      RETURN 1
dirCont:
     ENDIF            /* if status & user name */
  ENDWHILE
  IF(fBlock) THEN FreeDosObject(DOS_FIB,fBlock)
  IF(fLock) THEN UnLock(fLock)
ENDPROC 0

PROC cleanPlayPen()
  DEF stat,err
  DEF fLock
  DEF fib: PTR TO fileinfoblock
  DEF s: PTR TO CHAR
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF cnt = 0

  recFileNames.clear()

  IF(StrLen(sopt.ramPen)>0) THEN StrCopy(tempstr,sopt.ramPen) ELSE StringF(tempstr,'\sNode\d/Playpen/',cmds.bbsLoc,node)

  IF tempstr[StrLen(tempstr)-1]="/"
    SetStr(tempstr,StrLen(tempstr)-1)
  ENDIF

  IF(fib:= AllocDosObject(DOS_FIB,NIL))=NIL
    myError(0)
    RETURN
  ENDIF

  /* lock the directory (Playpen or RamPen) */
  IF((fLock:=Lock(tempstr,ACCESS_READ)))=0
    myError(8)
    JUMP fx2
  ENDIF

  IF((Examine(fLock,fib)))=0
    myError(6)
    JUMP fx2;
  ENDIF

  IF(fib.direntrytype > 0)   /* make sure we locked a directory */
    WHILE(ExNext(fLock,fib))
      IF(fib.direntrytype < 0)   /* found a file */
        /* or we can change to &Fib->fib_FileName[0] */
        IF(StrLen(fib.filename) = 0)   /* check for filename > 0 length */
          JUMP fx2
        ENDIF

        IF loggedOnUser=NIL
          stat:=1   ->just delete if no logged on user
          IF(StrLen(sopt.ramPen)>0) THEN StrCopy(tempstr,sopt.ramPen) ELSE StringF(tempstr,'\sNode\d/Playpen/',cmds.bbsLoc,node)
          checkPathSlash(tempstr)
          StrAdd(tempstr,fib.filename)
        ELSE
          cnt:=0
          s:=fib.filename;
          WHILE((s[0]) AND (cnt < 30))     /* check for valid file name */
            IF(s[0] = " ")      /* check for spaces at beginning of filename */
              JUMP fx2
            ENDIF
            IF(s[0] = "/")
             JUMP fx2
            ENDIF
            IF((isascii(s[0])))=FALSE
              JUMP fx2;
            ENDIF
            cnt++
            s++
          ENDWHILE

          /* get our copy to Filename */
          IF ownPartFiles
            StringF(tempstr2,'\sPartUpload/\s@\d-\d',currentConfDir,fib.filename,node,loggedOnUser.slotNumber)
          ELSE
            StringF(tempstr2,'\sPartUpload/\s@\d',currentConfDir,fib.filename,loggedOnUser.slotNumber)
          ENDIF

          IF(StrLen(sopt.ramPen)>0)
            StringF(tempstr,'\s\s',sopt.ramPen,fib.filename)
            REPEAT
              IF(tempstr[StrLen(tempstr)-1] = "/")
                 JUMP fx2
              ENDIF

              /* again not error, only for testing */
              /* check for valid copy */
              stat:=fileCopy(tempstr,tempstr2)
              IF(stat=FALSE) THEN StrAdd(tempstr2,'_')
            UNTIL (stat<>0) OR (StrLen(tempstr2)>=40)
              /* end if RamPen */
          ELSE    /* uploading to hdrive */
            StringF(tempstr,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,fib.filename)
            stat:=Rename(tempstr,tempstr2)
            err:=IoErr()
            IF((stat=0) AND (err=213))
              /* sx:  */
              REPEAT
                IF(tempstr[StrLen(tempstr)-1] = "/")
                  JUMP fx2
                ENDIF
                /* again not error, only for testing */
                /* check for valid filename */
                stat:=fileCopy(tempstr,tempstr2)
                IF(stat=FALSE)
                  StrAdd(tempstr2,'_')
                ELSE
                  -> #ifdef RTS
                  ->//(RTS) Sat Jun  6 21:23:40 1992  .. set cause we never knew we lost carrier with a parcial
                  ->// upload, there for when we went back from upload_a_file we didnt return goodbye or lost_carrier

                  ->//               partupload:=TRUE
                  ->#endif
                ENDIF
              UNTIL (stat<>0) OR (StrLen(tempstr2)>=40)
            ENDIF          /* end if(!stat&&err==213 */
          ENDIF            /* end else */
        ENDIF
        IF(stat)
          SetProtection(tempstr,FIBF_OTR_DELETE)
          DeleteFile(tempstr)
        ENDIF
      ENDIF                       /* end if(Fib->fib_DirEntryType < 0)  */
    ENDWHILE                      /* end while(ExNext(FLock,Fib))       */
  ENDIF                           /* end if(Fib->fib_DirEntryType > 0)  */

fx2:
  IF(fLock) THEN UnLock(fLock)
  IF(fib) THEN FreeDosObject(DOS_FIB,fib)
ENDPROC

PROC checkOurList(fname: PTR TO CHAR, str: PTR TO CHAR)
  DEF fp;
  DEF buff[255]:STRING
  ->DEF dest[255]:STRING

  IF((fp:=Open(fname,MODE_OLDFILE)))=0     /* can't find our file */
    RETURN RESULT_SUCCESS
  ENDIF

  WHILE((ReadStr(fp,buff)<>-1)) OR (StrLen(buff)>0)
    /* /X 4 changed this to just use simply text match
    IF(parsePatternNoCase2(buff,dest,200)<>-1)
      IF(MatchPatternNoCase(dest,str))
        Close(fp)
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF*/

    IF StriCmp(buff,str)
      Close(fp)
      RETURN RESULT_FAILURE
    ENDIF
  ENDWHILE
  Close(fp)
ENDPROC RESULT_SUCCESS

PROC checkForFile(fn: PTR TO CHAR)
  DEF path[255]:STRING,final[255]:STRING
  DEF x

  IF((InStr(fn,'%')>=0) OR ((InStr(fn,'#'))>=0) OR ((InStr(fn,'?'))>=0) OR ((InStr(fn,' '))>=0) OR ((InStr(fn,'/'))>=0) OR
    ((InStr(fn,'('))>=0) OR ((InStr(fn,')'))>=0) OR ((InStr(fn,':'))>=0) OR ((InStr(fn,'*'))>=0)) THEN RETURN RESULT_FAILURE

  /* here we can add our own file list of files to check */
  IF(StrLen(sopt.filesNot)>0)
    x:=checkOurList(sopt.filesNot,fn)   /* a list of files not to allow up */
    IF(x = RESULT_FAILURE) THEN RETURN RESULT_FAILURE
  ENDIF
  IF(lcFileXfr=FALSE)
    StrCopy(path,currentConfDir)
    StrAdd(path,'LcFiles/')
    StringF(final,'\s\s',path,fn)
    IF fileExists(final) THEN RETURN RESULT_FAILURE
  ENDIF
  ->//---------------- lcfiles checking finished
  x:=1;
  StringF(path,'DLPATH.\d',x)
  x++
  WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,final))
    checkPathSlash(final)
    StrAdd(final,fn)
    IF fileExists(final) THEN RETURN RESULT_FAILURE
    StringF(path,'DLPATH.\d',x)
    x++
  ENDWHILE
  x:=1
  StringF(path,'ULPATH.\d',x)
  x++
  WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,final))
    checkPathSlash(final)
    StrAdd(final,fn)
    IF fileExists(final) THEN RETURN RESULT_FAILURE
    StringF(path,'ULPATH.\d',x)
    x++
  ENDWHILE
ENDPROC RESULT_SUCCESS

PROC checkInPlaypens(s: PTR TO CHAR)
  DEF lock1,lock2,loop
  DEF tempstr[255]:STRING
  loop:=0;

  REPEAT
    IF(loop=node) THEN loop++

    StringF(tempstr,'\snode\d',cmds.bbsLoc,loop)
    IF(lock1:=Lock(tempstr,ACCESS_READ))
      StringF(tempstr,'\sNode\d/PLAYPEN/\s',cmds.bbsLoc,loop,s)
      IF(lock2:=Lock(tempstr,ACCESS_READ))
        UnLock(lock2)
        UnLock(lock1)
        RETURN 1
      ELSEIF(IoErr()<>205)
        UnLock(lock1)
        RETURN 1
      ENDIF
      UnLock(lock1)
    ENDIF
    loop++
  UNTIL lock1=NIL
ENDPROC 0

PROC doBgCheck()
  DEF bgport
  DEF msg:PTR TO jhMessage
  
  IF (zModemInfo.currentOperation=ZMODEM_UPLOAD) AND bgFileCheck AND ((loggedOnUserKeys.userFlags AND USER_BGFILECHECK) OR (checkToolTypeExists(TOOLTYPE_NODE,node,'FORCE_BGFILECHECK')))
      
    IF (bgport:=FindPort(bgCheckPortName))
      msg:=AllocMem(SIZEOF jhMessage,MEMF_ANY OR MEMF_CLEAR)
      IF msg
        msg.command:=BG_CHECKFILE
        AstrCopy(msg.string,FilePart(zModemInfo.fileName),200)
        msg.msg.ln.type:=NT_FREEMSG
        msg.msg.length:=SIZEOF jhMessage

        ->signal background checking to check the file
        PutMsg(bgport,msg)
      ENDIF
    ENDIF
  ENDIF
ENDPROC

PROC backgroundFileCheckThread()
  DEF bgCheckPort:PTR TO mp
  DEF msg:PTR TO jhMessage
  DEF exit=FALSE
  DEF msgcmd,type

  loadA4({threadtasksA4})

  bgCheckPort:=createPort(bgCheckPortName,0)
  IF bgCheckPort
    WHILE(exit=FALSE)
      WHILE(msg:=GetMsg(bgCheckPort))
        msgcmd:=msg.command       

        SELECT msgcmd
          CASE BG_EXIT
            exit:=TRUE
            ReplyMsg(msg)
            type:=msg.msg.ln.type
            IF type=NT_FREEMSG THEN FreeMem(msg,msg.msg.length)
          CASE BG_CHECKFILE
            doBackgroundCheck(msg.string)
            ReplyMsg(msg)
            type:=msg.msg.ln.type
            IF type=NT_FREEMSG THEN FreeMem(msg,msg.msg.length)
          CASE BG_CHECKFILE_THEN_QUIT
            doBackgroundCheck(msg.string)
            ReplyMsg(msg)
            type:=msg.msg.ln.type
            IF type=NT_FREEMSG THEN FreeMem(msg,msg.msg.length)
            exit:=TRUE
        ENDSELECT
      ENDWHILE
      IF exit=FALSE THEN WaitPort(bgCheckPort)
    ENDWHILE
  ENDIF
  deletePort(bgCheckPort)
  Exit(0)
ENDPROC 0

PROC displayOutPutofTest()
  DEF tempstr[255]:STRING
  StringF(tempstr,'\sOutPut_Of_Test',nodeWorkDir)
  nonStopDisplayFlag:=TRUE
  displayFile(tempstr,FALSE,FALSE)
ENDPROC

PROC checkFileExternal(temp: PTR TO CHAR, checkFile: PTR TO CHAR)
  DEF stat
  DEF fi
  DEF fi1
  DEF s[255]:STRING
  DEF i
  DEF fileName[256]:STRING,options[256]:STRING, image[256]:STRING
  DEF filetags:PTR TO LONG
  DEF stack,pri

  stat:=RESULT_SUCCESS

debugLog(LOG_ERROR,'debug10d1')

  IF readToolType(TOOLTYPE_FCHECK,temp,'CHECKER',s)
    StrCopy(options,s)
  ELSE
    RETURN 0,stat
  ENDIF

  IF readToolType(TOOLTYPE_FCHECK,temp,'OPTIONS',s)
    StrAdd(options,' ')
    StrAdd(options,s)
  ENDIF

  IF(readToolType(TOOLTYPE_FCHECK,temp,'STACK',s))
    stack:=Val(s)
  ELSE
    stack:=4096
  ENDIF

  IF(readToolType(TOOLTYPE_FCHECK,temp,'PRIORITY',s))
    pri:=Val(s)
  ELSE
    pri:=0
  ENDIF
  ->(RTS)
debugLog(LOG_ERROR,'debug10d2')
  StrAdd(options,' ')
  StrAdd(options,checkFile)
  StringF(fileName,'\sOutPut_Of_Test',nodeWorkDir)
  IF((fi:=Open(fileName,MODE_NEWFILE)))<>0
    filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,fi,NP_STACKSIZE,stack,NP_PRIORITY,pri,TAG_DONE]
debugLog(LOG_ERROR,'debug10d3')
    SystemTagList(options,filetags)
debugLog(LOG_ERROR,'debug10d4')
    FastDisposeList(filetags)
    Close(fi)

debugLog(LOG_ERROR,'debug10d5')
    IF bgChecking=FALSE THEN displayOutPutofTest()
debugLog(LOG_ERROR,'debug10d6')

    IF(readToolType(TOOLTYPE_FCHECK,temp,'SCRIPT',s))
      StrAdd(s,' ')
      IF(fi:=Open('NIL:',MODE_NEWFILE))<>0
        filetags:=NEW [SYS_INPUT,0,SYS_OUTPUT,fi,NP_STACKSIZE,stack,NP_PRIORITY,pri,TAG_DONE]
debugLog(LOG_ERROR,'debug10d7')
        StringF(options,'\s \s \s \d',s,checkFile,FilePart(checkFile),node)
        SystemTagList(options,filetags)
debugLog(LOG_ERROR,'debug10d8')
        FastDisposeList(filetags)
        Close(fi)
      ENDIF
    ENDIF
debugLog(LOG_ERROR,'debug10d9')

    StringF(options,'\sOutPut_Of_Test',nodeWorkDir)
    i:=1
    StringF(fileName,'ERROR.\d',i)
    i++
debugLog(LOG_ERROR,'debug10d10')
    WHILE(readToolType(TOOLTYPE_FCHECK,temp,fileName,s))
       fi1:=Open(options,MODE_OLDFILE)
       WHILE((ReadStr(fi1,image)<>-1)) OR (StrLen(image)>0)
         StrAdd(image,' ')
         IF(InStr(image,s))<>-1
           stat:=RESULT_FAILURE
         ENDIF
         EXIT stat=RESULT_FAILURE
       ENDWHILE
       Close(fi1);
       EXIT stat=RESULT_FAILURE
       StringF(fileName,'ERROR.\d',i)
       i++
    ENDWHILE
debugLog(LOG_ERROR,'debug10d11')
    SetProtection(options,FIBF_OTR_DELETE)
    DeleteFile(options)
debugLog(LOG_ERROR,'debug10d12')
  ELSE
debugLog(LOG_ERROR,'debug10d13')
    RETURN 0,stat
  ENDIF
debugLog(LOG_ERROR,'debug10d14')
ENDPROC 1,stat

PROC testFile(str: PTR TO CHAR, path: PTR TO CHAR)
  DEF x,x2,stat,r
  DEF temp[100]:STRING,temp2[100]:STRING
  DEF temp4[100]:STRING

  aeGoodFile:=RESULT_NOT_ALLOWED
  stat:=RESULT_NOT_ALLOWED

  StringF(temp2,'FILECHECK \s',str)
  IF (processSysCommand(temp2)=RESULT_SUCCESS) AND (aeGoodFile<>RESULT_NOT_TESTED)
    RETURN aeGoodFile
  ENDIF

  StrCopy(temp,str)
  x:=0
  REPEAT
    IF(temp[x]=".")
      x2:=0
      REPEAT
        temp2[x2]:=temp[x+x2+1]
        x2++
      UNTIL temp[x+x2+1]=0
      temp2[x2]:=0
      UpperStr(temp2)
      IF(StrLen(temp2)=3)
        StrCopy(temp4,path)
        aeGoodFile:=RESULT_NOT_ALLOWED
        stat:=RESULT_NOT_ALLOWED
        aePuts('Testing ...')
        aePuts(FilePart(str))
        aePuts('\b\n')

        StrAdd(temp4,temp)
debugLog(LOG_ERROR,'debug10d')
        r,stat:=checkFileExternal(temp2,temp4)
debugLog(LOG_ERROR,'debug10e')
        RETURN stat
      ENDIF
    ENDIF
    x++
  UNTIL x>=StrLen(temp) /* end do */
ENDPROC RESULT_NOT_ALLOWED

PROC displaySysopULStats()

  DEF i,num,num2
  DEF str[100]:STRING,str2[100]:STRING
  DEF fp
  DEF cb:PTR TO confBase

  IF(checkSecurity(ACS_USER_ULSTATS))
    FOR i:=1 TO cmds.numConf
      cb:=confBases.item(getConfIndex(i,1))
      IF (checkConfAccess(i))
        num:=0
        StringF(str,'\sNumULs',getConfLocation(i))
        IF((fp:=Open(str,MODE_OLDFILE)))<>0
          ReadStr(fp,str2)
          Close(fp)
          num:=Val(str2) AND 65535
        ENDIF
        num2:=num-(cb.uploadTracking AND 65535)
        IF num2<0 THEN num2:=num2+65536
        cb.uploadTracking:=num
        IF(num2<>0)
          StringF(str2,'\b\n\s has \d new file(s) uploaded.\b\n',getConfName(i),num2)
          aePuts(str2)
        ENDIF
      ENDIF
    ENDFOR
    
  ENDIF


  IF(checkSecurity(ACS_ULSTATS))=FALSE THEN RETURN

  FOR i:=1 TO cmds.numConf
    num:=0
    num2:=0
    StringF(str,'\sSysopStats/NumULs_\d',cmds.bbsLoc,i)
    IF((fp:=Open(str,MODE_OLDFILE)))<>0
      ReadStr(fp,str2)
      Close(fp)
      IF(loggedOnUser.slotNumber=1)
        SetProtection(str,FIBF_OTR_DELETE)
        DeleteFile(str)
      ENDIF
      num:=Val(str2)
    ENDIF

    StrAdd(str,'HOLD')
    IF((fp:=Open(str,MODE_OLDFILE)))<>0
      ReadStr(fp,str2)
      Close(fp)
      IF(loggedOnUser.slotNumber=1)
        SetProtection(str,FIBF_OTR_DELETE)
        DeleteFile(str)
      ENDIF
      num2:=Val(str2)
    ENDIF
    IF((num<>0) OR (num2<>0))
      StringF(str2,'\b\n\s has \d new uploads, \d upload, \d hold\b\n',getConfName(i),(num+num2),num,num2)
      aePuts(str2)
    ENDIF
  ENDFOR
ENDPROC

PROC sysopULStats(holdflag)
  DEF num
  DEF str[256]:STRING,str2[256]:STRING
  DEF ff
  DEF cb:PTR TO confBase

  IF holdflag=FALSE
    StringF(str,'\sNumULs',currentConfDir)
    num:=0
    IF((ff:=Open(str,MODE_OLDFILE)))<>0
      ReadStr(ff,str2)
      num:=Val(str2) AND 65535
      Close(ff)
    ENDIF
    num:=(num+1) AND 65535
    cb:=confBases.item(getConfIndex(currentConf,1))
    cb.uploadTracking:=num

    ff:=Open(str,MODE_NEWFILE)
    IF(ff<>0)
      StringF(str,'\d\n',num)
      fileWrite(ff,str)
      Close(ff)
    ENDIF
  ENDIF

  StringF(str,'\sSysopStats/NumULs_\d',cmds.bbsLoc,currentConf)
  IF(holdflag) THEN StrAdd(str,'HOLD')

  num:=0
  IF((ff:=Open(str,MODE_OLDFILE)))<>0
    ReadStr(ff,str2)
    num:=Val(str2)
    Close(ff)
  ENDIF
  num++
  ff:=Open(str,MODE_NEWFILE)
  IF(ff=0) THEN RETURN
  StringF(str,'\d\n',num)
  fileWrite(ff,str)
  Close(ff)
ENDPROC

PROC sysopUpload()
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF destpath[255]:STRING
  DEF string[255]:STRING
  DEF tmpBCD[8]:ARRAY OF CHAR
  DEF str[255]:STRING
  DEF stat,cnt
  DEF spacehi,spacelo,space2hi,space2lo
  DEF path[255]:STRING
  DEF status,x,ch

  aePuts('\b\nDestination path for upload? ')
  stat:=lineInput('','',250,INPUT_TIMEOUT,destpath)
  checkPathSlash(destpath)
  IF((stat<0) OR (StrLen(destpath)=0))
    aePuts('\b\n')
    RETURN
  ENDIF

  IF(findAssign(destpath))
    aePuts('\b\nDevice not Mounted.\b\n')
    aePuts('\b\n')
    RETURN
  ENDIF

  spacehi,spacelo:=rFreeSpace(destpath)                /* check free space - now in mb instead of bytes */
  IF(spacehi=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS

  IF(StrLen(sopt.ramPen)>0) THEN StrCopy(path,sopt.ramPen) ELSE StringF(path,'\sNode\d/Playpen/',cmds.bbsLoc,node)

  space2hi,space2lo:=rFreeSpace(path)

  IF((space2hi)<2)    /* Do we have 2 megs or free space ?? */
    IF checkToolTypeExists(TOOLTYPE_NODE,node,'RAMWORK')=FALSE
      myError(9)            /* no free space */
      RETURN RESULT_SUCCESS
    ENDIF
  ENDIF

  aePuts('\b\n')
  formatSpaceValue(spacehi,spacelo,tempstr)
  formatSpaceValue(space2hi,space2lo,tempstr2)
  StringF(string,'\s available for uploading.  \s at one time.\b\n',tempstr,tempstr2)   ->changed to indicate space in mb/gb/tb instead of bytes
  aePuts(string)

  ulFileCount:=0
  skipdFiles.clear()
  convertToBCD(0,dTBT)
  convertToBCD(0,uTBT)
  dlTTTM:=0
  ulTTTM:=0
  tTEFF:=0
  tTCPS:=0
  cnt:=0
  sysopUploading:=TRUE

  displayUserToCallersLog(1)
  fileReceive(path,1)     /* path of upload */

  sysopUploading:=FALSE
  aePuts('\b\n\b\nFile Uploading Complete...\b\n')

  CopyMem(uTBT,tmpBCD,8)
  divBCD1024(tmpBCD)
  formatBCD(tmpBCD,tempstr)

  ulTTTM:=Div(ulTTTM,50)
  StringF(string,' \d file(s), \sk bytes, \d minute(s). \d second(s), \d cps, \d% efficiency.',ulFileCount,tempstr,Div(ulTTTM,60),Mod(ulTTTM,60),tTCPS,tTEFF)
  aePuts(string)

  aePuts('\b\n\b\n')

  StrCopy(str,'\t')
  StrAdd(str,string)

  IF(ulFileCount>0)
    callersLog(str)
    udLog(str)
  ELSE
    callersLog('\tUpload Failed..')
    udLog('\tUpload Failed..')
  ENDIF

  IF(logonType>=LOGON_TYPE_REMOTE)
    IF checkCarrier()=FALSE
      cleanPlayPen()
      RETURN RESULT_SUCCESS
    ENDIF
  ENDIF

  FOR x:=0 TO recFileNames.count()-1
    StrCopy(str,recFileNames.item(x))

    IF(StrLen(sopt.ramPen)>0)
      StringF(tempstr,'\s\s',sopt.ramPen,str)
    ELSE
      StringF(tempstr,'\sNode\d/PLAYPEN/\s',cmds.bbsLoc,node,str)
    ENDIF
    StringF(tempstr2,'copying \s to \s',str,destpath)
    aePuts(tempstr2)

    StringF(tempstr2,'\s\s',destpath,str)

    IF fileExists(tempstr2)
      StringF(string,' - file exists, do you wish to overwrite? ',FilePart(tempstr2))
      aePuts(string)
      ch:=readChar(INPUT_TIMEOUT)
      IF(ch<0) THEN RETURN ch
      IF((ch="Y") OR (ch="y"))
        aePuts('Yes\b\n')
        DeleteFile(tempstr2)
      ELSE
        aePuts('No\b\n')
      ENDIF
    ELSE
      aePuts('\b\n')
    ENDIF

    status:=Rename(tempstr,tempstr2)
    IF(status=FALSE)
      fileCopy(tempstr,tempstr2)
      SetProtection(tempstr,FIBF_OTR_DELETE)
      DeleteFile(tempstr)
    ENDIF
  ENDFOR
  cleanPlayPen()
ENDPROC RESULT_SUCCESS

PROC formatFileSizeForDirList(fsize,fsstr:PTR TO CHAR)
  DEF tmpSize
  IF sopt.toggles[TOGGLES_CREDITBYKB]
    tmpSize:=Shr(fsize,10) AND $003fffff
    IF tmpSize<=999999
      StringF(fsstr,'\r\d[6]K',tmpSize)
    ELSE
      IF checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'CONVERT_TO_MB')=FALSE
        StringF(fsstr,'\dK',tmpSize)
      ELSE
        StringF(fsstr,'\r\d[4].\dM',Shr(fsize,20) AND $fff,Div(fsize-Shl(Shr(fsize,20) AND $fff,20),104858))
      ENDIF
    ENDIF
  ELSE
    IF fsize<=9999999
      StringF(fsstr,'\r\d[7]',fsize)
    ELSE
      IF checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'CONVERT_TO_MB')=FALSE
        StringF(fsstr,'\d',fsize)
      ELSE
        StringF(fsstr,'\r\d[4].\dM',Shr(fsize,20) AND $fff,Div(fsize-Shl(Shr(fsize,20) AND $fff,20),104858))
      ENDIF
    ENDIF
  ENDIF
ENDPROC

PROC uploadaFile(uLFType,cmd,attach,alreadyUploaded=FALSE)            -> JOE
  DEF fBlock: fileinfoblock
  DEF fLock
  DEF i,x,x2,x3,cnt,status,moveToLCFILES,hold,cstat,noF,lcfile
  DEF status2,gstat
  DEF peff,pcps,tFShi,tFSlo,fSUploadingHi,fSUploadingLo
  DEF path[256]:STRING,str[255]:STRING,istr[255]:STRING,str2[255]:STRING
  DEF fmtstr[256]:STRING
  DEF odate[20]:STRING,fcomment[256]:STRING
  DEF ray[256]:STRING,ray2[256]:STRING,string[256]:STRING
  DEF buff[255]:STRING
  DEF tmpBCD[8]:ARRAY OF CHAR
  DEF tempstr[255]:STRING,tempstr2[255]:STRING,tempstr3[255]:STRING
  DEF uaf,f
  DEF foundDupe=0
  DEF mstat      /* check for carrier. trying to stop upload guru from parcial upload */
  DEF fsstr[11]:STRING
  DEF tempsize,bgCnt
  DEF dizSysCmd[255]:STRING
  DEF exitLoop


  /* these two for testing asCII chars */
  DEF cnt1 = 0
  DEF s:PTR TO CHAR

  IF alreadyUploaded=FALSE
    ulFileCount:=0
    skipdFiles.clear()

    IF(maxDirs=0)
      aePuts('\b\n');
      myError(5)             ->Sorry no files in conf
      RETURN RESULT_FAILURE
    ENDIF

    IF(attach=FALSE)
      IF displayScreen(SCREEN_NOUPLOADS) THEN RETURN RESULT_SUCCESS
    ENDIF


    IF(uLFType=0)
      displayScreen(SCREEN_UPLOAD)
    ENDIF

    tFShi,tFSlo:=freeDiskSpace()                /* check free space - now in mb instead of bytes */
    IF(tFShi=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS

    IF(StrLen(sopt.ramPen)>0) THEN StrCopy(path,sopt.ramPen) ELSE StringF(path,'\sNode\d/Playpen/',cmds.bbsLoc,node)

    fSUploadingHi,fSUploadingLo:=rFreeSpace(path)

    IF((fSUploadingHi)<2)    /* Do we have 2 megs or free space ?? */
      IF checkToolTypeExists(TOOLTYPE_NODE,node,'RAMWORK')=FALSE
        myError(9)            /* no free space */
        RETURN RESULT_SUCCESS
      ENDIF
    ENDIF

    IF(uLFType=0)
      IF(StrLen(sopt.ramPen)>0)                     /* are we uploading to a diff device */
        StringF(buff,'\s UPLOADING to \s..\b\n',xprTitle.item(loggedOnUser.xferProtocol),sopt.ramPen)
      ELSE                        /* otherwise normal upload to playpen dir */
        StringF(buff,'\s UPLOADING....\b\n',xprTitle.item(loggedOnUser.xferProtocol))
      ENDIF

      aePuts(buff)                              /* show it to the user */

      formatSpaceValue(tFShi,tFSlo,tempstr)
      formatSpaceValue(fSUploadingHi,fSUploadingLo,tempstr2)
      StringF(string,'\s available for uploading.  \s at one time.\b\n',tempstr,tempstr2)   ->changed to indicate space in mb instead of bytes
      aePuts(string)
      aePuts('Filename lengths above 12 are not allowed.\b\n\b\n')

      zresume:=resumeStuff()
      IF(zresume<0) THEN RETURN zresume
      IF((zresume=0) AND StriCmp(cmd,'RG'))
        aePuts('\b\nThere are no more files to resume on.\b\n\b\n')
        RETURN RESULT_SUCCESS
      ENDIF
      IF(zresume=0)
        gstat:=uploadDesc()
        IF(gstat<0)
          cleanItUp()
          RETURN gstat
        ENDIF
      ENDIF
    ENDIF


    /* if user used 'rz' it never entered the above loop so gstat never got set */

    /* uploading to another device?? */
    IF(StrLen(sopt.ramPen)>0) THEN StrCopy(path,sopt.ramPen) ELSE StringF(path,'\sNode\d/Playpen/',cmds.bbsLoc,node)

    convertToBCD(0,dTBT)
    convertToBCD(0,uTBT)
    ulTTTM:=0
    dlTTTM:=0
    tTEFF:=0
    tTCPS:=0

    IF(beenUDd=FALSE)
      displayUserToCallersLog(1)
      beenUDd:=TRUE
    ENDIF

    fileReceive(path,uLFType)     /* path of upload */

    aePuts('\b\n\b\nFile Uploading Complete...\b\n')
  ENDIF

  peff:=NIL
  pcps:=NIL
  ObtainSemaphore(bgData)
  bgCnt:=bgData.checkedCount
  ReleaseSemaphore(bgData)

  IF(ulFileCount<>0) OR (bgCnt<>0)
    peff:=tTEFF
    pcps:=tTCPS
  ENDIF

  CopyMem(uTBT,tmpBCD,8)
  divBCD1024(tmpBCD)
  formatBCD(tmpBCD,tempstr)

  ulTTTM:=Div(ulTTTM,50)
  StringF(string,' \d file(s), \sk bytes, \d minute(s). \d second(s), \d cps, \d% efficiency.',ulFileCount,tempstr,Div(ulTTTM,60),Mod(ulTTTM,60),pcps,peff)
  aePuts(string)

  IF (pcps > loggedOnUserKeys.upCPS2)
    loggedOnUserKeys.upCPS2:=pcps
    IF pcps>65535 THEN pcps:=65535
    loggedOnUserKeys.oldUpCPS:=pcps
  ENDIF

  IF bgFileCheck AND ((loggedOnUserKeys.userFlags AND USER_BGFILECHECK) OR (checkToolTypeExists(TOOLTYPE_NODE,node,'FORCE_BGFILECHECK')))
    IF bgCnt>0
      StringF(tempstr,'\b\n\b\n\d files were checked and posted in the background during upload',bgCnt)
      aePuts(tempstr)
    ENDIF
    bgCnt:=0
  ENDIF

  aePuts('\b\n\b\n')

  StrCopy(str,'\t')
  StrAdd(str,string)

  IF((ulFileCount)>0)
    callersLog(str)
    udLog(str)
       
    doUploadNotify()
  ELSE
    callersLog('\tUpload Failed..')
    udLog('\tUpload Failed..')
  ENDIF

  IF ulTTTM<0
    StringF(str,'\t\t****UL ERROR (-) TIME USED = \d',-ulTTTM)
    callersLog(str)
  ENDIF

  peff:=(Div(Mul(ulTTTM,3),2)+60)
  IF(ulFileCount<1) OR (ulTTTM<1) THEN peff:=0

  IF(skipdFiles.count()>0)
    aePuts('The file(s) :\b\n')
    x:=0
    WHILE(x<skipdFiles.count())
      StringF(str,'\t\t\s\b\n',skipdFiles.item(x))
      aePuts(str)
      StringF(str,'\tSkipped \s',skipdFiles.item(x))
      callersLog(str)
      udLog(str)
      x:=x+1
    ENDWHILE
    aePuts('\b\n\t\tSKIPPED.  They already exist or have symbols.\b\n')
    skipdFiles.clear()
  ENDIF

  StringF(str,'Time increased by \d mins.\b\n\b\n',Div(peff,60))
  aePuts(str)

  timeLimit:=timeLimit+peff    /* add time to user while online */

  /* dunno why cause we dont return shit */
  checkOnlineStatus()    /* can return no carrier */

  purgeLine()

  IF(cmds.acLvl[LVL_KEEP_UPLOAD_CREDIT]>0) THEN loggedOnUser.timeTotal:=loggedOnUser.timeTotal+(Div(peff,2))

  moveToLCFILES:=0
  hold:=0
  lcfile:=0

  noF:=0
  cnt:=0
  x2:=0

  /* loop thru uploaded (ing) list of files & move to where they belong*/
  /* this gets the list of files uploaded */


  FOR x:=0 TO recFileNames.count()-1
    StrCopy(str,recFileNames.item(x))
    IF(cmds.acLvl[LVL_CAPITOLS_in_FILE]=1) THEN UpperStr(str)

    noF:=noF+1
    moveToLCFILES:=FALSE
    hold:=0
    lcfile:=0
    IF(noF>ulFileCount) THEN JUMP eit

    cnt:=0;   /* reset to zero */

    IF(StrLen(str)>0)

      formatLongDate(getSystemTime(),fmtstr)

      StrCopy(odate,fmtstr)

      /* add our check for ram playpen */
      IF(StrLen(sopt.ramPen)>0) THEN StringF(str2,'\s\s',sopt.ramPen,str) ELSE StringF(str2,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,str)

      IF((fLock:=Lock(str2,ACCESS_READ))=NIL)
        myError(8)
        JUMP nx
      ENDIF

      IF(fBlock:=(AllocDosObject(DOS_FIB,NIL))) = NIL
        myError(11)
        UnLock(fLock)
        RETURN RESULT_FAILURE
      ENDIF
      IF( Examine(fLock,fBlock) )
        fsize:=fBlock.size
        formatFileSizeForDirList(fsize,fsstr)
      ELSE
        StrCopy(fsstr,'')
      ENDIF

      UnLock(fLock)
      FreeDosObject(DOS_FIB,fBlock)

      IF((StrLen(str)>12) AND (moveToLCFILES=FALSE))
        /* if we loose carrier here with a +++, it will show up as
        the file name so check for carrier now */

        StringF(fmtstr,'\s is too long a name, please rename.\b\n\b\n',str)
        aePuts(fmtstr)
        aePuts('             [------------]')
inpAgain:
        IF(logonType>=LOGON_TYPE_REMOTE)
          cstat:=checkCarrier()
          IF(cstat=FALSE)
            modemOffHook()
            moveToLCFILES:=handleLCFiles(str,fcomment)
            JUMP cNext
          ENDIF
        ENDIF
        aePuts('\b\nNew Filename: ')
        status:=lineInput('','',12,INPUT_TIMEOUT,istr)
        IF(status<0)
          modemOffHook()
          moveToLCFILES:=handleLCFiles(str,fcomment)
         JUMP cNext
        ENDIF
        IF(StrLen(istr)=0) THEN JUMP inpAgain
        IF( ((istr[0]="R") AND (istr[1]="Z")) AND (StrLen(istr)= 2))
          aePuts('\b\nRZ is an invalid name for a file\b\n')
          JUMP inpAgain
        ENDIF

        x2:=0
        REPEAT          /* CHECK THE STRING */
          IF((istr[x2]=":") OR (istr[x2]="/") OR (istr[x2]="*") OR (istr[x2]=" ") OR (istr[x2]="#") OR (istr[x2] = "+") OR (istr[x2] = "?"))
             myError(10)  -> aePuts("\b\nYou may not include any special symbols\b\n");
             JUMP inpAgain
          ENDIF
          x2:=x2+1
        UNTIL x2>=StrLen(istr)

        status:=checkForFile(istr) /* should include RZ */
        IF(status=RESULT_FAILURE)
          StringF(tempstr,'The name \s is used, please rename.\b\n',istr)
          aePuts(tempstr)
          JUMP inpAgain
        ENDIF

        IF(StrLen(sopt.ramPen)>0)                       /* check Ram dir */
          StringF(tempstr,'\s\s',sopt.ramPen,istr)
          StringF(tempstr2,'\s\s',sopt.ramPen,str)
        ELSE
          StringF(tempstr,'\sNode\d/PlayPen/\s',cmds.bbsLoc,node,istr)
          StringF(tempstr2,'\sNode\d/PlayPen/\s',cmds.bbsLoc,node,str)
        ENDIF

        status:=Rename(tempstr2,tempstr)        /* oldstr, newstr */
        IF(status=NIL)
          StringF(tempstr2,'The name \s is used, please rename.\b\n',istr)
          aePuts(tempstr2)
          JUMP inpAgain
        ENDIF
        StrCopy(str,istr)
        StrCopy(str2,tempstr)
        IF(cmds.acLvl[LVL_CAPITOLS_in_FILE]=1) THEN UpperStr(str)  /* use upper case only */

        aePuts('\b\n')
      ENDIF    /* end if str > 12 */
      
      readToolType(TOOLTYPE_BBSCONFIG,'','FILEDIZ_SYSCMD',dizSysCmd)

      StringF(tempstr,'EXAMINE')
      IF runSysCommand(tempstr,str2)=RESULT_SUCCESS
        i:=1       
        REPEAT
          ->exit the background check if we just ran the file diz door and no diz was found
          exitLoop:=StriCmp(tempstr,dizSysCmd) AND (fileExists(str2)=FALSE)
          IF exitLoop=FALSE
            StringF(tempstr,'EXAMINE\d',i)
            i++
            exitLoop:=(runSysCommand(tempstr,str2)<>RESULT_SUCCESS)
          ENDIF
        UNTIL(exitLoop)
        
      ENDIF

cinpAgain:
      x2:=0
      IF(logonType>=LOGON_TYPE_REMOTE)
        cstat:=checkCarrier()
        IF(cstat=FALSE)
          modemOffHook()
          IF (moveToLCFILES:=handleLCFiles(str,fcomment)) THEN JUMP cNext
        ENDIF
      ENDIF

      StringF(fmtstr,'\s\s',nodeWorkDir,str)

      uaf:=Open(fmtstr,MODE_OLDFILE)
      IF(uaf=0)

        StringF(buff,'\b\nEnter a description, you only have \d lines.',max_desclines)
        aePuts(buff)

        aePuts('\b\nPress return alone to end.  Begin description with (/) to make upload ''Private''.\b\n')
        IF readToolType(TOOLTYPE_CONF,currentConf,'ULPROMPT',fmtstr)
          aePuts(fmtstr)
          aePuts('\b\n')
        ENDIF

        aePuts('                                [--------------------------------------------]\b\n')
        StringF(fmtstr,'\l\s[13] \s  \s :',str,fsstr,odate)
        aePuts(fmtstr)

        status:=lineInput('','',44,INPUT_TIMEOUT,fcomment)
        IF(status<0)
          modemOffHook()
          moveToLCFILES:=handleLCFiles(str,fcomment)
          JUMP cNext
        ENDIF

        IF(StrLen(fcomment)=0) THEN JUMP cinpAgain

        IF( ((fcomment[0]) = "R" OR (fcomment[0] = "r")) AND ((fcomment[1] = "Z") OR (fcomment[1] = "z")) AND (StrLen(fcomment) < 4) ) THEN JUMP cinpAgain

        /* stop that B0 shit */
        IF((fcomment[0] = "B") AND (fcomment[1] ="0")) THEN JUMP cinpAgain

        s:=fcomment
        cnt1:=0
        WHILE(s[0] AND (cnt1 < 20))
          IF((isascii((s[0])))=FALSE) THEN JUMP cinpAgain
          cnt1++
          s++
        ENDWHILE

        REPEAT
          aePuts('                                :')
          status:=lineInput('','',44,INPUT_TIMEOUT,tempstr)
          scomment.setItem(x2,tempstr)
          IF(status<0)
            modemOffHook()
            moveToLCFILES:=handleLCFiles(str,fcomment)
            FOR i:=0 TO x2
              scomment.setItem(i,'')
            ENDFOR
            JUMP cNext
          ENDIF
          x2:=x2+1
        UNTIL ((StrLen(scomment.item(x2-1))=0) OR (x2>= (max_desclines-1)))
      ELSE
        ReadStr(uaf,fcomment)
        WHILE(ReadStr(uaf,tempstr)<>-1) OR (StrLen(tempstr)>0)
          scomment.setItem(x2,tempstr)
          x2:=x2+1
          EXIT (x2>=(max_desclines-1))
        ENDWHILE
        Close(uaf)
      ENDIF
cNext:
      status2:=RESULT_NOT_ALLOWED
      IF((moveToLCFILES=FALSE) AND (rzmsg=FALSE))
        StringF(fmtstr,'\b\nTesting... \s...\b\n',str)
        status2:=testFile(str,path)
        IF((status2=RESULT_NOT_ALLOWED) OR (status2=RESULT_SUCCESS)) THEN aePuts('\b\nTested Ok...')
      ENDIF

      status:=checkForFile(str)

      IF(moveToLCFILES)
        status:=RESULT_LCFILES
      ELSE
        IF((fcomment[0]="/") AND (rzmsg=NIL)) THEN status:=RESULT_PRIVATE
      ENDIF

      IF(status2=RESULT_FAILURE)            /* Move to a Hold AREA */
        hold:=1
        StringF(tempstr,'Requires review, possibly bad format\b\n\t  Moving to \s''s private Directory.\b\n\b\n',cmds.sysopName)
        aePuts(tempstr)
        JUMP move_It
      ENDIF

      IF(status=RESULT_FAILURE)             /* Move to a Hold AREA */
        IF(foundDupe)
          StringF(tempstr,'\b\nFile already exists, moving to \s''s private directory\b\n',cmds.sysopName)
          aePuts(tempstr)
          hold:=1
        ENDIF
      ENDIF

      IF(status=RESULT_SUCCESS)            /* Move to Upload AREA */
        hold:=NIL
        IF creditAccountTrackUploads(loggedOnUser)
          loggedOnUser.uploads:=loggedOnUser.uploads+1
        ENDIF
      ENDIF
      IF(status=RESULT_LCFILES)
        lcfile:=1
        rzmsg:=NIL
        aePuts('\b\nCarrier lost, moving to lost carrier directory.\b\n')
      ENDIF

      IF(status=RESULT_PRIVATE)             /* Private Upload */
        hold:=1
        rzmsg:=NIL
        StringF(tempstr,'\b\nMoving to \s''s private directory.\b\n\b\n',cmds.sysopName)
        aePuts(tempstr)
      ENDIF

      IF(rzmsg)
         aePuts('\b\nMoving to message base file directory.\b\n')
      ENDIF
move_It:     /* gets here if lostcarrier, and file is complete but not when file is incomplete */

      IF(hold OR lcfile OR rzmsg)
        IF(lcfile) THEN StringF(tempstr2,'\sLCFILES/\s',currentConfDir,str)
        IF(hold) THEN StringF(tempstr2,'\sHOLD/\s',currentConfDir,str)
        IF(rzmsg) THEN StringF(tempstr2,'\sF\d/\s',msgBaseLocation,mailHeader.msgNumb,str)

        IF(StrLen(sopt.ramPen)>0)
          StringF(tempstr,'\s\s',sopt.ramPen,str)
        ELSE
          StringF(tempstr,'\sNode\d/PLAYPEN/\s',cmds.bbsLoc,node,str)
        ENDIF

        status:=0
        WHILE((StrLen(FilePart(tempstr2))<35) AND (status=FALSE))
          status:=Rename(tempstr,tempstr2)
          IF(status=FALSE)
            status:=fileCopy(tempstr,tempstr2)
            IF(status=FALSE) THEN StrAdd(tempstr2,'_')
            IF(status)
              SetProtection(tempstr,FIBF_OTR_DELETE)
              DeleteFile(tempstr)
            ENDIF
          ENDIF
        ENDWHILE

        StrCopy(tempstr,'\tUpload ')
        IF(status=NIL)
          StringF(tempstr2,'WARNING!\b\nUnable to move file!\b\n')
          aePuts(tempstr2)
          StrAdd(tempstr,'unable to be ')
        ENDIF
        StringF(tempstr3,'moved to \s',tempstr2)
        StrAdd(tempstr,tempstr3)
        callersLog(tempstr)
      ELSE
        moveFile(str,fsize)
      ENDIF

      sysopULStats(hold)
      /* Add Uploaded Bytes to Users Account */
      IF((hold=NIL) AND (lcfile=NIL) AND (rzmsg=NIL))
        IF creditAccountTrackUploads(loggedOnUser)
          IF sopt.toggles[TOGGLES_CREDITBYKB] THEN fsize:=Shr(fsize,10) AND $003fffff
          addBCD(loggedOnUserMisc.uploadBytesBCD,fsize)
          loggedOnUser.bytesUpload:=convertFromBCD(loggedOnUserMisc.uploadBytesBCD)
       ENDIF
      ENDIF

      /* Build the first line to send to upload dir */
      IF(lcfile AND (StrLen(str) > 12))
        StringF(fmtstr,'\s \s  \s  \s\n',str,fsstr,odate,fcomment)
      ELSE
        StringF(fmtstr,'\l\s[13] \s  \s  \s\n',str,fsstr,odate,fcomment)
      ENDIF


      IF(StrLen(str) < 13)       /* for big file name on lost carrier */
        IF(checksym)
          fmtstr[13]:=checksym
        ELSE
          IF(status2=RESULT_FAILURE) THEN fmtstr[13]:="F"
          IF(status2=RESULT_SUCCESS) THEN fmtstr[13]:="P"
          IF(status2=RESULT_NOT_ALLOWED) THEN fmtstr[13]:="N"
        ENDIF
        IF(foundDupe)
          fmtstr[13]:="D"
          foundDupe:=0
        ENDIF
      ENDIF

      IF((hold=NIL) AND (lcfile=NIL))
        IF(rzmsg=FALSE)
          StrCopy(ray,currentConfDir);
          StrAdd(ray,'DIR')
          StringF(ray2,'\d',maxDirs)
          StrAdd(ray,ray2)
        ELSE
          StringF(ray,'\sF\d/\s.dis',msgBaseLocation,mailHeader.msgNumb,str)
        ENDIF
      ELSE
        StrCopy(ray,currentConfDir)
        IF(lcfile)
          StrAdd(ray,'LCFILES/')
          StrAdd(ray,purgeScanNM)
          StrAdd(ray,'.lc')
        ELSE
          StrAdd(ray,'HOLD/HELD')
        ENDIF
      ENDIF

      f:=Open(ray,MODE_READWRITE)
      Seek(f,0,OFFSET_END)
      fileWrite(f,fmtstr)
      x3:=0;
      WHILE(x2)
        /* Print the comment lines */
        IF(StrLen(scomment.item(x3))>0)
          StringF(tempstr,'                                 \s\n',scomment.item(x3))
          fileWrite(f,tempstr)
          scomment.setItem(x3,'')
          x3:=x3+1
        ENDIF
        x2:=x2-1
      ENDWHILE
      IF(checkToolTypeExists(TOOLTYPE_NODE,node,'SENTBY_FILES'))   /* Print the Sent by: line */
        StringF(tempstr,'                                 Sent by: \s\n',loggedOnUser.name)
        fileWrite(f,tempstr)
      ENDIF
      Close(f)
    ENDIF   /*if strlen > 1 */

 nx:
  ENDFOR       /* else */

eit:

  ->purgeLine();

  cleanPlayPen()

  cleanItUp()

  /* we get here after lcfile but gugued*/
  tempsize:=convertFromBCD(uTBT)
  IF sopt.toggles[TOGGLES_CREDITBYKB]
    tempsize:=Shr(tempsize,10) AND $003fffff
  ENDIF

  IF(lcfile=FALSE) AND (bytesADL<>$7fffffff)
    loggedOnUser.todaysBytesLimit:=loggedOnUser.todaysBytesLimit+tempsize
    bytesADL:=bytesADL+tempsize     /* dont add bytes if files moved to LCFILES DIR */
  ENDIF

  displayULStats(loggedOnUser,loggedOnUserMisc)          /* Show User stats.. Num Dnloads, uploads */
  aePuts('\b\n')

  mstat:=checkOnlineStatus()
  IF(mstat<0)
    RETURN mstat
  ENDIF

  IF(uLFType=FALSE)     /* nor a rz upload */
    IF(gstat=2)
      RETURN pGoodbye()
    ENDIF
  ENDIF

ENDPROC RESULT_SUCCESS

PROC doBackgroundCheck(fname:PTR TO CHAR)
  DEF i
  DEF fileName[255]:STRING
  DEF path[255]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF tempstr3[255]:STRING
  DEF fmtstr[255]:STRING
  DEF fcomment[255]:STRING
  DEF status,status2,fsize
  DEF fh,hold,x2,x3,exitLoop

  DEF dizSysCmd[255]:STRING

  IF (StrLen(fname)>0) AND (StrLen(fname)<=12)

    readToolType(TOOLTYPE_BBSCONFIG,'','FILEDIZ_SYSCMD',dizSysCmd)

    IF(StrLen(sopt.ramPen)>0)
      StrCopy(path,sopt.ramPen)
      StringF(fileName,'\s\s',sopt.ramPen,fname)
    ELSE
      StringF(path,'\sNode\d/Playpen/',cmds.bbsLoc,node)
      StringF(fileName,'\sNode\d/Playpen/\s',cmds.bbsLoc,node,fname)
    ENDIF

    IF fileExists(fileName)
      StringF(tempstr,'\s\s',nodeWorkDir,fname)
      StrCopy(tempstr2,'EXAMINE')
      IF runSysCommand(tempstr2,fileName)=RESULT_SUCCESS
        i:=1
        REPEAT
          ->exit the background check if we just ran the file diz door and no diz was found
          exitLoop:=StriCmp(tempstr2,dizSysCmd) AND (fileExists(tempstr)=FALSE)
          IF exitLoop=FALSE
            StringF(tempstr2,'EXAMINE\d',i)
            i++
            exitLoop:=(runSysCommand(tempstr2,fileName)<>RESULT_SUCCESS)
          ENDIF
        UNTIL(exitLoop)
        
        IF fileExists(tempstr)

          fh:=Open(tempstr,MODE_OLDFILE)
          x2:=0
          IF fh<>0
            ReadStr(fh,fcomment)
            WHILE(ReadStr(fh,tempstr)<>-1) OR (StrLen(tempstr)>0)
              scomment.setItem(x2,tempstr)
              x2:=x2+1
              EXIT (x2>=(max_desclines-1))
            ENDWHILE
            Close(fh)
          ENDIF

          fsize:=FileLength(fileName)


          status2:=RESULT_NOT_ALLOWED
          status2:=testFile(fname,path)
          status:=checkForFile(fname)


          IF(fcomment[0]="/") THEN status:=RESULT_PRIVATE

          hold:=0

          IF(status2=RESULT_FAILURE)            /* Move to a Hold AREA */
            hold:=1
            ->StringF(tempstr,'Requires review, possibly bad format\b\n\t  Moving to \s''s private Directory.\b\n\b\n',cmds.sysopName)
            ->aePuts(tempstr)
          ELSEIF(status=RESULT_FAILURE)             /* Move to a Hold AREA */
            ->StringF(tempstr,'\b\nFile already exists, moving to \s''s private directory\b\n',cmds.sysopName)
            ->aePuts(tempstr)
            hold:=1
          ELSEIF(status=RESULT_SUCCESS)            /* Move to Upload AREA */
            hold:=0
            IF creditAccountTrackUploads(loggedOnUser)
              loggedOnUser.uploads:=loggedOnUser.uploads+1
            ENDIF
          ELSEIF(status=RESULT_PRIVATE)             /* Private Upload */
            hold:=1
            ->StringF(tempstr,'\b\nMoving to \s''s private directory.\b\n\b\n',cmds.sysopName)
            ->aePuts(tempstr)
          ENDIF

          IF(hold)
            StringF(tempstr2,'\sHOLD/\s',currentConfDir,fname)

            IF(StrLen(sopt.ramPen)>0)
              StringF(tempstr,'\s\s',sopt.ramPen,fname)
            ELSE
              StringF(tempstr,'\sNode\d/PLAYPEN/\s',cmds.bbsLoc,node,fname)
            ENDIF

            status:=0
            WHILE((StrLen(FilePart(tempstr2))<35) AND (status=FALSE))
              status:=Rename(tempstr,tempstr2)
              IF(status=FALSE)
                status:=fileCopy(tempstr,tempstr2)
                IF(status=FALSE) THEN StrAdd(tempstr2,'_')
                IF(status)
                  SetProtection(tempstr,FIBF_OTR_DELETE)
                  DeleteFile(tempstr)
                ENDIF
              ENDIF
            ENDWHILE

            StrCopy(tempstr,'\tUpload ')
            IF(status=NIL)
              StrAdd(tempstr,'unable to be ')
            ENDIF
            StringF(tempstr3,'moved to \s',tempstr2)
            StrAdd(tempstr,tempstr3)
            callersLog(tempstr)
          ELSE
            moveFile(fname,fsize)
          ENDIF

          ObtainSemaphore(bgData)
          bgData.checkedCount:=bgData.checkedCount+1
          addBCD(bgData.checkedBytes,fsize)
          ReleaseSemaphore(bgData)

          sysopULStats(hold)
          /* Add Uploaded Bytes to Users Account */
          IF((hold=NIL))
            IF creditAccountTrackUploads(loggedOnUser)
              IF sopt.toggles[TOGGLES_CREDITBYKB] THEN fsize:=Shr(fsize,10) AND $003fffff
              addBCD(loggedOnUserMisc.uploadBytesBCD,fsize)
              loggedOnUser.bytesUpload:=convertFromBCD(loggedOnUserMisc.uploadBytesBCD)
           ENDIF
          ENDIF
          IF (bytesADL<>$7fffffff)
            loggedOnUser.todaysBytesLimit:=loggedOnUser.todaysBytesLimit+fsize
            bytesADL:=bytesADL+fsize
          ENDIF


          formatFileSizeForDirList(fsize,tempstr)
          formatLongDate(getSystemTime(),tempstr2)

          /* Build the first line to send to upload dir */
          StringF(fmtstr,'\l\s[13] \s  \s  \s\n',fname,tempstr,tempstr2,fcomment)

          IF(checksym)
            fmtstr[13]:=checksym
          ELSE
            IF(status2=RESULT_FAILURE) THEN fmtstr[13]:="F"
            IF(status2=RESULT_SUCCESS) THEN fmtstr[13]:="P"
            IF(status2=RESULT_NOT_ALLOWED) THEN fmtstr[13]:="N"
          ENDIF

          IF(hold=NIL)
            StrCopy(tempstr3,currentConfDir);
            StrAdd(tempstr3,'DIR')
            StringF(tempstr2,'\d',maxDirs)
            StrAdd(tempstr3,tempstr2)
          ELSE
            StrCopy(tempstr3,currentConfDir)
            StrAdd(tempstr3,'HOLD/HELD')
          ENDIF

          fh:=Open(tempstr3,MODE_READWRITE)
          Seek(fh,0,OFFSET_END)
          fileWrite(fh,fmtstr)
          x3:=0;
          WHILE(x2)
            /* Print the comment lines */
            IF(StrLen(scomment.item(x3))>0)
              StringF(tempstr,'                                 \s\n',scomment.item(x3))
              fileWrite(fh,tempstr)
              scomment.setItem(x3,'')
              x3:=x3+1
            ENDIF
            x2:=x2-1
          ENDWHILE
          IF(checkToolTypeExists(TOOLTYPE_NODE,node,'SENTBY_FILES'))   /* Print the Sent by: line */
            StringF(tempstr,'                                 Sent by: \s\n',loggedOnUser.name)
            fileWrite(fh,tempstr)
          ENDIF
          Close(fh)
        ENDIF
      ENDIF
    ENDIF
  ENDIF
ENDPROC

PROC handleLCFiles(fname:PTR TO CHAR, fcomment:PTR TO CHAR)
  DEF fileName[255]:STRING
  DEF lcString[255]:STRING
  DEF fh

  StringF(fileName,'\s\s',nodeWorkDir,fname)

  runSysCommand('LCFILES',fname)

  IF fileExists(fileName)
    fh:=Open(fileName,MODE_OLDFILE)
    IF(fh<>0)
      ReadStr(fh,lcString)
      StrCopy(fcomment,lcString)
      Close(fh)
      RETURN (StrLen(fname)>12)
    ENDIF
  ENDIF

  fh:=Open(fileName,MODE_NEWFILE)
  IF(fh<>0)
    StringF(lcString,'LOST CARRIER \s',loggedOnUser.name)

    fileWrite(fh,lcString)
    Close(fh)
    StrCopy(fcomment,lcString)
  ENDIF

ENDPROC TRUE

PROC creditAccountEnabled(hoozer: PTR TO user)
  IF hoozer.creditDays=0 THEN RETURN FALSE
  IF getSystemTime()>(hoozer.creditStartDate+Mul(hoozer.creditDays,86400)) THEN RETURN FALSE
ENDPROC TRUE

PROC creditAccountTrackDownloads(hoozer: PTR TO user)
  IF (creditAccountEnabled(hoozer)=FALSE) THEN RETURN TRUE
  IF (hoozer.creditTracking AND TRACK_DOWNLOADS_BIT) THEN RETURN TRUE
ENDPROC FALSE

PROC creditAccountTrackUploads(hoozer: PTR TO user)
  IF creditAccountEnabled(hoozer)=FALSE THEN RETURN TRUE
  IF (hoozer.creditTracking AND TRACK_UPLOADS_BIT) THEN RETURN TRUE
ENDPROC FALSE

PROC downloadPrompt(ratioType, mins, bytes, filespec, files, str:PTR TO CHAR)

 IF(ratioType=0) THEN StringF(str,'\b\n\d mins, \d bytes, Filespec(\d): ',mins,bytes,filespec)
 IF(ratioType=2) THEN StringF(str,'\b\n\d mins, \d files, Filespec(\d): ',mins,files,filespec)
 IF(ratioType=1) THEN StringF(str,'\b\n\d mins, \d bytes, \d files, Filespec(\d): ',mins,bytes,files,filespec)
ENDPROC

PROC beginDLF(cmdcode,params)      /* begin downloading */
  DEF stat
  stat:=downloadAFile(cmdcode,params)
  IF(stat=RESULT_GOODBYE) THEN modemOffHook()
ENDPROC stat

PROC calcConfBad(confNum)
  DEF cb:PTR TO confBase
  DEF badBCD[8]:ARRAY OF CHAR
  DEF bad
  DEF i

  cb:=confBases.item(getConfIndex(confNum,1))

  IF(cb.ratioType<2)
    convertToBCD(0,badBCD)
    FOR i:=1 TO cb.ratio
      addBCD2(badBCD,cb.uploadBytesBCD)
    ENDFOR
    subBCD2(badBCD,cb.downloadBytesBCD)
    IF badBCD[0]>=$50
      ->result was negative
      bad:=0
    ELSE
      bad:=convertFromBCD(badBCD)

      ->bad needs to be used in a signed comparison, so don't allow values >7fffffff
      IF bad<0 THEN bad:=$7fffffff
    ENDIF
  ENDIF
ENDPROC bad

PROC checkRatiosAndTime(minsptr:PTR TO LONG,sizeptr:PTR TO LONG,cntptr:PTR TO LONG,errormsg:PTR TO CHAR, estDlCPS,tfsizes:PTR TO stdlist,freeDFlags:PTR TO stdlist)
  ->DEF string[300]:STRING
  DEF tsec,min,tempsize
  DEF tbad,bad,nad=0
  DEF i
  DEF freeDFlag=0
  DEF cb:PTR TO confBase
  
  tempsize:=0
  FOR i:=1 TO cmds.numConf
      tempsize:=tempsize+tfsizes.item(i-1)
  ENDFOR
  
  tsec:=Div(tempsize,estDlCPS)
  min:=tsec/60
  minsptr[]:=min
  
  IF(((Div(timeLimit,60))-min)<0) AND (checkSecurity(ACS_OVERRIDE_TIMELIMIT)=FALSE)
    StrCopy(errormsg,'Not enough time for requested downloads.')
    RETURN FALSE
  ENDIF

  IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING))
    saveMsgPointers(currentConf,currentMsgBase)
    tempsize:=0
    FOR i:=0 TO cmds.numConf-1
      tempsize:=tempsize+tfsizes.item(i)
    ENDFOR
    IF sopt.toggles[TOGGLES_CREDITBYKB] THEN tempsize:=Shr(tempsize,10) AND $003fffff

    IF(tempsize>bytesADL)
      StrCopy(errormsg,'Not enough daily byte allowance for requested downloads')
      RETURN FALSE
    ENDIF

    FOR i:=1 TO cmds.numConf
      tempsize:=tfsizes.item(i-1)
      freeDFlag:=freeDFlags.item(i-1)

      IF sopt.toggles[TOGGLES_CREDITBYKB] THEN tempsize:=Shr(tempsize,10) AND $003fffff

      IF tempsize>0
        bad:=calcConfBad(i)
        cb:=confBases.item(getConfIndex(i,1))

        IF(((bad-tempsize)<0) AND (cb.ratioType<2) AND (cb.ratio<>0) AND (creditAccountEnabled(loggedOnUser)=FALSE))
          StringF(errormsg,'Conf \d: Not enough free bytes for requested downloads.',relConf(i))
          RETURN FALSE
        ENDIF

        IF (cb.ratioType>0) AND (cb.ratio<>0) AND (creditAccountEnabled(loggedOnUser)=FALSE)
          nad:=(cb.ratio*(cb.upload+1))-cb.downloads

          IF (nad<freeDFlag)
            StringF(errormsg,'Conf \d: Not enough free files for requested number of downloads.',relConf(i))
            RETURN FALSE
          ENDIF
        ENDIF

        EXIT ((nad=freeDFlag) AND ((cb.ratio<>0) AND (cb.ratioType>0)))
      ENDIF
    ENDFOR

    tempsize:=tfsizes.item(currentConf-1)
    freeDFlag:=freeDFlags.item(currentConf-1)
    bad:=calcConfBad(currentConf)
    IF bad<bytesADL THEN tbad:=bad ELSE tbad:=bytesADL
    nad:=0
    IF (cb.ratioType>0) AND (cb.ratio<>0) AND (creditAccountEnabled(loggedOnUser)=FALSE)
      nad:=(cb.ratio*(cb.upload+1))-cb.downloads
    ENDIF


  ELSE
    tempsize:=0
    freeDFlag:=0
    nad:=0

    FOR i:=0 TO cmds.numConf-1
      tempsize:=tempsize+tfsizes.item(i)
      freeDFlag:=freeDFlag+freeDFlags.item(i)
    ENDFOR
    IF sopt.toggles[TOGGLES_CREDITBYKB] THEN tempsize:=Shr(tempsize,10) AND $003fffff

    IF bad<bytesADL THEN tbad:=bad ELSE tbad:=bytesADL

    IF(tempsize>bytesADL)
      StrCopy(errormsg,'Not enough daily byte allowance for requested downloads')
      RETURN FALSE
    ENDIF

    IF(((tbad-tempsize)<0) AND (loggedOnUser.secBoard<2) AND (loggedOnUser.secLibrary<>0) AND (creditAccountEnabled(loggedOnUser)=FALSE))
      StrCopy(errormsg,'Not enough free bytes for requested downloads.')
      RETURN FALSE
    ENDIF

    IF (loggedOnUser.secBoard>0) AND (loggedOnUser.secLibrary<>0) AND (creditAccountEnabled(loggedOnUser)=FALSE)
      nad:=(loggedOnUser.secLibrary*(loggedOnUser.uploads+1))-loggedOnUser.downloads

      IF (nad<freeDFlag)
        StrCopy(errormsg,'Not enough free files for requested number of downloads.\b\n\b\n')
        RETURN FALSE
      ENDIF
    ENDIF

  ENDIF
  sizeptr[]:=tbad-tempsize
  cntptr[]:=nad-freeDFlag
  
  IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING))
    IF((nad=freeDFlag) AND ((cb.ratio<>0) AND (cb.ratioType>0))) THEN RETURN 1
  ELSE
    IF((nad=freeDFlag) AND ((loggedOnUser.secLibrary<>0) AND (loggedOnUser.secBoard>0))) THEN RETURN 1
  ENDIF

  
ENDPROC 2

PROC downloadAFile(cmdcode: PTR TO CHAR, params) HANDLE
  DEF string[300]:STRING
  DEF tsec,min,secs,i,x,status,mystat,proto
  DEF peff,pcps
  ->DEF tempsize,tbad
  DEF tmpBCD[8]:ARRAY OF CHAR
  DEF bcdStr[20]:STRING
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF tempList=NIL:PTR TO stdlist
  DEF item:PTR TO flagFileItem
  DEF finalList:PTR TO stdlist
  DEF tfsizes=NIL:PTR TO stdlist
  DEF freeDFlags=NIL:PTR TO stdlist
  DEF estDlCPS,cnt,size

  proto:=0
  numFiles:=0

  aePuts('\b\n')
  IF(maxDirs=0)
    myError(5) ->Sorry()
    RETURN RESULT_FAILURE
  ENDIF

  IF (quietDownload=FALSE)
    IF (displayScreen(SCREEN_DOWNLOAD))
      doPause()
      aePuts('\b\n')
    ENDIF
  ENDIF

  IF loggedOnUserMisc.lastDlCPS<>0
    estDlCPS:=loggedOnUserMisc.lastDlCPS
  ELSE
    estDlCPS:=Div(onlineBaud,10)
  ENDIF
  
  convertToBCD(0,dtfsize)

  displayULStats(loggedOnUser,loggedOnUserMisc)              /* Show User stats.. Num Dnloads, uploads */

  IF(loggedOnUser.secLibrary<>0)     /* Dont have a zero ratio */
    IF((loggedOnUser.secBoard>0) AND (creditAccountEnabled(loggedOnUser)=FALSE))
      cnt:=(loggedOnUser.secLibrary*(loggedOnUser.uploads+1))-loggedOnUser.downloads
      StringF(string,'Files Avail before UL : \d\b\n',cnt)
      aePuts(string)
      IF(cnt<1)
        exceedRatio()
        RETURN RESULT_SUCCESS
      ENDIF
    ENDIF
    IF(loggedOnUser.secBoard<2)

      convertToBCD(0,tmpBCD)
      FOR i:=1 TO loggedOnUser.secLibrary
        addBCD2(tmpBCD,loggedOnUserMisc.uploadBytesBCD)
      ENDFOR
      subBCD2(tmpBCD,loggedOnUserMisc.downloadBytesBCD)
      IF tmpBCD[0]>=$50
        ->result was negative
        StrCopy(bcdStr,'0')
        cnt:=0
      ELSE
        formatBCD(tmpBCD,bcdStr)
        cnt:=convertFromBCD(tmpBCD)

        ->bad needs to be used in a signed comparison, so don't allow values >7fffffff
        IF cnt<0 THEN cnt:=$7fffffff
      ENDIF

      IF cnt=$7fffffff THEN StrCopy(bcdStr,'Infinite')

      IF sopt.toggles[TOGGLES_CREDITBYKB]
        StringF(string,'KBytes Avail before UL : \s\b\n',bcdStr)
      ELSE
        StringF(string,'Bytes Avail before UL : \s\b\n',bcdStr)
      ENDIF
      aePuts(string)

      IF(cnt<1)
        exceedRatio()
        RETURN RESULT_SUCCESS
      ENDIF
    ENDIF
  ELSE
    aePuts('Download to Upload Ratio : Disabled.\b\n')
  ENDIF

  IF (quietDownload=FALSE)
    aePuts('Space between filenames.  ')
    IF checkSecurity(ACS_FILE_EXPANSION)=FALSE THEN aePuts('No ')
    aePuts('Wildcards permitted.\b\n')
    ->AEPutStr("      Zmodem Uploading & Downloading only\b\n")
  ENDIF

  tempList:=NEW tempList.stdlist(flagFilesList.count()+1)
  sysopdl:=FALSE

  IF (StriCmp(cmdcode,'DS')) AND (checkSecurity(ACS_SYSOP_DOWNLOAD))
    sysopdl:=TRUE
    StringF(string,'\tSYSOP DOWNLOAD: \s',cmdcode)
    callersLog(string)
    udLog(string)

    addFlagItems(tempList,currentConf,params)
  ELSE
    addFlagItems(tempList,currentConf,params)

    FOR i:=0 TO flagFilesList.count()-1
      item:=flagFilesList.item(i)
      addFlagItem(tempList,item.confNum,item.fileName)
    ENDFOR

  ENDIF

  tfsizes:=NEW tfsizes.stdlist(cmds.numConf)
  freeDFlags:=NEW freeDFlags.stdlist(cmds.numConf)
  finalList:=NEW finalList.stdlist(MAX_FLAGGED_FILES)
  FOR i:=0 TO cmds.numConf-1
    tfsizes.add(0)
    freeDFlags.add(0)
  ENDFOR

  IF(tempList.count()<>0)
    aePuts('\b\nChecking...\b\n')
    IF(sysopdl=FALSE)
      FOR i:=0 TO tempList.count()-1
        item:=tempList.item(i)
        FOR x:=0 TO StrLen(item.fileName)-1
          IF((item.fileName[x]=":") OR (item.fileName[x]="/") OR
            (((item.fileName[x]="?") OR (item.fileName[x]="#") OR (item.fileName[x]="*")) AND (checkSecurity(ACS_FILE_EXPANSION)=FALSE)))
            aePuts('\b\nYou may not include any special symbols\b\n')
            JUMP arestart1
          ENDIF
        ENDFOR
        IF((item.fileName[0]="?") OR (item.fileName[0]="*"))
          aePuts('\b\nToo ambigious, start with at least one character.\b\n')
          JUMP arestart1
        ENDIF
      ENDFOR
    ELSE
      FOR i:=0 TO tempList.count()-1
        item:=tempList.item(i)
        FOR x:=0 TO StrLen(item.fileName)-1
          IF((item.fileName[x]="?") OR (item.fileName[x]="*") OR (item.fileName[x]="#"))
            aePuts('\b\nSysop download doesn''t support wildcards\b\n')
            JUMP arestart1
          ENDIF
        ENDFOR
      ENDFOR
    ENDIF
    status:=checklist(tempList,tfsizes,freeDFlags,finalList)
    IF(status=RESULT_FAILURE)
      Throw(ERR_EXCEPT,RESULT_SUCCESS)
    ENDIF
  ENDIF

arestart1:

  clearFlagItems(tempList)
  END tempList
  tempList:=NIL

arestart:

  LOOP
    status:=checkRatiosAndTime({min},{size},{cnt},string,estDlCPS,tfsizes,freeDFlags)
    IF status=0
      StrAdd(string,'\b\n\b\n')
      aePuts(string)
      Throw(ERR_EXCEPT,RESULT_SUCCESS)
    ENDIF
    IF status=1 THEN JUMP astart

    IF (quietDownload=FALSE)
      IF((loggedOnUser.secLibrary=0) OR (creditAccountEnabled(loggedOnUser)))
        StringF(tempStr,'\b\n\d mins, (Ratio Disabled), Filespec(\d): ',(Div(timeLimit,60))-min,(numFiles+1))
      ELSE
        downloadPrompt(loggedOnUser.secBoard,(Div(timeLimit,60))-min,size,(numFiles+1),cnt,tempStr)
      ENDIF
      aePuts(tempStr)
      
      status:=lineInput('','',200,INPUT_TIMEOUT,tempStr2)
      fullTrim(tempStr2,tempStr)
    ELSE
      StrCopy(tempStr,'')
    ENDIF

    IF(status<0)
      Throw(ERR_EXCEPT,RESULT_NO_CARRIER)
    ENDIF

    IF((StrLen(tempStr)=0) AND (numFiles=0))
      aePuts('\b\n')
      Throw(ERR_EXCEPT,RESULT_SUCCESS)
    ENDIF

    IF(StrLen(tempStr)=0) THEN JUMP astart
    IF((((tempStr[0]="q") OR (tempStr[0]="Q")) OR ((tempStr[0]="a") OR (tempStr[0]="A"))) AND (StrLen(tempStr)=1))
      aePuts('Aborting...\b\n\b\n')
      Throw(ERR_EXCEPT,RESULT_SUCCESS)
    ENDIF

    aePuts('\b\nChecking...\b\n')
    IF(sysopdl=FALSE)
      FOR x:=0 TO StrLen(tempStr)-1
        IF((tempStr[x]=":") OR (tempStr[x]="/") OR
          (((tempStr[x]="?") OR (tempStr[x]="#") OR (tempStr[x]="*")) AND (checkSecurity(ACS_FILE_EXPANSION)=FALSE)))
          aePuts('\b\nYou may not include any special symbols\b\n')
          JUMP arestart
        ENDIF
      ENDFOR
      IF((tempStr[0]="?") OR (tempStr[0]="*"))
        aePuts('\b\nToo ambigious, start with at least one character.\b\n')
        JUMP arestart
      ENDIF
    ELSE
      FOR x:=0 TO StrLen(tempStr)-1
        IF((tempStr[x]="?") OR (tempStr[x]="*") OR (tempStr[x]="#"))
          aePuts('\b\nSysop download doesn''t support wildcards\b\n')
          JUMP arestart
        ENDIF
      ENDFOR
    ENDIF

    status:=checkForFileSize(tempStr,'',currentConf,tfsizes,freeDFlags,finalList,0)
    IF((status=RESULT_FAILURE) OR (status=RESULT_SIGNALLED) OR (status=RESULT_PRIVATE))
      Throw(ERR_EXCEPT,RESULT_SUCCESS)
    ENDIF
  ENDLOOP

astart:

  END tfsizes
  tfsizes:=NIL
  END freeDFlags
  freeDFlags:=NIL

  IF(numFiles=0) THEN RETURN RESULT_NO_CARRIER

  IF(StriCmp(xprLib.item(loggedOnUser.xferProtocol),'INTERNAL'))
    aePuts('\b\nZmodem ')
  ELSEIF(StriCmp(xprLib.item(loggedOnUser.xferProtocol),'FTP'))
    aePuts('\b\nFTP ')
  ELSE
    StringF(tempStr,'\b\n\s',xprTitle.item(loggedOnUser.xferProtocol))
    aePuts(tempStr)
  ENDIF
  IF loggedOnUserMisc.lastDlCPS<>0
    StringF(tempStr,' Batch Download Estimate at \d cps:\b\n',estDlCPS)
  ELSE
    StringF(tempStr,' Batch Download Estimate at \d bps:\b\n',onlineBaud)
  ENDIF
  aePuts(tempStr)

  tsec:=divBCD(dtfsize,estDlCPS)
  min:=Div(tsec,60)
  secs:=tsec-(Mul(min,60))
  CopyMem(dtfsize,tmpBCD,8)
  divBCD1024(tmpBCD)
  StringF(tempStr,'   \d files, \dk bytes, \d mins \d secs\b\n',numFiles,convertFromBCD(tmpBCD),min,secs)
  aePuts(tempStr)

  IF(min>(Div(timeLimit,60))) AND (checkSecurity(ACS_OVERRIDE_TIMELIMIT)=FALSE)
    aePuts('  Insufficent time for transfer.\b\n\b\n')
    RETURN RESULT_SUCCESS
  ENDIF

  aePuts('\b\nLAST CHANCE!   (Enter) to Start, (G)oodbye after transfer, (A)bort? ')

  REPEAT
    mystat:=checkOnlineStatus()
    IF(mystat<0) THEN RETURN mystat
    mystat:=readChar(INPUT_TIMEOUT)

    IF(mystat<(-1)) THEN RETURN RESULT_NO_CARRIER

    IF((mystat=65) OR (mystat=97))
      aePuts('Abort!\b\n\b\n')
      RETURN RESULT_SUCCESS
    ENDIF
    IF (((status="l") OR (status="L")) AND (logonType<LOGON_TYPE_REMOTE))
      localUpload:=TRUE
      status:=13
      JUMP breakd
    ENDIF
  UNTIL (mystat=13) OR (mystat=71) OR (mystat=103)
breakd:

  IF (mystat<>13) THEN aePuts('Goodbye!\b\n\b\n') ELSE aePuts('\b\n\b\n')

  convertToBCD(0,dTBT)
  convertToBCD(0,uTBT)
  ulTTTM:=0
  dlTTTM:=0
  tTEFF:=0
  tTCPS:=0
  dlFileCount:=0
  ulFileCount:=0

  IF(beenUDd=FALSE)
    displayUserToCallersLog(1)
    beenUDd:=TRUE
  ENDIF

  status:=downloadFiles(finalList,dtfsize,TRUE)

  IF(status<>0) THEN clearFlagItems(flagFilesList)

  aePuts('\b\n\b\nFile transfer Completed.\b\n')
  peff:=NIL
  pcps:=NIL
  IF(dlFileCount<>0)
    ->peff:=Div(tTEFF,onlineNFiles)
    ->pcps:=Div(tTCPS,onlineNFiles)
    peff:=tTEFF
    pcps:=tTCPS 
    loggedOnUserMisc.lastDlCPS:=pcps
  ENDIF
  ->// (RTS) added dnload cps rate Fri Mar 27 13:13:29 1992
  CopyMem(dTBT,tmpBCD,8)
  divBCD1024(tmpBCD)
  formatBCD(tmpBCD,tempStr)
  dlTTTM:=Div(dlTTTM,50)
  StringF(string,' \d files, \sk bytes, \d minutes \d seconds \d cps, \d% efficiency at \d',dlFileCount,tempStr,Div(dlTTTM,60),Mod(dlTTTM,60),pcps,peff,onlineBaud)
  aePuts(string)
  aePuts('\b\n\b\n')

  /* is this baud higher then max cps down ? */
  IF(pcps > loggedOnUserKeys.dnCPS2)
    loggedOnUserKeys.dnCPS2:=pcps
    IF pcps>65535 THEN pcps:=65535
    loggedOnUserKeys.oldDnCPS:=pcps
  ENDIF

  clearFlagItems(finalList)
  END finalList

  StrCopy(tempStr,'\t')
  StrAdd(tempStr,string)

  IF(dlFileCount>0)
    callersLog(tempStr)
    udLog(tempStr)
  ELSE
    callersLog('\tDownload Failed..')
    udLog('\tDownload Failed..')
  ENDIF
 
  IF (ulFileCount>0)
    ->hydra uploads
    ObtainSemaphore(bgData)
    bgData.checkedCount:=0
    convertToBCD(0,bgData.checkedBytes)
    ReleaseSemaphore(bgData)

    IF ulTTTM
      CopyMem(uTBT,tmpBCD,8)
      mulBCD(tmpBCD,50)
      tTCPS:=divBCD(tmpBCD,ulTTTM)
    ELSE
      tTCPS:=convertFromBCD(uTBT)
    ENDIF
    tTEFF:=calcEfficiency(tTCPS,onlineBaud)    

    receivePlayPen(TRUE)
    uploadaFile(0,'',FALSE,TRUE)
  ENDIF

  displayULStats(loggedOnUser,loggedOnUserMisc)          /* Show User stats.. Num Dnloads, uploads */
  aePuts('\b\n')
  
  purgeLine()

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  IF((mystat=71) OR (mystat=103)) THEN RETURN(pGoodbye())
EXCEPT
  IF tempList
    clearFlagItems(tempList)
    END tempList
  ENDIF
  IF tfsizes
    END tfsizes
  ENDIF
  IF freeDFlags
    END freeDFlags
  ENDIF
  IF finalList
    clearFlagItems(finalList)
    END finalList
  ENDIF
  RETURN exceptioninfo
ENDPROC RESULT_SUCCESS

PROC ccom()
  DEF i,i2,stat
  DEF str[81]:STRING
  DEF display_time[30]:STRING
  DEF buff[255]: STRING

  formatLongDateTime(getSystemTime(),display_time)

  StringF(str,'\tOperator Paged at (\s)',display_time)
  callersLog(str)

  conPuts('\b\nF1 Toggles chat\b\n',-1)

  IF (runSysCommand('PAGER','')<>RESULT_SUCCESS)
    /* show our page sign to user */
    StringF(buff,'\s\b\n\b\nPaging \s (CTRL-C to Abort). .',display_time,cmds.sysopName)
    aePuts(buff)
    FOR i:=0 TO 19
      DisplayBeep(NIL)
      aePuts(' .')
      FOR i2:=1 TO 50
        Delay(1)
        IF(logonType>=LOGON_TYPE_REMOTE)
          stat:=checkCarrier()
          IF(stat=FALSE) THEN RETURN RESULT_NO_CARRIER
        ENDIF
        IF(checkInput())
          stat:=readChar(1)
          IF(chatF=1)
            aePuts('\b\n\b\n')
            RETURN RESULT_SUCCESS
          ENDIF
          IF(stat=3)
              aePuts('Aborted!\b\n\b\n')
            RETURN RESULT_SUCCESS
          ENDIF
        ENDIF
      ENDFOR
    ENDFOR
  ENDIF

  aePuts('\b\n\b\nThe Sysop has been paged\b\n')
  aePuts('You may continue using the system\b\n')
  aePuts('until ')
  aePuts(cmds.sysopName)
  aePuts(' answers your request.\b\n\b\n')
  statMessage(1,1,'                            ')
  StringF(str,'[37m\s[0m',loggedOnUser.name)
  statMessage(1,1,str)

ENDPROC RESULT_SUCCESS

PROC viewAFile(cmdcode,params)
  DEF stat,x
  DEF path[255]:STRING, final[255]:STRING, fn[100]:STRING, clog[100]:STRING
  DEF f,ft=NIL
  DEF drivenum=1
  DEF tempStr[999]:STRING

  nonStopDisplayFlag:=FALSE
  lineCount:=0

  aePuts('\b\n')
  IF(maxDirs=0)
    aePuts('No files available in this conference.\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  parseParams(params)

  nonStopDisplayFlag:=paramsContains('NS')

  IF parsedParams.count()>0
    StrCopy(fn,parsedParams.item(0))
    JUMP some
  ENDIF

  aePuts('Enter filename of file to view? ')
  stat:=lineInput('','',40,INPUT_TIMEOUT,fn)
  IF(stat<0) THEN RETURN RESULT_NO_CARRIER

  IF(StrLen(fn)=0)
    aePuts('\b\n')
    RETURN RESULT_SUCCESS
  ENDIF


some:
  StrCopy(path,currentConfDir)
  IF(path[StrLen(path)-1]="/") THEN SetStr(path,StrLen(path)-1)
  JUMP skipMe

skipToIt:
  StringF(tempStr,'File \s not found.\b\n\b\n',path)
  aePuts(tempStr)
  RETURN RESULT_FAILURE

skipMe:

  IF((checkSecurity(ACS_SYSOP_VIEW)) AND (StriCmp(cmdcode,'VS')))
    IF(findAssign(fn))
      StrCopy(path,fn)
      JUMP skipToIt
    ENDIF

    f:=Open(fn,MODE_OLDFILE)
    IF(f=0)
      StrCopy(path,fn)
      JUMP skipToIt
    ENDIF
    Close(f)
    StringF(tempStr,'\tSysopView \s',fn)
    callersLog(tempStr)
    StrCopy(final,fn)
    JUMP skipit
  ENDIF

  FOR x:=0 TO StrLen(fn)-1
    IF((fn[x]=":") OR (fn[x]="/") OR (fn[x]="*") OR (fn[x]="@"))
      aePuts('You may not include any special symbols\b\n\b\n')
      RETURN RESULT_FAILURE
    ENDIF
  ENDFOR


  StringF(path,'DLPATH.\d',drivenum++)
  WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,path))
    checkPathSlash(path)
    StrCopy(final,path)
    StrAdd(final,fn)
skipit:
    ft:=Open(final,MODE_OLDFILE)
    IF(ft<>0)
      IF restricted(final)
        aePuts('\b\nAttempt to read RESTRICTED file denied\b\n')
        aePuts('Updating Callerslog\b\n')
        StringF(clog,'\t\tAttempt to read RESTRICTED file [\s]',fn)
        callersLog(clog)
        Close(ft)
        RETURN RESULT_FAILURE
      ENDIF
      WHILE ((ReadStr(ft,tempStr))<>-1) OR (StrLen(tempStr)>0)
        IF((tempStr[0]>128) OR (tempStr[1]>128) OR (tempStr[2]>128))
          Close(ft)
          aePuts('\b\nThis file is not a text file.\b\n\b\n')
          RETURN RESULT_FAILURE
        ENDIF
        IF (InStr(tempStr,'')>=0) OR (StrLen(tempStr)<80)
          aePuts(tempStr)
        ELSE
          WHILE StrLen(tempStr)>0
            IF StrLen(tempStr)>79
              aePuts2(tempStr,79)
              StrCopy(tempStr,tempStr+79)
            ELSE
              aePuts(tempStr)
              StrCopy(tempStr,'')
            ENDIF
            IF StrLen(tempStr)>0
              aePuts('\b\n')
              IF(stat:=checkForPause())
                Close(ft)
                aePuts('\b\n')
                RETURN stat
              ENDIF
            ENDIF
          ENDWHILE
        ENDIF
        aePuts('\b\n')
        IF(stat:=checkForPause())
          Close(ft)
          aePuts('\b\n')
          RETURN stat
        ENDIF
        IF(checkInput())
          stat:=readChar(1)
          SELECT stat
            CASE 23 /* Pause */
              stat:=readChar(INPUT_TIMEOUT)
              IF(stat<0)
                Close(ft)
                RETURN RESULT_NO_CARRIER
              ENDIF
            CASE 3 /* ^C */
              aePuts('**Break\b\n\b\n')
              Close(ft)
              RETURN RESULT_FAILURE
          ENDSELECT
        ENDIF
      ENDWHILE
      Close(ft)
      aePuts('\b\n\b\n')
      RETURN RESULT_SUCCESS
    ENDIF
    EXIT ft<>NIL
    StringF(path,'DLPATH.\d',drivenum++)
  ENDWHILE
  aePuts('File not found.\b\n\b\n')
ENDPROC RESULT_SUCCESS

PROC showVoteTopics()
  DEF topicNum
  DEF tempstr[255]:STRING
  DEF votefile[255]:STRING
  DEF voted=FALSE
  DEF i,confbit,confbyte
  DEF cb: PTR TO confBase

  FOR topicNum:=1 TO 25
    StringF(votefile,'\sVote/Vote\r\z\d[2].def',currentConfDir,topicNum)
    IF fileExists(votefile)
      confbyte:=Shr(topicNum+3,3)
      confbit:=Shl(1,Mod(topicNum+3,8))
      cb:=confBases.item(getConfIndex(currentConf,1))
      voted:=(cb.handle[confbyte] AND confbit)<>0

      loadMsg(votefile)
      FOR i:=0 TO lines-1
        IF i=0
          StringF(tempstr,'[34m[[0m\r\d[2][34m] [32m\s [35m\s\b\n',topicNum,msgBuf.item(i),IF voted THEN 'VOTED' ELSE '     ')
        ELSE
          StringF(tempstr,'           [35m\s\b\n',msgBuf.item(i))
        ENDIF
        aePuts(tempstr)
      ENDFOR
    ENDIF
  ENDFOR
  doPause()
ENDPROC

PROC createVoteTopic()
  DEF topicNum,lock
  DEF votefile[255]:STRING
  DEF tempStr[255]:STRING
  DEF ans,questNum,fh

  StringF(votefile,'\sVote',currentConfDir)
  IF(lock:=CreateDir(votefile))
    UnLock(lock)
  ENDIF

  StringF(votefile,'\sVote/VoteLock',currentConfDir)
  IF fileExists(votefile)=FALSE
    IF((fh:=Open(votefile,MODE_NEWFILE)))=0 THEN RETURN RESULT_FAILURE
    fileWriteLn(fh,'DO NOT DELETE!')
    Close(fh)
  ENDIF

  aePuts('\b\n[34mENTER TOPIC NUMBER [33m([0m1-25[33m)[34m>:[0m ')
  topicNum:=numberInputNoDefault()
  IF (topicNum<1) OR (topicNum>25)
    RETURN
  ENDIF

  StringF(votefile,'\sVote/Vote\r\z\d[2].def',currentConfDir,topicNum)
  IF fileExists(votefile)
    aePuts('\b\n[0mTOPIC ALREADY EXISTS\b\n')
    RETURN
  ENDIF

  aePuts('\b\n[33mENTER TOPIC DESCRIPTION [0m\b\n')
  msgBuf.clear()
  lines:=0
  IF edit(FALSE,50)<>RESULT_SUCCESS THEN RETURN RESULT_SUCCESS
  IF lines=0 THEN RETURN RESULT_SUCCESS

  saveMsg(votefile)
  questNum:=1
  REPEAT
    StringF(tempStr,'\b\n[33mENTER QUESTION \d[0m\b\n',questNum)
    aePuts(tempStr)
    msgBuf.clear()
    lines:=0

    IF edit(FALSE,50)<>RESULT_SUCCESS THEN lines:=0

    IF lines<>0
      StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].qst',currentConfDir,topicNum,questNum)
      saveMsg(votefile)
      ans:="A"
      REPEAT
        StringF(tempStr,'\b\nANSWER [33m\c[0m ]\b\n',ans)
        aePuts(tempStr)
        msgBuf.clear()
        lines:=0
        IF edit(FALSE,50)<>RESULT_SUCCESS THEN lines:=0

        IF (lines<>0)
          StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].\c',currentConfDir,topicNum,questNum,ans)
          saveMsg(votefile)
          ans++
        ELSE
          ans:=0
        ENDIF
      UNTIL (ans>="Z") OR (ans=0)
      questNum++
    ELSE
      questNum:=-1
    ENDIF
  UNTIL (questNum<0) OR (questNum>99)
ENDPROC

PROC deleteVoteTopic()
  DEF topicNum
  DEF votefile[255]:STRING
  DEF i,ans

  aePuts('\b\n[34mENTER TOPIC NUMBER TO DELETE [33m>:[0m ' )
  topicNum:=numberInputNoDefault()
  IF (topicNum<1) OR (topicNum>25)
    RETURN
  ENDIF
  StringF(votefile,'\sVote/Vote\r\z\d[2].def',currentConfDir,topicNum)

  IF fileExists(votefile)=FALSE
    aePuts('\b\n[0mTHIS TOPIC DOES NOT EXIST\b\n')
    doPause()
    RETURN
  ENDIF

  DeleteFile(votefile)

  i:=1
  REPEAT
    StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].qst',currentConfDir,topicNum,i)
    IF fileExists(votefile)
      DeleteFile(votefile)
      StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].cnt',currentConfDir,topicNum,i)
      DeleteFile(votefile)
      ans:="A"
      REPEAT
        StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].\c',currentConfDir,topicNum,i,ans)
        IF fileExists(votefile)
          DeleteFile(votefile)
          StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].\c.cnt',currentConfDir,topicNum,i,ans)
          DeleteFile(votefile)
        ELSE
          ans:="Z"
        ENDIF
        ans++
      UNTIL ans>"Z"
    ELSE
      i:=99
    ENDIF
    i++
  UNTIL i>99

  aePuts('\b\n[33mTOPIC DELETED[0m\b\n')
  doPause()
ENDPROC

PROC editVoteTopic()
  DEF topicNum,questNum,ans
  DEF votefile[255]:STRING
  DEF n

  aePuts('\b\n[34mENTER TOPIC NUMBER [33m([0m1-25[33m)[34m>:[0m ')
  topicNum:=numberInputNoDefault()
  IF (topicNum<1) OR (topicNum>25)
    RETURN
  ENDIF
  StringF(votefile,'\sVote/Vote\r\z\d[2].def',currentConfDir,topicNum)
  IF fileExists(votefile)=FALSE
    aePuts('[0mTHIS TOPIC DOES NOT EXIST\b\n')
    RETURN
  ENDIF

  aePuts('\b\n')
  REPEAT
    aePuts('[0m   ENTER OPTION\b\n')
    aePuts('[0m1. EDIT DESCRIPTION\b\n')
    aePuts('[0m2. EDIT QUESTION\b\n')
    aePuts('[0m3. EDIT ANSWER\b\n')
    aePuts('[0m4. EXIT\b\n')
    aePuts('[0m>')
    n:=readChar(INPUT_TIMEOUT)
    IF n<0 THEN RETURN
    sendChar(n)
    aePuts('\b\n')
    SELECT n
      CASE "1"
        aePuts('\b\n[33mEDIT TOPIC DESCRIPTION [0m')
        StringF(votefile,'\sVote/Vote\r\z\d[2].def',currentConfDir,topicNum)
        loadMsg(votefile)
        IF edit(FALSE,50)=RESULT_SUCCESS
          IF lines>0
            saveMsg(votefile)
          ENDIF
        ENDIF
        n:="4"
      CASE "2"
        aePuts('\b\n[34mEDIT QUESTION NUMBER[0m > ')
        questNum:=numberInputNoDefault()
        IF (questNum>0) AND (questNum<100)
          StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].qst',currentConfDir,topicNum,questNum)
          IF fileExists(votefile)
            loadMsg(votefile)
            IF edit(FALSE,50)=RESULT_SUCCESS
              IF lines>0
                saveMsg(votefile)
              ENDIF
            ENDIF
          ELSE
            aePuts('\b\nQUESTION DOES NOT EXIST\b\n')
            doPause()
          ENDIF
        ENDIF
        n:="4"

      CASE "3"
        aePuts('\b\n[34mEDIT QUESTION NUMBER[0m > ')
        questNum:=numberInputNoDefault()
        IF (questNum>0) AND (questNum<100)
          StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].qst',currentConfDir,topicNum,questNum)
          IF fileExists(votefile)
            aePuts('\b\n[34mEDIT CHOICE [33m[[0mA-Z[33m][0m > ')
            ans:=readChar(INPUT_TIMEOUT)
            IF ans<0 THEN RETURN
            ans:=UpperChar(ans)
            sendChar(ans)
            aePuts('\b\n')
            IF (ans>="A") AND (ans<="Z")
              StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].\c',currentConfDir,topicNum,questNum,ans)
              IF fileExists(votefile)
                loadMsg(votefile)
                IF edit(FALSE,50)=RESULT_SUCCESS
                  IF lines>0
                    saveMsg(votefile)
                  ENDIF
                ENDIF
              ELSE
                aePuts('\b\nCHOICE DOES NOT EXIST\b\n')
                doPause()
              ENDIF
            ENDIF
          ELSE
            aePuts('\b\nQUESTION DOES NOT EXIST\b\n')
            doPause()
          ENDIF
        ENDIF
        n:="4"
    ENDSELECT
  UNTIL n="4"

ENDPROC

PROC vote()
  DEF votefile[255]:STRING
  DEF topicNum
  DEF found=0
  DEF i,confbyte,confbit
  DEF tempstr[255]:STRING
  DEF cb: PTR TO confBase
  DEF voted,stat

  REPEAT
    aePuts('\b\n\b\n                  [34m*[0m--[33mVOTING TOPICS MENU[0m--[34m*[0m\b\n\b\n')

    FOR topicNum:=1 TO 25
      StringF(votefile,'\sVote/Vote\r\z\d[2].def',currentConfDir,topicNum)
      IF fileExists(votefile)
        confbyte:=Shr(topicNum+3,3)
        confbit:=Shl(1,Mod(topicNum+3,8))
        cb:=confBases.item(getConfIndex(currentConf,1))
        voted:=(cb.handle[confbyte] AND confbit)<>0
        loadMsg(votefile)
        FOR i:=0 TO lines-1
          IF i=0
            StringF(tempstr,'[34m[[0m\r\d[2][34m] [32m\s [35m\s\b\n',topicNum,msgBuf.item(i),IF voted THEN 'VOTED' ELSE '     ')
          ELSE
            StringF(tempstr,'           [35m\s\b\n',msgBuf.item(i))
          ENDIF
          aePuts(tempstr)
        ENDFOR
        found++
      ENDIF
    ENDFOR

    IF found=0
      aePuts('[0mVOTING IS NOT ESTABLISHED FOR THIS CONFERENCE\b\n\b\n')
      doPause()
      RETURN
    ENDIF

    aePuts('[34m[[0m Q[34m] [33mQUIT[0m\b\n')
    aePuts('>: ')

    stat:=lineInput('','',2,INPUT_TIMEOUT,tempstr)
    IF stat<>RESULT_SUCCESS THEN RETURN
    topicNum:=Val(tempstr)
    IF (topicNum>0) AND (topicNum<26)
      confbyte:=Shr(topicNum+3,3)
      confbit:=Shl(1,Mod(topicNum+3,8))
      cb:=confBases.item(getConfIndex(currentConf,1))
      voted:=(cb.handle[confbyte] AND confbit)<>0
      IF voted
        showTopicVotes(topicNum)
      ELSE
        topicVote(topicNum)
      ENDIF
    ENDIF
  UNTIL StriCmp(tempstr,'Q')
ENDPROC

PROC showTopicVotes(topicNum)
  DEF questNum,i,stat
  DEF votefile[255]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[10]:STRING
  DEF tempstr3[10]:STRING
  DEF ans
  DEF cnt1,cnt2

  StringF(tempstr,'\b\n[33mTOPIC [34m[[0m\d[34m][0m\b\n',topicNum)
  aePuts(tempstr)

  questNum:=1
  StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].qst',currentConfDir,topicNum,questNum)
  WHILE fileExists(votefile)
    aePuts('\b\n')
    loadMsg(votefile)
    FOR i:=0 TO lines-1
      StringF(tempstr,'\s\b\n',msgBuf.item(i))
      aePuts(tempstr)
    ENDFOR
    aePuts('\b\n')
    StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].cnt',currentConfDir,topicNum,questNum)
    cnt1:=readFloatFromFile(votefile)
    RealF(tempstr2,cnt1,0)

    StringF(tempstr,'[35mTOTAL VOTES FOR THIS QUESTION [0m= [33m\s\b\n',tempstr2)
    aePuts(tempstr)
    ans:="A"
    StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].\c',currentConfDir,topicNum,questNum,ans)
    WHILE fileExists(votefile)
      loadMsg(votefile)

      StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].\c.cnt',currentConfDir,topicNum,questNum,ans)
      cnt2:=readFloatFromFile(votefile)

      FOR i:=0 TO lines-1
        IF i=0
          IF !cnt1>0.0
            RealF(tempstr2,cnt2,0)
            RealF(tempstr3,!cnt2/cnt1*100.0,1)
            StringF(tempstr,'[34m[[0m\c[34m][0m \l\s[40] [35mVOTES[33m: [0m\s, \s%\b\n',ans,msgBuf.item(i),tempstr2,tempstr3)
          ELSE
            StringF(tempstr,'[34m[[0m\c[34m][0m \l\s[40]\b\n',ans,msgBuf.item(i))
          ENDIF
        ELSE
          StringF(tempstr,'    \s\b\n',msgBuf.item(i))
        ENDIF
        aePuts(tempstr)
      ENDFOR
      ans++
      StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].\c',currentConfDir,topicNum,questNum,ans)
    ENDWHILE

    stat:=doPause()
    IF stat<>RESULT_SUCCESS THEN RETURN

    questNum++
    StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].qst',currentConfDir,topicNum,questNum)
  ENDWHILE

ENDPROC

PROC topicVote(topicNum)
  DEF questNum,i,stat
  DEF userfile[255]:STRING
  DEF votefile[255]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[10]:STRING
  DEF ans,ch
  DEF cnt1,cnt2
  DEF fh,lock
  DEF confbyte,confbit
  DEF cb:PTR TO confBase

  StringF(userfile,'\sVote/uservote\d',currentConfDir,node)
  IF((fh:=Open(userfile,MODE_NEWFILE)))=0
    StringF(tempstr,'\b\nTell \s an error occured creating the uservote file\b\n',cmds.sysopName)
    aePuts(tempstr)
    RETURN
  ENDIF

  StringF(tempstr,'\b\n[33mTOPIC [34m[[0m\d[34m][0m\b\n',topicNum)
  aePuts(tempstr)

  questNum:=1
  StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].qst',currentConfDir,topicNum,questNum)
  WHILE fileExists(votefile)
    aePuts('\b\n')
    loadMsg(votefile)
    FOR i:=0 TO lines-1
      StringF(tempstr,'\s\b\n',msgBuf.item(i))
      aePuts(tempstr)
    ENDFOR
    aePuts('\b\n')
    StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].cnt',currentConfDir,topicNum,questNum)
    cnt1:=readFloatFromFile(votefile)
    RealF(tempstr2,cnt1,0)

    StringF(tempstr,'[35mTOTAL VOTES FOR THIS QUESTION [0m= [33m\s\b\n',tempstr2)
    aePuts(tempstr)
    ans:="A"
    StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].\c',currentConfDir,topicNum,questNum,ans)
    WHILE fileExists(votefile)
      loadMsg(votefile)

      FOR i:=0 TO lines-1
        IF i=0
          StringF(tempstr,'[34m[[0m\c[34m][0m \l\s[40]\b\n',ans,msgBuf.item(i))
        ELSE
          StringF(tempstr,'    \s\b\n',msgBuf.item(i))
        ENDIF
        aePuts(tempstr)
      ENDFOR
      ans++
      StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].\c',currentConfDir,topicNum,questNum,ans)
    ENDWHILE

    aePuts('\b\n[0mCHOICE >: ')

    ch:=readChar(INPUT_TIMEOUT)
    IF ch<0
      Close(fh)
      RETURN
    ENDIF
    ch:=UpperChar(ch)
    sendChar(ch)
    aePuts('\b\n')

    IF (ch>="A") AND (ch<="Z")
      ans:=ch
      StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].\c',currentConfDir,topicNum,questNum,ans)
      IF fileExists(votefile)
        StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].cnt',currentConfDir,topicNum,questNum)
        fileWriteLn(fh,votefile)
        StringF(votefile,'\sVote/Vote\r\z\d[2].\z\d[2].\c.cnt',currentConfDir,topicNum,questNum,ans)
        fileWriteLn(fh,votefile)
      ENDIF
    ENDIF

    stat:=doPause()
    IF stat<>RESULT_SUCCESS
      Close(fh)
      RETURN
    ENDIF

    questNum++
    StringF(votefile,'\sVote/Vote\r\z\d[2].\r\z\d[2].qst',currentConfDir,topicNum,questNum)
  ENDWHILE

  Close(fh)
  StringF(votefile,'\sVote/VoteLock',currentConfDir)

  i:=0
  REPEAT
    lock:=Lock(votefile,ACCESS_WRITE)
    IF lock=NIL
      Delay(60)
    ENDIF
    i++
  UNTIL (lock<>NIL) OR (i=10)

  IF(lock)
    IF((fh:=Open(userfile,MODE_OLDFILE)))<>0
      WHILE(ReadStr(fh,votefile)<>-1) OR (StrLen(votefile)>0)
        cnt2:=!readFloatFromFile(votefile)+1.0
        writeFloatToFile(votefile,cnt2)
      ENDWHILE
      Close(fh)
    ENDIF
    UnLock(lock)

    ->flag voting as complete
    cb:=confBases.item(getConfIndex(currentConf,1))
    confbyte:=Shr(topicNum+3,3)
    confbit:=Shl(1,Mod(topicNum+3,8))
    cb.handle[confbyte]:=cb.handle[confbyte] OR confbit
  ELSE
    StringF(tempstr,'\tError \d trying to Lock Voting Booth',IoErr())
    callersLog(tempstr)
  ENDIF

ENDPROC

PROC showVoteStats()
  DEF topicNum
  DEF votefile[255]:STRING

  FOR topicNum:=1 TO 25
    StringF(votefile,'\sVote/Vote\r\z\d[2].def',currentConfDir,topicNum)
    IF fileExists(votefile)
      showTopicVotes(topicNum)
    ENDIF
  ENDFOR
ENDPROC

PROC voteMenu()
  DEF ch
  REPEAT
    sendCLS()
    aePuts('\b\n                 [34m*[0m--[33mVOTE MAINTENANCE[0m--[34m*[0m\b\n\b\n')
    aePuts('[34m[[0m 1[34m] [35mSHOW VOTING STATISTICS[0m\b\n')
    aePuts('[34m[[0m 2[34m] [35mSHOW TOPICS[0m\b\n')
    aePuts('[34m[[0m 3[34m] [35mCREATE VOTE TOPIC[0m\b\n'  )
    aePuts('[34m[[0m 4[34m] [35mDELETE VOTE TOPIC[0m\b\n')
    aePuts('[34m[[0m 5[34m] [35mEDIT   VOTE TOPIC[0m\b\n')
    aePuts('[34m[[0m 6[34m] [35mVOTE[0m\b\n')
    aePuts('[34m[[0m 7[34m] [33mEXIT VOTE MAINTENANCE[0m\b\n')
    aePuts('\b\n>')

    ch:=readChar(INPUT_TIMEOUT)
    IF ch<0 THEN RETURN
    sendChar(ch)
    aePuts('\b\n')

    SELECT ch
      CASE "1"
        showVoteStats()
      CASE "2"
        showVoteTopics()
      CASE "3"
        createVoteTopic()
      CASE "4"
        deleteVoteTopic()
      CASE "5"
        editVoteTopic()
      CASE "6"
        vote()
        ch:=0
    ENDSELECT

  UNTIL (ch<"1") OR (ch="7")

ENDPROC

PROC findLastAccount()
  DEF fh,size

  IF((fh:=Open(userDataFile,MODE_OLDFILE)))=0 THEN RETURN RESULT_FAILURE

  Seek(fh,0,OFFSET_END)
  size:=Seek(fh,0,OFFSET_CURRENT)
  Close(fh)
ENDPROC Div(size,SIZEOF user)

PROC numberInputNoDefault()
  DEF tempStr[20]:STRING
  lineInput('','',5,INPUT_TIMEOUT,tempStr)
ENDPROC Val(tempStr) AND $FFFF

PROC numberInput(n)
  DEF tempStr[20]:STRING
  StringF(tempStr,'\d',n AND 65535)
  lineInput('',tempStr,5,INPUT_TIMEOUT,tempStr)
ENDPROC Val(tempStr) AND $FFFF

PROC rJoinInput(conf,msgbase)
  DEF tempStr[20]:STRING
  DEF p
  lineInput('','',5,INPUT_TIMEOUT,tempStr)
  conf:=Val(tempStr)
  IF (p:=InStr(tempStr,'.'))>=0
    msgbase:=Val(tempStr+p+1)
  ELSE
    msgbase:=0
  ENDIF
ENDPROC conf,msgbase

PROC longNumberInput(n)
  DEF tempStr[20]:STRING
  formatUnsignedLong(n,tempStr)
  lineInput('',tempStr,10,INPUT_TIMEOUT,tempStr)
ENDPROC Val(tempStr)

PROC uucpNumberInput(n)
  DEF tempStr[4]:STRING
  StringF(tempStr,'\d',n)
  lineInput('',tempStr,1,INPUT_TIMEOUT,tempStr)
ENDPROC Val(tempStr)

PROC bcdNumberInput(bcdArray:PTR TO CHAR)
  DEF tempStr[20]:STRING

  formatBCD(bcdArray,tempStr)
  lineInput('',tempStr,14,INPUT_TIMEOUT,tempStr)
ENDPROC bcdVal(tempStr,bcdArray)

PROC bcdVal(inStr:PTR TO CHAR, bcdArray:PTR TO CHAR)
  DEF valid=TRUE
  DEF n,bit,i2,i

  i2:=7
  bit:=FALSE
  i:=StrLen(inStr)-1
  WHILE(i2>=0)
    IF i>=0 THEN n:=inStr[i]-"0" ELSE n:=0
    IF (n<0) OR (n>9) THEN valid:=FALSE
    EXIT valid=FALSE

    IF (bit)
      bcdArray[i2]:=bcdArray[i2] OR Shl(n,4)
      i2--
    ELSE
      bcdArray[i2]:=n
    ENDIF
    bit:=Not(bit)
    i--
  ENDWHILE

  IF valid=FALSE
    FOR i:=0 TO 7
      bcdArray[i]:=0
    ENDFOR
  ENDIF
ENDPROC valid

PROC checkLockAccounts(f6)
  DEF tempstr[255]:STRING
  DEF fh,res=FALSE

  IF f6 OR (logonType<LOGON_TYPE_REMOTE) THEN RETURN TRUE

  StringF(tempstr,'\sLockAccounts',cmds.bbsLoc)
  IF fileExists(tempstr)
    fh:=Open(tempstr,MODE_OLDFILE)
    IF fh<>0
      WHILE((ReadStr(fh,tempstr)<>-1) OR (StrLen(tempstr)>0)) AND (res=FALSE)
        IF StriCmp(tempstr,loggedOnUser.name) THEN res:=TRUE
      ENDWHILE
      Close(fh)
    ENDIF
    RETURN res
  ELSE
    RETURN TRUE
  ENDIF
ENDPROC

PROC findUserAnswers(which,answersFilename:PTR TO CHAR)
  DEF i,lock
  DEF tempStr[255]:STRING
  
  StrCopy(answersFilename,'')
  i:=0
  REPEAT
    StringF(tempStr,'\sNode\d',cmds.bbsLoc,i)
    lock:=Lock(tempStr,ACCESS_READ)
    IF lock<>0 THEN UnLock(lock)

    IF lock
      IF checkToolTypeExists(TOOLTYPE_NODE,i,'CENTRAL_ANSWERS')
        StringF(answersFilename,'\sAnswers/\d',cmds.bbsLoc,which)
      ELSE
        StringF(answersFilename,'\sNode\d/Answers/\d',cmds.bbsLoc,i,which)
      ENDIF
    ENDIF
    i++
  UNTIL (lock=0) OR fileExists(answersFilename) OR (i>MAXNODES)
  IF (i>MAXNODES) OR (lock=0) THEN StrCopy(answersFilename,'')
ENDPROC StrLen(answersFilename)>0

PROC checkChanges(changes)
  DEF ch
  IF changes=FALSE THEN RETURN TRUE
  aePuts('You have unsaved changes. Do you wish to lose them (Y/N)? ')
  ch:=readChar(INPUT_TIMEOUT)
  IF(ch<0) THEN RETURN TRUE
  aePuts('[F[E[K')
  
  IF((ch="Y") OR (ch="y")) THEN RETURN TRUE
ENDPROC FALSE

PROC editInfo(which:LONG, hoozer:PTR TO user, hoozer2:PTR TO userKeys, hoozer3: PTR TO userMisc,f6)

  DEF flag, command
  DEF tempStr[255]:STRING
  DEF temp,stat,i,preset
  DEF checkLock
  DEF page=0
  DEF value1,value2
  DEF changes=FALSE

  nofkeys:=1
  displayAccount(which,page,hoozer,hoozer2,hoozer3,f6)
  StrCopy(tempStr,hoozer.name)
  UpperStr(tempStr)
  AstrCopy(hoozer2.userName,tempStr,31)

  checkLock:=checkLockAccounts(f6)
  REPEAT
    flag:=0
    command:=readChar(INPUT_TIMEOUT)
    IF(command<0) THEN RETURN command
    command:=UpperChar(command)

    flag:=0

->b) internet name
->c) email address
->d) lines per screen
->e) computer type
->f) screen type
->g) screen clear
->h) transfer protocol
->i) zoom type
->j) available for chat
->k) translator
->l) expert mode
->m) bg file check

    SELECT command
      CASE "\t"
        IF f6 ORELSE checkChanges(changes)
          flag:=2
        ENDIF
      CASE "X"         /* NO-SAVE */
        IF f6 ORELSE checkChanges(changes)
          aePuts('[JNo-Save\b\n')
          flag:=1
        ENDIF
      CASE " "
        page:=Eor(page,1)
        sendCLS()
        displayAccount(which,page,hoozer,hoozer2,hoozer3,f6)
      CASE "+"
        IF(onlineEdit=FALSE)
          IF checkChanges(changes)
            which:=which+1
            changes:=FALSE
            IF(loadAccount(which,hoozer,hoozer2,hoozer3)<>RESULT_FAILURE)
              displayAccountInfo(which,page,hoozer,hoozer2,hoozer3,f6)
            ELSE
              which:=1
              loadAccount(which,hoozer,hoozer2,hoozer3)
              displayAccountInfo(which,page,hoozer,hoozer2,hoozer3,f6)
            ENDIF
          ENDIF
        ENDIF
      CASE "-"
        IF(onlineEdit=FALSE)
          IF checkChanges(changes)
            which:=which-1
            changes:=FALSE
            IF(which<1) THEN which:=findLastAccount()
            loadAccount(which,hoozer,hoozer2,hoozer3)
            displayAccountInfo(which,page,hoozer,hoozer2,hoozer3,f6)
          ENDIF
        ENDIF
      CASE "~" /* SAVE */
        aePuts('[JSave\b\n')
        hoozer.newUser:=0
        displayAccountInfo(which,page,hoozer,hoozer2,hoozer3,f6)
        IF(hoozer.slotNumber=0)
          hoozer2.number:=0
          stat:=saveAccount(hoozer,hoozer2,hoozer3,which,1) /* 1 = FORCE SAVE */

          IF(stat<>RESULT_SUCCESS) THEN aePuts('Can''t Save account\b\n')
        ELSE
          hoozer2.number:=hoozer.slotNumber
                  /* save using Slot_number */
          stat:=saveAccount(hoozer,hoozer2,hoozer3,0,0) /* Not forced */
          IF(stat<>RESULT_SUCCESS) THEN aePuts('Can''t Save account\b\n')
        ENDIF

        IF logonType>=LOGON_TYPE_REMOTE
          StringF(tempStr,'\tREMOTE Account Maintenance on Account \d',hoozer.slotNumber)
        ELSE
          StringF(tempStr,'\tLOCAL  Account Maintenance on Account \d',hoozer.slotNumber)
        ENDIF
        callersLog(tempStr)
        changes:=FALSE
      CASE "!" /* Credit Maintenance */
        creditMaintenance(which,hoozer,hoozer2,hoozer3,f6)
        displayAccount(which,page,hoozer,hoozer2,hoozer3,f6)
      CASE "*" /* User Notes */
        userNotes(which,hoozer,hoozer2,hoozer3,f6)
        displayAccount(which,page,hoozer,hoozer2,hoozer3,f6)
      CASE "@" /* Conference Accounting */
        conferenceAccounting(hoozer,hoozer2,hoozer3,f6)
        displayAccount(which,page,hoozer,hoozer2,hoozer3,f6)
      CASE "?"
        findUserAnswers(which,tempStr)       
        IF StrLen(tempStr)>0
          sendCLS()
          displayFile(tempStr,TRUE,FALSE)
          doPause()
          displayAccount(which,page,hoozer,hoozer2,hoozer3,f6)
        ENDIF
    ENDSELECT

    IF checkLock
      IF (command>="1") AND (command<="8")
        StringF(tempStr,'\c ',command)
        preset:=Val(tempStr)
        IF readToolType(TOOLTYPE_PRESET,preset,'PRESET.AREA',tempStr)
          AstrCopy(hoozer.conferenceAccess,tempStr,10)

          StringF(tempStr,'[JPreset \d. ',preset)
          aePuts(tempStr)
          changes:=TRUE

          hoozer.newUser:=0
          applyPreset(hoozer,TOOLTYPE_PRESET,preset)
          
          hoozer.timeUsed:=0
          hoozer.timeTotal:=hoozer.timeLimit
          hoozer2.oldUpCPS:=0
          hoozer2.upCPS2:=0
          hoozer2.oldDnCPS:=0
          hoozer2.dnCPS2:=0
          aePuts('Preset All Conferences with Ratios & RatioType ')
          stat:=yesNo(1)
          IF stat THEN applyConfPresets(hoozer,preset)
          aePuts('[18;1H                                                                    ')

          ->//(RTS)             hoozer2->baud_rate = 0

          ->saveAccount(hoozer,hoozer2,hoozer3,0,0)
          displayAccountInfo(which,page,hoozer,hoozer2,hoozer3,f6)
        ENDIF
      ENDIF

      SELECT command
        CASE CHAR_DELETE            /* DELETE */
          aePuts('[JDelete\b\n')
          stat:=which
          hoozer.slotNumber:=0
          hoozer2.number:=0
          changes:=TRUE

          stat:=saveAccount(hoozer,hoozer2,hoozer3,stat,1)
          IF(stat<>RESULT_SUCCESS) THEN  aePuts('Can''t Save account\b\n')
          deleteConfAccess(stat)
          displayAccountInfo(which,page,hoozer,hoozer2,hoozer3,f6)
          flag:=0
        CASE "9"                       /* RE-ACTIVATE */
          aePuts('[JRe-Activate\b\n')
          changes:=TRUE
          hoozer.slotNumber:=which
          flag:=0
      ENDSELECT

      IF (page=0)
        SELECT command
          CASE "A"             /* NAME */
            aePuts('[2;10H')
            StrCopy(tempStr,hoozer.name)
            lineInput('',tempStr,30,INPUT_TIMEOUT,tempStr)
            AstrCopy(hoozer.name,tempStr,31)
            UpperStr(tempStr)
            AstrCopy(hoozer2.userName,tempStr,31)
            changes:=TRUE
            flag:=0
          CASE "B"             /* Real Name */
            aePuts('[2;56H')
            StrCopy(tempStr,hoozer3.realName)
            lineInput('',tempStr,25,INPUT_TIMEOUT,tempStr)
            AstrCopy(hoozer3.realName,tempStr,26)
            changes:=TRUE
            flag:=0
          CASE "C"             /* Location */
            aePuts('[3;10H')
            StrCopy(tempStr,hoozer.location)
            lineInput('',tempStr,29,INPUT_TIMEOUT,tempStr)
            AstrCopy(hoozer.location,tempStr,30)
            changes:=TRUE
            flag:=0
          CASE "D" /* PASS */
            IF((logonType>=LOGON_TYPE_REMOTE) AND (f6=FALSE))
              IF(loggedOnUser.slotNumber=1)
                aePuts('[3;56H')

                StrCopy(tempStr,'')
                StrAdd(tempStr,'         ')
                FOR i:=1 TO 9
                  StrAddChar(tempStr,8)
                ENDFOR
                aePuts(tempStr)
                lineInput('','',50,INPUT_TIMEOUT,tempStr)
                IF StrLen(tempStr)>0
                  setNewPassword(hoozer,hoozer3,tempStr)
                  hoozer3.pwdLastUpdated:=getSystemTime()
                  changes:=TRUE
                ENDIF
              ENDIF
            ELSE
              StrCopy(tempStr,'[3;56H')
              StrAdd(tempStr,'         ')
              FOR i:=1 TO 9
                StrAddChar(tempStr,8)
              ENDFOR
              aePuts(tempStr)
              lineInput('','',50,INPUT_TIMEOUT,tempStr)
              IF StrLen(tempStr)>0
                setNewPassword(hoozer,hoozer3,tempStr)
                hoozer3.pwdLastUpdated:=getSystemTime()
                changes:=TRUE
              ENDIF
            ENDIF
            flag:=0
          CASE "E" /* Phone number */
            aePuts('[4;21H')
            StrCopy(tempStr,hoozer.phoneNumber)
            lineInput('',tempStr,12,INPUT_TIMEOUT,tempStr)
            AstrCopy(hoozer.phoneNumber,tempStr,13)
            changes:=TRUE
            flag:=0
          CASE "F" /* conference access */
            aePuts('[4;56H')
            StrCopy(tempStr,hoozer.conferenceAccess)
            lineInput('',tempStr,9,INPUT_TIMEOUT,tempStr)
            AstrCopy(hoozer.conferenceAccess,tempStr,10)
            changes:=TRUE
            flag:=0
          CASE "G" /* RATIO */
            aePuts('[5;21H')
            hoozer.secLibrary:=numberInput(hoozer.secLibrary)
            changes:=TRUE
            flag:=0
          CASE "H" /* SEC_Level */
            IF((logonType>=LOGON_TYPE_REMOTE) AND (f6=FALSE))
              IF(loggedOnUser.slotNumber=1)
                aePuts('[5;56H')
                hoozer.secStatus:=numberInput(hoozer.secStatus)
              ENDIF
            ELSE
              aePuts('[5;56H')
              hoozer.secStatus:=numberInput(hoozer.secStatus)
            ENDIF
            changes:=TRUE
            flag:=0
          CASE "I"  /* Ratio Type */
            aePuts('[6;21H')
            hoozer.secBoard:=numberInput(hoozer.secBoard)
            IF((hoozer.secBoard<0) OR (hoozer.secBoard > 2))
              sendBELL()
              hoozer.secBoard:=0
            ENDIF
            StringF(tempStr,'[6;1H[33mI> [32mRatio Type ....[36m:[0m \l\d[5]',hoozer.secBoard)
            aePuts(tempStr)
            IF(hoozer.secBoard=0) THEN aePuts(' [32m<-[33mByte[32m)[0m')
            IF(hoozer.secBoard=1) THEN aePuts(' [32m<-[33mB/F[32m)[0m ')
            IF(hoozer.secBoard=2) THEN aePuts(' [32m<-[33mFile[32m)[0m')
            changes:=TRUE
            flag:=0
          CASE "J"                 /* conference ReJoin */
            aePuts('[6;56H')
            value1,value2:=rJoinInput(hoozer.confRJoin, hoozer.msgBaseRJoin)
            hoozer.confRJoin:=value1
            hoozer.msgBaseRJoin:=value2
            changes:=TRUE
            flag:=0
          CASE "K"                 /* UPLOADS */
            aePuts('[7;21H')
            hoozer.uploads:=numberInput(hoozer.uploads)
            changes:=TRUE
            flag:=0
          CASE "L" /* MESSAGES_POSTED */
            aePuts('[7;56H')
            hoozer.messagesPosted:=numberInput(hoozer.messagesPosted)
            changes:=TRUE
            flag:=0
          CASE "M" /* DOWNLOADS */
            aePuts('[8;21H')
            hoozer.downloads:=numberInput(hoozer.downloads)
            changes:=TRUE
            flag:=0
          CASE "N" /* New user ??  */
            aePuts('[8;56H   [8;56H')
            command:=yesNo(0)
            IF(command)   THEN hoozer.newUser:=1 ELSE hoozer.newUser:=0
            changes:=TRUE
            flag:=0
          CASE "#"
            aePuts('[6;71H')
            hoozer.timesCalled:=numberInput(hoozer.timesCalled)
            changes:=TRUE
            flag:=0
          CASE "%"
            aePuts('[7;71H')
            hoozer2.timesOnToday:=numberInput(getTodaysCalls(hoozer,hoozer2))
            changes:=TRUE
            flag:=0
          CASE "O" /* Bytes Uploaded */
            aePuts('[9;21H')

            bcdNumberInput(hoozer3.uploadBytesBCD)
            hoozer.bytesUpload:=convertFromBCD(hoozer3.uploadBytesBCD)
            changes:=TRUE
            flag:=0
          CASE "P" /* Bytes Downloaded */
            aePuts('[10;21H')
            bcdNumberInput(hoozer3.downloadBytesBCD)
            hoozer.bytesDownload:=convertFromBCD(hoozer3.downloadBytesBCD)
            changes:=TRUE
            flag:=0
          CASE "Q" /* Daily Bytes Limit */
            aePuts('[11;21H         [11;21H')
            IF hoozer.todaysBytesLimit<>0
              temp:=hoozer.todaysBytesLimit-hoozer.dailyBytesLimit
            ELSE
              temp:=0
            ENDIF
            hoozer.dailyBytesLimit:=longNumberInput(hoozer.dailyBytesLimit)
            hoozer.todaysBytesLimit:=hoozer.dailyBytesLimit
            IF hoozer.todaysBytesLimit<>0 THEN hoozer.todaysBytesLimit:=hoozer.todaysBytesLimit+temp
            changes:=TRUE
            flag:=0
          CASE "R" /* Time_Total */
            aePuts('[12;17H')
            hoozer.timeTotal:=Mul(numberInput(Div(hoozer.timeTotal,60)),60)
            IF(hoozer.timeTotal<hoozer.timeLimit)
              hoozer.timeTotal:=hoozer.timeLimit
            ELSE
              IF(cmds.acLvl[LVL_KEEP_UPLOAD_CREDIT]<2)
                hoozer.timeTotal:=hoozer.timeLimit
              ENDIF
            ENDIF
            changes:=TRUE
            flag:=0;
          CASE "S"         /* zero upcps rate */
            aePuts('[12;47H')
            hoozer2.upCPS2:=longNumberInput(hoozer2.upCPS2)
            IF hoozer2.upCPS2>65535 THEN hoozer2.oldUpCPS:=65535 ELSE hoozer2.oldUpCPS:=hoozer2.upCPS2
            changes:=TRUE
            flag:=0;
          CASE "T"         /* zero dncps rate */
            aePuts('[12;69H')
            hoozer2.dnCPS2:=longNumberInput(hoozer2.dnCPS2)
            IF hoozer2.dnCPS2>65535 THEN hoozer2.oldDnCPS:=65535 ELSE hoozer2.oldDnCPS:=hoozer2.dnCPS2
            changes:=TRUE
            flag:=0
          CASE "U" /* Time_Limit */
            aePuts('[13;17H')
            hoozer.timeLimit:=Mul(numberInput(Div(hoozer.timeLimit,60)),60)
            IF(hoozer.timeTotal<hoozer.timeLimit)
              hoozer.timeTotal:=hoozer.timeLimit
            ELSE
              IF(cmds.acLvl[LVL_KEEP_UPLOAD_CREDIT]<2)
                hoozer.timeTotal:=hoozer.timeLimit
              ENDIF
            ENDIF
            IF(loggedOnUser.slotNumber=hoozer.slotNumber)
              timeLimit:=hoozer.timeTotal-hoozer.timeUsed
            ENDIF
            changes:=TRUE
            flag:=0
          CASE "V" /* TIME_USED */
            aePuts('[13;51H')
            hoozer.timeUsed:=Mul(numberInput(Div(hoozer.timeUsed,60)),60)
            IF(loggedOnUser.slotNumber=hoozer.slotNumber)
              timeLimit:=hoozer.timeTotal-hoozer.timeUsed
            ENDIF
            changes:=TRUE
            flag:=0;
          CASE "W" /*uucpa*/
            aePuts('[13;76H')
            hoozer.uucpa:=uucpNumberInput(hoozer.uucpa)
            changes:=TRUE
            flag:=0
          CASE "Y" /* chat limit */
            aePuts('[14;17H')
            temp:=hoozer.chatLimit-hoozer.chatRemain
            hoozer.chatLimit:=Mul(numberInput(Div(hoozer.chatLimit,60)),60)
            hoozer.chatRemain:=hoozer.chatLimit-temp
            IF hoozer.chatRemain<0 THEN hoozer.chatRemain:=0
            changes:=TRUE
            flag:=0
          CASE "Z" /* chat used */
            aePuts('[14;51H')
            hoozer.chatRemain:=hoozer.chatLimit-Mul(numberInput(Div(hoozer.chatLimit-hoozer.chatRemain,60)),60)
            IF hoozer.chatRemain<0 THEN hoozer.chatRemain:=0
            changes:=TRUE
            flag:=0
        ENDSELECT
      ELSEIF page=1
        SELECT command
          CASE "A"             /* NAME */
            aePuts('[2;10H')
            StrCopy(tempStr,hoozer.name)
            lineInput('',tempStr,30,INPUT_TIMEOUT,tempStr)
            AstrCopy(hoozer.name,tempStr,31)
            UpperStr(tempStr)
            AstrCopy(hoozer2.userName,tempStr,31)
            changes:=TRUE
            flag:=0
          CASE "B"             /* Password reset */
            aePuts('[3;21H   [3;21H')
            command:=yesNo(0)
            IF(command)   THEN hoozer3.forcePwdReset:=1 ELSE hoozer3.forcePwdReset:=0
            changes:=TRUE
            flag:=0
          CASE "C"             /* account locked */
            aePuts('[3;56H   [3;56H')
            command:=yesNo(0)
            IF(command)   THEN hoozer3.accountLocked:=1 ELSE hoozer3.accountLocked:=0
            changes:=TRUE
            flag:=0
          CASE "D" /* invalid attempts */
            aePuts('[4;21H')
            hoozer3.invalidAttempts:=numberInput(hoozer3.invalidAttempts)
            changes:=TRUE
            flag:=0
        ENDSELECT
      ENDIF
    ENDIF

    aePuts('[18;1H')
  UNTIL flag
  nofkeys:=0

ENDPROC flag

PROC applyConfPresets(hoozer:PTR TO user, preset:LONG)
  DEF i,m
  DEF cb:PTR TO confBase

  IF loggedOnUser<>NIL THEN masterSavePointers(loggedOnUser)

  masterLoadPointers(hoozer)

  FOR i:=1 TO cmds.numConf
    FOR m:=1 TO getConfMsgBaseCount(i)
      cb:=confBases.item(getConfIndex(i,m))

      IF checkToolTypeExists(TOOLTYPE_PRESET,preset,'PRESET.RATIO')
        cb.ratio:=readToolTypeInt(TOOLTYPE_PRESET,preset,'PRESET.RATIO')
      ENDIF

      IF checkToolTypeExists(TOOLTYPE_PRESET,preset,'PRESET.RATIOTYPE')
        cb.ratioType:=readToolTypeInt(TOOLTYPE_PRESET,preset,'PRESET.RATIOTYPE')
      ENDIF
    ENDFOR

  ENDFOR
  masterSavePointers(hoozer)

  IF loggedOnUser<>NIL THEN masterLoadPointers(loggedOnUser)
ENDPROC

PROC userNotes(which:LONG, hoozer:PTR TO user, hoozer2:PTR TO userKeys, hoozer3:PTR TO userMisc, onlineEdit)
  DEF flag
  DEF tempstr[255]:STRING
  DEF command,lock
  DEF fname[255]:STRING

  fileattach:=FALSE
  REPEAT

    sendCLS()
    aePuts('[2;1H                          [33mUSER ACCOUNT NOTES[0m')

    conCursorOff()

    aePuts('[4;0H[0m')

    StringF(tempstr,'[\z\d[4]] \s[32]',hoozer.slotNumber,hoozer.name)
    aePuts(tempstr)

    IF(lock:=CreateDir(userNotesFolder))
      UnLock(lock)
    ENDIF
    StringF(fname,'\s\d',userNotesFolder,hoozer.slotNumber)

    aePuts('[6;0H[33mUSER NOTES[0m\b\n\b\n')
    aePuts('[34m------------------------------------------------------------------------------[0m\b\n')
    IF displayFile(fname)=FALSE THEN aePuts('None\b\n')
    aePuts('[34m------------------------------------------------------------------------------[0m\b\n')
    aePuts('\b\n')
    aePuts('[33m<TAB>[36m=[0mExit [33mE[36m=[0mEdit\b\n')
    flag:=0
    command:=readChar(INPUT_TIMEOUT)
    IF(command<0) THEN RETURN command
    command:=UpperChar(command)

    flag:=0

    SELECT command
      CASE "+"
        IF(onlineEdit=FALSE)
          which:=which+1
          IF(loadAccount(which,hoozer,hoozer2,hoozer3)=RESULT_FAILURE)
            which:=1
            loadAccount(which,hoozer,hoozer2,hoozer3)
          ENDIF
        ENDIF
      CASE "-"
        IF(onlineEdit=FALSE)
          which:=which-1
          IF(which<1) THEN which:=findLastAccount()
          loadAccount(which,hoozer,hoozer2,hoozer3)
        ENDIF
      CASE "E"
        loadMsg(fname)
        IF(edit()=RESULT_SUCCESS) THEN saveMsg(fname)
      CASE "\t"
        flag:=1
    ENDSELECT
  UNTIL flag

ENDPROC

PROC listNewAccounts(f6)
  DEF foflag,x,maximum,stat
  DEF fh
  DEF tempStr[255]:STRING
  DEF i

  onlineEdit:=1
  foflag:=0
  send017()
  sendCLS()
  aePuts('Searching...')
  maximum:=findLastAccount()
  IF(fh:=Open(userKeysFile,MODE_OLDFILE))<>0
    FOR x:=1 TO maximum
      stat:=Read(fh,tempUserKeys,SIZEOF userKeys)
      ->//      printf("Name %-31s New User = %d\b\n",GHoozer2.UserName,GHoozer2.New_User)
      IF(stat<>SIZEOF userKeys)
        StringF(tempStr,'FILE-FAULT[\d], ',x)
        aePuts(tempStr)
      ELSE
        IF((tempUserKeys.newUser=1) AND (includeDeact OR (tempUserKeys.number<>0)))
          foflag:=1
          loadAccount(x,tempUser,tempUserKeys,tempUserMisc)
          stat:=editInfo(x,tempUser,tempUserKeys,tempUserMisc,f6)
          IF(stat=1)
            aePuts('\b\nAbort')
            JUMP acctMark1
          ENDIF
          aePuts('Searching...')
        ENDIF
      ENDIF
      IF((logonType>=LOGON_TYPE_REMOTE) AND (checkOnlineStatus()<0))
        Close(fh)
        onlineEdit:=0
        RETURN RESULT_NO_CARRIER
      ENDIF
      IF(checkInput())
        stat:=readChar(INPUT_TIMEOUT)
        SELECT stat
          CASE 23
            purgeLine()
            aePuts('Any key..')
            stat:=readChar(INPUT_TIMEOUT)
            IF((stat=RESULT_TIMEOUT) OR (stat=RESULT_NO_CARRIER))
              Close(fh)
              onlineEdit:=0
              RETURN stat
            ENDIF
            StrCopy(tempStr,'')

            FOR i:=1 TO 9
              StrAddChar(tempStr,8)
            ENDFOR
            StrAdd(tempStr,'         ')
            FOR i:=1 TO 9
              StrAddChar(tempStr,8)
            ENDFOR
            aePuts(tempStr)
          CASE 3 /* ^C */
            aePuts('\b\nAbort\b\n')
            JUMP acctMark1
          DEFAULT
            purgeLine()
        ENDSELECT
      ENDIF
    ENDFOR
acctMark1:
    IF(foflag=FALSE) THEN   aePuts('[0mNo new users.')
    Close(fh)
  ENDIF
  aePuts('\b\n\b\n')
  onlineEdit:=0
ENDPROC RESULT_SUCCESS

PROC onlineEditor(f6)
  DEF temp,t=0
  DEF str[255]:STRING
  DEF extraBytes
  
  temp:=loggedOnUser.timeLimit

  IF loggedOnUser.todaysBytesLimit<>0 
    extraBytes:=loggedOnUser.todaysBytesLimit-loggedOnUser.dailyBytesLimit
  ELSE
    extraBytes:=0
  ENDIF

  StrCopy(str,'\d',loggedOnUser.slotNumber)
  IF runSysCommand('ACCOUNTS',str)<>RESULT_SUCCESS
    t:=1
    editInfo(loggedOnUser.slotNumber,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,f6)
  ENDIF
  IF(loggedOnUser.timeLimit<>temp)
    IF(loggedOnUser.timeLimit>temp) THEN loggedOnUser.timeTotal:=loggedOnUser.timeLimit
    timeLimit:=loggedOnUser.timeLimit-loggedOnUser.timeUsed
  ENDIF

  IF (loggedOnUser.dailyBytesLimit<>0)
    bytesADL:=loggedOnUser.dailyBytesLimit+extraBytes-loggedOnUser.dailyBytesDld
    loggedOnUser.todaysBytesLimit:=loggedOnUser.dailyBytesLimit+extraBytes
  ELSE
    bytesADL:=$7fffffff
    loggedOnUser.todaysBytesLimit:=0
  ENDIF
  IF(t) THEN aePuts('\b\nCompleted Edit\b\n')
ENDPROC

PROC listCreditAccounts(f6)
  DEF foflag,x,maximum,stat
  DEF fh
  DEF tempStr[255]:STRING

  onlineEdit:=1
  foflag:=0
  maximum:=findLastAccount()
  IF(fh:=Open(userDataFile,MODE_OLDFILE))<>0
    FOR x:=1 TO maximum
      stat:=Read(fh,tempUser,SIZEOF user)
      ->//      printf("Name %-31s New User = %d\b\n",GHoozer2.UserName,GHoozer2.New_User)
      IF(stat<>SIZEOF user)
        StringF(tempStr,'FILE-FAULT[\d], ',x)
        aePuts(tempStr)
      ELSE
        IF((tempUser.creditDays>0) AND (includeDeact OR (tempUser.slotNumber<>0)))
          foflag:=1
          loadAccount(x,tempUser,tempUserKeys,tempUserMisc)
          stat:=creditMaintenance(x,tempUser,tempUserKeys,tempUserMisc,f6)
          IF(stat=1) THEN JUMP exitcreditlist
        ENDIF
      ENDIF
      IF((logonType>=LOGON_TYPE_REMOTE) AND (checkOnlineStatus()<0))
        Close(fh)
        onlineEdit:=0
        RETURN RESULT_NO_CARRIER
      ENDIF
    ENDFOR
exitcreditlist:
    Close(fh)
  ENDIF
  aePuts('\b\n\b\n')
  onlineEdit:=0
ENDPROC RESULT_SUCCESS

PROC creditMaintenance(which:LONG, hoozer:PTR TO user, hoozer2:PTR TO userKeys, hoozer3: PTR TO userMisc,f6)
  DEF tempstr[255]:STRING
  DEF datestr[15]:STRING,datestr2[15]:STRING,currdatestr[15]:STRING,currtimestr[15]:STRING
  DEF yesno[3]:STRING
  DEF flag=FALSE,remain,ch,stat
  DEF checkLock
  DEF changes=FALSE

  IF (logonType=LOGON_TYPE_REMOTE) AND (checkSecurity(ACS_CREDIT_ACCESS)=FALSE) AND (f6=FALSE)
    RETURN 0
  ENDIF

  checkLock:=checkLockAccounts(f6)

  sendCLS()
  REPEAT

    aePuts('[2;1H                      [33mACCOUNT CREDIT MAINTENANCE[0m')

    conCursorOff()

    aePuts('[4;2H[0m')

    StringF(tempstr,'[\z\d[4]] \s[32]',hoozer.slotNumber,hoozer.name)
    aePuts(tempstr)

    aePuts('[6;2H[33mCREDIT STATUS [0m')

    IF hoozer.creditDays=0 THEN aePuts('[37mINACTIVE      [0m') ELSE aePuts('[32mACTIVE        [0m')

    StringF(tempstr,'[8;2H[33m1.>[32m Days Credited  [33m[[0m\d[7][33m][0m',hoozer.creditDays AND $FFFF)
    aePuts(tempstr)

    StringF(tempstr,'[9;2H[33m2.>[32m Amount Paid    [33m[[0m\d[7][33m][0m',hoozer.creditAmount AND $FFFF)
    aePuts(tempstr)

    formatLongDate(hoozer.creditTotalDate,datestr)
    StringF(tempstr,'[10;2H[33m3.>[32m Amount Paid to Date [33m[[0m\d[7][33m][32m as of [0m\s',hoozer.creditTotalToDate AND $FFFF,datestr)
    aePuts(tempstr)

    IF (hoozer.creditTracking AND TRACK_UPLOADS_BIT) THEN StrCopy(yesno,'Yes') ELSE StrCopy(yesno,'No ')
    IF hoozer.creditStartDate=0
      StrCopy(datestr,'')
    ELSE
      formatLongDate(hoozer.creditStartDate,datestr)
    ENDIF
    StringF(tempstr,'[11;2H[33m4.> [32mTrack Uploads   [0m\s [32m Beginning Date [0m\s',yesno,datestr)
    aePuts(tempstr)

    IF (hoozer.creditTracking AND TRACK_DOWNLOADS_BIT) THEN StrCopy(yesno,'Yes') ELSE StrCopy(yesno,'No ')
    IF hoozer.creditStartDate=0
      StrCopy(datestr2,'')
    ELSE
      formatLongDate(hoozer.creditStartDate+Mul(hoozer.creditDays,86400),datestr2)
    ENDIF
    StringF(tempstr,'[12;2H[33m5.> [32mTrack Downloads [0m\s [32m Ending Date    [0m\s',yesno,datestr2)
    aePuts(tempstr)

    IF (hoozer.creditStartDate=0) OR (hoozer.creditDays=0)
      remain:=0
    ELSE
      remain:=((Div(hoozer.creditStartDate,86400))+hoozer.creditDays)-(Div(getSystemDate(),86400))
    ENDIF
    StringF(tempstr,'[13;2H[33m   [32m Days Remaining. [0m\d[7]',remain)
    aePuts(tempstr)

    aePuts('[15;2H[33mX[36m=[0mEXIT [33mR[36m=[0mRESET/SET BEGINNING DATE [0m')
    aePuts('[33mT[36m=[0mTERMINATE CREDIT ACCOUNT [0m')
    aePuts('[16;2H[33mU[36m=[0mUPDATE CREDIT TOTAL [33m~[36m=[0mSAVE ACCOUNT [0m')
    aePuts('[33m<TAB>[36m=[0mCONT[0m')

    conCursorOn()
    aePuts('[17;2H')

    ch:=readChar(INPUT_TIMEOUT)

    aePuts('[17;2H                                     [17;2H')

    IF(ch<0) THEN RETURN ch
    ch:=UpperChar(ch)

    SELECT ch
      CASE "\t"
        IF f6 ORELSE checkChanges(changes) THEN flag:=2
      CASE "X"
        IF f6 ORELSE checkChanges(changes) THEN flag:=1
    ENDSELECT

    IF checkLock
      SELECT ch
        CASE "1"
          aePuts('[8;22H')
          hoozer.creditDays:=numberInput(hoozer.creditDays)
          changes:=TRUE
        CASE "2"
          aePuts('[9;22H')
          hoozer.creditAmount:=numberInput(hoozer.creditAmount)
          changes:=TRUE
        CASE "3"
          aePuts('[10;27H')
          hoozer.creditTotalToDate:=numberInput(hoozer.creditTotalToDate)
          hoozer.creditTotalDate:=getSystemDate()
          changes:=TRUE
        CASE "4"
          hoozer.creditTracking:=Eor(hoozer.creditTracking,TRACK_UPLOADS_BIT)
          changes:=TRUE
        CASE "5"
          hoozer.creditTracking:=Eor(hoozer.creditTracking,TRACK_DOWNLOADS_BIT)
          changes:=TRUE
        CASE "U"
          hoozer.creditTotalToDate:=hoozer.creditTotalToDate+hoozer.creditAmount
          hoozer.creditTotalDate:=getSystemDate()
          changes:=TRUE
        CASE "R"
          hoozer.creditStartDate:=getSystemDate()
          changes:=TRUE
        CASE "T"
          hoozer.creditDays:=0
          changes:=TRUE
        CASE "~"
          IF (logonType<LOGON_TYPE_REMOTE) OR (f6=TRUE)
            IF (hoozer.creditDays>0) AND (hoozer.creditStartDate=0) THEN hoozer.creditStartDate:=getSystemDate()

            aePuts('[17;2HSaving Account...')
            changes:=FALSE

            formatLongDate(getSystemDate(),currdatestr)
            formatLongTime(getSystemDate(),currtimestr)

            IF(hoozer.creditDays=0)
              StringF(tempstr,'\s \s \s [\d[4]] CREDIT ACCOUNT INACTIVATED\n',currdatestr,currtimestr,hoozer.name,hoozer.slotNumber)
              creditLog(tempstr)
            ELSE
              StringF(tempstr,'\s \s \s [\d[4]]\n\tDAYS [\d[7]] AMOUNT [\d[7]] STARTDATE \s ENDDATE \s\n',currdatestr,currtimestr,hoozer.name,hoozer.slotNumber,hoozer.creditDays,hoozer.creditAmount,datestr,datestr2)
              creditLog(tempstr)
              formatLongDate(hoozer.creditTotalDate,datestr)
              StringF(tempstr,'\tAMOUNT PAID TO DATE [\d[7]] AS OF \s\n',hoozer.creditTotalToDate,datestr)
              creditLog(tempstr)
            ENDIF

            IF(hoozer.slotNumber=0)
              hoozer2.number:=0
              stat:=saveAccount(hoozer,hoozer2,hoozer3,which,1) /* 1 = FORCE SAVE */

              IF(stat<>RESULT_SUCCESS) THEN aePuts('Can''t Save account\b\n')
            ELSE
              hoozer2.number:=hoozer.slotNumber
                      /* save using Slot_number */
              stat:=saveAccount(hoozer,hoozer2,hoozer3,0,0) /* Not forced */
              IF(stat<>RESULT_SUCCESS) THEN aePuts('Can''t Save account\b\n')
            ENDIF

          ENDIF
      ENDSELECT
    ENDIF

  UNTIL flag

ENDPROC flag


PROC conferenceAccounting(hoozer:PTR TO user, hoozer2:PTR TO userKeys, hoozer3: PTR TO userMisc,f6)
  DEF tempstr[255]:STRING,tempstr2[255]:STRING
  DEF cb: PTR TO confBase
  DEF i,m,flag=0,conf,msgbase,ch,oldval
  DEF checkLock
  DEF oldBCD[8]:ARRAY OF CHAR
  DEF changes=FALSE

  IF loggedOnUser<>NIL THEN masterSavePointers(loggedOnUser)

  masterLoadPointers(hoozer)

  IF f6
    ->recalculate totals
    
    IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING))
      hoozer.uploads:=0
      hoozer.downloads:=0
      hoozer.bytesUpload:=0
      hoozer.bytesDownload:=0
      FOR i:=0 TO 7
        hoozer3.downloadBytesBCD[i]:=0
        hoozer3.uploadBytesBCD[i]:=0
      ENDFOR
    ENDIF
    hoozer.messagesPosted:=0
    FOR i:=1 TO cmds.numConf
      FOR m:=1 TO getConfMsgBaseCount(i)
        cb:=confBases.item(getConfIndex(i,m))
        IF (checkConfAccess(i,hoozer))
          IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING)) AND (readToolTypeInt(TOOLTYPE_CONF,conf,'CONFDB_SHARED')<=0)
            hoozer.uploads:=hoozer.uploads+cb.upload
            hoozer.downloads:=hoozer.downloads+cb.downloads
            addBCD2(hoozer3.downloadBytesBCD,cb.downloadBytesBCD)
            addBCD2(hoozer3.uploadBytesBCD,cb.uploadBytesBCD)
            hoozer.bytesDownload:=convertFromBCD(hoozer3.downloadBytesBCD)
            hoozer.bytesUpload:=convertFromBCD(hoozer3.uploadBytesBCD)
          ENDIF
          hoozer.messagesPosted:=hoozer.messagesPosted+cb.messagesPosted
        ENDIF
      ENDFOR
    ENDFOR
  ENDIF

  conf:=hoozer.confRJoin
  msgbase:=hoozer.msgBaseRJoin

  IF checkConfAccess(conf,hoozer)=FALSE
    i:=0
    REPEAT
      conf++
      IF conf>cmds.numConf THEN conf:=1
      i++
    UNTIL (checkConfAccess(conf,hoozer)) OR (i>cmds.numConf)
    IF (i>cmds.numConf)
      RETURN 1
    ENDIF
  ENDIF

  checkLock:=checkLockAccounts(f6)
  sendCLS()

  REPEAT
    conCursorOff()

    cb:=confBases.item(getConfIndex(conf,msgbase))

    StringF(tempstr,'[2;1H [32mName[36m:[0m \s[32] ',hoozer.name)
    aePuts(tempstr)

    StringF(tempstr,'[3;1H [32mLoc.[36m:[0m \s[29]\b\n',hoozer.location)
    aePuts(tempstr)

    IF getConfMsgBaseCount(conf)>1
      getMsgBaseName(conf,msgbase,tempstr)
      StringF(tempstr2,'\s - \s',getConfName(conf),tempstr)
    ELSE
      getConfName(conf,tempstr2)
    ENDIF

    StringF(tempstr,'[4;1H [32mConf[36m:[0m \s[60]\b\n',tempstr2)
    aePuts(tempstr)

    StringF(tempstr,'[6;2H[33mG>[32mRatio .........[36m:[0m \d[7]\b\n',cb.ratio AND $FFFF)
    aePuts(tempstr)

    StringF(tempstr,'[7;2H[33mI>[32mRatio Type ....[36m:[0m \d[5]',cb.ratioType AND $FFFF)
    aePuts(tempstr)
    IF(cb.ratioType=0) THEN aePuts(' [32m<-[33mByte[32m)[0m')
    IF(cb.ratioType=1) THEN aePuts(' [32m<-[33mB/F[32m)[0m ')
    IF(cb.ratioType=2) THEN aePuts(' [32m<-[33mFile[32m)[0m')

    StringF(tempstr,'[8;2H[33mK>[32mUploads .......[36m:[0m \d[10]\b\n',cb.upload AND $FFFF)
    aePuts(tempstr)

    StringF(tempstr,'[9;2H[33mM>[32mDownloads .....[36m:[0m \d[10]\b\n',cb.downloads AND $FFFF)
    aePuts(tempstr)

    formatBCD(cb.uploadBytesBCD,tempstr2)
    IF sopt.toggles[TOGGLES_CREDITBYKB]
      StringF(tempstr,'[10;2H[33mO>[32mKBytes Uled ...[36m:[0m \s[16]\b\n',tempstr2)
    ELSE
      StringF(tempstr,'[10;2H[33mO>[32mBytes Uled ....[36m:[0m \s[16]\b\n',tempstr2)
    ENDIF
    aePuts(tempstr)

    formatBCD(cb.downloadBytesBCD,tempstr2)
    IF sopt.toggles[TOGGLES_CREDITBYKB]
      StringF(tempstr,'[11;2H[33mP>[32mKBytes Dled ...[36m:[0m \s[16]\b\n',tempstr2)
    ELSE
      StringF(tempstr,'[11;2H[33mP>[32mBytes Dled ....[36m:[0m \s[16]\b\n',tempstr2)
    ENDIF
    aePuts(tempstr)

    StringF(tempstr,'[12;2H[33mL>[32mMessages Posted[36m:[0m \d[10]',cb.messagesPosted AND $FFFF)
    aePuts(tempstr)

    aePuts('[6;40H[33mAccumulated Total[0m')

    StringF(tempstr,'[8;40H[32mUploads .......[36m:[0m \d[10]\b\n',hoozer.uploads AND $FFFF)
    aePuts(tempstr)

    StringF(tempstr,'[9;40H[32mDownloads .....[36m:[0m \d[10]\b\n',hoozer.downloads AND $FFFF)
    aePuts(tempstr)

    formatBCD(hoozer3.uploadBytesBCD,tempstr2)
    IF sopt.toggles[TOGGLES_CREDITBYKB]
      StringF(tempstr,'[10;40H[32mKBytes Uled ...[36m:[0m \s[16]\b\n',tempstr2)
    ELSE
      StringF(tempstr,'[10;40H[32mBytes Uled ....[36m:[0m \s[16]\b\n',tempstr2)
    ENDIF
    aePuts(tempstr)

    formatBCD(hoozer3.downloadBytesBCD,tempstr2)
    IF sopt.toggles[TOGGLES_CREDITBYKB]
      StringF(tempstr,'[11;40H[32mKBytes Dled ...[36m:[0m \s[16]\b\n',tempstr2)
    ELSE
      StringF(tempstr,'[11;40H[32mBytes Dled ....[36m:[0m \s[16]\b\n',tempstr2)
    ENDIF
    aePuts(tempstr)

    StringF(tempstr,'[12;40H[32mMessages_Posted[36m:[0m \d[10]',hoozer.messagesPosted AND $FFFF)
    aePuts(tempstr)

    aePuts('[14;1H  [33m-/+[36m=[0mPrev/Next Conference      [33m~[36m=[0mSAVE[0m\n')

    aePuts('[15;1H  [33m<TAB>[36m=[0mEXIT Conference Accounting[0m\b\n')

    aePuts('[16;1H')

    conCursorOn()

    ch:=readChar(INPUT_TIMEOUT)
        IF(ch<0) THEN RETURN ch

    ch:=UpperChar(ch)

    SELECT ch
      CASE "+"
        msgbase:=msgbase+1
        IF msgbase>getConfMsgBaseCount(conf)
          REPEAT
            conf++
            IF conf>cmds.numConf THEN conf:=1
          UNTIL checkConfAccess(conf,hoozer)
          msgbase:=1
        ENDIF
      CASE "-"
        msgbase:=msgbase-1
        IF msgbase<1
          REPEAT
            conf--
            IF conf<1 THEN conf:=cmds.numConf
          UNTIL checkConfAccess(conf,hoozer)
          msgbase:=getConfMsgBaseCount(conf)
        ENDIF

      CASE "\t"
        IF checkChanges(changes)
          flag:=1
        ENDIF
    ENDSELECT

    IF checkLock
      SELECT ch
        CASE "G"
          aePuts('[6;21H')
          cb.ratio:=numberInput(cb.ratio)
          changes:=TRUE
        CASE "I"
          aePuts('[7;21H')
          cb.ratioType:=numberInput(cb.ratioType)
          IF((cb.ratioType<0) OR (cb.ratioType > 2))
            sendBELL()
            cb.ratioType:=0
          ENDIF
          changes:=TRUE
        CASE "K"
          aePuts('[8;21H')
          oldval:=cb.upload
          cb.upload:=numberInput(cb.upload)
          IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING)) THEN hoozer.uploads:=hoozer.uploads-oldval+cb.upload
          changes:=TRUE
        CASE "M"
          aePuts('[9;21H')
          oldval:=cb.downloads
          cb.downloads:=numberInput(cb.downloads)
          IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING)) THEN hoozer.downloads:=hoozer.downloads-oldval+cb.downloads
          changes:=TRUE
        CASE "O"
          aePuts('[10;21H')

          FOR i:=0 TO 7
            oldBCD[i]:=cb.uploadBytesBCD[i]
          ENDFOR
          bcdNumberInput(cb.uploadBytesBCD)
          cb.bytesUpload:=convertFromBCD(cb.uploadBytesBCD)
          IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING))
            subBCD2(hoozer3.uploadBytesBCD,oldBCD)
            addBCD2(hoozer3.uploadBytesBCD,cb.uploadBytesBCD)
            hoozer.bytesUpload:=convertFromBCD(hoozer3.uploadBytesBCD)
          ENDIF
          changes:=TRUE
        CASE "P"
          aePuts('[11;21H')
          FOR i:=0 TO 7
            oldBCD[i]:=cb.downloadBytesBCD[i]
          ENDFOR
          bcdNumberInput(cb.downloadBytesBCD)
          cb.bytesDownload:=convertFromBCD(cb.downloadBytesBCD)
          IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING))
            subBCD2(hoozer3.downloadBytesBCD,oldBCD)
            addBCD2(hoozer3.downloadBytesBCD,cb.downloadBytesBCD)
            hoozer.bytesDownload:=convertFromBCD(hoozer3.downloadBytesBCD)
          ENDIF
          changes:=TRUE
        CASE "L"
          aePuts('[12;21H')
          oldval:=cb.messagesPosted
          cb.messagesPosted:=numberInput(cb.messagesPosted)
          hoozer.messagesPosted:=hoozer.messagesPosted-oldval+cb.messagesPosted
          changes:=TRUE
        CASE "~"
          aePuts('[JSave\b\n')

          masterSavePointers(hoozer)
          changes:=FALSE

          IF (logonType>=LOGON_TYPE_REMOTE)
            StringF(tempstr,'\tREMOTE Conference Maintenance on Account \d, Conference \s',hoozer.slotNumber,conf)
            callersLog(tempstr)
          ELSE
            StringF(tempstr,'\tLOCAL  Conference Maintenance on Account \d, Conference \s',hoozer.slotNumber,conf)
            callersLog(tempstr)
          ENDIF
      ENDSELECT
    ENDIF

  UNTIL flag<>0
  IF loggedOnUser<>NIL THEN masterLoadPointers(loggedOnUser)
  IF f6 THEN loadMsgPointers(currentConf,currentMsgBase)
ENDPROC flag

PROC doOnLineEdit(f6)
  DEF charStr[1]:STRING
  DEF oldAcsLevel


  StrCopy(charStr,' ')
  charStr[0]:=12
  onlineEdit:=1
  IF(logonType>=LOGON_TYPE_REMOTE)
    ioFlags[IOFLAG_SER_IN]:=0
    ioFlags[IOFLAG_SER_OUT]:=0
  ENDIF
  conPuts(charStr)
  oldAcsLevel:=acsLevel
  acsLevel:=255
  onlineEditor(f6)
  acsLevel:=oldAcsLevel
  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  IF(logonType>=LOGON_TYPE_REMOTE)
    ioFlags[IOFLAG_SER_IN]:=-1
    ioFlags[IOFLAG_SER_OUT]:=-1
  ENDIF
  onlineEdit:=0
ENDPROC



PROC deleteConfAccess(slot)
  DEF bi
  DEF t:confBase
  DEF i,m,j
  DEF temp[100]:STRING

  FOR i:=1 TO cmds.numConf

    FOR m:=1 TO getConfMsgBaseCount(i)
      getConfDbFileName(i,m,temp)

      bi:=Open(temp,MODE_OLDFILE)
      IF(bi<>0)
        Seek(bi,(slot-1)*SIZEOF confBase,OFFSET_BEGINNING)
        Read(bi,t,SIZEOF confBase)
        t.confRead:=0
        t.newSinceDate:=0
        t.confRead:=0
        t.confYM:=0
        t.bytesDownload:=0
        t.bytesUpload:=0
        t.uploadTracking:=0
        t.unused:=0
        t.unused2:=0
        t.upload:=0
        t.downloads:=0
        t.ratioType:=0
        t.ratio:=0
        t.messagesPosted:=0
        t.active:=0
        t.access:=0
        FOR j:=0 TO 7
           t.downloadBytesBCD[j]:=0
           t.uploadBytesBCD[j]:=0
        ENDFOR
        Seek(bi,(slot-1)*SIZEOF confBase,OFFSET_BEGINNING)
        Write(bi,t,SIZEOF confBase)

        Close(bi)
      ENDIF
    ENDFOR
  ENDFOR
ENDPROC


PROC checkNEdit(which,f6)
  DEF stat

  stat:=findLastAccount()
  IF(which>stat)
    aePuts('Higher Than Maximum Account\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  sendCLS()
  stat:=loadAccount(which,tempUser,tempUserKeys,tempUserMisc)
  IF(stat=RESULT_FAILURE)
    aePuts('Warning, error while loading account\b\n')
    RETURN RESULT_FAILURE
  ENDIF
  send017()
  sendCLS()
  stat:=editInfo(which,tempUser,tempUserKeys,tempUserMisc,f6)
ENDPROC stat

PROC editAccounts(f6)
  DEF stat
  DEF which,lw
  DEF tempStr[255]:STRING

  includeDeact:=FALSE
  
  setEnvStat(ENV_ACCOUNT)
  IF runSysCommand('ACCOUNTS','')<>RESULT_SUCCESS

    LOOP
        IF includeDeact
          aePuts('\b\nI>nactive accounts: Include')
        ELSE
          aePuts('\b\nI>nactive accounts: Exclude')
        ENDIF
      aePuts('  S>earch by name  N>ew account editing\b\nC>redit Accounts  B>ulk editing\b\nEdit which account? ')
      stat:=lineInput('','',5,INPUT_TIMEOUT,tempStr)
      IF(stat) THEN JUMP returnf
      IF(UpperChar(tempStr[0])="N")
        listNewAccounts(f6)
      ELSEIF(UpperChar(tempStr[0])="B")
        bulkAccountEditor()
      ELSEIF(UpperChar(tempStr[0])="C")
        listCreditAccounts(f6)
      ELSEIF(UpperChar(tempStr[0])="I")
        includeDeact:=Not(includeDeact)
      ELSEIF(UpperChar(tempStr[0])="S")
        aePuts('\b\nUserName: ')
        stat:=lineInput('','',30,INPUT_TIMEOUT,tempStr)
        IF (stat) THEN JUMP returnf
        IF (StrLen(tempStr))
          lw:=0
          REPEAT
            lw++
            which:=findUserFromName(lw,NAME_TYPE_USERNAME,tempStr,tempUser,tempUserKeys,tempUserMisc)
            IF(which<=0)
              aePuts('\b\nSorry no user under that name.\b\n')
            ELSE
              lw:=which
              stat:=checkNEdit(which,f6)
              IF stat<0 THEN JUMP returnf
            ENDIF
          UNTIL (which<=0) OR (stat<>2)
        ENDIF
      ELSE
        which:=Val(tempStr)
        IF(which<=0) THEN JUMP returnf
        stat:=checkNEdit(which,f6)
        IF stat<0 THEN JUMP returnf
      ENDIF
    ENDLOOP
returnf:
    aePuts('\b\n')
  ENDIF
  includeDeact:=FALSE

ENDPROC RESULT_SUCCESS

PROC updateAllUsers(confnum,msgBaseNum,updateType, newVal)
  DEF fh,stat
  DEF cb: PTR TO confBase
  DEF confDbFile[255]:STRING

  getConfDbFileName(confnum,msgBaseNum,confDbFile)

  cb:=NEW cb

  fh:=Open(confDbFile,MODE_READWRITE)

  IF fh<>0
    REPEAT
      stat:=Read(fh,cb,SIZEOF confBase)
      IF stat=SIZEOF confBase
        Seek(fh,-stat,OFFSET_CURRENT)

        SELECT updateType
          CASE UPDATE_RATIO
            cb.ratio:=newVal
          CASE UPDATE_RATIO_TYPE
            cb.ratioType:=newVal
          CASE UPDATE_MAILSCAN_PTRS
            cb.confRead:=newVal
          CASE UPDATE_NEW_MAIL_SCAN
            IF newVal
              cb.handle[0]:=cb.handle[0] OR MAIL_SCAN_MASK
            ELSE
              cb.handle[0]:=cb.handle[0] AND Not(MAIL_SCAN_MASK)
            ENDIF
          CASE UPDATE_NEW_FILE_SCAN
            IF newVal
              cb.handle[0]:=cb.handle[0] OR FILE_SCAN_MASK
            ELSE
              cb.handle[0]:=cb.handle[0] AND Not(FILE_SCAN_MASK)
            ENDIF
          CASE UPDATE_DEFAULT_ZOOM_FLAG
            IF newVal
              cb.handle[0]:=cb.handle[0] OR ZOOM_SCAN_MASK
            ELSE
              cb.handle[0]:=cb.handle[0] AND Not(ZOOM_SCAN_MASK)
            ENDIF
          CASE UPDATE_LAST_MESSAGE
            cb.confYM:=newVal
          CASE UPDATE_MESSAGES_POSTED
            cb.messagesPosted:=newVal
          CASE UPDATE_RESET_VOTING
            cb.handle[0]:=cb.handle[0] AND 15
            cb.handle[1]:=0
            cb.handle[2]:=0
            cb.handle[3]:=0
        ENDSELECT

        stat:=Write(fh,cb,SIZEOF confBase)
      ENDIF
    UNTIL stat<>SIZEOF confBase
    Close(fh)
  ENDIF
  END cb

ENDPROC

PROC dumpUserStats(confnum,msgBaseNum)
  DEF fh,fhs
  DEF cb: PTR TO confBase
  DEF confDbFile[255]:STRING
  DEF confStatFile[255]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[20]:STRING
  DEF n,stat

  StringF(confStatFile,'\sConf\d.Stats',cmds.bbsLoc,confnum)

  fhs:=Open(confStatFile,MODE_NEWFILE)
  IF fhs<>0
    getConfDbFileName(confnum,msgBaseNum,confDbFile)

    cb:=NEW cb

    fh:=Open(confDbFile,MODE_READWRITE)

    IF fh<>0
      n:=1
      StringF(tempstr,'Conference Name: \s',getConfName(confnum))
      fileWriteLn(fhs,tempstr)
      fileWriteLn(fhs,'==========================================')
      REPEAT
        stat:=Read(fh,cb,SIZEOF confBase)
        IF stat=SIZEOF confBase
          IF loadAccount(n,tempUser,NIL,NIL)=RESULT_SUCCESS
            StringF(tempstr,'Name            : \s',tempUser.name)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Location        : \s',tempUser.location)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Area Access     : \s',tempUser.conferenceAccess)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Ratio           : \d',cb.ratio)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'RatioType       : \d',cb.ratioType)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Files Uploaded  : \d',cb.upload)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Files Downloaded: \d',cb.downloads)
            fileWriteLn(fhs,tempstr)
            formatBCD(cb.uploadBytesBCD,tempstr2)
            StringF(tempstr,'Bytes Uploaded  : \s',tempstr2)
            fileWriteLn(fhs,tempstr)
            formatBCD(cb.downloadBytesBCD,tempstr2)
            StringF(tempstr,'Bytes Downloaded: \s',tempstr2)
            fileWriteLn(fhs,tempstr)
            StringF(tempstr,'Messages Posted : \d',cb.messagesPosted)
            fileWriteLn(fhs,tempstr)
            fileWriteLn(fhs,'------------------------------------------')
          ENDIF
        ENDIF
        n++
      UNTIL stat<>SIZEOF confBase
      Close(fh)
    ENDIF

    Close(fhs)
    END cb
  ENDIF
ENDPROC

PROC resizeConfDB(confnum,msgBaseNum,newSize)
  DEF confDbFile[255]:STRING
  DEF oldConfDbFile[255]:STRING
  DEF cb: PTR TO confBase
  DEF cb2: PTR TO confBase
  DEF fh1,fh2

  cb:= NEW cb
  cb2:= NEW cb2

  getConfDbFileName(confnum,msgBaseNum,confDbFile)

  StrCopy(oldConfDbFile,confDbFile)
  StrAdd(oldConfDbFile,'.old')

  DeleteFile(oldConfDbFile)

  Rename(confDbFile,oldConfDbFile)

  IF (fh1:=Open(confDbFile,MODE_NEWFILE))<>0
    IF (fh2:=Open(oldConfDbFile,MODE_OLDFILE))<>0
      WHILE newSize>0
        IF (Read(fh2,cb,SIZEOF confBase)=SIZEOF confBase)
          Write(fh1,cb,SIZEOF confBase)
        ELSE
          Write(fh1,cb2,SIZEOF confBase)
        ENDIF
        newSize--
      ENDWHILE

      Close(fh1)
      Close(fh2)
      DeleteFile(oldConfDbFile)
    ELSE
      Close(fh1)
      DeleteFile(confDbFile)

      ->put the old file back
      Rename(oldConfDbFile,confDbFile)
    ENDIF
  ELSE
    ->put the old file back
    Rename(oldConfDbFile,confDbFile)
  ENDIF
  END cb
  END cb2
ENDPROC

PROC makeFtpDirCache(confLoc:PTR TO CHAR, confnum, dirnum, dlpath:PTR TO CHAR, subdir:PTR TO CHAR)
  DEF dirCache[255]:STRING
  DEF fh
  DEF lock
  DEF f_info: PTR TO fileinfoblock
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF s,t
   
  f_info:=AllocDosObject(DOS_FIB,NIL)
  IF(f_info)=NIL
    RETURN
  ENDIF

  lock:=Lock(dlpath,ACCESS_READ)
  IF(lock)=0
    FreeDosObject(DOS_FIB,f_info)
    RETURN
  ENDIF

  IF(Examine(lock,f_info))=0
    UnLock(lock)
    FreeDosObject(DOS_FIB,f_info)
    RETURN
  ENDIF

  StringF(dirCache,'\sDirCaches/Conf\dDir\d\s\s',confLoc,confnum,dirnum,IF StrLen(subdir)>0 THEN '_' ELSE '',subdir)
  fh:=Open(dirCache,MODE_NEWFILE)
  IF fh<>0
    IF(f_info.direntrytype>0)
      WHILE(((ExNext(lock,f_info))<>0))
        IF (StrCmp('.dircache',f_info.filename)=FALSE)
          t:=dateStampToDateTime(f_info.datestamp)
          s:=f_info.size
          IF (f_info.direntrytype>0)
            StringF(tempstr,'\s\s/',dlpath,f_info.filename)
            StringF(tempstr2,'\s\s\s',subdir,IF StrLen(subdir)>0 THEN '_' ELSE '',f_info.filename)
            makeFtpDirCache(confLoc,confnum,dirnum,tempstr,tempstr2)
            s:=-1
          ENDIF
          StringF(tempstr,'\z\h[8] \z\h[8] \s\n',t,s,f_info.filename)
          WriteF(tempstr)
          Write(fh,tempstr,StrLen(tempstr))
        ENDIF
      ENDWHILE
    ENDIF
    Close(fh)
  ENDIF
  
  UnLock(lock)
  FreeDosObject(DOS_FIB,f_info)
  
ENDPROC

PROC conferenceMaintenance()
  DEF conf,flag=0,ch,size,n,f,m
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF confLoc[255]:STRING
  DEF confStr[10]:STRING
  DEF path[255]:STRING
  DEF path2[255]:STRING
  DEF dirCacheEnabled
  DEF lock,fh
  DEF num,num2,match
  DEF msgBase

  conf:=1
  msgBase:=1
  m:=findLastAccount()
  loadMsgPointers(conf,msgBase)
  getConfLocation(conf,confLoc)
  getMailStatFile(conf,msgBase)
  getConfDbFileName(conf,msgBase,tempstr)
  size:=Div(FileLength(tempstr),SIZEOF confBase)

  REPEAT
    conCursorOff()
    aePuts('[2;1H                      [33mCONFERENCE MAINTENANCE[0m')


    IF getConfMsgBaseCount(conf)>1
      getMsgBaseName(conf,msgBase,tempstr2)
      StringF(tempstr,'\s - \s',getConfName(conf),tempstr2)
      StringF(confStr,'\d.\d',conf,msgBase)
    ELSE
      getConfName(conf,tempstr)
      StringF(confStr,'\d',conf)
    ENDIF

    StringF(tempstr,'[4;1H [32mConference [34m[[0m\s[5][34m][36m:[0m \s[29]\b\n',confStr,tempstr)
    aePuts(tempstr)
    aePuts('[6;1H[0m THE FOLLOWING OPTIONS EFFECT ALL USERS FOR THIS CONFERENCE!\b\n')
    aePuts('[8;2H[33m1.>[32m Ratio[0m')
    aePuts('[9;2H[33m2.>[32m Ratio Type[0m')
    aePuts('[10;2H[33m3.>[32m Reset New Mail Scan Pointers[0m')
    aePuts('[11;2H[33m4.>[32m Reset Last Message Read Pointers[0m')
    aePuts('[12;2H[33m5.>[32m Dump all user stats to Conf.Stats[0m')
    aePuts('[13;2H[33m6.>[32m Set Default New Mail Scan[0m')
    aePuts('[14;2H[33m7.>[32m Set Default New File Scan[0m')
    aePuts('[15;2H[33m8.>[32m Set Default Zoom Flag[0m')
    
    
    aePuts('[8;40H[33m9.>[32m Reset Messages Posted[0m')
    aePuts('[9;40H[33mA.>[32m Reset Voting Booth[0m')
    StringF(tempstr,'[10;40H[33mB.>[32m Next   Msg # [0m\z\r\d[8]',mailStat.highMsgNum)
    aePuts(tempstr)
    StringF(tempstr,'[11;40H[33mC.>[32m Lowest Msg # [0m\z\r\d[8]',mailStat.lowestKey)
    aePuts(tempstr)
    StringF(tempstr,'[12;40H[33mD.>[32m Capacity [0m\d[4] [32mUsers',size)
    aePuts(tempstr)
    IF size>0
      f:=Mul(Mod(Mul(m,100),size),1000)
      n:=Div(Mul(m,100),size)
    ELSE
      f:=0
      n:=0
    ENDIF
    IF (n>100)
      StringF(tempstr,'[13;44H[31m\r>100% In use    ')
    ELSEIF (n<90)
      StringF(tempstr,'[13;44H[33m\r\d[2].\z\r\d[3]% In use ',n,f)
    ELSE
      StringF(tempstr,'[13;44H[31m\r\d.\z\r\d[3]% In use ',n,f)
    ENDIF
    aePuts(tempstr)
    
    StringF(tempstr,'\sDirCaches/enabled',confLoc)
    IF (dirCacheEnabled:=fileExists(tempstr))
      aePuts('[14;40H[33mE.>[32m Ram Dir Cache(s) [0mEnabled ')
      aePuts('[15;40H[33mF.>[32m Refresh Dir Cache(s)')
    ELSE
      aePuts('[14;40H[33mE.>[32m Ram Dir Cache(s) [0mDisabled')
      aePuts('[15;40H[33m                        ')
    ENDIF

    aePuts('[17;2H[33m<TAB>[36m to exit [33m-/+[36m=[0mPrev/Next Conference [0m')

    aePuts('[18;2H')
    conCursorOn()

    ch:=readChar(INPUT_TIMEOUT)
    IF(ch<0) THEN RETURN ch

    ch:=UpperChar(ch)

    SELECT ch
      CASE "1"
        aePuts('[0mRatio > ')
        n:=numberInputNoDefault()
        aePuts('[18;2H [0mWorking....')
        IF n>=0 THEN updateAllUsers(conf,msgBase,UPDATE_RATIO,n)
      CASE "2"
        aePuts('[0mRatio Type > ')
        n:=numberInputNoDefault()
        aePuts('[18;2H [0mWorking....')
        IF n>=0 THEN updateAllUsers(conf,msgBase,UPDATE_RATIO_TYPE,n)
      CASE "3"
        aePuts('[18;2H [0mWorking....')
        updateAllUsers(conf,msgBase,UPDATE_MAILSCAN_PTRS,-1)
      CASE "4"
        aePuts('[18;2H [0mWorking....')
        updateAllUsers(conf,msgBase,UPDATE_LAST_MESSAGE,-1)
      CASE "5"
        aePuts('[18;2H [0mWorking....')
        dumpUserStats(conf,msgBase)
      CASE "6"
        aePuts('[18;2H [0mDefault ON ')
        n:=yesNo(1)
        aePuts('[18;2H [0mWorking....')
        IF n
          updateAllUsers(conf,msgBase,UPDATE_NEW_MAIL_SCAN,TRUE)
        ELSE
          updateAllUsers(conf,msgBase,UPDATE_NEW_MAIL_SCAN,FALSE)
        ENDIF
      CASE "7"
        aePuts('[18;2H [0mDefault ON ')
        n:=yesNo(1)
        aePuts('[18;2H [0mWorking....')
        IF n
          updateAllUsers(conf,msgBase,UPDATE_NEW_FILE_SCAN,TRUE)
        ELSE
          updateAllUsers(conf,msgBase,UPDATE_NEW_FILE_SCAN,FALSE)
        ENDIF
      CASE "8"
        aePuts('[18;2H [0mDefault ON ')
        n:=yesNo(1)
        aePuts('[18;2H [0mWorking....')
        IF n
          updateAllUsers(conf,msgBase,UPDATE_DEFAULT_ZOOM_FLAG,TRUE)
        ELSE
          updateAllUsers(conf,msgBase,UPDATE_DEFAULT_ZOOM_FLAG,FALSE)
        ENDIF
      CASE "9"
        aePuts('[18;2H [0mWorking....')
        updateAllUsers(conf,msgBase,UPDATE_MESSAGES_POSTED,0)
      CASE "A"
        aePuts('[18;2H [0mWorking....')
        updateAllUsers(conf,msgBase,UPDATE_RESET_VOTING,-1)
      CASE "B"
        aePuts('[0mNext Message > ')
        n:=numberInputNoDefault()
        IF n>=0
          mailStat.highMsgNum:=n
          saveStatOnly()
        ENDIF
      CASE "C"
        aePuts('[0mLow Message  > ')
        n:=numberInputNoDefault()
        IF n>=0
          mailStat.lowestKey:=n
          saveStatOnly()
        ENDIF
      CASE "D"
        aePuts('[0mSize in records > ')
        n:=numberInputNoDefault()
        IF n>0
          aePuts('[18;2H[0mResizing, Please Standby')
          resizeConfDB(conf,msgBase,n)
          getConfDbFileName(conf,msgBase,tempstr)
          size:=Div(FileLength(tempstr),SIZEOF confBase)
        ENDIF
      CASE "E"
        IF dirCacheEnabled
          StringF(tempstr,'\sDirCaches/enabled',confLoc)
          DeleteFile(tempstr)
          StringF(tempstr,'DELETE RAM:DirCaches/Conf\dDir#?',conf)
          Execute(tempstr,0,0)
          StringF(tempstr,'DELETE \sDirCaches/Conf\dDir#?',confLoc,conf)
          Execute(tempstr,0,0)
        ELSE
          StringF(tempstr,'\sDirCaches',confLoc)
          IF(lock:=CreateDir(tempstr))
            UnLock(lock)
          ENDIF
          StringF(tempstr,'ram:DirCaches',confLoc)
          IF(lock:=CreateDir(tempstr))
            UnLock(lock)
          ENDIF
          StringF(tempstr,'\sDirCaches/enabled',confLoc)
          fh:=Open(tempstr,MODE_NEWFILE)
          IF fh THEN Close(fh)
        ENDIF
      CASE "F"
        StringF(tempstr,'DELETE RAM:DirCaches/Conf\dDir#?',conf)
        Execute(tempstr,0,0)
        StringF(tempstr,'DELETE \sDirCaches/Conf\dDir#?',confLoc,conf)
        Execute(tempstr,0,0)
        IF dirCacheEnabled
          aePuts('[18;2H[0mCreating, Please Standby')
          num:=1
          StringF(path,'DLPATH.\d',num++)
          WHILE(readToolType(TOOLTYPE_CONF,conf,path,path))
            checkPathSlash(path)
            num2:=1
            match:=FALSE
            StringF(path2,'ULPATH.\d',num2++)
            WHILE (match=FALSE) AND (readToolType(TOOLTYPE_CONF,conf,path2,path2))
              checkPathSlash(path2)
              IF StriCmp(path,path2) THEN match:=TRUE
              StringF(path2,'ULPATH.\d',num2++)
            ENDWHILE
          
            IF match=FALSE
            
              IF checkToolTypeExists(TOOLTYPE_CONF,conf,'FTP_NO_DIRLIST')
                makeFtpDirCache(confLoc,conf,num-1,path,'')
              ELSE
                StringF(tempstr,'LIST FILES LFORMAT %N "\s" >"\sDirCaches/Conf\dDir\d"',path,confLoc,conf,num-1)
                Execute(tempstr,0,0)
              ENDIF
              
              StringF(tempstr,'COPY "\sDirCaches/Conf\dDir\d#?" ram:DirCaches/',confLoc,conf,num-1)
              Execute(tempstr,0,0)
            ENDIF
            StringF(path,'DLPATH.\d',num++)
          ENDWHILE
        ENDIF
      CASE "\t"
        flag:=1
      CASE "-"
        msgBase:=msgBase-1
        IF msgBase<1
          conf:=conf-1
          IF conf<1 THEN conf:=cmds.numConf
          msgBase:=getConfMsgBaseCount(conf)
        ENDIF
        loadMsgPointers(conf,msgBase)
        getMailStatFile(conf,msgBase)
        getConfLocation(conf,confLoc)
        getConfDbFileName(conf,msgBase,tempstr)
        size:=Div(FileLength(tempstr),SIZEOF confBase)
      CASE "+"
        msgBase:=msgBase+1
        IF msgBase>getConfMsgBaseCount(conf)
          conf:=conf+1
          IF conf>cmds.numConf THEN conf:=1
          msgBase:=1
        ENDIF

        getMailStatFile(conf,msgBase)
        getConfLocation(conf,confLoc)
        getConfDbFileName(conf,msgBase,tempstr)
        size:=Div(FileLength(tempstr),SIZEOF confBase)
    ENDSELECT
    aePuts('[18;2H                                     ')

  UNTIL flag

ENDPROC

PROC findOpenAccount(hoozer:PTR TO user, hoozer2: PTR TO userKeys, hoozer3: PTR TO userMisc)
  DEF slot

  slot:=findFreeSlot()
  IF loadAccount(slot,hoozer,hoozer2,hoozer3)<>RESULT_SUCCESS
    initNewUser(hoozer,hoozer2,hoozer3,slot)
  ENDIF
ENDPROC

PROC displayAccount(who:LONG, page, hoozer:PTR TO user, hoozer2: PTR TO userKeys, hoozer3: PTR TO userMisc, f6:LONG)
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF temp
  DEF baud
  sendCLS()

  baud:=hoozer2.baud AND $ffff

  SELECT baud
    CASE 49664
      baud:=115200
    CASE 33792
      baud:=230400
    CASE 17920
      baud:=345600
    CASE 2048
      baud:=460800
    CASE 51712
      baud:=576000
    CASE 24576
      baud:=614400
    CASE 35840
    baud:=691200
    CASE 19968
      baud:=806400
    CASE 4096
      baud:=921600
  ENDSELECT

  IF(hoozer.slotNumber=who)
    StrCopy(tempStr2,'[33m  ACTIVE')
  ELSE
    StrCopy(tempStr2,'[37mINACTIVE')
  ENDIF
  StringF(tempStr,'[0;0H\s[0m [\d]   [32mBAUD[36m:[0m \d\b\n',tempStr2,who,baud)
  aePuts(tempStr)

  StringF(tempStr,'[2;1H[33mA> [32mName[36m:[0m \l\s[32] ',hoozer.name)
  aePuts(tempStr)

  IF page=0
    StringF(tempStr,'[2;42H[33mB> [32mReal Name[36m:[0m \l\s[25]',hoozer3.realName)
    aePuts(tempStr)
    StringF(tempStr,'[3;1H[33mC> [32mLoc.[36m:[0m \l\s[29]',hoozer.location)
    aePuts(tempStr)
    IF((logonType>=LOGON_TYPE_REMOTE) AND (f6=FALSE))
      IF(loggedOnUser.slotNumber=1)
        StringF(tempStr,'[3;42H[33mD> [32mPass ....[36m: [44mENCRYPTED[0m')
        aePuts(tempStr)
      ELSE
        aePuts('[3;42H[33mD> [32mPass ....[34m: [31mDISABLED[0m')
      ENDIF
    ELSE
      StringF(tempStr,'[3;42H[33mD> [32mPass ....[36m: [44mENCRYPTED[0m')
      aePuts(tempStr)
    ENDIF

    StringF(tempStr,'[4;1H[33mE> [32mPhone Number ..[36m:[0m \l\s[13]',hoozer.phoneNumber)
    aePuts(tempStr)

    StringF(tempStr,'[4;36H[33mF> [32mArea Name......[36m:[0m \l\s',hoozer.conferenceAccess)
    aePuts(tempStr)

    StringF(tempStr,'[5;1H[33mG> [32mRatio .........[36m:[0m \l\d[7]',hoozer.secLibrary)
    aePuts(tempStr)

    StringF(tempStr,'[5;36H[33mH> [32mSec_Level .....[36m:[0m \l\d[5]',hoozer.secStatus)
    aePuts(tempStr)

    StringF(tempStr,'[6;1H[33mI> [32mRatio Type ....[36m:[0m \l\d[5]',hoozer.secBoard)
    aePuts(tempStr)
    IF(hoozer.secBoard=0) THEN aePuts(' [32m<-[33mByte[32m)[0m')
    IF(hoozer.secBoard=1) THEN aePuts(' [32m<-[33mB/F[32m)[0m ')
    IF(hoozer.secBoard=2) THEN aePuts(' [32m<-[33mFile[32m)[0m')

    IF (getConfMsgBaseCount(hoozer.confRJoin)>1) AND (hoozer.msgBaseRJoin>0)
      StringF(tempStr2,'\d.\d',hoozer.confRJoin,hoozer.msgBaseRJoin)
    ELSE
      StringF(tempStr2,'\d',hoozer.confRJoin)
    ENDIF
    StringF(tempStr,'[6;36H[33mJ> [32mAutoReJoin ....[36m:[0m \l\s[7]',tempStr2)
    aePuts(tempStr)

    StringF(tempStr,'[7;1H[33mK> [32mUploads .......[36m:[0m \l\d[10]',hoozer.uploads AND $FFFF)
    aePuts(tempStr)

    StringF(tempStr,'[7;36H[33mL> [32mMessages Posted[36m:[0m \l\d[7]',hoozer.messagesPosted AND $FFFF)
    aePuts(tempStr)

    StringF(tempStr,'[8;1H[33mM> [32mDownloads .....[36m:[0m \l\d[10]\b\n',hoozer.downloads AND $FFFF)
    aePuts(tempStr)

    IF hoozer.newUser THEN StrCopy(tempStr2,'Yes') ELSE StrCopy(tempStr2,'No')
    StringF(tempStr,'[8;36H[33mN> [32mNew_User ......[36m:[0m \s[3] ',tempStr2)
    aePuts(tempStr)

    StringF(tempStr,'[6;63H[33m#[32mCalls[36m: [0m\l\d[6]',hoozer.timesCalled AND $FFFF)
    aePuts(tempStr)

    StringF(tempStr,'[7;63H[33m%[32mToday[36m: [0m\l\d[6]',getTodaysCalls(hoozer,hoozer2))
    aePuts(tempStr)

    formatBCD(hoozer3.uploadBytesBCD,tempStr2)

    IF sopt.toggles[TOGGLES_CREDITBYKB]
      StringF(tempStr,'[9;1H[33mO> [32mKBytes Uled ...[36m:[0m \l\s[14]',tempStr2)
    ELSE
      StringF(tempStr,'[9;1H[33mO> [32mBytes Uled ....[36m:[0m \l\s[14]',tempStr2)
    ENDIF
    aePuts(tempStr)

    formatLongDateTime(hoozer.timeLastOn,tempStr2)
    StringF(tempStr,'[9;39H[32mLast Called ...[36m:[0m \s',tempStr2)
    aePuts(tempStr)

    formatBCD(hoozer3.downloadBytesBCD,tempStr2)
    IF sopt.toggles[TOGGLES_CREDITBYKB]
      StringF(tempStr,'[10;1H[33mP> [32mKBytes Dled ...[36m:[0m \l\s[14]',tempStr2)
    ELSE
      StringF(tempStr,'[10;1H[33mP> [32mBytes Dled ....[36m:[0m \l\s[14]',tempStr2)
    ENDIF
    aePuts(tempStr)

    temp:=computerTypes.count()
    IF temp=0
      StringF(tempStr,'[10;39H[32mComputer Type .[36m:[0m ')
    ELSEIF hoozer.secBulletin>=temp
      StringF(tempStr,'[10;39H[32mComputer Type .[36m:[0m NOT VALID!',computerTypes.item(hoozer.secBulletin))
    ELSE
      StringF(tempStr,'[10;39H[32mComputer Type .[36m:[0m \l\s[16]',computerTypes.item(hoozer.secBulletin))
    ENDIF
    aePuts(tempStr)

    IF (hoozer.dailyBytesLimit<>0)
      formatUnsignedLong(hoozer.dailyBytesLimit,tempStr2)
    ELSE
      StrCopy(tempStr2,'Infinite')
    ENDIF
    IF sopt.toggles[TOGGLES_CREDITBYKB]
      StringF(tempStr,'[11;1H[33mQ> [32mKByte Limit ...[36m:[0m \l\s[10]',tempStr2)
    ELSE
      StringF(tempStr,'[11;1H[33mQ> [32mByte Limit ....[36m:[0m \l\s[10]',tempStr2)
    ENDIF
    aePuts(tempStr)

    temp:=screenTypeTitle.count()
    IF temp=0
      StringF(tempStr,'[11;39H[32mScreen Type  ..[36m:[0m ')
    ELSEIF hoozer.screenType>=temp
      StringF(tempStr,'[11;39H[32mScreen Type  ..[36m:[0m NOT VALID!')
    ELSE
      StringF(tempStr,'[11;39H[32mScreen Type  ..[36m:[0m \l\s',screenTypeTitle.item(hoozer.screenType))
    ENDIF
    aePuts(tempStr)

    StringF(tempStr,'[12;1H[33mR> [32mTime_Total[36m:[0m [36m[[0m\l\d[8][36m][0m mins    ',Div(hoozer.timeTotal,60))
    aePuts(tempStr)

    formatUnsignedLong(hoozer2.upCPS2,tempStr2)
    StringF(tempStr,'[12;36H[33mS> [32mCps UP[36m:[0m \l\s[10]',tempStr2)
    aePuts(tempStr)

    formatUnsignedLong(hoozer2.dnCPS2,tempStr2)
    StringF(tempStr,'[12;58H[33mT> [32mCps DN[36m:[0m \l\s[10]',tempStr2)
    aePuts(tempStr)

    StringF(tempStr,'[13;1H[33mU> [32mTime_Limit[36m:[0m [36m[[0m\l\d[8][36m][0m mins    ',Div(hoozer.timeLimit,60))
    aePuts(tempStr)
    StringF(tempStr,' [33mV> [32mTime_Used[36m:[0m [36m[[0m\l\d[8][36m][0m mins  [33mW> [32mUUCP[36m: [0m\d  ',Div(hoozer.timeUsed,60),hoozer.uucpa)
    aePuts(tempStr)

    StringF(tempStr,'[14;1H[33mY> [32mChat_Limit[36m:[0m [36m[[0m\l\d[8][36m][0m mins    ',Div(hoozer.chatLimit,60))
    aePuts(tempStr)
    StringF(tempStr,' [33mZ> [32mChat_Used[36m:[0m [36m[[0m\l\d[8][36m][0m mins    ',Div((hoozer.chatLimit-hoozer.chatRemain),60))
    aePuts(tempStr)

    aePuts('\b\n')
  ENDIF
  
  IF page=1
 
    IF hoozer3.forcePwdReset THEN StrCopy(tempStr2,'Yes') ELSE StrCopy(tempStr2,'No')                                              
    StringF(tempStr,'[3;1H[33mB> [32mForce Pwd Reset[36m:[0m \l\s[3]',tempStr2)
    aePuts(tempStr)

    IF hoozer3.accountLocked THEN StrCopy(tempStr2,'Yes') ELSE StrCopy(tempStr2,'No')
    StringF(tempStr,'[3;36H[33mC> [32mAccount Locked [36m:[0m \l\s',tempStr2)
    aePuts(tempStr)
    
    StringF(tempStr,'[4;1H[33mD> [32mInvalid Pwd Att[36m:[0m \l\d[3]',hoozer3.invalidAttempts)
    aePuts(tempStr)

    formatLongDateTime(hoozer3.pwdLastUpdated,tempStr2)
    StringF(tempStr,'[4;39H[32mLast Pwd Reset [36m:[0m \l\s',tempStr2)
    aePuts(tempStr)

    SELECT hoozer3.pwdType
      CASE PWD_LEGACY
        StrCopy(tempStr2,'LEGACY       ')
      CASE PWD_PBKDF2_5
        StrCopy(tempStr2,'PBKDF2(5)    ')
      CASE PWD_PBKDF2_50
        StrCopy(tempStr2,'PBKDF2(50)   ')
      CASE PWD_PBKDF2_100
        StrCopy(tempStr2,'PBKDF2(100)  ')
      CASE PWD_PBKDF2_1000
        StrCopy(tempStr2,'PBKDF2(1000) ')
      CASE PWD_PBKDF2_10000
        StrCopy(tempStr2,'PBKDF2(10000)')
    ENDSELECT
    
    StringF(tempStr,'[5;4H[32mPwd Type ......[36m:[0m \s',tempStr2)
    aePuts(tempStr)

    formatIP(hoozer3.lastIP,tempStr2)
    StringF(tempStr,'[5;39H[32mLast IP Addr ..[36m:[0m \s',tempStr2)
    aePuts(tempStr)

  ENDIF
  
  displayAccountActions(who)
ENDPROC

PROC displayAccountActions(who:LONG)
  DEF tempStr[200]:STRING
  DEF tempStr2[20]:STRING
  
  aePuts('[16;1H[33mX  [36m=[0mEXIT-NOSAVE [33m~[36m=[0mSAVE  [33m1-8[36m=[0mPRESETS  [33m9[36m=[0mRE-ACTIVATE  [33m<DEL>[36m=[0mDELETE  [33m*[36m=[0mUSER NOTES\b\n')
  StrCopy(tempStr,'[33m<TAB>[36m=[0mCONT [33m@[36m=[0mCONFERENCE ACCOUNTING [33m![36m=[0mCREDIT ACCOUNT MAINTENANCE ')
  IF findUserAnswers(who,tempStr2) THEN StrAdd(tempStr,'[33m?[36m=[0mUSER ANSWERS') ELSE StrAdd(tempStr,'              ')
  StrAdd(tempStr,'\b\n')
  aePuts(tempStr)
ENDPROC


PROC displayAccountInfo(who:LONG, page,hoozer:PTR TO user, hoozer2:PTR TO userKeys, hoozer3:PTR TO userMisc,f6:LONG)
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF baud,temp

  baud:=hoozer2.baud AND $ffff

  SELECT baud
    CASE 49664
      baud:=115200
    CASE 33792
      baud:=230400
    CASE 17920
      baud:=345600
    CASE 2048
      baud:=460800
    CASE 51712
      baud:=576000
    CASE 24576
      baud:=614400
    CASE 35840
    baud:=691200
    CASE 19968
      baud:=806400
    CASE 4096
      baud:=921600
  ENDSELECT

  IF(hoozer.slotNumber=who)
    StringF(tempStr,'[0;0H[33m  ACTIVE[0m [\d]   [32mBAUD[36m:[0m \d    \b\n',hoozer.slotNumber,baud)
    aePuts(tempStr)
  ELSE
    StringF(tempStr,'[0;0H[37mINACTIVE[0m [\d]   [32mBAUD[36m:[0m \d    \b\n',who,baud)
    aePuts(tempStr)
  ENDIF

  StringF(tempStr,'[2;10H\l\s[32]',hoozer.name)
  aePuts(tempStr)

  IF page=0
    StringF(tempStr,'[2;56H\l\s[25]',hoozer3.realName)
    aePuts(tempStr)
    StringF(tempStr,'[3;10H\l\s[29]',hoozer.location)
    aePuts(tempStr)

    IF((logonType>=LOGON_TYPE_REMOTE) AND (f6=FALSE))

      IF(loggedOnUser.slotNumber=1)
        StringF(tempStr,'[3;56H[36m[44mENCRYPTED[0m[K')
        aePuts(tempStr)
      ELSE
        aePuts('[3;56H[36m[44mDISABLED[0m[K\b\n')
      ENDIF
    ELSE
      StringF(tempStr,'[3;56H[36m[44mENCRYPTED[0m[K')
      aePuts(tempStr)
    ENDIF
    StringF(tempStr,'[4;21H\l\s[13]',hoozer.phoneNumber)
    aePuts(tempStr)

    StringF(tempStr,'[4;56H\l\s[10]',hoozer.conferenceAccess)
    aePuts(tempStr)

    StringF(tempStr,'[5;21H\l\d[7]',hoozer.secLibrary)
    aePuts(tempStr)

    StringF(tempStr,'[5;56H\l\d[5]',hoozer.secStatus)
    aePuts(tempStr)


    StringF(tempStr,'[6;21H\l\d[5]',hoozer.secBoard)
    aePuts(tempStr)
    IF(hoozer.secBoard=0) THEN aePuts(' [32m<-[33mByte[32m)[0m')
    IF(hoozer.secBoard=1) THEN aePuts(' [32m<-[33mB/F[32m)[0m ')
    IF(hoozer.secBoard=2) THEN aePuts(' [32m<-[33mFile[32m)[0m')


    IF (getConfMsgBaseCount(hoozer.confRJoin)>1) AND (hoozer.msgBaseRJoin>0)
      StringF(tempStr2,'\d.\d',hoozer.confRJoin,hoozer.msgBaseRJoin)
    ELSE
      StringF(tempStr2,'\d',hoozer.confRJoin)
    ENDIF

    StringF(tempStr,'[6;56H\l\s[7]',tempStr2)
    aePuts(tempStr)

    StringF(tempStr,'[7;21H\l\d[10]',hoozer.uploads AND $FFFF)
    aePuts(tempStr)

    StringF(tempStr,'[7;56H\l\d[7]',hoozer.messagesPosted AND $FFFF)
    aePuts(tempStr)

    StringF(tempStr,'[8;21H\l\d[10]',hoozer.downloads AND $FFFF)
    aePuts(tempStr)

    IF hoozer.newUser THEN StrCopy(tempStr2,'Yes') ELSE StrCopy(tempStr2,'No')
    StringF(tempStr,'[8;36H[33mN> [32mNew_User ......[36m:[0m \s[3] ',tempStr2)
    aePuts(tempStr)

    StringF(tempStr,'[6;63H[33m#[32mCalls[36m: [0m\l\d[6]',hoozer.timesCalled AND $FFFF)
    aePuts(tempStr)

    StringF(tempStr,'[7;63H[33m%[32mToday[36m: [0m\l\d[6]',getTodaysCalls(hoozer,hoozer2))
    aePuts(tempStr)

    formatBCD(hoozer3.uploadBytesBCD,tempStr2)
    StringF(tempStr,'[9;21H\l\s[14]',tempStr2)
    aePuts(tempStr)

    formatLongDateTime(hoozer.timeLastOn,tempStr2)
    StringF(tempStr,'[9;56H\s',tempStr2)
    aePuts(tempStr)

    formatBCD(hoozer3.downloadBytesBCD,tempStr2)
    StringF(tempStr,'[10;21H\l\s[14]',tempStr2)
    aePuts(tempStr)

    temp:=computerTypes.count()
    IF temp=0
      StringF(tempStr,'[10;56H')
    ELSEIF hoozer.secBulletin>=temp
      StringF(tempStr,'[10;56HNOT VALID!')
    ELSE
      StringF(tempStr,'[10;56H\l\s[16]',computerTypes.item(hoozer.secBulletin))
    ENDIF
    aePuts(tempStr)

    IF (hoozer.dailyBytesLimit<>0)
      formatUnsignedLong(hoozer.dailyBytesLimit,tempStr2)
    ELSE
      StrCopy(tempStr2,'Infinite')
    ENDIF
    StringF(tempStr,'[11;21H\l\s[10]',tempStr2)
    aePuts(tempStr)

    temp:=screenTypeTitle.count()
    IF temp=0
      StringF(tempStr,'[11;56H')
    ELSEIF (hoozer.screenType>=temp)
      StringF(tempStr,'[11;56HNOT VALID!')
    ELSE
      StringF(tempStr,'[11;56H\l\s[16]',screenTypeTitle.item(hoozer.screenType))
    ENDIF
    aePuts(tempStr)

    StringF(tempStr,'[12;17H\l\d[6]',Div(hoozer.timeTotal,60))
    aePuts(tempStr)

    formatUnsignedLong(hoozer2.upCPS2,tempStr2)
    StringF(tempStr,'[12;39H[32mCps UP[36m:[0m \l\s[10]',tempStr2)
    aePuts(tempStr)

    formatUnsignedLong(hoozer2.dnCPS2,tempStr2)
    StringF(tempStr,'[12;61H[32mCps DN[36m:[0m \l\s[10]',tempStr2)
    aePuts(tempStr)

    StringF(tempStr,'[13;17H\l\d[6]',Div(hoozer.timeLimit,60))
    aePuts(tempStr)
    StringF(tempStr,'[13;51H\l\d[6]',Div(hoozer.timeUsed,60))
    aePuts(tempStr)

    StringF(tempStr,'[13;76H\d',hoozer.uucpa)
    aePuts(tempStr)

    StringF(tempStr,'[14;17H\l\d[6]',Div(hoozer.chatLimit,60))
    aePuts(tempStr)
    StringF(tempStr,'[14;51H\l\d[6]',Div((hoozer.chatLimit-hoozer.chatRemain),60))
    aePuts(tempStr)
  ENDIF
  
  IF page=1
    IF hoozer3.forcePwdReset THEN StrCopy(tempStr2,'Yes') ELSE StrCopy(tempStr2,'No')
    StringF(tempStr,'[3;21H\l\s[3]',tempStr2)
    aePuts(tempStr)

    IF hoozer3.accountLocked THEN StrCopy(tempStr2,'Yes') ELSE StrCopy(tempStr2,'No')
    StringF(tempStr,'[3;56H\l\s[3]',tempStr2)
    aePuts(tempStr)
    
    StringF(tempStr,'[4;21H\l\d[3]',hoozer3.invalidAttempts)
    aePuts(tempStr)

    formatLongDateTime(hoozer3.pwdLastUpdated,tempStr2)
    StringF(tempStr,'[4;56H\l\s',tempStr2)
    aePuts(tempStr)

    SELECT hoozer3.pwdType
      CASE PWD_LEGACY
        StrCopy(tempStr2,'LEGACY       ')
      CASE PWD_PBKDF2_5
        StrCopy(tempStr2,'PBKDF2(5)    ')
      CASE PWD_PBKDF2_50
        StrCopy(tempStr2,'PBKDF2(50)   ')
      CASE PWD_PBKDF2_100
        StrCopy(tempStr2,'PBKDF2(100)  ')
      CASE PWD_PBKDF2_1000
        StrCopy(tempStr2,'PBKDF2(1000) ')
      CASE PWD_PBKDF2_10000
        StrCopy(tempStr2,'PBKDF2(10000)')
    ENDSELECT
    
    StringF(tempStr,'[5;21H\s',tempStr2)
    aePuts(tempStr)

    formatIP(hoozer3.lastIP,tempStr2)
    StringF(tempStr,'[5;56H\l\s',tempStr2)
    aePuts(tempStr)

  ENDIF
  displayAccountActions(who)
ENDPROC

PROC bulkAccountEditor()
  DEF flag,command
  DEF settings[18]:ARRAY OF LONG
  DEF areaName[255]:STRING
  DEF secLevel[3]:STRING
  DEF i,v,v2,r,p
  DEF tempstr[255]:STRING

  sendCLS()
  conCursorOff()

  displayBulkScreen()

  FOR i:=0 TO 17
    settings[i]:=String(15)
  ENDFOR
  StrCopy(areaName,'')
  StrCopy(secLevel,'')

  REPEAT
    flag:=0
    displayBulkSettings(settings,areaName,secLevel)
    conCursorOn()
    command:=readChar(INPUT_TIMEOUT)
    IF(command<0) THEN RETURN command
    command:=UpperChar(command)

    SELECT command
      CASE "@"
        IF bulkPresets()=RESULT_ABORT
          flag:=1
        ELSE
          sendCLS()
          conCursorOff()

          displayBulkScreen()
        ENDIF
      CASE "F"
        aePuts('[6;21H               [6;21H')
        lineInput('',settings[13],15,INPUT_TIMEOUT,settings[13])
      CASE "G"
        aePuts('[6;59H               [6;59H')
        lineInput('',settings[0],15,INPUT_TIMEOUT,settings[0])
        v,r:=Val(settings[0])
        IF r=0 THEN StrCopy(settings[0],'') ELSE StringF(settings[0],'\d',v)
      CASE "H"
        aePuts('[7;21H               [7;21H')
        lineInput('',settings[14],3,INPUT_TIMEOUT,settings[14])
        v,r:=Val(settings[14])
        IF r=0 THEN StrCopy(settings[14],'') ELSE StringF(settings[14],'\d',v)
      CASE "I"
        aePuts('[7;59H               [7;59H')
        lineInput('',settings[1],15,INPUT_TIMEOUT,settings[1])
        v,r:=Val(settings[1])
        IF (r=0) OR (v<0) OR (v>2) THEN StrCopy(settings[1],'') ELSE StringF(settings[1],'\d',v)
      CASE "J"
        aePuts('[8;21H               [8;21H')
        lineInput('',settings[2],15,INPUT_TIMEOUT,settings[2])
        v,r:=Val(settings[2])
        IF (r=0) OR (v<1) OR (v>cmds.numConf)
          StrCopy(settings[2],'')
        ELSE
          IF (p:=InStr(settings[2],'.'))>=0
            v2,r:=Val(p+1+settings[2])
            StringF(settings[2],'\d.\d',v,v2)
          ELSE
            StringF(settings[2],'\d',v)
          ENDIF
        ENDIF
      CASE "K"
        aePuts('[9;21H               [9;21H')
        lineInput('',settings[3],15,INPUT_TIMEOUT,settings[3])
        v,r:=Val(settings[3])
        IF r=0 THEN StrCopy(settings[3],'') ELSE StringF(settings[3],'\d',v)
      CASE "L"
        aePuts('[9;59H               [9;59H')
        lineInput('',settings[4],15,INPUT_TIMEOUT,settings[4])
        v,r:=Val(settings[4])
        IF r=0 THEN StrCopy(settings[4],'') ELSE StringF(settings[4],'\d',v)
      CASE "M"
        aePuts('[10;21H               [10;21H')
        lineInput('',settings[5],15,INPUT_TIMEOUT,settings[5])
        v,r:=Val(settings[5])
        IF r=0 THEN StrCopy(settings[5],'') ELSE StringF(settings[5],'\d',v)
      CASE "O"
        aePuts('[11;21H               [11;21H')
        lineInput('',settings[6],15,INPUT_TIMEOUT,settings[6])
        v,r:=Val(settings[6])
        IF r=0 THEN StrCopy(settings[6],'') ELSE StringF(settings[6],'\d',v)
      CASE "P"
        aePuts('[11;59H               [11;59H')
        lineInput('',settings[7],15,INPUT_TIMEOUT,settings[7])
        v,r:=Val(settings[7])
        IF r=0 THEN StrCopy(settings[7],'') ELSE StringF(settings[7],'\d',v)
      CASE "Q"
        aePuts('[12;21H               [12;21H')
        lineInput('',settings[8],15,INPUT_TIMEOUT,settings[8])
        v,r:=Val(settings[8])
        IF r=0 THEN StrCopy(settings[8],'') ELSE StringF(settings[8],'\d',v)
      CASE "R"
        aePuts('[13;21H               [13;21H')
        lineInput('',settings[9],15,INPUT_TIMEOUT,settings[9])
        v,r:=Val(settings[9])
        IF r=0 THEN StrCopy(settings[9],'') ELSE StringF(settings[9],'\d',v)
      CASE "U"
        aePuts('[13;59H               [13;59H')
        lineInput('',settings[10],15,INPUT_TIMEOUT,settings[10])
        v,r:=Val(settings[10])
        IF r=0 THEN StrCopy(settings[10],'') ELSE StringF(settings[10],'\d',v)
      CASE "Y"
        aePuts('[14;21H               [14;21H')
        lineInput('',settings[11],15,INPUT_TIMEOUT,settings[11])
        v,r:=Val(settings[11])
        IF r=0 THEN StrCopy(settings[11],'') ELSE StringF(settings[11],'\d',v)
      CASE "#"
        aePuts('[15;21H               [15;21H')
        lineInput('',settings[12],15,INPUT_TIMEOUT,settings[12])
        v,r:=Val(settings[12])
        IF r=0 THEN StrCopy(settings[12],'') ELSE StringF(settings[12],'\d',v)
      CASE "*"
        IF StrLen(settings[15])=0
         StrCopy(settings[15],'1')
        ELSEIF StrCmp(settings[15],'1')
         StrCopy(settings[15],'0')
        ELSE
         StrCopy(settings[15],'')
        ENDIF
      CASE "!"
        IF StrLen(settings[16])=0
         StrCopy(settings[16],'1')
        ELSEIF StrCmp(settings[16],'1')
         StrCopy(settings[16],'0')
        ELSE
         StrCopy(settings[16],'')
        ENDIF
      CASE "&"
        IF StrLen(settings[17])=0
         StrCopy(settings[17],'1')
        ELSEIF StrCmp(settings[17],'1')
         StrCopy(settings[17],'0')
        ELSE
         StrCopy(settings[17],'')
        ENDIF
      CASE "1" /* select area Name */
        aePuts('[20;26H          [20;26H')
        lineInput('',areaName,10,INPUT_TIMEOUT,areaName)
      CASE "2" /* select access Level */
        aePuts('[20;64H   [20;64H')
        lineInput('',secLevel,3,INPUT_TIMEOUT,secLevel)
        v,r:=Val(secLevel)
        IF r=0 THEN StrCopy(secLevel,'')
      CASE "3" /* select access Level */
        includeDeact:=Not(includeDeact)
      CASE "~"
        aePuts('[0mUpdating users...')
        v:=applyBulkChanges(settings,areaName,secLevel)
        IF (logonType>=LOGON_TYPE_REMOTE)
          StringF(tempstr,'\tREMOTE Bulk User Update, Area=\s, SecLevel=\s, RecordsAffected=\d',areaName,secLevel,v)
        ELSE
          StringF(tempstr,'\tLOCAL  Bulk User Update, Area=\s, SecLevel=\s RecordsAffected=\d',areaName,secLevel,v)
        ENDIF
        callersLog(tempstr)
        aePuts('[24;1H                                     ')
      CASE "\t"
        flag:=1
    ENDSELECT
    conCursorOff()
  UNTIL flag
ENDPROC

PROC displayBulkScreen()
  aePuts('[2;1H                     [33mBULK ACCOUNT MAINTENANCE[0m')

  aePuts('[4;1H Updates to apply:')

  aePuts('[6;1H[33mF> [32mArea Name .....[36m:')
  aePuts('[6;39H[33mG> [32mRatio .........[36m:')
  aePuts('[7;1H[33mH> [32mSec_Level .....[36m:')
  aePuts('[7;39H[33mI> [32mRatio Type ....[36m:')
  aePuts('[8;1H[33mJ> [32mAutoRejoin ....[36m:')
  aePuts('[9;1H[33mK> [32mUploads .......[36m:')
  aePuts('[9;39H[33mL> [32mMessages Posted[36m:')
  aePuts('[10;1H[33mM> [32mDownloads .....[36m:')

  IF sopt.toggles[TOGGLES_CREDITBYKB]
    aePuts('[11;1H[33mO> [32mKBytes Uled ...[36m:')
  ELSE
    aePuts('[11;1H[33mO> [32mBytes Uled ....[36m:')
  ENDIF

  IF sopt.toggles[TOGGLES_CREDITBYKB]
    aePuts('[11;39H[33mP> [32mKBytes Dled ...[36m:')
  ELSE
    aePuts('[11;39H[33mP> [32mBytes Dled ....[36m:')
  ENDIF

  IF sopt.toggles[TOGGLES_CREDITBYKB]
    aePuts('[12;1H[33mQ> [32mKByte Limit ...[36m:')
  ELSE
    aePuts('[12;1H[33mQ> [32mByte Limit ....[36m:')
  ENDIF

  aePuts('[13;1H[33mR> [32mTime Total ....[36m:')
  aePuts('[13;39H[33mU> [32mTime Limit ....[36m:')
  aePuts('[15;39H[33m*> [32mActive ........[36m:')

  aePuts('[14;1H[33mY> [32mChat Limit ....[36m:')
  aePuts('[15;1H[33m#> [32mTimes Called ..[36m:')

  aePuts('[16;1H[33m!> [32mForce Pwd Reset[36m:')
  aePuts('[16;39H[33m&> [32mAccnt Locked ..[36m:')

  aePuts('[18;2H[0mFilter Settings:')

  aePuts('[20;1H[33m1> [32mSelect Area Name [36m:')
  aePuts('[20;39H[33m2> [32mSelect Sec Level [36m:')
  aePuts('[21;1H[33m3> [32mInclude deactivated [36m:')
  aePuts('[23;1H[33m~[36m=[0mApply Changes [33m@[36m=[0mPresets [33m<TAB>[36m=[0mExit\b\n')
ENDPROC

PROC displayBulkSettings(settings:PTR TO LONG, areaName:PTR TO CHAR, secLevel:PTR TO CHAR)
  DEF tempStr[255]:STRING
  DEF i,tot,v

  StringF(tempStr,'[6;58H[0m \s',IF StrLen(settings[0])=0 THEN 'Leave Unchanged' ELSE settings[0])
  aePuts(tempStr)

  IF StrLen(settings[1])=0
    StringF(tempStr,'[7;58H[0m Leave Unchanged')
  ELSE
    v:=Val(settings[1])
    IF(v=0) THEN StringF(tempStr,'[7;58H[0m \d [32m<-[33mByte[32m)[0m',v)
    IF(v=1) THEN StringF(tempStr,'[7;58H[0m \d [32m<-[33mB/F[32m)[0m',v)
    IF(v=2) THEN StringF(tempStr,'[7;58H[0m \d [32m<-[33mFile[32m)[0m',v)
  ENDIF
  aePuts(tempStr)

  StringF(tempStr,'[8;20H[0m \s',IF StrLen(settings[2])=0 THEN 'Leave Unchanged' ELSE settings[2])
  aePuts(tempStr)
  StringF(tempStr,'[9;20H[0m \s',IF StrLen(settings[3])=0 THEN 'Leave Unchanged' ELSE settings[3])
  aePuts(tempStr)
  StringF(tempStr,'[9;58H[0m \s',IF StrLen(settings[4])=0 THEN 'Leave Unchanged' ELSE settings[4])
  aePuts(tempStr)
  StringF(tempStr,'[10;20H[0m \s',IF StrLen(settings[5])=0 THEN 'Leave Unchanged' ELSE settings[5])
  aePuts(tempStr)
  StringF(tempStr,'[11;20H[0m \s',IF StrLen(settings[6])=0 THEN 'Leave Unchanged' ELSE settings[6])
  aePuts(tempStr)
  StringF(tempStr,'[11;58H[0m \s',IF StrLen(settings[7])=0 THEN 'Leave Unchanged' ELSE settings[7])
  aePuts(tempStr)
  StringF(tempStr,'[12;20H[0m \s',IF StrLen(settings[8])=0 THEN 'Leave Unchanged' ELSE settings[8])
  aePuts(tempStr)
  StringF(tempStr,'[13;20H[0m \s',IF StrLen(settings[9])=0 THEN 'Leave Unchanged' ELSE settings[9])
  aePuts(tempStr)
  StringF(tempStr,'[13;58H[0m \s',IF StrLen(settings[10])=0 THEN 'Leave Unchanged' ELSE settings[10])
  aePuts(tempStr)
  StringF(tempStr,'[14;20H[0m \s',IF StrLen(settings[11])=0 THEN 'Leave Unchanged' ELSE settings[11])
  aePuts(tempStr)
  StringF(tempStr,'[15;20H[0m \s',IF StrLen(settings[12])=0 THEN 'Leave Unchanged' ELSE settings[12])
  aePuts(tempStr)
  StringF(tempStr,'[6;20H[0m \s',IF StrLen(settings[13])=0 THEN 'Leave Unchanged' ELSE settings[13])
  aePuts(tempStr)
  StringF(tempStr,'[7;20H[0m \s',IF StrLen(settings[14])=0 THEN 'Leave Unchanged' ELSE settings[14])
  aePuts(tempStr)
  StringF(tempStr,'[15;58H[0m \s',IF StrLen(settings[15])=0 THEN 'Leave Unchanged' ELSE IF Val(settings[15])=0 THEN 'Deactivate     ' ELSE 'Activate       ')
  aePuts(tempStr)

  StringF(tempStr,'[16;20H[0m \s',IF StrLen(settings[16])=0 THEN 'Leave Unchanged' ELSE IF Val(settings[16])=1 THEN 'Yes            ' ELSE 'No             ')
  aePuts(tempStr)
  StringF(tempStr,'[16;58H[0m \s',IF StrLen(settings[17])=0 THEN 'Leave Unchanged' ELSE IF Val(settings[17])=1 THEN 'Yes            ' ELSE 'No             ')
  aePuts(tempStr)

  i,tot:=calcAffected(areaName,secLevel)

  StringF(tempStr,'[18;19H[34m[[0m\d/\d[34m][0m Users will be updated.     ',i,tot)
  aePuts(tempStr)

  StringF(tempStr,'[20;26H\s',IF StrLen(areaName)=0 THEN 'N/A' ELSE areaName)
  aePuts(tempStr)

  StringF(tempStr,'[20;64H\s',IF StrLen(secLevel)=0 THEN 'N/A' ELSE secLevel)
  aePuts(tempStr)

  StringF(tempStr,'[21;26H\s',IF includeDeact THEN 'Yes' ELSE 'No ')
  aePuts(tempStr)

  aePuts('[24;1H')
ENDPROC

PROC applyBulkChanges(settings:PTR TO LONG,areaName:PTR TO CHAR,secLevel:PTR TO CHAR)
  DEF fh,fh2,fh3,v,p
  DEF stat,stat2,stat3,match
  DEF sn=1
  DEF extraBytes

  IF((fh:=Open(userDataFile,MODE_OLDFILE)))=0 THEN RETURN RESULT_FAILURE

  IF((fh2:=Open(userMiscFile,MODE_OLDFILE)))=0
    Close(fh)
    RETURN RESULT_FAILURE
  ENDIF

  IF((fh3:=Open(userKeysFile,MODE_OLDFILE)))=0
    Close(fh)
    Close(fh2)
    RETURN RESULT_FAILURE
  ENDIF

  REPEAT
    stat:=Read(fh,tempUser,SIZEOF user)
    IF stat<>0
      IF(stat<>SIZEOF user)
        Close(fh)
        Close(fh2)
        Close(fh3)
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF

    stat2:=Read(fh2,tempUserMisc,SIZEOF userMisc)
    IF stat2<>0
      IF(stat2<>SIZEOF userMisc)
        Close(fh)
        Close(fh2)
        Close(fh3)
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF

    stat3:=Read(fh3,tempUserKeys,SIZEOF userKeys)
    IF stat3<>0
      IF(stat3<>SIZEOF userKeys)
        Close(fh)
        Close(fh2)
        Close(fh3)
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF

    IF ((stat<>0) AND (stat2<>0) AND (stat3<>0))

      match:=FALSE
      IF StrLen(areaName)>0
        IF StriCmp(tempUser.conferenceAccess,areaName) THEN match:=TRUE
      ENDIF

      IF StrLen(secLevel)>0
        v:=Val(secLevel)
        IF v=tempUser.secStatus THEN match:=TRUE
      ENDIF

      IF (StrLen(areaName)=0) AND (StrLen(secLevel)=0) THEN match:=TRUE

      IF ((includeDeact=FALSE) AND (tempUserKeys.number=0)) THEN match:=FALSE

      IF match
        IF StrLen(settings[0])>0 THEN tempUser.secLibrary:=Val(settings[0])
        IF StrLen(settings[1])>0 THEN tempUser.secBoard:=Val(settings[1])
        IF StrLen(settings[2])>0 
          IF (p:=InStr(settings[2],'.'))>=0
            tempUser.confRJoin:=Val(settings[2])
            tempUser.msgBaseRJoin:=Val(p+1+settings[2])
          ELSE
            tempUser.confRJoin:=Val(settings[2])
            tempUser.msgBaseRJoin:=0
          ENDIF
        ENDIF
        IF StrLen(settings[3])>0 THEN tempUser.uploads:=Val(settings[3])
        IF StrLen(settings[4])>0 THEN tempUser.messagesPosted:=Val(settings[4])
        IF StrLen(settings[5])>0 THEN tempUser.downloads:=Val(settings[5])
        IF StrLen(settings[6])>0
          bcdVal(settings[6],tempUserMisc.uploadBytesBCD)
          tempUser.bytesUpload:=convertFromBCD(tempUserMisc.uploadBytesBCD)
        ENDIF
        IF StrLen(settings[7])>0
          bcdVal(settings[7],tempUserMisc.downloadBytesBCD)
          tempUser.bytesDownload:=convertFromBCD(tempUserMisc.downloadBytesBCD)
        ENDIF

        IF StrLen(settings[8])>0
          IF tempUser.todaysBytesLimit<>0
            extraBytes:=tempUser.todaysBytesLimit-tempUser.dailyBytesLimit
          ELSE
            extraBytes:=0
          ENDIF
          tempUser.dailyBytesLimit:=Val(settings[8])
          tempUser.todaysBytesLimit:=tempUser.dailyBytesLimit
          IF tempUser.todaysBytesLimit<>0 THEN tempUser.todaysBytesLimit:=tempUser.todaysBytesLimit+extraBytes
        ENDIF
        IF StrLen(settings[9])>0 THEN tempUser.timeTotal:=Mul(Val(settings[9]),60)
        IF StrLen(settings[10])>0 THEN tempUser.timeLimit:=Mul(Val(settings[10]),60)
        IF StrLen(settings[11])>0 THEN tempUser.chatLimit:=Mul(Val(settings[11]),60)
        IF StrLen(settings[12])>0 THEN tempUser.timesCalled:=Val(settings[12])
        IF StrLen(settings[13])>0 THEN AstrCopy(tempUser.conferenceAccess,settings[13],10)
        IF StrLen(settings[14])>0 THEN tempUser.secStatus:=Val(settings[14])
        IF StrLen(settings[15])>0 
          IF Val(settings[15])=0 THEN tempUser.slotNumber:=0 ELSE tempUser.slotNumber:=sn
          tempUserKeys.number:=tempUser.slotNumber
        ENDIF
        IF StrLen(settings[16])>0 
          IF Val(settings[16])=0 THEN tempUserMisc.forcePwdReset:=FALSE ELSE tempUserMisc.forcePwdReset:=TRUE
        ENDIF

        IF StrLen(settings[17])>0 
          IF Val(settings[17])=0 THEN tempUserMisc.accountLocked:=FALSE ELSE tempUserMisc.accountLocked:=TRUE
        ENDIF

        Seek(fh,-SIZEOF user,OFFSET_CURRENT)
        Write(fh,tempUser,SIZEOF user)

        Seek(fh2,-SIZEOF userMisc,OFFSET_CURRENT)
        Write(fh2,tempUserMisc,SIZEOF userMisc)

        Seek(fh3,-SIZEOF userKeys,OFFSET_CURRENT)
        Write(fh3,tempUserKeys,SIZEOF userKeys)
      ENDIF
    ENDIF
    sn++
  UNTIL (stat2=0) OR (stat=0) OR (stat3=0)

  Close(fh)
  Close(fh2)
ENDPROC

PROC bulkPresets()
  DEF flag,command
  DEF preset:LONG,allConf:LONG
  DEF areaName[255]:STRING
  DEF secLevel[3]:STRING
  DEF v,r
  DEF tempstr[255]:STRING

  sendCLS()
  conCursorOff()

  displayBulkPresetScreen()

  preset:=-1
  allConf:=0
  StrCopy(areaName,'')
  StrCopy(secLevel,'')

  REPEAT
    flag:=0
    displayBulkPresetSettings(preset,allConf,areaName,secLevel)
    conCursorOn()
    command:=readChar(INPUT_TIMEOUT)
    IF(command<0) THEN RETURN command
    command:=UpperChar(command)

    SELECT command
      CASE "1"
        IF checkToolTypeExists(TOOLTYPE_PRESET,1,'PRESET.AREA')
          IF preset=1 THEN preset:=-1 ELSE preset:=1
        ENDIF
      CASE "2"
        IF checkToolTypeExists(TOOLTYPE_PRESET,2,'PRESET.AREA')
          IF preset=2 THEN preset:=-1 ELSE preset:=2
        ENDIF
      CASE "3"
        IF checkToolTypeExists(TOOLTYPE_PRESET,3,'PRESET.AREA')
          IF preset=3 THEN preset:=-1 ELSE preset:=3
        ENDIF
      CASE "4"
        IF checkToolTypeExists(TOOLTYPE_PRESET,4,'PRESET.AREA')
          IF preset=4 THEN preset:=-1 ELSE preset:=4
        ENDIF
      CASE "5"
        IF checkToolTypeExists(TOOLTYPE_PRESET,5,'PRESET.AREA')
          IF preset=5 THEN preset:=-1 ELSE preset:=5
        ENDIF
      CASE "6"
        IF checkToolTypeExists(TOOLTYPE_PRESET,6,'PRESET.AREA')
          IF preset=6 THEN preset:=-1 ELSE preset:=6
        ENDIF
      CASE "7"
        IF checkToolTypeExists(TOOLTYPE_PRESET,7,'PRESET.AREA')
          IF preset=7 THEN preset:=-1 ELSE preset:=7
        ENDIF
      CASE "8"
        IF checkToolTypeExists(TOOLTYPE_PRESET,8,'PRESET.AREA')
          IF preset=8 THEN preset:=-1 ELSE preset:=8
        ENDIF
      CASE "9"
        allConf:=Not(allConf)
      CASE "A" /* select area Name */
        aePuts('[19;26H          [19;26H')
        lineInput('',areaName,10,INPUT_TIMEOUT,areaName)
      CASE "B" /* select access Level */
        aePuts('[20;26H   [20;26H')
        lineInput('',secLevel,3,INPUT_TIMEOUT,secLevel)
        v,r:=Val(secLevel)
        IF r=0 THEN StrCopy(secLevel,'')
      CASE "C"
        includeDeact:=Not(includeDeact)
      CASE "@"
        flag:=2
      CASE "~"
        IF preset<>-1
          aePuts('[0mUpdating users...')
          v:=applyBulkPresetChanges(preset,allConf,areaName,secLevel)
          IF (logonType>=LOGON_TYPE_REMOTE)
            StringF(tempstr,'\tREMOTE Bulk Preset Apply, Area=\s, SecLevel=\s, Preset=\d, AllConfs=\s, RecordsAffected=\d',areaName,secLevel,preset,IF allConf THEN 'Yes' ELSE 'No',v)
          ELSE
            StringF(tempstr,'\tLOCAL  Bulk Preset Apply, Area=\s, SecLevel=\s, Preset=\d, AllConfs=\s, RecordsAffected=\d',areaName,secLevel,preset,IF allConf THEN 'Yes' ELSE 'No',v)
          ENDIF
          callersLog(tempstr)
          aePuts('[24;1H                                     ')
        ENDIF
      CASE "\t"
        flag:=1
    ENDSELECT
    conCursorOff()
  UNTIL flag
  
  IF flag=1 THEN RETURN RESULT_ABORT
ENDPROC RESULT_SUCCESS

PROC displayBulkPresetScreen()
  aePuts('[2;1H                     [33mBULK ACCOUNT MAINTENANCE[0m')

  aePuts('[4;1H Preset to apply:')

  IF checkToolTypeExists(TOOLTYPE_PRESET,1,'PRESET.AREA') THEN aePuts('[6;1H[33m1> [32mApply Preset 1...[36m:')
  IF checkToolTypeExists(TOOLTYPE_PRESET,2,'PRESET.AREA') THEN aePuts('[7;1H[33m2> [32mApply Preset 2...[36m:')
  IF checkToolTypeExists(TOOLTYPE_PRESET,3,'PRESET.AREA') THEN aePuts('[8;1H[33m3> [32mApply Preset 3...[36m:')
  IF checkToolTypeExists(TOOLTYPE_PRESET,4,'PRESET.AREA') THEN aePuts('[9;1H[33m4> [32mApply Preset 4...[36m:')
  IF checkToolTypeExists(TOOLTYPE_PRESET,5,'PRESET.AREA') THEN aePuts('[10;1H[33m5> [32mApply Preset 5...[36m:')
  IF checkToolTypeExists(TOOLTYPE_PRESET,6,'PRESET.AREA') THEN aePuts('[11;1H[33m6> [32mApply Preset 6...[36m:')
  IF checkToolTypeExists(TOOLTYPE_PRESET,7,'PRESET.AREA') THEN aePuts('[12;1H[33m7> [32mApply Preset 7...[36m:')
  IF checkToolTypeExists(TOOLTYPE_PRESET,8,'PRESET.AREA') THEN aePuts('[13;1H[33m8> [32mApply Preset 8...[36m:')

  aePuts('[15;1H[33m9> [32mApply All Conf Ratio Presets...[36m:')

  aePuts('[17;2H[0mFilter Settings:')

  aePuts('[19;1H[33mA> [32mSelect Area Name [36m:')
  aePuts('[20;1H[33mB> [32mSelect Sec Level [36m:')
  aePuts('[21;1H[33mC> [32mInclude deactivated [36m:')
  aePuts('[23;1H[33m~[36m=[0mApply Changes [33m@[36m=[0mUpdates [33m<TAB>[36m=[0mExit\b\n')
ENDPROC

PROC displayBulkPresetSettings(preset:LONG, allConfs:LONG, areaName:PTR TO CHAR, secLevel:PTR TO CHAR)
  DEF tempStr[255]:STRING
  DEF i,tot

  IF checkToolTypeExists(TOOLTYPE_PRESET,1,'PRESET.AREA')
    StringF(tempStr,'[6;22H[0m \s',IF preset=1 THEN 'Yes' ELSE 'No ')
    aePuts(tempStr)
  ENDIF
  IF checkToolTypeExists(TOOLTYPE_PRESET,2,'PRESET.AREA')
    StringF(tempStr,'[7;22H[0m \s',IF preset=2 THEN 'Yes' ELSE 'No ')
    aePuts(tempStr)
  ENDIF
  IF checkToolTypeExists(TOOLTYPE_PRESET,3,'PRESET.AREA')
    StringF(tempStr,'[8;22H[0m \s',IF preset=3 THEN 'Yes' ELSE 'No ')
    aePuts(tempStr)
  ENDIF
  IF checkToolTypeExists(TOOLTYPE_PRESET,4,'PRESET.AREA')
    StringF(tempStr,'[9;22H[0m \s',IF preset=4 THEN 'Yes' ELSE 'No ')
    aePuts(tempStr)
  ENDIF
  IF checkToolTypeExists(TOOLTYPE_PRESET,5,'PRESET.AREA')
    StringF(tempStr,'[10;22H[0m \s',IF preset=5 THEN 'Yes' ELSE 'No ')
    aePuts(tempStr)
  ENDIF
  IF checkToolTypeExists(TOOLTYPE_PRESET,6,'PRESET.AREA')
    StringF(tempStr,'[11;22H[0m \s',IF preset=6 THEN 'Yes' ELSE 'No ')
    aePuts(tempStr)
  ENDIF
  IF checkToolTypeExists(TOOLTYPE_PRESET,7,'PRESET.AREA')
    StringF(tempStr,'[12;22H[0m \s',IF preset=7 THEN 'Yes' ELSE 'No ')
    aePuts(tempStr)
  ENDIF
  IF checkToolTypeExists(TOOLTYPE_PRESET,8,'PRESET.AREA')
    StringF(tempStr,'[13;22H[0m \s',IF preset=8 THEN 'Yes' ELSE 'No ')
    aePuts(tempStr)
  ENDIF

  StringF(tempStr,'[15;36H[0m \s',IF allConfs THEN 'Yes' ELSE 'No ')
  aePuts(tempStr)

  i,tot:=calcAffected(areaName,secLevel)

  StringF(tempStr,'[17;19H[34m[[0m\d/\d[34m][0m Users will be updated.     ',i,tot)
  aePuts(tempStr)

  StringF(tempStr,'[19;26H\s',IF StrLen(areaName)=0 THEN 'N/A' ELSE areaName)
  aePuts(tempStr)

  StringF(tempStr,'[20;26H\s',IF StrLen(secLevel)=0 THEN 'N/A' ELSE secLevel)
  aePuts(tempStr)

  StringF(tempStr,'[21;26H\s',IF includeDeact THEN 'Yes' ELSE 'No ')
  aePuts(tempStr)

  aePuts('[24;1H')
ENDPROC

PROC applyBulkPresetChanges(preset:LONG,allConf:LONG,areaName:PTR TO CHAR,secLevel:PTR TO CHAR)
  DEF fh,fh2,fh3,v
  DEF stat,stat2,stat3,match
  DEF tempStr[255]:STRING

  IF((fh:=Open(userDataFile,MODE_OLDFILE)))=0 THEN RETURN RESULT_FAILURE

  IF((fh2:=Open(userMiscFile,MODE_OLDFILE)))=0
    Close(fh)
    RETURN RESULT_FAILURE
  ENDIF

  IF((fh3:=Open(userKeysFile,MODE_OLDFILE)))=0
    Close(fh)
    Close(fh2)
    RETURN RESULT_FAILURE
  ENDIF

  REPEAT
    stat:=Read(fh,tempUser,SIZEOF user)
    IF stat<>0
      IF(stat<>SIZEOF user)
        Close(fh)
        Close(fh2)
        Close(fh3)
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF

    stat2:=Read(fh2,tempUserMisc,SIZEOF userMisc)
    IF stat2<>0
      IF(stat2<>SIZEOF userMisc)
        Close(fh)
        Close(fh2)
        Close(fh3)
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF

    stat3:=Read(fh3,tempUserKeys,SIZEOF userKeys)
    IF stat3<>0
      IF(stat3<>SIZEOF userKeys)
        Close(fh)
        Close(fh2)
        Close(fh3)
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF

    IF ((stat<>0) AND (stat2<>0) AND (stat3<>0))

      match:=FALSE
      IF StrLen(areaName)>0
        IF StriCmp(tempUser.conferenceAccess,areaName) THEN match:=TRUE
      ENDIF

      IF StrLen(secLevel)>0
        v:=Val(secLevel)
        IF v=tempUser.secStatus THEN match:=TRUE
      ENDIF

      IF (StrLen(areaName)=0) AND (StrLen(secLevel)=0) THEN match:=TRUE

      IF ((includeDeact=FALSE) AND (tempUserKeys.number=0)) THEN match:=FALSE

      IF match
        IF readToolType(TOOLTYPE_PRESET,preset,'PRESET.AREA',tempStr)
          AstrCopy(tempUser.conferenceAccess,tempStr,10)

          tempUser.newUser:=0
          applyPreset(tempUser,TOOLTYPE_PRESET,preset)
          tempUser.timeTotal:=tempUser.timeLimit
          IF allConf THEN applyConfPresets(tempUser,preset)
        ENDIF

        Seek(fh,-SIZEOF user,OFFSET_CURRENT)
        Write(fh,tempUser,SIZEOF user)

        Seek(fh2,-SIZEOF userMisc,OFFSET_CURRENT)
        Write(fh2,tempUserMisc,SIZEOF userMisc)
      ENDIF
    ENDIF
  UNTIL (stat2=0) OR (stat=0) OR (stat3=0)

  Close(fh)
  Close(fh2)
  Close(fh3)
ENDPROC

PROC calcAffected(areaName:PTR TO CHAR, secLevel:PTR TO CHAR)
  DEF fh,fh2,tot=0,all=0,v
  DEF stat,stat2, match

  IF((fh:=Open(userDataFile,MODE_OLDFILE)))=0 THEN RETURN RESULT_FAILURE

  IF((fh2:=Open(userKeysFile,MODE_OLDFILE)))=0
    Close(fh)
    RETURN RESULT_FAILURE
  ENDIF

  REPEAT
    stat:=Read(fh,tempUser,SIZEOF user)
    IF stat<>0
      IF(stat<>SIZEOF user)
        Close(fh)
        Close(fh2)
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF

    stat2:=Read(fh2,tempUserKeys,SIZEOF userKeys)
    IF stat2<>0
      IF(stat2<>SIZEOF userKeys)
        Close(fh)
        Close(fh2)
        RETURN RESULT_FAILURE
      ENDIF
    ENDIF

    IF (stat<>0) AND (stat2<>0)
      all++
      match:=FALSE
      IF StrLen(areaName)>0
        IF StriCmp(tempUser.conferenceAccess,areaName) THEN match:=TRUE
      ENDIF

      IF StrLen(secLevel)>0
        v:=Val(secLevel)
        IF v=tempUser.secStatus THEN match:=TRUE
      ENDIF

      IF (StrLen(areaName)=0) AND (StrLen(secLevel)=0) THEN match:=TRUE
      
      IF ((includeDeact=FALSE) AND (tempUserKeys.number=0)) THEN match:=FALSE

      IF match THEN tot++
    ENDIF
  UNTIL (stat<>SIZEOF user) OR (stat2<>SIZEOF userKeys)

  Close(fh)
  Close(fh2)
ENDPROC tot,all

PROC fileStatus(opt)
  DEF i,s,n
  DEF tmp[200]:STRING
  DEF bytesup[15]:STRING
  DEF bytesdown[15]:STRING
  DEF bytesavail[15]:STRING
  DEF ca=FALSE

  IF(opt=FALSE) THEN s:=cmds.numConf ELSE s:=currentConf

  IF(checkSecurity(ACS_CONFERENCE_ACCOUNTING)) THEN ca:=TRUE

  aePuts('\b\n')
  aePuts('[32m              Uploads                 Downloads\b\n')
  aePuts('\b\n')
  IF sopt.toggles[TOGGLES_CREDITBYKB]
    aePuts('[32m    Conf  Files    KBytes         Files    KBytes         KBytes Avail Ratio\b\n')
  ELSE
    aePuts('[32m    Conf  Files    Bytes          Files    Bytes          Bytes Avail  Ratio\b\n')
  ENDIF
    aePuts('[0m    ----  -------  -------------- -------  -------------- -----------  -----\b\n')
  saveMsgPointers(currentConf,currentMsgBase)

  FOR i:=1 TO s
    IF (opt=FALSE) OR (i=currentConf)
      IF i=(currentConf) THEN n:=3 ELSE n:=6
      IF checkConfAccess(i)
        IF (ca=TRUE) OR (i=currentConf)
          IF (ca) THEN loadMsgPointers(i,1)
          formatBCD(loggedOnUserMisc.uploadBytesBCD,bytesup)
          formatBCD(loggedOnUserMisc.downloadBytesBCD,bytesdown)
          IF (loggedOnUser.todaysBytesLimit<>0)
            formatUnsignedLong((loggedOnUser.todaysBytesLimit-loggedOnUser.dailyBytesDld),bytesavail)
          ELSE
            StrCopy(bytesavail,'Infinite')
          ENDIF

          IF(loggedOnUser.secLibrary)
            StringF(tmp,'[33m    \r\d[4][0m> [3\dm\d[7]  \r\s[14] \r\d[7]  \r\s[14]   \r\s[9]   \d[0m:[3\dm1\b\n', relConf(i), n,loggedOnUser.uploads AND $FFFF,bytesup,loggedOnUser.downloads AND $FFFF,bytesdown,bytesavail,loggedOnUser.secLibrary,n)
          ELSE
            StringF(tmp,'[33m    \r\d[4][0m> [3\dm\d[7]  \r\s[14] \r\d[7]  \r\s[14]   \r\s[9]  [31mDSBLD\b\n', relConf(i), n,loggedOnUser.uploads AND $FFFF,bytesup,loggedOnUser.downloads AND $FFFF,bytesdown,bytesavail)
          ENDIF
          aePuts(tmp)
        ENDIF
      ENDIF
    ENDIF
  ENDFOR
  aePuts('[0m\b\n')
  loadMsgPointers(currentConf,currentMsgBase)
ENDPROC

PROC sysopPaged()
  DEF tempstring[255]:STRING
  DEF tempstring2[255]:STRING

  runExecuteOn('SYSOP_PAGE')
  IF(checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_SYSOP_PAGE')) AND (StrLen(mailOptions.sysopEmail)>0)
    StringF(tempstring,'\s: Ami-Express page notification',cmds.bbsName)
    StringF(tempstring2,'This is a notification that you were paged by \s.',loggedOnUser.name)
    sendMail(tempstring,tempstring2,FALSE,NIL,0,mailOptions.sysopEmail)
  ENDIF
ENDPROC

PROC who(opt)
  DEF fileName[100]:STRING
  DEF mes[100]:STRING
  DEF mes2[100]:STRING
  DEF mes1[100]:STRING
  DEF name[100]:STRING
  DEF location[100]:STRING
  DEF chatstr[10]:STRING

  DEF s:PTR TO singlePort
  DEF singles[MAXNODES]:ARRAY OF LONG
  DEF status,i,olmBlocked

  aePuts('\b\n')
  aePuts('\b\n')
  aePuts('[34m.---+---------------------+---------------------+---------------------+----.[0m\b\n')



  aePuts('[34m|[33mNd#[34m|[36m Name/Handle         [34m|[36m Location   [34m         |[36m Action              [34m|[36mChat[0m[34m|[0m\b\n')
  aePuts('[34m)---+---------------------+---------------------+---------------------+----([0m\b\n')

  ObtainSemaphore(masterNode)
  FOR i:=0 TO MAXNODES-1
    singles[i]:=(masterNode.myNode[i].s)
  ENDFOR
  ReleaseSemaphore(masterNode)
  FOR i:=0 TO MAXNODES-1
    s:=singles[i]
    ObtainSemaphore(s)

    status:=s.status
    StrCopy(name,s.handle)
    StrCopy(location,s.location)
    StrCopy(fileName,s.misc1)
    IF(opt)
      StringF(mes, '[34m| [0m\l\d[20] [32m|[0m \l\d[25] [32m|[0m',s,masterNode)
      StringF(mes1,' \l\d[20] [32m|[0m',s.semi.nestcount)
      StringF(mes2,'[34m| [0m\d ',i)
      aePuts(mes2)
      aePuts(mes)
      aePuts(mes1)
      aePuts('\b\n')
      aePuts('[34m|---+---------------------+---------------------+---------------------+----|[0m\b\n')

      ReleaseSemaphore(s)
      JUMP whonext
    ENDIF
    olmBlocked:=s.misc2[0]
    ReleaseSemaphore(s)

    IF olmBlocked THEN StrCopy(chatstr,'[31mNO') ELSE StrCopy(chatstr,'[32mYES')

    SELECT status
      CASE ENV_IDLE
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','IDLE',chatstr)
      CASE ENV_DOWNLOADING
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        IF checkSecurity(ACS_HIDE_FILES)
          StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','DOWNLOADING',chatstr)
        ELSEIF(StrLen(fileName)>0)
          StringF(mes1,' DL: \l\s[16] [34m|[0m',fileName,chatstr)
        ELSE
          StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','BEGINNING DL',chatstr)
        ENDIF
      CASE ENV_UPLOADING
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        IF checkSecurity(ACS_HIDE_FILES)
          StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','UPLOADING',chatstr)
        ELSEIF(StrLen(fileName)>0)
          StringF(mes1,' UL: \l\s[16] [34m|[0m',fileName,chatstr)
        ELSE
          StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','BEGINNING UL',chatstr)
        ENDIF
      CASE ENV_DOORS
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        IF(i=node)
          StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','WHO',chatstr)
        ELSEIF(StrLen(fileName)>0)
          StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m',fileName,chatstr)
        ELSE
          StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','MODULE',chatstr)
        ENDIF
      CASE ENV_MAIL
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','READING MAIL',chatstr)
      CASE ENV_STATS
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','REVIEWING STATS',chatstr)
      CASE ENV_ACCOUNT
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','ACCOUNT EDITING',chatstr)
      CASE ENV_ZOOM
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','ZOOMING',chatstr)
      CASE ENV_FILES
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','VIEWING DIRS',chatstr)
      CASE ENV_BULLETINS
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','READING BULLS',chatstr)
      CASE ENV_VIEWING
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','VIEWING FILES',chatstr)
      CASE ENV_ACCOUNTSEQ
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','')
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','ACCOUNT SEQUENCE',chatstr)
      CASE ENV_LOGOFF
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','LOGGING OFF',chatstr)
      CASE ENV_SYSOP
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','SYSOPING',chatstr)
      CASE ENV_SHELL
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','USING SHELL',chatstr)
      CASE ENV_EMACS
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','EDITING',chatstr)
      CASE ENV_JOIN
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','JOINING CONF',chatstr)
      CASE ENV_CHAT
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','CHATTING',chatstr)
      CASE ENV_NOTACTIVE
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','')
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','NODE INACTIVE.',chatstr)
      CASE ENV_REQ_CHAT
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','REQUESTING CHAT',chatstr)
      CASE ENV_CONNECT
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','CONNECTING',chatstr)
      CASE ENV_LOGGINGON
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','LOGGING ON',chatstr)
      CASE ENV_AWAITCONNECT
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','')
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','AWAITING CONNECT',chatstr)
      CASE ENV_SCANNING
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','SCANNING MAIL',chatstr)
      CASE ENV_SHUTDOWN
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','')
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','SHUTDOWN',chatstr)
      CASE ENV_MULTICHAT
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','MULTICHAT',chatstr)
      CASE ENV_SUSPEND
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','')
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','SUSPENDED',chatstr)
      CASE ENV_RESERVE
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','')
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','RESERVED',chatstr)
      CASE ENV_ONLINEMSG
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m',name,location)
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','ONLINE MESSAGE',chatstr)
      CASE -1
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','')
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','UNAVAILABLE',chatstr)
      DEFAULT
        StringF(mes, '[34m| [33m\l\s[19] [34m|[35m \l\s[19] [34m|[0m','','')
        StringF(mes1,' \l\s[19] [34m|\l\s[9][34m|[0m','',chatstr)
    ENDSELECT
    StringF(mes2,'[34m| [0m\z\r\d[2]',i)
    IF((((status<>27) AND (status<>24) AND (status<>18)) OR checkSecurity(ACS_SYSOP_COMMANDS)) AND (status>=0))
      aePuts(mes2)
      aePuts(mes)
      aePuts(mes1)
      aePuts('\b\n')
      IF cmds.acLvl[LVL_LONGWHO] THEN aePuts('[34m|---+---------------------+---------------------+---------------------+----|[0m\b\n')
    ENDIF

whonext:
  ENDFOR
  IF cmds.acLvl[LVL_LONGWHO]=FALSE THEN aePuts('[34m|---+---------------------+---------------------+---------------------+----|[0m\b\n')
  aePuts('[34m`--------------------------------------------------------------------------''[0m\b\n')
  aePuts('\b\n')
ENDPROC

PROC sendOlmPacket(nodenum,msg:PTR TO CHAR,last)
  DEF np: PTR TO mp
  DEF olmMsg:PTR TO jhMessage
  DEF nodeserverport[15]:STRING

  StringF(nodeserverport,'AEServer.\d',nodenum)
  IF (np:=FindPort(nodeserverport))=NIL THEN RETURN RESULT_FAILURE

  IF(olmMsg:=AllocMem(256,MEMF_ANY OR MEMF_CLEAR))
    olmMsg.command:=SV_INCOMING_MSG
    olmMsg.nodeID:=node
    olmMsg.msg.length:=256
    olmMsg.msg.replyport:=0

    olmMsg.data:=0
    olmMsg.lineNum:=last
    AstrCopy(olmMsg.string,msg,200)

    PutMsg(np,olmMsg)
  ELSE
    aePuts('Insufficient Memory\b\n')
    RETURN RESULT_FAILURE
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandGreets()
  aePuts('\b\nIn memory of those who came before us...\b\n\b\n')

  aePuts('[34m[[0mscoopex[34m][0m [34m[[0mlsd[34m][0m [34m[[0mskid row[34m][0m [34m[[0malpha flight[34m][0m [34m[[0mtrsi[34m][0m [34m[[0mbamiga sector one[34m][0m\b\n\b\n')
  aePuts('[34m[[0mfairlight[34m][0m [34m[[0mdefjam[34m][0m [34m[[0mparadox[34m][0m [34m[[0mlegend[34m][0m [34m[[0manthrox[34m][0m [34m[[0mcrystal[34m][0m [34m[[0mangels[34m][0m\b\n\b\n')
  aePuts('[34m[[0mvision factory[34m][0m [34m[[0mzenith[34m][0m [34m[[0mslipstream[34m][0m [34m[[0mdual crew[34m][0m [34m[[0mdelight[34m][0m [34m[[0mshining[34m][0m\b\n\b\n')
  aePuts('[34m[[0mquartex[34m][0m [34m[[0mglobal overdose[34m][0m [34m[[0mparanoimia[34m][0m [34m[[0msupplex[34m][0m [34m[[0mclassic[34m][0m [34m[[0mhoodlum[34m][0m\b\n\b\n')
  aePuts('[34m[[0maccumulators[34m][0m [34m[[0mhellfire[34m][0m [34m[[0moracle[34m][0m [34m[[0mendless piracy[34m][0m [34m[[0mhqc[34m][0m [34m[[0msetrox[34m][0m\b\n\b\n')
  aePuts('[34m[[0mprodigy[34m][0m [34m[[0mprestige[34m][0m [34m[[0mnemesis[34m][0m [34m[[0mgenesis[34m][0m [34m[[0mloonies[34m][0m [34m[[0mhorizon[34m][0m [34m[[0magile[34m][0m\b\n\b\n')
  aePuts('[34m[[0mcrack inc[34m][0m [34m[[0mvalhalla[34m][0m [34m[[0msunflex inc[34m][0m [34m[[0mministry[34m][0m [34m[[0mthe band[34m][0m [34m[[0mrazor1911[34m][0m\b\n\b\n')
  aePuts('[34m[[0mconqueror and zike[34m][0m [34m[[0mmad[34m][0m [34m[[0mthe company[34m][0m\b\n\b\n')
ENDPROC

PROC internalCommand0()
  DEF status
  DEF string[32]:STRING
  DEF str[255]:STRING

  IF (checkSecurity(ACS_REMOTE_SHELL)=FALSE)
    RETURN RESULT_NOT_ALLOWED
  ENDIF
  setEnvStat(ENV_SHELL)

  IF(StrLen(cmds.remotePass)>0)
    status:=getPass2('\b\nEnter Remote Shell Password: ',cmds.remotePass,0,30,string)
    IF(status<0) THEN RETURN RESULT_SLEEP_LOGOFF
    IF(status<>RESULT_SUCCESS)
      aePuts('\b\n')
      aePuts('Remote password failed\b\n\b\n')
      StringF(str,'\tRemote password (\s) failed.\n',string)
      callersLog(str)
      RETURN RESULT_FAILURE
    ENDIF

    IF(logonType>=LOGON_TYPE_REMOTE)
      status:=checkCarrier()
      IF(status=FALSE) THEN RETURN RESULT_SLEEP_LOGOFF
    ENDIF
  ENDIF
  remoteShell()
ENDPROC RESULT_SUCCESS

PROC internalCommand1()
  IF (checkSecurity(ACS_ACCOUNT_EDITING)=FALSE)
    RETURN RESULT_NOT_ALLOWED
  ENDIF
  callersLog('\tAccount editing.\n')
  editAccounts(FALSE)
ENDPROC RESULT_SUCCESS

PROC internalCommand2(params)
  DEF temp[255]:STRING
  DEF n,loop,fh,stat
  IF (checkSecurity(ACS_LIST_NODES)=FALSE)
    RETURN RESULT_NOT_ALLOWED
  ENDIF

  setEnvStat(ENV_SYSOP)
  aePuts('\b\n')

  parseParams(params)

  IF parsedParams.count()>0
    n:=Val(parsedParams.item(0))
    StringF(temp,'\sNode\d/Callerslog',cmds.bbsLoc,n)
    displayCallersLog(temp,paramsContains('NS'))
  ELSE
    loop:=0
    REPEAT
      StringF(temp,'\sNode\d/Callerslog',cmds.bbsLoc,loop)
      IF(fh:=Open(temp,MODE_OLDFILE))<>0
        Close(fh)
        StringF(temp,'\d - Callerslog for Node \d\b\n',loop,loop)
        aePuts(temp)
        loop++
      ENDIF
    UNTIL fh=NIL

    aePuts('\b\nWhich node to view? ')
    stat:=lineInput('','',5,INPUT_TIMEOUT,temp)
    IF (stat<0) OR (StrLen(temp)=0)
      aePuts('\b\n')
      RETURN
    ENDIF

    n:=Val(temp)

    StringF(temp,'\sNode\d/Callerslog',cmds.bbsLoc,n)
    IF(fh:=Open(temp,MODE_OLDFILE))<>0
      Close(fh)
      StringF(temp,'\d - Callerslog for Node \d\b\n',n,n)
      aePuts(temp)
      StringF(temp,'\sNode\d/Callerslog',cmds.bbsLoc,n)
      displayCallersLog(temp,FALSE)
    ELSE
      aePuts('\b\nNot a valid node!\b\n')
    ENDIF
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommand3(params)
  setEnvStat(ENV_EMACS)
  IF(checkSecurity(ACS_EDIT_DIRS)=FALSE) THEN RETURN RESULT_NOT_ALLOWED
  editDirFile(params)
ENDPROC

PROC internalCommand4(params)
  setEnvStat(ENV_EMACS)
  IF(checkSecurity(ACS_EDIT_FILES)=FALSE) THEN RETURN RESULT_NOT_ALLOWED
  editAnyFile(params)
ENDPROC RESULT_SUCCESS

PROC internalCommand5(params)
  setEnvStat(ENV_SYSOP)
  IF(checkSecurity(ACS_SYSOP_COMMANDS)=FALSE) THEN RETURN RESULT_NOT_ALLOWED
  myDirAnyWhere(params)
ENDPROC RESULT_SUCCESS

PROC internalCommandLT()
  DEF newConf
  IF checkSecurity(ACS_JOIN_CONFERENCE)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  saveMsgPointers(currentConf,currentMsgBase)

  setEnvStat(ENV_JOIN)
  newConf:=currentConf-1
  WHILE (newConf>0) AND (checkConfAccess(newConf)=FALSE)
    newConf--
  ENDWHILE

  IF newConf<1
    internalCommandJ('')
  ELSE
    joinConf(newConf,1,FALSE,FALSE)
  ENDIF

ENDPROC RESULT_SUCCESS

PROC internalCommandGT()
  DEF newConf
  IF checkSecurity(ACS_JOIN_CONFERENCE)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  saveMsgPointers(currentConf,currentMsgBase)

  setEnvStat(ENV_JOIN)
  newConf:=currentConf+1
  WHILE (newConf<=cmds.numConf) AND (checkConfAccess(newConf)=FALSE)
    newConf++
  ENDWHILE

  IF newConf>cmds.numConf
    internalCommandJ('')
  ELSE
    joinConf(newConf,1,FALSE,FALSE)
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandLT2()
  DEF newMsgBase
  saveMsgPointers(currentConf,currentMsgBase)

  setEnvStat(ENV_JOIN)
  newMsgBase:=currentMsgBase-1

  IF newMsgBase<1
    internalCommandJM('')
  ELSE
    joinConf(currentConf,newMsgBase,FALSE,FALSE)
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandGT2()
  DEF newMsgBase
  saveMsgPointers(currentConf,currentMsgBase)

  setEnvStat(ENV_JOIN)
  newMsgBase:=currentMsgBase+1

  IF newMsgBase>getConfMsgBaseCount(currentConf)
    internalCommandJM('')
  ELSE
    joinConf(currentConf,newMsgBase,FALSE,FALSE)
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandQuestionMark()
  IF (loggedOnUser.expert="X")
    checkScreenClear()
    displayScreen(SCREEN_MENU)
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandA(params)
  IF checkSecurity(ACS_DOWNLOAD)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_FILES)
  alterFlags(params)
ENDPROC  RESULT_SUCCESS

PROC internalCommandB(params)
  DEF stat,stat2
  DEF str[81]:STRING
  DEF screenFilename[255]:STRING
  DEF fh

  IF checkSecurity(ACS_READ_BULLETINS)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_BULLETINS)

  StrCopy(str,confScreenDir)
  StrAdd(str,'Bulletins/BullHelp.txt')
  IF((fh:=Open(str,MODE_OLDFILE)))=0
    myError(ERR_NO_BULLS)
    RETURN RESULT_SUCCESS
  ENDIF
  Close(fh)

  parseParams(params)
  IF parsedParams.count()>0
    stat:=Val(parsedParams.item(0))
    nonStopDisplayFlag:=paramsContains('NS')
  ELSE
helpAgain:
    StrCopy(str,confScreenDir)
    StrAdd(str,'Bulletins/BullHelp')
    IF (findSecurityScreen(str,screenFilename)) THEN displayFile(screenFilename)
inputAgain:
    StringF(str,'Which Bulletin (?)=List, (Enter)=none? ')
    aePuts(str)
    stat2:=lineInput('','',8,INPUT_TIMEOUT,str)
    IF(stat2<0) THEN RETURN stat2
    IF(StrLen(str)=0)
      aePuts('\b\n')
      RETURN RESULT_SUCCESS
    ENDIF
    IF(StrCmp(str,'?')) THEN JUMP helpAgain
    parseParams(str)
    nonStopDisplayFlag:=paramsContains('NS')
    stat:=Val(parsedParams.item(0))
  ENDIF

  StringF(str,'\sBulletins/Bull\d',confScreenDir,stat)
  IF findSecurityScreen(str,screenFilename)
    displayFile(screenFilename)
  ELSE
    StringF(str,'\b\nSorry there is no bulletin #\d\b\n\b\n',stat)
    aePuts(str)
  ENDIF
  JUMP inputAgain
ENDPROC RESULT_SUCCESS

PROC internalCommandC(params)
  DEF res
  IF checkSecurity(ACS_COMMENT_TO_SYSOP)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_MAIL)
  parseParams(params)
  mciViewSafe:=FALSE
  IF checkToolTypeExists(TOOLTYPE_CONF,currentConf,'CUSTOM')=FALSE
    res:=commentToSYSOP()
  ELSE
    customMsgbaseCmd(MAIL_SYSOP_COMMENT,currentConf,1)
  ENDIF
  mciViewSafe:=TRUE
ENDPROC res

PROC internalCommandCF()
  DEF i,m,loop=TRUE,editmask
  DEF confNums[255]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF confStr[10]:STRING
  DEF c1,c2,c3,c4
  DEF cb: PTR TO confBase
  DEF ch
  DEF stat
  DEF p:PTR TO CHAR
  DEF v
  DEF n,cnt

  IF checkSecurity(ACS_CONFFLAGS)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  REPEAT
    sendCLS()
    aePuts('\b\n')
      aePuts('[32m        M A F Z Conference                      M A F Z Conference[0m\b\n')
      aePuts('[33m        ~ ~ ~ ~ ~~~~~~~~~~~~~~~~~~~~~~~         ~ ~ ~ ~ ~~~~~~~~~~~~~~~~~~~~~~~[0m\b\n\b\n')
    n:=0

    FOR i:=1 TO cmds.numConf
      IF checkConfAccess(i)
        FOR m:=1 TO getConfMsgBaseCount(i)
          cb:=confBases.item(getConfIndex(i,m))

          IF((checkToolTypeExists(TOOLTYPE_CONF,i,'FORCE_NEWSCAN')))
            c1:="F"
          ELSEIF (checkToolTypeExists(TOOLTYPE_CONF,i,'NO_NEWSCAN'))
            c1:="D"
          ELSEIF (cb.handle[0] AND MAIL_SCAN_MASK)
            c1:="*"
          ELSE
            c1:=" "
          ENDIF

          IF((checkToolTypeExists(TOOLTYPE_CONF,i,'SHOW_NEW_FILES')))
            c2:="F"
          ELSEIF (checkToolTypeExists(TOOLTYPE_CONF,i,'NO_NEW_FILES'))
            c2:="D"
          ELSEIF(cb.handle[0] AND FILE_SCAN_MASK)
            c2:="*"
          ELSE
            c2:=" "
          ENDIF

          IF(cb.handle[0] AND MAILSCAN_ALL)
            c4:="*"
          ELSE
            c4:=" "
          ENDIF

          IF (cb.handle[0] AND ZOOM_SCAN_MASK) THEN c3:="*" ELSE c3:=" "

          IF getConfMsgBaseCount(i)>1
            getMsgBaseName(i,m,tempstr)
            StringF(tempstr2,'\s - \s',getConfName(i),tempstr)
            StringF(confStr,'\d.\d',relConf(i),m)
            StringF(tempstr,'[34m[[0m\r\s[5][34m] [36m\c \c \c \c [0m\l\s[23]',confStr,c1,c4, c2,c3,tempstr2)
          ELSE
            getConfName(i,tempstr2)
            StringF(tempstr,'[34m[[0m\r\d[5][34m] [36m\c \c \c \c [0m\l\s[23]',relConf(i),c1,c4, c2,c3,tempstr2)
          ENDIF
          
          aePuts(tempstr)
          IF n AND 1
            aePuts('\b\n')
          ELSE
            aePuts(' ')
          ENDIF
          n++
        ENDFOR
      ENDIF
    ENDFOR

    aePuts('\b\n\b\nEdit which flags [M]ailScan, [A]ll Messages, [F]ileScan, [Z]oom >: ')
    ch:=readChar(INPUT_TIMEOUT)
    IF (ch="m") OR (ch="M")  
      editmask:=MAIL_SCAN_MASK
    ELSEIF (ch="f") OR (ch="F" )
      editmask:=FILE_SCAN_MASK
    ELSEIF (ch="z") OR (ch="Z")
      editmask:=ZOOM_SCAN_MASK
    ELSEIF (ch="a") OR (ch="A")
      editmask:=MAILSCAN_ALL
    ELSE
      editmask:=-1
      loop:=FALSE
    ENDIF
    StrCopy(tempstr,' ')
    tempstr[0]:=ch
    aePuts(tempstr)
    aePuts('\b\n')

    IF (editmask<>-1)
      aePuts('Enter Conference Numbers,''*'' toggle all,''-'' All off,''+'' All on >: ')
      stat:=lineInput('','',200,INPUT_TIMEOUT,confNums)
      IF stat<>RESULT_SUCCESS THEN RETURN stat

      IF StrLen(confNums)=0 THEN RETURN RESULT_SUCCESS

      IF StrCmp(confNums,'+')
        FOR i:=1 TO cmds.numConf
          IF checkConfAccess(i)
            FOR m:=1 TO getConfMsgBaseCount(i)
              cb:=confBases.item(getConfIndex(i,m))
              cb.handle[0]:=cb.handle[0] OR editmask
            ENDFOR
          ENDIF
        ENDFOR
      ELSEIF StrCmp(confNums,'-')
        FOR i:=1 TO cmds.numConf
          IF checkConfAccess(i)
            FOR m:=1 TO getConfMsgBaseCount(i)
              cb:=confBases.item(getConfIndex(i,m))
              cb.handle[0]:=cb.handle[0] AND (Not(editmask))
            ENDFOR
          ENDIF
        ENDFOR
      ELSEIF StrLen(confNums)>0
        p:=confNums
        WHILE((i:=InStr(p,','))<>-1) AND ((p-confNums)<StrLen(confNums))
          StrCopy(tempstr,p,i)
          fullTrim(tempstr,tempstr2)
          p:=p+i+1
          
          FOR i:=1 TO cmds.numConf
            IF checkConfAccess(i)
              v:=getInverse(i)
              cnt:=getConfMsgBaseCount(i)
              FOR m:=1 TO cnt
                IF cnt=1
                  StringF(tempstr,'\d',v)
                ELSE
                  StringF(tempstr,'\d.\d',v,m)
                ENDIF
                IF StrCmp(tempstr,tempstr2)
                  cb:=confBases.item(getConfIndex(i,m))
                  cb.handle[0]:=Eor(cb.handle[0],editmask)
                ENDIF
              ENDFOR
            ENDIF
          ENDFOR
        ENDWHILE
        IF ((p-confNums)<StrLen(confNums))
          fullTrim(p,tempstr2)
          FOR i:=1 TO cmds.numConf
            IF checkConfAccess(i)
              v:=getInverse(i)
              cnt:=getConfMsgBaseCount(i)
              FOR m:=1 TO cnt
                IF cnt=1
                  StringF(tempstr,'\d',v)
                ELSE
                  StringF(tempstr,'\d.\d',v,m)
                ENDIF
                IF StrCmp(tempstr,tempstr2)
                  cb:=confBases.item(getConfIndex(i,m))
                  cb.handle[0]:=Eor(cb.handle[0],editmask)
                ENDIF
              ENDFOR
            ENDIF
          ENDFOR
        ENDIF
      ENDIF
    ENDIF
  UNTIL loop=FALSE
ENDPROC

PROC internalCommandCM()
  IF checkSecurity(ACS_SYSOP_COMMANDS)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_SYSOP)

  sendCLS()
  conferenceMaintenance()
  loadMsgPointers(currentConf,currentMsgBase)

ENDPROC RESULT_SUCCESS

PROC internalCommandD(cmdcode,params)
  IF checkSecurity(ACS_DOWNLOAD)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_DOWNLOADING)

  beginDLF(cmdcode,params)
ENDPROC RESULT_SUCCESS

PROC internalCommandE(params)
  IF checkSecurity(ACS_ENTER_MESSAGE)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_MAIL)
  parseParams(params)
  IF checkToolTypeExists(TOOLTYPE_CONF,currentConf,'CUSTOM')=FALSE
    RETURN callMsgFuncs(MAIL_CREATE,currentConf,currentMsgBase) ->EnterMSG()
  ELSE
    customMsgbaseCmd(MAIL_CREATE,currentConf,1)
    RETURN RESULT_SUCCESS
  ENDIF
ENDPROC

PROC internalCommandFS()
  IF checkSecurity(ACS_CONFERENCE_ACCOUNTING)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  fileStatus(0)
ENDPROC RESULT_SUCCESS

PROC internalCommandF(params)
  IF checkSecurity(ACS_FILE_LISTINGS)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_FILES)
ENDPROC displayFileList(params);

PROC internalCommandFR(params)
  IF checkSecurity(ACS_FILE_LISTINGS)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_FILES)
ENDPROC displayFileList(params,TRUE);

PROC internalCommandFM(params) HANDLE
  DEF stat,fLLoop,i,useflagged=FALSE,dirloop
  DEF str[200]:STRING,ss[80]:STRING,ray[200]:STRING
  DEF tempfile[256]:STRING
  DEF fcopy = FALSE
  DEF startDir,dirScan,action
  DEF foundfile[12]:STRING
  DEF foundDateStr[20]:STRING
  DEF flagfilelist=NIL:PTR TO stringlist
  DEF matchpos
  DEF item:PTR TO flagFileItem

  IF checkSecurity(ACS_EDIT_FILES)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_FILES)

  parseParams(params)

  lineCount:=0
  nonStopDisplayFlag:=FALSE

  aePuts('\b\n')
  IF(maxDirs=0)
    myError(5); ->Sorry();
    RETURN RESULT_FAILURE
  ENDIF

  IF(parsedParams.count()>0)
    flagfilelist:=NEW flagfilelist.stringlist(parsedParams.count())

    FOR i:=0 TO parsedParams.count()-1
      flagfilelist.add(parsedParams.item(i))
    ENDFOR
    JUMP fmSkip1
  ENDIF

  IF flagFilesList.count()>0
    aePuts('You have flagged files, do you wish to work with these files ')
    stat:=yesNo(1)
    IF(stat<0) THEN RETURN stat
    aePuts('\b\n')
    IF stat
      useflagged:=TRUE

      flagfilelist:=NEW flagfilelist.stringlist(flagFilesList.count())
      FOR i:=0 TO flagFilesList.count()-1
        item:=flagFilesList.item(i)
        flagfilelist.add(item.fileName)
      ENDFOR
      JUMP fmSkip1
    ENDIF
  ENDIF

  aePuts('Enter filename(s) to search for (wildcards are permitted): ')
  stat:=lineInput('','',78,INPUT_TIMEOUT,ss)
  IF(stat<0) THEN RETURN RESULT_NO_CARRIER

  aePuts('\b\n')
  IF(StrLen(ss)=0)
    RETURN RESULT_SUCCESS
  ENDIF

  flagfilelist:=NEW flagfilelist.stringlist(100)
  parseList(ss,flagfilelist)

fmSkip1:

  stat,startDir,dirScan:=getDirSpan('');      /* chg to "A' to search all dirs */
  IF(stat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS

  aePuts('\b\n')

  IF(flagfilelist.count()>0)

    fLLoop:=startDir
    WHILE(fLLoop<=dirScan)
      StrCopy(str,currentConfDir)   /* get BBS conf locale dir */
      IF(dirScan<>(-1))                /* add 'DIR' */
      ->(RTS) buff copy
      IF(fLLoop = maxDirs)    /* at upload dir */
        StrAdd(str,'DIR')
        StringF(ray,'\d',fLLoop)
        StrAdd(str,ray)
        StringF(ray,'Scanning directory \d\b\n',fLLoop)
        aePuts(ray)
      ELSE
        StrAdd(str,'DIR')
        StringF(ray,'\d',fLLoop)      /* add dir Number */
        StrAdd(str,ray)               /* add path & name */
        StringF(ray,'Scanning directory \d\b\n',fLLoop)
        aePuts(ray)
      ENDIF
        lineCount++
      ELSE
        StrAdd(str,'hold/held')
        aePuts('\b\nScanning directory HOLD\b\n')
      ENDIF

      dirloop:=TRUE

      matchpos:=0
      WHILE dirloop

        stat,action,matchpos:=maintenanceFileSearch(dirScan=-1,str,flagfilelist,foundfile,foundDateStr,matchpos)
        IF(stat<0)
          aePuts('\b\n')
          IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
          RETURN stat
        ENDIF

        IF (stat=RESULT_NOT_FOUND)
          dirloop:=FALSE
        ELSE
          aePuts('\b\n')
          IF (action="D") OR (action="d")
            IF maintenanceFileDelete(str,dirScan=-1,foundfile,matchpos)<>RESULT_SUCCESS
              IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
              Raise(ERR_EXCEPT)
            ENDIF
          ELSEIF (action="M") OR (action="m")
            IF maintenanceFileMove(str,dirScan=-1,foundfile,foundDateStr,matchpos)<>RESULT_SUCCESS
              IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
              Raise(ERR_EXCEPT)
            ENDIF
          ELSEIF (action="V") OR (action="v")
            IF dirScan=-1
              aePuts('\b\nView option is not available for hold directory\b\n')
            ELSE
              internalCommandV('V',foundfile)
            ENDIF
          ELSEIF (action="q") OR (action="q")
            IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
            Raise(ERR_EXCEPT)
          ENDIF
          IF useflagged
            aePuts('\b\nRemove from flagged list')
            stat:=yesNo(1)
            IF(stat<0)
              END flagfilelist
              RETURN stat
            ENDIF
            IF stat THEN removeFlagFromList(foundfile)
          ENDIF
        ENDIF
      ENDWHILE
      IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)

      fLLoop++
      ->if(DirScan!=-1) FLLoop+=1;
    ENDWHILE
  ENDIF
  aePuts('\b\n')
  END flagfilelist
  IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
EXCEPT
  IF flagfilelist THEN END flagfilelist
ENDPROC RESULT_SUCCESS

PROC internalCommandG(params)
  DEF mystat
  DEF auto

  parseParams(params)
  IF parsedParams.count()>0
    auto:=paramsContains('Y')
  ENDIF

  IF auto=FALSE
    IF partUploadOK(0)=RESULT_ABORT THEN RETURN RESULT_SUCCESS
    mystat:=checkFlagged()
    IF(mystat=0)
      aePuts('\b\n')
      RETURN RESULT_SUCCESS
    ENDIF
  ENDIF
  saveFlagged()
  IF StrLen(historyFolder)>0 THEN saveHistory()
  reqState:=REQ_STATE_LOGOFF
  setEnvStat(ENV_LOGOFF)

ENDPROC RESULT_SUCCESS

PROC internalCommandH(params)
  DEF tempstr[255]:STRING,screen[255]:STRING

  parseParams(params)
  IF parsedParams.count()>0
    nonStopDisplayFlag:=paramsContains('NS')
  ENDIF

  StringF(tempstr,'\sBBSHelp',cmds.bbsLoc)
  IF findSecurityScreen(tempstr,screen)
    displayFile(screen)
  ELSE
    aePuts('\b\n\b\nSorry Help is unavailable at this time.\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

ENDPROC RESULT_SUCCESS

PROC internalCommandUpHat(params)
  DEF tempstr[255]:STRING
  DEF screen[255]:STRING
  DEF ch

  StringF(tempstr,'\shelp/\s',cmds.bbsLoc,params)
  LOOP
    IF findSecurityScreen(tempstr,screen)
      displayFile(screen)
      ch:=doPause()
      IF(ch<0) THEN RETURN ch
      aePuts('\b\n')
      RETURN RESULT_SUCCESS
    ELSE
      IF(StrLen(params)>0)
        params[StrLen(params)-1]:=0
        StringF(tempstr,'\shelp/\s',cmds.bbsLoc,params)
      ELSE
        RETURN RESULT_SUCCESS
      ENDIF
    ENDIF
  ENDLOOP
ENDPROC RESULT_SUCCESS

PROC internalCommandJ(params)
  DEF newStr[5]:STRING
  DEF newConf,stat
  DEF newMsgBase=1
  DEF param,pos,cnt
  DEF tempStr[255]:STRING

  IF checkSecurity(ACS_JOIN_CONFERENCE)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  saveMsgPointers(currentConf,currentMsgBase)

  setEnvStat(ENV_JOIN)

  parseParams(params)

  newConf:=-1
  IF parsedParams.count()>0
    param:=parsedParams.item(0)
    IF StrLen(param)>0
      newConf:=Val(param)    
      IF (pos:=InStr(param,'.'))>=0
        newMsgBase:=Val(param+pos+1)
      ELSEIF parsedParams.count()>1
        newMsgBase:=Val(parsedParams.item(1))
      ENDIF
    ENDIF
  ENDIF

  newConf:=getInverse(newConf)

  IF (newConf<1) OR (newConf>cmds.numConf)
    displayScreen(SCREEN_JOINCONF)
    StringF(tempStr,'Conference Number (1-\d): ',cmds.numConf)
    stat:=lineInput(tempStr,'',5,INPUT_TIMEOUT,newStr)
    IF stat<>RESULT_SUCCESS THEN RETURN stat

    IF StrLen(newStr)=0 THEN RETURN RESULT_SUCCESS

    newConf:=getInverse(Val(newStr))
  ENDIF

  IF newConf<1 THEN newConf:=1
  IF newConf>cmds.numConf THEN newConf:=cmds.numConf

  IF(checkConfAccess(newConf)=FALSE)
    aePuts('\b\nYou do not have access to the requested conference\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  IF StrLen(getConfLocation(newConf))=0
    callersLog('****Conference Location unknown in MENU routines****')
    StringF(tempStr,'**** For Conference \d',newConf)
    callersLog(tempStr)
  ENDIF

  cnt:=getConfMsgBaseCount(newConf)

  IF (newMsgBase<1) OR (newMsgBase>cnt)
    IF displayScreen(SCREEN_CONF_JOINMSGBASE)=FALSE
      displayScreen(SCREEN_JOINMSGBASE)
    ENDIF
    StringF(tempStr,'Message Base Number (1-\d): ',cnt)
    stat:=lineInput(tempStr,'',5,INPUT_TIMEOUT,newStr)
    IF stat<>RESULT_SUCCESS THEN RETURN stat

    IF StrLen(newStr)=0 THEN RETURN RESULT_SUCCESS

    newMsgBase:=Val(newStr)
  ENDIF

  joinConf(newConf,newMsgBase,FALSE,FALSE)
ENDPROC RESULT_SUCCESS

PROC internalCommandJM(params)
  DEF newStr[5]:STRING
  DEF newMsgBase,stat,cnt
  DEF param
  DEF tempStr[255]:STRING

  IF checkSecurity(ACS_JOIN_CONFERENCE)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  saveMsgPointers(currentConf,currentMsgBase)

  setEnvStat(ENV_JOIN)

  parseParams(params)

  newMsgBase:=-1
  IF parsedParams.count()>0
    param:=parsedParams.item(0)

    IF (InStr(param,'.')>=0)
      internalCommandJ(params)
      RETURN
    ENDIF
    
    IF StrLen(param)>0 THEN newMsgBase:=Val(param)
  ENDIF

  cnt:=readToolTypeInt(TOOLTYPE_MSGBASE,currentConf,'NMSGBASES') 
  IF cnt=-1
    aePuts('\b\nThis conference does not contain multiple message bases\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF


  cnt:=getConfMsgBaseCount(currentConf)

  IF (newMsgBase<1) OR (newMsgBase>cnt)
    IF displayScreen(SCREEN_CONF_JOINMSGBASE)=FALSE
      displayScreen(SCREEN_JOINMSGBASE)
    ENDIF
    StringF(tempStr,'Message Base Number (1-\d): ',cnt)
    stat:=lineInput(tempStr,'',5,INPUT_TIMEOUT,newStr)
    IF stat<>RESULT_SUCCESS THEN RETURN stat

    IF StrLen(newStr)=0 THEN RETURN RESULT_SUCCESS

    newMsgBase:=Val(newStr)
  ENDIF

  IF newMsgBase<1 THEN newMsgBase:=1
  IF newMsgBase>cnt THEN newMsgBase:=cnt

  joinConf(currentConf,newMsgBase,FALSE,FALSE)
ENDPROC RESULT_SUCCESS

PROC internalCommandM()

  IF(ansiColour)
    ansiColour:=FALSE
    aePuts('\b\nAnsi Color Off\b\n')
  ELSE
    ansiColour:=TRUE
    aePuts('\b\nAnsi Color On\b\n')
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandMS()
  DEF conf,msgbase,mystat,oldconf,oldMsgBase,n

  nonStopDisplayFlag:=FALSE
  oldconf:=currentConf
  oldMsgBase:=currentMsgBase
  currentConf:=0
  lineCount:=2
  aePuts('\b\nScanning conferences for mail...\b\n\b\n')
  mciViewSafe:=FALSE
  FOR conf:=1 TO cmds.numConf
    IF (checkConfAccess(conf))
      n:=getConfMsgBaseCount(conf)
      FOR msgbase:=1 TO n
        mystat:=joinConf(conf,msgbase,TRUE,FALSE,FORCE_MAILSCAN_ALL)
      ENDFOR
    ENDIF
    EXIT mystat=RESULT_FAILURE
  ENDFOR
  mciViewSafe:=TRUE
  joinConf(oldconf,oldMsgBase,TRUE,FALSE,FORCE_MAILSCAN_SKIP)
  currentConf:=oldconf
  currentMsgBase:=oldMsgBase
ENDPROC RESULT_SUCCESS

PROC internalCommandN(params)
  IF checkSecurity(ACS_FILE_LISTINGS)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_FILES)
ENDPROC myNewFiles(params)

PROC internalCommandNM()
  DEF str[255]:STRING
  DEF stat,nd,read,status
  DEF sp:PTR TO singlePort
  DEF serverMsg:PTR TO jhMessage
  DEF nodeport

  IF checkSecurity(ACS_SYSOP_COMMANDS)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  IF sopt.toggles[TOGGLES_MULTICOM]=0 THEN RETURN RESULT_SUCCESS

  setEnvStat(ENV_SYSOP)

  LOOP
    who(0)
    aePuts('\b\n')

    aePuts('Which to change <Q>=QUIT ? ')

    stat:=lineInput('','',2,INPUT_TIMEOUT,str)

    aePuts('\b\n')

    IF(stat<0) THEN RETURN stat
    IF (StriCmp(str,'q')) THEN RETURN RESULT_SUCCESS

    nd,read:=Val(str)
    IF read>0
      IF nd=node
        aePuts('You cannot perform actions on the node you are connected to.\b\n')
      ELSEIF (nd>=0) AND (nd<MAXNODES)
        status:=-1
        ObtainSemaphore(masterNode)
        sp:=(masterNode.myNode[nd].s)
        ReleaseSemaphore(masterNode)

        IF sp
          ObtainSemaphore(sp)
          status:=sp.status
          ReleaseSemaphore(sp)
        ENDIF

        IF status=ENV_AWAITCONNECT
          StringF(str,'Do you wish to take node \d offline ',nd)
          aePuts(str)
          stat:=yesNo(2)
          IF(stat<0) THEN RETURN stat
          IF(stat)
            StringF(str,'AEServer.\d',nd)
            IF (nodeport:=FindPort(str))<>NIL
              serverMsg:=AllocMem(SIZEOF jhMessage,MEMF_ANY OR MEMF_CLEAR)
              serverMsg.msg.length:=SIZEOF jhMessage
              serverMsg.msg.replyport:=0
              serverMsg.command:=SV_EXITNODE
              PutMsg(nodeport,serverMsg)
              Delay(60)
            ENDIF
          ENDIF

        ELSEIF (status=ENV_NOTACTIVE) OR (status=ENV_SHUTDOWN)
          StringF(str,'Do you wish to bring node \d online ',nd)
          aePuts(str)
          stat:=yesNo(2)
          IF(stat)
            sendACPCommand2('',SV_STARTNODE,nd)
            Delay(480)
          ENDIF
        ELSEIF status>=0
          StringF(str,'Do you wish to disconnect the current user from node \d ',nd)
          aePuts(str)
          stat:=yesNo(2)
          IF(stat<0) THEN RETURN stat
          IF(stat)
            StringF(str,'AEServer.\d',nd)
            IF (nodeport:=FindPort(str))<>NIL
              serverMsg:=AllocMem(SIZEOF jhMessage,MEMF_ANY OR MEMF_CLEAR)
              serverMsg.msg.length:=SIZEOF jhMessage
              serverMsg.msg.replyport:=0
              serverMsg.command:=SV_KICKUSER
              PutMsg(nodeport,serverMsg)
              Delay(120)
            ENDIF
          ENDIF
        ENDIF
      ENDIF
    ENDIF

  ENDLOOP

ENDPROC RESULT_SUCCESS

PROC internalCommandO()
  DEF result
  DEF string[255]:STRING

  IF(pagesAllowed=0)
    setEnvStat(ENV_MAIL)
    IF((checkSecurity(ACS_COMMENT_TO_SYSOP)=FALSE)) THEN RETURN RESULT_NOT_ALLOWED
    mciViewSafe:=FALSE
    result:=commentToSYSOP()
    mciViewSafe:=TRUE
    RETURN result
  ENDIF

  IF(pagesAllowed<>-1) THEN pagesAllowed--
  /* no chat unless validated */
  IF((checkSecurity(ACS_PAGE_SYSOP))=FALSE) THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_REQ_CHAT)
  pagedFlag:=1

  sysopPaged()

  result:=RESULT_SUCCESS

  IF(sysopAvail=FALSE) AND (checkSecurity(ACS_OVERRIDE_CHAT)=FALSE)
    StringF(string,'\b\nSorry, \s, is not around right now\b\n',cmds.sysopName)
    aePuts(string)
    aePuts('You can use ''C'' to leave a comment.\b\n\b\n')
  ELSE
    result:=ccom()
  ENDIF

ENDPROC result

PROC internalCommandOLM(params)
  DEF nodenumstr[2]:STRING
  DEF msgsent
  DEF tempStr[255]:STRING
  DEF olmBlocked
  DEF nodenum
  DEF userstatus
  DEF destNode: PTR TO singlePort
  DEF i

  IF((checkSecurity(ACS_OLM))=FALSE) OR (sopt.toggles[TOGGLES_MULTICOM]=FALSE) THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_ONLINEMSG)
  aePuts('\b\n[34m*[0mOLM MESSAGE SYSTEM[34m*[0m\b\n')

  parseParams(params)
  IF(parsedParams.count()>0)
    StrCopy(nodenumstr,parsedParams.item(0))
  ELSE
    lineInput('\b\n[32m-[0m OLM to Which Node? [36m[[0mNode [33m#[36m][0m [36m[[0mR[36m][0m To Reply[0m Or [36m[[0mQ[36m][0m To Quit[32m:[0m ','',2,INPUT_TIMEOUT,nodenumstr)
  ENDIF

  IF StriCmp(nodenumstr,'R')
    IF (lastOlmNode=-1)
      aePuts('\b\nNo OLM has been received in this session\b\n')
      RETURN RESULT_SUCCESS
    ENDIF
    StringF(nodenumstr,'\d',lastOlmNode)
  ENDIF

  IF (StrLen(nodenumstr)=0) OR (StriCmp(nodenumstr,'Q')) THEN RETURN RESULT_SUCCESS

  fileattach:=FALSE
  aePuts('\b\n')

  IF(parsedParams.count()<2)
    msgBuf.clear()
    lines:=0
    IF edit()<>RESULT_SUCCESS THEN RETURN RESULT_SUCCESS
  ENDIF

  nodenum:=Val(nodenumstr)

  IF (nodenum<0) OR (nodenum>=MAXNODES)
    userstatus:=-1
    olmBlocked:=TRUE
  ELSE
    olmBlocked:=FALSE
    ObtainSemaphore(masterNode)
    IF masterNode.myNode[nodenum]<>NIL
      destNode:=masterNode.myNode[nodenum].s
      IF destNode<>NIL
        userstatus:=destNode.status
        olmBlocked:=destNode.misc2[0]
      ENDIF
    ENDIF
    ReleaseSemaphore(masterNode)

    IF olmBlocked
      StringF(tempStr,'\b\n[34m*[0m--[33mNODE [0m\d[33m HAS MESSAGES SUPPRESSED[0m--[34m*[0m\b\n',nodenum)
      aePuts(tempStr)
    ENDIF
  ENDIF

  IF (userstatus<0) OR (olmBlocked)
    aePuts('\b\n[34m*[0mOLM UNSUCCESSFUL[34m*[0m\b\n')
    RETURN RESULT_SUCCESS
  ENDIF

  msgsent:=TRUE

  StringF(tempStr,'\b\n\b\n[34m*[0mOnline Message![0m From Node[32m:[36m([33m\d[36m)[0m User[32m: [36m[[0m\s[36m][0m\b\n\b\n',node,loggedOnUser.name)
  IF sendOlmPacket(nodenum,tempStr,0)<>RESULT_SUCCESS THEN msgsent:=FALSE
  IF(parsedParams.count()<2)
    FOR i:=0 TO lines-1
      StringF(tempStr,'\s\b\n',msgBuf.item(i))
      IF sendOlmPacket(nodenum,tempStr,0)<>RESULT_SUCCESS THEN msgsent:=FALSE
    ENDFOR
  ELSE
    StrCopy(tempStr,'')
    FOR i:=1 TO parsedParams.count()-1
      StrAdd(tempStr,parsedParams.item(i))
      StrAdd(tempStr,' ')
    ENDFOR
    StrAdd(tempStr,'\b\n')
    IF sendOlmPacket(nodenum,tempStr,0)<>RESULT_SUCCESS THEN msgsent:=FALSE
  ENDIF
  StringF(tempStr,'\b\n[34m*[0mPress [36m[[33mReturn[36m][0m To Resume BBS Operations.\b\n\b\n')
  IF sendOlmPacket(nodenum,tempStr,-1)<>RESULT_SUCCESS THEN msgsent:=FALSE

  IF msgsent
    aePuts('[34m*[0mOLM SENT[34m*[0m\b\n')
  ELSE
    aePuts('[34m*[0mOLM UNSUCCESSFUL[34m*[0m')
  ENDIF

ENDPROC RESULT_SUCCESS

PROC internalCommandQ()
  IF checkSecurity(ACS_QUIET_NODE)
    quietFlag:=Not(quietFlag)
    sendQuietFlag(quietFlag)
    IF(quietFlag)
      aePuts('\b\nQuiet Mode On\b\n')
    ELSE
      aePuts('\b\nQuiet Mode Off\b\n')
    ENDIF
  ELSE
    RETURN RESULT_NOT_ALLOWED
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandR(params)
  IF checkSecurity(ACS_READ_MESSAGE)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_MAIL)
  parseParams(params)

  getMailStatFile(currentConf,currentMsgBase)

  IF checkToolTypeExists(TOOLTYPE_CONF,currentConf,'CUSTOM')=FALSE
    RETURN callMsgFuncs(MAIL_READ,currentConf,currentMsgBase)
  ELSE
    customMsgbaseCmd(MAIL_READ,currentConf,1)
    RETURN RESULT_SUCCESS
  ENDIF

ENDPROC

PROC internalCommandRL(params)
  IF checkSecurity(ACS_RELOGON)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  relogon:=TRUE
  internalCommandG(params)
ENDPROC RESULT_SUCCESS

PROC internalCommandS()
  DEF tmp[150]:STRING
  DEF tmp2[25]:STRING

  IF checkSecurity(ACS_DISPLAY_USER_STATS)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_STATS)

  aePuts('\b\n')

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'USERNUMBER_LOGIN')
    StringF(tmp,'[32mUser Number[33m:[0m \d\b\n',loggedOnUser.slotNumber)
    aePuts(tmp)
  ENDIF
  IF sopt.toggles[TOGGLES_CONFRELATIVE]=FALSE
    StringF(tmp,'[32mArea Name  [33m:[0m \s\b\n',loggedOnUser.conferenceAccess)
    aePuts(tmp)
  ENDIF
  StringF(tmp,'[32mCaller Num.[33m:[0m \d\b\n',callerNum)
  aePuts(tmp)
  formatLongDateTime(loggedOnUser.timeLastOn,tmp2)
  StringF(tmp,'[32mLst Date On[33m:[0m \s\b\n',tmp2)
  aePuts(tmp)
  StringF(tmp,'[32mSecurity Lv[33m:[0m \d\b\n',loggedOnUser.secStatus)
  aePuts(tmp)
  StringF(tmp,'[32m# Times On [33m:[0m \d\b\n',loggedOnUser.timesCalled AND $FFFF)
  aePuts(tmp)
  StringF(tmp,'[32mTimes Today[33m:[0m \d\b\n',getTodaysCalls(loggedOnUser,loggedOnUserKeys))
  aePuts(tmp)
  StringF(tmp,'[32mMsgs Posted[33m:[0m \d\b\n',loggedOnUser.messagesPosted AND $FFFF)
  aePuts(tmp)
  StringF(tmp,'[32mOnline Baud[33m:[0m \d\b\n',onlineBaud)
  aePuts(tmp)
  formatUnsignedLong(loggedOnUserKeys.upCPS2,tmp2)
  StringF(tmp,'[32mRate CPS UP[33m:[0m \s\b\n',tmp2)
  aePuts(tmp)
  formatUnsignedLong(loggedOnUserKeys.dnCPS2,tmp2)
  StringF(tmp,'[32mRate CPS DN[33m:[0m \s\b\n',tmp2)
  aePuts(tmp)

  StringF(tmp,'[32mScreen  Clr[33m:[0m \s\b\n',IF loggedOnUserKeys.userFlags AND USER_SCRNCLR THEN 'YES' ELSE 'NO')
  aePuts(tmp)

  StringF(tmp,'[32mProtocol   [33m:[0m \s\b\n',xprTitle.item(loggedOnUser.xferProtocol))
  aePuts(tmp)

  IF (checkSecurity(ACS_SHOW_PAYMENTS)) AND (loggedOnUser.creditDays>0)
    IF creditAccountEnabled(loggedOnUser)
      formatLongDate(loggedOnUser.creditStartDate+Mul(loggedOnUser.creditDays,86400),tmp2)
      StringF(tmp,'[32mCredit Account Expires[33m:[0m \s\b\n',tmp2)
      aePuts(tmp)
    ELSE
      aePuts('[31mCredit Account has EXPIRED[0m\b\n')
    ENDIF
  ENDIF

  StringF(tmp,'[32mSysop  Here[33m:[0m \s\b\n',IF sysopAvail THEN 'YES' ELSE 'NO')
  aePuts(tmp)

  IF(pagesAllowed<>-1)
    StringF(tmp,'[32mSysop Pages Remaining[33m:[0m \d\b\n',pagesAllowed)
    aePuts(tmp)
  ENDIF

  fileStatus(1)
  aePuts('\b\n')
ENDPROC RESULT_SUCCESS

PROC internalCommandRZ(cmdcode)
  DEF stat
  IF checkSecurity(ACS_UPLOAD)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_UPLOADING)

  IF logonType>=LOGON_TYPE_REMOTE
    bgFileCheck:=checkToolTypeExists(TOOLTYPE_NODE,node,'BGFILECHECK')
  ELSE
    bgFileCheck:=FALSE
  ENDIF
  stat:=uploadaFile(1,cmdcode,FALSE)
  IF stat=RESULT_GOODBYE THEN modemOffHook()
ENDPROC RESULT_SUCCESS

PROC internalCommandT()
  DEF datestring[20]:STRING
  DEF timestring[20]:STRING
  DEF dt : datetime

  DateStamp(dt.stamp)

  dt.format:=FORMAT_USA
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=datestring
  dt.strtime:=timestring

  IF DateToStr(dt)
    aePuts('\b\nIt is ')
    aePuts(datestring)
    aePuts(' ')
    aePuts(timestring)
    aePuts('\b\n')
  ELSE
    aePuts('Unable to get system time\b\n')
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandU(cmdcode)
  DEF stat
  IF checkSecurity(ACS_UPLOAD)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_UPLOADING)

  IF logonType>=LOGON_TYPE_REMOTE
    bgFileCheck:=checkToolTypeExists(TOOLTYPE_NODE,node,'BGFILECHECK')
  ELSE
    bgFileCheck:=FALSE
  ENDIF
  stat:=uploadaFile(0,cmdcode,FALSE)
  IF stat=RESULT_GOODBYE THEN modemOffHook()
ENDPROC RESULT_SUCCESS

PROC internalCommandUS()
  IF checkSecurity(ACS_SYSOP_COMMANDS)=FALSE THEN RETURN RESULT_NOT_ALLOWED
  setEnvStat(ENV_UPLOADING)

  sysopUpload()
ENDPROC RESULT_SUCCESS

PROC internalCommandUP()
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  formatLongDateTime(nodeStart,tempStr2)
  StringF(tempStr,'\b\nNode \d was started at \s.\b\n',node,tempStr2)
  aePuts(tempStr)
ENDPROC RESULT_SUCCESS

PROC internalCommandV(cmdcode,params)
  IF checkSecurity(ACS_VIEW_A_FILE)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_VIEWING)
  IF ripMode
    aePuts('[1!')
  ENDIF
  viewAFile(cmdcode,params)
  IF ripMode
    aePuts('[2!')
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandVER()
  DEF tempStr[255]:STRING
  StringF(tempStr,'\b\nAmiExpress \s (\s) Copyright ©2018-2023 Darren Coles\b\n\b\n',expressVer,expressDate)
  aePuts(tempStr)
  aePuts('Original Version:\b\n')
  aePuts('  (C)1989-91 Mike Thomas, Synthetic Technologies\b\n')
  aePuts('  (C)1992-95 Joe Hodge, LightSpeed Technologies Inc.\b\n\b\n')
  
  StringF(tempStr,'Registered to \s.\b\n',regKey)
  aePuts(tempStr)
ENDPROC RESULT_SUCCESS

PROC internalCommandVO()
  IF checkSecurity(ACS_VOTE)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_DOORS)
  setEnvMsg('Voting Booth')
  IF checkSecurity(ACS_MODIFY_VOTE)
    voteMenu()
  ELSE
    vote()
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandW()
  DEF stat,option
  DEF str[255]:STRING
  DEF str2[255]:STRING
  DEF temp

  IF checkSecurity(ACS_EDIT_USER_INFO)=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_STATS)
  LOOP
    IF(logonType>=LOGON_TYPE_REMOTE)
      stat:=checkCarrier()
      IF(stat=FALSE) THEN RETURN RESULT_SLEEP_LOGOFF
    ENDIF

    /* FormFeed Line since user indicates he wants this option */
    checkScreenClear()

    aePuts('\b\n')

    aePuts('                       [34m*[0m--[33mUSER CONFIGURATION[0m--[34m*[0m\b\n')
    aePuts('\b\n')

    IF((checkSecurity(ACS_EDIT_USER_NAME))=FALSE)
      aePuts('[34m[[0m  0[34m][31m [DISABLED][0m\b\n')
    ELSE
      StringF(str,'[34m[[0m  0[34m][35m LOGIN NAME.............. [33m\s[0m\b\n',loggedOnUser.name)
      aePuts(str)
    ENDIF

    IF((checkSecurity(ACS_EDIT_EMAIL))=FALSE)
      aePuts('[34m[[0m  1[34m][31m [DISABLED][0m\b\n')
    ELSE
      StringF(str,'[34m[[0m  1[34m][35m EMAIL ADDRESS........... [33m\s[0m\b\n',loggedOnUserMisc.eMail)
      aePuts(str)
    ENDIF

    IF((checkSecurity(ACS_EDIT_REAL_NAME))=FALSE)
      aePuts('[34m[[0m  2[34m][31m [DISABLED][0m\b\n')
    ELSE
      StringF(str,'[34m[[0m  2[34m][35m REAL NAME............... [33m\s[0m\b\n',loggedOnUserMisc.realName)
      aePuts(str)
    ENDIF

    IF((checkSecurity(ACS_EDIT_INTERNET_NAME))=FALSE)
      aePuts('[34m[[0m  3[34m][31m [DISABLED][0m\b\n')
    ELSE
      StringF(str,'[34m[[0m  3[34m][35m INTERNET NAME........... [33m\s[0m\b\n',loggedOnUserMisc.internetName)
      aePuts(str)
    ENDIF

    IF((checkSecurity(ACS_EDIT_USER_LOCATION))=FALSE)
      aePuts('[34m[[0m  4[34m][31m [DISABLED][0m\b\n')
    ELSE
      StringF(str,'[34m[[0m  4[34m][35m LOCATION................ [33m\s[0m\b\n',loggedOnUser.location)
      aePuts(str)
    ENDIF

    IF((checkSecurity(ACS_EDIT_PHONE_NUMBER))=FALSE)
      aePuts('[34m[[0m  5[34m][31m [DISABLED][0m\b\n')
    ELSE
      StringF(str,'[34m[[0m  5[34m][35m PHONE NUMBER............ [33m\s[0m\b\n',loggedOnUser.phoneNumber)
      aePuts(str)
    ENDIF

    IF((checkSecurity(ACS_EDIT_PASSWORD))=FALSE)
      aePuts('[34m[[0m  6[34m][31m [DISABLED][0m\b\n')
    ELSE
      StringF(str,'[34m[[0m  6[34m][35m PASSWORD................ [36mENCRYPTED[0m\b\n')
      aePuts(str)
    ENDIF

    IF loggedOnUser.lineLength=0 THEN StrCopy(str2,'Auto') ELSE StringF(str2,'\d',loggedOnUser.lineLength)
    StringF(str,'[34m[[0m  7[34m][35m LINES PER SCREEN........ [33m\s[0m\b\n',str2)
    aePuts(str)

    temp:=computerTypes.count()
    IF temp=0
      StringF(str,'[34m[[0m  8[34m][35m COMPUTER................ [33m[0m\b\n')
    ELSEIF(loggedOnUser.secBulletin>=temp)
      StringF(str,'[34m[[0m  8[34m][35m COMPUTER................ [33mNOT VALID![0m\b\n')
    ELSE
      StringF(str,'[34m[[0m  8[34m][35m COMPUTER................ [33m\s[0m\b\n',computerTypes.item(loggedOnUser.secBulletin))
    ENDIF
    aePuts(str)

    temp:=screenTypeTitle.count()
    IF temp=0
      StringF(str,'[34m[[0m  9[34m][35m SCREEN TYPE............. [33m[0m\b\n')
    ELSEIF(loggedOnUser.screenType>=screenTypeTitle.count())
      StringF(str,'[34m[[0m  9[34m][35m SCREEN TYPE............. [33mNOT VALID![0m\b\n')
    ELSE
      StringF(str,'[34m[[0m  9[34m][35m SCREEN TYPE............. [33m\s[0m\b\n',screenTypeTitle.item(loggedOnUser.screenType))
    ENDIF
    aePuts(str)

    IF (loggedOnUserKeys.userFlags AND USER_SCRNCLR)
      StringF(str,'[34m[[0m 10[34m][35m SCREEN CLEAR............ [32mYES[0m\b\n')
    ELSE
      StringF(str,'[34m[[0m 10[34m][35m SCREEN CLEAR............ [37mNO[0m\b\n')
    ENDIF
    aePuts(str)

    IF((checkSecurity(ACS_XPR_SEND)) OR (checkSecurity(ACS_XPR_RECEIVE)))
      temp:=xprTitle.count()
      IF temp=0
        StringF(str,'[34m[[0m 11[34m][35m TRANSFER PROTOCOL....... [33m[0m\b\n')
      ELSEIF(loggedOnUser.xferProtocol>=temp)
        StringF(str,'[34m[[0m 11[34m][35m TRANSFER PROTOCOL....... [33mNOT VALID![0m\b\n')
      ELSE
        StringF(str,'[34m[[0m 11[34m][35m TRANSFER PROTOCOL....... [33m\s[0m\b\n',xprTitle.item(loggedOnUser.xferProtocol))
      ENDIF
      aePuts(str)
    ELSE
      aePuts('[34m[[0m 11[34m][31m [DISABLED][0m\b\n')
    ENDIF

    option:=loggedOnUser.editorType
    IF(checkSecurity(ACS_FULL_EDIT))
      SELECT option
        CASE 0
          StringF(str,'[34m[[0m 12[34m][35m EDITOR TYPE............. [33mPROMPT[0m\b\n')
        CASE 1
          StringF(str,'[34m[[0m 12[34m][35m EDITOR TYPE............. [33mLINE EDITOR[0m\b\n')
        DEFAULT
          StringF(str,'[34m[[0m 12[34m][35m EDITOR TYPE............. [33mFULLSCREEN EDITOR[0m\b\n')
      ENDSELECT
    ELSE
      aePuts('[34m[[0m 12[34m][31m [DISABLED][0m\b\n')
    ENDIF

    option:=loggedOnUser.zoomType
    IF(checkSecurity(ACS_ZOOM_MAIL))
      SELECT option
        CASE 1
          StringF(str,'[34m[[0m 13[34m][35m ZOOM TYPE............... [33mASCII[0m\b\n')
        CASE 0
          StringF(str,'[34m[[0m 13[34m][35m ZOOM TYPE............... [33mQWK[0m\b\n')
      ENDSELECT
      aePuts(str)
    ELSE
      aePuts('[34m[[0m 13[34m][31m [DISABLED][0m\b\n')
    ENDIF

    IF(checkSecurity(ACS_OLM))
      IF blockOLM
        StringF(str,'[34m[[0m 14[34m][35m AVAILABLE FOR CHAT/OLM.. [37mNO[0m\b\n')
      ELSE
        StringF(str,'[34m[[0m 14[34m][35m AVAILABLE FOR CHAT/OLM.. [32mYES[0m\b\n')
      ENDIF
      aePuts(str)
    ELSE
      aePuts('[34m[[0m 14[34m][31m [DISABLED][0m\b\n')
    ENDIF

    IF(checkSecurity(ACS_TRANSLATION))
      StringF(str,'[34m[[0m 15[34m][35m TRANSLATOR.............. [33m\s[0m\b\n',userLanguage)
      aePuts(str)
    ENDIF

    IF(checkToolTypeExists(TOOLTYPE_NODE,node,'BGFILECHECK')) AND (checkToolTypeExists(TOOLTYPE_NODE,node,'FORCE_BGFILECHECK')=FALSE)
      option:=loggedOnUserKeys.userFlags AND USER_BGFILECHECK
      IF option
        StringF(str,'[34m[[0m 16[34m][35m BACKGROUND FILE CHECK... [32mYES[0m\b\n')
      ELSE
        StringF(str,'[34m[[0m 16[34m][35m BACKGROUND FILE CHECK... [37mNO[0m\b\n')
      ENDIF
      aePuts(str)
    ELSE
      aePuts('[34m[[0m 16[34m][31m [DISABLED][0m\b\n')
    ENDIF


    aePuts('\b\n')

    aePuts('Which to change <CR>=QUIT ? ')

    stat:=lineInput('','',2,INPUT_TIMEOUT,str)
    IF(stat<0) THEN RETURN stat
    IF (StrLen(str)=0)
      aePuts('\b\n')
      saveAccount(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,0,0)
      checkUserOnLine(0)
      RETURN RESULT_SUCCESS
    ENDIF

    aePuts('\b\n')
    option:=Val(str)

    SELECT option
      CASE 0
         ->EDIT USER NAME
        IF (checkSecurity(ACS_EDIT_USER_NAME)=FALSE) THEN JUMP cant
        loop1:
        aePuts('Name: ')
        StrCopy(str,loggedOnUser.name,31)
        stat:=lineInput('',str,30,INPUT_TIMEOUT,str)
        IF(stat<0) THEN RETURN stat
        IF(StriCmp(loggedOnUserKeys.userName,str)) THEN JUMP cant
        IF(stat:=checkIfNameAllowed(str)) THEN JUMP loop1
        StrCopy(str2,str)
        aePuts('\b\nChecking for duplicate name...')
        stat:=checkForAst(str2)
        IF(stat)
          aePuts('No wildcards allowed in a name.\b\n\b\n')
          JUMP loop1
        ENDIF
        stat:=findUserFromName(1,NAME_TYPE_USERNAME,str2,tempUser,tempUserKeys,tempUserMisc)
        IF(stat<>0)
          aePuts('Already in use!, try another.\b\n\b\n')
          JUMP loop1
        ENDIF
        aePuts('Ok!\b\n')
        AstrCopy(loggedOnUser.name,str,31)
        UpperStr(str)
        AstrCopy(loggedOnUserKeys.userName,str,31)
        saveAccount(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,0,0)
      CASE 1
         ->EDIT EMAIL ADDRESS
        IF (checkSecurity(ACS_EDIT_EMAIL)=FALSE) THEN JUMP cant
        aePuts('Email Address: ')
        StrCopy(str,loggedOnUserMisc.eMail,50)
        stat:=lineInput('',str,100,INPUT_TIMEOUT,str)
        IF(stat<0) THEN RETURN stat
        IF(StrLen(str)=0) THEN JUMP cant
        AstrCopy(loggedOnUserMisc.eMail,str,50)
      CASE 2
         ->EDIT REAL NAME
        IF (checkSecurity(ACS_EDIT_REAL_NAME)=FALSE) THEN JUMP cant
        loop2:
        aePuts('Real Name: (Alpha Numeric) ')
        StrCopy(str,loggedOnUserMisc.realName,26)
        stat:=lineInput('',str,25,INPUT_TIMEOUT,str)
        IF(stat<0) THEN RETURN stat
        IF(StriCmp(loggedOnUserMisc.realName,str)) THEN JUMP cant
        aePuts('\b\nChecking for duplicate name...')
        stat:=checkForAst(str)
        IF(stat)
          aePuts('No wildcards allowed in a name.\b\n\b\n')
          JUMP loop2
        ENDIF
        stat:=findUserFromName(1,NAME_TYPE_REALNAME,str,tempUser,tempUserKeys,tempUserMisc)
        IF(stat<>0)
          aePuts('Already in use!, try another.\b\n\b\n')
          JUMP loop2
        ENDIF
        aePuts('Ok!\b\n')
        AstrCopy(loggedOnUserMisc.realName,str,26)
      CASE 3
         ->EDIT INTERNET NAME
        IF (checkSecurity(ACS_EDIT_INTERNET_NAME)=FALSE) THEN JUMP cant
        loop3:
        aePuts('Internet Name: (Alpha Numeric No Spaces) ')
        StrCopy(str,loggedOnUserMisc.internetName,10)
        stat:=lineInput('',str,9,INPUT_TIMEOUT,str)
        IF(stat<0) THEN RETURN stat
        IF(StriCmp(loggedOnUserMisc.realName,str)) THEN JUMP cant
        aePuts('\b\nChecking for duplicate name...')
        stat:=checkForAst(str)
        IF(stat)
          aePuts('No wildcards allowed in a name.\b\n\b\n')
          JUMP loop3
        ENDIF
        stat:=findUserFromName(1,NAME_TYPE_INTERNETNAME,str,tempUser,tempUserKeys,tempUserMisc)
        IF(stat<>0)
          aePuts('Already in use!, try another.\b\n\b\n')
          JUMP loop3
        ENDIF
        aePuts('Ok!\b\n')
        AstrCopy(loggedOnUserMisc.internetName,str,10)
      CASE 4
         ->EDIT LOCATION
        IF (checkSecurity(ACS_EDIT_USER_LOCATION)=FALSE) THEN JUMP cant
        aePuts('From: ')
        StrCopy(str,loggedOnUser.location,30)
        stat:=lineInput('',str,29,INPUT_TIMEOUT,str)
        IF(stat<0) THEN RETURN stat
        IF(StrLen(str)=0) THEN JUMP cant
        AstrCopy(loggedOnUser.location,str,30)
      CASE 5
         ->EDIT PHONE NUMBER
        IF (checkSecurity(ACS_EDIT_PHONE_NUMBER)=FALSE) THEN JUMP cant
        aePuts('Phone: ')
        StrCopy(str,loggedOnUser.phoneNumber,13)
        stat:=lineInput('',str,12,INPUT_TIMEOUT,str)
        IF(stat<0) THEN RETURN stat
        IF(StrLen(str)=0) THEN JUMP cant
        AstrCopy(loggedOnUser.phoneNumber,str,13)
      CASE 6
         ->EDIT PASSWORD
        IF (checkSecurity(ACS_EDIT_PASSWORD)=FALSE) THEN JUMP cant

        stat:=getPass2('Enter New Password: ',0,0,50,str)
        IF(stat<0) THEN RETURN stat
        IF(StrLen(str)=0) THEN JUMP cant

        stat:=getPass2('Reenter New Password: ',0,0,50,str2)
        IF(stat<0) THEN RETURN stat
        IF(StrLen(str2)=0) THEN JUMP cant

        IF StrCmp(str,str2)
          stat:=checkPasswordStrength(str)
          IF stat=1
            stat:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'MIN_PASSWORD_LENGTH') 
            StringF(str,'\b\nPassword length must be at least \d chars, changes not saved',stat)
            aePuts(str)
            Delay(60)
          ELSEIF stat=2
            stat:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'MIN_PASSWORD_STRENGTH') 
            StringF(str,'\b\nPassword must have at least \d of these:\b\n  upper case,lower case, numeric and symbols - changes not saved',stat)
            aePuts(str)
            Delay(60)
          ELSE
            setNewPassword(loggedOnUser,loggedOnUserMisc,str)
            loggedOnUserMisc.pwdLastUpdated:=getSystemTime()
          ENDIF
        ELSE
          aePuts('\b\nPasswords do not match, changes not saved')
          Delay(60)
        ENDIF
      CASE 7
        ->EDIT NUMBER OF SCREEN LINES
        REPEAT
          stat:=numberOfLinesTest()
          IF(stat<0) THEN RETURN stat
        UNTIL stat=RESULT_SUCCESS
      CASE 8
        ->EDIT COMPUTER
        IF((computerTypes.count()>0))
          IF (stat:=chooseComputer())
            IF(stat<0) THEN RETURN stat
          ENDIF
        ENDIF
      CASE 9
        ->EDIT SCREEN TYPE
        IF(screenTypeTitle.count()>0)
          IF (stat:=chooseScreenType())
            IF(stat<0) THEN RETURN stat
          ENDIF
        ENDIF
      CASE 10
        ->EDIT SCREEN CLEAR
        loggedOnUserKeys.userFlags:=Eor(loggedOnUserKeys.userFlags,USER_SCRNCLR)
      CASE 11
        ->EDIT TRANSFER PROTOCOL
        IF ((checkSecurity(ACS_XPR_SEND) OR checkSecurity(ACS_XPR_RECEIVE))=FALSE) THEN JUMP cant

        IF(xprTitle.count()>0)
          IF (stat:=chooseProtocol())
            IF(stat<0) THEN RETURN stat
          ENDIF
        ENDIF
      CASE 12
        ->EDIT EDITOR TYPE
        IF (checkSecurity(ACS_FULL_EDIT)=FALSE) THEN JUMP cant
        loggedOnUser.editorType:=loggedOnUser.editorType+1
        IF loggedOnUser.editorType=3 THEN loggedOnUser.editorType:=0
      CASE 13
        ->EDIT ZOOM MAIL
        IF (checkSecurity(ACS_ZOOM_MAIL)=FALSE) THEN JUMP cant
        loggedOnUser.zoomType:=((loggedOnUser.zoomType+1) AND 1)
      CASE 14
        ->EDIT AVAILABLE FOR CHAT/OLM
        IF (checkSecurity(ACS_OLM)=FALSE) THEN JUMP cant
        blockOLM:=Not(blockOLM)
      CASE 15
        ->EDIT TRANSLATOR
        IF (checkSecurity(ACS_TRANSLATION)=FALSE) THEN JUMP cant

        stat:=chooseTranslator()
        IF(stat<0) THEN RETURN stat
      CASE 16
        ->EDIT BACKGROUND FILECHECK
        IF(checkToolTypeExists(TOOLTYPE_NODE,node,'BGFILECHECK')) AND (checkToolTypeExists(TOOLTYPE_NODE,node,'FORCE_BGFILECHECK')=FALSE)
          loggedOnUserKeys.userFlags:=Eor(loggedOnUserKeys.userFlags,USER_BGFILECHECK)
        ENDIF
    ENDSELECT

cant:
  ENDLOOP
ENDPROC RESULT_SUCCESS

PROC internalCommandWHO()
  IF (checkSecurity(ACS_WHO_IS_ONLINE) AND (sopt.toggles[TOGGLES_MULTICOM]<>0))
    setEnvStat(ENV_DOORS)
    who(0)
  ELSE
    RETURN RESULT_NOT_ALLOWED
  ENDIF

ENDPROC RESULT_SUCCESS

PROC internalCommandWHD()
  IF (checkSecurity(ACS_WHO_IS_ONLINE) AND (sopt.toggles[TOGGLES_MULTICOM]<>0))
    setEnvStat(ENV_DOORS)
    who(1)
  ELSE
    RETURN RESULT_NOT_ALLOWED
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandX()
  IF loggedOnUser.expert="X"
    aePuts('\b\nExpert mode disabled\b\n')
    loggedOnUser.expert:="N"
  ELSE
    aePuts('\b\nExpert mode enabled\b\n')
    loggedOnUser.expert:="X"
  ENDIF
ENDPROC RESULT_SUCCESS

PROC internalCommandZ(params)
  DEF stat,fLLoop
  DEF str[200]:STRING,ss[80]:STRING,ray[200]:STRING
  DEF tempfile[256]:STRING
  DEF fcopy = FALSE
  DEF startDir,dirScan

  IF((checkSecurity(ACS_ZIPPY_TEXT_SEARCH)))=FALSE THEN RETURN RESULT_NOT_ALLOWED

  setEnvStat(ENV_FILES)

  lineCount:=0
  nonStopDisplayFlag:=FALSE

  aePuts('\b\n')
  IF(maxDirs=0)
    myError(5); ->Sorry();
    RETURN RESULT_FAILURE
  ENDIF

  parseParams(params)

  IF(parsedParams.count()>0)
    StrCopy(ss,parsedParams.item(0))
    JUMP zSkip1
  ENDIF

  aePuts('Enter string to search for: ')
  stat:=lineInput('','',78,INPUT_TIMEOUT,ss)
  IF(stat<0) THEN RETURN RESULT_NO_CARRIER

  aePuts('\b\n')
  IF(StrLen(ss)=0)
    RETURN RESULT_SUCCESS
  ENDIF

zSkip1:
  UpperStr(ss)

  IF(parsedParams.count()>1)
    stat,startDir,dirScan:=getDirSpan(parsedParams.item(1))
  ELSE
    stat,startDir,dirScan:=getDirSpan('');      /* chg to "A' to search all dirs */
  ENDIF

  IF(stat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS

  nonStopDisplayFlag:=paramsContains('NS')

  aePuts('\b\n')

  IF(StrLen(ss)>0)

    fLLoop:=startDir
    WHILE(fLLoop<=dirScan)
      StrCopy(str,currentConfDir)   /* get BBS conf locale dir */
      IF(dirScan<>(-1))                /* add 'DIR' */
        ->(RTS) buff copy
        IF(fLLoop = maxDirs)    /* at upload dir */
          StrAdd(str,'DIR')
          StringF(ray,'\d',fLLoop)
          StrAdd(str,ray)
          StringF(ray,'Scanning directory \d\b\n',fLLoop)
          aePuts(ray)
        ELSE
          StrAdd(str,'DIR')
          StringF(ray,'\d',fLLoop)      /* add dir Number */
          StrAdd(str,ray)               /* add path & name */
          StringF(ray,'Scanning directory \d\b\n',fLLoop)
          aePuts(ray)
        ENDIF
        lineCount++
      ENDIF
      IF(dirScan=-1)
        StrAdd(str,'hold/held')
        aePuts('Scanning directory HOLD\b\n')
      ENDIF
      stat:=zippy(str,ss)
      IF(stat<0)
        aePuts('\b\n')
        IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
        RETURN stat
      ENDIF

      fLLoop++
      ->if(DirScan!=-1) FLLoop+=1;
    ENDWHILE
  ENDIF
  aePuts('\b\n')
  IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
ENDPROC RESULT_SUCCESS

PROC internalCommandZOOM()
  DEF zoomOption
  DEF mystat
  DEF lock=0,oldlock=0
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF tempZoomFile[255]:STRING
  DEF outputZoomName[255]:STRING
  DEF zip=FALSE

  IF((checkSecurity(ACS_ZOOM_MAIL)))=FALSE THEN RETURN RESULT_NOT_ALLOWED

  aePuts('\b\n')
  mystat:=-1

  zoomOption:=loggedOnUser.zoomType
  SELECT zoomOption
    CASE 1
      setEnvStat(ENV_ZOOM)
      mystat:=asciiZoom()
    CASE 0
      setEnvStat(ENV_ZOOM)
      mystat:=qwkZoom()
  ENDSELECT

  IF(mystat<0)
    RETURN mystat
  ENDIF

  aePuts('\b\n[32mPack Method [0m1) LHA, 2) ZIP ?>')
  mystat:=lineInput('','',1,INPUT_TIMEOUT,tempstr)

  IF mystat<0
    RETURN mystat
  ENDIF

  zip:=FALSE
  IF StrLen(tempstr)>0
    IF tempstr[0]="2"
      zip:=TRUE
    ENDIF
  ENDIF

  IF zip
    StrCopy(tempstr,'c:ZIP -0')
  ELSE
    StrCopy(tempstr,'c:LHA -z a')
  ENDIF

  SELECT zoomOption
    CASE 1
      IF zip
        readToolType(TOOLTYPE_ASCPACK,'','ZIP',tempstr)
      ELSE
        readToolType(TOOLTYPE_ASCPACK,'','LHA',tempstr)
      ENDIF
    CASE 0
      IF zip
        readToolType(TOOLTYPE_QWKPACK,'','ZIP',tempstr)
      ELSE
        readToolType(TOOLTYPE_QWKPACK,'','LHA',tempstr)
      ENDIF
  ENDSELECT

  StringF(tempstr2,'\sNode\d/PlayPen',cmds.bbsLoc,node)
  lock:=Lock(tempstr2,ACCESS_READ)
  IF lock<>0
    oldlock:=CurrentDir(lock)
  ENDIF

  SELECT zoomOption
    CASE 1
      StringF(outputZoomName,'\sNode\d/PlayPen/AE\z\r\d[4].ASC',cmds.bbsLoc,node,loggedOnUser.slotNumber)

      aePuts('\b\n[32mPacking Messages\b\n')
      StringF(tempZoomFile,'\sNode\d/PlayPen/MESSAGES.DAT',cmds.bbsLoc,node)
      StringF(tempstr2,'\s \s \s',tempstr,FilePart(outputZoomName),FilePart(tempZoomFile))
      Execute(tempstr2,0,0)
      DeleteFile(tempZoomFile)
    CASE 0
      StringF(outputZoomName,'\sNode\d/PlayPen/AE\z\r\d[4].QWK',cmds.bbsLoc,node,loggedOnUser.slotNumber)

      aePuts('\b\n[32mPacking Control File\b\n')
      StringF(tempZoomFile,'\sNode\d/PlayPen/CONTROL.DAT',cmds.bbsLoc,node)
      StringF(tempstr2,'\s \s \s',tempstr,FilePart(outputZoomName),FilePart(tempZoomFile))
      Execute(tempstr2,0,0)
      DeleteFile(tempZoomFile)

      aePuts('\b\n[32mPacking Messages\b\n')
      StringF(tempZoomFile,'\sNode\d/PlayPen/MESSAGES.DAT',cmds.bbsLoc,node)
      StringF(tempstr2,'\s \s \s',tempstr,FilePart(outputZoomName),FilePart(tempZoomFile))
      Execute(tempstr2,0,0)
      DeleteFile(tempZoomFile)

      aePuts('\b\n[32mPacking Index File\b\n')
      StringF(tempZoomFile,'\sNode\d/PlayPen/MESSAGES.NDX',cmds.bbsLoc,node)
      StringF(tempstr2,'\s \s \s',tempstr,FilePart(outputZoomName),FilePart(tempZoomFile))
      Execute(tempstr2,0,0)
      DeleteFile(tempZoomFile)
  ENDSELECT

  IF oldlock<>0 THEN CurrentDir(oldlock)
  IF lock<>0 THEN UnLock(lock)

  IF fileExists(outputZoomName)
    SetComment(outputZoomName,'F')
    aePuts('\b\n')
    IF (logonType<>LOGON_TYPE_REMOTE) AND (checkSecurity(ACS_LOCAL_DOWNLOADS)=FALSE)
      aePuts('[33mNot supported locally...\b\n')
      RETURN RESULT_SUCCESS
    ENDIF
    convertToBCD(0,dTBT)
    convertToBCD(0,uTBT)
    dlTTTM:=0
    ulTTTM:=0
    tTEFF:=NIL
    tTCPS:=NIL
    aePuts('[33mPrepare for ZoomMail Zmodem Download:\b\n')
    mystat:=doPause()
    IF(mystat<0)
       DeleteFile(outputZoomName)
       RETURN mystat
    ENDIF
    setEnvStat(ENV_DOWNLOADING)
    downloadFile(outputZoomName)
    DeleteFile(outputZoomName)
  ELSE
    aePuts('[33mZoom did not produce any output to download\b\n')
  ENDIF
ENDPROC RESULT_SUCCESS

PROC asciiZoomConf(confNum,msgBaseNum,confNameType)
  DEF mystat,fi,fo,fi1,count,timeVar
  DEF cb:PTR TO confBase
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF date[255]:STRING
  DEF zoomName[255]:STRING
  DEF zoomConfMailName[31]:STRING
  DEF msgBaseLoc[255]:STRING

  loadMsgPointers(confNum,msgBaseNum)

  SELECT confNameType
    CASE NAME_TYPE_USERNAME
      StrCopy(zoomConfMailName,loggedOnUserKeys.userName,31)
    CASE NAME_TYPE_REALNAME
      StrCopy(zoomConfMailName,loggedOnUserMisc.realName,26)
    CASE NAME_TYPE_INTERNETNAME
      StrCopy(zoomConfMailName,loggedOnUserMisc.internetName,10)
   ENDSELECT

  IF checkToolTypeExists(TOOLTYPE_CONF,confNum,'CUSTOM')=FALSE
    mystat:=getMailStatFile(confNum,msgBaseNum)

    IF(mystat=RESULT_FAILURE) THEN RETURN RESULT_FAILURE
    IF(lastMsgReadConf<mailStat.lowestKey) THEN lastMsgReadConf:=mailStat.lowestKey
    IF(lastNewReadConf<mailStat.lowestKey) THEN lastNewReadConf:=mailStat.lowestKey

    IF(lastMsgReadConf>mailStat.highMsgNum) THEN lastMsgReadConf:=mailStat.highMsgNum
    IF(lastNewReadConf>mailStat.highMsgNum) THEN lastNewReadConf:=mailStat.highMsgNum
  ENDIF

  fo:=NIL

  cb:=confBases.item(getConfIndex(confNum,msgBaseNum))

  IF cb.handle[0] AND ZOOM_SCAN_MASK
    IF getConfMsgBaseCount(confNum)>1
      getMsgBaseName(confNum,msgBaseNum,tempstr2)
      StringF(tempstr,'[32mZooming Conference[33m: [0m  \s [\s]  ',getConfName(confNum),tempstr2)
    ELSE     
      StringF(tempstr,'[32mZooming Conference[33m: [0m  \s   ',getConfName(confNum))
    ENDIF
    aePuts(tempstr)
    mystat:=0

    IF checkToolTypeExists(TOOLTYPE_CONF,confNum,'CUSTOM')
      customMsgbaseCmd(MAIL_ZOOM,confNum,0)
      JUMP customAsciiDone
    ENDIF

    getMsgBaseLocation(confNum,msgBaseNum,msgBaseLoc)
    StringF(tempstr,'\sHeaderFile',msgBaseLoc)

    IF (fi:=Open(tempstr,MODE_OLDFILE))=0
      aePuts('Message Base does not exist\b\n')
      RETURN 0
    ENDIF

    StringF(zoomName,'\sNode\d/PlayPen/MESSAGES.DAT',cmds.bbsLoc,node)
    fo:=Open(zoomName,MODE_READWRITE)
    Seek(fo,0,OFFSET_END)
    IF(fo=0)
      Close(fi)
      RETURN 0
    ENDIF
    Seek(fo,0,OFFSET_END)

    currentSeekPos:=0
    msgNum:=lastMsgReadConf
    count:=0
    WHILE ((msgNum<mailStat.highMsgNum) AND (count<200) AND (mystat<>RESULT_FAILURE))
      mystat:=loadMessageHeader(fi)
      IF(mystat<>RESULT_FAILURE)

        IF(logonType>=LOGON_TYPE_REMOTE)
          IF(checkCarrier()=FALSE)
            Close(fo)
            Close(fi)
            RETURN RESULT_NO_CARRIER
          ENDIF
        ENDIF

        checkDoorMsg(0)
        IF(StriCmp(mailHeader.toName,zoomConfMailName)) OR (StriCmp(mailHeader.fromName,zoomConfMailName)) OR (mailHeader.status="P")  OR (mailHeader.status="p") OR (checkSecurity(ACS_SYSOP_READ))
          IF(((mailHeader.recv=FALSE) OR (checkSecurity(ACS_SYSOP_READ))) AND (mailHeader.status<>"D"))
            timeVar:=mailHeader.msgDate
            formatLongDate(timeVar,date)
            StringF(tempstr,'\nDate   : \l\s[30]  Number: \d\n',date,mailHeader.msgNumb)
            fileWrite(fo,tempstr)
            StrCopy(date,mailHeader.toName)
            IF(StriCmp(date,'eall',4))
              StrCopy(date,zoomConfMailName)
              StrAdd(date,' (ALL)')
            ELSE
              StrCopy(date,mailHeader.toName)
            ENDIF
            StringF(tempstr,'To     : \l\s[30]  ',date)
            fileWrite(fo,tempstr)

            IF(mailHeader.recv<>0)
              timeVar:=mailHeader.recv
              formatLongDate(timeVar,date)
              StringF(tempstr,'Recv''d: \l\s\n',date)
              fileWrite(fo,tempstr)
            ELSE
              fileWrite(fo,'Recv''d: ')
              IF(StriCmp(mailHeader.toName,'ALL'))
                fileWrite(fo,'N/A\n')
              ELSE
                fileWrite(fo,'No\n')
              ENDIF
            ENDIF

            IF(mailHeader.status="P") OR (mailHeader.status="p")
              StrCopy(tempstr,'Public Message')
            ELSE
              StrCopy(tempstr,'Receiver Only')
            ENDIF

            StringF(tempstr2,'From   : \l\s[30]  Status: \s\n',mailHeader.fromName,tempstr)
            fileWrite(fo,tempstr2)
            StringF(tempstr2,'Subject: \s\n',mailHeader.subject)
            fileWrite(fo,tempstr2)
            StringF(tempstr2,'Conf   : [\d] \s\n\n',relConf(confNum),getConfName(confNum))
            fileWrite(fo,tempstr2)
            StringF(tempstr2,'\s\d',msgBaseLoc,mailHeader.msgNumb)
            IF(fi1:=Open(tempstr2,MODE_OLDFILE))<>0
              WHILE(Fgets(fi1,tempstr,80)<>NIL)
                fileWrite(fo,tempstr)
              ENDWHILE
              fileWrite(fo,'\n==========================================================================\n\n');
              Close(fi1)
              count++
              aePuts('.')
            ENDIF
          ENDIF
        ENDIF
        msgNum++

      ENDIF
    ENDWHILE

    IF msgNum>mailStat.highMsgNum THEN msgNum:=mailStat.highMsgNum

    Close(fi)
    Close(fo)
    lastMsgReadConf:=msgNum

customAsciiDone:
    saveMsgPointers(confNum,msgBaseNum)

    IF (count=0)
      aePuts('\tNo New Mail!\b\n')
    ELSE
      aePuts('\b\n')
    ENDIF
  ELSE
    RETURN RESULT_ABORT
  ENDIF

ENDPROC count

PROC asciiZoom()
  DEF conf,cnt,msgbase
  DEF mystat,zoomConfNameType
  DEF tempStr1[255]:STRING
  DEF tempStr2[255]:STRING
  DEF zoomName[255]:STRING

  StringF(zoomName,'\sNode\d/PlayPen/MESSAGES.DAT',cmds.bbsLoc,node)
  DeleteFile(zoomName)

  saveMsgPointers(currentConf,currentMsgBase)
  cnt:=0
  FOR conf:=1 TO cmds.numConf
    IF (checkConfAccess(conf))
      FOR msgbase:=1 TO getConfMsgBaseCount(conf)
        zoomConfNameType:=NAME_TYPE_USERNAME
        StringF(tempStr1,'REALNAME.\d',msgbase)
        StringF(tempStr2,'INTERNETNAME.\d',msgbase)
        IF checkToolTypeExists(TOOLTYPE_CONF,conf,'REALNAME') OR checkToolTypeExists(TOOLTYPE_MSGBASE,conf,tempStr1)
          zoomConfNameType:=NAME_TYPE_REALNAME
        ELSEIF checkToolTypeExists(TOOLTYPE_CONF,conf,'INTERNETNAME') OR checkToolTypeExists(TOOLTYPE_MSGBASE,conf,tempStr2)
          zoomConfNameType:=NAME_TYPE_INTERNETNAME
        ENDIF

        mystat:=asciiZoomConf(conf,msgbase,zoomConfNameType)
        IF mystat<>RESULT_ABORT THEN cnt++
      ENDFOR
    ENDIF
    EXIT mystat=RESULT_FAILURE
    IF (mystat=RESULT_TIMEOUT) OR (mystat=RESULT_NO_CARRIER)
      loadMsgPointers(currentConf,currentMsgBase)
      RETURN mystat
    ENDIF
  ENDFOR

  IF cnt=0
    aePuts('No conferences selected for zooming. Use CF to configure\b\n')
    RETURN RESULT_ABORT
  ENDIF

  loadMsgPointers(currentConf,currentMsgBase)
ENDPROC RESULT_SUCCESS

PROC qwkZoomConf(confNum,msgBaseNum,recNum,confNameType)
  DEF mystat,fi,fo,fo2,count
  DEF cb:PTR TO confBase
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF date[255]:STRING
  DEF time[255]:STRING
  DEF zoomName[255]:STRING
  DEF i,j,status,msgLen
  DEF ndx:qwkNDX
  DEF cnt
  DEF zoomConfMailName[31]:STRING
  DEF msgBaseLoc[255]:STRING

  loadMsgPointers(confNum,msgBaseNum)

  SELECT confNameType
    CASE NAME_TYPE_USERNAME
      StrCopy(zoomConfMailName,loggedOnUserKeys.userName,31)
    CASE NAME_TYPE_REALNAME
      StrCopy(zoomConfMailName,loggedOnUserMisc.realName,26)
    CASE NAME_TYPE_INTERNETNAME
      StrCopy(zoomConfMailName,loggedOnUserMisc.internetName,10)
  ENDSELECT

  IF checkToolTypeExists(TOOLTYPE_CONF,confNum,'CUSTOM')=FALSE
    mystat:=getMailStatFile(confNum,msgBaseNum)

    IF(mystat=RESULT_FAILURE) THEN RETURN RESULT_FAILURE,recNum
    IF(lastMsgReadConf<mailStat.lowestKey) THEN lastMsgReadConf:=mailStat.lowestKey
    IF(lastNewReadConf<mailStat.lowestKey) THEN lastNewReadConf:=mailStat.lowestKey

    IF(lastMsgReadConf>mailStat.highMsgNum) THEN lastMsgReadConf:=mailStat.highMsgNum
    IF(lastNewReadConf>mailStat.highMsgNum) THEN lastNewReadConf:=mailStat.highMsgNum
  ENDIF

  fo:=NIL

  cb:=confBases.item(getConfIndex(confNum,msgBaseNum))

  IF cb.handle[0] AND ZOOM_SCAN_MASK
    IF getConfMsgBaseCount(confNum)>1
      getMsgBaseName(confNum,msgBaseNum,tempstr2)
      StringF(tempstr,'[32mZooming Conference[33m: [0m  \s [\s]  ',getConfName(confNum),tempstr2)
    ELSE     
      StringF(tempstr,'[32mZooming Conference[33m: [0m  \s   ',getConfName(confNum))
    ENDIF
    aePuts(tempstr)
    mystat:=0

    IF checkToolTypeExists(TOOLTYPE_CONF,confNum,'CUSTOM')
      customMsgbaseCmd(MAIL_ZOOM,confNum,0)
      JUMP customQwkDone
    ENDIF

    getMsgBaseLocation(confNum,msgBaseNum,msgBaseLoc)

    StringF(tempstr,'\sHeaderFile',msgBaseLoc)

    IF (fi:=Open(tempstr,MODE_OLDFILE))=0
      aePuts('Message Base does not exist\b\n')
      RETURN 0,recNum
    ENDIF

    StringF(zoomName,'\sNode\d/PlayPen/MESSAGES.DAT',cmds.bbsLoc,node)
    fo:=Open(zoomName,MODE_READWRITE)
    Seek(fo,0,OFFSET_END)
    IF(fo=0)
      Close(fi)
      RETURN 0,recNum
    ENDIF

    StringF(zoomName,'\sNode\d/PlayPen/MESSAGES.NDX',cmds.bbsLoc,node)
    fo2:=Open(zoomName,MODE_READWRITE)
    Seek(fo2,0,OFFSET_END)
    IF(fo2=0)
      Close(fo)
      Close(fi)
      RETURN 0,recNum
    ENDIF

    currentSeekPos:=0
    msgNum:=lastMsgReadConf
    count:=0
    WHILE ((msgNum<mailStat.highMsgNum) AND (count<200) AND (mystat<>RESULT_FAILURE))
      mystat:=loadMessageHeader(fi)
      IF(mystat<>RESULT_FAILURE)

        IF(logonType>=LOGON_TYPE_REMOTE)
          IF(checkCarrier()=FALSE)
            Close(fo)
            Close(fo2)
            Close(fi);
            RETURN RESULT_NO_CARRIER,recNum
          ENDIF
        ENDIF

        checkDoorMsg(0)
        IF(StriCmp(mailHeader.toName,zoomConfMailName)) OR (StriCmp(mailHeader.fromName,zoomConfMailName)) OR (mailHeader.status="P") OR (mailHeader.status="p") OR (checkSecurity(ACS_SYSOP_READ))
          IF(((mailHeader.recv=FALSE) OR (checkSecurity(ACS_SYSOP_READ))) AND (mailHeader.status<>"D"))

            IF (mailHeader.status="P") OR (mailHeader.status="p")
              IF mailHeader.recv>0
                status:="-"
              ELSE
                status:=" "
              ENDIF
            ELSE
              status:="*"
            ENDIF

            formatLongDate(mailHeader.msgDate,date)
            formatLongTime(mailHeader.msgDate,time)
            SetStr(time,5)

            StringF(tempstr,'\s\d',msgBaseLoc,mailHeader.msgNumb)
            mystat:=loadMsg(tempstr)
            IF(mystat=FALSE)
              lines:=1
              msgBuf.setItem(0,'MESSAGE IS MISSING\n')
            ENDIF

            msgLen:=0
            FOR i:=0 TO lines-1
              msgLen:=msgLen+StrLen(msgBuf.item(i))+1
            ENDFOR
            msgLen:=msgLen+127
            msgLen:=Shr(msgLen,7)     ->divide by 128

            ->append to MESSAGES.DAT
            StringF(tempstr,'\s[128]','')
            StringF(tempstr,'\c\z\r\d[7]\l\s[8]\l\s[5]\l\s[25]\l\s[25]\l\s[25]                    \l\d[6]\c\c\c   ',status,mailHeader.msgNumb,
                date,time,mailHeader.toName,mailHeader.fromName,mailHeader.subject,msgLen+1,$E1,confNum,0)
            cnt:=Write(fo,tempstr,128)
            IF cnt<>128 THEN aePuts('error writing mail file')

            StrCopy(tempstr2,'')
            FOR i:=0 TO lines-1
              StringF(tempstr,'\s\c',msgBuf.item(i),$e3)
              StrAdd(tempstr2,tempstr)
              IF (StrLen(tempstr2)>=128)
                cnt:=Write(fo,tempstr2,128)
                IF cnt<>128 THEN aePuts('error writing mail file')
                FOR j:=128 TO StrLen(tempstr2)-1
                  tempstr2[j-128]:=tempstr2[j]
                ENDFOR
                SetStr(tempstr2,StrLen(tempstr2)-128)
              ENDIF
            ENDFOR
            IF StrLen(tempstr2)>0
              StringF(tempstr,'\l\s[128]',tempstr2)
              cnt:=Write(fo,tempstr,128)
              IF cnt<>128 THEN aePuts('error writing mail file')
            ENDIF

            ->append to MESSAGES.NDX
            ndx.recNum:=recNum
            ndx.conf:=confNum
            cnt:=Write(fo2,ndx,5)   ->SHOULD BE SIZEOF qwkNDX but it pads it to even size
            IF cnt<>5 THEN aePuts('error writing mail file')
            count++
          ENDIF
        ENDIF
        msgNum++
        recNum:=recNum+1.0

      ENDIF
    ENDWHILE
    IF msgNum>mailStat.highMsgNum THEN msgNum:=mailStat.highMsgNum

    Close(fi)
    Close(fo)
    Close(fo2)
    lastMsgReadConf:=msgNum

customQwkDone:
    saveMsgPointers(confNum,msgBaseNum)

    IF (count=0)
      aePuts('\tNo New Mail!\b\n')
    ELSE
      aePuts('\b\n')
    ENDIF
  ELSE
    RETURN RESULT_ABORT,recNum
  ENDIF

ENDPROC count,recNum

PROC qwkZoom()
  DEF conf,cnt,msgbase
  DEF mystat,n
  DEF zoomName[255]:STRING
  DEF fo,count
  DEF tempstr[255]:STRING
  DEF namestr1[255]:STRING
  DEF namestr2[255]:STRING
  DEF zoomConfNameType

  StringF(zoomName,'\sNode\d/PlayPen/MESSAGES.DAT',cmds.bbsLoc,node)
  DeleteFile(zoomName)

  StringF(zoomName,'\sNode\d/PlayPen/MESSAGES.NDX',cmds.bbsLoc,node)
  DeleteFile(zoomName)

  ->CREATE CONTROL.DAT
  StringF(zoomName,'\sNode\d/PlayPen/CONTROL.DAT',cmds.bbsLoc,node)
  fo:=Open(zoomName,MODE_NEWFILE)
  IF(fo=0)
    RETURN 0
  ENDIF
  fileWriteLn(fo,cmds.bbsName)
  StrCopy(tempstr,'N/A')
  readToolType(TOOLTYPE_QWKCONFIG,'','BBS.ADDRESS',tempstr)
  fileWrite(fo,tempstr); fileWrite(fo,'\b\n')
  StrCopy(tempstr,'N/A')
  readToolType(TOOLTYPE_QWKCONFIG,'','BBS.NUMBER',tempstr)
  fileWrite(fo,tempstr); fileWrite(fo,'\b\n')
  StringF(tempstr,'\s, Sysop',cmds.sysopName)
  fileWrite(fo,tempstr); fileWrite(fo,'\b\n')

  StrCopy(tempstr,'AMXBBS')
  readToolType(TOOLTYPE_QWKCONFIG,'','BBS.ID',tempstr)
  IF StrLen(tempstr)>6 THEN SetStr(tempstr,6)
  fileWrite(fo,'000000,')
  fileWrite(fo,tempstr); fileWrite(fo,'\b\n')
  formatLongDateTime2(getSystemTime(),tempstr,",")
  fileWrite(fo,tempstr); fileWrite(fo,'\b\n')
  StrCopy(tempstr,loggedOnUser.name)
  UpperStr(tempstr)
  fileWrite(fo,tempstr); fileWrite(fo,'\b\n')
  fileWrite(fo,'\b\n')
  fileWrite(fo,'0\b\n')
  fileWrite(fo,'0\b\n')

  count:=0
  FOR conf:=1 TO cmds.numConf
    IF (checkConfAccess(conf)) THEN count:=count+getConfMsgBaseCount(conf)
  ENDFOR
  StringF(tempstr,'\d\b\n',count-1)
  fileWrite(fo,tempstr)
  n:=1
  FOR conf:=1 TO cmds.numConf
    IF (checkConfAccess(conf))
      FOR msgbase:=1 TO getConfMsgBaseCount(conf)
        StringF(tempstr,'\d\b\n',n)
        fileWrite(fo,tempstr)
        getMsgBaseName(conf,msgbase,tempstr)
        IF StrLen(tempstr)>10 THEN SetStr(tempstr,10)
        StrAdd(tempstr,'\b\n')
        fileWrite(fo,tempstr)
        n++
      ENDFOR
    ENDIF
  ENDFOR
  fileWrite(fo,'HELLO\b\n')
  fileWrite(fo,'NEWS\b\n')
  fileWrite(fo,'GOODBYE\b\n')
  Close(fo)

  StringF(zoomName,'\sNode\d/PlayPen/MESSAGES.DAT',cmds.bbsLoc,node)
  fo:=Open(zoomName,MODE_NEWFILE)
  IF(fo=0)
    DeleteFile(zoomName)
    RETURN 0
  ENDIF

  ->append signature bytes to messages.dat
  StringF(tempstr,'\l\s[128]','CopyRight Sparkware')
  fileWrite(fo,tempstr)
  Close(fo)

  floatMsgRecNum:=1.0
  cnt:=0

  saveMsgPointers(currentConf,currentMsgBase)
  FOR conf:=1 TO cmds.numConf
    IF (checkConfAccess(conf))
      FOR msgbase:=1 TO getConfMsgBaseCount(conf)
        zoomConfNameType:=NAME_TYPE_USERNAME
        StringF(namestr1,'REALNAME.\d',msgbase)
        StringF(namestr2,'INTERNETNAME.\d',msgbase)
        IF checkToolTypeExists(TOOLTYPE_CONF,conf,'REALNAME') OR checkToolTypeExists(TOOLTYPE_MSGBASE,conf,namestr1)
          zoomConfNameType:=NAME_TYPE_REALNAME
        ELSEIF checkToolTypeExists(TOOLTYPE_CONF,conf,'INTERNETNAME') OR checkToolTypeExists(TOOLTYPE_MSGBASE,conf,namestr2)
          zoomConfNameType:=NAME_TYPE_INTERNETNAME
        ENDIF
        mystat,floatMsgRecNum:=qwkZoomConf(conf,msgbase,floatMsgRecNum,zoomConfNameType)
        IF mystat<>RESULT_ABORT THEN cnt++
      ENDFOR
    ENDIF
    EXIT mystat=RESULT_FAILURE
    IF (mystat=RESULT_TIMEOUT) OR (mystat=RESULT_NO_CARRIER)
      loadMsgPointers(currentConf,currentMsgBase)
      RETURN mystat
    ENDIF
  ENDFOR
  loadMsgPointers(currentConf,currentMsgBase)

  IF cnt=0
    aePuts('No conferences selected for zooming. Use CF to configure\b\n')
    RETURN RESULT_ABORT
  ENDIF
ENDPROC RESULT_SUCCESS

PROC getDirSpan(pass:PTR TO CHAR)
  DEF str[200]:STRING
  DEF mystat
  DEF dirScan=0,startDir=0

  IF(StrLen(pass)=0)
    IF (loggedOnUser.secStatus>=holdAccessLevel) OR (checkSecurity(ACS_HOLD_ACCESS))
      StringF(str,'[36mDirectories: [32m([33m1-\d[32m)[36m, [32m([33mA[32m)[36mll, [32m([33mU[32m)[36mpload, [32m([33mH[32m)[36mold, [32m([33mEnter[32m)[36m=none? [0m',maxDirs)
    ELSE
      StringF(str,'[36mDirectories: [32m([33m1-\d[32m)[36m, [32m([33mA[32m)[36mll, [32m([33mU[32m)[36mpload, [32m([33mEnter[32m[32m)[36m=none? [0m',maxDirs)
    ENDIF
    aePuts(str)
    mystat:=lineInput('','',8,INPUT_TIMEOUT,str)
    IF(mystat<0) THEN RETURN RESULT_NO_CARRIER
    IF(StrLen(str)=0)
      aePuts('\b\n')
      RETURN RESULT_FAILURE,startDir,dirScan
    ENDIF
  ELSE
    StrCopy(str,pass)
  ENDIF

  ->  gnsflag=CheckForNS(str);             /* check for Non-Stop */

  IF((str[0]="U") OR (str[0]="u"))   /* Scan only upload directory */
    dirScan:=maxDirs
    startDir:=dirScan
    JUMP mNCont
  ENDIF
  IF((str[0]="A") OR (str[0]="a"))                /* scan all dirs */
    dirScan:=maxDirs
    startDir:=1
    JUMP mNCont
  ENDIF
  IF((str[0]="L") OR (str[0]="l"))
    dirScan:=0
    startDir:=0
    JUMP mNCont
  ENDIF
  IF(((str[0]="H") OR (str[0]="h")) AND ((loggedOnUser.secStatus>=holdAccessLevel) OR (checkSecurity(ACS_HOLD_ACCESS))))
    dirScan:=-1
    startDir:=-1
    JUMP mNCont
  ENDIF
  ->strcat(str," ");
  dirScan:=Val(str)
  ->sscanf(str,"%d",&DirScan);
  IF((dirScan>maxDirs) OR (dirScan<1))
    aePuts('\b\nNo such directory.\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF
  startDir:=dirScan

mNCont:
  ->  nonStopDisplayFlag:=CheckForNS(str);
ENDPROC RESULT_SUCCESS,startDir,dirScan

PROC maintenanceFileDelete(dirname:PTR TO CHAR, srchold, fname:PTR TO CHAR,matchposition)
  DEF oldDirName[255]:STRING
  DEF fh1,fh2
  DEF dirline[255]:STRING
  DEF compareFname[255]:STRING
  DEF padfname[255]:STRING
  DEF path[255]:STRING
  DEF found,drivenum,currpos,foundit

  StrCopy(padfname,fname)
  UpperStr(padfname)

  ->pad fname to 12 charactesr
  StrAdd(padfname,'            ')
  SetStr(padfname,12)

  StrCopy(path,dirname)
  getFileName(path)      ->get the actual name for the file so we can preserve the casing
  StringF(dirname,'\s\s',currentConfDir,path)

  StrCopy(oldDirName,dirname)
  StrAdd(oldDirName,'.old')

  aePuts('\b\nRemoving from directory list, please wait..')

  DeleteFile(oldDirName)

  IF Rename(dirname,oldDirName) = FALSE
    aePuts('\b\nError during operation, delete operation aborted.\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  foundit:=FALSE

  IF (fh1:=Open(dirname,MODE_NEWFILE))<>0
    IF (fh2:=Open(oldDirName,MODE_OLDFILE))<>0
      found:=0
      currpos:=Seek(fh2,0,OFFSET_CURRENT)
      WHILE(Fgets(fh2,dirline,255)<>NIL)
        IF(dirLineNewFile(dirline))
          StrCopy(compareFname,dirline,12)
          UpperStr(compareFname)
          IF(StrCmp(compareFname,padfname)) AND (currpos=matchposition)
            found:=1
            foundit:=TRUE
          ELSE
            found:=0
          ENDIF
        ENDIF

        IF found=0
          Fputs(fh1,dirline)
        ENDIF
        currpos:=Seek(fh2,0,OFFSET_CURRENT)
      ENDWHILE

      Close(fh1)
      Close(fh2)

      IF foundit=FALSE
        DeleteFile(dirname)

        ->put the old file back
        Rename(oldDirName,dirname)

        aePuts('\b\nError updating directory list, delete operation aborted.\b\n')
        RETURN RESULT_FAILURE
      ENDIF

      DeleteFile(oldDirName)

      IF srchold
        aePuts('\b\nRemoving from hold folder, please wait..')
        StringF(path,'\sHold/\s',currentConfDir,fname)
        DeleteFile(path)
      ELSE
        aePuts('\b\nRemoving from download folder, please wait..')
        drivenum:=1
        StringF(path,'DLPATH.\d',drivenum++)
        WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,path))
          checkPathSlash(path)
          StrAdd(path,fname)
          DeleteFile(path)
          StringF(path,'DLPATH.\d',drivenum++)
        ENDWHILE
      ENDIF
      aePuts('\b\n\b\nDelete operation complete \b\n')
    ELSE
      Close(fh1)
      DeleteFile(dirname)

      ->put the old file back
      Rename(oldDirName,dirname)
      aePuts('\b\nError reading directory list, delete operation aborted.\b\n')
      RETURN RESULT_FAILURE
    ENDIF
  ELSE
    ->put the old file back
    Rename(oldDirName,dirname)
    aePuts('\b\nError creating the new directory list, delete operation aborted.\b\n')
    RETURN RESULT_FAILURE
  ENDIF

ENDPROC RESULT_SUCCESS

PROC maintenanceFileMove(dirname:PTR TO CHAR, srchold, fname:PTR TO CHAR,datestr:PTR TO CHAR,matchposition)
  DEF oldDirName[255]:STRING
  DEF oldDestDirName[255]:STRING
  DEF fh1,fh2,fh3,fh4
  DEF dirline[255]:STRING
  DEF dirline2[255]:STRING
  DEF tempstr[255]:STRING
  DEF destFile[255]:STRING
  DEF destDate[20]:STRING
  DEF compareFname[255]:STRING
  DEF padfname[255]:STRING
  DEF path[255]:STRING
  DEF found,drivenum,drivenum2
  DEF destConfStr[255]:STRING
  DEF destDirStr[255]:STRING
  DEF d1,d2,brk,filemoved,status,n
  DEF destConf,destDir,stat,maxConfDir
  DEF currpos

  REPEAT
    stat:=lineInput('\b\nConference Number to move to (L to List): ','',5,INPUT_TIMEOUT,destConfStr)
    IF stat<>RESULT_SUCCESS THEN RETURN stat

    IF StrLen(destConfStr)=0 THEN RETURN RESULT_SUCCESS

    IF ((StrCmp(destConfStr,'L')) OR (StrCmp(destConfStr,'l')))
      aePuts('\b\n')
      aePuts('                                 [32mConference List\b\n')
      aePuts('\b\n')
      processMciCmd('~CL|',4,0)
      n:=FALSE
    ELSE
      n:=TRUE
    ENDIF
  UNTIL n

  d1:=getDateCompareVal(datestr)

  destConf:=getInverse(Val(destConfStr))

  IF destConf<1 THEN destConf:=1
  IF destConf>cmds.numConf THEN destConf:=cmds.numConf

  IF(checkConfAccess(destConf)=FALSE)
    aePuts('\b\nYou do not have access to the requested conference\b\n\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  StringF(tempstr,'\b\nYou have chosen conference: \s\b\n',getConfName(destConf))
  aePuts(tempstr)

  maxConfDir:=readToolTypeInt(TOOLTYPE_CONF,destConf,'NDIRS')

  StringF(tempstr,'\b\nDirectory to move to: (1-\d), (A)uto, (Enter)=abort? ',maxConfDir)
  aePuts(tempstr)
  stat:=lineInput('','',5,INPUT_TIMEOUT,destDirStr)

  IF stat<>RESULT_SUCCESS THEN RETURN stat

  IF StrLen(destDirStr)=0 THEN RETURN RESULT_SUCCESS

  IF (destDirStr[0]="A") OR (destDirStr[0]="a")
    destDir:=-1
    stat:=maxConfDir
    WHILE (destDir=-1) AND (stat>0)
      StringF(path,'\sDIR\d',getConfLocation(destConf),stat)
      IF (fh1:=Open(path,MODE_OLDFILE))<>0
        Fgets(fh1,dirline,255)
        dirline[13]:=" "
        parseParams(dirline)
        IF parsedParams.count()>2
          StrCopy(destDate,parsedParams.item(2))
          IF (StrLen(destDate)=8) AND (destDate[2]="-") AND (destDate[5]="-")
            d2:=getDateCompareVal(destDate)
            IF d1>=d2 THEN destDir:=stat
          ENDIF
        ENDIF

        Close(fh1)
      ENDIF
      stat--
    ENDWHILE
    IF destDir=-1 THEN destDir:=1
  ELSE
    destDir:=Val(destDirStr)
    IF (destDir<1) OR (destDir>maxConfDir) THEN RETURN RESULT_SUCCESS
  ENDIF

  StrCopy(padfname,fname)
  UpperStr(padfname)

  ->pad fname to 12 charactesr
  StrAdd(padfname,'            ')
  SetStr(padfname,12)

  StringF(path,'\sDIR\d',getConfLocation(destConf),destDir)
  getFileName(path)      ->get the actual name for the file so we can preserve the casing
  StringF(destDirStr,'\s\s',getConfLocation(destConf),path)

  StrCopy(path,dirname)
  getFileName(path)      ->get the actual name for the file so we can preserve the casing
  StringF(dirname,'\s\s',currentConfDir,path)

  StrCopy(oldDirName,dirname)
  StrAdd(oldDirName,'.old')

  StrCopy(oldDestDirName,destDirStr)
  StrAdd(oldDestDirName,'.old')

  filemoved:=FALSE

  aePuts('\b\nUpdating directory list, please wait..')

  DeleteFile(oldDirName)
  IF Rename(dirname,oldDirName)=FALSE
    aePuts('\b\nError accessing the directory list, move operation aborted.\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  DeleteFile(oldDestDirName)
  IF Rename(destDirStr,oldDestDirName)=FALSE
    Rename(oldDirName,dirname)
    aePuts('\b\nError accessing the destination directory list, move operation aborted.\b\n')
    RETURN RESULT_FAILURE
  ENDIF

  IF (fh1:=Open(dirname,MODE_NEWFILE))<>0
    IF (fh2:=Open(oldDirName,MODE_OLDFILE))<>0
      IF (fh3:=Open(destDirStr,MODE_NEWFILE))<>0
        IF (fh4:=Open(oldDestDirName,MODE_OLDFILE))<>0
          found:=0
          currpos:=Seek(fh2,0,OFFSET_CURRENT)
          WHILE(Fgets(fh2,dirline,255)<>NIL)
            IF(dirLineNewFile(dirline))
              StrCopy(compareFname,dirline,12)
              UpperStr(compareFname)
              IF(StrCmp(compareFname,padfname)) AND (currpos=matchposition)
                found:=1
                filemoved:=TRUE
                brk:=FALSE
                ->we've found our file in the source dir, scan the dest dir for the correct position to put it
                WHILE(Fgets(fh4,dirline2,255)<>NIL)
                  IF(dirLineNewFile(dirline2))
                    StrCopy(tempstr,dirline2)
                    tempstr[13]:=" "
                    parseParams(tempstr)

                    IF parsedParams.count()>2
                      StrCopy(destDate,parsedParams.item(2))
                      IF (StrLen(destDate)=8) AND (destDate[2]="-") AND (destDate[5]="-")
                        d2:=getDateCompareVal(destDate)
                        brk:=(d2>=d1)
                      ENDIF
                    ENDIF
                  ENDIF
                  EXIT brk
                  ->copy the line from the old dest dir to the new dest dir
                  Fputs(fh3,dirline2)
                ENDWHILE
              ELSE
                IF (found=1)
                  ->we've found the end of the file being moved in the source dir, copy the remainder of the dest dir over
                  IF brk THEN Fputs(fh3,dirline2)
                  WHILE(Fgets(fh4,dirline2,255)<>NIL)
                    Fputs(fh3,dirline2)
                  ENDWHILE
                  found:=0
                ENDIF
              ENDIF
            ENDIF

            IF found=1
              ->copy the line from the old source dir to the new dest dir
              Fputs(fh3,dirline)
            ELSE
              ->copy the line back to the new source dir
              Fputs(fh1,dirline)
            ENDIF
            currpos:=Seek(fh2,0,OFFSET_CURRENT)
          ENDWHILE

          IF (found=1)
            ->if we still haven't copied over the remainder of the dest file then do it now
            IF brk THEN Fputs(fh3,dirline2)
            WHILE(Fgets(fh4,dirline2,255)<>NIL)
              Fputs(fh3,dirline2)
            ENDWHILE
            found:=0
          ENDIF

          Close(fh1)
          Close(fh2)
          Close(fh3)
          Close(fh4)

          drivenum:=1
          StringF(path,'ULPATH.\d',drivenum)

          IF((readToolType(TOOLTYPE_CONF,destConf,path,tempstr))=FALSE) OR (filemoved=FALSE)
            checkPathSlash(tempstr)
            DeleteFile(dirname)

            ->put the old file back
            Rename(oldDirName,dirname)

            DeleteFile(destDirStr)

            ->put the old file back
            Rename(oldDestDirName,destDirStr)

            IF filemoved=FALSE
              aePuts('\b\n failed to update directory list, move operation aborted.\b\n')
            ELSE
              aePuts('\b\n Error reading upload directory, move operation aborted.\b\n')
            ENDIF
            RETURN RESULT_FAILURE
          ENDIF

          aePuts('\b\nMoving file, please wait..')
          drivenum:=1
          filemoved:=FALSE

          IF srchold
            StringF(path,'\sHold/\s',currentConfDir,fname)

            StringF(destFile,'\s\s',tempstr,fname)

            IF (fileExists(path))
              status:=Rename(path,destFile)
              IF(status=FALSE)
                status:=fileCopy(path,destFile)
                IF(status)
                  SetProtection(path,FIBF_OTR_DELETE)
                  DeleteFile(path)
                  filemoved:=TRUE
                ENDIF
              ELSE
                filemoved:=TRUE
              ENDIF
            ENDIF
          ELSE
            StringF(path,'DLPATH.\d',drivenum++)
            WHILE(readToolType(TOOLTYPE_CONF,currentConf,path,path)) AND (filemoved=FALSE)
              checkPathSlash(path)
              IF StriCmp(path,tempstr)=FALSE
                StrAdd(path,fname)

                StringF(destFile,'\s\s',tempstr,fname)

                IF (fileExists(path))
                  drivenum2:=1
                  WHILE (filemoved=FALSE) AND (drivenum2<>-1)
                    status:=Rename(path,destFile)
                    IF(status=FALSE)
                      status:=fileCopy(path,destFile)
                      IF(status)
                        SetProtection(path,FIBF_OTR_DELETE)
                        DeleteFile(path)
                        filemoved:=TRUE
                      ELSE
                        ->try the next upload path
                        drivenum2++
                        StringF(path,'ULPATH.\d',drivenum2)
                        IF(readToolType(TOOLTYPE_CONF,destConf,path,tempstr))
                          checkPathSlash(tempstr)
                          StringF(destFile,'\s\s',tempstr,fname)
                        ELSE
                          ->no more paths to try
                          drivenum2:=-1
                        ENDIF
                      ENDIF
                    ELSE
                      filemoved:=TRUE
                    ENDIF
                  ENDWHILE
                ENDIF
              ELSE
                filemoved:=TRUE
              ENDIF
              StringF(path,'DLPATH.\d',drivenum++)
            ENDWHILE
          ENDIF

          IF (filemoved)
            DeleteFile(oldDirName)
            DeleteFile(oldDestDirName)
            aePuts('\b\n\b\nMove operation successful \b\n')
          ELSE
            DeleteFile(dirname)

            ->put the old file back
            Rename(oldDirName,dirname)

            DeleteFile(destDirStr)

            ->put the old file back
            Rename(oldDestDirName,destDirStr)

            aePuts('\b\n\b\nMove operation failed, restoring directories \b\n')
            RETURN RESULT_FAILURE
          ENDIF

        ELSE
          Close(fh3)
          Close(fh2)
          Close(fh1)

          DeleteFile(dirname)

          ->put the old file back
          Rename(oldDirName,dirname)

          DeleteFile(destDirStr)

          ->put the old file back
          Rename(oldDestDirName,destDirStr)

          aePuts('\b\n Error reading directory list, move operation aborted.\b\n')
          RETURN RESULT_FAILURE
        ENDIF
      ELSE
        Close(fh2)
        Close(fh1)

        DeleteFile(dirname)

        ->put the old file back
        Rename(oldDirName,dirname)

        ->put the old file back
        Rename(oldDestDirName,destDirStr)
        aePuts('\b\n Error creating the new directory list, move operation aborted.\b\n')
        RETURN RESULT_FAILURE
      ENDIF
    ELSE
      Close(fh1)
      DeleteFile(dirname)

      ->put the old file back
      Rename(oldDirName,dirname)
      aePuts('\b\nError reading directory list, delete operation aborted.\b\n')
      RETURN RESULT_FAILURE
    ENDIF
  ELSE
    ->put the old file back
    Rename(oldDirName,dirname)
    aePuts('\b\nError creating the new directory list, delete operation aborted.\b\n')
    RETURN RESULT_FAILURE
  ENDIF

ENDPROC RESULT_SUCCESS

PROC maintenanceFileSearch(holddir,fname:PTR TO CHAR,searchList: PTR TO stringlist,outfname: PTR TO CHAR, outfiledate: PTR TO CHAR,startposition)
  DEF fi,found=FALSE
  DEF image[258]:ARRAY OF CHAR
  DEF tempStr[258]:STRING
  DEF dirfname[12]:STRING
  DEF gi1,count=0,loop,ch,i
  DEF datestr[258]:STRING
  DEF test:PTR TO CHAR
  DEF viewAllowed,prev
  DEF patternBuf,patBufLen


  fi:=Open(fname,MODE_OLDFILE)
  IF(fi=0)
    RETURN RESULT_NOT_FOUND,0,0
  ENDIF

  Seek(fi,startposition,OFFSET_BEGINNING)

  viewAllowed:=checkSecurity(ACS_VIEW_A_FILE)
  IF holddir THEN viewAllowed:=FALSE

  WHILE(Fgets(fi,image,252)<>NIL)
    stripReturn(image)
    IF(checkInput())
      gi1:=readChar(1)
      IF gi1=3  /*  ctrl-c */
        Close(fi)
        aePuts('**Break\b\n')
        RETURN RESULT_FAILURE,0,0
      ENDIF
    ENDIF
    IF(dirLineNewFile(image))
      StrCopy(dirfname,image,12)
      StrCopy(tempStr,image,12)
      i:=0
      WHILE tempStr[i]<>" "
        i++
      ENDWHILE
      SetStr(tempStr,i)

      patBufLen:=StrLen(tempStr)*2+2
      patternBuf:=New(patBufLen)
      IF patternBuf=0
        Close(fi)
        myError(1)
        RETURN RESULT_FAILURE,0,0
      ENDIF

      IF (parsePatternNoCase2(tempStr, patternBuf, patBufLen))=-1
        myError(1)
        Dispose(patternBuf)
        Close(fi)
        RETURN RESULT_FAILURE,0,0
      ENDIF

      FOR i:=0 TO searchList.count()-1
        IF MatchPatternNoCase(patternBuf,searchList.item(i)) THEN found:=1
      ENDFOR
      
      Dispose(patternBuf)
    ENDIF

    IF found
      StrCopy(datestr,image)
      datestr[13]:=" "
      parseParams(datestr)

      test:=parsedParams.item(2)
      IF (StrLen(test)=8) AND (test[2]="-") AND (test[5]="-")
        StrCopy(datestr,test)
      ENDIF

      count:=0
      aePuts('\b\n')
      aePuts(image)
      aePuts('\b\n')
      prev:=Seek(fi,0,OFFSET_CURRENT)
      WHILE(Fgets(fi,image,252)<>NIL) AND (dirLineNewFile(image)=FALSE) AND (count<max_desclines)
        stripReturn(image)
        aePuts(image)
        aePuts('\b\n')
        count++
        prev:=Seek(fi,0,OFFSET_CURRENT)
      ENDWHILE
      Seek(fi,prev,OFFSET_BEGINNING)
      aePuts('\b\n')
      IF (viewAllowed=TRUE)
        aePuts('[32m([33mC[32m)[36montinue, [32m([33mD[32m)[36melete, [32m([33mM[32m)[36move, [32m([33mV[32m)[36miew, [32m([33mQ[32m)[36muit[0m? ')
      ELSE
        aePuts('[32m([33mC[32m)[36montinue, [32m([33mD[32m)[36melete, [32m([33mM[32m)[36move, [32m([33mQ[32m)[36muit[0m? ')
      ENDIF
      loop:=TRUE
      WHILE(loop)
        ch:=readChar(INPUT_TIMEOUT)
        IF(ch<0)
          Close(fi)
          RETURN ch,0,0
        ENDIF
        IF (ch="C") OR (ch="c")
          aePuts('\b\n')
          found:=FALSE
          loop:=FALSE
        ELSEIF (ch="d") OR (ch="D") OR (ch="m") OR (ch="M") OR (((ch="v") OR (ch="V")) AND (viewAllowed=TRUE)) OR (ch="q") OR (ch="Q")
          Close(fi)
          StrCopy(outfname,dirfname)
          IF (count:=InStr(dirfname,' '))>=0 THEN SetStr(outfname,count)
          StrCopy(outfiledate,datestr)
          RETURN RESULT_SUCCESS,ch,startposition
        ENDIF
      ENDWHILE
    ENDIF
    startposition:=Seek(fi,0,OFFSET_CURRENT)
  ENDWHILE
  Close(fi)
ENDPROC RESULT_NOT_FOUND,0,0

PROC zippy(fname:PTR TO CHAR,search_string: PTR TO CHAR)
  DEF fi;
  DEF current:PTR TO CHAR
  DEF image[258]:ARRAY OF CHAR
  DEF found=0
  DEF x=1
  DEF gi1
  DEF myzip

  myzip:=AllocMem(25600,MEMF_CLEAR OR MEMF_PUBLIC)
  IF(myzip=FALSE) THEN RETURN RESULT_SUCCESS

  current:=myzip+257 ->ln(1,1);
  UpperStr(search_string);

  fi:=Open(fname,MODE_OLDFILE)
  IF(fi=0)
    FreeMem(myzip,25600)
    RETURN RESULT_SUCCESS
  ENDIF

  WHILE(Fgets(fi,image,252)<>NIL)
    IF(checkInput())
      gi1:=readChar(1)
      SELECT gi1
        CASE 23 /* ctrl-s */
          gi1:=readChar(INPUT_TIMEOUT)
          IF(gi1<0)
            Close(fi);
            FreeMem(myzip,25600)
            RETURN gi1
          ENDIF
        CASE 3  /*  ctrl-c */
          Close(fi)
          aePuts('**Break\b\n')
          FreeMem(myzip,25600)
          RETURN RESULT_FAILURE
      ENDSELECT
    ENDIF
    stripReturn(image)
    IF (dirLineNewFile(image))
      IF (x<100)
        current:=myzip+Shl(x,8)+1   ->ln(1,x)
        current[0]:=0
      ENDIF
      IF(found)
        found:=1
        LOOP
          current:=myzip+Shl(found,8)+1    ->ln(1,found)
          EXIT (current[0]=0) OR (found>=99)
          aePuts(current)
          aePuts('\b\n')
          found++
          gi1:=flagPause(1)
          IF(gi1<0)
            Close(fi)
            FreeMem(myzip,25600)
            RETURN gi1
          ENDIF
        ENDLOOP
      ENDIF
      found:=0
      x:=1
      current:=myzip+Shl(x,8)+1   ->ln(1,x)
    ENDIF
    IF x<100
      AstrCopy(current,image)
    ENDIF
    UpperStr(image)
    IF(InStr(image,search_string))>=0 THEN found:=1
    x++;
    current:=myzip+Shl(x,8)+1   ->ln(1,x);
  ENDWHILE

  current:=myzip+Shl(x,8)+1    ->ln(1,x)
  current[0]:=0
  IF(found)
    found:=1
    LOOP
      current:=myzip+Shl(found,8)+1   ->  ln(1,found)
      EXIT current[0]=0
      aePuts(current)
      aePuts('\b\n')
      found++
      gi1:=flagPause(1)
      IF(gi1<0)
        Close(fi)
        FreeMem(myzip,25600)
        RETURN gi1
      ENDIF
    ENDLOOP
  ENDIF

  Close(fi)
  FreeMem(myzip,25600)
ENDPROC RESULT_SUCCESS

PROC displayFileList(params, reverse=FALSE)
  DEF stat,fLLoop
  DEF str[81]:STRING,ray[200]:STRING
  DEF tempfile[256]:STRING
  DEF fcopy = FALSE
  DEF startDir,dirScan

  nonStopDisplayFlag:=0
  lineCount:=0

  aePuts('\b\n')
  IF(maxDirs=0)
    myError(5); ->Sorry();
    RETURN RESULT_FAILURE
  ENDIF

  parseParams(params)
  IF(parsedParams.count()>0)
    stat,startDir,dirScan:=getDirSpan(parsedParams.item(0))
  ELSE
    displayScreen(SCREEN_FILEHELP) ->IF(displayScreen(SCREEN_FILEHELP))=FALSE THEN unAvailNotice(GSTR3,GSTR1);
    stat,startDir,dirScan:=getDirSpan('')
  ENDIF

  IF(stat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS

  nonStopDisplayFlag:=paramsContains('NS')

  IF reverse
    fLLoop:=dirScan
  ELSE
    fLLoop:=startDir
  ENDIF
  WHILE(fLLoop<=dirScan) AND (fLLoop>=startDir)
    StrCopy(str,currentConfDir)
    IF(dirScan<>(-1))
      IF(fLLoop = maxDirs)    /* at upload dir */
        StrAdd(str,'DIR')
        StringF(ray,'\d',fLLoop)
        StrAdd(str,ray)
        IF reverse
          StringF(ray,'Reverse scanning directory \d\b\n',fLLoop)
        ELSE
          StringF(ray,'Scanning directory \d\b\n',fLLoop)
        ENDIF
        aePuts(ray)

        /* now copy to T: and use T: copy */
        StringF(tempfile,'T:tdir.\d',node)
        IF((fileCopy(str,tempfile)))
          StrCopy(str,tempfile)
          fcopy:=TRUE
        ENDIF
      ELSE
        StrAdd(str,'DIR')
        StringF(ray,'\d',fLLoop)
        StrAdd(str,ray)
        StringF(ray,'Scanning directory \d\b\n',fLLoop)
        aePuts(ray)
      ENDIF
    ELSE
      StrAdd(str,'hold/held')
      aePuts('Scanning directory HOLD\b\n')
    ENDIF
    stat:=flagPause(1)
    IF(stat<0)
      IF(fcopy) THEN DeleteFile(tempfile)  ->(RTS)
      RETURN stat
    ENDIF
    IF reverse
      stat:=fileListReverse(str)
    ELSE
      stat:=displayIt(str)
    ENDIF
    IF(fcopy)
      DeleteFile(tempfile) ->(RTS)
      fcopy:=FALSE
    ENDIF
    IF(stat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS
    IF(stat=RESULT_NO_CARRIER) THEN RETURN RESULT_NO_CARRIER
    IF(stat=RESULT_TIMEOUT) THEN RETURN stat
    ->if(DirScan == MaxDirs)  return(stat);

    aePuts('\b\n')
    IF reverse
      fLLoop--
    ELSE
      fLLoop++
    ENDIF
  ENDWHILE
  IF(fcopy) THEN DeleteFile(tempfile);  ->(RTS)
ENDPROC RESULT_SUCCESS

PROC displayIt(fname: PTR TO CHAR)
  DEF fp,res

  fp:=Open(fname,MODE_OLDFILE)
  IF(fp=0)
    myError(4) ->(RTS) FileListError();
    RETURN RESULT_SUCCESS
  ENDIF

  /* We should check for the file in ram: if there, show it, if not, copy it */

  res:=displayIt2(fp)
  Close(fp)
ENDPROC res

PROC displayIt2(fp)
  DEF moreStat,stat,color = 0
  DEF str[200]:STRING

  WHILE(Fgets(fp,str,180)<>NIL)
    str[181]:=0
    SetStr(str,StrLen(str))
    IF(str[StrLen(str)-1]="\n")
      IF(nonStopDisplayFlag=FALSE) THEN   lineCount++
      StrAdd(str,'\b')
    ENDIF

    IF(color=1) THEN aePuts('[0m')
    aePuts(str)

    IF(sCheckInput())
      stat:=readChar(1)
      IF(stat<0)
        RETURN stat
      ENDIF
      SELECT stat
        CASE 23  /* Pause */
          stat:=readChar(INPUT_TIMEOUT)
          IF(stat<0)
            RETURN RESULT_NO_CARRIER
          ENDIF
        CASE 3 /* ^C */
          aePuts('**Break\b\n\b\n')
          RETURN RESULT_FAILURE
      ENDSELECT
    ENDIF
    IF newFilesPauseFlag
      moreStat:=checkForPause()
    ELSE
      moreStat:=flagPause(0)
    ENDIF
    IF(moreStat<0)
      RETURN moreStat
    ENDIF
  ENDWHILE
ENDPROC RESULT_SUCCESS

PROC displayIt3(buffer:PTR TO CHAR)
  DEF moreStat,stat,color = 0
  DEF str[200]:STRING
  DEF count
  DEF loop=TRUE

  WHILE(loop)
    count:=0
    WHILE (buffer[0]<>0) AND (buffer[0]<>"\n") AND (count<180)
      str[count++]:=buffer[0]
      buffer++
    ENDWHILE
    IF buffer[0]="\n"
      str[count++]:=buffer[0]
      buffer++
    ELSEIF buffer[0]=0
      loop:=FALSE
    ENDIF
    str[count++]:=0
    SetStr(str,StrLen(str))
    IF(str[StrLen(str)-1]="\n")
      IF(nonStopDisplayFlag=FALSE) THEN   lineCount++
      StrAdd(str,'\b')
    ENDIF

    IF(color=1) THEN aePuts('[0m')
    aePuts(str)

    IF(sCheckInput())
      stat:=readChar(1)
      IF(stat<0)
        RETURN stat
      ENDIF
      SELECT stat
        CASE 23  /* Pause */
          stat:=readChar(INPUT_TIMEOUT)
          IF(stat<0)
            RETURN RESULT_NO_CARRIER
          ENDIF
        CASE 3 /* ^C */
          aePuts('**Break\b\n\b\n')
          RETURN RESULT_FAILURE
      ENDSELECT
    ENDIF
    IF newFilesPauseFlag
      moreStat:=checkForPause()
    ELSE
      moreStat:=flagPause(0)
    ENDIF
    IF(moreStat<0)
      RETURN moreStat
    ENDIF
  ENDWHILE
ENDPROC RESULT_SUCCESS

PROC myNewFiles(params)
  DEF month,day,year
  DEF tv,mystat,stat,comstat
  DEF fLLoop
  DEF tempfile[256]:STRING         ->(RTS) for buffer of upload dir
  DEF c[256]:STRING
  DEF str[200]:STRING,ray[200]:STRING
  DEF fn[81]:STRING,sz[81]:STRING,dt[81]:STRING,cmt[81]:STRING
  DEF mdt,ddt,ydt
  DEF timeVar;
  DEF fcopy = FALSE
  DEF pchar: PTR TO CHAR
  DEF startDir,dirScan
  DEF fp1

  nonStopDisplayFlag:=0
  lineCount:=0

  aePuts('\b\n')
  IF(maxDirs=0)
    myError(5) -> Sorry();
    RETURN RESULT_FAILURE
  ENDIF

  timeVar:=loggedOnUser.newSinceDate
  formatLongDate(timeVar,ray)
  StrCopy(str,'')

  parseParams(params)
  IF(parsedParams.count()>0)
    pchar:=parsedParams.item(0)
    IF(pchar[0]="s") OR (pchar[0]="S")
      StrCopy(str,ray)
    ELSE
      StrCopy(str,parsedParams.item(0))
    ENDIF
  ENDIF

  nonStopDisplayFlag:=paramsContains('NS')

  WHILE(StrLen(str)<>8)
    comstat:=1
    StringF(str,'Date as (mm-dd-yy) to search from (Enter)=\s: ',ray)
    aePuts(str)
    mystat:=lineInput('','',8,INPUT_TIMEOUT,str)
    IF(mystat<0) THEN RETURN RESULT_NO_CARRIER
    IF(StrLen(str)=0) THEN StrCopy(str,ray)
    IF(StrLen(str)<>8) THEN aePuts('\b\n')
  ENDWHILE
  StringF(c,'\tDirectory Scan for (\s)',str)
  callersLog(c)

  month,day,year:=decodeDateStr(str)
  
  ->sscanf(str,"%d %d %d",&month,&day,&year);

  tv:=0

  StrCopy(c,'')
  IF(parsedParams.count()>1)
    StrCopy(c,parsedParams.item(1))
  ENDIF
  IF(parsedParams.count()>2)
    StrAdd(c,' ')
    StrAdd(c,parsedParams.item(2));
  ENDIF
  mystat,startDir,dirScan:=getDirSpan(c)
  IF(mystat=RESULT_FAILURE) THEN RETURN RESULT_SUCCESS

  nonStopDisplayFlag:=paramsContains('NS');

  newSinceFlag:=1
  fcopy:=FALSE

  fLLoop:=startDir;
  WHILE(fLLoop<=dirScan)
    StrCopy(str,currentConfDir)
    IF(dirScan<>(-1))
      ->(RTS)   buffer upload dir
      IF(fLLoop = maxDirs)
        StrAdd(str,'DIR')
        StringF(ray,'\d',fLLoop)
        StrAdd(str,ray)
        StringF(ray,'Scanning directory \d\b\n',fLLoop)
        aePuts(ray)

        StringF(tempfile,'T:tdir.\d',node)
        /* now copy to T: and use T: copy */
        IF((fileCopy(str,tempfile)))
          StrCopy(str,tempfile)
          fcopy:=TRUE
        ENDIF
      ELSE
        StrAdd(str,'DIR')
        StringF(ray,'\d',fLLoop)
        StrAdd(str,ray)
        StringF(ray,'Scanning directory \d\b\n',fLLoop)
        aePuts(ray)
      ENDIF
    ELSE
      StrAdd(str,'hold/held')
      aePuts('Scanning directory HOLD\b\n')
    ENDIF
    IF newFilesPauseFlag
      stat:=checkForPause()
    ELSE
      stat:=flagPause(1)
    ENDIF
    IF(stat<0)
      IF(fcopy) THEN DeleteFile(tempfile)
      RETURN stat
    ENDIF
    fp1:=Open(str,MODE_OLDFILE)
    IF(fp1=0)
      aePuts('No Files are available.\b\n\b\n')
      IF(fcopy) THEN DeleteFile(tempfile)
      RETURN RESULT_SUCCESS
    ENDIF

    WHILE(Fgets(fp1,c,250)<>NIL)
      c[250]:=0
      SetStr(c,StrLen(c))
      IF(dirLineNewFile(c)=FALSE) THEN JUMP fgetnext

      parseParams(c)
      IF(parsedParams.count()>0) THEN StrCopy(fn,parsedParams.item(0))
      IF(parsedParams.count()>1) THEN StrCopy(sz,parsedParams.item(1))
      IF(parsedParams.count()>2) THEN StrCopy(dt,parsedParams.item(2))
      IF(parsedParams.count()>3) THEN StrCopy(cmt,parsedParams.item(3))
      ->scanf(c,"%s %s %s %s",&fn,&sz,&dt,&cmt);

      IF((dt[0]<="9") AND (dt[0]>="0") AND (StrLen(dt)=8))
        IF(Not((dt[2]="-") AND (dt[5]="-") AND (dt[6]<="9") AND (dt[6]>="0")))
          StrCopy(sz,dt)
          StrCopy(dt,cmt)
        ENDIF
      ELSE
        StrCopy(sz,dt)
        StrCopy(dt,cmt)
      ENDIF

      mdt,ddt,ydt:=decodeDateStr(dt)

      ->sscanf(dt,"%d %d %d",&mdt,&ddt,&ydt);

      IF(ydt>year)
        tv:=1
      ELSE
        IF(ydt=year)
          IF(mdt>month)
            tv:=1
          ELSEIF(mdt=month)
            IF(ddt>=day) THEN   tv:=1
          ENDIF
        ENDIF
      ENDIF
      EXIT tv
fgetnext:
    ENDWHILE

    IF(tv<>0)
      c[StrLen(c)-1]:=0
      aePuts(c)
      aePuts('\b\n')
      IF newFilesPauseFlag
        stat:=checkForPause()
      ELSE
        stat:=flagPause(1)
      ENDIF
      IF(stat<0)
        Close(fp1)
        IF(fcopy) THEN DeleteFile(tempfile)
        RETURN stat
      ENDIF

      ->   stat=DisplayIt();      /* Mikes unbuffered */
      stat:=displayIt2(fp1)   /* my buffered dir code */
      Close(fp1)
      tv:=0
      IF(stat<0)
        IF(fcopy) THEN DeleteFile(tempfile)
        RETURN stat
      ENDIF
    ELSE
      Close(fp1)
    ENDIF
    tv:=0
    fLLoop++
  ENDWHILE
  aePuts('\b\n')
  nonStopDisplayFlag:=0
  IF(fcopy) THEN DeleteFile(tempfile)
ENDPROC RESULT_SUCCESS

PROC flagPause(count)
  DEF moreStat
  DEF str[200]:STRING

  IF(nonStopDisplayFlag=FALSE) THEN lineCount:=lineCount+count

  IF((nonStopDisplayFlag=FALSE) AND (lineCount>=userLineLen))
    lineCount:=0;
    LOOP
      aePuts('[32m([33mPause[32m)[34m...[32m([33mf[32m)[36mlags, More[32m([33mY[32m/[33mn[32m/[33mns[32m)[0m? ')
      moreStat:=lineInput('','',190,INPUT_TIMEOUT,str)
      IF(moreStat<0) THEN RETURN moreStat

      EXIT (str[0]=0) OR (str[0]="y") OR (str[0]="Y")

      IF(logonType>=LOGON_TYPE_REMOTE)
        moreStat:=checkCarrier()
        IF(moreStat=FALSE) THEN RETURN RESULT_NO_CARRIER
      ENDIF
      IF((str[0]="N") OR (str[0]="n"))
        IF((str[1]="S") OR (str[1]="s"))
          nonStopDisplayFlag:=1
          JUMP fpbrk
        ELSE
          aePuts('\b\n')
          RETURN RESULT_FAILURE
        ENDIF
      ENDIF
      IF((str[0]="F") OR (str[0]="f"))
        IF(StrLen(str)>2) THEN moreStat:=flagFiles(str+2) ELSE moreStat:=flagFiles(NIL)
        IF(moreStat<RESULT_FAILURE) THEN RETURN moreStat
        ->if(AnsiColor)
        aePuts('[A[K')
      ENDIF
    ENDLOOP
fpbrk:
    aePuts('[1A[K')
  ENDIF
ENDPROC RESULT_SUCCESS


PROC confScan()
  DEF mystat,conf,n,msgbase
  DEF prompt=FALSE
  DEF mscan=TRUE
  DEF fscan=TRUE
  setEnvStat(ENV_SCANNING)

  displayScreen(SCREEN_MAILSCAN)

  IF (prompt:=checkToolTypeExists(TOOLTYPE_NODE,node,'MAILSCAN_PROMPT'))
    aePuts('\b\n[0mScan for Mail ')
    mystat:=yesNo(1)
    IF mystat<0 THEN RETURN mystat
    mscan:=(mystat=1)
  ENDIF

  IF (prompt=FALSE) OR (mscan=TRUE)
    aePuts('\b\nScanning conferences for mail...\b\n\b\n')
    lineCount:=2
    mciViewSafe:=FALSE
    FOR conf:=1 TO cmds.numConf
      IF (checkConfAccess(conf))

        fscan:=checkFileConfScan(conf)


        n:=getConfMsgBaseCount(conf)
        FOR msgbase:=1 TO n
          IF prompt=FALSE
            mscan:=checkMailConfScan(conf,msgbase)
          ENDIF
          mystat:=joinConf(conf,msgbase,TRUE,FALSE,IF mscan=FALSE THEN FORCE_MAILSCAN_SKIP ELSE FORCE_MAILSCAN_NOFORCE)
        ENDFOR
        IF (mystat=RESULT_SUCCESS) AND (fscan)
          newFilesPauseFlag:=TRUE
          currentConf:=conf
          runSysCommand('N','S U')
          currentConf:=0
          newFilesPauseFlag:=FALSE
        ELSE
          mystat:=RESULT_SUCCESS
        ENDIF
      ENDIF
      EXIT mystat=RESULT_FAILURE
      IF (mystat=RESULT_TIMEOUT) OR (mystat=RESULT_NO_CARRIER)
        mciViewSafe:=TRUE
        RETURN mystat
      ENDIF
    ENDFOR
    mciViewSafe:=TRUE

    IF checkSecurity(ACS_UPLOAD)
      ->//AEPutStr("\b\n[35m  --[32mChecking for PartUploads\b\n[0m");
      FOR conf:=1 TO cmds.numConf
        IF (checkConfAccess(conf))
          mystat:=joinConf(conf,1,TRUE,FALSE,FORCE_MAILSCAN_SKIP)
          IF (mystat=RESULT_SUCCESS)

            mystat:=partUploadOK(1)
            IF(mystat=RESULT_FAILURE)
              currentConf:=conf
              setEnvStat(ENV_UPLOADING)
              IF(checkSecurity(ACS_UPLOAD))
                IF logonType>=LOGON_TYPE_REMOTE
                  bgFileCheck:=checkToolTypeExists(TOOLTYPE_NODE,node,'BGFILECHECK')
                ELSE
                  bgFileCheck:=FALSE
                ENDIF
                mystat:=uploadaFile(0,'URG',FALSE)
                IF mystat=RESULT_GOODBYE THEN modemOffHook()
              ENDIF
            ELSEIF(mystat=RESULT_ABORT)
              aePuts('\b\n')
            ENDIF
          ENDIF
        ENDIF
        EXIT mystat=RESULT_FAILURE
        IF (mystat=RESULT_TIMEOUT) OR (mystat=RESULT_NO_CARRIER) OR (mystat=RESULT_GOODBYE) THEN RETURN mystat
      ENDFOR
      mystat:=doPause()
      IF(mystat<0) THEN RETURN mystat
    ENDIF
  ENDIF
ENDPROC RESULT_SUCCESS

PROC captureRealAndInternetNames(conf,msgbase)
  DEF stat,valid
  DEF realNamesUsed=FALSE,internetNamesUsed=FALSE
  DEF tempstr[30]:STRING
  DEF namestr[255]:STRING

  IF (conf<1) OR (msgbase<1) THEN RETURN RESULT_SUCCESS

  IF checkToolTypeExists(TOOLTYPE_CONF,conf,'REALNAME') THEN realNamesUsed:=TRUE
  IF checkToolTypeExists(TOOLTYPE_CONF,conf,'INTERNETNAME') THEN internetNamesUsed:=TRUE
  StringF(namestr,'REALNAME.\d',msgbase)
  IF checkToolTypeExists(TOOLTYPE_MSGBASE,conf,namestr) THEN realNamesUsed:=TRUE
  StringF(namestr,'INTERNETNAME.\d',msgbase)
  IF checkToolTypeExists(TOOLTYPE_MSGBASE,conf,namestr) THEN internetNamesUsed:=TRUE

  IF ((realNamesUsed=TRUE) AND (StrLen(loggedOnUserMisc.realName)=0))
    valid:=FALSE
    aePuts('\b\n')
    IF displayScreen(SCREEN_REALNAMES)=FALSE
      aePuts('Real Names are required for messages in this conference/msgbase \b\n')
    ENDIF
    aePuts('\b\n')
    REPEAT
      aePuts('Real Name (Alpha Numeric): ')
      stat:=lineInput('','',25,INPUT_TIMEOUT,tempstr)
      IF stat<0 THEN RETURN stat
      IF StrLen(tempstr)=0 THEN RETURN RESULT_FAILURE

      IF (StrLen(tempstr)<>1) AND (StriCmp(tempstr,loggedOnUserMisc.realName)=FALSE)
        aePuts('\b\nChecking for duplicate name...')
        stat:=checkForAst(tempstr)
        IF(stat)
          aePuts('No wildcards allowed in a name.\b\n')
        ELSEIF findUserFromName(1,NAME_TYPE_REALNAME,tempstr,tempUser,tempUserKeys,tempUserMisc)
            aePuts('Already in use!, try another.\b\n\b\n')
        ELSE
          aePuts('Ok!\b\n')
          valid:=TRUE
        ENDIF
      ENDIF
    UNTIL valid
    AstrCopy(loggedOnUserMisc.realName,tempstr,26)
  ENDIF

  IF ((internetNamesUsed=TRUE) AND (StrLen(loggedOnUserMisc.internetName)=0))
    valid:=FALSE

    aePuts('\b\n')
    IF displayScreen(SCREEN_INTERNETNAMES)=FALSE
      aePuts('Internet Names are required for messages in this conference/msgbase\b\n')
    ENDIF
    aePuts('\b\n')

    REPEAT
      aePuts('Internet Name (Alpha Numeric No Spaces): ')
      stat:=lineInput('','',9,INPUT_TIMEOUT,tempstr)
      IF stat<0 THEN RETURN stat

      IF StrLen(tempstr)=0 THEN RETURN RESULT_FAILURE

      IF (StrLen(tempstr)<>1) AND (StriCmp(tempstr,loggedOnUserMisc.internetName)=FALSE)
        aePuts('\b\nChecking for duplicate name...')
        stat:=checkForAst(tempstr)
        IF(stat)
          aePuts('No wildcards allowed in a name.\b\n')
        ELSEIF findUserFromName(1,NAME_TYPE_INTERNETNAME,tempstr,tempUser,tempUserKeys,tempUserMisc)
          aePuts('Already in use!, try another.\b\n\b\n')
        ELSE
          aePuts('Ok!\b\n')
          valid:=TRUE
        ENDIF
      ENDIF
    UNTIL valid
    AstrCopy(loggedOnUserMisc.internetName,tempstr,10)
  ENDIF

ENDPROC RESULT_SUCCESS

PROC processCommand(cmdtext,allowsyscmd=FALSE, subtype=-1)
  DEF cmdcode[255]:STRING
  DEF cmdparams[255]:STRING
  DEF spacepos,res

  IF EstrLen(cmdtext)=0 THEN RETURN RESULT_SUCCESS

  spacepos:=InStr(cmdtext,' ')

  IF spacepos>=0
    midStr2(cmdcode,cmdtext,0,spacepos)
    MidStr(cmdparams,cmdtext,spacepos+1)
  ELSE
    StrCopy(cmdcode,cmdtext)
    StrCopy(cmdparams,'')
  ENDIF
  UpperStr(cmdcode)

  -> try running it as a bbscommand first
  IF (subtype<SUBTYPE_INTCMD)
    IF allowsyscmd
      IF (res:=runSysCommand(cmdcode,cmdparams,TRUE,subtype))=RESULT_SUCCESS THEN RETURN RESULT_SUCCESS
      IF res=RESULT_NOT_ALLOWED THEN RETURN res
    ENDIF
    IF (res:=runBbsCommand(cmdcode,cmdparams,TRUE,subtype))=RESULT_SUCCESS THEN RETURN RESULT_SUCCESS
    IF res=RESULT_NOT_ALLOWED THEN RETURN res
  ENDIF
ENDPROC processInternalCommand(cmdcode,cmdparams)

PROC processSysCommand(cmdtext, allowBBSCmd=FALSE)
  DEF cmdcode[255]:STRING
  DEF cmdparams[255]:STRING
  DEF spacepos,res

  IF EstrLen(cmdtext)=0 THEN RETURN RESULT_SUCCESS

  IF (spacepos:=InStr(cmdtext,' '))>=0
    midStr2(cmdcode,cmdtext,0,spacepos)
    MidStr(cmdparams,cmdtext,spacepos+1)
  ELSE
    StrCopy(cmdcode,cmdtext)
    StrCopy(cmdparams,'')
  ENDIF

  -> try running it as a syscommand first
  IF (res:=runSysCommand(cmdcode,cmdparams))=RESULT_SUCCESS THEN RETURN RESULT_SUCCESS
  IF res=RESULT_NOT_ALLOWED THEN RETURN res

  IF allowBBSCmd
    -> try running it as a bbscommand next
    IF (res:=runBbsCommand(cmdcode,cmdparams,TRUE)=RESULT_SUCCESS) THEN RETURN RESULT_SUCCESS
    IF res=RESULT_NOT_ALLOWED THEN RETURN res
  ENDIF

ENDPROC processInternalCommand(cmdcode,cmdparams,TRUE)

PROC processInternalCommand(cmdcode,cmdparams,privcmd=FALSE)
  DEF res=RESULT_SUCCESS
   
  IF (StrCmp(cmdcode,'0'))
    res:=internalCommand0()
  ELSEIF (StrCmp(cmdcode,'1'))
    res:=internalCommand1()
  ELSEIF (StrCmp(cmdcode,'2'))
    res:=internalCommand2(cmdparams)
  ELSEIF (StrCmp(cmdcode,'3'))
    res:=internalCommand3(cmdparams)
  ELSEIF (StrCmp(cmdcode,'4'))
    res:=internalCommand4(cmdparams)
  ELSEIF (StrCmp(cmdcode,'5'))
    res:=internalCommand5(cmdparams)
  ELSEIF (StrCmp(cmdcode,'D'))
    res:=internalCommandD(cmdcode,cmdparams)
  ELSEIF (StrCmp(cmdcode,'DS'))
    res:=internalCommandD(cmdcode,cmdparams)
  ELSEIF (StrCmp(cmdcode,'S'))
    res:=internalCommandS()
  ELSEIF (StrCmp(cmdcode,'T'))
    res:=internalCommandT()
  ELSEIF (StrCmp(cmdcode,'F'))
    res:=internalCommandF(cmdparams)
  ELSEIF (StrCmp(cmdcode,'FR'))
    res:=internalCommandFR(cmdparams)
  ELSEIF (StrCmp(cmdcode,'FM'))
    res:=internalCommandFM(cmdparams)
  ELSEIF (StrCmp(cmdcode,'FS'))
    res:=internalCommandFS()
  ELSEIF (StrCmp(cmdcode,'G'))
    res:=internalCommandG(cmdparams)
  ELSEIF (StrCmp(cmdcode,'J'))
    res:=internalCommandJ(cmdparams)
  ELSEIF (StrCmp(cmdcode,'JM'))
    res:=internalCommandJM(cmdparams)
  ELSEIF (StrCmp(cmdcode,'<'))
    res:=internalCommandLT()
  ELSEIF (StrCmp(cmdcode,'<<'))
    res:=internalCommandLT2()
  ELSEIF (StrCmp(cmdcode,'>'))
    res:=internalCommandGT()
  ELSEIF (StrCmp(cmdcode,'>>'))
    res:=internalCommandGT2()
  ELSEIF (StrCmp(cmdcode,'R'))
    res:=internalCommandR(cmdparams)
  ELSEIF (StrCmp(cmdcode,'A'))
    res:=internalCommandA(cmdparams)
  ELSEIF (StrCmp(cmdcode,'B'))
    res:=internalCommandB(cmdparams)
  ELSEIF (StrCmp(cmdcode,'C'))
    res:=internalCommandC(cmdparams)
  ELSEIF (StrCmp(cmdcode,'CF'))
    res:=internalCommandCF()
  ELSEIF (StrCmp(cmdcode,'GR'))
    res:=internalCommandGreets()
  ELSEIF (StrCmp(cmdcode,'CM'))
    res:=internalCommandCM()
  ELSEIF (StrCmp(cmdcode,'E'))
    res:=internalCommandE(cmdparams)
  ELSEIF (StrCmp(cmdcode,'H'))
    res:=internalCommandH(cmdparams)
  ELSEIF (StrCmp(cmdcode,'M'))
    res:=internalCommandM()
  ELSEIF (StrCmp(cmdcode,'MS'))
    res:=internalCommandMS()
  ELSEIF (StrCmp(cmdcode,'N'))
    res:=internalCommandN(cmdparams)
  ELSEIF (StrCmp(cmdcode,'NM'))
    res:=internalCommandNM()
  ELSEIF (StrCmp(cmdcode,'O'))
    res:=internalCommandO()
  ELSEIF (StrCmp(cmdcode,'OLM'))
    res:=internalCommandOLM(cmdparams)
  ELSEIF (StrCmp(cmdcode,'Q'))
    res:=internalCommandQ()
  ELSEIF (StrCmp(cmdcode,'RL'))
    res:=internalCommandRL(cmdparams)
  ELSEIF (StrCmp(cmdcode,'U'))
    res:=internalCommandU(cmdcode)
  ELSEIF (StrCmp(cmdcode,'US'))
    res:=internalCommandUS()
  ELSEIF (StrCmp(cmdcode,'UP'))
    res:=internalCommandUP()
  ELSEIF (StrCmp(cmdcode,'RZ'))
    res:=internalCommandRZ(cmdcode)
  ELSEIF (StrCmp(cmdcode,'V'))
    res:=internalCommandV(cmdcode,cmdparams)
  ELSEIF (StrCmp(cmdcode,'VER'))
    res:=internalCommandVER()
  ELSEIF (StrCmp(cmdcode,'VS'))
    res:=internalCommandV(cmdcode,cmdparams)
  ELSEIF (StrCmp(cmdcode,'VO'))
    res:=internalCommandVO()
  ELSEIF (StrCmp(cmdcode,'W'))
    res:=internalCommandW()
  ELSEIF (StrCmp(cmdcode,'WHO'))
    res:=internalCommandWHO()
  ELSEIF (StrCmp(cmdcode,'WHD'))
    res:=internalCommandWHD()
  ELSEIF (StrCmp(cmdcode,'X'))
    res:=internalCommandX()
  ELSEIF (StrCmp(cmdcode,'Z'))
    res:=internalCommandZ(cmdparams)
  ELSEIF (StrCmp(cmdcode,'ZOOM'))
    res:=internalCommandZOOM()
  ELSEIF (StrCmp(cmdcode,'?'))
    res:=internalCommandQuestionMark()
  ELSEIF (StrCmp(cmdcode,'^'))
    res:=internalCommandUpHat(cmdparams)
  ELSEIF privcmd=FALSE
    aePuts('\b\nNo such command!!  Use ''?'' for command list.\b\n\b\n')
  ENDIF

  IF ((res=RESULT_NOT_ALLOWED) AND (privcmd=FALSE)) THEN higherAccess()

ENDPROC res

PROC displayMenuPrompt()
  DEF mPrompt[255]:STRING
  DEF msgBaseName[255]:STRING
  DEF tempstr[30]:STRING

  IF StrLen(menuPrompt)>0
    aePuts('[0m')
    processMci(menuPrompt)
    aePuts(' ')
  ELSE
    IF getConfMsgBaseCount(currentConf)>1
      getMsgBaseName(currentConf,currentMsgBase,msgBaseName)
      StringF(tempstr,'\s - \s',currentConfName,msgBaseName)
      StringF(mPrompt,'[0m[35m\s [0m[[36m\d[34m:[36m\s[0m] Menu ([33m\d[0m mins. left): ',cmds.bbsName,relConfNum,tempstr,Div((loggedOnUser.timeTotal-loggedOnUser.timeUsed),60))
    ELSE
      StringF(mPrompt,'[0m[35m\s [0m[[36m\d[34m:[36m\s[0m] Menu ([33m\d[0m mins. left): ',cmds.bbsName,relConfNum,currentConfName,Div((loggedOnUser.timeTotal-loggedOnUser.timeUsed),60))
    ENDIF
    aePuts(mPrompt)
  ENDIF
ENDPROC

PROC getTodaysCalls(user:PTR TO user, userKeys:PTR TO userKeys)
  DEF currTime,currDay,lastDay
  
  currTime:=getSystemTime()
  currDay:=Div(currTime-21600,86400)
  lastDay:=Div(user.timeLastOn-21600,86400)  
  IF currDay<>lastDay THEN RETURN 0
ENDPROC userKeys.timesOnToday AND $FFFF

PROC translateShortcut(key,outString)
  DEF i,p,sh:PTR TO CHAR
  DEF shkey[255]:STRING
  DEF shval[255]:STRING
  DEF keyStr[10]:STRING
  
  StrCopy(keyStr,'0')
  SELECT key
    CASE 13
      StrCopy(keyStr,'RET')
    CASE CHAR_DELETE
      StrCopy(keyStr,'DEL')
    CASE CHAR_BACKSPACE
      StrCopy(keyStr,'BACK')
    CASE CHAR_TAB
      StrCopy(keyStr,'TAB')
    CASE 27
      StrCopy(keyStr,'ESC')
    CASE 32
      StrCopy(keyStr,'SPACE')
    DEFAULT
      keyStr[0]:=key
  ENDSELECT
  FOR i:=0 TO shortcuts.count()-1
    sh:=shortcuts.item(i)
    IF (p:=InStr(sh,'='))
      StrCopy(shkey,sh,p)
      StrCopy(shval,sh+p+1)
      IF StriCmp(keyStr,shkey)
        StrCopy(outString,shval)
      ENDIF
    ENDIF
  ENDFOR
ENDPROC

PROC loadShortcuts(file:PTR TO CHAR)
  DEF fh
  DEF tempStr[255]:STRING
  shortcuts.clear()
  fh:=Open(file,MODE_OLDFILE)
  IF fh<>0
    WHILE((ReadStr(fh,tempStr)<>-1) OR (StrLen(tempStr)>0))
      shortcuts.add(tempStr)
    ENDWHILE
    Close(fh)
  ENDIF
ENDPROC

PROC processLoggedOnUser()
  DEF subState: PTR TO loggedOnState
  DEF string[255]:STRING
  DEF temp,stat
  DEF lastDay,currDay
  DEF currTime

  IF (stateData=0)
    StrCopy(securityFlags,'')

    StringF(string,'LANGUAGE.\d',loggedOnUser.translatorID AND 127)
    IF readToolType(TOOLTYPE_LANGUAGES,'',string,userLanguage)=FALSE THEN StrCopy(userLanguage,hostLanguage)

    ->reset protocol if out of range or not valid
    IF (loggedOnUser.xferProtocol<0) OR (loggedOnUser.xferProtocol>=xprLib.count()) OR ((checkSecurity(ACS_XPR_SEND)=FALSE) AND (checkSecurity(ACS_XPR_RECEIVE)=FALSE)) THEN loggedOnUser.xferProtocol:=0

    blockOLM:=FALSE
    messageMenuChar:=0
    disallowFileAttach:=FALSE
    statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
    IF(cmds.acLvl[LVL_SCREEN_TO_FRONT] AND scropen) THEN expressToFront()

    newSinceFlag:=0
    currTime:=getSystemTime()
    currDay:=Div(currTime-21600,86400)
    lastDay:=Div(loggedOnUser.timeLastOn-21600,86400)  
    
    IF (lastDay<>currDay)
      StringF(string,'timeused debug: \s logon new day reset,  currday \d, lastday \d',loggedOnUser.name, currDay,lastDay)
      debugLog(LOG_DEBUG,string)

      loggedOnUserKeys.timesOnToday:=0
      loggedOnUser.timeUsed:=0
      loggedOnUser.chatRemain:=loggedOnUser.chatLimit
      loggedOnUser.dailyBytesDld:=0
      loggedOnUser.timeTotal:=loggedOnUser.timeLimit
      loggedOnUser.todaysBytesLimit:=loggedOnUser.dailyBytesLimit
    ELSE
      IF loggedOnUser.dailyBytesLimit=0
        loggedOnUser.todaysBytesLimit:=0
      ELSE
        IF loggedOnUser.todaysBytesLimit<loggedOnUser.dailyBytesLimit THEN loggedOnUser.todaysBytesLimit:=loggedOnUser.dailyBytesLimit
      ENDIF
      loggedOnUserKeys.timesOnToday:=loggedOnUserKeys.timesOnToday+1
      StringF(string,'timeused debug: \s logon same day,  currday \d, lastday \d, timeused \d, todays dl \d',loggedOnUser.name,currDay,lastDay,loggedOnUser.timeUsed,loggedOnUser.dailyBytesDld)
      debugLog(LOG_DEBUG,string)
    ENDIF

    timeLimit:=loggedOnUser.timeTotal-loggedOnUser.timeUsed
    IF (loggedOnUser.todaysBytesLimit<>0)
      bytesADL:=loggedOnUser.todaysBytesLimit-loggedOnUser.dailyBytesDld
    ELSE
      bytesADL:=$7fffffff
    ENDIF
    updateTimeUsed()
    checkTimeUsed()

    updateLineLen()
    pagesAllowed:=readToolTypeInt(TOOLTYPE_ACCESS,acsLevel,'ACS.MAX_PAGES')
    chatF:=0
    currentConf:=0
    lastOlmNode:=-1
    subState:=NEW subState
    IF reqState<>REQ_STATE_LOGOFF THEN subState.subState:=SUBSTATE_DISPLAY_BULL ELSE subState.subState:=-1
    relogon:=FALSE
    nonStopDisplayFlag:=FALSE
    doorTimeout:=INPUT_TIMEOUT

    stateData:=subState
  ELSE
    subState:=stateData
  ENDIF

  IF subState.subState=SUBSTATE_DISPLAY_BULL
    IF (displayScreen(SCREEN_BULL)) THEN doPause()
    IF (displayScreen(SCREEN_NODE_BULL)) THEN doPause()
    IF logonType>=LOGON_TYPE_REMOTE
      stat:=checkCarrier()   
    ELSE
      stat:=TRUE
    ENDIF
    IF (stat) AND (reqState=REQ_STATE_NONE)
      stat:=confScan()
      IF stat=RESULT_SUCCESS
        subState.subState:=SUBSTATE_DISPLAY_CONF_BULL
      ELSE
        reqState:=REQ_STATE_LOGOFF
      ENDIF
    ELSE
      reqState:=REQ_STATE_LOGOFF
    ENDIF
  ELSEIF subState.subState=SUBSTATE_DISPLAY_CONF_BULL
    joinConf(loggedOnUser.confRJoin,loggedOnUser.msgBaseRJoin,FALSE,FORCE_MAILSCAN_SKIP)
    IF reqState=REQ_STATE_NONE
      loadFlagged()
      IF StrLen(historyFolder)>0 THEN loadHistory()
      blockOLM:=FALSE
      menuPause:=TRUE
      subState.subState:=SUBSTATE_DISPLAY_MENU
    ENDIF
  ELSEIF subState.subState=SUBSTATE_DISPLAY_MENU
    IF ((loggedOnUser.expert="N") AND (doorExpertMode=FALSE)) OR (checkToolTypeExists(TOOLTYPE_CONF,currentConf,'FORCE_MENUS'))
      IF (menuPause) THEN doPause()
      checkScreenClear()
      displayScreen(SCREEN_MENU)
    ENDIF
    doorExpertMode:=FALSE
    aePuts('\b\n')
    IF checkOnlineStatus()<>RESULT_SUCCESS THEN reqState:=REQ_STATE_LOGOFF
    updateTimeUsed()
    checkTimeUsed()
    ->show queued olm messages
    processOlmMessageQueue(TRUE)

    setEnvStat(ENV_IDLE)
    displayMenuPrompt()
    IF cmdShortcuts=FALSE
      subState.subState:=SUBSTATE_READ_COMMAND
    ELSE
      subState.subState:=SUBSTATE_READ_SHORTCUTS
    ENDIF
    StrCopy(commandText,'')
  ELSEIF subState.subState=SUBSTATE_READ_SHORTCUTS
    temp:=readChar(INPUT_TIMEOUT)
    IF(temp<0)
      IF timeoutLC THEN lostCarrier:=TRUE
      aePuts('Input timeout\b\n')
      aePuts('Goodbye\b\n\b\n')
      aePuts('Disconnecting..\b\n')
      saveFlagged()
      IF StrLen(historyFolder)>0 THEN saveHistory()
      quickFlag:=TRUE
      IF reqState=REQ_STATE_NONE THEN reqState:=REQ_STATE_LOGOFF
    ENDIF
    IF state=STATE_SHUTDOWN THEN RETURN
    translateShortcut(temp,string)
    processMci(string)    
    menuPause:=FALSE
    subState.subState:=SUBSTATE_DISPLAY_MENU
  ELSEIF subState.subState=SUBSTATE_READ_COMMAND
    temp:=rawArrow
    rawArrow:=FALSE
    temp:=lineInput('','',255,INPUT_TIMEOUT,commandText)
    IF temp<>RESULT_SUCCESS
      IF timeoutLC THEN lostCarrier:=TRUE
      aePuts('Input timeout\b\n')
      aePuts('Goodbye\b\n\b\n')
      aePuts('Disconnecting..\b\n')
      saveFlagged()
      IF StrLen(historyFolder)>0 THEN saveHistory()
      quickFlag:=TRUE
      IF reqState=REQ_STATE_NONE THEN reqState:=REQ_STATE_LOGOFF
    ENDIF
    rawArrow:=temp
    IF state=STATE_SHUTDOWN THEN RETURN

    subState.subState:=SUBSTATE_PROCESS_COMMAND
  ELSEIF subState.subState=SUBSTATE_PROCESS_COMMAND
    IF (debugLogLevel>LOG_NONE)
      StringF(string,'\tMenu Command >: \s',commandText)
      callersLog(string)
    ENDIF

    UpperStr(commandText)
    processCommand(commandText)
    menuPause:=TRUE
    subState.subState:=SUBSTATE_DISPLAY_MENU
  ENDIF

  IF reqState<>REQ_STATE_NONE THEN END subState
ENDPROC

PROC processFtpLogon()
  DEF sendStr[255]:STRING
  DEF stat
  DEF authDone=FALSE
  DEF userName[100]:STRING
  DEF password[100]:STRING
  DEF dateStr[30]:STRING
  DEF tmp[255]:STRING
  DEF tmp2[255]:STRING
  DEF path[255]:STRING
  DEF tFShi,tFSlo,fSUploadingHi,fSUploadingLo

  binaryRaw:=TRUE

  ripMode:=FALSE
  confNameType:=NAME_TYPE_USERNAME
  state:=STATE_CONNECTING
  stateData:=0
  lostCarrier:=FALSE
  lineCount:=0
  setEnvStat(ENV_CONNECT)
  IF cacheResetOn=CACHE_RESET_LOGON THEN clearDiskObjectCache()

  IF (serialCache<>NIL) THEN serialCacheEnabled:=TRUE

  ansiColour:=FALSE

  IoctlSocket(telnetSocket,FIONBIO,[0])

  StrCopy(userName,'')
  StrCopy(password,'')

  authDone:=ftpDoLogin(socketbase,telnetSocket,userName,password)

  IF (authDone=FALSE)
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  stat:=chooseAName(userName,tempUser,tempUserKeys,tempUserMisc,0)
  IF (stat=RESULT_FAILURE)
    StrCopy(sendStr,'430 Invalid username or password\b\n')
    telnetSend(sendStr,EstrLen(sendStr))
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  logonTime:=getSystemTime()
  lastTimeUpdate:=logonTime
  loggedOnUser:=NEW loggedOnUser
  loggedOnUserKeys:=NEW loggedOnUserKeys
  loggedOnUserMisc:=NEW loggedOnUserMisc

  stat:=loadAccount(tempUser.slotNumber,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  IF(stat=RESULT_FAILURE)
    END loggedOnUser
    END loggedOnUserKeys
    END loggedOnUserMisc
    StrCopy(sendStr,'430 That account has problems\b\n')
    telnetSend(sendStr,EstrLen(sendStr))
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  IF ftpAuth(userName,password)=FALSE
    END loggedOnUser
    END loggedOnUserKeys
    END loggedOnUserMisc
    StrCopy(sendStr,'430 Invalid username or password\b\n')
    telnetSend(sendStr,EstrLen(sendStr))
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  setEnvStat(ENV_LOGGINGON)

  IF logonType=LOGON_TYPE_REMOTE THEN ximPort:=SERIAL_PORT ELSE ximPort:=CONSOLE_PORT

  updateCallerNum()

  IF(StrLen(reservedName)>0)
    IF(StriCmp(userName,reservedName))=FALSE
      StrCopy(sendStr,'420 Node is currently reserved for another user.\b\n')
      telnetSend(sendStr,EstrLen(sendStr))
      END loggedOnUser
      END loggedOnUserKeys
      END loggedOnUserMisc
      state:=STATE_LOGGING_OFF
      RETURN
    ENDIF
  ENDIF

  IF(loggedOnUser.slotNumber=0)
    StrCopy(sendStr,'420 That account has been deleted.\b\n')
    telnetSend(sendStr,EstrLen(sendStr))
    END loggedOnUser
    END loggedOnUserKeys
    END loggedOnUserMisc
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  stat:=checkUserOnLine(1)
  IF(stat=FALSE)
    END loggedOnUser
    END loggedOnUserKeys
    END loggedOnUserMisc
    StringF(sendStr,'420 User \s already on another node!',loggedOnUser.name)
    telnetSend(sendStr,EstrLen(sendStr))
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  validUser:=1
  convertAccess()

  loggedOnUserKeys.baud:=19200
  masterLoadPointers(loggedOnUser)

  doLogonNotify()

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)

  IF (StrLen(mybbsLoc)>0)
    StringF(sendStr,'230-Welcome to \s, located in \s\b\n',cmds.bbsName,mybbsLoc)
  ELSE
    StringF(sendStr,'230-Welcome to \s.\b\n',cmds.bbsName)
  ENDIF
  telnetSend(sendStr,EstrLen(sendStr))

  StringF(sendStr,'230-\b\n230-Running AmiExpress \s Copyright ©2018-2023 Darren Coles\b\n',expressVer)
  telnetSend(sendStr,EstrLen(sendStr))
  StringF(sendStr,'230-Registration \s. You are connected to Node \d\b\n',regKey,node)
  telnetSend(sendStr,EstrLen(sendStr))
  formatLongDateTime(getSystemTime(),dateStr)
  StringF(sendStr,'230-Connection occured at \s.\b\n',dateStr)
  telnetSend(sendStr,EstrLen(sendStr))

  displayUserToCallersLog(0)

  IF checkSecurity(ACS_DISPLAY_USER_STATS)
    setEnvStat(ENV_STATS)

    StringF(sendStr,'230-\b\n',dateStr)
    telnetSend(sendStr,EstrLen(sendStr))

    IF checkToolTypeExists(TOOLTYPE_NODE,node,'USERNUMBER_LOGIN')
      StringF(sendStr,'230-User Number: \d\b\n',loggedOnUser.slotNumber)
      telnetSend(sendStr,EstrLen(sendStr))
    ENDIF
    IF sopt.toggles[TOGGLES_CONFRELATIVE]=FALSE
      StringF(sendStr,'230-Area Name  : \s\b\n',loggedOnUser.conferenceAccess)
      telnetSend(sendStr,EstrLen(sendStr))
    ENDIF
    StringF(sendStr,'230-Caller Num.: \d\b\n',callerNum)
    telnetSend(sendStr,EstrLen(sendStr))
    formatLongDateTime(loggedOnUser.timeLastOn,tmp2)
    StringF(sendStr,'230-Lst Date On: \s\b\n',tmp2)
    telnetSend(sendStr,EstrLen(sendStr))
    StringF(sendStr,'230-Security Lv: \d\b\n',loggedOnUser.secStatus)
    telnetSend(sendStr,EstrLen(sendStr))
    StringF(sendStr,'230-# Times On : \d\b\n',loggedOnUser.timesCalled AND $FFFF)
    telnetSend(sendStr,EstrLen(sendStr))
    StringF(sendStr,'230-Times Today: \d\b\n',getTodaysCalls(loggedOnUser,loggedOnUserKeys))
    telnetSend(sendStr,EstrLen(sendStr))
    StringF(sendStr,'230-Msgs Posted: \d\b\n',loggedOnUser.messagesPosted AND $FFFF)
    telnetSend(sendStr,EstrLen(sendStr))
    formatUnsignedLong(loggedOnUserKeys.upCPS2,tmp2)
    StringF(sendStr,'230-Rate CPS UP: \s\b\n',tmp2)
    telnetSend(sendStr,EstrLen(sendStr))
    formatUnsignedLong(loggedOnUserKeys.dnCPS2,tmp2)
    StringF(sendStr,'230-Rate CPS DN: \s\b\n',tmp2)
    telnetSend(sendStr,EstrLen(sendStr))

    IF (checkSecurity(ACS_SHOW_PAYMENTS)) AND (loggedOnUser.creditDays>0)
      IF creditAccountEnabled(loggedOnUser)
        formatLongDate(loggedOnUser.creditStartDate+Mul(loggedOnUser.creditDays,86400),tmp2)
        StringF(sendStr,'230-Credit Account Expires: \s\b\n',tmp2)
        telnetSend(sendStr,EstrLen(sendStr))
      ELSE
        StrCopy(sendStr,'230-Credit Account has EXPIRED\b\n')
        telnetSend(sendStr,EstrLen(sendStr))
      ENDIF
    ENDIF

    StringF(sendStr,'230-Sysop  Here: \s\b\n',IF sysopAvail THEN 'YES' ELSE 'NO')
    telnetSend(sendStr,EstrLen(sendStr))
    StrCopy(sendStr,'230-\b\n')
    telnetSend(sendStr,EstrLen(sendStr))


    tFShi,tFSlo:=freeDiskSpace()                /* check free space - now in mb instead of bytes */
    IF(tFShi<>RESULT_FAILURE)
      IF(StrLen(sopt.ramPen)>0) THEN StrCopy(path,sopt.ramPen) ELSE StringF(path,'\sNode\d/Playpen/',cmds.bbsLoc,node)

      fSUploadingHi,fSUploadingLo:=rFreeSpace(path)

      formatSpaceValue(tFShi,tFSlo,tmp)
      formatSpaceValue(fSUploadingHi,fSUploadingLo,tmp2)
      StringF(sendStr,'230-\s available for uploading.  \s at one time.\b\n',tmp,tmp2)   ->changed to indicate space in mb instead of bytes
      telnetSend(sendStr,EstrLen(sendStr))
    ENDIF

  ENDIF

  state:=STATE_LOGGEDON
  stateData:=0
ENDPROC

PROC processFtpLoggedOnUser()
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF ftpDataPorts:PTR TO LONG
  DEF uploadPath[255]:STRING
  DEF lastDay,currDay
  DEF currTime,i
  DEF cnames:PTR TO stringlist
  DEF cdirs:PTR TO stringlist
  DEF cnums:PTR TO stdlist
  DEF confULBlock:PTR TO stringlist
  DEF ftpData:PTR TO ftpData
  DEF res
  
  setEnvStat(ENV_IDLE)

  reqState:=REQ_STATE_NONE
  StrCopy(tempstr,'')
  StrCopy(tempstr2,'')
  readToolType(TOOLTYPE_BBSCONFIG,'','FTPDATAPORT',tempstr)
  readToolType(TOOLTYPE_NODE,node,'FTPDATAPORT',tempstr2)
  IF (StrLen(tempstr)>0) AND (StrLen(tempstr2)>0) THEN StrAdd(tempstr,',')
  StrAdd(tempstr,tempstr2)
  ftpDataPorts:=makeIntList(tempstr)
  IF ListLen(ftpDataPorts)=0 THEN ListAddItem(ftpDataPorts,10001+(node*2))

  IoctlSocket(telnetSocket,FIONBIO,[0])

  blockOLM:=TRUE

  zModemInfo.currentUL:=0
  zModemInfo.currentDL:=0
  zModemInfo.fileList:=NIL

  StrCopy(securityFlags,'')

  IF(cmds.acLvl[LVL_SCREEN_TO_FRONT] AND scropen) THEN expressToFront()

  newSinceFlag:=0
  currTime:=getSystemTime()
  currDay:=Div(currTime-21600,86400)
  lastDay:=Div(loggedOnUser.timeLastOn-21600,86400)  
  
  IF (lastDay<>currDay)
    StringF(tempstr,'timeused debug: \s logon new day reset,  currday \d, lastday \d',loggedOnUser.name, currDay,lastDay)
    debugLog(LOG_DEBUG,tempstr)

    loggedOnUserKeys.timesOnToday:=0
    loggedOnUser.timeUsed:=0
    loggedOnUser.chatRemain:=loggedOnUser.chatLimit
    loggedOnUser.dailyBytesDld:=0
    loggedOnUser.timeTotal:=loggedOnUser.timeLimit
    loggedOnUser.todaysBytesLimit:=loggedOnUser.dailyBytesLimit
  ELSE
    IF loggedOnUser.dailyBytesLimit=0
      loggedOnUser.todaysBytesLimit:=0
    ELSE
      IF loggedOnUser.todaysBytesLimit<loggedOnUser.dailyBytesLimit THEN loggedOnUser.todaysBytesLimit:=loggedOnUser.dailyBytesLimit
    ENDIF
    loggedOnUserKeys.timesOnToday:=loggedOnUserKeys.timesOnToday+1
    StringF(tempstr,'timeused debug: \s logon same day,  currday \d, lastday \d, timeused \d, todays dl \d',loggedOnUser.name,currDay,lastDay,loggedOnUser.timeUsed,loggedOnUser.dailyBytesDld)
    debugLog(LOG_DEBUG,tempstr)
  ENDIF

  timeLimit:=loggedOnUser.timeTotal-loggedOnUser.timeUsed
  IF (loggedOnUser.todaysBytesLimit<>0)
    bytesADL:=loggedOnUser.todaysBytesLimit-loggedOnUser.dailyBytesDld
  ELSE
    bytesADL:=$7fffffff
  ENDIF
  updateTimeUsed()
  StringF(tempstr,'230 Time remaining for today \d mins.\b\n',Div(loggedOnUser.timeTotal-loggedOnUser.timeUsed,60))
  telnetSend(tempstr,EstrLen(tempstr))

  currentConf:=0
  lastOlmNode:=-1

  IF(StrLen(sopt.ramPen)>0) THEN StrCopy(uploadPath,sopt.ramPen) ELSE StringF(uploadPath,'\sNode\d/Playpen/',cmds.bbsLoc,node)

  cnames:=NEW cnames.stringlist(cmds.numConf)
  cdirs:=NEW cdirs.stringlist(cmds.numConf)
  cnums:=NEW cnums.stdlist(cmds.numConf)
  confULBlock:=NEW confULBlock.stringlist(cmds.numConf)
  FOR i:=1 TO cmds.numConf
    IF checkConfAccess(i) AND (checkToolTypeExists(TOOLTYPE_CONF,i,'EXCLUDE_FTP')=FALSE)
      IF readToolType(TOOLTYPE_CONF,i,'FTPDIRNAME',tempstr)=FALSE
        StrCopy(tempstr,confNames.item(i-1))
      ENDIF
      removeSlashes(tempstr)
      cnames.add(tempstr)
      cdirs.add(confDirs.item(i-1))
      cnums.add(i)
      IF readToolType(TOOLTYPE_CONF,i,'NO_FTP_UPLOADS',tempstr)
        IF StrLen(tempstr)=0
          confULBlock.add('FTP uploads not allowed in this conference')
        ELSE
          confULBlock.add(tempstr)
        ENDIF
      ELSE
        confULBlock.add('')
      ENDIF
    ENDIF
  ENDFOR

  res:=FALSE
  FOR i:=0 TO xprLib.count()-1
    IF(StriCmp(xprLib.item(i),'FTP'))
      IF readToolType(TOOLTYPE_XFERLIB,i,'FTPHOST',tempstr) THEN res:=TRUE
    ENDIF
  ENDFOR

  IF res=FALSE
    IF readToolType(TOOLTYPE_BBSCONFIG,'','FTPHOST',tempstr)=FALSE
      StrCopy(tempstr,'127.0.0.1')
    ENDIF
  ENDIF
  
  IF reqState=REQ_STATE_NONE
  
    ftpData:=NEW ftpData
    ftpData.aePuts:=NIL
    ftpData.conPuts:={conPuts}
    ftpData.readChar:=NIL
    ftpData.sCheckInput:=NIL
    ftpData.getPath:={ftpGetPath}
    ftpData.findFile:={ftpFindFile}
    ftpData.checkDownloadRatio:={ftpCheckRatio}
    ftpData.uploadFileStart:={ftpUploadFileStart}
    ftpData.uploadFileEnd:={ftpUploadFileEnd}
    ftpData.uploadFileProgress:={ftpTransferFileProgress}
    ftpData.downloadFileStart:={ftpDownloadFileStart}
    ftpData.downloadFileEnd:={ftpDownloadFileEnd}
    ftpData.downloadFileProgress:={ftpTransferFileProgress}
    ftpData.callersLog:={callersLog}
    ftpData.fileDupeCheck:={ftpDupeCheck}
    ftpData.ftpAuth:=NIL
    ftpData.processMessages:={processMessages}
    ftpData.getSigs:={getSigs}
    ftpData.startFileCheck:={ftpStartFileCheck}
    ftpData.waitFileCheck:={ftpWaitFileCheck}

    ftpData.confNames:=cnames
    ftpData.confDirs:=cdirs
    ftpData.confNums:=cnums
    ftpData.confULBlock:=confULBlock

    ftpServerMode(ftpData,telnetSocket,tempstr,uploadPath,ftpDataPorts,cmds.acLvl[LVL_CAPITOLS_in_FILE]<>0)
    END ftpData
  ENDIF

  END cnames
  END cdirs
  END cnums
  END confULBlock
  
  ->CloseSocket(telnetSocket)
  ->telnetSocket:=-1
 
  IF reqState=REQ_STATE_NONE THEN reqState:=REQ_STATE_LOGOFF
  
  DisposeLink(ftpDataPorts)
ENDPROC

PROC processSysopLogon()
  DEF tempstr[255]:STRING

  setEnvStat(ENV_CONNECT)
  logonTime:=getSystemTime()
  lastTimeUpdate:=logonTime
  loggedOnUser:=NEW loggedOnUser
  loggedOnUserKeys:=NEW loggedOnUserKeys
  loggedOnUserMisc:=NEW loggedOnUserMisc
  IF cacheResetOn=CACHE_RESET_LOGON THEN clearDiskObjectCache()

  sendCLS()

  -> load sysop user data
  IF loadAccount(1,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)<>RESULT_SUCCESS
    IF newUserAccount(cmds.sysopName)<>RESULT_SUCCESS
      END loggedOnUser
      END loggedOnUserKeys
      END loggedOnUserMisc
      loggedOnUser:=NIL
      loggedOnUserKeys:=NIL
      loggedOnUserMisc:=NIL
      reqState:=REQ_STATE_LOGOFF
      RETURN
    ENDIF
  ENDIF

  IF (netTrans<>0)
    AstrCopy(loggedOnUser.name,'NetMail Transfer',31)
    AstrCopy(loggedOnUser.location,'In Progress...',30)
    StrCopy(connectString,'SYSOP_LOCAL')
  ENDIF

  masterLoadPointers(loggedOnUser)
  convertAccess()
  logonType:=LOGON_TYPE_SYSOP
  confNameType:=NAME_TYPE_USERNAME
  displayUserToCallersLog(0)
  updateCallerNum()
  checkUserOnLine(0)
  validUser:=1
  ximPort:=CONSOLE_PORT
  state:=STATE_LOGGEDON
  setEnvStat(ENV_LOGGINGON)
  lostCarrier:=FALSE
  ripMode:=FALSE
  ansiColour:=TRUE
  mcioff:=FALSE
  mciViewSafe:=TRUE
  lineCount:=0
  

  IF readToolType(TOOLTYPE_NODE,node,'FORCE_ANSI',tempstr)
    UpperStr(tempstr)

    IF (InStr(tempstr,'N',0)>=0)
      ansiColour:=FALSE
    ENDIF

    IF (InStr(tempstr,'Q',0)>=0) AND (sopt.qLogon<>0) THEN quickFlag:=TRUE
    IF (InStr(tempstr,'R',0)>=0) THEN ripMode:=TRUE
  ELSE
    runSysCommand('ANSI','')
  ENDIF

  IF (netTrans<>0)
    runSysCommand(arg3,'')
    logoffLog('N')
    END loggedOnUser
    END loggedOnUserKeys
    END loggedOnUserMisc
    loggedOnUser:=NIL
    loggedOnUserKeys:=NIL
    loggedOnUserMisc:=NIL
    reqState:=REQ_STATE_LOGOFF
    checkShutDown()
    RETURN
  ENDIF

  stateData:=0
ENDPROC

PROC processOlmMessageQueue(showMessages)
  DEF temp

  IF olmQueue.count()>0
    IF showMessages
      aePuts('\b\nDisplaying Message Queue\b\n')
      FOR temp:=0 TO olmQueue.count()-1
        aePuts(olmQueue.item(temp))
      ENDFOR
    ENDIF
    olmQueue.clear()
  ENDIF
ENDPROC

PROC displayReserveNotice()
  DEF tempstr[255]:STRING

  StringF(tempstr,'\b\nNode \d is reserved right now, please try again later\b\n',node)
  aePuts(tempstr)
ENDPROC

PROC doReserve(username:PTR TO CHAR)
  IF(StrLen(reservedName)>0)
    IF(StriCmp(username,reservedName))=FALSE
      displayReserveNotice()
      Delay(60)
      RETURN 1
    ENDIF
  ENDIF
ENDPROC 0


PROC checkPassword()
  DEF tries=0,stat,lfh,i,r
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF resetCode[25]:STRING
  DEF resetChars[62]:STRING
  LOOP

    displayUserToCallersLog(0)

    REPEAT
      StrCopy(resetCode,'')
      IF(tries>2)
        aePuts('\b\nExcessive Password Failure\b\n')

        IF checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'MAIL_ON_PWD_FAIL') AND (StrLen(mailOptions.smtpHost)>0) AND (StrLen(loggedOnUserMisc.eMail)>0)

          aePuts('\b\nDo you want to send a reset code to your email address ')
          stat:=yesNo(1)
          IF(stat<0) THEN RETURN RESULT_SLEEP_LOGOFF
          IF stat
            FOR i:=1 TO 10
              StrCopy(resetChars,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789')
              r:=Rnd(StrLen(resetChars))
              StrAdd(resetCode,resetChars+r,1)
            ENDFOR
            
            StringF(tempStr,'\s: Ami-Express password failure notification',cmds.bbsName)
            StrCopy(tempStr2,'You have forgotten your password and requested a reset code. If you did not request the reset code then please ignore this email\b\n\b\n')
            StrAdd(tempStr2,'The reset code is : ')
            StrAdd(tempStr2,resetCode)
            StrAdd(tempStr2,'\b\n\b\nYou can use this code to reset your password and gain access to the system\b\n')
            sendMail(tempStr,tempStr2,FALSE,NIL,0,loggedOnUserMisc.eMail)
            
            aePuts('\b\nA reset code has been sent to yuour email address. Please enter it exactly below\b\n\b\n')
            stat:=lineInput('Reset code: ','',20,INPUT_TIMEOUT,tempStr)
            IF(stat<0) THEN RETURN RESULT_SLEEP_LOGOFF
            
            IF StrCmp(tempStr,resetCode)=FALSE
              aePuts('\b\nThe reset code was not correct.\b\n')
              StrCopy(resetCode,'')
            ELSE
              aePuts('\b\nThe reset code was correct, please now update your password.\b\n\b\n')
              aePuts('Password: ')
              stat:=lineInput('','',50,INPUT_TIMEOUT,tempStr)
              IF(stat<0) THEN RETURN RESULT_NO_CARRIER
              IF(StrLen(tempStr)>0)
                setNewPassword(loggedOnUser,loggedOnUserMisc,tempStr)
                loggedOnUserMisc.pwdLastUpdated:=getSystemTime()
              ENDIF
            ENDIF           
          ENDIF
        ENDIF
        IF StrLen(resetCode)=0
          runSysCommand('PWFAIL','')
          JUMP logoffErr
        ENDIF
      ENDIF
      IF StrLen(resetCode)=0
        stat:=getPass2(passwordPrompt,0,TRUE,50,tempStr)
        IF(stat<0)
          IF stat=RESULT_NO_CARRIER THEN RETURN RESULT_NO_CARRIER ELSE RETURN RESULT_SLEEP_LOGOFF
        ENDIF
      ELSE
        stat:=RESULT_SUCCESS
      ENDIF
      IF(stat<>RESULT_SUCCESS)
        StringF(tempStr2,'\tPassword Failure (\s)',tempStr)
        callersLog(tempStr2)
        aePuts('Invalid PassWord\b\n')
        tries++
      ENDIF

    UNTIL stat=RESULT_SUCCESS

    IF(checkToolTypeExists(TOOLTYPE_NODE,node,'PHONECHECK'))
      tries:=0
      REPEAT
        IF(tries>2)
          aePuts('\b\nExcessive PhoneNumber Failure\b\n')
          JUMP logoffErr
        ENDIF
        StrCopy(tempStr,loggedOnUser.phoneNumber)
        RightStr(tempStr2,tempStr,4)

        aePuts('Last 4 digits of your PhoneNumber: ')
        stat:=lineInput('','',4,INPUT_TIMEOUT,tempStr)
        IF(stat<0) THEN RETURN RESULT_SLEEP_LOGOFF
        IF(logonType>=LOGON_TYPE_REMOTE)
          stat:=checkCarrier()
          IF(stat=FALSE) THEN RETURN RESULT_SLEEP_LOGOFF
        ENDIF

        stat:=stringCompare(tempStr,tempStr2)
        IF(stat<>RESULT_SUCCESS)
          StringF(tempStr2,'\tPhoneNumber Failure (\s)',tempStr)
          callersLog(tempStr2)
          aePuts('Invalid PhoneNumber\b\n')
          tries++
        ENDIF
      UNTIL stat=RESULT_SUCCESS
    ENDIF
    statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)

    IF(uucp)
      IF(loggedOnUser.uucpa)
        validUser:=3
        conPuts('\b\nSystem dropping to UUCP...')
        callersLog('\tReceiving UUCP feed')
        purgeLineEnd()
        IF(lfh:=Open('NIL:',MODE_OLDFILE))<>0
          StringF(tempStr,'\sUtils/uucico -D \s -U \d -Getty -xx',cmds.bbsLoc,cmds.serDev,cmds.serDevUnit)
          Execute(tempStr,lfh,lfh)
          Close(lfh)
        ENDIF
        purgeLineStart()
        dropDTR()
        RETURN RESULT_FAILURE
      ENDIF
      aePuts('UUCP access has been denied!\b\n\b\n')
    ENDIF
    RETURN RESULT_SUCCESS
  ENDLOOP
logoffErr:
  callersLog('\t* Password Failure *')
ENDPROC RESULT_FAILURE

PROC checkBaudCallingTime()

  DEF tempstr[255]:STRING
  DEF startTime,endTime,time


  time:=Div(getSystemTime(),60) ->remove seconds
  time:=Mod(time,1440)   ->hours and minutes only
  time:= Mod(time,60) + Mul(Div(time,60),100)   ->convert to number between 0000 and 2359

  IF(checkSecurity(ACS_OVERRIDE_TIMES)) THEN RETURN TRUE

  StringF(tempstr,'START.\d',onlineBaud)
  startTime:=readToolTypeInt(TOOLTYPE_NODE_TIMES,node,tempstr)
  IF startTime=-1 THEN startTime:=0

  StringF(tempstr,'END.\d',onlineBaud)
  endTime:=readToolTypeInt(TOOLTYPE_NODE_TIMES,node,tempstr)
  IF endTime=-1 THEN endTime:=2359

  IF (endTime<startTime)
    IF((time>=endTime) AND (time<startTime)) THEN RETURN FALSE
    RETURN TRUE
  ENDIF

  IF(time>=startTime) THEN IF(time<=endTime) THEN RETURN TRUE ELSE RETURN FALSE
ENDPROC

PROC baudTime()
  DEF stat
  DEF tempstr[255]:STRING

  stat:=checkBaudCallingTime()
  IF(stat=FALSE)
    IF(stat:=displayScreen(SCREEN_NOT_TIME)=FALSE)
      StringF(tempstr,'\b\n\d baud is not allowed at this time.\b\n\b\n',onlineBaud)
      aePuts(tempstr)
    ENDIF
    stat:=FALSE
    Delay(120)
  ENDIF
ENDPROC stat

PROC doSystemPassword()
  DEF sysprompt[255]:STRING
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF stat,tries

  runSysCommand('SYSTEMPW','')
  IF(logonType>=LOGON_TYPE_REMOTE)
    stat:=checkCarrier()
    IF(stat=FALSE)
      state:=STATE_LOGGING_OFF
      RETURN RESULT_FAILURE
    ENDIF
  ENDIF
  IF reqState=REQ_STATE_LOGOFF
    state:=STATE_LOGGING_OFF
    RETURN RESULT_FAILURE
  ENDIF

  IF (StrLen(cmds.sysPass)=0) THEN RETURN RESULT_SUCCESS

  aePuts('\b\n')
  IF readToolType(TOOLTYPE_NODE,node,'SYS_PWRD_PROMPT',sysprompt)=FALSE THEN StrCopy(sysprompt,'>: ')

  tries:=1
  WHILE tries<4
    displayScreen(SCREEN_PRIVATE)
    stat:=getPass2(sysprompt,cmds.sysPass,0,30,tempStr)
    IF(stat<0)
      state:=STATE_LOGGING_OFF
      RETURN RESULT_FAILURE
    ENDIF
    EXIT stat=RESULT_SUCCESS
    aePuts('Invalid PassWord\b\n')
    StringF(tempStr2,'\t**System Password Failure \s **',tempStr)
    callersLog(tempStr2)
    tries++
  ENDWHILE

  IF(tries=4)
    callersLog('System Password Failure')
    runSysCommand('SYSPWDFAIL','')
    state:=STATE_LOGGING_OFF
    RETURN RESULT_FAILURE
  ENDIF
  aePuts('\b\n')
ENDPROC RESULT_SUCCESS

PROC applyPreset(userData:PTR TO user,presetType,presetNum)
  DEF tempStr[255]:STRING
  IF readToolType(presetType,presetNum,'PRESET.AREA',tempStr)
    userData.secStatus:=readToolTypeInt(presetType,presetNum,'PRESET.ACCESS')
    userData.secBoard:=readToolTypeInt(presetType,presetNum,'PRESET.RATIO_TYPE')
    userData.secLibrary:=readToolTypeInt(presetType,presetNum,'PRESET.RATIO')
    userData.timeLimit:=readToolTypeInt(presetType,presetNum,'PRESET.TIME_LIMIT')
    userData.confRJoin:=readToolTypeInt(presetType,presetNum,'PRESET.CONFRJOIN')
    userData.msgBaseRJoin:=readToolTypeInt(presetType,presetNum,'PRESET.MSGBASERJOIN')
    userData.dailyBytesLimit:=readToolTypeInt(presetType,presetNum,'PRESET.DAILY_BYTE_LIMIT')
    readToolType(presetType,presetNum,'PRESET.AREA',tempStr)
    AstrCopy(userData.conferenceAccess,tempStr,10)
  ENDIF
ENDPROC


PROC handleIemsi()
  DEF ch
  DEF iemsiDone=0
  DEF s,i
  DEF tempStr
  DEF tempStr2[255]:STRING
  DEF iemsiData[255]:STRING
  DEF bracketCount=0
  DEF crc,checkcrc,checklen
  
  tempStr:=String(2048)
  
  ch:="*"
  REPEAT
    IF (ch>31) THEN StrAddChar(tempStr,ch)
    WHILE (ch<>13) AND (ch>0)
      ch:=readChar(1)
      IF ch<0
        DisposeLink(tempStr)
        RETURN
      ENDIF
      
      IF (ch>31) THEN StrAddChar(tempStr,ch)
      IF ((s:=StrLen(tempStr))<8) AND (StrCmp(tempStr,'**EMSI_',s)=FALSE)
        DisposeLink(tempStr)        
        RETURN
      ENDIF
    ENDWHILE
    IF (ch=13) AND (InStr(tempStr,'**EMSI_ICI')=0)   
     
      crc:=crc32str(tempStr+2,StrLen(tempStr)-10)
      
      StringF(tempStr2,'$\s',tempStr+StrLen(tempStr)-8)
      checkcrc:=Val(tempStr2)
      StringF(tempStr2,'$\s[4]',tempStr+10)
      checklen:=Val(tempStr2)+22
    
      IF (crc<>checkcrc) OR (checklen<>StrLen(tempStr))
        serPuts('**EMSI_NAKEEC3\b')
      ELSE
        StrCopy(iemsiData,tempStr)
        StringF(tempStr,'{Ami-Express,\s}{\s}{\s}{\s}{\r\z\h[8]}{}{\\0}{}',expressVer,cmds.bbsName,mybbsLoc,cmds.sysopName,getSystemTime()-21600)
        StringF(tempStr,'**EMSI_ISI\r\z\h[4]\s',StrLen(tempStr),tempStr)
        crc:=crc32str(tempStr+2,StrLen(tempStr)-2)
        
        StringF(tempStr,'\s\r\z\h[8]\b',tempStr,crc)     
        serPuts(tempStr)
        iemsiDone:=1
      ENDIF
    ENDIF
    IF (iemsiDone AND (InStr(tempStr,'**EMSI_ACKA490')=0))
      iemsiDone++
    ENDIF
    IF iemsiDone<>3
      IF (InStr(tempStr,'**EMSI_NAKEEC3')=0)
        StrCopy(iemsiData,'')
        iemsiDone:=0
      ENDIF
    
      StrCopy(tempStr,'')
      ch:=readChar(1)
    ENDIF
  UNTIL (iemsiDone=3) OR (ch<0)
  bracketCount:=0
  StrCopy(tempStr,'')
  FOR i:=0 TO StrLen(iemsiData)-1
    IF bracketCount>0
      IF iemsiData[i]<>"}"
        StrAddChar(tempStr,iemsiData[i])
      ELSE
        IF bracketCount=1 THEN StrCopy(iemsiUsername,tempStr)
        IF bracketCount=6 THEN StrCopy(iemsiPassword,tempStr)
      ENDIF
    ENDIF
    IF iemsiData[i]="{"
      bracketCount++
      StrCopy(tempStr,'')
    ENDIF
  ENDFOR
  DisposeLink(tempStr)
ENDPROC

PROC processLogon()
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF userName[28]:STRING
  DEF dateStr[30]:STRING
  DEF retryCount
  DEF userFound
  DEF newUser
  DEF userNum
  DEF stat,ch
  DEF hrs,calcHrs,autovalPreset,pwdExpiryDays

  ripMode:=FALSE
  confNameType:=NAME_TYPE_USERNAME
  state:=STATE_CONNECTING
  stateData:=0
  lostCarrier:=FALSE
  lineCount:=0
  setEnvStat(ENV_CONNECT)
  IF cacheResetOn=CACHE_RESET_LOGON THEN clearDiskObjectCache()

  conCLS()
  conPuts('[0m')

  IF (checkToolTypeExists(TOOLTYPE_NODE,node,'STEALTH_MODE'))
    IF doSystemPassword()<>RESULT_SUCCESS THEN RETURN
  ENDIF

  conCursorOn()

  IF displayScreen(SCREEN_NOCALLERSATBAUD)
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  aePuts(connectString)
  aePuts('\b\n')
  
  StrCopy(iemsiUsername,'')
  StrCopy(iemsiPassword,'')
  IF (Not(checkToolTypeExists(TOOLTYPE_NODE,node,'DISABLE_IEMSI'))) AND (logonType=LOGON_TYPE_REMOTE)
    aePuts('**EMSI_IRQ8E08\b\n')
    ch:=readChar(1)
    WHILE (ch>=0) AND (ch<>"*")
      ch:=readChar(1)
    ENDWHILE
    IF ch="*" THEN handleIemsi()
  ENDIF

  IF (serialCache<>NIL) THEN serialCacheEnabled:=TRUE

  IF (StrLen(mybbsLoc)>0)
    StringF(tempStr,'\b\n[0mWelcome to \s, located in \s',cmds.bbsName,mybbsLoc)
  ELSE
    StringF(tempStr,'\b\n[0mWelcome to \s.',cmds.bbsName)
  ENDIF
  aePuts(tempStr)

  StringF(tempStr,'\b\n\b\nRunning AmiExpress \s Copyright ©2018-2023 Darren Coles\b\n',expressVer)
  aePuts(tempStr)
  StringF(tempStr,'Registration \s. You are connected to Node \d at \d baud',regKey,node,onlineBaud)
  aePuts(tempStr)
  formatLongDateTime(getSystemTime(),dateStr)
  StringF(tempStr,'\b\nConnection occured at \s.\b\n',dateStr)

  aePuts(tempStr)
  aePuts('\b\n')

  runSysCommand('FRONTEND','')

  IF readToolType(TOOLTYPE_NODE,node,'FORCE_ANSI',tempStr)=FALSE
    IF (runSysCommand('ANSI','')<>RESULT_SUCCESS)
      aePuts('ANSI, RIP or No graphics (A/r/n)? ')

      stat:=lineInput('','',10,INPUT_TIMEOUT/2,tempStr,FALSE)
      IF stat<>RESULT_SUCCESS
        state:=STATE_LOGGING_OFF
        RETURN
      ENDIF
    ELSE
     StrCopy(tempStr,'')
    ENDIF
  ENDIF
  UpperStr(tempStr)

  IF (InStr(tempStr,'N',0)>=0)
    ansiColour:=FALSE
  ENDIF

  IF (InStr(tempStr,'Q',0)>=0) AND (sopt.qLogon<>0) THEN quickFlag:=TRUE
  IF (InStr(tempStr,'R',0)>=0) THEN ripMode:=TRUE

  IF (Not(checkToolTypeExists(TOOLTYPE_NODE,node,'STEALTH_MODE')))
    IF doSystemPassword()<>RESULT_SUCCESS THEN RETURN
  ENDIF

  displayScreen(SCREEN_BBSTITLE)

  IF(StrLen(reservedName)>0)
    StringF(tempStr,'\b\n*** Node \d is reserved right now, for \s ***\b\n',node,reservedName)
    aePuts(tempStr)
  ENDIF

  IF logonType=LOGON_TYPE_REMOTE THEN ximPort:=SERIAL_PORT ELSE ximPort:=CONSOLE_PORT
  retryCount:=0
  userFound:=FALSE
  newUser:=FALSE

  updateCallerNum()

  validUser:=2

logonLoop:
  REPEAT

  StringF(tempStr,'\b\n\s ',namePrompt)
  
  IF StrLen(iemsiUsername)>0
    StrAdd(tempStr,iemsiUsername)
    StrAdd(tempStr,'\b\n')
    aePuts(tempStr)
    stat:=RESULT_SUCCESS
    StrCopy(userName,iemsiUsername)
    StrCopy(iemsiUsername,'')
  ELSE
    stat:=lineInput(tempStr,'',28,INPUT_TIMEOUT/2,userName)
  ENDIF
  IF stat<>RESULT_SUCCESS
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  IF (StrLen(userName)>0)

    uucp:=0
    StrCopy(tempStr,userName)
    IF StrCmp(tempStr,'UUCP.',5)
      uucp:=1
      StrCopy(userName,tempStr+5)
    ENDIF

    userNum:=Val(userName)
    IF (checkToolTypeExists(TOOLTYPE_NODE,node,'USERNUMBER_LOGIN')) AND (userNum>0)
      IF loadAccount(userNum,tempUser,tempUserKeys,tempUserMisc)=RESULT_SUCCESS THEN stat:=userNum ELSE stat:=0
    ELSE
      stat:=chooseAName(userName,tempUser,tempUserKeys,tempUserMisc,0)
    ENDIF

    setEnvStat(ENV_ACCOUNTSEQ)

    IF (stat=RESULT_FAILURE)
      IF StriCmp(userName,'NEW')=FALSE
        StringF(tempStr,'\b\nThe name \s is not used on this BBS.\b\n',userName)
        aePuts(tempStr)
        StrCopy(tempStr,'[R]etry your name or [C]ontinue as a new user? ')
      ELSE
        aePuts('\b\n')
        StrCopy(tempStr,'[C]ontinue as a new user? ')
      ENDIF
      stat:=lineInput(tempStr,'',28,INPUT_TIMEOUT/2,tempStr)
      IF stat<>RESULT_SUCCESS
        state:=STATE_LOGGING_OFF
        RETURN
      ENDIF

      UpperStr(tempStr)
      IF StrCmp(tempStr,'C') THEN newUser:=TRUE ELSE retryCount++
    ELSE
      userNum:=tempUser.slotNumber
      userFound:=TRUE
    ENDIF
  ELSE
    retryCount++
  ENDIF

  UNTIL (userFound) OR (newUser) OR (retryCount=5)

  IF retryCount=5
    aePuts('\b\nToo Many Errors, Goodbye!\b\n')
    Delay(50)
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  stat:=doReserve(userName)
  IF(stat)
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  IF newUser
    IF newUserAccount(userName)<>RESULT_SUCCESS
      END loggedOnUser
      END loggedOnUserKeys
      END loggedOnUserMisc
      loggedOnUser:=NIL
      loggedOnUserKeys:=NIL
      loggedOnUserMisc:=NIL
      state:=STATE_LOGGING_OFF
      RETURN
    ENDIF
  ELSE
    logonTime:=getSystemTime()
    lastTimeUpdate:=logonTime
    loggedOnUser:=NEW loggedOnUser
    loggedOnUserKeys:=NEW loggedOnUserKeys
    loggedOnUserMisc:=NEW loggedOnUserMisc

    stat:=loadAccount(userNum,loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
    IF(stat=RESULT_FAILURE)
      END loggedOnUser
      END loggedOnUserKeys
      END loggedOnUserMisc
      aePuts('That account has problems\b\n')
      retryCount++
      JUMP logonLoop
    ENDIF
  ENDIF

  IF loggedOnUser.newUser
    IF readToolType(TOOLTYPE_NODE,node,'AUTOVAL_DELAY',tempStr)=FALSE
      readToolType(TOOLTYPE_BBSCONFIG,0,'AUTOVAL_DELAY',tempStr)
    ENDIF
    
    IF StrLen(tempStr)>0
      hrs:=Val(tempStr)
      
      IF hrs>0
        calcHrs:=Div(getSystemTime()-loggedOnUser.accountDate,3600)
        IF (calcHrs>=hrs)
          IF readToolType(TOOLTYPE_NODE,node,'AUTOVAL_PRESET',tempStr)=FALSE
            readToolType(TOOLTYPE_BBSCONFIG,0,'AUTOVAL_PRESET',tempStr)
          ENDIF
          IF StrLen(tempStr)>0
            autovalPreset:=Val(tempStr)
            applyPreset(loggedOnUser,TOOLTYPE_PRESET,autovalPreset)
            loggedOnUser.newUser:=0
          ENDIF
        ENDIF
      ENDIF
    ENDIF
  ENDIF
    
  setEnvStat(ENV_LOGGINGON)
  sendQuietFlag(quietFlag)

  IF(loggedOnUser.slotNumber=0)
    aePuts('That account has been deleted.\b\n')
    END loggedOnUser
    loggedOnUser:=NIL
    END loggedOnUserKeys
    loggedOnUserKeys:=NIL
    END loggedOnUserMisc
    loggedOnUserMisc:=NIL

    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  stat:=checkUserOnLine(1)
  IF(stat=FALSE)
    StringF(tempStr,'User \s already on another node!',loggedOnUser.name)
    callersLog(tempStr)
    IF displayScreen(SCREEN_ONENODE)=FALSE THEN aePuts('\b\nYou are already logged into another node!\b\n')
    state:=STATE_LOGGING_OFF
    Delay(50)
    END loggedOnUser
    loggedOnUser:=NIL
    END loggedOnUserKeys
    loggedOnUserKeys:=NIL
    END loggedOnUserMisc
    loggedOnUserMisc:=NIL
    RETURN
  ENDIF

  IF newUser=FALSE
    IF logonType>=LOGON_TYPE_REMOTE
      stat:=checkPassword()
      IF stat<>RESULT_SUCCESS
        IF stat=RESULT_NO_CARRIER 
          logoffLog('Loss Carrier')
        ELSE
          logoffLog('N')
        ENDIF
        
        saveAccount(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,0,0)
        END loggedOnUser
        loggedOnUser:=NIL
        END loggedOnUserKeys
        loggedOnUserKeys:=NIL
        END loggedOnUserMisc
        loggedOnUserMisc:=NIL
        state:=STATE_LOGGING_OFF
        RETURN
      ENDIF
    ELSE
      displayUserToCallersLog(0)
    ENDIF
  ENDIF

  validUser:=1
  convertAccess()

  loggedOnUserKeys.baud:=onlineBaud
  masterLoadPointers(loggedOnUser)

  stat:=baudTime()
  IF(stat=FALSE)
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  IF (loggedOnUser.secStatus<=1)
    acsLevel:=loggedOnUser.secStatus
    IF (acsLevel=0) THEN displayScreen(SCREEN_LOCKOUT0) ELSE displayScreen(SCREEN_LOCKOUT1)
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF

  IF loggedOnUserMisc.accountLocked
    aePuts('\b\nYour account is locked out (possibly due to repeated password failures)\b\n\b\n')
    aePuts('Leave a comment for the sysop...\b\n\b\n')
    processCommand('C')

    aePuts('\b\nThanks you will now be disconnected...\b\n\b\n') 
    state:=STATE_LOGGING_OFF
    RETURN
  ENDIF
   
  pwdExpiryDays:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'PASSWORD_EXPIRY_DAYS') 
  IF pwdExpiryDays>=0
    IF (loggedOnUserMisc.pwdLastUpdated+Mul(pwdExpiryDays,86400))<getSystemTime()
      loggedOnUserMisc.forcePwdReset:=TRUE
    ENDIF
  ENDIF
  
  IF loggedOnUserMisc.forcePwdReset
    IF (checkSecurity(ACS_EDIT_PASSWORD)=FALSE)

      aePuts('\b\nYour account requires your password to be changed, however you do not have permission to do so.\b\n')
      aePuts('Leave a comment for the sysop...\b\n\b\n')
      processCommand('C')

      aePuts('\b\nThanks you will now be disconnected...\b\n\b\n') 
      state:=STATE_LOGGING_OFF
      RETURN
    ENDIF
    
    retryCount:=1
    aePuts('\b\nYour account requires your password to be changed.\b\n\b\n')
    REPEAT
      stat:=getPass2('Enter New Password: ',0,0,50,tempStr)
      IF (stat=RESULT_SUCCESS) AND (StrLen(tempStr))
        stat:=getPass2('Reenter New Password: ',0,0,50,tempStr2)
        IF (stat=RESULT_SUCCESS) AND (StrLen(tempStr2))
          IF StrCmp(tempStr,tempStr2)
            IF checkUserPassword(loggedOnUser,loggedOnUserMisc,tempStr)
              aePuts('\b\nYour new password must be different from your old password...\b\n\b\n') 
            ELSE
              stat:=checkPasswordStrength(tempStr)
              IF stat<>TRUE
                IF stat=1
                  stat:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'MIN_PASSWORD_LENGTH') 
                  StringF(tempStr,'\b\nPassword length must be at least \d chars, try again..\b\n\b\n',stat)
                  aePuts(tempStr)
                ELSEIF stat=2
                  stat:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'MIN_PASSWORD_STRENGTH') 
                  StringF(tempStr,'\b\nPassword must have at least \d of these:\b\n  upper case,lower case, numeric and symbols, try again..\b\n\b\n',stat)
                  aePuts(tempStr)
                ENDIF 
              ELSE
                setNewPassword(loggedOnUser,loggedOnUserMisc,tempStr)
                loggedOnUserMisc.pwdLastUpdated:=getSystemTime()
                loggedOnUserMisc.forcePwdReset:=FALSE
              ENDIF
            ENDIF
          ELSE
            aePuts('\b\nPasswords do not match, please try again.\b\n\b\n')
          ENDIF
        ENDIF
      ENDIF
      retryCount++
    UNTIL (retryCount>3) OR (loggedOnUserMisc.forcePwdReset=FALSE)

    IF (loggedOnUserMisc.forcePwdReset)
      aePuts('\b\nYou have not updated your password so you will now be disconnected...\b\n\b\n') 
      state:=STATE_LOGGING_OFF
      RETURN
    ENDIF
  ENDIF
      
  IF logonType>=LOGON_TYPE_REMOTE
    doLogonNotify()
  ENDIF

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)

  IF (quickFlag=FALSE)
    IF (displayScreen(SCREEN_LOGON)) THEN doPause()
  ENDIF

  processOlmMessageQueue(FALSE)

  state:=STATE_LOGGEDON
  stateData:=0
ENDPROC

PROC displayKeys()
  aePuts('         [44;33m F1 [40;35m  }- [33mSysop Login             [44;33m F2 [40;35m  }- [33mLocal Login\b\n')
  aePuts('         [44;33m F3 [40;35m  }- [33mInstant Remote Logon    [44;33m F4 [40;35m  }- [33mReserve for a user\b\n')
  aePuts('         [44;33m F5 [40;35m  }- [33mConference Maintenance  [44;33m F6 [40;35m  }- [33mAccount Editing\b\n')
  aePuts('       [44;33m SH+F5 [40;35m }- [33mOpen Shell            [44;33m SH+F6 [40;35m }- [33mView Callerslog\b\n')
  aePuts('         [44;33m F7 [40;35m  }- [33mChat Toggle             [44;33m F8 [40;35m  }- [33mReprogram modem\b\n')
  aePuts('         [44;33m F9 [40;35m  }- [33mExit BBS               [44;33m F10 [40;35m  }- [33mExit BBS [33m([37moff hook[33m)[0m\b\n')
  aePuts('                                       [44;33m SH+F10 [40;35m }- [33mClear tooltype cache[0m')
ENDPROC

PROC processAwait()
  DEF tempstr[255]:STRING
  DEF wasControl,ch
  DEF subState: PTR TO awaitState
  DEF ni:PTR TO nodeInfo

  IF (stateData=0)
    ansiColour:=TRUE
    quickFlag:=FALSE
    lostCarrier:=FALSE
    subState:=NEW subState
    serShared:=FALSE
    subState.subState:=SUBSTATE_DISPLAY_AWAIT
    subState.redrawScreen:=FALSE
    IF(sopt.trapDoor=FALSE) THEN resetSystem()

    stateData:=subState
    logonType:=LOGON_TYPE_LOGGED_OFF
    servercmd:=-1
  ELSE
    subState:=stateData
  ENDIF


  IF (subState.subState=SUBSTATE_DISPLAY_AWAIT) OR subState.redrawScreen
    subState.redrawScreen:=FALSE
    ioFlags[IOFLAG_SCR_OUT]:=-1
    ioFlags[IOFLAG_SER_OUT]:=0
    setEnvStat(ENV_AWAITCONNECT)
    statPrintUser(NIL,NIL,NIL)
    IF dStatBar THEN clearStatusPane()

    IF (sopt.trapDoor=FALSE) AND (netTrans=0)
      IF (KickVersion(40)) AND (bitPlanes>2)
        aePuts('[37m[ s')
      ENDIF
      conCursorOff()

      send017()
      sendCLS()

      StringF(tempstr,'\b\n                     [33m©2018-2023 AmiExpress [37mby[35m Darren Coles[0m\b\n\b\n')
      aePuts(tempstr)

      StringF(tempstr,'                              [33m Original Version:[0m\b\n\b\n')
      aePuts(tempstr)

      StringF(tempstr,'               [33m©1989-1991 [37mby[35m Mike Thomas, Synthetic Technologies[0m\b\n')
      aePuts(tempstr)
      StringF(tempstr,'             [33m©1992-1995 [37mby[35m Joe Hodge, LightSpeed Technologies Inc.[0m\b\n')
      aePuts(tempstr)
      aePuts('\b\n  [33m\b\n')

      IF displayScreen(SCREEN_AWAIT)=FALSE
        displayKeys()
        IF(StrLen(reservedName)>0)
          StringF(tempstr,'         [44;33m     The BBS is reserved for [31m\s[30]  [0m\b\n',reservedName)
          aePuts(tempstr)
        ENDIF
      ENDIF
    ENDIF

    IF subState.subState=SUBSTATE_DISPLAY_AWAIT THEN subState.subState:=SUBSTATE_INPUT
    ioFlags[IOFLAG_SCR_OUT]:=0
    ioFlags[IOFLAG_SER_IN]:=0
  ENDIF

  IF (sopt.trapDoor=FALSE) AND (netTrans=0)
    wasControl,ch:=processInputMessage(1,Shl(1,ownDevSignal),FALSE,FALSE)
    IF (ch=RESULT_SIGNALLED)
      suspendBBS(TRUE)
      displayInitialisingLogo()
      reInitModem()
    ENDIF
    IF dStatBar THEN clearStatusPane()
  ENDIF

  IF (netTrans<>0)
    logonType:=LOGON_TYPE_SYSOP
    intDoReset(sopt.offHook)
    reqState:=REQ_STATE_SYSOPLOGON
  ELSE
    IF sopt.toggles[TOGGLES_MULTICOM]
      ObtainSemaphore(masterNode)
      ni:=(masterNode.myNode[node])
      IF ni.netSocket=-2
        cntr:=cntr+1
        IF cntr=20
          cntr:=0
          ni.netSocket:=-1
        ENDIF
      ELSE
        cntr:=0
      ENDIF    
      ReleaseSemaphore(masterNode)
    ENDIF

    IF (checkSer()) OR (sopt.trapDoor) OR (instantLogon) OR (checkTelnetConnection()) AND (reqState=REQ_STATE_NONE)
      disableNodeMenus(TRUE)
      disableOnlineMenus(FALSE)

      IF checkIncomingCall()=RESULT_CONNECT
        debugLog(LOG_DEBUG,'REMOTE LOGON')
        ioFlags[IOFLAG_SCR_OUT]:=-1
        IF ftpConn
          logonType:=LOGON_TYPE_FTP
        ELSE
          logonType:=LOGON_TYPE_REMOTE
        ENDIF
        reqState:=REQ_STATE_LOGON
      ENDIF
    ENDIF
  ENDIF

  IF reqState<>REQ_STATE_NONE
    END subState
    IF loggedOnUser<>NIL THEN state:=STATE_LOGGING_OFF
    stateData:=0
    IF reqState=REQ_STATE_SYSOPLOGON
      state:=STATE_SYSOPLOGON
      reqState:=REQ_STATE_NONE
    ENDIF
    IF reqState=REQ_STATE_LOGON
      state:=STATE_LOGON
      reqState:=REQ_STATE_NONE
    ENDIF
    RETURN
  ENDIF
ENDPROC

PROC newUserAccount(userName: PTR TO CHAR)
  DEF tempStr[100]:STRING,tempStr2[255]:STRING
  DEF stat,tries=0
  DEF autovalPreset

  IF displayScreen(SCREEN_NONEWUSERS) THEN RETURN RESULT_SLEEP_LOGOFF

  IF displayScreen(SCREEN_NONEWATBAUD)  THEN RETURN RESULT_SLEEP_LOGOFF


  IF StrLen(cmds.newUserPw)>0
    displayScreen(SCREEN_NEWUSERPW)

    REPEAT

      aePuts('Enter New User Password: ')
      stat:=lineInput('','',30,INPUT_TIMEOUT,tempStr)
      IF(stat<0) THEN RETURN RESULT_SLEEP_LOGOFF

      IF(logonType>=LOGON_TYPE_REMOTE)
        stat:=checkCarrier()
        IF(stat=FALSE) THEN RETURN RESULT_SLEEP_LOGOFF
      ENDIF

      IF(StriCmp(tempStr,cmds.newUserPw)) THEN stat:=RESULT_SUCCESS ELSE stat:=RESULT_FAILURE

      IF(stat<>RESULT_SUCCESS)
        IF checkToolTypeExists(TOOLTYPE_NODE,node,'SHOWPWFAIL')
          StringF(tempStr2,'\tPassword Failure (\s)',tempStr)
        ELSE
          StrCopy(tempStr2,'\tPassword Failure (xxxx)')
        ENDIF
        callersLog(tempStr2)
        aePuts('Invalid PassWord\b\n')
        tries++
        IF(tries>2)
          aePuts('\b\nExcessive Password Failure\b\n')
          runSysCommand('NUPFAIL','')
          RETURN RESULT_SLEEP_LOGOFF
        ENDIF
      ENDIF
    UNTIL (stat=RESULT_SUCCESS)

    aePuts('Correct\b\n')
  ENDIF

  IF displayScreen(SCREEN_GUESTLOGON) THEN doPause()

  createNewAccount()

  IF StriCmp(userName,'NEW') THEN StrCopy(userName,'')
  
  AstrCopy(loggedOnUser.name,userName,31)

  IF displayScreen(SCREEN_JOIN) THEN doPause()

  stat:=doNewUser()
  IF stat<>RESULT_SUCCESS THEN RETURN RESULT_SLEEP_LOGOFF

  IF readToolType(TOOLTYPE_NODE,node,'AUTOVAL_PASSWORD',tempStr)=FALSE
    readToolType(TOOLTYPE_BBSCONFIG,0,'AUTOVAL_PASSWORD',tempStr)
  ENDIF
  
  IF StrLen(tempStr)>0
    tries:=5
    WHILE tries
      stat:=lineInput('Enter the auto-validation password (if known): ','',30,INPUT_TIMEOUT,tempStr2)
      IF StrLen(tempStr2)>0
        IF(StriCmp(tempStr,tempStr2))
          aePuts('\b\nAuto-validation password accepted.\b\n')
          IF readToolType(TOOLTYPE_NODE,node,'AUTOVAL_PRESET',tempStr)=FALSE
            readToolType(TOOLTYPE_BBSCONFIG,0,'AUTOVAL_PRESET',tempStr)
          ENDIF
          IF StrLen(tempStr)>0
            autovalPreset:=Val(tempStr)
            applyPreset(loggedOnUser,TOOLTYPE_PRESET,autovalPreset)
            loggedOnUser.newUser:=0
          ENDIF
          tries:=0
        ELSE
          tries--
          IF tries>0 THEN aePuts('\b\nIncorrect password, try again or leave blank if not known.\b\n\b\n')
          
        ENDIF
      ELSE
        tries:=0
      ENDIF
    ENDWHILE
  ENDIF

  IF (loggedOnUser.dailyBytesLimit<>0)
    bytesADL:=loggedOnUser.dailyBytesLimit
  ELSE
    bytesADL:=$7fffffff
  ENDIF
  convertAccess();

  loggedOnUserKeys.number:=loggedOnUser.slotNumber

  loggedOnUserKeys.baud:=onlineBaud;    /* hold last logged on baud rate */
  validUser:=0;                          /* not a valid user yet */

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)

  purgeLine()

  stat:=doNewUserQuestions()
  IF stat<>RESULT_SUCCESS THEN RETURN stat

  AstrCopy(loggedOnUserKeys.userName,loggedOnUser.name,31)
  UpperStr(loggedOnUserKeys.userName)

  displayUserToCallersLog(0)

  validUser:=1  /* ok script done */
  saveAccount(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,0,0)
  sendQuietFlag(quietFlag)
  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  clearMsgPointers()
  masterSavePointers(loggedOnUser)

  doNewUserNotify()
  IF displayScreen(SCREEN_JOINED) THEN doPause()
ENDPROC stat

PROC doNewUser()
  DEF ch,i,stat
  DEF string[255]:STRING
  DEF str2[10]:STRING

jLoop1:
  aePuts('\b\n')
  aePuts('Blank line to retreat\b\n')

  ch:=0
iJLoop:

  FOR i:=0  TO 4
    StringF(string,'\b\n\s ',namePrompt)
    aePuts(string)
                                         /*** MAKE KEYBOARD_TIMEOUT A VARIABLE */
    stat:=lineInput('',loggedOnUser.name,30,INPUT_TIMEOUT,string)
    IF(stat<0) THEN RETURN stat
    AstrCopy(loggedOnUser.name,string,31)

    IF(StrLen(loggedOnUser.name)=0)
      ch++
      IF(ch>5)
        aePuts('\b\nToo Many Errors, Goodbye!\b\n')
        RETURN RESULT_FAILURE
      ENDIF
      JUMP floopc
    ENDIF

    IF(StrLen(loggedOnUser.name)=1)
      aePuts('Get REAL!!  One Character???\b\n')
      JUMP floopc
    ENDIF
    StrCopy(string,loggedOnUser.name,31)

    IF(stat:=checkIfNameAllowed(string))
      JUMP floopc
    ENDIF

    StrCopy(string,loggedOnUser.name,31)

    aePuts('\b\nChecking for duplicate name...')
    stat:=checkForAst(string)

    IF(stat)
      aePuts('No wildcards allowed in a name.\b\n')
      JUMP floopc
    ENDIF

    stat:=findUserFromName(1,NAME_TYPE_USERNAME,string,tempUser,tempUserKeys,tempUserMisc)
    IF(stat<>0)
      aePuts('Already in use!, try another.\b\n')
      JUMP floopc
    ENDIF
    aePuts('Ok!\b\n\b\n')
    JUMP jLoop2

floopc:
  ENDFOR

  aePuts('\b\nToo Many Errors, Goodbye!\b\n')
  RETURN RESULT_FAILURE

->//--- end new loop1

jLoop2:
  aePuts('City, State: ')
  stat:=lineInput('','',29,INPUT_TIMEOUT,string)
  IF(stat<0) THEN RETURN stat
  AstrCopy(loggedOnUser.location,string,30)
  IF(StrLen(loggedOnUser.location)=0)
    aePuts('\b\n')
    JUMP iJLoop
  ENDIF

jLoop3:
  aePuts('Phone Number: ')
  stat:=lineInput('','',12,INPUT_TIMEOUT,string)
  IF(stat<0) THEN RETURN stat
  AstrCopy(loggedOnUser.phoneNumber,string,13)

  IF(StrLen(loggedOnUser.phoneNumber)=0)
    aePuts('\b\n')
    JUMP jLoop2
  ENDIF

jLoop4:
  aePuts('E-Mail Address: ')
  stat:=lineInput('','',50,INPUT_TIMEOUT,string)
  IF(stat<0) THEN RETURN stat
  AstrCopy(loggedOnUserMisc.eMail,string,50)

  IF(StrLen(loggedOnUserMisc.eMail)=0)
    aePuts('\b\n')
    JUMP jLoop3
  ENDIF

jLoop5:

  stat:=getPass2('Enter a PassWord: ',0,0,50,string)
  IF(stat<0) THEN RETURN stat
  IF(StrLen(string)=0)
    aePuts('\b\n')
    JUMP jLoop4
  ENDIF
  stat:=getPass2('Reenter the PassWord: ',0,0,50,str2)
  IF(stat<0) THEN RETURN stat

  IF(StrCmp(string,str2)=0)
    aePuts('\b\nPasswords do not match, try again..\b\n')
    JUMP jLoop5
  ENDIF

  stat:=checkPasswordStrength(string)
  IF stat<>TRUE
  
    IF stat=1
      stat:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'MIN_PASSWORD_LENGTH') 
      StringF(string,'\b\nPassword length must be at least \d chars, try again..\b\n',stat)
      aePuts(string)
    ELSEIF stat=2
      stat:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'MIN_PASSWORD_STRENGTH') 
      StringF(string,'\b\nPassword must have at least \d of these:\b\n  upper case,lower case, numeric and symbols, try again..\b\n',stat)
      aePuts(string)
    ENDIF 
    JUMP jLoop5
  ENDIF

  setNewPassword(loggedOnUser,loggedOnUserMisc,string)
  loggedOnUserMisc.pwdLastUpdated:=getSystemTime()

  aePuts('\b\n')
  stat:=numberOfLinesTest()
  IF(stat<0) THEN RETURN stat

  aePuts('\b\n')
  stat:=chooseComputer()
  IF(stat<0) THEN RETURN stat
  aePuts('\b\n')


  loggedOnUserKeys.baud:=onlineBaud
  loggedOnUserKeys.userFlags:=USER_NEWMSG

  aePuts('You want Screen Clears after Messages ? ')
  ch:=checkOnlineStatus()
  IF(ch<0) THEN RETURN ch
  ch:=readChar(INPUT_TIMEOUT)
  IF(ch<0) THEN RETURN ch
  IF((ch="Y") OR (ch="y"))
    loggedOnUserKeys.userFlags:=loggedOnUserKeys.userFlags OR USER_SCRNCLR         /* screen clear code sent */
    aePuts('Yes..\b\n\b\n')
  ELSE
    aePuts('No!\b\n\b\n')
  ENDIF

  IF bgFileCheck AND (checkToolTypeExists(TOOLTYPE_NODE,node,'DEFAULT_BGFILECHECK')) THEN loggedOnUserKeys.userFlags:=loggedOnUserKeys.userFlags OR USER_BGFILECHECK
  
  StringF(string,'Handle: \s\b\n',loggedOnUser.name)
  aePuts(string)
  StringF(string,'City, St.: \s\b\n',loggedOnUser.location)
  aePuts(string)
  StringF(string,'Phone Num: \s\b\n',loggedOnUser.phoneNumber)
  aePuts(string)
  StringF(string,'E-Mail   : \s\b\n',loggedOnUserMisc.eMail)
  aePuts(string)
  
  IF loggedOnUser.lineLength=0 THEN StrCopy(str2,'Auto') ELSE StringF(str2,'\d',loggedOnUser.lineLength) 
  StringF(string,'Num Lines: \s\b\n',str2)
  aePuts(string)
  StringF(string,'PassWord : \s\b\n','ENCRYPTED')
  aePuts(string)
  StringF(string,'Computer : \s\b\n',computerTypes.item(loggedOnUser.secBulletin))
  aePuts(string)
  aePuts('Scrn Clr : ')
  IF(loggedOnUserKeys.userFlags AND USER_SCRNCLR) THEN aePuts('YES\b\n') ELSE aePuts('NO\b\n')
  aePuts('\b\n')
  purgeLine()
  aePuts('Is the above Correct? ')

  LOOP
    ch:=checkOnlineStatus()
    IF(ch<0) THEN RETURN ch
      ch:=readChar(INPUT_TIMEOUT)
    IF(ch<0) THEN RETURN ch
    IF((ch="N") OR (ch="n") OR (ch="Q") OR (ch="q"))
      aePuts('No!\b\n\b\n')
      JUMP jLoop1
    ENDIF
    EXIT ((ch="Y") OR (ch="y"))
  ENDLOOP
  aePuts('Yes..\b\n\b\n')

ENDPROC

PROC doNewUserQuestions()
  DEF filename[200]:STRING, afilename[200]:STRING
  DEF ch,stat,lock
  DEF c[200]:STRING,string[200]:STRING,datestr[20]:STRING,timestr[20]:STRING
  DEF fp2,fp1
  DEF temp1[255]:STRING
  DEF calldate

  StringF(filename,'\sNode\d/Script\d',cmds.bbsLoc,node,onlineBaud)
  IF checkToolTypeExists(TOOLTYPE_NODE,node,'CENTRAL_ANSWERS')
    StringF(afilename,'\sAnswers',cmds.bbsLoc)
    IF(lock:=CreateDir(afilename))
      UnLock(lock)
    ENDIF
    StringF(afilename,'\sAnswers/\d',cmds.bbsLoc,loggedOnUser.slotNumber)
  ELSE
    StringF(afilename,'\sNode\d/Answers',cmds.bbsLoc,node)
  ENDIF

qAgain:

  StringF(string,'\sNode\d/TempAns',cmds.bbsLoc,node)

  IF((fp1:=Open(string,MODE_NEWFILE))=0) THEN RETURN RESULT_GOODBYE

  calldate:=getSystemTime()
  formatLongDate(calldate,datestr)
  formatLongTime(calldate,timestr)


  fileWriteLn(fp1,'**************************************************************')
  StringF(temp1,'\s (\s) [\d] \s (\s) \s',datestr,timestr,loggedOnUser.slotNumber,loggedOnUser.name,connectString,loggedOnUser.location)
  fileWriteLn(fp1,temp1)
  Close(fp1)

  IF (runSysCommand('SCRIPT','')<>RESULT_SUCCESS)

    fp2:=Open(filename,MODE_OLDFILE)
    IF(fp2=0) THEN RETURN RESULT_SUCCESS

    IF((fp1:=Open(string,MODE_READWRITE)))=0 THEN RETURN RESULT_GOODBYE
    Seek(fp1,0,OFFSET_END)

    -> read & verify Questionaire
    WHILE(ReadStr(fp2,c)<>-1) OR (StrLen(c)>0)
      IF (StrLen(c)=0) OR (c[StrLen(c)-1]<>"~")
        aePuts(c)
        aePuts('\b\n')
        fileWriteLn(fp1,c)
      ELSE
        SetStr(c,StrLen(c)-1)
        aePuts(c)
        fileWrite(fp1,c)
        stat:=lineInput('','',70,INPUT_TIMEOUT,string)
        IF(stat<0)
          Close(fp1)
          Close(fp2)
          RETURN stat
        ENDIF
        fileWriteLn(fp1,string)
      ENDIF
    ENDWHILE
    Close(fp1)
    Close(fp2)
  ENDIF

  aePuts('\b\n')

  aePuts('Is the above Correct? ')

  LOOP
    ch:=checkOnlineStatus()
      IF(ch<0) THEN RETURN ch
    ch:=readChar(INPUT_TIMEOUT)
      IF(ch<0) THEN RETURN ch
    IF((ch="N") OR (ch="n") OR (ch="Q") OR (ch="q"))
        aePuts('No!\b\n\b\n')
       JUMP qAgain
    ENDIF
    IF((ch="Y") OR (ch="y")) THEN JUMP qbreak
  ENDLOOP
qbreak:
  aePuts('Yes..\b\n\b\n')

  IF(fp1:=Open(afilename,MODE_READWRITE))=0
    fp1:=Open(afilename,MODE_NEWFILE)
  ELSE
    Seek(fp1,0,OFFSET_END)
  ENDIF

  StringF(string,'\sNode\d/TempAns',cmds.bbsLoc,node)
  IF((fp2:=Open(string,MODE_OLDFILE)))<>0
    LOOP
      EXIT ((ReadStr(fp2,c))=-1) AND (StrLen(c)=0)
      fileWriteLn(fp1,c)
    ENDLOOP
    Close(fp1)
    Close(fp2)
  ENDIF
ENDPROC RESULT_SUCCESS

PROC memClear(data:PTR TO CHAR,size)
  WHILE (size>0)
    data[]:=0
    data++
    size--
  ENDWHILE
ENDPROC

PROC initNewUser(userData:PTR TO user,userKeys: PTR TO userKeys,userMisc: PTR TO userMisc,slotNumber)
  DEF ttdata[255]:STRING

  memClear(userData,SIZEOF user)
  memClear(userKeys,SIZEOF userKeys)
  memClear(userMisc,SIZEOF userMisc)

  StringF(ttdata,'\sNode\d/Preset.1',cmds.bbsLoc,node)
  IF configFileExists(ttdata)
    applyPreset(userData,TOOLTYPE_NODE_PRESET,1)
  ELSE
    applyPreset(userData,TOOLTYPE_PRESET,1)
  ENDIF

  userData.newUser:=1
  IF(userData.confRJoin=NIL) THEN userData.confRJoin:=1
  userData.timeTotal:=userData.timeLimit
  userData.protocol:="Z"
  userData.timeLastOn:=getSystemTime()
  userData.accountDate:=getSystemTime()
  userData.expert:="N"

  AstrCopy(userData.location,' ')

  userData.slotNumber:=slotNumber
  userKeys.number:=slotNumber
  AstrCopy(userKeys.userName,userData.name)
ENDPROC

PROC createNewAccount()
  logonTime:=getSystemTime()
  lastTimeUpdate:=logonTime
  loggedOnUser:=NEW loggedOnUser
  loggedOnUserKeys:=NEW loggedOnUserKeys
  loggedOnUserMisc:=NEW loggedOnUserMisc

  AstrCopy(loggedOnUser.pass,'')

  loggedOnUser.slotNumber:=0
  initNewUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc,findFreeSlot())

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)

  loggedOnUserKeys.baud:=onlineBaud
  validUser:=0

  IF (loggedOnUser.dailyBytesLimit<>0)
    bytesADL:=loggedOnUser.dailyBytesLimit
  ELSE
    bytesADL:=$7fffffff
  ENDIF

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
ENDPROC

PROC findFreeSlot()
  DEF slot, stat, fh

  fh:=Open(userDataFile,MODE_OLDFILE)
  IF(fh=0) THEN RETURN 1

  IF (sopt.toggles[TOGGLES_REUSEINACTIVE])=FALSE
    Seek(fh,0,OFFSET_END)
    slot:=Div(Seek(fh,0,OFFSET_CURRENT),SIZEOF user)
    Close(fh)
    RETURN slot+1
  ENDIF

  slot:=0
  REPEAT
    stat:=Read(fh,tempUser,SIZEOF user)
    slot++
    IF (stat=SIZEOF user) AND (tempUser.slotNumber=0)
      Close(fh)
      RETURN slot
    ENDIF
  UNTIL stat<>SIZEOF user
  Close(fh)
ENDPROC slot

PROC expressToFront()
  IF screen<>NIL
    ScreenToFront(screen)
  ELSEIF window<>NIL
    WindowToFront(window)
  ENDIF
ENDPROC

PROC expressToBack()
  IF screen<>NIL
    ScreenToBack(screen)
  ELSEIF window<>NIL
    WindowToBack(window)
  ENDIF
ENDPROC

PROC initZmodemStatCon()
  IF zModemStatWriteMP=NIL THEN zModemStatWriteMP:=createPort(0,0)
  IF zModemStatWriteIO=NIL THEN zModemStatWriteIO:=createStdIO(zModemStatWriteMP)
  zModemStatWriteIO.data:=windowZmodem
  OpenDevice('console.device', 0, zModemStatWriteIO, 0)
ENDPROC

PROC closeTransferStatWin()
  SELECT statWinType
    CASE 0
      closezModemStats()     
    CASE 1
      closeHydraStats()
  ENDSELECT
ENDPROC

PROC closeHydraStats()
  IF hydraStatWriteIO1<>NIL
    CloseDevice(hydraStatWriteIO1)
    deleteStdIO(hydraStatWriteIO1)
    hydraStatWriteIO1:=NIL
  ENDIF
  IF hydraStatWriteMP1<>NIL
    deletePort(hydraStatWriteMP1)
    hydraStatWriteMP1:=NIL
  ENDIF

  IF(hydraWindow1<>NIL) THEN CloseWindow(hydraWindow1)
  hydraWindow1:=NIL
  
  IF hydraStatWriteIO2<>NIL
    CloseDevice(hydraStatWriteIO2)
    deleteStdIO(hydraStatWriteIO2)
    hydraStatWriteIO2:=NIL
  ENDIF
  IF hydraStatWriteMP2<>NIL
    deletePort(hydraStatWriteMP2)
    hydraStatWriteMP2:=NIL
  ENDIF

  IF(hydraWindow2<>NIL) THEN CloseWindow(hydraWindow2)
  hydraWindow2:=NIL

  IF hydraStatWriteIO3<>NIL
    CloseDevice(hydraStatWriteIO3)
    deleteStdIO(hydraStatWriteIO3)
    hydraStatWriteIO3:=NIL
  ENDIF
  IF hydraStatWriteMP3<>NIL
    deletePort(hydraStatWriteMP3)
    hydraStatWriteMP3:=NIL
  ENDIF

  IF hydraConsoleReadIO
    IF CheckIO(hydraConsoleReadIO)=FALSE THEN AbortIO(hydraConsoleReadIO)
    deleteExtIO(hydraConsoleReadIO)
  ENDIF
  IF hydraConsoleReadMP THEN deletePort(hydraConsoleReadMP)
  
  IF(hydraWindow3<>NIL) THEN CloseWindow(hydraWindow3)
  hydraWindow3:=NIL
ENDPROC

PROC closezModemStats()
  IF zModemStatWriteIO<>NIL
    CloseDevice(zModemStatWriteIO)
    deleteStdIO(zModemStatWriteIO)
    zModemStatWriteIO:=NIL
  ENDIF
  IF zModemStatWriteMP<>NIL
    deletePort(zModemStatWriteMP)
    zModemStatWriteMP:=NIL
  ENDIF

  IF(windowZmodem<>NIL) THEN CloseWindow(windowZmodem)
  windowZmodem:=NIL
ENDPROC

PROC openTransferStatWin()
  SELECT statWinType
    CASE 0
      openZmodemStat()
    CASE 1
      openHydraStat()
  ENDSELECT
ENDPROC


PROC openHydraStat() 
  DEF tags:PTR TO LONG
  DEF pubScreen[255]:STRING
  DEF pubLock=0:PTR TO screen
  DEF pub=FALSE

  IF readToolType(TOOLTYPE_WINDOW,node,'WINDOW.PUBSCREEN',pubScreen)
    pub:=TRUE
  ENDIF

  IF pub
    IF StrLen(pubScreen)>0
      pubLock:=LockPubScreen(pubScreen)
    ELSE
      pubLock:=LockPubScreen(NIL)
    ENDIF
    IF pubLock=FALSE THEN pub:=FALSE
  ENDIF

  IF pub 
    tags:=NEW [WA_CLOSEGADGET,1,
        WA_PUBSCREEN,pubLock,
        WA_SIZEGADGET,0,
        WA_DRAGBAR,1,
        WA_LEFT,(window.width/2-315)+window.leftedge,
        WA_LEFT,100,
        WA_TOP,5,
        WA_WIDTH,310,
        WA_HEIGHT,150,
        WA_DETAILPEN,0,
        WA_BLOCKPEN,7,
        WA_TITLE,
        'Receive Window',
        WA_IDCMP,IDCMP_CLOSEWINDOW,
        WA_FLAGS,WFLG_ACTIVATE,
        TAG_DONE]  
  ELSE
    tags:=NEW [WA_CLOSEGADGET,1,
        WA_CUSTOMSCREEN,screen,
        WA_SIZEGADGET,0,
        WA_DRAGBAR,1,
        WA_LEFT,(screen.width/2-315)+window.leftedge,
        WA_TOP,5,
        WA_WIDTH,310,
        WA_HEIGHT,150,
        WA_DETAILPEN,0,
        WA_BLOCKPEN,7,
        WA_TITLE,
        'Receive Window',
        WA_IDCMP,IDCMP_CLOSEWINDOW,
        WA_FLAGS,WFLG_ACTIVATE,
        TAG_DONE]  
  ENDIF
  
  hydraWindow1:=OpenWindowTagList(NIL,tags)
  FastDisposeList(tags)

  IF (hydraWindow1) AND (fontHandle<>NIL) THEN SetFont(hydraWindow1.rport,fontHandle)

  IF pub 
    tags:=NEW [WA_CLOSEGADGET,1,
        WA_PUBSCREEN,pubLock,
        WA_SIZEGADGET,0,
        WA_DRAGBAR,1,
        WA_LEFT,(window.width/2+5)+window.leftedge,
        WA_TOP,5,
        WA_WIDTH,310,
        WA_HEIGHT,150,
        WA_DETAILPEN,0,
        WA_BLOCKPEN,7,
        WA_TITLE,
        'Send Window',
        WA_IDCMP,IDCMP_CLOSEWINDOW,
        WA_FLAGS,WFLG_ACTIVATE,
        TAG_DONE]  
  ELSE
    tags:=NEW [WA_CLOSEGADGET,1,
        WA_CUSTOMSCREEN,screen,
        WA_SIZEGADGET,0,
        WA_DRAGBAR,1,
        WA_LEFT,(screen.width/2+5)+window.leftedge,
        WA_TOP,5,
        WA_WIDTH,310,
        WA_HEIGHT,150,
        WA_DETAILPEN,0,
        WA_BLOCKPEN,7,
        WA_TITLE,
        'Send Window',
        WA_IDCMP,IDCMP_CLOSEWINDOW,
        WA_FLAGS,WFLG_ACTIVATE,
        TAG_DONE]  
  ENDIF

  hydraWindow2:=OpenWindowTagList(NIL,tags)
  IF (hydraWindow2) AND (fontHandle<>NIL) THEN SetFont(hydraWindow2.rport,fontHandle)
  FastDisposeList(tags)

  IF pub 
    tags:=NEW [WA_CLOSEGADGET,1,
        WA_PUBSCREEN,pubLock,
        WA_SIZEGADGET,0,
        WA_DRAGBAR,1,
        WA_LEFT,(window.width/2-315)+window.leftedge,
        WA_TOP,158,
        WA_WIDTH,630,
        WA_HEIGHT,WA_HEIGHT,IF pubLock.height>250 THEN 90 ELSE 40,
        WA_DETAILPEN,0,
        WA_BLOCKPEN,7,
        WA_TITLE,
        'Chat Window',
        WA_IDCMP,IDCMP_CLOSEWINDOW,
        WA_FLAGS,WFLG_ACTIVATE,
        TAG_DONE]  
  ELSE
    tags:=NEW [WA_CLOSEGADGET,1,
        WA_CUSTOMSCREEN,screen,
        WA_SIZEGADGET,0,
        WA_DRAGBAR,1,
        WA_LEFT,(screen.width/2-315)+window.leftedge,
        WA_TOP,158,
        WA_WIDTH,630,
        WA_HEIGHT,IF screen.height>250 THEN 90 ELSE 40,
        WA_DETAILPEN,0,
        WA_BLOCKPEN,7,
        WA_TITLE,
        'Chat Window',
        WA_IDCMP,IDCMP_CLOSEWINDOW,
        WA_FLAGS,WFLG_ACTIVATE,
        TAG_DONE]  
  ENDIF

  hydraWindow3:=OpenWindowTagList(NIL,tags)
  IF (hydraWindow3) AND (fontHandle<>NIL) THEN SetFont(hydraWindow3.rport,fontHandle)
  FastDisposeList(tags)

  initHydraStatCon()

  IF pubLock THEN UnlockPubScreen(NIL,pubLock)

ENDPROC

PROC initHydraStatCon()
  IF hydraStatWriteMP1=NIL THEN hydraStatWriteMP1:=createPort(0,0)
  IF hydraStatWriteIO1=NIL THEN hydraStatWriteIO1:=createStdIO(hydraStatWriteMP1)
  hydraStatWriteIO1.data:=hydraWindow1
  OpenDevice('console.device', 0, hydraStatWriteIO1, 0)
  
  IF hydraStatWriteMP2=NIL THEN hydraStatWriteMP2:=createPort(0,0)
  IF hydraStatWriteIO2=NIL THEN hydraStatWriteIO2:=createStdIO(hydraStatWriteMP2)
  hydraStatWriteIO2.data:=hydraWindow2
  OpenDevice('console.device', 0, hydraStatWriteIO2, 0) 

  IF hydraStatWriteMP3=NIL THEN hydraStatWriteMP3:=createPort(0,0)
  IF hydraStatWriteIO3=NIL THEN hydraStatWriteIO3:=createStdIO(hydraStatWriteMP3)
  hydraStatWriteIO3.data:=hydraWindow3
  OpenDevice('console.device', 0, hydraStatWriteIO3, 0) 
  
  hydraConsoleReadMP:=createPort(0, 0)
  hydraConsoleReadIO:=createExtIO(hydraConsoleReadMP, SIZEOF iostd)
  
  hydraConsoleReadIO.device:=hydraStatWriteIO3.device
  hydraConsoleReadIO.unit:=hydraStatWriteIO3.unit

  queueHydraConsoleRead(conbuf)  -> Send the first console read request

ENDPROC


PROC openZmodemStat() 
  DEF tags:PTR TO LONG,tags2:PTR TO LONG,vi
  DEF tempstr[255]:STRING
  DEF pubScreen[255]:STRING
  DEF pubLock=0
  DEF pub=FALSE
  
  IF netMailTransfer
    IF zModemInfo.currentOperation=ZMODEM_DOWNLOAD
      StringF(tempstr,'[Node \d] NetMail Send Window',node)
      AstrCopy(zModemInfo.titleBar,tempstr)
    ELSE
      StringF(tempstr,'[Node \d] NetMail Receive Window',node)
      AstrCopy(zModemInfo.titleBar,tempstr)
    ENDIF 
  ELSE
    IF zModemInfo.currentOperation=ZMODEM_DOWNLOAD
      StringF(tempstr,'[Node \d] Send Window (??/??)',node)
      AstrCopy(zModemInfo.titleBar,tempstr)
    ELSE
      StringF(tempstr,'[Node \d] Receive Window (??/??)',node)
      AstrCopy(zModemInfo.titleBar,tempstr)
    ENDIF
  ENDIF

  IF bitPlanes=0
    pub:=TRUE
  ENDIF

  IF readToolType(TOOLTYPE_WINDOW,node,'WINDOW.PUBSCREEN',pubScreen)
    pub:=TRUE
  ENDIF

  IF pub
    IF StrLen(pubScreen)>0
      pubLock:=LockPubScreen(pubScreen)
    ELSE
      pubLock:=LockPubScreen(NIL)
    ENDIF
    IF pubLock=FALSE THEN pub:=FALSE
  ENDIF

  IF pub 
    tags:=NEW [WA_CLOSEGADGET,1,
          WA_PUBSCREEN,pubLock,
          WA_SIZEGADGET,0,
          WA_DRAGBAR,1,
          WA_LEFT,(window.width-350/2)+window.leftedge,
          WA_TOP,(window.height-150/2)+window.topedge,
          WA_WIDTH,350,
          WA_HEIGHT,150,
          WA_DETAILPEN,0,
          WA_BLOCKPEN,7,
          WA_TITLE,
          zModemInfo.titleBar,
          WA_IDCMP,IDCMP_CLOSEWINDOW,
          WA_FLAGS,WFLG_ACTIVATE,
          TAG_DONE]
  ELSE
    tags:=NEW [WA_CLOSEGADGET,1,
          WA_CUSTOMSCREEN,screen,
          WA_SIZEGADGET,0,
          WA_DRAGBAR,1,
          WA_LEFT,(screen.width-350)/2,
          WA_TOP,(screen.height-150)/2,
          WA_WIDTH,350,
          WA_HEIGHT,150,
          WA_DETAILPEN,0,
          WA_BLOCKPEN,7,
          WA_TITLE,
          zModemInfo.titleBar,
          WA_IDCMP,IDCMP_CLOSEWINDOW,
          WA_FLAGS,WFLG_ACTIVATE,
          TAG_DONE]
  ENDIF
  IF (windowZmodem=NIL) AND (scropen)
    windowZmodem:=OpenWindowTagList(NIL,tags)
    IF pubLock THEN UnlockPubScreen(NIL,pubLock)
    initZmodemStatCon()
    IF (KickVersion(40) AND (bitPlanes>2)) THEN zmodemStatPrint('[37m[ s')
    zmodemStatPrint('[H[J[0 p[H\n FileName:\n FileSize: 0\n ETA Time:\n Cur Time:\n Position: 0\n Resume P: 0\n Complete: N/A\n LastTime:\n      CPS: 0 Efficiency 0%\n\n Z Status: Starting\n Errors: 0\n ErrorPos: 0')

    IF (gadtoolsbase:=OpenLibrary('gadtools.library',0))<>NIL
      vi:=GetVisualInfoA(screen, [NIL])
      tags2:=NEW [GT_VISUALINFO,vi,TAG_DONE]

      DrawBevelBoxA(windowZmodem.rport,9,129,316,10,tags2)
      FreeVisualInfo(vi)
      FastDisposeList(tags2)
      CloseLibrary(gadtoolsbase)
    ENDIF
  ENDIF
  FastDisposeList(tags)

ENDPROC

PROC disableNodeMenus(flag)
  DEF item:PTR TO menuitem
  IF windowStat THEN ClearMenuStrip(windowStat)
  IF window THEN ClearMenuStrip(window)
  item:=expMenu.firstitem
  WHILE item
    IF (item.flags AND CHECKIT)=0
      IF flag THEN item.flags:=item.flags AND $FFEF ELSE item.flags:=item.flags OR $10
    ENDIF
    item:=item.nextitem
  ENDWHILE

  IF windowStat THEN ResetMenuStrip(windowStat,expMenu)
  IF window THEN ResetMenuStrip(window,expMenu)
  
ENDPROC

PROC disableOnlineMenus(flag)
  DEF item:PTR TO menuitem
  IF windowStat THEN ClearMenuStrip(windowStat)
  IF window THEN ClearMenuStrip(window)
  
  item:=expMenu.nextmenu.firstitem
  WHILE item
    IF flag THEN item.flags:=item.flags AND $FFEF ELSE item.flags:=item.flags OR $10
    item:=item.nextitem
  ENDWHILE

  IF windowStat THEN ResetMenuStrip(windowStat,expMenu)
  IF window THEN ResetMenuStrip(window,expMenu)
ENDPROC

PROC updateMenus()
  DEF item:PTR TO menuitem
  IF windowStat THEN ClearMenuStrip(windowStat)
  IF window THEN ClearMenuStrip(window)
  item:=expMenu.firstitem
  WHILE item
    IF GTMENUITEM_USERDATA(item)=-1
      IF sysopAvail THEN item.flags:=item.flags OR $100 ELSE item.flags:=item.flags AND $FEFF
    ENDIF
    IF GTMENUITEM_USERDATA(item)=-2
      IF dStatBar THEN item.flags:=item.flags OR $100 ELSE item.flags:=item.flags AND $FEFF
    ENDIF
    item:=item.nextitem
  ENDWHILE

  IF windowStat THEN ResetMenuStrip(windowStat,expMenu)
  IF window THEN ResetMenuStrip(window,expMenu)
 
ENDPROC

PROC createMenus()
  DEF eWinMenu:PTR TO newmenu
  DEF n=0

  eWinMenu:=NEW eWinMenu[28]
  eWinMenu[n].type:=NM_TITLE
  eWinMenu[n++].label:='Node'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Sysop logon             F1'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Local logon             F2'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Instant logon           F3'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Reserve node            F4'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Conference maintenance  F5'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Shell                Sh-F5'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Account editor          F6'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='View callerslog      Sh-F6'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n].flags:=CHECKIT
  eWinMenu[n].mutualexclude:=0
  eWinMenu[n].userdata:=-1
  eWinMenu[n++].label:='Sysop available       F7'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n].flags:=CHECKIT
  eWinMenu[n].mutualexclude:=0
  eWinMenu[n].userdata:=-2
  eWinMenu[n++].label:='Toggle status       Help'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Init modem              F8'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Exit node               F9'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Exit node (offhook)    F10'
  eWinMenu[n].type:=NM_TITLE
  eWinMenu[n++].label:='Online'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Chat                   F1'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Time limit'
  eWinMenu[n].type:=NM_SUB
  eWinMenu[n++].label:='Increase               F2'
  eWinMenu[n].type:=NM_SUB
  eWinMenu[n++].label:='Decrease               F3'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Capture                F4'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Show file              F5'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Account edit           F6'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Grant temporary access F7'
  eWinMenu[n].type:=NM_ITEM
  eWinMenu[n++].label:='Disconnect            F10'
  eWinMenu[n].type:=NM_END
  
  IF (gadtoolsbase:=OpenLibrary('gadtools.library',0))<>NIL
    expMenu:=CreateMenusA(eWinMenu,[TAG_END])
    disableNodeMenus(FALSE)
    disableOnlineMenus(TRUE)
    CloseLibrary(gadtoolsbase)
  ENDIF
  END eWinMenu[28]
  
ENDPROC

PROC freeMenus()
  IF expMenu
    IF (gadtoolsbase:=OpenLibrary('gadtools.library',0))<>NIL
      FreeMenus(expMenu)
      CloseLibrary(gadtoolsbase)
    ENDIF
  ENDIF
ENDPROC

PROC openExpressScreen()
  DEF width,height,top,left,dispId
  DEF pubScreen[255]:STRING
  DEF penstr[12]:STRING
  DEF debugstr[255]:STRING
  DEF pub=FALSE
  DEF pubLock=NIL
  DEF opentags:PTR TO LONG,temp
  DEF vi
  DEF pens: PTR TO INT, cols:PTR TO INT
  DEF pensize,colsize
  DEF statePtr:PTR TO awaitState

  IF scropen THEN RETURN

  top:=sopt.topEdge
  left:=sopt.leftEdge
  width:=sopt.width
  height:=sopt.height
  bitPlanes:=sopt.bitPlanes

  IF bitPlanes=0 
    StrCopy(pubScreen,'')
    pub:=TRUE
  ENDIF

  IF readToolType(TOOLTYPE_WINDOW,node,'WINDOW.PUBSCREEN',pubScreen)
    pub:=TRUE
  ENDIF

  IF pub
    IF StrLen(pubScreen)>0
      pubLock:=LockPubScreen(pubScreen)
    ELSE
      pubLock:=LockPubScreen(NIL)
    ENDIF
    IF pubLock=FALSE THEN pub:=FALSE
    StringF(debugstr,'pubscreen \s \d',pubScreen,pubLock)
    debugLog(LOG_DEBUG,debugstr)
  ENDIF

  dStatBar:=FALSE
  ->IF (checkToolTypeExists(TOOLTYPE_WINDOW,node,'WINDOW.STATBAR')) THEN toggleStatusDisplay()

  IF fontHandle=NIL
    readToolType(TOOLTYPE_NODE,node,'EXPFONT',fontName)
    defaultfontattr.name:=fontName
    defaultfontattr.ysize:=8

    fontHandle:=OpenFont(defaultfontattr)
    IF fontHandle=NIL THEN fontHandle:=OpenDiskFont(defaultfontattr)
  ENDIF

  IF pub=FALSE
    IF screen=NIL
      IF (bitPlanes<3) OR (KickVersion(40)=FALSE)
        ->colour 1 = white, colour 7 = red
        pens:=NEW [0,1,1,1,6,4,1,0,4,1,4,1,-1]:INT
        pensize:=13
        IF (bitPlanes>3)
          cols:=NEW [0,0,0,0,
             1,12,12,12,
             2,0,12,0,
             3,12,12,0,
             4,0,0,12,
             5,12,0,12,
             6,0,12,12,
             7,12,0,0,
             8,5,5,5,
             9,15,15,15,
             10,0,15,0,
             11,15,15,0,
             12,0,0,15,
             13,15,0,15,
             14,0,15,15,
             15,15,0,0,
             -1,0,0,0]:INT
          colsize:=68
        ELSE
          cols:=NEW [0,0,0,0,1,15,15,15,2,0,15,0,3,15,15,0,4,0,0,15,5,15,0,15,6,0,15,15,7,15,0,0,-1,0,0,0]:INT
          colsize:=36
        ENDIF

      ELSE
        ->colour 1 = red, colour 7 = white
        pens:=NEW [0,7,7,7,6,4,7,0,4,7,4,7,-1]:INT
        pensize:=13
        IF (bitPlanes>3)
          cols:=NEW [0,0,0,0,
           1,12,0,0,
           2,0,12,0,
           3,12,12,0,
           4,0,0,12,
           5,12,0,12,
           6,0,12,12,
           7,12,12,12,
           8,5,5,5,
           9,15,0,0,
           10,0,15,0,
           11,15,15,0,
           12,0,0,15,
           13,15,0,15,
           14,0,15,15,
           15,15,15,15,
           -1,0,0,0]:INT
          colsize:=68
        ELSE
          cols:=NEW [0,0,0,0,1,15,0,0,2,0,15,0,3,15,15,0,4,0,0,15,5,15,0,15,6,0,15,15,7,15,15,15,-1,0,0,0]:INT
          colsize:=36
        ENDIF
      ENDIF
  
      IF readToolType(TOOLTYPE_NODE,node,'SCREENPENS',penstr)
        FOR temp:=0 TO StrLen(penstr)-1
           IF (penstr[temp]>="0") AND (penstr[temp]<="7") THEN pens[temp]:=penstr[temp]-"0"
           IF (penstr[temp]>="A") AND (penstr[temp]<="F") THEN pens[temp]:=penstr[temp]-"A"+10
           IF (penstr[temp]>="a") AND (penstr[temp]<="f") THEN pens[temp]:=penstr[temp]-"a"+10
           
        ENDFOR
      ENDIF

      dispId:=V_HIRES
      IF sopt.interlace THEN dispId:=dispId OR V_LACE

      temp:=readToolTypeInt(TOOLTYPE_WINDOW,node,'WINDOW.DISPLAYID')
      IF temp<>-1 THEN dispId:=temp

      opentags:=NEW [SA_TYPE,CUSTOMSCREEN,SA_LEFT,0,SA_TOP,0,SA_WIDTH,width,SA_HEIGHT,height,SA_DEPTH,bitPlanes,SA_TITLE,titlebar,SA_DISPLAYID,dispId,
              SA_PUBNAME,IF StrLen(pubScreen)>0 THEN pubScreen ELSE 0,
              SA_PENS,pens,
              SA_INTERLEAVED,1,
              SA_FONT,defaultfontattr,
              SA_COLORS,cols,
              TAG_DONE]
      screen:=OpenScreenTagList(NIL,opentags)
      FastDisposeList(opentags)

      END pens[pensize]
      END cols[colsize]

      IF (screen) AND (StrLen(pubScreen)>0)
        PubScreenStatus(screen,0)
        pubLock:=LockPubScreen(pubScreen)
        IF pubLock<>FALSE THEN pub:=TRUE
      ENDIF
    ENDIF

    IF screen=NIL THEN RETURN ERR_SCREEN

    vi:=GetVisualInfoA(screen, [NIL])

    IF windowClose=NIL
      opentags:=NEW [WA_CLOSEGADGET,1,WA_CUSTOMSCREEN,screen,
         WA_TOP,0,
         WA_LEFT,0,
         WA_WIDTH,18,
         WA_HEIGHT,screen.wbortop+screen.font.ysize+1,
         ->WA_DETAILPEN,0,
         ->WA_BLOCKPEN,blockpen,
       WA_IDCMP,IDCMP_CLOSEWINDOW,
       TAG_DONE]
      windowClose:=OpenWindowTagList(NIL,opentags)
      FastDisposeList(opentags)
    ENDIF

    IF windowClose=NIL THEN RETURN ERR_WINDOW
  ENDIF

  IF window=NIL
    IF pub
      opentags:= NEW [WA_PUBSCREEN,pubLock,
        WA_CLOSEGADGET,1,
        WA_SIZEGADGET,1,
        WA_DEPTHGADGET,1,
        WA_DRAGBAR,1,
        WA_TOP,top,
        WA_LEFT,left,
        WA_WIDTH,width,
        WA_HEIGHT,height+30,
        WA_MINWIDTH,-1,
        WA_MAXWIDTH,-1,
        WA_MINHEIGHT,-1,
        WA_MAXHEIGHT,-1,
        ->WA_DETAILPEN,0,
        ->WA_BLOCKPEN,blockpen,
        WA_NEWLOOKMENUS,1,
        WA_IDCMP,IDCMP_CLOSEWINDOW OR IDCMP_MENUPICK,
        WA_FLAGS,WFLG_ACTIVATE,
        TAG_DONE]
      window:=OpenWindowTagList(NIL,opentags)
      FastDisposeList(opentags)
      IF (window) AND (fontHandle<>NIL) THEN SetFont(window.rport,fontHandle)
    ELSE
      opentags:=NEW [WA_BORDERLESS,1,WA_CUSTOMSCREEN,screen,
        WA_TOP,top+screen.wbortop+screen.font.ysize+1,
        WA_LEFT,left,
        WA_WIDTH,width,
        WA_HEIGHT,height-(screen.wbortop+screen.font.ysize+1),
        ->WA_DETAILPEN,0,
        ->WA_BLOCKPEN,blockpen,
        WA_NEWLOOKMENUS,1,
        WA_IDCMP,IDCMP_MENUPICK,
        WA_FLAGS,WFLG_ACTIVATE,
        TAG_DONE]
      window:=OpenWindowTagList(NIL,opentags)
      FastDisposeList(opentags)
    ENDIF
  ENDIF


  IF pubLock THEN UnlockPubScreen(NIL,pubLock)
  IF window=NIL THEN RETURN ERR_WINDOW

  updateMenus()
  LayoutMenusA(expMenu,vi,[GTMN_NEWLOOKMENUS,1,TAG_DONE])
  FreeVisualInfo(vi)
  SetMenuStrip(window,expMenu)

  IF state=STATE_AWAIT
    statePtr:=stateData
    statePtr.redrawScreen:=TRUE
  ENDIF

  -> Create reply port and io block for writing to console
  IF consoleMP=NIL THEN consoleMP:=createPort(0, 0)
  IF consoleMP=NIL THEN RETURN ERR_PORT

  IF consoleIO=NIL THEN consoleIO:=createExtIO(consoleMP,SIZEOF iostd)
  IF consoleIO=NIL THEN RETURN ERR_IO

  -> Create reply port and io block for reading from console
  IF consoleReadMP=NIL THEN consoleReadMP:=createPort(0, 0)
  IF consoleReadMP=NIL  THEN RETURN ERR_PORT
  IF consoleReadIO=NIL THEN consoleReadIO:=createExtIO(consoleReadMP, SIZEOF iostd)
  IF consoleReadIO=NIL THEN RETURN ERR_IO

  consoleIO.data:=window
  consoleIO.length:=SIZEOF window
  IF OpenDevice(consoleOutputDeviceName, 0, consoleIO, 0) THEN RETURN ERR_DEV

  IF StriCmp(consoleInputDeviceName,consoleOutputDeviceName)
    ->both console devices the same, so share the same device
    consoleReadIO.device:=consoleIO.device
    consoleReadIO.unit:=consoleIO.unit
  ELSE
    ->open a second device if the input and output devices aren't matching
    consoleReadIO.data:=window
    consoleReadIO.length:=SIZEOF window
    IF OpenDevice(consoleInputDeviceName, 0, consoleReadIO, 0) THEN RETURN ERR_DEV
    consoleReadIO.command:=CMD_WRITE
    IF (KickVersion(40)) AND (bitPlanes>2)
      consoleReadIO.data:='[37m[ s'
      consoleReadIO.length:=StrLen(consoleReadIO.data)
      DoIO(consoleReadIO)
    ENDIF
    consoleReadIO.data:='[0 p'
    consoleReadIO.length:=StrLen(consoleReadIO.data)
    DoIO(consoleReadIO)
  ENDIF

  queueConsoleRead({ibuf})  -> Send the first console read request
  scropen:=TRUE
  IF (KickVersion(40)) AND (bitPlanes>2)
    conPuts('[37m[ s',-1,TRUE)
  ENDIF
  conCursorOff()

  statPrintUser(loggedOnUser,loggedOnUserKeys,loggedOnUserMisc)
  IF (wantzwin) AND (window<>NIL) THEN openTransferStatWin()
  
  IF((sopt.statBar<>FALSE) AND (pub=FALSE)) THEN toggleStatusDisplay()
ENDPROC ERR_NONE

PROC handleMenuPick(menucode)
  DEF menu,item,subitem
  menu:=menucode AND $1F
  item:=(Shr((menucode),5) AND $3F)
  subitem:=(Shr((menucode),11) AND $1F)
  
  SELECT menu
    CASE 0
      SELECT item
        CASE 0
          servercmd:=SV_SYSOPLOG
        CASE 1
          servercmd:=SV_LOCALLOG
        CASE 2
          servercmd:=SV_INSTANT
        CASE 3
          servercmd:=SV_RESERVE
        CASE 4
          servercmd:=SV_CONFMAINT
        CASE 5
          servercmd:=SV_AESHELL
        CASE 6
          servercmd:=SV_ACCOUNTS
        CASE 7
          servercmd:=SV_VIEWLOGS
        CASE 8
          servercmd:=SV_CHATTOGGLE
        CASE 9
          servercmd:=SV_TOGGLESTATUS
        CASE 10
          servercmd:=SV_INITMODEM
        CASE 11
          servercmd:=SV_EXITNODE
        CASE 12
          servercmd:=SV_NODEOFFHOOK
      ENDSELECT
    CASE 1
      SELECT item
        CASE 0
          servercmd:=SV_CHAT
        CASE 1
          IF subitem=0
            servercmd:=SV_TIMEINCREASE
          ELSE
            servercmd:=SV_TIMEDECREASE
          ENDIF
        CASE 2
            servercmd:=SV_CAPTURE
        CASE 3
            servercmd:=SV_DISPLAYFILE
        CASE 4
            servercmd:=SV_ACCOUNTS
        CASE 5
            servercmd:=SV_GRANTTEMP
        CASE 6
            servercmd:=SV_KICKUSER
      ENDSELECT
  ENDSELECT
ENDPROC

PROC closeExpressScreen()

  closeAEStats()
  closeTransferStatWin()

  IF consoleReadIO
    IF CheckIO(consoleReadIO)=FALSE THEN AbortIO(consoleReadIO)
    ->WaitIO(consoleReadIO)
    IF (consoleReadIO.device<>consoleIO.device) OR (consoleReadIO.unit<>consoleIO.unit)
      CloseDevice(consoleReadIO)
    ENDIF
    deleteExtIO(consoleReadIO)
    consoleReadIO:=NIL
  ENDIF

  IF consoleIO
    IF CheckIO(consoleIO)=FALSE THEN AbortIO(consoleIO)
    ->WaitIO(consoleIO)
    CloseDevice(consoleIO)
    deleteExtIO(consoleIO)
    consoleIO:=NIL
  ENDIF

  IF consoleMP
    deletePort(consoleMP)
    consoleMP:=NIL
  ENDIF

  IF consoleReadMP
    deletePort(consoleReadMP)
    consoleReadMP:=NIL
  ENDIF


  IF windowClose
    CloseWindow(windowClose)
    windowClose:=NIL
  ENDIF

  IF window
    ClearMenuStrip(window)
    CloseWindow(window)
    window:=NIL
  ENDIF

  IF screen
    IF CloseScreen(screen) THEN screen:=NIL
  ENDIF

  IF fontHandle
    CloseFont(fontHandle)
    fontHandle:=NIL
  ENDIF

  scropen:=FALSE
ENDPROC

PROC waitSocketLib(leaveOpen=FALSE)
  DEF n=0,id=0
  IF socketbase=NIL THEN socketbase:=OpenLibrary('bsdsocket.library', 2) ELSE leaveOpen:=TRUE
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
    IF leaveOpen THEN RETURN
    CloseLibrary(socketbase)
  ENDIF
  socketbase:=NIL
ENDPROC

PROC checkTelnetConnection()
ENDPROC (telnetSocket>=0) AND (offHookFlag=FALSE)

PROC checkTelnetData()
  DEF count
  ->DEF buf[1]:STRING
  
  IF telnetSocket=-1 THEN RETURN FALSE
  
  IoctlSocket(telnetSocket,FIONREAD,{count})

  ->count:=Recv(telnetSocket,buf,1,MSG_PEEK)
ENDPROC count>0,count

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
    StringF(expDate,'\z\r\d[2]-\s[3]-\d[4]',d,'JanFebMarAprMayJunJulAugSepOctNovDec'+((m-1)*3),y)
  ELSE
    StrCopy(expVer,v)
    StrCopy(expDate,'')
  ENDIF
ENDPROC

PROC main() HANDLE
  DEF temppath[255]:STRING
  DEF tempstr[255]:STRING
  DEF tempstr2[255]:STRING
  DEF cb: PTR TO confBase
  DEF i,notfound,msg
  DEF p : PTR TO CHAR
  DEF tempfh
  DEF transptr:PTR TO mln
  DEF oldWinPtr
  DEF proc: PTR TO process
  DEF newbroker:PTR TO newbroker

  updateVersion(expressVer,expressDate)

  nodeStart:=getSystemTime()

  ->initialise random seed from scanline position and node start time
  p:=$dff006
  i:=Eor(Shl(p[0],8)+p[0],nodeStart) AND $FFFF
  Rnd((Shl(i,16)+i) OR $80000000)

  InitSemaphore(bgData)
  
  ->set windowptr to -1 to prevent any AmigaDOS insert volume dialogs
  proc:=FindTask(0)
  oldWinPtr:=proc.windowptr
  proc.windowptr:=-1

  fds:=NEW [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]:LONG

  ->extract arg1, arg2 and arg3 from arg using space as delimiter
  StrCopy(tempstr,arg)
  IF (i:=InStr(tempstr,' '))<>-1
    StrCopy(arg1,tempstr,i)
    StrCopy(tempstr,tempstr+i+1)
    IF (i:=InStr(tempstr,' '))<>-1
      StrCopy(arg2,tempstr,i)
      StrCopy(tempstr,tempstr+i+1)
      IF (i:=InStr(tempstr,' '))<>-1
        StrCopy(arg3,tempstr,i)
      ELSE
        StrCopy(arg3,tempstr)
      ENDIF
    ELSE
      StrCopy(arg2,tempstr)
    ENDIF
  ELSE
    StrCopy(arg1,tempstr)
  ENDIF

  IF StrLen(arg3)>0
    IF StriCmp(arg3,'STICKY')
      netTrans:=3
    ELSE
      netTrans:=2
    ENDIF
  ENDIF

  IF StrLen(arg1)>0
    node:=Val(arg1)
  ELSE
    Raise(ERR_NODEPARAM)
  ENDIF

  stripAnsi(0,0,1,0,ansi)

  securityNames:=[
   'ACS.ACCOUNT_EDITING','ACS.READ_BULLETINS','ACS.COMMENT_TO_SYSOP','ACS.DOWNLOAD','ACS.UPLOAD','ACS.ENTER_MESSAGE','ACS.FILE_LISTINGS','ACS.JOIN_CONFERENCE','ACS.NEW_FILES_SINCE',
   'ACS.PAGE_SYSOP','ACS.READ_MESSAGE','ACS.REMOTE_SHELL','ACS.DISPLAY_USER_STATS','ACS.VIEW_A_FILE','ACS.EDIT_USER_INFO','ACS.EDIT_INTERNET_NAME','ACS.EDIT_USER_LOCATION',
   'ACS.EDIT_PHONE_NUMBER','ACS.EDIT_PASSWORD','ACS.ZIPPY_TEXT_SEARCH','ACS.OVERRIDE_CHAT','ACS.SYSOP_DOWNLOAD','ACS.SYSOP_VIEW','ACS.SYSOP_READ','ACS.KEEP_UPLOAD_CREDIT',
   'ACS.OVERRIDE_TIMES','ACS.CLEAR_SCREEN_MSG','ACS.FREE_RESUMING','ACS.ONE_TIME_BULLETINS','ACS.DO_CALLERSLOG','ACS.SENTBY_FILES','ACS.DO_UD_LOG','ACS.SCREEN_TO_FRONT',
   'ACS.DEFAULT_CHAT_ON','ACS.EALL_MESSAGES','ACS.DUPE_FILECHECK','ACS.MESSAGE_EDIT','ACS.LIST_NODES','ACS.MSG_LEVEL','ACS.MSG_EXPERATION','ACS.DELETE_MESSAGE','ACS.ATTACH_FILES',
   'ACS.CUSTOMCOMMANDS','ACS.JOIN_SUB_CONFERENCE','ACS.ZOOM_MAIL','ACS.MCI_MESSAGE','ACS.EDIT_DIRS','ACS.EDIT_FILES','ACS.BREAK_CHAT','ACS.QUIET_NODE','ACS.SYSOP_COMMANDS','ACS.WHO_IS_ONLINE',
   'ACS.RELOGON','ACS.ULSTATS','ACS.XPR_RECEIVE','ACS.XPR_SEND','ACS.WILDCARDS','ACS.CONFERENCE_ACCOUNTING','ACS.PRI_MSGFILES','ACS.PUB_MSGFILES','ACS.FULL_EDIT','ACS.CONFFLAGS',
   'ACS.OLM','ACS.HIDE_FILES','ACS.SHOW_PAYMENTS','ACS.CREDIT_ACCESS','ACS.VOTE','ACS.MODIFY_VOTE','ACS.FILE_EXPANSION','ACS.EDIT_REAL_NAME','ACS.EDIT_USER_NAME','ACS.CENSORED',
   'ACS.ACCOUNT_VIEW','ACS.TRANSLATION','ACS.UNKNOWN','ACS.CREATE_CONFERENCE','ACS.LOCAL_DOWNLOADS','ACS.MAX_PAGES','ACS.OVERRIDE_DEFAULTS','ACS.HOLD_ACCESS','ACS.EDIT_EMAIL',
   'ACS.READ_PRIV_EALL','ACS.READ_PRIV_ALL','ACS.OVERRIDE_TIMELIMIT','ACS.OVERRIDE_CHATLIMIT','ACS.NO_TIMEOUT','ACS.USER_ULSTATS']


  StringF(tempstr,'AmiExpress_Node.\d',node)
  IF FindPort(tempstr)
    StringF(shutDownMsg,'Node   \d already running!',node)
    Raise(ERR_ALREADYRUNNING)
  ENDIF

  mailOptions:=NEW mailOptions

  IF (iconbase:=OpenLibrary('icon.library',33))=NIL THEN Raise(ERR_NOICON)

  IF (diskfontbase:=OpenLibrary('diskfont.library', 37))=NIL THEN Raise(ERR_NO_DISKFONT)

  socketbase:=OpenLibrary('bsdsocket.library', 4)

  recFileNames:=NEW recFileNames.stringlist()

  attachedFiles:=NEW attachedFiles.stringlist(5)

  shortcuts:=NEW shortcuts.stringlist(20)

  historyBuf:=NEW historyBuf.stringlist(20)
  historyNum:=0
  historyCycle:=0

  scomment:=NEW scomment.stringlist(max_desclines)
  FOR i:=1 TO max_desclines
    scomment.add('')
  ENDFOR

  skipdFiles:=NEW skipdFiles.stringlist(100)

  flagFilesList:=NEW flagFilesList.stdlist(MAX_FLAGGED_FILES)

  StrCopy(fontName,'topaz.font')

  StrCopy(securityFlags,'')

  parsedParams:=NEW parsedParams.stringlist(100)

  ioFlags[IOFLAG_FIL_IN]:=0
  ioFlags[IOFLAG_KBD_IN]:=-1
  ioFlags[IOFLAG_SER_IN]:=-1
  ioFlags[IOFLAG_FIL_OUT]:=0
  ioFlags[IOFLAG_PRT_OUT]:=0
  ioFlags[IOFLAG_SCR_OUT]:=0
  ioFlags[IOFLAG_SER_OUT]:=-1

  doorExtSig:=AllocSignal(-1)

  mailStat:=NEW mailStat
  mailHeader:=NEW mailHeader

  tempUser:=NEW tempUser
  tempUserKeys:=NEW tempUserKeys
  tempUserMisc:=NEW tempUserMisc

  IF createServerRP()=RESULT_FAILURE THEN Raise(ERR_SERVERRP)

  IF netTrans=3
    ->STICKY PARAMETER resets clears trapdoor
    sopt.trapDoor:=0
    netTrans:=0
  ENDIF

  saveA4(FindTask(0),{tasksA4})

  StringF(bgCheckPortName,'bgCheckPort\d',node)

  createResControl()
  createRexxPort()

  diskObjectCache:=NIL
  i:=readToolTypeInt(TOOLTYPE_NODE,node,'ICON_CACHE_SIZE')
  IF i<0
    i:=DEFAULT_DISK_OBJECT_CACHE_SIZE
  ENDIF
  IF i>0 THEN diskObjectCache:=NEW diskObjectCache.stdlist(i)

  cacheResetOn:=CACHE_RESET_LOGON
  IF readToolType(TOOLTYPE_NODE,node,'ICON_CACHE_RESET',tempstr)
    IF StriCmp(tempstr,'NEVER')
      cacheResetOn:=CACHE_RESET_NEVER
    ENDIF
  ENDIF

  IF readToolType(TOOLTYPE_NODE,node,'MAX_MESSAGE_LEN',tempstr)
    maxMsgLines:=Val(tempstr)
  ENDIF
  IF maxMsgLines=0 THEN maxMsgLines:=800
  msgBuf:=NEW msgBuf.stringlist(maxMsgLines)

  i:=readToolTypeInt(TOOLTYPE_NODE,node,'SERIAL_CACHE_SIZE')
  IF i>=0
    serialCacheSize:=i
  ENDIF

  IF readToolType(TOOLTYPE_NODE,node,'FIRSTCOMMAND',tempstr)
    processMci(tempstr,tempstr2)
    Execute(tempstr2,NIL,NIL)
  ENDIF

  ringCount:=readToolTypeInt(TOOLTYPE_NODE,node,'RINGCOUNT')

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'FTP')
    nativeFtp:=TRUE
    waitSocketLib(TRUE)
  ENDIF

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'TELNET')
    nativeTelnet:=TRUE
    waitSocketLib(TRUE)
  ENDIF

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'TELNETD')
    ringCount:=2;
    AstrCopy(cmds.mInit,'')
    AstrCopy(cmds.mReset,'ATS0=1*C1\b')
    AstrCopy(cmds.mRing,'RING')
    AstrCopy(cmds.mAnswer,'ATA')
    AstrCopy(sopt.offHook,'')
    waitSocketLib()
  ENDIF

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'TELSERD')
    ringCount:=2;
    AstrCopy(cmds.mInit,'')
    AstrCopy(cmds.mReset,'+++~ATH0S0=1+CID=3\b')
    AstrCopy(cmds.mRing,'RING')
    AstrCopy(cmds.mAnswer,'ATA')
    AstrCopy(sopt.offHook,'')
    sopt.toggles[TOGGLES_SERIALRESET]:=1
    waitSocketLib()
  ENDIF

  StringF(amixnetOutboundDir,'\sAmiXnet/OutBound/',cmds.bbsLoc)

  StringF(fCheckDir,'\sFcheck',cmds.bbsLoc)
  StringF(tempstr,'\sNode\d/Fcheck',cmds.bbsLoc,node)
  IF fileExists(tempstr)
    StrCopy(fCheckDir,tempstr)
  ENDIF

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'OWNDEVUNIT') AND (StrLen(cmds.serDev)>0)
    owndevunitbase:=OpenLibrary('OwnDevUnit.library',0)
    IF owndevunitbase=NIL THEN Raise(ERR_NOOWNDEVUNIT)

    ownDevSignal:=AllocSignal(-1)
    StringF(tempstr,'Express Node \d',node)
    IF AttemptDevUnit(cmds.serDev, cmds.serDevUnit, tempstr, ownDevSignal )
      Raise(ERR_NOSERIALLOCK)
    ELSE
      serialLocked:=TRUE
    ENDIF
  ENDIF

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'NO_CX')=FALSE
    IF (cxbase:=OpenLibrary('commodities.library', 37))=NIL THEN Raise(ERR_LIB)

    -> Commodities talks to a Commodities application through an Exec Message
    -> port, which the application provides
    broker_mp:=CreateMsgPort()

    StringF(tempstr,'Express Node \d',node)

    newbroker:= NEW [NB_VERSION,   -> Version of the NewBroker object
              0,  -> E-Note: pad byte
             tempstr,  -> Name: commodities uses for this commodity
             'Express',      -> Title of commodity that appears in CXExchange
             'Node Broker for Ami-Express',  -> Description
              0,  -> Unique: tells CX not to launch a commodity with the same name
              COF_SHOW_HIDE,  -> Flags: tells CX if this commodity has a window
              0,  -> Pri: this commodity's priority
              0,  -> E-Note: pad byte
              broker_mp, -> Port: mp CX talks to
              0   -> ReservedChannel: reserved for later use
             ]:newbroker

    broker:=CxBroker(newbroker, NIL)
    cxsigflag:=Shl(1, broker_mp.sigbit)

    END newbroker

    -> After it's set up correctly, the broker has to be activated
    ActivateCxObj(broker, TRUE)
  ENDIF


  IF(openSerial(cmds.openingBaud,8,1)<>0) THEN Raise(ERR_NOSERIAL)

  IF(sopt.trapDoor)
    IF StrLen(arg2)>0
      StringF(trapConnect,'CONNECT \s',arg+i+1)
    ELSE
      StrCopy(trapConnect,'CONNECT 19200')
    ENDIF
  ELSE
    intDoReset(sopt.offHook)
    Delay(60)
    StringF(tempstr,'\s\b',cmds.mInit)
    serPuts(tempstr)
    Delay(60)
  ENDIF
  purgeLine()
  ioFlags[IOFLAG_SER_OUT]:=0

  StrCopy(hostLanguage,'')
  readToolType(TOOLTYPE_LANGUAGES,'','HOSTLANGUAGE',hostLanguage)

  StrCopy(userLanguage,hostLanguage)

  IF sopt.translation<>NIL
    transptr:=sopt.translation

    translators:=transptr.succ
    managedTranslators:=FALSE
  ELSE
    loadTranslators()
  ENDIF

  /**** If MultiCom port initialized in ACP then setup appropriate links ****/
  IF(sopt.toggles[TOGGLES_MULTICOM])
    singleNode:=sopt.singleSemi
    masterNode:=sopt.masterSemi
  ENDIF

  IF(StrLen(sopt.offHook)=0)
    AstrCopy(sopt.offHook,'ATM0H1')
  ENDIF

  IF readToolType(TOOLTYPE_NODE,node,'NAME_PROMPT2',namePrompt)=FALSE
    IF readToolType(TOOLTYPE_NODE,node,'NAME_PROMPT',tempstr)
      StringF(namePrompt,'Enter your \s:',tempstr)
    ELSE
      StrCopy(namePrompt,'Enter your Name:')
    ENDIF
  ENDIF

  StrCopy(passwordPrompt,'Password: ')
  IF readToolType(TOOLTYPE_NODE,node,'PASSWORD_PROMPT',passwordPrompt)
    StrAdd(passwordPrompt,' ')
  ENDIF

  timeoutOverride:=readToolTypeInt(TOOLTYPE_NODE,node,'OVERRIDE_TIMEOUT')

  i:=readToolTypeInt(TOOLTYPE_NODE,node,'MAX_MSG_QUE')
  IF i=-1 THEN i:=5
  olmQueue:=NEW olmQueue.stringlist(i)

  olmBuf:=NEW olmBuf.stringlist(100)

  cmds.numConf:=readToolTypeInt(TOOLTYPE_CONFCONFIG,'','NCONFS')
  IF cmds.numConf<1 THEN cmds.numConf:=1

  StrCopy(historyFolder,'')
  readToolType(TOOLTYPE_BBSCONFIG,'','HISTORY',historyFolder)

  IF readToolType(TOOLTYPE_BBSCONFIG,'','USERNOTES',userNotesFolder)=FALSE
    StringF(userNotesFolder,'\suserNotes/',cmds.bbsLoc)
  ENDIF

  i:=readToolTypeInt(TOOLTYPE_BBSCONFIG,node,'MAX_DESCLINES')
  IF i<>-1 THEN max_desclines:=i

  i:=readToolTypeInt(TOOLTYPE_BBSCONFIG,node,'HOLD_ACCESS_LEVEL')
  IF i<>-1 THEN holdAccessLevel:=i

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'NO_EMAILS')=FALSE
    mailOptions.smtpPort:=readToolTypeInt(TOOLTYPE_BBSCONFIG,0,'SMTP_PORT')
    IF readToolType(TOOLTYPE_BBSCONFIG,0,'SMTP_HOST',tempstr) THEN AstrCopy(mailOptions.smtpHost,tempstr,255)
    IF readToolType(TOOLTYPE_BBSCONFIG,0,'SMTP_USERNAME',tempstr) THEN AstrCopy(mailOptions.username,tempstr,255)
    IF readToolType(TOOLTYPE_BBSCONFIG,0,'SMTP_PASSWORD',tempstr) THEN AstrCopy(mailOptions.password,tempstr,255)
    IF readToolType(TOOLTYPE_BBSCONFIG,0,'SYSOP_EMAIL',tempstr) THEN AstrCopy(mailOptions.sysopEmail,tempstr,255)
    IF readToolType(TOOLTYPE_BBSCONFIG,0,'BBS_EMAIL',tempstr) THEN AstrCopy(mailOptions.bbsEmail,tempstr,255)
    IF checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'SMTP_SSL') THEN mailOptions.ssl:=TRUE ELSE mailOptions.ssl:=FALSE
  ENDIF

  IF StrLen(mailOptions.smtpHost)>0
    IF initssl(mailOptions.ssl)=FALSE
      Raise(ERR_SSL)
    ENDIF
  ENDIF
  
  readToolType(TOOLTYPE_BBSCONFIG,0,'DEFAULT_MENUNAME',defaultMenuName)
  IF StrLen(defaultMenuName)=0 THEN StrCopy(defaultMenuName,'MENU')

  timeoutLC:=checkToolTypeExists(TOOLTYPE_BBSCONFIG,0,'TIMEOUT_LC');

  consoleDebugLevel:=readToolTypeInt(TOOLTYPE_NODE,node,'CONSOLE_DEBUG')
  StringF(tempstr,'\s ',arg)
  UpperStr(tempstr)
  IF (InStr(tempstr,' CONSOLE_DEBUG '))<>-1
    consoleDebugLevel:=LOG_DEBUG
  ENDIF

  IF (InStr(tempstr,' NO_DEBUG '))<>-1
    consoleDebugLevel:=LOG_NONE
  ENDIF

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'DEBUG_LOG') THEN debugLogLevel:=LOG_WARN ELSE debugLogLevel:=LOG_NONE

  StrCopy(consoleOutputDeviceName,'console.device')
  readToolType(TOOLTYPE_NODE,node,'CONSOLE_OUTPUT_DEVICE',consoleOutputDeviceName)

  StrCopy(consoleInputDeviceName,'console.device')
  readToolType(TOOLTYPE_NODE,node,'CONSOLE_INPUT_DEVICE',consoleInputDeviceName)

  memConf:=List(cmds.numConf+1)
  confNames:=NEW confNames.stringlist(cmds.numConf)
  confDirs:=NEW confDirs.stringlist(cmds.numConf)
  FOR i:=1 TO cmds.numConf
    ListAdd(memConf,[0])
    StringF(tempstr,'NAME.\d',i)
    readToolType(TOOLTYPE_CONFCONFIG,'',tempstr,tempstr2)
    confNames.add(tempstr2)
    IF i<11
      p:=cmds.conf1Name
      AstrCopy(p+((i-1)*54),tempstr2,54)
    ENDIF

    StringF(tempstr,'LOCATION.\d',i)
    readToolType(TOOLTYPE_CONFCONFIG,'',tempstr,tempstr2)
    checkPathSlash(tempstr2)
    confDirs.add(tempstr2)
    IF i<11
      p:=cmds.conf1Loc
      AstrCopy(p+((i-1)*54),tempstr2,54)
    ENDIF
  ENDFOR
  ListAdd(memConf,[0])

  confBases:=NEW confBases.stdlist(countMsgBases())
  FOR i:=1 TO confBases.maxSize()
    cb:=NEW cb
    confBases.add(cb)
  ENDFOR

  xprTitle:=NEW xprTitle.stringlist(100)
  xprLib:=NEW xprLib.stringlist(100)
  i:=1
  REPEAT
    notfound:=FALSE
    StringF(temppath,'TITLE.\d',i)
    IF readToolType(TOOLTYPE_XPRTYPES,'',temppath,tempstr)=FALSE
      notfound:=TRUE
    ENDIF

    StringF(temppath,'LIBRARY.\d',i)
    IF readToolType(TOOLTYPE_XPRTYPES,'',temppath,tempstr2)=FALSE
      notfound:=TRUE
    ENDIF

    IF notfound=FALSE
      xprTitle.add(tempstr)
      xprLib.add(tempstr2)
    ENDIF
    i++
  UNTIL notfound

  screenTypeTitle:=NEW screenTypeTitle.stringlist(100)
  screenTypeExt:=NEW screenTypeExt.stringlist(100)
  i:=1
  REPEAT
    notfound:=FALSE
    StringF(temppath,'TITLE.\d',i)
    IF readToolType(TOOLTYPE_SCREENTYPES,'',temppath,tempstr)=FALSE
      notfound:=TRUE
    ENDIF

    StringF(temppath,'TYPE.\d',i)
    IF readToolType(TOOLTYPE_SCREENTYPES,'',temppath,tempstr2)=FALSE
      notfound:=TRUE
    ENDIF

    IF (StrLen(tempstr)=0) OR (StrLen(tempstr2)=0) THEN notfound:=TRUE

    IF notfound=FALSE
      screenTypeTitle.add(tempstr)
      IF (tempstr2[0]<>".")
        StringF(tempstr,'.\s',tempstr2)
        screenTypeExt.add(tempstr)
      ELSE
        screenTypeExt.add(tempstr2)
      ENDIF

    ENDIF
    i++
  UNTIL notfound

  IF checkToolTypeExists(TOOLTYPE_NODE,node,'OWN_PARTFILES') THEN ownPartFiles:=TRUE

  StrCopy(confDBName,'Conf.DB')
  readToolType(TOOLTYPE_NODE,node,'CONF_DB',confDBName)

  IF readToolType(TOOLTYPE_NODE,node,'USERDATA_NAME',temppath)
    StrCopy(userDataFile,temppath)
  ELSE
    StringF(userDataFile,'\suser.data',cmds.bbsLoc)
  ENDIF

  IF readToolType(TOOLTYPE_NODE,node,'USERKEYS_NAME',temppath)
    StrCopy(userKeysFile,temppath)
  ELSE
    StringF(userKeysFile,'\suser.keys',cmds.bbsLoc)
  ENDIF

  IF readToolType(TOOLTYPE_NODE,node,'USERMISC_NAME',temppath)
    StrCopy(userMiscFile,temppath)
  ELSE
    StringF(userMiscFile,'\suser.misc',cmds.bbsLoc)
  ENDIF

  autoDeactivateDays:=readToolTypeInt(TOOLTYPE_BBSCONFIG,'','AUTO_DEACTIVATE_DAYS')

  computerEntries:=readToolTypeInt(TOOLTYPE_COMPUTERLIST,'','COMPUTER.NUM')

  onlineBaud:=cmds.openingBaud
  onlineBaudR:=cmds.openingBaud

  IF (computerEntries>0)
    computerTypes:=NEW computerTypes.stringlist(computerEntries)
    FOR i:=1 TO computerEntries
      StringF(temppath,'COMPUTER.\d',i)
      readToolType(TOOLTYPE_COMPUTERLIST,'',temppath,tempstr)
      computerTypes.add(tempstr)
    ENDFOR
  ENDIF
  IF computerEntries=0
    StrCopy(shutDownMsg,'Computer Types Error')
    Raise(ERR_COMPUTERTYPES)
  ENDIF

  StringF(nodeWorkDir,'\sNode\d/Work/',cmds.bbsLoc,node)

  tidyPlayPen()
  cleanItUp()
  clearUser()

  clearOverride()

  sysopAvail:=IF cmds.acLvl[LVL_DEFAULT_CHAT_ON] THEN TRUE ELSE FALSE
  updateTitle(NIL)

  IF(sopt.toggles[TOGGLES_QUIETSTART])
    quietFlag:=TRUE
  ELSE
    quietFlag:=FALSE
  ENDIF

  sendQuietFlag(quietFlag)

  IF readToolType(TOOLTYPE_BBSCONFIG,'','REGKEY',regKey)=FALSE
    StrCopy(regKey,'NONE')
  ENDIF

  StrCopy(nodeScreenDir,sopt.nodeScreens)


  IF (proc.task.ln.pri<>cmds.taskPri)
    SetTaskPri(FindTask(0),cmds.taskPri)
  ENDIF

  createMenus()
  IF (sopt.iconify=FALSE) THEN openExpressScreen()

  formatLongDateTime(getSystemTime(),tempstr)
  StringF(tempstr2,'####### BBS Node \d started on \s #######\n',node,tempstr)
  startLog(tempstr2)

  displayInitialisingLogo()

  state:=STATE_AWAIT
  reqState:=REQ_STATE_NONE
  debugLog(LOG_DEBUG,'Node ready')


  WHILE state<>STATE_SHUTDOWN
    IF state=STATE_AWAIT THEN processAwait()
    IF ftpConn
      IF (state=STATE_LOGON) THEN processFtpLogon()
      IF state=STATE_LOGGEDON THEN processFtpLoggedOnUser()
    ELSE
      IF state=STATE_SYSOPLOGON THEN processSysopLogon()
      IF (state=STATE_LOGON) THEN processLogon()
      IF state=STATE_LOGGEDON THEN processLoggedOnUser()
    ENDIF
    IF state=STATE_LOGGING_OFF THEN processLoggingOff()

    IF reqState<>REQ_STATE_NONE
      IF (state<>STATE_LOGGING_OFF) AND (state<>STATE_AWAIT) THEN state:=STATE_LOGGING_OFF

      IF reqState=REQ_STATE_LOGOFF
        reqState:=REQ_STATE_NONE
      ELSEIF (state=STATE_AWAIT)
        state:=STATE_SHUTDOWN
      ENDIF
    ENDIF

  ENDWHILE

  IF reqState=REQ_STATE_SHUTDOWN_OFFHOOK
    -> go offhook
    modemOffHook()
  ENDIF

 EXCEPT DO
  IF sopt<>NIL
    setEnvStat(ENV_SHUTDOWN)

    StringF(tempstr,'####### BBS Node \d shutdown @ \s#######\n',node,shutDownMsg)
    startLog(tempstr)
    IF(StrLen(sopt.shutDown)>0)
      StringF(tempstr,'execute \s \d',sopt.shutDown,node)
      IF(tempfh:=Open('NIL:',MODE_OLDFILE))
        Execute(tempstr,tempfh,tempfh)
        Close(tempfh)
      ENDIF
    ENDIF
  ENDIF

  IF fds<>NIL
    END fds[32]
  ENDIF
  
  IF proc<>NIL
    proc.windowptr:=oldWinPtr
  ENDIF

  IF(captureFP)
    Close(captureFP)
    captureFP:=NIL
  ENDIF

  unloadTranslators()

  END attachedFiles

  END shortcuts

  END scomment
  END parsedParams
  END computerTypes
  END historyBuf
  END msgBuf

  END confBases

  IF flagFilesList
    clearFlagItems(flagFilesList)
    END flagFilesList
  ENDIF

  END recFileNames
  END confNames
  END confDirs
  END olmBuf
  END olmQueue

  END xprLib
  END xprTitle

  END screenTypeTitle
  END screenTypeExt

  clearDiskObjectCache()
  IF diskObjectCache<>NIL THEN END diskObjectCache
  DisposeLink(memConf)

  END skipdFiles

  IF (loggedOnUser) THEN END loggedOnUser
  IF (loggedOnUserKeys) THEN END loggedOnUserKeys
  IF (loggedOnUserMisc) THEN END loggedOnUserMisc
  IF (mailStat) THEN END mailStat
  IF (mailHeader) THEN END mailHeader

  IF(tempUser) THEN END tempUser
  IF(tempUserKeys) THEN END tempUserKeys
  IF(tempUserMisc) THEN END tempUserMisc

  cleanupssl()
  END mailOptions
  
  IF socketbase<>NIL THEN CloseLibrary(socketbase)
  socketbase:=NIL
  
  closeExpressScreen()
  freeMenus()
  
  IF iconbase THEN CloseLibrary(iconbase)
  IF diskfontbase THEN CloseLibrary(diskfontbase)

  IF broker THEN DeleteCxObj(broker)
  IF broker_mp
    -> Empty the port of CxMsgs
    WHILE msg:=GetMsg(broker_mp) DO ReplyMsg(msg)
    DeleteMsgPort(broker_mp)
  ENDIF
  IF cxbase THEN CloseLibrary(cxbase)

  IF serverRP THEN deleteServerRP()
  IF resmp THEN deleteResControl()
  IF rexxmp THEN deleteRexxPort()

  IF ownDevSignal<>NIL THEN FreeSignal(ownDevSignal)
  IF serialLocked
    FreeDevUnit(cmds.serDev,cmds.serDevUnit)
    serialLocked:=FALSE
  ENDIF
  IF owndevunitbase THEN CloseLibrary(owndevunitbase)

  closeSerial()
 
  IF (doorExtSig<>NIL) THEN FreeSignal(doorExtSig)
  doorExtSig:=NIL

  SELECT exception
  CASE ERR_SSL
    debugLog(LOG_ERROR,'Error: failed during ssl setup (open AmiSSL library or create ssl context')
  CASE ERR_SCREEN
    debugLog(LOG_ERROR,'Error: Failed to open custom screen')
  CASE ERR_BRKR
    debugLog(LOG_ERROR,'Error: Could not create broker')
  CASE ERR_CXERR
    debugLog(LOG_ERROR,'Error: Could not activate broker')
  CASE ERR_LIB
    debugLog(LOG_ERROR,'Error: Could not open commodities.library')
  CASE ERR_PORT
    debugLog(LOG_ERROR,'Error: Could not create message port')
  CASE ERR_ALREADYRUNNING
    debugLog(LOG_ERROR,'Error: Node already running')
  CASE ERR_NOSERIAL
    StringF(tempstr,'Can''t open \s!',cmds.serDev)
    debugLog(LOG_ERROR,tempstr)
  CASE ERR_NOSERIALLOCK
    StringF(tempstr,'Can''t get an owndevunit lock on \s!',cmds.serDev)
    debugLog(LOG_ERROR,tempstr)
  CASE ERR_NOOWNDEVUNIT
    StringF(tempstr,'Can''t open owndevunit.library',cmds.serDev)
    debugLog(LOG_ERROR,tempstr)
  CASE ERR_FDSRANGE
    debugLog(LOG_ERROR,'FDS Range error')
  CASE ERR_NODEPARAM
    WriteF('Express should not be launched manually\n.') 
  CASE "NIL"
    StringF(tempstr,'NIL pointer error at line \d',exceptioninfo)
    debugLog(LOG_ERROR,tempstr) 
    WriteF('Error: NIL pointer exception')
  DEFAULT
    IF exception<>0
      StringF(tempstr,'Unknown exception \d',exception)
      debugLog(LOG_ERROR,tempstr) 
    ENDIF
  ENDSELECT
ENDPROC

PROC saveA4(taskID,tasktable)
  MOVEM.L D0-D7/A0-A6,-(A7)
  MOVE.L taskID,D7

  LEA regA4(PC),A0
  MOVE.L tasktable,A1
  MOVE.L node,D0
  ADD.W D0,D0
  ADD.W D0,D0
  MOVE.L A4,0(A0,D0.W)
  MOVE.L D7,0(A1,D0.W)
  MOVEM.L (A7)+,D0-D7/A0-A6 
ENDPROC

PROC loadA4(tasktable)
  MOVEM.L D0-D7/A0-A3/A5-A6,-(A7)

  MOVE.L 4,A6
  SUB.L A1,A1
  JSR -$126(A6)     ->findtask
  MOVE.L D0,D1

  LEA regA4(PC),A0
  MOVE.L tasktable,A1
  CLR.L D0
findA4task:
  MOVE.L 0(A1,D0.W),D2
  CMP.L D1,D2
  BEQ taskfound

  ADD.L #4,D0
  CMP.L #128,D0
  BNE findA4task

  MOVE.L #AG_BADPARM,D7
  JSR  -$6c(A6)   ->Alert(AG_BADPARM)

taskfound:
  MOVE.L 0(A0,D0),A4
  MOVEM.L (A7)+,D0-D7/A0-A3/A5-A6
ENDPROC

tasksA4:
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL

threadtasksA4:
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL

regA4:
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL
    LONG NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL
