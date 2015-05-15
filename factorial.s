/*Ricado Zepeda, 12311*/

.globl main
main:
	stmfd sp!, {lr}
	LDR R11, =_dataGlobal
	push {lr}
	BL main_0
	B _salir

DivideU32:
	result .req r0
	remainder .req r1
	shift .req r2
	current .req r3
	clz shift,r1
	clz r3,r0
	subs shift,r3
	lsl current,r1,shift
	mov remainder,r0
	mov result,#0
	blt divideU32Return$
	divideU32Loop$:
		cmp remainder,current
		blt divideU32LoopContinue$
		add result,result,#1
		subs remainder,current
		lsleq result,shift
		beq divideU32Return$
	divideU32LoopContinue$:
		subs shift,#1
		lsrge current,#1
		lslge result,#1
		bge divideU32Loop$
divideU32Return$:
	.unreq current
	mov pc,lr
	.unreq result
	.unreq remainder
	.unreq shift

	

factorial_0:
	pop {R4}
	STR R4, [R11, #0]
	push {lr}
	LDR R4, [R11, #0]
	MOV R5, #0
	CMP R4, R5
	BEQ _condExpTrue_0
	B _condExpFalse_0

_condExpTrue_0:
	MOV R4, #1
	pop {R5}
	push {R4}
	MOV pc, R5

	B _condExpEnd_0

_condExpFalse_0:
	LDR R4, [R11, #0]
	LDR R5, [R11, #0]
	push {R5}
	push {R4}
	LDR R5, [R11, #0]
	MOV R6, #1
	SUB R5, R5, R6
	push {R5}
	BL factorial_0
	pop {R5}
	pop {R4}
	pop {R6}
	STR R6, [R11, #0]
	MUL R4, R4, R5
	pop {R5}
	push {R4}
	MOV pc, R5


_condExpEnd_0:
	MOV R4, #1
	pop {R5}
	push {R4}
	MOV pc, R5


main_0:
	push {lr}
	LDR R4, [R11, #0]
	push {R4}
	MOV R4, #5
	push {R4}
	BL factorial_0
	pop {R4}
	pop {R5}
	STR R5, [R11, #0]
	STR R4, [R11, #0]

	LDR R0, =_formatoInt
	MOV R1, R4	
	BL printf

	pop {pc}

_IndexOutOfBounds:
	LDR R0, =_IOOB
	BL puts

_salir:
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}
	BX lr

.section .data
.align 2
_IOOB:
	.asciz "El indice no esta dentro del rango del arreglo "
_formatoInt:
	.asciz "%d\n"
_dataGlobal:
	.space 4

