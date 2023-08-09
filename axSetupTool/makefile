# Compile axed

options=DEBUG IGNORECACHE SYM SHOWFNAME ADDBUF 300
compiler=EVO

all:					axSetupTool

release:				options = IGNORECACHE OPTI SHOWFNAME ADDBUF 300
release:			axSetupTool

axSetupTool:	axSetupTool.e frmMain.m axedit.m
							$(compiler) axSetupTool $(options)

axedit.m:			axedit.e
							$(compiler) axedit $(options)

stringlist.m:		../stringlist.e
							$(compiler) /stringlist $(options)

tooltypes.m:	tooltypes.e stringlist.m
							$(compiler) tooltypes $(options)

miscfuncs.m:	miscfuncs.e
							$(compiler) miscfuncs $(options)

controls.m:		controls.e
							$(compiler) controls $(options)

frmBase.m:		frmBase.e axedit.m
							$(compiler) frmBase $(options)

frmMain.m:		frmMain.e frmBase.m axedit.m frmEditList.m frmNodeEdit.m frmConfEdit.m frmSettingsEdit.m frmAccess.m frmCommands.m
							$(compiler) frmMain $(options)

frmEditList.m:	frmEditList.e frmAddItem.m frmBase.m frmAddComplexItem.m tooltypes.m axedit.m stringlist.m miscfuncs.m configobject.m
							$(compiler) frmEditList $(options)

frmSettingsEdit.m:	frmSettingsEdit.e frmBase.m tooltypes.m axedit.m controls.m miscfuncs.m stringlist.m
							$(compiler) frmSettingsEdit $(options)

frmPresetsEdit.m:	frmPresetsEdit.e frmBase.m tooltypes.m axedit.m controls.m miscfuncs.m stringlist.m
							$(compiler) frmPresetsEdit $(options)

frmAddItem.m:	frmAddItem.e frmBase.m axedit.m
							$(compiler) frmAddItem $(options)

frmAddComplexItem.m:	frmAddComplexItem.e frmBase.m axedit.m controls.m stringlist.m tooltypes.m configobject.m
							$(compiler) frmAddComplexItem $(options)

frmConfEdit.m:	frmConfEdit.e frmBase.m tooltypes.m axedit.m controls.m miscfuncs.m frmAddComplexItem.m configobject.m stringlist.m
							$(compiler) frmConfEdit $(options)

frmNodeEdit.m:	frmNodeEdit.e frmBase.m tooltypes.m axedit.m controls.m miscfuncs.m
							$(compiler) frmNodeEdit $(options)

frmAccess.m:	frmAccess.e frmBase.m frmPresetsEdit.m axedit.m frmEditList.m
							$(compiler) frmAccess $(options)

frmCommands.m:	frmCommands.e frmBase.m axedit.m frmEditList.m stringlist.m tooltypes.m
							$(compiler) frmCommands $(options)

configobject.m:	configobject.e stringlist.m
							$(compiler) configobject $(options)
clean:
							delete axSetupTool axedit.m frmAddItem.m frmBase.m frmMain.m frmEditList.m frmNodeEdit.m frmConfEdit.m frmSettingsEdit.m tooltypes.m controls.m frmAccess.m frmCommands.m miscfuncs.m /stringlist.m configobject.m
