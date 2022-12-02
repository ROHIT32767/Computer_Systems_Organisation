.global fun1            # makes the assembler export it (add it to the symbol table of the object) so that the linker can find it later for use in other translation units
# We intake 3 parameters n,&A[0],&B[0] and we modify array B through the operations performed by pushing elements of array A onto the stack and we print elements of array B in q1.c
.illegal:               # Label "illegal" is used when an invalid input is entered
movq $-1,%rax           # In case of error or invalid input return ’-1’
ret                     # return from function fun1
fun1:                   # definition of fun1 starts here(modifies an array into a new array where each of element of the array corresponds to the next greatest element of that corresponding element in main array)
cmpq $1,%rdi            # checks whether N is less than 1
jl .illegal             # jumps to "illegal" label when N<1   
cmpq $100,%rdi          # compares N and 100
jg .illegal             # jumps to "illegal" label when N>100       
movq %rdi,%r12          # moves(copies) n into %r12 register
decq %rdi               # decrements %rdi (%rdi=n-1)
movq %rsp,%r15          # moves (copies)current address pointed by stack pointer into %r15 register so that the system can be retrieved back to the same state before fun1 was called
movq $-1,(%rdx,%rdi,8)  # performs B[n-1]=-1
pushq (%rsi,%rdi,8)     # pushes A[n-1] onto the stack
decq %rdi               # decrements %rdi (%rdi=n-2)
jmp .stack              # jumps to label "stack"

.stack:                 # definition of label "stack" starts here               
cmpq $0,%rdi            # basically we are writing a for-loop of the form for(int i=n-2;i>=0;i--),hence we are comparing i and 0
jl .answer              # jumps to label "zero" if i<0 
movq (%rsi,%rdi,8),%r11 # moves or stores A[i] into %r11 register
jmp .while              # jumps to label "while",basically we are running a while loop of the form while(Top!=NULL&&(Top->val<A[i]))
 

.test:                  # definition of label "test" starts here
cmpq %rsp,%r15          # compares Top and initial value of %rsp
je .if                  # jumps to "if" label if Top=initial value of %rsp
cmpq (%rsp),%r11        # compares Top->val and A[i]
jl .else                # jumps to "else" label if (Top->val)< A[i]
jmp .backtowhile        # jumps to label "backtowhile" ,basically if both the conditions are unmet we rerun the while loop

 
.while:                 # definition of label "while" starts here  
jmp .test               # jumps to label "test"
.backtowhile:           # definition of label "backtowhile" starts here
popq %r9                # pops Top of stack
jmp .test               # jumps to label "test" ,basically to check if both the conditions are met 


.if:                    # definition of label "if" starts here,basically after breaking out of the while loop,we are checking if(Top==NULL)
movq $-1,(%rdx,%rdi,8)  # performs the operation B[i]=-1
pushq (%rsi,%rdi,8)     # pushes A[i] into the stack
decq %rdi               # decrements i
jmp .stack              # jumps to label "stack"
.else:                  # definition of label "else" starts here,basically after breaking out of the while loop,we are checking if(Top!=NULL)
movq (%rsp),%r8         # moves Top->val into %r8 register
movq %r8,(%rdx,%rdi,8)  # performs the operation B[i]=Top->val
pushq (%rsi,%rdi,8)     # pushes A[i] into the stack
decq %rdi               # decrements i
jmp .stack              # jumps to label "stack"

.test1:                 # definition of label "test1" starts here
cmpq %rsp,%r15          # compares %rsp and initial value of %rsp,if we dont clear the new contents added to the stack,we will get segmentation fault
je .return              # jumps to label "return",if %rsp=initial value of %rsp
jmp .answer1            # jumps to label "answer1",if %rsp!=initial value of %rsp

.answer:                # definition of label "answer" starts here
jmp .test1              # jumps to label "test1"
.answer1:               # definition of label "answer1" starts here
popq %r10               # we pop the stack until %rsp = initial value of %rsp
jmp .test1              # jumps to label "test1"


.return:                # definition of label "return" starts here
ret                     # returns from fun1


