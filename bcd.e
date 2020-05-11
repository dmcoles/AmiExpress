->BCD helper methods

OPT OSVERSION=37
OPT MODULE

   MODULE '*axobjects'

EXPORT PROC formatBCD(valArrayBCD:PTR TO CHAR, outStr)
  DEF tempStr[2]:STRING
  DEF i,n,start=FALSE

  StrCopy(outStr,'')
  FOR i:=0 TO 7
    n:=valArrayBCD[i]
    IF (n<>0) OR (start) OR (i=7)
      IF (start) OR (n>=$10)
        StringF(tempStr,'\d\d',Shr(n AND $F0,4),n AND $F)
      ELSE
        StringF(tempStr,'\d',n AND $F)
      ENDIF
      StrAdd(outStr,tempStr)
      start:=TRUE
    ENDIF
  ENDFOR
ENDPROC

EXPORT PROC subBCD2(bcdTotal:PTR TO CHAR, bcdValToSub: PTR TO CHAR)
  MOVE.L bcdValToSub,A0
  LEA 8(A0),A0
  MOVE.L bcdTotal,A1
  LEA 8(A1),A1

  SUB.L D0,D0        ->clear X flag

  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
  SBCD -(A0),-(A1)
ENDPROC


EXPORT PROC addBCD2(bcdTotal:PTR TO CHAR, bcdValToAdd: PTR TO CHAR)
  MOVE.L bcdValToAdd,A0
  LEA 8(A0),A0
  MOVE.L bcdTotal,A1
  LEA 8(A1),A1

  SUB.L D0,D0        ->clear X flag

  ABCD -(A0),-(A1)
  ABCD -(A0),-(A1)
  ABCD -(A0),-(A1)
  ABCD -(A0),-(A1)
  ABCD -(A0),-(A1)
  ABCD -(A0),-(A1)
  ABCD -(A0),-(A1)
  ABCD -(A0),-(A1)
ENDPROC


EXPORT PROC addBCD(bcdTotal:PTR TO CHAR, valToAdd)
  DEF bcdVal[8]:ARRAY OF CHAR

  convertToBCD(valToAdd,bcdVal)
  addBCD2(bcdTotal,bcdVal)
ENDPROC

EXPORT PROC divBCD1024(bcdVal:PTR TO CHAR)

  DEF decVal[16]:ARRAY OF CHAR
  DEF i,i2,n=0,c=0
  
  FOR i:=0 TO 7
    decVal[n]:=Shr(bcdVal[i] AND $f0,4)
    n++
    decVal[n]:=bcdVal[i] AND $f
    n++
  ENDFOR
  
  FOR i2:=0 TO 9
    c:=0
    FOR i:=0 TO 15
      n:=Shr(decVal[i],1)
      IF c THEN n:=n+5
      c:=decVal[i] AND 1
      decVal[i]:=n
    ENDFOR
  ENDFOR

  n:=0
  FOR i:=0 TO 7
    bcdVal[i]:=Shl(decVal[n],4)+decVal[n+1]
    n:=n+2
  ENDFOR
ENDPROC


EXPORT PROC convertFromBCD(inArray:PTR TO CHAR)
  DEF tempBCD[8]:ARRAY
  DEF bcdStr[20]:STRING

  convertToBCD($ffffffff,tempBCD)
  subBCD2(tempBCD,inArray)
  IF ((tempBCD[0] AND $F0)<>0)
    RETURN $ffffffff
  ENDIF
  formatBCD(inArray,bcdStr)
ENDPROC Val(bcdStr)

EXPORT PROC convertToBCD(invalue,outArray: PTR TO CHAR)
  DEF shift,i

  FOR i:=0 TO 7
    outArray[i]:=0
  ENDFOR

  FOR shift:=0 TO 31
    FOR i:=0 TO 7
      IF (outArray[i] AND $F0)>=$50 THEN outArray[i]:=outArray[i]+$30
      IF (outArray[i] AND $F)>=$5 THEN outArray[i]:=outArray[i]+$3
    ENDFOR
    FOR i:=0 TO 6
      outArray[i]:=Shl(outArray[i],1)
      IF outArray[i+1] AND $80
        outArray[i]:=outArray[i] OR 1
      ENDIF
    ENDFOR
    outArray[7]:=Shl(outArray[7],1)
    IF (invalue AND $80000000)
      outArray[7]:=outArray[7] OR 1
    ENDIF
    invalue:=Shl(invalue,1)
  ENDFOR
ENDPROC

EXPORT PROC convertUserUDBytesTOBCD(userPtr: PTR TO user, userMiscPtr: PTR TO userMisc)
  DEF updateUpload=TRUE, updateDownload=TRUE
  DEF i

  FOR i:=0 TO 7
    IF (userMiscPtr.downloadBytesBCD[i]<>0) THEN updateDownload:=FALSE
    IF (userMiscPtr.uploadBytesBCD[i]<>0) THEN updateUpload:=FALSE
  ENDFOR

  IF updateUpload
    convertToBCD(userPtr.bytesUpload,userMiscPtr.uploadBytesBCD)
  ENDIF

  IF updateDownload
    convertToBCD(userPtr.bytesDownload,userMiscPtr.downloadBytesBCD)
  ENDIF
ENDPROC

EXPORT PROC convertConfUDBytesTOBCD(confPtr: PTR TO confBase)
  DEF updateUpload=TRUE, updateDownload=TRUE
  DEF i

  FOR i:=0 TO 7
    IF (confPtr.downloadBytesBCD[i]<>0) THEN updateDownload:=FALSE
    IF (confPtr.uploadBytesBCD[i]<>0) THEN updateUpload:=FALSE
  ENDFOR

  IF updateUpload
    convertToBCD(confPtr.bytesUpload,confPtr.uploadBytesBCD)
  ENDIF

  IF updateDownload
    convertToBCD(confPtr.bytesDownload,confPtr.downloadBytesBCD)
  ENDIF
ENDPROC
