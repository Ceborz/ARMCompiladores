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
	MOV R4, #10
	STR R4, [R11, #40]
	LDR R4, [R11, #40]
	MOV R5, #11
	CMP R5, #0
	BLT _IndexOutOfBounds
	CMP R5, #10
	BGE _IndexOutOfBounds
	MOV R6, #4
	MUL R5, R5, R6
	ADD R5, R5, #0
	STR R4, [R11, R5]
	MOV R4, #3
	CMP R4, #0
	BLT _IndexOutOfBounds
	CMP R4, #10
	BGE _IndexOutOfBounds
	MOV R5, #4
	MUL R4, R4, R5
	ADD R4, R4, #0
	LDR R4, [R11, R4]

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
	.space 44

