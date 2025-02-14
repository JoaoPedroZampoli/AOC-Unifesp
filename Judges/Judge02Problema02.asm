.data
    msg1: .asciiz "Entre com o coordenada x1 do ponto A: \n"
    msg2: .asciiz "Entre com o coordenada y1 do ponto A: \n"
    msg3: .asciiz "Entre com o coordenada x2 do ponto B: \n"
    msg4: .asciiz "Entre com o coordenada y2 do ponto B: \n"
    msg5: .asciiz "Entre com o coordenada x3 do ponto C: \n"
    msg6: .asciiz "Entre com o coordenada y3 do ponto C: \n"
    msg7: .asciiz "Area do triangulo: "

.text
.globl main

main:
# Imprime mensagem 1
    li $v0, 4
    la $a0, msg1
    syscall

# Ler x1
    li $v0, 6
    syscall
    mov.s $f1, $f0

# Imprime mensagem 2
    li $v0, 4
    la $a0, msg2
    syscall

# Ler y1
    li $v0, 6
    syscall
    mov.s $f2, $f0

# Imprime mensagem 3
    li $v0, 4
    la $a0, msg3
    syscall

# Ler x2
    li $v0, 6
    syscall
    mov.s $f3, $f0

# Imprime mensagem 4
    li $v0, 4
    la $a0, msg4
    syscall

# Ler y2
    li $v0, 6
    syscall
    mov.s $f4, $f0

# Imprime mensagem 5
    li $v0, 4
    la $a0, msg5
    syscall

# Ler x3
    li $v0, 6
    syscall
    mov.s $f5, $f0

# Imprime mensagem 6
    li $v0, 4
    la $a0, msg6
    syscall

# Ler y3
    li $v0, 6
    syscall
    mov.s $f6, $f0

# Calcula area do triangulo
    sub.s $f7, $f4, $f6
    sub.s $f8, $f6, $f2
    sub.s $f9, $f2, $f4
    mul.s $f7, $f7, $f1
    mul.s $f8, $f8, $f3
    mul.s $f9, $f9, $f5
    add.s $f7, $f7, $f8
    add.s $f7, $f7, $f9
    li.s $f10, 2.0
    div.s $f7, $f7, $f10

    abs.s $f7, $f7

# Imprime mensagem 7
    li $v0, 4
    la $a0, msg7
    syscall

# Imprime area do triangulo
    li $v0, 2
    mov.s $f12, $f7
    syscall