.data 
    msg1: .asciiz "Defina a qtde de inteiros a serem somados: "
    msg2: .asciiz "O resultado eh: "

.text
.globl main

main:
    # Imprime a mensagem msg1
    li $v0, 4 # Codigo do syscall para imprimir string (Load 4 no registrador $v0)
    la $a0, msg1 # Endereco da string a ser impressa
    syscall

    # Leitura da quantidade de inteiros a serem somados
    li $v0, 5 # Codigo do syscall para ler um número inteiro (Load 5 no registrador $v0)
    syscall
    move $t0, $v0 # Salva o valor lido em $t0, $to armazena N

    # Inicializar a soma
    li $t1, 0 # Inicializa o acumulador com 0

    # Inicializar contador de loop
    li $t2, 0 # Inicializa o contador com 0

loop:
    beq $t2, $t0, fimLoop # Se $t2(Contador) for igual a $t0, vai para o fim do loop

    # Leitura de um inteiro
    li $v0, 5 # Codigo do syscall para ler um número inteiro (Load 5 no registrador $v0)
    syscall
    add $t1, $t1, $v0 # Soma o valor lido ao acumulador

    # Incremento no contador
    addi $t2, $t2, 1 # Incrementa o contador
    j, loop # Volta para o inicio do loop

fimLoop:
    li $v0, 4 # Codigo do syscall para imprimir string (Load 4 no registrador $v0)
    la $a0, msg2 # Endereco da string a ser impressa