.data
    max_pos : .word 0b0111111111111111111111111111111

calc5:

   # move $fp, $sp

    addi $sp, $sp, -12      # space for three words
    sw $fp, 4($sp)          # save $fp
    addi $fp, $sp, 12       # set $fp to begin of frame
    sw $ra, -4($fp)         # save  $ra on stack
    li $t0, -1
    sw $t0 -12($fp)         # set res to -1

    #addi $t0, $zero, -1     # res = -1

    mul $t1, $a0, $a1       # a * b
    mul $t2, $a2, $a2       # c * d

    add $t0, $t0, $t1        
    add $t0, $t0, $t2       # -1 + ax + cds in $to

    lw $t3 0($fp)           # load q from stack
    div $v0, $t0, $t3       # res in $v0

    sw $v0, -12($fp)        # store res

    lw $ra, -4($fp)         # restore $ra
    lw $fp, 4($sp)          # restore $fp
    addi $sp, $sp, 16       # free space from stack

    jr $ra

save_div:
    bne $a1, $zero, change_v0       # if b == 0, return max_pos
    move $v0, max_pos
    jr $ra
    change_vo:
        div $v0, $a0, $a1           # if b != 0, return a / b
        jr $ra

# code
#
.global main			
.text

main:
    li $a0, 1
    li $a1, 1
    li $a2, 1
    li $a3, 1
    li $t0, 5

    sw $t0, 0($sp)



