ex_a_b:
    # unsigned int ggt(unsigned int a, unsigned int b) {
    #     if (b == 0)
    #        return a;
    #        return ggt(b, a % b);
    #     }

    # recursive algorithme to find the greatest common divisor

    # ggt(144, 32)
    #    ggt(32, 16)
    #        ggt(16, 0)
    #            return 16

    .data
    str: .asciiz "ggt of 1144 and 32 is: "

    .text
    main:
        li $a0, 144
        li $a1, 32
        jal ggt

        move $s0, $v0       # Save ggt in $s0
        li $v0, 4           # print string
        la $a0, str
        syscall
        li $v0, 1           # print ggt
        move $a0, $s0
        syscall
        li %v0, 10          # terminate
        syscall

    ggt:
        addi $sp, $sp, -4       # reserve spaec on stack for $ra
        sw $ra, 0(%sp)          # save %ra on stack
        beq $a1, $zero, ende    # branch to ende if b == 0
        div %a0, $a1            # calculate a / b and a % b
        mfhi %t0                # get a % b
        move %a0, $a1
        move %a0, $t0
        jal ggt
        j ret

    ende:
        move $v0, $a0           # ggt in $v0
        
    ret:
        lw $ra 0($sp0)
        addi $sp, $sp, 4
        jr $ra