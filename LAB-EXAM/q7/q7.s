.global binarySearch

.illegal:
movq $-1,%rax
ret

binarySearch:
cmpq $1,%rsi
jl .illegal
movq %rdx,%r15 # key
movq $0,%r14 # low
movq %rsi,%r13 # high
decq %r13
jmp .while


.while:
cmpq %r13,%r14
jg .illegal
movq %r14,%r12 # middle
addq %r13,%r12
movq $2,%r11 # 2
movq %r12,%rax
cqto
idivq %r11
movq %rax,%r12
cmpq (%rdi,%r12,8),%r15
je .found
cmpq %r15,(%rdi,%r12,8)
jl .if
jmp .else



.if:
movq %r12,%r8
incq %r8
movq %r8,%r14
jmp .while

.else:
movq %r12,%r8
decq %r8
movq %r8,%r13
jmp .while



.found:
movq %r12,%rax
ret

