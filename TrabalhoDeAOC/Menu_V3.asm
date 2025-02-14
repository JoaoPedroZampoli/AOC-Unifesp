.data
boasvindas: .asciiz "\n╔═══════════════════════════════════════════════════════╗\n║        SISTEMA CENTRAL DE EVENTOS SÍSMICOS            ║\n╚═══════════════════════════════════════════════════════╝\n"

header: .asciiz "\n╭──────────── MENU PRINCIPAL ────────────────╮\n"
menu_option1: .asciiz "│  [1] Eventos Sísmicos Recentes             │\n"
menu_option2: .asciiz "│  [2] Simulador de Eventos Sísmicos         │\n"
menu_option3: .asciiz "│  [3] Relatar Experiência                   │\n"
menu_option4: .asciiz "│  [4] Instruções de Sobrevivência           │\n"
menu_option5: .asciiz "│  [5] Como Usar o Sistema                   │\n"
menu_option6: .asciiz "│  [6] Sair                                  │\n"
menu_linha_vazia: .asciiz "│                                            │\n"
descricao_opcao1: .asciiz "│ -> Confira informações como local, data,   │\n│    hora, estatísticas e mais a respeito    │\n│    dos últimos três eventos registrados.   │\n"
descricao_opcao2: .asciiz "│ -> Aprenda sobre as diferentes escalas e   │\n│    simule terremotos e tsunamis!           │\n"
descricao_opcao3: .asciiz "│ -> Vivenciou algum terremoto ou tsunami?   │\n│    Nos conte sobre sua experiência!        │\n"
descricao_opcao4: .asciiz "│ -> Descubra medidas a serem tomadas antes, │\n│    durante ou depois de um terremoto ou    │\n│    tsunami.                                │\n"
descricao_opcao5: .asciiz "│ -> Entenda como navegar o nosso sistema!   │\n"
descricao_opcao6: .asciiz "│ -> Encerrar sessão.                        │\n"
footer: .asciiz "╰────────────────────────────────────────────╯\n"
menu_saida: .asciiz " \n╭────────────────────────────────────╮\n│  [1] Voltar para o menu principal  │\n│  [2] Encerrar sessão               │\n╰────────────────────────────────────╯\n"
escolha_op: .asciiz "\n📋 Digite sua escolha (1-2): "
opcao_invalida_saida: .asciiz "\n⚠️  Opção inválida! Por favor, escolha 1 ou 2.\n"

# Opção 1: Histórico de eventos sísmicos recentes
escolher_opcao: .asciiz "\n📋 Digite sua escolha (1-6): "
opcao_invalida: .asciiz "\n⚠️  Opção inválida! Por favor, escolha entre 1 e 6.\n"

caminhocsv:   .asciiz "significant_month.csv"
buffer:       .space  2048      
virgula:      .asciiz ","
novalinha:    .asciiz "\n"
tab:          .asciiz "    "   # Espaçamento fixo
separador_op1:    .asciiz " | "
inicioranking:.asciiz "Esse e o historico dos terremotos significativos dos ultimos 30 dias:\n\n"
max_sizes:    .space  20      # Array para armazenar o maior tamanho de cada coluna (supondo 5 colunas)

#Opção 2: Simulador de eventos sismicos
titulo: .asciiz "\n╔════════════════════════════════════════════════════════╗\n║     SISTEMA DE ANÁLISE DE TERREMOTOS E TSUNAMIS        ║\n╚════════════════════════════════════════════════════════╝\n\n"
descricao: .asciiz "Este sistema permite:\n1. Calcular a magnitude Richter (M) a partir de dados sísmicos da amplitude máxima do movimento do solo (A) e da distância do epicentro em relação ao sismógrafo (d)\n2. Analisar o risco de tsunamis com base na magnitude M, informada diretamente ou calculada pelo programa\n\n"
menu_header: .asciiz "╭──────────── MENU DE OPÇÕES ─────────────╮\n"
opcao1_simulador: .asciiz "│  [1] Calcular Magnitude Richter         │\n"
opcao2_simulador: .asciiz "│  [2] Análise Direta (Magnitude M)       │\n"
opcao3_simulador: .asciiz "│  [3] Sair do Sistema                    │\n"
menu_footer: .asciiz "╰─────────────────────────────────────────╯\n"
prompt: .asciiz "\nDigite sua escolha (1-3): "
erro: .asciiz "\n⚠️  Opção inválida! Por favor, escolha 1, 2 ou 3.\n"
input_amplitude: .asciiz "\n📏 Digite a amplitude máxima (μm): "
input_distancia: .asciiz "📍 Digite a distância do epicentro (km): "
input_magnitude: .asciiz "\n📊 Digite a magnitude Richter (com uma casa decimal): "
separador: .asciiz "\n----------------------------------------\n"
processando: .asciiz "\n⌛ Processando dados...\n"
resultado_m: .asciiz "\n📊 Magnitude calculada na escala Richter: "
newline: .asciiz "\n"

# Constantes para o cálculo da Magnitude Richter
dez: .float 10.0                    
conv_micro_to_nano: .float 1000.0  # converter micrômetros para nanômetros
const_2080: .float 2080.0          # Constante da fórmula
const_1_11: .float 1.11            # Coeficiente do segundo termo
const_0_00189: .float 0.00189      # Coeficiente do terceiro termo
const_2_09: .float 2.09            # Constante de subtracao

# Constantes para o cálculo do logaritmo
ln_10: .float 2.30258509   # ln(10) - usado para converter de ln para log10
um: .float 1.0
dois: .float 2.0
tres: .float 3.0
quatro: .float 4.0
meio: .float 0.5
limite_serie: .word 15     # Número de termos para expansão em série de Taylor
cem: .float 100.0 
epsilon: .float 0.0000001

#Opção 3: Relato de experiência
boasvindas_relato: .asciiz "\nVivenciou algum evento sísmico?\n\nPara relatar sua experiência, responda o formulário abaixo:\n"
pergunta1: .asciiz "\n1 - Em que cidade você se encontrava?\n"
pergunta2: .asciiz "\n2 - Você sentiu o terremoto?\n"
pergunta3: .asciiz "\n3 - Outros sentiram o terremoto?\n"
pergunta4: .asciiz "\n4 - Foi difícil ficar em pé e/ou andar?\n"
pergunta5: .asciiz "\n5 - Você percebeu objetos se movendo?\n"
pergunta6: .asciiz "\n6 - Você se encontrava dentro de algum estabelecimento (prédio, casa etc)?\n"
pergunta6_1: .asciiz "\n6.1 - Houve algum dano estrutural interno perceptível?\n"
pergunta6_2: .asciiz "\n6.2 - Houve algum dano estrutural externo perceptível?\n"
pergunta7: .asciiz "\n7 - Você já havia vivido uma situação como essa?\n"
pergunta8: .asciiz "\n8 - Você havia tomado alguma medida para se preparar para uma situação como essa?\n"
pergunta9: .asciiz "\n9 - Você soube quais medidas tomar durante o evento?\n"
pergunta10: .asciiz "\n10 - Você soube quais medidas tomar após o evento?\n"
menu_op3: .asciiz "\n╭───────────╮\n│  [1] Não  │\n│  [2] Sim  │\n╰───────────╯\n"
tchau_op3: .asciiz "\nSeu relato nos ajuda muito, obrigada por compartilhar!\n"
arquivo_reacao: .asciiz "reacao.txt"
buffer_relato: .space 8
string_entrada: .space 256
string_saida: .space 256

.text
.globl main
main:
  # imprime mensagem de boas-vindas
  li $v0, 4
  la $a0, boasvindas
  syscall

menu_principal:
  # imprime menu header
  li $v0, 4
  la $a0, header
  syscall
  
  # imprime opção 1
  li $v0, 4
  la $a0, menu_option1
  syscall
  
  # imprime opção 2
  li $v0, 4
  la $a0, menu_option2
  syscall
  
  # imprime opção 3
  li $v0, 4
  la $a0, menu_option3
  syscall
  
  # imprime opção 4
  li $v0, 4
  la $a0, menu_option4
  syscall
  
  # imprime opção 5
  li $v0, 4
  la $a0, menu_option5
  syscall
  
  # imprime opção 6
  li $v0, 4
  la $a0, menu_option6
  syscall
  
  # imprime menu footer
  li $v0, 4
  la $a0, footer
  syscall

opcao_menu:

  # prompt de escolha
  li $v0, 4
  la $a0, escolher_opcao
  syscall

  # recebe opcao
  li $v0, 5
  syscall
  move $t0, $v0

  # compara opcao
  li $t1, 1
  beq $t0, $t1, opcao1

  li $t1, 2
  beq $t0, $t1, opcao2

  li $t1, 3
  beq $t0, $t1, opcao3

  li $t1, 4
  beq $t0, $t1, opcao4

  li $t1, 5
  beq $t0, $t1, opcao5

  li $t1, 6
  beq $t0, $t1, fim

  # caso opcao invalida
  li $v0, 4
  la $a0, opcao_invalida
  syscall

  j menu_principal 

opcao1:       # Eventos Sísmicos Recentes

  li 	    $v0, 4
  la      $a0, inicioranking
  syscall
  
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

  li $v0, 4                       # imprime menu de saída
  la $a0, menu_saida
  syscall

  li $v0, 4                       # imprime mensagem de escolha
  la $a0, escolha_op
  syscall

  li $v0, 5                       # lê input do usuário
  syscall

  li $t2, 1
  beq $v0, $t2, menu_principal    # 1 = voltar para o menu principal
  li $t2, 2
  beq $v0, $t2, fim               # 2 = fim

  li $v0, 4
  la $a0, opcao_invalida_saida
  syscall

  j FimPrograma

# Passagem 1: Encontrar o maior tamanho de cada coluna
CalculaMaximos:
  li      $t0, 0             # índice no buffer
  li      $t3, 0             # índice da coluna
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
  bgt     $t6, $t4, PulaSave
  sb      $t4, 0($t5)        # Salva novo tamanho máximo

PulaSave:
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
  li      $t0, 0             # índice no buffer
  li      $t3, 0             # índice da coluna
  li      $t4, 0             # Comprimento atual da palavra

LoopImprime:
  lb      $t1, buffer($t0)   # Carregar caractere atual
  beqz    $t1, Retorna       # Se for fim da string, retorna
  li      $t2, ','           
  beq     $t1, $t2, CheckColuna
  li      $t2, '\n'         
  beq     $t1, $t2, PrintLinha
  
  # Imprimir caractere apenas se estiver na coluna desejada
  beq     $t3, 0, PrintChar  # time
  beq     $t3, 13, PrintChar # place
  beq     $t3, 14, PrintChar # type
  beq     $t3, 1, PrintChar  # latitude
  beq     $t3, 2, PrintChar  # longitude
  beq     $t3, 3, PrintChar  # depth
  beq     $t3, 4, PrintChar  # mag
  j       PulaPrint

PrintChar:
  move    $a0, $t1           
  li      $v0, 11            
  syscall 

PulaPrint:
  addi    $t4, $t4, 1        
  addi    $t0, $t0, 1        
  j       LoopImprime

CheckColuna:
  # Verificar se a coluna atual deve ser impressa
  beq     $t3, 0, PrintColuna  # time
  beq     $t3, 13, PrintColuna # place
  beq     $t3, 14, PrintColuna # type
  beq     $t3, 1, PrintColuna  # latitude
  beq     $t3, 2, PrintColuna  # longitude
  beq     $t3, 3, PrintColuna  # depth
  beq     $t3, 4, PrintColuna  # mag
  j       PulaColuna

PrintColuna:
  la      $t5, max_sizes     
  add     $t5, $t5, $t3      
  lb      $t6, 0($t5)        # Carrega tamanho m�ximo
  sub     $t7, $t6, $t4      # Espa�os restantes
  
EspacoLoop:
  blez    $t7, FimEspacos
  li      $a0, ' '           
  li      $v0, 11            
  syscall                    
  addi    $t7, $t7, -1        
  j       EspacoLoop
FimEspacos:
  la      $a0, separador_op1     
  li      $v0, 4            
  syscall                    
PulaColuna:
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
  
opcao2: # Simulador de eventos sismicos

 # Limpa a tela (simulado com várias newlines)
  li $v0, 4
  la $a0, newline
  syscall
  syscall
  syscall

  # Mostra título
  li $v0, 4
  la $a0, titulo
  syscall

  # Mostra descrição
  li $v0, 4
  la $a0, descricao
  syscall

# Menu do simulador de tsunamis/calculadora da escala Richter
while:        
  menu_loop:
  # Mostra cabeçalho do menu
  li $v0, 4
  la $a0, menu_header
  syscall

  # Mostra opções
  li $v0, 4
  la $a0, opcao1_simulador
  syscall
  
  li $v0, 4
  la $a0, opcao2_simulador
  syscall
  
  li $v0, 4
  la $a0, opcao3_simulador
  syscall

  # Mostra rodapé do menu
  li $v0, 4
  la $a0, menu_footer
  syscall

  # Prompt de escolha
  li $v0, 4
  la $a0, prompt
  syscall

  # Lê escolha do usuário
  li $v0, 5
  syscall
  move $t0, $v0                                        #t0 = controle do menu do simulador

  # Valida entrada
  blt $t0, 1, entrada_invalida                         #t0 < 1: valor invalido   
  bgt $t0, 3, entrada_invalida                         #t0 > 3: valor invalido

  beq $t0, 1, calculadora_Richter                      #t0 = 1: calcula Escala Richter a partir da distancia e amplitude
  beq $t0, 2, analise_direta                           #t0 = 2: ja vai direto para a previsao de tsunamis
  beq $t0, 3, sair_simulador                           #t0 = 3: sai do simulador e volta para o menu principal


entrada_invalida:
  li $v0, 4
  la $a0, erro
  syscall
  j while                                            #volta para o while 


calculadora_Richter:
  # Mostra separador
  li $v0, 4
  la $a0, separador
  syscall

  # Solicita amplitude
  li $v0, 4
  la $a0, input_amplitude
  syscall

  # Lê amplitude em micrômetros
  li $v0, 5
  syscall
  mtc1 $v0, $f11
  cvt.s.w $f11, $f11

  # Converte amplitude para nanômetros (multiplica por 1000)
  l.s $f0, conv_micro_to_nano
  mul.s $f11, $f11, $f0

  # Solicita distância
  li $v0, 4
  la $a0, input_distancia
  syscall

  # Lê distância em km
  li $v0, 5
  syscall
  mtc1 $v0, $f12
  cvt.s.w $f12, $f12

  # Mostra processando
  li $v0, 4
  la $a0, processando
  syscall

  # Cálculo da Magnitude ML = log10(A/2080) + 1.11*log10(R) + 0.00189*R - 2.09
  # Onde A é a amplitude máxima do movimento do solo em nanômetros e R é a distância do epicentro em km

  mov.s $f20, $f12          # Guarda R em $f20
  
  # Primeiro termo: log10(A/2080)
  l.s $f14, const_2080
  div.s $f15, $f11, $f14    # A/2080
  mov.s $f13, $f15
  jal log10
  mov.s $f16, $f0           # Guarda resultado do primeiro termo
  
  # Segundo termo: 1.11*log10(R)
  mov.s $f13, $f20          # Usa R guardado em $f20
  jal log10
  l.s $f14, const_1_11
  mul.s $f17, $f0, $f14     # 1.11 * log10(R)
  
  # Terceiro termo: 0.00189*R
  l.s $f14, const_0_00189
  mul.s $f18, $f20, $f14    # 0.00189 * R (usando R guardado em $f20)
  
  # Soma todos os termos e subtrai 2.09
  add.s $f12, $f16, $f17    # Primeiro + Segundo termo
  add.s $f12, $f12, $f18    # + Terceiro termo
  l.s $f14, const_2_09
  sub.s $f12, $f12, $f14    # - 2.09

  # Imprime  resultado
  li $v0, 4
  la $a0, resultado_m
  syscall
  
  li $v0, 2                         #imprime o float que esta em f12 (resultado do calculo da magnitude)
  syscall 

  li $v0, 4
  la $a0, newline
  syscall
  syscall

  j while   #provisorio (por ultimo, jump para a parte de previsao de tsunamis) 

# Função log10(x) - entrada em $f13, saída em $f0
log10:
  # Salva registradores
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Salva valor original
  mov.s $f14, $f13

  # Reduz número se for muito grande (> 100) 
  l.s $f1, cem         
  c.lt.s $f14, $f1
  bc1t calc_direct     # Se < 100, calcula diretamente log10(x)

  # Para números grandes, divide por 100 e adiciona log10(100)=2 
  div.s $f13, $f13, $f1
  jal calc_ln
  l.s $f1, ln_10
  div.s $f0, $f0, $f1
  l.s $f1, dois
  add.s $f0, $f0, $f1
  j log10_end

calc_direct:
  jal calc_ln
  l.s $f1, ln_10
  div.s $f0, $f0, $f1

log10_end:
  # Restaura e retorna
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

# Função calc_ln melhorada - entrada em $f13, saída em $f0
calc_ln:
  # Preparação
  l.s $f1, um
  l.s $f2, dois
  
  # Calcula y = (x-1)/(x+1)
  add.s $f3, $f13, $f1  # x + 1
  sub.s $f4, $f13, $f1  # x - 1
  div.s $f5, $f4, $f3   # y = (x-1)/(x+1)
  
  # Soma = y
  mov.s $f6, $f5        # Soma inicial
  mov.s $f7, $f5        # y^n atual
  
  # Inicializa contadores
  li $t0, 3             # Denominador atual
  li $t1, 35            # 35 iterações
  li $t2, 1             # Contador de iterações
  
serie_ln:
  bge $t2, $t1, fim_serie
  
  # Calcula próximo termo com precisão
  mul.s $f7, $f7, $f5   
  mul.s $f7, $f7, $f5   
  
  # Divide pelo denominador
  mtc1 $t0, $f8
  cvt.s.w $f8, $f8
  div.s $f8, $f7, $f8
  
  # Adiciona à soma com verificação de magnitude
  abs.s $f9, $f8        # Pega valor absoluto do termo
  l.s $f10, epsilon     # Limite de precisão
  c.lt.s $f9, $f10      # Se termo muito pequeno, termina
  bc1t fim_serie
  
  add.s $f6, $f6, $f8
  
  # Atualiza contadores
  addi $t0, $t0, 2
  addi $t2, $t2, 1
  j serie_ln
  
fim_serie:
  mul.s $f0, $f6, $f2
  jr $ra


analise_direta:
  # Mostra separador
  li $v0, 4
  la $a0, separador
  syscall

  # Solicita magnitude
  li $v0, 4
  la $a0, input_magnitude
  syscall

  li $v0, 6                           # syscall para ler float
  syscall                             # reg f0 = magnitude M

  # Mostra mensagem de processamento
  li $v0, 4
  la $a0, processando
  syscall

  j while   #provisorio -> jump para a parte que calcula a previsão de ocorrencia de tsunami baseado na magnitude da escala Richter

sair_simulador:
  # Mostra separador final
  li $v0, 4
  la $a0, separador
  syscall

  j menu_principal

opcao3:                       # relato de experiência

  li $v0, 4
  la $a0, boasvindas_relato
  syscall

  # PERGUNTA 1

  li $v0, 4
  la $a0, pergunta1
  syscall

  li $v0, 8
  la $a0, string_entrada	    # lê a string de entrada do usuário
  li $a1, 256
  syscall

  jal processa_string

  j relato

processa_string:		          # função para processar a string
  la $t0, string_entrada             
  la $t1, string_saida
  
laco_processamento:
  lb $t2, ($t0)
  
  # encerra processamento da string se encontra '\n'
  li $t3, 10
  beq $t2, $t3, adiciona_extensao
  
  # verifica se é menor do que o valor ascii de 'A'
  li $t3, 65
  blt $t2, $t3, pula_caractere
  
  # verifica se é menor ou igual ao valor ascii de 'Z'
  li $t3, 90
  ble $t2, $t3, maiuscula
  
  # verifica se é menor do que o valor ascii de 'a'
  li $t3, 97
  blt $t2, $t3, pula_caractere
  
  # verifica se é menor ou igual ao valor ascii de 'z'
  li $t3, 122
  ble $t2, $t3, monta_string
  
  j pula_caractere

maiuscula:			              # converte caractere para minúscula
  addi $t2, $t2, 32 
  
monta_string:			            # armazena o caractere processado na string de saída
  sb $t2, 0($t1)
  addi $t0, $t0, 1
  addi $t1, $t1, 1
  j laco_processamento

pula_caractere:
  addi $t0, $t0, 1 
  j laco_processamento

adiciona_extensao:		        # adiciona a extensão ".txt"
  li $t2, 46
  sb $t2, 0($t1)
  addi $t1, $t1, 1
  
  li $t2, 116
  sb $t2, 0($t1)
  addi $t1, $t1, 1
  
  li $t2, 120
  sb $t2, 0($t1)
  addi $t1, $t1, 1
  
  li $t2, 116
  sb $t2, 0($t1)
  addi $t1, $t1, 1
  
  sb $zero, ($t1)         	  # adiciona \0 ao final da string

  jr $ra

relato:
  
  li $t1, 0 # indicador

  # Syscall 13, Modo 0 - Abre o arquivo para leitura
  li $v0, 13              
  la $a0, string_saida    
  li $a1, 0                  
  syscall

  bltz $v0, sair_op3
  move $s0, $v0

  # Syscall 14 - Lê o conteúdo do arquivo
  li $v0, 14
  move $a0, $s0           
  la $a1, buffer_relato          
  li $a2, 8            
  syscall

  # Syscall 16 - Fecha o arquivo
  li $v0, 16
  move $a0, $s0
  syscall

  la $t5, buffer_relato

  lb $t6, 0($t5)              
  addi $t6, $t6, 1          # adiciona à contagem de quem respondeu ao formulário
  sb $t6, 0($t5)
  addi $t5, $t5, 1          # avança para a próxima posição

  # PERGUNTA 2

  li $v0, 4
  la $a0, pergunta2
  syscall

  jal le_escreve_op3

  # PERGUNTA 3

  li $v0, 4
  la $a0, pergunta3
  syscall

  jal le_escreve_op3

  # PERGUNTA 4

  li $v0, 4
  la $a0, pergunta4
  syscall

  jal le_escreve_op3

  # PERGUNTA 5

  li $v0, 4
  la $a0, pergunta5
  syscall

  jal le_escreve_op3

  # PERGUNTA 6

  li $v0, 4
  la $a0, pergunta6
  syscall

  li $t1, 6 # indicador

  jal le_escreve_op3

  # PERGUNTA 6.1

  li $v0, 4
  la $a0, pergunta6_1
  syscall

  jal le_escreve_op3

  # PERGUNTA 6.2

  li $v0, 4
  la $a0, pergunta6_2
  syscall

  jal le_escreve_op3

reacao:

  # Syscall 13, Modo 0x202 (514 em decimal) - Abre o arquivo e trunca para 0 bytes
  li $v0, 13              
  la $a0, string_saida            
  li $a1, 0x202
  li $a2, 0x1FF
  syscall

  bltz $v0, sair_op3
  move $s0, $v0

  # Syscall 15 - Escrita (no caso, sobrescreve/atualiza o conteúdo)
  li $v0, 15                  
  move $a0, $s0               
  la $a1, buffer_relato              
  li $a2, 8                 
  syscall

  # Syscall 16 - Fecha o arquivo (de intensidade)
  li $v0, 16
  move $a0, $s0
  syscall

  # Syscall 13, Modo 0 - Abre o arquivo (de reacao) para leitura
  li $v0, 13              
  la $a0, arquivo_reacao   
  li $a1, 0                  
  syscall

  bltz $v0, sair_op3
  move $s0, $v0

  # Syscall 14 - Lê o conteúdo do arquivo
  li $v0, 14                 
  move $a0, $s0           
  la $a1, buffer_relato          
  li $a2, 5            
  syscall

  # Syscall 16 - Fecha o arquivo
  li $v0, 16
  move $a0, $s0
  syscall

  la $t5, buffer_relato

  lb $t6, 0($t5)
  addi $t6, $t6, 1        # adiciona à contagem de quem respondeu ao formulário (geral)
  sb $t6, 0($t5)

  addi $t5, $t5, 1

  # PERGUNTA 7

  li $v0, 4
  la $a0, pergunta7
  syscall

  jal le_escreve_op3

  # PERGUNTA 8

  li $v0, 4
  la $a0, pergunta8
  syscall

  jal le_escreve_op3

  # PERGUNTA 9

  li $v0, 4
  la $a0, pergunta9
  syscall

  jal le_escreve_op3

  # PERGUNTA 10

  li $v0, 4
  la $a0, pergunta10
  syscall

  jal le_escreve_op3

  # Syscall 13, Modo 0x202 (514 em decimal) - Abre o arquivo e trunca para 0 bytes
  li $v0, 13              
  la $a0, arquivo_reacao            
  li $a1, 0x202
  li $a2, 0x1FF
  syscall

  bltz $v0, sair_op3
  move $s0, $v0

  # Syscall 15 - Escrita (no caso, sobrescreve/atualiza o conteúdo)
  li $v0, 15                  
  move $a0, $s0               
  la $a1, buffer_relato              
  li $a2, 5                 
  syscall

  # Syscall 16 - Fecha o arquivo (de reação)
  li $v0, 16
  move $a0, $s0
  syscall

  j sair_op3

le_escreve_op3:

  # imprime menu de opções
  li $v0, 4
  la $a0, menu_op3
  syscall

prompt_op3:

  # imprime prompt de escolha
  li $v0, 4
  la $a0, escolha_op
  syscall

  # lê input do usuário (não = 1, sim = 2)
  li $v0, 5
  syscall

  move $t9, $v0 # guarda resposta em $t9

  # verifica se resposta é não
  li $t2, 1
  beq $t9, $t2, resposta_nao_op3
  li $t2, 2
  bne $t9, $t2, escolha_invalida_op3

  # caso resposta for 'sim'
  lb $t6, 0($t5)
  addi $t6, $t6, 1
  sb $t6, 0($t5)

resposta_nao_op3:

  addi $t5, $t5, 1 # muda pra a próxima posição do buffer de relato

  # verifica se chegou na pergunta 6 (possível desvio)
  li $t2, 6
  beq $t1, $t2, caso_p6
  
  li $t1, 0 # reseta indicador

  jr $ra

escolha_invalida_op3:

  li $v0, 4
  la $a0, opcao_invalida_saida
  syscall

  j prompt_op3

caso_p6:

  li $t1, 0 # reseta indicador
  
  li $t2, 1 # não
  beq $t9, $t2, p6_nao

voltar_relato:

  jr $ra

p6_nao:

  addi $t5, $t5, 2 # avança 2 posições no buffer de relato (6.1 e 6.2)

  j reacao

sair_op3:

  li $v0, 4                       # imprime mensagem de tchau
  la $a0, tchau_op3
  syscall

escolha_saida_op3:

  li $v0, 4                       # imprime menu de saída
  la $a0, menu_saida
  syscall

  li $v0, 4                       # imprime mensagem de escolha
  la $a0, escolha_op
  syscall

  li $v0, 5                       # lê input do usuário
  syscall

  li $t2, 1
  beq $v0, $t2, menu_principal    # 1 = voltar para o menu principal
  li $t2, 2
  beq $v0, $t2, fim               # 2 = fim

  li $v0, 4
  la $a0, opcao_invalida_saida
  syscall

  j escolha_saida_op3

opcao4: # Instruções de sobrevivência

  j menu_principal

opcao5: # guia de uso do sistema

  # imprime menu header
  li $v0, 4
  la $a0, header
  syscall

  # imprime opção 1
  li $v0, 4
  la $a0, menu_option1
  syscall
  
  # imprime descricao opcao 1
  li $v0, 4
  la $a0, descricao_opcao1
  syscall
  
  # imprime linha vazia
  li $v0, 4
  la $a0, menu_linha_vazia 
  syscall
  
  # imprime opção 2
  li $v0, 4
  la $a0, menu_option2
  syscall
  
  # imprime descricao opcao 2
  li $v0, 4
  la $a0, descricao_opcao2
  syscall
  
  # imprime linha vazia
  li $v0, 4
  la $a0, menu_linha_vazia 
  syscall
  
  # imprime opção 3
  li $v0, 4
  la $a0, menu_option3
  syscall
  
  # imprime descricao opcao 3
  li $v0, 4
  la $a0, descricao_opcao3
  syscall
  
  # imprime linha vazia
  li $v0, 4
  la $a0, menu_linha_vazia 
  syscall
  
  # imprime opção 4
  li $v0, 4
  la $a0, menu_option4
  syscall
  
  # imprime descricao opcao 4
  li $v0, 4
  la $a0, descricao_opcao4
  syscall
  
  # imprime linha vazia
  li $v0, 4
  la $a0, menu_linha_vazia 
  syscall
  
  # imprime opção 5
  li $v0, 4
  la $a0, menu_option5
  syscall
  
  # imprime descricao opcao 5
  li $v0, 4
  la $a0, descricao_opcao5
  syscall
  
  # imprime linha vazia
  li $v0, 4
  la $a0, menu_linha_vazia 
  syscall
  
  # imprime opção 6
  li $v0, 4
  la $a0, menu_option6
  syscall
  
  # imprime descricao opcao 6
  li $v0, 4
  la $a0, descricao_opcao6
  syscall
  
  # imprime menu footer
  li $v0, 4
  la $a0, footer
  syscall

  j opcao_menu

fim:
  li $v0, 10
  syscall