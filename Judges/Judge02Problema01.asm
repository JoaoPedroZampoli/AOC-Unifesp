.data
    msg1: .asciiz "Digite a string: \n"
    msg2: .asciiz "\nString concatenada com a invertida: "
    msg3: .asciiz "A String eh um palindromo\n"
    msg4: .asciiz "A String nao eh um palindromo\n"
    msg5: .asciiz "\nQuantidade de substrings palindromos eh: "
    memoria1: .space 100
    resultado: .space 200
.text
.globl main

main:
  # Imprime mensagem 1
    li $v0, 4
    la $a0, msg1
    syscall

    # Ler String
    li $v0, 8
    la $a0, memoria1
    li $a1, 100
    syscall

    # Remove o \n do final da string
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
    la $t0, memoria1      # fonte
    la $t1, memoria1      # destino
LoopRemoveSpaces:
    lb $t2, 0($t0)       # carrega caractere
    beqz $t2, EndRemoveSpaces
    beq $t2, 32, SkipSpace  # 32 = espaco em ASCII
    sb $t2, 0($t1)       # salva caractere nao-espaco
    addi $t1, $t1, 1     # avanca destino
SkipSpace:
    addi $t0, $t0, 1     # avanca fonte
    j LoopRemoveSpaces
EndRemoveSpaces:
    sb $zero, 0($t1)     # termina string

VerificaPalindromo:
    la $t0, memoria1  # inicio da string
    la $t1, memoria1  # vai ate o fim da string
    
EncontraFim:
    lb $t2, 0($t1)
    beqz $t2, ComparaPalindromo
    addi $t1, $t1, 1
    j EncontraFim

ComparaPalindromo:
    addi $t1, $t1, -1  # volta para ultimo caractere
    move $t2, $t0     # inicio da string

ComparaLoop:
    bge $t2, $t1, EhPalindromo
    lb $t3, 0($t2)    # caractere do inicio
    lb $t4, 0($t1)    # caractere do fim
    bne $t3, $t4, NaoPalindromo
    addi $t2, $t2, 1
    addi $t1, $t1, -1
    j ComparaLoop

EhPalindromo:
    li $v0, 4
    la $a0, msg3
    syscall
    li $s0, -1 # Inicializando o contador aqui porque tava dando erro ao iniciar com 0 no ContaSubstrings
    j ContaSubstrings

NaoPalindromo:
    li $v0, 4
    la $a0, msg4
    li $s0, 0 # Inicializando o contador aqui porque tava dando erro no ContaSubstrings
    syscall

ContaSubstrings:
    la $s1, memoria1 # ponteiro para string
    li $s2, 0        # posicao inicial
    
    # Calcula tamanho da string
    la $t0, memoria1
    li $s3, 0        # tamanho da string
TamString:
    lb $t1, 0($t0)
    beqz $t1, IniciaContagem
    addi $s3, $s3, 1
    addi $t0, $t0, 1
    j TamString

IniciaContagem:
    li $s4, 3        # tamanho inicial da substring (3)
    
LoopExterno:
    bgt $s4, $s3, ConcatenaString  # se tamanho maior que tam_string, termina
    move $s2, $zero                 # reinicia posicao inicial
    
LoopInterno:
    add $t0, $s2, $s4              # posicao final = inicial + tamanho
    bgt $t0, $s3, ProximoTamanho   # se exceder string, próximo tamanho
    
    # Verifica se substring e palindromo
    move $t1, $s2                  # inicio da substring
    sub $t2, $t0, 1               # fim da substring
    
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
    addi $s0, $s0, 1              # incrementa contador
    
ProximaPosicao:
    addi $s2, $s2, 1              # próxima posicao inicial
    j LoopInterno
    
ProximoTamanho:
    addi $s4, $s4, 1              # incrementa tamanho
    j LoopExterno

ConcatenaString:
    la $t0, memoria1              # origem
    la $t1, resultado             # destino
    
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
    addi $t0, $t0, -1             # ultimo caractere
    
CopiaInvertida:
    la $t3, memoria1              # carrega endereco base no t3
    blt $t0, $t3, FinalizaCopia   # compara com o registrador
    lb $t2, 0($t0)
    sb $t2, 0($t1)
    addi $t0, $t0, -1
    addi $t1, $t1, 1
    j CopiaInvertida
    
FinalizaCopia:
    sb $zero, 0($t1)             # termina string

    # Imprime resultados
    li $v0, 4
    la $a0, msg2
    syscall
    
    li $v0, 4
    la $a0, resultado
    syscall
    
    li $v0, 4
    la $a0, msg5
    syscall
    
    li $v0, 1
    move $a0, $s0
    syscall
    
    li $v0, 10
    syscall