.data
    string1: .asciiz "Imagine uma frase muito legal aqui!\n"

.text
.globl main

main:
    li $v0, 4 # Load 4 no Registrador $v0 (para imprimir string)
    la $a0, string1 # Carrega o endereço da string1 no Registrador $a0
    syscall

    li $v0, 10
    syscall