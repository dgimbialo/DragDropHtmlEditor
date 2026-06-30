; This font occupies 3588 bytes packed into 1252 instruction words
	.include    "cpu.inc"
	.section    .font,code
	.global	_Square_12

_Square_12:
	.pbyte	12	;Em Height
	.pbyte	3	;Top Margin
	.pbyte	0	;Bottom Margin
	.pbyte	0x20,0x00	;first character code
	.pbyte	0	;reserved
	.pbyte	0x83,0x00	;last character code
	.pbyte	0	;reserved
	.pbyte	20	;Bitmap Height
	.pbyte	16	;Baseline, from top of bitmap
	.pbyte	23	;Bitmap Width
	.pbyte	(  104 &0xff), (  104 >>8)&0xff,  5		; ' '
	.pbyte	(  111 &0xff), (  111 >>8)&0xff,  4		; '!'
	.pbyte	(  118 &0xff), (  118 >>8)&0xff,  4		; '"'
	.pbyte	(  125 &0xff), (  125 >>8)&0xff, 12		; '#'
	.pbyte	(  139 &0xff), (  139 >>8)&0xff, 11		; '$'
	.pbyte	(  153 &0xff), (  153 >>8)&0xff, 15		; '%'
	.pbyte	(  167 &0xff), (  167 >>8)&0xff, 12		; '&'
	.pbyte	(  181 &0xff), (  181 >>8)&0xff,  2		; '''
	.pbyte	(  188 &0xff), (  188 >>8)&0xff,  5		; '('
	.pbyte	(  195 &0xff), (  195 >>8)&0xff,  5		; ')'
	.pbyte	(  202 &0xff), (  202 >>8)&0xff,  8		; '*'
	.pbyte	(  209 &0xff), (  209 >>8)&0xff, 13		; '+'
	.pbyte	(  223 &0xff), (  223 >>8)&0xff,  5		; ','
	.pbyte	(  230 &0xff), (  230 >>8)&0xff,  6		; '-'
	.pbyte	(  237 &0xff), (  237 >>8)&0xff,  5		; '.'
	.pbyte	(  244 &0xff), (  244 >>8)&0xff,  4		; '/'
	.pbyte	(  251 &0xff), (  251 >>8)&0xff, 11		; '0'
	.pbyte	(  265 &0xff), (  265 >>8)&0xff, 11		; '1'
	.pbyte	(  279 &0xff), (  279 >>8)&0xff, 11		; '2'
	.pbyte	(  293 &0xff), (  293 >>8)&0xff, 11		; '3'
	.pbyte	(  307 &0xff), (  307 >>8)&0xff, 11		; '4'
	.pbyte	(  321 &0xff), (  321 >>8)&0xff, 11		; '5'
	.pbyte	(  335 &0xff), (  335 >>8)&0xff, 11		; '6'
	.pbyte	(  349 &0xff), (  349 >>8)&0xff, 11		; '7'
	.pbyte	(  363 &0xff), (  363 >>8)&0xff, 11		; '8'
	.pbyte	(  377 &0xff), (  377 >>8)&0xff, 11		; '9'
	.pbyte	(  391 &0xff), (  391 >>8)&0xff,  5		; ':'
	.pbyte	(  398 &0xff), (  398 >>8)&0xff,  5		; ';'
	.pbyte	(  405 &0xff), (  405 >>8)&0xff, 13		; '<'
	.pbyte	(  419 &0xff), (  419 >>8)&0xff, 13		; '='
	.pbyte	(  433 &0xff), (  433 >>8)&0xff, 13		; '>'
	.pbyte	(  447 &0xff), (  447 >>8)&0xff,  8		; '?'
	.pbyte	(  454 &0xff), (  454 >>8)&0xff, 16		; '@'
	.pbyte	(  468 &0xff), (  468 >>8)&0xff, 11		; 'A'
	.pbyte	(  482 &0xff), (  482 >>8)&0xff, 11		; 'B'
	.pbyte	(  496 &0xff), (  496 >>8)&0xff, 11		; 'C'
	.pbyte	(  510 &0xff), (  510 >>8)&0xff, 12		; 'D'
	.pbyte	(  524 &0xff), (  524 >>8)&0xff, 10		; 'E'
	.pbyte	(  538 &0xff), (  538 >>8)&0xff,  9		; 'F'
	.pbyte	(  552 &0xff), (  552 >>8)&0xff, 12		; 'G'
	.pbyte	(  566 &0xff), (  566 >>8)&0xff, 12		; 'H'
	.pbyte	(  580 &0xff), (  580 >>8)&0xff,  4		; 'I'
	.pbyte	(  587 &0xff), (  587 >>8)&0xff,  9		; 'J'
	.pbyte	(  601 &0xff), (  601 >>8)&0xff, 11		; 'K'
	.pbyte	(  615 &0xff), (  615 >>8)&0xff, 10		; 'L'
	.pbyte	(  629 &0xff), (  629 >>8)&0xff, 15		; 'M'
	.pbyte	(  643 &0xff), (  643 >>8)&0xff, 12		; 'N'
	.pbyte	(  657 &0xff), (  657 >>8)&0xff, 12		; 'O'
	.pbyte	(  671 &0xff), (  671 >>8)&0xff, 10		; 'P'
	.pbyte	(  685 &0xff), (  685 >>8)&0xff, 12		; 'Q'
	.pbyte	(  699 &0xff), (  699 >>8)&0xff, 11		; 'R'
	.pbyte	(  713 &0xff), (  713 >>8)&0xff, 11		; 'S'
	.pbyte	(  727 &0xff), (  727 >>8)&0xff,  8		; 'T'
	.pbyte	(  734 &0xff), (  734 >>8)&0xff, 12		; 'U'
	.pbyte	(  748 &0xff), (  748 >>8)&0xff, 10		; 'V'
	.pbyte	(  762 &0xff), (  762 >>8)&0xff, 16		; 'W'
	.pbyte	(  776 &0xff), (  776 >>8)&0xff, 10		; 'X'
	.pbyte	(  790 &0xff), (  790 >>8)&0xff, 10		; 'Y'
	.pbyte	(  804 &0xff), (  804 >>8)&0xff, 10		; 'Z'
	.pbyte	(  818 &0xff), (  818 >>8)&0xff,  5		; '['
	.pbyte	(  825 &0xff), (  825 >>8)&0xff,  4		; '\'
	.pbyte	(  832 &0xff), (  832 >>8)&0xff,  5		; ']'
	.pbyte	(  839 &0xff), (  839 >>8)&0xff, 16		; '^'
	.pbyte	(  853 &0xff), (  853 >>8)&0xff,  8		; '_'
	.pbyte	(  860 &0xff), (  860 >>8)&0xff,  8		; '`'
	.pbyte	(  867 &0xff), (  867 >>8)&0xff,  9		; 'a'
	.pbyte	(  881 &0xff), (  881 >>8)&0xff,  9		; 'b'
	.pbyte	(  895 &0xff), (  895 >>8)&0xff,  9		; 'c'
	.pbyte	(  909 &0xff), (  909 >>8)&0xff,  9		; 'd'
	.pbyte	(  923 &0xff), (  923 >>8)&0xff,  9		; 'e'
	.pbyte	(  937 &0xff), (  937 >>8)&0xff,  5		; 'f'
	.pbyte	(  944 &0xff), (  944 >>8)&0xff,  9		; 'g'
	.pbyte	(  958 &0xff), (  958 >>8)&0xff,  9		; 'h'
	.pbyte	(  972 &0xff), (  972 >>8)&0xff,  4		; 'i'
	.pbyte	(  979 &0xff), (  979 >>8)&0xff,  4		; 'j'
	.pbyte	(  986 &0xff), (  986 >>8)&0xff,  8		; 'k'
	.pbyte	(  993 &0xff), (  993 >>8)&0xff,  4		; 'l'
	.pbyte	( 1000 &0xff), ( 1000 >>8)&0xff, 14		; 'm'
	.pbyte	( 1014 &0xff), ( 1014 >>8)&0xff,  9		; 'n'
	.pbyte	( 1028 &0xff), ( 1028 >>8)&0xff,  9		; 'o'
	.pbyte	( 1042 &0xff), ( 1042 >>8)&0xff,  9		; 'p'
	.pbyte	( 1056 &0xff), ( 1056 >>8)&0xff,  9		; 'q'
	.pbyte	( 1070 &0xff), ( 1070 >>8)&0xff,  7		; 'r'
	.pbyte	( 1077 &0xff), ( 1077 >>8)&0xff,  9		; 's'
	.pbyte	( 1091 &0xff), ( 1091 >>8)&0xff,  8		; 't'
	.pbyte	( 1098 &0xff), ( 1098 >>8)&0xff,  9		; 'u'
	.pbyte	( 1112 &0xff), ( 1112 >>8)&0xff,  8		; 'v'
	.pbyte	( 1119 &0xff), ( 1119 >>8)&0xff, 12		; 'w'
	.pbyte	( 1133 &0xff), ( 1133 >>8)&0xff,  8		; 'x'
	.pbyte	( 1140 &0xff), ( 1140 >>8)&0xff,  8		; 'y'
	.pbyte	( 1147 &0xff), ( 1147 >>8)&0xff,  8		; 'z'
	.pbyte	( 1154 &0xff), ( 1154 >>8)&0xff,  8		; '{'
	.pbyte	( 1161 &0xff), ( 1161 >>8)&0xff,  8		; '|'
	.pbyte	( 1168 &0xff), ( 1168 >>8)&0xff,  8		; '}'
	.pbyte	( 1175 &0xff), ( 1175 >>8)&0xff, 13		; '~'
	.pbyte	( 1189 &0xff), ( 1189 >>8)&0xff,  5		; 0x7f
	.pbyte	( 1196 &0xff), ( 1196 >>8)&0xff, 11		; 0x80
	.pbyte	( 1210 &0xff), ( 1210 >>8)&0xff,  9		; 0x81
	.pbyte	( 1224 &0xff), ( 1224 >>8)&0xff, 13		; 0x82
	.pbyte	( 1238 &0xff), ( 1238 >>8)&0xff, 12		; 0x83

; Character 20 ' '
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 21 '!'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 22 '"'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x0A			;  | # #|
	.pbyte	0x0A			;  | # #|
	.pbyte	0x0A			;  | # #|
	.pbyte	0x0A			;  | # #|
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
; Character 23 '#'
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x40,0x02			;  |      #  #  |
	.pbyte	0x20,0x01			;  |     #  #   |
	.pbyte	0x20,0x01			;  |     #  #   |
	.pbyte	0xFC,0x07			;  |  ######### |
	.pbyte	0x90,0x00			;  |    #  #    |
	.pbyte	0x90,0x00			;  |    #  #    |
	.pbyte	0xFE,0x03			;  | #########  |
	.pbyte	0x48,0x00			;  |   #  #     |
	.pbyte	0x48,0x00			;  |   #  #     |
	.pbyte	0x48,0x00			;  |   #  #     |
	.pbyte	0x24,0x00			;  |  #  #      |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 24 '$'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x20,0x00			;  |     #     |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x22,0x02			;  | #   #   # |
	.pbyte	0x22,0x02			;  | #   #   # |
	.pbyte	0x22,0x00			;  | #   #     |
	.pbyte	0x26,0x00			;  | ##  #     |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x20,0x03			;  |     #  ## |
	.pbyte	0x20,0x02			;  |     #   # |
	.pbyte	0x22,0x02			;  | #   #   # |
	.pbyte	0x22,0x02			;  | #   #   # |
	.pbyte	0x26,0x03			;  | ##  #  ## |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x20,0x00			;  |     #     |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 25 '%'
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x1C,0x02			;  |  ###    #     |
	.pbyte	0x22,0x02			;  | #   #   #     |
	.pbyte	0x22,0x01			;  | #   #  #      |
	.pbyte	0x22,0x01			;  | #   #  #      |
	.pbyte	0x22,0x01			;  | #   #  #      |
	.pbyte	0xA2,0x3E			;  | #   # # ##### |
	.pbyte	0xBE,0x22			;  | ##### # #   # |
	.pbyte	0x40,0x22			;  |      #  #   # |
	.pbyte	0x40,0x22			;  |      #  #   # |
	.pbyte	0x40,0x22			;  |      #  #   # |
	.pbyte	0x20,0x22			;  |     #   #   # |
	.pbyte	0x20,0x1C			;  |     #    ###  |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 26 '&'
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0xF8,0x00			;  |   #####    |
	.pbyte	0x04,0x01			;  |  #     #   |
	.pbyte	0x04,0x01			;  |  #     #   |
	.pbyte	0x04,0x01			;  |  #     #   |
	.pbyte	0x0C,0x00			;  |  ##        |
	.pbyte	0x18,0x00			;  |   ##       |
	.pbyte	0x36,0x00			;  | ## ##      |
	.pbyte	0xC2,0x02			;  | #    ## #  |
	.pbyte	0x82,0x03			;  | #     ###  |
	.pbyte	0x02,0x03			;  | #      ##  |
	.pbyte	0x02,0x07			;  | #      ### |
	.pbyte	0xFC,0x09			;  |  #######  #|
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 27 '''
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x02			;  | #|
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
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00			;  |  |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 28 '('
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x0C			;  |  ## |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x0C			;  |  ## |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 29 ')'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x06			;  | ##  |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x06			;  | ##  |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 2a '*'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x24			;  |  #  #  |
	.pbyte	0x3C			;  |  ####  |
	.pbyte	0x18			;  |   ##   |
	.pbyte	0x66			;  | ##  ## |
	.pbyte	0x18			;  |   ##   |
	.pbyte	0x3C			;  |  ####  |
	.pbyte	0x24			;  |  #  #  |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 2b '+'
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x40,0x00			;  |      #      |
	.pbyte	0x40,0x00			;  |      #      |
	.pbyte	0x40,0x00			;  |      #      |
	.pbyte	0x40,0x00			;  |      #      |
	.pbyte	0xFC,0x07			;  |  #########  |
	.pbyte	0x40,0x00			;  |      #      |
	.pbyte	0x40,0x00			;  |      #      |
	.pbyte	0x40,0x00			;  |      #      |
	.pbyte	0x40,0x00			;  |      #      |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 2c ','
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 2d '-'
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
	.pbyte	0x1E			;  | #### |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00			;  |      |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 2e '.'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x02			;  | #   |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 2f '/'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x08			;  |   #|
	.pbyte	0x08			;  |   #|
	.pbyte	0x08			;  |   #|
	.pbyte	0x08			;  |   #|
	.pbyte	0x04			;  |  # |
	.pbyte	0x04			;  |  # |
	.pbyte	0x04			;  |  # |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x01			;  |#   |
	.pbyte	0x01			;  |#   |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 30 '0'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x06,0x03			;  | ##     ## |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x06,0x03			;  | ##     ## |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 31 '1'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x60,0x00			;  |     ##    |
	.pbyte	0x70,0x00			;  |    ###    |
	.pbyte	0x58,0x00			;  |   ## #    |
	.pbyte	0x44,0x00			;  |  #   #    |
	.pbyte	0x40,0x00			;  |      #    |
	.pbyte	0x40,0x00			;  |      #    |
	.pbyte	0x40,0x00			;  |      #    |
	.pbyte	0x40,0x00			;  |      #    |
	.pbyte	0x40,0x00			;  |      #    |
	.pbyte	0x40,0x00			;  |      #    |
	.pbyte	0x40,0x00			;  |      #    |
	.pbyte	0x40,0x00			;  |      #    |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 32 '2'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x00,0x02			;  |         # |
	.pbyte	0x00,0x03			;  |        ## |
	.pbyte	0xF0,0x01			;  |    #####  |
	.pbyte	0x3C,0x00			;  |  ####     |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0xFE,0x03			;  | ######### |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 33 '3'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x00,0x02			;  |         # |
	.pbyte	0x00,0x02			;  |         # |
	.pbyte	0xF0,0x01			;  |    #####  |
	.pbyte	0x00,0x02			;  |         # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 34 '4'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xC0,0x00			;  |      ##   |
	.pbyte	0xE0,0x00			;  |     ###   |
	.pbyte	0xA0,0x00			;  |     # #   |
	.pbyte	0x90,0x00			;  |    #  #   |
	.pbyte	0x98,0x00			;  |   ##  #   |
	.pbyte	0x8C,0x00			;  |  ##   #   |
	.pbyte	0x84,0x00			;  |  #    #   |
	.pbyte	0x86,0x00			;  | ##    #   |
	.pbyte	0xFE,0x03			;  | ######### |
	.pbyte	0x80,0x00			;  |       #   |
	.pbyte	0x80,0x00			;  |       #   |
	.pbyte	0x80,0x00			;  |       #   |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 35 '5'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFE,0x01			;  | ########  |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0xFE,0x00			;  | #######   |
	.pbyte	0x82,0x01			;  | #     ##  |
	.pbyte	0x00,0x01			;  |        #  |
	.pbyte	0x00,0x01			;  |        #  |
	.pbyte	0x00,0x01			;  |        #  |
	.pbyte	0x00,0x01			;  |        #  |
	.pbyte	0x02,0x01			;  | #      #  |
	.pbyte	0x02,0x01			;  | #      #  |
	.pbyte	0xFC,0x00			;  |  ######   |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 36 '6'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x06,0x03			;  | ##     ## |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0xFE,0x01			;  | ########  |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x06,0x02			;  | ##      # |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 37 '7'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFE,0x01			;  | ########  |
	.pbyte	0x80,0x01			;  |       ##  |
	.pbyte	0x80,0x00			;  |       #   |
	.pbyte	0xC0,0x00			;  |      ##   |
	.pbyte	0x40,0x00			;  |      #    |
	.pbyte	0x60,0x00			;  |     ##    |
	.pbyte	0x20,0x00			;  |     #     |
	.pbyte	0x30,0x00			;  |    ##     |
	.pbyte	0x10,0x00			;  |    #      |
	.pbyte	0x18,0x00			;  |   ##      |
	.pbyte	0x08,0x00			;  |   #       |
	.pbyte	0x0C,0x00			;  |  ##       |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 38 '8'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x02,0x03			;  | #      ## |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x06,0x03			;  | ##     ## |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 39 '9'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x02,0x03			;  | #      ## |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0xFC,0x03			;  |  ######## |
	.pbyte	0x00,0x02			;  |         # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x06,0x03			;  | ##     ## |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 3a ':'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 3b ';'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 3c '<'
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x04			;  |          #  |
	.pbyte	0x80,0x03			;  |       ###   |
	.pbyte	0x60,0x00			;  |     ##      |
	.pbyte	0x1C,0x00			;  |  ###        |
	.pbyte	0x0C,0x00			;  |  ##         |
	.pbyte	0x70,0x00			;  |    ###      |
	.pbyte	0x80,0x01			;  |       ##    |
	.pbyte	0x00,0x06			;  |         ##  |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 3d '='
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0xFC,0x07			;  |  #########  |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0xFC,0x07			;  |  #########  |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 3e '>'
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x04,0x00			;  |  #          |
	.pbyte	0x38,0x00			;  |   ###       |
	.pbyte	0xC0,0x00			;  |      ##     |
	.pbyte	0x00,0x07			;  |        ###  |
	.pbyte	0x00,0x06			;  |         ##  |
	.pbyte	0xC0,0x01			;  |      ###    |
	.pbyte	0x30,0x00			;  |    ##       |
	.pbyte	0x0C,0x00			;  |  ##         |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 3f '?'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x7C			;  |  ##### |
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x82			;  | #     #|
	.pbyte	0x80			;  |       #|
	.pbyte	0xC0			;  |      ##|
	.pbyte	0x70			;  |    ### |
	.pbyte	0x18			;  |   ##   |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 40 '@'
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0xC0,0x07			;  |      #####     |
	.pbyte	0x30,0x18			;  |    ##     ##   |
	.pbyte	0x08,0x20			;  |   #         #  |
	.pbyte	0x04,0x40			;  |  #           # |
	.pbyte	0x84,0x47			;  |  #    ####   # |
	.pbyte	0x42,0x44			;  | #    #   #   # |
	.pbyte	0x22,0x44			;  | #   #    #   # |
	.pbyte	0x22,0x44			;  | #   #    #   # |
	.pbyte	0x22,0x22			;  | #   #   #   #  |
	.pbyte	0x22,0x32			;  | #   #   #  ##  |
	.pbyte	0xC4,0x1D			;  |  #   ### ###   |
	.pbyte	0x0C,0x10			;  |  ##        #   |
	.pbyte	0x18,0x18			;  |   ##      ##   |
	.pbyte	0xE0,0x07			;  |     ######     |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 41 'A'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x70,0x00			;  |    ###    |
	.pbyte	0x50,0x00			;  |    # #    |
	.pbyte	0x58,0x00			;  |   ## #    |
	.pbyte	0xD8,0x00			;  |   ## ##   |
	.pbyte	0x88,0x00			;  |   #   #   |
	.pbyte	0x8C,0x01			;  |  ##   ##  |
	.pbyte	0x04,0x01			;  |  #     #  |
	.pbyte	0x04,0x01			;  |  #     #  |
	.pbyte	0xFE,0x03			;  | ######### |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x03,0x06			;  |##       ##|
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 42 'B'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFE,0x01			;  | ########  |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0xFE,0x01			;  | ########  |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0xFE,0x01			;  | ########  |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 43 'C'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x06,0x03			;  | ##     ## |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x06,0x03			;  | ##     ## |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 44 'D'
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0xFE,0x03			;  | #########  |
	.pbyte	0x02,0x06			;  | #       ## |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x06			;  | #       ## |
	.pbyte	0xFE,0x03			;  | #########  |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 45 'E'
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0xFE,0x01			;  | ######## |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0xFE,0x01			;  | ######## |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0xFE,0x01			;  | ######## |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 46 'F'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0xFE,0x00			;  | ####### |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0xFE,0x00			;  | ####### |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 47 'G'
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0xF8,0x01			;  |   ######   |
	.pbyte	0x04,0x06			;  |  #      ## |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x00			;  | #          |
	.pbyte	0x02,0x00			;  | #          |
	.pbyte	0xC2,0x07			;  | #    ##### |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x06,0x06			;  | ##      ## |
	.pbyte	0xFC,0x03			;  |  ########  |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 48 'H'
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0xFE,0x03			;  | #########  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 49 'I'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 4a 'J'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x81,0x00			;  |#      # |
	.pbyte	0x81,0x00			;  |#      # |
	.pbyte	0x81,0x00			;  |#      # |
	.pbyte	0x7E,0x00			;  | ######  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 4b 'K'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x82,0x01			;  | #     ##  |
	.pbyte	0xC2,0x00			;  | #    ##   |
	.pbyte	0x62,0x00			;  | #   ##    |
	.pbyte	0x32,0x00			;  | #  ##     |
	.pbyte	0x12,0x00			;  | #  #      |
	.pbyte	0x0E,0x00			;  | ###       |
	.pbyte	0x1A,0x00			;  | # ##      |
	.pbyte	0x32,0x00			;  | #  ##     |
	.pbyte	0x62,0x00			;  | #   ##    |
	.pbyte	0xC2,0x00			;  | #    ##   |
	.pbyte	0x82,0x01			;  | #     ##  |
	.pbyte	0x02,0x03			;  | #      ## |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 4c 'L'
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0xFE,0x01			;  | ######## |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 4d 'M'
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x06,0x18			;  | ##        ##  |
	.pbyte	0x06,0x18			;  | ##        ##  |
	.pbyte	0x0A,0x14			;  | # #      # #  |
	.pbyte	0x0A,0x14			;  | # #      # #  |
	.pbyte	0x1A,0x16			;  | # ##    ## #  |
	.pbyte	0x12,0x12			;  | #  #    #  #  |
	.pbyte	0x12,0x12			;  | #  #    #  #  |
	.pbyte	0x32,0x13			;  | #  ##  ##  #  |
	.pbyte	0x22,0x11			;  | #   #  #   #  |
	.pbyte	0xE2,0x11			;  | #   ####   #  |
	.pbyte	0xC2,0x10			;  | #    ##    #  |
	.pbyte	0xC2,0x10			;  | #    ##    #  |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00			;  |               |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 4e 'N'
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x06,0x04			;  | ##       # |
	.pbyte	0x0E,0x04			;  | ###      # |
	.pbyte	0x1A,0x04			;  | # ##     # |
	.pbyte	0x1A,0x04			;  | # ##     # |
	.pbyte	0x32,0x04			;  | #  ##    # |
	.pbyte	0x62,0x04			;  | #   ##   # |
	.pbyte	0x62,0x04			;  | #   ##   # |
	.pbyte	0xC2,0x04			;  | #    ##  # |
	.pbyte	0x82,0x05			;  | #     ## # |
	.pbyte	0x82,0x05			;  | #     ## # |
	.pbyte	0x02,0x07			;  | #      ### |
	.pbyte	0x02,0x06			;  | #       ## |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 4f 'O'
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0xFC,0x03			;  |  ########  |
	.pbyte	0x06,0x06			;  | ##      ## |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x06,0x06			;  | ##      ## |
	.pbyte	0xFC,0x03			;  |  ########  |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 50 'P'
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0xFE,0x00			;  | #######  |
	.pbyte	0x02,0x01			;  | #      # |
	.pbyte	0x02,0x01			;  | #      # |
	.pbyte	0x02,0x01			;  | #      # |
	.pbyte	0x02,0x01			;  | #      # |
	.pbyte	0x02,0x01			;  | #      # |
	.pbyte	0xFE,0x00			;  | #######  |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x02,0x00			;  | #        |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 51 'Q'
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0xFC,0x03			;  |  ########  |
	.pbyte	0x06,0x06			;  | ##      ## |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0xC2,0x04			;  | #    ##  # |
	.pbyte	0x02,0x05			;  | #      # # |
	.pbyte	0x06,0x06			;  | ##      ## |
	.pbyte	0xFC,0x07			;  |  ######### |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 52 'R'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFE,0x01			;  | ########  |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0xFE,0x01			;  | ########  |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 53 'S'
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0x02,0x00			;  | #         |
	.pbyte	0xFC,0x00			;  |  ######   |
	.pbyte	0xE0,0x03			;  |     ##### |
	.pbyte	0x00,0x02			;  |         # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0xFC,0x01			;  |  #######  |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 54 'T'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0xFF			;  |########|
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 55 'U'
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x02,0x02			;  | #       #  |
	.pbyte	0x06,0x03			;  | ##     ##  |
	.pbyte	0xFC,0x01			;  |  #######   |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 56 'V'
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x03,0x03			;  |##      ##|
	.pbyte	0x02,0x01			;  | #      # |
	.pbyte	0x02,0x01			;  | #      # |
	.pbyte	0x86,0x01			;  | ##    ## |
	.pbyte	0x84,0x00			;  |  #    #  |
	.pbyte	0x84,0x00			;  |  #    #  |
	.pbyte	0xCC,0x00			;  |  ##  ##  |
	.pbyte	0x48,0x00			;  |   #  #   |
	.pbyte	0x48,0x00			;  |   #  #   |
	.pbyte	0x78,0x00			;  |   ####   |
	.pbyte	0x30,0x00			;  |    ##    |
	.pbyte	0x30,0x00			;  |    ##    |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 57 'W'
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0xC1,0x41			;  |#     ###     # |
	.pbyte	0x43,0x61			;  |##    # #    ## |
	.pbyte	0x42,0x21			;  | #    # #    #  |
	.pbyte	0x42,0x21			;  | #    # #    #  |
	.pbyte	0x62,0x23			;  | #   ## ##   #  |
	.pbyte	0x26,0x32			;  | ##  #   #  ##  |
	.pbyte	0x24,0x12			;  |  #  #   #  #   |
	.pbyte	0x24,0x12			;  |  #  #   #  #   |
	.pbyte	0x34,0x16			;  |  # ##   ## #   |
	.pbyte	0x1C,0x1C			;  |  ###     ###   |
	.pbyte	0x18,0x0C			;  |   ##     ##    |
	.pbyte	0x18,0x0C			;  |   ##     ##    |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 58 'X'
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x03,0x03			;  |##      ##|
	.pbyte	0x86,0x01			;  | ##    ## |
	.pbyte	0xC4,0x00			;  |  #   ##  |
	.pbyte	0x48,0x00			;  |   #  #   |
	.pbyte	0x38,0x00			;  |   ###    |
	.pbyte	0x30,0x00			;  |    ##    |
	.pbyte	0x30,0x00			;  |    ##    |
	.pbyte	0x48,0x00			;  |   #  #   |
	.pbyte	0xCC,0x00			;  |  ##  ##  |
	.pbyte	0x84,0x00			;  |  #    #  |
	.pbyte	0x02,0x01			;  | #      # |
	.pbyte	0x03,0x03			;  |##      ##|
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 59 'Y'
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x01,0x03			;  |#       ##|
	.pbyte	0x83,0x01			;  |##     ## |
	.pbyte	0x82,0x00			;  | #     #  |
	.pbyte	0x44,0x00			;  |  #   #   |
	.pbyte	0x6C,0x00			;  |  ## ##   |
	.pbyte	0x28,0x00			;  |   # #    |
	.pbyte	0x10,0x00			;  |    #     |
	.pbyte	0x10,0x00			;  |    #     |
	.pbyte	0x10,0x00			;  |    #     |
	.pbyte	0x10,0x00			;  |    #     |
	.pbyte	0x10,0x00			;  |    #     |
	.pbyte	0x10,0x00			;  |    #     |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 5a 'Z'
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0xFE,0x03			;  | #########|
	.pbyte	0x00,0x03			;  |        ##|
	.pbyte	0x80,0x01			;  |       ## |
	.pbyte	0x80,0x00			;  |       #  |
	.pbyte	0xC0,0x00			;  |      ##  |
	.pbyte	0x60,0x00			;  |     ##   |
	.pbyte	0x30,0x00			;  |    ##    |
	.pbyte	0x18,0x00			;  |   ##     |
	.pbyte	0x08,0x00			;  |   #      |
	.pbyte	0x0C,0x00			;  |  ##      |
	.pbyte	0x06,0x00			;  | ##       |
	.pbyte	0xFE,0x03			;  | #########|
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00			;  |          |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 5b '['
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x0E			;  | ### |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x02			;  | #   |
	.pbyte	0x0E			;  | ### |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 5c '\'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x01			;  |#   |
	.pbyte	0x01			;  |#   |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x04			;  |  # |
	.pbyte	0x04			;  |  # |
	.pbyte	0x04			;  |  # |
	.pbyte	0x08			;  |   #|
	.pbyte	0x08			;  |   #|
	.pbyte	0x08			;  |   #|
	.pbyte	0x08			;  |   #|
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 5d ']'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x0E			;  | ### |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x08			;  |   # |
	.pbyte	0x0E			;  | ### |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 5e '^'
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0xC0,0x01			;  |      ###       |
	.pbyte	0x60,0x03			;  |     ## ##      |
	.pbyte	0x30,0x06			;  |    ##   ##     |
	.pbyte	0x18,0x0C			;  |   ##     ##    |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00			;  |                |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 5f '_'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0xFF			;  |########|
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 60 '`'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x0C			;  |  ##    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 61 'a'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x7C,0x00			;  |  #####  |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0xFC,0x00			;  |  ###### |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0xFC,0x00			;  |  ###### |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 62 'b'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x7A,0x00			;  | # ####  |
	.pbyte	0x86,0x00			;  | ##    # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x86,0x00			;  | ##    # |
	.pbyte	0x7A,0x00			;  | # ####  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 63 'c'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x7C,0x00			;  |  #####  |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x7C,0x00			;  |  #####  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 64 'd'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0xBC,0x00			;  |  #### # |
	.pbyte	0xC2,0x00			;  | #    ## |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0xC2,0x00			;  | #    ## |
	.pbyte	0xBC,0x00			;  |  #### # |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 65 'e'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x7C,0x00			;  |  #####  |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0xFE,0x00			;  | ####### |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0xC2,0x00			;  | #    ## |
	.pbyte	0x7C,0x00			;  |  #####  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 66 'f'
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x18			;  |   ##|
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x1E			;  | ####|
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x04			;  |  #  |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 67 'g'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0xBC,0x00			;  |  #### # |
	.pbyte	0xC2,0x00			;  | #    ## |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0xC2,0x00			;  | #    ## |
	.pbyte	0xBC,0x00			;  |  #### # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x7C,0x00			;  |  #####  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 68 'h'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x7A,0x00			;  | # ####  |
	.pbyte	0x86,0x00			;  | ##    # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 69 'i'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 6a 'j'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x03			;  |##  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 6b 'k'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x02			;  | #      |
	.pbyte	0x02			;  | #      |
	.pbyte	0x02			;  | #      |
	.pbyte	0x02			;  | #      |
	.pbyte	0x22			;  | #   #  |
	.pbyte	0x12			;  | #  #   |
	.pbyte	0x0A			;  | # #    |
	.pbyte	0x06			;  | ##     |
	.pbyte	0x0A			;  | # #    |
	.pbyte	0x1A			;  | # ##   |
	.pbyte	0x32			;  | #  ##  |
	.pbyte	0x62			;  | #   ## |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 6c 'l'
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x02			;  | #  |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00			;  |    |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 6d 'm'
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0xBE,0x07			;  | ##### ####   |
	.pbyte	0xC6,0x08			;  | ##   ##   #  |
	.pbyte	0x42,0x08			;  | #    #    #  |
	.pbyte	0x42,0x08			;  | #    #    #  |
	.pbyte	0x42,0x08			;  | #    #    #  |
	.pbyte	0x42,0x08			;  | #    #    #  |
	.pbyte	0x42,0x08			;  | #    #    #  |
	.pbyte	0x42,0x08			;  | #    #    #  |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00			;  |              |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 6e 'n'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x7A,0x00			;  | # ####  |
	.pbyte	0x86,0x00			;  | ##    # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 6f 'o'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x7C,0x00			;  |  #####  |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x7C,0x00			;  |  #####  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 70 'p'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x7A,0x00			;  | # ####  |
	.pbyte	0x86,0x00			;  | ##    # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x86,0x00			;  | ##    # |
	.pbyte	0x7A,0x00			;  | # ####  |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 71 'q'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0xBC,0x00			;  |  #### # |
	.pbyte	0xC2,0x00			;  | #    ## |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0xC2,0x00			;  | #    ## |
	.pbyte	0xBC,0x00			;  |  #### # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 72 'r'
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x3E			;  | ##### |
	.pbyte	0x46			;  | ##   #|
	.pbyte	0x42			;  | #    #|
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x02			;  | #     |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00			;  |       |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 73 's'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x7C,0x00			;  |  #####  |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x02,0x00			;  | #       |
	.pbyte	0x7E,0x00			;  | ######  |
	.pbyte	0x80,0x00			;  |       # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x7C,0x00			;  |  #####  |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 74 't'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x02			;  | #      |
	.pbyte	0x02			;  | #      |
	.pbyte	0x3F			;  |######  |
	.pbyte	0x02			;  | #      |
	.pbyte	0x02			;  | #      |
	.pbyte	0x02			;  | #      |
	.pbyte	0x02			;  | #      |
	.pbyte	0x22			;  | #   #  |
	.pbyte	0x22			;  | #   #  |
	.pbyte	0x3C			;  |  ####  |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 75 'u'
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0xC2,0x00			;  | #    ## |
	.pbyte	0xBC,0x00			;  |  #### # |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 76 'v'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x41			;  |#     # |
	.pbyte	0x22			;  | #   #  |
	.pbyte	0x22			;  | #   #  |
	.pbyte	0x22			;  | #   #  |
	.pbyte	0x14			;  |  # #   |
	.pbyte	0x14			;  |  # #   |
	.pbyte	0x14			;  |  # #   |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 77 'w'
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x61,0x08			;  |#    ##    #|
	.pbyte	0x63,0x0C			;  |##   ##   ##|
	.pbyte	0xF2,0x04			;  | #  ####  # |
	.pbyte	0x92,0x04			;  | #  #  #  # |
	.pbyte	0x92,0x04			;  | #  #  #  # |
	.pbyte	0x94,0x02			;  |  # #  # #  |
	.pbyte	0x0C,0x03			;  |  ##    ##  |
	.pbyte	0x0C,0x03			;  |  ##    ##  |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 78 'x'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0xC3			;  |##    ##|
	.pbyte	0x24			;  |  #  #  |
	.pbyte	0x3C			;  |  ####  |
	.pbyte	0x18			;  |   ##   |
	.pbyte	0x18			;  |   ##   |
	.pbyte	0x24			;  |  #  #  |
	.pbyte	0x66			;  | ##  ## |
	.pbyte	0xC3			;  |##    ##|
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 79 'y'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0xC3			;  |##    ##|
	.pbyte	0x42			;  | #    # |
	.pbyte	0x42			;  | #    # |
	.pbyte	0x66			;  | ##  ## |
	.pbyte	0x24			;  |  #  #  |
	.pbyte	0x24			;  |  #  #  |
	.pbyte	0x18			;  |   ##   |
	.pbyte	0x18			;  |   ##   |
	.pbyte	0x18			;  |   ##   |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x06			;  | ##     |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 7a 'z'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0xFE			;  | #######|
	.pbyte	0xC0			;  |      ##|
	.pbyte	0x60			;  |     ## |
	.pbyte	0x30			;  |    ##  |
	.pbyte	0x18			;  |   ##   |
	.pbyte	0x0C			;  |  ##    |
	.pbyte	0x06			;  | ##     |
	.pbyte	0xFE			;  | #######|
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 7b '{'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x60			;  |     ## |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x0C			;  |  ##    |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x60			;  |     ## |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 7c '|'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x10			;  |    #   |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 7d '}'
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x00			;  |        |
	.pbyte	0x06			;  | ##     |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x30			;  |    ##  |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x08			;  |   #    |
	.pbyte	0x06			;  | ##     |
	.pbyte	0x00			;  |        |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 7e '~'
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x3C,0x02			;  |  ####   #   |
	.pbyte	0xE2,0x01			;  | #   ####    |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 7f 0x7f
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x06			;  | ##  |
	.pbyte	0x09			;  |#  # |
	.pbyte	0x09			;  |#  # |
	.pbyte	0x06			;  | ##  |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00			;  |     |
	.pbyte	0x00		;pad to multiple of 3 bytes
; Character 80 0x80
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x20,0x00			;  |     #     |
	.pbyte	0x50,0x00			;  |    # #    |
	.pbyte	0x50,0x00			;  |    # #    |
	.pbyte	0xD8,0x00			;  |   ## ##   |
	.pbyte	0x88,0x00			;  |   #   #   |
	.pbyte	0x88,0x00			;  |   #   #   |
	.pbyte	0x84,0x01			;  |  #    ##  |
	.pbyte	0x04,0x01			;  |  #     #  |
	.pbyte	0x06,0x03			;  | ##     ## |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0x02,0x02			;  | #       # |
	.pbyte	0xFF,0x07			;  |###########|
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00			;  |           |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 81 0x81
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x00,0x00			;  |         |
	.pbyte	0x86,0x00			;  | ##    # |
	.pbyte	0x82,0x00			;  | #     # |
	.pbyte	0x42,0x00			;  | #    #  |
	.pbyte	0x42,0x00			;  | #    #  |
	.pbyte	0x42,0x00			;  | #    #  |
	.pbyte	0x63,0x00			;  |##   ##  |
	.pbyte	0x63,0x00			;  |##   ##  |
	.pbyte	0xDD,0x00			;  |# ### ## |
	.pbyte	0x01,0x00			;  |#        |
	.pbyte	0x01,0x00			;  |#        |
	.pbyte	0x01,0x00			;  |#        |
	.pbyte	0x01,0x00			;  |#        |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 82 0x82
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x38,0x07			;  |   ###  ###  |
	.pbyte	0xCC,0x08			;  |  ##  ##   # |
	.pbyte	0x84,0x08			;  |  #    #   # |
	.pbyte	0x44,0x08			;  |  #   #    # |
	.pbyte	0xCC,0x0C			;  |  ##  ##  ## |
	.pbyte	0x38,0x07			;  |   ###  ###  |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00			;  |             |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
; Character 83 0x83
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0xF0,0x00			;  |    ####    |
	.pbyte	0x08,0x01			;  |   #    #   |
	.pbyte	0x04,0x02			;  |  #      #  |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x02,0x04			;  | #        # |
	.pbyte	0x06,0x06			;  | ##      ## |
	.pbyte	0x04,0x02			;  |  #      #  |
	.pbyte	0x08,0x01			;  |   #    #   |
	.pbyte	0x9E,0x07			;  | ####  #### |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00			;  |            |
	.pbyte	0x00,0x00		;pad to multiple of 3 bytes
