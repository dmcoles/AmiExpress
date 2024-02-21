# Compile ACP and EXPRESS and any dependencies

debugoptions=DEBUG IGNORECACHE NILCHECK OPTI SYM SHOWFNAME
releaseoptions=IGNORECACHE OPTI SHOWFNAME
compiler=EVO
expprogramname=AmiExpress
acpprogramname=ACP
version=5.6.1-dev

ifeq ($(build),release)
options=$(releaseoptions)
else
options=$(debugoptions)
endif

all:					ACP express5 jsonImport icon2cfg qwk ftn

release:				options=$(releaseoptions)
release:				ACP express5 jsonImport icon2cfg qwk ftn

axSetupTool:
							$(MAKE) MAKEFLAGS=-B -C axSetupTool build=$(build)

ACP:					ACP.e acpversion.m axcommon.m jsonParser.m jsonCreate.m stringlist.m 
							$(compiler) ACP $(options)

express5:			express.e expversion.m axcommon.m axconsts.m MiscFuncs.m axobjects.m axenums.m stringlist.m errors.m mailssl.m ftpd.m httpd.m xymodem.m zmodem.m hydra.m tooltypes.m pwdhash.m bcd.m sha256.m
							$(compiler) express $(options)
							copy express express5
							delete express

VerInfoGen:		VerInfoGen.e
							$(compiler) VerInfoGen $(options)

ftn:					ftn.e stringlist.m axobjects.m
							$(compiler) ftn $(options)

qwk:					qwk.e stringlist.m axobjects.m
							$(compiler) qwk $(options)

icon2cfg:			icon2cfg.e MiscFuncs.m
							$(compiler) icon2cfg $(options)

jsonImport:		jsonImport.e jsonParser.m  jsonCreate.m
							$(compiler) jsonImport $(options)

jsonParser.m: jsonParser.e MiscFuncs.m
							$(compiler) jsonParser $(options)

jsonCreate.m: jsonCreate.e MiscFuncs.m jsonParser.m
							$(compiler) jsonCreate $(options)

zmodem.m:			zmodem.e bcd.m
							$(compiler) zmodem $(options)

xymodem.m:		xymodem.e bcd.m
							$(compiler) xymodem $(options)

hydra.m:		  hydra.e
							$(compiler) hydra $(options)

stringlist.m:	stringlist.e
							$(compiler) stringlist $(options)

MiscFuncs.m:	MiscFuncs.e axconsts.m axenums.m axobjects.m errors.m
							$(compiler) MiscFuncs $(options)

errors.m:			errors.e
							$(compiler) errors $(options)

mailssl.m:		mailssl.e
							$(compiler) mailssl $(options)

tooltypes.m:	tooltypes.e
							$(compiler) tooltypes $(options)

pwdhash.m:		pwdhash.e
							$(compiler) pwdhash $(options)

axcommon.m:		axcommon.e stringlist.m
							$(compiler) axcommon $(options)
              
axconsts.m:		axconsts.e
							$(compiler) axconsts $(options)

axobjects.m:	axobjects.e axconsts.m stringlist.m
							$(compiler) axobjects $(options)

axenums.m:		axenums.e
							$(compiler) axenums $(options)

expversion.m:	expversion.e
							$(compiler) expversion $(options)

expversion.e: VerInfoGen
							VerInfoGen expversion.e $(expprogramname) $(version) usedate

acpversion.m:	acpversion.e
							$(compiler) acpversion $(options)

acpversion.e: VerInfoGen
							VerInfoGen acpversion.e $(acpprogramname) $(version) usedate

bcd.m:				bcd.e axobjects.m
							$(compiler) bcd $(options)

sha256.m:			sha256.e
							$(compiler) sha256 $(options)

ftpd.m:				ftpd.e tooltypes.m stringlist.m axobjects.m axenums.m MiscFuncs.m bcd.m
							$(compiler) ftpd $(options)

httpd.m:			httpd.e axcommon.m stringlist.m
							$(compiler) httpd $(options)

clean:
							delete expversion.e acpversion.e delete express VerInfoGen express5 acp qwk ftn jsonImport icon2cfg MiscFuncs.m stringlist.m errors.m mailssl.m jsonCreate.m jsonParser.m axcommon.m ftpd.m httpd.m axconsts.m axobjects.m axenums.m zmodem.m xymodem.m hydra.m bcd.m expversion.m acpversion.m pwdhash.m tooltypes.m sha256.m

dist:					options=$(releaseoptions)
dist:					build=release
dist:					ACP express5 jsonImport icon2cfg qwk ftn axSetupTool
							-delete Rel ALL FORCE
							makedir Rel
							makedir Rel/AmiExpress
							makedir Rel/AmiExpress/AmiExpress
							makedir Rel/AmiExpress/AmiExpress/Utils
							lha x deployment/binaries.lha Rel/AmiExpress/
							Copy Rel/AmiExpress/Installer Rel/
							-delete Rel/AmiExpress/Installer
							Copy acp Rel/AmiExpress/AmiExpress/
							Copy express5 Rel/AmiExpress/AmiExpress/express
							Copy jsonImport Rel/AmiExpress/AmiExpress/Utils/
							Copy icon2cfg Rel/AmiExpress/AmiExpress/Utils/
							Copy icon2cfg Rel/AmiExpress/AmiExpress/Utils/
							Copy axSetupTool/axSetupTool Rel/AmiExpress/AmiExpress/Utils/
							Copy qwk Rel/AmiExpress/AmiExpress/Utils/
							Copy ftn Rel/AmiExpress/AmiExpress/Utils/
							Copy deployment/Install\ Ami-Express Rel/
							Copy deployment/Install\ Ami-Express.info Rel/
							Copy deployment/File_Id.Diz Rel/
							Copy deployment/read_me.txt Rel/
							Lha -r a t:Amix560.lha Rel/
							Copy t:Amix560.lha Rel/
							-delete t:Amix560.lha
							join deployment/read_me.hdr deployment/read_me.txt TO Rel/Amix560.readme

.PHONY: 			expversion.e acpversion.e axSetupTool
