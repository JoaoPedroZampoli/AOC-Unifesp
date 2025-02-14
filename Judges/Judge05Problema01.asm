.data
    str1:           .asciiz "Digite o texto:\n"
    str2:           .asciiz "Digite a chave:\n"
    BufferTexto:    .space 256
    BufferChave:    .space 256
    BufferFiltrado: .space 256
    BufferChaveFiltrada: .space 256
    result:         .space 256

.text
.globl main
main:
    la   $a0, str1
    li   $v0, 4
    syscall

    la   $a0, BufferTexto
    li   $v0, 8
    li   $a1, 256
    syscall

    la   $a0, str2
    li   $v0, 4
    syscall

    la   $a0, BufferChave
    li   $v0, 8
    li   $a1, 256
    syscall

    la   $t0, BufferTexto
    la   $t1, BufferFiltrado

LoopFiltro:
    lb   $t2, 0($t0)
    beq  $t2, $zero, FiltroPassado
    li   $t3, 65
    li   $t4, 90
    bge  $t2, $t3, CheckMaiusculas
    j    CheckMinusculas

CheckMaiusculas:
    ble  $t2, $t4, StoreLetra
    j    CheckMinusculas

CheckMinusculas:
    li   $t3, 97
    li   $t4, 122
    blt  $t2, $t3, PulaLetra
    bgt  $t2, $t4, PulaLetra

StoreLetra:
    sb   $t2, 0($t1)
    addi $t1, $t1, 1

PulaLetra:
    addi $t0, $t0, 1
    j    LoopFiltro

FiltroPassado:
    sb   $zero, 0($t1)

    la   $t0, BufferChave
    la   $t1, BufferChaveFiltrada

LoopFiltroChave:
    lb   $t2, 0($t0)
    beq  $t2, $zero, FiltroChavePassado
    li   $t3, 65
    li   $t4, 90
    bge  $t2, $t3, CheckChaveMaiusculas
    j    CheckChaveMinusculas

CheckChaveMaiusculas:
    ble  $t2, $t4, StoreChave
    j    CheckChaveMinusculas

CheckChaveMinusculas:
    li   $t3, 97
    li   $t4, 122
    blt  $t2, $t3, PulaChave
    bgt  $t2, $t4, PulaChave
    addi $t2, $t2, -32

StoreChave:
    sb   $t2, 0($t1)
    addi $t1, $t1, 1

PulaChave:
    addi $t0, $t0, 1
    j    LoopFiltroChave

FiltroChavePassado:
    sb   $zero, 0($t1)

    la   $t0, BufferFiltrado
    la   $t5, BufferChaveFiltrada
    la   $t6, result

LoopDescriptografar:
    lb   $t2, 0($t0)
    beq  $t2, $zero, Final

    lb   $t3, 0($t5)
    beq  $t3, $zero, ChaveReset
    j    ProcessaLetra

ChaveReset:
    la   $t5, BufferChaveFiltrada
    lb   $t3, 0($t5)

ProcessaLetra:
    move $t9, $t2
    li   $t8, 97
    blt  $t9, $t8, ProcessaMaiuscula
    j    ProcessaMinuscula

ProcessaMaiuscula:
    sub  $t2, $t9, 65
    j    DoDecrypt

ProcessaMinuscula:
    sub  $t2, $t9, 97

DoDecrypt:
    sub  $t3, $t3, 65
    sub  $t4, $t2, $t3
    addi $t4, $t4, 26
    li   $t7, 26
    div  $t4, $t7
    mfhi $t4

    li   $t8, 97
    blt  $t9, $t8, ManterMaiuscula
    j    ManterMinuscula

ManterMaiuscula:
    addi $t4, $t4, 65
    j    StoreResult

ManterMinuscula:
    addi $t4, $t4, 97

StoreResult:
    sb   $t4, 0($t6)
    addi $t6, $t6, 1

    addi $t0, $t0, 1
    addi $t5, $t5, 1
    j    LoopDescriptografar

Final:
    sb   $zero, 0($t6)

    li   $v0, 4
    la   $a0, result
    syscall

    li   $v0, 10
    syscall