            ORG         0000H   
				
			MOV			TMOD,#00100000B
			MOV			TH1,#232
			MOV			TL1,#232
			SETB		TR1
			MOV			SCON,#01110000B
			ACALL       INIT2 
			
;==================================================
;				STARTUP
;==================================================
START:		MOV			DPTR,#STARTUP		;LOAD-TEXT
			MOV			R5,#48				;6-TEXT
			ACALL		CGRAM				;
			MOV			R0,#16
			MOV			R1,#10001111B
			
TEXT1:		ACALL		LINE1
			MOV			DPTR,#TAB1
			ACALL		DISPLAY
			DEC			R1
			MOV			R6,#34
			ACALL		IDELAY
			DJNZ		R0,TEXT1
			
			MOV			R6,#200
			ACALL		IDELAY
			
			MOV			R0,#10
			MOV			R1,#10001111B
			
TEXT2:		ACALL		LINE1
			MOV			DPTR,#TAB2
			ACALL		DISPLAY
			DEC			R1
			MOV			R6,#24
			ACALL		IDELAY
			DJNZ		R0,TEXT2
			
			MOV			R6,#200
			ACALL		IDELAY
			ACALL		IDELAY
			
;==================================================
;				MAIN
;==================================================
			MOV			R6,#255			;SET MDELAY
			MOV			R1,#11000000B
			CLR			TI

MAINMENU:	ACALL		LINE2
			MOV			DPTR,#TAB3
			ACALL		DISPLAY
			
			MOV			R6,#255
			ACALL		MDELAY
			
			ACALL		LINE2
			MOV			DPTR,#TAB4
			ACALL		DISPLAY
			
			ACALL		MDELAY
			
			AJMP 		MAINMENU

MDELAY:		MOV			B,R6
MDL:		MOV			R7,#255	
			DJNZ		R7,$
			JNB 		P1.0,MELODY
			JNB 		P1.1,MELODY
			JNB 		P1.2,MELODY
			JNB 		P1.3,MELODY
			DJNZ		R6,MDL
			MOV         R6,B
			RET
			
TRANS2:		ACALL		RELEASE    
			AJMP		BEGIN
;==================================================
;				ALBUM
;==================================================
MELODY:		MOV 		A,P1
			ACALL		SWICTH_ANIM
			MOV 		R1,#10000000B
			ACALL       LINE1       
        MOV         DPTR,#TAB0       
        ACALL       DISPLAY 
			MOV         DPTR,#MUSIC      
			AJMP		TRANS2		
;==================================================
;				ANIMATION
;==================================================
SWICTH_ANIM:
      MOV			DPTR,#STAB1			
			ACALL		SLOOP	
			MOV			DPTR,#WHITE			
			ACALL		SLOOP
			RET
			
SLOOP:		MOV			R0,#16
			MOV			R1,#10001111B			
SWICTH1:	ACALL		LINE1
			ACALL		DISPLAY
			DEC			R1
			MOV			R6,#15
			ACALL		IDELAY
			DJNZ		R0,SWICTH1		
			
			MOV			R0,#16
			MOV			R1,#11001111B		
SWICTH2:	ACALL		LINE2
			ACALL		DISPLAY
			DEC			R1
			MOV			R6,#15
			ACALL		IDELAY
			DJNZ		R0,SWICTH2	
			RET

;==================================================
;				SCORE
;==================================================				
BEGIN:      MOV         R4,         #0          ;           HIGH        BYTE        OF          COUNTER     
            MOV         R5,         #0          ;           LOW         BYTE        OF          COUNTER     
					
MAIN:		MOV 		R1,#11000000B
			ACALL       LINE2
			ACALL       DISPLAY2    
			MOV         P0,R5 
LOOP:		CLR			TI
			CLR			RI
			MOV			A,#11111111B
			JNB			P1.0,CASE0
			JNB			P1.1,CASE1
			JNB			P1.2,CASE2
			JNB			P1.3,CASE3    
			DJNZ		R1,LOOP
			ACALL		CONT
			AJMP		LOOP
			
CASE0:		MOV			A,#00111111B
			AJMP		TRANS       
			
CASE1:		MOV			A,#11001111B
			AJMP		TRANS      

CASE2:		MOV			A,#11110011B
			AJMP		TRANS      
			
CASE3:		MOV			A,#11111100B
			AJMP		TRANS
     
			
			
TRANS:		ACALL		RELEASE 
;WAIT1:		JNB			TI,WAIT1
;WAIT2:		JNB			RI,WAIT2
			AJMP		MAIN
			
			
RELEASE: 	MOV 		R1,P1
			MOV 		SBUF,A
			ACALL		CONT
			;CJNE 		R1,#01111111B,RELEASE
			RET
;MOVP1,#11111110B
;JNBP2.0,KEY0      

KEY0:       CLR			RI
			INC         R5          
            CJNE        R5,         #0,         OUT        ;           IF          R5          !=          0,          NO          OVERFLOW    
            MOV         R5,         #0          
            INC         R4          
            CJNE        R4,         #40,        OUT        
            MOV         R4,         #0          
OUT:        RET        

INIT2:      ACALL       DELAY       
            MOV         A,          #38H        
            ACALL       WRINS       
            MOV         A,          #38H        
            ACALL       WRINS       
            MOV         A,          #38H        
            ACALL       WRINS       
            MOV         A,          #38H        
            ACALL       WRINS       
            MOV         A,          #08H        
            ACALL       WRINS       
            MOV         A,          #01H        
            ACALL       WRINS       
            MOV         A,          #06H        
            ACALL       WRINS       
            MOV         A,          #0CH        
            ACALL       WRINS       
            RET        
			
CGRAM:		MOV			A,#01000000B
			ACALL		WRINS
			MOV			R4,#0;
CGRAMLOOP:	MOV			A,R4
			MOVC		A,@A+DPTR
			ACALL		WRDATA
			INC			R4
			DJNZ		R5,CGRAMLOOP
			RET
			
DISPLAY:    PUSH        07          
            MOV         R7,         #00H        
NEXT:       MOV         A,          R7          
            MOVC        A,          @A+DPTR     
            CJNE        A,          #10H,       DSP         
            POP         07          
            RET         
			
DSP:        ACALL       WRDATA      
            INC         R7          
            AJMP        NEXT        

DISPLAY2:   
            MOV         A,          R4;         HIGH        BYTE        
            MOV         B,          #100        
            DIV         AB          ;           DIVIDE      A           BY          100,        QUOTIENT(HUNDRED)IN          A,          REMAINDER   IN          B           
            MOV         A,          B           ;           REMAINDER   TO          A           
            MOV         B,          #10         
            DIV         AB          ;           DIVIDE      A           BY          10,         QUOTIENT(TENTHS)IN          A,          REMAINDER   IN          B           
            MOV         R2,         A;          STORE       HIGH        TENTHS      ON          R2          
            MOV         R3,         B;          STORE       HIGH        ONES        ON          R3          

;WEWANTTOFINDTHERESULTAFTERMULTIPLIEDBY256
            MOV         A,          R2          
            MOV         B,          #2          
            MUL         AB          
            MOV         B,          #10         
            DIV         AB          
            MOV         R0,         B;          R2*2        (RESULT'S   THOUSANDS)  

            MOV         A,          R3          
            MOV         B,          #2          
            MUL         AB          
            MOV         B,          #10         
            DIV         AB          
            MOV         R1,         B;          R3*2        
            ADD         A,          R0;         ADD         CARRY       TO          RESULT'S    THOUSANDS   
            MOV         R0,         A;          

            MOV         A,          R2          
            MOV         B,          #5          
            MUL         AB          
            MOV         B,          #10         
            DIV         AB          
            MOV         R6,         B;          R2*5        
            ADD         A,          R0;         ADD         CARRY       TO          RESULT'S    THOUSANDS   
            MOV         R0,         A;          

            MOV         A,          R1          
            ADD         A,          R6          
            MOV         B,          #10;        CHECK       CARRY       
            DIV         AB          
            MOV         R1,         B;(R3*2     +           R2*5)       RESULT'S    HUNDREDS    
            ADD         A,          R0          
            MOV         R0,         A;          ADD         CARRY       TO          RESULT'S    THOUSANDS   

            MOV         A,          R3          
            MOV         B,          #5          
            MUL         AB          
            MOV         B,          #10         
            DIV         AB          
            MOV         R6,         B;          R3*5        
            ADD         A,          R1;         ADD         CARRY       TO          RESULT'S    HUNDREDS    
            MOV         R1,         A           

            MOV         A,          R2          
            MOV         B,          #6          
            MUL         AB          
            MOV         B,          #10         
            DIV         AB          
            MOV         R7,         B;          R2*6        
            ADD         A,          R1;         ADD         CARRY       TO          RESULT'S    HUNDREDS    
            MOV         R1,         A           

            MOV         A,          R6          
            ADD         A,          R7          
            MOV         B,          #10;        CHECK       CARRY       
            DIV         AB          
            MOV         R6,         B;          (R3*5       +           R2*6)       RESULT'S    TENTHS      
            ADD         A,          R1          
            MOV         R1,         A;          ADD         CARRY       TO          RESULT'S    HUNDREDS    

            MOV         A,          R3          
            MOV         B,          #6          
            MUL         AB          
            MOV         B,          #10         
            DIV         AB          
            MOV         R7,         B;          6*R3        RESULT'S    ONES        
            ADD         A,          R6;         ADD         CARRY       TO          RESULT'S    TENTHS      
            MOV         R6,         A           


            MOV         A,          R5          ;           LOAD        LOW         BYTE        
            MOV         B,          #100        
            DIV         AB          ;           DIVIDE      A           BY          100,        QUOTIENT(HUNDREDS)IN          A,          REMAINDER   IN          B           
            PUSH        B           
            ADD         A,          R1;         ADD         HIGH        HUNDREDS    TO          LOW         HUNDREDS    
            MOV         B,          #10         
            DIV         AB;         CHECK       CARRY       
            MOV         R1,         B;          SAVE        COUNTER     HUNDREDS    

            ADD         A,          R0;         CHECK       THOUSANDS   OVEFLOW     
            MOV         B,          #10         
            DIV         AB          
            MOV         R0,         B           
            POP         B           

            MOV         A,          B           ;           REMAINDER   TO          A           
            MOV         B,          #10         
            DIV         AB          ;           DIVIDE      A           BY          10,         QUOTIENT(TENTHS)IN          A,          REMAINDER   IN          B           
            PUSH        B           
            ADD         A,          R6          
            MOV         B,          #10         
            DIV         AB;         CHECK       CARRY       
            MOV         R6,         B;          SAVE        COUNTER     TENTHS      

            ADD         A,          R1;         CHECK       HUNDRESD    OVERFLOW    
            MOV         B,          #10         
            DIV         AB          
            MOV         R1,         B           
            ADD         A,          R0          
            MOV         R0,         A           
            POP         B           

            MOV         A,          B           ;           REMAINDER   TO          A           
            ADD         A,          R7          
            MOV         B,          #10         
            DIV         AB;         CHECK       CARRY       
            MOV         R7,         B;          SAVE        COUNTER     ONES        

            ADD         A,          R6;         CHECK       TENTHSOVERFLOW
            MOV         B,          #10         
            DIV         AB          
            MOV         R6,         B           
            ADD         A,          R1;         CHECK       HUNDRESD    OVERFLOW    
            MOV         B,          #10         
            DIV         AB          
            MOV         R1,         B           
            ADD         A,          R0          
            MOV         R0,         A           

            MOV         A,          R0          
            ADD         A,          #30H        ;           CONVERT     TO          ASCII       
            ACALL       WRDATA      ;           WRITE       TO          DISPLAY     (10^3)      

            MOV         A,          R1          
            ADD         A,          #30H        ;           CONVERT     TO          ASCII       
            ACALL       WRDATA      ;           WRITE       TO          DISPLAY     (10^3)      

            MOV         A,          R6          
            ADD         A,          #30H        ;           CONVERT     TO          ASCII       
            ACALL       WRDATA      ;           WRITE       TO          DISPLAY     (10^3)      

            MOV         A,          R7          
            ADD         A,          #30H        ;           CONVERT     TO          ASCII       
            ACALL       WRDATA      ;           WRITE       TO          DISPLAY     (10^3)      

            RET         

LINE1:      MOV         A,          R1
            ACALL       WRINS       
            RET         

LINE2:      MOV         A,          R1
            ACALL       WRINS       
            RET         

WRINS:      
            MOV         P1,         #00111111B  
            NOP         
            SETB        P1.7        
            MOV         P0,         A           
            NOP         
            CLR         P1.7        
            ACALL       DLY1        
            RET         

WRDATA:     
            MOV         P1,         #01111111B  
            NOP         
            SETB        P1.7        
            MOV         P0,         A           
            NOP         
            CLR         P1.7        
            ACALL       DLY2        
            RET         

DELAY:      
            PUSH        07          
            MOV         R6,         #100        
DL:         MOV         R7,         #200        
            DJNZ        R7,         $           
            DJNZ        R6,         DL          
            POP         07          
            RET         

DLY1:       
            PUSH        07          
            PUSH        06          
            MOV         R6,         #20         
DL1:        MOV         R7,         #200        
            DJNZ        R7,         $           
            DJNZ        R6,         DL1         
            POP         06          
            POP         07          
            RET         

DLY2:       
            PUSH        06          
            MOV         R6,         #80         
            DJNZ        R6,         $           
            POP         06          
            RET                

;==================================================
;				CUSTOM-TEXT
;==================================================
			
STARTUP:	DB		00000001B
			DB		00001111B
			DB		00000010B
			DB		00011111B
			DB		00000100B
			DB		00000111B
			DB		00000100B
			DB		00000111B
			
			DB		00000000B
			DB		00011100B
			DB		00001000B
			DB		00011111B
			DB		00000100B
			DB		00010100B
			DB		00000100B
			DB		00011100B
				
			DB		00000010B
			DB		00000001B
			DB		00000010B
			DB		00000001B
			DB		00000000B
			DB		00000001B
			DB		00000001B
			DB		00000110B
			
			DB		00000100B
			DB		00011111B
			DB		00001000B
			DB		00001111B
			DB		00001001B
			DB		00001001B
			DB		00010001B
			DB		00010010B
				
			DB		00001000B
			DB		00001110B
			DB		00010000B
			DB		00001100B
			DB		00000010B
			DB		00001111B
			DB		00000010B
			DB		00001100B
				
			DB		00000000B
			DB		00000000B
			DB		00000000B
			DB		00000000B
			DB		00000000B
			DB		00000000B
			DB		00000000B
			DB		00000000B			

WHITE:		DB			11111110B
			DB			10H
			
STAB1:		DB			11111111B
			DB			10H

;==================================================
;				TEXT-TABLES
;==================================================
TAB0:       DB          'SCORE:     '           
            DB          10H  
				
TAB1:		DB			'MCS5'
			DB			'1-'
			DB			10H
				
TAB2:		DB			00H
			DB			01H
			DB			02H
			DB			03H
			DB			04H
			DB			05H
			DB			10H
				
TAB3:		DB			'    '				DB			'<ST'
			DB			'ART>'
			DB			10H

TAB4:		DB			'    '				
			DB			'    '
	-TABLES		DB			'    '
			DB			10H
;==================================================
;				STARTUP-DELAY
;==================================================
IDELAY:      MOV        B,R6          
IDL:         MOV        R7,#200        
			 DJNZ       R7,$           
             DJNZ       R6,IDL          
             MOV        R6,B           
             RET    
			
IDELAY2:	MOV			R6,#80
			DJNZ		R6,$
			RET
;==================================================
;				PLAYER
;==================================================        
CONT:      	CLR         A           
            MOVC        A,          @A+DPTR     
            CJNE        A,          #40,        CHK         
            AJMP		START       
CHK:        CJNE        A,          #255,       OK          
STOP:       AJMP        STOP        
OK:         PUSH        ACC         
            INC         DPTR        
            CLR         A           
            MOVC        A,          @A+DPTR     
            MOV         R2,         A           
            POP         ACC
			
CHK1:       CJNE        A,          #1,         CHK2        
            ACALL       B6          
CHK2:       CJNE        A,          #2,         CHK3        
            ACALL       AS6         
CHK3:       CJNE        A,          #3,         CHK4        
            ACALL       A6          
CHK4:       CJNE        A,          #4,         CHK5        
            ACALL       GS6         
CHK5:       CJNE        A,          #5,         CHK6        
            ACALL       G6          
CHK6:       CJNE        A,          #6,         CHK7        
            ACALL       FS6         
CHK7:       CJNE        A,          #7,         CHK8        
            ACALL       F6          
CHK8:       CJNE        A,          #8,         CHK9        
            ACALL       E6          
CHK9:       CJNE        A,          #9,         CHK10       
            ACALL       DS6         
CHK10:      CJNE        A,          #10,        CHK11       
            ACALL       D6          
CHK11:      CJNE        A,          #11,        CHK12       
            ACALL       CS6         
CHK12:      CJNE        A,          #12,        CHK13       
            ACALL       C6          
CHK13:      CJNE        A,          #13,        CHK14       
            ACALL       B5          
CHK14:      CJNE        A,          #14,        CHK15       
            ACALL       AS5         
CHK15:      CJNE        A,          #15,        CHK16       
            ACALL       A5          
CHK16:      CJNE        A,          #16,        CHK17       
            ACALL       GS5         
CHK17:      CJNE        A,          #17,        CHK18       
            ACALL       G5          
CHK18:      CJNE        A,          #18,        CHK19       
            ACALL       FS5         
CHK19:      CJNE        A,          #19,        CHK20       
            ACALL       F5          
CHK20:      CJNE        A,          #20,        CHK21       
            ACALL       E5          
CHK21:      CJNE        A,          #21,        CHK22       
            ACALL       DS5         
CHK22:      CJNE        A,          #22,        CHK23       
            ACALL       D5          
CHK23:      CJNE        A,          #23,        CHK24       
            ACALL       CS5         
CHK24:      CJNE        A,          #24,        CHK25       
            ACALL       C5          
CHK25:      CJNE        A,          #25,        CHK26       
            ACALL       B4          
CHK26:      CJNE        A,          #26,        CHK27       
            ACALL       AS4         
CHK27:      CJNE        A,          #27,        CHK28       
            ACALL       A4          
CHK28:      CJNE        A,          #28,        CHK29       
            ACALL       GS4         
CHK29:      CJNE        A,          #29,        CHK30       
            ACALL       G4          
CHK30:      CJNE        A,          #30,        CHK31       
            ACALL       FS4         
CHK31:      CJNE        A,          #31,        CHK32       
            ACALL       F4          
CHK32:      CJNE        A,          #32,        CHK33       
            ACALL       E4          
CHK33:      CJNE        A,          #33,        CHK34       
            ACALL       DS4         
CHK34:      CJNE        A,          #34,        CHK35       
            ACALL       D4          
CHK35:      CJNE        A,          #35,        CHK36       
            ACALL       CS4         
CHK36:      CJNE        A,          #36,        CHK37       
            ACALL       C4          
CHK37:      CJNE        A,          #37,        CHK38       
            ACALL       B3          
CHK38:      CJNE        A,          #38,        CHK39       
            ACALL       AS3         
CHK39:      CJNE        A,          #39,        CHK40       
            ACALL       A3          
CHK40:      CJNE        A,          #40,        CHK41       
            ACALL       GS3         
CHK41:      CJNE        A,          #41,        CHK42       
            ACALL       G3          
CHK42:      CJNE        A,          #42,        CHK43       
            ACALL       FS3         
CHK43:      CJNE        A,          #43,        CHK44       
            ACALL       F3          
CHK44:      CJNE        A,          #44,        CHK45       
            ACALL       E3          
CHK45:      CJNE        A,          #45,        CHK46       
            ACALL       DS3         
CHK46:      CJNE        A,          #46,        CHK47       
            ACALL       D3          
CHK47:      CJNE        A,          #47,        CHK48       
            ACALL       CS3         
CHK48:      CJNE        A,          #48,        CHK0        
            ACALL       C3          
CHK0:       CJNE        A,          #00,        CONT2       
            ACALL       NON         
CONT2:      INC         DPTR 
            RET   
			
B6:         MOV         R6,         #16         
            MOV         R3,         #247        
            AJMP        OUTPUT      
AS6:        MOV         R6,         #17         
            MOV         R3,         #233        
            AJMP        OUTPUT      
A6:         MOV         R6,         #18         
            MOV         R3,         #220        
            AJMP        OUTPUT      
GS6:        MOV         R6,         #19         
            MOV         R3,         #208        
            AJMP        OUTPUT      
G6:         MOV         R6,         #21         
            MOV         R3,         #196        
            AJMP        OUTPUT      
FS6:        MOV         R6,         #22         
            MOV         R3,         #185        
            AJMP        OUTPUT      
F6:         MOV         R6,         #23         
            MOV         R3,         #175        
            AJMP        OUTPUT      
E6:         MOV         R6,         #25         
            MOV         R3,         #165        
            AJMP        OUTPUT      
DS6:        MOV         R6,         #26         
            MOV         R3,         #156        
            AJMP        OUTPUT      
D6:         MOV         R6,         #28         
            MOV         R3,         #147        
            AJMP        OUTPUT      
CS6:        MOV         R6,         #29         
            MOV         R3,         #139        
            AJMP        OUTPUT      
C6:         MOV         R6,         #31         
            MOV         R3,         #131        
            AJMP        OUTPUT      
B5:         MOV         R6,         #33         
            MOV         R3,         #124        
            AJMP        OUTPUT      
AS5:        MOV         R6,         #35         
            MOV         R3,         #116        
            AJMP        OUTPUT      
A5:         MOV         R6,         #37         
            MOV         R3,         #110        
            AJMP        OUTPUT      
GS5:        MOV         R6,         #40         
            MOV         R3,         #104        
            AJMP        OUTPUT      
G5:         MOV         R6,         #42         
            MOV         R3,         #98         
            AJMP        OUTPUT      
FS5:        MOV         R6,         #44         
            MOV         R3,         #92         
            AJMP        OUTPUT      
F5:         MOV         R6,         #47         
            MOV         R3,         #87         
            AJMP        OUTPUT      
E5:         MOV         R6,         #50         
            MOV         R3,         #82         
            AJMP        OUTPUT      
DS5:        MOV         R6,         #53         
            MOV         R3,         #78         
            AJMP        OUTPUT      
D5:         MOV         R6,         #56         
            MOV         R3,         #73         
            AJMP        OUTPUT      
CS5:        MOV         R6,         #60         
            MOV         R3,         #69         
            AJMP        OUTPUT      
C5:         MOV         R6,         #63         
            MOV         R3,         #65         
            AJMP        OUTPUT      
B4:         MOV         R6,         #67         
            MOV         R3,         #62         
            AJMP        OUTPUT      
AS4:        MOV         R6,         #71         
            MOV         R3,         #58         
            AJMP        OUTPUT      
A4:         MOV         R6,         #75         
            MOV         R3,         #55         
            AJMP        OUTPUT      
GS4:        MOV         R6,         #80         
            MOV         R3,         #52         
            AJMP        OUTPUT      
G4:         MOV         R6,         #84         
            MOV         R3,         #49         
            AJMP        OUTPUT      
FS4:        MOV         R6,         #89         
            MOV         R3,         #46         
            AJMP        OUTPUT      
F4:         MOV         R6,         #95         
            MOV         R3,         #44         
            AJMP        OUTPUT      
E4:         MOV         R6,         #100        
            MOV         R3,         #41         
            AJMP        OUTPUT      
DS4:        MOV         R6,         #107        
            MOV         R3,         #39         
            AJMP        OUTPUT      
D4:         MOV         R6,         #113        
            MOV         R3,         #37         
            AJMP        OUTPUT      
CS4:        MOV         R6,         #120        
            MOV         R3,         #35         
            AJMP        OUTPUT      
C4:         MOV         R6,         #127        
            MOV         R3,         #33         
            AJMP        OUTPUT      
B3:         MOV         R6,         #134        
            MOV         R3,         #31         
            AJMP        OUTPUT      
AS3:        MOV         R6,         #142        
            MOV         R3,         #29         
            AJMP        OUTPUT      
A3:         MOV         R6,         #151        
            MOV         R3,         #28         
            AJMP        OUTPUT      
GS3:        MOV         R6,         #160        
            MOV         R3,         #26         
            AJMP        OUTPUT      
G3:         MOV         R6,         #169        
            MOV         R3,         #24         
            AJMP        OUTPUT      
FS3:        MOV         R6,         #180        
            MOV         R3,         #23         
            AJMP        OUTPUT      
F3:         MOV         R6,         #190        
            MOV         R3,         #22         
            AJMP        OUTPUT      
E3:         MOV         R6,         #201        
            MOV         R3,         #21         
            AJMP        OUTPUT      
DS3:        MOV         R6,         #213        
            MOV         R3,         #20         
            AJMP        OUTPUT      
D3:         MOV         R6,         #226        
            MOV         R3,         #18         
            AJMP        OUTPUT      
CS3:        MOV         R6,         #239        
            MOV         R3,         #17         
            AJMP        OUTPUT      
C3:         MOV         R6,         #254        
            MOV         R3,         #16         
            AJMP        OUTPUT      

NON:        MOV         R6,         #33         
            MOV         R3,         #124        
            AJMP        OUTPUT      

OUTPUT:     PUSH        03          
PLOOP:      CJNE        A,          #00,        SOUND       
            AJMP        MUTE        
SOUND:      CLR         P2.6        
MUTE:       ACALL       PDELAY       
            SETB        P2.6        
            ACALL       PDELAY       
            DJNZ        R3,         PLOOP        
            POP         03          
            DJNZ        R2,         OUTPUT      

REST:       MOV         R6,         #170        
            MOV         R3,         #20         

WAIT:       ACALL       PPDELAY       
            DJNZ        R3,         WAIT        
            RET         

PDELAY:      MOV         B,          R6          
PDL:         MOV         R7,         #6          
            DJNZ        R7,         $           
            DJNZ        R6,         PDL          
            MOV         R6,         B           
            RET     

PPDELAY:     MOV         B,          R6          
PPDL:        MOV         R7,         #6          
            DJNZ        R7,         $    
			JNB			RI,COT
			MOV			A,SBUF
			CJNE		A,#11111110B,COT 
			ACALL		KEY0
COT:        DJNZ        R6,         PPDL          
            MOV         R6,         B 			
            RET   
;==================================================
;				ALBUM-MUSIC
;==================================================
MUSIC:      DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          18,         1,          0,          1,          21,         1,          18,         1           
            DB          16,         1,          0,          1,          18,         1,          16,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          16,         1,          0,          1,          18,         1,          16,         1           
            DB          18,         1,          0,          1,          21,         1,          18,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          18,         1,          0,          1,          21,         1,          18,         1           
            DB          16,         1,          0,          1,          18,         1,          16,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          33,         1,          0,          1,          33,         1,          21,         1           
            DB          0,          1,          21,         1,          23,         1,          21,         1           
            DB          16,         1,          0,          1,          0,          1,          0,          1           
            DB          18,         1,          0,          1,          0,          1,          0,          1           
            DB          21,         1,          19,         1,          18,         1,          16,         1           
            DB          14,         1,          0,          1,          9,          1,          11,         1           
            DB          14,         1,          0,          1,          21,         1,          0,          1           
            DB          14,         1,          16,         1,          18,         1,          19,         1           
            DB          21,         1,          19,         1,          18,         1,          16,         1           
            DB          14,         1,          0,          1,          16,         1,          18,         1           
            DB          19,         1,          21,         1,          19,         1,          18,         1           
            DB          19,         1,          21,         1,          22,         1,          19,         1           
            DB          21,         1,          19,         1,          18,         1,          16,         1           
            DB          14,         1,          0,          1,          9,          1,          11,         1           
            DB          14,         1,          0,          1,          21,         1,          0,          1           
            DB          14,         1,          16,         1,          18,         1,          19,         1           
            DB          21,         1,          19,         1,          18,         1,          16,         1           
            DB          14,         1,          0,          1,          16,         1,          18,         1           
            DB          19,         1,          0,          1,          18,         1,          0,          1           
            DB          16,         1,          0,          1,          14,         1,          0,          1           
            DB          21,         1,          19,         1,          18,         1,          16,         1           
            DB          14,         1,          0,          1,          9,          1,          11,         1           
            DB          14,         1,          0,          1,          21,         1,          0,          1           
            DB          14,         1,          16,         1,          18,         1,          19,         1           
            DB          21,         1,          19,         1,          18,         1,          16,         1           
            DB          14,         1,          0,          1,          16,         1,          18,         1           
            DB          19,         1,          21,         1,          19,         1,          18,         1           
            DB          19,         1,          21,         1,          22,         1,          19,         1           
            DB          21,         1,          19,         1,          18,         1,          16,         1           
            DB          14,         1,          0,          1,          9,          1,          11,         1           
            DB          14,         1,          0,          1,          21,         1,          0,          1           
            DB          14,         1,          16,         1,          18,         1,          19,         1           
            DB          21,         1,          19,         1,          18,         1,          16,         1           
            DB          14,         1,          0,          1,          16,         1,          18,         1           
            DB          19,         1,          0,          1,          18,         1,          0,          1           
            DB          16,         1,          0,          1,          14,         1,          0,          1           
            DB          11,         1,          9,          1,          14,         1,          16,         1           
            DB          14,         1,          0,          1,          16,         1,          14,         1           
            DB          11,         1,          9,          1,          14,         1,          16,         1           
            DB          14,         1,          0,          1,          16,         1,          14,         1           
            DB          16,         1,          18,         1,          19,         1,          23,         1           
            DB          21,         1,          0,          1,          23,         1,          21,         1           
            DB          19,         1,          18,         1,          16,         1,          14,         1           
            DB          21,         1,          0,          1,          14,         1,          11,         1           
            DB          11,         1,          9,          1,          14,         1,          16,         1           
            DB          14,         1,          0,          1,          16,         1,          14,         1           
            DB          11,         1,          9,          1,          14,         1,          16,         1           
            DB          14,         1,          0,          1,          16,         1,          14,         1           
            DB          16,         1,          18,         1,          19,         1,          23,         1           
            DB          21,         1,          0,          1,          23,         1,          21,         1           
            DB          19,         1,          18,         1,          16,         1,          14,         1           
            DB          21,         1,          0,          1,          14,         1,          11,         1           
            DB          11,         1,          9,          1,          14,         1,          16,         1           
            DB          14,         1,          0,          1,          16,         1,          14,         1           
			DB          40 
				
			END       
