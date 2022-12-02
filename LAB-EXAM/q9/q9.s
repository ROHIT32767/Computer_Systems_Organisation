.global factorial,sumfact

.illegal:
movq $-1,%rax
ret

.zero:
movq $1,%rax
ret

factorial:
cmpq $0,%rdi
je .zero
cmpq $0,%rdi
jl .illegal
movq $1,%rax
movq $1,%rsi
incq %rsi
.start:
cmpq %rsi,%rdi
jl .result
imulq %rsi,%rax
jo .overflow
.back:
incq %rsi
jmp .start

.result:
ret;

.overflow:
movq $1,%r10
shlq $63,%r10
cqto
idivq %r10
movq %rdx,%rax
jmp .back

sumfact:
cmpq $0,%rdi
jl .illegal
movq $0,%r14
movq %rdi,%r15
.begin:
cmpq $10,%rdi
jl .lessthan10
movq %rdi,%rsi
movq $10,%r9
movq %rsi,%rax
cqto
idivq %r9
movq %rdx,%rdi
movq %rax,%r8
call factorial
addq %rax,%r14
jo .overflow1
.back1:
movq %r8,%rdi
jmp .begin

.lessthan10:
call factorial
addq %rax,%r14
jo .overflow2
.back2:
movq %r14,%rax
cmpq %rax,%r15
jne .notequal
movq $1,%rax
ret


.notequal:
movq $-1,%rax
ret

.overflow1:
movq %r14,%rax
movq $1,%r10
shlq $63,%r10
cqto
idivq %r10
movq %rdx,%r14
jmp .back1

.overflow2:
movq %r14,%rax
movq $1,%r10
shlq $63,%r10
cqto
idivq %r10
movq %rdx,%r14
jmp .back2


