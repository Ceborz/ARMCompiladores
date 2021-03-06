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

	

main_0:
	push {lr}
	MOV R4, #4
	MOV R5, #1
	CMP R5, #0
	BLT _IndexOutOfBounds
	CMP R5, #5
	BGE _IndexOutOfBounds
	MOV R6, #104
	MUL R5, R6, R5
	MOV R6, #8
	ADD R5, R5, R6
	MOV R6, #2
	CMP R6, #0
	BLT _IndexOutOfBounds
	CMP R6, #4
	BGE _IndexOutOfBounds
	MOV R7, #24
	MUL R6, R7, R6
	ADD R5, R5, R6
	MOV R6, #4
	ADD R5, R5, R6
	MOV R6, #0
	CMP R6, #0
	BLT _IndexOutOfBounds
	CMP R6, #2
	BGE _IndexOutOfBounds
	MOV R7, #8
	MUL R6, R7, R6
	ADD R5, R5, R6
	ADD R5, R5, #8
	STR R4, [R11, R5]
	MOV R4, #1
	CMP R4, #0
	BLT _IndexOutOfBounds
	CMP R4, #5
	BGE _IndexOutOfBounds
	MOV R5, #104
	MUL R4, R5, R4
	MOV R5, #8
	ADD R4, R4, R5
	MOV R5, #2
	CMP R5, #0
	BLT _IndexOutOfBounds
	CMP R5, #4
	BGE _IndexOutOfBounds
	MOV R6, #24
	MUL R5, R6, R5
	ADD R4, R4, R5
	MOV R5, #4
	ADD R4, R4, R5
	MOV R5, #0
	CMP R5, #0
	BLT _IndexOutOfBounds
	CMP R5, #2
	BGE _IndexOutOfBounds
	MOV R6, #8
	MUL R5, R6, R5
	ADD R4, R4, R5
	ADD R4, R4, #8
	LDR R4, [R11, R4]

	MOV R5, #4
	ADD R4, R4, R5
	STR R4, [R11, #0]
	LDR R4, [R11, #0]
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
_formatoChar:
	.asciz "%c\n"
_dataGlobal:
	.space 524

