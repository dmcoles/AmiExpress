# Compile ACP and EXPRESS and any dependencies

options=DEBUG IGNORECACHE

all:					acp express5 jsonimport icon2cfg

release:				options = IGNORECACHE 
release:				acp express5 jsonimport icon2cfg

acp:					acp.e axcommon.m miscfuncs.m jsonparser.m
							ec acp $(options)

express5:			express.e axcommon.m stringlist.m ftpd.m
							ec express $(options)
							copy express express5
							delete express

ftpd.m:				ftpd.e
							ec ftpd $(options)

icon2cfg:			icon2cfg.e miscfuncs.m
							ec icon2cfg $(options)

jsonimport:		jsonimport.e jsonparser.m 
							ec jsonimport $(options)

jsonparser.m: jsonparser.e miscfuncs.m
							ec jsonparser $(options)

stringlist.m:	stringlist.e
							ec stringlist $(options)

miscfuncs.m:	miscfuncs.e
							ec miscfuncs $(options)

axcommon.m :	axcommon.e
							ec axcommon $(options)

clean :
							delete	express express5 acp jsonimport icon2cfg miscfuncs.m jsonparser.m axcommon.m ftpd.m