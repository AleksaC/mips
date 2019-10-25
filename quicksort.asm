.data
    input_prompt: .asciiz "N = "
    input_prompt2: .asciiz "Elementi niza: \n"
    spacing: .asciiz " "

.text
quicksort:
    slt $t0, $a1, $a2
    beq $t0, $zero, return_quicksort

    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal partition
    lw $ra, 0($sp)

    addi $sp, $sp, -12
    sw $a1, 0($sp)
    sw $a2, 4($sp)
    sw $ra, 8($sp)
    sw $v0, 12($sp)

    addi $a2, $v0, -1
    jal quicksort

    lw $a1, 0($sp)
    lw $a2, 4($sp)
    lw $ra, 8($sp)
    lw $v0, 12($sp)

    sw $a1, 0($sp)
    sw $a2, 4($sp)
    sw $ra, 8($sp)

    addi $a1, $v0, 1
    jal quicksort

    lw $ra, 8($sp)
    addi $sp, $sp, 16

    return_quicksort:
        jr $ra

partition:
    mul $t0, $a2, 4
    add $t0, $a0, $t0
    lw $t1, 0($t0) # pivot

    mul $t2, $a1, 4
    add $t2, $a0, $t2# i
    move $t3, $t2 # j

    loop:
        beq $t3, $t0, return_partition
        
        lw $t4, 0($t3)
        slt $t5, $t4, $t1

        beq $t5, $zero, next
        
        lw $t5, 0($t2)

        sw $t4, 0($t2)
        sw $t5, 0($t3)
        
        addi $t2, $t2, 4
    
    next:
        addi $t3, $t3, 4
        j loop

    return_partition:
        lw $t3, 0($t2)
        
        sw $t1, 0($t2)
        sw $t3, 0($t0)

        sub $v0, $t2, $a0
        div $v0, $v0, 4
        
        jr $ra

main:
    la $a0, input_prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s0, $v0

    li $t0, 4
    mul $v0, $v0, $t0

    move $a0, $v0
    li $v0, 9
    syscall

    move $s1, $v0
    move $t0, $s1
    li $t1, 0

    la $a0, input_prompt2
    li $v0, 4
    syscall

    read_loop:
        beq $t1, $s0, sort
        li $v0, 5
        syscall
        sw $v0, 0($t0)
        addi $t0, $t0, 4
        addi $t1, $t1, 1
        j read_loop

    sort:
        move $a0, $s1
        li $a1, 0
        addi $a2, $s0, -1
        jal quicksort
    
    move $t0, $s1
    li $t1, 0

    print_loop:
        beq $t1, $s0, exit
        lw $a0, 0($t0)
        li $v0, 1
        syscall
        la $a0, spacing
        li $v0, 4
        syscall
        addi $t0, $t0, 4
        addi $t1, $t1, 1
        j print_loop

    exit:
        li $v0, 10
        syscall
