.data
    msg1: .asciiz "Digite a string: \n"
    msg2: .asciiz "String concatenada com a invertida: "
    msg3: .asciiz "A String eh um palindromo\n"
    msg4: .asciiz "A String nao eh um palindromo\n"
    msg5: .asciiz "Quantidade de substrings palindromos eh: "
    memoria1: .space 100
    resultado: .space 200
.text
.globl main

main:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 8
    la $a0, memoria1
    li $a1, 100
    syscall

    la $t0, memoria1
    
RemoveNvLinha:
    lb $t1, 0($t0)
    beqz $t1, VerificaPalindromo
    beq $t1, 10, ReporNvLinha
    addi $t0, $t0, 1
    j RemoveNvLinha
ReporNvLinha:
    sb $zero, 0($t0)

RemoveSpaces:
    la $t0, memoria1
    la $t1, memoria1
LoopRemoveSpaces:
    lb $t2, 0($t0)
    beqz $t2, EndRemoveSpaces
    beq $t2, 32, SkipSpace
    sb $t2, 0($t1)
    addi $t1, $t1, 1
SkipSpace:
    addi $t0, $t0, 1
    j LoopRemoveSpaces
EndRemoveSpaces:
    sb $zero, 0($t1)

VerificaPalindromo:
    la $t0, memoria1
    la $t1, memoria1
    
EncontraFim:
    lb $t2, 0($t1)
    beqz $t2, ComparaPalindromo
    addi $t1, $t1, 1
    j EncontraFim

ComparaPalindromo:
    addi $t1, $t1, -1
    move $t2, $t0

ComparaLoop:
    bge $t2, $t1, EhPalindromo
    lb $t3, 0($t2)
    lb $t4, 0($t1)
    bne $t3, $t4, NaoPalindromo
    addi $t2, $t2, 1
    addi $t1, $t1, -1
    j ComparaLoop

EhPalindromo:
    li $v0, 4
    la $a0, msg3
    syscall
    li $s0, -1
    j ContaSubstrings

NaoPalindromo:
    li $v0, 4
    la $a0, msg4
    li $s0, 0
    syscall

ContaSubstrings:
    la $s1, memoria1
    li $s2, 0
    
    la $t0, memoria1
    li $s3, 0
TamString:
    lb $t1, 0($t0)
    beqz $t1, IniciaContagem
    addi $s3, $s3, 1
    addi $t0, $t0, 1
    j TamString

IniciaContagem:
    li $s4, 3
    
LoopExterno:
    bgt $s4, $s3, ConcatenaString
    move $s2, $zero
    
LoopInterno:
    add $t0, $s2, $s4
    bgt $t0, $s3, ProximoTamanho
    
    move $t1, $s2
    sub $t2, $t0, 1
    
VerificaSubstring:
    bge $t1, $t2, SubstringPalindroma
    add $t3, $s1, $t1
    add $t4, $s1, $t2
    lb $t5, 0($t3)
    lb $t6, 0($t4)
    bne $t5, $t6, ProximaPosicao
    addi $t1, $t1, 1
    addi $t2, $t2, -1
    j VerificaSubstring
    
SubstringPalindroma:
    addi $s0, $s0, 1
    
ProximaPosicao:
    addi $s2, $s2, 1
    j LoopInterno
    
ProximoTamanho:
    addi $s4, $s4, 1
    j LoopExterno

ConcatenaString:
    la $t0, memoria1
    la $t1, resultado
    
CopiaOriginal:
    lb $t2, 0($t0)
    beqz $t2, PreparaInvertida
    sb $t2, 0($t1)
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    j CopiaOriginal
    
PreparaInvertida:
    la $t0, memoria1
    add $t0, $t0, $s3
    addi $t0, $t0, -1
    
CopiaInvertida:
    la $t3, memoria1
    blt $t0, $t3, FinalizaCopia
    lb $t2, 0($t0)
    sb $t2, 0($t1)
    addi $t0, $t0, -1
    addi $t1, $t1, 1
    j CopiaInvertida
    
FinalizaCopia:
    sb $zero, 0($t1)
    
    li $v0, 4
    la $a0, msg5
    syscall
    
    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 4
    la $a0, msg2
    syscall
    
    li $v0, 4
    la $a0, resultado
    syscall
    
    li $v0, 10
    syscall