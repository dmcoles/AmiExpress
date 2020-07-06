/*
JSON parser

IF you are saving icons you must open icon library in advance

*/
OPT OSVERSION=37
OPT MODULE

->  MODULE 'dos/dos','workbench/workbench','icon','wb','dos/dosextens'
  MODULE '*miscfuncs'


CONST JSMN_PARENT_LINKS=0
CONST JSMN_STRICT=1

CONST BUFSIZ = 8192

/**
 * JSON type identifier. Basic types are:
 * 	o Object
 * 	o Array
 * 	o String
 * 	o Other primitive: number, boolean (true/false) or NIL
 */

EXPORT ENUM JSMN_UNDEFINED = 0,JSMN_OBJECT = 1,JSMN_ARRAY = 2,JSMN_STRING = 3,JSMN_PRIMITIVE = 4

EXPORT ENUM 
	/* Not enough tokens were provided */
	JSMN_ERROR_NOMEM = -1,
	/* Invalid character inside JSON string */
	JSMN_ERROR_INVAL = -2,
	/* The string is not a full JSON packet, more bytes expected */
	JSMN_ERROR_PART = -3

/**
 * JSON token description.
 * type		type (object, array, string etc.)
 * start	start position in JSON data string
 * end		end position in JSON data string
 */
EXPORT OBJECT jsmntok_t
  type
	start:LONG
	end:LONG
	size:LONG
->#ifdef JSMN_PARENT_LINKS
	parent:LONG
->#endif
ENDOBJECT

/**
 * JSON parser. Contains an array of token blocks available. Also stores
 * the string being parsed now and current position in that string
 */
EXPORT OBJECT jsmn_parser
	pos:LONG /* offset in the JSON string */
	toknext:LONG /* next token to allocate */
	toksuper:LONG /* superior token node, e.g parent object or array */
ENDOBJECT


/**
 * Create JSON parser over an array of tokens
 */
-> jsmn_init(jsmn_parser *parser)

/**
 * Run JSON parser. It parses a JSON data string into and array of tokens, each describing
 * a single JSON object.
 */
->int jsmn_parse(jsmn_parser *parser, const char *js, size_t len, jsmntok_t *tokens, unsigned int num_tokens)



/**
 * Allocates a fresh unused token from the token pool.
 */
PROC jsmn_alloc_token(parser:PTR TO jsmn_parser,tokens, num_tokens)
	DEF tok:PTR TO jsmntok_t
	IF (parser.toknext >= num_tokens) 
		RETURN NIL
	ENDIF
	tok:=tokens+(parser.toknext*SIZEOF jsmntok_t)
  parser.toknext:=parser.toknext+1

	tok.start:=-1
  tok.end:=-1
	tok.size:=0
  IF JSMN_PARENT_LINKS
    tok.parent:=-1
  ENDIF
ENDPROC tok


/**
 * Fills token type and boundaries.
 */
PROC jsmn_fill_token(token:PTR TO jsmntok_t, type,start, end)
	token.type:=type
	token.start:=start
	token.end:=end
	token.size:=0
ENDPROC

/**
 * Fills next available token with JSON primitive.
 */
PROC jsmn_parse_primitive(parser:PTR TO jsmn_parser, js: PTR TO CHAR,len,tokens, num_tokens)
	DEF token:PTR TO jsmntok_t, start,ch,found

	start:=parser.pos

  WHILE (parser.pos < len) AND (js[parser.pos] <> 0)
    ch:=js[parser.pos]
      /* In strict mode primitive must be followed by "," or "}" or "]" */
    found:=FALSE
    IF JSMN_STRICT AND (ch=":") 
      found:=TRUE
    ELSEIF (ch="\t") OR (ch="\b") OR (ch="\n") OR (ch=" ") OR (ch=",") OR (ch="]") OR (ch="}")
      found:=TRUE
    ENDIF
    IF found THEN JUMP foundit
		IF ((ch < 32) OR (ch >= 127))
			parser.pos:=start
			RETURN JSMN_ERROR_INVAL
		ENDIF
    parser.pos:=parser.pos+1
	ENDWHILE
  IF JSMN_STRICT
	/* In strict mode primitive must be followed by a comma/object/array */
    parser.pos:=start
    RETURN JSMN_ERROR_PART
  ENDIF

foundit:
	IF (tokens = NIL)
		parser.pos:=parser.pos-1
		RETURN 0
	ENDIF
	token:=jsmn_alloc_token(parser, tokens, num_tokens)
	IF (token = NIL)
		parser.pos:=start
		RETURN JSMN_ERROR_NOMEM
	ENDIF
	jsmn_fill_token(token, JSMN_PRIMITIVE, start, parser.pos)
  IF JSMN_PARENT_LINKS
    token.parent:=parser.toksuper
  ENDIF
	parser.pos:=parser.pos-1
ENDPROC 0

/**
 * Fills next token with JSON string.
 */
PROC jsmn_parse_string(parser:PTR TO jsmn_parser, js:PTR TO CHAR,len, tokens, num_tokens)
  DEF token:PTR TO jsmntok_t
  DEF start
  DEF c,i,ch

  start:=parser.pos
	parser.pos:=parser.pos+1

	/* Skip starting quote */
	WHILE ((parser.pos < len) AND (js[parser.pos] <> 0))
		c:=js[parser.pos]

		/* Quote: end of string */
		IF (c = 34) 
			IF (tokens = NIL) 
				RETURN 0
			ENDIF
			token:=jsmn_alloc_token(parser, tokens, num_tokens)
			IF (token = NIL)
				parser.pos:=start
				RETURN JSMN_ERROR_NOMEM
			ENDIF
			jsmn_fill_token(token, JSMN_STRING, start+1, parser.pos)
      IF JSMN_PARENT_LINKS
        token.parent:=parser.toksuper
      ENDIF
			RETURN 0
		ENDIF

		/* Backslash: Quoted symbol expected */
		IF ((c = "\\") AND (parser.pos + 1 < len))
			parser.pos:=parser.pos+1
      ch:=js[parser.pos]
			SELECT ch
				/* Allowed escaped symbols */
				CASE 34
        CASE "/"
        CASE "\\"
        CASE "b"
        CASE "f"
        CASE "r"
        CASE "n"
        CASE "t"
				/* Allows escaped symbol \uXXXX */
				CASE "u"
					parser.pos:=parser.pos+1
          i:=0
					WHILE (i < 4) AND (parser.pos < len) AND (js[parser.pos] <> 0)
						/* If it isn't a hex character we have an error */
						IF(Not(((js[parser.pos] >= 48) AND (js[parser.pos] <= 57)) OR /* 0-9 */
									 ((js[parser.pos] >= 65) AND (js[parser.pos] <= 70)) OR /* A-F */
									 ((js[parser.pos] >= 97) AND (js[parser.pos] <= 102))))  /* a-f */
							parser.pos:=start
							RETURN JSMN_ERROR_INVAL
						ENDIF
						parser.pos:=parser.pos+1
            i++
					ENDWHILE
					parser.pos:=parser.pos-1
				/* Unexpected symbol */
				DEFAULT
					parser.pos:=start
					RETURN JSMN_ERROR_INVAL
			ENDSELECT
		ENDIF
    parser.pos:=parser.pos+1
	ENDWHILE
	parser.pos:=start
ENDPROC JSMN_ERROR_PART

/**
 * Parse JSON string and fill tokens.
 */
EXPORT PROC jsmn_parse(parser:PTR TO jsmn_parser, js:PTR TO CHAR, len,tokens, num_tokens)
	DEF r,i
  DEF token:PTR TO jsmntok_t
	DEF count 
  DEF c,exit=FALSE
  DEF type
  DEF t:PTR TO jsmntok_t
  DEF tok:PTR TO jsmntok_t

  count:=parser.toknext
	WHILE ((parser.pos < len) AND (js[parser.pos] <> 0))
    c:=js[parser.pos]
    IF (c="{") OR (c="[")
      count++
      IF (tokens <> NIL)
        token:=jsmn_alloc_token(parser, tokens, num_tokens)
        IF (token = NIL) 
            WriteF('1.JSMN_ERROR_NOMEM pos=\d,count=\d\n',parser.pos,count)
          RETURN JSMN_ERROR_NOMEM
        ENDIF
        IF (parser.toksuper <> -1) 
          tok:=tokens+(parser.toksuper*SIZEOF jsmntok_t)
          tok.size:=tok.size+1
          IF JSMN_PARENT_LINKS THEN token.parent:=parser.toksuper
        ENDIF
        token.type:=(IF c ="{" THEN JSMN_OBJECT ELSE JSMN_ARRAY)
        token.start:=parser.pos
        parser.toksuper:= parser.toknext - 1
      ENDIF
    ELSEIF (c="}") OR (c="]")
      IF (tokens <> NIL)
        type:=(IF c = "}" THEN JSMN_OBJECT ELSE JSMN_ARRAY)
        IF JSMN_PARENT_LINKS
          IF (parser.toknext < 1) 
            WriteF('2.JSMN_ERROR_INVAL pos=\d,count=\d\n',parser.pos,count)
            RETURN JSMN_ERROR_INVAL
          ENDIF
          token:=tokens+((parser.toknext - 1)*SIZEOF jsmntok_t)
          exit:=FALSE
          WHILE exit=FALSE
            IF ((token.start <> -1) AND (token.end = -1))
              IF (token.type <> type)
                WriteF('3.JSMN_ERROR_INVAL pos=\d,count=\d\n',parser.pos,count)
                RETURN JSMN_ERROR_INVAL
              ENDIF
              token.end:=parser.pos + 1
              parser.toksuper:= token.parent
              exit:=TRUE
            ELSEIF (token.parent = -1)
              IF((token.type <> type) OR (parser.toksuper = -1))
                WriteF('4.JSMN_ERROR_INVAL pos=\d,count=\d\n',parser.pos,count)
                ->RETURN JSMN_ERROR_INVAL
              ENDIF
              exit:=TRUE
            ELSE
              token:=tokens+(token.parent*SIZEOF jsmntok_t)
            ENDIF
          ENDWHILE
        ELSE
          exit:=FALSE
          i:=parser.toknext - 1
          WHILE i>=0
            token:= tokens+(i*SIZEOF jsmntok_t)
            IF ((token.start <> -1) AND (token.end = -1) )
              IF (token.type <> type)
                WriteF('5.JSMN_ERROR_INVAL pos=\d,count=\d\n',parser.pos,count)
                RETURN JSMN_ERROR_INVAL
              ENDIF
              parser.toksuper:=-1
              token.end:=parser.pos + 1
              exit:=TRUE
            ENDIF
            EXIT exit
            i--
          ENDWHILE
          /* Error if unmatched closing bracket */
          IF (i = -1)
            WriteF('6.JSMN_ERROR_INVAL pos=\d,count=\d\n',parser.pos,count)
            RETURN JSMN_ERROR_INVAL
          ENDIF
          exit:=FALSE
          WHILE (i>=0) AND (exit=FALSE)
            token:=tokens+(i*SIZEOF jsmntok_t)
            IF ((token.start <> -1) AND (token.end = -1))
              parser.toksuper:=i
              exit:=TRUE
            ENDIF
            i--
          ENDWHILE
        ENDIF
      ENDIF
    ELSEIF c=34
      r:=jsmn_parse_string(parser, js, len, tokens, num_tokens)
      IF (r < 0) THEN RETURN r
      count++
      IF ((parser.toksuper <> -1) AND (tokens <> NIL))
        tok:=tokens+(parser.toksuper*SIZEOF jsmntok_t)
        tok.size:=tok.size+1
      ENDIF
      ->break
    ELSEIF (c="\t") OR (c="\b") OR (c="\n") OR (c=" ")
      ->break
    ELSEIF c=":"
      parser.toksuper:=parser.toknext - 1
    ELSEIF c=","
      IF (tokens <> NIL) AND (parser.toksuper <> -1)
        tok:=tokens+(parser.toksuper*SIZEOF jsmntok_t)
        IF (tok.type <> JSMN_ARRAY) AND (tok.type <> JSMN_OBJECT)
          IF JSMN_PARENT_LINKS
            parser.toksuper:=tok.parent
          ELSE
            exit:=FALSE
            FOR i:= parser.toknext - 1 TO 0 STEP -1
              tok:=tokens+(i*SIZEOF jsmntok_t)
              IF ((tok.type = JSMN_ARRAY) OR (tok.type = JSMN_OBJECT))
                IF ((tok.start <> -1) AND (tok.end = -1))
                  parser.toksuper:=i
                  exit:=TRUE
                ENDIF
              ENDIF
              EXIT exit
            ENDFOR
          ENDIF
        ENDIF
      ENDIF

    ELSEIF JSMN_STRICT
      IF ((c="-") OR (c="0") OR (c="1") OR (c="2") OR (c="3") OR (c="4") OR (c="5") OR (c="6") OR (c="7") OR (c="8") OR (c="9") OR (c="t") OR (c="f") OR (c="n"))
        /* In strict mode primitives are: numbers and booleans */
        /* And they must not be keys of the object */
        IF ((tokens <> NIL) AND (parser.toksuper <> -1))
          t:=tokens+(parser.toksuper*SIZEOF jsmntok_t)
          IF ((t.type = JSMN_OBJECT) OR ((t.type = JSMN_STRING) AND (t.size <> 0)))
            WriteF('7.JSMN_ERROR_INVAL pos=\d,count=\d\n',parser.pos,count)
            RETURN JSMN_ERROR_INVAL
          ENDIF
        ENDIF
        r:=jsmn_parse_primitive(parser, js, len, tokens, num_tokens)
        IF (r < 0) THEN RETURN r
        count++
        IF ((parser.toksuper <> -1) AND (tokens <> NIL))
          tok:=tokens+(parser.toksuper*SIZEOF jsmntok_t)
          tok.size:=tok.size+1
        ENDIF
      ELSE
        /* Unexpected char in strict mode */
        WriteF('8.JSMN_ERROR_INVAL c=\c, pos=\d,count=\d\n',c,parser.pos,count)
        RETURN JSMN_ERROR_INVAL
      ENDIF
    ELSE /*JSMN_STRICT=FALSE*/
      /* In non-strict mode every unquoted value is a primitive */
      r:=jsmn_parse_primitive(parser, js, len, tokens, num_tokens)
      IF (r < 0) THEN RETURN r
      count++
      IF ((parser.toksuper <> -1) AND (tokens <> NIL))
        tok:=tokens+(parser.toksuper*SIZEOF jsmntok_t)
        tok.size:=tok.size+1
      ENDIF
    ENDIF
    parser.pos:=parser.pos+1
	ENDWHILE

	IF (tokens <> NIL) 
		FOR i:=parser.toknext - 1 TO 0 STEP -1
			/* Unmatched opened object or array */
      tok:=tokens+(i*SIZEOF jsmntok_t)
			IF ((tok.start <> -1) AND (tok.end = -1))
        WriteF('9.JSMN_ERROR_PART pos=\d,count=\d\n',parser.pos,count)
				RETURN JSMN_ERROR_PART
			ENDIF
		ENDFOR
	ENDIF

ENDPROC count

/**
 * Creates a new parser based over a given  buffer with an array of tokens
 * available.
 */
EXPORT PROC jsmn_init(parser:PTR TO jsmn_parser)
	parser.pos:=0
	parser.toknext:=0
	parser.toksuper:=-1
ENDPROC
