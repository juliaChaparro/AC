
    .data 
TAM_VET: .word32 2 ; vai ser o tamanho do vetor 
VETOR: .word32 1,9 ; vai ser quais elementos tem no meu vetor 
CHAVE: .word32 8 ; qual eh a chave que voce quer encontrar 

ACHOU:        .asciiz "SIM" ; se a chave que voce quiz procurar estava no vetor 
N_ACHOU:      .asciiz "NAO" ; se a cahve que voce quiz procurar nao estava no vetor
PARAMS_SYS5:    .space 8

    .code

SETUP:
    lw $s1, TAM_VET($zero); final do meu vetor 
    addi $t9,$zero,0; inicio do meu vetor 
    addi $s2, $zero,2 ; registrador de apoio 
    addi $s3,$s3,4 ; registrador de apoio


TAM:    ;funcao que calcula o meio 

    add $a3,$t9,$s1 ; a3 guarda o resultado da soma do inicio mas fim
    div  $a3, $s2 ; dividindo os resultado da soma por 2 para achar o meio 
    MFLO $s4 ; pegando o resultado da divisao 
    j MEIO
    
MOVER_INICIO:
    addi $t9 ,$s4,1 ; vai pegar e somar +1 para o valor original ser o meu novo tamanho
    BEQ $t9,$s1, N_ACHOU ; se os vetores chegarem no final e forem igual e nao ter encontrado o valor buscado vai para a label  nao achou
    j TAM    

MOVER_FIM:
    sub $s1,$s1,$s4 ; vai diminuir o valor do fim 
    addi $s1,$s1,-1
    BEQ $t9,$s1, N_ACHOU  ;se os vetores chegarem no final e forem igual e nao ter encontrado o valor buscado vai para a label  nao achou
    j TAM


MEIO:
    mult $s4,$s3 ; multiplicando os valores para ter o indice do vetor 
    MFLO $s6; indice do meio do meu vetor  
    lw $s7, VETOR($s6) ; o valor do meio do meu vetor 
    lw $t8, CHAVE($zero) ; colocando a chave de busca 
    BEQ $s7,$t8, ACHOU ; vendo se o valor do vetor e a chave for igual ele vai para a label ACHOU
    BNE $s7,$t8, LOOP ; se nao for igual ele vai para a label LOOP


ACHOU: ;
    daddi $a0,$zero,ACHOU 
    j PRINT


N_ACHOU:
    daddi $a0,$zero,N_ACHOU
    j PRINT

PRINT: ; vai colocar na tela o que colocado nos registradores 
    sw $a0, PARAMS_SYS5($zero)
    addi $t6,$zero,PARAMS_SYS5
    syscall 5
    syscall 0


LOOP:   ; se o valor do vetor for menor que a chave feita vai executar o codigo decidindo qual label (MOVER_INICIO e MOVER_FIM) sera para o caso 
    slt $t0, $s7,$t8
    BEQZ $t0, MOVER_FIM
    J MOVER_INICIO
