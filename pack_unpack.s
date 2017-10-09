; Michael Pohoreski
; github
; HGR Packer/Unpacker by removing/adding HGR screen holes
; Pack 8,192 bytes down to 8,192-512 = 7,680 = 30 sectors instead of 34 sectors
; Remove the "screen holes" by "sliding" remaining memory down over them
; Basically a glorified memcpy()
;
; Binary
; ====== 
;    CALL-151
;    0300:A9 20 A2 40 85 FB A0 FE
;    0308:D0 08 A9 40 A2 20 86 FB
;    0310:A0 FC 8C 3D 03 8C 41 03
;    0318:C8 8C 45 03 A0 00 84 FE
;    0320:85 FF 84 FC 86 FD A2 78
;    0328:B1 FE 91 FC E6 FE D0 02
;    0330:E6 FF E6 FC D0 02 E6 FD
;    0338:CA D0 ED 18 A5 FE 69 08
;    0340:85 FE D0 E2 E6 FF C6 FB
;    0348:D0 DC 60 
;    BSAVE HGR_PACK_UPACK,A$300,L$4B
;
; Usage
; =====
;    BLOAD PIC,A$2000
;    CALL 768:REM $300
;    BSAVE PIC.PACK,A$4000,L$1E00
;    CALL 778:REM $30A
;    BSAVE PIC.HGR,A$2000,L$2000
;
; Pack - Monitor Commands
; =======================
;    4000<2000.2077M
;    4078<2080.20F7M
;    40F0<2100.2177M
;    4168<2180.21F7M
;    41E0<2200.2277M
;    4258<2280.22F7M
;    42D0<2300.2377M
;    4348<2380.23F7M
;    43C0<2400.2477M
;    4438<2480.24F7M
;    44B0<2500.2577M
;    4528<2580.25F7M
;    45A0<2600.2677M
;    4618<2680.26F7M
;    4690<2700.2777M
;    4708<2780.27F7M
;    4780<2800.2877M
;    47F8<2880.28F7M
;    4870<2900.2977M
;    48E8<2980.29F7M
;    4960<2A00.2A77M
;    49D8<2A80.2AF7M
;    4A50<2B00.2B77M
;    4AC8<2B80.2BF7M
;    4B40<2C00.2C77M
;    4BB8<2C80.2CF7M
;    4C30<2D00.2D77M
;    4CA8<2D80.2DF7M
;    4D20<2E00.2E77M
;    4D98<2E80.2EF7M
;    4E10<2F00.2F77M
;    4E88<2F80.2FF7M
;    4F00<3000.3077M
;    4F78<3080.30F7M
;    4FF0<3100.3177M
;    5068<3180.31F7M
;    50E0<3200.3277M
;    5158<3280.32F7M
;    51D0<3300.3377M
;    5248<3380.33F7M
;    52C0<3400.3477M
;    5338<3480.34F7M
;    53B0<3500.3577M
;    5428<3580.35F7M
;    54A0<3600.3677M
;    5518<3680.36F7M
;    5590<3700.3777M
;    5608<3780.37F7M
;    5680<3800.3877M
;    56F8<3880.38F7M
;    5770<3900.3977M
;    57E8<3980.39F7M
;    5860<3A00.3A77M
;    58D8<3A80.3AF7M
;    5950<3B00.3B77M
;    59C8<3B80.3BF7M
;    5A40<3C00.3C77M
;    5AB8<3C80.3CF7M
;    5B30<3D00.3D77M
;    5BA8<3D80.3DF7M
;    5C20<3E00.3E77M
;    5C98<3E80.3EF7M
;    5D10<3F00.3F77M
;    5D88<3F80.3FF7M
;
; Unpack - Monitor Commands
; =========================
;    2000<4000.4077M
;    2078<4080.40F7M
;    20F0<4100.4177M
;    2168<4180.41F7M
;    21E0<4200.4277M
;    2258<4280.42F7M
;    22D0<4300.4377M
;    2348<4380.43F7M
;    23C0<4400.4477M
;    2438<4480.44F7M
;    24B0<4500.4577M
;    2528<4580.45F7M
;    25A0<4600.4677M
;    2618<4680.46F7M
;    2690<4700.4777M
;    2708<4780.47F7M
;    2780<4800.4877M
;    27F8<4880.48F7M
;    2870<4900.4977M
;    28E8<4980.49F7M
;    2960<4A00.4A77M
;    29D8<4A80.4AF7M
;    2A50<4B00.4B77M
;    2AC8<4B80.4BF7M
;    2B40<4C00.4C77M
;    2BB8<4C80.4CF7M
;    2C30<4D00.4D77M
;    2CA8<4D80.4DF7M
;    2D20<4E00.4E77M
;    2D98<4E80.4EF7M
;    2E10<4F00.4F77M
;    2E88<4F80.4FF7M
;    2F00<5000.5077M
;    2F78<5080.50F7M
;    2FF0<5100.5177M
;    3068<5180.51F7M
;    30E0<5200.5277M
;    3158<5280.52F7M
;    31D0<5300.5377M
;    3248<5380.53F7M
;    32C0<5400.5477M
;    3338<5480.54F7M
;    33B0<5500.5577M
;    3428<5580.55F7M
;    34A0<5600.5677M
;    3518<5680.56F7M
;    3590<5700.5777M
;    3608<5780.57F7M
;    3680<5800.5877M
;    36F8<5880.58F7M
;    3770<5900.5977M
;    37E8<5980.59F7M
;    3860<5A00.5A77M
;    38D8<5A80.5AF7M
;    3950<5B00.5B77M
;    39C8<5B80.5BF7M
;    3A40<5C00.5C77M
;    3AB8<5C80.5CF7M
;    3B30<5D00.5D77M
;    3BA8<5D80.5DF7M
;
; First Packed Byte: $4000
; Last Packed Byte:  $5DFF

; Each page of HGR memory has 6 scanlines
;   First Half of Page ($78 bytes) = 3 scanlines
;   Last  Half of Page ($78 bytes) = 3 scanlines
Row = $FB   ; 6 scanlines/page processed per loop
Dst = $FC
Src = $FE

        org $300

; ========================================================================
Pack
        lda #$20        ; Src: HGR Page 1
        ldx #$40        ; Dst: HGR Page 2
        sta Row         ; 32 pages * 6 scanlines/page = 192 scanlines
        ldy #Src
        bne Common

; ========================================================================
Unpack
        lda #$40        ; Src: HGR Page 2
        ldx #$20        ; Dst: HGR Page 1
        stx Row         ; 32 pages * 6 scanlines/page = 192 scanlines
        ldy #Dst

; A = Src Page
; X = Dst Page
; Pack:
; Y = Src zero-page address
; Unpack:
; Y = Dst zero-page address
; ========================================================================
Common
        sty _Delta1+1   ; *** SELF-MODIFYING
        sty _Delta2+1   ; *** SELF-MODIFYING
        iny
        sty _Delta3+1   ; *** SELF-MODIFYING

        ldy #$00        ; low of src, low of dst

        sty Src+0
        sta Src+1

        sty Dst+0
        stx Dst+1

; -------- process 3 scan lines
HalfPage
        ldx #$78        ; Pack 3 (non-linear) scan lines [$2000..$2027, $2028..$2057, $2058..$2077]
CopyHalf
        lda (Src),y
        sta (Dst),y

        inc Src+0       ; src++
        bne SrcPage
        inc Src+1       ; 16-bit pointer
SrcPage
        inc Dst+0       ; dst++
        bne DstPage
        inc Dst+1       ; 16-bit pointer
DstPage
        dex
        bne CopyHalf

; -------- processed 6 scanlines?
        clc             ; src += 8
_Delta1 lda Src+0       ; *** SELF-MODIFIED
        adc #8          ; src = $xx78 + 8 -> $xx80
_Delta2 sta Src+0       ; *** SELF-MODIFIED
        bne HalfPage    ; src = $xxF8 + 8 -> $yy00
_Delta3 inc Src+1       ; *** SELF-MODIFIED

        dec Row 
        bne HalfPage
        rts

