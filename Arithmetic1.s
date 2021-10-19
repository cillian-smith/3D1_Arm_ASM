 Start of file Arithmetic1.s
@
@ Copyright 2020 University of Dublin. All Rights Reserved.
@
@ Write an arm program to evaluate 4 * x * x + 3 * x
@ assume x is in r1 and store result in r0
@ 


	.text

start:

        MOV     r1, #0x8 


@ Upload the code that goes between the dashed lines.
@ -------------- start cut ------------------------

	@MOV 	r2, #3
	@MOV 	r3, #4

	@MUL	r0, r1, r1 	@creates x^2 
	@MUL r2, r1, r2
	@MUL r3, r0, r3

	@ADD r0, r2, r3 





	MUL	r0, r1, r1 	@creates x^2 
	MOV 	r3, r0		@moves x^2 to r3 
	ADD 	r0, r3, r3	
	ADD 	r0, r0, r3
	ADD 	r0, r0, r3
	MOV	r3, r0		@creates 4x^2 and moves it to r3 

	ADD	r0, r1, r1	
	ADD	r0, r0, r1
	MOV	r2, r0		@creates 3x and moves it to r2 

	ADD 	r0, r2, r3 	@adds r2 and r3 and stores in r0 

	

@ -------------- end cut --------------------------

stop:   B	stop
	.data
	.end
@
@ End of file Arithmetic1.s