.global fun4,fun5   #  makes the assembler export it (add it to the symbol table of the object) so that the linker can find it later for use in other translation units 
                    # fun4 checks whether a number is a prime number or not(if prime,returns 1;else,returns -1)
                    # fun5 finds the largest prime factor of N

fun4:               # definition of fun4 starts here(checks if N is prime)            
movq %rdi,%rsi      # copies(moves) N into %rsi
decq %rsi           # decrements %rsi
cmpq $1,%rdi        # compares N and 1
jle .illegal        # jumps to label "illegal" if N<=1
jmp .prime          # jumps to label "prime" if N>1

        .prime:     # definition of label "prime" starts here
            cmpq $1,%rsi    # compares %rsi and 1
            je .true        # jumps to label "true"(if %rsi=1),i.e,1 is the only solution of N%x=0 where 0<x<N
            movq %rdi,%rax  # idivq S signifies that it performs signed division of %rdx:%rax by S(Here we are moving %rdi into %rax)
            cqto            # converts quadword in %rax to octoword in %rdx:%rax 
            idivq %rsi      # quotient is  stored in %rax,remainder is stored in %rdx 
            cmpq $0,%rdx    # compares the remainder (of the above division operation) with 0
            je .false       # jumps to label "false"(if we encounter a number x such that N%x=0 where 1<x<N)
            decq %rsi       # decrements %rsi
            jmp .prime      # loops back to label "prime"




.false:             # definition of label "false" starts here
movq $-1,%rax       # we have found that N is composite(moves -1 into %rax)
ret                 # returns from fun4

.true:              # definition of label "true" starts here
movq $1,%rax        # we have found that N is prime(moves 1 into %rax)
ret                 # returns from fun4





fun5:               # definition of fun4 starts here(checks if N is prime) 
    movq %rdi,%r11  # store N in %r11 register(as changes may occur to %rdi in some instructions,but we want to know the initial value of N)
    movq %rdi,%rsi  # copies(moves) N into %rsi
    cmpq $1,%rdi    # compares N and 1
    jle .illegal    # jumps to label "illegal" if N<=1
    jmp .result     # jumps to label "result" if N>1

        .result:    # definition of label "result" starts here
            movq %r11,%rax  # idivq S signifies that it performs signed division of %rdx:%rax by S(Here we are moving %rdi into %rax)  
            cqto            # converts quadword in %rax to octoword in %rdx:%rax 
            idivq %rsi      # quotient is  stored in %rax,remainder is stored in %rdx 
            cmpq $0,%rdx    # compares the remainder (of the above division operation) with 0
            je .checkprime  # jumps to label "checkprime"
            .Lcontinue:     # definition of label "Lcontinue" starts here     
            decq %rsi       # decrements %rsi
            jmp .result     # jumps to label "result"
            
                



.Lprime:                    # definition of label "Lprime" starts here                    
        movq %r9,%rsi       # restore the value of %rsi from the prestored value register %r9
        movq %r11,%rdi      # restore the value of %rdi from the prestored value register %r11
        jmp .Lcontinue      # jumps to label "Lcontinue"

.checkprime:                # definition of label "checkprime" starts here  
            movq %rsi,%r9   # store %rsi in %r9 register(as changes may occur to %rsi in some instructions,but we want to know the initial value of %rsi)
            movq %r9,%rdi   # moves %r9 into %rdi
            call fun4       # calls fun4
            cmpq $-1,%rax   # compares -1 and %rax (basically checks if %rdi is composite)
            je .Lprime      # jumps to label "Lprime" (if %rax = -1)
            movq %r9,%rsi   # restore the value of %rsi from the prestored value register %r9
            cmpq $1,%rax    # compares 1 and %rax (basically checks if %rdi is prime)
            je .found       # jumps to label "found" (if %rax = 1)


.found:                     # definition of label "found" starts here
movq %rsi,%rax              # moves %rsi into %rax (%rsi = largest prime factor of N)
ret                         # returns from fun5

.illegal:                   # Label "illegal" is used when an invalid input is entered  
    movq $-1,%rax;          # In case of error or invalid input return ’-1’(move -1 to %rax)
    ret                     # return from the function which jumped into "illegal" label








