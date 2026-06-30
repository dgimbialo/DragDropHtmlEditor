; This font occupies 1805 bytes packed into 639 instruction words
	.include    "cpu.inc"
	.section    .font,code
	.global	    _Square_8

_Square_8:
	.pbyte	8	;Em Height
	.pbyte	2	;Top Margin
	.pbyte	0	;Bottom Margin
	.pbyte	0x20,0x00	;first character code
	.pbyte	0	;reserved
	.pbyte	0x83,0x00	;last character code
	.pbyte	0	;reserved
	.pbyte	14	;Bitmap Height
	.pbyte	11	;Baseline, from top of bitmap
	.pbyte	16	;Bitmap Width
;start of the map is at _Square_8 + 8
	.pbyte	(  104 &0xff), (  104 >>8)&0xff,  4		; ' '
	.pbyte	(  109 &0xff), (  109 >>8)&0xff,  3		; '!'
	.pbyte	(  114 &0xff), (  114 >>8)&0xff,  3		; '"'
	.pbyte	(  119 &0xff), (  119 >>8)&0xff,  8		; '#'
	.pbyte	(  124 &0xff), (  124 >>8)&0xff,  7		; '$'
	.pbyte	(  129 &0xff), (  129 >>8)&0xff, 10		; '%'
	.pbyte	(  139 &0xff), (  139 >>8)&0xff,  8		; '&'
	.pbyte	(  144 &0xff), (  144 >>8)&0xff,  2		; '''
	.pbyte	(  149 &0xff), (  149 >>8)&0xff,  4		; '('
	.pbyte	(  154 &0xff), (  154 >>8)&0xff,  4		; ')'
	.pbyte	(  159 &0xff), (  159 >>8)&0xff,  6		; '*'
	.pbyte	(  164 &0xff), (  164 >>8)&0xff,  9		; '+'
	.pbyte	(  174 &0xff), (  174 >>8)&0xff,  4		; ','
	.pbyte	(  179 &0xff), (  179 >>8)&0xff,  4		; '-'
	.pbyte	(  184 &0xff), (  184 >>8)&0xff,  4		; '.'
	.pbyte	(  189 &0xff), (  189 >>8)&0xff,  3		; '/'
	.pbyte	(  194 &0xff), (  194 >>8)&0xff,  7		; '0'
	.pbyte	(  199 &0xff), (  199 >>8)&0xff,  7		; '1'
	.pbyte	(  204 &0xff), (  204 >>8)&0xff,  7		; '2'
	.pbyte	(  209 &0xff), (  209 >>8)&0xff,  7		; '3'
	.pbyte	(  214 &0xff), (  214 >>8)&0xff,  7		; '4'
	.pbyte	(  219 &0xff), (  219 >>8)&0xff,  7		; '5'
	.pbyte	(  224 &0xff), (  224 >>8)&0xff,  7		; '6'
	.pbyte	(  229 &0xff), (  229 >>8)&0xff,  7		; '7'
	.pbyte	(  234 &0xff), (  234 >>8)&0xff,  7		; '8'
	.pbyte	(  239 &0xff), (  239 >>8)&0xff,  7		; '9'
	.pbyte	(  244 &0xff), (  244 >>8)&0xff,  4		; ':'
	.pbyte	(  249 &0xff), (  249 >>8)&0xff,  4		; ';'
	.pbyte	(  254 &0xff), (  254 >>8)&0xff,  9		; '<'
	.pbyte	(  264 &0xff), (  264 >>8)&0xff,  9		; '='
	.pbyte	(  274 &0xff), (  274 >>8)&0xff,  9		; '>'
	.pbyte	(  284 &0xff), (  284 >>8)&0xff,  6		; '?'
	.pbyte	(  289 &0xff), (  289 >>8)&0xff, 11		; '@'
	.pbyte	(  299 &0xff), (  299 >>8)&0xff,  8		; 'A'
	.pbyte	(  304 &0xff), (  304 >>8)&0xff,  8		; 'B'
	.pbyte	(  309 &0xff), (  309 >>8)&0xff,  8		; 'C'
	.pbyte	(  314 &0xff), (  314 >>8)&0xff,  8		; 'D'
	.pbyte	(  319 &0xff), (  319 >>8)&0xff,  7		; 'E'
	.pbyte	(  324 &0xff), (  324 >>8)&0xff,  7		; 'F'
	.pbyte	(  329 &0xff), (  329 >>8)&0xff,  8		; 'G'
	.pbyte	(  334 &0xff), (  334 >>8)&0xff,  8		; 'H'
	.pbyte	(  339 &0xff), (  339 >>8)&0xff,  3		; 'I'
	.pbyte	(  344 &0xff), (  344 >>8)&0xff,  6		; 'J'
	.pbyte	(  349 &0xff), (  349 >>8)&0xff,  7		; 'K'
	.pbyte	(  354 &0xff), (  354 >>8)&0xff,  7		; 'L'
	.pbyte	(  359 &0xff), (  359 >>8)&0xff, 10		; 'M'
	.pbyte	(  369 &0xff), (  369 >>8)&0xff,  9		; 'N'
	.pbyte	(  379 &0xff), (  379 >>8)&0xff,  8		; 'O'
	.pbyte	(  384 &0xff), (  384 >>8)&0xff,  7		; 'P'
	.pbyte	(  389 &0xff), (  389 >>8)&0xff,  8		; 'Q'
	.pbyte	(  394 &0xff), (  394 >>8)&0xff,  8		; 'R'
	.pbyte	(  399 &0xff), (  399 >>8)&0xff,  8		; 'S'
	.pbyte	(  404 &0xff), (  404 >>8)&0xff,  6		; 'T'
	.pbyte	(  409 &0xff), (  409 >>8)&0xff,  8		; 'U'
	.pbyte	(  414 &0xff), (  414 >>8)&0xff,  7		; 'V'
	.pbyte	(  419 &0xff), (  419 >>8)&0xff, 11		; 'W'
	.pbyte	(  429 &0xff), (  429 >>8)&0xff,  7		; 'X'
	.pbyte	(  434 &0xff), (  434 >>8)&0xff,  7		; 'Y'
	.pbyte	(  439 &0xff), (  439 >>8)&0xff,  7		; 'Z'
	.pbyte	(  444 &0xff), (  444 >>8)&0xff,  4		; '['
	.pbyte	(  449 &0xff), (  449 >>8)&0xff,  3		; '/'
	.pbyte	(  454 &0xff), (  454 >>8)&0xff,  4		; ']'
	.pbyte	(  459 &0xff), (  459 >>8)&0xff, 11		; '^'
	.pbyte	(  469 &0xff), (  469 >>8)&0xff,  6		; '_'
	.pbyte	(  474 &0xff), (  474 >>8)&0xff,  6		; '`'
	.pbyte	(  479 &0xff), (  479 >>8)&0xff,  6		; 'a'
	.pbyte	(  484 &0xff), (  484 >>8)&0xff,  6		; 'b'
	.pbyte	(  489 &0xff), (  489 >>8)&0xff,  6		; 'c'
	.pbyte	(  494 &0xff), (  494 >>8)&0xff,  6		; 'd'
	.pbyte	(  499 &0xff), (  499 >>8)&0xff,  6		; 'e'
	.pbyte	(  504 &0xff), (  504 >>8)&0xff,  4		; 'f'
	.pbyte	(  509 &0xff), (  509 >>8)&0xff,  6		; 'g'
	.pbyte	(  514 &0xff), (  514 >>8)&0xff,  6		; 'h'
	.pbyte	(  519 &0xff), (  519 >>8)&0xff,  3		; 'i'
	.pbyte	(  524 &0xff), (  524 >>8)&0xff,  3		; 'j'
	.pbyte	(  529 &0xff), (  529 >>8)&0xff,  5		; 'k'
	.pbyte	(  534 &0xff), (  534 >>8)&0xff,  3		; 'l'
	.pbyte	(  539 &0xff), (  539 >>8)&0xff, 10		; 'm'
	.pbyte	(  549 &0xff), (  549 >>8)&0xff,  6		; 'n'
	.pbyte	(  554 &0xff), (  554 >>8)&0xff,  6		; 'o'
	.pbyte	(  559 &0xff), (  559 >>8)&0xff,  6		; 'p'
	.pbyte	(  564 &0xff), (  564 >>8)&0xff,  6		; 'q'
	.pbyte	(  569 &0xff), (  569 >>8)&0xff,  5		; 'r'
	.pbyte	(  574 &0xff), (  574 >>8)&0xff,  6		; 's'
	.pbyte	(  579 &0xff), (  579 >>8)&0xff,  5		; 't'
	.pbyte	(  584 &0xff), (  584 >>8)&0xff,  6		; 'u'
	.pbyte	(  589 &0xff), (  589 >>8)&0xff,  5		; 'v'
	.pbyte	(  594 &0xff), (  594 >>8)&0xff,  9		; 'w'
	.pbyte	(  604 &0xff), (  604 >>8)&0xff,  6		; 'x'
	.pbyte	(  609 &0xff), (  609 >>8)&0xff,  5		; 'y'
	.pbyte	(  614 &0xff), (  614 >>8)&0xff,  6		; 'z'
	.pbyte	(  619 &0xff), (  619 >>8)&0xff,  6		; '{'
	.pbyte	(  624 &0xff), (  624 >>8)&0xff,  6		; '|'
	.pbyte	(  629 &0xff), (  629 >>8)&0xff,  6		; '}'
	.pbyte	(  634 &0xff), (  634 >>8)&0xff,  9		; '~'
	.pbyte	(  644 &0xff), (  644 >>8)&0xff,  4		; ''
	.pbyte	(  649 &0xff), (  649 >>8)&0xff,  7		; '�'
	.pbyte	(  654 &0xff), (  654 >>8)&0xff,  6		; '�'
	.pbyte	(  659 &0xff), (  659 >>8)&0xff,  9		; '�'
	.pbyte	(  669 &0xff), (  669 >>8)&0xff,  8		; '�'

Square721BT_8_Glyphs:
; Character 20 ' '
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 21 '!'
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x00			;  |   |
	.pbyte	0x02			;  | # |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 22 '"'
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x05			;  |# #|
	.pbyte	0x05			;  |# #|
	.pbyte	0x05			;  |# #|
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 23 '#'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x50			;  |    # # |
	.pbyte	0x50			;  |    # # |
	.pbyte	0x48			;  |   #  # |
	.pbyte	0xFC			;  |  ######|
	.pbyte	0x28			;  |   # #  |
	.pbyte	0x7E			;  | ###### |
	.pbyte	0x14			;  |  # #   |
	.pbyte	0x14			;  |  # #   |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 24 '$'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x49			;  |#  #  #|
	.pbyte	0x09			;  |#  #   |
	.pbyte	0x3E			;  | ##### |
	.pbyte	0x48			;  |   #  #|
	.pbyte	0x49			;  |#  #  #|
	.pbyte	0x49			;  |#  #  #|
	.pbyte	0x3E			;  | ##### |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 25 '%'
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x2F,0x00			;  |#### #    |
	.pbyte	0x29,0x00			;  |#  # #    |
	.pbyte	0x19,0x00			;  |#  ##     |
	.pbyte	0xF9,0x01			;  |#  ###### |
	.pbyte	0x3F,0x01			;  |######  # |
	.pbyte	0x28,0x01			;  |   # #  # |
	.pbyte	0x28,0x01			;  |   # #  # |
	.pbyte	0xE8,0x01			;  |   # #### |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 26 '&'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x7C			;  |  ##### |
	.pbyte	0x44			;  |  #   # |
	.pbyte	0x04			;  |  #     |
	.pbyte	0x1C			;  |  ###   |
	.pbyte	0x52			;  | #  # # |
	.pbyte	0x62			;  | #   ## |
	.pbyte	0xC2			;  | #    ##|
	.pbyte	0xBC			;  |  #### #|
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 27 '''
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x02			;  | #|
	.pbyte	0x02			;  | #|
	.pbyte	0x02			;  | #|
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 28 '('
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x06			;  | ## |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x06			;  | ## |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 29 ')'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x03			;  |##  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x03			;  |##  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 2A '*'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x14			;  |  # # |
	.pbyte	0x36			;  | ## ##|
	.pbyte	0x14			;  |  # # |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 2B '+'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x10,0x00			;  |    #    |
	.pbyte	0x10,0x00			;  |    #    |
	.pbyte	0x10,0x00			;  |    #    |
	.pbyte	0xFE,0x00			;  | ####### |
	.pbyte	0x10,0x00			;  |    #    |
	.pbyte	0x10,0x00			;  |    #    |
	.pbyte	0x10,0x00			;  |    #    |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 2C ','
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 2D '-'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x0E			;  | ###|
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 2E '.'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 2F '/'
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x04			;  |  #|
	.pbyte	0x04			;  |  #|
	.pbyte	0x04			;  |  #|
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x01			;  |#  |
	.pbyte	0x01			;  |#  |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 30 '0'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x3C			;  |  #### |
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x3C			;  |  #### |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 31 '1'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x18			;  |   ##  |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x10			;  |    #  |
	.pbyte	0x10			;  |    #  |
	.pbyte	0x10			;  |    #  |
	.pbyte	0x10			;  |    #  |
	.pbyte	0x10			;  |    #  |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 32 '2'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x3C			;  |  #### |
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x40			;  |      #|
	.pbyte	0x38			;  |   ### |
	.pbyte	0x06			;  | ##    |
	.pbyte	0x02			;  | #     |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 33 '3'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x7C			;  |  #####|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x38			;  |   ### |
	.pbyte	0x40			;  |      #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x3C			;  |  #### |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 34 '4'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x30			;  |    ## |
	.pbyte	0x28			;  |   # # |
	.pbyte	0x28			;  |   # # |
	.pbyte	0x24			;  |  #  # |
	.pbyte	0x22			;  | #   # |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x20			;  |     # |
	.pbyte	0x20			;  |     # |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 35 '5'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x3E			;  | ##### |
	.pbyte	0x40			;  |      #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x3C			;  |  #### |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 36 '6'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x3C			;  |  #### |
	.pbyte	0x42			;  | #    #|
	.pbyte	0x02			;  | #     |
	.pbyte	0x3E			;  | ##### |
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x7C			;  |  #####|
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 37 '7'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x40			;  |      #|
	.pbyte	0x20			;  |     # |
	.pbyte	0x20			;  |     # |
	.pbyte	0x10			;  |    #  |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x04			;  |  #    |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 38 '8'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x3C			;  |  #### |
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x7C			;  |  #####|
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 39 '9'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x3E			;  | ##### |
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x7C			;  |  #####|
	.pbyte	0x40			;  |      #|
	.pbyte	0x40			;  |      #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x3C			;  |  #### |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 3A ':'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 3B ';'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 3C '<'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x40,0x00			;  |      #  |
	.pbyte	0x30,0x00			;  |    ##   |
	.pbyte	0x0C,0x00			;  |  ##     |
	.pbyte	0x06,0x00			;  | ##      |
	.pbyte	0x18,0x00			;  |   ##    |
	.pbyte	0x60,0x00			;  |     ##  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 3D '='
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x7E,0x00			;  | ######  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x7E,0x00			;  | ######  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 3E '>'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x0C,0x00			;  |  ##     |
	.pbyte	0x30,0x00			;  |    ##   |
	.pbyte	0x60,0x00			;  |     ##  |
	.pbyte	0x18,0x00			;  |   ##    |
	.pbyte	0x06,0x00			;  | ##      |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 3F '?'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x3C			;  |  ####|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x20			;  |     #|
	.pbyte	0x18			;  |   ## |
	.pbyte	0x08			;  |   #  |
	.pbyte	0x00			;  |      |
	.pbyte	0x08			;  |   #  |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 40 '@'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xF0,0x01			;  |    #####  |
	.pbyte	0x0C,0x02			;  |  ##     # |
	.pbyte	0xF4,0x04			;  |  # ####  #|
	.pbyte	0x9A,0x04			;  | # ##  #  #|
	.pbyte	0x4A,0x04			;  | # #  #   #|
	.pbyte	0x4A,0x02			;  | # #  #  # |
	.pbyte	0xBA,0x01			;  | # ### ##  |
	.pbyte	0x0C,0x00			;  |  ##       |
	.pbyte	0xF8,0x01			;  |   ######  |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 41 'A'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x14			;  |  # #   |
	.pbyte	0x14			;  |  # #   |
	.pbyte	0x12			;  | #  #   |
	.pbyte	0x22			;  | #   #  |
	.pbyte	0x3E			;  | #####  |
	.pbyte	0x21			;  |#    #  |
	.pbyte	0x41			;  |#     # |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 42 'B'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x7E			;  | ###### |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x3E			;  | #####  |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x7E			;  | ###### |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 43 'C'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x3C			;  |  ####  |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x02			;  | #      |
	.pbyte	0x02			;  | #      |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x3C			;  |  ####  |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 44 'D'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x7E			;  | ###### |
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x7E			;  | ###### |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 45 'E'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 46 'F'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x3E			;  | ##### |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x3E			;  | ##### |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 47 'G'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x7C			;  |  ##### |
	.pbyte	0x82			;  | #     #|
	.pbyte	0x02			;  | #      |
	.pbyte	0x02			;  | #      |
	.pbyte	0xE2			;  | #   ###|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x7C			;  |  ##### |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 48 'H'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x7E			;  | ###### |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 49 'I'
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 4A 'J'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x10			;  |    # |
	.pbyte	0x10			;  |    # |
	.pbyte	0x10			;  |    # |
	.pbyte	0x10			;  |    # |
	.pbyte	0x10			;  |    # |
	.pbyte	0x11			;  |#   # |
	.pbyte	0x11			;  |#   # |
	.pbyte	0x0E			;  | ###  |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 4B 'K'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x62			;  | #   ##|
	.pbyte	0x12			;  | #  #  |
	.pbyte	0x0A			;  | # #   |
	.pbyte	0x0E			;  | ###   |
	.pbyte	0x0A			;  | # #   |
	.pbyte	0x12			;  | #  #  |
	.pbyte	0x22			;  | #   # |
	.pbyte	0x62			;  | #   ##|
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 4C 'L'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x3E			;  | ##### |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 4D 'M'
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x86,0x01			;  | ##    ## |
	.pbyte	0x86,0x01			;  | ##    ## |
	.pbyte	0x46,0x01			;  | ##   # # |
	.pbyte	0x4A,0x01			;  | # #  # # |
	.pbyte	0x4A,0x01			;  | # #  # # |
	.pbyte	0x2A,0x01			;  | # # #  # |
	.pbyte	0x32,0x01			;  | #  ##  # |
	.pbyte	0x32,0x01			;  | #  ##  # |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 4E 'N'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x86,0x00			;  | ##    # |
	.pbyte	0x86,0x00			;  | ##    # |
	.pbyte	0x8A,0x00			;  | # #   # |
	.pbyte	0x92,0x00			;  | #  #  # |
	.pbyte	0x92,0x00			;  | #  #  # |
	.pbyte	0xA2,0x00			;  | #   # # |
	.pbyte	0xC2,0x00			;  | #    ## |
	.pbyte	0xC2,0x00			;  | #    ## |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 4F 'O'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x7C			;  |  ##### |
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x7C			;  |  ##### |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 50 'P'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x7E			;  | ######|
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 51 'Q'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x7C			;  |  ##### |
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0xA2			;  | #   # #|
	.pbyte	0xC2			;  | #    ##|
	.pbyte	0xFC			;  |  ######|
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 52 'R'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x7E			;  | ###### |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x3E			;  | #####  |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 53 'S'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x7E			;  | ###### |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x02			;  | #      |
	.pbyte	0x0E			;  | ###    |
	.pbyte	0x70			;  |    ### |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x7C			;  |  ##### |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 54 'T'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x3F			;  |######|
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 55 'U'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x3C			;  |  ####  |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 56 'V'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x41			;  |#     #|
	.pbyte	0x21			;  |#    # |
	.pbyte	0x22			;  | #   # |
	.pbyte	0x22			;  | #   # |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 57 'W'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x31,0x02			;  |#   ##   # |
	.pbyte	0x31,0x02			;  |#   ##   # |
	.pbyte	0x32,0x01			;  | #  ##  #  |
	.pbyte	0x2A,0x01			;  | # # #  #  |
	.pbyte	0x4A,0x01			;  | # #  # #  |
	.pbyte	0x4A,0x01			;  | # #  # #  |
	.pbyte	0xCC,0x00			;  |  ##  ##   |
	.pbyte	0x84,0x00			;  |  #    #   |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 58 'X'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x63			;  |##   ##|
	.pbyte	0x22			;  | #   # |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x0C			;  |  ##   |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x22			;  | #   # |
	.pbyte	0x41			;  |#     #|
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 59 'Y'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x41			;  |#     #|
	.pbyte	0x22			;  | #   # |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 5A 'Z'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x40			;  |      #|
	.pbyte	0x20			;  |     # |
	.pbyte	0x10			;  |    #  |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x04			;  |  #    |
	.pbyte	0x02			;  | #     |
	.pbyte	0x7E			;  | ######|
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 5B '['
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x06			;  | ## |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x06			;  | ## |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 5C '/'
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x01			;  |#  |
	.pbyte	0x01			;  |#  |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x04			;  |  #|
	.pbyte	0x04			;  |  #|
	.pbyte	0x04			;  |  #|
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 5D ']'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x03			;  |##  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x03			;  |##  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 5E '^'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x30,0x00			;  |    ##     |
	.pbyte	0x48,0x00			;  |   #  #    |
	.pbyte	0x84,0x00			;  |  #    #   |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 5F '_'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x3F			;  |######|
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 60 '`'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x02			;  | #    |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 61 'a'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x3E			;  | #####|
	.pbyte	0x20			;  |     #|
	.pbyte	0x3E			;  | #####|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x3E			;  | #####|
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 62 'b'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x02			;  | #    |
	.pbyte	0x02			;  | #    |
	.pbyte	0x1E			;  | #### |
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x1E			;  | #### |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 63 'c'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x1C			;  |  ### |
	.pbyte	0x22			;  | #   #|
	.pbyte	0x02			;  | #    |
	.pbyte	0x02			;  | #    |
	.pbyte	0x22			;  | #   #|
	.pbyte	0x3E			;  | #####|
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 64 'd'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x20			;  |     #|
	.pbyte	0x20			;  |     #|
	.pbyte	0x3C			;  |  ####|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x3C			;  |  ####|
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 65 'e'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x3E			;  | #####|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x3E			;  | #####|
	.pbyte	0x02			;  | #    |
	.pbyte	0x22			;  | #   #|
	.pbyte	0x1C			;  |  ### |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 66 'f'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x0E			;  | ###|
	.pbyte	0x02			;  | #  |
	.pbyte	0x0F			;  |####|
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 67 'g'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x3C			;  |  ####|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x3C			;  |  ####|
	.pbyte	0x20			;  |     #|
	.pbyte	0x3E			;  | #####|
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 68 'h'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x02			;  | #    |
	.pbyte	0x02			;  | #    |
	.pbyte	0x3E			;  | #####|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 69 'i'
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x02			;  | # |
	.pbyte	0x00			;  |   |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 6A 'j'
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x02			;  | # |
	.pbyte	0x00			;  |   |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x03			;  |## |
	.pbyte	0x00			;  |   |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 6B 'k'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x1A			;  | # ##|
	.pbyte	0x0A			;  | # # |
	.pbyte	0x06			;  | ##  |
	.pbyte	0x06			;  | ##  |
	.pbyte	0x0A			;  | # # |
	.pbyte	0x12			;  | #  #|
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 6C 'l'
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x02			;  | # |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00			;  |   |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 6D 'm'
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0xFE,0x00			;  | #######  |
	.pbyte	0x92,0x00			;  | #  #  #  |
	.pbyte	0x92,0x00			;  | #  #  #  |
	.pbyte	0x92,0x00			;  | #  #  #  |
	.pbyte	0x92,0x00			;  | #  #  #  |
	.pbyte	0x92,0x00			;  | #  #  #  |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 6E 'n'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x3E			;  | #####|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 6F 'o'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x1C			;  |  ### |
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x1C			;  |  ### |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 70 'p'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x1E			;  | #### |
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x1E			;  | #### |
	.pbyte	0x02			;  | #    |
	.pbyte	0x02			;  | #    |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 71 'q'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x3C			;  |  ####|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x3C			;  |  ####|
	.pbyte	0x20			;  |     #|
	.pbyte	0x20			;  |     #|
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 72 'r'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x1E			;  | ####|
	.pbyte	0x12			;  | #  #|
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 73 's'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x3E			;  | #####|
	.pbyte	0x02			;  | #    |
	.pbyte	0x3E			;  | #####|
	.pbyte	0x20			;  |     #|
	.pbyte	0x20			;  |     #|
	.pbyte	0x3E			;  | #####|
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 74 't'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x02			;  | #   |
	.pbyte	0x1F			;  |#####|
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x12			;  | #  #|
	.pbyte	0x1E			;  | ####|
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 75 'u'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x22			;  | #   #|
	.pbyte	0x3E			;  | #####|
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 76 'v'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x11			;  |#   #|
	.pbyte	0x11			;  |#   #|
	.pbyte	0x0A			;  | # # |
	.pbyte	0x0A			;  | # # |
	.pbyte	0x0A			;  | # # |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 77 'w'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x99,0x00			;  |#  ##  # |
	.pbyte	0x99,0x00			;  |#  ##  # |
	.pbyte	0x59,0x00			;  |#  ## #  |
	.pbyte	0x56,0x00			;  | ## # #  |
	.pbyte	0x66,0x00			;  | ##  ##  |
	.pbyte	0x66,0x00			;  | ##  ##  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 78 'x'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x19			;  |#  ## |
	.pbyte	0x0A			;  | # #  |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x06			;  | ##   |
	.pbyte	0x0A			;  | # #  |
	.pbyte	0x11			;  |#   # |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 79 'y'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x11			;  |#   #|
	.pbyte	0x09			;  |#  # |
	.pbyte	0x0A			;  | # # |
	.pbyte	0x0A			;  | # # |
	.pbyte	0x06			;  | ##  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x02			;  | #   |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 7A 'z'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x3E			;  | #####|
	.pbyte	0x10			;  |    # |
	.pbyte	0x08			;  |   #  |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x02			;  | #    |
	.pbyte	0x3E			;  | #####|
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 7B '{'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x18			;  |   ## |
	.pbyte	0x08			;  |   #  |
	.pbyte	0x08			;  |   #  |
	.pbyte	0x08			;  |   #  |
	.pbyte	0x06			;  | ##   |
	.pbyte	0x08			;  |   #  |
	.pbyte	0x08			;  |   #  |
	.pbyte	0x08			;  |   #  |
	.pbyte	0x08			;  |   #  |
	.pbyte	0x18			;  |   ## |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 7C '|'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 7D '}'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x06			;  | ##   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x18			;  |   ## |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x04			;  |  #   |
	.pbyte	0x06			;  | ##   |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 7E '~'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x4C,0x00			;  |  ##  #  |
	.pbyte	0x32,0x00			;  | #  ##   |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 7F ''
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x07			;  |### |
	.pbyte	0x05			;  |# # |
	.pbyte	0x07			;  |### |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 80 '�'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x08			;  |   #   |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x14			;  |  # #  |
	.pbyte	0x12			;  | #  #  |
	.pbyte	0x22			;  | #   # |
	.pbyte	0x22			;  | #   # |
	.pbyte	0x21			;  |#    # |
	.pbyte	0x7F			;  |#######|
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 81 '�'
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x12			;  | #  # |
	.pbyte	0x11			;  |#   # |
	.pbyte	0x09			;  |#  #  |
	.pbyte	0x09			;  |#  #  |
	.pbyte	0x09			;  |#  #  |
	.pbyte	0x17			;  |### # |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 82 '�'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x6C,0x00			;  |  ## ##  |
	.pbyte	0x92,0x00			;  | #  #  # |
	.pbyte	0x92,0x00			;  | #  #  # |
	.pbyte	0x6C,0x00			;  |  ## ##  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 83 '�'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x38			;  |   ###  |
	.pbyte	0x44			;  |  #   # |
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x44			;  |  #   # |
	.pbyte	0xEE			;  | ### ###|
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes

	.end
