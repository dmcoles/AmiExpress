# Compile ACP and EXPRESS and any dependencies

options=DEBUG IGNORECACHE

compiler=EC

all:					acp express5 jsonimport icon2cfg

release:				options = IGNORECACHE 
release:				acp express5 jsonimport icon2cfg

acp:					acp.e axcommon.m jsonparser.m stringlist.m
							$(compiler) acp $(options)

express5:			express.e axcommon.m axconsts.m miscfuncs.m axobjects.m axenums.m stringlist.m errors.m mailssl.m ftpd.m httpd.m
							$(compiler) express $(options)
							copy express express5
							delete express

icon2cfg:			icon2cfg.e miscfuncs.m
							$(compiler) icon2cfg $(options)

jsonimport:		jsonimport.e jsonparser.m 
							$(compiler) jsonimport $(options)

jsonparser.m: jsonparser.e miscfuncs.m
							$(compiler) jsonparser $(options)

stringlist.m:	stringlist.e
							$(compiler) stringlist $(options)

miscfuncs.m:	miscfuncs.e axconsts.m axenums.m
							$(compiler) miscfuncs $(options)

errors.m:			errors.e
							$(compiler) errors $(options)

mailssl.m:		mailssl.e
							$(compiler) mailssl $(options)

axcommon.m:		axcommon.e stringlist.m
							$(compiler) axcommon $(options)
              
axconsts.m:		axconsts.e
							$(compiler) axconsts $(options)

axobjects.m:	axobjects.e axconsts.m
							$(compiler) axobjects $(options)

axenums.m:		axenums.e
							$(compiler) axenums $(options)

ftpd.m:				ftpd.e
							$(compiler) ftpd $(options)

httpd.m:			httpd.e axcommon.m stringlist.m
							$(compiler) httpd $(options)
clean :
							delete	express express5 acp jsonimport icon2cfg miscfuncs.m stringlist.m errors.m mailssl.m jsonparser.m axcommon.m ftpd.m httpd.m axconsts.m axobjects.m axenums.m 