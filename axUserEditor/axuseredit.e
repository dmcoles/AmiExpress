OPT MODULE
OPT PREPROCESS


->/////////////////////////////////////////////////////////////////////////////
->////////////////////////////////////////////////////// External modules /////
->/////////////////////////////////////////////////////////////////////////////
MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi'
MODULE 'utility/tagitem'


->/////////////////////////////////////////////////////////////////////////////
->//////////////////////////////////////////////////// Object definitions /////
->/////////////////////////////////////////////////////////////////////////////
EXPORT OBJECT app_obj
	app                     :	PTR TO LONG
	winUserList             :	PTR TO LONG
	mn_label_1              :	PTR TO LONG
	mnlabel1About           :	PTR TO LONG
	mnlabel1AboutMui        :	PTR TO LONG
	mnlabel1barlabel        :	PTR TO LONG
	mnlabel1Exit            :	PTR TO LONG
	mnlabel1AddUser         :	PTR TO LONG
	mnlabel1EditUser        :	PTR TO LONG
	strFilter               :	PTR TO LONG
	btnApplyFilter          :	PTR TO LONG
	lvUsers                 :	PTR TO LONG
	txtUserCount            :	PTR TO LONG
	btnAdd                  :	PTR TO LONG
	btnEdit                 :	PTR TO LONG
	btnExit                 :	PTR TO LONG
	winUserDetails          :	PTR TO LONG
	mnuEditUser             :	PTR TO LONG
	mnlabel2Save            :	PTR TO LONG
	mnlabel2Cancel          :	PTR TO LONG
	mnlabel2ApplyPreset     :	PTR TO LONG
	headerPanel             :	PTR TO LONG
	btnSelectUserPrev       :	PTR TO LONG
	btnSelectUserLoad       :	PTR TO LONG
	txtSelectUserName       :	PTR TO LONG
	slUserId                :	PTR TO LONG
	btnSelectUserNext       :	PTR TO LONG
	cyPreset                :	PTR TO LONG
	btnApply                :	PTR TO LONG
	strUsername             :	PTR TO LONG
	cyActive                :	PTR TO LONG
	strRealname             :	PTR TO LONG
	strLocation             :	PTR TO LONG
	strPassword             :	PTR TO LONG
	strPhone                :	PTR TO LONG
	slSecLevel              :	PTR TO LONG
	cySecArea               :	PTR TO LONG
	cyRejoinConf            :	PTR TO LONG
	strRatio                :	PTR TO LONG
	cyRatioType             :	PTR TO LONG
	strUploads              :	PTR TO LONG
	strDownloads            :	PTR TO LONG
	strUploadBytes          :	PTR TO LONG
	strDownloadBytes        :	PTR TO LONG
	strMessages             :	PTR TO LONG
	strUploadCPS            :	PTR TO LONG
	strDownloadCPS          :	PTR TO LONG
	strByteLimit            :	PTR TO LONG
	strTimeTotal            :	PTR TO LONG
	strTimeLimit            :	PTR TO LONG
	strChatLimit            :	PTR TO LONG
	strTimeUsed             :	PTR TO LONG
	strChatUsed             :	PTR TO LONG
	cyPwdReset              :	PTR TO LONG
	cyAccountLocked         :	PTR TO LONG
	strInvalidAttempts      :	PTR TO LONG
	cyComputers             :	PTR TO LONG
	cyScreens               :	PTR TO LONG
	cyNewUser               :	PTR TO LONG
	strTotalCalls           :	PTR TO LONG
	strPwdType              :	PTR TO LONG
	strCallsToday           :	PTR TO LONG
	strLastCalled           :	PTR TO LONG
	strLastPwdReset         :	PTR TO LONG
	btnSave                 :	PTR TO LONG
	btnCancel               :	PTR TO LONG
	stR_txtUserCount        :	PTR TO CHAR
	stR_txtSelectUserName   :	PTR TO CHAR
	cyPresetContent         :	PTR TO LONG
	stR_mainPanel           :	PTR TO LONG
	cyActiveContent         :	PTR TO LONG
	cySecAreaContent        :	PTR TO LONG
	cyRejoinConfContent     :	PTR TO LONG
	cyRatioTypeContent      :	PTR TO LONG
	cyPwdResetContent       :	PTR TO LONG
	cyAccountLockedContent  :	PTR TO LONG
	cyComputersContent      :	PTR TO LONG
	cyScreensContent        :	PTR TO LONG
	cyNewUserContent        :	PTR TO LONG
ENDOBJECT


->/////////////////////////////////////////////////////////////////////////////
->/////////// Creates one instance of one object or the whole application /////
->/////////////////////////////////////////////////////////////////////////////
PROC create() OF app_obj

	DEF mnlabel1File , mnlabel1Edit , grOUP_ROOT_0 , gr_grp_17
	DEF la_label_40 , gr_grp_0 , mnlabel2Project , mnlabel2Presets
	DEF grOUP_ROOT_1 , presetPanel , la_label_39 , mainPanel
	DEF userDetailsPanel , gr_grp_12 , la_label_0 , la_label_37
	DEF la_label_1 , la_label_2 , la_label_3 , la_label_9
	DEF gr_grp_13 , la_label_8 , la_label_7 , la_label_15 , space_11
	DEF userStatsPanel , la_label_6 , la_label_10 , la_label_11
	DEF la_label_12 , la_label_13 , la_label_14 , la_label_16
	DEF la_label_18 , la_label_19 , space_2 , space_3 , space_14
	DEF space_15 , space_16 , space_17 , userLimitsPanel
	DEF la_label_17 , la_label_20 , la_label_21 , la_label_22
	DEF la_label_23 , la_label_24 , la_label_31 , la_label_32
	DEF la_label_33 , space_4 , space_5 , space_19 , space_18
	DEF space_25C , space_26C , userMiscPanel , gr_grp_15
	DEF la_label_29 , la_label_30 , gr_grp_14 , la_label_25
	DEF la_label_26 , la_label_35 , la_label_27 , la_label_28
	DEF la_label_34 , space_7 , space_24 , space_25 , space_6
	DEF space_26 , footerPanel , space_27

	self.stR_txtUserCount        := 'Total Users: 5500'
	self.stR_txtSelectUserName   := 'rebel'
	self.cyPresetContent         := [
		'1' ,
		NIL ]
	self.stR_mainPanel           := [
		'Details' ,
		'Stats' ,
		'Limits & Lockouts' ,
		'Misc' ,
		NIL ]
	self.cyActiveContent         := [
		'Yes' ,
		'No' ,
		NIL ]
	self.cySecAreaContent        := [
		'NewUser' ,
		NIL ]
	self.cyRejoinConfContent     := [
		'Conf1' ,
		NIL ]
	self.cyRatioTypeContent      := [
		'Bytes' ,
		'Bytes & Files' ,
		'Files' ,
		NIL ]
	self.cyPwdResetContent       := [
		'Yes' ,
		'No' ,
		NIL ]
	self.cyAccountLockedContent  := [
		'Yes' ,
		'No' ,
		NIL ]
	self.cyComputersContent      := [
		'A500' ,
		NIL ]
	self.cyScreensContent        := [
		'Ansi' ,
		NIL ]
	self.cyNewUserContent        := [
		'Yes' ,
		'No' ,
		NIL ]

	la_label_40 := Label( 'Filter' )

	self.strFilter := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strFilter' ,
	End

	self.btnApplyFilter := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Apply' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnApplyFilter' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	gr_grp_17 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_17' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , la_label_40 ,
		Child , self.strFilter ,
		Child , self.btnApplyFilter ,
	End

	self.lvUsers := ListObject ,
		MUIA_Frame , MUIV_Frame_InputList ,
		MUIA_List_Title , ',,' ,
		MUIA_List_Format , 'MAXWIDTH=20,MINWIDTH=40,MINWIDTH=40' ,
	End

	self.lvUsers := ListviewObject ,
		MUIA_HelpNode , 'lvUsers' ,
		MUIA_Listview_MultiSelect , MUIV_Listview_MultiSelect_Default ,
		MUIA_Listview_List , self.lvUsers ,
	End

	self.txtUserCount := TextObject ,
		MUIA_Background , MUII_WindowBack ,
		MUIA_Text_Contents , self.stR_txtUserCount ,
		MUIA_Text_SetMin , MUI_TRUE ,
	End

	self.btnAdd := SimpleButton( 'Add' )

	self.btnEdit := SimpleButton( 'Edit' )

	self.btnExit := SimpleButton( 'Exit' )

	gr_grp_0 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_0' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnAdd ,
		Child , self.btnEdit ,
		Child , self.btnExit ,
	End

	grOUP_ROOT_0 := GroupObject ,
		Child , gr_grp_17 ,
		Child , self.lvUsers ,
		Child , self.txtUserCount ,
		Child , gr_grp_0 ,
	End

	self.mnlabel1About := MenuitemObject ,
		MUIA_Menuitem_Title , 'About' ,
	End

	self.mnlabel1AboutMui := MenuitemObject ,
		MUIA_Menuitem_Title , 'About Mui' ,
	End

	self.mnlabel1barlabel := MenuitemObject ,
		MUIA_Menuitem_Title , 'barlabel' ,
	End

	self.mnlabel1Exit := MenuitemObject ,
		MUIA_Menuitem_Title , 'Exit' ,
	End

	mnlabel1File := MenuitemObject ,
		MUIA_Menuitem_Title , 'File' ,
		MUIA_Family_Child , self.mnlabel1About ,
		MUIA_Family_Child , self.mnlabel1AboutMui ,
		MUIA_Family_Child , self.mnlabel1barlabel ,
		MUIA_Family_Child , self.mnlabel1Exit ,
	End

	self.mnlabel1AddUser := MenuitemObject ,
		MUIA_Menuitem_Title , 'Add User' ,
	End

	self.mnlabel1EditUser := MenuitemObject ,
		MUIA_Menuitem_Title , 'Edit User' ,
	End

	mnlabel1Edit := MenuitemObject ,
		MUIA_Menuitem_Title , 'Edit' ,
		MUIA_Family_Child , self.mnlabel1AddUser ,
		MUIA_Family_Child , self.mnlabel1EditUser ,
	End

	self.mn_label_1 := MenustripObject ,
		MUIA_Family_Child , mnlabel1File ,
		MUIA_Family_Child , mnlabel1Edit ,
	End

	self.winUserList := WindowObject ,
		MUIA_Window_Title , 'Ami-Express User Editor' ,
		MUIA_Window_Menustrip , self.mn_label_1 ,
		MUIA_Window_ID , "0WIN" ,
		WindowContents , grOUP_ROOT_0 ,
	End

	self.btnSelectUserPrev := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , '<' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnSelectUserPrev' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnSelectUserLoad := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Load' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnSelectUserLoad' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.txtSelectUserName := TextObject ,
		MUIA_Weight , 30 ,
		MUIA_Background , MUII_WindowBack ,
		MUIA_Text_Contents , self.stR_txtSelectUserName ,
		MUIA_Text_SetMin , MUI_TRUE ,
	End

	self.slUserId := SliderObject ,
		MUIA_HelpNode , 'slUserId' ,
		MUIA_Frame , MUIV_Frame_Slider ,
		MUIA_Slider_Min , 0 ,
		MUIA_Slider_Max , 100 ,
		MUIA_Slider_Level , 0 ,
	End

	self.btnSelectUserNext := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , '>' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnSelectUserNext' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.headerPanel := GroupObject ,
		MUIA_HelpNode , 'headerPanel' ,
		MUIA_Frame , MUIV_Frame_Group ,
		MUIA_FrameTitle , 'Select User' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnSelectUserPrev ,
		Child , self.btnSelectUserLoad ,
		Child , self.txtSelectUserName ,
		Child , self.slUserId ,
		Child , self.btnSelectUserNext ,
	End

	la_label_39 := TextObject ,
		MUIA_Text_PreParse , '\er' ,
		MUIA_Text_Contents , 'Preset' ,
		MUIA_ShowMe , FALSE ,
		MUIA_InnerLeft , 0 ,
		MUIA_InnerRight , 0 ,
	End

	self.cyPreset := CycleObject ,
		MUIA_HelpNode , 'cyPreset' ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Cycle_Entries , self.cyPresetContent ,
	End

	self.btnApply := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Apply' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnApply' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	presetPanel := GroupObject ,
		MUIA_HelpNode , 'presetPanel' ,
		MUIA_FrameTitle , 'Apply A Preset' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , la_label_39 ,
		Child , self.cyPreset ,
		Child , self.btnApply ,
	End

	la_label_0 := Label( 'User Name' )

	self.strUsername := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strUsername' ,
	End

	la_label_37 := Label( 'Active' )

	self.cyActive := CycleObject ,
		MUIA_HelpNode , 'cyActive' ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Cycle_Entries , self.cyActiveContent ,
	End

	la_label_1 := Label( 'Real Name' )

	self.strRealname := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strRealname' ,
	End

	la_label_2 := Label( 'Location' )

	self.strLocation := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strLocation' ,
	End

	la_label_3 := Label( 'Password' )

	self.strPassword := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strPassword' ,
		MUIA_String_Secret , MUI_TRUE ,
	End

	la_label_9 := Label( 'Phone Number' )

	self.strPhone := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strPhone' ,
	End

	gr_grp_12 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_12' ,
		MUIA_Background , MUII_RequesterBack ,
		MUIA_Group_Columns , 4 ,
		Child , la_label_0 ,
		Child , self.strUsername ,
		Child , la_label_37 ,
		Child , self.cyActive ,
		Child , la_label_1 ,
		Child , self.strRealname ,
		Child , la_label_2 ,
		Child , self.strLocation ,
		Child , la_label_3 ,
		Child , self.strPassword ,
		Child , la_label_9 ,
		Child , self.strPhone ,
	End

	la_label_8 := Label( 'Security Level' )

	self.slSecLevel := SliderObject ,
		MUIA_HelpNode , 'slSecLevel' ,
		MUIA_Frame , MUIV_Frame_Slider ,
		MUIA_Slider_Min , 0 ,
		MUIA_Slider_Max , 255 ,
		MUIA_Slider_Level , 0 ,
	End

	la_label_7 := Label( 'Area' )

	self.cySecArea := CycleObject ,
		MUIA_HelpNode , 'cySecArea' ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Cycle_Entries , self.cySecAreaContent ,
	End

	la_label_15 := Label( 'Conference' )

	self.cyRejoinConf := CycleObject ,
		MUIA_HelpNode , 'cyRejoinConf' ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Cycle_Entries , self.cyRejoinConfContent ,
	End

	gr_grp_13 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_13' ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_RequesterBack ,
		MUIA_Group_Columns , 2 ,
		Child , la_label_8 ,
		Child , self.slSecLevel ,
		Child , la_label_7 ,
		Child , self.cySecArea ,
		Child , la_label_15 ,
		Child , self.cyRejoinConf ,
	End

	space_11 := VSpace( 0 )

	userDetailsPanel := GroupObject ,
		MUIA_HelpNode , 'userDetailsPanel' ,
		MUIA_Background , MUII_RequesterBack ,
		MUIA_Frame , MUIV_Frame_Group ,
		MUIA_Group_SameWidth , MUI_TRUE ,
		Child , gr_grp_12 ,
		Child , gr_grp_13 ,
		Child , space_11 ,
	End

	la_label_6 := Label( 'Ratio' )

	self.strRatio := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strRatio' ,
	End

	la_label_10 := Label( 'Ratio Type' )

	self.cyRatioType := CycleObject ,
		MUIA_HelpNode , 'cyRatioType' ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Cycle_Entries , self.cyRatioTypeContent ,
	End

	la_label_11 := Label( 'Uploads' )

	self.strUploads := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strUploads' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	la_label_12 := Label( 'Downloads' )

	self.strDownloads := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strDownloads' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	la_label_13 := Label( 'Bytes U/L' )

	self.strUploadBytes := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strUploadBytes' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 16 ,
	End

	la_label_14 := Label( 'Bytes D/L' )

	self.strDownloadBytes := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strDownloadBytes' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 16 ,
	End

	la_label_16 := Label( 'Messages Posted' )

	self.strMessages := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strMessages' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	la_label_18 := Label( 'CPS Up' )

	self.strUploadCPS := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strUploadCPS' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 9 ,
	End

	la_label_19 := Label( 'CPS Down' )

	self.strDownloadCPS := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strDownloadCPS' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 9 ,
	End

	space_2 := HVSpace

	space_3 := HVSpace

	space_14 := HVSpace

	space_15 := HVSpace

	space_16 := HVSpace

	space_17 := HVSpace

	userStatsPanel := GroupObject ,
		MUIA_HelpNode , 'userStatsPanel' ,
		MUIA_Background , MUII_RequesterBack ,
		MUIA_Frame , MUIV_Frame_Group ,
		MUIA_Group_Columns , 4 ,
		MUIA_Group_SameHeight , MUI_TRUE ,
		MUIA_Group_SameWidth , MUI_TRUE ,
		Child , la_label_6 ,
		Child , self.strRatio ,
		Child , la_label_10 ,
		Child , self.cyRatioType ,
		Child , la_label_11 ,
		Child , self.strUploads ,
		Child , la_label_12 ,
		Child , self.strDownloads ,
		Child , la_label_13 ,
		Child , self.strUploadBytes ,
		Child , la_label_14 ,
		Child , self.strDownloadBytes ,
		Child , la_label_16 ,
		Child , self.strMessages ,
		Child , la_label_18 ,
		Child , self.strUploadCPS ,
		Child , la_label_19 ,
		Child , self.strDownloadCPS ,
		Child , space_2 ,
		Child , space_3 ,
		Child , space_14 ,
		Child , space_15 ,
		Child , space_16 ,
		Child , space_17 ,
	End

	la_label_17 := Label( 'Byte Limit' )

	self.strByteLimit := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strByteLimit' ,
		MUIA_String_Accept , '0123456789' ,
	End

	la_label_20 := Label( 'Time Total' )

	self.strTimeTotal := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strTimeTotal' ,
		MUIA_String_Accept , '-0123456789' ,
	End

	la_label_21 := Label( 'Time Limit' )

	self.strTimeLimit := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strTimeLimit' ,
		MUIA_String_Accept , '-0123456789' ,
	End

	la_label_22 := Label( 'Chat Limit' )

	self.strChatLimit := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strChatLimit' ,
	End

	la_label_23 := Label( 'Time Used' )

	self.strTimeUsed := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strTimeUsed' ,
		MUIA_String_Accept , '-0123456789' ,
	End

	la_label_24 := Label( 'Chat Used' )

	self.strChatUsed := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strChatUsed' ,
		MUIA_String_Accept , '-0123456789' ,
	End

	la_label_31 := Label( 'Force Pwd Reset' )

	self.cyPwdReset := CycleObject ,
		MUIA_HelpNode , 'cyPwdReset' ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Cycle_Entries , self.cyPwdResetContent ,
	End

	la_label_32 := Label( 'Account Locked' )

	self.cyAccountLocked := CycleObject ,
		MUIA_HelpNode , 'cyAccountLocked' ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Cycle_Entries , self.cyAccountLockedContent ,
	End

	la_label_33 := Label( 'Invalid Attempts' )

	self.strInvalidAttempts := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strInvalidAttempts' ,
		MUIA_String_Accept , '-0123456789' ,
	End

	space_4 := HVSpace

	space_5 := HVSpace

	space_19 := HVSpace

	space_18 := HVSpace

	space_25C := HVSpace

	space_26C := HVSpace

	userLimitsPanel := GroupObject ,
		MUIA_HelpNode , 'UserLimitsPanel' ,
		MUIA_Background , MUII_RequesterBack ,
		MUIA_Frame , MUIV_Frame_Group ,
		MUIA_Group_Columns , 4 ,
		MUIA_Group_SameHeight , MUI_TRUE ,
		MUIA_Group_SameWidth , MUI_TRUE ,
		Child , la_label_17 ,
		Child , self.strByteLimit ,
		Child , la_label_20 ,
		Child , self.strTimeTotal ,
		Child , la_label_21 ,
		Child , self.strTimeLimit ,
		Child , la_label_22 ,
		Child , self.strChatLimit ,
		Child , la_label_23 ,
		Child , self.strTimeUsed ,
		Child , la_label_24 ,
		Child , self.strChatUsed ,
		Child , la_label_31 ,
		Child , self.cyPwdReset ,
		Child , la_label_32 ,
		Child , self.cyAccountLocked ,
		Child , la_label_33 ,
		Child , self.strInvalidAttempts ,
		Child , space_4 ,
		Child , space_5 ,
		Child , space_19 ,
		Child , space_18 ,
		Child , space_25C ,
		Child , space_26C ,
	End

	la_label_29 := Label( 'Computer Type' )

	self.cyComputers := CycleObject ,
		MUIA_HelpNode , 'cyComputers' ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Cycle_Entries , self.cyComputersContent ,
	End

	la_label_30 := Label( 'Screen Type' )

	self.cyScreens := CycleObject ,
		MUIA_HelpNode , 'cyScreens' ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Cycle_Entries , self.cyScreensContent ,
	End

	gr_grp_15 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_15' ,
		MUIA_Background , MUII_RequesterBack ,
		MUIA_Group_Columns , 2 ,
		Child , la_label_29 ,
		Child , self.cyComputers ,
		Child , la_label_30 ,
		Child , self.cyScreens ,
	End

	la_label_25 := Label( 'New User' )

	self.cyNewUser := CycleObject ,
		MUIA_HelpNode , 'cyNewUser' ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Cycle_Entries , self.cyNewUserContent ,
	End

	la_label_26 := Label( 'Total Calls' )

	self.strTotalCalls := StringObject ,
		MUIA_Disabled , MUI_TRUE ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strTotalCalls' ,
	End

	la_label_35 := Label( 'Password Type' )

	self.strPwdType := StringObject ,
		MUIA_Disabled , MUI_TRUE ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strPwdType' ,
		MUIA_String_Accept , '-0123456789' ,
	End

	la_label_27 := Label( 'Calls Today' )

	self.strCallsToday := StringObject ,
		MUIA_Disabled , MUI_TRUE ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strCallsToday' ,
		MUIA_String_Accept , '-0123456789' ,
	End

	la_label_28 := Label( 'Last Called' )

	self.strLastCalled := StringObject ,
		MUIA_Disabled , MUI_TRUE ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strLastCalled' ,
	End

	la_label_34 := Label( 'Last Pwd Reset' )

	self.strLastPwdReset := StringObject ,
		MUIA_Disabled , MUI_TRUE ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strLastPwdReset' ,
	End

	space_7 := HVSpace

	space_24 := HVSpace

	space_25 := HVSpace

	space_6 := HVSpace

	gr_grp_14 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_14' ,
		MUIA_Background , MUII_RequesterBack ,
		MUIA_Group_Columns , 4 ,
		Child , la_label_25 ,
		Child , self.cyNewUser ,
		Child , la_label_26 ,
		Child , self.strTotalCalls ,
		Child , la_label_35 ,
		Child , self.strPwdType ,
		Child , la_label_27 ,
		Child , self.strCallsToday ,
		Child , la_label_28 ,
		Child , self.strLastCalled ,
		Child , la_label_34 ,
		Child , self.strLastPwdReset ,
		Child , space_7 ,
		Child , space_24 ,
		Child , space_25 ,
		Child , space_6 ,
	End

	space_26 := HVSpace

	userMiscPanel := GroupObject ,
		MUIA_HelpNode , 'userMiscPanel' ,
		MUIA_Background , MUII_RequesterBack ,
		MUIA_Frame , MUIV_Frame_Group ,
		MUIA_Group_SameWidth , MUI_TRUE ,
		Child , gr_grp_15 ,
		Child , gr_grp_14 ,
		Child , space_26 ,
	End

	mainPanel := RegisterObject ,
		MUIA_Register_Titles , self.stR_mainPanel ,
		MUIA_HelpNode , 'mainPanel' ,
		Child , userDetailsPanel ,
		Child , userStatsPanel ,
		Child , userLimitsPanel ,
		Child , userMiscPanel ,
	End

	self.btnSave := SimpleButton( 'Save' )

	self.btnCancel := SimpleButton( 'Cancel' )

	footerPanel := GroupObject ,
		MUIA_HelpNode , 'footerPanel' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnSave ,
		Child , self.btnCancel ,
	End

	space_27 := HVSpace

	grOUP_ROOT_1 := GroupObject ,
		Child , self.headerPanel ,
		Child , presetPanel ,
		Child , mainPanel ,
		Child , footerPanel ,
		Child , space_27 ,
	End

	self.mnlabel2Save := MenuitemObject ,
		MUIA_Menuitem_Title , 'Save' ,
	End

	self.mnlabel2Cancel := MenuitemObject ,
		MUIA_Menuitem_Title , 'Cancel' ,
	End

	mnlabel2Project := MenuitemObject ,
		MUIA_Menuitem_Title , 'Project' ,
		MUIA_Family_Child , self.mnlabel2Save ,
		MUIA_Family_Child , self.mnlabel2Cancel ,
	End

	self.mnlabel2ApplyPreset := MenuitemObject ,
		MUIA_Menuitem_Title , 'Apply Preset' ,
	End

	mnlabel2Presets := MenuitemObject ,
		MUIA_Menuitem_Title , 'Edit' ,
		MUIA_Family_Child , self.mnlabel2ApplyPreset ,
	End

	self.mnuEditUser := MenustripObject ,
		MUIA_Family_Child , mnlabel2Project ,
		MUIA_Family_Child , mnlabel2Presets ,
	End

	self.winUserDetails := WindowObject ,
		MUIA_Window_Title , 'Edit User' ,
		MUIA_Window_Menustrip , self.mnuEditUser ,
		MUIA_Window_ID , "1WIN" ,
		WindowContents , grOUP_ROOT_1 ,
	End

	self.app := ApplicationObject ,
		//( IF icon THEN MUIA_Application_DiskObject ELSE TAG_IGNORE ) , icon ,
		//( IF arexx THEN MUIA_Application_Commands ELSE TAG_IGNORE ) , ( IF arexx THEN arexx.commands ELSE NIL ) ,
		//( IF arexx THEN MUIA_Application_RexxHook ELSE TAG_IGNORE ) , ( IF arexx THEN arexx.error ELSE NIL ) ,
		//( IF menu THEN MUIA_Application_Menu ELSE TAG_IGNORE ) , menu ,
		MUIA_Application_Author , 'NONE' ,
		MUIA_Application_Base , 'NONE' ,
		MUIA_Application_Title , 'NONE' ,
		MUIA_Application_Version , '$VER: NONE XX.XX (XX.XX.XX)' ,
		MUIA_Application_Copyright , 'NOBODY' ,
		MUIA_Application_Description , 'NONE' ,
		MUIA_Application_HelpFile , 'axsys.guide' ,
		SubWindow , self.winUserList ,
		SubWindow , self.winUserDetails ,
	End

ENDPROC self.app


->/////////////////////////////////////////////////////////////////////////////
->////////////////////////// Disposes the object or the whole application /////
->/////////////////////////////////////////////////////////////////////////////
PROC dispose() OF app_obj IS ( IF self.app THEN Mui_DisposeObject( self.app ) ELSE NIL )


->/////////////////////////////////////////////////////////////////////////////
->/////////////////////// Initializes all the notifications of one object /////
->/////////////////////////////////////////// or of the whole application /////
->/////////////////////////////////////////////////////////////////////////////
PROC init_notifications(  ) OF app_obj

	domethod( self.winUserList , [
		MUIM_Notify , MUIA_Window_CloseRequest , MUI_TRUE ,
		self.app ,
		2 ,
		MUIM_Application_ReturnID , MUIV_Application_ReturnID_Quit ] )

	domethod( self.lvUsers , [
		MUIM_Notify , MUIA_Listview_DoubleClick , MUI_TRUE ,
		self.winUserDetails ,
		3 ,
		MUIM_Set , MUIA_Window_Open , MUI_TRUE ] )

	domethod( self.btnAdd , [
		MUIM_Notify , MUIA_Pressed , FALSE ,
		self.winUserDetails ,
		3 ,
		MUIM_Set , MUIA_Window_Open , MUI_TRUE ] )

	domethod( self.btnEdit , [
		MUIM_Notify , MUIA_Pressed , FALSE ,
		self.winUserDetails ,
		3 ,
		MUIM_Set , MUIA_Window_Open , MUI_TRUE ] )

	domethod( self.btnExit , [
		MUIM_Notify , MUIA_Pressed , FALSE ,
		self.app ,
		2 ,
		MUIM_Application_ReturnID , MUIV_Application_ReturnID_Quit ] )

	domethod( self.winUserList , [
		MUIM_Window_SetCycleChain , self.strFilter ,
		self.btnApplyFilter ,
		self.lvUsers ,
		self.btnAdd ,
		self.btnEdit ,
		self.btnExit ,
		0 ] )

	domethod( self.winUserDetails , [
		MUIM_Notify , MUIA_Window_CloseRequest , MUI_TRUE ,
		self.winUserDetails ,
		3 ,
		MUIM_Set , MUIA_Window_Open , FALSE ] )

	domethod( self.btnSave , [
		MUIM_Notify , MUIA_Pressed , FALSE ,
		self.winUserDetails ,
		3 ,
		MUIM_Set , MUIA_Window_Open , FALSE ] )

	domethod( self.btnCancel , [
		MUIM_Notify , MUIA_Pressed , FALSE ,
		self.winUserDetails ,
		3 ,
		MUIM_Set , MUIA_Window_Open , FALSE ] )

	domethod( self.winUserDetails , [
		MUIM_Window_SetCycleChain , self.headerPanel ,
		self.btnSelectUserPrev ,
		self.btnSelectUserLoad ,
		self.slUserId ,
		self.btnSelectUserNext ,
		self.cyPreset ,
		self.btnApply ,
		self.strUsername ,
		self.cyActive ,
		self.strRealname ,
		self.strLocation ,
		self.strPassword ,
		self.strPhone ,
		self.slSecLevel ,
		self.cySecArea ,
		self.cyRejoinConf ,
		self.strRatio ,
		self.cyRatioType ,
		self.strUploads ,
		self.strDownloads ,
		self.strUploadBytes ,
		self.strDownloadBytes ,
		self.strMessages ,
		self.strUploadCPS ,
		self.strDownloadCPS ,
		self.strByteLimit ,
		self.strTimeTotal ,
		self.strTimeLimit ,
		self.strChatLimit ,
		self.strTimeUsed ,
		self.strChatUsed ,
		self.cyPwdReset ,
		self.cyAccountLocked ,
		self.strInvalidAttempts ,
		self.cyComputers ,
		self.cyScreens ,
		self.cyNewUser ,
		self.strTotalCalls ,
		self.strPwdType ,
		self.strCallsToday ,
		self.strLastCalled ,
		self.strLastPwdReset ,
		self.btnSave ,
		self.btnCancel ,
		0 ] )

	set( self.winUserList ,MUIA_Window_Open , MUI_TRUE )

ENDPROC


