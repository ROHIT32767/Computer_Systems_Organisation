.global fun2

.illegal:
movq $-1,%rax
ret

fun2:
pushq %rbx
movq %rdi,%rbx
movq $2,%rax
cmpq $1,%rdi
jle .answer
leaq -1(%rdi),%rdi
call fun2
cqto 
idivq %rbx
movq %rbx,%r15
addq %r15 ,%r15
addq $-1,%r15
imulq %r15,%rax
imulq $2,%rax

.answer:
popq %rbx
cqto
movq $13,%r14
idivq %r14
movq %rdx ,%rax
ret

