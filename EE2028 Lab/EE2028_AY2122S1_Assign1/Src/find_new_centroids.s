/*
 * find_new_centroids.s
 *
 *  Created on: 2021/8/26
 *      Author: Gu Jing
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

		.global find_new_centroids

@ Start of executable code
.section .text

@ EE2028 Assignment 1, Sem 1, AY 2021/22
@ (c) ECE NUS, 2021

@ Write Student 1’s Name here: Rachit
@ Write Student 2’s Name here: Seth

@ You could create a look-up table of registers here:
@R0 = 0x20017ef8 (POINTS)
@R2 = 0x20017ec8 (CLASS NUMBER)
@R3 = 0x20017eb8 (NEW_CENTROID)

@ write your program from here:
find_new_centroids:
	PUSH {R14}
	PUSH {R0-R6,R8-R12}
	MOV R4,#0 @R4 = class 1/2 POINT counter
	LDR R6,[R2] @R6 = CLASS TRACKER
	LDR R8,[R3] @R8 = COUNTER FOR M, FOR DECREMENT.
	MOV R11,R0 @USING R11 FOR SECOND CENTROID (points10)
	MOV R12,R2 @USING R12 FOR SECOND CENTROID (class)

MAIN1:
	CMP R6,#1
	BEQ CENTROID1
	LDR R5,[R0],#4 @R5 = X COORDINATE OF POINT 1
	LDR R5,[R0],#4 @Y COORDINATE OF POINT 1
	SUB R8,#1 @COUNTER M -1
	LDR R6,[R2,#4]!
	CMP R8,#0
	BGT MAIN1
	B CENTROID1COORDINATES
CENTROID1:
	LDR R5,[R0],#4 @R5 = X COORDINATE OF POINT 1
	ADD R9,R9,R5 @R9 = Stored value of X coords (added) for class 1
	LDR R5,[R0],#4 @Y COORDINATE OF POINT 1
	ADD R10,R10,R5 @R10 = Stored value of Y coords (added) for class 1
	ADD R4,#1 @CLASS COUNTER +1
	SUB R8,#1 @COUNTER M -1
	LDR R6,[R2,#4]!
	CMP R8,#0
	BGT MAIN1

CENTROID1COORDINATES:
	LDR R8,[R3]
	SDIV R9,R9,R4 @Finding the average of X-coordinates of class 1
	STR R9,[R3],#4
	SDIV R10,R10,R4  @Finding the average of Y-coordinates of class 1
	STR R10,[R3],#4
	MOV R9,#0 @ RESET X-COORDINATE ADDER
	MOV R10,#0 @ RESET Y-COORDINATE ADDER
	MOV R4,#0 @RESET FOR CLASS 2 COUNTER
//	MOV R8,#8 @RESET R8 FOR M COUNTER

MAIN2:
	CMP R6,#2
	BEQ CENTROID2
	LDR R5,[R11],#4 @R11 = X COORDINATE OF POINT
	LDR R5,[R11],#4 @Y COORDINATE OF POINT
	SUB R8,#1 @COUNTER M -1
	LDR R6,[R12,#4]! @r6 = class tracker
	CMP R8,#0
	BGT MAIN2
	B CENTROID2COORDINATES
CENTROID2:
	LDR R5,[R11],#4 @R5 = X COORDINATE OF POINT
	ADD R9,R9,R5
	LDR R5,[R11],#4 @Y COORDINATE OF POINT
	ADD R10,R10,R5
	ADD R4,#1 @CLASS COUNTER +1
	SUB R8,#1 @COUNTER M -1
	LDR R6,[R12,#4]!
	CMP R8,#0
	BGT MAIN2

CENTROID2COORDINATES:
	SDIV R9,R9,R4
	STR R9,[R3],#4
	SDIV R10,R10,R4
	STR R10,[R3],#4
	/*MOV R9,#0
	MOV R10,#0
	MOV R4,#0
	LDR R8,[R3]
	CMP R6,#2
	BEQ CENTROID2*/
	BL SUBROUTINE
	POP {R0-R6,R8-R12}
	POP {R14}
	BX LR

SUBROUTINE:
	BX LR

