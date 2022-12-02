.global factorial,firstfact

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


firstfact:
cmpq $0,%rdi
jle .illegal
movq %rdi,%r14
movq $1,%rsi

.start1:
movq %rsi,%rdi
movq %rsi,%r15
call factorial
cqto
idivq %r14
movq %r15,%rsi
cmpq $0,%rdx
je .finish
incq %rsi
jmp .start1


.finish:
movq %rsi,%rax
ret
