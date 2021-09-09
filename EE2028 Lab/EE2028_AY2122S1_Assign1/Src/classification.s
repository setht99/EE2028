/*
 * classification.s
 *
 *  Created on: 2021/8/26
 *      Author: Gu Jing
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

		.global classification

@ Start of executable code
.section .text

@ EE2028 Assignment 1, Sem 1, AY 2021/22
@ (c) ECE NUS, 2021

@ Write Student 1’s Name here:
@ Write Student 2’s Name here:

@ You could create a look-up table of registers here:
@ r0 (points10) start from 0x20017ef8.
@ r1 (centroids10) start from 0x20017ee8.
@ r2 (class) start from 0x20017ec8.
@ first have to load the content of register [R0] and [R1],
@ then
@ write your program from here:
classification:
	PUSH {R14}
	PUSH {R6,R8-R10}
	LDR R5,[R0] @Load content of R0 to R5.
	LDR R6,[R1] @Load content of R1 to R6.
	@MOV R6, #0
	@MOV R7, #0
	MOV R8, #0

// 1st centroid
	SUB R8,R5,R6  @ (R5 - R6) goes to R8
	MUL R8,R8 @Squaring x coordinate
	LDR R5,[R0,#4]! @ R0 jump to next 4 bytes, then load the content to R5
	LDR R6,[R1,#4]! @ R1 jump to next 4 bytes, then load the content to R6
	SUB R9,R5,R6 @ (R5 - R6) goes to R9
	MUL R9,R9 @squaring y coordinate
	ADD R10,R8,R9 @adding x^2 and y^2 coordinate
	LDR R5,[R0,#-4]! @R0 go back 4 bytes. x-coordinate

// 2nd centroid
	LDR R6,[R1,#4]! @R1 jump to next 4 bytes. x-coor of 2nd centroid.
	SUB R8,R5,R6  @ (R5 - R6) goes to R8
	MUL R8,R8 @Squaring x coordinate (2nd centroid)
	LDR R5,[R0,#4]! @ R0 jump to next 4 bytes, then load the content to R5
	LDR R6,[R1,#4]! @ R1 jump to next 4 bytes, then load the content to R6
	SUB R9,R5,R6 @ (R5 - R6) goes to R9
	MUL R9,R9 @squaring y coordinate
	ADD R11,R8,R9 @adding x^2 and y^2 coordinate

// Comparing and then classifying to 1 or 2.
	MOV R5,#1
	MOV R6,#2
	CMP R10,R11
	ITE CS
	STRCS R5,[R2],#4
	STRCC R6,[R2],#4
	BL SUBROUTINE
	POP {R6,R8-R10}
	POP {R14}
	BX LR

SUBROUTINE:

	BX LR
