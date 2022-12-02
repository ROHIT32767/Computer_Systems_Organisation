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
push %rbx
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
movq %rdi,%rbx
imulq %r12,%rbx
addq %r13,%rbx
movq $0,(%r9,%rbx,8)
jmp .forn
.column:
incq %r13
movq $0,%r14
jmp .forp

.forn:
cmpq %r14,%rsi
jle .column
movq %rdi,%rbx
imulq %r12,%rbx
addq %r14,%rbx
movq (%rcx,%rbx,8),%r11
movq %rsi,%rbx
imulq %r14,%rbx
addq %r13,%rbx
imulq (%r8,%rbx,8),%r11
movq %rdi,%rbx
imulq %r12,%rbx
addq %r13,%rbx
addq %r11,(%r9,%rbx,8)
incq %r14
jmp .forn


.answer1:
pop %rbx
ret
