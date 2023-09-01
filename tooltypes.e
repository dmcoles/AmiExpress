/* tooltypes helper functions */

  OPT MODULE
  
  MODULE 'workbench/workbench','icon','dos/dos'
  MODULE '*axcommon','*axenums','*axobjects','*stringlist','*miscfuncs'

->all of the below are globals shared with express.e 
->must be changed in both places
EXPORT DEF cmds:PTR TO commands
EXPORT DEF confDirs: PTR TO stringlist
EXPORT DEF currentConf
EXPORT DEF currentConfDir:PTR TO CHAR
EXPORT DEF fCheckDir:PTR TO CHAR
EXPORT DEF xprLib: PTR TO stringlist
EXPORT DEF diskObjectCache:PTR TO stdlist
EXPORT DEF node
EXPORT DEF cacheTests
EXPORT DEF cacheHits
EXPORT DEF loggedOnUser: PTR TO user
EXPORT DEF memConf:PTR TO LONG

EXPORT PROC getNodeFile(toolType,tooltypeSelector,nodeFile)
  DEF tempStr[255]:STRING
  DEF tempStr2[255]:STRING
  DEF i,p

  SELECT toolType
    CASE TOOLTYPE_NODE
      -> tooltypeSector is node number
      StringF(nodeFile,'\sNode\d',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_WINDOW
      -> tooltypeSector is node number
      StringF(nodeFile,'\sNode\d/WINDOW.DEF',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_CONFCONFIG
      -> tooltypeSector is not used
      StringF(nodeFile,'\sConfconfig',cmds.bbsLoc)
    CASE TOOLTYPE_BBSCONFIG
      -> tooltypeSector is not used
      StringF(nodeFile,'\sbbsConfig',cmds.bbsLoc)
    CASE TOOLTYPE_NAMESNOTALLOWED
      -> tooltypeSector is not used
      StringF(nodeFile,'\sNamesNotAllowed',cmds.bbsLoc)
    CASE TOOLTYPE_CONF
      -> tooltypeSector is conf number
      ->get conf location
      StringF(tempStr,'LOCATION.\d',tooltypeSelector)
      readToolType(TOOLTYPE_CONFCONFIG,'',tempStr,tempStr2)
      IF tempStr2[StrLen(tempStr2)-1]="/" THEN SetStr(tempStr2,StrLen(tempStr2)-1)
      StringF(nodeFile,'\s',tempStr2)
    CASE TOOLTYPE_MSGBASE
      -> tooltypeSector is conf number
      ->get conf location
      StrCopy(tempStr,confDirs.item(tooltypeSelector-1))      ->getConfLocation(tooltypeSelector,tempStr)
      StringF(nodeFile,'\sMsgBases',tempStr)
    CASE TOOLTYPE_BBSCMD
      -> tooltypeSector is command name string
      StringF(nodeFile,'\sCommands/BBSCmd/\s',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_CONFCMD
      -> tooltypeSector is command name string
      StringF(nodeFile,'\sCommands/Conf\dCmd/\s',cmds.bbsLoc,currentConf,tooltypeSelector)
    CASE TOOLTYPE_CONFCMD2
      -> tooltypeSector is command name string
      StringF(nodeFile,'\s\s',currentConfDir,tooltypeSelector)
    CASE TOOLTYPE_NODECMD
      -> tooltypeSector is command name string
      StringF(nodeFile,'\sCommands/Node\dCmd/\s',cmds.bbsLoc,node,tooltypeSelector)
    CASE TOOLTYPE_CONFSYSCMD
      -> tooltypeSector is command name string
      StringF(nodeFile,'\sCommands/Conf\dSysCmd/\s',cmds.bbsLoc,currentConf,tooltypeSelector)
    CASE TOOLTYPE_NODESYSCMD
      -> tooltypeSector is command name string
      StringF(nodeFile,'\sCommands/Node\dSysCmd/\s',cmds.bbsLoc,node,tooltypeSelector)
    CASE TOOLTYPE_SYSCMD
      -> tooltypeSector is command name string
      StringF(nodeFile,'\sCommands/SYSCmd/\s',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_DRIVES
      -> tooltypeSector is not used
      StringF(nodeFile,'\sDrives',cmds.bbsLoc)
    CASE TOOLTYPE_COMPUTERLIST
      -> tooltypeSector is not used
      StringF(nodeFile,'\sComputerList',cmds.bbsLoc)
    CASE TOOLTYPE_DEFAULT_ACCESS
      -> tooltypeSector is not used
      StringF(nodeFile,'\sAccess',cmds.bbsLoc)
    CASE TOOLTYPE_USER_ACCESS
      -> tooltypeSector is not used
      getUserAccessFilename(nodeFile)
    CASE TOOLTYPE_ACCESS
      -> tooltypeSector is access level number
      StringF(nodeFile,'\sAccess/ACS.\d',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_AREA
      -> tooltypeSector is access area name
      StringF(nodeFile,'\sAccess/AREA.\s',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_PRESET
      -> tooltypeSector is preset level number
      StringF(nodeFile,'\sAccess/PRESET.\d',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_NODE_PRESET
      -> tooltypeSector is access level number, note this also uses the current node
      StringF(nodeFile,'\sNode\d/PRESET.\d',cmds.bbsLoc,node,tooltypeSelector)
    CASE TOOLTYPE_FCHECK
      -> tooltypeSector is file type
      StringF(nodeFile,'\s/\s',fCheckDir,tooltypeSelector)
    CASE TOOLTYPE_NODE_WINDOW
      -> tooltypeSector is node number
      StringF(nodeFile,'\sNode\d/WINDOW.DEF',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_NODE_TIMES
      -> tooltypeSector is node number
      StringF(nodeFile,'\sNode\d/TIMES.DEF',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_CONNECT
      -> tooltypeSector is node number
      StringF(nodeFile,'\sNode\d/Connect.Def',cmds.bbsLoc,tooltypeSelector)
    CASE TOOLTYPE_XPRTYPES
      -> tooltypeSector is not used
      StringF(nodeFile,'\sProtocols/XprTypes',cmds.bbsLoc)
    CASE TOOLTYPE_XFERLIB
      -> tooltypeSector is xpr lib number
      StringF(nodeFile,'\sProtocols/\s',cmds.bbsLoc,xprLib.item(tooltypeSelector))
    CASE TOOLTYPE_SCREENTYPES
      -> tooltypeSector is not used
      StringF(nodeFile,'\sScreenTypes',cmds.bbsLoc)
    CASE TOOLTYPE_NRAMS
      -> tooltypeSector is node,
      StringF(tempStr,'\sNode\d/NRAMS',cmds.bbsLoc,tooltypeSelector)
      IF findFirst(tempStr,tempStr2)
        p:=-1
        FOR i:=0 TO StrLen(tempStr2)-1
          IF tempStr2[i]="." THEN p:=i
        ENDFOR
        IF (p>=0)
          SetStr(tempStr2,p)
        ENDIF
        StringF(nodeFile,'\s/\s',tempStr,tempStr2)
      ELSE
        StrCopy(nodeFile,'')
      ENDIF
    CASE TOOLTYPE_ASCPACK
      -> tooltypeSector is not used
      StringF(nodeFile,'\sZoom/ASCPACK',cmds.bbsLoc)
    CASE TOOLTYPE_QWKPACK
      -> tooltypeSector is not used
      StringF(nodeFile,'\sZoom/QWKPACK',cmds.bbsLoc)
    CASE TOOLTYPE_QWKCONFIG
      -> tooltypeSector is not used
      StringF(nodeFile,'\sZoom/QWKCFG',cmds.bbsLoc)
    CASE TOOLTYPE_LANGUAGES
      -> tooltypeSector is not used
      StringF(nodeFile,'\sLanguages',cmds.bbsLoc)
  ENDSELECT
ENDPROC

EXPORT PROC readToolType(toolType,tooltypeSelector,key,outValue)
  DEF nodeFile[255]:STRING
  DEF do: PTR TO diskobject
  DEF tooltypes
  DEF s: PTR TO CHAR

  s:=NIL
  getNodeFile(toolType,tooltypeSelector,nodeFile)

  do:=getOrCreateCacheItem(nodeFile)
  IF (do)
    tooltypes:=do.tooltypes
    IF (s:=FindToolType(tooltypes,key)) THEN StrCopy(outValue,s)
  ENDIF
  IF diskObjectCache=NIL
    FreeDiskObject(do)
  ELSE
    IF tooltypeSelector=TOOLTYPE_CONF
      key--
      IF memConf ANDALSO (key<(ListLen(memConf)-1)) THEN memConf[key]:=do
    ENDIF
  ENDIF
ENDPROC s<>NIL

EXPORT PROC readToolTypeInt(toolType,tooltypeSelector,key)
  DEF value[255]:STRING
  IF readToolType(toolType,tooltypeSelector,key,value)
    RETURN Val(value)
  ENDIF
ENDPROC -1

EXPORT PROC checkToolType(toolType,tooltypeSelector,key,testValue)
  DEF nodeFile[255]:STRING
  DEF do: diskobject
  DEF tooltypes
  DEF s: PTR TO CHAR
  DEF result=FALSE

  s:=NIL

  getNodeFile(toolType,tooltypeSelector,nodeFile)

  do:=getOrCreateCacheItem(nodeFile)
  IF (do)
    tooltypes:=do.tooltypes
    IF(s:=FindToolType(tooltypes,key))
      IF (MatchToolValue(s,testValue)) THEN result:=TRUE
    ENDIF
  ENDIF
  IF diskObjectCache=NIL THEN FreeDiskObject(do)
ENDPROC result

EXPORT PROC checkToolTypeExists(toolType,tooltypeSelector,key)
  DEF nodeFile[255]:STRING
  DEF do: diskobject
  DEF tooltypes
  DEF s: PTR TO CHAR
  DEF result=FALSE

  s:=NIL

  getNodeFile(toolType,tooltypeSelector,nodeFile)

  do:=getOrCreateCacheItem(nodeFile)
  IF (do)
    tooltypes:=do.tooltypes
    IF(s:=FindToolType(tooltypes,key)) THEN result:=TRUE
  ENDIF
  IF diskObjectCache=NIL THEN FreeDiskObject(do)
ENDPROC result

EXPORT PROC getOrCreateCacheItem(fileName:PTR TO CHAR)
  DEF i,cnt,found=FALSE
  DEF cacheObj: PTR TO diskObjectCacheItem
  DEF oldCacheObj: PTR TO diskObjectCacheItem
  DEF do=NIL:PTR TO diskobject
  DEF fn2[255]:STRING
  DEF ownToolTypes
  DEF toolTypes:PTR TO LONG
  DEF fh,fileBuf,off,lineCount,len

  IF diskObjectCache<>NIL
    cnt:=diskObjectCache.count()

    i:=0
    WHILE (i<cnt) AND (found=FALSE)
      IF (cacheObj:=diskObjectCache.item(i))
        IF StriCmp(fileName,cacheObj.fileName)
          do:=cacheObj.diskObject
          found:=TRUE
        ENDIF
      ENDIF
      IF found=FALSE THEN i++
    ENDWHILE
  ENDIF

  cacheTests++
  IF found
    ->LRU algorithm, move most recently used to end of list
    i++
    WHILE i<cnt
      diskObjectCache.setItem(i-1,diskObjectCache.item(i))
      i++
    ENDWHILE
    diskObjectCache.setItem(cnt-1,cacheObj)
    cacheHits++
  ELSE
    do:=GetDiskObject(fileName)
    ownToolTypes:=FALSE
    IF do=NIL
      StringF(fn2,'\s.txt',fileName)
      IF fileExists(fn2)=FALSE
        StringF(fn2,'\s.cfg',fileName)
        IF fileExists(fn2)
          do:=GetDefDiskObject(WBPROJECT)
        ENDIF
      ELSE
        do:=GetDefDiskObject(WBPROJECT)
      ENDIF
      IF do<>NIL
        fileBuf:=New(FileLength(fn2)+1)     ->allow an extra char in case file does not end in LF

        fh:=Open(fn2,MODE_OLDFILE)
        IF fh<>0
          off:=0
          lineCount:=0
          WHILE(ReadStr(fh,fn2)<>-1) OR (StrLen(fn2)>0)
            len:=0
            WHILE (fn2[len]<>0) AND (fn2[len]<>";")
              len++
            ENDWHILE

            ->trim trailing space
            WHILE (fn2[len-1]<=32) AND (len>0)
              len--
              EXIT len=0    ->this is just here to prevent the fn2[len-1] causing a buffer underrun in the absence of short circuit evaluation
            ENDWHILE
            SetStr(fn2,len)

            AstrCopy(fileBuf+off,fn2,len+1)
            lineCount++
            off:=off+len+1
          ENDWHILE

          toolTypes:=List(lineCount+1)
          off:=0
          FOR i:=1 TO lineCount
            ListAddItem(toolTypes,fileBuf+off)
            off:=off+StrLen(fileBuf+off)+1
          ENDFOR
          ListAdd(toolTypes,[NIL])
          do.tooltypes:=toolTypes
          ownToolTypes:=TRUE
          Close(fh)
        ELSE
          Dispose(fileBuf)
          FreeDiskObject(do)
          do:=NIL
        ENDIF
      ENDIF
    ENDIF
    IF diskObjectCache<>NIL
      cacheObj:=NEW cacheObj
      cacheObj.fileName:=String(StrLen(fileName))
      cacheObj.ownsToolTypes:=ownToolTypes
      StrCopy(cacheObj.fileName,fileName)
      cacheObj.diskObject:=do

      IF diskObjectCache.count()<(diskObjectCache.maxSize()-1)
        diskObjectCache.add(cacheObj)
      ELSE
        oldCacheObj:=diskObjectCache.item(0)
        DisposeLink(oldCacheObj.fileName)
        FreeDiskObject(oldCacheObj.diskObject)
        diskObjectCache.remove(0)
        diskObjectCache.add(cacheObj)
      ENDIF
    ENDIF
  ENDIF
ENDPROC do

EXPORT PROC clearDiskObjectCache()
  DEF cacheObj: PTR TO diskObjectCacheItem
  DEF i, do: PTR TO diskobject
  DEF mem
  
  IF memConf THEN FOR i:=0 TO ListLen(memConf)-1 DO memConf[i]:=0
  IF diskObjectCache=NIL THEN RETURN
  FOR i:=0 TO diskObjectCache.count()-1
    IF (cacheObj:=diskObjectCache.item(i))
      IF cacheObj.ownsToolTypes
        do:=cacheObj.diskObject
        mem:=do.tooltypes[0]      -> release the file buffer (first string pointer points to start of buffer)
        Dispose(mem)
        DisposeLink(do.tooltypes)     ->our tooltypes is a list that needs to be freed
      ENDIF
      DisposeLink(cacheObj.fileName)
      IF cacheObj.diskObject<>NIL
        do:=cacheObj.diskObject
        FreeDiskObject(do)
      ENDIF
      END cacheObj
    ENDIF
  ENDFOR
  diskObjectCache.clear()
  cacheTests:=0
  cacheHits:=0
ENDPROC

EXPORT PROC getUserAccessFilename(outFilename: PTR TO CHAR)
  DEF tempStr[255]:STRING

  DEF i,c

  StrCopy(tempStr,loggedOnUser.name)
  FOR i:=0 TO StrLen(tempStr)-1
    c:=tempStr[i]
    SELECT c
      CASE "%"
        tempStr[i]:="_"
      CASE "#"
        tempStr[i]:="_"
      CASE "?"
        tempStr[i]:="_"
      CASE "/"
        tempStr[i]:="_"
      CASE "("
        tempStr[i]:="_"
      CASE ")"
        tempStr[i]:="_"
    ENDSELECT
  ENDFOR

  StringF(outFilename,'\sACCESS/\s',cmds.bbsLoc,tempStr)
ENDPROC

