 ORG 0000H
        MOV R4, #0   ; High byte of counter
        MOV R5, #0   ; Low byte of counter

MAIN:   ACALL INIT2
        ACALL LINE1 
        MOV DPTR, #TAB1
        ACALL DISPLAY
        ACALL LINE2
        ACALL DISPLAY2

LOOP:   MOV P0, R5
        ;MOV P1, #11111110B
        ;JNB P2.0, KEY0
        AJMP key0
        AJMP LOOP

KEY0:   ACALL DEBOUNCE     ; Debounce the key press
        INC R5
        CJNE R5, #0, MAIN  ; If R5 != 0, no overflow
        MOV R5,#0
		INC R4
		cjne r4, #40, MAIN
		mov r4,#0
        AJMP MAIN

INIT2:  ACALL DELAY
        MOV A, #38H
        ACALL WRINS
        MOV A, #38H
        ACALL WRINS
        MOV A, #38H
        ACALL WRINS
        MOV A, #38H
        ACALL WRINS
        MOV A, #08H
        ACALL WRINS
        MOV A, #01H
        ACALL WRINS
        MOV A, #06H
        ACALL WRINS
        MOV A, #0CH
        ACALL WRINS
        RET 

DISPLAY:
        PUSH 07
        MOV R7, #00H
NEXT:   MOV A, R7
        MOVC A, @A+DPTR
        CJNE A, #10H, DSP
        POP 07
        RET


DSP:    
        ACALL WRDATA
        INC R7
        AJMP NEXT

DISPLAY2:
        MOV A,R4       ; High Byte
        MOV B, #100    
        DIV AB         ; Divide A by 100, quotient(hundred) in A, remainder in B
        MOV A, B       ; Remainder to A
        MOV B, #10       
        DIV AB         ; Divide A by 10, quotient(tenths) in A, remainder in B
        MOV R2,A       ; Store High tenths on R2
        MOV R3,B       ; Store High ones on R3

        ; We want to find the result after multiplied by 256
        MOV A,R2
        MOV B,#2
        MUL AB 
        MOV B,#10
        DIV AB
        MOV R0,B ; R2*2 (Result's Thousands)

        MOV A,R3
        MOV B,#2
        MUL AB 
        MOV B,#10
        DIV AB
        MOV R1,B ; R3*2
        ADD A,R0 ; Add carry to Result's Thousands
        MOV R0,A ;
        
        MOV A,R2
        MOV B,#5
        MUL AB
        MOV B,#10
        DIV AB
        MOV R6,B ; R2*5
        ADD A,R0 ; Add carry to Result's Thousands
        MOV R0,A ;

        MOV A,R1
        ADD A,R6 
        MOV B,#10 ; Check Carry
        DIV AB
        MOV R1,B; (R3*2 + R2*5) Result's Hundreds
        ADD A,R0
        MOV R0,A ; Add Carry to Result's Thousands

        MOV A,R3
        MOV B,#5
        MUL AB 
        MOV B,#10
        DIV AB
        MOV R6,B ; R3*5
        ADD A,R1 ; Add carry to Result's Hundreds
        MOV R1,A

        MOV A,R2
        MOV B,#6
        MUL AB
        MOV B,#10
        DIV AB
        MOV R7,B ; R2*6
        ADD A,R1 ; Add carry to Result's Hundreds
        MOV R1,A

        MOV A,R6
        ADD A,R7
        MOV B,#10 ; Check Carry
        DIV AB
        MOV R6,B ; (R3*5 + R2*6) Result's Tenths 
        ADD A,R1
        MOV R1,A ; Add carry to Result's Hundreds 
        
        MOV A,R3
        MOV B,#6
        MUL AB 
        MOV B,#10
        DIV AB
        MOV R7,B ; 6*R3 Result's ones
        ADD A,R6 ; Add carry to Result's Tenths
        MOV R6,A


        MOV A, R5      ; Load Low Byte
        MOV B, #100    
        DIV AB         ; Divide A by 100, quotient(hundreds) in A, remainder in B
        PUSH B
        ADD A,R1       ; Add High Hundreds to Low Hundreds
        MOV B,#10 
        DIV AB; Check carry
        MOV R1,B ; Save Counter Hundreds

        ADD A,R0 ; Check thousands oveflow 
        MOV B,#10
        DIV AB
        MOV R0,B
        POP B 

        MOV A, B       ; Remainder to A
        MOV B, #10      
        DIV AB         ; Divide A by 10, quotient(tenths) in A, remainder in B
        PUSH B  
        ADD A,R6
        MOV B,#10 
        DIV AB; Check carry
        MOV R6,B ; Save Counter Tenths 

        ADD A,R1  ; Check Hundresd Overflow
        MOV B,#10
        DIV AB
        MOV R1,B
        ADD A,R0
        MOV R0,A
        POP B 

        MOV A, B       ; Remainder to A
        ADD A,R7
        MOV B,#10 
        DIV AB; Check carry
        MOV R7,B ; Save Counter ones

        ADD A,R6  ; Check TenthsOverflow
        MOV B,#10
        DIV AB
        MOV R6,B
        ADD A,R1  ; Check Hundresd Overflow
        MOV B,#10
        DIV AB
        MOV R1,B
        ADD A,R0
        MOV R0,A

        MOV A,R0
        ADD A, #30H    ; Convert to ASCII
        ACALL WRDATA   ; Write to display (10^3)
        
        MOV A,R1
        ADD A, #30H    ; Convert to ASCII
        ACALL WRDATA   ; Write to display (10^3)

        MOV A,R6
        ADD A, #30H    ; Convert to ASCII
        ACALL WRDATA   ; Write to display (10^3)

        MOV A,R7
        ADD A, #30H    ; Convert to ASCII
        ACALL WRDATA   ; Write to display (10^3)

        RET

LINE1:  MOV A, #10000000B
        ACALL WRINS
        RET

LINE2:  MOV A, #11000000B
        ACALL WRINS
        RET

WRINS:  
        MOV P1, #00111111B
        NOP
        SETB P1.7
        MOV P0, A
        NOP
        CLR P1.7
        ACALL DLY1
        RET

WRDATA: 
        MOV P1, #01111111B
        NOP
        SETB P1.7
        MOV P0, A
        NOP
        CLR P1.7
        ACALL DLY2
        RET

DELAY:  
        PUSH 07
        MOV R6, #100
DL:     MOV R7, #200
        DJNZ R7, $
        DJNZ R6, DL
        POP 07
        RET

DLY1:   
        PUSH 07
		PUSH 06
        MOV R6, #20
DL1:    MOV R7, #200
        DJNZ R7, $
        DJNZ R6, DL1
        POP 06
		POP 07
        RET 

DLY2:   
		PUSH 06
        MOV R6, #80
        DJNZ R6, $
		POP 06
        RET

DEBOUNCE:
        ; Wait until key is released
        MOV R2, #20   ; Delay loop for debouncing
WAIT_RELEASE:
        JNB P2.0, WAIT_RELEASE
        DJNZ R2, WAIT_RELEASE
        RET

TAB1:   DB 'Score: '
        DB 10H

        END