.global bubblesort

.illegal:
movq $-1,%rax
ret

bubblesort:
cmpq $1,%rsi
jl .illegal
movq $0,%r12
movq $0,%r13
decq %rsi
.fori:
cmpq %r12,%rsi
jle .answer
jmp .forj
.back:
incq %r12
movq $0,%r13
jmp .fori


.forj:
movq %rsi,%r14
subq %r12,%r14
cmpq %r13,%r14
jle .back
movq (%rdi,%r13,8),%r8
incq %r13
movq (%rdi,%r13,8),%r9
decq %r13
cmpq %r9,%r8
jg .swap
incq %r13
jmp .forj





.swap:
movq %r9,(%rdi,%r13,8)
incq %r13
movq %r8,(%rdi,%r13,8)
jmp .forj




.answer:
ret
