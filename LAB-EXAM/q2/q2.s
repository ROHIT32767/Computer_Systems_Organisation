.global parity




parity:
movq %rdi,%r12
movq $0,%rsi
movq $0,%r14

.loop:
cmpq $63,%rsi
jg .answer
movq $1,%r13
movq %r12,%r15
andq %r13,%r15
shrq $1,%r12
cmpq $1,%r15
je .increment
.back:
incq %rsi
jmp .loop

.increment:
incq %r14
jmp .back

.answer:
movq %r14,%rax
movq $2,%r13
cqto
idivq %r13
movq %rdx,%rax
ret



