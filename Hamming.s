//@ Design and write an assembly language program that 
//@ generates a 12-bit Hamming Code in R0 from an 8-bit value in R1.
 
	.text

start:

	LDR	r1, =0xAC
//@10101100
//@11 10 9 8 6 5 4 2 


//@ Upload the code that goes between the dashed lines.
//@ -------------- start cut ------------------------
    LDR		r1, =0xAC
    LDR		r4, =0x1
    LDR		r2, =0x0
    LDR		r3, =0x0
    MOV		r5, r1
    
    //@c0
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #1
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #2
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #1
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r6, r3
    
    //@c1
    LDR		r3, =0x0
    MOV		r1, r5
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #2
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #1
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #2
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r7, r3
    
    //@c2
    LDR		r3, =0x0
    MOV		r1, r5
    MOV		r1, r1, LSR #1
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #1
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #1
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #4
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r8, r3
    
    //@c3
    LDR		r3, =0x0
    MOV		r1, r5
    MOV		r1, r1, LSR #4
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #1
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #1
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r1, r1, LSR #1
    AND		r2, r4, r1
    EOR		r3, r3, r2
    MOV		r9, r3
    
    //@loading	values
    LDR		r10, =0xF
    LDR		r11, =0x7
    LDR		r12, =0x1
    
    //@separating	the 8 into 4,3,1
    AND		r2, r10, r5, ROR #4
    AND		r3, r11, r5, ROR #1
    AND		r4, r12, r5
    
    //@creating	a 12 bit from the 8 bit
    LDR		r10, =0x0
    ADD		r10, r2, r10
    MOV		r10, r10, LSL #4
    ADD		r10, r3, r10
    MOV		r10, r10, LSL #2
    ADD		r10, r4, r10
    MOV		r10, r10, LSL #2
    
    //@shifting	the parity bits to correct positions
    MOV		r7, r7, LSL #1
    MOV		r8, r8, LSL #3
    MOV		r9, r9, LSL #7
    
    MOV		r0, r10
    EOR		r0, r0, r6
    EOR		r0, r0, r7
    EOR		r0, r0, r8
    EOR		r0, r0, r9



//@ -------------- end cut --------------------------

stop:   B	stop
	.data
	.end

//@ End of file Hamming.s


/*@ Check bit c0 in bit position 0 is calculated to produce even parity for bits
@ 2, 4, 6, 8, and 10. (i.e. c0 should be 1 to produce even parity for the bit
@ sequence 0, 0, 1, 0, 0)

@ • Check bit c1 in bit position 1 is calculated to produce even parity for bits
@ 2, 5, 6, 9 and 10. (i.e. c1 should be 1 to produce even parity for the bit
@ sequence 0, 1, 1, 1, 0)

@ • Check bit c2 in bit position 3 is calculated to produce even parity for bits
@ 4, 5, 6 and 11. (i.e. c2 should be 1 to produce even parity for the bit
@ sequence 0, 1, 1, 1)

@ • Check bit c3 in bit position 7 is calculated to produce even parity for bits
@ 8, 9, 10 and 11. (i.e. c3 should be 0 to produce even parity for the bit
@ sequence 0, 1, 0, 1)

@11 10  9   8   7   6   5   4   3   2   1   0

@0  0   0   0   0   0   0   0   0   0   0   0
@11 10  9   8   *   6   5   4   *   2   *   *


@           8       6       4       2       *

@   10  9           6   5           2   *   

@11                 6   5   4   *            

@11 10  9   8   *                            
*/