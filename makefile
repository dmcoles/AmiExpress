# Compile ACP and EXPRESS and any dependencies

options=DEBUG IGNORECACHE NILCHECK
compiler=EC
expprogramname=AmiExpress
acpprogramname=ACP
version=5.4.0-beta

all:					acp express5 jsonimport icon2cfg qwk ftn

release:				options = IGNORECACHE 
release:				acp express5 jsonimport icon2cfg qwk ftn

acp:					acp.e acpversion.m axcommon.m jsonparser.m jsoncreate.m stringlist.m 
							$(compiler) acp $(options)

express5:			express.e expversion.m axcommon.m axconsts.m miscfuncs.m axobjects.m axenums.m stringlist.m errors.m mailssl.m ftpd.m httpd.m xymodem.m zmodem.m tooltypes.m pwdhash.m bcd.m
							$(compiler) express $(options)
							copy express express5
							delete express

verinfogen:		verinfogen.e
							$(compiler) verinfogen $(options)

ftn:					ftn.e stringlist.m
							$(compiler) ftn $(options)

qwk:					qwk.e stringlist.m
							$(compiler) qwk $(options)

icon2cfg:			icon2cfg.e miscfuncs.m
							$(compiler) icon2cfg $(options)

jsonimport:		jsonimport.e jsonparser.m  jsoncreate.m
							$(compiler) jsonimport $(options)

jsonparser.m: jsonparser.e miscfuncs.m
							$(compiler) jsonparser $(options)

jsoncreate.m: jsoncreate.e miscfuncs.m jsonparser.m
							$(compiler) jsoncreate $(options)

zmodem.m:			zmodem.e
							$(compiler) zmodem $(options)

xymodem.m:		xymodem.e
							$(compiler) xymodem $(options)

stringlist.m:	stringlist.e
							$(compiler) stringlist $(options)

miscfuncs.m:	miscfuncs.e axconsts.m axenums.m axobjects.m errors.m
							$(compiler) miscfuncs $(options)

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

axobjects.m:	axobjects.e axconsts.m
							$(compiler) axobjects $(options)

axenums.m:		axenums.e
							$(compiler) axenums $(options)

expversion.m:	expversion.e
							$(compiler) expversion $(options)

expversion.e: verinfogen
							verinfogen expversion.e $(expprogramname) $(version) usedate

acpversion.m:	acpversion.e
							$(compiler) acpversion $(options)

acpversion.e: verinfogen
							verinfogen acpversion.e $(acpprogramname) $(version) usedate

bcd.m:				bcd.e
							$(compiler) bcd $(options)

ftpd.m:				ftpd.e
							$(compiler) ftpd $(options)

httpd.m:			httpd.e axcommon.m stringlist.m
							$(compiler) httpd $(options)

clean:
							delete expversion.e acpversion.e delete express verinfogen express5 acp qwk ftn jsonimport icon2cfg miscfuncs.m stringlist.m errors.m mailssl.m jsoncreate.m jsonparser.m axcommon.m ftpd.m httpd.m axconsts.m axobjects.m axenums.m zmodem.m xymodem.m bcd.m expversion.m acpversion.m pwdhash.m tooltypes.m
              
.PHONY: 			expversion.e
              