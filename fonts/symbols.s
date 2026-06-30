; symbols.s — Special symbol font glyphs for TFT display.
;
; Character 0x84 = left arrow  (←)
; Character 0x85 = right arrow (→)
;
; Font sizes:  8pt (h=9, w=11), 12pt (h=13, w=15), 16pt (h=17, w=22),
;              20pt (h=21, w=26), 32pt (h=33, w=40)
;
; Glyph bit order: LSB = leftmost pixel, 1 = foreground, 0 = background.

        .section    .font,code

;; =====================================================================
;;  SYMBOLS  8pt  —  height 9,  width 11,  2 bytes/row  (COMMENTED OUT)
;; =====================================================================
;        .global _Symbols_8
;_Symbols_8:
;        .pbyte  8               ; Em Height
;        .pbyte  0               ; Top Margin
;        .pbyte  0               ; Bottom Margin
;        .pbyte  0x84,0x00       ; first character code
;        .pbyte  0               ; reserved
;        .pbyte  0x85,0x00       ; last character code
;        .pbyte  0               ; reserved
;        .pbyte  9               ; Bitmap Height
;        .pbyte  8               ; Baseline
;        .pbyte  11              ; Max Width
;        ; character map
;        .pbyte  (   6 &0xFF), (   6 >>8)&0xFF, 11      ; 0x84 at word 6, width 11
;        .pbyte  (  12 &0xFF), (  12 >>8)&0xFF, 11      ; 0x85 at word 12, width 11
;
;; --- glyph 0x84: left arrow, 9 rows x 2 bytes = 18 bytes = 6 words ---
;        .pbyte  0x10,0x00       ; row 0
;        .pbyte  0x18,0x00       ; row 1
;        .pbyte  0x1C,0x00       ; row 2
;        .pbyte  0xFE,0x07       ; row 3
;        .pbyte  0xFF,0x07       ; row 4
;        .pbyte  0xFE,0x07       ; row 5
;        .pbyte  0x1C,0x00       ; row 6
;        .pbyte  0x18,0x00       ; row 7
;        .pbyte  0x10,0x00       ; row 8
;
;; --- glyph 0x85: right arrow, 9 rows x 2 bytes = 18 bytes = 6 words ---
;        .pbyte  0x40,0x00       ; row 0
;        .pbyte  0xC0,0x00       ; row 1
;        .pbyte  0xC0,0x01       ; row 2
;        .pbyte  0xFF,0x03       ; row 3
;        .pbyte  0xFF,0x07       ; row 4
;        .pbyte  0xFF,0x03       ; row 5
;        .pbyte  0xC0,0x01       ; row 6
;        .pbyte  0xC0,0x00       ; row 7
;        .pbyte  0x40,0x00       ; row 8

;; =====================================================================
;;  SYMBOLS 12pt  —  height 13,  width 15,  2 bytes/row  (COMMENTED OUT)
;; =====================================================================
;        .global _Symbols_12
;_Symbols_12:
;        .pbyte  12              ; Em Height
;        .pbyte  0               ; Top Margin
;        .pbyte  0               ; Bottom Margin
;        .pbyte  0x84,0x00       ; first character code
;        .pbyte  0               ; reserved
;        .pbyte  0x85,0x00       ; last character code
;        .pbyte  0               ; reserved
;        .pbyte  13              ; Bitmap Height
;        .pbyte  12              ; Baseline
;        .pbyte  15              ; Max Width
;        ; character map
;        .pbyte  (   6 &0xFF), (   6 >>8)&0xFF, 15      ; 0x84 at word 6, width 15
;        .pbyte  (  15 &0xFF), (  15 >>8)&0xFF, 15      ; 0x85 at word 15, width 15
;
;; --- glyph 0x84: left arrow, 13 rows x 2 bytes = 26 bytes + 1 pad = 9 words ---
;        .pbyte  0x40,0x00       ; row 0
;        .pbyte  0x60,0x00       ; row 1
;        .pbyte  0x70,0x00       ; row 2
;        .pbyte  0x78,0x00       ; row 3
;        .pbyte  0x7C,0x00       ; row 4
;        .pbyte  0xFE,0x7F       ; row 5
;        .pbyte  0xFF,0x7F       ; row 6
;        .pbyte  0xFE,0x7F       ; row 7
;        .pbyte  0x7C,0x00       ; row 8
;        .pbyte  0x78,0x00       ; row 9
;        .pbyte  0x70,0x00       ; row 10
;        .pbyte  0x60,0x00       ; row 11
;        .pbyte  0x40,0x00       ; row 12
;        .pbyte  0x00            ; pad to word boundary
;
;; --- glyph 0x85: right arrow, 13 rows x 2 bytes = 26 bytes + 1 pad = 9 words ---
;        .pbyte  0x00,0x01       ; row 0
;        .pbyte  0x00,0x03       ; row 1
;        .pbyte  0x00,0x07       ; row 2
;        .pbyte  0x00,0x0F       ; row 3
;        .pbyte  0x00,0x1F       ; row 4
;        .pbyte  0xFF,0x3F       ; row 5
;        .pbyte  0xFF,0x7F       ; row 6
;        .pbyte  0xFF,0x3F       ; row 7
;        .pbyte  0x00,0x1F       ; row 8
;        .pbyte  0x00,0x0F       ; row 9
;        .pbyte  0x00,0x07       ; row 10
;        .pbyte  0x00,0x03       ; row 11
;        .pbyte  0x00,0x01       ; row 12
;        .pbyte  0x00            ; pad to word boundary

; =====================================================================
;  SYMBOLS 16pt  —  height 17,  width 22,  3 bytes/row
; =====================================================================
        .global _Symbols_16
_Symbols_16:
        .pbyte  16              ; Em Height
        .pbyte  0               ; Top Margin
        .pbyte  0               ; Bottom Margin
        .pbyte  0x84,0x00       ; first character code
        .pbyte  0               ; reserved
        .pbyte  0x85,0x00       ; last character code
        .pbyte  0               ; reserved
        .pbyte  17              ; Bitmap Height
        .pbyte  16              ; Baseline
        .pbyte  22              ; Max Width
        ; character map
        .pbyte  (   6 &0xFF), (   6 >>8)&0xFF, 22      ; 0x84 at word 6, width 22
        .pbyte  (  23 &0xFF), (  23 >>8)&0xFF, 22      ; 0x85 at word 23, width 22

; --- glyph 0x84: left arrow, 17 rows x 3 bytes = 51 bytes = 17 words ---
        .pbyte  0x00,0x01,0x00          ; row 0
        .pbyte  0x80,0x01,0x00          ; row 1
        .pbyte  0xC0,0x01,0x00          ; row 2
        .pbyte  0xE0,0x01,0x00          ; row 3
        .pbyte  0xF0,0x01,0x00          ; row 4
        .pbyte  0xF8,0x01,0x00          ; row 5
        .pbyte  0xFC,0xFF,0x3F          ; row 6
        .pbyte  0xFE,0xFF,0x3F          ; row 7
        .pbyte  0xFF,0xFF,0x3F          ; row 8
        .pbyte  0xFE,0xFF,0x3F          ; row 9
        .pbyte  0xFC,0xFF,0x3F          ; row 10
        .pbyte  0xF8,0x01,0x00          ; row 11
        .pbyte  0xF0,0x01,0x00          ; row 12
        .pbyte  0xE0,0x01,0x00          ; row 13
        .pbyte  0xC0,0x01,0x00          ; row 14
        .pbyte  0x80,0x01,0x00          ; row 15
        .pbyte  0x00,0x01,0x00          ; row 16

; --- glyph 0x85: right arrow, 17 rows x 3 bytes = 51 bytes = 17 words ---
        .pbyte  0x00,0x20,0x00          ; row 0
        .pbyte  0x00,0x60,0x00          ; row 1
        .pbyte  0x00,0xE0,0x00          ; row 2
        .pbyte  0x00,0xE0,0x01          ; row 3
        .pbyte  0x00,0xE0,0x03          ; row 4
        .pbyte  0x00,0xE0,0x07          ; row 5
        .pbyte  0xFF,0xFF,0x0F          ; row 6
        .pbyte  0xFF,0xFF,0x1F          ; row 7
        .pbyte  0xFF,0xFF,0x3F          ; row 8
        .pbyte  0xFF,0xFF,0x1F          ; row 9
        .pbyte  0xFF,0xFF,0x0F          ; row 10
        .pbyte  0x00,0xE0,0x07          ; row 11
        .pbyte  0x00,0xE0,0x03          ; row 12
        .pbyte  0x00,0xE0,0x01          ; row 13
        .pbyte  0x00,0xE0,0x00          ; row 14
        .pbyte  0x00,0x60,0x00          ; row 15
        .pbyte  0x00,0x20,0x00          ; row 16

;; =====================================================================
;;  SYMBOLS 20pt  —  height 21,  width 26,  4 bytes/row  (COMMENTED OUT)
;; =====================================================================
;        .global _Symbols_20
;_Symbols_20:
;        .pbyte  20              ; Em Height
;        .pbyte  0               ; Top Margin
;        .pbyte  0               ; Bottom Margin
;        .pbyte  0x84,0x00       ; first character code
;        .pbyte  0               ; reserved
;        .pbyte  0x85,0x00       ; last character code
;        .pbyte  0               ; reserved
;        .pbyte  21              ; Bitmap Height
;        .pbyte  20              ; Baseline
;        .pbyte  26              ; Max Width
;        ; character map
;        .pbyte  (   6 &0xFF), (   6 >>8)&0xFF, 26      ; 0x84 at word 6, width 26
;        .pbyte  (  34 &0xFF), (  34 >>8)&0xFF, 26      ; 0x85 at word 34, width 26
;
;; --- glyph 0x84: left arrow, 21 rows x 4 bytes = 84 bytes = 28 words ---
;        .pbyte  0x00,0x04,0x00,0x00     ; row 0
;        .pbyte  0x00,0x06,0x00,0x00     ; row 1
;        .pbyte  0x00,0x07,0x00,0x00     ; row 2
;        .pbyte  0x80,0x07,0x00,0x00     ; row 3
;        .pbyte  0xC0,0x07,0x00,0x00     ; row 4
;        .pbyte  0xE0,0x07,0x00,0x00     ; row 5
;        .pbyte  0xF0,0x07,0x00,0x00     ; row 6
;        .pbyte  0xF8,0x07,0x00,0x00     ; row 7
;        .pbyte  0xFC,0xFF,0xFF,0x03     ; row 8
;        .pbyte  0xFE,0xFF,0xFF,0x03     ; row 9
;        .pbyte  0xFF,0xFF,0xFF,0x03     ; row 10
;        .pbyte  0xFE,0xFF,0xFF,0x03     ; row 11
;        .pbyte  0xFC,0xFF,0xFF,0x03     ; row 12
;        .pbyte  0xF8,0x07,0x00,0x00     ; row 13
;        .pbyte  0xF0,0x07,0x00,0x00     ; row 14
;        .pbyte  0xE0,0x07,0x00,0x00     ; row 15
;        .pbyte  0xC0,0x07,0x00,0x00     ; row 16
;        .pbyte  0x80,0x07,0x00,0x00     ; row 17
;        .pbyte  0x00,0x07,0x00,0x00     ; row 18
;        .pbyte  0x00,0x06,0x00,0x00     ; row 19
;        .pbyte  0x00,0x04,0x00,0x00     ; row 20
;
;; --- glyph 0x85: right arrow, 21 rows x 4 bytes = 84 bytes = 28 words ---
;        .pbyte  0x00,0x80,0x00,0x00     ; row 0
;        .pbyte  0x00,0x80,0x01,0x00     ; row 1
;        .pbyte  0x00,0x80,0x03,0x00     ; row 2
;        .pbyte  0x00,0x80,0x07,0x00     ; row 3
;        .pbyte  0x00,0x80,0x0F,0x00     ; row 4
;        .pbyte  0x00,0x80,0x1F,0x00     ; row 5
;        .pbyte  0x00,0x80,0x3F,0x00     ; row 6
;        .pbyte  0x00,0x80,0x7F,0x00     ; row 7
;        .pbyte  0xFF,0xFF,0xFF,0x00     ; row 8
;        .pbyte  0xFF,0xFF,0xFF,0x01     ; row 9
;        .pbyte  0xFF,0xFF,0xFF,0x03     ; row 10
;        .pbyte  0xFF,0xFF,0xFF,0x01     ; row 11
;        .pbyte  0xFF,0xFF,0xFF,0x00     ; row 12
;        .pbyte  0x00,0x80,0x7F,0x00     ; row 13
;        .pbyte  0x00,0x80,0x3F,0x00     ; row 14
;        .pbyte  0x00,0x80,0x1F,0x00     ; row 15
;        .pbyte  0x00,0x80,0x0F,0x00     ; row 16
;        .pbyte  0x00,0x80,0x07,0x00     ; row 17
;        .pbyte  0x00,0x80,0x03,0x00     ; row 18
;        .pbyte  0x00,0x80,0x01,0x00     ; row 19
;        .pbyte  0x00,0x80,0x00,0x00     ; row 20

; =====================================================================
;  SYMBOLS 32pt  —  height 33,  width 32,  4 bytes/row
;  (max width=32 due to PaintGlyph_32 using u32 for row data)
; =====================================================================
        .global _Symbols_32
_Symbols_32:
        .pbyte  31              ; Em Height
        .pbyte  0               ; Top Margin
        .pbyte  0               ; Bottom Margin
        .pbyte  0x84,0x00       ; first character code
        .pbyte  0               ; reserved
        .pbyte  0x85,0x00       ; last character code
        .pbyte  0               ; reserved
        .pbyte  33              ; Bitmap Height
        .pbyte  32              ; Baseline
        .pbyte  32              ; Max Width
        ; character map
        .pbyte  (   6 &0xFF), (   6 >>8)&0xFF, 32      ; 0x84 at word 6, width 32
        .pbyte  (  50 &0xFF), (  50 >>8)&0xFF, 32      ; 0x85 at word 50, width 32

; --- glyph 0x84: left arrow, 33 rows x 4 bytes = 132 bytes = 44 words ---
; Same triangle shape (tip at col 16, expands left), shaft trimmed to col 31.
        .pbyte  0x00,0x00,0x01,0x00     ; row 0:  tip col 16
        .pbyte  0x00,0x80,0x01,0x00     ; row 1:  cols 15-16
        .pbyte  0x00,0xC0,0x01,0x00     ; row 2:  cols 14-16
        .pbyte  0x00,0xE0,0x01,0x00     ; row 3:  cols 13-16
        .pbyte  0x00,0xF0,0x01,0x00     ; row 4:  cols 12-16
        .pbyte  0x00,0xF8,0x01,0x00     ; row 5:  cols 11-16
        .pbyte  0x00,0xFC,0x01,0x00     ; row 6:  cols 10-16
        .pbyte  0x00,0xFE,0x01,0x00     ; row 7:  cols 9-16
        .pbyte  0x00,0xFF,0x01,0x00     ; row 8:  cols 8-16
        .pbyte  0x80,0xFF,0x01,0x00     ; row 9:  cols 7-16
        .pbyte  0xC0,0xFF,0x01,0x00     ; row 10: cols 6-16
        .pbyte  0xE0,0xFF,0x01,0x00     ; row 11: cols 5-16
        .pbyte  0xF0,0xFF,0x01,0x00     ; row 12: cols 4-16
        .pbyte  0xF8,0xFF,0xFF,0xFF     ; row 13: cols 3-31
        .pbyte  0xFC,0xFF,0xFF,0xFF     ; row 14: cols 2-31
        .pbyte  0xFE,0xFF,0xFF,0xFF     ; row 15: cols 1-31
        .pbyte  0xFF,0xFF,0xFF,0xFF     ; row 16: cols 0-31
        .pbyte  0xFE,0xFF,0xFF,0xFF     ; row 17: cols 1-31
        .pbyte  0xFC,0xFF,0xFF,0xFF     ; row 18: cols 2-31
        .pbyte  0xF8,0xFF,0xFF,0xFF     ; row 19: cols 3-31
        .pbyte  0xF0,0xFF,0x01,0x00     ; row 20: cols 4-16
        .pbyte  0xE0,0xFF,0x01,0x00     ; row 21: cols 5-16
        .pbyte  0xC0,0xFF,0x01,0x00     ; row 22: cols 6-16
        .pbyte  0x80,0xFF,0x01,0x00     ; row 23: cols 7-16
        .pbyte  0x00,0xFF,0x01,0x00     ; row 24: cols 8-16
        .pbyte  0x00,0xFE,0x01,0x00     ; row 25: cols 9-16
        .pbyte  0x00,0xFC,0x01,0x00     ; row 26: cols 10-16
        .pbyte  0x00,0xF8,0x01,0x00     ; row 27: cols 11-16
        .pbyte  0x00,0xF0,0x01,0x00     ; row 28: cols 12-16
        .pbyte  0x00,0xE0,0x01,0x00     ; row 29: cols 13-16
        .pbyte  0x00,0xC0,0x01,0x00     ; row 30: cols 14-16
        .pbyte  0x00,0x80,0x01,0x00     ; row 31: cols 15-16
        .pbyte  0x00,0x00,0x01,0x00     ; row 32: tip col 16

; --- glyph 0x85: right arrow, 33 rows x 4 bytes = 132 bytes = 44 words ---
; Same triangle shape (tip at col 15, expands right), shaft trimmed to col 0.
        .pbyte  0x00,0x80,0x00,0x00     ; row 0:  tip col 15
        .pbyte  0x00,0x80,0x01,0x00     ; row 1:  cols 15-16
        .pbyte  0x00,0x80,0x03,0x00     ; row 2:  cols 15-17
        .pbyte  0x00,0x80,0x07,0x00     ; row 3:  cols 15-18
        .pbyte  0x00,0x80,0x0F,0x00     ; row 4:  cols 15-19
        .pbyte  0x00,0x80,0x1F,0x00     ; row 5:  cols 15-20
        .pbyte  0x00,0x80,0x3F,0x00     ; row 6:  cols 15-21
        .pbyte  0x00,0x80,0x7F,0x00     ; row 7:  cols 15-22
        .pbyte  0x00,0x80,0xFF,0x00     ; row 8:  cols 15-23
        .pbyte  0x00,0x80,0xFF,0x01     ; row 9:  cols 15-24
        .pbyte  0x00,0x80,0xFF,0x03     ; row 10: cols 15-25
        .pbyte  0x00,0x80,0xFF,0x07     ; row 11: cols 15-26
        .pbyte  0x00,0x80,0xFF,0x0F     ; row 12: cols 15-27
        .pbyte  0xFF,0xFF,0xFF,0x1F     ; row 13: cols 0-28
        .pbyte  0xFF,0xFF,0xFF,0x3F     ; row 14: cols 0-29
        .pbyte  0xFF,0xFF,0xFF,0x7F     ; row 15: cols 0-30
        .pbyte  0xFF,0xFF,0xFF,0xFF     ; row 16: cols 0-31
        .pbyte  0xFF,0xFF,0xFF,0x7F     ; row 17: cols 0-30
        .pbyte  0xFF,0xFF,0xFF,0x3F     ; row 18: cols 0-29
        .pbyte  0xFF,0xFF,0xFF,0x1F     ; row 19: cols 0-28
        .pbyte  0x00,0x80,0xFF,0x0F     ; row 20: cols 15-27
        .pbyte  0x00,0x80,0xFF,0x07     ; row 21: cols 15-26
        .pbyte  0x00,0x80,0xFF,0x03     ; row 22: cols 15-25
        .pbyte  0x00,0x80,0xFF,0x01     ; row 23: cols 15-24
        .pbyte  0x00,0x80,0xFF,0x00     ; row 24: cols 15-23
        .pbyte  0x00,0x80,0x7F,0x00     ; row 25: cols 15-22
        .pbyte  0x00,0x80,0x3F,0x00     ; row 26: cols 15-21
        .pbyte  0x00,0x80,0x1F,0x00     ; row 27: cols 15-20
        .pbyte  0x00,0x80,0x0F,0x00     ; row 28: cols 15-19
        .pbyte  0x00,0x80,0x07,0x00     ; row 29: cols 15-18
        .pbyte  0x00,0x80,0x03,0x00     ; row 30: cols 15-17
        .pbyte  0x00,0x80,0x01,0x00     ; row 31: cols 15-16
        .pbyte  0x00,0x80,0x00,0x00     ; row 32: tip col 15

        .end
