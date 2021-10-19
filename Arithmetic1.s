@ Write an arm program to evaluate 4 * x * x + 3 * x
@ assume x is in r1 and store result in r0


	.text

start:

        MOV     r1, #0x8 

@ -------------- start cut ------------------------

	MOV 	r2, #3
	MOV 	r3, #4

	MUL	r0, r1, r1 	@creates x^2 
	MUL r2, r1, r2
	MUL r3, r0, r3

	ADD r0, r2, r3 


@ -------------- end cut --------------------------

stop:   B	stop
	.data
	.end
