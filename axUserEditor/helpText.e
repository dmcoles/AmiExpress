->help text definitions
OPT MODULE

EXPORT ENUM 
  HLP_ADD_USER,
  HLP_EDIT_USER,
  HLP_SET_FILTER,
  HLP_APPLY_FILTER,
  HLP_EXIT,
  HLP_SET_PASSWORD_1,
  HLP_SET_PASSWORD_2,
  HLP_SELECT_USER,
  HLP_LOAD_USER,
  HLP_SELECT_PRESET,
  HLP_APPLY_PRESET,
  HLP_USERNAME,
  HLP_ACTIVE,
  HLP_REALNAME,
  HLP_INTERNETNAME,
  HLP_EMAILADDRESS,
  HLP_LOCATION,
  HLP_SETPASSWORD,
  HLP_PHONENUM,
  HLP_SECURITYLEVEL,
  HLP_SECURITYAREA,
  HLP_CONFERENCE,
  HLP_RATIO,
  HLP_RATIOTYPE,
  HLP_UPLOADS,
  HLP_DOWNLOADS,
  HLP_UPLOADBYTES,
  HLP_DOWNLOADBYTES,
  HLP_MESSAGES,
  HLP_CPSUP,
  HLP_CPSDOWN,
  HLP_BYTELIMT,
  HLP_TIMETOTAL,
  HLP_TIMELIMIT,
  HLP_CHATLIMIT,
  HLP_TIMEUSED,
  HLP_CHATUSED,
  HLP_FORCEPWDRESET,
  HLP_ACCOUNTLOCKED,
  HLP_INVALIDATTEMPTS,
  
  HLP_CONFACC_CONF,
  HLP_CONFACC_UPLOADS,
  HLP_CONFACC_DOWNLOADS,
  HLP_CONFACC_UPLOADBYTES,
  HLP_CONFACC_DOWNLOADBYTES,
  HLP_CONFACC_RATIO,
  HLP_CONFACC_RATIOTYPE,
  HLP_CONFACC_MESSAGES,
  
  HLP_COMPUTERTYPE,
  HLP_SCREENTYPE,
  HLP_NEWUSER,
  HLP_TOTALCALLS,
  HLP_PASSWORDTYPE,
  HLP_CALLSTODAY,
  HLP_LASTCALLDATE,
  HLP_LASTPWDRESETDATE,
  
  HLP_SAVE,
  HLP_CANCEL,
  END_OF_LIST

EXPORT DEF helpTexts:PTR TO LONG

PROC addHelp(id,text)
  IF id>=END_OF_LIST THEN Throw( "HLP" , "LIST" )
  helpTexts[id]:=text
ENDPROC

EXPORT PROC getHelpText(id)
  IF id<ListLen(helpTexts) THEN RETURN helpTexts[id]
ENDPROC ''

EXPORT PROC helpTextDeinitialise()
  DisposeLink(helpTexts)
ENDPROC

EXPORT PROC helpTextInitialise()
  helpTexts:=List(END_OF_LIST)
  SetList(helpTexts,END_OF_LIST)

  addHelp(HLP_SET_PASSWORD_1,'New password for the user')
  addHelp(HLP_SET_PASSWORD_2,'Reenter the new password for verification')
  addHelp(HLP_ADD_USER,'Add a new user')
  addHelp(HLP_EDIT_USER,'Edit the currently selected user')
  addHelp(HLP_SET_FILTER,'Set the text to filter on')
  addHelp(HLP_APPLY_FILTER,'Apply the filter')
  addHelp(HLP_EXIT,'Close the application')
  addHelp(HLP_SELECT_USER,'Select a different user to edit')
  addHelp(HLP_LOAD_USER,'Load selected user details')
  addHelp(HLP_SELECT_PRESET,'Select a preset to apply')
  addHelp(HLP_APPLY_PRESET,'Apply the selected preset')

  addHelp(HLP_SAVE,'Save changes to user')
  addHelp(HLP_CANCEL,'Cancel changes')

  addHelp(HLP_USERNAME,'Users login name')
  addHelp(HLP_ACTIVE,'Is the account active')
  addHelp(HLP_REALNAME,'Users real name')
  addHelp(HLP_INTERNETNAME,'Users internet name')
  addHelp(HLP_EMAILADDRESS,'Users email address')
  addHelp(HLP_LOCATION,'Users location')
  addHelp(HLP_SETPASSWORD,'Change the users password')
  addHelp(HLP_PHONENUM,'Users phone number')
  addHelp(HLP_SECURITYLEVEL,'Users security access level')
  addHelp(HLP_SECURITYAREA,'Users security access area')
  addHelp(HLP_CONFERENCE,'Current conference for user')

  addHelp(HLP_RATIO,'Users ratio')
  addHelp(HLP_RATIOTYPE,'Users ratio type')
  addHelp(HLP_UPLOADS,'Number of files uploaded')
  addHelp(HLP_DOWNLOADS,'Number of files downloaded')
  addHelp(HLP_UPLOADBYTES,'Total bytes uploaded')
  addHelp(HLP_DOWNLOADBYTES,'Total bytes downloaded')
  addHelp(HLP_MESSAGES,'Total number of messages posted')
  addHelp(HLP_CPSUP,'Highest CPS during upload')
  addHelp(HLP_CPSDOWN,'Highest CPS during download')

  addHelp(HLP_BYTELIMT,'Users daily byte limit')
  addHelp(HLP_TIMETOTAL,'Users daily time limit')
  addHelp(HLP_TIMELIMIT,'Users daily time limit')
  addHelp(HLP_CHATLIMIT,'Users daily time limit')
  addHelp(HLP_TIMEUSED,'Current time used today')
  addHelp(HLP_CHATUSED,'Current chat time used today')
  addHelp(HLP_FORCEPWDRESET,'Force password reset for user on next login')
  addHelp(HLP_ACCOUNTLOCKED,'Users account is locked out')
  addHelp(HLP_INVALIDATTEMPTS,'Number of consecutive invalid pasword attempts')

  addHelp(HLP_CONFACC_CONF,'Conference stats to edit')
  addHelp(HLP_CONFACC_UPLOADS,'Number of uploads in this conference')
  addHelp(HLP_CONFACC_DOWNLOADS,'Number of downloads in this conference')
  addHelp(HLP_CONFACC_UPLOADBYTES,'Bytes uploaded in this conference')
  addHelp(HLP_CONFACC_DOWNLOADBYTES,'Bytes downloaded in this conference')
  addHelp(HLP_CONFACC_RATIO,'Ratio for this conference')
  addHelp(HLP_CONFACC_RATIOTYPE,'Ratio type for this conference')
  addHelp(HLP_CONFACC_MESSAGES,'Number of mesages posted in this conference')

  addHelp(HLP_COMPUTERTYPE,'Users computer type')
  addHelp(HLP_SCREENTYPE,'Users selected screen type')
  addHelp(HLP_NEWUSER,'Is this a new user')
  addHelp(HLP_TOTALCALLS,'Users total number of calls to the system')
  addHelp(HLP_PASSWORDTYPE,'Password encryption type')
  addHelp(HLP_CALLSTODAY,'Number of calls today')
  addHelp(HLP_LASTCALLDATE,'Last time the user accessed the sytem')
  addHelp(HLP_LASTPWDRESETDATE,'Last time the users password was reset')

ENDPROC
