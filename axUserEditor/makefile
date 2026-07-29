# Compile axUserEditor

debugoptions=DEBUG IGNORECACHE LARGE NILCHECK SYM SHOWFNAME ADDBUF 10
releaseoptions=IGNORECACHE OPTI SHOWFNAME ADDBUF 10
compiler=EVO

ifeq ($(build),release)
options=$(releaseoptions)
else
options=$(debugoptions)
endif

all:					axUserEditor

release:			options=$(releaseoptions)
release:			axUserEditor

axUserEditor:	axUserEditor.e frmMain.m axUserObjects.m
							$(compiler) axUserEditor $(options)
              
frmMain.m:	frmMain.e frmBase.m frmEditUser.m axuseredit.m axUserObjects.m stringlist.m
							$(compiler) frmMain $(options)              

frmBase.m:	frmBase.e axuseredit.m
							$(compiler) frmBase $(options)              

tooltypes.m:	
							$(compiler) /axSetupTool/tooltypes $(options)              

miscfuncs.m:	
							$(compiler) /axSetupTool/miscfuncs $(options)              

axUserObjects.m:	axUserObjects.e
							$(compiler) axUserObjects $(options)              

frmEditUser.m:	frmEditUser.e frmBase.m axuseredit.m axUserObjects.m tooltypes.m stringlist.m
							$(compiler) frmEditUser $(options)              

stringlist.m:	
							$(compiler) /stringlist $(options)

axuseredit.m:			axuseredit.e
							$(compiler) axuseredit $(options)


clean:
							delete axUserEditor frmMain.m frmBase.m axuseredit.m axUserObjects.m frmEditUser.m
