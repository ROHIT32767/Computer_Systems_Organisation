.global fun2                # makes the assembler export it (add it to the symbol table of the object) so that the linker can find it later for use in other translation units

.illegal:                   # Label "illegal" is used when an invalid input is entered
movq $-1,%rax               # In case of error or invalid input return ’-1’
ret                         # return from function fun2

.abs:                       # definition of label "abs" starts here,iff diff<0
imulq $-1,%r14              # multiples diff with -1,basically diff=|diff|
jmp .endabs                 # jumps to label "endabs"

.zero:                      # definition of label "zero" starts here
movq $0,%rax                # if |diff|>n,then returns 0
jmp .L35                    # jumps to label "L35"

.one:                       # definition of label "one" starts here
movq $1,%rax                # if |diff|=1 and n=1,then returns 1
jmp .L35                    # jumps to label "L35"


.two:                       # definition of label "two" starts here
movq $2,%rax                # if diff=0 and n=1,then returns 2
jmp .L35                    # jumps to label "L35"


.nis1:                      # definition of label "nis1" starts here,if n=1
cmpq $0,%r14                # compares diff and 0
je .two                     # jumps to label "two" if diff=0
cmpq $1,%r14                # comapres diff and 1
je .one                     # jumps to label "one" if |diff|=1 



fun2:                       # definition of fun2 starts here
cmpq $1,%rdi                # compares N and 1
jl .illegal                 # jumps to label "illegal" if N < 1
pushq %rbx                  # push %rbx onto the stack
pushq %r13                  # push %r13 onto the stack
movq %rdi,%rbx              # moves(copies) %rdi into %rbx
movq %rsi,%r14              # moves(copies) %rsi into %r14
movq %rsi,%r13              # moves(copies) %rsi into %r13
cmpq $0,%r14                # checking if diff>0
jl .abs                     # jumps to label "abs" ,if diff<0
.endabs:                    # definition of label "endabs" starts here
cmpq %r14,%rdi              # compares diff and n          
jl .zero                    # jumps to label "zero" if |diff|>n
cmpq $1,%rdi                # compares n and 1
je .nis1                    # jumps to label "nis1" if n=1
leaq -1(%rdi),%rdi          # decrements n
movq %r13,%r11              # moves(copies) %r13 into %r11
addq $1,%r11                # increments %r11
movq %r11,%rsi              # moves(copies) %r11 into %rsi
call fun2                   # call fun2(n-1,diff+1)
movq %rax,%r15              # storing return value of fun2(n-1,diff+1) into %r15
pushq %r15                  # pushing %r15 into the stack
movq %r13,%r11              # moves(copies) %r13 into %r11
subq $1,%r11                # decrements %r11
movq %r11,%rsi              # moves(copies) %r11 into %rsi
movq %rbx,%rdi              # copies n into %rdi
decq %rdi                   # decrements %rdi
call fun2                   # calls fun2(n-1,diff-1)
popq %r8                    # retrieving value of fun2(n-1,diff+1) from the stack
addq %r8,%rax               # storing fun2(n-1,diff-1)+fun2(n-1,diff+1) into %rax
jo .overflow1
.L1:
movq %rax,%r15              # storing fun2(n-1,diff+1)+fun2(n-1,diff-1) into %r15
pushq %r15                  # pushing %r15 into the stack
movq %r13,%r11              # moves(copies) %r13 into %r11
movq %r11,%rsi              # moves(copies) %r11 into %rsi
movq %rbx,%rdi              # copies n into %rdi
decq %rdi                   # decrements %rdi
call fun2                   # call fun2(n-1,diff)
addq %rax,%rax              # storing fun2(n-1,diff)+fun2(n-1,diff) into %rax
jo .overflow2
.L2:
popq %r9                    # retrieving value of fun2(n-1,diff+1)+ fun2(n-1,diff-1) from the satck
addq %r9,%rax               # storing fun2(n-1,diff-1)+fun2(n-1,diff+1)+(2*fun2(n-1,diff)) into %rax
jo .overflow3

.L35:                       # definition of label "L35" starts here
popq %r13                   # pops %r13 from the stack
popq %rbx                   # pops %rbx from the stack
ret                         # return from fun2


.overflow1:                 # definition of label "overflow1" starts here
movq $1,%r10                # moves(copies) 1 into %r10
shlq $63,%r10               # left shifting 1 by 63
cqto                        # sign extending %rax to %rdx::%rax
idivq %r10                  # dividing %rax by %r10
movq %rdx,%rax              # moves(copies) %rdx into %rax
jmp .L1                     # jumps to label "L1"

.overflow2:                 # definition of label "overflow2" starts here
movq $1,%r10                # moves(copies) 1 into %r10
shlq $63,%r10               # left shifting 1 by 63
cqto                        # sign extending %rax to %rdx::%rax
idivq %r10                  # dividing %rax by %r10
movq %rdx,%rax              # moves(copies) %rdx into %rax
jmp .L2                     # jumps to label "L2"

.overflow3:                 # definition of label "overflow3" starts here
movq $1,%r10                # moves(copies) 1 into %r10
shlq $63,%r10               # left shifting 1 by 63
cqto                        # sign extending %rax to %rdx::%rax
idivq %r10                  # dividing %rax by %r10
movq %rdx,%rax              # moves(copies) %rdx into %rax
jmp .L35                    # jumps to label "L35"

