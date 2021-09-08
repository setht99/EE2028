/**
 ******************************************************************************
 * @project        : EE2028 Assignment 1 Program Template
 * @file           : main.c
 * @author         : Gu Jing, ECE, NUS
 * @brief          : Main program body
 ******************************************************************************
 * @attention
 *
 * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
 * All rights reserved.</center></h2>
 *
 * This software component is licensed by ST under BSD 3-Clause license,
 * the "License"; You may not use this file except in compliance with the
 * License. You may obtain a copy of the License at:
 *                        opensource.org/licenses/BSD-3-Clause
 *
 ******************************************************************************
 */

#include "stdio.h"

#define M 8	 // No. of data points in total
#define N 2  // No. of centroids

// Necessary function to enable printf() using semihosting
extern void initialise_monitor_handles(void);

// Functions to be written in
extern void classification(int* arg1, int* arg2, int* arg3, int* arg4);
extern void find_new_centroids(int* arg1, int* arg2, int* arg3, int* arg4);

int main(void)
{
	// Necessary function to enable printf() using semihosting
	initialise_monitor_handles();

	double points[M][2] = { {0.0, 0.0},
							{0.0, 1.0},
							{1.0, 1.0},
							{1.0, 0.0},
							{3.0, 0.0},
							{3.0, 1.0},
							{4.0, 0.0},
							{4.0, 1.0} };

	double centroids[N][2] ={ {0.0, 0.5},
							  {3.0, 0.5} };

	int i,j;
	int temp1, temp2, temp3, temp4;
	int points10[M][2];
	int centroids10[N][2];
	int class[M] = {0,0,0,0,0,0,0,0};
	int new_centroids10[N][2] = {{M,N},{0,0}};

	// Multiply the coordinates by 10 so that the final answers have 1 decimal point
	for (i=0; i<M; i++)
		for (j=0; j<2; j++)
			points10[i][j] = points[i][j]*10;

	for (i=0; i<N; i++)
		for (j=0; j<2; j++)
			centroids10[i][j] = centroids[i][j]*10;

	// Binary Classification
	classification((int*)points10, (int*)centroids10, (int*)class, (int*)new_centroids10);
	printf("Class for each point: \n");
	for (i=0; i<M; i++)
	{
		printf("point %d: class %d \n", i, class[i]);

	}
	printf("\n");

	// Re-computation of centroids
	find_new_centroids((int*)points10, (int*)centroids10, (int*)class, (int*)new_centroids10);
	printf("New centroids: \n");
	for (i=0; i<N; i++)
	{
		temp1 = new_centroids10[i][0] / 10;
		temp2 = new_centroids10[i][0] % 10;
		temp3 = new_centroids10[i][1] / 10;
		temp4 = new_centroids10[i][1] % 10;
		printf("(%d.%d, %d.%d)\n",temp1, temp2, temp3, temp4);

	}
	printf("\n");

	// Infinite loop
	while(1){}

}

