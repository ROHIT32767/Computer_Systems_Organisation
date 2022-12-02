.global fun6    # makes the assembler export it (add it to the symbol table of the object) so that the linker can find it later for use in other translation units
                # fun6 finds the sum of squares of first N Integers
.illegal :      # Label "illegal" is used when an invalid input is entered  
movq $-1,%rax   # In case of error or invalid input return ’-1’(move -1 to %rax)
ret             # returns from fun6

fun6:           # definition of fun3 starts here(computes GCD)
cmpq $1,%rdi    # compares %rdi and 1    
jl .illegal     # jumps to label "illegal" if N<=1
movq %rsi,%r11  # stroing LONG_MAX IN %r11
movq $0,%rsi    # initialises %rsi to 0 (%rsi = curr_num)
incq %rsi       # increments curr_num       
movq $0,%r12    # initialises %r12 to 0 (%r12 = curr_index)
movq $0,%r15    # initialises %r15 to 0 (%r15 = curr_sum)
jmp .loop       # jumps to label "loop"

.loop:          # definition of label "loop" starts here
cmpq %r12,%rdi  # compares N and curr_index 
je .result      # jumps to label "result"(if N = curr_index )
movq %rsi,%r14  # moves %rsi to %r14 (%r14 = curr_num)
imulq %r14,%r14 # multiplies curr_num with curr_num and stores it in curr_num
jo .multiply    # jumps to label "multiply" if overflow occurs in multiplication
.start:         # definition of label "start" starts here
addq %r14,%r15  # adds curr_num to curr_sum
jo .add         # jumps to label "add" if overflow occurs in multiplication
.restart:       # definition of label "restart" starts here
incq %rsi       # increments curr_num
incq %r12       # increments curr_index
jmp .loop       # jumps to label "loop"(loop-back)


.result:        # definition of label "result" starts here
movq %r15,%rax  # storing curr_sum into %rax
ret             # returns from fun6


.multiply:      # definition of label "multiply" starts here
subq %r11,%r14  # subtracting LONG_MAX result of multiplication 
subq $1,%r14    # subtracting $1 from %r14
jmp .start      # jumps back to label "start"

.add:           # definition of label "add" starts here
subq %r11,%r15  # subtracting LONG_MAX result of addition
subq $1,%r15    # subtracting $1 from %r15
jmp .restart    # jumps back to label "restart"

