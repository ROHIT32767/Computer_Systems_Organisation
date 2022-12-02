.global prime,sum


.illegal:
movq $-1,%rax
ret

prime:
cmpq $1,%rdi
jle .illegal
movq %rdi,%rsi
decq %rsi
.check:
cmpq $1,%rsi
je .true
movq %rdi,%rax
cqto
idivq %rsi
cmpq $0,%rdx
je .false
decq %rsi
jmp .check

.true:
movq $1,%rax
ret

.false:
movq $-1,%rax
ret

.zero:
movq $0,%rax
ret

sum:
cmpq $2,%rdi
jle .zero
movq %rdi,%r14
movq %rsi,%r15
decq %r14
movq $0,%r13
.loop:
cmpq $1,%r14
jle .finish
movq %r14,%rdi
call prime
cmpq $1,%rax
jne .jumpback
addq %r14,%r13
movq %r13,%rax
cqto
idivq %r15
movq %rdx,%r13
decq %r14
jmp .loop



.jumpback:
decq %r14
jmp .loop





.finish:
movq %r13,%rax
ret



