
    .data 

vetor: .word32 1,2,3,4,5,6,7,8
CHAVE: .word32 7

ACHOU:        .asciiz "SIM"
N_ACHOU:      .asciiz "NAO"

    .code

SETAP:
    addi $s1,$zero,8
    addi $s2,$zero,2
    addi $s3,$zero,4

TAM:
    div  $s1, $s2
    MFHI $s5
    MFLO $s4

    BNEZ $s5, MEIO
    BEQZ $S5, PAR


PAR:
        addi $s4, $s4,1;
        j MEIO


INICIO:


MEIO:
        mult $s4,$s3
        MFHI $s6
        

FIM:




