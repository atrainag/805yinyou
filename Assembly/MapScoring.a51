            ORG          0000H
            MOV          R4, #0 ; SCORE HIGH BYTE
            MOV          R5, #0 ; SCORE LOW BYTE

            MOV          R0, #0FFH ; JUDGE ON LINE 5
            MOV          R1, #0FFH ; JUDGE ON LINE 6
            MOV          R2, #0FFH ; JUDGE ON LINE 7
MAIN:       
            MOV          DPTR, #TABLE
            MOV          R3, #32

LOOP:       
            PUSH         DPH
            PUSH         DPL
            ACALL        INIT2
            ACALL        LINE1
            MOV          DPTR, #TAB1
            ACALL        DISPLAY
            ACALL        LINE2
            ACALL        DISPLAY2
            POP          DPL
            POP          DPH
            MOV          R6, #9
SCAN:       ACALL        SCAN1
            DJNZ         R6, SCAN
            INC          DPTR
            MOV          P1, #11111110B
            JNB          P2.0, KEY0
            JNB          P2.1, KEY0
            JNB          P2.2, KEY0
            JNB          P2.3, KEY0
            MOV          P1, #11111101B
            JNB          P2.0, KEY1
            JNB          P2.1, KEY1
            JNB          P2.2, KEY1
            JNB          P2.3, KEY1
            MOV          P1, #11111011B
            JNB          P2.0, KEY2
            JNB          P2.1, KEY2
            JNB          P2.2, KEY2
            JNB          P2.3, KEY2
            MOV          P1, #11110111B
            JNB          P2.0, KEY3
            JNB          P2.1, KEY3
            JNB          P2.2, KEY3
            JNB          P2.3, KEY3
NEXTNOTE:   DJNZ         R3, LOOP
OK:         AJMP         OK
            AJMP         MAIN

KEY0:       
;ACALLDEBOUNCE;DEBOUNCETHEKEYPRESS
            MOV          R6, #00000011B
            AJMP         JUDGE
KEY1:       
;ACALLDEBOUNCE;DEBOUNCETHEKEYPRESS
            MOV          R6, #00001100B
            AJMP         JUDGE
KEY2:       
;ACALLDEBOUNCE;DEBOUNCETHEKEYPRESS
            MOV          R6, #00110000B
            AJMP         JUDGE
KEY3:       
;ACALLDEBOUNCE;DEBOUNCETHEKEYPRESS
            MOV          R6, #11000000B
            AJMP         JUDGE

JUDGE:      
            MOV          A, R0
            ANL          A, R6
            JZ           GSCORE
            MOV          A, R1
            ANL          A, R6
            JZ           PSCORE
            MOV          A, R2
            ANL          A, R6
            JZ           GSCORE
            AJMP         MISS
PSCORE:     
            PUSH         06
            MOV          R6, #10
            AJMP         SCOREADD

GSCORE:     
            PUSH         06
            MOV          R6, #5
            AJMP         SCOREADD

SCOREADD:   INC          R5
            CJNE         R5, #0, CONTADD; IF R5 != 0, NO OVERFLOW
            MOV          R5, #0
            INC          R4
            CJNE         R4, #40, CONTADD
            MOV          R4, #0
CONTADD:    DJNZ         R6, SCOREADD
            POP          06
            AJMP         NEXTNOTE

MISS:       
            AJMP         NEXTNOTE

JMPNEXT:    AJMP         NEXTNOTE
SCAN1:      
            PUSH         06
            PUSH         05
            PUSH         04
            PUSH         03
            MOV          R3, #00H
            MOV          R5, #11111110B
            MOV          R4, #08
LOOP1:      MOV          A, R3
            MOVC         A, @A+DPTR
            MOV          P0, A
            CJNE         R4, #3, CHKL6
            AJMP         INSERTL5
CHKL6:      CJNE         R4, #2, CHKL7
            AJMP         INSERTL6
CHKL7:      CJNE         R4, #1, RETURNSCAN
            AJMP         INSERTL7
RETURNSCAN: MOV          P1, R5
            MOV          R6, #3
DL11:       MOV          R7, #200
DL2:        DJNZ         R7, DL2
            DJNZ         R6, DL11
            ORL          P0, #00000000B
            MOV          A, R5
            RL           A
            MOV          R5, A
            INC          R3
            DJNZ         R4, LOOP1
            POP          03
            POP          04
            POP          05
            POP          06
            RET         

INSERTL5:   MOV          R0, A
            AJMP         RETURNSCAN
INSERTL6:   MOV          R1, A
            AJMP         RETURNSCAN
INSERTL7:   MOV          R2, A
            AJMP         RETURNSCAN


INIT2:      ACALL        DELAY
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
            RET         

DISPLAY:    
            PUSH         07
            MOV          R7, #00H
NEXT:       MOV          A, R7
            MOVC         A, @A+DPTR
            CJNE         A, #10H, DSP
            POP          07
            RET         


DSP:        
            ACALL        WRDATA
            INC          R7
            AJMP         NEXT

DISPLAY2:   
            PUSH         00
            PUSH         01
            PUSH         02
            PUSH         03
            MOV          A, R4; HIGH BYTE
            MOV          B, #100
            DIV          AB ; DIVIDE A BY 100, QUOTIENT(HUNDRED)IN A, REMAINDER IN B
            MOV          A, B ; REMAINDER TO A
            MOV          B, #10
            DIV          AB ; DIVIDE A BY 10, QUOTIENT(TENTHS)IN A, REMAINDER IN B
            MOV          R2, A; STORE HIGH TENTHS ON R2
            MOV          R3, B; STORE HIGH ONES ON R3

;WEWANTTOFINDTHERESULTAFTERMULTIPLIEDBY256
            MOV          A, R2
            MOV          B, #2
            MUL          AB
            MOV          B, #10
            DIV          AB
            MOV          R0, B; R2*2 (RESULT'S THOUSANDS)

            MOV          A, R3
            MOV          B, #2
            MUL          AB
            MOV          B, #10

            DIV          AB
            MOV          R1, B; R3*2
            ADD          A, R0; ADD CARRY TO RESULT'S THOUSANDS
            MOV          R0, A;

            MOV          A, R2
            MOV          B, #5
            MUL          AB
            MOV          B, #10
            DIV          AB
            MOV          R6, B; R2*5
            ADD          A, R0; ADD CARRY TO RESULT'S THOUSANDS
            MOV          R0, A;

            MOV          A, R1
            ADD          A, R6
            MOV          B, #10; CHECK CARRY
            DIV          AB
            MOV          R1, B;(R3*2 + R2*5) RESULT'S HUNDREDS
            ADD          A, R0
            MOV          R0, A; ADD CARRY TO RESULT'S THOUSANDS

            MOV          A, R3
            MOV          B, #5
            MUL          AB
            MOV          B, #10
            DIV          AB
            MOV          R6, B; R3*5
            ADD          A, R1; ADD CARRY TO RESULT'S HUNDREDS
            MOV          R1, A

            MOV          A, R2
            MOV          B, #6
            MUL          AB
            MOV          B, #10
            DIV          AB
            MOV          R7, B; R2*6
            ADD          A, R1; ADD CARRY TO RESULT'S HUNDREDS
            MOV          R1, A

            MOV          A, R6
            ADD          A, R7
            MOV          B, #10; CHECK CARRY
            DIV          AB
            MOV          R6, B; (R3*5 + R2*6) RESULT'S TENTHS
            ADD          A, R1
            MOV          R1, A; ADD CARRY TO RESULT'S HUNDREDS

            MOV          A, R3
            MOV          B, #6
            MUL          AB
            MOV          B, #10
            DIV          AB
            MOV          R7, B; 6*R3 RESULT'S ONES
            ADD          A, R6; ADD CARRY TO RESULT'S TENTHS
            MOV          R6, A


            MOV          A, R5 ; LOAD LOW BYTE
            MOV          B, #100
            DIV          AB ; DIVIDE A BY 100, QUOTIENT(HUNDREDS)IN A, REMAINDER IN B
            PUSH         B
            ADD          A, R1; ADD HIGH HUNDREDS TO LOW HUNDREDS
            MOV          B, #10
            DIV          AB; CHECK CARRY
            MOV          R1, B; SAVE COUNTER HUNDREDS

            ADD          A, R0; CHECK THOUSANDS OVEFLOW
            MOV          B, #10
            DIV          AB
            MOV          R0, B
            POP          B

            MOV          A, B ; REMAINDER TO A
            MOV          B, #10
            DIV          AB ; DIVIDE A BY 10, QUOTIENT(TENTHS)IN A, REMAINDER IN B
            PUSH         B
            ADD          A, R6
            MOV          B, #10
            DIV          AB; CHECK CARRY
            MOV          R6, B; SAVE COUNTER TENTHS

            ADD          A, R1; CHECK HUNDRESD OVERFLOW
            MOV          B, #10
            DIV          AB
            MOV          R1, B
            ADD          A, R0
            MOV          R0, A
            POP          B

            MOV          A, B ; REMAINDER TO A
            ADD          A, R7
            MOV          B, #10
            DIV          AB; CHECK CARRY
            MOV          R7, B; SAVE COUNTER ONES

            ADD          A, R6; CHECK TENTHSOVERFLOW
            MOV          B, #10
            DIV          AB
            MOV          R6, B
            ADD          A, R1; CHECK HUNDRESD OVERFLOW
            MOV          B, #10
            DIV          AB
            MOV          R1, B
            ADD          A, R0
            MOV          R0, A

            MOV          A, R0
            ADD          A, #30H ; CONVERT TO ASCII
            ACALL        WRDATA ; WRITE TO DISPLAY (10^3)

            MOV          A, R1
            ADD          A, #30H ; CONVERT TO ASCII
            ACALL        WRDATA ; WRITE TO DISPLAY (10^3)

            MOV          A, R6
            ADD          A, #30H ; CONVERT TO ASCII
            ACALL        WRDATA ; WRITE TO DISPLAY (10^3)

            MOV          A, R7
            ADD          A, #30H ; CONVERT TO ASCII
            ACALL        WRDATA ; WRITE TO DISPLAY (10^3)

            POP          03
            POP          02
            POP          01
            POP          00

            RET         

LINE1:      MOV          A, #10000000B
            ACALL        WRINS
            RET         

LINE2:      MOV          A, #11000000B
            ACALL        WRINS
            RET         

WRINS:      
            MOV          P1, #00111111B
            NOP         
            SETB         P1.7
            MOV          P0, A
            NOP         
            CLR          P1.7
            ACALL        DLY1
            RET         

WRDATA:     
            MOV          P1, #01111111B
            NOP         
            SETB         P1.7
            MOV          P0, A
            NOP         
            CLR          P1.7
            ACALL        DLY2
            RET         

DELAY:      
            PUSH         07
            PUSH         06
            MOV          R6, #100
DL:         MOV          R7, #200
            DJNZ         R7, $
            DJNZ         R6, DL
            POP          06
            POP          07
            RET         

DLY1:       
            PUSH         07
            PUSH         06
            MOV          R6, #20
DL1:        MOV          R7, #200
            DJNZ         R7, $
            DJNZ         R6, DL1
            POP          06
            POP          07
            RET         

DLY2:       
            PUSH         06
            MOV          R6, #80
            DJNZ         R6, $
            POP          06
            RET         

DEBOUNCE:   
            PUSH         02
            MOV          R2, #20 ; DELAY LOOP FOR DEBOUNCING

WAIT_RELEASE:
            JNB          P2.0, WAIT_RELEASE
            DJNZ         R2, WAIT_RELEASE
            POP          02
            RET         

TAB1:       DB           'SCORE:'
            DB           10H

TABLE:      DB           11111111B
            DB           11111111B
            DB           11111111B
            DB           11111111B
            DB           11111111B
            DB           11111111B
            DB           11111111B
            DB           11111111B

            DB           00111111B
            DB           11111111B
            DB           11001111B
            DB           11111111B
            DB           11110011B
            DB           11111111B
            DB           11111100B
            DB           11111111B

            DB           11111111B
            DB           11111111B
            DB           11111111B
            DB           11111111B
            DB           11111111B
            DB           11111111B
            DB           11111111B
            DB           11111111B
            END         
