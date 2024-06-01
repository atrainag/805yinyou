            ORG         0000H       
            AJMP        MAIN        

MAIN:       MOV         DPTR,       #TABLE      
            MOV R3,#32
LOOP:       MOV         R2,         #9          
SCAN:       ACALL       SCAN1       
            DJNZ        R2,         SCAN        
            INC         DPTR        
		push p1
		MOV		P1,#11111110B
		JNB		P2.0,KEY0
		JNB		P2.1,KEY1
		JNB		P2.2,KEY2
		JNB		P2.3,KEY3
		MOV		P1,#11111101B
		JNB		P2.0,KEY4
		JNB		P2.1,KEY5
		JNB		P2.2,KEY6
		JNB		P2.3,KEY7
		MOV		P1,#11111011B
		JNB		P2.0,KEY8
		JNB		P2.1,KEY9
		JNB		P2.2,KEYA
		JNB		P2.3,KEYB
		MOV		P1,#11110111B
		JNB		P2.0,KEYC
		JNB		P2.1,KEYD
		JNB		P2.2,KEYE
		JNB		P2.3,KEYF
		pop p1
			DJNZ R3,LOOP
            AJMP        MAIN        

SCAN1:      
            MOV         R1,         #00H        
            MOV         R5,         #11111110B  
            MOV         R4,         #08         
LOOP1:      MOV         A,          R1          
            MOVC        A,          @A+DPTR     
            MOV         P0,         A           
            MOV         P1,         R5          
            MOV         R6,         #3          
DL1:        MOV         R7,         #200        
DL2:        DJNZ        R7,         DL2         
            DJNZ        R6,         DL1         
            ORL         P0,         #00000000B  
            MOV         A,          R5          
            RL          A           
            MOV         R5,         A           
            INC         R1          
            DJNZ        R4,         LOOP1       
            RET         

KEY0:	    mov a,P0	
            anl a,#11111100B
            ajmp judge

KEY1:	    mov a,P0	
            anl a,#11110011B
            ajmp judge
KEY2:	    mov a,P0	
            anl a,#11001111B
            ajmp judge
KEY3:	    mov a,P0	
            anl a,#00111111B
            ajmp judge

JUDGE:      jnz score
            ajmp miss

score:  

TABLE: DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          00111111B   
            DB          11111111B   
            DB          11111111B   

            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            DB 11111111B 
            end