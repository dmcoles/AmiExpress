# Compile axUserEditor

debugoptions= IGNORECACHE LARGE NILCHECK  SHOWFNAME ADDBUF 20 DEBUG SYM
releaseoptions=IGNORECACHE OPTI SHOWFNAME ADDBUF 20
compiler=EVO

ifeq ($(build),release)
options=$(releaseoptions)
else
options=$(debugoptions)
endif

all:					axUserEditor

release:			options=$(releaseoptions)
release:			axUserEditor

axUserEditor:	axUserEditor.e frmMain.m axUserObjects.m helpText.m
							$(compiler) axUserEditor $(options)
              
frmMain.m:	frmMain.e frmBase.m frmEditUser.m axuseredit.m axUserObjects.m stringlist.m helpText.m tooltypes.m
							$(compiler) frmMain $(options)              

frmSetPassword.m:	frmSetPassword.e frmBase.m axuseredit.m helpText.m
							$(compiler) frmSetPassword $(options)              

frmBase.m:	frmBase.e axuseredit.m
							$(compiler) frmBase $(options)              

helpText.m:	helpText.e
							$(compiler) helpText $(options)

tooltypes.m:	
							$(compiler) /axSetupTool/tooltypes $(options)              

miscfuncs.m:	
							$(compiler) /axSetupTool/miscfuncs $(options)              

axUserObjects.m:	axUserObjects.e
							$(compiler) axUserObjects $(options)              

frmEditUser.m:	frmEditUser.e frmSetPassword.m frmBase.m axuseredit.m axUserObjects.m tooltypes.m stringlist.m pwdHash.m sha256.m helpText.m
							$(compiler) frmEditUser $(options)              

stringlist.m:	
							$(compiler) /stringlist $(options)

pwdHash.m:	
							$(compiler) /pwdHash $(options)

sha256.m:	
							$(compiler) /sha256 $(options)

axuseredit.m:			axuseredit.e
							$(compiler) axuseredit $(options)


clean:
							delete axUserEditor frmMain.m frmBase.m axuseredit.m axUserObjects.m frmEditUser.m helpText.m
