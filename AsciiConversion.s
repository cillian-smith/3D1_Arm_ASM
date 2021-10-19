@ A sequence of seven ASCII symbols, each in the range '0' . . . '9', can 
@ represent an unsigned value in the range 0 . . . 9,999,999 in text form. 
@ 
@ Design and write an ARM assembly language program that will convert such 
@ a sequence to the value represented by the symbols. 
@ 
@ Assume that the seven byte-size ASCII symbols will be stored in R1 to R7, 
@ with the most significant digit stored in R7. 
@ 
@ Store the result of the conversion in R0.
@ 
@ For example, given the following sequence of ASCII symbols
@         '1', '0', '3', '4', '2', '7', '9'
@ your program should store the value 1,034,279 (0x000FC827) in R0.
@ 


	.text

start:

	LDR	R7, ='1'
	LDR	R6, ='0'
	LDR	R5, ='3'
	LDR	R4, ='4'
	LDR	R3, ='2'
	LDR	R2, ='7'
	LDR	R1, ='9'


@ Upload the code that goes between the dashed lines.
@ -------------- start cut ------------------------


@convert ascii representation to hex 
SUB r7, #0x30
SUB r6, #0x30
SUB r5, #0x30
SUB r4, #0x30
SUB r3, #0x30
SUB r2, #0x30
SUB r1, #0x30 

@load the SF and multiply by the hex number 
LDR r8, =1000000
MUL r7, r7, r8 

LDR r8, =100000
MUL r6, r6, r8

LDR r8, =10000
MUL r5, r5, r8

LDR r8, =1000
MUL r4, r4, r8

LDR r8, =100
MUL r3, r3, r8

LDR r8, =10
MUL r2, r2, r8

@add all figures together
ADD r0, r7, r6 
ADD r0, r0, r5
ADD r0, r0, r4
ADD r0, r0, r3
ADD r0, r0, r2
ADD r0, r0, r1  


@ -------------- end cut --------------------------

stop:   B	stop
	.data
	.end
@
@ End of file AsciiConversion.s
