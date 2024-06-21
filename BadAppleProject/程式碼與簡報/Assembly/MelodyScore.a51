;==================================================
; INITIALIZATION
;==================================================
            ORG          0000H
            MOV			 TMOD,#00100000B
            MOV			 TH1,#232
            MOV			 TL1,#232
            SETB		 TR1
            MOV			 SCON,#01110000B
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
; MAIN
;==================================================
MAIN:       
            MOV           R0,#0 ;Score High Byte
            MOV           R3,#0 ;Score Low Byte

            MOV          R1, #10000000B 
            ACALL        SETCURSOR
            MOV          DPTR, #TAB3 ; Waiting signal
            ACALL        DISPLAY
            ACALL        IDELAY
            MOV          R1, #10000000B 
            ACALL        SETCURSOR
            MOV          DPTR, #TAB4 ; (Blank)
            ACALL        DISPLAY
            MOV          R1, #11000000B 
            ACALL        SETCURSOR
            MOV          DPTR, #TAB4 
            ACALL        DISPLAY
            ACALL        IDELAY

            MOV          DPTR, #MUSIC
            CLR          RI 
            MOV          A,SBUF
            CJNE         A,#39,MAIN
            CLR         RI
CONT:       
            PUSH         DPL
            PUSH         DPH
            MOV          R1, #10000000B 
            ACALL        SETCURSOR
            MOV          DPTR, #TAB2
            ACALL        DISPLAY
            MOV 		     R1,#11000000B
            ACALL        SETCURSOR
            ACALL        DISPLAYSCR
            POP          DPH
            POP          DPL
            JNB			    RI,CONT3
            CLR         RI
            MOV			    A,SBUF
            CJNE		    A,#11111110B,CONTCHK
            MOV         R4,#10
            AJMP        SCOREINC
CONTCHK:    CJNE		    A,#11111101B,CONT3
;            MOV         R4,#1
;            AJMP        SCOREINC
CONT3:
            CLR          A
            MOVC         A, @A+DPTR
            CJNE         A, #69, CHK
            AJMP         ENDSCR
CHK:        CJNE         A, #255, OK
STOP:       AJMP         STOP
OK:         AJMP         CHK1 

;==================================================
; DISPLAY SCORE
;==================================================
DISPLAYSCR:   
            ; Load the High and Low byte to R4 and R5
            MOV         A,R0
            MOV         R4,A
            MOV         A,R3
            MOV         R5,A

            MOV         A,          R4 
            MOV         B,          #100    
            DIV         AB                  ; High/100, A = High的百 ，B = High的十  
            MOV         A,          B       ; A = High的十
            MOV         B,          #10     
            DIV         AB                  ; A/10
            MOV         R2,         A       ; R2 = A1 (PPT的)
            MOV         R3,         B       ; R3 = A0 (PPT的)

            MOV         A,          R2          
            MOV         B,          #2          
            MUL         AB                  ; 2*A1 
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9)
            MOV         R0,         B       ; R0 = 2*A1 = 千(還沒加B)

            MOV         A,          R3       
            MOV         B,          #2          
            MUL         AB                  ; 2*A0
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9) 
            MOV         R1,         B
            ADD         A,          R0     
            MOV         R0,         A;      ; Carry Over

            MOV         A,          R2          
            MOV         B,          #5          
            MUL         AB                  ; 5*A1
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9)
            MOV         R6,         B
            ADD         A,          R0      
            MOV         R0,         A;      ; Carry Over    

            MOV         A,          R1          
            ADD         A,          R6      ; 2*A0 + 5*A1
            MOV         B,          #10
            DIV         AB                  ; Handle Overflow (>9) 
            MOV         R1,         B       ; R1 = 2*A0 + 5*A1 = 百(還沒加B)
            ADD         A,          R0           
            MOV         R0,         A       ; Carry Over

            MOV         A,          R3          
            MOV         B,          #5          
            MUL         AB                  ; 5 * A0
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9)
            MOV         R6,         B
            ADD         A,          R1
            MOV         R1,         A       ; Carry Over    

            MOV         A,          R2          
            MOV         B,          #6          
            MUL         AB                  ; 6 * A1
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9)  
            MOV         R7,         B
            ADD         A,          R1
            MOV         R1,         A       ; Carry Over    

            MOV         A,          R6          
            ADD         A,          R7      ; 5*A0 + 6*A1    
            MOV         B,          #10
            DIV         AB                  ; Handle Overflow (>9) 
            MOV         R6,         B       ; R6 = 5*A0 + 6*A1 = 十 (還沒加B)
            ADD         A,          R1          
            MOV         R1,         A       ; Carry Over

            MOV         A,          R3          
            MOV         B,          #6          
            MUL         AB                  ; 6 * A0
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9)
            MOV         R7,         B
            ADD         A,          R6
            MOV         R6,         A       ; Carry Over    


            MOV         A,          R5
            MOV         B,          #100        
            DIV         AB                  ; Low/100, A = Low的百 ，B = Low的十  
            PUSH        B                   
            ADD         A,          R1      ; R1 + B = 千
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9)
            MOV         R1,         B       

            ADD         A,          R0      ; Carry Over 
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9)
            MOV         R0,         B           
            POP         B           

            MOV         A,          B       
            MOV         B,          #10         
            DIV         AB                  ; Low的百/100, A = Low的十, B = Low的個
            PUSH        B           
            ADD         A,          R6      ; R6 + B(PPT的) = 百
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9)
            MOV         R6,         B

            ADD         A,          R1      ; Carry Over
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9)
            MOV         R1,         B           
            ADD         A,          R0      ; Carry Over    
            MOV         R0,         A           
            POP         B           

            MOV         A,          B       ; A = Low的個
            ADD         A,          R7      ; R7 + B = 十    
            MOV         B,          #10        
            DIV         AB                  ; Handle Overflow (>9) 
            MOV         R7,         B       

            ADD         A,          R6      ; Carry Over
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9) 
            MOV         R6,         B           
            ADD         A,          R1      ; Carry Over
            MOV         B,          #10         
            DIV         AB                  ; Handle Overflow (>9) 
            MOV         R1,         B           
            ADD         A,          R0      ; Carry Over      
            MOV         R0,         A           

            ;CONVERT TO ASCII
            MOV         A,          R0         
            ADD         A,          #30H 
            ACALL       WRDATA 

            MOV         A,          R1          
            ADD         A,          #30H
            ACALL       WRDATA      

            MOV         A,          R6          
            ADD         A,          #30H        
            ACALL       WRDATA      

            MOV         A,          R7          
            ADD         A,          #30H        
            ACALL       WRDATA     

            ;RESTORE TO R0 R3
            MOV         A,R4
            MOV         R0,A
            MOV         A,R5
            MOV         R3,A
            
            RET         

;==================================================
; CHECK NOTE
CHK1:       CJNE        A,          #1,         CHK6        
            ACALL       B6          
CHK6:       CJNE        A,          #6,         CHK7
            ACALL       FS6
CHK7:       CJNE        A,          #7,         CHK9        
            ACALL       F6          
CHK9:       CJNE        A, #9,CHK11
            ACALL       DS6
CHK11:      CJNE        A,          #11,        CHK14       
            ACALL       CS6         
CHK14:      CJNE        A,          #14,        CHK16
            ACALL       AS5         
CHK16:      CJNE        A,          #16,        CHK18       
            ACALL       GS5         
CHK18:      CJNE        A,          #18,        CHK19       
            ACALL       FS5         
CHK19:      CJNE        A,          #19,        CHK21       
            ACALL       F5          
CHK21:      CJNE        A,          #21,        CHK22       
            ACALL       DS5         
CHK22:      CJNE        A,          #22,        CHK23       
            ACALL       D5          
CHK23:      CJNE        A,          #23,        CHK33       
            ACALL       CS5         
CHK33:      CJNE        A,          #33,        CHK0
            ACALL       DS4         
CHK0:       CJNE        A,          #00,        CONT2       
            ACALL       NON         
CONT2:      INC          DPTR
            AJMP         CONT

;==================================================
; NOTE FREQUENCIES
;==================================================
B6:         MOV         R6,         #16         
            MOV         R5,         #247        
            AJMP        OUTPUT      
FS6:        MOV          R6, #22
            MOV          R5, #185
            AJMP         OUTPUT
F6:         MOV          R6, #23
            MOV          R5, #175
            AJMP         OUTPUT
DS6:        MOV         R6,         #26         
            MOV         R5,         #156        
            AJMP        OUTPUT      
CS6:        MOV         R6,         #29         
            MOV         R5,         #139        
            AJMP        OUTPUT      
AS5:        MOV         R6,         #35         
            MOV         R5,         #116        
            AJMP        OUTPUT      
GS5:        MOV         R6,         #40         
            MOV         R5,         #104        
            AJMP        OUTPUT      
FS5:        MOV         R6,         #44         
            MOV         R5,         #92         
            AJMP        OUTPUT      
F5:         MOV         R6,         #47         
            MOV         R5,         #87         
            AJMP        OUTPUT      
DS5:        MOV         R6,         #53         
            MOV         R5,         #78         
            AJMP        OUTPUT      
D5:         MOV         R6,         #56         
            MOV         R5,         #73         
            AJMP        OUTPUT      
CS5:        MOV         R6,         #60         
            MOV         R5,         #69         
            AJMP        OUTPUT      
DS4:        MOV         R6,         #107        
            MOV         R5,         #39         
            AJMP        OUTPUT      
GS3:        MOV         R6,         #160        
            MOV         R5,         #26         
            AJMP        OUTPUT      
NON:        MOV         R6,         #33         
            MOV         R5,         #124        
            AJMP        OUTPUT      

;==================================================
; SING
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
REST:       MOV          R6, #103
            MOV          R5, #20
WAIT:       ACALL        DELAY
            DJNZ         R5, WAIT
            RET

;==================================================
; ADDITIONAL FUNCTIONS
;==================================================
DELAY:      MOV          B, R6
DL:         MOV          R7, #6
            DJNZ         R7, $
            DJNZ         R6, DL
            MOV          R6, B
            RET         

SCOREINC:       
            INC         R3          
            CJNE        R3,         #0,         OUT        
            MOV         R3,         #0          
            INC         R0          
            CJNE        R0,         #40,        OUT        
            MOV         R0,         #0          
OUT:        DJNZ        R4,SCOREINC
            AJMP        CONT3

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

IDELAY:     MOV          R6, #255
IDL:        MOV          R7, #200
            DJNZ         R7, $
            DJNZ         R6, IDL
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
; END SCREEN 
;==================================================
ENDSCR:    
            MOV          R1, #10000000B
            ACALL        SETCURSOR
            MOV          DPTR, #TAB7
            ACALL        DISPLAY
            JNB          RI,$
            CLR          RI
            AJMP         MAIN

;==================================================
;TEXT-TABLES
;==================================================
TAB2:       DB          'SCORE'
            DB          '     '
            DB          '     '
            DB          ' '
            DB          10H

TAB3:		
            DB		     	'Waiti'				
            DB		     	'ng Si'
			      DB		     	'gnal'  
      			DB		     	10H

TAB4:   		
            DB		     	'     '				
            DB		     	'     '
			      DB		     	'    '  
			      DB		    	10H

TAB7:       DB          'YOUR '
            DB          'FINAL'
            DB          ' SCOR'
            DB          'E'
            DB          10H
;==================================================
; MUSIC
;==================================================
MUSIC:      
            DB 0,0,0,0
            DB 33,0,33,21
            DB 0,21,23,21
            DB 33,0,33,21
            DB 0,21,23,21
            DB 33,0,33,21
            DB 0,21,23,21
            DB 18,0,21,18
            DB 16,0,18,16
            DB 33,0,33,21
            DB 0,21,23,21
            DB 33,0,33,21
            DB 0,21,23,21
            DB 33,0,33,21
            DB 0,21,23,21
            DB 16,0,18,16
            DB 18,0,21,18
            DB 33,0,33,21
            DB 0,21,23,21
            DB 33,0,33,21
            DB 0,21,23,21
            DB 33,0,33,21
            DB 0,21,23,21
            DB 18,0,21,18
            DB 16,0,18,16
            DB 33,0,33,21
            DB 0,21,23,21
            DB 33,0,33,21
            DB 0,21,23,21
            DB 33,0,33,21
            DB 0,21,23,21
            DB 16,0,0,0
            DB 18,0,0,0
            DB 21,19,18,16
            DB 14,0,9,11
            DB 14,0,21,0
            DB 14,16,18,19
            DB 21,19,18,16
            DB 14,0,16,18
            DB 19,21,19,18
            DB 19,21,22,19
            DB 21,19,18,16
            DB 14,0,9,11
            DB 14,0,21,0
            DB 14,16,18,19
            DB 21,19,18,16
            DB 14,0,16,18
            DB 19,0,18,0
            DB 16,0,14,0
            DB 21,19,18,16
            DB 14,0,9,11
            DB 14,0,21,0
            DB 14,16,18,19
            DB 21,19,18,16
            DB 14,0,16,18
            DB 19,21,19,18
            DB 19,21,22,19
            DB 21,19,18,16
            DB 14,0,9,11
            DB 14,0,21,0
            DB 14,16,18,19
            DB 21,19,18,16
            DB 14,0,16,18
            DB 19,0,18,0
            DB 16,0,14,0
            DB 11,9,14,16
            DB 14,0,16,14
            DB 11,9,14,16
            DB 14,0,16,14
            DB 16,18,19,23
            DB 21,0,23,21
            DB 19,18,16,14
            DB 21,0,14,11
            DB 11,9,14,16
            DB 14,0,16,14
            DB 11,9,14,16
            DB 14,0,16,14
            DB 16,18,19,23
            DB 21,0,23,21
            DB 19,18,16,14
            DB 21,0,14,11
            DB 11,9,14,16
            DB 14,0,16,14
            DB 11,9,14,16
            DB 14,0,16,14
            DB 16,18,19,23
            DB 21,0,23,21
            DB 19,18,16,14
            DB 21,0,14,11
            DB 11,9,14,16
            DB 14,0,16,14
            DB 11,9,14,16
            DB 14,0,9,7
            DB 6,7,9,11
            DB 14,0,16,14
            DB 16,18,19,23
            DB 21,0,0,0
            DB 11,0,0,0
            DB 0,0,0,0
            DB 11,0,0,0
            DB 0,0,0,0
            DB 16,0,0,23
            DB 21,0,23,21
            DB 19,0,0,0
            DB 21,0,0,0
            DB 11,0,0,0
            DB 0,0,0,0
            DB 11,0,0,0
            DB 0,0,0,0
            DB 16,0,0,23
            DB 21,0,23,21
            DB 0,0,0,0
            DB 21,0,0,0
            DB 11,9,14,16
            DB 14,0,16,0
            DB 11,9,14,16
            DB 14,0,16,0
            DB 16,18,19,23
            DB 21,0,23,0
            DB 19,18,16,14
            DB 21,0,14,0
            DB 11,9,14,16
            DB 14,0,16,0
            DB 11,9,14,16
            DB 14,0,9,0
            DB 6,7,9,11
            DB 14,0,16,0
            DB 0,0,0,0
            DB 21,0,0,0
            DB 0, 69

            END         
