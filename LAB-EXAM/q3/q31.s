.global sum

.illegal:
movq $-1,%rax
ret

sum:
cmpq $1,%rsi
jl .illegal
cmpq $1,%rdx
jl .illegal
movq %rsi,%r12
movq %rdx,%r13
movq $0,%r14
movq $0,%r15
movq $0,%rcx
.form:
cmpq %r14,%r12
jle .answer
jmp .forn
.column:
incq %r14
movq $0,%r15
jmp .form




.forn:
cmpq %r15,%r13
jle .column
movq %r14,%r11
imulq %r12,%r11
addq %r15,%r11
imulq $8,%r11
movq (%rdi,%r11),%r10
movq %r10,%rax
movq $2,%r8
cqto
idivq %r8
cmpq $0,%rdx
je .add
.back:
incq %r15
jmp .forn



.add:
addq %r10,%rcx
jmp .back


.answer:
movq %rcx,%rax
ret

