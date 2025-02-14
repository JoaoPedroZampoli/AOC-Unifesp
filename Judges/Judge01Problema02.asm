.data
    msg1: .asciiz "Entre com o combustivel e a quantidade em litros: \n"
    msg2: .asciiz "Foram comercializados R$ "
    msg3: .asciiz " de gasolina, R$ "
    msg4: .asciiz " de alcool e R$ "
    msg5: .asciiz " de diesel.\n"
    msg6: .asciiz "Entrada invalida!\n"
    buffer: .space 20
    gasolina: .asciiz "gasolina"
    alcool: .asciiz "alcool"
    diesel: .asciiz "diesel"
 
.text
.globl main
 
main:
    # Inicializar totais
    li $s0, 0       # Total Gasolina
    li $s1, 0       # Total Álcool
    li $s2, 0       # Total Diesel
    
    # Ler N (número de clientes)
    li $v0, 5
    syscall
    move $s3, $v0   # $s3 = N (contador de clientes)
 
    # Imprimir mensagem de entrada
    li $v0, 4
    la $a0, msg1
    syscall
    
loop_clientes:
    beqz $s3, Finaliza    # Se contador == 0, termina
    
    # Ler string do combustível
    li $v0, 8
    la $a0, buffer
    li $a1, 20
    syscall
    
    # Remover o \n do final da string
    move $t0, $a0
    RemoverNovaLinha:
        lb $t1, ($t0)
        beqz $t1, FimRemover
        beq $t1, 10, NovaLinha
        addi $t0, $t0, 1
        j RemoverNovaLinha
    NovaLinha:
        sb $zero, ($t0)
    FimRemover:
    
    # Ler quantidade
    li $v0, 5
    syscall
    move $t2, $v0   # $t2 = quantidade em litros
    
    # Comparar com "gasolina"
    la $a0, buffer
    la $a1, gasolina
    jal ComparaString
    beqz $v0, Gasolina
    
    # Comparar com "alcool"
    la $a0, buffer
    la $a1, alcool
    jal ComparaString
    beqz $v0, Alcool
    
    # Comparar com "diesel"
    la $a0, buffer
    la $a1, diesel
    jal ComparaString
    beqz $v0, Diesel
    
    # Se chegou aqui, entrada inválida
    li $v0, 4
    la $a0, msg6
    syscall
    j Finaliza
    
Gasolina:
    li $t3, 5       # Preço da gasolina
    mul $t4, $t2, $t3
    add $s0, $s0, $t4
    j Continuar
    
Alcool:
    li $t3, 4       # Preço do álcool
    mul $t4, $t2, $t3
    add $s1, $s1, $t4
    j Continuar
    
Diesel:
    li $t3, 6       # Preço do diesel
    mul $t4, $t2, $t3
    add $s2, $s2, $t4
    
Continuar:
    addi $s3, $s3, -1    # Decrementa contador
    j loop_clientes
 
Finaliza:
    # Imprimir resultados
    li $v0, 4
    la $a0, msg2
    syscall
    
    li $v0, 1
    move $a0, $s0
    syscall
    
    li $v0, 4
    la $a0, msg3
    syscall
    
    li $v0, 1
    move $a0, $s1
    syscall
    
    li $v0, 4
    la $a0, msg4
    syscall
    
    li $v0, 1
    move $a0, $s2
    syscall
    
    li $v0, 4
    la $a0, msg5
    syscall
    
    li $v0, 10
    syscall
 
# Função para comparar strings
ComparaString:
    ComparaStringLoop:
        lb $t0, ($a0)
        lb $t1, ($a1)
        bne $t0, $t1, ComparaStringDiferenca
        beqz $t0, ComparaStringIgual
        addi $a0, $a0, 1
        addi $a1, $a1, 1
        j ComparaStringLoop
    ComparaStringDiferenca:
        li $v0, 1
        jr $ra
    ComparaStringIgual:
        li $v0, 0
        jr $ra