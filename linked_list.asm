.data
    razmak: .asciiz " "
    novi_red: .asciiz "\n"

.text
dodajNaPocetak:
    move $t0, $a0
    
    li $a0, 8
    li $v0, 9
    syscall

    sw $a1, 0($v0)
    sw $t0, 4($v0)

    jr $ra

dodajNaKraj:
    move $t0, $a0

    bne $a0, $zero, petlja
    
    li $a0, 8
    li $v0, 9
    syscall

    sw $a1, 0($v0)
    sw $t0, 4($v0)

    j return_dodajNaKraj

    petlja:
        lw $t1, 4($t0)
        beq $t1, $zero, dodaj
        move $t0, $t1
        j petlja
    
    dodaj:
        move $t1, $a0

        li $a0, 8
        li $v0, 9
        syscall
        
        sw $v0, 4($t0)
        sw $a1, 0($v0)
        sw $zero, 4($v0)

    move $v0, $t1

    return_dodajNaKraj:
        jr $ra

dodajIza:
    move $t0, $a0
    li $a0, 8
    li $v0, 9
    syscall

    move $a0, $t0

    sw $a2, 0($v0)

    beq $a0, $zero, return_dodajIza

    move $t0, $v0
    move $v0, $a0

    li $t1, 0

    nadji_posljednjeg:
        beq $a0, $zero, dodaj_iza
        lw $t2, 0($a0)
        bne $t2, $a1, dalje
        move $t1, $a0

    dalje:
        move $t3, $a0 
        lw $a0, 4($a0)
        j nadji_posljednjeg

    dodaj_iza:
        beq $t1, $zero, na_kraj
        lw $t3, 4($t1)
        sw $t3, 4($t0)
        sw $t0, 4($t1)
        j return_dodajIza
    
    na_kraj:
        sw $t0, 4($t3)

    return_dodajIza:
        jr $ra

brisi:
    beq $a0, $zero, kraj
    lw $t0, 0($a0)

    bne $t0, $a1, brisi_dalje

    lw $t1, 4($a0)
    move $v0, $t1

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    lw $a0, 4($a0)
    jal brisi

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    j return_brisi

    brisi_dalje:
        addi $sp, $sp, -8
        sw $ra, 0($sp)
        sw $a0, 4($sp)

        lw $a0, 4($a0)
        jal brisi

        lw $ra, 0($sp)
        lw $a0, 4($sp)
        addi $sp, $sp, 8
        
        sw $v0, 4($a0)
        move $v0, $a0
        
        j return_brisi

    kraj:
        li $v0, 0
    return_brisi:
        jr $ra

pojavljivanja:
    beq $a0, $zero, return_pojavljivanja

    lw $t0, 0($a0)
    bne $t0, $a1, sledeci

    addi $v0, $v0, 1
    move $v1, $t1

    sledeci:
        addi $t1, $t1, 1
        lw $a0, 4($a0)
        
        addi $sp, $sp, -4
        sw $ra, 0($sp)
        jal pojavljivanja
        lw $ra, 0($sp)
        addi $sp, $sp, 4

    return_pojavljivanja:
        jr $ra

stampa:
    beq $a0, $zero, rerurn_stampa

    move $t0, $a0

    lw $a0, 0($a0)
    li $v0, 1
    syscall

    la $a0, razmak
    li $v0, 4
    syscall

    lw $a0, 4($t0)

    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal stampa
    lw $ra, 0($sp)
    addi $sp, $sp, 4

    rerurn_stampa:
        jr $ra

main:
    li $s0, 0

    move $a0, $s0
    li $a1, 1
    jal dodajNaKraj
    move $s0, $v0

    move $a0, $s0
    li $a1, 7
    jal dodajNaPocetak
    move $s0, $v0

    move $a0, $s0
    li $a1, 3
    jal dodajNaPocetak
    move $s0, $v0

    move $a0, $s0
    li $a1, 5
    jal dodajNaPocetak
    move $s0, $v0

    move $a0, $s0
    li $a1, 10
    jal dodajNaKraj
    move $s0, $v0

    move $a0, $s0
    li $a1, 3
    jal dodajNaPocetak
    move $s0, $v0

    move $a0, $s0
    li $a1, 3
    jal brisi
    move $s0, $v0

    move $a0, $s0
    li $a1, 40
    li $a2, 9
    jal dodajIza
    move $s0, $v0

    move $a0, $s0
    li $a1, 3
    li $a2, 22
    jal dodajIza
    move $s0, $v0

    move $a0, $s0
    li $a1, 22
    jal brisi
    move $s0, $v0

    li $t1, 0
    li $v0, 0
    li $v1, -1

    move $a0, $s0
    li $a1, 3
    jal pojavljivanja

    move $t0, $v0
    move $t1, $v1

    move $a0, $t0
    li $v0, 1
    syscall

    la $a0, razmak
    li $v0, 4
    syscall

    move $a0, $t1
    li $v0, 1
    syscall

    la $a0, novi_red
    li $v0, 4
    syscall

    move $a0, $s0
    jal stampa

	li $v0, 10
	syscall
