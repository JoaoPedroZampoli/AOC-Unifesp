.text
.globl main

main:
    li $t2, 10 # Load 10 no Registrador $t2
    li $v0, 1 # Carrega 1 no Registrador $v0 (para imprimir inteiro)
    move $a0, $t2 # Move o valor de $t2 para $a0
    syscall

    li $v0, 10 # Carrega 10 no Registrador $v0 (para sair do programa)
    syscall