            ORG         0000H       
            AJMP        MAIN        

MAIN:       MOV         DPTR,       #TABLE      
            MOV         R3,         #82         
LOOP:       MOV         R2,         #12         
SCAN:       ACALL       SCAN1       
            DJNZ        R2,         SCAN        
            INC         DPTR        
            DJNZ        R3,         LOOP        
            AJMP        MAIN        

SCAN1:      MOV         R1,         #00H        
            MOV         R5,         #11111110B  
            MOV         R4,         #08         
LOOP1:      MOV         A,          R1          
            MOVC        A,          @A+DPTR     
            MOV         P0,         A           
            MOV         P1,         R5          
            MOV         R6,         #5          
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

TABLE:      
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
            DB          11110011B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11110011B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11110011B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          00111111B   
            DB          11001111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11110011B   
            DB          11111111B   
            DB          11001111B   
            DB          00111111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11110011B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11110011B   
            DB          11001111B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11111111B   
            DB          11001111B   
            DB          00111111B   
            DB          11001111B   
            DB          11111100B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111111B   
            DB          11110011B   
            DB          11111100B   
            DB          11110011B   
            DB          11001111B   

            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            DB          11111111B   
            END         
