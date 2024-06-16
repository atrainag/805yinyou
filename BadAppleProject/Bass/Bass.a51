;==================================================
;INITIALIZATION
;==================================================
            ORG          0000H
            MOV          TMOD, #00100000B
            MOV          TH1, #232
            MOV          TL1, #232
            SETB         TR1
            MOV          SCON, #01110000B
            ACALL        DELAY
            MOV          A, #38H
            ACALL        WRINS
            MOV          A, #38H
            ACALL        WRINS
            MOV          A, #38H
            ACALL        WRINS
            MOV          A, #38H
            ACALL        WRINS
            MOV          A, #08H
            ACALL        WRINS
            MOV          A, #01H
            ACALL        WRINS
            MOV          A, #06H
            ACALL        WRINS
            MOV          A, #0CH
            ACALL        WRINS

;==================================================
;STARTUP
;==================================================
BEGIN:      MOV          DPTR, #STARTUP;LOAD-TEXT
            MOV          R5, #56; 7-TEXT
            ACALL        CGRAM ;
            MOV          R0, #16
            MOV          R1, #10001111B
TEXT1:      
            ACALL        SETCURSOR
            MOV          DPTR, #TAB1
            ACALL        DISPLAY
            DEC          R1
            MOV          R6, #34
            ACALL        IDELAY
            DJNZ         R0, TEXT1
            MOV          R6, #200
            ACALL        IDELAY
            MOV          R0, #10
            MOV          R1, #10001111B
TEXT2:      
            ACALL        SETCURSOR
            MOV          DPTR, #TAB2
            ACALL        DISPLAY
            DEC          R1
            MOV          R6, #24
            ACALL        IDELAY
            DJNZ         R0, TEXT2
            MOV          R6, #200
            ACALL        IDELAY
            ACALL        IDELAY

;==================================================
; MAIN
;==================================================
            MOV          R1, #11000000B
MAIN:       
            ACALL        SETCURSOR
            MOV          DPTR, #TAB3
            ACALL        DISPLAY
            ACALL        MDELAY
            ACALL        SETCURSOR
            MOV          DPTR, #TAB4
            ACALL        DISPLAY
            ACALL        MDELAY
            AJMP         MAIN

MDELAY:     MOV          R6, 255
MDL:        MOV          R7, #255
            DJNZ         R7, $
            JNB          P1.0, START
            JNB          P1.1, START
            JNB          P1.2, START
            JNB          P1.3, START
            DJNZ         R6, MDL
            RET         

START:      
            ACALL        SWITCH_ANIM
            MOV          R1, #10000000B
            ACALL        SETCURSOR
            MOV          DPTR,#TAB5
            ACALL        DISPLAY
            MOV          R1, #11000000B
            ACALL        SETCURSOR
            MOV          DPTR,#TAB6
            ACALL        DISPLAY
            MOV          DPTR, #MUSIC
            MOV          SBUF, #39
            CLR          TI
            JNB          TI, $

STARTDLY:   
 			MOV          R7,#15
STARTDL:	MOV          R6,#255
            DJNZ         R6,$ 
		    DJNZ         R7,STARTDL
CONT:       
CONT3:      
            CLR          A
            MOVC         A, @A+DPTR
            CJNE         A, #40, CHK
            AJMP         ENDSCR
CHK:        CJNE         A, #255, OK
STOP:       AJMP         STOP
OK:         MOV          R4, #1
            AJMP         CHK1

    
;==================================================
;CHECK NOTE
;==================================================
CHK1:       CJNE         A, #1, CHK7
            ACALL        B6
CHK7:       CJNE         A, #7, CHK9
            ACALL        F6
CHK9:       CJNE         A, #9, CHK11
            ACALL        DS6
CHK11:      CJNE         A, #11, CHK14
            ACALL        CS6
CHK14:      CJNE         A, #14, CHK16
            ACALL        AS5
CHK16:      CJNE         A, #16, CHK18
            ACALL        GS5
CHK18:      CJNE         A, #18, CHK19
            ACALL        FS5
CHK19:      CJNE         A, #19, CHK21
            ACALL        F5
CHK21:      CJNE         A, #21, CHK23
            ACALL        DS5
CHK23:      CJNE         A, #23, CHK25
            ACALL        CS5
CHK25:      CJNE         A, #25, CHK26
            ACALL        B4
CHK26:      CJNE         A, #26, CHK28
            ACALL        AS4
CHK28:      CJNE         A, #28, CHK30
            ACALL        GS4
CHK30:      CJNE         A, #30, CHK31
            ACALL        FS4
CHK31:      CJNE         A, #31, CHK33
            ACALL        F4
CHK33:      CJNE         A, #33, CHK34
            ACALL        DS4
CHK34:      CJNE         A, #34, CHK35
            ACALL        D4
CHK35:      CJNE         A, #35, CHK37
            ACALL        CS4
CHK37:      CJNE         A, #37, CHK0
            ACALL        B3
CHK0:       CJNE         A, #00, CONT2
            ACALL        NON
CONT2:      INC          DPTR
            AJMP         CONT

;==================================================
;NOTE FREQUENCIES
;==================================================
B6:         MOV          R6, #16
            MOV          R5, #247
            AJMP         OUTPUT
F6:         MOV          R6, #23
            MOV          R5, #175
            AJMP         OUTPUT
DS6:        MOV          R6, #26
            MOV          R5, #156
            AJMP         OUTPUT
CS6:        MOV          R6, #29
            MOV          R5, #139
            AJMP         OUTPUT
AS5:        MOV          R6, #35
            MOV          R5, #116
            AJMP         OUTPUT
GS5:        MOV          R6, #40
            MOV          R5, #104
            AJMP         OUTPUT
FS5:        MOV          R6, #44
            MOV          R5, #92
            AJMP         OUTPUT
F5:         MOV          R6, #47
            MOV          R5, #87
            AJMP         OUTPUT
DS5:        MOV          R6, #53
            MOV          R5, #78
            AJMP         OUTPUT
CS5:        MOV          R6, #60
            MOV          R5, #69
            AJMP         OUTPUT
B4:         MOV          R6, #67
            MOV          R5, #62
            AJMP         OUTPUT
AS4:        MOV          R6, #71
            MOV          R5, #58
            AJMP         OUTPUT
GS4:        MOV          R6, #80
            MOV          R5, #52
            AJMP         OUTPUT
FS4:        MOV          R6, #89
            MOV          R5, #46
            AJMP         OUTPUT
F4:         MOV          R6, #95
            MOV          R5, #44
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
B3:         MOV          R6, #134
            MOV          R5, #31
            AJMP         OUTPUT
GS3:        MOV          R6, #160
            MOV          R5, #26
            AJMP         OUTPUT
NON:        MOV          R6, #33
            MOV          R5, #124
            AJMP         OUTPUT

;==================================================
;SING
;==================================================
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
REST:       MOV          R6, #171
            MOV          R5, #20
WAIT:       ACALL        CHKDELAY
            DJNZ         R5, WAIT
            RET         
            
;==================================================
;ANIMATION
;==================================================
SWITCH_ANIM:
            MOV          DPTR, #STAB1
            ACALL        SLOOP
            MOV          DPTR, #WHITE
            ACALL        SLOOP
            RET         
SLOOP:      
            MOV          R0, #16
            MOV          R1, #10001111B
SWITCH1:    ACALL        SETCURSOR
            ACALL        DISPLAY
            DEC          R1
            MOV          R6, #15
            ACALL        IDELAY
            DJNZ         R0, SWITCH1
            MOV          R0, #16
            MOV          R1, #11001111B
SWITCH2:    ACALL        SETCURSOR
            ACALL        DISPLAY
            DEC          R1
            MOV          R6, #15
            ACALL        IDELAY
            DJNZ         R0, SWITCH2
            RET         

;==================================================
; END SCREEN 
;==================================================
ENDSCR:    
            MOV          R1, #10000000B
            ACALL        SETCURSOR
            MOV          DPTR, #TAB7
            ACALL        DISPLAY
            MOV          R1, #11000000B
            ACALL        SETCURSOR
            MOV          DPTR, #TAB8
            ACALL        DISPLAY
WAITKEY:    JNB          P1.0,RETRY
            JNB          P1.1,RETRY
            JNB          P1.2,RETRY
            JNB          P1.3,RETRY
            AJMP WAITKEY
RETRY:      MOV          A,#59
            MOV          SBUF,A
            CLR          TI
            JNB          TI,$
            AJMP         BEGIN

;==================================================
; TRANSFER KEY
;==================================================
CASE0:		
            MOV			     A,#00111111B
			      AJMP		     RELEASE       
CASE1:		
            MOV			     A,#11001111B
			      AJMP		     RELEASE      
CASE2:		
            MOV			     A,#11110011B
            AJMP		     RELEASE      
CASE3:		
            MOV			     A,#11111100B
            AJMP		     RELEASE
RELEASE: 	
            MOV 		     SBUF,A
            CLR          TI
            AJMP         CHKDL

;==================================================
; ADDITIONAL FUNCTIONS
;==================================================
DELAY:      MOV          B, R6
DL:         MOV          R7, #6
            DJNZ         R7, $
            DJNZ         R6, DL
            MOV          R6, B
            RET         

CHKDELAY:      MOV          B, R6
            JNB          P1.0,CASE0
            JNB          P1.1,CASE1
            JNB          P1.2,CASE2
            JNB          P1.3,CASE3    
CHKDL:         MOV          R7, #6
            DJNZ         R7, $
            DJNZ         R6, CHKDL
            MOV          R6, B
            RET         

CGRAM:      MOV          A, #01000000B
            ACALL        WRINS
            MOV          R4, #0;
CGRAMLOOP:  MOV          A, R4
            MOVC         A, @A+DPTR
            ACALL        WRDATA
            INC          R4
            DJNZ         R5, CGRAMLOOP
            RET         

DISPLAY:    PUSH         07
            MOV          R7, #00H
NEXT:       MOV          A, R7
            MOVC         A, @A+DPTR
            CJNE         A, #10H, DSP
            POP          07
            RET         

DSP:        ACALL        WRDATA
            INC          R7
            AJMP         NEXT

SETCURSOR:  
            MOV          A, R1
            ACALL        WRINS
            RET         

WRINS:      
            MOV          P1, #00111111B
            NOP         
            SETB         P1.7
            MOV          P0, A
            NOP         
            CLR          P1.7
            ACALL        DELAY8MS
            RET         
WRDATA:     
            MOV          P1, #01111111B
            NOP         
            SETB         P1.7
            MOV          P0, A
            NOP         
            CLR          P1.7
            ACALL        DELAY160US
            RET         

IDELAY:     MOV          B, R6
IDL:        MOV          R7, #200
            DJNZ         R7, $
            DJNZ         R6, IDL
            MOV          R6, B
            RET         

IDELAY2:    MOV          R6, #80
            DJNZ         R6, $
            RET         
DELAY40MS:  
            PUSH         07
            MOV          R6, #100
DL40:       MOV          R7, #200
            DJNZ         R7, $
            DJNZ         R6, DL40
            POP          07
            RET         
DELAY8MS:   
            PUSH         07
            PUSH         06
            MOV          R6, #20
DL8:        MOV          R7, #200
            DJNZ         R7, $
            DJNZ         R6, DL8
            POP          06
            POP          07
            RET         

DELAY160US: 
            PUSH         06
            MOV          R6, #80
            DJNZ         R6, $
            POP          06
            RET         
      
;==================================================
;MUSIC
;==================================================
MUSIC:      
            DB           0, 0, 0, 0
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 34, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 34, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 34, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           28, 0, 0, 0
            DB           30, 0, 0, 0
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 34, 26
            DB           33, 26, 33, 26
            DB           21, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 34, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 34, 26
            DB           33, 26, 33, 26
            DB           21, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 34, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 34, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 34, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 34, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           33, 26, 33, 26
            DB           37, 30, 37, 30
            DB           37, 30, 37, 30
            DB           35, 28, 35, 28
            DB           34, 26, 14, 11
            DB           37, 9, 14, 16
            DB           14, 0, 16, 14
            DB           35, 9, 14, 16
            DB           14, 0, 16, 14
            DB           33, 18, 19, 31
            DB           30, 0, 31, 30
            DB           33, 18, 16, 14
            DB           30, 0, 14, 11
            DB           37, 9, 14, 16
            DB           14, 0, 16, 14
            DB           35, 9, 14, 16
            DB           14, 0, 16, 14
            DB           33, 18, 19, 31
            DB           30, 0, 31, 30
            DB           19, 18, 16, 14
            DB           30, 0, 14, 11
            DB           37, 30, 25, 37
            DB           30, 25, 37, 14
            DB           35, 28, 23, 35
            DB           28, 23, 35, 14
            DB           33, 26, 21, 33
            DB           26, 21, 33, 21
            DB           33, 26, 21, 33
            DB           26, 21, 33, 11
            DB           37, 30, 25, 37
            DB           30, 25, 37, 14
            DB           35, 28, 23, 35
            DB           28, 23, 35, 7
            DB           33, 26, 21, 33
            DB           26, 21, 33, 14
            DB           16, 18, 19, 23
            DB           28, 0, 30, 0
            DB           33, 1
            DB           40

;==================================================
;TEXT-TABLES
;==================================================
TAB1:       DB           'MCS5'
            DB           '1-'
            DB           10H

TAB2:       DB           00H
            DB           01H
            DB           02H
            DB           03H
            DB           04H
            DB           ' '
            DB           10H

TAB3:		
            DB		     	'    '				
            DB		     	'<ST'
			      DB		     	'ART>'  
      			DB		     	10H

TAB4:   		DB		    	'    '				
      			DB		    	'    '
            DB		    	'    '
			      DB		    	10H

TAB5:       DB          'Playi'
            DB          'ng-No'
            DB          'w:'
            DB          10H

TAB6:       DB          'Bad A'
            DB          'pple'
            DB          05H
            DB          06H
            DB          10H

TAB7:       DB          'PRESS'
            DB          ' ANY '
            DB          'KEY T'
            DB          'O'
            DB          10H

TAB8:       DB          ' CONT'
            DB          'INUE'
            DB          10H

;==================================================
;CUSTOM-TEXT
;==================================================
STARTUP:    DB           00000001B
            DB           00001111B
            DB           00000010B
            DB           00011111B
            DB           00000100B
            DB           00000111B
            DB           00000100B
            DB           00000111B

            DB           00000000B
            DB           00011100B
            DB           00001000B
            DB           00011111B
            DB           00000100B
            DB           00010100B
            DB           00000100B
            DB           00011100B

            DB           00000010B
            DB           00000001B
            DB           00000010B
            DB           00000001B
            DB           00000000B
            DB           00000001B
            DB           00000001B
            DB           00000110B

            DB           00000100B
            DB           00011111B
            DB           00001000B
            DB           00001111B
            DB           00001001B
            DB           00001001B
            DB           00010001B
            DB           00010010B

            DB           00001000B
            DB           00001110B
            DB           00010000B
            DB           00001100B
            DB           00000010B
            DB           00001111B
            DB           00000010B
            DB           00001100B

            DB           00000000B
            DB           00000000B
            DB           00000000B
            DB           00000000B
            DB           00000111B
            DB           00001111B
            DB           00011111B
            DB           00001111B

            DB           00011100B
            DB           00011110B
            DB           00011011B
            DB           00011000B
            DB           00011000B
            DB           00011000B
            DB           00010000B
            DB           00000000B

WHITE:      DB           11111110B
            DB           10H

STAB1:      DB           11111111B
            DB           10H
            END         
