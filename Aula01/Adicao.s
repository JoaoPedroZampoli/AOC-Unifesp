.text
.globl main

main:
    li $t0, 25 # Load 25 no Registrador $t0
    li $t1, 10 # Load 10 no Registrador $t1
    add $t2, $t0, $t1 # Soma $t0 e $t1 e armazena em $t2
    li $v0, 10 # Carrega 10 no Registrador $v0 (para sair do programa)
    syscall