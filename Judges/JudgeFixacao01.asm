.data 
    msg1: .asciiz "Defina a qtde de inteiros a serem somados: "
    msg2: .asciiz "O resultado eh: "

.text
.globl main

main:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $t1, 0

    li $t2, 0

loop:
    beq $t2, $t0, fimLoop

    li $v0, 5
    syscall
    add $t1, $t1, $v0

    addi $t2, $t2, 1
    j, loop

fimLoop:
    li $v0, 4
    la $a0, msg2 