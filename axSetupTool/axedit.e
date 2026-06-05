OPT MODULE
OPT PREPROCESS


->/////////////////////////////////////////////////////////////////////////////
->////////////////////////////////////////////////////// External modules /////
->/////////////////////////////////////////////////////////////////////////////
MODULE 'muimaster' , 'libraries/mui'
MODULE 'tools/boopsi'
MODULE 'utility/tagitem' , 'utility/hooks'


->/////////////////////////////////////////////////////////////////////////////
->//////////////////////////////////////////////////// Object definitions /////
->/////////////////////////////////////////////////////////////////////////////
EXPORT OBJECT app_display
	editConfs                   :	hook
ENDOBJECT

EXPORT OBJECT app_obj
	app                         :	PTR TO LONG
	winMain                     :	PTR TO LONG
	mn_label_1                  :	PTR TO LONG
	mnlabel1About               :	PTR TO LONG
	mnlabel1AboutMui            :	PTR TO LONG
	mnlabel1Exit                :	PTR TO LONG
	mnlabel1Donotremovefolder1  :	PTR TO LONG
	mnlabel1Removefolder1       :	PTR TO LONG
	mnlabel1Ask1                :	PTR TO LONG
	mnlabel1NodeDelete          :	PTR TO LONG
	mnlabel1Donotremovefolder2  :	PTR TO LONG
	mnlabel1Removefolder2       :	PTR TO LONG
	mnlabel1Ask2                :	PTR TO LONG
	btnSystem                   :	PTR TO LONG
	btnServer                   :	PTR TO LONG
	btnBackup                   :	PTR TO LONG
	btnRestrict                 :	PTR TO LONG
	btnNodes                    :	PTR TO LONG
	btnConfs                    :	PTR TO LONG
	btnSecurity                 :	PTR TO LONG
	btnCommands                 :	PTR TO LONG
	btnComputers                :	PTR TO LONG
	btnProtocols                :	PTR TO LONG
	btnNamesNotAllowed          :	PTR TO LONG
	btnScreenTypes              :	PTR TO LONG
	btnLanguages                :	PTR TO LONG
	btnDrives                   :	PTR TO LONG
	btnCheckers                 :	PTR TO LONG
	btnConnect                  :	PTR TO LONG
	btnZoom                     :	PTR TO LONG
	btnUsers                    :	PTR TO LONG
	tx_label_0                  :	PTR TO LONG
	gr_ax_image                 :	PTR TO LONG
	btnAbout                    :	PTR TO LONG
	btnTools                    :	PTR TO LONG
	btnExit                     :	PTR TO LONG
	wi_conf_edit                :	PTR TO LONG
	btnFirstConf                :	PTR TO LONG
	btnPrevConf                 :	PTR TO LONG
	strConfName                 :	PTR TO LONG
	strConfNum                  :	PTR TO LONG
	btnNextConf                 :	PTR TO LONG
	btnLastConf                 :	PTR TO LONG
	btnAddConf                  :	PTR TO LONG
	btnConfClone                :	PTR TO LONG
	btnRemoveConf               :	PTR TO LONG
	gr_conf_pages               :	PTR TO LONG
	gr_conf_settings            :	PTR TO LONG
	gr_conf_more                :	PTR TO LONG
	lv_download_paths           :	PTR TO LONG
	pa_downloadpath             :	PTR TO LONG
	stR_PA_downloadpath         :	PTR TO LONG
	bt_dlpath_add               :	PTR TO LONG
	bt_dlpath_remove            :	PTR TO LONG
	lv_upload_paths             :	PTR TO LONG
	pa_uploadpath               :	PTR TO LONG
	stR_PA_uploadpath           :	PTR TO LONG
	bt_ulpath_add               :	PTR TO LONG
	bt_ulpath_remove            :	PTR TO LONG
	lvMsgbases                  :	PTR TO LONG
	btnMsgbaseAdd               :	PTR TO LONG
	btnMsgbaseEdit              :	PTR TO LONG
	btnMsgbaseDelete            :	PTR TO LONG
	btnSaveConf                 :	PTR TO LONG
	btnCancelConf               :	PTR TO LONG
	wi_nodeEdit                 :	PTR TO LONG
	btnFirstNode                :	PTR TO LONG
	btnPrevNode                 :	PTR TO LONG
	str_Node_Number             :	PTR TO LONG
	btnNextNode                 :	PTR TO LONG
	btnLastNode                 :	PTR TO LONG
	btnAddNode                  :	PTR TO LONG
	btnNodeClone                :	PTR TO LONG
	btnRemoveNode               :	PTR TO LONG
	gr_node_pages               :	PTR TO LONG
	gr_node_settings            :	PTR TO LONG
	gr_node_second_settings     :	PTR TO LONG
	gr_node_more_settings       :	PTR TO LONG
	gr_node_serial_settings     :	PTR TO LONG
	gr_node_window_settings     :	PTR TO LONG
	gr_node_time_settings       :	PTR TO LONG
	str300start                 :	PTR TO LONG
	str300end                   :	PTR TO LONG
	str1200start                :	PTR TO LONG
	str1200end                  :	PTR TO LONG
	str2400start                :	PTR TO LONG
	str2400end                  :	PTR TO LONG
	str4800start                :	PTR TO LONG
	str4800end                  :	PTR TO LONG
	str9600start                :	PTR TO LONG
	str9600end                  :	PTR TO LONG
	str12000start               :	PTR TO LONG
	str12000end                 :	PTR TO LONG
	str14400start               :	PTR TO LONG
	str14400end                 :	PTR TO LONG
	str16800start               :	PTR TO LONG
	str16800end                 :	PTR TO LONG
	str19200start               :	PTR TO LONG
	str19200end                 :	PTR TO LONG
	str21600start               :	PTR TO LONG
	str21600end                 :	PTR TO LONG
	str24000start               :	PTR TO LONG
	str24000end                 :	PTR TO LONG
	str26400start               :	PTR TO LONG
	str26400end                 :	PTR TO LONG
	str28800start               :	PTR TO LONG
	str28800end                 :	PTR TO LONG
	str31200start               :	PTR TO LONG
	str31200end                 :	PTR TO LONG
	str33600start               :	PTR TO LONG
	str33600end                 :	PTR TO LONG
	str38400start               :	PTR TO LONG
	str38400end                 :	PTR TO LONG
	str57600start               :	PTR TO LONG
	str57600end                 :	PTR TO LONG
	str115200start              :	PTR TO LONG
	str115200end                :	PTR TO LONG
	btnNodeSave                 :	PTR TO LONG
	btnNodeCancel               :	PTR TO LONG
	wi_listEdit                 :	PTR TO LONG
	grp_arrange                 :	PTR TO LONG
	lv_list                     :	PTR TO LONG
	grp_computers_add           :	PTR TO LONG
	strListItem                 :	PTR TO LONG
	btnItemAdd                  :	PTR TO LONG
	btnItemEdit                 :	PTR TO LONG
	btnItemRemove               :	PTR TO LONG
	btnListSave                 :	PTR TO LONG
	btnListCancel               :	PTR TO LONG
	wi_security                 :	PTR TO LONG
	btnAccess                   :	PTR TO LONG
	btnAreas                    :	PTR TO LONG
	btnPresets                  :	PTR TO LONG
	wi_systemdata               :	PTR TO LONG
	gr_settings                 :	PTR TO LONG
	btnSettingsSave             :	PTR TO LONG
	btnSettingsCancel           :	PTR TO LONG
	wi_add_item                 :	PTR TO LONG
	gr_item_detail1             :	PTR TO LONG
	la_item_detail1             :	PTR TO LONG
	stR_item_detail1e           :	PTR TO LONG
	gr_item_detail2             :	PTR TO LONG
	la_item_detail2             :	PTR TO LONG
	stR_item_detail2            :	PTR TO LONG
	bt_new_item_save            :	PTR TO LONG
	bt_new_item_cancel          :	PTR TO LONG
	wi_presets                  :	PTR TO LONG
	ra_presets                  :	PTR TO LONG
	gr_preset_settings          :	PTR TO LONG
	btnPresetSave               :	PTR TO LONG
	btnPresetClose              :	PTR TO LONG
	wi_areas                    :	PTR TO LONG
	la_area                     :	PTR TO LONG
	stR_area                    :	PTR TO LONG
	gr_area_main                :	PTR TO LONG
	bt_area_save                :	PTR TO LONG
	bt_area_cancel              :	PTR TO LONG
	wi_commands                 :	PTR TO LONG
	grpCommands                 :	PTR TO LONG
	btnBBSCmd                   :	PTR TO LONG
	btnSysCmd                   :	PTR TO LONG
	winTools                    :	PTR TO LONG
	tx_label_3                  :	PTR TO LONG
	txtAcpStatus                :	PTR TO LONG
	tx_label_4                  :	PTR TO LONG
	txtNodeCount                :	PTR TO LONG
	tx_label_6                  :	PTR TO LONG
	txtConfCount                :	PTR TO LONG
	btnShutdown                 :	PTR TO LONG
	btnStart                    :	PTR TO LONG
	btnRestart                  :	PTR TO LONG
	btnClose                    :	PTR TO LONG
	stR_TX_label_0              :	PTR TO CHAR
	stR_TX_label_3              :	PTR TO CHAR
	stR_txtAcpStatus            :	PTR TO CHAR
	stR_TX_label_4              :	PTR TO CHAR
	stR_txtNodeCount            :	PTR TO CHAR
	stR_TX_label_6              :	PTR TO CHAR
	stR_txtConfCount            :	PTR TO CHAR
	stR_gr_conf_pages           :	PTR TO LONG
	stR_gr_node_pages           :	PTR TO LONG
	ra_presetsContent           :	PTR TO LONG
ENDOBJECT


->/////////////////////////////////////////////////////////////////////////////
->/////////// Creates one instance of one object or the whole application /////
->/////////////////////////////////////////////////////////////////////////////
PROC create( display : PTR TO app_display ) OF app_obj

	DEF mnlabel1File , mnlabel1Settings , mnlabel1ConferenceDelete
	DEF grOUP_ROOT_0 , gr_grp_1 , gr_grp_2 , grOUP_ROOT_2
	DEF gr_confselect , obj_aux0 , obj_aux1 , obj_aux2 , obj_aux3
	DEF gr_grp_13 , gr_downloadpaths , gr_grp_20 , gr_uploadpaths
	DEF gr_grp_22 , gr_messagebases , gr_grp_46 , gr_save
	DEF grOUP_ROOT_3 , gr_nodeSelect , obj_aux4 , obj_aux5
	DEF gr_grp_50 , lbl300start , lbl300end , lbl1200start
	DEF lbl1200end , lbl2400start , lbl2400end , lbl4800start
	DEF lbl4800end , lbl9600start , lbl9600end , lbl12000start
	DEF lbl12000end , lbl14400start , lbl14400end , lbl16800start
	DEF lbl16800end , lbl19200start , lbl19200end , lbl21600start
	DEF lbl21600end , lbl24000start , lbl24000end , lbl26400start
	DEF lbl26400end , lbl28800start , lbl28800end , lbl31200start
	DEF lbl31200end , lbl33600start , lbl33600end , lbl38400start
	DEF lbl38400end , lbl57600start , lbl57600end , lbl115200start
	DEF lbl115200end , gr_nodesave , grp_root_listitems , space_28
	DEF gr_grp_28 , grOUP_ROOT_5 , grOUP_ROOT_6
	DEF gr_settingsSaveCancel , grOUP_ROOT_7 , gr_item_buttons
	DEF grOUP_ROOT_8 , gr_grp_39 , gr_grp_36 , gr_grp_38
	DEF grOUP_ROOT_9 , gr_grp_43 , gr_area_save , grOUP_ROOT_11
	DEF gr_grp_48 , space_29 , gr_grp_49 , space_30

	self.stR_TX_label_0              := '\ec/X\nSetup Tool'
	self.stR_TX_label_3              := 'ACP Status'
	self.stR_txtAcpStatus            := NIL
	self.stR_TX_label_4              := 'Nodes'
	self.stR_txtNodeCount            := NIL
	self.stR_TX_label_6              := 'Conferences'
	self.stR_txtConfCount            := NIL
	self.stR_gr_conf_pages           := [
		'Main' ,
		'More' ,
		'Download Paths' ,
		'Upload Paths' ,
		'Message bases' ,
		NIL ]
	self.stR_gr_node_pages           := [
		'Main' ,
		'Second' ,
		'More' ,
		'Serial/Modem' ,
		'Window' ,
		'Time restrictions' ,
		NIL ]
	self.ra_presetsContent           := [
		'1' ,
		'2' ,
		'3' ,
		'4' ,
		'5' ,
		'6' ,
		'7' ,
		'8' ,
		'9' ,
		NIL ]

	self.btnSystem := SimpleButton( 'System' )

	self.btnServer := SimpleButton( 'Server' )

	self.btnBackup := SimpleButton( 'Backup' )

	self.btnRestrict := SimpleButton( 'Restricted' )

	self.btnNodes := SimpleButton( 'Nodes' )

	self.btnConfs := SimpleButton( 'Conferences' )

	self.btnSecurity := SimpleButton( 'Security' )

	self.btnCommands := SimpleButton( 'Commands' )

	self.btnComputers := SimpleButton( 'Computers' )

	self.btnProtocols := SimpleButton( 'Protocols' )

	self.btnNamesNotAllowed := SimpleButton( 'Names Not Allowed' )

	self.btnScreenTypes := SimpleButton( 'Screen Types' )

	self.btnLanguages := SimpleButton( 'Languages' )

	self.btnDrives := SimpleButton( 'Drives' )

	self.btnCheckers := SimpleButton( 'File Checkers' )

	self.btnConnect := SimpleButton( 'Connect' )

	self.btnZoom := SimpleButton( 'Zoom' )

	self.btnUsers := SimpleButton( 'Users' )

	gr_grp_1 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_1' ,
		MUIA_Weight , 66 ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Group_Columns , 3 ,
		Child , self.btnSystem ,
		Child , self.btnServer ,
		Child , self.btnBackup ,
		Child , self.btnRestrict ,
		Child , self.btnNodes ,
		Child , self.btnConfs ,
		Child , self.btnSecurity ,
		Child , self.btnCommands ,
		Child , self.btnComputers ,
		Child , self.btnProtocols ,
		Child , self.btnNamesNotAllowed ,
		Child , self.btnScreenTypes ,
		Child , self.btnLanguages ,
		Child , self.btnDrives ,
		Child , self.btnCheckers ,
		Child , self.btnConnect ,
		Child , self.btnZoom ,
		Child , self.btnUsers ,
	End

	self.tx_label_0 := TextObject ,
		MUIA_Background , MUII_TextBack ,
		MUIA_Frame , MUIV_Frame_Group ,
		MUIA_Text_Contents , self.stR_TX_label_0 ,
		MUIA_Text_SetMin , MUI_TRUE ,
	End

	self.gr_ax_image := GroupObject ,
		MUIA_HelpNode , 'GR_ax_image' ,
	End

	self.btnAbout := SimpleButton( 'About' )

	self.btnTools := SimpleButton( 'Tools' )

	self.btnExit := SimpleButton( 'Exit' )

	gr_grp_2 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_2' ,
		MUIA_Weight , 32 ,
		MUIA_Frame , MUIV_Frame_Button ,
		MUIA_Group_SameWidth , MUI_TRUE ,
		MUIA_Group_VertSpacing , 5 ,
		Child , self.tx_label_0 ,
		Child , self.gr_ax_image ,
		Child , self.btnAbout ,
		Child , self.btnTools ,
		Child , self.btnExit ,
	End

	grOUP_ROOT_0 := GroupObject ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , gr_grp_1 ,
		Child , gr_grp_2 ,
	End

	self.mnlabel1About := MenuitemObject ,
		MUIA_Menuitem_Title , 'About' ,
	End

	self.mnlabel1AboutMui := MenuitemObject ,
		MUIA_Menuitem_Title , 'About Mui...' ,
	End

	self.mnlabel1Exit := MenuitemObject ,
		MUIA_Menuitem_Title , 'Exit' ,
	End

	mnlabel1File := MenuitemObject ,
		MUIA_Menuitem_Title , 'File' ,
		MUIA_Family_Child , self.mnlabel1About ,
		MUIA_Family_Child , self.mnlabel1AboutMui ,
		MUIA_Family_Child , self.mnlabel1Exit ,
	End

	self.mnlabel1Donotremovefolder1 := MenuitemObject ,
		MUIA_Menuitem_Title , 'Do not remove folder' ,
		MUIA_Menuitem_Checkit , MUI_TRUE ,
	End

	self.mnlabel1Removefolder1 := MenuitemObject ,
		MUIA_Menuitem_Title , 'Remove Folder' ,
		MUIA_Menuitem_Checkit , MUI_TRUE ,
	End

	self.mnlabel1Ask1 := MenuitemObject ,
		MUIA_Menuitem_Title , 'Ask' ,
		MUIA_Menuitem_Checkit , MUI_TRUE ,
	End

	mnlabel1ConferenceDelete := MenuitemObject ,
		MUIA_Menuitem_Title , 'Conference Delete' ,
		MUIA_Family_Child , self.mnlabel1Donotremovefolder1 ,
		MUIA_Family_Child , self.mnlabel1Removefolder1 ,
		MUIA_Family_Child , self.mnlabel1Ask1 ,
	End

	self.mnlabel1Donotremovefolder2 := MenuitemObject ,
		MUIA_Menuitem_Title , 'Do not remove folder' ,
		MUIA_Menuitem_Checkit , MUI_TRUE ,
	End

	self.mnlabel1Removefolder2 := MenuitemObject ,
		MUIA_Menuitem_Title , 'Remove Folder' ,
		MUIA_Menuitem_Checkit , MUI_TRUE ,
	End

	self.mnlabel1Ask2 := MenuitemObject ,
		MUIA_Menuitem_Title , 'Ask' ,
		MUIA_Menuitem_Checkit , MUI_TRUE ,
	End

	self.mnlabel1NodeDelete := MenuitemObject ,
		MUIA_Menuitem_Title , 'Node Delete' ,
		MUIA_Family_Child , self.mnlabel1Donotremovefolder2 ,
		MUIA_Family_Child , self.mnlabel1Removefolder2 ,
		MUIA_Family_Child , self.mnlabel1Ask2 ,
	End

	mnlabel1Settings := MenuitemObject ,
		MUIA_Menuitem_Title , 'Settings' ,
		MUIA_Family_Child , mnlabel1ConferenceDelete ,
		MUIA_Family_Child , self.mnlabel1NodeDelete ,
	End

	self.mn_label_1 := MenustripObject ,
		MUIA_Family_Child , mnlabel1File ,
		MUIA_Family_Child , mnlabel1Settings ,
	End

	self.winMain := WindowObject ,
		MUIA_Window_Title , 'Ami-Express Setup Tool' ,
		MUIA_Window_Menustrip , self.mn_label_1 ,
		MUIA_Window_ID , "0WIN" ,
		MUIA_Window_AppWindow , MUI_TRUE ,
		WindowContents , grOUP_ROOT_0 ,
	End

	self.btnFirstConf := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , '<<' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnFirstConf' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnPrevConf := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , '<' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnPrevConf' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.strConfName := StringObject ,
		MUIA_Disabled , MUI_TRUE ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strConfName' ,
	End

	obj_aux1 := Label2( 'Conference' )

	obj_aux0 := GroupObject ,
		MUIA_Group_Columns , 2 ,
		Child , obj_aux1 ,
		Child , self.strConfName ,
	End

	self.strConfNum := StringObject ,
		MUIA_Disabled , MUI_TRUE ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strConfNum' ,
		MUIA_String_Accept , '-0123456789' ,
	End

	obj_aux3 := Label2( 'Number' )

	obj_aux2 := GroupObject ,
		MUIA_Group_Columns , 2 ,
		MUIA_Weight , 0 ,
		Child , obj_aux3 ,
		Child , self.strConfNum ,
	End

	self.btnNextConf := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , '>' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnNextConf' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnLastConf := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , '>>' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnLastConf' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnAddConf := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Add' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnAddConf' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnConfClone := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Clone' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnConfClone' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnRemoveConf := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Remove' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnRemoveConf' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	gr_confselect := GroupObject ,
		MUIA_HelpNode , 'GR_confselect' ,
		MUIA_Frame , MUIV_Frame_Group ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnFirstConf ,
		Child , self.btnPrevConf ,
		Child , obj_aux0 ,
		Child , obj_aux2 ,
		Child , self.btnNextConf ,
		Child , self.btnLastConf ,
		Child , self.btnAddConf ,
		Child , self.btnConfClone ,
		Child , self.btnRemoveConf ,
	End

	self.gr_conf_settings := VirtgroupObject ,
		VirtualFrame ,
		MUIA_HelpNode , 'GR_conf_settings' ,
		MUIA_Group_Columns , 4 ,
		MUIA_Group_HorizSpacing , 4 ,
	End

	self.gr_conf_settings := ScrollgroupObject ,
		MUIA_Scrollgroup_Contents , self.gr_conf_settings ,
	End

	self.gr_conf_more := VirtgroupObject ,
		VirtualFrame ,
		MUIA_HelpNode , 'GR_conf_more' ,
		MUIA_Group_Columns , 4 ,
		MUIA_Group_HorizSpacing , 4 ,
	End

	self.gr_conf_more := ScrollgroupObject ,
		MUIA_Scrollgroup_Contents , self.gr_conf_more ,
	End

	self.lv_download_paths := ListObject ,
		MUIA_Frame , MUIV_Frame_InputList ,
	End

	self.lv_download_paths := ListviewObject ,
		MUIA_HelpNode , 'LV_download_paths' ,
		MUIA_Listview_MultiSelect , MUIV_Listview_MultiSelect_Default ,
		MUIA_Listview_List , self.lv_download_paths ,
	End

	self.stR_PA_downloadpath := StringMUI( '' , 80 )

	self.pa_downloadpath := PopButton( MUII_PopDrawer )

	self.pa_downloadpath := PopaslObject ,
		MUIA_HelpNode , 'PA_downloadpath' ,
		MUIA_Popasl_Type , 0 ,
		MUIA_Popstring_String , self.stR_PA_downloadpath ,
		MUIA_Popstring_Button , self.pa_downloadpath ,
	End

	self.bt_dlpath_add := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Add' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'BT_dlpath_add' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.bt_dlpath_remove := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Remove' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'BT_dlpath_remove' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	gr_grp_20 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_20' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.pa_downloadpath ,
		Child , self.bt_dlpath_add ,
		Child , self.bt_dlpath_remove ,
	End

	gr_downloadpaths := GroupObject ,
		MUIA_HelpNode , 'GR_downloadpaths' ,
		Child , self.lv_download_paths ,
		Child , gr_grp_20 ,
	End

	self.lv_upload_paths := ListObject ,
		MUIA_Frame , MUIV_Frame_InputList ,
	End

	self.lv_upload_paths := ListviewObject ,
		MUIA_HelpNode , 'LV_upload_paths' ,
		MUIA_Listview_MultiSelect , MUIV_Listview_MultiSelect_Default ,
		MUIA_Listview_List , self.lv_upload_paths ,
	End

	self.stR_PA_uploadpath := StringMUI( '' , 80 )

	self.pa_uploadpath := PopButton( MUII_PopDrawer )

	self.pa_uploadpath := PopaslObject ,
		MUIA_HelpNode , 'PA_uploadpath' ,
		MUIA_Popasl_Type , 0 ,
		MUIA_Popstring_String , self.stR_PA_uploadpath ,
		MUIA_Popstring_Button , self.pa_uploadpath ,
	End

	self.bt_ulpath_add := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Add' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'BT_ulpath_add' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.bt_ulpath_remove := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Remove' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'BT_ulpath_remove' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	gr_grp_22 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_22' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.pa_uploadpath ,
		Child , self.bt_ulpath_add ,
		Child , self.bt_ulpath_remove ,
	End

	gr_uploadpaths := GroupObject ,
		MUIA_HelpNode , 'GR_uploadpaths' ,
		Child , self.lv_upload_paths ,
		Child , gr_grp_22 ,
	End

	self.lvMsgbases := ListObject ,
		MUIA_Frame , MUIV_Frame_InputList ,
	End

	self.lvMsgbases := ListviewObject ,
		MUIA_HelpNode , 'lvMsgbases' ,
		MUIA_Listview_MultiSelect , MUIV_Listview_MultiSelect_Default ,
		MUIA_Listview_List , self.lvMsgbases ,
	End

	self.btnMsgbaseAdd := SimpleButton( 'Add' )

	self.btnMsgbaseEdit := SimpleButton( 'Edit' )

	self.btnMsgbaseDelete := SimpleButton( 'Remove' )

	gr_grp_46 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_46' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnMsgbaseAdd ,
		Child , self.btnMsgbaseEdit ,
		Child , self.btnMsgbaseDelete ,
	End

	gr_messagebases := GroupObject ,
		MUIA_HelpNode , 'GR_messagebases' ,
		Child , self.lvMsgbases ,
		Child , gr_grp_46 ,
	End

	self.gr_conf_pages := RegisterObject ,
		MUIA_Register_Titles , self.stR_gr_conf_pages ,
		MUIA_HelpNode , 'gr_conf_pages' ,
		Child , self.gr_conf_settings ,
		Child , self.gr_conf_more ,
		Child , gr_downloadpaths ,
		Child , gr_uploadpaths ,
		Child , gr_messagebases ,
	End

	gr_grp_13 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_13' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.gr_conf_pages ,
	End

	self.btnSaveConf := SimpleButton( 'Save' )

	self.btnCancelConf := SimpleButton( 'Close' )

	gr_save := GroupObject ,
		MUIA_HelpNode , 'GR_save' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnSaveConf ,
		Child , self.btnCancelConf ,
	End

	grOUP_ROOT_2 := GroupObject ,
		Child , gr_confselect ,
		Child , gr_grp_13 ,
		Child , gr_save ,
	End

	self.wi_conf_edit := WindowObject ,
		MUIA_Window_Title , 'Conference Editor' ,
		MUIA_Window_ID , "1WIN" ,
		WindowContents , grOUP_ROOT_2 ,
	End

	self.btnFirstNode := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , '<<' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnFirstNode' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnPrevNode := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , '<' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnPrevNode' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.str_Node_Number := StringObject ,
		MUIA_Disabled , MUI_TRUE ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str_Node_Number' ,
		MUIA_String_Accept , '-0123456789' ,
	End

	obj_aux5 := Label2( 'Node Number' )

	obj_aux4 := GroupObject ,
		MUIA_Group_Columns , 2 ,
		Child , obj_aux5 ,
		Child , self.str_Node_Number ,
	End

	self.btnNextNode := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , '>' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnNextNode' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnLastNode := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , '>>' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnLastNode' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnAddNode := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Add' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnAddNode' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnNodeClone := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Clone' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnNodeClone' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnRemoveNode := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Remove' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnRemoveNode' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	gr_nodeSelect := GroupObject ,
		MUIA_HelpNode , 'GR_nodeSelect' ,
		MUIA_Frame , MUIV_Frame_Group ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnFirstNode ,
		Child , self.btnPrevNode ,
		Child , obj_aux4 ,
		Child , self.btnNextNode ,
		Child , self.btnLastNode ,
		Child , self.btnAddNode ,
		Child , self.btnNodeClone ,
		Child , self.btnRemoveNode ,
	End

	self.gr_node_settings := VirtgroupObject ,
		VirtualFrame ,
		MUIA_HelpNode , 'GR_node_settings' ,
		MUIA_Group_Columns , 4 ,
		MUIA_Group_HorizSpacing , 4 ,
	End

	self.gr_node_settings := ScrollgroupObject ,
		MUIA_Scrollgroup_Contents , self.gr_node_settings ,
	End

	self.gr_node_second_settings := VirtgroupObject ,
		VirtualFrame ,
		MUIA_HelpNode , 'GR_node_second_settings' ,
		MUIA_Group_Columns , 2 ,
		MUIA_Group_HorizSpacing , 4 ,
	End

	self.gr_node_second_settings := ScrollgroupObject ,
		MUIA_Scrollgroup_Contents , self.gr_node_second_settings ,
	End

	self.gr_node_more_settings := VirtgroupObject ,
		VirtualFrame ,
		MUIA_HelpNode , 'GR_node_more_settings' ,
		MUIA_Group_Columns , 2 ,
		MUIA_Group_HorizSpacing , 4 ,
	End

	self.gr_node_more_settings := ScrollgroupObject ,
		MUIA_Scrollgroup_Contents , self.gr_node_more_settings ,
	End

	self.gr_node_serial_settings := VirtgroupObject ,
		VirtualFrame ,
		MUIA_HelpNode , 'GR_node_serial_settings' ,
		MUIA_Group_HorizSpacing , 4 ,
	End

	self.gr_node_serial_settings := ScrollgroupObject ,
		MUIA_Scrollgroup_Contents , self.gr_node_serial_settings ,
	End

	self.gr_node_window_settings := VirtgroupObject ,
		VirtualFrame ,
		MUIA_HelpNode , 'GR_node_window_settings' ,
		MUIA_Group_HorizSpacing , 4 ,
	End

	self.gr_node_window_settings := ScrollgroupObject ,
		MUIA_Scrollgroup_Contents , self.gr_node_window_settings ,
	End

	lbl300start := Label( '300 Baud' )

	self.str300start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str300start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl300end := Label( '\ecto' )

	self.str300end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str300end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl1200start := Label( '1200 Baud' )

	self.str1200start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str1200start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl1200end := Label( '\ecto' )

	self.str1200end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str1200end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl2400start := Label( '2400 Baud' )

	self.str2400start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str2400start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl2400end := Label( '\ecto' )

	self.str2400end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str2400end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl4800start := Label( '4800 Baud' )

	self.str4800start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str4800start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl4800end := Label( '\ecto' )

	self.str4800end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str4800end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl9600start := Label( '9600 Baud' )

	self.str9600start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str9600start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl9600end := Label( '\ecto' )

	self.str9600end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str9600end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl12000start := Label( '12000 Baud' )

	self.str12000start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str12000start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl12000end := Label( '\ecto' )

	self.str12000end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str12000end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl14400start := Label( '14400 Baud' )

	self.str14400start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str14400start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl14400end := Label( '\ecto' )

	self.str14400end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str14400end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl16800start := Label( '16800 Baud' )

	self.str16800start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str16800start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl16800end := Label( '\ecto' )

	self.str16800end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str16800end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl19200start := Label( '19200 Baud' )

	self.str19200start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str19200start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl19200end := Label( '\ecto' )

	self.str19200end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str19200end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl21600start := Label( '21600 Baud' )

	self.str21600start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str21600start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl21600end := Label( '\ecto' )

	self.str21600end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str21600end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl24000start := Label( '24000 Baud' )

	self.str24000start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str24000start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl24000end := Label( '\ecto' )

	self.str24000end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str24000end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl26400start := Label( '26400 Baud' )

	self.str26400start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str26400start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl26400end := Label( '\ecto' )

	self.str26400end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str26400end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl28800start := Label( '28800 Baud' )

	self.str28800start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str28800start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl28800end := Label( '\ecto' )

	self.str28800end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str28800end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl31200start := Label( '31200 Baud' )

	self.str31200start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str31200start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl31200end := Label( '\ecto' )

	self.str31200end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str31200end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl33600start := Label( '33600 Baud' )

	self.str33600start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str33600start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl33600end := Label( '\ecto' )

	self.str33600end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str33600end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl38400start := Label( '38400 Baud' )

	self.str38400start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str38400start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl38400end := Label( '\ecto' )

	self.str38400end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str38400end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl57600start := Label( '57600 Baud' )

	self.str57600start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str57600start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl57600end := Label( '\ecto' )

	self.str57600end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str57600end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl115200start := Label( '115200 Baud' )

	self.str115200start := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str115200start' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	lbl115200end := Label( '\ecto' )

	self.str115200end := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'str115200end' ,
		MUIA_String_Accept , '0123456789' ,
		MUIA_String_MaxLen , 5 ,
	End

	self.gr_node_time_settings := VirtgroupObject ,
		VirtualFrame ,
		MUIA_HelpNode , 'GR_node_time_settings' ,
		MUIA_Group_Columns , 4 ,
		MUIA_Group_SameWidth , MUI_TRUE ,
		MUIA_Group_HorizSpacing , 4 ,
		Child , lbl300start ,
		Child , self.str300start ,
		Child , lbl300end ,
		Child , self.str300end ,
		Child , lbl1200start ,
		Child , self.str1200start ,
		Child , lbl1200end ,
		Child , self.str1200end ,
		Child , lbl2400start ,
		Child , self.str2400start ,
		Child , lbl2400end ,
		Child , self.str2400end ,
		Child , lbl4800start ,
		Child , self.str4800start ,
		Child , lbl4800end ,
		Child , self.str4800end ,
		Child , lbl9600start ,
		Child , self.str9600start ,
		Child , lbl9600end ,
		Child , self.str9600end ,
		Child , lbl12000start ,
		Child , self.str12000start ,
		Child , lbl12000end ,
		Child , self.str12000end ,
		Child , lbl14400start ,
		Child , self.str14400start ,
		Child , lbl14400end ,
		Child , self.str14400end ,
		Child , lbl16800start ,
		Child , self.str16800start ,
		Child , lbl16800end ,
		Child , self.str16800end ,
		Child , lbl19200start ,
		Child , self.str19200start ,
		Child , lbl19200end ,
		Child , self.str19200end ,
		Child , lbl21600start ,
		Child , self.str21600start ,
		Child , lbl21600end ,
		Child , self.str21600end ,
		Child , lbl24000start ,
		Child , self.str24000start ,
		Child , lbl24000end ,
		Child , self.str24000end ,
		Child , lbl26400start ,
		Child , self.str26400start ,
		Child , lbl26400end ,
		Child , self.str26400end ,
		Child , lbl28800start ,
		Child , self.str28800start ,
		Child , lbl28800end ,
		Child , self.str28800end ,
		Child , lbl31200start ,
		Child , self.str31200start ,
		Child , lbl31200end ,
		Child , self.str31200end ,
		Child , lbl33600start ,
		Child , self.str33600start ,
		Child , lbl33600end ,
		Child , self.str33600end ,
		Child , lbl38400start ,
		Child , self.str38400start ,
		Child , lbl38400end ,
		Child , self.str38400end ,
		Child , lbl57600start ,
		Child , self.str57600start ,
		Child , lbl57600end ,
		Child , self.str57600end ,
		Child , lbl115200start ,
		Child , self.str115200start ,
		Child , lbl115200end ,
		Child , self.str115200end ,
	End

	self.gr_node_time_settings := ScrollgroupObject ,
		MUIA_Scrollgroup_Contents , self.gr_node_time_settings ,
	End

	self.gr_node_pages := RegisterObject ,
		MUIA_Register_Titles , self.stR_gr_node_pages ,
		MUIA_HelpNode , 'gr_node_pages' ,
		Child , self.gr_node_settings ,
		Child , self.gr_node_second_settings ,
		Child , self.gr_node_more_settings ,
		Child , self.gr_node_serial_settings ,
		Child , self.gr_node_window_settings ,
		Child , self.gr_node_time_settings ,
	End

	gr_grp_50 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_50' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.gr_node_pages ,
	End

	self.btnNodeSave := SimpleButton( 'Save' )

	self.btnNodeCancel := SimpleButton( 'Close' )

	gr_nodesave := GroupObject ,
		MUIA_HelpNode , 'GR_nodesave' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnNodeSave ,
		Child , self.btnNodeCancel ,
	End

	grOUP_ROOT_3 := GroupObject ,
		Child , gr_nodeSelect ,
		Child , gr_grp_50 ,
		Child , gr_nodesave ,
	End

	self.wi_nodeEdit := WindowObject ,
		MUIA_Window_Title , 'Node Editor' ,
		MUIA_Window_ID , "2WIN" ,
		WindowContents , grOUP_ROOT_3 ,
	End

	self.lv_list := ListObject ,
		MUIA_Frame , MUIV_Frame_InputList ,
	End

	self.lv_list := ListviewObject ,
		MUIA_HelpNode , 'LV_list' ,
		MUIA_Listview_MultiSelect , MUIV_Listview_MultiSelect_Default ,
		MUIA_Listview_List , self.lv_list ,
	End

	self.strListItem := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'strListItem' ,
	End

	self.btnItemAdd := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Add' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnItemAdd' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnItemEdit := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Edit' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnItemEdit' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	self.btnItemRemove := TextObject ,
		ButtonFrame ,
		MUIA_Weight , 0 ,
		MUIA_Background , MUII_ButtonBack ,
		MUIA_Text_Contents , 'Remove' ,
		MUIA_Text_PreParse , '\ec' ,
		MUIA_HelpNode , 'btnItemRemove' ,
		MUIA_InputMode , MUIV_InputMode_RelVerify ,
	End

	space_28 := VSpace( 0 )

	self.grp_computers_add := GroupObject ,
		MUIA_HelpNode , 'grp_computers_add' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.strListItem ,
		Child , self.btnItemAdd ,
		Child , self.btnItemEdit ,
		Child , self.btnItemRemove ,
		Child , space_28 ,
	End

	self.grp_arrange := GroupObject ,
		MUIA_HelpNode , 'grp_arrange' ,
		Child , self.lv_list ,
		Child , self.grp_computers_add ,
	End

	self.btnListSave := SimpleButton( 'Save' )

	self.btnListCancel := SimpleButton( 'Close' )

	gr_grp_28 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_28' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnListSave ,
		Child , self.btnListCancel ,
	End

	grp_root_listitems := GroupObject ,
		Child , self.grp_arrange ,
		Child , gr_grp_28 ,
	End

	self.wi_listEdit := WindowObject ,
		MUIA_Window_Title , 'Edit <xxx>' ,
		MUIA_Window_ID , "3WIN" ,
		WindowContents , grp_root_listitems ,
	End

	self.btnAccess := SimpleButton( 'Access Levels' )

	self.btnAreas := SimpleButton( 'Areas' )

	self.btnPresets := SimpleButton( 'Presets' )

	grOUP_ROOT_5 := GroupObject ,
		Child , self.btnAccess ,
		Child , self.btnAreas ,
		Child , self.btnPresets ,
	End

	self.wi_security := WindowObject ,
		MUIA_Window_Title , 'Security' ,
		MUIA_Window_ID , "4WIN" ,
		WindowContents , grOUP_ROOT_5 ,
	End

	self.gr_settings := VirtgroupObject ,
		VirtualFrame ,
		MUIA_HelpNode , 'GR_settings' ,
		MUIA_Group_Columns , 2 ,
	End

	self.gr_settings := ScrollgroupObject ,
		MUIA_Scrollgroup_Contents , self.gr_settings ,
	End

	self.btnSettingsSave := SimpleButton( 'Save' )

	self.btnSettingsCancel := SimpleButton( 'Close' )

	gr_settingsSaveCancel := GroupObject ,
		MUIA_HelpNode , 'GR_settingsSaveCancel' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnSettingsSave ,
		Child , self.btnSettingsCancel ,
	End

	grOUP_ROOT_6 := GroupObject ,
		Child , self.gr_settings ,
		Child , gr_settingsSaveCancel ,
	End

	self.wi_systemdata := WindowObject ,
		MUIA_Window_Title , 'System Data' ,
		MUIA_Window_ID , "5WIN" ,
		WindowContents , grOUP_ROOT_6 ,
	End

	self.la_item_detail1 := Label( 'item label' )

	self.stR_item_detail1e := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'STR_item_detail1e' ,
	End

	self.gr_item_detail1 := GroupObject ,
		MUIA_HelpNode , 'GR_item_detail1' ,
		MUIA_Group_Columns , 2 ,
		Child , self.la_item_detail1 ,
		Child , self.stR_item_detail1e ,
	End

	self.la_item_detail2 := Label( 'detail' )

	self.stR_item_detail2 := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'STR_item_detail2' ,
	End

	self.gr_item_detail2 := GroupObject ,
		MUIA_HelpNode , 'GR_item_detail2' ,
		MUIA_Group_Columns , 2 ,
		Child , self.la_item_detail2 ,
		Child , self.stR_item_detail2 ,
	End

	self.bt_new_item_save := SimpleButton( 'Ok' )

	self.bt_new_item_cancel := SimpleButton( 'Cancel' )

	gr_item_buttons := GroupObject ,
		MUIA_HelpNode , 'GR_item_buttons' ,
		MUIA_Group_Columns , 2 ,
		Child , self.bt_new_item_save ,
		Child , self.bt_new_item_cancel ,
	End

	grOUP_ROOT_7 := GroupObject ,
		Child , self.gr_item_detail1 ,
		Child , self.gr_item_detail2 ,
		Child , gr_item_buttons ,
	End

	self.wi_add_item := WindowObject ,
		MUIA_Window_Title , 'Add <xxx>' ,
		MUIA_Window_ID , "6WIN" ,
		WindowContents , grOUP_ROOT_7 ,
	End

	self.ra_presets := RadioObject ,
		MUIA_HelpNode , 'RA_presets' ,
		MUIA_Radio_Entries , self.ra_presetsContent ,
	End

	gr_grp_36 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_36' ,
		Child , self.ra_presets ,
	End

	self.gr_preset_settings := GroupObject ,
		MUIA_HelpNode , 'GR_preset_settings' ,
		MUIA_Group_Columns , 2 ,
	End

	gr_grp_39 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_39' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , gr_grp_36 ,
		Child , self.gr_preset_settings ,
	End

	self.btnPresetSave := SimpleButton( 'Save' )

	self.btnPresetClose := SimpleButton( 'Close' )

	gr_grp_38 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_38' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.btnPresetSave ,
		Child , self.btnPresetClose ,
	End

	grOUP_ROOT_8 := GroupObject ,
		Child , gr_grp_39 ,
		Child , gr_grp_38 ,
	End

	self.wi_presets := WindowObject ,
		MUIA_Window_Title , 'Edit Presets' ,
		MUIA_Window_ID , "7WIN" ,
		WindowContents , grOUP_ROOT_8 ,
	End

	self.la_area := Label( 'Area Name' )

	self.stR_area := StringObject ,
		MUIA_Frame , MUIV_Frame_String ,
		MUIA_HelpNode , 'STR_area' ,
	End

	gr_grp_43 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_43' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.la_area ,
		Child , self.stR_area ,
	End

	self.gr_area_main := VirtgroupObject ,
		VirtualFrame ,
		MUIA_HelpNode , 'GR_area_main' ,
		MUIA_Group_Columns , 2 ,
	End

	self.gr_area_main := ScrollgroupObject ,
		MUIA_Scrollgroup_Contents , self.gr_area_main ,
	End

	self.bt_area_save := SimpleButton( 'Ok' )

	self.bt_area_cancel := SimpleButton( 'Cancel' )

	gr_area_save := GroupObject ,
		MUIA_HelpNode , 'GR_area_save' ,
		MUIA_Group_Horiz , MUI_TRUE ,
		Child , self.bt_area_save ,
		Child , self.bt_area_cancel ,
	End

	grOUP_ROOT_9 := GroupObject ,
		Child , gr_grp_43 ,
		Child , self.gr_area_main ,
		Child , gr_area_save ,
	End

	self.wi_areas := WindowObject ,
		MUIA_Window_Title , 'window_title' ,
		MUIA_Window_ID , "8WIN" ,
		WindowContents , grOUP_ROOT_9 ,
	End

	self.btnBBSCmd := SimpleButton( 'Edit BBSCmd' )

	self.btnSysCmd := SimpleButton( 'Edit SysCmd' )

	self.grpCommands := GroupObject ,
		Child , self.btnBBSCmd ,
		Child , self.btnSysCmd ,
	End

	self.wi_commands := WindowObject ,
		MUIA_Window_Title , 'Commands' ,
		MUIA_Window_ID , "9WIN" ,
		WindowContents , self.grpCommands ,
	End

	self.tx_label_3 := TextObject ,
		MUIA_Background , MUII_WindowBack ,
		MUIA_Text_Contents , self.stR_TX_label_3 ,
		MUIA_Text_SetMin , MUI_TRUE ,
	End

	self.txtAcpStatus := TextObject ,
		MUIA_Background , MUII_WindowBack ,
		MUIA_Frame , MUIV_Frame_Text ,
		MUIA_Text_Contents , self.stR_txtAcpStatus ,
		MUIA_Text_SetMin , MUI_TRUE ,
	End

	self.tx_label_4 := TextObject ,
		MUIA_Background , MUII_WindowBack ,
		MUIA_Text_Contents , self.stR_TX_label_4 ,
		MUIA_Text_SetMin , MUI_TRUE ,
	End

	self.txtNodeCount := TextObject ,
		MUIA_Background , MUII_WindowBack ,
		MUIA_Frame , MUIV_Frame_Text ,
		MUIA_Text_Contents , self.stR_txtNodeCount ,
		MUIA_Text_SetMin , MUI_TRUE ,
	End

	self.tx_label_6 := TextObject ,
		MUIA_Background , MUII_WindowBack ,
		MUIA_Text_Contents , self.stR_TX_label_6 ,
		MUIA_Text_SetMin , MUI_TRUE ,
	End

	self.txtConfCount := TextObject ,
		MUIA_Background , MUII_WindowBack ,
		MUIA_Frame , MUIV_Frame_Text ,
		MUIA_Text_Contents , self.stR_txtConfCount ,
		MUIA_Text_SetMin , MUI_TRUE ,
	End

	space_29 := VSpace( 0 )

	gr_grp_48 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_48' ,
		Child , self.tx_label_3 ,
		Child , self.txtAcpStatus ,
		Child , self.tx_label_4 ,
		Child , self.txtNodeCount ,
		Child , self.tx_label_6 ,
		Child , self.txtConfCount ,
		Child , space_29 ,
	End

	self.btnShutdown := SimpleButton( 'Shutdown' )

	self.btnStart := SimpleButton( 'Start' )

	self.btnRestart := SimpleButton( 'Restart' )

	self.btnClose := SimpleButton( 'Close' )

	space_30 := HVSpace

	gr_grp_49 := GroupObject ,
		MUIA_HelpNode , 'GR_grp_49' ,
		MUIA_Weight , 49 ,
		Child , self.btnShutdown ,
		Child , self.btnStart ,
		Child , self.btnRestart ,
		Child , self.btnClose ,
		Child , space_30 ,
	End

	grOUP_ROOT_11 := GroupObject ,
		MUIA_Group_Columns , 2 ,
		Child , gr_grp_48 ,
		Child , gr_grp_49 ,
	End

	self.winTools := WindowObject ,
		MUIA_Window_Title , 'Tools' ,
		MUIA_Window_ID , "10WI" ,
		WindowContents , grOUP_ROOT_11 ,
	End

	self.app := ApplicationObject ,
		//( IF icon THEN MUIA_Application_DiskObject ELSE TAG_IGNORE ) , icon ,
		//( IF arexx THEN MUIA_Application_Commands ELSE TAG_IGNORE ) , ( IF arexx THEN arexx.commands ELSE NIL ) ,
		//( IF arexx THEN MUIA_Application_RexxHook ELSE TAG_IGNORE ) , ( IF arexx THEN arexx.error ELSE NIL ) ,
		//( IF menu THEN MUIA_Application_Menu ELSE TAG_IGNORE ) , menu ,
		MUIA_Application_Author , 'Darren Coles' ,
		MUIA_Application_Base , 'NONE' ,
		MUIA_Application_Title , 'Ami-Express Configuration Editor' ,
		MUIA_Application_Copyright , '(c)2023 Darren Coles' ,
		MUIA_Application_HelpFile , 'axsys.guide' ,
		SubWindow , self.winMain ,
		SubWindow , self.wi_conf_edit ,
		SubWindow , self.wi_nodeEdit ,
		SubWindow , self.wi_listEdit ,
		SubWindow , self.wi_security ,
		SubWindow , self.wi_systemdata ,
		SubWindow , self.wi_add_item ,
		SubWindow , self.wi_presets ,
		SubWindow , self.wi_areas ,
		SubWindow , self.wi_commands ,
		SubWindow , self.winTools ,
	End

ENDPROC self.app


->/////////////////////////////////////////////////////////////////////////////
->////////////////////////// Disposes the object or the whole application /////
->/////////////////////////////////////////////////////////////////////////////
PROC dispose() OF app_obj IS ( IF self.app THEN Mui_DisposeObject( self.app ) ELSE NIL )


