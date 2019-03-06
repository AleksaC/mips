# Computes sum of first n integers in a loop

.text

main:
	la $a0, n_prompt
	li $v0, 4
	syscall

	li $v0, 5
	syscall

	move $t0, $v0

	li $t1, 0 # current number
    li $t2, 0 # sum

loop:
    blt $t0, $t1, print
    add $t2, $t1, $t2
    addi $t1, $t1, 1
    j loop

print:
    la $a0, sum_prompt
    li $v0, 4
    syscall

    move $a0, $t2
    li $v0, 1
    syscall

    li $v0, 10
    syscall

.data
	n_prompt: .asciiz "n = "
	sum_prompt: .asciiz "Sum of first n integers is: "
