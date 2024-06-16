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
 cjne a,#01,sendnext

 clr sm2
 clr RI
 jnb ri,$
 mov a,sbuf
 jnb acc.1,on
 jnb acc.0, off
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
    ajmp send
off: setb p0.0
send :  
    setb tb8
    clr ti
    mov sbuf,#03
    jnb ti,$
    cpl p0.4

    clr tb8
    clr ti
    mov sbuf,p0
    jnb ti,$
    cpl p0.3
    ajmp loop

delay: mov r6,#25
dl1: mov r7,#200
dl2: djnz r7,dl2
    djnz r6,dl1
    ret 
 

 end