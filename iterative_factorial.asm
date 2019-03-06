# Calculates factorial iteratively

.text

main:
    la $a0, n_prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    move $t0, $v0
    li $t1, 1 # counter
    li $t2, 1 # factorial

loop:
    blt $t0, $t1, print
    mul $t2, $t2, $t1
    addi $t1, $t1, 1
    j loop

print:
    la $a0, fact_prompt
    li $v0, 4
    syscall

    move $a0, $t2
    li $v0, 1
    syscall

    li $v0, 10
    syscall

.data
    n_prompt: .asciiz "n = "
    fact_prompt: .asciiz "n! = "