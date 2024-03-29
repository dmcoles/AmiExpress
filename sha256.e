OPT MODULE 

CONST SHA1_DIGEST_SIZE=20
CONST SIZE_OF_SHA_1_CHUNK=64

CONST SIZE_OF_SHA_256_HASH=32
CONST SIZE_OF_SHA_256_CHUNK=64
CONST TOTAL_LEN_LEN=8

OBJECT sha_256
  hash:PTR TO CHAR
  chunk[SIZE_OF_SHA_256_CHUNK]: ARRAY OF CHAR
  chunk_pos:PTR TO CHAR
  space_left:LONG
  total_len:LONG
  h[8]:ARRAY OF LONG
ENDOBJECT

OBJECT sha1_ctx
  state[5]:ARRAY OF LONG
  count[2]:ARRAY OF LONG
  buffer[SIZE_OF_SHA_1_CHUNK]:ARRAY OF CHAR
ENDOBJECT

/*
 * Comments from pseudo-code at https://en.wikipedia.org/wiki/SHA-2 are reproduced here.
 * When useful for clarification, portions of the pseudo-code are reproduced here too.
 */

/*
 * @brief Rotate a 32-bit value by a number of bits to the right.
 * @param value The value to be rotated.
 * @param count The number of bits to rotate by.
 * @return The rotated value.
 */
PROC right_rot(value, count)
 MOVE.L value,D0
 MOVE.L count,D1
 ROR.L D1,D0
ENDPROC D0

PROC left_rot(value, count)
 MOVE.L value,D0
 MOVE.L count,D1
 ROL.L D1,D0
ENDPROC D0
/*
 * @brief Update a hash value under calculation with a new chunk of data.
 * @param h Pointer to the first hash item, of a total of eight.
 * @param p Pointer to the chunk data, which has a standard length.
 *
 * @note This is the SHA-256 work horse.
 */
PROC consume_chunk(h:PTR TO LONG, p:PTR TO CHAR)
  DEF i,j
  DEF ah[8]:ARRAY OF LONG
  DEF w[16]:ARRAY OF LONG
  DEF s0,s1,ch
  DEF k:PTR TO LONG
  DEF temp1,temp2,maj

	/* Initialize working variables to current hash value: */
  FOR i:=0 TO 7 DO ah[i]:=h[i]

	/*
	 * The w-array is really w[64], but since we only need 16 of them at a time, we save stack by
	 * calculating 16 at a time.
	 *
	 * This optimization was not there initially and the rest of the comments about w[64] are kept in their
	 * initial state.
	 */

	/*
	 * create a 64-entry message schedule array w[0..63] of 32-bit words (The initial values in w[0..63]
	 * don't matter, so many implementations zero them here) copy chunk into first 16 words w[0..15] of the
	 * message schedule array
	 */

	/* Compression function main loop: */
	FOR i:=0 TO 3
		FOR j:=0 TO 15
			IF (i = 0) 
				w[j]:=Lsl(p[0],24) OR Lsl(p[1],16) OR Lsl(p[2],8) OR p[3]
				p+=4
			ELSE
				/* Extend the first 16 words into the remaining 48 words w[16..63] of the
				 * message schedule array: */
				s0:=Eor(
          Eor(
            right_rot(w[(j + 1) AND $f], 7),
            right_rot(w[(j + 1) AND $f], 18)),
            Lsr(w[(j + 1) AND $f],3))
				s1:=Eor
          (Eor(
            right_rot(w[(j + 14) AND $f], 17),
            right_rot(w[(j + 14) AND $f], 19)),
            Lsr(w[(j + 14) AND $f],10))
				w[j]:=w[j] + s0 + w[(j + 9) AND $f] + s1
			ENDIF
			s1:=Eor(Eor(right_rot(ah[4], 6),right_rot(ah[4], 11)),right_rot(ah[4], 25))
			ch:=Eor((ah[4] AND ah[5]),(Not(ah[4]) AND ah[6]))

			/*
			 * Initialize array of round constants:
			 * (first 32 bits of the fractional parts of the cube roots of the first 64 primes 2..311):
			 */
      k:={kdata}

			temp1:=ah[7] + s1 + ch + k[Lsl(i,4) OR j] + w[j]
			s0:= Eor(Eor(right_rot(ah[0], 2),right_rot(ah[0], 13)),right_rot(ah[0], 22))
			maj:= Eor(Eor(ah[0] AND ah[1],ah[0] AND ah[2]),ah[1] AND ah[2])
			temp2:=s0+maj

			ah[7]:=ah[6]
			ah[6]:=ah[5]
			ah[5]:=ah[4]
			ah[4]:=ah[3]+temp1
			ah[3]:=ah[2]
			ah[2]:=ah[1]
			ah[1]:=ah[0]
			ah[0]:=temp1+temp2
		ENDFOR
	ENDFOR

	/* Add the compressed chunk to the current hash value: */
	FOR i:=0 TO 7 DO h[i]:=h[i]+ah[i]
ENDPROC

/* blk0() and blk() perform the initial expand. */
/* I got the idea of expanding during the round function from SSLeay */
#define blk0(i) block[i]
#define blk(i) (block[i AND 15]:= left_rot(Eor(Eor(Eor(block[(i+13) AND 15],block[(i+8) AND 15]),block[(i+2) AND 15]),block[i AND 15]),1))

/* (R0+R1), R2, R3, R4 are the different operations used in SHA1 */

#define r0(v, w, x, y, z, i) z:=z+Eor(w AND Eor(x,y),y)+blk0(i)+$5a827999+left_rot(v,5)
#define r1(v, w, x, y, z, i) z:=z+Eor(w AND Eor(x,y),y)+blk(i)+$5a827999+left_rot(v,5)
#define r2(v, w, x, y, z, i) z:=z+Eor(Eor(w,x),y)+blk(i)+$6ed9eba1+left_rot(v,5)
#define r3(v, w, x, y, z, i) z:=z+(((w OR x) AND y) OR (w AND x))+blk(i)+$8f1bbcdc+left_rot(v,5)
#define r4(v, w, x, y, z, i) z:=z+Eor(Eor(w,x),y)+blk(i)+$ca62c1d6+left_rot(v,5)

PROC sha1_transform(state:PTR TO LONG,buffer:PTR TO CHAR)
  DEF a,b,c,d,e
  DEF block[16]:ARRAY OF LONG
  
  CopyMem(buffer,block,64)

  /* Copy context->state[] to working vars */
  a:=state[0]
  b:=state[1]
  c:=state[2]
  d:=state[3]
  e:=state[4]

  /* 4 rounds of 20 operations each. Loop unrolled. */
  r0(a, b, c, d, e, 0);b:=left_rot(b,30)
  r0(e, a, b, c, d, 1);a:=left_rot(a,30)
  r0(d, e, a, b, c, 2);e:=left_rot(e,30)
  r0(c, d, e, a, b, 3);d:=left_rot(d,30)
  r0(b, c, d, e, a, 4);c:=left_rot(c,30)
  r0(a, b, c, d, e, 5);b:=left_rot(b,30)
  r0(e, a, b, c, d, 6);a:=left_rot(a,30)
  r0(d, e, a, b, c, 7);e:=left_rot(e,30)
  r0(c, d, e, a, b, 8);d:=left_rot(d,30)
  r0(b, c, d, e, a, 9);c:=left_rot(c,30)
  r0(a, b, c, d, e, 10);b:=left_rot(b,30)
  r0(e, a, b, c, d, 11);a:=left_rot(a,30)
  r0(d, e, a, b, c, 12);e:=left_rot(e,30)
  r0(c, d, e, a, b, 13);d:=left_rot(d,30)
  r0(b, c, d, e, a, 14);c:=left_rot(c,30)
  r0(a, b, c, d, e, 15);b:=left_rot(b,30)
  r1(e, a, b, c, d, 16);a:=left_rot(a,30)
  r1(d, e, a, b, c, 17);e:=left_rot(e,30)
  r1(c, d, e, a, b, 18);d:=left_rot(d,30)
  r1(b, c, d, e, a, 19);c:=left_rot(c,30)
  r2(a, b, c, d, e, 20);b:=left_rot(b,30)
  r2(e, a, b, c, d, 21);a:=left_rot(a,30)
  r2(d, e, a, b, c, 22);e:=left_rot(e,30)
  r2(c, d, e, a, b, 23);d:=left_rot(d,30)
  r2(b, c, d, e, a, 24);c:=left_rot(c,30)
  r2(a, b, c, d, e, 25);b:=left_rot(b,30)
  r2(e, a, b, c, d, 26);a:=left_rot(a,30)
  r2(d, e, a, b, c, 27);e:=left_rot(e,30)
  r2(c, d, e, a, b, 28);d:=left_rot(d,30)
  r2(b, c, d, e, a, 29);c:=left_rot(c,30)
  r2(a, b, c, d, e, 30);b:=left_rot(b,30)
  r2(e, a, b, c, d, 31);a:=left_rot(a,30)
  r2(d, e, a, b, c, 32);e:=left_rot(e,30)
  r2(c, d, e, a, b, 33);d:=left_rot(d,30)
  r2(b, c, d, e, a, 34);c:=left_rot(c,30)
  r2(a, b, c, d, e, 35);b:=left_rot(b,30)
  r2(e, a, b, c, d, 36);a:=left_rot(a,30)
  r2(d, e, a, b, c, 37);e:=left_rot(e,30)
  r2(c, d, e, a, b, 38);d:=left_rot(d,30)
  r2(b, c, d, e, a, 39);c:=left_rot(c,30)
  r3(a, b, c, d, e, 40);b:=left_rot(b,30)
  r3(e, a, b, c, d, 41);a:=left_rot(a,30)
  r3(d, e, a, b, c, 42);e:=left_rot(e,30)
  r3(c, d, e, a, b, 43);d:=left_rot(d,30)
  r3(b, c, d, e, a, 44);c:=left_rot(c,30)
  r3(a, b, c, d, e, 45);b:=left_rot(b,30)
  r3(e, a, b, c, d, 46);a:=left_rot(a,30)
  r3(d, e, a, b, c, 47);e:=left_rot(e,30)
  r3(c, d, e, a, b, 48);d:=left_rot(d,30)
  r3(b, c, d, e, a, 49);c:=left_rot(c,30)
  r3(a, b, c, d, e, 50);b:=left_rot(b,30)
  r3(e, a, b, c, d, 51);a:=left_rot(a,30)
  r3(d, e, a, b, c, 52);e:=left_rot(e,30)
  r3(c, d, e, a, b, 53);d:=left_rot(d,30)
  r3(b, c, d, e, a, 54);c:=left_rot(c,30)
  r3(a, b, c, d, e, 55);b:=left_rot(b,30)
  r3(e, a, b, c, d, 56);a:=left_rot(a,30)
  r3(d, e, a, b, c, 57);e:=left_rot(e,30)
  r3(c, d, e, a, b, 58);d:=left_rot(d,30)
  r3(b, c, d, e, a, 59);c:=left_rot(c,30)
  r4(a, b, c, d, e, 60);b:=left_rot(b,30)
  r4(e, a, b, c, d, 61);a:=left_rot(a,30)
  r4(d, e, a, b, c, 62);e:=left_rot(e,30)
  r4(c, d, e, a, b, 63);d:=left_rot(d,30)
  r4(b, c, d, e, a, 64);c:=left_rot(c,30)
  r4(a, b, c, d, e, 65);b:=left_rot(b,30)
  r4(e, a, b, c, d, 66);a:=left_rot(a,30)
  r4(d, e, a, b, c, 67);e:=left_rot(e,30)
  r4(c, d, e, a, b, 68);d:=left_rot(d,30)
  r4(b, c, d, e, a, 69);c:=left_rot(c,30)
  r4(a, b, c, d, e, 70);b:=left_rot(b,30)
  r4(e, a, b, c, d, 71);a:=left_rot(a,30)
  r4(d, e, a, b, c, 72);e:=left_rot(e,30)
  r4(c, d, e, a, b, 73);d:=left_rot(d,30)
  r4(b, c, d, e, a, 74);c:=left_rot(c,30)
  r4(a, b, c, d, e, 75);b:=left_rot(b,30)
  r4(e, a, b, c, d, 76);a:=left_rot(a,30)
  r4(d, e, a, b, c, 77);e:=left_rot(e,30)
  r4(c, d, e, a, b, 78);d:=left_rot(d,30)
  r4(b, c, d, e, a, 79);c:=left_rot(c,30)

  /* Add the working vars back into context.state[] */
  state[0]:=state[0]+a
  state[1]:=state[1]+b
  state[2]:=state[2]+c
  state[3]:=state[3]+d
  state[4]:=state[4]+e

  /* Wipe variables */
  a:=0
  b:=0
  c:=0
  d:=0
  e:=0

ENDPROC

PROC sha1_init(context:PTR TO sha1_ctx)
  /* SHA1 initialization constants */
  context.state[0]:=$67452301
  context.state[1]:=$efcdab89
  context.state[2]:=$98badcfe
  context.state[3]:=$10325476
  context.state[4]:=$c3d2e1f0
  context.count[0]:=0
  context.count[1]:=0
ENDPROC

PROC sha1_update(context:PTR TO sha1_ctx, p,len)
  DEF data:PTR TO CHAR
  DEF i,j
  data:=p

  j:=(Shr(context.count[0],3)) AND 63
  context.count[0]:=context.count[0] + Shl(len,3)
  IF (context.count[0] < Shl(len,3))
    context.count[1]:=context.count[1]+1
  ENDIF
  context.count[1]:=context.count[1] + Lsr(len,29)
  IF ((j + len) > 63)
    i:=64 - j
    CopyMem(data, context.buffer+j, i)
    sha1_transform(context.state, context.buffer)
    WHILE ((i+63)<len)
      sha1_transform(context.state, data + i)
      i+=64
    ENDWHILE
    j:= 0
  ELSE
    i:=0
  ENDIF
  CopyMem(data+i, context.buffer+j, len - i)
ENDPROC

PROC sha1_final(digest:PTR TO CHAR, context:PTR TO sha1_ctx) 
  DEF i
  DEF finalcount[8]:ARRAY OF CHAR

  FOR i:=0 TO 7
    finalcount[i]:= ((Shr(context.count[(IF i >= 4 THEN 0 ELSE 1)],((3 - (i AND 3)) * 8))) AND 255)
  ENDFOR
  sha1_update(context, [128]:CHAR, 1)
  WHILE ((context.count[0] AND 504) <> 448)
    sha1_update(context, [0]:CHAR, 1)
  ENDWHILE
  sha1_update(context, finalcount, 8) /* Should cause SHA1_Transform */
  FOR i:=0 TO SHA1_DIGEST_SIZE-1
      digest[i]:=((Shr(context.state[Shr(i,2)],((3 - (i AND 3)) * 8))) AND 255)
  ENDFOR

  /* Wipe variables */
  i:=0
  MemFill(context.buffer,64,0)
  MemFill(context.state,20,0)
  MemFill(context.count,8,0)
  MemFill(finalcount,8,0)    /* SWR */

  sha1_transform(context.state, context.buffer);
ENDPROC

PROC sha_256_init(sha_256:PTR TO sha_256, hash:PTR TO CHAR)
	sha_256.hash:=hash
	sha_256.chunk_pos:=sha_256.chunk
	sha_256.space_left:=SIZE_OF_SHA_256_CHUNK
	sha_256.total_len:=0

	/*
	 * Initialize hash values (first 32 bits of the fractional parts of the square roots of the first 8 primes
	 * 2..19):
	 */
	sha_256.h[0]:=$6a09e667
	sha_256.h[1]:=$bb67ae85
	sha_256.h[2]:=$3c6ef372
	sha_256.h[3]:=$a54ff53a
	sha_256.h[4]:=$510e527f
	sha_256.h[5]:=$9b05688c
	sha_256.h[6]:=$1f83d9ab
	sha_256.h[7]:=$5be0cd19
ENDPROC

PROC sha_256_write(sha_256:PTR TO sha_256, data,len)
  DEF p
  DEF consumed_len
  p:=data
	sha_256.total_len:=sha_256.total_len+len

	WHILE (len > 0)
		/*
		 * If the input chunks have sizes that are multiples of the calculation chunk size, no copies are
		 * necessary. We operate directly on the input data instead.
		 */
		IF ((sha_256.space_left = SIZE_OF_SHA_256_CHUNK) AND (len >= SIZE_OF_SHA_256_CHUNK))
			consume_chunk(sha_256.h, p)
			len -= SIZE_OF_SHA_256_CHUNK
			p += SIZE_OF_SHA_256_CHUNK
			CONT TRUE
		ENDIF
		/* General case, no particular optimization. */
		consumed_len:=IF (len < sha_256.space_left) THEN len ELSE sha_256.space_left
		CopyMem(p, sha_256.chunk_pos, consumed_len)
		sha_256.space_left -= consumed_len
		len -= consumed_len
		p += consumed_len
		IF (sha_256.space_left = 0)
			consume_chunk(sha_256.h, sha_256.chunk)
			sha_256.chunk_pos:=sha_256.chunk
			sha_256.space_left:=SIZE_OF_SHA_256_CHUNK
		ELSE
			sha_256.chunk_pos:=sha_256.chunk_pos+consumed_len
		ENDIF
	ENDWHILE
ENDPROC

PROC sha_256_close(sha_256:PTR TO sha_256)

  DEF pos:PTR TO CHAR
  DEF space_left
  DEF h:PTR TO LONG
  DEF left,len,i,hash:PTR TO LONG
  pos:=sha_256.chunk_pos
  space_left:=sha_256.space_left
  h:=sha_256.h
	/*
	 * The current chunk cannot be full. Otherwise, it would already have be consumed. I.e. there is space left for
	 * at least one byte. The next step in the calculation is to add a single one-bit to the data.
	 */
	pos[]++:=$80
	space_left--

	/*
	 * Now, the last step is to add the total data length at the end of the last chunk, and zero padding before
	 * that. But we do not necessarily have enough space left. If not, we pad the current chunk with zeroes, and add
	 * an extra chunk at the end.
	 */
	IF (space_left < TOTAL_LEN_LEN)
    MemFill(pos,space_left,0)
		consume_chunk(h, sha_256.chunk)
		pos:=sha_256.chunk
		space_left:=SIZE_OF_SHA_256_CHUNK
	ENDIF
	left:=space_left - TOTAL_LEN_LEN
  MemFill(pos,left,0)
	pos+= left
	len:=sha_256.total_len
	pos[7]:=Lsl(len,3)
  len:=Lsr(len,5)
	FOR i:=6 TO 0 STEP -1
		pos[i]:=len
		len:=Lsr(len,8)
	ENDFOR
	consume_chunk(h, sha_256.chunk)
	/* Produce the final hash value (big-endian): */
  hash:=sha_256.hash
	FOR i:=0 TO 7
    hash[i]:=h[i]
	ENDFOR
	
ENDPROC sha_256.hash

EXPORT PROC calc_sha_1(hash:PTR TO CHAR, input, len)
  DEF context:PTR TO sha1_ctx
  
  NEW context
  sha1_init(context)
  sha1_update(context, input, len)
  sha1_final(hash,context)
  END context
ENDPROC

EXPORT PROC calc_sha_256(hash:PTR TO CHAR, input, len)
  DEF sha_256:PTR TO sha_256
  
  NEW sha_256
  sha_256_init(sha_256, hash)
  sha_256_write(sha_256, input, len)
  sha_256_close(sha_256)
  END sha_256
ENDPROC

kdata:  LONG $428a2f98, $71374491, $b5c0fbcf, $e9b5dba5, $3956c25b, $59f111f1, $923f82a4,
			    $ab1c5ed5, $d807aa98, $12835b01, $243185be, $550c7dc3, $72be5d74, $80deb1fe,
			    $9bdc06a7, $c19bf174, $e49b69c1, $efbe4786, $0fc19dc6, $240ca1cc, $2de92c6f,
			    $4a7484aa, $5cb0a9dc, $76f988da, $983e5152, $a831c66d, $b00327c8, $bf597fc7,
			    $c6e00bf3, $d5a79147, $06ca6351, $14292967, $27b70a85, $2e1b2138, $4d2c6dfc,
			    $53380d13, $650a7354, $766a0abb, $81c2c92e, $92722c85, $a2bfe8a1, $a81a664b,
			    $c24b8b70, $c76c51a3, $d192e819, $d6990624, $f40e3585, $106aa070, $19a4c116,
			    $1e376c08, $2748774c, $34b0bcb5, $391c0cb3, $4ed8aa4a, $5b9cca4f, $682e6ff3,
			    $748f82ee, $78a5636f, $84c87814, $8cc70208, $90befffa, $a4506ceb, $bef9a3f7,
			    $c67178f2

/*  $OpenBSD: pkcs5_pbkdf2.c,v 1.11 2019/11/21 16:07:24 tedu Exp $  */

/*-
 * Copyright (c) 2008 Damien Bergamini <damien.bergamini@free.fr>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

EXPORT PROC hmac_sha1(text:PTR TO CHAR, text_len, key:PTR TO CHAR, key_len, digest:PTR TO CHAR)
  DEF k_pad:PTR TO CHAR
  DEF tk[SHA1_DIGEST_SIZE]:ARRAY OF CHAR
  DEF i

  k_pad:=New(SIZE_OF_SHA_1_CHUNK+text_len)

  IF (key_len > SIZE_OF_SHA_1_CHUNK)
    calc_sha_1(tk,key, key_len)
    key:=tk
    key_len:=SHA1_DIGEST_SIZE
  ENDIF

  CopyMem(key,k_pad, key_len)
  CopyMem(text,k_pad+SIZE_OF_SHA_1_CHUNK, text_len)
  FOR i:=0 TO SIZE_OF_SHA_1_CHUNK-1 DO k_pad[i]:=Eor(k_pad[i],$36)

  calc_sha_1(digest,k_pad, SIZE_OF_SHA_1_CHUNK+text_len)
  Dispose(k_pad)

  k_pad:=New(SIZE_OF_SHA_1_CHUNK+SHA1_DIGEST_SIZE)
  CopyMem(key,k_pad,key_len)
  CopyMem(digest, k_pad+SIZE_OF_SHA_1_CHUNK, SHA1_DIGEST_SIZE)

  FOR i:=0 TO SIZE_OF_SHA_1_CHUNK-1 DO k_pad[i]:=Eor(k_pad[i],$5c)

  calc_sha_1(digest,k_pad, SIZE_OF_SHA_1_CHUNK+SHA1_DIGEST_SIZE)
  Dispose(k_pad)
ENDPROC

EXPORT PROC hmac_sha256(text:PTR TO CHAR, text_len, key:PTR TO CHAR, key_len, digest:PTR TO CHAR)
  DEF k_pad:PTR TO CHAR
  DEF tk[SIZE_OF_SHA_256_HASH]:ARRAY OF CHAR
  DEF i

  k_pad:=New(SIZE_OF_SHA_256_CHUNK+text_len)

  IF (key_len > SIZE_OF_SHA_256_CHUNK)
    calc_sha_256(tk,key, key_len)
    key:=tk
    key_len:=SIZE_OF_SHA_256_HASH
  ENDIF

  CopyMem(key,k_pad, key_len)
  CopyMem(text,k_pad+SIZE_OF_SHA_256_CHUNK, text_len)
  FOR i:=0 TO SIZE_OF_SHA_256_CHUNK-1 DO k_pad[i]:=Eor(k_pad[i],$36)

  calc_sha_256(digest,k_pad, SIZE_OF_SHA_256_CHUNK+text_len)
  Dispose(k_pad)

  k_pad:=New(SIZE_OF_SHA_256_CHUNK+SIZE_OF_SHA_256_HASH)
  CopyMem(key,k_pad,key_len)
  CopyMem(digest, k_pad+SIZE_OF_SHA_256_CHUNK, SIZE_OF_SHA_256_HASH)

  FOR i:=0 TO SIZE_OF_SHA_256_CHUNK-1 DO k_pad[i]:=Eor(k_pad[i],$5c)

  calc_sha_256(digest,k_pad, SIZE_OF_SHA_256_CHUNK+SIZE_OF_SHA_256_HASH)
  Dispose(k_pad)
ENDPROC

/*
 * Password-Based Key Derivation Function 2 (PKCS #5 v2.0).
 * Code based on IEEE Std 802.11-2007, Annex H.4.2.
 */
EXPORT PROC pkcs5_pbkdf2(pass:PTR TO CHAR, pass_len, salt:PTR TO CHAR, salt_len, key:PTR TO CHAR, key_len, rounds)
    DEF asalt:PTR TO CHAR
    DEF obuf[SIZE_OF_SHA_256_HASH]:ARRAY OF CHAR
    DEF d1[SIZE_OF_SHA_256_HASH]: ARRAY OF CHAR
    DEF d2[SIZE_OF_SHA_256_HASH]:ARRAY OF CHAR
    DEF i,j,count,r

    IF ((rounds < 1) OR (key_len = 0)) THEN JUMP bad
    
    IF ((salt_len = 0) OR (salt_len > ($7fffffff - 4))) THEN JUMP bad
    
    IF ((asalt:=New(salt_len + 4))=0) THEN JUMP bad

    CopyMem(salt, asalt, salt_len)
    
    count:=0
    WHILE(key_len>0)
      count++
      asalt[salt_len]:=Shr(count,24)
      asalt[salt_len+1]:=Shr(count,16)
      asalt[salt_len+2]:=Shr(count,8)
      asalt[salt_len+3]:=count AND 255

      hmac_sha256(asalt, salt_len + 4, pass, pass_len, d1)     
      CopyMem(d1,obuf,SIZE_OF_SHA_256_HASH)

      FOR i:=1 TO rounds-1
        hmac_sha256(d1, SIZE_OF_SHA_256_HASH, pass, pass_len, d2)
        CopyMem(d2,d1,SIZE_OF_SHA_256_HASH)
        FOR j:=0 TO SIZE_OF_SHA_256_HASH-1
          obuf[j]:=Eor(obuf[j],d1[j])
        ENDFOR
      ENDFOR

      IF key_len < SIZE_OF_SHA_256_HASH THEN r:=key_len ELSE r:=SIZE_OF_SHA_256_HASH
      CopyMem(obuf,key,r)
      key+=r
      key_len-=r
    ENDWHILE

    MemFill(asalt,salt_len + 4,0)    
    Dispose(asalt)
    
    MemFill(d1,SIZE_OF_SHA_256_HASH,0)    
    MemFill(d2,SIZE_OF_SHA_256_HASH,0)    
    MemFill(obuf,SIZE_OF_SHA_256_HASH,0)    

    RETURN 0

bad:
    /* overwrite with 0 in case caller doesn't check return code */
    MemFill(key,key_len,0)
ENDPROC -1

EXPORT PROC calcPasswordSalt(s:PTR TO CHAR)
  DEF i
  FOR i:=0 TO 7
    s[i]:=Rnd(95)+32
  ENDFOR
ENDPROC
