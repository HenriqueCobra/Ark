;------------------------------------------------------------------------------
; ZONA I: Definicao de constantes
;         Pseudo-instrucao : EQU
;------------------------------------------------------------------------------
WRITE	        EQU     FFFEh
INITIAL_SP      EQU     FDFFh
CURSOR			EQU     FFFCh
CURSOR_INIT		EQU     FFFFh
FIM_TEXTO 		EQU 	'@'
TIMER_UNITS     EQU     FFF6h
ACTIVATE_TIMER  EQU     FFF7h
ON              EQU     1d 
OFF             EQU     0d

CIMA_ESQUERDA   EQU     0d
CIMA_DIREITA    EQU     1d 
BAIXO_ESQUERDA  EQU     2d 
BAIXO_DIREITA   EQU     3d

MAP_WIDTH       EQU     81d    
MAP_HEIGHT	    EQU     24d 

TOP_BOUND       EQU     3d
BOTTOM_BOUND    EQU     22d
LEFT_BOUND      EQU     1d
RIGHT_BOUND     EQU     78d

SHIP_ROW        EQU     21d       
SHIP_INITIAL_X  EQU     36d       
SHIP_LEN   EQU     16d ;mudar a função print map pra imprimir mapa de tamanho correto


MAX_LIVES	  	EQU     5d

;------------------------------------------------------------------------------
; ZONA II: definicao de variaveis
;          Pseudo-instrucoes : WORD - palavra (16 bits)
;                              STR  - sequencia de caracteres (cada ocupa 1 palavra: 16 bits).
;          Cada caracter ocupa 1 palavra
;------------------------------------------------------------------------------

		ORIG	8000h
Mapa_Linha0 	STR '%==============================================================================%', FIM_TEXTO
Mapa_Linha1		STR '|Pontos: 000                         Arkanoid                         Vidas: x |', FIM_TEXTO
Mapa_Linha2 	STR '%==============================================================================%', FIM_TEXTO
Mapa_Linha3		STR '|                                                                              |', FIM_TEXTO
Mapa_Linha4  	STR '|          [x][x]                [x][x]                 [x][x]                 |', FIM_TEXTO
Mapa_Linha5		STR '|                                                                              |', FIM_TEXTO
Mapa_Linha6		STR '|                                                                              |', FIM_TEXTO
Mapa_Linha7		STR '|                                                                              |', FIM_TEXTO
Mapa_Linha8		STR '|                                                                              |', FIM_TEXTO
Mapa_Linha9		STR '|          [x][x]                [x][x]                  [x][x]                |', FIM_TEXTO
Mapa_Linha10	STR '|                                                                              |', FIM_TEXTO
Mapa_Linha11	STR '|                     [x]                      [x]                             |', FIM_TEXTO
Mapa_Linha12	STR '|                     [x]                      [x]                             |', FIM_TEXTO
Mapa_Linha13	STR '|                                                                              |', FIM_TEXTO
Mapa_Linha14	STR '|          [x][x]                 [x][x]                 [x][x]                |', FIM_TEXTO
Mapa_Linha15	STR '|                                                                              |', FIM_TEXTO
Mapa_Linha16	STR '|                                                                              |', FIM_TEXTO
Mapa_Linha17	STR '|                                                                              |', FIM_TEXTO
Mapa_Linha18	STR '|                                                                              |', FIM_TEXTO
Mapa_Linha19	STR '|                                                                              |', FIM_TEXTO
Mapa_Linha20	STR '|                                                                              |', FIM_TEXTO
Mapa_Linha21	STR '|                                                                              |', FIM_TEXTO
Mapa_Linha22	STR '|                                                                              |', FIM_TEXTO
Mapa_Linha23	STR '%==============================================================================%', FIM_TEXTO

Linha0 	STR '%==============================================================================%', FIM_TEXTO
Linha1	STR '|Pontos: 000                         Arkanoid                         Vidas: x |', FIM_TEXTO
Linha2 	STR '%==============================================================================%', FIM_TEXTO
Linha3	STR '|                                                                              |', FIM_TEXTO
Linha4  STR '|          [x][x]                [x][x]                 [x][x]                 |', FIM_TEXTO
Linha5	STR '|                                                                              |', FIM_TEXTO
Linha6	STR '|                                                                              |', FIM_TEXTO
Linha7	STR '|                                                                              |', FIM_TEXTO
Linha8	STR '|                                                                              |', FIM_TEXTO
Linha9	STR '|          [x][x]                [x][x]                  [x][x]                |', FIM_TEXTO
Linha10	STR '|                                                                              |', FIM_TEXTO
Linha11	STR '|                     [x]                      [x]                             |', FIM_TEXTO
Linha12	STR '|                     [x]                      [x]                             |', FIM_TEXTO
Linha13	STR '|                                                                              |', FIM_TEXTO
Linha14	STR '|          [x][x]                 [x][x]                 [x][x]                |', FIM_TEXTO
Linha15	STR '|                                                                              |', FIM_TEXTO
Linha16	STR '|                                                                              |', FIM_TEXTO
Linha17	STR '|                                                                              |', FIM_TEXTO
Linha18	STR '|                                                                              |', FIM_TEXTO
Linha19	STR '|                                                                              |', FIM_TEXTO
Linha20	STR '|                                                                              |', FIM_TEXTO
Linha21	STR '|                                                                              |', FIM_TEXTO
Linha22	STR '|                                                                              |', FIM_TEXTO
Linha23 STR '%==============================================================================%', FIM_TEXTO
LinhaGameOVR STR '|                                  Game Over                                   |', FIM_TEXTO
LinhaRestart STR '|                            Press [R] to Restart                              |', FIM_TEXTO

GameState WORD ON

ShipIndex WORD SHIP_INITIAL_X
ShipLen   WORD SHIP_LEN
ballState WORD BAIXO_DIREITA

Blank 		STR ' ',FIM_TEXTO
ShipPart	STR '-',FIM_TEXTO
Ball 		STR 'o',FIM_TEXTO

Alerta 	  STR 'Arquitetura de computadores', FIM_TEXTO
index     WORD 	0d
Linha     WORD 	0d
Coluna    WORD	0d
Character WORD  'A'

BallX	WORD	40d
BallY	WORD	20d

lifeCount WORD 	MAX_LIVES
Score	 WORD    0d
	
;------------------------------------------------------------------------------
; ZONA II: definicao de tabela de interrupções
;------------------------------------------------------------------------------

			ORIG 	FE00h
INT0 		WORD 	Interrompe
INT1		WORD    MovDireita
INT2		WORD 	MovEsquerda
INT3		WORD 	RestartGame
			ORIG 	FE0Fh
INT15       WORD    Timer

;------------------------------------------------------------------------------
; ZONA IV: codigo
;        conjunto de instrucoes Assembly, ordenadas de forma a realizar
;        as funcoes pretendidas
;------------------------------------------------------------------------------
                ORIG    0000h
                JMP     Main

Timer:  PUSH R1
		PUSH R2

		MOV R1, M[GameState]
		CMP R1, 1d
		JMP.nz EndTimer

		CALL BlockColision
		CALL ShipColision
		CALL LifeSys
		CALL MoveBall
		CALL ConfigureTimer
		JMP EndTimer

EndTimer: POP R2
		  POP R1

		  RTI

RestartGame: PUSH R1

			 MOV R1, OFF
			 CMP M[GameState], R1
			 JMP.nz EndRestartGame
			 MOV R1, ON
			 MOV M[GameState], R1
			 CALL FlashMemory
			 CALL PrintMap
			 CALL ConfigureTimer
			 JMP EndRestartGame

EndRestartGame: POP R1				
				RTI

UpdateScore:	PUSH R1
				PUSH R2
				PUSH R3

				INC M[Score]
				MOV R2, M[Score]
				MOV R1, 10
				DIV R2, R1
				MOV R3, 1d 
		 		MOV R2, 10d
				ADD R1, 48d
				CALL PrintChar
				MOV R2, M[Score]
				MOV R1, 10
				DIV R2, R1
				MOV R1, R2
				MOV R2, 10
				DIV R1, R2
				MOV R1, R2
				MOV R3, 1d 
		 		MOV R2, 9d
				ADD R1, 48d
				CALL PrintChar

				POP R3
				POP R2
				POP R1

				RET

FlashMemory:	PUSH R1
    			PUSH R2
    			PUSH R3
				PUSH R4

    			MOV R1, Linha0      
   				MOV R2, Mapa_Linha0       
    			MOV R3, MAP_HEIGHT
				MOV R4, MAP_WIDTH
				MUL R4, R3

FlashLoop:	CMP R3, 0
			JMP.z EndFlashMemory

			MOV R4, M[R2]
			MOV M[R1], R4
			INC R1
			INC R2
			DEC R3
			JMP FlashLoop

EndFlashMemory:	POP R4
				POP R3
    			POP R2
    			POP R1

   				RET

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

GetAddr: PUSH R3
		 PUSH R4

		 MOV R3, MAP_WIDTH
		 MUL R3, R2      ; R3 = y * MAP_WIDTH
		 ADD R1, R3      ; R1 = x + y*MAP_WIDTH
		 ADD R1, Linha0  ; base do mapa
		 POP R4
		 POP R3
		 RET

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

RemoveBlock:	PUSH R1
				PUSH R2
				PUSH R3
				PUSH R4

				CMP R3, '['
				JMP.z Wipe
				DEC R1
				CMP R3, 'x'
				JMP.z Wipe
				DEC R1
				CMP R3, ']'
				JMP.z Wipe
				JMP EndRemoveBlock

Wipe:			MOV R4, M[Blank]
				MOV M[R1], R4
				INC R1
				MOV R4, M[Blank]
				MOV M[R1], R4
				INC R1
				MOV R4, M[Blank]
				MOV M[R1], R4
				SUB R1, 3
				SUB R1, Linha0
				MOV R3, R1
				MOV R2, MAP_WIDTH
				DIV R3, R2
				MOV R1, M[Blank]
				INC R2
				CALL PrintChar
				INC R2
				CALL PrintChar
				INC R2
				CALL PrintChar
				CALL UpdateScore
				JMP EndRemoveBlock

EndRemoveBlock: POP R4
				POP R3
				POP R2
				POP R1

				RET

BlockColision: PUSH R1
 		  	   PUSH R2
 		  	   PUSH R3
 		  	   PUSH R4

 		  	MOV R4, M[ballState]
 			CMP R4, CIMA_DIREITA
 		 	JMP.z BlockCimaDireita
 		  	MOV R4, M[ballState]
 		  	CMP R4, CIMA_ESQUERDA
 		  	JMP.z BlockCimaEsquerda
 		   	MOV R4, M[ballState]
			CMP R4, BAIXO_DIREITA
			JMP.z BlockBaixoDireita
			MOV R4, M[ballState]
			CMP R4, BAIXO_ESQUERDA
			JMP.z BlockBaixoEsquerda

BlockCimaDireita: MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 ;offset na memória
				  ADD R1, R2 ; ajusta o sistema de cordenadas para memoria sequencial
				  INC R1 ;analisa bloco a direita da bola
				  MOV R3, '['
				  CMP M[R1], R3
				  JMP.z MudaCimaEsquerda

				  MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 
				  ADD R1, R2
				  SUB R1, MAP_WIDTH
				  MOV R3, 'x'
				  CMP M[R1], R3
				  JMP.z MudaBaixoDireita
				  MOV R3, '['
				  CMP M[R1], R3
				  JMP.z MudaBaixoDireita
				  MOV R3, ']'
				  CMP M[R1], R3
				  JMP.z MudaBaixoDireita
				  
				  MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 
				  ADD R1, R2
				  SUB R1, MAP_WIDTH
				  ADD R1, 1d
				  MOV R3, '['
				  CMP M[R1], R3
				  JMP.z MudaBaixoEsquerda
				  JMP EndBlockColision


BlockCimaEsquerda:MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 ;offset na memória
				  ADD R1, R2 ; ajusta o sistema de cordenadas para memoria sequencial
				  DEC R1 ;analisa bloco a esquerda da bola
				  MOV R3, ']'
				  CMP M[R1], R3
				  JMP.z MudaCimaDireita

				  MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 
				  ADD R1, R2
				  SUB R1, MAP_WIDTH
				  MOV R3, 'x'
				  CMP M[R1], R3
				  JMP.z MudaBaixoEsquerda
				  MOV R3, '['
				  CMP M[R1], R3
				  JMP.z MudaBaixoEsquerda
				  MOV R3, ']'
				  CMP M[R1], R3
				  JMP.z MudaBaixoEsquerda
				  
				  MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 
				  ADD R1, R2
				  SUB R1, MAP_WIDTH
				  DEC R1
				  MOV R3, ']'
				  CMP M[R1], R3
				  JMP.z MudaBaixoDireita
				  JMP EndBlockColision

BlockBaixoDireita:MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 ;offset na memória
				  ADD R1, R2 ; ajusta o sistema de cordenadas para memoria sequencial
				  INC R1 ;analisa bloco a direita da bola
				  MOV R3, '['
				  CMP M[R1], R3
				  JMP.z MudaBaixoEsquerda

				  MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 
				  ADD R1, R2
				  ADD R1, MAP_WIDTH
				  MOV R3, 'x'
				  CMP M[R1], R3
				  JMP.z MudaCimaDireita
				  MOV R3, '['
				  CMP M[R1], R3
				  JMP.z MudaCimaDireita
				  MOV R3, ']'
				  CMP M[R1], R3
				  JMP.z MudaCimaDireita
				  
				  MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 
				  ADD R1, R2
				  ADD R1, MAP_WIDTH
				  INC R1
				  MOV R3, '['
				  CMP M[R1], R3
				  JMP.z MudaCimaEsquerda
				  JMP EndBlockColision

BlockBaixoEsquerda: MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 ;offset na memória
				  ADD R1, R2 ; ajusta o sistema de cordenadas para memoria sequencial
				  DEC R1 ;analisa bloco a Esquerda da bola
				  MOV R3, ']'
				  CMP M[R1], R3
				  JMP.z MudaBaixoDireita

				  MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 
				  ADD R1, R2
				  ADD R1, MAP_WIDTH
				  MOV R3, 'x'
				  CMP M[R1], R3
				  JMP.z MudaCimaEsquerda
				  MOV R3, '['
				  CMP M[R1], R3
				  JMP.z MudaCimaEsquerda
				  MOV R3, ']'
				  CMP M[R1], R3
				  JMP.z MudaCimaEsquerda
				  
				  MOV R1, M[BallX]
				  MOV R2, M[BallY]
				  MOV R3, MAP_WIDTH
				  MUL R3, R2
				  ADD R1, Linha0 
				  ADD R1, R2
				  ADD R1, MAP_WIDTH
				  DEC R1
				  MOV R3, ']'
				  CMP M[R1], R3
				  JMP.z MudaCimaDireita
				  JMP EndBlockColision

MudaCimaDireita: CALL RemoveBlock
				 MOV R1, CIMA_DIREITA
				 MOV M[ballState], R1
				 JMP EndBlockColision

MudaCimaEsquerda: CALL RemoveBlock
				  MOV R1, CIMA_ESQUERDA
				  MOV M[ballState], R1
				  JMP EndBlockColision	

MudaBaixoDireita: CALL RemoveBlock
				  MOV R1, BAIXO_DIREITA
				  MOV M[ballState], R1
				  JMP EndBlockColision

MudaBaixoEsquerda: CALL RemoveBlock
				   MOV R1, BAIXO_ESQUERDA
				   MOV M[ballState], R1
				   JMP EndBlockColision


EndBlockColision: 	POP R4	
					POP R3
					POP R2
					POP R1
					RET

LifeSys: PUSH R1
		 PUSH R2
		 PUSH R3
		 PUSH R4

		 MOV R1, M[lifeCount]
		 CMP R1, 0
		 JMP.z HardReset

		 MOV R1, M[BallY]
		 CMP R1, BOTTOM_BOUND
		 JMP.nz EndLifeSys

		 DEC M[lifeCount]

		 MOV R3, 1d 
		 MOV R2, 77d
		 MOV R1, M[lifeCount]
		 ADD R1, 48d

		 CALL PrintChar

		 JMP SoftReset
		 
HardReset:	MOV R1, OFF
			MOV M[GameState], R1

			MOV R3, M[BallY]
		  	MOV R2, M[BallX]
		  	MOV R1, M[Blank]
			CALL PrintChar

			MOV R1, LinhaGameOVR
			MOV R3, 12d
			MOV R4, 0d
			CALL Printf
			MOV R1, LinhaRestart
			INC R3
			CALL Printf
			
			MOV R1, SHIP_INITIAL_X
			MOV M[ShipIndex], R1
			MOV R1, CIMA_DIREITA
			MOV M[ballState], R1
			MOV R1, 40d
			MOV M[BallX], R1
			MOV R1, 20d
			MOV M[BallY], R1
			MOV R1,	MAX_LIVES
			MOV M[lifeCount], R1
			MOV R1, 0d
			MOV M[Score], R1

			JMP EndLifeSys
		
SoftReset:  MOV R3, M[BallY]
		  	MOV R1, M[Blank]
		  	MOV R2, M[BallX]
			CALL PrintChar
			MOV R2, M[ShipIndex]
			MOV R4, SHIP_LEN
			SHR R4, 1
			ADD R2, R4
			MOV R3, SHIP_ROW
			DEC R3
			DEC R3
			MOV M[BallY], R3
			MOV M[BallX], R2
		  	MOV R1, M[Ball]
			MOV R3, M[BallY]
		  	MOV R2, M[BallX]
			CALL PrintChar
			JMP EndLifeSys


EndLifeSys: POP R4
			POP R3
			POP R2
			POP R1
			RET

ShipColision:	PUSH R1
				PUSH R2
				PUSH R3
				PUSH R4

				MOV R1, M[BallY]
				MOV R2, SHIP_ROW
				DEC R2
				CMP R1, R2
				JMP.nz EndShipColision
				MOV R1, M[ShipIndex]
				CMP M[BallX], R1
				JMP.n EndShipColision
				MOV R1, M[BallX]
				SUB R1, M[ShipIndex]
				CMP R1, SHIP_LEN
				JMP.nn EndShipColision

				MOV R1, M[ballState]
				CMP R1, BAIXO_DIREITA
				JMP.z	ChangeStateUpRight
				MOV R1, M[ballState]
				CMP R1, BAIXO_ESQUERDA
				JMP.z	ChangeStateUpLeft
				JMP EndShipColision
				
ChangeStateUpRight: MOV R1, CIMA_DIREITA
			 	   MOV M[ballState], R1
				   JMP EndShipColision

ChangeStateUpLeft:  MOV R1, CIMA_ESQUERDA
			 	   MOV M[ballState], R1
				   JMP EndShipColision

EndShipColision:POP R4
				POP R3
				POP R2
				POP R1

				RET

MoveBall: PUSH R1
		  PUSH R2
		  PUSH R3
		  PUSH R4

		  MOV R1, M[GameState]
		  CMP R1, OFF
		  JMP.z EndMoveBall	
		  MOV R4, M[ballState]
		  CMP R4, CIMA_DIREITA
		  JMP.z MovCimaDir
		  MOV R4, M[ballState]
		  CMP R4, CIMA_ESQUERDA
		  JMP.z MovCimaEsq
		  MOV R4, M[ballState]
		  CMP R4, BAIXO_DIREITA
		  JMP.z MovBaixoDir
		  MOV R4, M[ballState]
		  CMP R4, BAIXO_ESQUERDA
		  JMP.z MovBaixoEsq

EndMoveBall:  POP R4
			  POP R3
			  POP R2
			  POP R1

			  RET

MovCimaDir:	MOV R1, CIMA_DIREITA
			MOV M[ballState], R1
			MOV R3, M[BallY]
			CMP R3, TOP_BOUND
			JMP.z MovBaixoDir

			MOV R3, M[BallX]
			CMP R3, RIGHT_BOUND
			JMP.z MovCimaEsq

			MOV R3, M[BallY]
		  	MOV R1, M[Blank]
		  	MOV R2, M[BallX]
			CALL PrintChar
			INC M[BallX]
		  	DEC M[BallY]
		  	MOV R3, M[BallY]
		  	MOV R1, M[Ball]
		  	MOV R2, M[BallX]
		  	CALL PrintChar

			JMP EndMoveBall


MovCimaEsq:	MOV R1, CIMA_ESQUERDA
			MOV M[ballState], R1 
			MOV R3, M[BallY]
			CMP R3, TOP_BOUND
			JMP.z MovBaixoEsq

			MOV R3, M[BallX]
			CMP R3, LEFT_BOUND
			JMP.z MovCimaDir

			MOV R3, M[BallY]
		  	MOV R1, M[Blank]
		  	MOV R2, M[BallX]
			CALL PrintChar
			DEC M[BallX]
		  	DEC M[BallY]
		  	MOV R3, M[BallY]
		  	MOV R1, M[Ball]
		  	MOV R2, M[BallX]
		  	CALL PrintChar

			JMP EndMoveBall

MovBaixoDir:MOV R1, BAIXO_DIREITA
			MOV M[ballState], R1
			MOV R3, M[BallY]
			CMP R3, BOTTOM_BOUND
			JMP.z MovCimaDir

			MOV R3, M[BallX]
			CMP R3, RIGHT_BOUND
			JMP.z MovBaixoEsq

			MOV R3, M[BallY]
		  	MOV R1, M[Blank]
		  	MOV R2, M[BallX]
			CALL PrintChar
			INC M[BallX]
		  	INC M[BallY]
		  	MOV R3, M[BallY]
		  	MOV R1, M[Ball]
		  	MOV R2, M[BallX]

		  	CALL PrintChar

			JMP EndMoveBall

MovBaixoEsq:MOV R1, BAIXO_ESQUERDA
			MOV M[ballState], R1
			MOV R3, M[BallY]
			CMP R3, BOTTOM_BOUND
			JMP.z MovCimaEsq

			MOV R3, M[BallX]
			CMP R3, LEFT_BOUND
			JMP.z MovBaixoDir

			MOV R3, M[BallY]
		  	MOV R1, M[Blank]
		  	MOV R2, M[BallX]
			CALL PrintChar
			DEC M[BallX]
		  	INC M[BallY]
		  	MOV R3, M[BallY]
		  	MOV R1, M[Ball]
		  	MOV R2, M[BallX]
		  	CALL PrintChar

		  	JMP EndMoveBall

MovDireita: PUSH R1
			PUSH R2
			PUSH R3

			MOV R1, M[GameState]
			CMP R1, OFF
			JMP.z EndMovDireita
			MOV R1, M[ShipIndex]
			ADD R1, SHIP_LEN
			DEC R1
			CMP R1, RIGHT_BOUND 
			JMP.z EndMovDireita

			MOV R3, SHIP_ROW
			MOV R1, M[ Blank ]
			MOV R2, M[ ShipIndex ]
			CALL PrintChar

			MOV R1, M[ ShipPart ]
			ADD R2, SHIP_LEN
			CALL PrintChar

			INC M[ ShipIndex ]


EndMovDireita: POP R3
			   POP R2
			   POP R1

			   RTI 

MovEsquerda: PUSH R1
			 PUSH R2
			 PUSH R3

			MOV R1, M[GameState]
			CMP R1, OFF
			JMP.z EndMovEsquerda
			MOV R2, M[ ShipIndex ]
			CMP R2, LEFT_BOUND
			JMP.z EndMovEsquerda

			DEC M[ ShipIndex ]
			MOV R2, M[ ShipIndex ]
			MOV R3, SHIP_ROW
			MOV R1, M[ ShipPart ]
			CALL PrintChar

			MOV R1, M[ Blank ]
			ADD R2, SHIP_LEN
			CALL PrintChar
			


EndMovEsquerda:POP R3
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
			PUSH R2
			PUSH R3

			SHL 	R3, 8d
			OR 		R3, R2
			MOV 	M[CURSOR], R3
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
			PUSH R5

			MOV		R1, Linha0
			MOV 	R3, M[ Linha ]
			MOV 	R4, M[ Coluna ]
			MOV 	R5, 0d

	Ciclo1:	CMP     R3,	MAP_HEIGHT
			JMP.z   EndPrintMap
			CALL	Printf
			ADD		R1, MAP_WIDTH
			INC 	R3
			JMP 	Ciclo1

EndPrintMap:CALL PrintShip
			MOV R3, 1d 
		 	MOV R2, 77d
		 	MOV R1, M[lifeCount]
			ADD R1, 48d

			CALL PrintChar
			POP R5
			POP R4
			POP R3
			POP R2
			POP R1

			RET

PrintShip:	PUSH R1
		 	PUSH R2
			PUSH R3
			PUSH R4

			MOV     R1, M[ ShipPart ]
			MOV     R2, M[ ShipIndex ]
			MOV     R3, SHIP_ROW

	Ciclo2:	CMP 	R4, SHIP_LEN
			JMP.z   EndPrintShip
			CALL    PrintChar
			INC     R2
			INC     R4
			JMP     Ciclo2

EndPrintShip:	POP R4
				POP R3
				POP R2
				POP R1

				RET

ConfigureTimer: PUSH R1 

				MOV R1, 2d
				MOV M[ TIMER_UNITS ], R1
				MOV R1, ON
				MOV M[ ACTIVATE_TIMER ], R1

				POP R1
				RET

Main:	ENI
		MOV		R1, INITIAL_SP
		MOV		SP, R1		 		; We need to initialize the stack
		MOV		R1, CURSOR_INIT		; We need to initialize the cursor 
		MOV		M[ CURSOR ], R1		; with value CURSOR_INIT
		
		CALL 	PrintMap

		CALL ConfigureTimer


							
Cycle:	BR		Cycle	
Halt:   BR		Halt
