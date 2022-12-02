.global firstN

.illegal:
movq $-1,%rax
ret

firstN:
pushq %rbx
movq %rdi,%rbx
cmpq $1,%rdi
jl .illegal
cmpq $1,%rdi
je .Nis1
movq %rbx,%r9
decq %r9
movq %r9,%rdi
call firstN
addq %rbx,%rax
cqto
idivq %rsi
movq %rdx,%rax
popq %rbx
ret

.Nis1:
popq %rbx
movq $1,%rax
ret



