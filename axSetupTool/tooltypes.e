OPT MODULE
OPT PREPROCESS

MODULE 'workbench/workbench','icon','*/stringlist','dos/dos'

DEF diskObjectCache:PTR TO stdlist
DEF changesMade

EXPORT OBJECT diskObjectCacheItem
  fileName:PTR TO CHAR
  diskObject: LONG
  originalToolTypes: LONG
  ownsToolTypes: CHAR
  changed:CHAR
ENDOBJECT

EXPORT PROC readToolType(toolType,key,outValue)
  DEF do: PTR TO diskobject
  DEF tooltypes
  DEF s: PTR TO CHAR
  
  s:=NIL
  StrCopy(outValue,'')
  do:=getOrCreateCacheItem(toolType)
  IF (do)
    tooltypes:=do.tooltypes
    IF tooltypes
      IF (s:=FindToolType(tooltypes,key)) THEN StrCopy(outValue,s)
    ENDIF
    IF diskObjectCache=NIL THEN FreeDiskObject(do)
  ENDIF
ENDPROC s<>NIL

EXPORT PROC readAllToolTypes(toolType,outList:PTR TO stringlist)
  DEF do: PTR TO diskobject
  DEF tooltypes:PTR TO LONG
  DEF count

  outList.clear()
  do:=getOrCreateCacheItem(toolType)
  IF (do)
    tooltypes:=do.tooltypes
    IF tooltypes
      count:=0
      WHILE tooltypes[count]<>0 
        outList.add(tooltypes[count])
        count++
      ENDWHILE
    ENDIF
    IF diskObjectCache=NIL THEN FreeDiskObject(do)
  ENDIF
ENDPROC

PROC getKeyName(tooltype,outKey)
  DEF i=0
  StrCopy(outKey,'')
  WHILE i<StrLen(tooltype)
    EXIT tooltype[i]="="
    IF tooltype[i]<>" " THEN StrAddChar(outKey,tooltype[i])
    i++
  ENDWHILE
ENDPROC

EXPORT PROC writeToolType(toolType,key,newValue=-1,force=FALSE)
  DEF do: PTR TO diskobject
  DEF oldtooltypes:PTR TO LONG,newToolTypes,count,i
  DEF keyName[255]:STRING
  DEF newItem[255]:STRING
  DEF needToAdd=TRUE
  DEF item
  DEF s
  DEF cacheObj:PTR TO diskObjectCacheItem


  IF newValue=-1
    StringF(newItem,'\s',key)
    newValue:=''
  ELSEIF newValue
    IF StrLen(newValue)=0
      deleteToolType(toolType,key)
      RETURN
    ENDIF
    StringF(newItem,'\s=\s',key,newValue)
  ELSEIF force=FALSE
    deleteToolType(toolType,key)
    RETURN
  ENDIF

  do,cacheObj:=getOrCreateCacheItem(toolType,TRUE)
  IF (do)
    oldtooltypes:=do.tooltypes
    IF oldtooltypes
      IF (s:=FindToolType(oldtooltypes,key)) ANDALSO StrCmp(s,newValue)
        //no changes so no need to save
        RETURN
      ENDIF
    ENDIF
    ->WriteF('update tooltype \s \s = \s\n',toolType,key,newValue)
    changesMade:=TRUE
    
    count:=0
    IF oldtooltypes
      WHILE oldtooltypes[count]<>0 
        count++
      ENDWHILE
    ENDIF

    IF (cacheObj.originalToolTypes=oldtooltypes)
      newToolTypes:=List(count+27)
            
      FOR i:=0 TO count-1
        ListAddItem(newToolTypes,AstrClone(oldtooltypes[i],255))
      ENDFOR
      ListAddItem(newToolTypes,0)
      oldtooltypes:=newToolTypes
    ENDIF  
    
    IF ListLen(oldtooltypes)=ListMax(oldtooltypes)
      newToolTypes:=List(count+27)
      FOR i:=0 TO count-1
        ListAddItem(newToolTypes,AstrClone(oldtooltypes[i],255))
        DisposeLink(oldtooltypes[i])
      ENDFOR
      ListAdd(newToolTypes,[NIL])
      DisposeLink(oldtooltypes)
      oldtooltypes:=newToolTypes
    ENDIF

    FOR i:=0 TO count-1
      getKeyName(oldtooltypes[i],keyName)
      IF StriCmp(keyName,key)
        StrCopy(oldtooltypes[i],newItem)
        cacheObj.changed:=TRUE
        needToAdd:=FALSE
      ENDIF
    ENDFOR
    IF needToAdd
      ->WriteF('added \s\n',newItem)
      changesMade:=TRUE
      cacheObj.changed:=TRUE
      oldtooltypes[count]:=StrClone(newItem)
      ListAddItem(oldtooltypes,0)
    ENDIF
    do.tooltypes:=oldtooltypes
  ENDIF
ENDPROC

EXPORT PROC deleteToolType(toolType,key)
  DEF do: PTR TO diskobject
  DEF oldtooltypes:PTR TO LONG,newToolTypes
  DEF keyName[255]:STRING
  DEF count,i,changed=FALSE,n
  DEF cacheObj:PTR TO diskObjectCacheItem

  do,cacheObj:=getOrCreateCacheItem(toolType)
  IF (do)
    oldtooltypes:=do.tooltypes
    
    IF(FindToolType(oldtooltypes,key))=FALSE THEN RETURN

    count:=0
    IF oldtooltypes
      WHILE oldtooltypes[count]<>0 
        count++
      ENDWHILE
    ENDIF

    IF (cacheObj.originalToolTypes=oldtooltypes)
      newToolTypes:=List(count+27)
      FOR i:=0 TO count-1
        ListAddItem(newToolTypes,AstrClone(oldtooltypes[i],255))
      ENDFOR
      ListAdd(newToolTypes,[NIL])
      oldtooltypes:=newToolTypes
    ENDIF  

    n:=0
    FOR i:=0 TO count-1
      getKeyName(oldtooltypes[i],keyName)
      IF StriCmp(keyName,key)=FALSE
        IF i<>n THEN StrCopy(oldtooltypes[n],oldtooltypes[i])
        n++
      ELSE
        changed:=TRUE
        cacheObj.changed:=TRUE
      ENDIF
    ENDFOR
    FOR i:=n TO count-1
      DisposeLink(oldtooltypes[i])
      oldtooltypes[i]:=NIL
    ENDFOR
    SetList(oldtooltypes,n+1)
    do.tooltypes:=oldtooltypes

    IF changed
      ->WriteF('delete tooltype \s \s\n',toolType,key)
      changesMade:=TRUE
    ENDIF
  ENDIF
ENDPROC


EXPORT PROC readToolTypeInt(toolType,key)
  DEF value[255]:STRING
  IF readToolType(toolType,key,value)
    RETURN Val(value)
  ENDIF
ENDPROC -1

EXPORT PROC checkToolTypeExists(toolType,key)
  DEF nodeFile[255]:STRING
  DEF do: PTR TO diskobject
  DEF tooltypes
  DEF s: PTR TO CHAR
  DEF result=FALSE

  s:=NIL

  do:=getOrCreateCacheItem(toolType)
  IF (do)
    tooltypes:=do.tooltypes
    IF tooltypes
      IF(s:=FindToolType(tooltypes,key)) THEN result:=TRUE
    ENDIF
    IF diskObjectCache=NIL THEN FreeDiskObject(do)
  ENDIF
ENDPROC result

EXPORT PROC initialiseCache()
  diskObjectCache:=NEW diskObjectCache.stdlist(100)
  changesMade:=FALSE
ENDPROC

EXPORT PROC deInitialiseCache()
  END diskObjectCache
ENDPROC

PROC freeCacheItem(cacheObj:PTR TO diskObjectCacheItem)
  DEF newtooltypes:PTR TO LONG
  DEF do:PTR TO diskobject
  DEF item:PTR TO LONG
  DEF mem,i

  IF cacheObj.changed
    ->WriteF('saving file and freeing \s\n',cacheObj.fileName)
    PutDiskObject(cacheObj.fileName,cacheObj.diskObject)
  ENDIF

  do:=cacheObj.diskObject
  IF do
    IF do.tooltypes<>cacheObj.originalToolTypes
      newtooltypes:=do.tooltypes
      FOR i:=0 TO ListLen(newtooltypes)-1
        IF newtooltypes[i] THEN DisposeLink(newtooltypes[i])
      ENDFOR
      DisposeLink(newtooltypes)
      do.tooltypes:=cacheObj.originalToolTypes
    ENDIF

    IF cacheObj.ownsToolTypes
      IF do.tooltypes
        mem:=do.tooltypes[0]      -> release the file buffer (first s.tring pointer points to start of buffer)
        Dispose(mem)
        DisposeLink(do.tooltypes)     ->our tooltypes is a list that needs to be freed
      ENDIF
    ENDIF

    DisposeLink(cacheObj.fileName)
    FreeDiskObject(do)
  ENDIF
  END cacheObj

ENDPROC

PROC getOrCreateCacheItem(fileName:PTR TO CHAR,getDef=FALSE)
  DEF i,cnt,found=FALSE
  DEF cacheObj: PTR TO diskObjectCacheItem
  DEF oldCacheObj: PTR TO diskObjectCacheItem
  DEF do=NIL:PTR TO diskobject
  DEF fn2[255]:STRING
  DEF ownToolTypes
  DEF toolTypes:PTR TO LONG
  DEF fh,fileBuf,off,lineCount,len,item
  DEF newValues:PTR TO stringlist

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

  IF found
    ->LRU algorithm, move most recently used to end of list
    i++
    WHILE i<cnt
      diskObjectCache.setItem(i-1,diskObjectCache.item(i))
      i++
    ENDWHILE
    diskObjectCache.setItem(cnt-1,cacheObj)
    item:=diskObjectCache.item(cnt-1)

  ELSE
    do:=GetDiskObject(fileName)
    ownToolTypes:=FALSE
    IF do=NIL
      StringF(fn2,'\s.txt',fileName)
      IF FileLength(fn2)>=0
        StringF(fn2,'\s.cfg',fileName)
        IF FileLength(fn2)>=0
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
    
    IF (do=NIL)
      IF (getDef)
        do:=GetDefDiskObject(WBPROJECT)
        ->WriteF('create new disk obj\n')
      ELSE
        RETURN 0,0
      ENDIF
    ENDIF
    
    IF diskObjectCache<>NIL
      NEW cacheObj

      cacheObj.fileName:=String(StrLen(fileName))
      cacheObj.ownsToolTypes:=ownToolTypes
      IF do
        cacheObj.originalToolTypes:=do.tooltypes
      ELSE
        cacheObj.originalToolTypes:=0
      ENDIF
      StrCopy(cacheObj.fileName,fileName)
      cacheObj.diskObject:=do

      IF diskObjectCache.count()<(diskObjectCache.maxSize()-1)
        diskObjectCache.add(cacheObj)
      ELSE
        freeCacheItem(diskObjectCache.item(0))
        diskObjectCache.remove(0)
        diskObjectCache.add(cacheObj)
      ENDIF
      item:=diskObjectCache.item(diskObjectCache.count()-1)
    ENDIF
  ENDIF
ENDPROC do,item

EXPORT PROC clearDiskObjectCache()
  DEF cacheObj: PTR TO diskObjectCacheItem
  DEF i, do: PTR TO diskobject
  DEF mem
  
  IF diskObjectCache=NIL THEN RETURN
  FOR i:=0 TO diskObjectCache.count()-1
    IF (cacheObj:=diskObjectCache.item(i))
      freeCacheItem(cacheObj)
    ENDIF
  ENDFOR
  diskObjectCache.clear()
ENDPROC

EXPORT PROC deleteFileFromCache(filename:PTR TO CHAR)
  DEF cacheObj: PTR TO diskObjectCacheItem
  DEF i
  
  IF diskObjectCache=NIL THEN RETURN

  FOR i:=diskObjectCache.count()-1 TO 0 STEP -1
    cacheObj:=diskObjectCache.item(i)
    IF StriCmp(filename,cacheObj.fileName) 
      freeCacheItem(cacheObj)
      diskObjectCache.remove(i)
    ENDIF
  ENDFOR
ENDPROC

EXPORT PROC saveCachedChanges()
  DEF cacheObj: PTR TO diskObjectCacheItem
  DEF i
  
  IF diskObjectCache=NIL THEN RETURN
  FOR i:=0 TO diskObjectCache.count()-1
    cacheObj:=diskObjectCache.item(i)
    IF cacheObj.changed
      ->WriteF('saving file \s\n',cacheObj.fileName)
      PutDiskObject(cacheObj.fileName,cacheObj.diskObject)
      cacheObj.changed:=FALSE
    ENDIF
  ENDFOR
ENDPROC

EXPORT PROC clearChangeFlag()
  changesMade:=FALSE
ENDPROC

EXPORT PROC getChangeFlag() IS changesMade
