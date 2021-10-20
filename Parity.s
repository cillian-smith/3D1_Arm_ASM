@ Design and write an assembly language program that 
@ will calculate the parity bit for a 7 bit value stored in r0. 
@ 
@ The program should then store the computed parity bit 
@ in bit 7 of r0. Assume even parity.
@ 
@ Using even parity, the parity bit of a value is set such that the 
@ number of set bits (1's) in a value is always even.
@ 


	.text

start:

	LDR	r0, =0x16


@ Upload the code that goes between the dashed lines.
@ -------------- start cut ------------------------

    LDR r1, =0x1        @initialised registers r1,r2,r3
    LDR r2, =0x0
    LDR r3, =0x0
    MOV r5, r0          @move checked number to r5 
   
    AND r2, r1, r0      @ AND checking if teh LSB is 1, and storing it in r2
    EOR r3, r3, r2      @ XOR checking if the number of set bits is even, ie if there was already one set bit and another was found the bit would be set to 0
    MOV r0, r0, LSR #1  @shift the bits 1 to the right to elimate the LSB 

    AND r2, r1, r0      @repeat logic 
    EOR r3, r3, r2
    MOV r0, r0, LSR #1

    AND r2, r1, r0
    EOR r3, r3, r2
    MOV r0, r0, LSR #1

    AND r2, r1, r0
    EOR r3, r3, r2
    MOV r0, r0, LSR #1

    AND r2, r1, r0
    EOR r3, r3, r2
    MOV r0, r0, LSR #1

    AND r2, r1, r0
    EOR r3, r3, r2
    MOV r0, r0, LSR #1

    AND r2, r1, r0
    EOR r3, r3, r2
    MOV r0, r0, LSR #1

    AND r2, r1, r0
    EOR r3, r3, r2

    MOV r3, r3, LSL #7      @shift the LSB (essentially boolean, checking odd or even set bits) to bit 7
    EOR r0, r3, r5  

@ -------------- end cut --------------------------

stop:   B	stop
	.data
	.end
