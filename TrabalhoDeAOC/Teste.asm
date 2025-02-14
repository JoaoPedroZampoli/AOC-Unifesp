.data
    caminhocsv:   .asciiz "C:\\Users\\jpsza\\OneDrive\\Documentos\\GitHub\\Pessoal\\AOC-Unifesp\\TrabalhoDeAOC\\significant_month.csv"
    buffer:       .space  2048      
    virgula:      .asciiz ","
    novalinha:    .asciiz "\n"
    tab:          .asciiz "    "   # Espaçamento fixo
    separador:    .asciiz " | "
    max_sizes:    .space  20      # Array para armazenar o maior tamanho de cada coluna (supondo 5 colunas)

.text
main:
    # Abrir o arquivo
    li      $v0, 13             
    la      $a0, caminhocsv     
    li      $a1, 0             
    syscall
    bltz    $v0, FimPrograma    
    move    $s0, $v0           
    
    # Ler arquivo para buffer
    li      $v0, 14             
    move    $a0, $s0           
    la      $a1, buffer         
    li      $a2, 2048          
    syscall
    
    # Fechar arquivo
    li      $v0, 16            
    move    $a0, $s0           
    syscall
    
    # Passagem 1: Calcular tamanhos máximos
    la      $a0, buffer        
    jal     CalculaMaximos     
    
    # Passagem 2: Imprimir alinhado
    la      $a0, buffer        
    jal     ImprimeAlinhado    
    
FimPrograma:
    li      $v0, 10            
    syscall

# Passagem 1: Encontrar o maior tamanho de cada coluna
CalculaMaximos:
    li      $t0, 0             # Índice no buffer
    li      $t3, 0             # Índice da coluna
    li      $t4, 0             # Comprimento atual da palavra

LoopMax:
    lb      $t1, buffer($t0)   # Carregar caractere atual
    beqz    $t1, Retorna       # Se for fim da string, retorna
    li      $t2, ','           
    beq     $t1, $t2, NovaColuna
    li      $t2, '\n'         
    beq     $t1, $t2, NovaLinha
    addi    $t4, $t4, 1        # Incrementa comprimento
    addi    $t0, $t0, 1        
    j       LoopMax

NovaColuna:
    la      $t5, max_sizes     # Endereço do array de tamanhos máximos
    add     $t5, $t5, $t3      
    lb      $t6, 0($t5)        # Carrega tamanho salvo
    bgt     $t6, $t4, SkipSave
    sb      $t4, 0($t5)        # Salva novo tamanho máximo
SkipSave:
    li      $t4, 0             # Reset comprimento
    addi    $t3, $t3, 1        # Avança para próxima coluna
    addi    $t0, $t0, 1        
    j       LoopMax

NovaLinha:
    li      $t3, 0             # Reset índice de coluna
    li      $t4, 0             # Reset comprimento
    addi    $t0, $t0, 1        
    j       LoopMax

Retorna:
    jr      $ra

# Passagem 2: Imprimir os valores alinhados
ImprimeAlinhado:
    li      $t0, 0             # Índice no buffer
    li      $t3, 0             # Índice da coluna
    li      $t4, 0             # Comprimento atual da palavra

LoopImprime:
    lb      $t1, buffer($t0)   # Carregar caractere atual
    beqz    $t1, Retorna       
    li      $t2, ','           
    beq     $t1, $t2, PrintColuna
    li      $t2, '\n'         
    beq     $t1, $t2, PrintLinha
    
    move    $a0, $t1           
    li      $v0, 11            
    syscall                    
    addi    $t4, $t4, 1        
    addi    $t0, $t0, 1        
    j       LoopImprime

PrintColuna:
    la      $t5, max_sizes     
    add     $t5, $t5, $t3      
    lb      $t6, 0($t5)        # Carrega tamanho máximo
    sub     $t7, $t6, $t4      # Espaços restantes
    
EspacoLoop:
    blez    $t7, FimEspacos
    li      $a0, ' '           
    li      $v0, 11            
    syscall                    
    subi    $t7, $t7, 1        
    j       EspacoLoop
FimEspacos:
    la      $a0, separador     
    li      $v0, 4            
    syscall                    
    li      $t4, 0             
    addi    $t3, $t3, 1        
    addi    $t0, $t0, 1        
    j       LoopImprime

PrintLinha:
    li      $t3, 0             
    li      $t4, 0             
    la      $a0, novalinha     
    li      $v0, 4            
    syscall                    
    addi    $t0, $t0, 1        
    j       LoopImprime
