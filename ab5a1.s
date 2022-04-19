ex_a:  
    # Test if unsigned a + unsigned b results to an overflow
    # a is stored in $s1, b in $s2

    addi $t0, $zero, -1     # 2^n - 1
    sub $t0, $t0, $s1       # 2^n-1 - a
    bgt $s2, $t0, overflow  # b > t0 results in an overflow



ex_b:

    # Add 64 bit numbers on 32 bit architecture
    # a in $s1, $s0, b in $s3, $s2

    add $s4, $s0, $s2       # Add lower half
    add $s5, $s1, $s3       # Add upper half
    # result is only correct, if theres no overflow from lower half to upper half
    addi $t0, $zero, -1     # 2^n - 1
    sub $t0, $t0, $s0       # 2^n-1 - lower-a
    ble $s2, $t0, continue  # lower b > t0 results in an overflow, branch lower-equal is contrary to greater-than
    addi $s5, $s5, 1        # If there's an overflow, add 1 to upper half
continue: