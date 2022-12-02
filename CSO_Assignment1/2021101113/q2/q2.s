.global fun3    #  makes the assembler export it (add it to the symbol table of the object) so that the linker can find it later for use in other translation units
                # fun3 finds the greatest common divisor of two positive integers M and N

.illegal:       # Label "illegal" is used when an invalid input is entered  
    movq $-1,%rax;  # In case of error or invalid input return ’-1’(move -1 to %rax)
    ret             # returns from fun3

.makepositiveM:     # definition of label "makepositiveM" starts here(when M<0)   
imulq $-1,%rdi      # multiplies M with -1
jmp .back1          # jumps to label "back1"

.makepositiveN:     # definition of label "makepositiveN" starts here(when N<0)   
imulq $-1,%rsi      # multiplies N with -1    
jmp .back           # jumps to label "back"         


.zerocaseM:         # definition of label "zerocaseM" starts here(when M=0)   
cmpq $0,%rsi        # comparing N and 0       
jl .makepositiveN   # jumps to label "makepositiveN" if N<0
.back:              # definition of label "back" starts here(when M=0)   
movq %rsi,%rax      # stores the value of %rsi into %rax      
ret                 # returns from fun3

.positiveM:         # definition of label "positiveM" starts here(when M<0) 
imulq $-1,%rdi      # multiplies M with -1
jmp .Mpve           # jumps to label "Mpve"

.positiveN:         # definition of label "positiveN" starts here(when N<0) 
imulq $-1,%rsi      # multiplies N with -1
jmp .Npve           # jumps to label "Npve"

.zerocaseN:         # definition of label "zerocaseN" starts here(when N=0) 
cmpq $0,%rdi        # comparing M and 0  
jl .makepositiveM   # jumps to label "makepositiveM" if M<0
.back1:             # definition of label "back1" starts here(when N=0) 
movq %rdi,%rax      # stores the value of %rdi into %rax 
ret                 # returns from fun3


fun3:               # definition of fun3 starts here(computes GCD)
cmpq $0,%rdi        # comparing M and 0
je .zerocaseM       # jumps to zerocaseM,if M=0
cmpq $0,%rsi        # comparing N and 0
je .zerocaseN       # jumps to zerocaseN,if N=0
cmpq $0,%rdi        # comparing M and 0
jl .positiveM       # Since GCD of negative numbers is defined as gcd(a,b)=gcd(|a|,|b|),if M<0,we jump to label "positiveM"
.Mpve:              # definition of label "MPve" starts here(Now M is made +ve)
cmpq $0,%rsi        # comparing N and 0
jl .positiveN       # Since GCD of negative numbers is defined as gcd(a,b)=gcd(|a|,|b|),if N<0,we jump to label "positiveN"
.Npve:              # definition of label "NPve" starts here(Now N is made +ve)
movq %rsi,%r10      # store N in %r10 register(as changes may occur to %rsi in some instructions,but we want to know the initial value of N)
movq %rdi,%r11      # store M in %r11 register(as changes may occur to %rdi in some instructions,but we want to know the initial value of M)
cmpq %rsi,%rdi      # compares M and N
je .same            # jumps to label "same",if M=N,as GCD(x,x)=x
cmpq %rsi,%rdi      # compares M and N
jg .Nsmall          # jumps to label "Nsmall",if M>N,as we want to get a number x such that M%x=0 and N%x=0 where 0<x<N 
jmp .Msmallcheck    # jumps to label "Msmallcheck",if M<N,as we want to get a number x such that M%x=0 and N%x=0 where 0<x<M 


    .Nsmall:        # definition of label "Nsmall" starts here(when M>N)        
    movq %rdi,%rax  # idivq S signifies that it performs signed division of %rdx:%rax by S(Here we are moving %rdi into %rax)
    cqto            # converts quadword in %rax to octoword in %rdx:%rax 
    idivq %rsi      # quotient is  stored in %rax,remainder is stored in %rdx 
    cmpq $0,%rdx    # compares the remainder (of the above division operation) with 0
    je .othercheck1 # jumps to label "othercheck1" if remainder=0
    .LQ21:          # definition of label "LQ21" starts here
    jmp .NSforloop  # jumps to label "NSforloop"(N<M)
    
        .NSforloop: # definition of "NSforloop" starts here(N<M) 
        decq %rsi   # decrements %rsi
        jmp .Nsmall # jumps to label "Nsmall"(N<M)


    .Msmallcheck:   # definition of label "Msmallcheck" starts here(when M<N)   
    movq %rsi,%r8   # Here we are swapping M and N ,so as to ease our operation for both cases M<N and M>N   
    movq %rdi,%rsi  # To facilitate swapping,we are using (a temp kind of variable)%r8 register
    movq %r8,%rdi   # Now %rdi=N and %rsi=M,let M'=N and N'=M
    jmp .Msmall     # jumps to label "Msmall"(when M<N)

    .Msmall:        # definition of label "Msmall" starts here(when M<N)
    movq %rdi,%rax  # idivq S signifies that it performs signed division of %rdx:%rax by S(Here we are moving %rdi into %rax)
    cqto            # converts quadword in %rax to octoword in %rdx:%rax  
    idivq %rsi      # quotient is  stored in %rax,remainder is stored in %rdx       
    cmpq $0,%rdx    # compares the remainder (of the above division operation) with 0
    je .othercheck2 # jumps to label "othercheck2" if remainder=0
    .LQ22:          # definition of label "LQ22" starts here          
    jmp .MSforloop  # jumps to label "MSforloop"(N>M)  
    
        .MSforloop: # definition of "NSforloop" starts here(N<M) 
        decq %rsi   # decrements %rsi
        jmp .Msmall # jumps to label "Msmall"(N<M)

 


.othercheck1:       # definition of label "othercheck1" starts here(when M<N)       
movq %r10,%rdi      # uses the prestored value of N to know whether %rsi divides N,given that %rsi divides M
movq %rdi,%rax      # idivq S signifies that it performs signed division of %rdx:%rax by S(Here we are moving %rdi into %rax)
cqto                # converts quadword in %rax to octoword in %rdx:%rax
idivq %rsi          # quotient is  stored in %rax,remainder is stored in %rdx
cmpq $0,%rdx        # compares the remainder (of the above division operation) with 0
je .same            # jumps to label "same" if remainder=0
movq %r11,%rdi      # if %rsi doesnt divide N((N%rsi)!=0),restore the value of M from the prestored value register %r11
jmp .LQ21           # jumps to label "LQ21" if (N%rsi)!=0

.othercheck2:       # definition of label "othercheck2" starts here(when M'<N')
movq %r11,%rdi      # uses the prestored value of M to know whether %rsi divides M,given that %rsi divides N
movq %rdi,%rax      # idivq S signifies that it performs signed division of %rdx:%rax by S(Here we are moving %rdi into %rax)
cqto                # converts quadword in %rax to octoword in %rdx:%rax
idivq %rsi          # quotient is  stored in %rax,remainder is stored in %rdx
cmpq $0,%rdx        # compares the remainder (of the above division operation) with 0
je .same            # jumps to label "same" if remainder=0
movq %r10,%rdi      # if %rsi doesnt divide M((M%rsi)!=0),restore the value of N from the prestored value register %r10
jmp .LQ22           # jumps to label "LQ21" if (N%rsi)!=0


.same:              # definition of label "same" starts here(first instance of a number x such that M%x=0 and N%x=0)
movq %rsi,%rax      # stores the value of %rsi into %rax
ret                 # returns from fun3

 

 




