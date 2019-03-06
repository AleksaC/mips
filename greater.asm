# Loads 2 integers and prints the greater of the two

.data
    num_prompt: .asciiz "Enter a number: "
    greater_prompt: .asciiz "The greater number is: "

.text
main:
    la $a0, num_prompt
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    
    move $t0, $v0
    
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    
    move $t1, $v0
    
    la $a0, greater_prompt
    li $v0, 4
    syscall
    
    blt $t0, $t1, print
    move $t1, $t0
	
print:
    move $a0, $t1
    li $v0, 1
    syscall
    
    li $v0, 10
    syscall
