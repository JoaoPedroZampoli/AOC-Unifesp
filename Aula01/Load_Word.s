.data
    value: .word 20

.text
.globl main

main:
    li $t2, 10
    lw $t3, value
    add $t4, $t2, $t3
    sub $t5, $t2, $t3

    li $v0, 10
    syscall