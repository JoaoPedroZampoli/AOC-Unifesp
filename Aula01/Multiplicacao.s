.text
.globl main

main:
    li $t1, 02 # Load 2 no Registrador $t1
    li $t2, 03 # Load 3 no Registrador $t2
    mul $t0, $t1, $t2 # Multiplica $t1 e $t2 e armazena em $t0
    li $v0, 10 # Carrega 10 no Registrador $v0 (para sair do programa)
    syscall