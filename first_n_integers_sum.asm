#
.text

main:
	la $a0, n_prompt
	li $v0, 4
	syscall

	li $v0, 5
	syscall

	move $t0, $v0

	move $t1, $


	li $v0, 10
	syscall
    
.data
	n_prompt: .asciiz "n = "
	sum_prompt: .asciiz "Sum of first n integers is: "