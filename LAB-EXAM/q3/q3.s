.global sum

.illegal:
movq $-1,%rax
ret

sum:
cmpq $1,%rsi
jl .illegal
cmpq $1,%rdx
jl .illegal
movq %rdx,%r15
imulq %rsi,%r15
movq $0,%r14
movq $0,%r10
jmp .loop

.loop:
cmpq %r14,%r15
jle .answer
movq (%rdi,%r14,8),%r13
movq $2,%r12
movq %r13,%rax
cqto
idivq %r12
cmpq $0,%rdx
je .add
.back:
incq %r14
jmp .loop


.add:
addq %r13,%r10
movq $1,%r9
shlq $63,%r9
movq %r10,%rax
cqto
idivq %r9
movq %rdx,%r10
jmp .back

.answer:
movq %r10,%rax
ret
