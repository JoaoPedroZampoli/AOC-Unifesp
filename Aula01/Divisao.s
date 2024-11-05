.text
.globl main

main:
    li $t1, 20 # Load 20 no Registrador $t1
    li $t2, 10 # Load 10 no Registrador $t2
    div $t1, $t2 # Divide $t1 por $t2
    li $v0, 10
    syscall