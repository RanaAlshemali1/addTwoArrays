.data	 		# data section 
arr1: .word 9, 8, 3, 8, 5, 2, 7, 4, 9, 1				# First array content
arr2: .word 6, 1, 5, 2, 3, 3, 6, 7, 1, 5			# Second array content
sum: .space 40								# Space for the sum array of size 10
parr1: .asciiz "Array1 = {9, 8, 3, 8, 5, 2, 7, 4, 9, 1}\n"		# First array content print statment
parr2: .asciiz "Array2 = {6, 1, 5, 2, 3, 3, 6, 7, 1, 5}\n"	# Second array content print statment
psum: .asciiz  " Sum   = {"							# Sum array printing statment
ppran: .asciiz "}\n"							# closed parenthese for the sum array
pcomma: .asciiz ", "							# Comma btw sum array

.text 			# text section
.globl main 		# call main by SPIM

main: 
	la $s0, arr1	# load address ‘arr1’ into $s0
	la $s1, arr2	# load address ‘arr2’ into $s1
	la $s2, sum	# load address ‘sum’ into $s2
	li $t0, 0	# set counter to 0
	li $t1, 10	# max count value
Loop: 
	beq $t0, $t1, Done	# if (i == 10) branch to Done
	lw $t2, 0($s0) 		# load word 0(arr1) into $t2
	lw $t3, 0($s1) 		# load word 0(arr2) into $t3
	add $s3, $t2, $t3	# add arr1[i] + arr2[i]
	sw $s3, 0($s2) 		# &sum[i] = s3
	addi $s0, 4		# move the pointer to the next element in arr1
	addi $s1, 4		# move the pointer to the next element in arr2
	addi $s2, 4		# move the pointer to the next element in sum
	addi $t0, 1		# increase the counter by 1
	j Loop			# jump to loop
Done: 
	la $s2, sum	# load address ‘sum’ into $s2
	la $a0, parr1  	# load address ‘parr1’ into $a0 to print array1
	li $v0, 4	# system call code for print_str
	syscall		# print the string
	la $a0, parr2 	# load address ‘parr2’ into $a0 to print array2
	li $v0, 4	# system call code for print_str
	syscall		# print the string
	la $a0, psum  	# load address ‘psum’ into $a0 to print the sum string
	li $v0, 4	# system call code for print_str
	syscall		# print the string
	lw $a0, ($s2)	# load the first elemnt in the 'sum' array
	li $v0, 1 	# system call code for print_int
	syscall		# print the int
			# here we print the first element in the 'sum' array so we 
			# can have the commas in order inside the loop. 
			# (elemnt then comma) except for the last one
	li $t0, 1	# set i = 0
	li $t1, 10	# set max vale for counter = 10
Print:
	la $a0, pcomma  	# load address ‘pcomma’ into $a0 to print the comma 
	li $v0, 4		# system call code for print_str
	syscall			# print the string
	addi $s2, 4		# move the array pointer to the next element
	addi $t0, 1		# i++
	lw $a0, ($s2)		# load the next array elemnt
	li $v0, 1 		# system call code for print_int
	syscall			# print the int
	bne $t0, $t1, Print	# if (i != 10 ) loop again
Exit:
	la $a0, ppran  	# load address ‘ppran’ into $a0 to print the parenthese 
	li $v0, 4	# system call code for print_str
	syscall		# print the string
# End
	li	$v0, 10
	syscall

