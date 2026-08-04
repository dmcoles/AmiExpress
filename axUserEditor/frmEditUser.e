OPT MODULE
OPT PREPROCESS

MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi','dos/dos','libraries/asl','dos/var','dos/datetime'
MODULE 'utility/tagitem' , 'utility/hooks', 'tools/installhook'

MODULE '*frmBase','*frmSetPassword','*axuseredit','*axuserobjects','*/axSetupTool/tooltypes','*/stringlist','*/axSetupTool/miscfuncs','*/pwdHash','*/sha256'

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
  btnSetPasswordClickHook: hook
  controlChangeHook: hook
  userData:PTR TO user
  userKeys:PTR TO userKeys
  userMisc:PTR TO userMisc
  confDbEntries:LONG
  editedConfDbEntries:LONG
  computerList:PTR TO LONG
  screenTypesList:PTR TO LONG
  confNameList:PTR TO LONG
  confDbList:PTR TO LONG
  confDbSharedItems:PTR TO LONG
  areaList:PTR TO LONG
  presetmenus[10]:ARRAY OF LONG
  presetCycleItems[10]:ARRAY OF LONG
  newPassword[80]:ARRAY OF CHAR
  unsavedChanges:CHAR
  userId:INT
  passType:INT
  confCount:INT
  currConf:INT
ENDOBJECT

->returns system time converted to c time format and ticks
EXPORT PROC getSystemTime()
  DEF currDate: datestamp
  DEF startds:PTR TO datestamp

  startds:=DateStamp(currDate)
  ->2922 days between 1/1/70 and 1/1/78

ENDPROC (Mul(Mul(startds.days+2922,1440),60)+(startds.minute*60)+(startds.tick/50))+21600,Mod(startds.tick,50)

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


EXPORT PROC subBCD2(bcdTotal:PTR TO CHAR, bcdValToSub: PTR TO CHAR)
  MOVE.L bcdValToSub,A0
  LEA 8(A0),A0
  MOVE.L bcdTotal,A1
  LEA 8(A1),A1

  SUB.L D0,D0        ->clear X flag

  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
ENDPROC

EXPORT PROC convertFromBCD(inArray:PTR TO CHAR)
  DEF tempBCD[8]:ARRAY
  DEF bcdStr[20]:STRING

  convertToBCD($ffffffff,tempBCD)
  subBCD2(tempBCD,inArray)
  IF ((tempBCD[0] AND $F0)<>0)
    RETURN $ffffffff
  ENDIF
  formatBCD(inArray,bcdStr)
ENDPROC Val(bcdStr)


PROC cancelbuttonPressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  domethod(self.app.app,[MUIM_Application_ReturnID,MUIA_Window_CloseRequest])
ENDPROC

PROC savebuttonPressed() OF frmEditUser
  MOVE.L (A1),self
  GetA4()

  IF self.validateSettings()=FALSE THEN RETURN
  
  domethod(self.app.app,[MUIM_Application_ReturnID,ID_SAVE])
ENDPROC

PROC loadbuttonPressed() OF frmEditUser
  DEF level
  MOVE.L (A1),self
  GetA4()

  IF self.unsavedChanges
    IF self.unsavedChangesWarning()=0 THEN RETURN
  ENDIF

  get( self.app.slUserId, MUIA_Slider_Level,{level})
  self.loadUser(level)
ENDPROC

PROC controlchanged() OF frmEditUser
  MOVE.L (A1),self
  GetA4()
  
  self.unsavedChanges:=TRUE
ENDPROC

PROC prevbuttonPressed() OF frmEditUser
  DEF level
  MOVE.L (A1),self
  GetA4()

  get(self.app.slUserId, MUIA_Slider_Level,{level})
  IF level>1 THEN set(self.app.slUserId, MUIA_Slider_Level,level-1)
ENDPROC

PROC setpasswordbuttonpressed() OF frmEditUser
  DEF frmSetPwd:PTR TO frmSetPassword
  DEF newPassword[80]:STRING
  DEF tempstring[20]:STRING
  MOVE.L (A1),self
  GetA4()
 
  NEW frmSetPwd.create(self.app)

  IF frmSetPwd.setPassword(newPassword)
    AstrCopy(self.newPassword,newPassword)

    SELECT self.passType
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

    self.unsavedChanges:=TRUE
  ENDIF
  END frmSetPwd
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

PROC confbasechanged() OF frmEditUser
  DEF level
  DEF i,cb:PTR TO confBase
  MOVE.L (A1),self
  GetA4()

  self.loadConfBase(FALSE)
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
  
  IF self.unsavedChanges
    IF self.unsavedChangesWarning()=0 THEN RETURN FALSE
  ENDIF

ENDPROC TRUE

PROC unsavedChangesWarning() OF frmEditUser
  IF Mui_RequestA(0,self.winMain,0,'Unsaved changes',
    '*OK|CANCEL','You have unsaved changes,\nif you continue you will lose them.',0)=0 THEN RETURN FALSE
ENDPROC TRUE

PROC updatePassword() OF frmEditUser
  DEF newpass[80]:STRING
  
  StrCopy(newpass,self.newPassword)
  IF EstrLen(newpass)>0
    
    self.userMisc.pwdType:=self.passType
    SELECT self.passType
      CASE PWD_LEGACY
        UpperStr(newpass)
        self.userData.pwdHash:=calcPasswordHash(newpass)
        MemFill(self.userMisc.pwdHash,32,0)
      CASE PWD_PBKDF2_5
        calcPasswordSalt(self.userMisc.salt)
        pkcs5_pbkdf2(newpass,StrLen(newpass), self.userMisc.salt,8, self.userMisc.pwdHash, 32, 5)
        self.userData.pwdHash:=-1
      CASE PWD_PBKDF2_50
        calcPasswordSalt(self.userMisc.salt)
        pkcs5_pbkdf2(newpass,StrLen(newpass), self.userMisc.salt,8, self.userMisc.pwdHash, 32, 50)
        self.userData.pwdHash:=-1
      CASE PWD_PBKDF2_100
        calcPasswordSalt(self.userMisc.salt)
        pkcs5_pbkdf2(newpass,StrLen(newpass), self.userMisc.salt,8, self.userMisc.pwdHash, 32, 100)
        self.userData.pwdHash:=-1
      CASE PWD_PBKDF2_1000
        calcPasswordSalt(self.userMisc.salt)
        pkcs5_pbkdf2(newpass,StrLen(newpass), self.userMisc.salt,8, self.userMisc.pwdHash, 32, 1000)
        self.userData.pwdHash:=-1
      CASE PWD_PBKDF2_10000
        calcPasswordSalt(self.userMisc.salt)
        pkcs5_pbkdf2(newpass,StrLen(newpass), self.userMisc.salt,8, self.userMisc.pwdHash, 32, 10000)
        self.userData.pwdHash:=-1
    ENDSELECT
    self.userMisc.pwdLastUpdated:=getSystemTime()
  ENDIF
ENDPROC

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
  DEF i,cb:PTR TO confBase

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

  set( self.app.strCbRatio, MUIA_Text_Contents,'')
  set( self.app.cyCbRatioType, MUIA_Cycle_Active,0)
  set( self.app.strCbUploads, MUIA_Text_Contents,'0')  
  set( self.app.strCbDownloads, MUIA_Text_Contents,'0')
  set( self.app.strCbDownloadBytes, MUIA_Text_Contents,'0')
  set( self.app.strCbUploadBytes, MUIA_Text_Contents,'0')
  set( self.app.strCbMessages, MUIA_Text_Contents,'0')
  
  set ( self.app.cyCbConf,MUIA_Cycle_Active,0)
  self.currConf:=0

  self.loadConfBase(TRUE)

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
  DEF toolTypeFile2[200]:STRING  
  DEF count,i,loop,n
  DEF tempstring[200]:STRING

  StringF(toolTypeFile,'\sConfConfig',self.bbsPath)

  count:=readToolTypeInt(toolTypeFile,'NCONFS')
  self.confCount:=count
  self.freeList(self.confNameList)
  self.freeList(self.confDbList)
  Dispose(self.confDbEntries)
  Dispose(self.editedConfDbEntries)
  Dispose(self.confDbSharedItems)

  self.confNameList:=New((count+1)*4)
  self.confDbList:=New((count+1)*4)
  self.confDbEntries:=New(count*SIZEOF confBase)
  self.editedConfDbEntries:=New(count*SIZEOF confBase)
  self.confDbSharedItems:=New(count*4)
  IF (count>0)
    FOR i:=1 TO count
      StringF(toolname,'NAME.\d',i)
      readToolType(toolTypeFile,toolname,tempstring)
      self.confNameList[i-1]:=StrClone(tempstring)

      StringF(toolTypeFile2,'\sConf\d',self.bbsPath,i)
      StringF(toolname,'CONFDB_SHARED')
      n:=readToolTypeInt(toolTypeFile2,toolname)
      IF n<=0
        StringF(toolname,'LOCATION.\d',i)
        readToolType(toolTypeFile,toolname,tempstring)
        StrAdd(tempstring,'Conf.DB')
        self.confDbList[i-1]:=StrClone(tempstring)
      ELSE
        self.confDbList[i-1]:=''
      ENDIF
      self.confDbSharedItems[i-1]:=n
    ENDFOR
  ENDIF
  set(self.app.cyRejoinConf,MUIA_Cycle_Entries,self.confNameList)
  set(self.app.cyCbConf,MUIA_Cycle_Entries,self.confNameList)

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
  set(self.app.cyComputers,MUIA_Disabled,count=0)

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
  set(self.app.cyScreens,MUIA_Disabled,count=0)

  StringF(toolTypeFile,'\sBBSConfig',self.bbsPath)
  readToolType(toolTypeFile,'PASSWORD_SECURITY',tempstring)
  IF StriCmp(tempstring,'LEGACY')
    self.passType:=PWD_LEGACY
  ELSEIF StriCmp(tempstring,'PBKDF2_5')
    self.passType:=PWD_PBKDF2_5
  ELSEIF StriCmp(tempstring,'PBKDF2_50')
    self.passType:=PWD_PBKDF2_50
  ELSEIF StriCmp(tempstring,'PBKDF2_100')
    self.passType:=PWD_PBKDF2_100
  ELSEIF StriCmp(tempstring,'PBKDF2_1000')
    self.passType:=PWD_PBKDF2_1000
  ELSEIF StriCmp(tempstring,'PBKDF2_10000')
    self.passType:=PWD_PBKDF2_10000
  ELSE
    self.passType:=PWD_LEGACY
  ENDIF
ENDPROC

PROC loadUserData(userId) OF frmEditUser
  DEF result=0
  DEF tempstring[200]:STRING
  DEF fh,i
  DEF cb:PTR TO confBase

  userId--
  
  MemFill(self.userData,SIZEOF user,0)
  MemFill(self.userKeys,SIZEOF userKeys,0)
  MemFill(self.userMisc,SIZEOF userMisc,0)
  MemFill(self.confDbEntries,SIZEOF confBase*self.confCount,0)
  
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
  
  FOR i:=0 TO self.confCount-1
    //only load the ones that are not shared
    IF self.confDbSharedItems[i]<=0
      fh:=Open(self.confDbList[i],MODE_OLDFILE)
      IF fh
        Seek(fh,userId*SIZEOF confBase,OFFSET_BEGINNING)
        result+=Fread(fh,self.confDbEntries+(i*SIZEOF confBase),SIZEOF confBase,1)
        Close(fh)
      ENDIF
    ENDIF
  ENDFOR
  
ENDPROC result

PROC loadUser(userId) OF frmEditUser
  DEF result=0,i
  DEF tempstring[200]:STRING
  DEF cb:PTR TO confBase
   
  result:=self.loadUserData(userId)

  userId--

  IF result=(3+self.confCount)
  
    CopyMem(self.confDbEntries,self.editedConfDbEntries,SIZEOF confBase*self.confCount)

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

  set ( self.app.cyCbConf,MUIA_Cycle_Active,0)
  self.currConf:=0
  self.loadConfBase(TRUE)

  self.unsavedChanges:=FALSE
  
ENDPROC

PROC showControlError(control,page,errorText:PTR TO CHAR) OF frmEditUser
    set ( self.app.mainPanel,MUIA_Group_ActivePage,page)
    set ( self.winMain,MUIA_Window_ActiveObject,control)
    Mui_RequestA(0,self.winMain,0,'Error','*OK',errorText,0)
ENDPROC

PROC validateNumber(control) OF frmEditUser
  DEF tempstr[200]:STRING
  DEF i,tempval:PTR TO CHAR
  
  get(control, MUIA_Text_Contents,{tempval})
  fullTrim(tempval,tempstr)
  
  FOR i:=0 TO EstrLen(tempstr)-1
    IF NOT(tempstr[i]==["0" TO "9"]) THEN RETURN FALSE
  ENDFOR
ENDPROC TRUE

PROC checkDuplicateUser(userName:PTR TO CHAR) OF frmEditUser
  DEF userData:PTR TO user
  DEF fh
  DEF fname[200]:STRING
  DEF dupe=FALSE

  NEW userData

  StringF(fname,'\suser.data',self.bbsPath)
  fh:=Open(fname,MODE_OLDFILE)
  IF fh
    IF Fread(fh,userData,SIZEOF user,1)=1
      IF StrCmp(userName,userData.name,SIZEOF userData.name) AND (userData.slotNumber<>0) AND (userData.slotNumber<>self.userId) THEN dupe:=TRUE
    ENDIF
    Close(fh)
  ENDIF
  
  END userData
ENDPROC dupe

PROC validateSettings() OF frmEditUser
  DEF tempval,r,l
  
  get(self.app.strUsername, MUIA_Text_Contents,{tempval})
  IF StrLen(tempval)=0
    self.showControlError(self.app.strUsername,0,'UserName cannot be blank.')
    RETURN FALSE
  ENDIF
  
  IF self.checkDuplicateUser(tempval)<>0
    self.showControlError(self.app.strUsername,0,'UserName is already in use.')
    RETURN FALSE
  ENDIF
  
  IF (self.userId=-1) AND (StrLen(self.newPassword)=0)
    self.showControlError(self.app.strRatio,0,'You must set a password for the new user.')
    RETURN FALSE
  ENDIF
  
  IF self.validateNumber(self.app.strRatio)=FALSE
    self.showControlError(self.app.strRatio,1,'Ratio is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strUploads)=FALSE
    self.showControlError(self.app.strUploads,1,'Uploads is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strDownloads)=FALSE
    self.showControlError(self.app.strDownloads,1,'Downloads is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strUploadBytes)=FALSE
    self.showControlError(self.app.strDownloads,1,'Bytes U/L is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strDownloadBytes)=FALSE
    self.showControlError(self.app.strDownloads,1,'Bytes D/L is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strMessages)=FALSE
    self.showControlError(self.app.strMessages,1,'Messages Posted is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strUploadCPS)=FALSE
    self.showControlError(self.app.strUploadCPS,1,'CPS Up is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strDownloadCPS)=FALSE
    self.showControlError(self.app.strDownloadCPS,1,'CPS Down is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strByteLimit)=FALSE
    self.showControlError(self.app.strByteLimit,2,'Byte Limit is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strTimeTotal)=FALSE
    self.showControlError(self.app.strTimeTotal,2,'Time Total is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strTimeLimit)=FALSE
    self.showControlError(self.app.strTimeLimit,2,'Time Limit is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strChatLimit)=FALSE
    self.showControlError(self.app.strChatLimit,2,'Chat Limit is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strTimeUsed)=FALSE
    self.showControlError(self.app.strTimeUsed,2,'Time Used is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strChatUsed)=FALSE
    self.showControlError(self.app.strChatUsed,2,'Chat Used is not a valid value.')
    RETURN FALSE
  ENDIF

  IF self.validateNumber(self.app.strInvalidAttempts)=FALSE
    self.showControlError(self.app.strInvalidAttempts,2,'Invalid Attempts is not a valid value.')
    RETURN FALSE
  ENDIF
ENDPROC TRUE


/*PROC dumpcb(title:PTR TO CHAR,cb:PTR TO confBase) OF frmEditUser
  DEF i
  WriteF(title)
  FOR i:=0 TO self.confCount-1
    WriteF('cb \d downbytes = \d\n',i,cb.bytesDownload)
  ENDFOR
ENDPROC*/

PROC saveCurrentConfBase() OF frmEditUser
  DEF tempval
  DEF editedConfBase:PTR TO confBase

  editedConfBase:=self.editedConfDbEntries+(SIZEOF confBase*self.currConf)
 
  get(self.app.strCbDownloadBytes, MUIA_Text_Contents,{tempval})
  formatBCD(editedConfBase.downloadBytesBCD,tempval)
  editedConfBase.bytesDownload:=convertFromBCD(editedConfBase.downloadBytesBCD)

  get(self.app.strCbUploadBytes, MUIA_Text_Contents,{tempval})
  formatBCD(editedConfBase.uploadBytesBCD,tempval)
  editedConfBase.bytesUpload:=convertFromBCD(editedConfBase.uploadBytesBCD)

  get(self.app.strCbUploads, MUIA_Text_Contents,{tempval})
  editedConfBase.upload:=Val(tempval)

  get(self.app.strCbDownloads, MUIA_Text_Contents,{tempval})
  editedConfBase.downloads:=Val(tempval)

  get(self.app.strCbRatio, MUIA_Text_Contents,{tempval})
  editedConfBase.ratio:=Val(tempval)
      
  get(self.app.cyCbRatioType, MUIA_Cycle_Active,{tempval})
  editedConfBase.ratioType:=tempval

  get(self.app.strCbMessages, MUIA_Text_Contents,{tempval})
  editedConfBase.messagesPosted:=Val(tempval)
ENDPROC

PROC loadConfBase(firstTime) OF frmEditUser
  DEF tempstring[200]:STRING
  DEF temp
  DEF tempval
  DEF editedConfBase:PTR TO confBase

  temp:=self.unsavedChanges
  
  IF firstTime=FALSE THEN self.saveCurrentConfBase()
    
  get(self.app.cyCbConf, MUIA_Cycle_Active,{tempval})
  editedConfBase:=self.editedConfDbEntries+(SIZEOF confBase*tempval)
  self.currConf:=tempval;

  IF editedConfBase.bytesDownload=-1
    formatBCD(editedConfBase.downloadBytesBCD,tempstring)
  ELSE
    StringF(tempstring,'\d',editedConfBase.bytesDownload)
  ENDIF
  set( self.app.strCbDownloadBytes, MUIA_Text_Contents,tempstring)

  IF editedConfBase.bytesUpload=-1
    formatBCD(editedConfBase.uploadBytesBCD,tempstring)
  ELSE
    StringF(tempstring,'\d',editedConfBase.bytesUpload)
  ENDIF
  set( self.app.strCbUploadBytes, MUIA_Text_Contents,tempstring)

  StringF(tempstring,'\d',editedConfBase.upload)
  set( self.app.strCbUploads, MUIA_Text_Contents,tempstring)

  StringF(tempstring,'\d',editedConfBase.downloads)
  set( self.app.strCbDownloads, MUIA_Text_Contents,tempstring)

  StringF(tempstring,'\d',editedConfBase.ratio)
  set( self.app.strCbRatio, MUIA_Text_Contents,tempstring)
   
  StringF(tempstring,'\d',editedConfBase.messagesPosted)
  set( self.app.strCbMessages, MUIA_Text_Contents,tempstring)

  set(self.app.cyCbRatioType, MUIA_Cycle_Active,editedConfBase.ratioType)

  self.unsavedChanges:=temp
ENDPROC


PROC saveUser(userId) OF frmEditUser
  DEF fh,flen,tempval,i
  DEF userdatafname[200]:STRING
  DEF userkeysfname[200]:STRING
  DEF usermiscfname[200]:STRING
  DEF tempstring[100]:STRING
  DEF tempstring2[100]:STRING
  DEF oldUserData:PTR TO user
  DEF oldUserKeys:PTR TO userKeys
  DEF oldUserMisc:PTR TO userMisc
  DEF oldConfBases
  DEF newUser=FALSE
  DEF oldConfBase:PTR TO confBase
  DEF newConfBase:PTR TO confBase
  DEF editedConfBase:PTR TO confBase

  StringF(userdatafname,'\suser.data',self.bbsPath)
  StringF(userkeysfname,'\suser.keys',self.bbsPath)
  StringF(usermiscfname,'\suser.misc',self.bbsPath)

  IF userId=-1
   //create new user id
    flen:=FileLength(userdatafname)
    userId:=Div(flen+SIZEOF user-1,SIZEOF user)+1
    newUser:=TRUE
  ENDIF
  
  NEW oldUserData
  NEW oldUserKeys
  NEW oldUserMisc
  oldConfBases:=New(self.confCount*SIZEOF confBase)
  
  IF newUser=FALSE
    CopyMem(self.userData,oldUserData,SIZEOF user)
    CopyMem(self.userKeys,oldUserKeys,SIZEOF userKeys)
    CopyMem(self.userMisc,oldUserMisc,SIZEOF userMisc)
    CopyMem(self.confDbEntries,oldConfBases,self.confCount*SIZEOF confBase)
  ENDIF

  self.loadUserData(userId)
  
  get(self.app.strUsername, MUIA_Text_Contents,{tempval})
  
  IF StrCmp(oldUserData.name,tempval)=FALSE
    AstrCopy(self.userData.name,tempval,ARRAYSIZE oldUserData.name)
  ENDIF
  
  StrCopy(tempstring,tempval)
  UpperStr(tempstring)
  IF StrCmp(oldUserKeys.userName,tempstring)=FALSE
    AstrCopy(self.userKeys.userName,tempstring,ARRAYSIZE oldUserKeys.userName)
  ENDIF

  get(self.app.cyActive, MUIA_Cycle_Active,{tempval})
  IF oldUserData.slotNumber<>(IF tempval=1 THEN 0 ELSE userId)
    self.userData.slotNumber:=IF tempval=1 THEN 0 ELSE userId
  ENDIF

  IF oldUserKeys.number<>(IF tempval=1 THEN 0 ELSE userId)
    self.userKeys.number:=IF tempval=1 THEN 0 ELSE userId
  ENDIF

  get(self.app.strRealname, MUIA_Text_Contents,{tempval})
  IF StrCmp(oldUserMisc.realName,tempval)=FALSE
    AstrCopy(self.userMisc.realName,tempval,ARRAYSIZE oldUserMisc.realName)
  ENDIF
   
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
    formatBCD(self.userMisc.downloadBytesBCD,tempval)
    self.userData.bytesDownload:=convertFromBCD(self.userMisc.downloadBytesBCD)
  ENDIF

  get(self.app.strUploadBytes, MUIA_Text_Contents,{tempval})
  formatBCD(oldUserMisc.uploadBytesBCD,tempstring)
  IF StrCmp(tempstring,tempval)=FALSE
    formatBCD(self.userMisc.uploadBytesBCD,tempval)
    self.userData.bytesUpload:=convertFromBCD(self.userMisc.uploadBytesBCD)
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


  self.saveCurrentConfBase()
  
  FOR i:=0 TO self.confCount-1
    //only update the ones that are not shared
    IF self.confDbSharedItems[i]<=0
      editedConfBase:=self.editedConfDbEntries+(SIZEOF confBase*i)
      oldConfBase:=oldConfBases+(SIZEOF confBase*i)
      newConfBase:=self.confDbEntries+(SIZEOF confBase*i)

      IF StrCmp(oldConfBase.handle,editedConfBase.handle)=FALSE
        AstrCopy(newConfBase.handle,tempval,ARRAYSIZE oldConfBase.handle)
      ENDIF

      formatBCD(editedConfBase.downloadBytesBCD,tempstring2)
      formatBCD(oldConfBase.downloadBytesBCD,tempstring)
      IF StrCmp(tempstring,tempstring2)=FALSE
        CopyMem(editedConfBase.downloadBytesBCD,newConfBase.downloadBytesBCD,ARRAYSIZE oldConfBase.downloadBytesBCD)
        newConfBase.bytesDownload:=convertFromBCD(newConfBase.downloadBytesBCD)
      ENDIF

      formatBCD(editedConfBase.uploadBytesBCD,tempstring2)
      formatBCD(oldConfBase.uploadBytesBCD,tempstring)
      IF StrCmp(tempstring,tempstring2)=FALSE
        CopyMem(editedConfBase.uploadBytesBCD,newConfBase.uploadBytesBCD,ARRAYSIZE oldConfBase.uploadBytesBCD)
        newConfBase.bytesUpload:=convertFromBCD(newConfBase.uploadBytesBCD)
      ENDIF

      IF oldConfBase.upload<>editedConfBase.upload
        newConfBase.upload:=editedConfBase.upload
      ENDIF

      IF oldConfBase.downloads<>editedConfBase.downloads
        newConfBase.downloads:=editedConfBase.downloads
      ENDIF

      IF oldConfBase.ratio<>editedConfBase.ratio
        newConfBase.ratio:=editedConfBase.ratio
      ENDIF
      
      IF oldConfBase.ratioType<>editedConfBase.ratioType
        newConfBase.ratioType:=editedConfBase.ratioType
      ENDIF

      IF oldConfBase.messagesPosted<>editedConfBase.messagesPosted
        newConfBase.messagesPosted:=editedConfBase.messagesPosted
      ENDIF
    ENDIF
  ENDFOR


  self.updatePassword()
   
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

  FOR i:=0 TO self.confCount-1
    //only save the ones that are not shared
    IF self.confDbSharedItems[i]<=0
      fh:=Open(self.confDbList[i],MODE_READWRITE)
      IF fh
        Seek(fh,userId*SIZEOF confBase,OFFSET_BEGINNING)
        Fwrite(fh,self.confDbEntries+(i*SIZEOF confBase),SIZEOF confBase,1)
        Close(fh)
      ENDIF
    ENDIF
  ENDFOR


  self.unsavedChanges:=FALSE

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
  DEF ratio,ratioType
  DEF cb:PTR TO confBase
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
  
  ratioType:=readToolTypeInt(toolTypeFile,'PRESET.RATIO_TYPE')
  set( self.app.cyRatioType, MUIA_Cycle_Active,ratioType)

  ratio:=readToolTypeInt(toolTypeFile,'PRESET.RATIO')
  StringF(tempstring,'\d',ratio)
  set( self.app.strRatio, MUIA_Text_Contents,tempstring)
  
  StringF(tempstring,'\d',readToolTypeInt(toolTypeFile,'PRESET.TIME_LIMIT'))
  set( self.app.strTimeLimit, MUIA_Text_Contents,tempstring)
  
  FOR i:=0 TO self.confCount-1
    cb:=self.editedConfDbEntries+(i*SIZEOF confBase)

    cb.ratio:=ratio
    cb.ratioType:=ratioType

    StringF(tempstring,'\d',ratio)
    set( self.app.strCbRatio, MUIA_Text_Contents,tempstring)

    set( self.app.cyCbRatioType, MUIA_Cycle_Active,ratioType)

  ENDFOR
ENDPROC

PROC setupStrControlChangeNotify(control) OF frmEditUser
  domethod( control , [
    MUIM_Notify , MUIA_Text_Contents, MUIV_EveryTime,
    control,
    3,
    MUIM_CallHook , self.controlChangeHook , self ] )
ENDPROC

PROC setupCycleControlChangeNotify(control) OF frmEditUser
  domethod( control , [
    MUIM_Notify , MUIA_Cycle_Active, MUIV_EveryTime,
    control,
    3,
    MUIM_CallHook , self.controlChangeHook , self ] )
ENDPROC

PROC setupSliderControlChangeNotify(control) OF frmEditUser
  domethod( control , [
    MUIM_Notify , MUIA_Slider_Level, MUIV_EveryTime,
    control,
    3,
    MUIM_CallHook , self.controlChangeHook , self ] )
ENDPROC

PROC setupControlChangeNotify() OF frmEditUser  
  installhook( self.controlChangeHook, {controlchanged})
    
  self.setupStrControlChangeNotify(self.app.strUsername)
  self.setupCycleControlChangeNotify(self.app.cyActive)
  self.setupStrControlChangeNotify(self.app.strRealname)
  self.setupStrControlChangeNotify(self.app.strPassword)
  self.setupStrControlChangeNotify(self.app.strLocation)
  self.setupStrControlChangeNotify(self.app.strPhone)
  self.setupCycleControlChangeNotify(self.app.cyRejoinConf)
  self.setupCycleControlChangeNotify(self.app.cySecArea)
  self.setupSliderControlChangeNotify(self.app.slSecLevel)
  self.setupStrControlChangeNotify(self.app.strRatio)
  self.setupCycleControlChangeNotify(self.app.cyRatioType)
  self.setupStrControlChangeNotify(self.app.strUploads)
  self.setupStrControlChangeNotify(self.app.strDownloads)
  self.setupStrControlChangeNotify(self.app.strDownloadBytes)
  self.setupStrControlChangeNotify(self.app.strUploadBytes)
  self.setupStrControlChangeNotify(self.app.strMessages)  
  self.setupStrControlChangeNotify(self.app.strUploadCPS)
  self.setupStrControlChangeNotify(self.app.strDownloadCPS)
  self.setupStrControlChangeNotify(self.app.strByteLimit)
  self.setupStrControlChangeNotify(self.app.strTimeTotal)
  self.setupStrControlChangeNotify(self.app.strTimeLimit)
  self.setupStrControlChangeNotify(self.app.strChatLimit)
  self.setupStrControlChangeNotify(self.app.strTimeUsed)
  self.setupStrControlChangeNotify(self.app.strChatUsed)
  self.setupCycleControlChangeNotify(self.app.cyPwdReset)
  self.setupCycleControlChangeNotify(self.app.cyAccountLocked)
  self.setupStrControlChangeNotify(self.app.strInvalidAttempts)
  self.setupCycleControlChangeNotify(self.app.cyNewUser)
  self.setupCycleControlChangeNotify(self.app.cyComputers)
  self.setupCycleControlChangeNotify(self.app.cyScreens)

  self.setupCycleControlChangeNotify(self.app.strCbDownloadBytes)
  self.setupCycleControlChangeNotify(self.app.strCbUploadBytes)
  self.setupCycleControlChangeNotify(self.app.strCbUploads)
  self.setupCycleControlChangeNotify(self.app.strCbDownloads)
  self.setupCycleControlChangeNotify(self.app.strCbRatio)
  self.setupCycleControlChangeNotify(self.app.cyCbRatioType)
  self.setupCycleControlChangeNotify(self.app.strCbMessages)
ENDPROC

PROC clearStrControlChangeNotify(control) OF frmEditUser
  domethod(control,[MUIM_KillNotify,MUIA_Text_Contents])
ENDPROC

PROC clearCycleControlChangeNotify(control) OF frmEditUser
  domethod(control,[MUIM_KillNotify,MUIA_Cycle_Active])
ENDPROC

PROC clearSliderControlChangeNotify(control) OF frmEditUser
  domethod(control,[MUIM_KillNotify,MUIA_Slider_Level])
ENDPROC

PROC clearControlChangeNotify() OF frmEditUser
  self.clearStrControlChangeNotify(self.app.strUsername)
  self.clearCycleControlChangeNotify(self.app.cyActive)
  self.clearStrControlChangeNotify(self.app.strRealname)
  self.clearStrControlChangeNotify(self.app.strPassword)
  self.clearStrControlChangeNotify(self.app.strLocation)
  self.clearStrControlChangeNotify(self.app.strPhone)
  self.clearCycleControlChangeNotify(self.app.cyRejoinConf)
  self.clearCycleControlChangeNotify(self.app.cySecArea)
  self.clearSliderControlChangeNotify(self.app.slSecLevel)
  self.clearStrControlChangeNotify(self.app.strRatio)
  self.clearCycleControlChangeNotify(self.app.cyRatioType)
  self.clearStrControlChangeNotify(self.app.strUploads)
  self.clearStrControlChangeNotify(self.app.strDownloads)
  self.clearStrControlChangeNotify(self.app.strDownloadBytes)
  self.clearStrControlChangeNotify(self.app.strUploadBytes)
  self.clearStrControlChangeNotify(self.app.strMessages)  
  self.clearStrControlChangeNotify(self.app.strUploadCPS)
  self.clearStrControlChangeNotify(self.app.strDownloadCPS)
  self.clearStrControlChangeNotify(self.app.strByteLimit)
  self.clearStrControlChangeNotify(self.app.strTimeTotal)
  self.clearStrControlChangeNotify(self.app.strTimeLimit)
  self.clearStrControlChangeNotify(self.app.strChatLimit)
  self.clearStrControlChangeNotify(self.app.strTimeUsed)
  self.clearStrControlChangeNotify(self.app.strChatUsed)
  self.clearCycleControlChangeNotify(self.app.cyPwdReset)
  self.clearCycleControlChangeNotify(self.app.cyAccountLocked)
  self.clearStrControlChangeNotify(self.app.strInvalidAttempts)
  self.clearCycleControlChangeNotify(self.app.cyNewUser)
  self.clearCycleControlChangeNotify(self.app.cyComputers)
  self.clearCycleControlChangeNotify(self.app.cyScreens)
  
  self.clearCycleControlChangeNotify(self.app.strCbDownloadBytes)
  self.clearCycleControlChangeNotify(self.app.strCbUploadBytes)
  self.clearCycleControlChangeNotify(self.app.strCbUploads)
  self.clearCycleControlChangeNotify(self.app.strCbDownloads)
  self.clearCycleControlChangeNotify(self.app.strCbRatio)
  self.clearCycleControlChangeNotify(self.app.cyCbRatioType)
  self.clearCycleControlChangeNotify(self.app.strCbMessages)
  
ENDPROC

PROC editUser(bbsPath:PTR TO CHAR, userId) OF frmEditUser
  DEF closeHook:PTR TO hook
  DEF showHook:PTR TO hook
  DEF sliderChangeHook:PTR TO hook
  DEF confbaseChangeHook:PTR TO hook
  DEF userDataFname[200]:STRING
  DEF res

  NEW closeHook
  NEW showHook
  NEW sliderChangeHook
  NEW confbaseChangeHook

  NEW self.userData
  NEW self.userKeys
  NEW self.userMisc

  self.bbsPath:=bbsPath
  self.unsavedChanges:=FALSE
  self.userId:=userId
  AstrCopy(self.newPassword,'')

  self.loadBBSSetup()

  StringF(userDataFname,'\suser.data',self.bbsPath)

  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  installhook( showHook, {formShow})
  self.showHook:=showHook

  self.aboutwin:=0

  set( self.winMain, MUIA_Window_Title,'Edit User')
  set( self.winMain, MUIA_Window_ID, "AXUE")
  set ( self.winMain,MUIA_Window_ActiveObject,self.app.strUsername)
  
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

	domethod( self.app.cyCbConf , [
		MUIM_Notify , MUIA_Cycle_Active, MUIV_EveryTime,
		self.app.cyCbConf,
		3,
    MUIM_CallHook , confbaseChangeHook , self ] )
  installhook( confbaseChangeHook, {confbasechanged})

  self.makePresetMenuItems()
  self.setupControlChangeNotify()
  
  self.setupButtonClick(self.app.btnSave,self.btnSaveClickHook,{savebuttonPressed})
  self.setupButtonClick(self.app.btnCancel,self.btnCancelClickHook,{cancelbuttonPressed})
  self.setupButtonClick(self.app.btnSelectUserLoad,self.btnLoadClickHook,{loadbuttonPressed})
  self.setupButtonClick(self.app.btnSelectUserPrev,self.btnPrevClickHook,{prevbuttonPressed})
  self.setupButtonClick(self.app.btnSelectUserNext,self.btnNextClickHook,{nextbuttonPressed})
  self.setupButtonClick(self.app.btnApply,self.btnApplyClickHook,{applypresetbuttonpressed})
  self.setupButtonClick(self.app.btnPassword,self.btnSetPasswordClickHook,{setpasswordbuttonpressed})

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
  domethod(self.app.btnPassword,[MUIM_KillNotify,MUIA_Pressed])
  
  domethod(self.app.slUserId,[MUIM_KillNotify,MUIA_Slider_Level])
  domethod(self.app.mnlabel2Save,[MUIM_KillNotify,MUIA_Menuitem_Trigger])
  domethod(self.app.mnlabel2Cancel,[MUIM_KillNotify,MUIA_Menuitem_Trigger])
  domethod(self.app.cyCbConf,[MUIM_KillNotify,MUIA_Cycle_Active])

  self.removePresetMenuItems()
  self.clearControlChangeNotify()

  self.freeList(self.computerList)
  self.freeList(self.screenTypesList)
  self.freeList(self.confNameList)
  self.freeList(self.confDbList)
  Dispose(self.confDbEntries)
  Dispose(self.editedConfDbEntries)
  Dispose(self.confDbSharedItems)
  self.freeList(self.areaList)

  END closeHook
  END showHook
  END sliderChangeHook
  END confbaseChangeHook

  END self.userData
  END self.userKeys
  END self.userMisc
ENDPROC res

PROC addUser(bbsPath:PTR TO CHAR) OF frmEditUser
  DEF closeHook:PTR TO hook
  DEF showHook:PTR TO hook
  DEF confbaseChangeHook:PTR TO hook
  DEF res

  NEW closeHook
  NEW showHook
  NEW confbaseChangeHook

  NEW self.userData
  NEW self.userKeys
  NEW self.userMisc

  self.bbsPath:=bbsPath
  self.unsavedChanges:=FALSE
  self.userId:=-1
  AstrCopy(self.newPassword,'')

  self.loadBBSSetup()

  installhook( closeHook, {canClose})    
  self.closeHook:=closeHook

  installhook( showHook, {formShow})
  self.showHook:=showHook

  self.aboutwin:=0

  set( self.winMain, MUIA_Window_Title,'Add New User')
  set( self.winMain, MUIA_Window_ID, "AXUN")
  set ( self.winMain,MUIA_Window_ActiveObject,self.app.strUsername)
 
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
    MUIM_CallHook , self.btnCancelClickHook , self ] )

	domethod( self.app.cyCbConf , [
		MUIM_Notify , MUIA_Cycle_Active, MUIV_EveryTime,
		self.app.cyCbConf,
		3,
    MUIM_CallHook , confbaseChangeHook , self ] )
  installhook( confbaseChangeHook, {confbasechanged})

  self.makePresetMenuItems()
  
  self.setupControlChangeNotify()
        
  self.setupButtonClick(self.app.btnSave,self.btnSaveClickHook,{savebuttonPressed})
  self.setupButtonClick(self.app.btnCancel,self.btnCancelClickHook,{cancelbuttonPressed})
  self.setupButtonClick(self.app.btnApply,self.btnApplyClickHook,{applypresetbuttonpressed})
  self.setupButtonClick(self.app.btnPassword,self.btnSetPasswordClickHook,{setpasswordbuttonpressed})

  self.newUser()

  res:=self.showModal()
  IF res THEN self.saveUser(-1)

  domethod(self.app.btnSave,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.btnCancel,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.btnApply,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.mnlabel2Save,[MUIM_KillNotify,MUIA_Menuitem_Trigger])
  domethod(self.app.mnlabel2Cancel,[MUIM_KillNotify,MUIA_Menuitem_Trigger])
  domethod(self.app.btnPassword,[MUIM_KillNotify,MUIA_Pressed])
  domethod(self.app.cyCbConf,[MUIM_KillNotify,MUIA_Cycle_Active])
  
  self.removePresetMenuItems()
  self.clearControlChangeNotify()

  self.freeList(self.computerList)
  self.freeList(self.screenTypesList)
  self.freeList(self.confNameList)
  self.freeList(self.confDbList)  
  Dispose(self.confDbEntries)
  Dispose(self.editedConfDbEntries)
  Dispose(self.confDbSharedItems)
  self.freeList(self.areaList)

  END closeHook
  END showHook
  END confbaseChangeHook

  END self.userData
  END self.userKeys
  END self.userMisc

ENDPROC res
