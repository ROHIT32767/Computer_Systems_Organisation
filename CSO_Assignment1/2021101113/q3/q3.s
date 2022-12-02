.global fun4    #  makes the assembler export it (add it to the symbol table of the object) so that the linker can find it later for use in other translation units 
                # fun4 checks whether a number is a prime number or not(if prime,returns 1;else,returns -1)
.illegal:       # Label "illegal" is used when an invalid input is entered           
    movq $-1,%rax   # In case of error or invalid input return ’-1’(move -1 to %rax)  
    ret             # returns from fun4 


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

