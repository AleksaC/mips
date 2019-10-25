.data
    str1_prompt: .asciiz "Unesite prvi string: "
    str2_prompt: .asciiz "Unesite drugi string: "
.text
ucitajString:
    li $a0, 100
    li $v0, 9
    syscall

    move $t0, $v0

    move $a0, $v0
    li $a1, 100
    li $v0, 8
    syscall

    move $v0, $t0

    jr $ra


okreniString:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    sub $t0, $a0, $a1 
    bgez $t0, return_okreniString

    lb $t0, 0($a0)
    lb $t1, 0($a1)
    sb $t1, 0($a0)
    sb $t0, 0($a1)

    addi $a0, $a0, 1
    addi $a1, $a1, -1

    jal okreniString

    return_okreniString:
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra

LevenshteinDistance:
    beq $a1, $zero, ret_l2
    beq $a3, $zero, ret_l1

    add $t0, $a0, $a1
    addi $t0, $t0, -1

    lb $t1, 0($t0)

    add $t0, $a2, $a3
    addi $t0, $t0, -1

    lb $t2, 0($t0)

    beq $t1, $t2, cost_0
    li $t0, 1
    j recursion

    cost_0:
        li $t0, 0

    recursion:
        addi $sp, $sp, -16
        sw $a1, 0($sp)
        sw $a3, 4($sp)
        sw $t0, 8($sp)
        sw $ra, 12($sp)

        addi $a1, $a1, -1
        addi $a3, $a3, -1
        jal LevenshteinDistance

        lw $a1, 0($sp)
        lw $a3, 4($sp)
        lw $t0, 8($sp)
        lw $ra, 12($sp)

        add $t0, $t0, $v0

        sw $t0, 8($sp)
        sw $ra, 12($sp)

        addi $a1, $a1, -1
        jal LevenshteinDistance

        lw $a1, 0($sp)
        lw $a3, 4($sp)
        lw $t0, 8($sp)
        lw $ra, 12($sp)

        addi $v0, $v0, 1

        ble $t0, $v0, next
        move $t0, $v0

    next:
        sw $a1, 0($sp)
        sw $a3, 4($sp)
        sw $t0, 8($sp)
        sw $ra, 12($sp)

        addi $a3, $a3, -1
        jal LevenshteinDistance

        lw $a1, 0($sp)
        lw $a3, 4($sp)
        lw $t0, 8($sp)
        lw $ra, 12($sp)
        addi $sp, $sp, 16

        addi $v0, $v0, 1

        ble $t0, $v0, ret
        move $t0, $v0
        j ret

    ret_l2:
        move $v0, $a3
        j return_LevenshteinDistance
    ret_l1:
        move $v0, $a1
        j return_LevenshteinDistance

    ret:
        move $v0, $t0
    return_LevenshteinDistance:
        jr $ra

duzina:
    move $t1, $a0
    petlja:
        lb $t0, 0($t1)
        beq $t0, $zero, return_duzina 
        addi $t1, $t1, 1
        j petlja

    return_duzina:
        sub $v0, $t1, $a0
        addi $v0, $v0, -1
        jr $ra

main:
    la $a0, str1_prompt
    li $v0, 4
    syscall

    jal ucitajString
    move $s0, $v0

    la $a0, str2_prompt
    li $v0, 4
    syscall

    jal ucitajString
    move $s1, $v0

    move $a0, $s0
    jal duzina
    move $a1, $v0

    move $a0, $s1
    jal duzina
    move $a3, $v0

    move $a0, $s0
    move $a2, $s1
    jal LevenshteinDistance

    move $a0, $v0
    li $v0, 1
    syscall

    move $a0, $s0
    move $a1, $s0

    do_kraja:
        lb $t0, 0($a1)
        beq $t0, $zero, okreni
        addi $a1, $a1, 1
        j do_kraja

    okreni:
        addi $a1, $a1, -1
        jal okreniString

    move $a0, $s0
    li $v0, 4
    syscall

    li $v0, 10
    syscall
