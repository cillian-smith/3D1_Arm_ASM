@ Design and write an assembly language program that will detect and correct single 
@ bit errors in a 12-bit Hamming Code in R0. Your program should begin by clearing 
@ and then re-calculating the check bits using the same assembly language program 
@ that was used to generate the original Hamming Code. Your program should then 
@ compare the original and re-calculated values and should finally correct any 
@ single bit error and store the correct 8 bit number in R0.
@ 


	.text

start:

	LDR	r0, =0xb6b


@ Upload the code that goes between the dashed lines.
@ -------------- start cut ------------------------



@start by retreving 8 bit number from 12 bit 
    LDR		r2, =0x1
    MOV		r1, r0
    MOV		r1, r1, LSR #2
    AND		r1, r1, r2
    MOV		r4, r1
    
    LDR		r2, =0x7
    MOV		r1, r0
    MOV		r1, r1, LSR #4
    AND		r1, r1, r2
    MOV		r5, r1
    
    LDR		r2, =0xF
    MOV		r1, r0
    MOV		r1, r1, LSR #8
    AND		r1, r1, r2
    MOV		r6, r1
    
    MOV		r6, r6, LSL #4
    MOV		r5, r5, LSL #1
@store new 8 bit in r1
    ORR		r6, r6, r5
    ORR		r1, r6, r4


@Hamming1 code
    LDR		r4, =0x1
    LDR		r2, =0x0
    LDR		r3, =0x0
    MOV		r5, r1
    
    @c0
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
    
    @c1
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
    
    @c2
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
    
    @c3
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
    
    @loading	values
    LDR		r10, =0xF
    LDR		r11, =0x7
    LDR		r12, =0x1
    
    @separating	the 8 into 4,3,1
    AND		r2, r10, r5, ROR #4
    AND		r3, r11, r5, ROR #1
    AND		r4, r12, r5
    
    @creating	a 12 bit from the 8 bit
    LDR		r10, =0x0
    ADD		r10, r2, r10
    MOV		r10, r10, LSL #4
    ADD		r10, r3, r10
    MOV		r10, r10, LSL #2
    ADD		r10, r4, r10
    MOV		r10, r10, LSL #2
    
    @shifting	the parity bits to correct positions
    MOV		r7, r7, LSL #1
    MOV		r8, r8, LSL #3
    MOV		r9, r9, LSL #7
    
    MOV		r1, r10
    EOR		r1, r1, r6
    EOR		r1, r1, r7
    EOR		r1, r1, r8
    EOR		r1, r1, r9

    @original	in r0, recalcuated in r1, the altered parity bits in r2
    EOR		r2, r1, r0
    @Isolate	the results of the EOR operatation to result in a 4-bit calculation
    LDR		r3, =0x80
    AND		r4, r3, r2
    MOV		r4, r4, LSR #4
    
    LDR		r3, =0x8
    AND		r5, r3, r2
    MOV		r5, r5, LSR #1
    
    LDR		r3, =0x3
    AND		r6, r3, r2
    

    ADD		r2, r4, r5
    ADD		r2, r2, r6
    
    @sub 1 to get error bit
    SUB		r2, r2, #1
    LDR		r8, =0x1
    MOV		r8, r8, LSL r2
    
    @invert error bit
    EOR		r0, r0, r8

    
    @get 8 bit from corrected 12 bit
    LDR		r2, =0x1
    MOV		r1, r0
    MOV		r1, r1, LSR #2
    AND		r1, r1, r2
    MOV		r4, r1
    
    LDR		r2, =0x7
    MOV		r1, r0
    MOV		r1, r1, LSR #4
    AND		r1, r1, r2
    MOV		r5, r1
    
    LDR		r2, =0xF
    MOV		r1, r0
    MOV		r1, r1, LSR #8
    AND		r1, r1, r2
    MOV		r6, r1
    
    MOV		r6, r6, LSL #4
    MOV		r5, r5, LSL #1
    
    MOV		r6, r6, LSL #4
    MOV		r5, r5, LSL #1
    @store	new 8 bit in r1
    ORR		r6, r6, r5
    ORR		r0, r6, r4


@ -------------- end cut --------------------------

stop:   B	stop
	.data
	.end
@
@ End of file Hamming2.s