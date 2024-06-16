 org 0000H
 mov tmod, #00100000b;
 mov th1,#232
 mov tl1,#232
 setb TR1

 mov scon, #11010000b

loop: jnb p1.0,CASE1
    jnb p1.1, case1
    jnb p1.2, case2
    jnb p1.3, CASE2
    ajmp loop

case1:
    cpl p0.7
    setb tb8
    clr ti
    mov sbuf,#01
    jnb ti, $
    cpl p0.6

    clr tb8
    clr ti
    mov sbuf,p1
    jnb ti,$
    cpl p0.5

    setb sm2
    clr RI
    jnb ri,$
    cpl p0.4

    clr sm2
    clr ri     
    jnb ri,$
    cpl p0.3
    mov a,sbuf
    mov c,acc.0
    mov p0.1,c
    call WAIT

    ajmp loop

case2: 
    cpl p0.7
    setb tb8
    clr ti

    mov sbuf,#02
    jnb ti,$
    cpl p0.6
    clr tb8
    clr ti
    mov sbuf,p1
    jnb  ti,$
    cpl p0.5 

    clr RI
    jnb ri,$
    cpl p0.4 
    mov a,sbuf
    mov c,acc.0
    mov p0.0,c
    call WAIT
    ajmp loop

wait: call DELAY
    mov a,p1
    cjne a,#11111111b,wait
    ret

delay: mov r6,#25
dl1: mov r7,#200
dl2: djnz r7,dl2
    djnz r6,dl1
    ret 
 
 end

