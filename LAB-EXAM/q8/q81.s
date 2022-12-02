.global mult


.illegal:
movq $-1,%rax
ret

mult:
cmpq $1,%rdi
jl .illegal
cmpq $1,%rsi
jl .illegal
cmpq $1,%rdx
jl .illegal
push %r10
push %r12
push %r13
push %r14
movq $0,%r12 # i
movq $0,%r13 # j
movq $0,%r14 # k
.form:
cmpq %r12,%rdi # i<m
jle .answer1 # return
jmp .forp
.row:
incq %r12 # i++
movq $0,%r13 # j=0;
movq $0,%r14
jmp .form

.forp:
cmpq %r13,%rdx
jle .row
movq %rdi,%r10
imulq %r12,%r10
addq %r13,%r10
movq $0,(%r9,%r10,8)
jmp .forn
.column:
incq %r13
movq $0,%r14
jmp .forp

.forn:
cmpq %r14,%rsi
jle .column
movq %rdi,%r10
imulq %r12,%r10
addq %r14,%r10
movq (%rcx,%r10,8),%r11
movq %rsi,%r10
imulq %r14,%r10
addq %r13,%r10
imulq (%r8,%r10,8),%r11
movq %rdi,%r10
imulq %r12,%r10
addq %r13,%r10
addq %r11,(%r9,%r10,8)
incq %r14
jmp .forn


.answer1:
pop %r14
pop %r13
pop %r12
pop %r10
ret
