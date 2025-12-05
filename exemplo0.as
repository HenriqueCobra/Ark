;------------------------------------------------------------------------------
; ZONA I: Definicao de constantes
;         Pseudo-instrucao : EQU
;------------------------------------------------------------------------------
WRITE	        EQU     FFFEh
INITIAL_SP      EQU     FDFFh
CURSOR			EQU     FFFCh
CURSOR_INIT		EQU     FFFFh
FIM_TEXTO 		EQU 	'@'

;------------------------------------------------------------------------------
; ZONA II: definicao de variaveis
;          Pseudo-instrucoes : WORD - palavra (16 bits)
;                              STR  - sequencia de caracteres (cada ocupa 1 palavra: 16 bits).
;          Cada caracter ocupa 1 palavra
;------------------------------------------------------------------------------

		ORIG	8000h
Linha0 	STR '%==============================================================================%', FIM_TEXTO
Linha1	STR '|Pontos:                                  arkanoid                       Vidas:|', FIM_TEXTO
Linha2 	STR '%==============================================================================%', FIM_TEXTO
Linha3	STR '|                                                                              |', FIM_TEXTO
Linha4  STR '|                                                                              |', FIM_TEXTO
Linha5	STR '|                                                                              |', FIM_TEXTO
Linha6	STR '|                                                                              |', FIM_TEXTO
Linha7	STR '|                                                                              |', FIM_TEXTO
Linha8	STR '|                                                                              |', FIM_TEXTO
Linha9	STR '|                                                                              |', FIM_TEXTO
Linha10	STR '|                                                                              |', FIM_TEXTO
Linha11	STR '|                                                                              |', FIM_TEXTO
Linha12	STR '|                                                                              |', FIM_TEXTO
Linha13	STR '|                                                                              |', FIM_TEXTO
Linha14	STR '|                                                                              |', FIM_TEXTO
Linha15	STR '|                                                                              |', FIM_TEXTO
Linha16	STR '|                                                                              |', FIM_TEXTO
Linha17	STR '|                                                                              |', FIM_TEXTO
Linha18	STR '|                                                                              |', FIM_TEXTO
Linha19	STR '|                                                                              |', FIM_TEXTO
Linha20	STR '|                                                                              |', FIM_TEXTO
Linha21	STR '|                                                                              |', FIM_TEXTO
Linha22	STR '|                                                                              |', FIM_TEXTO
Linha23 STR '%==============================================================================%', FIM_TEXTO


ShipIndex WORD 40d

Blank 		STR ' ',FIM_TEXTO
ShipPart	STR '_',FIM_TEXTO

Alerta 	STR 'Arquitetura de computadores', FIM_TEXTO
index   WORD 	0d
Linha   WORD 	0d
Coluna  WORD	0d
	
;------------------------------------------------------------------------------
; ZONA II: definicao de tabela de interrupções
;------------------------------------------------------------------------------

			ORIG 	FE00h
INT0 		WORD 	Interrompe
INT1		WORD    MovDireita

;------------------------------------------------------------------------------
; ZONA IV: codigo
;        conjunto de instrucoes Assembly, ordenadas de forma a realizar
;        as funcoes pretendidas
;------------------------------------------------------------------------------
                ORIG    0000h
                JMP     Main

RotinaInterrupcao: PUSH R1
		PUSH R2
		PUSH R3
		PUSH R4



		POP R4
		POP R3
		POP R2
		POP R1

		RTI

Funcao: PUSH R1
		PUSH R2
		PUSH R3
		PUSH R4



		POP R4
		POP R3
		POP R2
		POP R1

		RET

; R1 endereço da string
; R2 caracter atual
; R3 linha
; R4 coluna
; R5 contador

Interrompe: PUSH R1
		PUSH R2
		PUSH R3
		PUSH R4

		
		MOV R1, Alerta

		CALL PrintStrChar

		POP R4
		POP R3
		POP R2
		POP R1

		RTI

MovDireita: PUSH R1
			PUSH R2
			PUSH R3
			PUSH R4
			PUSH R5

			MOV R3, 21d
			MOV R1, M[ Blank ]
			MOV R4, M[ ShipIndex ]
			CALL PrintChar

			MOV R1, M[ ShipPart ]
			MOV R5, M[ ShipIndex ]
			ADD R5, 3d
			MOV R4, R5
			CALL PrintChar

			POP R4
			POP R3
			POP R2
			POP R1

			RTI


Printf:		PUSH R1
			PUSH R2
			PUSH R3
			PUSH R4
			PUSH R5
			PUSH R6

			MOV 	R5, 0d

			Ciclo:	MOV 	R6, R3
					ADD		R1, R5
					MOV		R2, M[R1]
					CMP 	R2, FIM_TEXTO
					JMP.z   EndPrintf
					ADD 	R4, R5
					SHL 	R6, 8
					OR 		R6, R4
					MOV 	M[CURSOR], R6
					MOV 	M[WRITE], R2
					SUB 	R4, R5
					SUB     R1, R5
					INC     R5
					JMP   	Ciclo

EndPrintf:	POP R6
			POP R5
			POP R4
			POP R3
			POP R2
			POP R1

			RET

PrintChar:	PUSH R1
			PUSH R3
			PUSH R4

			SHL 	R2, 8d
			OR 		R2, R3
			MOV 	M[CURSOR], R2
			MOV 	M[WRITE], R1
			
			POP R3
			POP R2
			POP R1

			RET

PrintStrChar:	PUSH R1
			PUSH R2
			PUSH R3
			PUSH R4
			PUSH R5

			MOV		R4, M[ index ]
			ADD		R4, R1
			MOV		R1, M[ R4 ]
			CMP 	R1, FIM_TEXTO
			JMP.z   EndPrintStrChar
			MOV 	R2, M[Linha]
			MOV 	R3, M[Coluna]
			SHL 	R2, 8d
			OR 		R2, R3
			MOV 	M[CURSOR], R2
			MOV 	M[WRITE], R1
			INC 	M[ index ]
			INC 	M[ Linha ]
			INC 	M[ Coluna]

EndPrintStrChar:	POP R5
				POP R4
				POP R3
				POP R2
				POP R1

				RET

PrintMap:	PUSH R1
			PUSH R2
			PUSH R3
			PUSH R4

			MOV		R1, Linha0
			MOV 	R3, M[ Linha ]
			MOV 	R4, M[ Coluna ]

	Ciclo1:	CMP     R3,	24
			JMP.z   EndPrintMap
			CALL	Printf
			ADD		R1, 81d
			INC 	R3
			JMP 	Ciclo1

EndPrintMap:POP R1
			POP R2
			POP R3
			POP R4

			RET

Main:	ENI
		MOV		R1, INITIAL_SP
		MOV		SP, R1		 		; We need to initialize the stack
		MOV		R1, CURSOR_INIT		; We need to initialize the cursor 
		MOV		M[ CURSOR ], R1		; with value CURSOR_INIT
		
		CALL 	PrintMap


							
Cycle:	BR		Cycle	
Halt:   BR		Halt
