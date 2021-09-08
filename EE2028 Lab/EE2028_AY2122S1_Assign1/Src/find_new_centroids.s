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

@ Write Student 1’s Name here:
@ Write Student 2’s Name here:

@ You could create a look-up table of registers here:


@ write your program from here:
find_new_centroids:
	PUSH {R14}

	BL SUBROUTINE

	POP {R14}
	BX LR

SUBROUTINE:

	BX LR
