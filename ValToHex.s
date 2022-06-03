@ Design and write an ARM assembly language program to 
@ convert a 32 bit unsigned value stored in r1
@ to it's hexadecimal ASCII string representation.
@ Store the resulting string beginning at address 
@ 0xA1000400. Your answer should contain 8 characters
@ including leading zeros where appropriate, and
@ should use uppercase 'A'-'F'.


	.text

start:

	LDR	r1, =0xFEED1234

@ Upload the code that goes between the dashed lines.
@ -------------- start cut ------------------------
    MOV r2, #9
    MOV r3, #28
    LDR		r0, =0xA1000400
MAINLOOP:
    MOV r4, r1
    MOV r4, r4, LSR r3
    SUB r3, r3, #4
    AND r4, r4, #0xF
    CMP r4, #0x9
    BHI NOTNUM
    ADD r6, r4, #0x30
    B STORE
NOTNUM:
    MOVS r4, r4
    SUB r6, r4, #0x9
    ADD r6, r6, #0x40
STORE:
    STR r6, [r0], #1
    SUB r2, #1
    CMP r2, #1
    BEQ END 
    B MAINLOOP
END:
@ -------------- end cut --------------------------

stop:   B	stop
	.data
	.end
@
@ End of file ValToHex.s