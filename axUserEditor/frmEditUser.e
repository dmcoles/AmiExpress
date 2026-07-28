OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','dos/dos','libraries/asl','dos/var','dos/datetime'
MODULE 'utility/tagitem' , 'utility/hooks', 'tools/installhook'

MODULE '*frmBase','*axuseredit','*axuserobjects','*/axSetupTool/tooltypes','*/stringlist','*/axSetupTool/miscfuncs'

ENUM PWD_LEGACY=0, PWD_PBKDF2_5=1, PWD_PBKDF2_50=2, PWD_PBKDF2_100=3,PWD_PBKDF2_1000=4,PWD_PBKDF2_10000=5

EXPORT OBJECT frmEditUser OF frmBase
  bbsPath:PTR TO CHAR
  aboutwin:LONG
  selectUser[80]:ARRAY OF CHAR
  btnSaveClickHook: hook
  btnCancelClickHook: hook
  btnLoadClickHook: hook
  btnPrevClickHook: hook
  btnNextClickHook: hook
  btnApplyClickHook: hook
  userData:PTR TO user
  userKeys:PTR TO userKeys
  userMisc:PTR TO userMisc
  computerList:PTR TO LONG
  screenTypesList:PTR TO LONG
  confNameList:PTR TO LONG
  areaList:PTR TO LONG
  presetmenus[10]:ARRAY OF LONG
  presetCycleItems[10]:ARRAY OF LONG
ENDOBJECT

PROC dateTimeToDateStamp(dateVal,datestamp:PTR TO datestamp)
  dateVal:=dateVal-21600

  datestamp.tick:=(dateVal-Mul(Div(dateVal,60),60))
  datestamp.tick:=Mul(datestamp.tick,50)
  dateVal:=Div(dateVal,60)
  datestamp.days:=Div((dateVal),1440)-2922   ->-2922 days between 1/1/70 and 1/1/78
  datestamp.minute:=dateVal-(Mul(datestamp.days+2922,1440))
ENDPROC

PROC formatLongDateTime(cDateVal,outDateStr)
  DEF d : PTR TO datestamp
  DEF dt : datetime
  DEF datestr[10]:STRING
  DEF timestr[10]:STRING
  DEF dateVal

  IF cDateVal=0 
    StringF(outDateStr,'N/A')
    RETURN
  ENDIF
  d:=dt.stamp
  dateTimeToDateStamp(cDateVal,d)

  dt.format:=FORMAT_DOS
  dt.flags:=0
  dt.strday:=0
  dt.strdate:=datestr
  dt.strtime:=timestr

  IF DateToStr(dt)
    StringF(outDateStr,'\s[7]\d\s \s',datestr,IF dt.stamp.days>=8035 THEN 20 ELSE 19,datestr+7,timestr)
    RETURN TRUE
  ENDIF
ENDPROC FALSE

EXPORT PROC convertToBCD(invalue,outArray: PTR TO CHAR)
  DEF shift,i

  FOR i:=0 TO 7
    outArray[i]:=0
  ENDFOR

  FOR shift:=0 TO 31
    FOR i:=0 TO 7
      IF (outArray[i] AND $F0)>=$50 THEN outArray[i]:=outArray[i]+$30
      IF (outArray[i] AND $F)>=$5 THEN outArray[i]:=outArray[i]+$3
    ENDFOR
    FOR i:=0 TO 6
      outArray[i]:=Shl(outArray[i],1)
      IF outArray[i+1] AND $80
        outArray[i]:=outArray[i] OR 1
      ENDIF
    ENDFOR
    outArray[7]:=Shl(outArray[7],1)
    IF (invalue AND $80000000)
      outArray[7]:=outArray[7] OR 1
    ENDIF
    invalue:=Shl(invalue,1)
  ENDFOR
ENDPROC

EXPORT PROC formatBCD(valArrayBCD:PTR TO CHAR, outStr)
  DEF tempStr[2]:STRING
  DEF i,n,start=FALSE

  StrCopy(outStr,'')
  FOR i:=0 TO 7
    n:=valArrayBCD[i]
    IF (n<>0) OR (start) OR (i=7)
      IF (start) OR (n>=$10)
        StringF(tempStr,'\d\d',Shr(n AND $F0,4),n AND $F)
      ELSE
        StringF(tempStr,'\d',n AND $F)
      ENDIF
      StrAdd(outStr,tempStr)
      start:=TRUE
    ENDIF
  ENDFOR
ENDPROC


PROC cancelbuttonPressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  domethod(self.app.app,[MUIM_Application_ReturnID,MUIA_Window_CloseRequest])
ENDPROC

PROC savebuttonPressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  domethod(self.app.app,[MUIM_Application_ReturnID,ID_SAVE])
ENDPROC

PROC loadbuttonPressed() OF frmEditUser
  DEF level
  MOVE.L (A1),self
  GetA4()

  get( self.app.slUserId, MUIA_Slider_Level,{level})
  self.loadUser(level)
ENDPROC

PROC prevbuttonPressed() OF frmEditUser
  DEF level
  MOVE.L (A1),self
  GetA4()

  get(self.app.slUserId, MUIA_Slider_Level,{level})
  IF level>1 THEN set(self.app.slUserId, MUIA_Slider_Level,level-1)
ENDPROC


PROC sliderchanged() OF frmEditUser
  DEF level
  MOVE.L (A1),self
  GetA4()

  get( self.app.slUserId, MUIA_Slider_Level,{level})
  self.getUserName(level)
  set( self.app.txtSelectUserName, MUIA_Text_Contents,self.selectUser)
  set( self.app.txtSelectUserName, MUIA_Weight,30)
ENDPROC

PROC nextbuttonPressed() OF frmEditUser
  DEF level,max
  MOVE.L (A1),self
  GetA4()

  get( self.app.slUserId, MUIA_Slider_Level,{level})
  get( self.app.slUserId, MUIA_Slider_Max,{max})
  IF level<max THEN set(self.app.slUserId, MUIA_Slider_Level,level+1)
ENDPROC

PROC formShow() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
ENDPROC

PROC create(app:PTR TO app_obj) OF frmEditUser
  SUPER self.create(app)
  self.winMain:=app.winUserDetails
ENDPROC

PROC canClose() OF frmEditUser
  MOVE.L (A1),self
  GetA4() 
ENDPROC TRUE

PROC getUserName(userId) OF frmEditUser
  DEF userData:PTR TO user
  DEF fh
  DEF fname[200]:STRING

  NEW userData
  AstrCopy(self.selectUser,'')

  userId--
  StringF(fname,'\suser.data',self.bbsPath)
  fh:=Open(fname,MODE_OLDFILE)
  IF fh
    Seek(fh,userId*SIZEOF user,OFFSET_BEGINNING)
    IF Fread(fh,userData,SIZEOF user,1)=1
      AstrCopy(self.selectUser,userData.name,80)
    ENDIF
    Close(fh)
  ENDIF
  
  END userData
ENDPROC

PROC newUser() OF frmEditUser
  self.loadBBSSetup()

  set( self.app.strUsername, MUIA_Text_Contents,'')

  set( self.app.cyActive, MUIA_Cycle_Active,0)
  set( self.app.strRealname, MUIA_Text_Contents,'')
  set( self.app.strPassword, MUIA_Text_Contents,'')
  set( self.app.strLocation, MUIA_Text_Contents,'')
  set( self.app.strPhone, MUIA_Text_Contents,'')
  set( self.app.cyRejoinConf, MUIA_Cycle_Active,0)
  set( self.app.cySecArea, MUIA_Cycle_Active,0)
  set( self.app.slSecLevel, MUIA_Slider_Level,0)
  set( self.app.strRatio, MUIA_Text_Contents,'')
  set( self.app.cyRatioType, MUIA_Cycle_Active,0)
  set( self.app.strUploads, MUIA_Text_Contents,'0')  
  set( self.app.strDownloads, MUIA_Text_Contents,'0')
  set( self.app.strDownloadBytes, MUIA_Text_Contents,'0')
  set( self.app.strUploadBytes, MUIA_Text_Contents,'0')
  set( self.app.strMessages, MUIA_Text_Contents,'0')
    
    set( self.app.strUploadCPS, MUIA_Text_Contents,'0')

    set( self.app.strDownloadCPS, MUIA_Text_Contents,'0')
    
    set( self.app.strByteLimit, MUIA_Text_Contents,'0')

    set( self.app.strTimeTotal, MUIA_Text_Contents,'0')

    set( self.app.strTimeLimit, MUIA_Text_Contents,'0')

    set( self.app.strChatLimit, MUIA_Text_Contents,'0')

    set( self.app.strTimeUsed, MUIA_Text_Contents,'0')

    set( self.app.strChatUsed, MUIA_Text_Contents,'0')

    set( self.app.cyPwdReset, MUIA_Cycle_Active,1)
    set( self.app.cyAccountLocked, MUIA_Cycle_Active,1)

    set( self.app.strInvalidAttempts, MUIA_Text_Contents,'0')

    set( self.app.cyNewUser,MUIA_Cycle_Active,0)
 
    set( self.app.cyComputers, MUIA_Cycle_Active,0)

    set( self.app.cyScreens, MUIA_Cycle_Active,0)

    set( self.app.strTotalCalls, MUIA_Text_Contents,'0')

    set( self.app.strPwdType, MUIA_Text_Contents,'N/A')

    set( self.app.strCallsToday, MUIA_Text_Contents,'0')

    set( self.app.strLastCalled, MUIA_Text_Contents,'')

    set( self.app.strLastPwdReset, MUIA_Text_Contents,'')
    
    self.applyPreset(1)
    
ENDPROC

PROC freeList(list:PTR TO LONG) OF frmEditUser
  DEF i
  IF list
    i:=0
    WHILE list[i]<>0
      DisposeLink(list[i])
      i++
    ENDWHILE
    Dispose(list)
  ENDIF
ENDPROC

PROC loadAreaNames(confCount) OF frmEditUser
  DEF accessPath[255]:STRING
  DEF areaToolType[255]:STRING
  DEF confToolType[20]:STRING
  DEF dir_info:PTR TO fileinfoblock
  DEF pdir,r,entry,i,n

  DEF confList:PTR TO LONG

  DEF buf[255]:STRING
  DEF parseBuf[100]:STRING
  DEF namesList:PTR TO stringlist

  StringF(accessPath,'\saccess/',self.bbsPath)
 
  IF ((dir_info:=AllocDosObject(DOS_FIB,NIL)) = NIL)
    RETURN 0
  ENDIF
  
  IF ((pdir:=Lock(accessPath,ACCESS_READ)))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    RETURN 0
  ENDIF
  
  IF(Examine(pdir, dir_info))=FALSE
    FreeDosObject(DOS_FIB,dir_info)
    UnLock(pdir)
    RETURN 0
  ENDIF

  IF ParsePatternNoCase('AREA.#?.info',parseBuf,100) =-1 THEN RETURN
  
  NEW namesList.stringlist(20)

  WHILE(ExNext(pdir,dir_info))
    IF(dir_info.direntrytype < 0)

      IF MatchPatternNoCase(parseBuf,dir_info.filename)
        StrCopy(buf,dir_info.filename+5)
        stripInfo(buf)
        namesList.add(buf)
      ENDIF
    ENDIF
  ENDWHILE
   
  UnLock(pdir)
  FreeDosObject(DOS_FIB,dir_info)

  namesList.sort()

  self.freeList(self.areaList)
  self.areaList:=New((namesList.count()+1)*4)

  FOR n:=0 TO namesList.count()-1
    self.areaList[n]:=StrClone(namesList.item(n))
  ENDFOR
  set(self.app.cySecArea,MUIA_Cycle_Entries,self.areaList)

  END namesList
ENDPROC

PROC loadBBSSetup() OF frmEditUser
  DEF toolname[200]:STRING
  DEF toolTypeFile[200]:STRING
  DEF count,i,loop
  DEF tempstring[200]:STRING

  StringF(toolTypeFile,'\sConfConfig',self.bbsPath)
  count:=readToolTypeInt(toolTypeFile,'NCONFS')
  self.freeList(self.confNameList)
  self.confNameList:=New((count+1)*4)
  IF (count>0)
    FOR i:=1 TO count
      StringF(toolname,'NAME.\d',i)
      readToolType(toolTypeFile,toolname,tempstring)
      self.confNameList[i-1]:=StrClone(tempstring)
    ENDFOR
  ENDIF
  set(self.app.cyRejoinConf,MUIA_Cycle_Entries,self.confNameList)

  self.loadAreaNames(count)

  StringF(toolTypeFile,'\sComputerList',self.bbsPath)
  count:=readToolTypeInt(toolTypeFile,'COMPUTER.NUM')
  self.freeList(self.computerList)
  self.computerList:=New((count+1)*4)
  IF (count>0)
    FOR i:=1 TO count
      StringF(toolname,'COMPUTER.\d',i)
      readToolType(toolTypeFile,toolname,tempstring)
      self.computerList[i-1]:=StrClone(tempstring)
    ENDFOR
  ENDIF
  set(self.app.cyComputers,MUIA_Cycle_Entries,self.computerList)

  StringF(toolTypeFile,'\sScreenTypes',self.bbsPath)
  loop:=TRUE
  count:=0
  WHILE (loop)
    StringF(toolname,'TITLE.\d',count+1)
    readToolType(toolTypeFile,toolname,tempstring)
    IF EstrLen(tempstring)>0
      count++   
    ELSE
      loop:=FALSE
    ENDIF
  ENDWHILE

  self.freeList(self.screenTypesList)
  self.screenTypesList:=New((count+1)*4)
  
  IF (count>0)
    FOR i:=1 TO count
      StringF(toolname,'TITLE.\d',i)
      readToolType(toolTypeFile,toolname,tempstring)
      self.screenTypesList[i-1]:=StrClone(tempstring)
    ENDFOR
  ENDIF
  set(self.app.cyScreens,MUIA_Cycle_Entries,self.screenTypesList)
ENDPROC

PROC loadUserData(userId) OF frmEditUser
  DEF result=0
  DEF tempstring[200]:STRING
  DEF fh

  userId--
  
  MemFill(self.userData,SIZEOF user,0)
  MemFill(self.userKeys,SIZEOF userKeys,0)
  MemFill(self.userMisc,SIZEOF userMisc,0)
  
  StringF(tempstring,'\suser.data',self.bbsPath) 
  fh:=Open(tempstring,MODE_OLDFILE)
  IF fh
    Seek(fh,userId*SIZEOF user,OFFSET_BEGINNING)
    result+=Fread(fh,self.userData,SIZEOF user,1)
    Close(fh)
  ENDIF

  StringF(tempstring,'\suser.keys',self.bbsPath) 
  fh:=Open(tempstring,MODE_OLDFILE)
  IF fh
    Seek(fh,userId*SIZEOF userKeys,OFFSET_BEGINNING)
    result+=Fread(fh,self.userKeys,SIZEOF userKeys,1)
    Close(fh)
  ENDIF

  StringF(tempstring,'\suser.misc',self.bbsPath) 
  fh:=Open(tempstring,MODE_OLDFILE)
  IF fh
    Seek(fh,userId*SIZEOF userMisc,OFFSET_BEGINNING)
    result+=Fread(fh,self.userMisc,SIZEOF userMisc,1)
    Close(fh)
  ENDIF
 
ENDPROC result

PROC loadUser(userId) OF frmEditUser
  DEF result=0,i
  DEF tempstring[200]:STRING
   
  result:=self.loadUserData(userId)

  userId--

  IF result=3
  
    self.loadBBSSetup()
  
    AstrCopy(self.selectUser,self.userData.name,80)
    set( self.app.txtSelectUserName, MUIA_Text_Contents,self.selectUser)
    set( self.app.strUsername, MUIA_Text_Contents,self.userData.name)
    set( self.app.cyActive, MUIA_Cycle_Active,IF self.userData.slotNumber=0 THEN 1 ELSE 0)
    set( self.app.strRealname, MUIA_Text_Contents,self.userMisc.realName)
    set( self.app.strPassword, MUIA_Text_Contents,'1234567890')
    set( self.app.strLocation, MUIA_Text_Contents,self.userData.location)
    set( self.app.strPhone, MUIA_Text_Contents,self.userData.phoneNumber)
    set( self.app.cyRejoinConf, MUIA_Cycle_Active,self.userData.confRJoin-1)

    i:=0
    WHILE self.areaList[i]
      IF StriCmp(self.areaList[i],self.userData.conferenceAccess) THEN set( self.app.cySecArea, MUIA_Cycle_Active,i)
      i++
    ENDWHILE
    
    set( self.app.slSecLevel, MUIA_Slider_Level,self.userData.secStatus)
    StringF(tempstring,'\d',self.userData.secLibrary)
    set( self.app.strRatio, MUIA_Text_Contents,tempstring)

    set( self.app.cyRatioType, MUIA_Cycle_Active,self.userData.secBoard)
    StringF(tempstring,'\d',self.userData.uploads)
    set( self.app.strUploads, MUIA_Text_Contents,tempstring)
    
    StringF(tempstring,'\d',self.userData.downloads)
    set( self.app.strDownloads, MUIA_Text_Contents,tempstring)

    IF self.userData.bytesDownload=-1
      formatBCD(self.userMisc.downloadBytesBCD,tempstring)
    ELSE
      StringF(tempstring,'\d',self.userData.bytesDownload)
    ENDIF
    set( self.app.strDownloadBytes, MUIA_Text_Contents,tempstring)

    IF self.userData.bytesUpload=-1
      formatBCD(self.userMisc.uploadBytesBCD,tempstring)
    ELSE
      StringF(tempstring,'\d',self.userData.bytesUpload)
    ENDIF
    set( self.app.strUploadBytes, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.messagesPosted)
    set( self.app.strMessages, MUIA_Text_Contents,tempstring)
    
    StringF(tempstring,'\d',self.userKeys.upCPS2)
    set( self.app.strUploadCPS, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userKeys.dnCPS2)
    set( self.app.strDownloadCPS, MUIA_Text_Contents,tempstring)
    
    StringF(tempstring,'\d',self.userData.dailyBytesLimit)
    set( self.app.strByteLimit, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.timeTotal)
    set( self.app.strTimeTotal, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.timeLimit)
    set( self.app.strTimeLimit, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.chatLimit)
    set( self.app.strChatLimit, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.timeUsed)
    set( self.app.strTimeUsed, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.chatLimit-self.userData.chatRemain)
    set( self.app.strChatUsed, MUIA_Text_Contents,tempstring)

    set( self.app.cyPwdReset, MUIA_Cycle_Active,IF self.userMisc.forcePwdReset=0 THEN 1 ELSE 0)
    set( self.app.cyAccountLocked, MUIA_Cycle_Active,IF self.userMisc.accountLocked=0 THEN 1 ELSE 0)

    StringF(tempstring,'\d',self.userMisc.invalidAttempts)
    set( self.app.strInvalidAttempts, MUIA_Text_Contents,tempstring)

    set( self.app.cyNewUser, MUIA_Cycle_Active,IF self.userData.newUser=0 THEN 1 ELSE 0)
 
    set( self.app.cyComputers, MUIA_Cycle_Active,self.userData.secBulletin)

    set( self.app.cyScreens, MUIA_Cycle_Active,self.userData.screenType)

    StringF(tempstring,'\d',self.userData.timesCalled)
    set( self.app.strTotalCalls, MUIA_Text_Contents,tempstring)

    SELECT self.userMisc.pwdType
      CASE PWD_LEGACY
        StrCopy(tempstring,'LEGACY')
      CASE PWD_PBKDF2_5
        StrCopy(tempstring,'PBKDF2(5)')
      CASE PWD_PBKDF2_50
        StrCopy(tempstring,'PBKDF2(50)')
      CASE PWD_PBKDF2_100
        StrCopy(tempstring,'PBKDF2(100)')
      CASE PWD_PBKDF2_1000
        StrCopy(tempstring,'PBKDF2(1000)')
      CASE PWD_PBKDF2_10000
        StrCopy(tempstring,'PBKDF2(10000)')
    ENDSELECT
    set( self.app.strPwdType, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userKeys.timesOnToday)
    set( self.app.strCallsToday, MUIA_Text_Contents,tempstring)

    formatLongDateTime(self.userData.timeLastOn,tempstring)
    set( self.app.strLastCalled, MUIA_Text_Contents,tempstring)

    formatLongDateTime(self.userMisc.pwdLastUpdated,tempstring)
    set( self.app.strLastPwdReset, MUIA_Text_Contents,tempstring)

  ENDIF
  
ENDPROC

PROC saveUser(userId) OF frmEditUser
  DEF fh,flen,tempval,i
  DEF userdatafname[200]:STRING
  DEF userkeysfname[200]:STRING
  DEF usermiscfname[200]:STRING
  DEF tempstring[100]:STRING
  DEF oldUserData:PTR TO user
  DEF oldUserKeys:PTR TO userKeys
  DEF oldUserMisc:PTR TO userMisc

  StringF(userdatafname,'\suser.data',self.bbsPath)
  StringF(userkeysfname,'\suser.keys',self.bbsPath)
  StringF(usermiscfname,'\suser.misc',self.bbsPath)

  IF userId=-1
   //create new user id
    flen:=FileLength(userdatafname)
    userId:=Div(flen+SIZEOF user-1,SIZEOF user)+1
  ENDIF
  
  NEW oldUserData
  CopyMem(self.userData,oldUserData,SIZEOF user)
  NEW oldUserKeys
  CopyMem(self.userKeys,oldUserKeys,SIZEOF userKeys)
  NEW oldUserMisc
  CopyMem(self.userMisc,oldUserMisc,SIZEOF userMisc)

  self.loadUserData(userId)

  
  get(self.app.strUsername, MUIA_Text_Contents,{tempval})
  
  IF StrCmp(oldUserData.name,tempval)=FALSE
    AstrCopy(self.userData.name,tempval,ARRAYSIZE oldUserData.name)
  ENDIF

  get(self.app.cyActive, MUIA_Cycle_Active,{tempval})
  IF oldUserData.slotNumber<>(IF tempval=1 THEN 0 ELSE userId)
    IF tempval=1 THEN self.userData.slotNumber:=0 ELSE self.userData.slotNumber:=userId
  ENDIF

  get(self.app.strRealname, MUIA_Text_Contents,{tempval})
  IF StrCmp(oldUserMisc.realName,tempval)=FALSE
    AstrCopy(self.userMisc.realName,tempval,ARRAYSIZE oldUserMisc.realName)
  ENDIF
  
  //password
  
  get(self.app.strLocation, MUIA_Text_Contents,{tempval})
  IF StrCmp(oldUserData.location,tempval)=FALSE
    AstrCopy(self.userData.location,tempval,ARRAYSIZE oldUserData.location)
  ENDIF
  
  get(self.app.strPhone, MUIA_Text_Contents,{tempval})
  IF StrCmp(oldUserData.phoneNumber,tempval)=FALSE
    AstrCopy(self.userData.phoneNumber,tempval,ARRAYSIZE oldUserData.phoneNumber)
  ENDIF

  get(self.app.cyRejoinConf, MUIA_Cycle_Active,{tempval})
  IF oldUserData.confRJoin<>(tempval+1)
    self.userData.confRJoin:=tempval+1
  ENDIF

  get(self.app.cySecArea, MUIA_Cycle_Active,{tempval})
  IF StrCmp(oldUserData.conferenceAccess,self.areaList[tempval])=FALSE
    AstrCopy(self.userData.conferenceAccess,self.areaList[tempval],ARRAYSIZE oldUserData.conferenceAccess)
  ENDIF

  get(self.app.slSecLevel, MUIA_Slider_Level,{tempval})
  IF oldUserData.secStatus<>tempval
    self.userData.secStatus:=tempval
  ENDIF

    /*AstrCopy(self.selectUser,self.userData.name,80)
    set( self.app.txtSelectUserName, MUIA_Text_Contents,self.selectUser)
    set( self.app.strUsername, MUIA_Text_Contents,self.userData.name)
    set( self.app.cyActive, MUIA_Cycle_Active,IF self.userData.slotNumber=0 THEN 1 ELSE 0)
    set( self.app.strRealname, MUIA_Text_Contents,self.userMisc.realName)
    set( self.app.strPassword, MUIA_Text_Contents,'1234567890')
    set( self.app.strLocation, MUIA_Text_Contents,self.userData.location)
    set( self.app.strPhone, MUIA_Text_Contents,self.userData.phoneNumber)
    set( self.app.cyRejoinConf, MUIA_Cycle_Active,self.userData.confRJoin-1)

    i:=0
    WHILE self.areaList[i]
      IF StriCmp(self.areaList[i],self.userData.conferenceAccess) THEN set( self.app.cySecArea, MUIA_Cycle_Active,i)
      i++
    ENDWHILE
    
    set( self.app.slSecLevel, MUIA_Slider_Level,self.userData.secStatus)*/
    
    
    get(self.app.strRatio, MUIA_Text_Contents,{tempval})
    IF oldUserData.secLibrary<>Val(tempval)
      self.userData.secLibrary:=Val(tempval)
    ENDIF
    
    get(self.app.cyRatioType, MUIA_Cycle_Active,{tempval})
    IF oldUserData.secBoard<>tempval
      self.userData.secBoard:=tempval
    ENDIF

    get(self.app.strUploads, MUIA_Text_Contents,{tempval})
    IF oldUserData.uploads<>Val(tempval)
      self.userData.uploads:=Val(tempval)
    ENDIF

    get(self.app.strDownloads, MUIA_Text_Contents,{tempval})
    IF oldUserData.downloads<>Val(tempval)
      self.userData.downloads:=Val(tempval)
    ENDIF

    get(self.app.strDownloadBytes, MUIA_Text_Contents,{tempval})
    formatBCD(oldUserMisc.downloadBytesBCD,tempstring)
    IF StrCmp(tempstring,tempval)=FALSE
      convertToBCD(tempval,self.userMisc.downloadBytesBCD)
    ENDIF

    get(self.app.strUploadBytes, MUIA_Text_Contents,{tempval})
    formatBCD(oldUserMisc.uploadBytesBCD,tempstring)
    IF StrCmp(tempstring,tempval)=FALSE
      convertToBCD(tempval,self.userMisc.uploadBytesBCD)
    ENDIF

    get(self.app.strMessages, MUIA_Text_Contents,{tempval})
    IF oldUserData.messagesPosted<>Val(tempval)
      self.userData.messagesPosted:=Val(tempval)
    ENDIF

    get(self.app.strUploadCPS, MUIA_Text_Contents,{tempval})
    IF oldUserKeys.upCPS2<>Val(tempval)
      self.userKeys.upCPS2:=Val(tempval)
    ENDIF

    get(self.app.strDownloadCPS, MUIA_Text_Contents,{tempval})
    IF oldUserKeys.dnCPS2<>Val(tempval)
      self.userKeys.dnCPS2:=Val(tempval)
    ENDIF
    
    /*StringF(tempstring,'\d',self.userData.secLibrary)
    set( self.app.strRatio, MUIA_Text_Contents,tempstring)

    set( self.app.cyRatioType, MUIA_Cycle_Active,self.userData.secBoard)
    
    StringF(tempstring,'\d',self.userData.uploads)
    set( self.app.strUploads, MUIA_Text_Contents,tempstring)
    
    StringF(tempstring,'\d',self.userData.downloads)
    set( self.app.strDownloads, MUIA_Text_Contents,tempstring)

    IF self.userData.bytesDownload=-1
      formatBCD(self.userMisc.downloadBytesBCD,tempstring)
    ELSE
      StringF(tempstring,'\d',self.userData.bytesDownload)
    ENDIF
    set( self.app.strDownloadBytes, MUIA_Text_Contents,tempstring)

    IF self.userData.bytesUpload=-1
      formatBCD(self.userMisc.uploadBytesBCD,tempstring)
    ELSE
      StringF(tempstring,'\d',self.userData.bytesUpload)
    ENDIF
    set( self.app.strUploadBytes, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.messagesPosted)
    set( self.app.strMessages, MUIA_Text_Contents,tempstring)
    
    StringF(tempstring,'\d',self.userKeys.upCPS2)
    set( self.app.strUploadCPS, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userKeys.dnCPS2)
    set( self.app.strDownloadCPS, MUIA_Text_Contents,tempstring)*/
    
    get(self.app.strByteLimit, MUIA_Text_Contents,{tempval})
    IF oldUserData.dailyBytesLimit<>Val(tempval)
      self.userData.dailyBytesLimit:=Val(tempval)
    ENDIF

    get(self.app.strTimeTotal, MUIA_Text_Contents,{tempval})
    IF oldUserData.timeTotal<>Val(tempval)
      self.userData.timeTotal:=Val(tempval)
    ENDIF

    get(self.app.strTimeLimit, MUIA_Text_Contents,{tempval})
    IF oldUserData.timeLimit<>Val(tempval)
      self.userData.timeLimit:=Val(tempval)
    ENDIF
    
    get(self.app.strChatLimit, MUIA_Text_Contents,{tempval})
    IF oldUserData.chatLimit<>Val(tempval)
      self.userData.chatLimit:=Val(tempval)
    ENDIF

    get(self.app.strTimeUsed, MUIA_Text_Contents,{tempval})
    IF oldUserData.timeUsed<>Val(tempval)
      self.userData.timeUsed:=Val(tempval)
    ENDIF

    get(self.app.strChatUsed, MUIA_Text_Contents,{tempval})
    IF (oldUserData.chatLimit-oldUserData.chatRemain)<>Val(tempval)
      self.userData.chatRemain:=self.userData.chatLimit-Val(tempval)
    ENDIF

    get(self.app.cyPwdReset, MUIA_Cycle_Active,{tempval})
    IF (IF oldUserMisc.forcePwdReset=0 THEN 1 ELSE 0)<>tempval
      self.userMisc.forcePwdReset:=IF tempval=0 THEN -1 ELSE 0
    ENDIF

    get(self.app.cyAccountLocked, MUIA_Cycle_Active,{tempval})
    IF (IF oldUserMisc.accountLocked=0 THEN 1 ELSE 0)<>tempval
      self.userMisc.accountLocked:=IF tempval=0 THEN -1 ELSE 0
    ENDIF

    get(self.app.strInvalidAttempts, MUIA_Text_Contents,{tempval})
    IF oldUserMisc.invalidAttempts<>Val(tempval)
      self.userMisc.invalidAttempts:=Val(tempval)
    ENDIF

    /*StringF(tempstring,'\d',self.userData.dailyBytesLimit)
    set( self.app.strByteLimit, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.timeTotal)
    set( self.app.strTimeTotal, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.timeLimit)
    set( self.app.strTimeLimit, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.chatLimit)
    set( self.app.strChatLimit, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.timeUsed)
    set( self.app.strTimeUsed, MUIA_Text_Contents,tempstring)

    StringF(tempstring,'\d',self.userData.chatLimit-self.userData.chatRemain)
    set( self.app.strChatUsed, MUIA_Text_Contents,tempstring)

    set( self.app.cyPwdReset, MUIA_Cycle_Active,IF self.userMisc.forcePwdReset=0 THEN 1 ELSE 0)
    set( self.app.cyAccountLocked, MUIA_Cycle_Active,IF self.userMisc.accountLocked=0 THEN 1 ELSE 0)

    StringF(tempstring,'\d',self.userMisc.invalidAttempts)
    set( self.app.strInvalidAttempts, MUIA_Text_Contents,tempstring)*/

    get(self.app.cyNewUser, MUIA_Cycle_Active,{tempval})
    IF (IF oldUserData.newUser=0 THEN 1 ELSE 0)<>tempval
      self.userData.newUser:=IF tempval=0 THEN -1 ELSE 0
    ENDIF

    get(self.app.cyComputers, MUIA_Cycle_Active,{tempval})
    IF oldUserData.secBulletin<>tempval
      self.userData.secBulletin:=tempval
    ENDIF

    get(self.app.cyScreens, MUIA_Cycle_Active,{tempval})
    IF oldUserData.screenType<>tempval
      self.userData.screenType:=tempval
    ENDIF

  /*
    set( self.app.cyNewUser, MUIA_Cycle_Active,IF self.userData.newUser=0 THEN 1 ELSE 0)
 
    set( self.app.cyComputers, MUIA_Cycle_Active,self.userData.secBulletin)

    set( self.app.cyScreens, MUIA_Cycle_Active,self.userData.screenType)*/
    
  userId--
 
  //save data
  fh:=Open(userdatafname,MODE_READWRITE)
  Seek(fh,userId*SIZEOF user,OFFSET_BEGINNING)
  Fwrite(fh,self.userData,SIZEOF user,1)
  Close(fh)
  
  fh:=Open(userkeysfname,MODE_READWRITE)
  Seek(fh,userId*SIZEOF userKeys,OFFSET_BEGINNING)
  Fwrite(fh,self.userKeys,SIZEOF userKeys,1)
  Close(fh)
  
  fh:=Open(usermiscfname,MODE_READWRITE)
  Seek(fh,userId*SIZEOF userMisc,OFFSET_BEGINNING)
  Fwrite(fh,self.userMisc,SIZEOF userMisc,1)
  Close(fh)

  END oldUserData
  END oldUserKeys
  END oldUserMisc
ENDPROC

PROC makePresetMenuItems() OF frmEditUser
  DEF i
  DEF fn[200]:STRING
  DEF presets:PTR TO LONG
  DEF n
  
  presets:=['Preset 1','Preset 2','Preset 3','Preset 4','Preset 5','Preset 6','Preset 7','Preset 8','Preset 9']
  
  FOR i:=0 TO 8
    StringF(fn,'\sAccess/PRESET.\d.info',self.bbsPath,i+1)
    
    IF FileLength(fn)>0
      self.presetmenus[i]:=MenuitemObject ,
        MUIA_Menuitem_Title , presets[i],
      End
    ENDIF
  ENDFOR 
  n:=0
  FOR i:=0 TO 8
    IF self.presetmenus[i]
      domethod(self.app.mnlabel2ApplyPreset,[MUIM_Family_AddTail,self.presetmenus[i]])
      self.presetCycleItems[n++]:=presets[i]
    ENDIF

    domethod( self.presetmenus[i] , [
      MUIM_Notify , MUIA_Menuitem_Trigger, MUIV_EveryTime,
      self.presetmenus[i],
      3,
      MUIM_CallHook , self.btnApplyClickHook , self ] )

  ENDFOR
  self.presetCycleItems[n++]:=0
  set(self.app.cyPreset,MUIA_Cycle_Entries,self.presetCycleItems)
ENDPROC

PROC removePresetMenuItems() OF frmEditUser
  DEF i
  FOR i:=0 TO 8
    IF self.presetmenus[i]<>0
      domethod(self.app.mnlabel2ApplyPreset,[MUIM_Family_Remove,self.presetmenus[i]])
      Mui_DisposeObject(self.presetmenus[i])
      self.presetmenus[i]:=0
    ENDIF
  ENDFOR
ENDPROC

PROC applypreset1menupressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  self.applyPreset(1)
ENDPROC

PROC applypreset2menupressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  self.applyPreset(2)
ENDPROC

PROC applypreset3menupressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  self.applyPreset(3)
ENDPROC

PROC applypreset4menupressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  self.applyPreset(4)
ENDPROC

PROC applypreset5menupressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  self.applyPreset(5)
ENDPROC

PROC applypreset6menupressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  self.applyPreset(6)
ENDPROC

PROC applypreset7menupressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  self.applyPreset(7)
ENDPROC

PROC applypreset8menupressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  self.applyPreset(8)
ENDPROC

PROC applypreset9menupressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  self.applyPreset(9)
ENDPROC

PROC applypresetbuttonpressed() OF frmEditUser
  DEF preset,component,i
  MOVE.L A2,component
  MOVE.L (A1),self
  GetA4()

  IF component=self.app.btnApply
    get( self.app.cyPreset, MUIA_Cycle_Active,{preset})
    self.applyPreset(preset+1)
  ELSE
    FOR i:=0 TO 8 
      IF component = self.presetmenus[i]
        self.applyPreset(i+1)
      ENDIF
    ENDFOR
  ENDIF
ENDPROC

PROC applyPreset(presetNum) OF frmEditUser
  DEF toolTypeFile[200]:STRING
  DEF tempstring[200]:STRING
  DEF i=0

  StringF(toolTypeFile,'\sAccess/PRESET.\d',self.bbsPath,presetNum)

  readToolType(toolTypeFile,'PRESET.AREA',tempstring)
  WHILE self.areaList[i]
    
    IF StriCmp(tempstring,self.areaList[i]) THEN set(self.app.cySecArea,MUIA_Cycle_Active,i)
    i++
  ENDWHILE
  
  set( self.app.slSecLevel, MUIA_Slider_Level,readToolTypeInt(toolTypeFile,'PRESET.ACCESS'))
  set( self.app.cyRejoinConf,MUIA_Cycle_Active,readToolTypeInt(toolTypeFile,'PRESET.CONFRJOIN')-1)
  //set( self.app.cyRejoinMsgbase,MUIA_Cycle_Active,readToolTypeInt(toolTypeFile,'PRESET.MSGBASERJOIN')-1)
  
  StringF(tempstring,'\d',readToolTypeInt(toolTypeFile,'PRESET.DAILY_BYTE_LIMIT'))
  set( self.app.strByteLimit, MUIA_Text_Contents,tempstring)
  
  set( self.app.cyRatioType, MUIA_Cycle_Active,readToolTypeInt(toolTypeFile,'PRESET.RATIO_TYPE'))

  StringF(tempstring,'\d',readToolTypeInt(toolTypeFile,'PRESET.RATIO'))
  set( self.app.strRatio, MUIA_Text_Contents,tempstring)
  
  StringF(tempstring,'\d',readToolTypeInt(toolTypeFile,'PRESET.TIME_LIMIT'))
  set( self.app.strTimeLimit, MUIA_Text_Contents,tempstring)
ENDPROC

PROC editUser(bbsPath:PTR TO CHAR, userId) OF frmEditUser
  DEF closeHook:PTR TO hook
  DEF showHook:PTR TO hook
  DEF sliderChangeHook:PTR TO hook
  DEF userDataFname[200]:STRING
  DEF res

  NEW closeHook
  NEW showHook
  NEW sliderChangeHook

  NEW self.userData
  NEW self.userKeys
  NEW self.userMisc

  self.bbsPath:=bbsPath

  StringF(userDataFname,'\suser.data',self.bbsPath)

  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  installhook( showHook, {formShow})
  self.showHook:=showHook

  self.aboutwin:=0

  set( self.winMain, MUIA_Window_Title,'Edit User')
  set( self.winMain, MUIA_Window_ID, "AXUE")
  
  set ( self.app.headerPanel,MUIA_ShowMe,MUI_TRUE)
  set ( self.app.headerPanel,MUIA_Slider_Min,1)
  set ( self.app.headerPanel,MUIA_Slider_Max,Div(FileLength(userDataFname),SIZEOF user))
  set ( self.app.headerPanel,MUIA_Slider_Level,userId)
  set ( self.app.mainPanel,MUIA_Group_ActivePage,MUIV_Group_ActivePage_First)

  domethod( self.app.slUserId , [
    MUIM_Notify ,  MUIA_Slider_Level , MUIV_EveryTime ,
    self.app.app,
    3 ,
        MUIM_CallHook , sliderChangeHook, self] )
  installhook( sliderChangeHook, {sliderchanged})

	domethod( self.app.mnlabel2Save , [
		MUIM_Notify , MUIA_Menuitem_Trigger, MUIV_EveryTime,
		self.app.mnlabel2Save,
		3,
    MUIM_CallHook , self.btnSaveClickHook , self ] )

	domethod( self.app.mnlabel2Cancel , [
		MUIM_Notify , MUIA_Menuitem_Trigger, MUIV_EveryTime,
		self.app.mnlabel2Cancel,
		3,
    MUIM_CallHook , self.btnCancelClickHook , self ] )

  self.makePresetMenuItems()
    
  self.setupButtonClick(self.app.btnSave,self.btnSaveClickHook,{savebuttonPressed})
  self.setupButtonClick(self.app.btnCancel,self.btnCancelClickHook,{cancelbuttonPressed})
  self.setupButtonClick(self.app.btnSelectUserLoad,self.btnLoadClickHook,{loadbuttonPressed})
  self.setupButtonClick(self.app.btnSelectUserPrev,self.btnPrevClickHook,{prevbuttonPressed})
  self.setupButtonClick(self.app.btnSelectUserNext,self.btnNextClickHook,{nextbuttonPressed})
  self.setupButtonClick(self.app.btnApply,self.btnApplyClickHook,{applypresetbuttonpressed})

  self.loadUser(userId)

  res:=self.showModal()
  IF res
    self.saveUser(userId)
  ENDIF

  domethod(self.app.btnCancel,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.btnSave,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.btnSelectUserLoad,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.btnSelectUserPrev,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.btnSelectUserNext,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.btnApply,[MUIM_KillNotify,MUIA_Pressed])
  
  domethod(self.app.slUserId,[MUIM_KillNotify,MUIA_Slider_Level])
  domethod(self.app.mnlabel2Save,[MUIM_KillNotify,MUIA_Menuitem_Trigger])
  domethod(self.app.mnlabel2Cancel,[MUIM_KillNotify,MUIA_Menuitem_Trigger])

  domethod(self.app.mnlabel2Cancel,[MUIM_KillNotify,MUIA_Menuitem_Trigger])

  self.removePresetMenuItems()

  self.freeList(self.computerList)
  self.freeList(self.screenTypesList)
  self.freeList(self.confNameList)
  self.freeList(self.areaList)

  END closeHook
  END showHook
  END sliderChangeHook

  END self.userData
  END self.userKeys
  END self.userMisc
ENDPROC res

PROC addUser(bbsPath:PTR TO CHAR) OF frmEditUser
  DEF closeHook:PTR TO hook
  DEF showHook:PTR TO hook
  DEF res

  NEW closeHook
  NEW showHook

  NEW self.userData
  NEW self.userKeys
  NEW self.userMisc

  self.bbsPath:=bbsPath

  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  installhook( showHook, {formShow})
  self.showHook:=showHook

  self.aboutwin:=0

  set( self.winMain, MUIA_Window_Title,'Add New User')
  set( self.winMain, MUIA_Window_ID, "AXUN")
  
  set ( self.app.headerPanel,MUIA_ShowMe,FALSE)
  set ( self.app.mainPanel,MUIA_Group_ActivePage,MUIV_Group_ActivePage_First)

	domethod( self.app.mnlabel2Save , [
		MUIM_Notify , MUIA_Menuitem_Trigger, MUIV_EveryTime,
		self.app.mnlabel2Save,
		3,
    MUIM_CallHook , self.btnSaveClickHook , self ] )

	domethod( self.app.mnlabel2Cancel , [
		MUIM_Notify , MUIA_Menuitem_Trigger, MUIV_EveryTime,
		self.app.mnlabel2Cancel,
		3,
    MUIM_CallHook , self.btnSaveClickHook , self ] )

  self.makePresetMenuItems()
        
  self.setupButtonClick(self.app.btnSave,self.btnSaveClickHook,{savebuttonPressed})
  self.setupButtonClick(self.app.btnCancel,self.btnCancelClickHook,{cancelbuttonPressed})
  self.setupButtonClick(self.app.btnApply,self.btnApplyClickHook,{applypresetbuttonpressed})

  self.newUser()

  res:=self.showModal()
  IF res THEN self.saveUser(-1)

  domethod(self.app.btnSave,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.btnCancel,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.btnApply,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.mnlabel2Save,[MUIM_KillNotify,MUIA_Menuitem_Trigger])
  domethod(self.app.mnlabel2Cancel,[MUIM_KillNotify,MUIA_Menuitem_Trigger])

  self.removePresetMenuItems()

  self.freeList(self.computerList)
  self.freeList(self.screenTypesList)
  self.freeList(self.confNameList)
  self.freeList(self.areaList)

  END closeHook
  END showHook

  END self.userData
  END self.userKeys
  END self.userMisc

ENDPROC res
