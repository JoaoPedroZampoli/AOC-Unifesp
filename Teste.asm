.data
    caminhocsv:   .asciiz "C:\\Users\\jpsza\\OneDrive\\Documentos\\GitHub\\Pessoal\\AOC-Unifesp\\TrabalhoDeAOC\\significant_month.csv"
    buffer:     .space  1024
    novalinha:    .asciiz "\n"

.text
main:
    li      $v0, 13
    la      $a0, caminhocsv
    li      $a1, 0
    syscall
    bltz    $v0, FimPrograma
    move    $s0, $v0

    li      $v0, 14
    move    $a0, $s0
    la      $a1, buffer
    li      $a2, 1024
    syscall

    li      $v0, 16
    move    $a0, $s0
    syscall

    la      $a0, buffer
    jal     VerificaEPrinta

FimPrograma:
    li      $v0, 10
    syscall

VerificaEPrinta:
    li      $t0, 0

VerificaLoop:
    lb      $t1, buffer($t0)
    beqz    $t1, FimVerifica

    li      $t2, '\n'
    beq     $t1, $t2, PrintNovaLinha

    move    $a0, $t1
    li      $v0, 11
    syscall

    addi    $t0, $t0, 1
    j       VerificaLoop

PrintNovaLinha:
    la      $a0, novalinha
    li      $v0, 4
    syscall

    addi    $t0, $t0, 1
    j       VerificaLoop

FimVerifica:
    jr      $ra