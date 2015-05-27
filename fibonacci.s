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

	

fibonacci_0:
	pop {R4}
	STR R4, [R11, #0]
	push {lr}
	LDR R4, [R11, #0]
	MOV R5, #2
	CMP R4, R5
	BLT _condExpTrue_0
	B _condExpFalse_0

_condExpTrue_0:
	LDR R4, [R11, #0]
	pop {R5}
	push {R4}
	MOV pc, R5


_condExpFalse_0:
	LDR R4, [R11, #0]
	push {R4}
	LDR R4, [R11, #4]
	push {R4}
	LDR R4, [R11, #8]
	push {R4}
	LDR R4, [R11, #0]
	MOV R5, #1
	SUB R4, R4, R5
	push {R4}
	BL fibonacci_0
	pop {R4}
	pop {R5}
	STR R5, [R11, #8]
	pop {R5}
	STR R5, [R11, #4]
	pop {R5}
	STR R5, [R11, #0]
	STR R4, [R11, #4]
	LDR R4, [R11, #0]
	push {R4}
	LDR R4, [R11, #4]
	push {R4}
	LDR R4, [R11, #8]
	push {R4}
	LDR R4, [R11, #0]
	MOV R5, #2
	SUB R4, R4, R5
	push {R4}
	BL fibonacci_0
	pop {R4}
	pop {R5}
	STR R5, [R11, #8]
	pop {R5}
	STR R5, [R11, #4]
	pop {R5}
	STR R5, [R11, #0]
	STR R4, [R11, #8]
	LDR R4, [R11, #4]
	LDR R5, [R11, #8]
	ADD R4, R4, R5
	pop {R5}
	push {R4}
	MOV pc, R5


main_0:
	push {lr}
	MOV R4, #0
	STR R4, [R11, #0]

_condWhile_0:
	LDR R4, [R11, #0]
	MOV R5, #10
	CMP R4, R5
	BLT _condExpTrue_1
	B _condExpFalse_1

_condExpTrue_1:
	LDR R4, [R11, #0]
	push {R4}
	LDR R4, [R11, #4]
	push {R4}
	LDR R4, [R11, #0]
	push {R4}
	BL fibonacci_0
	pop {R4}
	pop {R5}
	STR R5, [R11, #4]
	pop {R5}
	STR R5, [R11, #0]
	STR R4, [R11, #4]
	LDR R4, [R11, #4]
	LDR R0, =_formatoInt
	MOV R1, R4
	BL printf
	B _condWhile_0

_condExpFalse_1:
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
	.space 12

