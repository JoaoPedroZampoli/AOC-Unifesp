.data
str1: .asciiz "Digite a fita simples: \n"
str2: .asciiz "Cadeia de caracteres invalida!\n"
str3: .asciiz "Nao eh possivel comecar a traduzir!\n"
str4: .asciiz "Traducao incompleta!\n"
saida: .space 100
entrada: .space 100

.text
.globl main

main:
    li $v0, 4
    la $a0, str1
    syscall

    li $v0, 8
    la $a0, entrada
    li $a1, 100
    syscall

    la $a0, entrada
    jal DNAValida
    beq $v0, $zero, ErroInvalido

    la $a0, entrada
    la $a1, saida
    jal Transcreve

    la $a0, saida
    jal InicioVerificacao
    beq $v0, $zero, ErroInicio

    la $a0, saida
    jal VerificacaoTermino
    beq $v0, $zero, ErroIncompleto

    li $v0, 4
    la $a0, saida
    syscall

    j FimPrograma

ErroInvalido:
    li $v0, 4
    la $a0, str2
    syscall
    j FimPrograma

ErroInicio:
    li $v0, 4
    la $a0, str3
    syscall
    j FimPrograma

ErroIncompleto:
    li $v0, 4
    la $a0, str4
    syscall
    j FimPrograma

FimPrograma:
    li $v0, 10
    syscall

DNAValida:
    li $t1, 0  
LoopValidacao:
    lb $t0, 0($a0)
    beq $t0, '\n', FimValida
    beq $t0, 'A', ProximoValida
    beq $t0, 'T', ProximoValida
    beq $t0, 'C', ProximoValida
    beq $t0, 'G', ProximoValida
    li $v0, 0
    jr $ra
ProximoValida:
    addi $a0, $a0, 1
    j LoopValidacao
FimValida:
    li $v0, 1
    jr $ra

Transcreve:
    li $t1, 0	
LoopTranscrever:
    lb $t0, 0($a0)
    beq $t0, '\n', TranscricaoFim
    beq $t0, 'A', TranscreverU
    beq $t0, 'T', TranscreverA
    beq $t0, 'C', TranscreverG
    beq $t0, 'G', TranscreverC
    j TranscricaoFim
TranscreverU:
    li $t2, 'U'
    j Escrever
TranscreverA:
    li $t2, 'A'
    j Escrever
TranscreverG:
    li $t2, 'G'
    j Escrever
TranscreverC:
    li $t2, 'C'
    j Escrever
Escrever:
    sb $t2, 0($a1)
    addi $a1, $a1, 1
    addi $a0, $a0, 1
    j LoopTranscrever
TranscricaoFim:
    sb $zero, 0($a1)
    jr $ra
    
SaidaFormatacao:
    la $a0, saida   
    la $a1, saida   
    li $t3, 0        
LoopFormatacao:
    lb $t0, 0($a0)   
    beq $t0, $zero, FimFormatacao  
    sb $t0, 0($a1)   
    addi $a1, $a1, 1 
    addi $a0, $a0, 1 
    addi $t3, $t3, 1 

    li $t4, 3
    div $t3, $t4
    mfhi $t5
    bne $t5, $zero, LoopFormatacao

    li $t0, ' '     
    sb $t0, 0($a1)
    addi $a1, $a1, 1
    j LoopFormatacao

FimFormatacao:
    sb $zero, 0($a1) 
    jr $ra

InicioVerificacao:
    lb $t0, 0($a0)
    lb $t1, 1($a0)
    lb $t2, 2($a0)
    li $v0, 0
    beq $t0, 'A', ChecagemU1
    jr $ra
ChecagemU1:
    beq $t1, 'U', ChecagemG2
    jr $ra
ChecagemG2:
    beq $t2, 'G', InicioSucesso
    jr $ra
InicioSucesso:
    li $v0, 1
    jr $ra

VerificacaoTermino:
    li $v0, 0
LoopTerminal:
    lb $t0, 0($a0)
    beq $t0, $zero, FimTerminal
    lb $t1, 1($a0)
    lb $t2, 2($a0)
    beq $t0, 'U', ChecagemPara1
    addi $a0, $a0, 1
    j LoopTerminal
ChecagemPara1:
    beq $t1, 'A', ChecagemPara2A
    beq $t1, 'G', ChecagemPara2G
    addi $a0, $a0, 1
    j LoopTerminal
ChecagemPara2A:
    beq $t2, 'A', TerminoSucesso
    beq $t2, 'G', TerminoSucesso
    addi $a0, $a0, 1
    j LoopTerminal
ChecagemPara2G:
    beq $t2, 'A', TerminoSucesso
    addi $a0, $a0, 1
    j LoopTerminal
TerminoSucesso:
    li $v0, 1
FimTerminal:
    jr $ra
