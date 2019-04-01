#Trabalho 1 de Organização e Arquitetura de Computadores.

#O objetivo desse trabalho é fazer um programa em Assembly MIPS que simule uma calculadora com
#determinadas operações.

#Convenção: argumentos para os procedimentos sempre ficam entre os registradores $a0, ..., $a3(ou $f.. para valores flutuantes)
# e retorno sempre em $v0 e/ou $v1;

#ATENÇÃO: APENAS DIVISÃO E IMC TRATAM NÚMEROS FLOAT

#data:
	.data
	.align 0
	
ponteiro: .word	
		
str_menu: .asciiz "Escolha uma das seguintes opções:\n"
str_op0: .asciiz "Opção 0 -> Soma;\n"
str_op1: .asciiz "Opção 1 -> Subtração;\n"
str_op2: .asciiz "Opção 2 -> Multiplicação;\n"
str_op3: .asciiz "Opção 3 -> Divisão;\n"
str_op4: .asciiz "Opção 4 -> Potência;\n"
str_op5: .asciiz "Opção 5 -> Raiz quadrada;\n"
str_op6: .asciiz "Opção 6 -> Tabuada de um número;\n"
str_op7: .asciiz "Opção 7 -> Cálculo de IMC;\n"
str_op8: .asciiz "Opção 8 -> Fatorial;\n"
str_op9: .asciiz "Opção 9 -> Sequência de Fibonacci;\n"
str_op10: .asciiz "Opção 10 -> Sair do programa;\n"
str_dig1_32b: .asciiz "Digite um número(até 32 bits):"
str_dig2_32b: .asciiz "Digite outro número(até 32 bits):"
str_dig1_16b: .asciiz "Digite um número(até 16 bits):"
str_dig2_16b: .asciiz "Digite outro número(até 16 bits):"
str_peso: .asciiz "Digite o peso(em kg)(até 16 bits):"
str_altura: .asciiz "Digite a altura:(em m)(até 16 bits):"
str_res: .asciiz "O resultado é: "
str_fim: .asciiz "Fim de execução.\n"
str_erro: .asciiz "Erro -> Opção Inválida!\n"
str_erro_16b: .asciiz "Erro -> Número digitado excede os 16 bits.\n"
str_erro_div_zero: .asciiz "Erro -> Divisão por zero!\n"
str_erro_raiz_neg: .asciiz "Erro -> Raiz negativa!\n"
str_barra_n: .asciiz "\n"
str_virgula: .asciiz ", "

	.align 2				
float_16b: .float 65535.0		
float_zero: .float 0.0
		
#text:	
	.text
	.globl main
main:	
	#seta os valores de comparação:
	li $t0, 1
	li $t1, 2
	li $t2, 3
	li $t3, 4
	li $t4, 5
	li $t5, 6
	li $t6, 7
	li $t7, 8
	li $t8, 9
	li $t9, 10
	
	#variável auxiliar para o loop do switch:
	li $v1, 1
	j switch
	
erro:
	li $v0, 4
	la $a0, str_erro
	syscall
	
switch:			
	#imprimir menu e opções:
	li $v0, 4
	la $a0, str_menu
	syscall	
	la $a0, str_op0
	syscall
	la $a0, str_op1
	syscall
	la $a0, str_op2
	syscall
	la $a0, str_op3
	syscall
	la $a0, str_op4
	syscall
	la $a0, str_op5
	syscall
	la $a0, str_op6
	syscall
	la $a0, str_op7
	syscall
	la $a0, str_op8
	syscall
	la $a0, str_op9
	syscall
	la $a0, str_op10
	syscall
	
	#ler opção digitada:			
	li $v0, 5
	syscall
	

	#seleciona o label para onde realizará o brench
	blt $v0, $zero, erro
	beq $v0, $zero, op0
	beq $v0, $t0, op1			
	beq $v0, $t1, op2					
	beq $v0, $t2, op3
	beq $v0, $t3, op4
	beq $v0, $t4, op5
	beq $v0, $t5, op6
	beq $v0, $t6, op7
	beq $v0, $t7, op8
	beq $v0, $t8, op9
	beq $v0, $t9, op10
	bgt $v0, $t9, erro

#Soma	
op0:
	#imprime str_dig1_32b
	li $v0, 4
	la $a0, str_dig1_32b
	syscall
	#lê o primeiro número
	li $v0, 5
	syscall
	
	#argumento do procedimento soma
	move $a1, $v0
	
	#imprime str_dig2_32b
	li $v0, 4
	la $a0, str_dig2_32b
	syscall
	#lê o segundo número
	li $v0, 5
	syscall
	
	move $a0, $a1  #primeiro argumento no a0
	
	#argumento do procedimento soma
	move $a1, $v0
	
	jal soma
	
	#argumento para imprimir posteriormente
	move $a1, $v0
	
	#imprime str_res
	li $v0, 4
	la $a0, str_res
	syscall
	
	#imprime o retorno
	move $a0, $a1
	li $v0, 1
	syscall
	
	#imprime str_barra_n
	li $v0, 4
	la $a0, str_barra_n
	syscall
	
	j switch
	
							
#Subtração						
op1:
	#imprime str_dig1_32b
	li $v0, 4
	la $a0, str_dig1_32b
	syscall
	#lê o primeiro número
	li $v0, 5
	syscall
	
	#argumento do procedimento subtrair
	move $a1, $v0
	
	#imprime str_dig2_32b
	li $v0, 4
	la $a0, str_dig2_32b
	syscall
	#lê o segundo número
	li $v0, 5
	syscall
	
	move $a0, $a1  #primeiro argumento no a0
	
	#argumento do procedimento subtrair
	move $a1, $v0
	
	jal subtracao
	
	#argumento para imprimir posteriormente
	move $a1, $v0
	
	#imprime str_res
	li $v0, 4
	la $a0, str_res
	syscall
	
	#imprime o retorno
	move $a0, $a1
	li $v0, 1
	syscall
	
	#imprime str_barra_n
	li $v0, 4
	la $a0, str_barra_n
	syscall
	
	j switch
		
				
#Multiplicação	
op2:
	#imprime str_dig1_16b
	li $v0, 4
	la $a0, str_dig1_16b
	syscall
	#lê o primeiro número
	li $v0, 5
	syscall
	
	#argumento do procedimento multiplicar
	move $a1, $v0
	
	#confere se o número digitado cabe em 16 bits
	li $v0, 65535 #v0 = (2^16 - 1)
	bgt $a1, $v0, erro_16b
	
	#imprime str_dig2_16b
	li $v0, 4
	la $a0, str_dig2_16b
	syscall
	#lê o segundo número
	li $v0, 5
	syscall
	
	move $a0, $a1 #primeiro argumento no a0
	
	#argumento do procedimento multiplicar
	move $a1, $v0
	
	#confere se o número digitado cabe em 16 bits
	li $v0, 65535 #v0 = (2^16 - 1)
	bgt $a1, $v0, erro_16b	
	
	jal multiplicacao
	
	#argumento para imprimir posteriormente
	move $a1, $v0
	
	#imprime str_res
	li $v0, 4
	la $a0, str_res
	syscall
	
	#imprime o retorno
	move $a0, $a1
	li $v0, 1
	syscall
	
	#imprime str_barra_n
	li $v0, 4
	la $a0, str_barra_n
	syscall

	j switch
	

#Divisão	
op3:
	#imprime str_dig1_16b
	li $v0, 4
	la $a0, str_dig1_16b
	syscall
	#lê o primeiro número
	li $v0, 6
	syscall
	
	#argumento do procedimento dividir
	mov.s $f1, $f0
	
	#confere se o número digitado cabe em 16 bits
	l.s $f2, float_16b #f2 = (2^16 - 1)
	c.lt.s $f2, $f1
	bc1t erro_16b
	
	#imprime str_dig2_16b
	li $v0, 4
	la $a0, str_dig2_16b
	syscall
	#lê o segundo número
	li $v0, 6
	syscall
	
	#primeiro argumento está no $f1, segundo no $f0
	
	#confere se o número digitado cabe em 16 bits
	c.lt.s $f2, $f0
	bc1t erro_16b 	
	
	#$v1 == 0 (inicializa sem erro)
	li $v1, 0

	#swap entre $f0 e $f1
	mov.s $f2, $f0
	mov.s $f0, $f1
	mov.s $f1, $f2

	jal divisao
	
	#confere se o $v1 é 1(erro de divisão por 0)
	bne $v1, $zero, erro_div_zero
	
	#imprime str_res
	li $v0, 4
	la $a0, str_res
	syscall
	
	#imprime o retorno
	mov.s $f12, $f2
	li $v0, 2
	syscall
	
	#imprime str_barra_n
	li $v0, 4
	la $a0, str_barra_n
	syscall
	
	j switch

erro_div_zero:
	li $v0, 4
	la $a0, str_erro_div_zero
	syscall
	
	j switch		
			

	
#Potenciação	
op4:
	#imprime str_dig1_32b
	li $v0, 4
	la $a0, str_dig1_32b
	syscall
	#lê o primeiro número
	li $v0, 5
	syscall
	
	#argumento do procedimento potencia
	move $a1, $v0
	
	#imprime str_dig2_32b
	li $v0, 4
	la $a0, str_dig2_32b
	syscall
	#lê o segundo número
	li $v0, 5
	syscall
	
	move $a0, $a1  #primeiro argumento no a0
	
	#argumento do procedimento potencia
	move $a1, $v0

	jal potencia
	
	#argumento para imprimir posteriormente
	move $a1, $v0
	
	#imprime str_res
	li $v0, 4
	la $a0, str_res
	syscall
	
	#imprime o retorno
	move $a0, $a1
	li $v0, 1
	syscall
	
	#imprime str_barra_n
	li $v0, 4
	la $a0, str_barra_n
	syscall
	
	j switch
	
			
#Raiz quadrada	
op5:
	#imprime str_dig1_32b
	li $v0, 4
	la $a0, str_dig1_32b
	syscall
	#lê o número
	li $v0, 5
	syscall
	
	#argumento do procedimento raiz
	move $a0, $v0
	
	jal raiz_quadrada	
	
	#confere se o $v1 é 1(erro de raiz de numero negativo)
	blt $v1, $zero, erro_raiz_neg
		
	
	#argumento para imprimir posteriormente
	move $a1, $v0
	
	#imprime str_res
	li $v0, 4
	la $a0, str_res
	syscall
	
	#imprime o retorno
	move $a0, $a1
	li $v0, 1
	syscall
	
	#imprime str_barra_n
	li $v0, 4
	la $a0, str_barra_n
	syscall
	j switch
	
erro_raiz_neg:
	li $v0, 4
	la $a0, str_erro_raiz_neg
	syscall
	
	j switch

#Tabuada	
op6:
	#imprime str_dig1_32b
	li $v0, 4
	la $a0, str_dig1_32b
	syscall
	#lê o número
	li $v0, 5
	syscall
	
	#argumento do procedimento tabuada
	move $a0, $v0
	
	jal tabuada
	j switch	
	
	
#Cálculo de IMC	
op7:
	
	#imprime str_altura
	li $v0, 4
	la $a0, str_altura
	syscall
	#lê o primeiro número
	li $v0, 6
	syscall
	
	#argumento do procedimento imc
	mov.s $f1, $f0
	
	#confere se o número digitado cabe em 16 bits
	l.s $f2, float_16b #f2 = (2^16 - 1)
	c.lt.s $f2, $f1
	bc1t erro_16b
	
	#imprime str_peso
	li $v0, 4
	la $a0, str_peso
	syscall
	#lê o segundo número
	li $v0, 6
	syscall
	
	#confere se o número digitado cabe em 16 bits
	c.lt.s $f2, $f0
	bc1t erro_16b
	
	li $v1, 0 #seta erro para zero
	
	jal IMC
	
	bne $v1, $zero, erro_div_zero
	
	#imprime str_res
	li $v0, 4
	la $a0, str_res
	syscall
	
	#imprime o retorno
	mov.s $f12, $f2
	li $v0, 2
	syscall
	
	#imprime str_barra_n
	li $v0, 4
	la $a0, str_barra_n
	syscall
	
	j switch	
	
	
#Fatorial	
op8:
	#imprime str_dig1_32b
	li $v0, 4
	la $a0, str_dig1_32b
	syscall
	#lê o número
	li $v0, 5
	syscall
	
	#argumento do procedimento fatorial
	move $a0, $v0
	
	jal fatorial
	
	#argumento para imprimir posteriormente
	move $a1, $v0
	
	#imprime str_res
	li $v0, 4
	la $a0, str_res
	syscall
	
	#imprime o retorno
	move $a0, $a1
	li $v0, 1
	syscall

	#imprime str_barra_n
	li $v0, 4
	la $a0, str_barra_n
	syscall

	j switch	

	
#Fibonacci		
op9:
	#imprime str_dig1_32b
	li $v0, 4
	la $a0, str_dig1_32b
	syscall
	#lê o primeiro número
	li $v0, 5
	syscall
	
	#argumento do procedimento fibonacci
	move $a1, $v0
	
	#imprime str_dig2_32b
	li $v0, 4
	la $a0, str_dig2_32b
	syscall
	#lê o segundo número
	li $v0, 5
	syscall
	
	move $a0, $a1  #primeiro argumento no a0
	
	#argumento do procedimento fibonacci
	move $a1, $v0
	
	jal fibonacci_em_intervalo
	
	j switch	


		
op10:
	#imprime mensagem de encerramento
	li $v0, 4
	la $a0, str_fim
	syscall
	
	#sai do programa
	li $v0, 10
	syscall
	
	
erro_16b:
	#imprime mensagem de erro
	li $v0, 4
	la $a0, str_erro_16b	
	syscall
	
	j switch
		
																	


#Procedimentos:

#procedimento soma:
#parâmetros: $a0, $a1
#retorno: $v0
soma:   
	addi $sp, $sp, -12
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	           
	add $v0, $a0, $a1  #soma os dois numeros dados e salva em v0
    	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
   	jr $ra
	
	
#procedimento subtracao:
#parâmetros: $a0, $a1
#retorno: $v0	
subtracao:      
        addi $sp, $sp, -12
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
        
        sub $v0, $a0, $a1   #subtrai os dois numeros dados e salva em v0
    
        lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
        jr $ra
	
	
#procedimento multiplicacao:
#parâmetros: $a0, $a1
#retorno: $v0	
multiplicacao:
	addi $sp, $sp, -12
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	  
	mul $v0, $a0, $a1   #multiplica os dois numeros dados e salva em v0
    
        lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
        jr $ra


#procedimento divisao:
#parâmetros: $f0, $f1
#retorno: $f2(resultado), $v1(erro)	
divisao:
	addi $sp, $sp, -12
	s.s $f0, 0($sp)
	s.s $f1, 4($sp)
	sw $ra, 8($sp) 

	#trata o caso de divisão por zero
	l.s $f2 , float_zero
	c.eq.s $f1, $f2
	bc1t erro_divisao
	div.s $f2, $f0, $f1 #divide os dois numeros dados e salva o resultado em $f2
	j retorna_divisao
erro_divisao:
	li $v1, 1
retorna_divisao:
	l.s $f0, 0($sp)
	l.s $f1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
    	jr $ra
	


#procedimento IMC:
#parâmetros: $f0, $f1 (peso e altura, respectivamente)
#retorno: $f2(IMC), $v1(erro)	
IMC: 
	addi $sp, $sp, -12
	s.s $f0, 0($sp)
	s.s $f1, 4($sp)
	sw $ra, 8($sp)
	
	#trata o caso de erro da altura == 0, para não dividir por 0
	l.s $f2, float_zero
	c.eq.s $f1, $f2
	bc1t erro_IMC
	
	mul.s $f2, $f1, $f1   #f2 = altura * altura
   	div.s $f2, $f0, $f2   #f2 = peso / v0
	j retorna_IMC
erro_IMC:
	li $v1, 1	
retorna_IMC:
	l.s $f0, 0($sp)
	l.s $f1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
    	jr $ra	


#procedimento fatorial recursivo: recebe como parametro o inteiro em $a0 e retorna o fatorial dele em $v0	
fatorial:
	#armazena $a0 e $ra na pilha
	addi $sp, $sp, -8
	sw $a0, 0($sp)	
	sw $ra, 4($sp)
	
	ble $a0, $zero, retorna1 #a0 <= 0, retorna 1
	subi $a0, $a0, 1  #a0--
	jal fatorial #chamada recursiva
	addi $a0, $a0, 1 #evita que multiplique v0 por 0
	mul $v0, $v0, $a0 
	j retorna_fat 
	
retorna1:
	li $v0, 1
	
retorna_fat:	
	
	#recupera da pilha
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	#return
	jr $ra	

#Procedimento potencia recebe argumentos $a0 e $a1 e retorna em $v0 o resultado;
#a0 base
#a1 potencia desejada				
potencia:
	addi $sp, $sp, -12
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp) 
	li $v0, 1
	
powLoop:
	beqz $a1, exit_powLoop
	mul $v0, $v0, $a0			
	addi $a1, $a1, -1	
	j powLoop	
				
exit_powLoop:
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp) 
	addi $sp, $sp, 12
	jr $ra 								

	
#Procedimento raiz_quadrada recebe como argumento o $a0 e retorna sua raiz em $v0.
#a0 base da raiz
raiz_quadrada:
        #a0 base da raiz
        #EMPILHANDO $t0, $ra, $a0
        addi $sp, $sp, -28	# $sp = $sp - 28
        sw $t0, 0($sp) 
        sw $t1, 4($sp)		
        sw $t2, 8($sp)		  
        sw $t3, 12($sp)	        
        sw $t4, 16($sp)	         
        sw $ra, 20($sp)	        
        sw $a0, 24($sp)
        		 
        #COPIANDO O VALOR 2 PARA $t0
        addi $t0, $zero, 2		# $t0 = zero + 2
        addi $t1, $a0, 0		# $t1 = $a0 + 0
        div $t1, $t0			# $t1 / $t0
        mflo $t1			# send to $t1 quocient of div
        addi $t0, $zero, 0		# $t0 = $zero + 0
        addi $t2, $a0, 0		# $t2 = $a0 + 0
        addi $t4, $zero, 2		# $t4 = $zero + 2
rootLoop:
        bge $t0, $t1, exit_rootLoop	# if $t0 >= $t1 then exit_rootLoop
        div $a0, $t2			# $a0 / $t2
        mflo $t3 			# send to $t3 quocient of div
        add $t2, $t3, $t2		# $t0 = $t3 + $t2
        div $t2, $t4			# $t2 / $t4(2)
        mflo $t2			# send to $ quocient of div
        addi $t0, $t0, 1		# $t0 = $t0 + 1
        j rootLoop	# jump to rootLoop
exit_rootLoop:
        add $v0, $t2, $zero		# $v0 = $t2 + $zero
        lw $t0, 0($sp)		         
        lw $t1, 4($sp)		        
        lw $t2, 8($sp)		        
        lw $t3, 12($sp)	        
        lw $t4, 16($sp)	         
        lw $ra, 20($sp)	         
        lw $a0, 24($sp)		 
        addi $sp, $sp, 28		# $sp = $sp + 28
        jr $ra				# jump to $ra


#Procedimento tabuada recebe como argumento o $a0.
#a0 é o número que se deseja mostrar a tabuada. 
tabuada:
        #a0 como numero base para a tabuada
        addi $sp, $sp, -16		# $sp = $sp - 20
        sw $ra, 0($sp)		                
        sw $t0, 4($sp)		               
        sw $t1, 8($sp)		               
        sw $t2, 12($sp)		        
        sw $a0, 16($sp)	        	 
        addi $t0, $zero, 1		# $t0 = $zero + 1
        addi $t1, $zero, 10		# $t1 = $zero + 10
        add $t2, $zero, $a0		# $t2 = $zero + $a0
tabuadaLoop:
        bgt $t0, $t1, tabuada_exitLoop	# if $t0 > $t1 then tabuada_exitLoop
        add $a0, $zero, $t2		# $a0 = $zero + $t2
        mult $a0, $t0			# $a0 * $t0 = Hi and Lo registers
        mflo $a0			# copy Lo to $a0
        li $v0, 1	                # $v0 = 1
        syscall                         #printing integer
        #imprime str_barra_n
	li $v0, 4
	la $a0, str_barra_n
	syscall
        addi $t0, $t0, 1		# $t0 = $zero + 1
        j tabuadaLoop			#jump to tabuadaLoop
tabuada_exitLoop:
        lw $ra, 0($sp)		                
        lw $t0, 4($sp)		                 
        lw $t1, 8($sp)		               
        lw $t2, 12($sp)		        
        lw $a0, 16($sp)		                
        addi $sp, $sp, 16		# $sp = $sp + 20
        jr $ra				# jump to $ra
	



#Procedimento fibonacci_em_intervalo recebe como argumentos $a0 e $a1 com o intervalo de fibonacci desejado
# e chama o procedimento fibonacci para cada valor do intervalo imprimindo seu resultado;
fibonacci_em_intervalo:
	
	addi $sp, $sp, -12
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	
	subi $a0, $a0, 1
	
#loop para calcular o fibonacci de cada número do intervalo e imprimir este número	
loop_fibo: beq $a0, $a1, fim_loop_fibo
			
	jal fibonacci #retorno em $v0
	
	#imprime retorno
	move $s0, $a0
	move $s1, $v0
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, str_virgula
	syscall
	
	move $a0, $s0
	
	addi $a0, $a0, 1	
	j loop_fibo
fim_loop_fibo:
	
	li $v0, 4
	la $a0, str_barra_n
	syscall
			
							
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
        jr $ra


#Procedimento fibonacci recebe como parâmetro $a0 para o número da sequência de fibonacci 
fibonacci:
	addi $sp, $sp, -16
	sw $s0, 0($sp)	
	sw $s1, 4($sp)
	sw $a0, 8($sp)
	sw $ra, 12($sp)		
	
	li $s2, 0
    	slti $s2, $a0, 2     #se a0 menor que 2, s2 é 1
    	beq $s2, $zero, retorna_fib   #se s2 for 0, vai pro retorna_fib

    	addi $v0, $zero, 1   #últimas 2 chamadas da recursão
    	j retorna

retorna_fib: 
        addi $s0, $a0, 0
        addi $a0, $a0, -1
        jal fibonacci

        addi $s1, $v0, 0
        addi $a0, $s0, -2
        jal fibonacci

        add $v0, $s1, $v0
        #v0 tem o resultado

retorna: 
	lw $s0, 0($sp)
	lw $s1, 4($sp)
    	lw $a0, 8($sp)
    	lw $ra, 12($sp)
    	addi $sp, $sp, 16

    	jr $ra
	
	
	
	 																																		 																																		
