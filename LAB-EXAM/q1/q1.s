.global switchcase

.illegal:
movq $-1,%rax
ret

switchcase:
movq $0,%r14
cmpq $1,%rdx
je .add1
cmpq $2,%rdx
je .sub2
cmpq $3,%rdx
je .div3 
cmpq $4,%rdx
je .exp4
jmp .mod5


.add1:
addq %rsi,%rdi
movq %rdi,%rax
ret

.sub2:
subq %rsi,%rdi
movq %rdi,%rax
ret

.div3:
movq %rdi,%rax
cqto
idivq %rsi
ret

.exp4:
decq %rsi
.loop:
cmpq %r14,%rsi
jle .answer
incq %rsi
imulq %rdi,%rdi
decq %rsi
incq %r14
jmp .loop
.answer:
movq %rdi,%rax
ret


.mod5:
movq %rdi,%rax
cqto
idivq %rsi
movq %rdx,%rax
ret

