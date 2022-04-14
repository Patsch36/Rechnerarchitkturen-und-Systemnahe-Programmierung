
# data declarations
#
.data 
str1: .asciiz "Enter the First Operand: "
str2: .asciiz "Enter the Second Operand: "
str3: .asciiz "2 * A + 3 * B + A * B is "
str4: .asciiz " Done [0 = Yes, 1 = No]: "
newline: .asciiz "\n"  # This will cause the screen cursor to move to a newline

.align 2

# code
#
.globl main			
.text			
	
main: 
	la $a0, str1	# load string address into $a0 and I/O code into $v0     
	li $v0, 4		      
	syscall  		# execute the syscall to perform input/output via the console        

	li $v0, 5       # an I/O sequence to read an integer from 
					# the console window
	syscall 
	move $t0, $v0	# place the value read into register $t0

	la $a0, str2	# Load address of string 2 into register $a0
	li $v0, 4		# Load I/O code to print string to console
	syscall			# print string

	li $v0, 5		# an I/O sequence to read an integer from the console 	
	syscall 
	move $t1, $v0	# place the value read into register $t1


    sll $t2, $t0, 1   # Perform 2 * A
    mul $t3, $t1, 3   # Perform 3 * B
    mul $t4, $t0, $t1  # Perform A * B

    add $t5, $t2, $t3   # add first two results
    add $t6, $t5, $t4   # add Last result

    sw $t6, z

	la $a0, str3	# Load address of string 3 into register $a0
	li $v0, 4		# Load I/O code to print string to console
	syscall			# print string

	li $v0, 1		# an I/O sequence to print an integer to the console window
	move $a0, $t6	
	syscall 

	la $a0, newline	# print the new line character to force a carriage return 
	li $v0, 4		# on the console
	syscall 

	la $a0, str4	# Load address of string 5 into register $a0
	li $v0, 4		# Load I/O code to print string to console
	syscall			# print string

	li $v0, 5		# an I/O sequence to read an integer from the console
	syscall 

	bne $v0,$0, main	# if not complete (i.e., you provided 0) then start at 
					# the beginning

	li $v0, 10		# syscall code 10 for terminating the program
	syscall


