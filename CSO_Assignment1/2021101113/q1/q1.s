# It is preassumed that negative remainders are made +ve by adding divisior value and the quotient is adjusted accordingly(For example:when -11 is divided by 4,remainder is -3 ,now for making remainder +ve we add 4 and report the answer as -3 and 1)
.global fun1,fun2   #  makes the assembler export it (add it to the symbol table of the object) so that the linker can find it later for use in other translation units
                    # fun1 finds the remiander and fun2 finds the quotient when M is divided by N
                    # Labels are symbolic names which are used to identify memory locations that are referred to explicitly in the program
.illegal:           # Label "illegal" is used when an invalid input is entered
    movq $-1,%rax   # In case of error or invalid input return ’-1’
    ret             # return from the function which jumped into "illegal" label

.zero:              # definition of label "zero" starts here
    movq $0,%rax    # moves 0 into %rax
    ret             # returns from fun1

fun1:               # definition of fun1 starts here(computes remainder)
    cmpq $0,%rsi    # checks whether N is 0
    je .illegal     # jumps to "illegal" label when N=0   
    
    cmpq $0,%rdi    # checks if M is 0
    je .zero        # jumps to label "zero" if M=0 and N!=0    


    cmpq $0,%rdi    # checks whether M is greater than 0
    jg .Mpve        # if M>0,jumps to "Mpve" label
    jmp .Mnve       # if M<0,jumps to "Mnve" label


    .Mpve:      # definition of Mpve starts here(M>0)
    cmpq $0,%rsi        # compares N and 0
    jg .MpveNpve        # if N>0,jumps to label "MpveNpve"
    jmp .MpveNnve       # if N<0,jumps to label "MpveNnve"


        .MpveNpve:      # definition of label "MpveNpve" starts here(when M>0&&N>0)
            cmpq %rsi,%rdi              # compares M and N
            jge .testMpveNpve           # jumps to label "testMpveNpve",if M>=N,as we want to get a number x such that x=M-(k*N),where 0<=x<N        
            .L1:                        # definition of label "L1" starts here
            jmp .testMpve               # jumps to label "testMpve"
            
           

        .MpveNnve:      # definition of label "MpveNnve" starts here(when M>0&&N<0)            
            imulq $-1,%rsi              # we make N>0 by multiplying with -1
            cmpq %rsi,%rdi              # compares M and N
            jge .testMpveNnve           # if M>=N,jumps to label "testMpveNnve",if M>=N,as we want to get a number x such that x=M-(k*N),where 0<=x<N
            .L2:                        # definition of label "L2" starts here
            jmp .testMpve               # jumps to label "testMpve"
            



    .Mnve:      # definition of Mpve starts here(M<0)   
    cmpq $0,%rsi        # compares N and 0       
    jg .MnveNpve        # if N>0,jumps to label "MnveNpve"
    jmp .MnveNnve       # if N<0,jumps to label "MnveNnve"



    .MnveNpve:          # definition of label "MnveNpve" starts here(when M<0&&N>0)   
           imulq $-1,%rdi               # we make M>0 by multiplying with -1               
           cmpq %rsi,%rdi               # compares M and N                
           jmp .testMnveNpve            # jumps to label "testMnveNpve",if M>=N,as we want to get a number x such that x=M-(k*N),where 0<=x<N
           .L3:                         # definition of label "L3" starts here
           jmp .testMnve                # jumps to label "testMnve"                



           
    .MnveNnve:         # definition of label "MnveNnve" starts here(when M<0&&N<0)   
           imulq $-1,%rdi               # we make M>0 by multiplying with -1
           imulq $-1,%rsi               # we make N>0 by multiplying with -1
           cmpq %rsi,%rdi               # compares M and N
           jge .testMnveNnve            # if M>=N,jumps to label "testMnveNnve",if M>=N,as we want to get a number x such that x=M-(k*N),where 0<=x<N           
           .L4:                         # definition of label "L4" starts here
           jmp .testMnve                # jumps to label "testMnve"

            


        


 .testMpve:             # definition of label "testMpve" starts here(when M>0)  
         movq %rdi,%rax         # copies remainder(moves) into %rax
             ret                # returns from fun1
        
        
 .testMnve:             # definition of label "testMnve" starts here(when M<0)             
         imulq $-1,%rdi         # makes remainder negative
         addq %rsi,%rdi         # now add N to remainder(so that 0<=remainder<N)
         movq %rdi,%rax         # copies remainder(moves) into %rax
         ret                    # returns from fun1
        
 .testMpveNpve:         # definition of label "testMpveNpve" starts here(when M>0&&N>0) 
         subq %rsi,%rdi         # subtracts N from %rdi       
         cmpq %rsi,%rdi         # compares %rdi and N
         jge .testMpveNpve      # this loop repeats until the value of %rdi becomes less than N
         jmp .L1                # jumps to label "L1"
        

 .testMpveNnve:         # definition of label "testMpveNnve" starts here(when M>0&&N<0) 
         subq %rsi,%rdi         # subtracts N from %rdi
         cmpq %rsi,%rdi         # compares %rdi and N
         jge .testMpveNnve      # this loop repeats until the value of %rdi becomes less than N
         jmp .L2                # jumps to label "L2"
        

 .testMnveNpve:         # definition of label "testMnveNpve" starts here(when M<0&&N>0)
         subq %rsi,%rdi         # subtracts N from %rdi
         cmpq %rsi,%rdi         # compares %rdi and N
         jge .testMnveNpve      # this loop repeats until the value of %rdi becomes less than N
         jmp .L3                # jumps to label "L3"

 .testMnveNnve:         # definition of label "testMnveNnve" starts here(when M<0&&N<0)
         subq %rsi,%rdi         # subtracts N from %rdi
         cmpq %rsi,%rdi         # compares %rdi and N
         jge .testMnveNnve      # this loop repeats until the value of %rdi becomes less than N
         jmp .L4                # jumps to label "L4"
 
 
 
 
 
 
                
        

fun2:                           # definition of fun2 starts here(computes quotient)
    cmpq $0,%rsi                # checks whether N is 0
    je .illegal                 # jumps to "illegal" label when N=0
    movq $0,%r13                # %r13 is used to store the quotient(we increment it in loops),it is initialised to 0
    cmpq $0,%rdi                # checks whether M is greater than 0
    jg .QMpve                   # if M>0,jumps to "QMpve" label
    jmp .QMnve                  # if M<0,jumps to "QMnve" label

    .QMpve:                     # definition of QMpve starts here(M>0)
    cmpq $0,%rsi                # compares N and 0
    jg .QMpveNpve               # if N>0,jumps to label "QMpveNpve"
    jmp .QMpveNnve              # if N<0,jumps to label "QMpveNnve"
     
        .QMpveNpve:             # definition of label "QMpveNpve" starts here(when M>0&&N>0)
            cmpq %rsi,%rdi      # compares M and N
            jg .QtestMpveNpve   # jumps to label "QtestMpveNpve",if M>=N,as we want to get a number k such that x=M-(k*N),where 0<=x<N
            .L21:               # definition of label "L21" starts here
              jmp .samesign     # jumps to label "samesign"

        .QMpveNnve:             # definition of label "QMpveNnve" starts here(when M>0&&N<0)
            imulq $-1,%rsi      # we make N>0 by multiplying with -1
            cmpq %rsi,%rdi      # compares M and N
            jg .QtestMpveNnve   # if M>=N,jumps to label "QtestMpveNnve",if M>=N,as we want to get a number k such that x=M-(k*N),where 0<=x<N
            .L22:               # definition of label "L22" starts here
              jmp .diffsign     # jumps to label "diffsign"

    .QMnve:                     # definition of label "QMnve" starts here(when M>0&&N<0)
    cmpq $0,%rsi                # compares N and 0
    jg .QMnveNpve               # if N>0,jumps to label "QMnveNpve"
    jmp .QMnveNnve              # if N<0,jumps to label "QMnveNnve"

        .QMnveNpve:             # definition of label "QMnveNpve" starts here(when M<0&&N>0)
            imulq $-1,%rdi      # we make M>0 by multiplying with -1
            cmpq %rsi,%rdi      # compares M and N
            jg .QtestMnveNpve   # jumps to label "QtestMnveNpve",if M>=N,as we want to get a number k such that x=M-(k*N),where 0<=x<N
            .L23:               # definition of label "L23" starts here
              jmp .diffsign     # jumps to label "diffsign"

        .QMnveNnve:             # definition of label "QMnveNnve" starts here(when M<0&&N<0)
           imulq $-1,%rdi       # we make M>0 by multiplying with -1
           imulq $-1,%rsi       # we make N>0 by multiplying with -1
           cmpq %rsi,%rdi       # compares M and N
           jg .QtestMnveNnve    # jumps to label "QtestMnveNnve",if M>=N,as we want to get a number k such that x=M-(k*N),where 0<=x<N
            .L24:               # definition of label "L24" starts here
              jmp .samesign     # jumps to label "samesign"

         



        .samesign:              # definition of label "samesign" starts here(when M/N>0)
                movq %r13,%rax  # copies quotient(moves) into %rax
                ret             # returns from fun1            

        .diffsign:              # definition of label "diffsign" starts here(when M/N<0)                            
                imulq $-1,%r13  # makes quotient negative
                movq %r13,%rax  # copies quotient(moves) into %rax
                ret             # returns from fun1


        .QtestMpveNpve:         # definition of label "QtestMpveNpve" starts here(when M>0&&N>0)
                subq %rsi,%rdi  # subtracts N from %rdi
                incq %r13       # increments %r13
                cmpq %rsi,%rdi  # compares N and %rdi  
                jge .QtestMpveNpve      # this loop repeats until the value of %rdi becomes less than N     
                jmp .L21        # jumps to label "L21"       

        .QtestMpveNnve:         # definition of label "QtestMpveNnve" starts here(when M>0&&N<0)
                subq %rsi,%rdi  # subtracts N from %rdi
                incq %r13       # increments %r13
                cmpq %rsi,%rdi  # compares N and %rdi
                jge .QtestMpveNnve      # this loop repeats until the value of %rdi becomes less than N
                jmp .L22        # jumps to label "L22"

        .QtestMnveNpve:         # definition of label "QtestMnveNpve" starts here(when M<0&&N<0)
                subq %rsi,%rdi  # subtracts N from %rdi
                incq %r13       # increments %r13
                cmpq %rsi,%rdi  # compares N and %rdi
                jge .QtestMnveNpve     # this loop repeats until the value of %rdi becomes less than N 
                incq %r13       # increments %r13
                jmp .L23        # jumps to label "L23"

        .QtestMnveNnve:         # definition of label "QtestMnveNnve" starts here(when M<0&&N<0)
                subq %rsi,%rdi  # subtracts N from %rdi
                incq %r13       # increments %r13
                cmpq %rsi,%rdi  # compares N and %rdi
                jge .QtestMnveNnve      # this loop repeats until the value of %rdi becomes less than N 
                incq %r13       # increments %r13
                jmp .L24        # jumps to label "L24"
              




