            ORG          0000H
            ACALL        INIT
            ACALL        LABLE
LOOP:       ACALL        CHECK
            ACALL        CNTDSP
            AJMP         LOOP
INIT:       ACALL        DELAY
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

            MOV          40H, #00
            MOV          41H, #00
            MOV          42H, #00
            MOV          43H, #00
            MOV          44H, #00
            MOV          45H, #00
            MOV          46H, #00
            MOV          47H, #00

            MOV          21H, P1
            RET         

LABLE:      ACALL        L0101
            MOV          A, #'S'
            ACALL        WRDATA
            MOV          A, #'C'
            ACALL        WRDATA
            MOV          A, #'O'
            ACALL        WRDATA
            MOV          A, #'R'
            ACALL        WRDATA
            MOV          A, #'E'
            ACALL        WRDATA
            MOV          A, #':'
            ACALL        WRDATA

CHECK:      MOV          22H, 21H
            MOV          21H, P1
CHK1:       JB           21H.1, OK
            JNB          22H.1, OK
            MOV          R0, #40H
            ACALL        CNTINC

OK:         RET         

CNTINC:     MOV          A, #1
            ADD          A, @R0
            DA           A
            MOV          @R0, A
            INC          R0
            MOV          A, #0
            ADDC         A, @R0
            DA           A
            MOV          @R0, A
            RET         

CNTDSP:     ACALL        ASCII
            ACALL        L0107
            MOV          R0, #33H
            ACALL        DSP
            RET         

ASCII:      MOV          R0, #40H
            MOV          R1, #30H
            MOV          R2, #08H

LOOP1:      MOV          A, @R0
            PUSH         ACC
            ANL          A, #00001111B
            ADD          A, #30H
            MOV          @R1, A
            POP          ACC
            SWAP         A
            ANL          A, #00001111B
            ADD          A, #30H
            INC          R1
            MOV          @R1, A
            INC          R0
            INC          R1
            DJNZ         R2, LOOP1
            RET         

DSP:        MOV          R1, #4
LOOP1:      MOV          A, @R0
            ACALL        WRDATA
            DEC          R0
            DJNZ         R1, LOOP1
            RET         

DELAY:      MOV          R6, #100
DL:         MOV          R7, #200
            DJNZ         R7, $
            DJNZ         R6, DL
            RET         

L0101:      MOV          A, #10000000B
            ACALL        WRINS
            RET         

L0107:      MOV          A, #10000110B
            ACALL        WRINS
            RET         

WRINS:      MOV          P1, #00111111B
            NOP         
            SETB         P1.7
            MOV          P0, A
            NOP         
            CLR          P1.7
            ACALL        DLY1
            RET         

DLY1:       MOV          R6, #20
DL1:        MOV          R7, #200
            DJNZ         R7, $
            DJNZ         R6, DL1
            RET         

WRDATA:     MOV          P1, #10111111B
            NOP         
            SETB         P1.7
            MOV          P0, A
            NOP         
            CLR          P1.7
            ACALL        DLY2
            RET         

DLY2:       MOV          R6, #80
            DJNZ         R6, $
            CJNE         R2, 20, 12
            RET         

            END         

