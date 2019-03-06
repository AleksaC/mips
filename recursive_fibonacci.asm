# Recursively calculates nth fibonacci number

.text

fib:
    addi $sp, $sp, -12
    sw $a0, 0($sp)
    sw $ra, 4($sp)

    beq $a0, 0, base_case_0
    beq $a0, 1, base_case_1

    addi $a0, $a0, -1
    jal fib
    
    sw $v0, 8($sp)

    lw $a0, 0($sp)

    addi $a0, $a0, -2
    jal fib

    lw $t0, 8($sp)

    add $v0, $v0, $t0
    j return

base_case_0:
    li $v0, 0
    j return

base_case_1:
    li $v0, 1

return:
    lw $ra, 4($sp)
    addi $sp, $sp, 12
    jr $ra

main:
    la $a0, n_prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    move $a0, $v0
    jal fib

    move $t0, $v0

    la $a0, fib_prompt
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    li $v0, 10
    syscall

.data
    n_prompt: .asciiz "n = "
    fib_prompt: .asciiz "nth Fibonacci number is: "
