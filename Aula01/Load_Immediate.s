.text
.globl main

main:
    li $t1, 100 # Load 100 no Registrador $t0
    li $v0, 10 # Carrega 10 no Registrador $v0 (para sair do programa)
    syscall