
 org 0000H
 mov tmod,#00100000b
 mov th1,#232
 mov tl1,#232
 setb TR1

 mov scon , #11010000b

loop: setb sm2
 clr RI
 jnb ri,$
 mov a,sbuf	
 cjne a,#02,sendnext
 
 cpl p0.7
 clr sm2
 clr RI
 jnb ri,$
 mov a,sbuf
 cpl p0.6
 jnb acc.3, on
 jnb acc.2, off
 ajmp loop

sendnext: 
 CPL p0.7
 setb tb8
 mov sbuf,a
 clr ti
 jnb ti,$
 cpl p0.6 
 clr tb8
 clr sm2
 clr RI
 jnb ri,$

 clr ti
 mov a,sbuf
 mov sbuf,a
 jnb ti,$
 cpl p0.5
 ajmp loop 

on: clr p0.0
 clr ti	
 mov sbuf,p0
 jnb ti,$
 ajmp loop

off: setb p0.0
 clr ti
 mov sbuf,p0
 jnb ti,$
 ajmp loop

delay: mov r6,#25
dl1: mov r7,#200
dl2: djnz r7,dl2
    djnz r6,dl1
    ret 

 end