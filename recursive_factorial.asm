# Recursively calculates factorial of a given integer

.data
    n_prompt: .asciiz "n = "
    fact_prompt: .asciiz "n! = "

.text
factorial:
    addi $sp, $sp, -8
    sw $a0, 0($sp)
    sw $ra, 4($sp)

    ble $a0, 1, base_case
    addi $a0, $a0, -1
    jal factorial

    lw $a1, 0($sp)
    mul $v0, $v0, $a1
    j return 

base_case:
    li $v0, 1

return:
    lw $ra, 4($sp)
    add $sp, $sp, 8
    jr $ra

main:
    la $a0, n_prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    move $a0, $v0
    jal factorial
    move $t0, $v0

    la $a0, fact_prompt
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    li $v0, 10
    syscall
