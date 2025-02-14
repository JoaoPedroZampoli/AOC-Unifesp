.data
    msg1: .asciiz "Entre com o numero: \n"
    msg2: .asciiz " "
    msg3: .asciiz "\nF("
    msg3part2: .asciiz "): "

.text
.globl main

main:
    # Imprimir mensagem1
    li $v0, 4
    la $a0, msg1
    syscall

    # Ler N
    li $v0, 5
    syscall
    move $t0, $v0 # $t0 = N

    # Inicializar soma
    li $t1, 1 # $t1 = 1
    li $t2, 1 # $t2 = 1

    # Inicializa contador
    li $t3, 2 # $t3 = 0

    # Imprimir primeiros dois valores
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, msg2
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, msg2
    syscall

loop:
    beq $t3, $t0, fimLoop
    add $t4, $t1, $t2
    move $t1, $t2
    move $t2, $t4
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, msg2
    syscall
    addi $t3, $t3, 1
    j loop

fimLoop:
    # Imprimir mensagem2
    li $v0, 4
    la $a0, msg3
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, msg3part2
    syscall
    li $v0, 1
    move $a0, $t4
    syscall

    # Encerra o programa
    li $v0, 10
    syscall
