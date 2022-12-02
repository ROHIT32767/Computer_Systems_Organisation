.global partition

partition:
movq (%rdi,%rdx,8),%r14 # pivot=A[high]
movq %rsi,%r15 # i
decq %r15
movq %rsi,%r13 # j
.for:
cmpq %r13,%rdx
jle .comeout
movq (%rdi,%r13,8),%r12 # arr[j]
cmpq %r14,%r12
jl .if
.back:
incq %r13
jmp .for

.if:
incq %r15 # i
movq (%rdi,%r15,8),%r10 # arr[i]
movq %r10,(%rdi,%r13,8)
movq %r12,(%rdi,%r15,8)
jmp .back

.comeout:
incq %r15
movq (%rdi,%r15,8),%r10
movq (%rdi,%rdx,8),%r11
movq %r11,(%rdi,%r15,8)
movq %r10,(%rdi,%rdx,8)
movq %r15,%rax
ret


