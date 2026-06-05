->BCD helper methods

OPT MODULE

   MODULE '*axobjects'

/*PROC unsignedCompare(v1,v2)

  MOVE.L #0,D0
  MOVE.L v1,D1
  MOVE.L v2,D2
  CMP.L D1,D2
  BEQ done
  BHI high
  
  MOVE.L #-1,D0 
  BRA done
high:
  MOVE.L #1,D0
done:
ENDPROC D0*/

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

EXPORT PROC subBCD(bcdTotal:PTR TO CHAR, valToSub)
  DEF bcdVal[8]:ARRAY OF CHAR

  convertToBCD(valToSub,bcdVal)
  subBCD2(bcdTotal,bcdVal)
ENDPROC


EXPORT PROC addBCD(bcdTotal:PTR TO CHAR, valToAdd)
  DEF bcdVal[8]:ARRAY OF CHAR

  convertToBCD(valToAdd,bcdVal)
  addBCD2(bcdTotal,bcdVal)
ENDPROC

EXPORT PROC mulBCD(bcdVal:PTR TO CHAR,valToMul)
  DEF tmpVal[8]:ARRAY OF CHAR
  DEF i
  CopyMem(bcdVal,tmpVal,8)
  convertToBCD(0,bcdVal)
  WHILE(valToMul)
    FOR i:=1 TO Mod(valToMul,10)
      addBCD2(bcdVal,tmpVal)
    ENDFOR

    valToMul:=Div(valToMul,10)
    tmpVal[0]:=Shl(tmpVal[0] AND $F,4) OR Shr(tmpVal[1] AND $F0,4)
    tmpVal[1]:=Shl(tmpVal[1] AND $F,4) OR Shr(tmpVal[2] AND $F0,4)
    tmpVal[2]:=Shl(tmpVal[2] AND $F,4) OR Shr(tmpVal[3] AND $F0,4)
    tmpVal[3]:=Shl(tmpVal[3] AND $F,4) OR Shr(tmpVal[4] AND $F0,4)
    tmpVal[4]:=Shl(tmpVal[4] AND $F,4) OR Shr(tmpVal[5] AND $F0,4)
    tmpVal[5]:=Shl(tmpVal[5] AND $F,4) OR Shr(tmpVal[6] AND $F0,4)
    tmpVal[6]:=Shl(tmpVal[6] AND $F,4) OR Shr(tmpVal[7] AND $F0,4)
    tmpVal[7]:=Shl(tmpVal[7] AND $F,4)
    
  ENDWHILE
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

EXPORT PROC divBCD(dividend:PTR TO CHAR, divisor)
  DEF decVal[16]:ARRAY OF CHAR
  DEF i,n=0,v,r
  
  FOR i:=0 TO 7
    decVal[n]:=Shr(dividend[i] AND $f0,4)
    n++
    decVal[n]:=dividend[i] AND $f
    n++
  ENDFOR
  
  v:=0
  r:=0
  FOR i:=0 TO 15
    IF r
      r:=Mul(r,10)
      r+=decVal[i];
    ELSE
      r:=decVal[i];
    ENDIF   

    v:=Mul(v,10)
    IF r>=divisor
      n:=Div(r,divisor)
      v+=n
      r:=r-Mul(n,divisor);
    ENDIF
  ENDFOR
  
ENDPROC v

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
  DEF v

  v:=convertFromBCD(userMiscPtr.downloadBytesBCD)
  IF (userPtr.bytesDownload=-1) AND (v=-1) THEN updateDownload:=FALSE

  v:=convertFromBCD(userMiscPtr.uploadBytesBCD)
  IF (userPtr.bytesUpload=-1) AND (v=-1) THEN updateUpload:=FALSE

  IF updateUpload
    convertToBCD(userPtr.bytesUpload,userMiscPtr.uploadBytesBCD)
  ENDIF

  IF updateDownload
    convertToBCD(userPtr.bytesDownload,userMiscPtr.downloadBytesBCD)
  ENDIF
ENDPROC

EXPORT PROC convertConfUDBytesTOBCD(confPtr: PTR TO confBase)
  DEF updateUpload=TRUE, updateDownload=TRUE
  DEF v

  v:=convertFromBCD(confPtr.downloadBytesBCD)
  IF (confPtr.bytesDownload=-1) AND (v=-1) THEN updateDownload:=FALSE

  v:=convertFromBCD(confPtr.uploadBytesBCD)
  IF (confPtr.bytesUpload=-1) AND (v=-1) THEN updateUpload:=FALSE

  IF updateUpload
    convertToBCD(confPtr.bytesUpload,confPtr.uploadBytesBCD)
  ENDIF

  IF updateDownload
    convertToBCD(confPtr.bytesDownload,confPtr.downloadBytesBCD)
  ENDIF
ENDPROC
