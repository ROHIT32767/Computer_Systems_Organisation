.global GCD

.illegal:
movq $-1,%rax
ret

GCD:
cmpq $0,%rdi
jle .illegal
cmpq $0,%rsi
jle .illegal
cmpq %rsi,%rdi
jg .Mhigh
jmp .Nhigh

.Mhigh:
movq %rdi,%r12
movq %rsi,%r13

.loop:
cmpq $1,%r13
je .found1
movq %r12,%rax
cqto
idivq %r13
cmpq $0,%rdx
je .divideN
.proceed:
decq %r13
jmp .loop


.divideN:
movq %rsi,%rax
cqto
idivq %r13
cmpq $0,%rdx
je .found1
jmp .proceed


.found1:
movq %r13,%rax
ret



.Nhigh:
movq %rdi,%r12
movq %rsi,%r13

.loop1:
cmpq $1,%r12
je .found2
movq %r13,%rax
cqto
idivq %r12
cmpq $0,%rdx
je .divideM
.proceed2:
decq %r12
jmp .loop1


.divideM:
movq %rdi,%rax
cqto
idivq %r12
cmpq $0,%rdx
je .found2
jmp .proceed2


.found2:
movq %r12,%rax
ret


