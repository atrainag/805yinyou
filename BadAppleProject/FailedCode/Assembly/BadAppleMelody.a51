            ORG          0000H
            AJMP         START

START:      MOV          DPTR, #MUSIC
CONT:       CLR          A
            MOVC         A, @A+DPTR
            CJNE         A, #40, CHK
            AJMP         START
CHK:        CJNE         A, #255, OK
STOP:       AJMP         STOP
OK:         PUSH         ACC
            INC          DPTR
            CLR          A
            MOVC         A, @A+DPTR
            MOV          R4, A
            POP          ACC

CHK1:       CJNE         A, #1, CHK2
            ACALL        B6
CHK2:       CJNE         A, #2, CHK3
            ACALL        AS6
CHK3:       CJNE         A, #3, CHK4
            ACALL        A6
CHK4:       CJNE         A, #4, CHK5
            ACALL        GS6
CHK5:       CJNE         A, #5, CHK6
            ACALL        G6
CHK6:       CJNE         A, #6, CHK7
            ACALL        FS6
CHK7:       CJNE         A, #7, CHK8
            ACALL        F6
CHK8:       CJNE         A, #8, CHK9
            ACALL        E6
CHK9:       CJNE         A, #9, CHK10
            ACALL        DS6
CHK10:      CJNE         A, #10, CHK11
            ACALL        D6
CHK11:      CJNE         A, #11, CHK12
            ACALL        CS6
CHK12:      CJNE         A, #12, CHK13
            ACALL        C6
CHK13:      CJNE         A, #13, CHK14
            ACALL        B5
CHK14:      CJNE         A, #14, CHK15
            ACALL        AS5
CHK15:      CJNE         A, #15, CHK16
            ACALL        A5
CHK16:      CJNE         A, #16, CHK17
            ACALL        GS5
CHK17:      CJNE         A, #17, CHK18
            ACALL        G5
CHK18:      CJNE         A, #18, CHK19
            ACALL        FS5
CHK19:      CJNE         A, #19, CHK20
            ACALL        F5
CHK20:      CJNE         A, #20, CHK21
            ACALL        E5
CHK21:      CJNE         A, #21, CHK22
            ACALL        DS5
CHK22:      CJNE         A, #22, CHK23
            ACALL        D5
CHK23:      CJNE         A, #23, CHK24
            ACALL        CS5
CHK24:      CJNE         A, #24, CHK25
            ACALL        C5
CHK25:      CJNE         A, #25, CHK26
            ACALL        B4
CHK26:      CJNE         A, #26, CHK27
            ACALL        AS4
CHK27:      CJNE         A, #27, CHK28
            ACALL        A4
CHK28:      CJNE         A, #28, CHK29
            ACALL        GS4
CHK29:      CJNE         A, #29, CHK30
            ACALL        G4
CHK30:      CJNE         A, #30, CHK31
            ACALL        FS4
CHK31:      CJNE         A, #31, CHK32
            ACALL        F4
CHK32:      CJNE         A, #32, CHK33
            ACALL        E4
CHK33:      CJNE         A, #33, CHK34
            ACALL        DS4
CHK34:      CJNE         A, #34, CHK35
            ACALL        D4
CHK35:      CJNE         A, #35, CHK36
            ACALL        CS4
CHK36:      CJNE         A, #36, CHK37
            ACALL        C4
CHK37:      CJNE         A, #37, CHK38
            ACALL        B3
CHK38:      CJNE         A, #38, CHK39
            ACALL        AS3
CHK39:      CJNE         A, #39, CHK40
            ACALL        A3
CHK40:      CJNE         A, #40, CHK41
            ACALL        GS3
CHK41:      CJNE         A, #41, CHK42
            ACALL        G3
CHK42:      CJNE         A, #42, CHK43
            ACALL        FS3
CHK43:      CJNE         A, #43, CHK44
            ACALL        F3
CHK44:      CJNE         A, #44, CHK45
            ACALL        E3
CHK45:      CJNE         A, #45, CHK46
            ACALL        DS3
CHK46:      CJNE         A, #46, CHK47
            ACALL        D3
CHK47:      CJNE         A, #47, CHK48
            ACALL        CS3
CHK48:      CJNE         A, #48, CHK0
            ACALL        C3
CHK0:       CJNE         A, #00, CONT2
            ACALL        NON
CONT2:      INC          DPTR
            AJMP         CONT

B6:         MOV          R6, #16
            MOV          R5, #247
            AJMP         OUTPUT
AS6:        MOV          R6, #17
            MOV          R5, #233
            AJMP         OUTPUT
A6:         MOV          R6, #18
            MOV          R5, #220
            AJMP         OUTPUT
GS6:        MOV          R6, #19
            MOV          R5, #208
            AJMP         OUTPUT
G6:         MOV          R6, #21
            MOV          R5, #196
            AJMP         OUTPUT
FS6:        MOV          R6, #22
            MOV          R5, #185
            AJMP         OUTPUT
F6:         MOV          R6, #23
            MOV          R5, #175
            AJMP         OUTPUT
E6:         MOV          R6, #25
            MOV          R5, #165
            AJMP         OUTPUT
DS6:        MOV          R6, #26
            MOV          R5, #156
            AJMP         OUTPUT
D6:         MOV          R6, #28
            MOV          R5, #147
            AJMP         OUTPUT
CS6:        MOV          R6, #29
            MOV          R5, #139
            AJMP         OUTPUT
C6:         MOV          R6, #31
            MOV          R5, #131
            AJMP         OUTPUT
B5:         MOV          R6, #33
            MOV          R5, #124
            AJMP         OUTPUT
AS5:        MOV          R6, #35
            MOV          R5, #116
            AJMP         OUTPUT
A5:         MOV          R6, #37
            MOV          R5, #110
            AJMP         OUTPUT
GS5:        MOV          R6, #40
            MOV          R5, #104
            AJMP         OUTPUT
G5:         MOV          R6, #42
            MOV          R5, #98
            AJMP         OUTPUT
FS5:        MOV          R6, #44
            MOV          R5, #92
            AJMP         OUTPUT
F5:         MOV          R6, #47
            MOV          R5, #87
            AJMP         OUTPUT
E5:         MOV          R6, #50
            MOV          R5, #82
            AJMP         OUTPUT
DS5:        MOV          R6, #53
            MOV          R5, #78
            AJMP         OUTPUT
D5:         MOV          R6, #56
            MOV          R5, #73
            AJMP         OUTPUT
CS5:        MOV          R6, #60
            MOV          R5, #69
            AJMP         OUTPUT
C5:         MOV          R6, #63
            MOV          R5, #65
            AJMP         OUTPUT
B4:         MOV          R6, #67
            MOV          R5, #62
            AJMP         OUTPUT
AS4:        MOV          R6, #71
            MOV          R5, #58
            AJMP         OUTPUT
A4:         MOV          R6, #75
            MOV          R5, #55
            AJMP         OUTPUT
GS4:        MOV          R6, #80
            MOV          R5, #52
            AJMP         OUTPUT
G4:         MOV          R6, #84
            MOV          R5, #49
            AJMP         OUTPUT
FS4:        MOV          R6, #89
            MOV          R5, #46
            AJMP         OUTPUT
F4:         MOV          R6, #95
            MOV          R5, #44
            AJMP         OUTPUT
E4:         MOV          R6, #100
            MOV          R5, #41
            AJMP         OUTPUT
DS4:        MOV          R6, #107
            MOV          R5, #39
            AJMP         OUTPUT
D4:         MOV          R6, #113
            MOV          R5, #37
            AJMP         OUTPUT
CS4:        MOV          R6, #120
            MOV          R5, #35
            AJMP         OUTPUT
C4:         MOV          R6, #127
            MOV          R5, #33
            AJMP         OUTPUT
B3:         MOV          R6, #134
            MOV          R5, #31
            AJMP         OUTPUT
AS3:        MOV          R6, #142
            MOV          R5, #29
            AJMP         OUTPUT
A3:         MOV          R6, #151
            MOV          R5, #28
            AJMP         OUTPUT
GS3:        MOV          R6, #160
            MOV          R5, #26
            AJMP         OUTPUT
G3:         MOV          R6, #169
            MOV          R5, #24
            AJMP         OUTPUT
FS3:        MOV          R6, #180
            MOV          R5, #23
            AJMP         OUTPUT
F3:         MOV          R6, #190
            MOV          R5, #22
            AJMP         OUTPUT
E3:         MOV          R6, #201
            MOV          R5, #21
            AJMP         OUTPUT
DS3:        MOV          R6, #213
            MOV          R5, #20
            AJMP         OUTPUT
D3:         MOV          R6, #226
            MOV          R5, #18
            AJMP         OUTPUT
CS3:        MOV          R6, #239
            MOV          R5, #17
            AJMP         OUTPUT
C3:         MOV          R6, #254
            MOV          R5, #16
            AJMP         OUTPUT

NON:        MOV          R6, #33
            MOV          R5, #124
            AJMP         OUTPUT

OUTPUT:     PUSH         05
LOOP:       CJNE         A, #00, SOUND
            AJMP         MUTE
SOUND:      CLR          P2.6
MUTE:       ACALL        DELAY
            SETB         P2.6
            ACALL        DELAY
            DJNZ         R5, LOOP
            POP          05
            DJNZ         R4, OUTPUT

REST:       MOV          R6, #170
            MOV          R5, #20

WAIT:       ACALL        DELAY
            DJNZ         R5, WAIT
            RET         

DELAY:      MOV          B, R6
DL:         MOV          R7, #6
            DJNZ         R7, $
            DJNZ         R6, DL
            MOV          R6, B
            RET         

MUSIC:      
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           18, 1, 0, 1, 21, 1, 18, 1
            DB           16, 1, 0, 1, 18, 1, 16, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           16, 1, 0, 1, 18, 1, 16, 1
            DB           18, 1, 0, 1, 21, 1, 18, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           18, 1, 0, 1, 21, 1, 18, 1
            DB           16, 1, 0, 1, 18, 1, 16, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           33, 1, 0, 1, 33, 1, 21, 1
            DB           0, 1, 21, 1, 23, 1, 21, 1
            DB           16, 1, 0, 1, 0, 1, 0, 1
            DB           18, 1, 0, 1, 0, 1, 0, 1
            DB           21, 1, 19, 1, 18, 1, 16, 1
            DB           14, 1, 0, 1, 9, 1, 11, 1
            DB           14, 1, 0, 1, 21, 1, 0, 1
            DB           14, 1, 16, 1, 18, 1, 19, 1
            DB           21, 1, 19, 1, 18, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 18, 1
            DB           19, 1, 21, 1, 19, 1, 18, 1
            DB           19, 1, 21, 1, 22, 1, 19, 1
            DB           21, 1, 19, 1, 18, 1, 16, 1
            DB           14, 1, 0, 1, 9, 1, 11, 1
            DB           14, 1, 0, 1, 21, 1, 0, 1
            DB           14, 1, 16, 1, 18, 1, 19, 1
            DB           21, 1, 19, 1, 18, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 18, 1
            DB           19, 1, 0, 1, 18, 1, 0, 1
            DB           16, 1, 0, 1, 14, 1, 0, 1
            DB           21, 1, 19, 1, 18, 1, 16, 1
            DB           14, 1, 0, 1, 9, 1, 11, 1
            DB           14, 1, 0, 1, 21, 1, 0, 1
            DB           14, 1, 16, 1, 18, 1, 19, 1
            DB           21, 1, 19, 1, 18, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 18, 1
            DB           19, 1, 21, 1, 19, 1, 18, 1
            DB           19, 1, 21, 1, 22, 1, 19, 1
            DB           21, 1, 19, 1, 18, 1, 16, 1
            DB           14, 1, 0, 1, 9, 1, 11, 1
            DB           14, 1, 0, 1, 21, 1, 0, 1
            DB           14, 1, 16, 1, 18, 1, 19, 1
            DB           21, 1, 19, 1, 18, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 18, 1
            DB           19, 1, 0, 1, 18, 1, 0, 1
            DB           16, 1, 0, 1, 14, 1, 0, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 14, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 14, 1
            DB           16, 1, 18, 1, 19, 1, 23, 1
            DB           21, 1, 0, 1, 23, 1, 21, 1
            DB           19, 1, 18, 1, 16, 1, 14, 1
            DB           21, 1, 0, 1, 14, 1, 11, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 14, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 14, 1
            DB           16, 1, 18, 1, 19, 1, 23, 1
            DB           21, 1, 0, 1, 23, 1, 21, 1
            DB           19, 1, 18, 1, 16, 1, 14, 1
            DB           21, 1, 0, 1, 14, 1, 11, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 14, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 14, 1
            DB           16, 1, 18, 1, 19, 1, 23, 1
            DB           21, 1, 0, 1, 23, 1, 21, 1
            DB           19, 1, 18, 1, 16, 1, 14, 1
            DB           21, 1, 0, 1, 14, 1, 11, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 14, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 9, 1, 7, 1
            DB           6, 1, 7, 1, 9, 1, 11, 1
            DB           14, 1, 0, 1, 16, 1, 14, 1
            DB           16, 1, 18, 1, 19, 1, 23, 1
            DB           21, 1, 0, 1, 0, 1, 0, 1
            DB           11, 1, 0, 1, 0, 1, 0, 1
            DB           0, 1, 0, 1, 0, 1, 0, 1
            DB           11, 1, 0, 1, 0, 1, 0, 1
            DB           0, 1, 0, 1, 0, 1, 0, 1
            DB           16, 1, 0, 1, 0, 1, 23, 1
            DB           21, 1, 0, 1, 23, 1, 21, 1
            DB           19, 1, 0, 1, 0, 1, 0, 1
            DB           21, 1, 0, 1, 0, 1, 0, 1
            DB           11, 1, 0, 1, 0, 1, 0, 1
            DB           0, 1, 0, 1, 0, 1, 0, 1
            DB           11, 1, 0, 1, 0, 1, 0, 1
            DB           0, 1, 0, 1, 0, 1, 0, 1
            DB           16, 1, 0, 1, 0, 1, 23, 1
            DB           21, 1, 0, 1, 23, 1, 21, 1
            DB           0, 1, 0, 1, 0, 1, 0, 1
            DB           21, 1, 0, 1, 0, 1, 0, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 0, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 0, 1
            DB           16, 1, 18, 1, 19, 1, 23, 1
            DB           21, 1, 0, 1, 23, 1, 0, 1
            DB           19, 1, 18, 1, 16, 1, 14, 1
            DB           21, 1, 0, 1, 14, 1, 0, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 16, 1, 0, 1
            DB           11, 1, 9, 1, 14, 1, 16, 1
            DB           14, 1, 0, 1, 9, 1, 0, 1
            DB           6, 1, 7, 1, 9, 1, 11, 1
            DB           14, 1, 0, 1, 16, 1, 0, 1
            DB           0, 1, 0, 1, 0, 1, 0, 1
            DB           21, 1, 0, 1, 0, 1, 0, 1
            DB           0, 1

            DB           40
            END         
