            ORG         0000H      
				
			MOV 		TMOD,		#00100000B
			MOV 		TH1,		#232
			MOV 		TL1,		#232
			SETB 		TR1
			MOV			SCON,		#01110000B
			
START:		CLR			RI
WAITBUTTON:	JNB			RI,WAITBUTTON                   

			MOV			A,SBUF
			JNB			ACC.0,MAIN
			JNB			ACC.1,MAIN
			JNB			ACC.2,MAIN
			JNB			ACC.3,MAIN
			AJMP		START

MAIN:       MOV         DPTR,       #TABLE      
            PUSH    DPL 
            PUSH DPH
            MOV dptr,#MUSIC 
            MOV     R0, #0x10  ; Load R0 with the address 0x10
            MOV     @R0, DPL   ; Store DPL at address 0x10
            MOV     R0, #0x11  ; Load R0 with the address 0x11
            MOV     @R0, DPH   ; Store DPH at address 0x11
            POP DPH
            POP DPL
    
LOOP:      
            PUSH DPL
            PUSH DPH
            AJMP SING
            AJMP        MAIN        

SCAN1:      MOV         R1,         #00H        
            MOV         R5,         #11111110B  
            MOV         R4,         #08         
LOOP1:      MOV         A,          R1          
            MOVC        A,          @A+DPTR     
            MOV         P0,         A           
            MOV         P1,         R5          
            MOV         R6,         #3          
DL1:        MOV         R7,         #10    
DL2:        JB			RI,			TRANS
CONTINUE:   DJNZ        R7,         DL2         
            DJNZ        R6,         DL1         
            ORL         P0,         #00000000B  
            MOV         A,          R5          
            RL          A           
            MOV         R5,         A           
            INC         R1          
            DJNZ        R4,         LOOP1       
            RET         

TRANS:		MOV			A,			SBUF
			MOV			R3,			#00H
			JNB			ACC.6,		CHECK0
			JNB			ACC.4,		CHECK0
			JNB			ACC.2,		CHECK0
			JNB			ACC.0,		CHECK0
			AJMP		CONTINUE

CHECK0:		MOV			B,			#5
LOOPC0:		MOV			A,			R3
			MOVC		A,			@A+DPTR
			CJNE		A,#00111111B,BUTTON2
            AJMP TRUE
BUTTON2:	CJNE		A,#11001111B,BUTTON3
            AJMP TRUE
BUTTON3:	CJNE		A,#11110011B,BUTTON4
            AJMP TRUE
BUTTON4:	CJNE		A,#11111100B,CHECKA
			AJMP		TRUE
CHECKA:	INC			R3
			DJNZ		B,			LOOPC0
			AJMP		FALSE

TRUE:		MOV			A,#11111110B
			MOV			SBUF,A
WAIT1:		JNB			TI,WAIT1
			CLR			RI
			CLR			TI
			AJMP		CONTINUE
			
FALSE:		MOV			A,#11111101B
			MOV			SBUF,A
WAIT2:		JNB			TI,WAIT2
			CLR			RI
			CLR			TI
			AJMP		CONTINUE


SING:       
    MOV     R0, #0x10  ; Load R0 with the address 0x10
    MOV     DPL, @R0   ; Load DPL from address 0x10
    MOV     R0, #0x11  ; Load R0 with the address 0x11
    MOV     DPH, @R0   ; Load DPH from address 0x11
CONT:      	CLR         A           
            MOVC        A,          @A+DPTR     
OK:         
            PUSH 04
			PUSH 02
            MOV          R4,# 1
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
CHK37:      CJNE         A, #37, CHK40
            ACALL        B3
CHK0:       CJNE         A, #00, CONT2
            ACALL        NON
CONT2:      INC          DPTR
            MOV     R0, #0x10  ; Load R0 with the address 0x10
            MOV     @R0, DPL   ; Store DPL at address 0x10
            MOV     R0, #0x11  ; Load R0 with the address 0x11
            MOV     @R0, DPH   ; Store DPH at address 0x11
            POP 02
			POP 04
            POP DPH
            POP DPL
            INC         DPTR        
            AJMP LOOP 

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

OUTPUT:     PUSH         05
LOOP3:       CJNE         A, #00, SOUND
            AJMP         MUTE
SOUND:      CLR          P2.6
MUTE:       ACALL        DELAY
            SETB         P2.6
            ACALL        DELAY
            DJNZ         R5, LOOP3
            POP          05
            DJNZ         R4, OUTPUT

            MOV         R2,         #12
SCAN:       ACALL       SCAN1       
            DJNZ        R2,         SCAN        

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
TABLE:      
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   

            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B  				
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11001111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111100B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   


            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   

MUSIC:      
            DB            0, 0, 0, 0
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
            DB           28, 0, 0, 0, 0
            DB           30, 0, 0, 0, 0
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
            END         
