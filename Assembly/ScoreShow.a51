 org 0000H
 acall init
 acall lable
loop: acall check
 acall cntdsp
 ajmp loop
init: acall delay
 mov a,#38H
 acall wrins
 mov a,#38H
 acall wrins
 mov a,#38H
 acall wrins
 mov a,#38H
 acall wrins


 mov a,#08H
 acall wrins
 mov a,#01H
 acall wrins
 mov a,#06H
 acall wrins
 mov a,#0cH
 acall wrins

 mov 40h,#00
 mov 41h,#00
 mov 42h,#00
 mov 43h,#00
 mov 44h,#00
 mov 45h,#00
 mov 46h,#00
 mov 47h,#00
 
 mov 21h,p1
 ret 

lable: acall l0101
 mov A,#'S'
 acall wrdata
 mov A,#'C'
 acall wrdata
 mov A,#'O'
 acall wrdata
 mov A,#'R'
 acall wrdata
 mov A,#'E'
 acall wrdata
 mov A,#':'
 acall wrdata

check: mov 22h,21h
 mov 21h,p1
chk1: jb 21H.1,OK
 jnb 22h.1,OK
 mov r0,#40h
 acall cntinc
 
OK: RET

cntinc: mov a,#1
 add a,@r0
 da A
 mov @r0,A
 inc r0
 mov a,#0
 addc a,@r0
 da A
 mov @r0,A
 ret

cntdsp: acall ascii
 acall L0107
 mov r0,#33h
 acall dsp
 ret

ascii: mov r0,#40h
 mov r1,#30h
 mov r2,#08H

loop1:  mov a,@r0
 push acc
 anl a,#00001111B
 add a,#30h
 mov @r1,A
 pop acc
 swap A
 anl a,#00001111B
 add a,#30h 
 inc r1
 mov @r1,A
 inc r0
 inc r1
 djnz r2,loop1
 ret

dsp: mov r1,#4
loop1: mov a,@r0
 acall wrdata
 dec r0
 djnz r1,loop1
 ret

delay: mov r6,#100
dl: mov r7,#200
 djnz r7,$
 djnz r6,DL
 ret

L0101: mov A,#10000000b
 acall wrins
 ret

L0107: mov A,#10000110b
 acall wrins
 ret 

wrins: mov p1,#00111111B
 nop
 setb p1.7
 mov p0,A 
 nop
 clr p1.7
 acall dly1
 ret

dly1: mov r6,#20
dl1: mov r7,#200
 djnz r7,$
 djnz r6,dl1
 ret 

wrdata: mov p1,#10111111B
 nop
 setb p1.7
 mov p0,a
 nop
 clr p1.7
 acall dly2
 ret

dly2: mov r6,#80
 djnz r6,$
 ret

 end

